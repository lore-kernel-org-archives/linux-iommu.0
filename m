Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07262E567
	for <iommu@lists.linux.dev>; Thu,  2 Jan 2025 03:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735787703; cv=none; b=HVQatJZ13O8lkQZu+i28kjqVmf6jUuz7nbEanoM0IKzyh6bSEn1a3tqoPj1yjuqQVIGO75gdnpQabRPD5aVWyBP5GhczkI3GaCkUxJHOHRClUW6MJh+ZeaJPo44F63ZWHDl/MhXdHtEuriOiGFhDWwZSczTGdnycwXLK1IvKyRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735787703; c=relaxed/simple;
	bh=d7yBtQyknOqvJhZhNttxroz96ydGqtFrvajhn9MqczI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGlPkkyGdeUCjSVBlzHjYF4nWJE0DHEjXE8sNGg8pNBzMxZAR93XFlBIShTamCW4JQCkB8HyKz3ReJUff41SPfCEvixFOUPgqOuHCWirpvns1YAGQcJ1c48ww2BCyVBWWJJ9X6+nwYzA8eDeMaEHAc89jvujPJOyO9N7WEeMhew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VgO67tja; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VgO67tja"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735787702; x=1767323702;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d7yBtQyknOqvJhZhNttxroz96ydGqtFrvajhn9MqczI=;
  b=VgO67tjaMfYyp1HjQFx5ohMMxiGAQ74OiOy/xf9PPJD5iQBCecUVkHyR
   n+QE0mMceNiBsgumqmf2LIRtxu4WW+CNZ5g/V+bfti/YS1M7g/bwjd4M5
   lu7995dbDE57ODtnoh6GjfTCqPS6c2miJZawwezHRg78e4ugatUuHrbhZ
   EmTMj/Em7jrYtn3QlVuffOgK9AhAqslmLtJISBDb7nkqPLNwv3Wpr+3Kt
   CwPAiSomTK5/70vIvdVno1rylFsDk8B6ewi1lW0I+OzooVod3/x0HhbjU
   q5VneSpNU3g0f0gV8RHN/ksGjSiMcLiTHGDW6T3R+kxfSFipojgUeDHsD
   A==;
X-CSE-ConnectionGUID: 6Nbsrw34QbWTXRg6usRwCw==
X-CSE-MsgGUID: qy8mrsnGTHqLy0x2MmjrPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="35327021"
X-IronPort-AV: E=Sophos;i="6.12,284,1728975600"; 
   d="scan'208";a="35327021"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2025 19:15:01 -0800
X-CSE-ConnectionGUID: OQNgD3k8THmNRBsPws0Tiw==
X-CSE-MsgGUID: w/cJNGpnSaCY/oLSxM51mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,284,1728975600"; 
   d="scan'208";a="101884158"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2025 19:14:59 -0800
Message-ID: <bcf70c0d-ea12-4149-ba9a-2001df95186b@linux.intel.com>
Date: Thu, 2 Jan 2025 11:13:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Remove iommu cap audit
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yi Liu <yi.l.liu@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241216071828.22962-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241216071828.22962-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/24 15:18, Lu Baolu wrote:
> The capability audit code was introduced by commit <ad3d19029979>
> "iommu/vt-d: Audit IOMMU Capabilities and add helper functions", aiming
> to verify the consistency of capabilities across all IOMMUs for supported
> features.
> 
> Nowadays, all the kAPIs of the iommu subsystem have evolved to be device
> oriented, in preparation for supporting heterogeneous IOMMU architectures.
> There is no longer a need to require capability consistence among IOMMUs
> for any feature.
> 
> Remove the iommu cap audit code to make the driver align with the design
> in the iommu core.
> 
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/Makefile        |   2 +-
>   drivers/iommu/intel/cap_audit.c     | 217 ----------------------------
>   drivers/iommu/intel/cap_audit.h     | 131 -----------------
>   drivers/iommu/intel/iommu.c         |   9 --
>   drivers/iommu/intel/irq_remapping.c |   8 -
>   5 files changed, 1 insertion(+), 366 deletions(-)
>   delete mode 100644 drivers/iommu/intel/cap_audit.c
>   delete mode 100644 drivers/iommu/intel/cap_audit.h

Queued for v6.14.
