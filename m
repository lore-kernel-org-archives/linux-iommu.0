Return-Path: <SRS0=/C+/=P4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEE7C433F5
	for <iommu@archiver.kernel.org>; Tue,  9 Nov 2021 14:10:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01ED8611CC
	for <iommu@archiver.kernel.org>; Tue,  9 Nov 2021 14:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 01ED8611CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2351607D9;
	Tue,  9 Nov 2021 14:10:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CLZWGFlrokH6; Tue,  9 Nov 2021 14:10:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9F0A5607C7;
	Tue,  9 Nov 2021 14:10:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72083C0012;
	Tue,  9 Nov 2021 14:10:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14615C000E
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 14:10:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA53C80EE9
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 14:10:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2kRld7ZDaXfK for <iommu@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 14:10:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E7ED480EE1
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 14:10:35 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0554B68C4E; Tue,  9 Nov 2021 15:10:24 +0100 (CET)
Date: Tue, 9 Nov 2021 15:10:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 02/10] dma-direct: unmapped remapped pages when
 dma_set_decrypted
Message-ID: <20211109141019.GA23489@lst.de>
References: <20211021090611.488281-1-hch@lst.de>
 <20211021090611.488281-3-hch@lst.de>
 <81bc1acc-7701-0f27-f11b-1fd91adde63d@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <81bc1acc-7701-0f27-f11b-1fd91adde63d@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
 David Rientjes <rientjes@google.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Nov 04, 2021 at 12:35:41PM +0000, Robin Murphy wrote:
> On 2021-10-21 10:06, Christoph Hellwig wrote:
>> When dma_set_decrypted fails for the remapping case in dma_direct_alloc
>> we also need to unmap the pages before freeing them.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   kernel/dma/direct.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index d4d54af31a341..2fef8dd401fe9 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -230,7 +230,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>   		if (!ret)
>>   			goto out_free_pages;
>>   		if (dma_set_decrypted(dev, ret, size))
>
> I was going to say just stick the vunmap() in here to avoid adding yet more 
> messy conditionals, but one rabbit hole later... Given that the 
> dma_pgprot() we've just passed to dma_common_pages_remap() already adds in 
> pgprot_decrypted, why is this even here at all?

Good point.  This combination is pretty much untested anyway as the
architectures that support memory encryption never remap, but yes
I think the best is if gets removed.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
