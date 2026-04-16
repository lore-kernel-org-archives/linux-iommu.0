Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F273B2AA
	for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776375206; cv=none; b=EFPHP4UAZxaBKF1xGbhwOobW6+0SkzQBdBJ0uGPJ9oGNO9sHJN8MbEUv8nKwznNL481I6PeBrkt1dnS5bii9GCX7VhK3PheQjzFmFuwa6202UXYVaTtJfAKydu/FGqkX1ESra6MwCgKBeCU/EKSmfISr2sB1U8moj/dvZQnylZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776375206; c=relaxed/simple;
	bh=Qr09HvR/WKJlMA7e9vGsszQsr1eTliucpG8tOhZ48wI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eygRUG5A/LmVup+rrX/6WfcmAf4A0OSlK90mckY9cb+WDxHW9avf7TKbtAUNgqeAUeB/YOXVTeY0BLjJygO3ncpIr67aaZiAp8KvCcb1Sm2odMYt/0vyojZrF9niA2Rzjo/NFSamdn6Aauq0fRr45ANAZ+aFuka/V8MJCCYBcZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Gl2C1Usd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Gl2C1Usd"
Received: from localhost (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1337C20B7128;
	Thu, 16 Apr 2026 14:33:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1337C20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776375205;
	bh=s+oz0opCUnLZ+FkoRRgYT4H2hgOWB5oojjTDYMU55mM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gl2C1Usdr1/6gHrZKQVFjfKBhsgBCNgg0xiZeHFXcbv8cNLysL2vwtsVWsRV/BTwE
	 2RMFRFfXF9yD4BK8z3s7cUqvShSTq/lTOAj+4ImysCxNQF9dyljIc3YQ+hrbkIyWAs
	 Gwwq2U5XaSo1aE+Nw9x02sD9zpZcmZVXzBfIzaqU=
Date: Thu, 16 Apr 2026 14:33:21 -0700
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
 <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V4 05/10] vfio: Allow null group for noiommu without
 containers
Message-ID: <20260416143321.00006ef9@linux.microsoft.com>
In-Reply-To: <BL1PR11MB527147EF03B2CD4F76BC40518C232@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
	<20260414211412.2729-6-jacob.pan@linux.microsoft.com>
	<BL1PR11MB527147EF03B2CD4F76BC40518C232@BL1PR11MB5271.namprd11.prod.outlook.com>
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

On Thu, 16 Apr 2026 08:13:22 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan <jacob.pan@linux.microsoft.com>
> > Sent: Wednesday, April 15, 2026 5:14 AM
> > 
> > +/*
> > + * With noiommu enabled and no containers are supported, allow
> > devices that
> > + * don't have a dummy group.
> > + */
> > +static inline bool vfio_null_group_allowed(void)
> > +{
> > +	if (vfio_noiommu && (!IS_ENABLED(CONFIG_VFIO_CONTAINER)
> > && !IS_ENABLED(CONFIG_IOMMUFD_VFIO_CONTAINER)))
> > +		return true;
> > +
> > +	return false;
> > +}  
> 
> 'allow' kind of implies a policy choice, but throughput this patch
> it's actually a mandatory state when those conditions are true. Can we
> strengthen the words here and other places to not given an impression
> that even when null group is allowed it's still possible to create a
> vfio group for that situation?
> 
> Just like another comment said, iommufd is the only choice in this
> case, then probably could call it vfio_has_iommufd_group()?
Indeed this condition is not an option. I am ok with either
vfio_has_iommufd_group() or directly name what is being checked
vfio_noiommu_no_container()

> > 
> > @@ -392,6 +396,16 @@ void vfio_unregister_group_dev(struct
> > vfio_device *device)
> >  	bool interrupted = false;
> >  	long rc;
> > 
> > +	/*
> > +	 * For noiommu devices without a container, thus no dummy
> > group,
> > +	 * simply delete and unregister to balance refcount.
> > +	 */
> > +	if (!vfio_device_has_group(device)) {
> > +		vfio_device_del(device);
> > +		vfio_device_put_registration(device);
> > +		return;
> > +	}
> > +
> >  	/*  
> 
> can you elaborate why the following wait loop is also skipped? then
> above is removed by patch7 later...
My mistake, will delete this from both patches.

Thanks for catching this.

Jacob
