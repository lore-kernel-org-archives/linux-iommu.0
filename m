Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2BA1531E8
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 06:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752646671; cv=none; b=gYuk+HCwmWrIMjx0M0fd2YahGuC+Yi8paTnF8tV5UC6K+JhliYDC4LmJt+a0+J2RuavEnSdZtO4VSzbk2mTOfaNKx5E7OenmTmVvlx0Lq+D6NrVoaklOztnA1MBJPRR4YE6BNFIWkDPP8nBp9h7+UOBbnZ4/W5+ePi++FiHMjME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752646671; c=relaxed/simple;
	bh=wkOZJPyJqrbsm0LYBqzhTXhmaX0v8cwgBhlqzwwUj+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udIIunZQhnrg9+Dt9jNKTfBNl2nfEZ1ubbwUKAtZ5KQe/FCg0LLM1FhEERk/iRygfg1/e9eqvFv6rJUNq/MqVJGoRyRNtykyE+oOUiK2oMqGrdiHQ2dj+cahPadHt0o8RXNNah7d9ifs9FhWN6p0Mgsl7UG01EoOXrpZKaeOW5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WnzNeD8H; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WnzNeD8H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752646669; x=1784182669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wkOZJPyJqrbsm0LYBqzhTXhmaX0v8cwgBhlqzwwUj+c=;
  b=WnzNeD8HDuYrsQW8S2/nvjN0QGJaEBNjKgL7PR1lKEKlq/dPVbhRL8H3
   urYjCUjTMqdNBksAvQ1qZuC99rnugAENHyA/9mvK3CndHGLAC8vcXGo2M
   4aSrmCJA+EhdrWSLi7dfjsv6ftTyAQcEQP6SQn+7ZUN3cEA88puy7sJxc
   jLUkcIebQqd0MaZ9AJRZm6vugOb9F4+7ETXjhO2BBGpNCol6CKI/D1HRd
   Sx3IZJTrXMIsfjxqxCK5Ua0ZMiIh7gClcAyODtxRGo36aKuEzW27jNjiW
   2ro/b/HiAJcQBCPFNx1b4ncprnfP53/QS9Z0YNEd99LQq19CTvd/xySNl
   Q==;
X-CSE-ConnectionGUID: Ih0o2hVaTGGy8o2Ed/OAFg==
X-CSE-MsgGUID: roZi0Nz2Sb6F15b5Y36NIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54753492"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="54753492"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 23:17:49 -0700
X-CSE-ConnectionGUID: C3yVr/VMTj+ACgs7tEJc6Q==
X-CSE-MsgGUID: kTHRzzaCQTCPQcpw/x1fLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="161436760"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 15 Jul 2025 23:17:45 -0700
Date: Wed, 16 Jul 2025 14:09:07 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, jgg@ziepe.ca, kevin.tian@intel.com, will@kernel.org,
	aneesh.kumar@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	shuah@kernel.org, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v5 5/8] iommufd/vdevice: Remove struct device reference
 from struct vdevice
Message-ID: <aHdCAznEunT1Kcej@yilunxu-OptiPlex-7050>
References: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
 <20250715063245.1799534-6-yilun.xu@linux.intel.com>
 <aHakX0SzQ9/EX3AT@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHakX0SzQ9/EX3AT@Asurada-Nvidia>

On Tue, Jul 15, 2025 at 11:56:31AM -0700, Nicolin Chen wrote:
> On Tue, Jul 15, 2025 at 02:32:42PM +0800, Xu Yilun wrote:
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> > index eb90af5093d8..8a515987b948 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> > @@ -1218,7 +1218,7 @@ static void tegra241_vintf_destroy_vsid(struct iommufd_vdevice *vdev)
> >  
> >  static int tegra241_vintf_init_vsid(struct iommufd_vdevice *vdev)
> >  {
> > -	struct arm_smmu_master *master = dev_iommu_priv_get(vdev->dev);
> > +	struct arm_smmu_master *master = dev_iommu_priv_get(vdev->idev->dev);
> 
> Hmm, this breaks :(
> 
> drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c: In function 'tegra241_vintf_init_vsid':
> drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:1230:71: error: invalid use of undefined type 'struct iommufd_device'
>  1230 |         struct arm_smmu_master *master = dev_iommu_priv_get(vdev->idev->dev);
> 
> Unfortunately the iommufd_device structure is defined in the
> private header that's not shared with any IOMMU driver.
> 
> So, we need in the driver.c a new helper that converts a vdev
> pointer to dev. Something like:
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> index ff6bbd2137146..fd6b083535271 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> @@ -1227,7 +1227,8 @@ static void tegra241_vintf_destroy_vsid(struct iommufd_vdevice *vdev)
>  
>  static int tegra241_vintf_init_vsid(struct iommufd_vdevice *vdev)
>  {
> -	struct arm_smmu_master *master = dev_iommu_priv_get(vdev->idev->dev);
> +	struct device *dev = iommufd_vdevice_to_device(vdev);
> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>  	struct tegra241_vintf *vintf = viommu_to_vintf(vdev->viommu);
>  	struct tegra241_vintf_sid *vsid = vdev_to_vsid(vdev);
>  	struct arm_smmu_stream *stream = &master->streams[0];
> diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
> index df25db6d2eafc..6f1010da221c9 100644
> --- a/drivers/iommu/iommufd/driver.c
> +++ b/drivers/iommu/iommufd/driver.c
> @@ -83,6 +83,12 @@ void _iommufd_destroy_mmap(struct iommufd_ctx *ictx,
>  }
>  EXPORT_SYMBOL_NS_GPL(_iommufd_destroy_mmap, "IOMMUFD");
>  
> +struct device *iommufd_vdevice_to_device(struct iommufd_vdevice *vdev)
> +{
> +	return vdev->idev->dev;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_vdevice_to_device, "IOMMUFD");
> +
>  /* Caller should xa_lock(&viommu->vdevs) to protect the return value */
>  struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
>  				       unsigned long vdev_id)
> @@ -92,7 +98,7 @@ struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
>  	lockdep_assert_held(&viommu->vdevs.xa_lock);
>  
>  	vdev = xa_load(&viommu->vdevs, vdev_id);
> -	return vdev ? vdev->idev->dev : NULL;
> +	return vdev ? iommufd_vdevice_to_device(vdev) : NULL;
>  }
>  EXPORT_SYMBOL_NS_GPL(iommufd_viommu_find_dev, "IOMMUFD");
>  
> @@ -109,7 +115,7 @@ int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
>  
>  	xa_lock(&viommu->vdevs);
>  	xa_for_each(&viommu->vdevs, index, vdev) {
> -		if (vdev->idev->dev == dev) {
> +		if (iommufd_vdevice_to_device(vdev) == dev) {
>  			*vdev_id = vdev->virt_id;
>  			rc = 0;
>  			break;
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index 61410a78cbce7..ee88e90021870 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -266,6 +266,7 @@ int _iommufd_alloc_mmap(struct iommufd_ctx *ictx, struct iommufd_object *owner,
>  			unsigned long *offset);
>  void _iommufd_destroy_mmap(struct iommufd_ctx *ictx,
>  			   struct iommufd_object *owner, unsigned long offset);
> +struct device *iommufd_vdevice_to_device(struct iommufd_vdevice *vdev);
>  struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
>  				       unsigned long vdev_id);
>  int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
> @@ -300,6 +301,12 @@ static inline void _iommufd_destroy_mmap(struct iommufd_ctx *ictx,
>  {
>  }
>  
> +static inline struct device *
> +iommufd_vdevice_to_device(struct iommufd_vdevice *vdev)
> +{
> +	return ERR_PTR(-ENODEV);

I prefer return NULL, which is consistent with iommufd_viommu_find_dev().

Others good to me, and thanks for your fixing.

> +}
> +
>  static inline struct device *
>  iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
>  {
> 
