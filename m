Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F38224B15
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 19:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765569196; cv=none; b=LB0Obzhug2UVZSrVV9zt0nvbaTy8vEko6Y8ga0WMnWNZl1QXQbPJK8Bq1I89jRvoQOij2JSqrEcZLffah0xaoAJhtsaVzYXeTc77MmT2HI77NaJ4niHoQCIrBW5jOqgy4YFT7oEEo3Zj9Fx0s93u2cS2X4dpJN4mIEZpt7YA/jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765569196; c=relaxed/simple;
	bh=S7GG2tBDK1zvsluAseX4lUfT+qPYPy1V/H/3B3c98JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PeFbOOPVb6qKT4fpGRazxWk49BE5Z5G4daxNcY8t0qifZhmRCoh1LeGWA6jmASQPLEZI1U48W6/6M1ewZ4Bl2KuU2xBQK3KHrRDs6sWnt1uBpYusPiDXd+AHAt02+9VOIhGfw609vBD18PFUe9qwREyJE/gVNm+yblGuf58/cfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VYp+jhTq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VYp+jhTq"
Received: from localhost (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 06DD4211605C;
	Fri, 12 Dec 2025 11:53:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 06DD4211605C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765569194;
	bh=WoKhq8qkf5U58Ikz7dEP2j1lBagMH3Z/AikvQmCB0eo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VYp+jhTqoKALREJBAw4MLdAjixsuT1ruf45tP7IkIv3eJRE05C9aDdrWOCKnlzmxZ
	 LH+hs2JEFBXqmf7TIF7iLIphemQOXjLX2sVG7ZZkmjRtOVjpbokZEx/7Usx8JHEf3o
	 csU5MFmYhmegx68/1bAjrEqKRM8OUrFK8DhjYUy8=
Date: Fri, 12 Dec 2025 11:53:05 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe
 <jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>, Joerg
 Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "skhawaja@google.com" <skhawaja@google.com>,
 "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>, Zhang Yu
 <zhangyu1@linux.microsoft.com>, "Jean Philippe-Brucker"
 <jean-philippe@linaro.org>, David Matlack <dmatlack@google.com>
Subject: Re: [RFC 5/8] vfio: IOMMUFD relax requirement for noiommu mode
Message-ID: <20251212115305.00003b52@linux.microsoft.com>
In-Reply-To: <BN9PR11MB5276070DF6AF7A94446417028CAEA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
	<20251201173012.18371-6-jacob.pan@linux.microsoft.com>
	<BN9PR11MB5276070DF6AF7A94446417028CAEA@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On Fri, 12 Dec 2025 04:05:06 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan <jacob.pan@linux.microsoft.com>
> > Sent: Tuesday, December 2, 2025 1:30 AM
> > 
> > noiommu device only has auto domain, does not need to attach to
> > other ioas.
> > 
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > ---
> >  drivers/vfio/vfio_main.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> > index 38c8e9350a60..805d30b0b82f 100644
> > --- a/drivers/vfio/vfio_main.c
> > +++ b/drivers/vfio/vfio_main.c
> > @@ -317,9 +317,7 @@ static int __vfio_register_dev(struct
> > vfio_device *device,
> > 
> >  	if (WARN_ON(IS_ENABLED(CONFIG_IOMMUFD) &&
> >  		    (!device->ops->bind_iommufd ||
> > -		     !device->ops->unbind_iommufd ||
> > -		     !device->ops->attach_ioas ||
> > -		     !device->ops->detach_ioas)))
> > +		     !device->ops->unbind_iommufd)))
> >  		return -EINVAL;
> >   
> 
> the subject says to relax for noiommu, but above actually relax
> the check for all configs...

I will add a check here for noiommu mode.

Thanks,

Jacob
