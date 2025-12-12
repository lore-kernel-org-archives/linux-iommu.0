Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B635F2D2388
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765569090; cv=none; b=CHWvFuOMZmk8+P7gbWMrQkGCFUdxwLPYsE7KgaPD/j0AK4we9ovEw3jxjecsvdbOKtyHQ1GsIWSDcUT5v2yAB/+iE5bkHcEwEo3wi4+xVHvZQgwLMQrvfDBVV0Ah67cuq7cieLUhbR7GJhkhylUy6yuO3m14bp4rya9yY8SCFdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765569090; c=relaxed/simple;
	bh=Z4pXEHFHhLYyHkuPci2KxZOu1twbcAiHQuV6GYbUhnA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NuveQqvVDwTOKRSEpDtTIroLkWNnj+pS000k0UC8rCc36YWubO1pEBV+mKvVwuKJfT3pVdkzvVWChbrNj2z2LqrAZRUkP4QoUcaHvn9Vc/06SKhgsEWdM78vP8127mDFFNREd5R0jkC5RyU+czoAaqUGq9H23iniMsrtkkanJQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Lk1HFHFg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Lk1HFHFg"
Received: from localhost (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 27F23211605C;
	Fri, 12 Dec 2025 11:51:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 27F23211605C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765569087;
	bh=0IspfQ012xyAkrBrzvOIj9gxLTF33qEIVNh9ncaQt2A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lk1HFHFgXEFUbbP6aVxUYyKyUZjPKCc/gc8yYCACG3WGZYtiqkYht4IyMy/3wd+QD
	 a2T6HD2kr4IL4pqN+m2r/3xl1RzOM+m63m6SMxolsN496uPXPfLzHfs4Xtn+Kourum
	 tWRlm6p2qkq/JQTg4S4VPFJ4HX4+NSQ3sgtKabdg=
Date: Fri, 12 Dec 2025 11:51:15 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Baolu Lu <baolu.lu@linux.intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Alex Williamson <alex.williamson@redhat.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Nicolin Chen
 <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "skhawaja@google.com" <skhawaja@google.com>, "pasha.tatashin@soleen.com"
 <pasha.tatashin@soleen.com>, Zhang Yu <zhangyu1@linux.microsoft.com>, Jean
 Philippe-Brucker <jean-philippe@linaro.org>, David Matlack
 <dmatlack@google.com>, "Alex Williamson" <alex@shazbot.org>
Subject: Re: [RFC 2/8] iommu: Add a helper to check if any iommu device is
 registered
Message-ID: <20251212115115.00003a38@linux.microsoft.com>
In-Reply-To: <BN9PR11MB5276DAAEF28EEE1CF3B9DD9B8CAEA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
	<20251201173012.18371-3-jacob.pan@linux.microsoft.com>
	<f88707d4-bd04-4e9b-8d4b-ccb679d70dae@linux.intel.com>
	<20251202160635.0000433e@linux.microsoft.com>
	<20251203131129.GD1109247@nvidia.com>
	<20251203143609.00006b72@linux.microsoft.com>
	<0f3dad6d-b320-4d6d-a0b2-8919f3fca5e3@arm.com>
	<20251204140704.000043b1@linux.microsoft.com>
	<BN9PR11MB5276DAAEF28EEE1CF3B9DD9B8CAEA@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On Fri, 12 Dec 2025 04:02:38 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan <jacob.pan@linux.microsoft.com>
> > Sent: Friday, December 5, 2025 6:07 AM
> > 
> > Hi Robin,
> > 
> > On Thu, 4 Dec 2025 10:53:36 +0000
> > Robin Murphy <robin.murphy@arm.com> wrote:
> >   
> > > On 2025-12-03 10:36 pm, Jacob Pan wrote:  
> > > > Hi Jason,
> > > >
> > > > On Wed, 3 Dec 2025 09:11:29 -0400
> > > > Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > >  
> > > >> On Tue, Dec 02, 2025 at 04:06:35PM -0800, Jacob Pan wrote:  
> > > >>> However, as you pointed out there seems to be no standard
> > > >>> ordering for iommu device registration across platforms. e.g.
> > > >>> VT-d hooks up with x86_init, smmuv3 does that in platform
> > > >>> driver probe. This patchset puts dummy driver under
> > > >>> early_initcall which is after both but not a guarantee for
> > > >>> all platforms. Any suggestions?  
> > > >>
> > > >> I think we need to do something more like the sefltest does and
> > > >> manually bind a driver to a device so this init time ordering
> > > >> shouldn't matter.  
> > > > I have moved this dummy iommu driver init under iommufd_init(),
> > > > which aligns well since it runs after all physical IOMMU drivers
> > > > have registered. This dummy driver is intended for iommufd after
> > > > all. But I don't see a need to bind to a platform device as the
> > > > selttest does.  
> > >
> > > There is no "after all physical IOMMU drivers have registered",
> > > there is only "after we've given up waiting to see if one might
> > > be loaded as a module", but even that may be indefinite depending
> > > on build/runtime configuration.  
> > OK, how about we make loading the dummy driver an explicit user
> > opt-in, the same way as
> > /sys/module/iommufd/parameters/allow_unsafe_interrupt?  
> 
> enable_unsafe_noiommu_mode plus cdev already implies that need?
yes, i guess you meant hook up with the existing vfio knob
/sys/module/vfio/parameters/enable_unsafe_noiommu_mode

> 
> > 
> > In addition, make sure once noiommu driver is loaded, no other iommu
> > device can be registered.
> >   
> 
> this is probably the simplest way, e.g. converting below into a helper
> to add that check:
> 
> 	spin_lock(&iommu_device_lock);
> 	list_add_tail(&iommu->list, &iommu_device_list);
> 	spin_unlock(&iommu_device_lock);
> 
> called by all iommu_device_register() variants.
> 
> btw then you may need a new iommu_device_register_noiommu()
> as iommufd selftest has no such exclusiveness requirement.
> 
Yes, looks cleaner this way. iommu_device_register_noiommu() would just
fail if any other iommu devices have registered. There is no need for a
separate helper or check.

> or have a per-bus-type record to ensure each type can be only
> probed by a single driver?
That seems to be a broader change. I think it would work too. Let me
give that a try.

AFAIK, noiommu mode is only tied to PCI (due to vfio). I assume things
will stay this way.

