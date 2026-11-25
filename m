Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649626;
	b=G3mjduJ/f4G5ju4eWpvtUHp1+PACchDmKfgKtqFSUMwJ4B+4I0aptjnxE/gvjGlMlcR+
	 F0ZS6sxMVUI3IWTIcwOJYw4kYEBfVBv92oiHDR8LxhQ6mHySgTuEd+yNaRppYkOqaOdBG
	 V1EU8Z3AqQuiiWj+tSL1RkgSnv4Y3dd/YNJNAZ1HhK9Cxr+kqlEnUfiDAGzRDidoJnNL6
	 Ohu2dqhtIkwCDhNagUmNP/GGa+aFZV2b6inEW73kwsG0zso4UFcauKL3ljnH4cqKtmd9g
	 5nZtf8u1QrkrYnxQrbrab3uK8dohhdPa1GUXJB6/2Y8d935/o3oEN9TzFDpCxa8idEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649626;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=b2ogpMRdOGvQOxnTYrtAYFBvprrsM3s8fDuelvc9zDg=;
	b=nVgFwn3vPn5pxnWBsx2w2CS8b0T3K4JsEB9nKxQ0JkdP1M9Qv/F+ZsHeWJJByVpgx1Nx
	 k4kdhtKfx641yuc2Z/knQrbr5Fo4/Uo0iOIBq7n+m+/lO3IpBnEWfT8RsmjZe6UYFwQtC
	 fD89G/AOV9EI7UWqWjkJLcjv6C7cNG6omEzzgHQy72dmZW65jx9SvRlpjrLh2wQpEXqhR
	 IWAzZ5HpfOiZf9m3VYQPgi2YL8jiqL2wLAcOluQ4B5zMWNlEzERi4xVz4UpU05o9ItML4
	 Hbvg1eXUzyXRjWTOihuLAqFMBZ8avAbsQcfCHnuKGs3TQ0F/7FLbqldmqBfaRdg5njQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QCuwMB17;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FC2606A321;
	Wed, 25 Nov 2026 23:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68FC2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QCuwMB17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795649625; x=1827185625;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=pCVtF8v55FmaexWS2gyF6Vx3HQfifyvY5lhhfzgms4c=;
  b=QCuwMB17XM/COhqSiU3QLiaqeetPk+1rdpVNO1JNMstBMmymYMN8wkBo
   yDStQ3InSPPlcLi1yTD536Ndgis4UAvYEMShd5XN9mbWVOBx5m6Xbvp+k
   VLd4Ym+a9rlQuF8U8LcazgGt9NaXzrihWMaFLE8uLiylZuWjXcftOUKoh
   bsCid8rNzdrDTNL56L7NCDwALmy1NC90iHlsjw9/Slo7fBYY7kWf1cF54
   OglOYNRNkjYK5jfynFLhaXkanYbOOIq6gA2d83HIJu18MPqEI0AgFvtwK
   67ukGINMSN2AO6u8vFGrWrMMqjdx16aUNhNaj4msxStHWaH+LYLgbAHvc
   g==;
X-CSE-ConnectionGUID: kzo4O6iQT0a1pnvLaAvSrA==
X-CSE-MsgGUID: dINYwpi6TcGvlAfLC1/hQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4555518"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4555518"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:33:45 -0800
X-CSE-ConnectionGUID: sAWRZUW0RhOM423J0jnZyw==
X-CSE-MsgGUID: Qc2Duxs7RI+1Nhvs8BdKqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="13784609"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:33:41 -0800
Message-ID: <d9eb3700-ab16-4471-9814-00c62d4602c8@linux.intel.com>
Date: Thu, 26 Nov 2026 07:33:39 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 4/9] iommu/vt-d: Add interface for tdx-host when
 enabling trusted DMA
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Kiryl Shutsemau <kas@kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-5-baolu.lu@linux.intel.com>
 <CO1PR11MB4835EB7D858CC6C8A20F0E148C432@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <CO1PR11MB4835EB7D858CC6C8A20F0E148C432@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/2026 11:29 AM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, November 12, 2026 12:31 PM
>>
>> An Intel IOMMU that supports trusted DMA (ECAP.TDXCS) provides a second
>> set of DMA translation resources, managed by the TDX module and used
>> only for devices assigned to TDs. Before they can be used, the tdx-host
>> driver issues TDH.IOMMU.SETUP to put the IOMMU into Secure TDX Mode,
>> and
>> issues TDH.IOMMU.CLEAR to take it out again.
>>
>> The VT-d driver owns the hardware state these SEAMCALLs depend on, so
>> it checks that state and keeps its own use of the IOMMU out of the TDX
>> module's way. This is cooperation, not enforcement: the TDX module
>> protects trusted DMA regardless, and a misbehaving host can only cause
>> failures.
>>
>> Add a per-device interface so that an IOMMU is put into Secure TDX Mode
>> only when a device behind it needs trusted DMA. tdx-host tracks how many
>> devices use each IOMMU and calls into the VT-d driver only for the first
>> and the last of them:
>>
>> - dmar_tdxc_get_params() looks up the DMAR unit translating the device
>>    and returns its register base address, which is how the TDX module
>>    identifies an IOMMU, and its NUMA node, so that tdx-host can allocate
>>    the TDX module's metadata pages local to that IOMMU.
>>
>> - dmar_tdxc_acquire() is called right before TDH.IOMMU.SETUP. It checks
>>    the preconditions TDH.IOMMU.SETUP requires (DMA translation, queued
>>    invalidation and scalable mode enabled) and confines the host to the
>>    lower half of the domain ID space, since the TDX module owns the half
>>    with the MSB set.
>>
>> - dmar_tdxc_release() undoes acquire(). tdx-host calls it if
>>    TDH.IOMMU.SETUP fails, or after TDH.IOMMU.CLEAR succeeds for the last
>>    user. If TDH.IOMMU.CLEAR fails, tdx-host doesn't call it, so the upper
>>    half of the domain ID space stays reserved for the TDX module.
>>
>> DMAR units advertising ECAP.TDXCS are excluded from DMAR hotplug. No
>> platform currently supports both trusted DMA and DMAR hotplug, so that
>> flow can't be validated on hardware. Hot-removing such a unit is also
>> unsafe, because tdx-host may hold a reference to it and the TDX module
>> may own its trusted DMA resources. This also keeps the unit handle
>> returned by dmar_tdxc_get_params() valid for the lifetime of the system.
> 
> Here we used multiple terms (Intel IOMMU, VT-d, DMAR) to talk about
> a same thing. Intel IOMMU and VT-d are interchangeable, commonly used
> in many places. But DMAR is more a term in ACPI structure. Better avoid
> it in description, especially in exported interface names.

Intel IOMMU and VT-d refer to the hardware that the intel-iommu driver
drives. DMAR is the ACPI DMA remapping table, and the term is sometimes
used for the remapping hardware units it describes.

The interface here is not an intel-iommu driver interface, since those
should all go through the iommu core. It's exported from the ACPI/DMAR
layer instead, so dmar_tdx_* seems the more fitting name.

> 
>> @@ -689,6 +690,8 @@ struct intel_iommu {
>>   	u64		ecmdcap[DMA_MAX_NUM_ECMDCAP];
>>   	u32		gcmd; /* Holds TE, EAFL. Don't need SRTP, SFL, WBF
>> */
>>   	raw_spinlock_t	register_lock; /* protect register handling */
>> +	/* Acquired for the TDX module. Protected by register_lock. */
>> +	bool		tdxc_acquired;
> 
> "for the TDX module" or "for the TDX mode"?

The TDX mode. Will fix it.

> 
> s/tdxc_acquired/tdx_acquired/

Sure.

> 
>> @@ -47,9 +47,32 @@ struct dmar_drhd_unit {
>>   	u8	ignored:1; 		/* ignore drhd		*/
>>   	u8	include_all:1;
>>   	u8	gfx_dedicated:1;	/* graphic dedicated	*/
>> +	struct mutex tdxc_lock;		/* serializes acquire/release */
> 
> s/tdxc_lock/tdx_lock/

Sure.

> 
>>   	struct intel_iommu *iommu;
>>   };
>>
>> +/*
>> + * struct dmar_tdxc_params - IOMMU information for driving
>> TDH.IOMMU.*
>> + * @reg_base_addr: Register base address of the IOMMU. The TDX module
>> + *		   identifies an IOMMU by it.
>> + * @node: NUMA node of the IOMMU, for allocating the TDX module's
>> + *	  metadata pages local to it.
>> + * @drhd: VT-d internal handle; the caller must not dereference it. It
>> + *	  stays valid for the lifetime of the system because TDX
>> + *	  Connect-capable units are never hot-removed.
> 
> what will happen if the caller deferences it?

This will be dropped as discussed.

> 
>> @@ -2518,3 +2548,158 @@ bool dmar_platform_optin(void)
>>   	return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(dmar_platform_optin);
> 
> code starting here better fits in iommu.c?

See above.

> 
>> +
>> +static void dmar_tdxc_fill_params(struct dmar_drhd_unit *drhd,
>> +				  struct dmar_tdxc_params *params)
>> +{
>> +	params->reg_base_addr = drhd->reg_base_addr;
>> +	params->node = drhd->iommu->node;
>> +	/*
>> +	 * params->drhd stays valid because trusted DMA-capable units are
>> +	 * never hot-removed.
> 
> hmm now the 4th term for IOMMU...

This comment is gone as discussed.

> 
>> +/*
>> + * dmar_tdxc_acquire() - Acquire an IOMMU for TDH.IOMMU.SETUP
>> + * @dev: PCI device that will use trusted DMA
>> + * @params: Returned by dmar_tdxc_get_params() for @dev
>> + *
>> + * Call this right before issuing TDH.IOMMU.SETUP for the first user of
>> + * the IOMMU. On success, the caller must issue TDH.IOMMU.SETUP and
>> call
> 
> why defining the caller behavior here? what would happen if the caller
> just calls acquire()/release() w/o doing any SEAMCALL in between?

Nothing breaks. release() just undoes what acquire() did. You're right
that the interface shouldn't define the caller's behavior.

> 
>> + * dmar_tdxc_release() if it fails. The caller owns the per-IOMMU refcount
>> + * and must serialize all calls for the same IOMMU.
> 
> this function already serializes internally. What is the rationale asking for
> extra serialization in the caller?

None, it isn't needed. I'll describe what acquire() and release() do to
the IOMMU, and drop the requirements on the caller.

> 
>> + *
>> + * Return: 0 on success and error code on failure.
>> + */
>> +int dmar_tdxc_acquire(struct pci_dev *pdev,
>> +		      const struct dmar_tdxc_params *params)
>> +{
>> +	struct dmar_drhd_unit *drhd = params->drhd;
>> +	struct intel_iommu *iommu = drhd->iommu;
>> +	int ret;
>> +
>> +	if (WARN_ON(dmar_tdxc_find_drhd(pdev) != drhd))
>> +		return -EINVAL;
>> +
>> +	guard(mutex)(&drhd->tdxc_lock);
>> +	/* Still set if TDH.IOMMU.CLEAR failed and tdx-host was reloaded. */
>> +	if (iommu->tdxc_acquired)
>> +		return -EBUSY;
> 
> what does "tdx-host was reloaded" actually mean?

It's stale. After a failed TDH.IOMMU.CLEAR, the flag stays set and the
next acquire() fails, whether or not tdx-host is reloaded. I'll reword
it to:

	/* Still set if a previous TDH.IOMMU.CLEAR failed. */

> 
>> +
>> +	/*
>> +	 * TDH.IOMMU.SETUP requires DMA translation, queued invalidation
>> and
>> +	 * scalable mode to be enabled. Catch these here so the error is
> 
> Remove the 1st sentence as it is explained by the code.

Will do.

>> +	 * -EINVAL rather than an opaque TDX_IOMMU_INVALID_STATE.
>> +	 */
>> +	if (!(iommu->gcmd & DMA_GCMD_TE) || !iommu->qi
>> || !sm_supported(iommu))
>> +		return -EINVAL;
>> +

Thanks,
baolu
