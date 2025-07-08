Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A6018A6C4
	for <iommu@lists.linux.dev>; Tue,  8 Jul 2025 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964177; cv=none; b=N20QOqau+Pwjv8Why3I8WbRv1reFwsL31rKLh6FyuJuBHXH0pgt+RxxafdwK1Q2+GzpTlG2NfTgnN3f7KCa0JPNiOaEklhkM42D3PQg/6mc5ljkVLgc/DIMfuSeRUHy2naMKRiBgLzFitb8smihcW/jqn0TzPP3fMI/sUO7bx0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964177; c=relaxed/simple;
	bh=3W2W/I5PQ0k88njtcDlNpRAxY+PQLpS+bhmOD8piEcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLHmxW68En+Eqx32X8cH4qbLU312g1ytpGyZuAFxqdNZUEOJdq/Daclqy6oH1mbKbwawASWVufZI9XD0q7fExWSv8KtUz7Rg3w1254lSU7q6ZQ2abvGC0kgcMP/FADnGctIDv5vjV6/x1jD8wFgBBnTNJDFC3a3nlkeS3KPiw0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mx7zYsnL; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mx7zYsnL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751964176; x=1783500176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3W2W/I5PQ0k88njtcDlNpRAxY+PQLpS+bhmOD8piEcc=;
  b=mx7zYsnLnA87j8LLqsayhx7qq+FXYTaqsol4dW9muA+8i46LV8WdU4U7
   XlrQqt53BPQDdbwitqYzMC9nXy8qBL9+t9eaW0bIu2DKWahlqeOwtTWOM
   esLZsqSuOwURZNEBIdKuxiNUEkUyhcgAUAF5QODUnps5V58RR+o+1tDWO
   +XIUiiLDvddCHm+Ag0TbdeL7FiIPjXj+vD32HA207uC9LMXCL1P5z+y4Z
   6D4OIsz5TRSyHMziduoTmtSFa/aAAzR/S1X/vMUoY2m72SIEKH3hSoc2F
   KMRM7O7CeM1B7lbljT2lYsWdB9PVijmtii8/HP2jasi053XAhqnxLTA4/
   g==;
X-CSE-ConnectionGUID: VaJ3fhywQYOEUHp0BQWNOg==
X-CSE-MsgGUID: nev/n+/bQemgNwaXgGPHAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53911978"
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="53911978"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 01:42:56 -0700
X-CSE-ConnectionGUID: 856l2fiJR0yNJyojHfaWLA==
X-CSE-MsgGUID: K3I5cnZkSmGB5o9/Etfl8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="159974860"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa004.jf.intel.com with ESMTP; 08 Jul 2025 01:42:52 -0700
Date: Tue, 8 Jul 2025 16:34:37 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: jgg@nvidia.com, jgg@ziepe.ca, kevin.tian@intel.com, will@kernel.org,
	aneesh.kumar@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	shuah@kernel.org, nicolinc@nvidia.com, aik@amd.com,
	dan.j.williams@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v3 2/5] iommufd: Destroy vdevice on idevice destroy
Message-ID: <aGzYHR0+/mjufmUQ@yilunxu-OptiPlex-7050>
References: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
 <20250627033809.1730752-3-yilun.xu@linux.intel.com>
 <b5b84208-e43c-483e-838b-c42375d3bada@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5b84208-e43c-483e-838b-c42375d3bada@linux.intel.com>

> > -void iommufd_vdevice_destroy(struct iommufd_object *obj)
> > +void iommufd_vdevice_abort(struct iommufd_object *obj)
> >   {
> >   	struct iommufd_vdevice *vdev =
> >   		container_of(obj, struct iommufd_vdevice, obj);
> >   	struct iommufd_viommu *viommu = vdev->viommu;
> > +	struct iommufd_device *idev = vdev->idev;
> > +
> > +	lockdep_assert_held(&idev->igroup->lock);
> > +
> > +	/*
> > +	 * iommufd_vdevice_abort() could be reentrant, by
> > +	 * iommufd_device_unbind() or by iommufd_destroy(). Cleanup only once.
> > +	 */
> > +	if (!viommu)
> > +		return;
> >   	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
> >   	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
> >   	refcount_dec(&viommu->obj.users);
> >   	put_device(vdev->dev);
> > +	vdev->viommu = NULL;
> > +	idev->vdev = NULL;
> 
> I feel it makes more sense to reorder the operations like this:
> 
> 	vdev->viommu = NULL;
> 	vdev->idev = NULL;
> 	idev->vdev = NULL;
> 	put_device(vdev->dev);
> 
> put_device(vdev->dev) could potentially trigger other code paths that
> might attempt to reference vdev or its associated pointers. Therefore,
> it's safer to null all the relevant reference pointers before calling
> put_device().

Yep. due to other changes, now I keep:

        xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
        refcount_dec(&viommu->obj.users);
+       idev->vdev = NULL;
        put_device(vdev->dev);

Anyway, vdev->dev would be completely dropped in next patch, so it
doesn't matter much.

Thanks,
Yilun

> 
> Others look good to me,
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Thanks,
> baolu
