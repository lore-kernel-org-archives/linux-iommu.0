Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736F939FD4
	for <iommu@lists.linux.dev>; Sun, 21 Jun 2026 01:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782006322; cv=none; b=AKBRV/RSwc6rFK21E/cqgnA1WA/9slndmF75YJUlAkdRI+G+U1rAu8M3PkRoJtopvhTvZcHYuCTEbXGCU82xCTPI4DBCSCfcp16DSTnOEWjqjix76Q78ds9Ir+YLEDVPjgVs5wtn6WznuHszuLy5Lyl4G0oS2gxd4qd/iIAgQrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782006322; c=relaxed/simple;
	bh=wFFPGQPFFc2CzHb+9qIg8mL5l5HTJFbfxlhkboSXUcw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PBRxW8wkS50PtZCF3a9Frblu5U3QfZLZTF6agwJVlWc6yCW2umhHcM6sY9kLhOcsj5doAHIEPOzNbuH/sVQ9JaxDP1yaHLCRRTfeSnoxFVE5uXdZY1hga3m00M8K4svgwW9JYRwGlrA2ueCJNp2jU5fYVeq8qap7ha13wOjHfYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jYLAoBJK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jYLAoBJK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782006321; x=1813542321;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wFFPGQPFFc2CzHb+9qIg8mL5l5HTJFbfxlhkboSXUcw=;
  b=jYLAoBJKYOiP9btfuEO1CVF4VAeZEw0oXTClHV+C5L3piU6Ou3OZDWS3
   l6vxFslnYHii7j+cSrd1pmQ0MT/DWsSJtchv1U1quztFHtf1aaPmtEqIe
   ee7KslAlBkSKg28lU/hUzq7m80XsVRD08BcwOiXM63Ea/W+3eqQRCXmg1
   L1Gx38qC+jaYhj9HjALO33CX0qZ6AUZH5B4O7nKHnt0aCmwrz43rQgPU7
   A33BAOUcaFXq0LMDxmQZCHpyd6AAUDapcUtxEQscor49onWVXZ/CVy1by
   +SdS99S2nwqdbjvRcbAkazb3py7NkIdJMesxfqfMjeDl7GGfaZOtt7zlH
   Q==;
X-CSE-ConnectionGUID: IhxtjYtGScCgN9YgPQawYQ==
X-CSE-MsgGUID: 8uuKE+DKRZmNjDiMBrp9RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11823"; a="86628485"
X-IronPort-AV: E=Sophos;i="6.24,216,1774335600"; 
   d="scan'208";a="86628485"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2026 18:45:20 -0700
X-CSE-ConnectionGUID: 8+eWHNFtRhKA271Ld1Qmow==
X-CSE-MsgGUID: GiMBpXgCR4643MzbFdCpVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,216,1774335600"; 
   d="scan'208";a="250830858"
Received: from unknown (HELO [10.238.9.114]) ([10.238.9.114])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2026 18:45:17 -0700
Message-ID: <dcab2d86-30e5-4d29-9640-bd56c6fc9cea@linux.intel.com>
Date: Sun, 21 Jun 2026 09:45:14 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <jroedel@suse.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Chris Wright <chrisw@sous-sol.org>,
 Jesse Barnes <jbarnes@virtuousgeek.org>,
 "Mallick, Asit K" <asit.k.mallick@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/9] iommu/vt-d: Consolidate dmar state management and
 force_on logic
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20260604051540.592925-1-kevin.tian@intel.com>
 <20260604051540.592925-5-kevin.tian@intel.com>
 <c6ddabae-09ee-4101-94ca-d077514bae5a@linux.intel.com>
 <DM6PR11MB3690A320BEB82740F86424A18CE42@DM6PR11MB3690.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <DM6PR11MB3690A320BEB82740F86424A18CE42@DM6PR11MB3690.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/2026 3:14 PM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Monday, June 15, 2026 1:01 PM
>>
>> On 6/4/26 13:15, Kevin Tian wrote:
>>> +
>>> +static inline bool dmar_is_enabled(void)
>>> +{
>>> +	return dmar_state > 0;
>>> +}
>>> +
>>> +static inline bool dmar_is_disabled(void)
>>> +{
>>> +	return dmar_state < 0;
>>> +}
>>
>> The helpers above seem to conflict with:
>>
>> 	extern int intel_iommu_enabled;
>>
>> Can we possibly make the interface consistent?
>>
> 
> Can you elaborate the 'conflict' part?
> 
> If dmar_state<0, intel_iommu_enabled will be 0 as no initialization
> will happen.
> 
> if dmar_state>0, intel_iommu_enabled may be 0 or 1 upon whether
> initialization succeeds.
> 
> they server different purposes.
> 
> or did you mean that the name dmar_is_enabled() may cause
> confusion with intel_iommu_enabled?

Yes, that is exactly my concern. dmar_is_enabled() might be misused as a
replacement for intel_iommu_enabled.

> 
> I could rename it to dmar_should_enable() and dmar_should_disable()
> to differentiate.

That's better. How about dmar_requested()?

/*
  * Track whether the system wants to use the IOMMU based on a
  * combination of command-line overrides, firmware hint, platform trust
  * or secure requirements, etc.
  */
static inline bool dmar_requested(void)
{
	return dmar_state > 0;
}

Thanks,
baolu
