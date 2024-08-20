Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A014E4DA14
	for <iommu@lists.linux.dev>; Tue, 20 Aug 2024 04:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724127033; cv=none; b=p+nwX6s6kFbqu6dAbcyHWU7Uw128W/7wlJj3EoXhZfeVyjNGx4jDPSMoRSHPl2ALPwEOAFY5RiMp3YU/y3pTt3y6imTN7Q03RDwmSWVC4Ok4gnBHUNgjRLgpxxHQs2Lt07UZrBOatLPc7A/zKvymiE6Hl/7Dlb04MK8GVrTw14c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724127033; c=relaxed/simple;
	bh=QgBhNuA+/yVA9gSejlEjFSLZYb0KO+WdfemUy1Z5vD0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=q5A197witWF+Q1Ybcl+EETmc0c/NMMAsXLbzE6w8C6USOSRqlhyMbdU+Rn+spNzQ7hsSynVAoN3jG2AmJpCN0NAgnISxxE1CMmjdvQ9680bUrKf/Ox7GfyQLGI3ylqliJLlU3dwHMXJcggdJ6LGcZxZ9FPnf2FE3g0/5S58VZTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tvh/uBq9; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tvh/uBq9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724127032; x=1755663032;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QgBhNuA+/yVA9gSejlEjFSLZYb0KO+WdfemUy1Z5vD0=;
  b=Tvh/uBq9j1eI5XWTTAieOgjbs6e3Tn666a7+XU4vo5cPTCWSowBjeFND
   C1Mr3dSUejaJFGAi4c3p9RULAN2MqYKxOaAz1cZoFfty/A2nZFqbRIooi
   UN11UqcZ9svIEfd1MZeq2aqrV4CqmS/mRSN3PmdBBYb6wznqEzDhV/fpB
   Ui6IMJRWRtQBj0xY0FTK8rIpjxfR//1By04XRgeoaQ/BBzIZQj1vuT7MK
   6YQuNh96aqpsfSlXyaHEGlJ2nSgKOm7kYXPgZey75VEAadiz1TByj8YCU
   7+Nm7cI3vxgDmVdfF7rIM5rTm6KxuBk77uafxb1y1My0HFnVYmnb4tj2X
   g==;
X-CSE-ConnectionGUID: JeYbhaqySvicSFmqquaC3g==
X-CSE-MsgGUID: Gvk7SJL7SG2cptRrIDaoDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33788386"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="33788386"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 21:10:32 -0700
X-CSE-ConnectionGUID: jBem+RASQNi1pkn2tOViww==
X-CSE-MsgGUID: 4Fl2vCyKTcKoLb/7GstDwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="65456369"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 21:10:28 -0700
Message-ID: <4d9c1513-8062-4594-a06a-c9f179abdaab@linux.intel.com>
Date: Tue, 20 Aug 2024 12:10:26 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Vasant Hegde <vasant.hegde@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Move PCI PASID enablement to probe path
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240816104945.97160-1-baolu.lu@linux.intel.com>
 <6650ce02-ac85-4cb6-941c-cc7e8b6effc4@amd.com>
 <92b55591-e106-4366-ba5b-0588af50770f@linux.intel.com>
 <635b24b7-632d-4046-b82e-6ac6976686c9@amd.com>
 <0e807eec-ce51-42e2-9290-dc90c4210888@linux.intel.com>
 <20240819123400.GU3468552@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240819123400.GU3468552@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/19 20:34, Jason Gunthorpe wrote:
> On Mon, Aug 19, 2024 at 03:09:00PM +0800, Baolu Lu wrote:
>> On 2024/8/19 14:34, Vasant Hegde wrote:
>>> On 8/16/2024 6:39 PM, Baolu Lu wrote:
>>>> On 2024/8/16 20:16, Vasant Hegde wrote:
>>>>> On 8/16/2024 4:19 PM, Lu Baolu wrote:
>>>>>> Currently, PCI PASID is enabled alongside PCI ATS when an iommu domain is
>>>>>> attached to the device and disabled when the device transitions to block
>>>>>> translation mode. This approach is inappropriate as PCI PASID is a device
>>>>>> feature independent of the type of the attached domain.
>>>>> Reading through other thread, I thought we want to enable both PASID and PRI in
>>>>> device probe path. Did I miss something?
>>>> PRI is different. PRI should be enabled when the first iopf-capable
>>>> domain is attached to device or its PASID, and disabled when the last
>>>> such domain is detached.
>>> Right. That's what AMD driver also does (We enable it when we attach IOPF
>>> capable domain). But looking into pci_enable_pri() :
>>>
>>>
>>> 202         /*
>>> 203          * VFs must not implement the PRI Capability.  If their PF
>>> 204          * implements PRI, it is shared by the VFs, so if the PF PRI is
>>> 205          * enabled, it is also enabled for the VF.
>>> 206          */
>>> 207         if (pdev->is_virtfn) {
>>> 208                 if (pci_physfn(pdev)->pri_enabled)
>>> 209                         return 0;
>>> 210                 return -EINVAL;
>>> 211         }
>>> 212
>>>
>>>
>>> If we try to enable PRI for VF without first enabling it in PF it will fail right?
>>>
>>> Now if PF is attached to non-IOPF capable domain (like in AMD case attaching to
>>> domain with V1 page table) and we try to attach VF to IOPF capable domain  (say
>>> AMD v2 page table -OR- nested domain) it will fail right?
>> Yeah! So, the iommu driver should basically control the PRI switch on
>> the PF whenever someone wants to use it on a VF.
> PRI enable sounds like PASID enable to me.
> 
> The ATS control is per VF/PF, and PRI does nothing unless ATS returns
> a non-present indication.
> 
> Like PASID, it seems the purpose of PRI caps is to negotiate if the
> CPU can process PRI TLPs globally.
> 
> So, I'd guess that just like PASID we should turn it on at PF probe
> time if the IOMMU can globall handle PRI.
> 
> Enabling ATS will cause PRI TLPs to be sent.
> 
> Probably more of this code should be lifted out of the iommu drivers..

Some architectures, including VT-d non-scalable mode, doesn't support
ATS translation and translated requests when it is working in the
IDENTITY domain mode. In that case, probably PCI ATS still need to be
disabled when such domain is attached and re-enabled when the domain is
detached.

Thanks,
baolu
