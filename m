Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235B23C8723
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294393; cv=none; b=SqJfn2MHY7oRvUTVZFXr1Y+iE6oM3KPzS8S3V5NArfHpAxuqclEiCBQeq1nVOqpuifplVLHyX9HCYBK3mS34uDC6EB/zYHq+PUO3y8lRnsYaGpy/6owe4/YTelCHxMaLDVCMe1R+b5vAtFphPYnZ/dmMIt76Zq4bTyUkLTdjPIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294393; c=relaxed/simple;
	bh=ySimN5oyA5V9fGsuaxQ7nfJoaAhy8Ac77HkroBZSY/U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eIVmttSXIRstTdFIuxe3YrISvrhKDysCQ9hRS1fO6L/EGiR/T8ZvKuGYST0bY4LEtGHvQf9r+3f/WIaum/31pxMJdsgSA81xdDQfJQ/56xFhxP4SOaU07SHk+C59ALZkAO1DG8w4MN0OxrmRke6Jccood33oygGrJJsCV69Xr5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ReZQWk/Y; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ReZQWk/Y"
Received: from localhost (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id 566B820B7167;
	Wed, 20 May 2026 09:26:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 566B820B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779294384;
	bh=plhr38dide6W3O0lMP1T8Cwc0CHwNQ59/setgQoDvSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ReZQWk/YS6sh1GXr2CJ1dgzCZqkY6dhtvCgt1Ahs4SgxYDY4vEbijpvwQq8ruM0A9
	 jN7yDUbiqDY6Z5lB8lsM9/8t8sNBzjV3VkmSNQwAbTtytUpnbJ0GDP4zskda2daHsc
	 U+XGwlZZqIM99eeeIYBLkyEXLuvrLDIHvPkxYpCM=
Date: Wed, 20 May 2026 09:26:29 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
 <smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
 <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
 <skhawaja@google.com>, <pasha.tatashin@soleen.com>, Will Deacon
 <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v5 9/9] Documentation: Update VFIO NOIOMMU mode
Message-ID: <20260520092629.000053df@linux.microsoft.com>
In-Reply-To: <19f8ef7f-2935-45e9-8139-4d7030629f49@intel.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
	<20260511184116.3687392-10-jacob.pan@linux.microsoft.com>
	<19f8ef7f-2935-45e9-8139-4d7030629f49@intel.com>
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

Hi Yi,

On Wed, 20 May 2026 15:20:30 +0800
Yi Liu <yi.l.liu@intel.com> wrote:

> On 5/12/26 02:41, Jacob Pan wrote:
> > Document the NOIOMMU mode with newly added cdev support under
> > iommufd.
> > 
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > ---
> >   Documentation/driver-api/vfio.rst | 46
> > +++++++++++++++++++++++++++++-- 1 file changed, 44 insertions(+), 2
> > deletions(-)
> > 
> > diff --git a/Documentation/driver-api/vfio.rst
> > b/Documentation/driver-api/vfio.rst index
> > 2a21a42c9386..d97017d80b98 100644 ---
> > a/Documentation/driver-api/vfio.rst +++
> > b/Documentation/driver-api/vfio.rst @@ -275,8 +275,6 @@ in a VFIO
> > group. With CONFIG_VFIO_DEVICE_CDEV=y the user can now acquire a
> > device fd by directly opening a character device
> > /dev/vfio/devices/vfioX where "X" is the number allocated uniquely
> > by VFIO for registered devices. -cdev interface does not support
> > noiommu devices, so user should use -the legacy group interface if
> > noiommu is wanted. 
> >   The cdev only works with IOMMUFD.  Both VFIO drivers and
> > applications must adapt to the new cdev security model which
> > requires using @@ -370,6 +368,50 @@ IOMMUFD IOAS/HWPT to enable
> > userspace DMA:: 
> >   	/* Other device operations as stated in "VFIO Usage
> > Example" */ 
> > +VFIO NOIOMMU mode
> > +-------------------------------------------------------------------------------
> > +VFIO also supports a no-IOMMU mode, intended for usages where
> > unsafe DMA can +be performed by userspace drivers w/o physical
> > IOMMU protection. This mode +is controlled by the parameter:
> > +
> > +/sys/module/vfio/parameters/enable_unsafe_noiommu_mode
> > +
> > +Upon enabling this mode, with an assigned device, the user will be
> > presented +with a VFIO group and device file, e.g.::
> > +
> > +  /dev/vfio/
> > +  |-- devices
> > +  |   `-- noiommu-vfio0	/* VFIO device cdev */
> > +  |-- noiommu-0		/* VFIO group */
> > +  `-- vfio  
> 
> how about noiommu-vfioX and noiommu-Y? Just want to deliver the
> message that the two number is not 100% identical.
> 
good point.

> > +The capabilities vary depending on the device programming
> > interface and kernel +configuration used. The following table
> > summarizes the differences: +
> > ++-------------------+---------------------+----------------------+
> > +| Feature           | VFIO group          | VFIO device cdev     |
> > ++===================+=====================+======================+
> > +| VFIO device UAPI  | Yes                 | Yes                  |
> > ++-------------------+---------------------+----------------------+
> > +| VFIO container    | No                  | No                   |
> > ++-------------------+---------------------+----------------------+
> > +| IOMMUFD IOAS      | No                  | Yes*                 |
> > ++-------------------+---------------------+----------------------+
> > +  
> 
> not quite the above table. Why 'VFIO container' is "No" for VFIO
> group?
> 
I meant VFIO group interface has no access to VFIO container UAPIs,
such as DMA MAP/UNMAP.

how about I will add the following:

 The capabilities vary depending on the device programming interface and kernel
-configuration used. The following table summarizes the differences:
+configuration used. The following table summarizes the differences ("Yes" means
+the UAPI is accessible and functional in noiommu mode, "No" means the UAPI is
+not supported):

> > +Note that the VFIO container case includes IOMMUFD provided VFIO
> > compatibility +interfaces when either CONFIG_VFIO_CONTAINER or
> > CONFIG_IOMMUFD_VFIO_CONTAINER is +enabled.
> > +
> > +* IOMMUFD UAPI is available for VFIO device cdev to pin and map
> > user memory with
> > +  the ability to retrieve physical addresses for DMA command
> > submission. +
> > +A new IOMMUFD ioctl IOMMU_IOAS_NOIOMMU_GET_PA is added to retrieve
> > the physical +address for a given IOVA. Although there is no
> > physical DMA remapping hardware, +IOMMU_IOAS_MAP_FIXED_IOVA is
> > still used to establish IOVA-to-PA mappings in the +software page
> > table for later IOMMU_IOAS_NOIOMMU_GET_PA lookups.
> > +tools/testing/selftests/vfio/vfio_iommufd_noiommu_test.c provides
> > an example of +using this ioctl in no-IOMMU mode. +
> >   VFIO User API
> >   -------------------------------------------------------------------------------
> >     

