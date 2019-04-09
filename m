Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14319C10F0E
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 17:27:06 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A5D2133D
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 17:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A5D2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BCEAADDF;
	Tue,  9 Apr 2019 17:27:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 714E8DD2
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 17:27:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 113E276D
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 17:27:04 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 7CEBC68B02; Tue,  9 Apr 2019 19:26:52 +0200 (CEST)
Date: Tue, 9 Apr 2019 19:26:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 09/21] dma-iommu: refactor iommu_dma_get_sgtable
Message-ID: <20190409172652.GF14679@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
	<20190327080448.5500-10-hch@lst.de>
	<a42133a5-c88b-76c7-80fa-671cfbdd9759@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a42133a5-c88b-76c7-80fa-671cfbdd9759@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
	linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190409172652.bbiAKp0HYC7hmprYIUyc85LL53j0bFTjquJx7x7i4BQ@z>

On Tue, Apr 09, 2019 at 04:49:30PM +0100, Robin Murphy wrote:
>> *cpu_addr,
>> +		size_t size)
>> +{
>> +	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>> +	struct vm_struct *area = find_vm_area(cpu_addr);
>> +
>> +	if (WARN_ON(!area || !area->pages))
>> +		return -ENXIO;
>> +	return sg_alloc_table_from_pages(sgt, area->pages, count, 0, size,
>> +			GFP_KERNEL);
>> +}
>> +
>
> Is this complex enough to deserve being broken out? Really I'd prefer to 
> keep get_sgtable() as small and consolidated as possible so that it's that 
> much easier to delete in future :)

Well, it is logically separate, and this keeps it tidy.  But I agree
with the long term goal of killing off this awkward API that should
never have been added.

>
> I guess there is a certain symmetry with mmap(), so if that's the angle 
> you're dead set on, could we at least keep this guy down where 
> __iommu_dma_get_sgtable_page() was?

It is up there so that we can reduce the number of ifdef blocks for
dma remapping later on.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
