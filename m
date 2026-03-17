Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF7B227BB5
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 01:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773709708; cv=none; b=WTHk0sqPVCoZJRr1m7EmD4HXEjsSYCaAOCEi4W4bng4tR2MRWIhZNYt4O1RFVHKE/QCD7ygQ4IVBmW+fIqIiWWFJ6vh27am60tEeiYByvsSvHB/jbIbn7cCJJ8iZJaxfwRGqmIE8KjHt1fW0qkO7W3TRDOLq4fy8VmdyaWocq1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773709708; c=relaxed/simple;
	bh=t1D8j0zrQbbIq63XMln2o9FOnApn4uMtRi0dHRClgRI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cfMiOk07JgHETGpab3BxRsyRbcNcoS4trd0OgPlYqENirYXMh+gvGzdXa3M2B4CuUY5GWdRf3Wm/35UWErYCIbMMvJ0k8q7VFbSKekRw8/R5NJP57I3Hu7lQdmWP0Pug+MJDeEHMoUXv4cw9tLrQI0gv5rsyKwWs331nXdqDynY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D1DIAOFd; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D1DIAOFd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773709706; x=1805245706;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t1D8j0zrQbbIq63XMln2o9FOnApn4uMtRi0dHRClgRI=;
  b=D1DIAOFdohWM/pNrS4Sw7/ef3SqfjiKbUxawQ6CjFCO7YPV5ASmd0VTg
   j/C3spN44yTQ7t2PczIh0bVghSEMnX2YnE4VEl7oPBEtbrFTeyNKtFbrc
   4Dx7f2qMiatHEe+7BULN6kbfFKj+6eAnTX3/+VTgRwX5eKDmcELXQbdrB
   Sa38Vb9J+MleFJBA+eFqbD2gbb3NwS5HubHzfaejp7Bzm8rDWiJ9xUaTA
   trbJbcozw6FbYQs8TqFxu2dRXwJUgYKIviEtm/TncXdicWH34Y9FoMBXV
   njthLRAt3UJFaXuwk5yW5U70HD02k0HJ3SFB9BvN779Fst/LQyQumUhzu
   g==;
X-CSE-ConnectionGUID: u01DY9klSjutku2B5U5iag==
X-CSE-MsgGUID: +M4G+RHFQuCeC+RytuTk0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74851921"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74851921"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 18:08:26 -0700
X-CSE-ConnectionGUID: 3FDoOxl2Sa6EyOErJw+H+g==
X-CSE-MsgGUID: F3zn11BhQ6GrfwcQsWBheQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="218284611"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 18:08:24 -0700
Message-ID: <e02def98-ffa4-4467-b008-4652607b0d84@linux.intel.com>
Date: Tue, 17 Mar 2026 09:08:09 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Only handle IOPF for SVA when PRI is
 supported
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20260310075520.295104-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260310075520.295104-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/10/2026 3:55 PM, Lu Baolu wrote:
> In intel_svm_set_dev_pasid(), the driver unconditionally manages the IOPF
> handling during a domain transition. However, commit a86fb7717320
> ("iommu/vt-d: Allow SVA with device-specific IOPF") introduced support for
> SVA on devices that handle page faults internally without utilizing the
> PCI PRI. On such devices, the IOMMU-side IOPF infrastructure is not
> required. Calling iopf_for_domain_replace() on these devices is incorrect
> and can lead to unexpected failures during PASID attachment or unwinding.
> 
> Add a check for info->pri_supported to ensure that the IOPF queue logic
> is only invoked for devices that actually rely on the IOMMU's PRI-based
> fault handling.
> 
> Fixes: 17fce9d2336d ("iommu/vt-d: Put iopf enablement in domain attach path")
> Cc:stable@vger.kernel.org
> Suggested-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/svm.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)

Queued for v7.0-rc.
