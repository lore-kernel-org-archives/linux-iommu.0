Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF06C433F5
	for <iommu@archiver.kernel.org>; Wed, 30 Mar 2022 04:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D704740510;
	Wed, 30 Mar 2022 04:35:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TaS05gUour3f; Wed, 30 Mar 2022 04:35:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B71D4400FD;
	Wed, 30 Mar 2022 04:35:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E7AEC001D;
	Wed, 30 Mar 2022 04:35:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9F73C0012
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 04:35:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 87FA240142
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 04:35:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qsHSkFEVybnd for <iommu@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 04:35:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5603C400FD
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 04:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648614948; x=1680150948;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ZoWj1iYnMYM7xNhqLBqkQbeVYvtNJbctzqx4BvnGBYs=;
 b=T90Klg3M0BHK2reIOaNCcqtqqZ9hFPoyW9G2CAVhzQay9tiJKI/uzFmu
 XDJ39Ns94pAkpGafUJZOrn3XhvKva0m2f9h6f7BSMsOXJZPrGZDshwLH6
 RSyrmWofrwUolep3+kw3nyPfW8bnHjt9oK4s8BpqpjHWy4nGDBHVDaMXe
 DjSYZslg1HI0FtN0q4PKbJC4U8LTbmDessLQJH0Lk4P2a3Apm+rkQzoxh
 LR4PSAwk1zZOqV9vNw4SKdMyszyEj6z1Owu26gMcF0j8/Ini6szvxxolT
 SKdG7QHbzLlPIuImzdu55wg05ERXiTtdvlssEzl2lLJbzdFKdfBTbw5P7 Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="322625854"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; d="scan'208";a="322625854"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2022 21:35:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; d="scan'208";a="565256560"
Received: from unknown (HELO [10.249.164.87]) ([10.249.164.87])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2022 21:35:43 -0700
Message-ID: <d46a3f73-4e0f-c86a-f8f8-ff207bedf4e5@linux.intel.com>
Date: Wed, 30 Mar 2022 12:35:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v2 03/11] iommu/sva: Add iommu_domain type for SVA
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@intel.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-4-baolu.lu@linux.intel.com>
 <20220329143848.2e763727@jacob-builder>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220329143848.2e763727@jacob-builder>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
 Will Deacon <will@kernel.org>
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

On 2022/3/30 5:38, Jacob Pan wrote:
>> +static struct iommu_domain *
>> +iommu_sva_alloc_domain(struct device *dev, struct mm_struct *mm)
>> +{
>> +	struct bus_type *bus = dev->bus;
>> +	struct iommu_sva_cookie *cookie;
>> +	struct iommu_domain *domain;
>> +	void *curr;
>> +
>> +	if (!bus || !bus->iommu_ops)
>> +		return NULL;
>> +
>> +	cookie = kzalloc(sizeof(*cookie), GFP_KERNEL);
>> +	if (!cookie)
>> +		return NULL;
>> +
>> +	domain = bus->iommu_ops->domain_alloc(IOMMU_DOMAIN_SVA);
>> +	if (!domain)
>> +		goto err_domain_alloc;
>> +
>> +	cookie->mm = mm;
>> +	cookie->pasid = mm->pasid;
> How do you manage the mm life cycle? do you require caller take mm reference?
> Or this should be limited to the current mm?
> 

The existing sva_bind() interface requires the caller to take the mm
reference before calling it. So mm is safe during sva bind() and
unbind().

drivers/iommu/iommu.c:
/**
  * iommu_sva_bind_device() - Bind a process address space to a device
  * @dev: the device
  * @mm: the mm to bind, caller must hold a reference to it
  * @drvdata: opaque data pointer to pass to bind callback
  *
  * Create a bond between device and address space, allowing the device 
to access
  * the mm using the returned PASID. If a bond already exists between 
@device and
  * @mm, it is returned and an additional reference is taken. Caller 
must call
  * iommu_sva_unbind_device() to release each reference.
  *
  * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called 
first, to
  * initialize the required SVA features.
  *
  * On error, returns an ERR_PTR value.
  */
struct iommu_sva *
iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void 
*drvdata)

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
