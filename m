Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905A721A0B
	for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 02:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719369604; cv=none; b=GoRLAIrmhyQWoipdZ5hHKtm6dWmI6B38mwA2vFreOzZ7fR3glbD422c97roSobLTm5OT7r97Pli3T5LuGb5UOdNmzaBLcDTvNpyOdROn8b+78Y7Dsbxuzg0ZIoDedphCy8Ngk3dLQLGwSXcn00p/wri0CMz/5IzVtxR4BZKMfzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719369604; c=relaxed/simple;
	bh=QcE34O/pgjeaSLIBmO+f57+dDp4VVt67Nf6+waGdvEE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rzfXLNIkvKeCVH+eSwQzwVyFGbfpufV8+ytjwk2PxGWk1RVfAN8PaP6szVazhRhm4BOftCHDVtzq+CND5tDe8r6DOfOABPEdz2qiMGXLdY0EcZ0C32TEJg0Jx/VL1XrHg9NRFEYclxNrWcEqycISJI2xx3i29nLWlTb7hnxOSlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MvhaJGrv; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MvhaJGrv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719369603; x=1750905603;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QcE34O/pgjeaSLIBmO+f57+dDp4VVt67Nf6+waGdvEE=;
  b=MvhaJGrvq3r62M8p9pz4z0MW2gRK2yu1uz72y43UeA68hfFC5lgNPfnf
   ZMPSGDcX1CB/lz0/G5ratFnQ+6ZH8xfR10vJa4ufDQAmcyDM33z8swIbx
   7dY2AFyNXEXXaNefwX2Z3SdgJup5qFW5GKULCaNcTL+9FFPt+mmcQ6kG1
   nNE90gqGJ8g3ntVowcAyOJg+W5IO2dudQNDEOo9yGUcz9f0Axl3XPjNMf
   bRlAHglubD0nUblggSnz1Wz1Ecfl7lE5CTqbamtHj4ybsQ6sU/cU7WS/o
   G6TKtfvKhdQQ8FT9I7oECzTyaqTvyCeH1PSvy4BPZyVO+VBI6ko3OD0DD
   A==;
X-CSE-ConnectionGUID: OnwqdLW+S3CPBsgbSbSv/w==
X-CSE-MsgGUID: aUDVbXnxTYGsbrX2A/VThA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="27563253"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="27563253"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 19:40:02 -0700
X-CSE-ConnectionGUID: BG7+n+w2RwKjX95fNAyueA==
X-CSE-MsgGUID: abH/pdleSDyD0UrMzuCfzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="48770527"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 25 Jun 2024 19:39:59 -0700
Message-ID: <7e1a5185-18c8-470f-9621-b4ddd37c44c1@linux.intel.com>
Date: Wed, 26 Jun 2024 10:37:26 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iommu/vt-d: Remove hardware automatic ATS dependency
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 "Liu, Yi L" <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20240624052501.253405-1-baolu.lu@linux.intel.com>
 <20240624052501.253405-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276C8112DEF56C11CFC6F198CD52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <55d50738-cbb6-4bf5-8748-1b1c8c2de21e@linux.intel.com>
 <BN9PR11MB52769480729491394F4719728CD62@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52769480729491394F4719728CD62@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/24 9:53 AM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 25, 2024 4:40 PM
>>
>> On 2024/6/25 10:32, Tian, Kevin wrote:
>>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>> Sent: Monday, June 24, 2024 1:25 PM
>>>>
>>>> If a device is listed in the SATC table with ATC_REQUIRED flag set, it
>>>> indicates that the device has a functional requirement to enable its ATC
>>>> (via the ATS capability) for device operation. However, when IOMMU is
>>>> running in the legacy mode, ATS could be automatically supported by the
>>>> hardware so that the OS has no need to support the ATS functionality.
>>> hmm I don't think "has no need to support" matches...
>>>
>>>> This is a backward compatibility feature which enables older OSs. Since
>>>> Linux VT-d implementation has already supported ATS features for a long
>>>> time, there is no need to rely on this compatibility hardware. Remove it
>>>> to make the driver future-proof.
>>>>
>>>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>>>> ---
>>>>    drivers/iommu/intel/iommu.c | 9 +--------
>>>>    1 file changed, 1 insertion(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>>> index 07e394dfccc1..b63347c8bf5d 100644
>>>> --- a/drivers/iommu/intel/iommu.c
>>>> +++ b/drivers/iommu/intel/iommu.c
>>>> @@ -3056,14 +3056,7 @@ static bool dmar_ats_supported(struct pci_dev
>>>> *dev, struct intel_iommu *iommu)
>>>>    	dev = pci_physfn(dev);
>>>>    	satcu = dmar_find_matched_satc_unit(dev);
>>>>    	if (satcu)
>>>> -		/*
>>>> -		 * This device supports ATS as it is in SATC table.
>>>> -		 * When IOMMU is in legacy mode, enabling ATS is done
>>>> -		 * automatically by HW for the device that requires
>>>> -		 * ATS, hence OS should not enable this device ATS
>>>> -		 * to avoid duplicated TLB invalidation.
>>>> -		 */
>>> ...what above comment tries to convey.
>>>
>>> If this comment is valid, it's not about whether the OS itself supports
>>> ATS. instead it's a requirement for the OS to not manage ATS when
>>> it's already managed by HW.
>>>
>>> Unless there is a way to disable hw management with this change...
>>
>> This comment is not correct. The hardware automatic ATS is for older OS
>> compatible purposes, where the ATS is not aware of by the OS yet, but
>> ATS is functionally required for some SOC-integrated accelerators.
>>
>> The HAS specification for those platforms states that OSs supporting ATS
>> (so-called enlightened OSs) don't require automatic ATS anymore.
>>
>>   From the iommu driver's point of view, automatic ATS is not part of the
>> VT-d spec and also not enumerable, hence it should be transparent.
>>
> 
> I'm curious how automatic ATS can be disabled otherwise the old
> comment still makes sense as you will have both HW and SW
> managing ATS and then duplicated invalidations.
> 
> Is there a BIOS option to disable automatic ATS? Then the user will
> need to know which kernel version supports ATS to decide.
> 
> Or is it automatically enabled/disabled based on whether the
> IOMMU is in legacy or scalable mode? If yes then we may still want
> to disable SW-managed ATS when the IOMMU is in legacy mode to
> avoid duplicated invalidations.
> 
> btw ATS support was introduced long long time ago:
> 
> commit 93a23a7271dfb811b3adb72779054c3a24433112
> Author: Yu Zhao <yu.zhao@intel.com>
> Date:   Mon May 18 13:51:37 2009 +0800
> 
>      VT-d: support the device IOTLB
> 
>      Enable the device IOTLB (i.e. ATS) for both the bare metal and KVM
>      environments.
> 
>      Signed-off-by: Yu Zhao <yu.zhao@intel.com>
>      Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
> 
> while this hw-managed ATS was supported much later:
> 
> commit 97f2f2c5317f55ae3440733a090a96a251da222b
> Author: Yian Chen <yian.chen@intel.com>
> Date:   Tue Mar 1 10:01:59 2022 +0800
> 
>      iommu/vt-d: Enable ATS for the devices in SATC table
> 
>      Starting from Intel VT-d v3.2, Intel platform BIOS can provide additional
>      SATC table structure. SATC table includes a list of SoC integrated devices
>      that support ATC (Address translation cache).
> 
>      Enabling ATC (via ATS capability) can be a functional requirement for SATC
>      device operation or optional to enhance device performance/functionality.
>      This is determined by the bit of ATC_REQUIRED in SATC table. When IOMMU is
>      working in scalable mode, software chooses to always enable ATS for every
>      device in SATC table because Intel SoC devices in SATC table are trusted to
>      use ATS.
> 
>      On the other hand, if IOMMU is in legacy mode, ATS of SATC capable devices
>      can work transparently to software and be automatically enabled by IOMMU
>      hardware. As the result, there is no need for software to enable ATS on
>      these devices.
> 
>      This also removes dmar_find_matched_atsr_unit() helper as it becomes dead
>      code now.
> 
>      Signed-off-by: Yian Chen <yian.chen@intel.com>
>      Link: https://lore.kernel.org/r/20220222185416.1722611-1-yian.chen@intel.com
>      Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>      Link: https://lore.kernel.org/r/20220301020159.633356-13-baolu.lu@linux.inte
>      Signed-off-by: Joerg Roedel <jroedel@suse.de>
> 
> That history doesn't appear to support your argument that it's only
> for old OS which is not aware of ATS...

Software has no means to disable automatic ATS. Therefore it's not
expected to turn on the ATS in the device while the iommu is in legacy
mode. I will drop this change.

Best regards,
baolu
