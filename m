Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D712330328
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 23:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778022269; cv=none; b=ggNegcroTHtdMBHwUuUaAg/MkRF0bNNbtdtlZsrTrT85v/PujP3eBXtQ080PB9/lCbLcH6BwL/xMP8vTozwrXQ+DNZZwLZvtnZM/8/oyUoRwjdTO0y84ioKsVTFfn8pqF2Fo0+JZxD7q4QE1N8dsNKUswBoz69PyMwAQk2TzkRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778022269; c=relaxed/simple;
	bh=OUeU7oc1mO1hDAm2B/mcI2FuL/1MLaCoJXTrHPYYtzo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rB3Kogx/QtF7wbm6TEuThjZL7mlRYdDnUR5sMMmfIwcEltSb07QTjj/Pvt2qOGDI1+eTG6j30xL06NgyZ2S6qjw3vZZCQ4JORoBH0Sg75cq3pwDXluhdv7Hg2DtVTYbuM/g7JoacEiubM0S185Rnsr/aWu8PPQUn6z0kZeq1ofo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fHovfvRX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fHovfvRX"
Received: from localhost (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 37E6620B7168;
	Tue,  5 May 2026 16:04:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 37E6620B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778022263;
	bh=EEeOWLeX9BbcuofkiKdNq9JKxvJyc2q3TCJaSJpowGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fHovfvRXroGDvUdmK4odc8av28IrAg2WrsMScHy5tzaV8AUNfEg6+K3bt2HnJAKPG
	 PqLOVw5QIhLJ95Ejd++1gTlXWDKTBiN+4/Sv5b55TMd4f6+6zE2TC6xi3tQRQ2yFex
	 dxVeuUsZBkhwHaXQ+Uvs+19A0EKUBgOl8B0Er5U4=
Date: Tue, 5 May 2026 16:04:24 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe
 <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "skhawaja@google.com" <skhawaja@google.com>, "pasha.tatashin@soleen.com"
 <pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>, Baolu Lu
 <baolu.lu@linux.intel.com>, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH V4 03/10] iommufd: Allow binding to a noiommu device
Message-ID: <20260505160424.00007dca@linux.microsoft.com>
In-Reply-To: <BL1PR11MB5271870197CCDF631EDD00DA8C232@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
	<20260414211412.2729-4-jacob.pan@linux.microsoft.com>
	<BL1PR11MB5271870197CCDF631EDD00DA8C232@BL1PR11MB5271.namprd11.prod.outlook.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Kevin,

On Thu, 16 Apr 2026 07:56:55 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan <jacob.pan@linux.microsoft.com>
> > Sent: Wednesday, April 15, 2026 5:14 AM
> > 
> > +static bool is_vfio_noiommu(struct iommufd_device *idev)
> > +{
> > +	return !device_iommu_mapped(idev->dev) ||
> > !idev->dev->iommu; +}
> > +  
> 
> could you add some words why both conditions are checked? It's not
> obvious to me.
> 
> btw there is no need to add "_vfio_" in the name. 
Actually, I think the first check is not needed. group can be NULL if
no containers selected nor VFIO_GROUP is set.

I will change it to
+/*
+ * A noiommu device has no IOMMU driver attached regardless of whether it
+ * enters via the cdev path (no iommu_group) or the group path (fake
+ * noiommu iommu_group). In both cases dev->iommu is NULL.
+ */
+static bool iommufd_device_is_noiommu(struct iommufd_device *idev)
+{
+       return !idev->dev->iommu;
+}

> 
> > @@ -238,11 +232,11 @@ struct iommufd_device
> > *iommufd_device_bind(struct iommufd_ctx *ictx,
> >  	 * to restore cache coherency.
> >  	 */
> >  	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY))
> > -		return ERR_PTR(-EINVAL);
> > +		return -EINVAL;
> > 
> > -	igroup = iommufd_get_group(ictx, dev);
> > +	igroup = iommufd_get_group(idev->ictx, dev);  
> 
> pointless change.
will fix.

> > +struct iommufd_device *iommufd_device_bind(struct iommufd_ctx
> > *ictx,
> > +					   struct device *dev, u32
> > *id) +{
> > +	struct iommufd_device *idev;
> > +	int rc;
> > +
> >  	idev = iommufd_object_alloc(ictx, idev,
> > IOMMUFD_OBJ_DEVICE);
> > -	if (IS_ERR(idev)) {
> > -		rc = PTR_ERR(idev);
> > -		goto out_release_owner;
> > -	}
> > +	if (IS_ERR(idev))
> > +		return idev;
> > +
> >  	idev->ictx = ictx;
> > -	if (!iommufd_selftest_is_mock_dev(dev))
> > -		iommufd_ctx_get(ictx);
> >  	idev->dev = dev;
> >  	idev->enforce_cache_coherency =
> >  		device_iommu_capable(dev,
> > IOMMU_CAP_ENFORCE_CACHE_COHERENCY);
> > +
> > +	if (!is_vfio_noiommu(idev)) {
> > +		rc = iommufd_bind_iommu(idev);
> > +		if (rc)
> > +			goto err_out;
> > +	} else {
> > +		struct iommufd_group *igroup;
> > +
> > +		/*
> > +		 * Create a dummy igroup, lots of stuff expects
> > ths igroup to be
> > +		 * present, but a NULL igroup->group is OK
> > +		 */
> > +		igroup = iommufd_alloc_group(ictx, NULL);
> > +		if (IS_ERR(igroup)) {
> > +			rc = PTR_ERR(igroup);
> > +			goto err_out;
> > +		}
> > +		idev->igroup = igroup;  
> 
> though simple it's slightly clearer to move them into a wrapper e.g.
> iommufd_bind_dummy_iommu().
will move to a helper:
static int iommufd_bind_noiommu(struct iommufd_device *idev)
{
	struct iommufd_group *igroup;

	igroup = iommufd_alloc_group(idev->ictx, NULL);
	if (IS_ERR(igroup))
		return PTR_ERR(igroup);
	idev->igroup = igroup;
	return 0;
}
> > +	}
> > +
> > +	if (!iommufd_selftest_is_mock_dev(dev))
> > +		iommufd_ctx_get(ictx);  
> 
> better add a comment for the ordering here - this must be done
> here otherwise iommufd_device_destroy() will have a problem
> to handle partial initialization.
> 
will do.

> >  	/* The calling driver is a user until
> > iommufd_device_unbind() */ refcount_inc(&idev->obj.users);
> > -	/* igroup refcount moves into iommufd_device */
> > -	idev->igroup = igroup;  
> 
> this is common, why not leaving it here?
I think it is just easier to assign in each helper function where
igroup is allocated/get.

As you suggested above, iommufd_bind_noiommu(struct iommufd_device
*idev)
