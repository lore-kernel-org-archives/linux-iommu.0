Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AB9CCA479
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 05:57:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B5D7410E1;
	Tue, 28 Jun 2022 05:57:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5B5D7410E1
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q2d8uOFu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KRIyQjmRMW9W; Tue, 28 Jun 2022 05:57:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D48C9410D6;
	Tue, 28 Jun 2022 05:57:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D48C9410D6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98FB9C0032;
	Tue, 28 Jun 2022 05:57:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89EB1C002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 05:57:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5DDCA410D5
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 05:57:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5DDCA410D5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WDXNglcyWa8u for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 05:56:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 40639410D3
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 40639410D3
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 05:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656395819; x=1687931819;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=jkkFnV1SzLceUSN26FhY9YeMuVcIqRLbH9OTJaJLTP8=;
 b=Q2d8uOFupiaF/bNKEsTum+ZW9Uo54O7BSzGLxMNqobpv2HvfLT7lOapt
 ZegDtWtC06EWTxgtcvDVgbrlLxUSItPmWzpLICMdlfQBB1QaCqgeSOql2
 xI9Kg0U8CkFOi42KsFVRLUmwSDbQbzQArfbhMS9qESNiBMKaMAlY0LUcX
 5FAN60JGXgEakueC9I8V6XV9j5nT6WIRhVPFvjq7Bn8he2Sc6FE4f1q9D
 rehSZp2PeUE3xTZlZq+qU13eUAyphEGCvl1oMv/2/F0fS9rL46v+t6XIW
 ajFtxc4hGtWj0tXJ10Tqws8GoabLJH1YlMcGisDOHk9BtnBX3spne06sV A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="279188564"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="279188564"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2022 22:53:46 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="646762122"
Received: from ltang11-mobl1.ccr.corp.intel.com (HELO [10.249.169.64])
 ([10.249.169.64])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2022 22:53:37 -0700
Message-ID: <543603e3-9d08-59ee-01f2-8dd6e7c73a15@linux.intel.com>
Date: Tue, 28 Jun 2022 13:53:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v9 07/11] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276297FAEB8C9774AABAD208CB99@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276297FAEB8C9774AABAD208CB99@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
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

On 2022/6/27 18:14, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 21, 2022 10:44 PM
>> +struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct
>> mm_struct *mm)
>> +{
>> +	struct iommu_domain *domain;
>> +	ioasid_t max_pasids;
>> +	int ret = -EINVAL;
>> +
>> +	/* Allocate mm->pasid if necessary. */
> 
> this comment is for iommu_sva_alloc_pasid()

Updated.

> 
>> +	max_pasids = dev->iommu->max_pasids;
>> +	if (!max_pasids)
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +
>> +	ret = iommu_sva_alloc_pasid(mm, 1, max_pasids - 1);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
> 
> 
> ...
>> +void iommu_sva_unbind_device(struct iommu_sva *handle)
>> +{
>> +	struct device *dev = handle->dev;
>> +	struct iommu_domain *domain =
>> +			container_of(handle, struct iommu_domain, bond);
>> +	ioasid_t pasid = iommu_sva_get_pasid(handle);
>> +
>> +	mutex_lock(&iommu_sva_lock);
>> +	if (refcount_dec_and_test(&domain->bond.users)) {
>> +		iommu_detach_device_pasid(domain, dev, pasid);
>> +		iommu_domain_free(domain);
>> +	}
>> +	mutex_unlock(&iommu_sva_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
>> +
>> +u32 iommu_sva_get_pasid(struct iommu_sva *handle)
>> +{
>> +	struct iommu_domain *domain =
>> +			container_of(handle, struct iommu_domain, bond);
>> +
>> +	return domain->mm->pasid;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
> 
> Looks this is only used by unbind_device. Just open code it.

It's part of current IOMMU/SVA interfaces for the device drivers, and
has been used in various drivers.

$ git grep iommu_sva_get_pasid
drivers/dma/idxd/cdev.c:                pasid = iommu_sva_get_pasid(sva);
drivers/iommu/iommu-sva-lib.c:  ioasid_t pasid = 
iommu_sva_get_pasid(handle);
drivers/iommu/iommu-sva-lib.c:u32 iommu_sva_get_pasid(struct iommu_sva 
*handle)
drivers/iommu/iommu-sva-lib.c:EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
drivers/misc/uacce/uacce.c:     pasid = iommu_sva_get_pasid(handle);
include/linux/iommu.h:u32 iommu_sva_get_pasid(struct iommu_sva *handle);
include/linux/iommu.h:static inline u32 iommu_sva_get_pasid(struct 
iommu_sva *handle)

Or, I missed anything?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
