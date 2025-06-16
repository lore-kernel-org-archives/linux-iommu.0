Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6461A18C31
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 04:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750046600; cv=none; b=G35a6gPaeYwtUHnzaWgOG/SxfeRZPbteKLGh9MUJRfwsa7Fo+MeWXPuLWgAPDKP8MYxGJ/9l4Vg1MSNkOHG2IzD1L+KicAMi4fVwlBDV7/R7ICFvUOTHmEdfY51VOZbbzrMIpsvvNQU5/bsR74f8gJgBuPVQTl6e4geZOqKrlY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750046600; c=relaxed/simple;
	bh=H0gdGFUMYav6Jm5SILO9J01HtUlI+O54iz0Soqb0nlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6D3HNhKxj1UdDChE2oRDFwhEdl8HrhSxF9/fXosAiI5iuc9obLqg/ICtij42O3SGkOBJcSNLytNxMPNIzoNAoa6dDfIxfiG03Icc4OEtRj8XaJ+lAVNI4gsANUROzXSUN0hvvmTE6Y/gORQtetxl4GrjxiE/pGxI0+KeLIAPhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CKup66t9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CKup66t9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750046599; x=1781582599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H0gdGFUMYav6Jm5SILO9J01HtUlI+O54iz0Soqb0nlA=;
  b=CKup66t9QPqKm5HBxYeUCiHEWVzilx2/IBvV8EkuqBk1jFNHUtCG73Fk
   QVohEtpWv8uSDQX1w5+AhzLUlap143IB9K/d0JClVCVvwm60LnM/dOJqx
   nP8KCyRhwHMm1Jbbg83ZLB7oG2DGdU33EWW2+DGJ9srwx9GCVhJ2hZQTa
   qutqR1Gl3cZfM6wsiMY4m4gT5W4IzvRHaYB74whINXY4IutCL/zCg08wj
   qgRONZVjMK1xHhSryP6VG1phBjAWkx6HGE59LWPNszG7qnr/uVtx2NmAA
   w03vFi88iDC46c1XgnAidDuB8E9Z6fZF8QgHASArfzE4BO3T+X2d2QHkX
   A==;
X-CSE-ConnectionGUID: UJo3kyDJTVmDhQFU5ipT+w==
X-CSE-MsgGUID: FGkCvPUlThyEzArYDIGRfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52099976"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="52099976"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 21:03:18 -0700
X-CSE-ConnectionGUID: xGiPDYIjTQ+jP29rgezUKA==
X-CSE-MsgGUID: YFEYZ4GlQ0CPXGjDuwfA0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="185615226"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 15 Jun 2025 21:03:16 -0700
Date: Mon, 16 Jun 2025 11:56:07 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH] iommufd: Destroy vdevice on device unbind
Message-ID: <aE+V18uALqocLsoI@yilunxu-OptiPlex-7050>
References: <20250610065146.1321816-1-aneesh.kumar@kernel.org>
 <BN9PR11MB527606182417BB7A35349F598C74A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250612172645.GA1011960@ziepe.ca>
 <BN9PR11MB5276B467ADCC57BC6571CA458C77A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250613124202.GD1130869@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613124202.GD1130869@ziepe.ca>

On Fri, Jun 13, 2025 at 09:42:02AM -0300, Jason Gunthorpe wrote:
> On Fri, Jun 13, 2025 at 07:31:48AM +0000, Tian, Kevin wrote:
> > yeah that seems to be the option if the said life-cycle dependency
> > cannot be removed...
> > 
> > conceptually it's still a bit unclean as the user needs to know that
> > the vdevice object is special after idevice is unbound i.e. it can only
> > be destroyed instead of supporting any other kind of operations.
> 
> I would say userspace is somewhat malfunctioning if it destroys vfio
> before the vdevice. So the main aim here should be to contain the
> resulting mess, but still expect userspace to destroy the vdevice
> without a failure.
> 
> > hmm if the user needs to build certain knowledge anyway can we 
> > go one step further to state that the vdevice will be destroyed
> > automatically once its idevice is unbound so the user shouldn't
> > attempt to explicitly destroy it again after unbind?

I think this statement is complex to user. I'd rather from user POV the
vdev_id's lifecycle is mostly the same as other iommufd objects. The
only difference should be, after idev unbind, vdev_id would be
disfunctional, IOCTLs against the vdev_id would fail except IOMMU_DESTROY.

My understanding of the tombstone idea is:

 - Before idev unbind, IOCTL(IOMMU_DESTROY, vdev_id) could free the vdev
   as normal.
 - On idev unbind, destroy the associate vdev (if exists), but still
   reserve the ictx->objects xa entry.
 - After idev unbind & on IOCTL(IOMMU_DESTROY, vdev_id), just free the
   xa entry if it's a tombstone.
 - On fops_release, free the tombstones if exist.

Thanks,
Yilun

> 
> I would assume a malfunctioning userspace is probably going to destroy
> the vdevice explicitly. If it had proper knowledge it wouldn't have
> done this in the first place :)
> 
> Jason
> 
