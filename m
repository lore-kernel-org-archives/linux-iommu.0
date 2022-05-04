Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF23C433F5
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 07:58:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8B2AA405B3;
	Wed,  4 May 2022 07:58:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l4qUb6olFJQe; Wed,  4 May 2022 07:58:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 62333400C1;
	Wed,  4 May 2022 07:58:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A72EC0032;
	Wed,  4 May 2022 07:58:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F120C002D
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 07:58:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3F87760AE5
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 07:58:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6WnTLbWbmT5g for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 07:58:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7C41D60A88
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 07:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651651103; x=1683187103;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Oeji1B4yyBuyoQEJOvbEGC1Gb4wYj2jfC/S7tYYEPvI=;
 b=c5xzaS/hApcOXFRnuYbDGynKvS9EmV8idwl3wlm98hL75QCrakeDTese
 JsIY1M36c3uqZV5gcIIYFz2RKyuph7tUFNaW9jMvYt6c/tmO0IxQAx5g4
 qNjEXd37wNhvv1xmB5B31uarZo6kRMpu+kE+R4l+o3EOHzjQ2+O0laa50
 W6DT7ic+HMBlXDDzqQcflHYSVaHq0vTpQcOE9uFi1ON1e59aVWbHTSKOA
 DjLsaAPGyQaT8/BbrfTLABTYQ2VXmSH6Nfoi5OAF+3tI4F2UGx37gGYH6
 +Pqeihieutm+CCVNmhiePw1Cy/zg8WZpYVhjDMtN1joknbek1RfBZqVr5 Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="330682308"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; d="scan'208";a="330682308"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2022 00:58:22 -0700
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; d="scan'208";a="734289803"
Received: from yanc1-mobl.ccr.corp.intel.com (HELO [10.255.30.223])
 ([10.255.30.223])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2022 00:58:20 -0700
Message-ID: <b9787888-1524-e170-0506-c6a012891de6@linux.intel.com>
Date: Wed, 4 May 2022 15:58:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/5] iommu/vt-d: Check domain force_snooping against
 attached devices
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220501112434.874236-1-baolu.lu@linux.intel.com>
 <20220501112434.874236-4-baolu.lu@linux.intel.com>
 <20220502131747.GJ8364@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220502131747.GJ8364@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

On 2022/5/2 21:17, Jason Gunthorpe wrote:
> On Sun, May 01, 2022 at 07:24:32PM +0800, Lu Baolu wrote:
>> +static bool domain_support_force_snooping(struct dmar_domain *domain)
>> +{
>> +	struct device_domain_info *info;
>> +	unsigned long flags;
>> +	bool support = true;
>> +
>> +	spin_lock_irqsave(&device_domain_lock, flags);
>> +	if (list_empty(&domain->devices))
>> +		goto out;
> 
> Why? list_for_each_entry will just do nothing..

Yes. I will remove above two lines.

> 
>> +	list_for_each_entry(info, &domain->devices, link) {
>> +		if (!ecap_sc_support(info->iommu->ecap)) {
>> +			support = false;
>> +			break;
>> +		}
>> +	}
>> +out:
>> +	spin_unlock_irqrestore(&device_domain_lock, flags);
>> +	return support;
>> +}
>> +
>> +static void domain_set_force_snooping(struct dmar_domain *domain)
>> +{
>> +	struct device_domain_info *info;
>> +	unsigned long flags;
>> +
>> +	/*
>> +	 * Second level page table supports per-PTE snoop control. The
>> +	 * iommu_map() interface will handle this by setting SNP bit.
>> +	 */
>> +	if (!domain_use_first_level(domain))
>> +		return;
>> +
>> +	spin_lock_irqsave(&device_domain_lock, flags);
>> +	if (list_empty(&domain->devices))
>> +		goto out_unlock;
>> +
>> +	list_for_each_entry(info, &domain->devices, link)
>> +		intel_pasid_setup_page_snoop_control(info->iommu, info->dev,
>> +						     PASID_RID2PASID);
>> +
>> +out_unlock:
>> +	spin_unlock_irqrestore(&device_domain_lock, flags);
>> +}
>> +
>>   static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
>>   {
>>   	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>>   
>> -	if (!domain_update_iommu_snooping(NULL))
>> +	if (!domain_support_force_snooping(dmar_domain))
>>   		return false;
> 
> Maybe exit early if force_snooping = true?

Yes, should check "force_snooping = true" and return directly if
force_snooping has already been set. As you pointed below, the new
domain_attach should take care of this flag as well. Thanks!

> 
>> +	domain_set_force_snooping(dmar_domain);
>>   	dmar_domain->force_snooping = true;
>> +
>>   	return true;
>>   }
>>   
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index f8d215d85695..815c744e6a34 100644
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -762,3 +762,21 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
>>   
>>   	return 0;
>>   }
>> +
>> +/*
>> + * Set the page snoop control for a pasid entry which has been set up.
>> + */
> 
> So the 'first level' is only used with pasid?

Yes. A fake pasid (RID2PASID in spec) is used for legacy transactions
(those w/o pasid).

> 
>> +void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
>> +					  struct device *dev, u32 pasid)
>> +{
>> +	struct pasid_entry *pte;
>> +	u16 did;
>> +
>> +	pte = intel_pasid_get_entry(dev, pasid);
>> +	if (WARN_ON(!pte || !pasid_pte_is_present(pte)))
>> +		return;
>> +
>> +	pasid_set_pgsnp(pte);
> 
> Doesn't this need to be done in other places too, like when a new attach
> is made? Patch 5 removed it, but should that be made if
> domain->force_snooping?

Yes. I missed this. Will take care of this in the next version.

> 
> Jason

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
