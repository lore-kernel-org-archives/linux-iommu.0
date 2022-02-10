Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E82C433EF
	for <iommu@archiver.kernel.org>; Thu, 10 Feb 2022 01:11:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03B0460E5E;
	Thu, 10 Feb 2022 01:11:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P35SVNtz3gvF; Thu, 10 Feb 2022 01:11:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D648560BF2;
	Thu, 10 Feb 2022 01:11:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9F13C0011;
	Thu, 10 Feb 2022 01:11:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 769E2C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 01:11:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 63895402E1
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 01:11:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 47YFojcOVHyy for <iommu@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 01:11:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 723B040004
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 01:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644455512; x=1675991512;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=aWgYdPh3hxkc5p9L3CTkYdSFZfZ5U7JLDAtc29XbeFU=;
 b=QrMv9WojgjsTWa2yhAwAhNYTJLhc2KGQCqoD8/wa73SON/ZfQecruSAY
 KWwzvmj4N80F946DPMIayNvO7zDH3c5goGmfyDYrpR/a8PMUTwUDZWsI+
 /DGaJ9hITWmREipcrMgmLI3xJ3Fc6BIJeehlq0ymeU+/Bnz3toTJBdYOG
 eQbQ5BJLZfLLUcLyZgJMlRuZMGpdVa4At2uffw4ZeFcNkpFR3i9LqkbLo
 /FQP8eKoT5ApPmgwbpd79saGSWP7UsfqKKUtqoyssjmaJMA+qQfMpAWLu
 /xwJ+V9i/hZUF/ra1XVcjbjWEsteW0mCtBIHDvihjVGCflnnfB/YO2nZl Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="335792988"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; d="scan'208";a="335792988"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2022 17:11:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; d="scan'208";a="678973478"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 09 Feb 2022 17:11:47 -0800
Message-ID: <2707a77d-6171-0180-fa0e-72cf44719ed7@linux.intel.com>
Date: Thu, 10 Feb 2022 09:10:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 09/10] iommu: Use dev_iommu_ops() helper
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
 <20220208012559.1121729-10-baolu.lu@linux.intel.com>
 <20220209134152.GA4160@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220209134152.GA4160@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 David Airlie <airlied@linux.ie>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
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

On 2/9/22 9:41 PM, Jason Gunthorpe wrote:
> On Tue, Feb 08, 2022 at 09:25:58AM +0800, Lu Baolu wrote:
>> Convert all the feasible instances of dev->bus->iommu_ops to
>> dev_iommu_ops() in order to making the operation of obtaining
>> iommu_ops from a device consistent.
> 
> Why are there two patches doing this conversion? Roll this into the
> prior patch?

It's reasonable to merge this patch into the previous one where
dev_iommu_ops() was added.

> 
>>   void iommu_get_resv_regions(struct device *dev, struct list_head *list)
>>   {
>> -	const struct iommu_ops *ops = dev->bus->iommu_ops;
>> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>>   
>>   	if (ops && ops->get_resv_regions)
>>   		ops->get_resv_regions(dev, list);
> 
> And agree with Christoph, don't keep confusing ops null tests -
> dev_iommu_ops() never returns null and any function using it must rely
> on the caller to handle this, somehow.

Agree with you both.

> 
> However, I wonder how safe this is. Certainly some APIs like this one
> it is fine, but I would be happier if the 'first' APIs like
> bind/attach/alloc/etc fail silently upwards. In many cases these APIs
> are called based on things like DT configuration, or VFIO or
> something, and the caller is expecting the iommu layer to do all
> necessary validation.

domain_alloc()/bind/unbind/attach/detach/etc are APIs for external
kernel components. We shouldn't use dev_iommu_ops() there and all
necessary validation should be done.

The dev_iommu_ops() are for IOMMU subsystem internal use purpose, hence
we can add a WARN there and avoid further checks.

> 
>> @@ -2788,7 +2789,7 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
>>   {
>>   	struct iommu_group *group;
>>   	struct iommu_sva *handle = ERR_PTR(-EINVAL);
>> -	const struct iommu_ops *ops = dev->bus->iommu_ops;
>> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>>   
>>   	if (!ops || !ops->sva_bind)
>>   		return ERR_PTR(-ENODEV);
>> @@ -2831,7 +2832,7 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>>   {
>>   	struct iommu_group *group;
>>   	struct device *dev = handle->dev;
>> -	const struct iommu_ops *ops = dev->bus->iommu_ops;
>> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>>   
>>   	if (!ops || !ops->sva_unbind)
>>   		return;
>> @@ -2850,7 +2851,7 @@ EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
>>   
>>   u32 iommu_sva_get_pasid(struct iommu_sva *handle)
>>   {
>> -	const struct iommu_ops *ops = handle->dev->bus->iommu_ops;
>> +	const struct iommu_ops *ops = dev_iommu_ops(handle->dev);
>>   
>>   	if (!ops || !ops->sva_get_pasid)
>>   		return IOMMU_PASID_INVALID;
> 
> We all agreed that this sva object will turn into a domain and thus
> all of this will eventually move to domain ops?

Partially yes.

My plan is to leverage the sva-domain specific .attach/detach_dev_pasid
callbacks. All the sva related ops in iommu_ops could be removed.

> 
> Jason

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
