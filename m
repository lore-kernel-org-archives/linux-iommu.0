Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9F93EF0AF;
	Fri, 27 Feb 2026 11:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772191420; cv=none; b=a7QlkGSzoUMwG79x9QqosBUhpZ7zgb8KlvQCA7th+4HtjxRlMbIiRmHBDmR9A4Ud+toTTOnkpWuxDgug2z8tkmGxOqjJmndefmAw8T9YS+Ssh642QHHcOorcIycgvtsqYjgq8vWlIOmTokLTKnoXynOMBLon+gEz20MnGHG1Eeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772191420; c=relaxed/simple;
	bh=xARUtbiSECedk31YtYDlK/tyP4DMP+wGs2FP/IdOQIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bzm4L4QN4YRje82GdHvWWnehGEdbNVYp8h4YaAcVLM9R6D+Lwu7dT4z297DfGtzXGVky4D6DIyBV9l/Ffdj+xTV+TCnp4TT6do7YlzFnModYQpAiaNMTx04OboJZrwL44Jj2zvlMAq77+BENe2wIMzyWNfc3q4DJ5/VigZhNvbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lferv5vU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lferv5vU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772191418; x=1803727418;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xARUtbiSECedk31YtYDlK/tyP4DMP+wGs2FP/IdOQIc=;
  b=Lferv5vU25xME4q7k+6FnOcDMn6tHvnz1WLMc77+Z06QIO5uPHd6913j
   9pZ5eGaqeE522oEP3nqldVYjbdj2NluByEcqDOq8sZpEkloG+5G6bAS9+
   LgUPFlNYWbLgFiuHDMB4d+UBomkgTr/xWwRbnX6mYo4m9tgAFldWotVzp
   yoszKa8AmefWD/rtITQ8a6O57twNsOe/xJEZxpJr6zJxFFWi8r2/HeV3i
   cht+luSZenqBqAYDzkEouL5zF1wifuARN6IT5/VAEcVD+G2MA1RudQTrS
   S7vust0TGB4AaODGipo5+VPTa23znHdOz/kN+nu3pkHTbiZ+62dz0t1g2
   g==;
X-CSE-ConnectionGUID: XSYpaENiSU6qGfvrEn/LZQ==
X-CSE-MsgGUID: eTQY/+SFTPeJbVbpH2s2aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="77112546"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="77112546"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 03:23:38 -0800
X-CSE-ConnectionGUID: EYfyOVePQ/SXha9/S7v6/w==
X-CSE-MsgGUID: EVxMXE/ZRtO3xo12DOyV/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="221020288"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 27 Feb 2026 03:23:33 -0800
Date: Fri, 27 Feb 2026 19:03:56 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev, Dan Williams <dan.j.williams@intel.com>,
	Santosh Shukla <santosh.shukla@amd.com>,
	"Pratik R . Sampat" <prsampat@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Fuad Tabba <tabba@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH kernel] iommufd: Allow mapping from KVM's guest_memfd
Message-ID: <aaF6HD2gfe/udl/x@yilunxu-OptiPlex-7050>
References: <20260225075211.3353194-1-aik@amd.com>
 <aZ7-tTpobKiCFT5L@google.com>
 <fb10affb-40d5-4558-b64b-0ab22659ccf2@amd.com>
 <20260226192700.GB44359@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226192700.GB44359@ziepe.ca>

On Thu, Feb 26, 2026 at 03:27:00PM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 26, 2026 at 05:47:50PM +1100, Alexey Kardashevskiy wrote:
> > 
> > 
> > On 26/2/26 00:55, Sean Christopherson wrote:
> > > On Wed, Feb 25, 2026, Alexey Kardashevskiy wrote:
> > > > For the new guest_memfd type, no additional reference is taken as
> > > > pinning is guaranteed by the KVM guest_memfd library.
> > > > 
> > > > There is no KVM-GMEMFD->IOMMUFD direct notification mechanism as
> > > > the assumption is that:
> > > > 1) page stage change events will be handled by VMM which is going
> > > > to call IOMMUFD to remap pages;
> > > > 2) shrinking GMEMFD equals to VM memory unplug and VMM is going to
> > > > handle it.
> > > 
> > > The VMM is outside of the kernel's effective TCB.  Assuming the VMM will always
> > > do the right thing is a non-starter.
> > 
> > Right.
> > 
> > But, say, for 1), VMM does not the right thing and skips on PSC -
> > the AMD host will observe IOMMU fault events - noisy but harmless. I
> > wonder if it is different for others though.
> 
> ARM is also supposed to be safe as GPT faults are contained, IIRC.

Intel TDX will cause host machine check and restart, which are not
contained.

> 
> However, it is not like AMD in many important ways here. Critically ARM
> has a split guest physical space where the low addresses are all
> private and the upper addresses are all shared.

This is same as Intel TDX, the GPA shared bit are used by IOMMU to
target shared/private. You can imagine for T=1, there are 2 IOPTs, or
1 IOPT with all private at lower address & all shared at higher address.

> 
> Thus on Linux the iommu should be programed with the shared pages
> mapped into the shared address range. It would be wasteful to program
> it with large amounts of IOPTEs that are already know to be private.

For Intel TDX, it is not just a waste, the redundant IOMMU mappings are
dangerous.

> 
> I think if you are fully doing in-place conversion then you could
> program the entire shared address range to point to the memory pool
> (eg with 1G huge pages) and rely entirely on the GPT to arbitrate
> access. I don't think that is implemented in Linux though?
> 
> While on AMD, IIRC, the iommu should be programed with both the shared
> and private pages in the respective GPA locations, but due to the RMP
> matching insanity you have to keep restructuring the IOPTEs to exactly
> match the RMP layout.
> 
> I have no idea what Intel needs.

Secure part of IOPT (lower address) reuses KVM MMU (S-EPT) so needs no
extra update but needs a global IOTLB flush. The Shared part of IOPT
for T=1 needs update based on GPA.

> 
> Jason
