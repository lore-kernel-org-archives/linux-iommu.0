Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517D728DDA
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 02:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713926789; cv=none; b=u6OUAizF61XiJRcQxCtZZNMuEC0FyDQ/GUjyyKcnAmR4s+4/3/T14n67dNtKPBNe1nujVvZDD2CuBVonDZgJA7XaBBYUITPTM2eX0sRT3wMegKurKosPqGCoL2S2FeI27WTKZoDUB8dz2v1UOTvpRpB5HcN8KaHFTXGShEFvdJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713926789; c=relaxed/simple;
	bh=MiyHAf01++BUbs/aPGIknIWZ43yNcPC8sNtReIepA/s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SKIkFFtK88Yv3oeq5J76MUmpvPh5YSs9t4z5sJcMaMAgqTNU4K/HVG+aTj3o1Z472vS+IBK5wLH3CLWtHMfeJK99qt6SDMzn8Ti4j8F01SIJ8yGqbcZQgOhiYtMS+zN2nHkPL7EhXcSFN/OS4vxpRuH6i4UL9cBy+JjEA2sMCvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EWDVtBSk; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EWDVtBSk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713926788; x=1745462788;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MiyHAf01++BUbs/aPGIknIWZ43yNcPC8sNtReIepA/s=;
  b=EWDVtBSkOw5otLpppuQxGuROE8BOzqCDWHp0dqaNb1lmjsIE6UFc3d3V
   KKyODdZHkBROpYHe3Mq0RNDRFSP4i/shAvsI3VMcjWrvVeD7MpwzbcpZD
   Je3iguoNgMA8DhfmKVrAa5IzfPeKr64NBRJWNPIN3Fzcid3XYPoLTqEfi
   P5fVxrUpsCrh7AfD1PrkxoWT5GqOJp6/Tp4kO+noWJmoQ5Bhe5kMSkv+6
   jXlcXx0Zcus0xiO/Sh5lBHrxOS/8dfXk0jEslhehOPpXTWH+st2pb6uix
   LaEqw4k8zNZl9AR6PEHJrzNjCWQm/6KDWJ2Qc88woLUkOj7ZU+cxFws3u
   A==;
X-CSE-ConnectionGUID: 76k3v/3gTtmhCnZo30+Y6w==
X-CSE-MsgGUID: P74yqvW7SLizdT3FAvKX6A==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="12473036"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="12473036"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 19:46:03 -0700
X-CSE-ConnectionGUID: YAkqvKlzSJKFctxgTNGymg==
X-CSE-MsgGUID: xcsF7COYTyCRv1Cu3acPyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24449651"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 23 Apr 2024 19:46:00 -0700
Message-ID: <05d0d9bf-2a33-487f-bbf2-5d7780cbabb9@linux.intel.com>
Date: Wed, 24 Apr 2024 10:44:37 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Zhang, Tina" <tina.zhang@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 01/12] iommu/vt-d: Add cache tag assignment interface
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20240416080656.60968-1-baolu.lu@linux.intel.com>
 <20240416080656.60968-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276A1920E24BE91CF1FD2098C112@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276A1920E24BE91CF1FD2098C112@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/24 5:01 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, April 16, 2024 4:07 PM
>>
>> @@ -1757,6 +1759,9 @@ int domain_attach_iommu(struct dmar_domain
>> *domain, struct intel_iommu *iommu)
>>   	unsigned long ndomains;
>>   	int num, ret = -ENOSPC;
>>
>> +	if (domain->domain.type == IOMMU_DOMAIN_SVA)
>> +		return 0;
>> +
>>   	info = kzalloc(sizeof(*info), GFP_KERNEL);
>>   	if (!info)
>>   		return -ENOMEM;
>> @@ -1804,6 +1809,9 @@ void domain_detach_iommu(struct dmar_domain
>> *domain, struct intel_iommu *iommu)
>>   {
>>   	struct iommu_domain_info *info;
>>
>> +	if (domain->domain.type == IOMMU_DOMAIN_SVA)
>> +		return;
>> +
>>   	spin_lock(&iommu->lock);
>>   	info = xa_load(&domain->iommu_array, iommu->seq_id);
>>   	if (--info->refcnt == 0) {
> 
> above two are not called for SVA. Why do they start checking
> SVA type now?

domain_detach_iommu() is called in remove_dev_pasid path which covers
SVA domain as well.

I am moving the check to the domain_attach/detach_iommu() helpers so
that the call sites could be generic. I will later move the domain ID
management to the cache tag code, this kind of check will be dropped
then.

Best regards,
baolu
