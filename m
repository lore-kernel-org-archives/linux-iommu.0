Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E53542ABE
	for <iommu@lists.linux.dev>; Mon,  6 May 2024 07:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714981351; cv=none; b=aUbnjCOAXS2R26/RaP9YeORXkb0r5nQ3WgEAn5OjVGtP/Y4bGyITNDk3G+p8CTKrLHLf896MXIsoY5ij/2zmSstdkcab0XxX/m0R8cmAMbfumf4X8UIsSXMZHyvXH3Nod5wC+X7vSxU2lwd6yjQBk3vyb/a+DrhjKf6JY1lTjCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714981351; c=relaxed/simple;
	bh=iHKO1qzhns2fF3u7KQYzVcb8QhFm4i6HTrDF0c5MQPk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=njBd0vTQZxv5hl36bSF2ULwO3r860pO9EyAO3cgEGCfZ3ePkaaSLAPfBXmgQjrhDJkShS98rxasaz08dcwHmNocDOBMx/yKc7dZ4r0ECUBzv5VMIuw/mKKqVtKNoMszrXR8FTl7VIOrfVbZx7/kaqAooWeapeRbHxLioodfv9Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=atd8AKYI; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="atd8AKYI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714981349; x=1746517349;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iHKO1qzhns2fF3u7KQYzVcb8QhFm4i6HTrDF0c5MQPk=;
  b=atd8AKYImLcIDSMEPdDlhmhc/o6Ynt/eanj/RSNjZP+HbvEbAJlQ2+KQ
   H6soWEaBczKlFKH6VLbWJ1R+WIm7piyprLXMjl8WeoeQVlbipnn00TVjQ
   pho7jLutB2u4aMGrLTDXPFNS3n0qIORge/z23hjbBdn/MlA2tc2E0Bfhv
   yOnqfMWtmgVCxneHtdDPMBFAjY28lUfsZhXOEivEdsl9CZRJawaAv4S4p
   tV5sE7swUiFpBlmjelRofjzZvXNy6p0pXXIpSDaj6HRznVQpSmYqnRbYU
   KPM3GfGAKgVQTIiQCL2vxpJOOyrxA0x3Atd5j9LmJmxT55byXQL7hK77L
   w==;
X-CSE-ConnectionGUID: Fw/sTMRHQv+E8b1n16nmyA==
X-CSE-MsgGUID: L/WRWaXKRn6sVZ1jArA7yA==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="11249418"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="11249418"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:42:27 -0700
X-CSE-ConnectionGUID: pPqXQTQxT0iQdRXrEE8LaQ==
X-CSE-MsgGUID: FU75hEBKQSKFvFqwFPit3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="32889587"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.244.72]) ([10.125.244.72])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:42:24 -0700
Message-ID: <b4fe7b7c-d988-4c71-a34c-6e3806327b27@linux.intel.com>
Date: Mon, 6 May 2024 15:42:21 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "Pan, Jacob jun" <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v2 12/12] iommu/vt-d: Add set_dev_pasid callback for
 nested domain
To: Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>
References: <20240412081516.31168-1-yi.l.liu@intel.com>
 <20240412081516.31168-13-yi.l.liu@intel.com>
 <BN9PR11MB5276E97AECE1A58D9714B0C38C0F2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d466eb97-8c2b-4262-8213-b6a9987f59ea@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <d466eb97-8c2b-4262-8213-b6a9987f59ea@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/4/30 17:19, Yi Liu wrote:
> On 2024/4/17 17:25, Tian, Kevin wrote:
>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>> Sent: Friday, April 12, 2024 4:15 PM
>>>
>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>
>>> This allows the upper layers to set a nested type domain to a PASID of a
>>> device if the PASID feature is supported by the IOMMU hardware.
>>>
>>> The set_dev_pasid callback for non-nested domain has already be 
>>> there, so
>>> this only needs to add it for nested domains. Note that the S2 domain 
>>> with
>>> dirty tracking capability is not supported yet as no user for now.
>>
>> S2 domain does support dirty tracking. Do you mean the specific
>> check in intel_iommu_set_dev_pasid() i.e. pasid-granular dirty
>> tracking is not supported yet?
> 
> yes. We may remove this check when real usage comes. e.g. SIOV.
> 
>>> +static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
>>> +                      struct device *dev, ioasid_t pasid,
>>> +                      struct iommu_domain *old)
>>> +{
>>> +    struct device_domain_info *info = dev_iommu_priv_get(dev);
>>> +    struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>>> +    struct intel_iommu *iommu = info->iommu;
>>> +
>>> +    if (iommu->agaw < dmar_domain->s2_domain->agaw)
>>> +        return -EINVAL;
>>> +
>>
>> this check is covered by prepare_domain_attach_device() already.
> 
> This was added to avoid modifying the s2_domain's agaw. I'm fine to remove
> it personally as the existing attach path also needs to update domain's
> agaw per device attachment. @Baolu, how about your opinion?

We still need something to do before we can safely remove this check.
All the domain allocation interfaces should eventually have the device
pointer as the input, and all domain attributions could be initialized
during domain allocation. In the attach paths, it should return -EINVAL
directly if the domain is not compatible with the iommu for the device.

Best regards,
baolu
