Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CED3C9EE4
	for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 23:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777592465; cv=none; b=bTVsYCqrfYappMdzpM4X8ufdn6Rd4/Oe03SnElTleeIJtVSICvkvSZtW/97IijVn6/p742K/5CVV+vQElhVIPCf7AcUgr1TjrGn4kuolcNippQfsvsb8pnrjHrKC1fJpCGgk+uYYb9upMsk1e5c4BdxoxzzPYe9A2jdiVBo+qNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777592465; c=relaxed/simple;
	bh=oXGlyYq26zAUg+QOiDBlsMh3M/LGv4pGaoR3U7Li1rk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFL5v5xGouKbAe6H2ORnBDNg8BAG3KWGOwOoQsps99MMSiGb5bW4+iMDjMOLA6PZ4zjxOeR6jaQzCLnf9ivRfwN4szSq4//Vnh/g3dyckkjQ5qZAwF5tKaHgxzrZRtlYBRyqWFFG35la3Is0jXUyh+nwkAlx1tsmIM3y9MKWs/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=K/pvlMRE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="K/pvlMRE"
Received: from localhost (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6162720B7165;
	Thu, 30 Apr 2026 16:41:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6162720B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777592463;
	bh=UeeKqZf6rhrR6DVgGnHAKAW/5bc/aqK6o1Q3qiPH7Ic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K/pvlMREAqEcX1RE5bbDCJbVNwoLF0u2izzC5GG0gVNuM7ZI+bkdSAMRsVhefeVCg
	 +yziMgpX0TTk4PKyuhKQgou0f5eln2qDkcDiDj5QwEu19elinLgbZ/BmA6FudQ8zMO
	 TFO/9qrH678iHhJGazvr/ByrtHsqP/PjKbktbO0g=
Date: Thu, 30 Apr 2026 16:41:01 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
 <smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
 <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, <skhawaja@google.com>, <pasha.tatashin@soleen.com>,
 Will Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH V4 10/10] Documentation: Update VFIO NOIOMMU mode
Message-ID: <20260430164101.000039c8@linux.microsoft.com>
In-Reply-To: <b82b7f9e-befe-4a45-b242-6d6df0e70bd4@intel.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
	<20260414211412.2729-11-jacob.pan@linux.microsoft.com>
	<b82b7f9e-befe-4a45-b242-6d6df0e70bd4@intel.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Yi,

On Tue, 28 Apr 2026 15:46:02 +0800
Yi Liu <yi.l.liu@intel.com> wrote:

> On 4/15/26 05:14, Jacob Pan wrote:
> > Document the NOIOMMU mode with newly added cdev support under
> > iommufd.
> >=20
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > ---
> >   Documentation/driver-api/vfio.rst | 45
> > +++++++++++++++++++++++++++++-- 1 file changed, 43 insertions(+), 2
> > deletions(-)
> >=20
> > diff --git a/Documentation/driver-api/vfio.rst
> > b/Documentation/driver-api/vfio.rst index
> > 2a21a42c9386..da6f77414c3b 100644 ---
> > a/Documentation/driver-api/vfio.rst +++
> > b/Documentation/driver-api/vfio.rst @@ -275,8 +275,6 @@ in a VFIO
> > group. With CONFIG_VFIO_DEVICE_CDEV=3Dy the user can now acquire a
> > device fd by directly opening a character device
> > /dev/vfio/devices/vfioX where "X" is the number allocated uniquely
> > by VFIO for registered devices. -cdev interface does not support
> > noiommu devices, so user should use -the legacy group interface if
> > noiommu is wanted.=20
> >   The cdev only works with IOMMUFD.  Both VFIO drivers and
> > applications must adapt to the new cdev security model which
> > requires using @@ -370,6 +368,49 @@ IOMMUFD IOAS/HWPT to enable
> > userspace DMA::=20
> >   	/* Other device operations as stated in "VFIO Usage
> > Example" */=20
> > +VFIO NOIOMMU mode
> > +----------------------------------------------------------------------=
---------
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
> > +
> > +The capabilities vary depending on the device programming
> > interface and kernel +configuration used. The following table
> > summarizes the differences: +
> > ++-------------------+---------------------+----------------------+
> > +| Feature           | VFIO group          | VFIO device cdev     |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > +| VFIO device UAPI  | Yes                 | Yes                  |
> > ++-------------------+---------------------+----------------------+
> > +| VFIO container    | No                  | No                   |
> > ++-------------------+---------------------+----------------------+
> > +| IOMMUFD IOAS      | No                  | Yes*                 |
> > ++-------------------+---------------------+----------------------+
> > +
> > +Note that the VFIO container case includes IOMMUFD provided VFIO
> > compatibility +interfaces when either CONFIG_VFIO_CONTAINER or
> > CONFIG_IOMMUFD_VFIO_CONTAINER is +enabled.
> > +
> > +* IOMMUFD UAPI is available for VFIO device cdev to pin and map
> > user memory with
> > +  the ability to retrieve physical addresses for DMA command
> > submission. +
> > +A new IOMMUFD ioctl IOMMU_IOAS_GET_PA is added to retrieve the
> > physical address +for a given user virtual address. Note that
> > IOMMU_IOAS_MAP_FIXED_IOVA flag is +ignored in no-IOMMU mode since
> > there is no physical DMA remapping hardware. =20
>=20
> not quite get this. Does it mean the the iova field is not used when
> invoking IOMMU_IOAS_MAP ioctl? Hence the iova will be allocated by
> iommufd and returned to userspace? Also, how does kernel know it
> should ignore IOMMU_IOAS_MAP_FIXED_IOVA flag?
>=20

Good question. Let me clarify =E2=80=94 I should reword this in the cover l=
etter.

The IOMMU_IOAS_MAP_FIXED_IOVA flag is NOT silently ignored by the kernel.
Userspace can still pass it as with normal IOMMU mode, otherwise
IOPT_ALLOC_IOVA kicks in and IOMMUFD allocates an IOVA from the allowed
range.

What I meant is that in no-IOMMU mode, the IOVA itself has no physical
significance =E2=80=94 there is no DMA remapping hardware programming the
IOVA=E2=86=92PA translation. The IOVA is simply used as a key in the softwa=
re
IO page table (IOMMU_PT_AMDV1 backed) to track the pinned pages and
their physical addresses.

So from the userspace API perspective, the flow is identical:

  1. IOMMU_IOAS_MAP with FIXED_IOVA flag and user VA =E2=86=92 pins pages,
  stores PA in the SW page table at the given IOVA
  2. IOMMU_IOAS_GET_PA with that IOVA =E2=86=92 returns the physical address
  for DMA command submission

The kernel doesn't need special logic to "know" it should ignore
anything =E2=80=94 the same iopt_map code path runs; it's just that the
backing domain is iommufd_noiommu_ops (a software page table) rather
than a hardware IOMMU domain.

The user is assumed to know how to use the special IOVA as the unsafe
noiommu mode is enabled by the user.

I'll fix the misleading wording in the next version.
