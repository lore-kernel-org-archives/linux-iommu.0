Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F10C43334
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 05:41:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DAF34097F;
	Tue, 28 Jun 2022 05:41:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1DAF34097F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aC+98JUT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R7BaF1SpL_04; Tue, 28 Jun 2022 05:41:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5F6A640931;
	Tue, 28 Jun 2022 05:41:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F6A640931
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DF6DC0039;
	Tue, 28 Jun 2022 05:41:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D12C3C002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 05:41:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 97299401A4
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 05:41:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 97299401A4
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=aC+98JUT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2GuW8OgcQDT6 for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 05:41:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7B6B240017
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7B6B240017
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 05:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656394895; x=1687930895;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=UxZR/mfdIqnqviiBYRwMkxb2Ju8jlNFffAZNscjJglY=;
 b=aC+98JUT06y8SJVnljTQbK7VC0fIBxYWCzXydwBe8mGJGFek+z0Vt9r0
 9p7eeLqOsXU6XDtMbompX2GuCmaSIXTME8Ehwo05TjzDiYQ3FgK5H2F/i
 SKHMGZhnDZURTUUmtfqzMkSNQm45ksO443wZVu4h+PIPi+22ONNhlW/YQ
 EmEetnHGTz/Jzo+07iZW3T6NOOJtxxdjJFEoK4XCO+JqeZY7Yzte/q2AI
 KR9oOqBDgWXTqZ88Fp7HNPDbzaMcI/K/9V5MrIHIoBRL982k4KIVDY37P
 5k3Aa4w8ErVNRWYb0WADe/4b0wpsl/5sXm7u5hGeQRNZZL9/yFPDAjbJ1 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="343328487"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="343328487"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2022 22:41:34 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="646758511"
Received: from ltang11-mobl1.ccr.corp.intel.com (HELO [10.249.169.64])
 ([10.249.169.64])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2022 22:41:30 -0700
Message-ID: <42825be5-e24c-0f95-f49d-5f50d608506d@linux.intel.com>
Date: Tue, 28 Jun 2022 13:41:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v9 04/11] iommu: Add sva iommu_domain support
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-5-baolu.lu@linux.intel.com>
 <BN9PR11MB5276FA1A1A8C20786D958C048CB99@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276FA1A1A8C20786D958C048CB99@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>
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

Hi Kevin,

On 2022/6/27 16:29, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 21, 2022 10:44 PM
>>
>> The sva iommu_domain represents a hardware pagetable that the IOMMU
>> hardware could use for SVA translation. This adds some infrastructure
>> to support SVA domain in the iommu common layer. It includes:
>>
>> - Extend the iommu_domain to support a new IOMMU_DOMAIN_SVA
>> domain
>>    type. The IOMMU drivers that support SVA should provide the sva
>>    domain specific iommu_domain_ops.
>> - Add a helper to allocate an SVA domain. The iommu_domain_free()
>>    is still used to free an SVA domain.
>> - Add helpers to attach an SVA domain to a device and the reverse
>>    operation.
>>
>> Some buses, like PCI, route packets without considering the PASID value.
>> Thus a DMA target address with PASID might be treated as P2P if the
>> address falls into the MMIO BAR of other devices in the group. To make
>> things simple, the attach/detach interfaces only apply to devices
>> belonging to the singleton groups, and the singleton is immutable in
>> fabric i.e. not affected by hotplug.
>>
>> The iommu_attach/detach_device_pasid() can be used for other purposes,
>> such as kernel DMA with pasid, mediation device, etc.
> 
> I'd split this into two patches. One for adding iommu_attach/
> detach_device_pasid() and set/block_dev_pasid ops, and the
> other for adding SVA.

Yes. Make sense.

> 
>>   struct iommu_domain {
>>   	unsigned type;
>>   	const struct iommu_domain_ops *ops;
>>   	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
>> -	iommu_fault_handler_t handler;
>> -	void *handler_token;
>>   	struct iommu_domain_geometry geometry;
>>   	struct iommu_dma_cookie *iova_cookie;
>> +	union {
>> +		struct {	/* IOMMU_DOMAIN_DMA */
>> +			iommu_fault_handler_t handler;
>> +			void *handler_token;
>> +		};
> 
> why is it DMA domain specific? What about unmanaged
> domain? Unrecoverable fault can happen on any type
> including SVA. Hence I think above should be domain type
> agnostic.

The report_iommu_fault() should be replaced by the new
iommu_report_device_fault(). Jean has already started this work.

https://lore.kernel.org/linux-iommu/Yo4Nw9QyllT1RZbd@myrica/

Currently this is only for DMA domains, hence Robin suggested to make it
exclude with the SVA domain things.

https://lore.kernel.org/linux-iommu/f3170016-4d7f-e78e-db48-68305f683349@arm.com/

> 
>> +		struct {	/* IOMMU_DOMAIN_SVA */
>> +			struct mm_struct *mm;
>> +		};
>> +	};
>>   };
>>
> 
> 
> 
>> +
>> +struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>> +					    struct mm_struct *mm)
>> +{
>> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>> +	struct iommu_domain *domain;
>> +
>> +	domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
>> +	if (!domain)
>> +		return NULL;
>> +
>> +	domain->type = IOMMU_DOMAIN_SVA;
> 
> It's a bit weird that the type has been specified when calling
> ops->domain_alloc while it still leaves to the caller to set the
> type. But this is not caused by this series. could be cleaned
> up separately.

Yes. Robin has patches to refactor the domain allocation interface,
let's wait and see what it looks like finally.

> 
>> +
>> +	mutex_lock(&group->mutex);
>> +	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain,
>> GFP_KERNEL);
>> +	if (curr)
>> +		goto out_unlock;
> 
> Need check xa_is_err(old).

Either

(1) old entry is a valid pointer, or
(2) xa_is_err(curr)

are failure cases. Hence, "curr == NULL" is the only check we need. Did
I miss anything?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
