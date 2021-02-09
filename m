Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4A9C433E6
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 11:16:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A7D864E8B
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 11:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7D864E8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CD9F286F65;
	Tue,  9 Feb 2021 11:16:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XEVsKK3flX0X; Tue,  9 Feb 2021 11:16:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5302D86F61;
	Tue,  9 Feb 2021 11:16:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 475EBC0891;
	Tue,  9 Feb 2021 11:16:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27DBAC013A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 11:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2245386D23
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 11:16:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YEhS7FuwfZqf for <iommu@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 11:16:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id AE32F86D48
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 11:16:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7FC8ED1;
 Tue,  9 Feb 2021 03:16:12 -0800 (PST)
Received: from [10.57.49.26] (unknown [10.57.49.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBE543F73B;
 Tue,  9 Feb 2021 03:16:09 -0800 (PST)
Subject: Re: [RFC PATCH 10/11] vfio/iommu_type1: Optimize dirty bitmap
 population based on iommu HWDBM
To: Yi Sun <yi.y.sun@linux.intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
References: <20210128151742.18840-1-zhukeqian1@huawei.com>
 <20210128151742.18840-11-zhukeqian1@huawei.com>
 <20210207095630.GA28580@yi.y.sun>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <8150bd3a-dbb9-2e2b-386b-04e66f4b68dc@arm.com>
Date: Tue, 9 Feb 2021 11:16:08 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210207095630.GA28580@yi.y.sun>
Content-Language: en-GB
Cc: Mark Rutland <mark.rutland@arm.com>, kevin.tian@intel.com,
 Cornelia Huck <cohuck@redhat.com>, yan.y.zhao@intel.com, kvm@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, jiangkunkun@huawei.com,
 Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, lushenming@huawei.com,
 Kirti Wankhede <kwankhede@nvidia.com>, James Morse <james.morse@arm.com>,
 Marc Zyngier <maz@kernel.org>, wanghaibin.wang@huawei.com,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-02-07 09:56, Yi Sun wrote:
> Hi,
> 
> On 21-01-28 23:17:41, Keqian Zhu wrote:
> 
> [...]
> 
>> +static void vfio_dma_dirty_log_start(struct vfio_iommu *iommu,
>> +				     struct vfio_dma *dma)
>> +{
>> +	struct vfio_domain *d;
>> +
>> +	list_for_each_entry(d, &iommu->domain_list, next) {
>> +		/* Go through all domain anyway even if we fail */
>> +		iommu_split_block(d->domain, dma->iova, dma->size);
>> +	}
>> +}
> 
> This should be a switch to prepare for dirty log start. Per Intel
> Vtd spec, there is SLADE defined in Scalable-Mode PASID Table Entry.
> It enables Accessed/Dirty Flags in second-level paging entries.
> So, a generic iommu interface here is better. For Intel iommu, it
> enables SLADE. For ARM, it splits block.

 From a quick look, VT-D's SLADE and SMMU's HTTU appear to be the exact 
same thing. This step isn't about enabling or disabling that feature 
itself (the proposal for SMMU is to simply leave HTTU enabled all the 
time), it's about controlling the granularity at which the dirty status 
can be detected/reported at all, since that's tied to the pagetable 
structure.

However, if an IOMMU were to come along with some other way of reporting 
dirty status that didn't depend on the granularity of individual 
mappings, then indeed it wouldn't need this operation.

Robin.

>> +
>> +static void vfio_dma_dirty_log_stop(struct vfio_iommu *iommu,
>> +				    struct vfio_dma *dma)
>> +{
>> +	struct vfio_domain *d;
>> +
>> +	list_for_each_entry(d, &iommu->domain_list, next) {
>> +		/* Go through all domain anyway even if we fail */
>> +		iommu_merge_page(d->domain, dma->iova, dma->size,
>> +				 d->prot | dma->prot);
>> +	}
>> +}
> 
> Same as above comment, a generic interface is required here.
> 
>> +
>> +static void vfio_iommu_dirty_log_switch(struct vfio_iommu *iommu, bool start)
>> +{
>> +	struct rb_node *n;
>> +
>> +	/* Split and merge even if all iommu don't support HWDBM now */
>> +	for (n = rb_first(&iommu->dma_list); n; n = rb_next(n)) {
>> +		struct vfio_dma *dma = rb_entry(n, struct vfio_dma, node);
>> +
>> +		if (!dma->iommu_mapped)
>> +			continue;
>> +
>> +		/* Go through all dma range anyway even if we fail */
>> +		if (start)
>> +			vfio_dma_dirty_log_start(iommu, dma);
>> +		else
>> +			vfio_dma_dirty_log_stop(iommu, dma);
>> +	}
>> +}
>> +
>>   static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
>>   					unsigned long arg)
>>   {
>> @@ -2812,8 +2900,10 @@ static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
>>   		pgsize = 1 << __ffs(iommu->pgsize_bitmap);
>>   		if (!iommu->dirty_page_tracking) {
>>   			ret = vfio_dma_bitmap_alloc_all(iommu, pgsize);
>> -			if (!ret)
>> +			if (!ret) {
>>   				iommu->dirty_page_tracking = true;
>> +				vfio_iommu_dirty_log_switch(iommu, true);
>> +			}
>>   		}
>>   		mutex_unlock(&iommu->lock);
>>   		return ret;
>> @@ -2822,6 +2912,7 @@ static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
>>   		if (iommu->dirty_page_tracking) {
>>   			iommu->dirty_page_tracking = false;
>>   			vfio_dma_bitmap_free_all(iommu);
>> +			vfio_iommu_dirty_log_switch(iommu, false);
>>   		}
>>   		mutex_unlock(&iommu->lock);
>>   		return 0;
>> -- 
>> 2.19.1
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
