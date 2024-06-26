Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2219117B50F
	for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407302; cv=none; b=aEnWJH6ED4n5bA2QC5dacMsit6Xy4xyLve5wOVpgDD8l9reB/NLqgVPxGQcA8Om01UbD8REYFj5fbn6vkiW850oHUfRjbPysuoj9xkfnMuAR80pFzZHZ0uJV08ZDjKsXu1q26Gi7aK6AM/Da4ujLBLPF+DRx98z2E4I4TrME15I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407302; c=relaxed/simple;
	bh=73KR6Ej2ApKphd24Pl1eiILZBGG1dwgteOBL5XjDHQQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Cq4q3KCJhU7b2GrYwGoh/HCiGe9fv/yz4HpXUjKh/m1lGW0826GvSD2ElbaiZIZQKys5pp4+1VVRwFFxyTRQff+HUe7/Gqf6ETov8Ht4oyTLTa1R93MGVJ8gnhtjsncaDw+NwAxn/SGmqc6ilcR85XGjV6ZfCg2ixK5u2qM7sfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nSou/nZk; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nSou/nZk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719407301; x=1750943301;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=73KR6Ej2ApKphd24Pl1eiILZBGG1dwgteOBL5XjDHQQ=;
  b=nSou/nZk+omaZ6Dkb+onCkNlW5E9N5AERKGHleUfDxk9Dj1rciQ2WxCN
   sUApuEW/OY/VmQga+pclAVTjPt+WYLcH1MDLzxvN7KEBbNnzh1iWcVzK3
   603NoOnubRHUf/UUBkfgPmaoXpswVFVPKflRDZjKZbIEcq69p7ZOqufjj
   S9UTt2BkuYWeaAGJIz65Ntx4RDZ4EYi6fHvz0vC79a7sYpOwIeOfINFsz
   8lCUZj61RuyH0N/QzpwLXXAxjoO+V4+n4RPCzDmQUOpr7z9x/JLlq8ERt
   eee7u6jo/BWxUc3Apo2s+xoq69qELSyaTtqkkbkwpRR7ubsMAenDP0Puw
   Q==;
X-CSE-ConnectionGUID: n6gFGYthTKCdo8TrUXVQgw==
X-CSE-MsgGUID: 75xquK5uRd+b2g2Av18Rew==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16356321"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="16356321"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 06:05:12 -0700
X-CSE-ConnectionGUID: np6vIdDzSbetGwSXRpzCEQ==
X-CSE-MsgGUID: e9ivyvPHR/mafUNCCf65OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="48445013"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 06:05:10 -0700
Message-ID: <e3888b78-c787-4a2d-bd43-7dcddc2b5bb9@linux.intel.com>
Date: Wed, 26 Jun 2024 21:05:07 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/vt-d: Refactor PCI PRI enabling/disabling callbacks
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20240606034019.42795-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276E8767AB63378C81130528CD62@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276E8767AB63378C81130528CD62@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/26 14:53, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, June 6, 2024 11:40 AM
>>
>> +/*
>> + * Invalidate the caches for a present-to-present change in a context
>> + * table entry according to the Spec 6.5.3.3 (Guidance to Software for
>> + * Invalidations).
>> + *
>> + * Since context entry is not encoded by domain-id when operating in
>> + * scalable-mode (refer Section 6.2.1), this performs coarser
>> + * invalidation than the domain-selective granularity requested.
>> + */
>> +static void invalidate_present_context_change(struct device_domain_info
>> *info)
>> +{
>> +	struct intel_iommu *iommu = info->iommu;
>> +
>> +	iommu->flush.flush_context(iommu, 0, 0, 0,
>> DMA_CCMD_GLOBAL_INVL);
>> +	if (sm_supported(iommu))
>> +		qi_flush_pasid_cache(iommu, 0, QI_PC_GLOBAL, 0);
>> +	iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
>> +	__iommu_flush_dev_iotlb(info, 0, MAX_AGAW_PFN_WIDTH);
>> +}
>> +
> 
> this invalidates the entire cache/iotlb for all devices behind this
> iommu just due to a PRI enable/disable operation on a single
> device.
> 
> No that's way too much. If there is a burden to identify all active
> DIDs used by this device then pay it and penalize only that device.

You are right. We should not simplify the flow like this.

> 
> btw in concept PRI will not be enabled/disabled when there are
> PASIDs of this device being actively attached. So at this point
> there should only be RID with attached domain then we only
> need to find that DID out and use it to invalidate related caches.

The assumption of "PRI will not be enabled/disabled when there are
PASIDs of this device being actively attached" is not always correct.
Both the pasid domain attachment and PRI are controlled by the device
driver and there is no order rules for the drivers.

For example, the idxd driver attaches the default domain to a PASID and
use it for kernel ENQCMD and use other PASIDs for SVA usage.

I am considering working out a generic helper to handle caches after
change to a context entry what was present. How do you like below code
(compiled but not tested)?

/*
  * Cache invalidations after change in a context table entry that was 
present
  * according to the Spec 6.5.3.3 (Guidance to Software for 
Invalidations). If
  * IOMMU is in scalable mode and all PASID table entries of the device were
  * non-present, set affect_domains to true. Otherwise, false.
  */
void intel_context_flush_present(struct device_domain_info *info,
				 struct context_entry *context,
				 bool affect_domains)
{
	struct intel_iommu *iommu = info->iommu;
	u16 did = context_domain_id(context);
	struct pasid_entry *pte;
	int i;

	assert_spin_locked(&iommu->lock);

	/*
	 * Device-selective context-cache invalidation. The Domain-ID field
	 * of the Context-cache Invalidate Descriptor is ignored by hardware
	 * when operating in scalable mode. Therefore the @did value doesn't
	 * matter in scalable mode.
	 */
	iommu->flush.flush_context(iommu, did, PCI_DEVID(info->bus, info->devfn),
				   DMA_CCMD_MASK_NOBIT, DMA_CCMD_DEVICE_INVL);

	/*
	 * For legacy mode:
	 * - Domain-selective IOTLB invalidation
	 * - Global Device-TLB invalidation to all affected functions
	 */
	if (!sm_supported(iommu)) {
		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
		__iommu_flush_dev_iotlb(info, 0, MAX_AGAW_PFN_WIDTH);

		return;
	}

	/*
	 * For scalable mode:
	 * - Domain-selective PASID-cache invalidation to affected domains
	 * - Domain-selective IOTLB invalidation to affected domains
	 * - Global Device-TLB invalidation to affected functions
	 */
	if (affect_domains) {
		for (i = 0; i < info->pasid_table->max_pasid; i++) {
			pte = intel_pasid_get_entry(info->dev, i);
			if (!pte || !pasid_pte_is_present(pte))
				continue;

			did = pasid_get_domain_id(pte);
			qi_flush_pasid_cache(iommu, did, QI_PC_ALL_PASIDS, 0);
			iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
		}
	}

	__iommu_flush_dev_iotlb(info, 0, MAX_AGAW_PFN_WIDTH);
}

Best regards,
baolu
