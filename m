Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3839515958E
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 07:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724051346; cv=none; b=TJuq64uEal2dalXSkgoJbfx+YiRlMHEcY6rzCEw8MSF8QpNNceHlc+nxT5x6CH7sKDyr49Lzi12EnVIvk5Jmb+42hoMEJLcT2XoHP2SLYf8oPi6wLAl3qYlyI47SmFCEmO9/MESIwUCvhH3Ss4tE34kIkaixaAjM/QHaoqB8+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724051346; c=relaxed/simple;
	bh=ZYNeLaQKbci3ezeTj561FqIQlpHKrGkDbaDepOOcoE4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ODE7UL0fk6h/6gtXSYx7poylrIodD2RCtdHbjnkVU0tzaR8ASb+Ha3VPmQe6vWUk2GiFMlui6yslUNgfgp5hCStgBGTcVaCVE+S06eP6nDOSiVzW5YIjFxxyE6nApovNes1vzj4qlqRPT9NiuXnsRv8qH0pBpnwO9REVawfCeKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uud5EmbG; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uud5EmbG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724051345; x=1755587345;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZYNeLaQKbci3ezeTj561FqIQlpHKrGkDbaDepOOcoE4=;
  b=Uud5EmbGRf0s/kOhPi21fBNVLEcZgn+dwsXxPuMLkFZULEpmhS4kV4zs
   gMujdEKJipjaM81Kfa/0MdYzMlLGrtF2B0xIAx7NcI8nUR4NfYGQb615/
   RZMKxsVvnO6lxYVbJqTYzYnHYcystjByJBKbGdappzz2IEyxITLQix1O8
   ql2RaxOHaulOhJxtytX3qi/nqAmsMZs23pQHi9AE+6S2dXLUHXc0J+A6l
   OvqlSIWKAohHKgUf1eeaSNIdHyqcyd7bTsIsU26y0GWSakRvrbj+rNWS2
   N32ev9QzR0JC7SjTm8B50qDILu/uugkWafulTMaCu+FSbqXjZqoR7ktJu
   A==;
X-CSE-ConnectionGUID: auZItKc2TMeH+8TxRdir4g==
X-CSE-MsgGUID: fVQjXk6JT1C2lueJWT97dQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="21902244"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="21902244"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 00:09:05 -0700
X-CSE-ConnectionGUID: 9lAcx4mRR9yU3AbkExpyYA==
X-CSE-MsgGUID: 2XvNQ288Tfic6O8ThK9sTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="64939199"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.228]) ([10.124.240.228])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 00:09:02 -0700
Message-ID: <0e807eec-ce51-42e2-9290-dc90c4210888@linux.intel.com>
Date: Mon, 19 Aug 2024 15:09:00 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Move PCI PASID enablement to probe path
To: Vasant Hegde <vasant.hegde@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>
References: <20240816104945.97160-1-baolu.lu@linux.intel.com>
 <6650ce02-ac85-4cb6-941c-cc7e8b6effc4@amd.com>
 <92b55591-e106-4366-ba5b-0588af50770f@linux.intel.com>
 <635b24b7-632d-4046-b82e-6ac6976686c9@amd.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <635b24b7-632d-4046-b82e-6ac6976686c9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/19 14:34, Vasant Hegde wrote:
> On 8/16/2024 6:39 PM, Baolu Lu wrote:
>> On 2024/8/16 20:16, Vasant Hegde wrote:
>>> On 8/16/2024 4:19 PM, Lu Baolu wrote:
>>>> Currently, PCI PASID is enabled alongside PCI ATS when an iommu domain is
>>>> attached to the device and disabled when the device transitions to block
>>>> translation mode. This approach is inappropriate as PCI PASID is a device
>>>> feature independent of the type of the attached domain.
>>> Reading through other thread, I thought we want to enable both PASID and PRI in
>>> device probe path. Did I miss something?
>> PRI is different. PRI should be enabled when the first iopf-capable
>> domain is attached to device or its PASID, and disabled when the last
>> such domain is detached.
> Right. That's what AMD driver also does (We enable it when we attach IOPF
> capable domain). But looking into pci_enable_pri() :
> 
> 
> 202         /*
> 203          * VFs must not implement the PRI Capability.  If their PF
> 204          * implements PRI, it is shared by the VFs, so if the PF PRI is
> 205          * enabled, it is also enabled for the VF.
> 206          */
> 207         if (pdev->is_virtfn) {
> 208                 if (pci_physfn(pdev)->pri_enabled)
> 209                         return 0;
> 210                 return -EINVAL;
> 211         }
> 212
> 
> 
> If we try to enable PRI for VF without first enabling it in PF it will fail right?
> 
> Now if PF is attached to non-IOPF capable domain (like in AMD case attaching to
> domain with V1 page table) and we try to attach VF to IOPF capable domain  (say
> AMD v2 page table -OR- nested domain) it will fail right?

Yeah! So, the iommu driver should basically control the PRI switch on
the PF whenever someone wants to use it on a VF.

We could simplify things by turning on PRI for the whole PF when the
first iopf-capable domain is attached to a VF. Then, we'd only turn it
off once all VFs have such domains detached.

Thanks,
baolu
Yeah, so the iommu driver should flip the PRI switch on the PF whenever
someone wants to turn it on for its VF.

We could change things up so that when the first iopf-capable domain is 
attached to any VF or PF, we turn on PRI for the whole device. Then, we
turn it off when every VF and PF have such domains detached.
