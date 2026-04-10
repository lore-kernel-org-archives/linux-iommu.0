Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F21340DAB
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 23:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775862597; cv=none; b=mxyqFGnAMEwmn4QfdMvjuyzWRd9qk0wCQvjzbHKkPb9UOatzjysEQ9LpOa3n5AkXqIxWn8Cn0rCP8Um9s30MsEZYotyyGOeWspAroAtwkSntmTcZS4rbHAUb1+jXG/ZdPKaCG0BH99S0mixrFpdsA2tshNbYZe3PvH5Dwhm8Coo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775862597; c=relaxed/simple;
	bh=CHI9CoEVnzYc9SDcTIOZU+I6cyxnZD8pBs58WGT/g/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MI4LlTpEP3Ma3iHk7yYV9qwynmIdruuP5ZHOORvoQQcv2HwkfOukWPrwPahlzKmBJH4qoLsdqJRFzINHnzDzmidV8edljrYVAIiDyh+Wc/fgoYWRFkv0Ay8K0PxQVooXASJimztYy2daWcHzwK9ytZAKBdChkqrLhWC44ctcWus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LbC0J3dT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LbC0J3dT"
Received: from localhost (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 93C2720B710C;
	Fri, 10 Apr 2026 16:09:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 93C2720B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775862595;
	bh=3YNtmbW71P1ACKfBXJ2Ts4/oHFQvToQsIqWaGm4Pc3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LbC0J3dTBPFaKJWy7NGVT2jUrlHg5rcgN6gxw8d3oITfluVRLl9vpoxyrnCThW1lz
	 oIBUnsPbL1ezuNC4UXyLHRNxr2G78Zj4J0hNtmFq2pXf2DD4t6HKrN6GPz8MRGKOzH
	 On+Kyn17v575GDMS61CTakOIVIONctAKnUO/oYd0=
Date: Fri, 10 Apr 2026 16:09:53 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, skhawaja@google.com, pasha.tatashin@soleen.com, Will
 Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V3 05/10] vfio: Allow null group for noiommu without
 containers
Message-ID: <20260410160953.000020e5@linux.microsoft.com>
In-Reply-To: <20260409184416.GO3357077@nvidia.com>
References: <20260403051146.10210-1-jacob.pan@linux.microsoft.com>
	<20260403051146.10210-6-jacob.pan@linux.microsoft.com>
	<20260409184416.GO3357077@nvidia.com>
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

On Thu, 9 Apr 2026 15:44:16 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Apr 02, 2026 at 10:11:41PM -0700, Jacob Pan wrote:
> 
> > @@ -598,6 +604,14 @@ static struct vfio_group
> > *vfio_noiommu_group_alloc(struct device *dev, struct vfio_group
> > *group; int ret;
> >  
> > +	/*
> > +	 * With noiommu enabled under cdev interface only, there
> > is no need to
> > +	 * create a vfio_group if the group based containers are
> > not enabled.
> > +	 * The cdev interface is exclusively used for iommufd.
> > +	 */
> > +	if (vfio_null_group_allowed())
> > +		return NULL;  
> 
> Sashiko wondered if this causes a null pointer deref without pointing
> at a specific case. Claude found a case:
> 
> @@ -696,6 +696,9 @@ void vfio_device_remove_group(struct vfio_device
> *device) struct vfio_group *group = device->group;
>         struct iommu_group *iommu_group;
>  
> +       if (!group)
> +               return;
> +
>         if (group->type == VFIO_NO_IOMMU || group->type ==
> VFIO_EMULATED_IOMMU) iommu_group_remove_device(device->dev);
> 
> Happens during error unwind in __vfio_register_dev()
will do.  

> It also points out that the hunks are weirdly split between this patch
> and "vfio: Enable cdev noiommu mode under iommufd" so that things are
> broken at this point.
> 
> I think you should pull the vfio_device_has_group() and related into
> this patch.
> 
makes sense, will regroup.

