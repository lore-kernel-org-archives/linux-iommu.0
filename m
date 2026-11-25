Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795580865;
	b=Hta7KKxtCVw3llaqpDz4J7oZxDgTHvgt22uXOPZKO1owCnVwfBgs8CPt/DUmOC8BQHOZ
	 ddJOmO/GbR++cslBYuPw8/1tHV71D5OTv6gtEqD6pL12NaHIFTrWToNg1a15S4Sk0qIVF
	 w0KFc/nBDEo+60Pt3YV56bt2hUcuNRhQoijiFxpjno+NReTBWNUO38Emw3KA4LJ6l5xIl
	 ubg1l4JBBHx4FaCYMD6225mEn+k2kifXV5lvbd5Lt/6vxn90eZ6cxA15bBRxWBzembnYg
	 3UE9cJ7bhpTEQ9BUtJPkRHIszzi5EEQ88n36XoPZ+Y6lnSyVVQSqS2ZZYuWV3LY9DRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795580865;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=nVpT+yraa1yVDO8OUEHZEK0jQepG0L6bEBsfuNb+iGI=;
	b=rwoCakNNh2HqFQW+T/kn5VJ9ZUm6bQrSmoahlbuwCwu9qoM98eVNWR4TlAeeIWHq8pk3
	 UbzsXAXJe4aeYAUW3p1cbi3tlJoqQMhhuQFwqq5p7e6eI+87JQPGw/6MleYGj5gax+asm
	 DuC26rNfk7Yy2q65iEpX2qnm8JeWRTh1JdGUJxoI2jA6TAtzM0RSp6eEBRNODsYhtGpGS
	 E4X6uN2u0x8O3JEUqKebgFXE4ThVqdGpljAWD4nEEtH0vB/1D2QI2mDo7D2Mg04RtpF3o
	 OEmteYYFodjFb7+7pBZlzdFQc0shLYidt8AWuL11raS7qkUQ92Ofd0wv17Uy7aYUFBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=max3s595;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FC5606A321;
	Wed, 25 Nov 2026 04:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56FC5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=max3s595
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795580865; x=1827116865;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S0QOwBRZ6Kla96s+DysG5kGhzedqDXrOzukPb4PwcwQ=;
  b=max3s595MZiT93/eoaSvwXmLN+AmvzHMI3gwJceROHc0GK32jOalxpiH
   drrFz2JaeJ7RMmTjNtXZ2f38t2RKegQDrAp9f4wabbmLuWAJagTOEbeD7
   eEgh7WJuRQE74GkxZWRCPwDJsp6IAlB2JahrUCU3NhzS12Q9c1PeeyFIY
   PJQ3FmGGEQ8bHzdo08dnAWcnlUVzqdp09lxv5i0sSDeK69o0fBBx6knmc
   k7EZVfowY3cvcwt68wVpich4swUMTKB2dqHAfUruO9JgcDOVnl82xZxM7
   Y4o1vAKIEI/vgSsJ96vDOgTStD3pZsGhl9zy1FEacobRIB4ahWDOSnl0g
   Q==;
X-CSE-ConnectionGUID: OJ27f151QvWFG9idXiCAPg==
X-CSE-MsgGUID: JFHXwhoISLaMAMZWr6fwgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4344764"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4344764"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 20:27:22 -0800
X-CSE-ConnectionGUID: 6cAE2U3XQ5KA5qmCb5h2Nw==
X-CSE-MsgGUID: eXgbEvJRSz+i35YH+AbkCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11747849"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 20:27:02 -0800
Message-ID: <9da20e39-4168-433f-a48e-857c1196bebe@linux.intel.com>
Date: Wed, 25 Nov 2026 12:26:59 +0800
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
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Kiryl Shutsemau <kas@kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/9] x86/virt/tdx: Add SEAMCALL wrappers for IOMMU
 setup/clear
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-2-baolu.lu@linux.intel.com>
 <CO1PR11MB4835FD5EB44EB94467A82E5F8C442@CO1PR11MB4835.namprd11.prod.outlook.com>
 <8ef35412-44a1-4fca-8ba2-06bbad367b22@linux.intel.com>
 <CO1PR11MB4835DE6974C89C303A8C2B658C432@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CO1PR11MB4835DE6974C89C303A8C2B658C432@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/2026 11:08 AM, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Wednesday, November 25, 2026 10:47 AM
>>
>> On 11/24/2026 4:07 PM, Tian, Kevin wrote:
>>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>> Sent: Thursday, November 12, 2026 12:31 PM
>>>>
>>>> Intel VT-d hardware gains a second set of DMA translation structures,
>>>> managed by the TDX module and used only for devices assigned to TDs.
>>>> Each IOMMU has a trusted root-table address register and a trusted
>>>> invalidation queue, both accessible only from SEAM. The existing
>>>> untrusted DMA translation path of the IOMMU stays under host control.
>>>>
>>>> Before trusted DMA can be used through an IOMMU, the TDX module
>> must
>>>> initialize these resources. TDH.IOMMU.SETUP does this: it puts the
>>>> IOMMU into Secure TDX Mode, programs the trusted root table and the
>>> s/Secure TDX Mode/TDX mode/, across the series
>> Secure TDX Mode is the term used in TDX Connect ABI specification.
>>
> Can you double confirm it? I can see two "Secure TDX Mode"s and one
> "TDX Mode" in the public spec. so it's inconsistent.
> 
> Then from the internal ABI spec, still two "Secure TDX Mode"s but a lot
> of more "TDX mode"s...

You're right, the spec isn't consistent, and "TDX mode" is clear enough.
I'll use "TDX mode" across the series.

Thanks,
baolu
