Return-Path: <SRS0=/C+/=P4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C568AC433F5
	for <iommu@archiver.kernel.org>; Tue,  9 Nov 2021 14:23:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 511C861101
	for <iommu@archiver.kernel.org>; Tue,  9 Nov 2021 14:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 511C861101
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18332400AA;
	Tue,  9 Nov 2021 14:23:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VXZ-JiOAErwy; Tue,  9 Nov 2021 14:23:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A545940332;
	Tue,  9 Nov 2021 14:23:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E135C0012;
	Tue,  9 Nov 2021 14:23:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 773DDC000E
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 14:23:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6AEB74011C
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 14:23:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1_ptCv80olM9 for <iommu@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 14:23:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B747E400F3
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 14:23:26 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id E9F0667373; Tue,  9 Nov 2021 15:23:22 +0100 (CET)
Date: Tue, 9 Nov 2021 15:23:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 04/10] dma-direct: clean up the remapping checks in
 dma_direct_alloc
Message-ID: <20211109142322.GC23489@lst.de>
References: <20211021090611.488281-1-hch@lst.de>
 <20211021090611.488281-5-hch@lst.de>
 <bc7bc5eb-282d-3dbb-b4f9-b9bbd9e0f0a1@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bc7bc5eb-282d-3dbb-b4f9-b9bbd9e0f0a1@arm.com>
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

On Thu, Nov 04, 2021 at 12:35:59PM +0000, Robin Murphy wrote:
>> @@ -166,6 +166,7 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
>>   void *dma_direct_alloc(struct device *dev, size_t size,
>>   		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>>   {
>> +	bool remap = false;
>
> How about also adding a "bool set_uncached = false"...

Done.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
