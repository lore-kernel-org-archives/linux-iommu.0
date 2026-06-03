Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE17A37CD40
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 17:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780508856; cv=none; b=lJDLH+z2tb3DsmAlS0PWyumQXl4Y6REzmgbn4RRlBCSUXZgY0bneR2MX23eW3Q5H/TKDe5jCS3n6LpBwOJycUtAqGJf0ANRFSiBDjeMek0aznRmCoz+7v5j4rTA55pAA90vmXTXx6Ibs6Nwx71GsurFFB6CtpfRLBqahp12U+Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780508856; c=relaxed/simple;
	bh=EFqkePX41bm9unbFa2Nu4IkQs20GcVOGdBLbvdDjApk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JoNg1TsXmzSjK1PpGgL7x3gmvaI1LPodpVdzZ/ZlOlUKpDpSxXU1xP2UKFFXL1RF15knMNavbJFJ9tHkYJxUYcQTGR0aeiRO/H0uZE+NZTT94jmEd87knjogoaOznNxEBBkfWAaPIY6dClbK0kU3kn7nH2rh99SeFzBYbPK5VLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZpJnZ3J2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZpJnZ3J2"
Received: from localhost (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id E9F0520B7169;
	Wed,  3 Jun 2026 10:47:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E9F0520B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780508839;
	bh=52pzwWidZJ79e6tWwRkwjg9Jc9qA9kaGQqyIzuWHhN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZpJnZ3J2XiOGTNC3E+MHSWtJSWQWZfHaXGExk9HIQuWMwIzgMA134+qpdaSbtAqXW
	 8t55vCaSuIWuXx6AJ342oG8bQEYKhxZvHwWtQTupfFJwM9vKlH4TgkRg9dt4c6Qj0Z
	 83q+ojea3t3IuL2zk6JGtdmt8Bj2+h6Mb7dkmXxo=
Date: Wed, 3 Jun 2026 10:47:32 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe
 <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Baolu Lu
 <baolu.lu@linux.intel.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
 "skhawaja@google.com" <skhawaja@google.com>, "pasha.tatashin@soleen.com"
 <pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v7 5/6] vfio: Enable cdev noiommu mode under iommufd
Message-ID: <20260603104732.000000b4@linux.microsoft.com>
In-Reply-To: <DM6PR11MB3690040824703648D2DC0FA98C132@DM6PR11MB3690.namprd11.prod.outlook.com>
References: <20260603054438.2450130-1-jacob.pan@linux.microsoft.com>
	<20260603054438.2450130-6-jacob.pan@linux.microsoft.com>
	<DM6PR11MB3690040824703648D2DC0FA98C132@DM6PR11MB3690.namprd11.prod.outlook.com>
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

On Wed, 3 Jun 2026 06:38:56 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan <jacob.pan@linux.microsoft.com>
> > Sent: Wednesday, June 3, 2026 1:45 PM
> > 
> > 
> > +	if (vfio_device_is_noiommu(device) &&
> > IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU)) {
> > +		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> > +		dev_warn(device->dev,
> > +			 "Adding kernel taint for vfio-noiommu
> > cdev on device\n");
> > +	}
> > +  
> 
> what is "vfio-noiommu cdev on device"? just remove 'on device'?
> 
will do, it was due to literal replacing group with cdev.

> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

