Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC7B1B85FD
	for <iommu@lists.linux.dev>; Thu, 26 Jun 2025 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750909130; cv=none; b=K6dHwdcv3TLUDnOitv6F3WdrWnmWXDcgIEXHIv/Z2tof18mTBMm5IFB3OCEgyBZeIS50sk06i6vIccpjGWnkbNsEOY5L75LoJKeVUT4G/O4TNF+mdpLiFecYBuBRth1ci/w4zSHKBeMb9SEVglpPFeDFtgRfycuagww7eyPQjl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750909130; c=relaxed/simple;
	bh=qsb+gqnjKhUuAhN7Z7oyO9sPPXSOXU/jB3r2Fqw2FHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZS4hi54d/iiHLCc2fFAV1Hbg/WOBq6DHQ0KERsOxC/qHGnGygwWfqomE7b8jjPgrYdsd71qwSInWqEWcfFtSG0ExqnRx7HYcKgURVtgKdOQmuVB9tDYfoY7sft3dArCiNW/7V7ZP18PE51kXKKdBHR2nnbcTIh75DTGl44sidM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h8s4+H5p; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h8s4+H5p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750909129; x=1782445129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qsb+gqnjKhUuAhN7Z7oyO9sPPXSOXU/jB3r2Fqw2FHU=;
  b=h8s4+H5pdwJbPSqBhAKNYNrF/zOyHw1NYA+3WdfmL0oppLayqVJJ7Bvt
   /SsBo3QlpzaScxVp02QBEnWqR9pEPd1NaUeqfwasCZaqjPI5lYjuLcynT
   TkcvkLx++PUomw3dN+nfcgqpLzqGmLM58wY40M9fbpry+vdv6qxd0yQXi
   8uwoI9qMW3TjO1rwKkSjm+XQE3/04P9dEKODPkTX5tv2iX62KW5f9aQus
   M0KBO+IdAfly0KnIGAUWEoHBsctkIJfJ0R2Jf+CCDU8mjvBe+t1PMQejG
   FfYwpBM0nXT2CreG1+TTsjzeLBQivTohmVi0hfJTYWcyyP6N9dTQVt+Mp
   w==;
X-CSE-ConnectionGUID: wgmYLpWjSHe9Uau1zXoNFw==
X-CSE-MsgGUID: cQoGVx1xSJi5ZmQUPc4wjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="75735524"
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="75735524"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 20:38:48 -0700
X-CSE-ConnectionGUID: 7VMGBjGrQFCQzhMD7SVYgA==
X-CSE-MsgGUID: ElzvkcQWTgWMxRDG1dks8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="156431983"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 25 Jun 2025 20:38:45 -0700
Date: Thu, 26 Jun 2025 11:31:06 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, aneesh.kumar@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, shuah@kernel.org,
	nicolinc@nvidia.com, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v2 3/4] iommufd: Destroy vdevice on idevice destroy
Message-ID: <aFy++lne6X+1bFlM@yilunxu-OptiPlex-7050>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
 <20250623094946.1714996-4-yilun.xu@linux.intel.com>
 <20250624145346.GC150753@nvidia.com>
 <aFvKCEt6FadGtYr+@yilunxu-OptiPlex-7050>
 <20250625123832.GF167785@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625123832.GF167785@nvidia.com>

On Wed, Jun 25, 2025 at 09:38:32AM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 25, 2025 at 06:06:00PM +0800, Xu Yilun wrote:
> > > 	/*
> > > 	 * We don't know what thread is actually going to destroy the vdev, but
> > > 	 * once the vdev is destroyed the pointer is NULL'd. At this
> > > 	 * point idev->users is 0 so no other thread can set a new vdev.
> > > 	 */
> > > 	if (!wait_event_timeout(idev->ictx->destroy_wait,
> > > 				!READ_ONCE(idev->vdev),
> > > 				msecs_to_jiffies(60000)))
> > > 		pr_crit("Time out waiting for iommufd vdevice removed\n");
> > > }
> > > 
> > > Though there is a cleaner option here, you could do:
> > > 
> > > 	mutex_lock(&idev->igroup->lock);
> > > 	if (idev->vdev)
> > > 		iommufd_vdevice_abort(&idev->vdev->obj);
> > > 	mutex_unlock(&idev->igroup->lock);
> > > 
> > > And make it safe to call abort twice, eg by setting dev to NULL and
> > > checking for that. First thread to get to the igroup lock, either via
> > > iommufd_vdevice_destroy() or via the above will do the actual abort
> > > synchronously without any wait_event_timeout. That seems better??
> > 
> > I'm good to both options, but slightly tend not to make vdevice so
> > special from other objects, so still prefer the wait_event option.
> 
> The wait_event is a ugly hack though, even in its existing code. The
> above version is better because it doesn't have any failure mode and
> doesn't introduce any unlocked use of the idev->vdev which is easier
> to reason about, no READ_ONCE/WRITE_ONCE/etc
> 
> It sounds like you should largely leave the existing other parts the
> same as this v2, though can you try reorganize it to look a little
> more like the version I shared?

Sure. But may I confirm that your only want reentrant
iommufd_vdevice_abort() but not your iommufd_object_remove_tombstone()
changes?

To me, grab a shortterm_users but not a user is a new operation model. I
hesitate to add it when the existing refcount_inc(&obj->user) works for
this case.

Thanks,
Yilun

> 
> Jason
> 
