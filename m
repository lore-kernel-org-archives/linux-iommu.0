Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890B313D53F
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 03:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725507376; cv=none; b=i0dsOgnDRZtYAxMFvzRvrF1FGescB0g3DoyKW/on2YFuFD3hCKm+WOEv/eypCGkipg9WMkZieNqGIgJ/1MLVLrsqzyIvDIQIZVpy+F0aRyyIfLQLyBQfdhVKvKui/ET1A/gfd/0biCrlR7UicdMcF0xXG4Jpz2Sel+6cvbLP94A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725507376; c=relaxed/simple;
	bh=DngHHRRSDlz3SVTN9ih5beWK6ZFXtPsMmDJF35B7U3s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lJqTPZFk0+f+1LItLfxQ0EDXD5IVHTVN5jKNN5Ldfz+vrrnbTEbFqEb5XyFFIdBenMckrH/uyMRrBYfmoS7ew1Tj/X1VcZPXhzwNUW2rvBWfBiEWfsvUAdVaDbQz1mFDQuK8uuGXvnAYc6Q/tHEj99GIjp0MKl5re6dkqYAwC/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FBDaEeMu; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBDaEeMu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725507374; x=1757043374;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DngHHRRSDlz3SVTN9ih5beWK6ZFXtPsMmDJF35B7U3s=;
  b=FBDaEeMuiLfsLMpqE78uN2xoiol5O51NC71AKsHhVsnd+OHq36JJEMNY
   0xoyNc2apo4L0Y4Lug4Oq7K9P2USxWFjmINpO0qswqBdl/EAYQLZKghBD
   pjLN4/lPYN5VnuG7lvqz64qn2qHDjEEJPQXh4ZcoknwRjPJe5XOPo0BFu
   n3EXQTqsGjxNoA+so0+swQ6dTKaAqFtVWXjllU4hpbwroE/6u3weCtuPZ
   OWReS//phUdK1ulZCRLstJKVZ2G6TbH8GTv+OUlNXYAFSiRErKWr9pndo
   VMiA94Dw06WjdPnA61Sik0KnVPQD4CpZEESwJ2+qORyO7QAp4glNQthPz
   g==;
X-CSE-ConnectionGUID: Y+a4HDMdRim3rKlY7kSCIQ==
X-CSE-MsgGUID: L3l/Lgd9SraLh4FEklCNXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="24153633"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="24153633"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 20:36:14 -0700
X-CSE-ConnectionGUID: WOYQos7PQO+rLnTRNydlCA==
X-CSE-MsgGUID: PBQNEb9eQpOQyDl0RjYLyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="66226216"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 04 Sep 2024 20:36:11 -0700
Message-ID: <baace573-44ef-4caa-bb02-27d0e7035bcc@linux.intel.com>
Date: Thu, 5 Sep 2024 11:32:14 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
Subject: Re: [PATCH 5/6] iommu: init pasid array while doing domain_replace
 and iopf is active
To: j.granados@samsung.com, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Klaus Jensen <its@irrelevant.dk>
References: <20240904-jag-iopfv8-v1-0-e3549920adf3@samsung.com>
 <20240904-jag-iopfv8-v1-5-e3549920adf3@samsung.com>
 <c2e765a8-d935-42db-bd22-c12e7960f2f0@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <c2e765a8-d935-42db-bd22-c12e7960f2f0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 11:30 AM, Baolu Lu wrote:
> On 9/4/24 9:17 PM, Joel Granados via B4 Relay wrote:
>> From: Joel Granados<j.granados@samsung.com>
>>
>> iommu_report_device_fault expects a pasid array to have an
>> iommu_attach_handle when a fault is detected.
> 
> The iommu_attach_handle is expected only when an iopf-capable domain is
> attached to the device or PASID. The iommu_report_device_fault() treats
> it as a fault when a fault occurs, but no iopf-capable domain is
> attached.
> 
>> Add this handle when the
>> replacing hwpt has a valid iommufd fault object. Remove it when we
>> release ownership of the group.
> 
> The iommu_attach_handle is managed by the caller (iommufd here for
> example). Therefore, before iommu_attach_handle tries to attach a domain
> to an iopf-capable device or pasid, it should allocate the handle and

Correct:

"... attach an iopf-capable domain to device or pasid ..."

Sorry for the typo.

> pass it to the domain attachment interfaces. Conversely, the handle can
> only be freed after the domain is detached.
> 
> Thanks,
> baolu
