Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0EC33C51A
	for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776120203; cv=none; b=AND5AWjpa8fTsk/ycVKtwES/pk5Y8Hbp55cUjlW+T2XLRqW7WCfDULek9lBCEJRV38HoHj5KzV8rgxFc7hoPoN7qNnmmwA1emZDIqaga9cwaGuY4IaZjG/fFnWhdl4z3aqVKxjaEgVwb1sNLYLCAXszRDhfe6ELiVhXbRc7cpuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776120203; c=relaxed/simple;
	bh=uFZMH/83QRRjaYzwGFL8IrOq9KJCcfTa9NMYG9IZSSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dgA/MoH+yk244Y6D/L+aSnw2SPIU8IAfqWaCtBNSm33tkL+P9AcQiSC+b6O52D49E1FJO0qlFKJ5SHFHL338lZE04DzM5ge3EpMd9PEWqXwwQhUmzCCv88Cu9gDYOybw+0rrjk7udKcFdSqS67uQ5Z2xMvSYv6+hHq0CW6/L+9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZrAyZTvi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZrAyZTvi"
Received: from localhost (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2EDE920B7129;
	Mon, 13 Apr 2026 15:43:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2EDE920B7129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776120200;
	bh=2VYcIkjOqV8vgXd+X6vztTl04zOP4/7CpqjReOMxfLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZrAyZTvibj6DjZ7nyxSRU0jG2IzUvNGLq39TozEXGcXz19fw5ZddPfYJm4mM7DUC8
	 GnFdnqG2USn/1QyytXATJ0WHr6Nog1c/fhPNSyEpsFhWOIP0yCo9ytJDCTPryY+x3I
	 bHKG9Ox8iwjGE5RFh/LNyL11us7IFCs6af5INPzY=
Date: Mon, 13 Apr 2026 15:43:18 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, skhawaja@google.com, pasha.tatashin@soleen.com, Will
 Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>, Jacob Pan
 <jacob.pan@linux.microsoft.com>
Subject: Re: [PATCH V3 07/10] vfio: Enable cdev noiommu mode under iommufd
Message-ID: <20260413154318.000043cf@linux.microsoft.com>
In-Reply-To: <20260409184841.GP3357077@nvidia.com>
References: <20260403051146.10210-1-jacob.pan@linux.microsoft.com>
	<20260403051146.10210-8-jacob.pan@linux.microsoft.com>
	<20260409184841.GP3357077@nvidia.com>
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

On Thu, 9 Apr 2026 15:48:41 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Apr 02, 2026 at 10:11:43PM -0700, Jacob Pan wrote:
> > @@ -392,6 +398,16 @@ void vfio_unregister_group_dev(struct
> > vfio_device *device) bool interrupted = false;
> >  	long rc;
> >  
> > +	/*
> > +	 * For noiommu devices without a container, thus no dummy
> > group,
> > +	 * simply delete and unregister to balance refcount.
> > +	 */
> > +	if (device->noiommu && !vfio_device_has_group(device)) {
> > +		vfio_device_del(device);
> > +		vfio_device_put_registration(device);
> > +		return;
> > +	}
> > +  
> 
> Sashiko points out this can't just skip the waiting even for no-iommu
> mode, it isn't linked to groups and containers but the lifecylce of
> the open FD.
> 
> Maybe just stick a !group inside vfio_device_group_unregister() is
> sufficient?
Yes, will do.

Thanks,

Jacob


