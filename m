Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3653298261
	for <iommu@lists.linux.dev>; Tue,  8 Jul 2025 08:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962843; cv=none; b=nJWM8OEhdKpwPfqTaT+GvyxPJOAjdrr7iUVhSTFRQcEopsE7oWScNixmXevgV1afD68o4Nkk8dN+GI5EyOkilN70T03ucSFO9JN0oru+VSHZskpTES6Qwa6M5YAQcmuFmKWRLjFkIBZPFQEjCy6hin3alptmutrLDEyJcZkXwUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962843; c=relaxed/simple;
	bh=nlwrLtl03wZynLrI5W8nM8lCn/KPdVjQrbS6ywj+uns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWNsvHIJZ7noy3clN/9GyuPHrLlMRb0lZLI+0ylxUcnpy5WBqgbEDF46Up40Ed6GznR7XrT5C6gZMPNo67p8730tKg5cgdo7Zwa3S096eoshkdRpjYn02RMarNCosv4CZR4MEUzeDEcSNKO3/pm6nMcar/GcCjSU7gIX+OSr9Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eOjT9l8u; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eOjT9l8u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751962841; x=1783498841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nlwrLtl03wZynLrI5W8nM8lCn/KPdVjQrbS6ywj+uns=;
  b=eOjT9l8uHGGBlzAl126R3npX4xMzZ3DBUNt7zEhl/pq0+SaSz1JKVHS/
   lFiz6qETEOMNM//muzuTYDfpiUQiBeavQ0CJU/JJnw6NHr+HMDAvuf76F
   Y3XVJ/1fV3WJ3IG99tGa5MHWH9HA51tVP57D0egwYHzWggOT8zjo0uSJX
   aFkfhPKe2f1RnqpbgtbUpnNrOoQ1Am9uXnSwkzOSr4m5BnSxvxDJQrx51
   aEw5DauZgwsH5oeLLRjmqi0Uj4qiCW0tzmM01uM4jpnjbtyFa7bjnHWNO
   eE0uEo20W1XV3uPad0mk/BJIJZ0jcQlAZcgfnwMxHRhnYO07kb7bjyjIZ
   Q==;
X-CSE-ConnectionGUID: Ogmut8wORgK0O4ciq3F1mg==
X-CSE-MsgGUID: tOR1PFJ9RKOl+w9w+Xboww==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="56804498"
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="56804498"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 01:20:40 -0700
X-CSE-ConnectionGUID: rfOLo3+WQk6TEMPo1o8iAw==
X-CSE-MsgGUID: 4ZhITdttTuSc2poDAMha4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="186392208"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 08 Jul 2025 01:20:36 -0700
Date: Tue, 8 Jul 2025 16:12:23 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, jgg@ziepe.ca, kevin.tian@intel.com, will@kernel.org,
	aneesh.kumar@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	shuah@kernel.org, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v3 2/5] iommufd: Destroy vdevice on idevice destroy
Message-ID: <aGzS57bGWtg8BpEU@yilunxu-OptiPlex-7050>
References: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
 <20250627033809.1730752-3-yilun.xu@linux.intel.com>
 <aGLmq8D88mN5lkmN@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGLmq8D88mN5lkmN@Asurada-Nvidia>

On Mon, Jun 30, 2025 at 12:34:03PM -0700, Nicolin Chen wrote:
> On Fri, Jun 27, 2025 at 11:38:06AM +0800, Xu Yilun wrote:
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
> > +		 * destroyed/freed. Since iommufd_vdevice_abort() is reentrant,
> > +		 * safe to destroy vdev here.
> > +		 */
> > +		iommufd_vdevice_abort(&idev->vdev->obj);
> > +		goto out_unlock;
> 
> This is the case #3, i.e. a racing vdev destory, in the commit log?
> 
> I think it is worth clarifying that there is a concurrent destroy:
> 		/*
> 		 * An ongoing vdev destroy ioctl has removed the vdev from the
> 		 * object xarray but has not finished iommufd_vdevice_destroy()
> 		 * yet, as it is holding the same mutex.

Applied this part.

>		 * Destroy the vdev here,
> 		 * i.e. the iommufd_vdevice_destroy() will be a NOP once it is
> 		 * unlocked.
> 		 */
> 
> > @@ -147,10 +183,12 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
> >  	if (rc)
> >  		goto out_abort;
> >  	iommufd_object_finalize(ucmd->ictx, &vdev->obj);
> > -	goto out_put_idev;
> > +	goto out_unlock_igroup;
> >  
> >  out_abort:
> >  	iommufd_object_abort_and_destroy(ucmd->ictx, &vdev->obj);
> > +out_unlock_igroup:
> > +	mutex_unlock(&idev->igroup->lock);
> 
> Looks like we will have to partially revert the _ucmd allocator,
> in this function:
> https://lore.kernel.org/all/107b24a3b791091bb09c92ffb0081c56c413b26d.1749882255.git.nicolinc@nvidia.com/
> 
> Please try fixing the conflicts on top of Jason's for-next tree.

Yes, will rebase for next version.

Thanks,
Yilun

> 
> Thanks
> Nicolin
