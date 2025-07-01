Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630DB26B771
	for <iommu@lists.linux.dev>; Tue,  1 Jul 2025 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751362024; cv=none; b=C3DFNa4xoDjsYrc7Vi+j28uN/GzU4/szjRhk2yPRVOUS5P+aouq7bQsoIqubPbgO8oh7LsHA9UBQEkK14RDGRTfYUusdZWG/wkgXE/IJ8INxW/1V5mfZPZ5KzLpu5YoeQNV7w9zpfvyGFKuX3SjFrFsreFDSWdCVJ5SNptyACOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751362024; c=relaxed/simple;
	bh=Hr3g8/dr2I51Hz/UKUxC6s7OaYARDzimfDOgbgb3nNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmEK20A3eXsEVu2m/XbZP71cMHXIN3jLPwClftc2xF83r/pSP33SKqJBGd1ISwp2VO+z2BnZq9Sd3HvXFoQeY4wFJGzQog/5EIhb2sKx3Wl2+eQtBaF4ieqX6NQwJv6MrneGnWro7UyxRbJGRldCZekCjWBqDTnuPSth1N8z9WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=COpKYWZL; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="COpKYWZL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751362024; x=1782898024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hr3g8/dr2I51Hz/UKUxC6s7OaYARDzimfDOgbgb3nNM=;
  b=COpKYWZL4gNNzr48CJUP9O9R0AlpVkERQWwG0JBN+ikzVmdDhBBzNekT
   ouu0VLGhw+LOWHg7yWJlt8Pi8+ekMqyLPmxTDD/0Rst/jwYVLWQHqncBj
   oRPhRFdI28n+gCYMlhHGtP40pveDOSx/7TRalRBk2m0w0O5ko+HO4fNgQ
   gu7PoqN8HxHHIFCQVsxsgTaDfUBvN4e7kTm8YU6QCmdMIabEJRe/z97dj
   gIFGV+xAMLipseboFINH19zOr7oSxIiqN8LxGw6dKBb7mxy3A+xKHzeVE
   w+1NyD+099XLN8XkfdayzlUw1pNe6AeHbHfjseeGx6bWJrGjWTlsq5m51
   w==;
X-CSE-ConnectionGUID: YZqnsLaaTCibZMEPtUiG/Q==
X-CSE-MsgGUID: fGrINgxQT+ij7k2WVHd69w==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53578574"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="53578574"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 02:27:03 -0700
X-CSE-ConnectionGUID: ihnzyz2rRE6Ln3ibE1kwTA==
X-CSE-MsgGUID: E1H5n1WVQ0Ka/0tREbX5kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="158269398"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa004.jf.intel.com with ESMTP; 01 Jul 2025 02:27:00 -0700
Date: Tue, 1 Jul 2025 17:19:05 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"will@kernel.org" <will@kernel.org>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"aik@amd.com" <aik@amd.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>
Subject: Re: [PATCH v3 2/5] iommufd: Destroy vdevice on idevice destroy
Message-ID: <aGOoCa3BkV7KrwVz@yilunxu-OptiPlex-7050>
References: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
 <20250627033809.1730752-3-yilun.xu@linux.intel.com>
 <BL1PR11MB52712CE938B57E41C34580908C46A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <aGJkitx6wjfQ888t@yilunxu-OptiPlex-7050>
 <20250630145051.GY167785@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630145051.GY167785@nvidia.com>

On Mon, Jun 30, 2025 at 11:50:51AM -0300, Jason Gunthorpe wrote:
> On Mon, Jun 30, 2025 at 06:18:50PM +0800, Xu Yilun wrote:
> 
> > I need to reconsider this, seems we need a dedicated vdev lock to
> > synchronize concurrent vdev abort/destroy.
> 
> It is not possible to be concurrent
> 
> destroy is only called once after it is no longer possible to call
> abort.

I'm almost about to drop the "abort twice" idea. [1]

[1]: https://lore.kernel.org/linux-iommu/20250625123832.GF167785@nvidia.com/

See from the flow below,

  T1. iommufd_device_unbind(idev)
	iommufd_device_destroy(obj)
		mutex_lock(&idev->igroup->lock)
 		iommufd_vdevice_abort(idev->vdev.obj)
		mutex_unlock(&idev->igroup->lock)
	kfree(obj)

  T2. iommufd_destroy(vdev_id)
	iommufd_vdevice_destroy(obj)
		mutex_lock(&vdev->idev->igroup->lock)
		iommufd_vdevice_abort(obj);
		mutex_unlock(&vdev->idev->igroup->lock)
	kfree(obj)

iommufd_vdevice_destroy() will access idev->igroup->lock, but it is
possible the idev is already freed at that time:

                                            iommufd_destroy(vdev_id)
                                            iommufd_vdevice_destroy(obj)
  iommufd_device_unbind(idev)
  iommufd_device_destroy(obj)
  mutex_lock(&idev->igroup->lock)
                                            mutex_lock(&vdev->idev->igroup->lock) (wait)
  iommufd_vdevice_abort(idev->vdev.obj)
  mutex_unlock(&idev->igroup->lock)
  kfree(obj)
                                            mutex_lock(&vdev->idev->igroup->lock) (PANIC)
                                            iommufd_vdevice_abort(obj)
                                            ...

We also can't introduce some vdev side lock instead of idev side lock,
vdev could also be freed right after iommufd_vdevice_destroy().

I think the only simple way is to let idev destruction wait for vdev
destruction, that go back to the wait_event idea ...

Thanks,
Yilun
