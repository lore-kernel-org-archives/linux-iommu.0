Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E244155326;
	Sat, 28 Feb 2026 04:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772253251; cv=none; b=mdYCbk6T1VJ7zfWEXayHLqRMGQV1hYLvdV7sRNFWVPrdpkievtK4A3mqJBRW13fNb6SVwBdM1WNb7bOfmodnMvtKhpTmmNL8BeaeVmcdOhhdm66zXssCacuw1hsCCAZoQ1n5Ckhi05b69xsMKPQTUnBFDu7nRWHt402j+N3vrZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772253251; c=relaxed/simple;
	bh=6ZTdM+dG94A4q6lLWOntfkiT+NYMWFdAVdePg/GzGgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2szMnlB64kRApybXa7GsbodxV3dv+KaT6rSiYCHckJ8XPnZbNhq6WvPj1O65tcv6xgjSOnrYx7tEZOS06JHYrEn6lAbXhX+fS0p/YyjrfJ9Y+8WBBfxFHWFHPELclyHB1rWWkiQPdFtmSKeLLL3zVmd+Ha1taorBiekrTlUpQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=abU0k8+l; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="abU0k8+l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772253249; x=1803789249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6ZTdM+dG94A4q6lLWOntfkiT+NYMWFdAVdePg/GzGgM=;
  b=abU0k8+lOtrDe7CP/kg13OCt8U9mZ6qHrDH3PiMdMx2NreNl6V+LJzLc
   nvclNYwMDv5h7iKnc29OB1Xbq28rzwGO5FqfQFoYUgX44vWFeey+sEZ5x
   +XxI8i2zrJdSeTB6uUdIilTL2jXPMh0z3W3/gptT0wyAxL65GHY3Sy3yd
   BaMyXcxHm2Yt7dgAjCye/A52giHVoSs7rX/cp61oKM1LTxi6wbnz+sZQE
   Ea6YDtARMoi1G6bLQ8FKOwBrDrWQgiU2owBICtbcsj2ES7WEC8tqkiv14
   9OPMBui11F7DKFWO1IcKO3exDh9dPP7RsI8N1tWGXiVVvQOEQynYGr/NU
   A==;
X-CSE-ConnectionGUID: rZdwp/cJTs6xmbPsHjivag==
X-CSE-MsgGUID: pnzDraLsTbyPTE34JFVgNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="73383056"
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="73383056"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 20:34:09 -0800
X-CSE-ConnectionGUID: PMTaQJFSSROROo54YRIIow==
X-CSE-MsgGUID: lR9E7gR8QGqIjUNJzS9R/g==
X-ExtLoop1: 1
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 27 Feb 2026 20:34:04 -0800
Date: Sat, 28 Feb 2026 12:14:25 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Alexey Kardashevskiy <aik@amd.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev, Dan Williams <dan.j.williams@intel.com>,
	Santosh Shukla <santosh.shukla@amd.com>,
	"Pratik R . Sampat" <prsampat@amd.com>,
	Fuad Tabba <tabba@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	michael.roth@amd.com, vannapurve@google.com
Subject: Re: [RFC PATCH kernel] iommufd: Allow mapping from KVM's guest_memfd
Message-ID: <aaJroUzTZXZfbRAl@yilunxu-OptiPlex-7050>
References: <20260225075211.3353194-1-aik@amd.com>
 <aZ7-tTpobKiCFT5L@google.com>
 <CAEvNRgEiod74cRoVQVC5LUbWDZf6Wwz1ssjQN0fveN=RBAjsTw@mail.gmail.com>
 <20260226190757.GA44359@ziepe.ca>
 <aaDL8tYrVCWlQg79@google.com>
 <20260227002105.GC44359@ziepe.ca>
 <aaDlRdnhIqRXEbPZ@google.com>
 <20260227010902.GE44359@ziepe.ca>
 <aaFzgGTpZI0eZWdD@yilunxu-OptiPlex-7050>
 <20260227131815.GG44359@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227131815.GG44359@ziepe.ca>

On Fri, Feb 27, 2026 at 09:18:15AM -0400, Jason Gunthorpe wrote:
> On Fri, Feb 27, 2026 at 06:35:44PM +0800, Xu Yilun wrote:
> 
> > Will cause host machine check and host restart, same as host CPU
> > accessing encrypted memory. Intel TDX has no lower level privilege
> > protection table so the wrong accessing will actually impact the
> > memory encryption engine.
> 
> Blah, of course it does.
> 
> So Intel needs a two step synchronization to wipe the IOPTEs before
> any shared private conversions and restore the right ones after.

Mainly about shared IOPTE (for both T=0 table & T=1 table): "unmap
before conversion to private" & "map after conversion to shared"

I see there are already some consideration in QEMU to support in-place
conversion + shared passthrough [*], using uptr, but seems that's
exactly what you are objecting to.

[*]: https://lore.kernel.org/all/18f64464-2ead-42d4-aeaa-f781020dca05@intel.com/

For Intel, T=1 private IOPTE reuses S-EPT, this is the real CC business
and the correctness is managed by KVM & firmware, no notification
needed.

Further more, I think "unmap shared IOPTE before conversion to private"
may be the only concern to ensure kernel safety, other steps could be
fully left to userspace. Hope the downgrading from "remap" to
"invalidate" simplifies the notification.

> 
> AMD needs a nasty HW synchronization with RMP changes, but otherwise
> wants to map the entire physical space.
> 
> ARM doesn't care much, I think it could safely do either approach?
> 
> These are very different behaviors so I would expect that userspace
> needs to signal which of the two it wants.
> 
> It feels like we need a fairly complex dedicated synchronization logic
> in iommufd coupled to the shared/private machinery in guestmemfd
> 
> Not really sure how to implement the Intel version right now, it is
> sort of like a nasty version of SVA..
> 
> Jason
