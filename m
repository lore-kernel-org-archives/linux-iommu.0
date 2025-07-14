Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13AE25C80D
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 18:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516730; cv=none; b=c4CinZMZkqUi/b4qz0/h8NugT5rK6HlB/y1rf+8NKmEEAbAmuA2k1ttctX10D4WVDCBu/9kRxh8qThB06YkvqF3iVhjxyAbr3/GOS+grjc93QTfxz4YZphxCbCDgkqhzIJceD8/3nz0qNH8JFA8zHGou4Yhlpojr/sIKhlW+KLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516730; c=relaxed/simple;
	bh=Zptfm1+ncVe0WYKzwnFgOc94sK+lXQkGVwbdmZ/nzRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLblLKepFhH/PyFqZDXgFs7J7teuTZmaQyHuGEbRyO8j6WEnwTdmWNAZIJVRLlEDj/93yGR+cEv2CWNMvrXUhio7pc+UzWS5Gypj3J1VQvJ1xHkIkWuw2ixEbX7eEWC8VSTO8hcH850HmebqFVvxGEDAY+CxNG2oqjKt7Rp4Hds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ejzkQ+U5; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ejzkQ+U5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752516729; x=1784052729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zptfm1+ncVe0WYKzwnFgOc94sK+lXQkGVwbdmZ/nzRc=;
  b=ejzkQ+U59IPRIMkg5KB/WSFwd+n6XnI/Fo5JrobfereCKUiyJwo7hicb
   zjuQ/+VcKbhvi8AFtSmpVt/PJ5/cPNxlqLtzfYpsSmW3nF4bvzhIsXVgu
   v9Fs3zbNEKmbQEHR2a9xgZ+h+9WLJRkjfUVkkgqjnxZXOhetyXx47ZPcu
   g/ZgikZwRRkb3Cov9rthWGU8pqmcuRWd8mbf8p8u0w3E55nubNadttM9f
   ZOTaBfhmNtYL2N86cKvDVk1umxYtBIQX82vE7o3jso2HEr4WUWEDDm8H9
   nVOuhBb+0jl7dRKGd5a8feAssB6we7qtrFVouXbKGODa0ETY/hXUrLVDA
   A==;
X-CSE-ConnectionGUID: 4cgYIKB8R8WnNDMrmRX3XQ==
X-CSE-MsgGUID: AJSTWeHtQe+ZHGSuM8YM4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="57331250"
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="57331250"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 11:12:08 -0700
X-CSE-ConnectionGUID: ii9TSDseStKaN1Cdmrl4Aw==
X-CSE-MsgGUID: Q+rxJdaHShqug6lQk6ge/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="161320870"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 14 Jul 2025 11:12:04 -0700
Date: Tue, 15 Jul 2025 02:03:32 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, kevin.tian@intel.com, will@kernel.org,
	aneesh.kumar@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	shuah@kernel.org, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v4 4/7] iommufd: Destroy vdevice on idevice destroy
Message-ID: <aHVGdG275Kcf14uJ@yilunxu-OptiPlex-7050>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-5-yilun.xu@linux.intel.com>
 <aHHG/H6IT9lvYy8x@Asurada-Nvidia>
 <aHKfwQ41x28bNWAL@yilunxu-OptiPlex-7050>
 <aHUzCAM8NKuFYbj3@yilunxu-OptiPlex-7050>
 <20250714165346.GI2067380@nvidia.com>
 <aHU/nVdsuxgRK+u4@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHU/nVdsuxgRK+u4@Asurada-Nvidia>

On Mon, Jul 14, 2025 at 10:34:21AM -0700, Nicolin Chen wrote:
> On Mon, Jul 14, 2025 at 01:53:46PM -0300, Jason Gunthorpe wrote:
> > On Tue, Jul 15, 2025 at 12:40:40AM +0800, Xu Yilun wrote:
> > > diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> > > index 702ae248df17..bdd5a5227cbf 100644
> > > --- a/drivers/iommu/iommufd/viommu.c
> > > +++ b/drivers/iommu/iommufd/viommu.c
> > > @@ -128,7 +128,8 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
> > >         mutex_lock(&idev->igroup->lock);
> > >         iommufd_vdevice_abort(obj);
> > >         mutex_unlock(&idev->igroup->lock);
> > > -       iommufd_put_object(idev->ictx, &idev->obj);
> > > +       refcount_dec(&idev->obj.shortterm_users);
> > > +       wake_up_interruptible_all(&vdev->viommu->ictx->destroy_wait);
> > >  }
> > 
> > I think the main point of keeping both refcounts is to keep the above
> > hidden in the main functions and out of the object functions.
> 
> I see. Maybe we can just update the comments that we are keeping
> both refcounts but using shortterm_users only to do the trick.

I don't think we need special comments. The new usage is not a trick.
It follows the existing mechanism of iommufd_get/put_object().

https://lore.kernel.org/linux-iommu/20250707122502.GS1410929@nvidia.com/

Adding a patch to rename shortterm_users -> wait_cnt should make
thing clear.

Thanks,
Yilun

> 
> Otherwise, we'd need an iommufd_lock_obj_shortterm..
> 
> Thanks
> Nicolin
