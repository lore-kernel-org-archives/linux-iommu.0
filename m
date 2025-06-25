Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E1329B22A
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846425; cv=none; b=J9vRlFzqf/1OWhmzQxcr8b7rmdV8mtbwdBreqi70n/p7LSFRV+MJmbjarqKQeiXtyCv4qcfouk5IB3yIySNsEHoA7lbzt0aCLcPYRvdA0VdMz6Ung4g4eWhA1kCvANSt3QfkuDLBxR1SDaXAkK2nHLRgbBoNK9dn5KEx8eJMpRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846425; c=relaxed/simple;
	bh=La7GgC9uIfvzuyiHzJNM4y+6GPHrM0tMUJEgqMvWOLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQVgJLAf1MuywU6VPg++NWB7rMDNKfvaQMHcddA01owFlyEocZ0LtK7LcSU0KSkLkd84pUGr3vMgV61LEh2H3E47t7qbI0PB4h9phOmob0/wCKB1WCy9+EGt8Bv9Vc+sgnfyDL8ulJGVrKdtTQfvTidI1Cvu8BvSs19QsNN7Jc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RhvAFWiT; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RhvAFWiT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750846423; x=1782382423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=La7GgC9uIfvzuyiHzJNM4y+6GPHrM0tMUJEgqMvWOLY=;
  b=RhvAFWiTGWbazt3360/+Y9d4ZzoPIQXJA3pXCEgbxcGAigqKHmBMkg1s
   /ZJodJLK8Ejv119dxm8B9BJWP+20gR7I3/nWhWpE1bj0nuAuwwe/g3us2
   uDi5lUUfJdNEJs2KwBc5307qMtBId9LnIw6lZtmOoOgm0MmJu23X93sTl
   VCH9rD5YLX/lrIn1bqwBt+gk67j4jCnl1zBcHqqwb2MDmQJa6mnCrt2et
   pKIMQ7GbLWzmWURA9e8slMkmCDWlW0swdO6JrOeBQH2Kxem5UGXjwI4ML
   9bQWR6/F4D732Uu2gDdosHbzHosdCsdM6i5Uqyh2wqfC9SjCs49TiQLLZ
   g==;
X-CSE-ConnectionGUID: Q6BuwpZ0TyCfZaOMupOtew==
X-CSE-MsgGUID: Xk40C/QvTkeFknZ66mIsVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="64467647"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="64467647"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 03:13:42 -0700
X-CSE-ConnectionGUID: 1DnGF/pASteKc/ORLLwOyA==
X-CSE-MsgGUID: /l0bhpQvToinaTLv9HEU4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="156572481"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 25 Jun 2025 03:13:37 -0700
Date: Wed, 25 Jun 2025 18:06:00 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, aneesh.kumar@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, shuah@kernel.org,
	nicolinc@nvidia.com, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v2 3/4] iommufd: Destroy vdevice on idevice destroy
Message-ID: <aFvKCEt6FadGtYr+@yilunxu-OptiPlex-7050>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
 <20250623094946.1714996-4-yilun.xu@linux.intel.com>
 <20250624145346.GC150753@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624145346.GC150753@nvidia.com>

On Tue, Jun 24, 2025 at 11:53:46AM -0300, Jason Gunthorpe wrote:
> On Mon, Jun 23, 2025 at 05:49:45PM +0800, Xu Yilun wrote:
> > +static void iommufd_device_remove_vdev(struct iommufd_device *idev)
> > +{
> > +	bool vdev_removing = false;
> > +
> > +	mutex_lock(&idev->igroup->lock);
> > +	if (idev->vdev) {
> > +		struct iommufd_vdevice *vdev;
> > +
> > +		vdev = iommufd_get_vdevice(idev->ictx, idev->vdev->obj.id);
> > +		if (IS_ERR(vdev)) {
> 
> This incrs obj.users which will cause a concurrent
> iommufd_object_remove() to fail with -EBUSY, which we are trying to
> avoid.

I have the same question as Kevin, leave this to that thread.

[...]

> 	/*
> 	 * We don't know what thread is actually going to destroy the vdev, but
> 	 * once the vdev is destroyed the pointer is NULL'd. At this
> 	 * point idev->users is 0 so no other thread can set a new vdev.
> 	 */
> 	if (!wait_event_timeout(idev->ictx->destroy_wait,
> 				!READ_ONCE(idev->vdev),
> 				msecs_to_jiffies(60000)))
> 		pr_crit("Time out waiting for iommufd vdevice removed\n");
> }
> 
> Though there is a cleaner option here, you could do:
> 
> 	mutex_lock(&idev->igroup->lock);
> 	if (idev->vdev)
> 		iommufd_vdevice_abort(&idev->vdev->obj);
> 	mutex_unlock(&idev->igroup->lock);
> 
> And make it safe to call abort twice, eg by setting dev to NULL and
> checking for that. First thread to get to the igroup lock, either via
> iommufd_vdevice_destroy() or via the above will do the actual abort
> synchronously without any wait_event_timeout. That seems better??

I'm good to both options, but slightly tend not to make vdevice so
special from other objects, so still prefer the wait_event option.

> 
> > +	/* vdev can't outlive idev, vdev->idev is always valid, need no refcnt */
> > +	vdev->idev = idev;
> 
> So this means a soon as 'idev->vdev = NULL;' happens idev is an
> invalid pointer. Need a WRITE_ONCE there.
> 
> I would rephrase the comment as 
>  iommufd_device_destroy() waits until idev->vdev is NULL before
>  freeing the idev, which only happens once the vdev is finished
>  destruction. Thus we do not need refcounting on either idev->vdev or
>  vdev->idev.
> 
> and group both assignments together.

Good to me.

Thanks,
Yilun
