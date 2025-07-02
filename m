Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78243C2E0
	for <iommu@lists.linux.dev>; Wed,  2 Jul 2025 02:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751423503; cv=none; b=pqBNYfciswNK0y2pIRZA3TMi2IyyrN379VSQNC4sKTGoEmUgKTRQi20HhVw/bApJnVRqzvsVO518KUx4m/aXvrpZTD2QXFohwhiM4v9oBFJMYVVR7LOL8YkFFZQlASzWxoNHQYiDkyN9Hq7r6m6XYYFMeF1leUZH+IWsVWld0gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751423503; c=relaxed/simple;
	bh=6iQ7WmwuVdriz7MaoWsLX07A7ttd5u5ifqXXe5zPMAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCvH/iO1Sqc5CvkDdqMT7gBbRahCc+icHy27pO1Vg8edreSKZg9L80++qaUdzO+TMSK+jqEI4HeTYfCp9qiW9Gv91IBcdH/F9l5vBXMGLMtiyE/b1mdTmN9SZXg6hboFLbgnWUIyKmqubMb+29DxR39Vmw2Ve0dMW6UfwW6dwvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WP1czUgT; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WP1czUgT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751423501; x=1782959501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6iQ7WmwuVdriz7MaoWsLX07A7ttd5u5ifqXXe5zPMAw=;
  b=WP1czUgT3Llk4pcVMg2S4i64LReU24ShclBZKOSmzLEPISfU/G+ausNV
   piDZeYAM+mYedsryxj76QI8/tX1fAgp8WJEXr3h3pg6XbsTdRq/ZeLFyw
   TONlyvAUq1siuYPYLpitlfcE3lmbjxfT0QqYTtZVXE65qL5we/uWKQZmE
   52aHTSsVbclkj9m0Kkxg/tAtXojQTyCjfurNS589oI10w9vwcobwIwiug
   V7sbpmuDFabYC/d2P4gjUcrJx8VoUoXClNn1cCJ5up4Ze1iQr3vvSpUV1
   AzUU3olRiH898RTN4/MxRouCIPZMaJCVaKbbihhMf/9n8sBHDXFxQbvQ7
   g==;
X-CSE-ConnectionGUID: 20GP6wEFTf2OOwdIjfn/Ug==
X-CSE-MsgGUID: cCJWTG65Qw+SPNPh/9trGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="65053521"
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="65053521"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 19:31:41 -0700
X-CSE-ConnectionGUID: F+T+WGjNRAaqpghHlNfwsw==
X-CSE-MsgGUID: m7KRpRdwTCG7dUqw7NMSbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="184980877"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 01 Jul 2025 19:31:38 -0700
Date: Wed, 2 Jul 2025 10:23:41 +0800
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
Message-ID: <aGSYLVmV17g832Ta@yilunxu-OptiPlex-7050>
References: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
 <20250627033809.1730752-3-yilun.xu@linux.intel.com>
 <BL1PR11MB52712CE938B57E41C34580908C46A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <aGJkitx6wjfQ888t@yilunxu-OptiPlex-7050>
 <20250630145051.GY167785@nvidia.com>
 <aGOoCa3BkV7KrwVz@yilunxu-OptiPlex-7050>
 <20250701121315.GD167785@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701121315.GD167785@nvidia.com>

On Tue, Jul 01, 2025 at 09:13:15AM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 01, 2025 at 05:19:05PM +0800, Xu Yilun wrote:
> > On Mon, Jun 30, 2025 at 11:50:51AM -0300, Jason Gunthorpe wrote:
> > > On Mon, Jun 30, 2025 at 06:18:50PM +0800, Xu Yilun wrote:
> > > 
> > > > I need to reconsider this, seems we need a dedicated vdev lock to
> > > > synchronize concurrent vdev abort/destroy.
> > > 
> > > It is not possible to be concurrent
> > > 
> > > destroy is only called once after it is no longer possible to call
> > > abort.
> > 
> > I'm almost about to drop the "abort twice" idea. [1]
> > 
> > [1]: https://lore.kernel.org/linux-iommu/20250625123832.GF167785@nvidia.com/
> > 
> > See from the flow below,
> > 
> >   T1. iommufd_device_unbind(idev)
> > 	iommufd_device_destroy(obj)
> > 		mutex_lock(&idev->igroup->lock)
> >  		iommufd_vdevice_abort(idev->vdev.obj)
> > 		mutex_unlock(&idev->igroup->lock)
> > 	kfree(obj)
> > 
> >   T2. iommufd_destroy(vdev_id)
> > 	iommufd_vdevice_destroy(obj)
> > 		mutex_lock(&vdev->idev->igroup->lock)
> > 		iommufd_vdevice_abort(obj);
> > 		mutex_unlock(&vdev->idev->igroup->lock)
> > 	kfree(obj)
> > 
> > iommufd_vdevice_destroy() will access idev->igroup->lock, but it is
> > possible the idev is already freed at that time:
> > 
> >                                             iommufd_destroy(vdev_id)
> >                                             iommufd_vdevice_destroy(obj)
> >   iommufd_device_unbind(idev)
> >   iommufd_device_destroy(obj)
> >   mutex_lock(&idev->igroup->lock)
> >                                             mutex_lock(&vdev->idev->igroup->lock) (wait)
> >   iommufd_vdevice_abort(idev->vdev.obj)
> >   mutex_unlock(&idev->igroup->lock)
> >   kfree(obj)
> >                                             mutex_lock(&vdev->idev->igroup->lock) (PANIC)
> >                                             iommufd_vdevice_abort(obj)
> >                                             ...
> 
> Yes, you can't touch idev inside the destroy function at all, under
> any version. idev is only valid if you have a refcount on vdev.
> 
> But why are you touching this lock? Arrange things so abort doesn't
> touch the idev??

idev has a pointer idev->vdev to track the vdev's lifecycle.
idev->igroup->lock protects the pointer. At the end of
iommufd_vdevice_destroy() this pointer should be NULLed so that idev
knows vdev is really destroyed.

I haven't found a safer way for vdev to sync up its validness with idev
w/o touching idev.

I was thinking of using vdev->idev and some vdev lock for tracking
instead. Then iommufd_vdevice_abort() doesn't touch idev. But it is
still the same, just switch to put idev in risk:


                                               iommufd_destroy(vdev_id)
                                               iommufd_vdevice_destroy(obj)
  iommufd_device_unbind(idev)
  iommufd_device_destroy(obj)
                                               mutex_lock(&vdev->some_lock)
  mutex_lock(&idev->vdev->some_lock) (wait)
                                               iommufd_vdevice_abort(obj)
                                               mutex_unlock(&vdev->some_lock)
                                               kfree(obj)
  mutex_lock(&idev->vdev->some_lock) (PANIC)
  iommufd_vdevice_abort(idev->vdev.obj)
  ...

Thanks,
Yilun
