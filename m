Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CC02459F3
	for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 10:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751279206; cv=none; b=mtomi/u8C7RiDcSqcbTjTGaVAgCqAiVznbECkGeLHN5QYW+gLZp9OXjoJEnwM3HHPDzev8hpFyahzhHuP1muTAT2iJqtVytU/zLVnyfWV645cGndR7RjpKC1gwHJKTfqih+907QWuutdLUqRB85neqWXV21UQu/iS+44jOdMlFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751279206; c=relaxed/simple;
	bh=lP9cZ5ZVd213PgYvBxRjMQzsYmVuhyx9RNU0p02YOoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvGBYdR4igamwkdRt+Nxa4MSUxyAynSYXLy7eHEmD/uiHB6QUKlWNo/xZq6c8YHrEW1QwiKb+sclI1jQ0nLN5X8oS+o7V8Qw+NJyrD3Zv667OnHjeWl5/2+PLnfKfgDpHdKO4nuOABn+lJyMzEn/apAOWNbAvxKxqD4uFedL74w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dLTv09gW; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dLTv09gW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751279205; x=1782815205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lP9cZ5ZVd213PgYvBxRjMQzsYmVuhyx9RNU0p02YOoU=;
  b=dLTv09gWJGuFIV45jQ6fBd4MxrvHrV3Y1+ImF+UNJrr8uRfUOAQGjdP1
   OM/iEm66qw7Sr9Mkrilx9Jrdr16bIpjrzKQMOebDQu22H8tYXcvswPyVR
   IL22mFegGsKy78NyJWU/1YPCyvq3pjU+LPtVLwUVUgEI5xwTHJsGBRF61
   Yufo8Xd3zstOsRF8TQtm3oLrx/NimhqPgiaezeut+iWksfJgSP3HvKFOR
   J9fR6l5XQzT45xWSXzZGyUtIOxBbdVOr8nPAnlqLR8NvhwIggXX8NU/S7
   QPg1tD+xYSJbqMPOhYLOtHsh76VMlMwR6WP3cIWjtxoVbcHG5Rh6J7dZ9
   g==;
X-CSE-ConnectionGUID: uzM9d+tbRK6J7766eKfRuw==
X-CSE-MsgGUID: xgeo56fpS8CgT7mPB0pcuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="53649395"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="53649395"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 03:26:45 -0700
X-CSE-ConnectionGUID: 6QCD6s3aRCuhF1tFyrQ++Q==
X-CSE-MsgGUID: ifNOHc7BR3KyP2lv8WUJbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="152900050"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 30 Jun 2025 03:26:41 -0700
Date: Mon, 30 Jun 2025 18:18:50 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "jgg@nvidia.com" <jgg@nvidia.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
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
Message-ID: <aGJkitx6wjfQ888t@yilunxu-OptiPlex-7050>
References: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
 <20250627033809.1730752-3-yilun.xu@linux.intel.com>
 <BL1PR11MB52712CE938B57E41C34580908C46A@BL1PR11MB5271.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB52712CE938B57E41C34580908C46A@BL1PR11MB5271.namprd11.prod.outlook.com>

On Mon, Jun 30, 2025 at 06:27:51AM +0000, Tian, Kevin wrote:
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> > Sent: Friday, June 27, 2025 11:38 AM
> > 
> > +static void iommufd_device_remove_vdev(struct iommufd_device *idev)
> > +{
> > +	struct iommufd_vdevice *vdev;
> > +
> > +	mutex_lock(&idev->igroup->lock);
> > +	/* vdev has been completely destroyed by userspace */
> > +	if (!idev->vdev)
> > +		goto out_unlock;
> > +
> > +	vdev = iommufd_get_vdevice(idev->ictx, idev->vdev->obj.id);
> > +	if (IS_ERR(vdev)) {
> > +		/*
> > +		 * vdev is removed from xarray by userspace, but is not
> > +		 * destroyed/freed. Since iommufd_vdevice_abort() is
> > reentrant,
> > +		 * safe to destroy vdev here.
> > +		 */
> > +		iommufd_vdevice_abort(&idev->vdev->obj);
> > +		goto out_unlock;
> > +	}
> 
> let's add a comment that vdev is still freed in iommufd_destroy()
> in this situation.

Yes.

> 
> > -void iommufd_vdevice_destroy(struct iommufd_object *obj)
> > +void iommufd_vdevice_abort(struct iommufd_object *obj)
> >  {
> >  	struct iommufd_vdevice *vdev =
> >  		container_of(obj, struct iommufd_vdevice, obj);
> >  	struct iommufd_viommu *viommu = vdev->viommu;
> > +	struct iommufd_device *idev = vdev->idev;
> > +
> > +	lockdep_assert_held(&idev->igroup->lock);
> > +
> > +	/*
> > +	 * iommufd_vdevice_abort() could be reentrant, by
> > +	 * iommufd_device_unbind() or by iommufd_destroy(). Cleanup only
> > once.
> > +	 */
> > +	if (!viommu)
> > +		return;
> 
> Just check idev->vdev, to be consistent with the other path.

I think there is problem here. From your comments above, vdev could be
aborted/destroyed by iommufd_destroy() again *after* idev is freed.
That means in iommufd_vdevice_abort/destroy(), usage of vdev->idev or
idev->vdev or vdev->idev->igroup->lock may be invalid.

I need to reconsider this, seems we need a dedicated vdev lock to
synchronize concurrent vdev abort/destroy.

Thanks,
Yilun

