Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5642C433EF
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 12:53:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7BA774036A;
	Tue, 12 Apr 2022 12:53:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rMOa8TPzQXin; Tue, 12 Apr 2022 12:53:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5078E40469;
	Tue, 12 Apr 2022 12:53:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27220C0033;
	Tue, 12 Apr 2022 12:53:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAF6EC002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 12:53:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A2648333F
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 12:53:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FcZewpFxVtlS for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 12:53:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D7F8A82F98
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 12:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649768000; x=1681304000;
 h=message-id:date:mime-version:cc:to:references:from:
 subject:in-reply-to:content-transfer-encoding;
 bh=3p+HZigMoDJf+SmGF5tM7x7zvBgqrhGgl3QbbiaEU7I=;
 b=JTFCxR5VxOJW/TgnO5Tu43UYQW1G71gsJwKvKQGTQ/shqJxq8ogaKrjk
 I3RztTRgXNDc2GZxIKZsqDy+IuxVKGK4amneU8vw24bzp3Hk3KVwG+QYr
 GTXeHnxUU2qIBJARM0TWUWn9PAjcs7zLl2FmbmkCWQ3FXdlERG0smjhRZ
 aMQtgu4MEqJ4ltLmDddNC92OJ4qBzHgXYtRBpAb3MtMaFzjqfGpIpXzzt
 2dfHz6jK9hXPODIxCo5djKD6Vzvlt0FlVGgWK8WqGclM79bpooB4rf8V3
 XpgBoAWEYeV4rYbiE5aZ8YeH71XAmH2JMKpi0LVLXhW3cMNaGojOgIGU3 Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="259962181"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; d="scan'208";a="259962181"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 05:53:20 -0700
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; d="scan'208";a="572752923"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.174])
 ([10.254.210.174])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 05:53:13 -0700
Message-ID: <1289f780-143e-004c-41ac-d95b6f18d63c@linux.intel.com>
Date: Tue, 12 Apr 2022 20:53:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
 <20220410102443.294128-9-baolu.lu@linux.intel.com>
 <BN9PR11MB5276BCAA64597FE400DF15CF8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC v3 08/12] iommu/sva: Use attach/detach_pasid_dev in
 SVA interfaces
In-Reply-To: <BN9PR11MB5276BCAA64597FE400DF15CF8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

On 2022/4/12 15:19, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Sunday, April 10, 2022 6:25 PM
>> +struct iommu_sva *
>> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void
>> *drvdata)
>> +{
>> +	int ret = -EINVAL;
>> +	struct iommu_sva *handle;
>> +	struct iommu_domain *domain;
>> +	struct iommu_sva_ioas *ioas;
>> +
>> +	/*
>> +	 * TODO: Remove the drvdata parameter after kernel PASID support
>> is
>> +	 * enabled for the idxd driver.
>> +	 */
>> +	if (drvdata)
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +
>> +	/* Allocate mm->pasid if necessary. */
>> +	ret = iommu_sva_alloc_pasid(mm, 1, (1U << dev->iommu->pasid_bits)
>> - 1);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>> +	mutex_lock(&iommu_sva_lock);
>> +	ioas = iommu_sva_ioas_get(mm, mm->pasid);
>> +	if (!ioas) {
>> +		ret = -ENOMEM;
> 
> ioas can be NULL for multiple reasons, e.g. :
> 
> 1) ioas->mm != mm;
> 2) kzalloc failure;
> 3) xa_store failure;
> 
> It's more sensible to return error from iommu_sva_ioas_get() directly.

Fair enough.

> 
>> +		goto out_unlock;
>> +	}
>> +
>> +	/* Search for an existing bond. */
>> +	list_for_each_entry(handle, &ioas->bonds, node) {
>> +		if (handle->dev == dev) {
>> +			refcount_inc(&handle->users);
>> +			/* No new bond, drop the counter. */
>> +			iommu_sva_ioas_put(ioas);
>> +			goto out_success;
>> +		}
>> +	}
>> +
>> +	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> 
> s/handle/bond/?

"handle" is used in the previous implementation but "bond" looks better
to read. :-)

> 
>> +	if (!handle) {
>> +		ret = -ENOMEM;
>> +		goto out_put_ioas;
>> +	}
>> +
>> +	/* The reference to ioas will be kept until domain free. */
>> +	domain = iommu_sva_alloc_domain(dev, ioas);
> 
> Shouldn't we first try whether existing domains are compatible to this
> device?

If we think that here domain represents a hardware pagetable actually
used by IOMMU for a {device, pasid}, we are able to use per-{device,
pasid} domain without checking compatibility. Sharing a domain among
devices under the same IOMMU may be an optimization. That could be done
in the IOMMU driver just like what vt-d driver is doing for pass-through
DMA domains.

> 
>> @@ -1952,6 +1954,7 @@ EXPORT_SYMBOL_GPL(iommu_domain_alloc);
>>   void iommu_domain_free(struct iommu_domain *domain)
>>   {
>>   	iommu_put_dma_cookie(domain);
>> +	iommu_sva_ioas_put(domain->sva_ioas);
>>   	domain->ops->free(domain);
>>   }
> 
> is it good to have general iommu_domain_free() to always call a put()
> function for a specific domain type? Why cannot it be done before
> calling iommu_domain_free() in sva-lib.c?

It's better to have a generic free() helper since an sva domain could be
freed outside of iommu sva code as you can see in the following patches.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
