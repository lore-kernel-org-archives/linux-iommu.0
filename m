Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F346E614
	for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 08:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304828; cv=none; b=M3xU7vv1DMhULaNK/OIPmaVnnigtWuIiLXvlqMu5apfdujmbUKtwzgo6Ka/4bV0+AJg+ZR7bR5OhA6CiwSkK8DvXexbuHBdrnt1TRx1Fw92AT1C88Ea73dCm9+IBr2dcnIwEDogei3XU2/kQZb77TvZn64HcbxRAhTs7vuMm18k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304828; c=relaxed/simple;
	bh=H0GBfM58+YQiml4VxIdC28FHy6s9KdUDhokOUjeIMWQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=udSmNF6swADmtDzN1UdJGSUoqXFNZwHjRX2hXAsIbtsu/rvDAiZzcC4d6wRypzq1w2wWTzFaLHJzf+otBAu9bXjiWZ2dT2saUQaq090uRsQACtFwVbi6myUGQyc9xmcA+lEEovGY64mANywxmlyEWSFWnEqHlShjE5Fb6yTRz8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eGBtcii0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eGBtcii0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719304826; x=1750840826;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H0GBfM58+YQiml4VxIdC28FHy6s9KdUDhokOUjeIMWQ=;
  b=eGBtcii0SvM2fjLOuQ9sTEjgGeEj4f8osvSrxCqDYW1u3F49N6jL4eLM
   U2yKFBFT7JbKvofWtGmnpNQrDohdpMq8NJy2bRpSY/K5B0m2866TMFVfe
   u21spkVoxlE4trK37PdbEA9TjHWgVsUQyHbNvP7ZdTfz5muTvLwC21crV
   gK9yTx8YOCpqwkPEmhebw7lW3MRH0DcHY1cuhXNmelq9TvQxJY/ZTwlN3
   OTJat5hXxhsNSYXwOE/A6QfmqEdq0nr1qQzxkIac5HG2Egzz9MR3p4xdS
   y+ny3EzKkvC6+muhVMn34pSDgcdlf6YGJnECQ8vL3fxrYqOctSHSyS4Ac
   g==;
X-CSE-ConnectionGUID: ZlDS86TpQx6TOseX0PKuJQ==
X-CSE-MsgGUID: eUq0Li69S4GuCOMmGV4+Mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16063710"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="16063710"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:40:26 -0700
X-CSE-ConnectionGUID: HMnY4KrCSBSem8ysH9srPQ==
X-CSE-MsgGUID: 3sBzE1SYQE2YHQf+Dc9XHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="74339718"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.100]) ([10.124.237.100])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:40:24 -0700
Message-ID: <55d50738-cbb6-4bf5-8748-1b1c8c2de21e@linux.intel.com>
Date: Tue, 25 Jun 2024 16:40:21 +0800
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
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276C8112DEF56C11CFC6F198CD52@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/25 10:32, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Monday, June 24, 2024 1:25 PM
>>
>> If a device is listed in the SATC table with ATC_REQUIRED flag set, it
>> indicates that the device has a functional requirement to enable its ATC
>> (via the ATS capability) for device operation. However, when IOMMU is
>> running in the legacy mode, ATS could be automatically supported by the
>> hardware so that the OS has no need to support the ATS functionality.
> hmm I don't think "has no need to support" matches...
> 
>> This is a backward compatibility feature which enables older OSs. Since
>> Linux VT-d implementation has already supported ATS features for a long
>> time, there is no need to rely on this compatibility hardware. Remove it
>> to make the driver future-proof.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 9 +--------
>>   1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 07e394dfccc1..b63347c8bf5d 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -3056,14 +3056,7 @@ static bool dmar_ats_supported(struct pci_dev
>> *dev, struct intel_iommu *iommu)
>>   	dev = pci_physfn(dev);
>>   	satcu = dmar_find_matched_satc_unit(dev);
>>   	if (satcu)
>> -		/*
>> -		 * This device supports ATS as it is in SATC table.
>> -		 * When IOMMU is in legacy mode, enabling ATS is done
>> -		 * automatically by HW for the device that requires
>> -		 * ATS, hence OS should not enable this device ATS
>> -		 * to avoid duplicated TLB invalidation.
>> -		 */
> ...what above comment tries to convey.
> 
> If this comment is valid, it's not about whether the OS itself supports
> ATS. instead it's a requirement for the OS to not manage ATS when
> it's already managed by HW.
> 
> Unless there is a way to disable hw management with this change...

This comment is not correct. The hardware automatic ATS is for older OS
compatible purposes, where the ATS is not aware of by the OS yet, but
ATS is functionally required for some SOC-integrated accelerators.

The HAS specification for those platforms states that OSs supporting ATS
(so-called enlightened OSs) don't require automatic ATS anymore.

 From the iommu driver's point of view, automatic ATS is not part of the
VT-d spec and also not enumerable, hence it should be transparent.

Best regards,
baolu
