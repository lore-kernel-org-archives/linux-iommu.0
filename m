Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DC63DE44D
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775839875; cv=none; b=p6ynotjI+mFH1cShrCE3WVHD3ijbukeXyueJPRnbBZwmjPC16zZT0yPD+1oa+ZzTzujiA+Jc9tExmEY89P1/u/Qt1pDfa+1AEVrsvmZCLJ+f44lBwkOrED/Gvlc4XnDdzRQxN/xgrLaWEiAWTeHwbeydDPXqqupH9T40LT1TqAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775839875; c=relaxed/simple;
	bh=K4YKxR435vjV3a9hQfXcImKV+g+MUGe/BvdNgRcJixY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jY1e6Jrp7befCicMQeuYDudHyWehY0rY2g1hUXzXcaPNmGtJyiGQU5kr1LOMvRiqkIfj4eQSuptYVdQA3VEw4QAPM3gMtK5LqnNGocosDrzDsIsv/7T7MBo02WYJSdUEF0fRIni5TC6iZP0fb5TLXWHr1Aqp2OVuH8gY/jVa7C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WMYN+DXi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WMYN+DXi"
Received: from localhost (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id DB0F220B710C;
	Fri, 10 Apr 2026 09:51:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DB0F220B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775839870;
	bh=rdaut57OSPBJt/B8jKMqxOStWeQz7715GCEYdz9sGUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WMYN+DXieGD7J/5AtEAz49OoBmB6Gp/CX+UpXICr+TBZ/gLC1QuEXFK99oSLhuKMT
	 Jdm+ZcjtPa26N1oASkVWHLsh+N853H4yCCvjRMYIpMgze7WbzS5Gla+1Xzqp3UICqP
	 1fS8Mi2wSmZ8yuHz//Z7xBqsR0vnlZKdZrm90ftw=
Date: Fri, 10 Apr 2026 09:51:08 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, skhawaja@google.com, pasha.tatashin@soleen.com, Will
 Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V3 03/10] iommufd: Allow binding to a noiommu device
Message-ID: <20260410095108.000006a0@linux.microsoft.com>
In-Reply-To: <20260409170657.GM3357077@nvidia.com>
References: <20260403051146.10210-1-jacob.pan@linux.microsoft.com>
	<20260403051146.10210-4-jacob.pan@linux.microsoft.com>
	<20260409170657.GM3357077@nvidia.com>
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

Hi Jason,

On Thu, 9 Apr 2026 14:06:57 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Apr 02, 2026 at 10:11:39PM -0700, Jacob Pan wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > Allow iommufd to bind devices without an IOMMU (noiommu mode) by
> > creating a dummy IOMMU group for such devices and skipping hwpt
> > operations.
> > 
> > This enables noiommu devices to operate through the same iommufd
> > API as IOMMU- capable devices.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > 
> > ---
> > v3:
> >    - handle new error cases iommufd_device_bind. (Mostafa)
> > ---
> >  drivers/iommu/iommufd/device.c | 126
> > +++++++++++++++++++++++---------- 1 file changed, 87 insertions(+),
> > 39 deletions(-)  
> 
> 
> > @@ -294,11 +334,10 @@ struct iommufd_device
> > *iommufd_device_bind(struct iommufd_ctx *ictx, *id = idev->obj.id;
> >  	return idev;
> >  
> > -out_release_owner:
> > -	iommu_device_release_dma_owner(dev);
> > -out_group_put:
> > -	iommufd_put_group(igroup);
> > +err_out:
> > +	iommufd_object_abort_and_destroy(ictx, &idev->obj);
> >  	return ERR_PTR(rc);  
> 
> I fed this to Sashiko and it pointed out the abort flow here will call
> iommufd_device_destroy() bit it isn't prepared to handle a partially
> initialized idev. It looks like igroup is only set once it is
> sufficiently initialized so:
> 
> @@ -211,6 +211,8 @@ void iommufd_device_destroy(struct iommufd_object
> *obj) struct iommufd_device *idev =
>                 container_of(obj, struct iommufd_device, obj);
>  
> +       if (!idev->igroup)
> +               return;
>         if (!is_vfio_noiommu(idev))
>                 iommu_device_release_dma_owner(idev->dev);
>         iommufd_put_group(idev->igroup);
> 
> Should fix it, but lets add a comment because it is pretty fragile:
> 
> @@ -335,6 +337,10 @@ struct iommufd_device
> *iommufd_device_bind(struct iommufd_ctx *ictx, return idev;
>  
>  err_out:
> +       /*
> +        * Be careful that iommufd_device_destroy() can handle partial
> +        * initialization.
> +        */
>         iommufd_object_abort_and_destroy(ictx, &idev->obj);
>         return ERR_PTR(rc);
Yeah, will add to the next version.

Tested the error path by faking a failed group allocation, works as
expected.
#  RUN           vfio_noiommu.device_bind_iommufd ...
vfio_iommufd_noiommu_test.c:265:device_bind_iommufd:Expected 0 )
# device_bind_iommufd: Test terminated by assertion
#          FAIL  vfio_noiommu.device_bind_iommufd
not ok 17 vfio_noiommu.device_bind_iommufd


