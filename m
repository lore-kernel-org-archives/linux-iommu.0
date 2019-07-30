Return-Path: <SRS0=JEM9=V3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A094C433FF
	for <iommu@archiver.kernel.org>; Tue, 30 Jul 2019 10:50:42 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132412087F
	for <iommu@archiver.kernel.org>; Tue, 30 Jul 2019 10:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132412087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B560A2AB6;
	Tue, 30 Jul 2019 10:50:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 82B9A2A92
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Jul 2019 10:43:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id CC08EF1
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Jul 2019 10:43:27 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45896344;
	Tue, 30 Jul 2019 03:43:27 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7572F3F575;
	Tue, 30 Jul 2019 03:43:26 -0700 (PDT)
Subject: Re: [PATCH] iommu/dma: Handle MSI mappings separately
To: Christoph Hellwig <hch@infradead.org>
References: <2b2595de703c60a772ebcffe248d0cf036143e6a.1564414114.git.robin.murphy@arm.com>
	<20190730062843.GA1400@infradead.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <90566814-ed36-2eb9-49e2-98a4a949c9f6@arm.com>
Date: Tue, 30 Jul 2019 11:43:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190730062843.GA1400@infradead.org>
Content-Language: en-GB
Cc: maz@kernel.org, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org,
	Andre Przywara <andre.przywara@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 30/07/2019 07:28, Christoph Hellwig wrote:
> On Mon, Jul 29, 2019 at 04:32:38PM +0100, Robin Murphy wrote:
>> MSI pages must always be mapped into a device's *current* domain, which
>> *might* be the default DMA domain, but might instead be a VFIO domain
>> with its own MSI cookie. This subtlety got accidentally lost in the
>> streamlining of __iommu_dma_map(), but rather than reintroduce more
>> complexity and/or special-casing, it turns out neater to just split this
>> path out entirely.
>>
>> Since iommu_dma_get_msi_page() already duplicates much of what
>> __iommu_dma_map() does, it can easily just make the allocation and
>> mapping calls directly as well. That way we can further streamline the
>> helper back to exclusively operating on DMA domains.
>>
>> Fixes: b61d271e59d7 ("iommu/dma: Move domain lookup into __iommu_dma_{map,unmap}")
>> Reported-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>> Reported-by: Andre Przywara <andre.przywara@arm.com>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> Hmm.  I remember proposing this patch and you didn't like it because
> we could also have msis for a !IOMMU_DMA_IOVA_COOKIE cookie type.
> Or did we talk past each other?

Do you have a pointer? That sparks the vaguest of memories, but I can't 
seem to turn anything up in my inbox. If that was my objection, though, 
it sounds like your patch was probably trying to go a step or two 
further than this one.

> Note that if this change turns out to be valid we should also
> clean up the iommu_dma_free_iova() side.

We're not touching the iommu_dma_{alloc,free}_iova() path here; those 
are designed to cope with both types of cookie, and I think that's a 
reasonable abstraction to keep. This is just getting rid of the 
asymmetry - and now bug - caused by trying to keep the MSI page flow 
going through a special case in __iommu_dma_map() despite that having 
evolved into a more specific DMA domain fastpath (there's no 
corresponding unmap special case since MSI mappings just persist and get 
recycled until the domain is destroyed).

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
