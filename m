Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6837C433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:21:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65B2D4187A;
	Wed, 11 May 2022 07:21:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D8PeYi7zpXqb; Wed, 11 May 2022 07:21:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F26EC41883;
	Wed, 11 May 2022 07:21:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE1C6C0039;
	Wed, 11 May 2022 07:21:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C12FC002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:21:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 74FD981336
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:21:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wJhAUt5Pq7aW for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:21:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9EE4B81242
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652253699; x=1683789699;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=WRk+Mj38yZ5XuDxKKjAT+LROx+EdfwdtEsjJvOuTgP4=;
 b=YGO4RNhm4sx7C/hCtxO39BL7+e15xV99wbWNRTj2sfptOxpkNP5wQ2U7
 j22A44u3MWGhAPXvgFVe5jLCDZZHc4kW4IdeINfbDMPSlEbfAat19XX2K
 f1nyHQoJ/FCdYe4J6Ez4AeiAzRLdKiDLrI+6FctXzl7OCsEKmVOX6DN3t
 NqifMeSZNnHC7VWQE9a3athlKzMSULV/5MckJHaaGfoN7OqkqexZofElR
 TaR2vsi2kYcaYa5hD39SmgmJE45AffEsIhiPmNxwfUkUZ+md6ci4mbKmz
 1ou3qhWhET8nIgLBuUkhKE+dgdd+DTHDK8AQ+OfGziZEDfS+8EWx900wa A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="269283801"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; d="scan'208";a="269283801"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 00:21:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; d="scan'208";a="542180435"
Received: from chenji3x-mobl1.ccr.corp.intel.com (HELO [10.255.30.10])
 ([10.255.30.10])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 00:21:35 -0700
Message-ID: <749a7d62-3e6c-ef5c-beaf-6b7add495740@linux.intel.com>
Date: Wed, 11 May 2022 15:21:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 08/12] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-9-baolu.lu@linux.intel.com>
 <20220510152330.GG49344@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220510152330.GG49344@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Robin Murphy <robin.murphy@arm.com>
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

On 2022/5/10 23:23, Jason Gunthorpe wrote:
> On Tue, May 10, 2022 at 02:17:34PM +0800, Lu Baolu wrote:
> 
>> +/**
>> + * iommu_sva_bind_device() - Bind a process address space to a device
>> + * @dev: the device
>> + * @mm: the mm to bind, caller must hold a reference to mm_users
>> + * @drvdata: opaque data pointer to pass to bind callback
>> + *
>> + * Create a bond between device and address space, allowing the device to access
>> + * the mm using the returned PASID. If a bond already exists between @device and
>> + * @mm, it is returned and an additional reference is taken. Caller must call
>> + * iommu_sva_unbind_device() to release each reference.
>> + *
>> + * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
>> + * initialize the required SVA features.
>> + *
>> + * On error, returns an ERR_PTR value.
>> + */
>> +struct iommu_sva *
>> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
>> +{
>> +	int ret = -EINVAL;
>> +	struct iommu_sva *handle;
>> +	struct iommu_domain *domain;
>> +
>> +	/*
>> +	 * TODO: Remove the drvdata parameter after kernel PASID support is
>> +	 * enabled for the idxd driver.
>> +	 */
>> +	if (drvdata)
>> +		return ERR_PTR(-EOPNOTSUPP);
> 
> Why is this being left behind? Clean up the callers too please.

Okay, let me try to.

> 
>> +	/* Allocate mm->pasid if necessary. */
>> +	ret = iommu_sva_alloc_pasid(mm, 1, (1U << dev->iommu->pasid_bits) - 1);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>> +	mutex_lock(&iommu_sva_lock);
>> +	/* Search for an existing bond. */
>> +	handle = xa_load(&dev->iommu->sva_bonds, mm->pasid);
>> +	if (handle) {
>> +		refcount_inc(&handle->users);
>> +		goto out_success;
>> +	}
> 
> How can there be an existing bond?
> 
> dev->iommu is per-device
> 
> The device_group_immutable_singleton() insists on a single device
> group
> 
> Basically 'sva_bonds' is the same thing as the group->pasid_array.

Yes, really.

> 
> Assuming we leave room for multi-device groups this logic should just
> be
> 
> 	group = iommu_group_get(dev);
> 	if (!group)
> 		return -ENODEV;
> 
> 	mutex_lock(&group->mutex);
> 	domain = xa_load(&group->pasid_array, mm->pasid);
> 	if (!domain || domain->type != IOMMU_DOMAIN_SVA || domain->mm != mm)
> 		domain = iommu_sva_alloc_domain(dev, mm);
> 
> ?

Agreed. As a helper in iommu core, how about making it more generic like
below?

+struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
+                                                   iosid_t pasid,
+                                                   unsigned int type)
+{
+       struct iommu_domain *domain;
+       struct iommu_group *group;
+
+       if (!pasid_valid(pasid))
+               return NULL;
+
+       group = iommu_group_get(dev);
+       if (!group)
+               return NULL;
+
+       mutex_lock(&group->mutex);
+       domain = xa_load(&group->pasid_array, pasid);
+       if (domain && domain->type != type)
+               domain = NULL;
+       mutex_unlock(&group->mutex);
+       iommu_group_put(group);
+
+       return domain;
+}

> 
> And stick the refcount in the sva_domain
> 
> Also, given the current arrangement it might make sense to have a
> struct iommu_domain_sva given that no driver is wrappering this in
> something else.

Fair enough. How about below wrapper?

+struct iommu_sva_domain {
+       /*
+        * Common iommu domain header, *must* be put at the top
+        * of the structure.
+        */
+       struct iommu_domain domain;
+       struct mm_struct *mm;
+       struct iommu_sva bond;
+}

The refcount is wrapped in bond.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
