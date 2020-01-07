Return-Path: <SRS0=zmEc=24=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D525BC33C99
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 10:55:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F3C20678
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 10:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F3C20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 82EFA84CE6;
	Tue,  7 Jan 2020 10:55:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CWbIX8_Bg_as; Tue,  7 Jan 2020 10:55:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6E33C84CC2;
	Tue,  7 Jan 2020 10:55:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5209EC1D82;
	Tue,  7 Jan 2020 10:55:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BC86C0881
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 10:55:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4A1EA20338
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 10:55:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wkZJuJHWTbA5 for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jan 2020 10:55:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by silver.osuosl.org (Postfix) with ESMTPS id D3B812011A
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 10:55:03 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id DE1FD68AFE; Tue,  7 Jan 2020 11:54:58 +0100 (CET)
Date: Tue, 7 Jan 2020 11:54:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [rfc] dma-mapping: preallocate unencrypted DMA atomic pool
Message-ID: <20200107105458.GA3139@lst.de>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com>
 <3213a6ac-5aad-62bc-bf95-fae8ba088b9e@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3213a6ac-5aad-62bc-bf95-fae8ba088b9e@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Singh,
 Brijesh" <brijesh.singh@amd.com>, "Grimm, Jon" <jon.grimm@amd.com>,
 baekhw@google.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Rientjes <rientjes@google.com>, Christoph Hellwig <hch@lst.de>
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

On Mon, Jan 06, 2020 at 05:34:00PM +0000, Robin Murphy wrote:
> On 01/01/2020 1:54 am, David Rientjes via iommu wrote:
>> Christoph, Thomas, is something like this (without the diagnosic
>> information included in this patch) acceptable for these allocations?
>> Adding expansion support when the pool is half depleted wouldn't be *that*
>> hard.
>>
>> Or are there alternatives we should consider?  Thanks!
>
> Are there any platforms which require both non-cacheable remapping *and* 
> unencrypted remapping for distinct subsets of devices?
>
> If not (and I'm assuming there aren't, because otherwise this patch is 
> incomplete in covering only 2 of the 3 possible combinations), then 
> couldn't we keep things simpler by just attributing both properties to the 
> single "atomic pool" on the basis that one or the other will always be a 
> no-op? In other words, basically just tweaking the existing "!coherent" 
> tests to "!coherent || force_dma_unencrypted()" and doing 
> set_dma_unencrypted() unconditionally in atomic_pool_init().

I think that would make most sense.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
