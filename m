Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9721D7E41
	for <iommu@lists.linux.dev>; Sat, 23 May 2026 22:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779573716; cv=none; b=hqRhpjLTCkEtlIMkGn7LrLaueDBQOxo2SjKMXNuJ02L+RHtpAfLWoG/qXQqbb+G9D+7XY6A0zdXLOsfbracDYxp1x77X2eqaX2N21UCZVJd0JNVUSSzKz1MLZU/NMFx35UhUoxrMs+RR1N75xtPs+wGjUb6rVXLSkCSSGM5v1UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779573716; c=relaxed/simple;
	bh=CtfS/vgeKB1jvBsBXPRHb/71HZL28V0H2lM3orPzmc0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i6YVV6LYaWy32A4PlszuhyZH/MOlyJp1oxYhtvbn/MJXd/6JVgRuZFxi+C5b3s+LiAiO599AuD3ftiU4Qb6Xvwx3GeQNvf+PO3n1WvyyIFZf8oo6OotKWulqVWwHviQzIuSbC+k9wbKPpEe4Vpk3q8XoJ1gCDgFJ9CpXgc3//FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aHahoZDE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aHahoZDE"
Received: from localhost (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7FA8220B7167;
	Sat, 23 May 2026 15:01:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7FA8220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779573700;
	bh=/DHrDcqKKvcnAhqm1QVmHGM/TdJ/A0nS85tQjBIzCFs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aHahoZDEALx+tf+PAW6S6FbQqPCtItC0QDdbqSvUVv8dubsY6P2JP8ZkGi9knFsa2
	 fycAGx0xxfjha6gtz0AIEl3AYapsUigzHRrw4pxGaQrVZ765Y6IfNUDiUP9qgLCDIP
	 7qPRqIJvB0YDHCy10A1gJIZapWMkwJhm2O6IHzIk=
Date: Sat, 23 May 2026 15:01:47 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
 <smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
 <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>, <skhawaja@google.com>,
 <pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v6 5/7] vfio: Enable cdev noiommu mode under iommufd
Message-ID: <20260523150147.00001c38@linux.microsoft.com>
In-Reply-To: <e431af3d-b19a-45d2-a58d-e400d43141f0@intel.com>
References: <20260521221155.1375144-1-jacob.pan@linux.microsoft.com>
	<20260521221155.1375144-6-jacob.pan@linux.microsoft.com>
	<e431af3d-b19a-45d2-a58d-e400d43141f0@intel.com>
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

On Fri, 22 May 2026 17:19:41 +0800
Yi Liu <yi.l.liu@intel.com> wrote:

> On 5/22/26 06:11, Jacob Pan wrote:
> > Now that devices under noiommu mode can bind with IOMMUFD and
> > perform IOAS operations, lift restrictions on cdev from VFIO side.
> > Use cases are documented in Documentation/driver-api/vfio.rst
> >=20
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > ---
> > v6:
> >    - Revert back to unified VFIO_NOIOMMU Kconfig for both cdev and
> > group. Use Kconfig dependency to restrict usages and avoid null
> > group checks. (Alex & Yi)
> >    - Add CAP_SYS_RAWIO checks for cdev open to maintain security
> > parity with the group noiommu path. (Alex)
> > v5:
> >     - Add Kconfig VFIO_CDEV_NOIOMMU to select IOMMUFD_NOIOMMU
> >       and its dependencies
> >     - Add comment to explain vfio_noiommu conditional definition
> > (Alex)
> >     - Removed early return for group noiommu in bind/unbind
> >     - Use consistent wording referring to VFIO noiommu mode (Kevin)
> >     - Update unsafe_noiommu Kconfig help text (Kevin)
> >     - Change dev_warn to dev_info for noiommu enabling msg (Kevin)
> > v4:
> >     - Remove early return in iommufd_bind for noiommu (Alex)
> > v3:
> >     - Consolidate into fewer patches
> > v2:
> >     - removed unnecessary device->noiommu set in
> >       iommufd_vfio_compat_ioas_get_id()
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > ---
> >   drivers/vfio/Kconfig       |  8 +++++---
> >   drivers/vfio/device_cdev.c |  3 +++
> >   drivers/vfio/iommufd.c     |  6 +++---
> >   drivers/vfio/vfio.h        | 20 +++++++++++++-------
> >   drivers/vfio/vfio_main.c   | 23 +++++++++++++++++++----
> >   include/linux/vfio.h       |  1 +
> >   6 files changed, 44 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> > index ceae52fd7586..d3d8fef2855c 100644
> > --- a/drivers/vfio/Kconfig
> > +++ b/drivers/vfio/Kconfig
> > @@ -22,8 +22,7 @@ config VFIO_DEVICE_CDEV
> >   	  The VFIO device cdev is another way for userspace to
> > get device access. Userspace gets device fd by opening device cdev
> > under /dev/vfio/devices/vfioX, and then bind the device fd with an
> > iommufd
> > -	  to set up secure DMA context for device access.  This
> > interface does
> > -	  not support noiommu.
> > +	  to set up secure DMA context for device access. =20
>=20
> if noiommu, it's unsafe DMA. :)
yes, here I just want to remove "This interface does not support
noiommu.".
>=20
> >   	  If you don't know what to do here, say N.
> >  =20
> > @@ -62,7 +61,10 @@ endif
> >  =20
> >   config VFIO_NOIOMMU
> >   	bool "VFIO No-IOMMU support"
> > -	depends on VFIO_GROUP
> > +	depends on VFIO_GROUP || VFIO_DEVICE_CDEV
> > +	depends on !VFIO_GROUP || VFIO_CONTAINER ||
> > IOMMUFD_VFIO_CONTAINER
> > +	depends on !VFIO_DEVICE_CDEV || !GENERIC_ATOMIC64
> > +	select IOMMUFD_NOIOMMU if VFIO_DEVICE_CDEV
> >   	help
> >   	  VFIO is built on the ability to isolate devices using
> > the IOMMU. Only with an IOMMU can userspace access to DMA capable
> > devices be diff --git a/drivers/vfio/device_cdev.c
> > b/drivers/vfio/device_cdev.c index 54abf312cf04..4e2c1e4fc1f8 100644
> > --- a/drivers/vfio/device_cdev.c
> > +++ b/drivers/vfio/device_cdev.c
> > @@ -27,6 +27,9 @@ int vfio_device_fops_cdev_open(struct inode
> > *inode, struct file *filep) struct vfio_device_file *df;
> >   	int ret;
> >  =20
> > +	if (device->noiommu && !capable(CAP_SYS_RAWIO))
> > +		return -EPERM;
> > +
> >   	/* Paired with the put in vfio_device_fops_release() */
> >   	if (!vfio_device_try_get_registration(device))
> >   		return -ENODEV;
> > diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
> > index a38d262c6028..d4f2e2a0f2f3 100644
> > --- a/drivers/vfio/iommufd.c
> > +++ b/drivers/vfio/iommufd.c
> > @@ -25,8 +25,8 @@ int vfio_df_iommufd_bind(struct vfio_device_file
> > *df)=20
> >   	lockdep_assert_held(&vdev->dev_set->lock);
> >  =20
> > -	/* Returns 0 to permit device opening under noiommu mode */
> > -	if (vfio_device_is_noiommu(vdev))
> > +	/* Group noiommu via iommufd compat needs no device
> > binding */
> > +	if (df->group && vfio_device_is_noiommu(vdev)) =20
>=20
> seems like vfio_device_is_noiommu() implies group path, then no need
> to use df->group.
>=20
df->group is needed because only the legacy VFIO group/iommufd-compat
noiommu path should skip real iommufd device binding.

For df->group =3D=3D NULL, the fd is a VFIO cdev fd. That path uses
VFIO_DEVICE_BIND_IOMMUFD and later VFIO_DEVICE_ATTACH_IOMMUFD_PT. Even
in noiommu cdev mode, bind must still call:

 vdev->ops->bind_iommufd(vdev, ictx, &df->devid);

so vdev->iommufd_device can get initialized. If the check were only:

 if (vfio_device_is_noiommu(vdev))
        return 0;
then cdev noiommu bind would falsely =E2=80=9Csucceed=E2=80=9D without sett=
ing
vdev->iommufd_device. Later VFIO_DEVICE_ATTACH_IOMMUFD_PT calls
vfio_iommufd_physical_attach_ioas(), hits:

 if (WARN_ON(!vdev->iommufd_device))
        return -EINVAL;

In the noiommu test, you will get:
  185.870670] ------------[ cut here ]------------
[  185.871952] WARNING: drivers/vfio/iommufd.c:157 at
vfio_iommufd_physical_attach_ioas+0x3f/0x50, CPU#0:
vfio-noiommu-pc/157[  185.875010] Modules linked in:[  185.875882] CPU:
0 UID: 0 PID: 157 Comm: vfio-noiommu-pc Tainted: G     U  W
7.1.0-rc1+ #20 PREEMPT[  185.878637] Tainted: [U]=3DUSER, [W]=3DWARN[
185.879711] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014[  185.882913]
RIP: 0010:vfio_iommufd_physical_attach_ioas+0x3f/0x50[  185.884624]
Code: 89 f2 31 f6 f6 83 50 04 00 00 01 75 16 e8 d9 aa c6 ff 85 c0 75 07
80 8b 50 04 00 00 01 5b c3 cc cc cc cc e8 43 ab c6 ff eb e8 <0f> 0b
b80[  185.889701] RSP: 0018:ffa000000062fd88 EFLAGS: 00010246[
185.891161] RAX: ffffffff81f59ee0 RBX: ff1100010c43b800 RCX:
0000000000000000[  185.893141] RDX: ff1100010c708040 RSI:
ffa000000062fda0 RDI: 0000000000000000[  185.895127] RBP:
ff1100010c43b800 R08: ff1100010c7c12b0 R09: 0000000000000000[
185.897119] R10: 0000000000000000 R11: 0000000000000000 R12:
00007ffec4c2f720[  185.899102] R13: ffa000000062fda0 R14:
ff11000103bd40d0 R15: ff1100010c43b800[  185.901075] FS:
0000000028d69380(0000) GS:ff110004e4a8d000(0000)
knlGS:0000000000000000[  185.903284] CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033[  185.904888] CR2: 0000000028d73988 CR3:
0000000103507002 CR4: 0000000000f73ef0[  185.906853] PKRU: 55555554[
185.907636] Call Trace:[  185.908373]  <TASK>[  185.908932]
vfio_df_ioctl_attach_pt+0xc7/0x170[  185.910085]
vfio_device_fops_unl_ioctl+0x49b/0xa50[  185.911322]  ?
file_tty_write.isra.0+0x202/0x320[  185.912507]
__x64_sys_ioctl+0x425/0xa30[  185.913502]  do_syscall_64+0x5e/0xf80[
185.914444]  ? irqentry_exit+0x3b/0x5e0[  185.915414]
entry_SYSCALL_64_after_hwframe+0x76/0x7e[  185.916701] RIP:
0033:0x434a4d[  185.917498] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0
48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8
10 00 00 00 0f 05 <89> c2 3d0[  185.922052] RSP: 002b:00007ffec4c2f6b0
EFLAGS: 00000246 ORIG_RAX: 0000000000000010[  185.923785] RAX:
ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000434a4d[
185.925398] RDX: 00007ffec4c2f720 RSI: 0000000000003b77 RDI:
0000000000000004[  185.927007] RBP: 00007ffec4c2f700 R08:
0000000000000064 R09: 0000000000000000[  185.928611] R10:
0000000000000000 R11: 0000000000000246 R12: 00007ffec4c30918[
185.930211] R13: 00007ffec4c30940 R14: 00000000004cf868 R15:
0000000000000001[  185.931758]  </TASK>[  185.932258] ---[ end trace
0000000000000000 ]---Failed to attach pt to device

> static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
> {
>      return IS_ENABLED(CONFIG_VFIO_NOIOMMU) &&
>             vdev->group->type =3D=3D VFIO_NO_IOMMU;
> }
>=20
> >   		return 0;
> >  =20
> >   	return vdev->ops->bind_iommufd(vdev, ictx, &df->devid);
> > @@ -58,7 +58,7 @@ void vfio_df_iommufd_unbind(struct
> > vfio_device_file *df)=20
> >   	lockdep_assert_held(&vdev->dev_set->lock);
> >  =20
> > -	if (vfio_device_is_noiommu(vdev))
> > +	if (df->group && vfio_device_is_noiommu(vdev))
> >   		return;
> >  =20
> >   	if (vdev->ops->unbind_iommufd)
> > diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> > index e4b72e79b7e3..6f0a2dfc8a00 100644
> > --- a/drivers/vfio/vfio.h
> > +++ b/drivers/vfio/vfio.h
> > @@ -358,19 +358,13 @@ void vfio_init_device_cdev(struct vfio_device
> > *device);=20
> >   static inline int vfio_device_add(struct vfio_device *device)
> >   {
> > -	/* cdev does not support noiommu device */
> > -	if (vfio_device_is_noiommu(device))
> > -		return device_add(&device->device);
> >   	vfio_init_device_cdev(device);
> >   	return cdev_device_add(&device->cdev, &device->device);
> >   }
> >  =20
> >   static inline void vfio_device_del(struct vfio_device *device)
> >   {
> > -	if (vfio_device_is_noiommu(device))
> > -		device_del(&device->device);
> > -	else
> > -		cdev_device_del(&device->cdev, &device->device);
> > +	cdev_device_del(&device->cdev, &device->device);
> >   }
> >  =20
> >   int vfio_device_fops_cdev_open(struct inode *inode, struct file
> > *filep); @@ -420,6 +414,18 @@ static inline void
> > vfio_cdev_cleanup(void) }
> >   #endif /* CONFIG_VFIO_DEVICE_CDEV */
> >  =20
> > +#if IS_ENABLED(CONFIG_VFIO_NOIOMMU)
> > +static inline bool vfio_device_is_cdev_noiommu(struct vfio_device
> > *vdev) +{
> > +	return vdev->noiommu;
> > +}
> > +#else
> > +static inline bool vfio_device_is_cdev_noiommu(struct vfio_device
> > *vdev) +{
> > +	return false;
> > +}
> > +#endif
> > +
> >   #if IS_ENABLED(CONFIG_VFIO_VIRQFD)
> >   int __init vfio_virqfd_init(void);
> >   void vfio_virqfd_exit(void);
> > diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> > index 6222376ab6ab..84381c500623 100644
> > --- a/drivers/vfio/vfio_main.c
> > +++ b/drivers/vfio/vfio_main.c
> > @@ -321,6 +321,20 @@ static int vfio_init_device(struct vfio_device
> > *device, struct device *dev, return ret;
> >   }
> >  =20
> > +static int vfio_device_set_noiommu_and_name(struct vfio_device
> > *device) +{
> > +	if (IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV) && vfio_noiommu &&
> > !device->dev->iommu) {
> > +		device->noiommu =3D true;
> > +		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> > +		dev_warn(device->dev,
> > +			 "Adding kernel taint for vfio-noiommu
> > cdev on device\n");
> > +	}
> > +
> > +	/* Just to be safe, expose to user explicitly noiommu cdev
> > node */
> > +	return dev_set_name(&device->device, "%svfio%d",
> > +		     device->noiommu ? "noiommu-" : "",
> > device->index); +}
> > +
> >   static int __vfio_register_dev(struct vfio_device *device,
> >   			       enum vfio_group_type type)
> >   {
> > @@ -340,20 +354,21 @@ static int __vfio_register_dev(struct
> > vfio_device *device, if (!device->dev_set)
> >   		vfio_assign_device_set(device, device);
> >  =20
> > -	ret =3D dev_set_name(&device->device, "vfio%d",
> > device->index);
> > +	ret =3D vfio_device_set_group(device, type);
> >   	if (ret)
> >   		return ret;
> >  =20
> > -	ret =3D vfio_device_set_group(device, type);
> > +	ret =3D vfio_device_set_noiommu_and_name(device); =20
>=20
> the order of dev_set_name and vfio_device_set_group() are swapped, any
> special reason?
The ordering was intentional in an earlier version where the cdev
noiommu check depended on device->group. With the current check using
!device->dev->iommu, the ordering is no longer strictly required for
that test.
=20
I kept vfio_device_set_group() first because the rest of registration
already treats group setup as the first VFIO state to unwind, and this
lets the existing err_out path handle failures after group assignment,
including dev_set_name(). I can restore the old order if you prefer,
since it is not functionally required anymore.

> >   	if (ret)
> > -		return ret;
> > +		goto err_out;
> >  =20
> >   	/*
> >   	 * VFIO always sets IOMMU_CACHE because we offer no way
> > for userspace to
> >   	 * restore cache coherency. It has to be checked here
> > because it is only
> >   	 * valid for cases where we are using iommu groups.
> >   	 */
> > -	if (type =3D=3D VFIO_IOMMU && !vfio_device_is_noiommu(device)
> > &&
> > +	if (type =3D=3D VFIO_IOMMU && !(vfio_device_is_noiommu(device)
> > ||
> > +
> > vfio_device_is_cdev_noiommu(device)) && =20
>=20
> now, the group path and cdev path have their own is_noiommu helper,
> can the two helpers be consolidated?
>=20
They could be consolidated mechanically, but I feel they are checking
different things it is more clear to keep them separate?

> >   	    !device_iommu_capable(device->dev,
> > IOMMU_CAP_CACHE_COHERENCY)) { ret =3D -EINVAL;
> >   		goto err_out;
> > diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> > index 31b826efba00..45f08986359e 100644
> > --- a/include/linux/vfio.h
> > +++ b/include/linux/vfio.h
> > @@ -74,6 +74,7 @@ struct vfio_device {
> >   	u8 iommufd_attached:1;
> >   #endif
> >   	u8 cdev_opened:1;
> > +	u8 noiommu:1;
> >   	/*
> >   	 * debug_root is a static property of the vfio_device
> >   	 * which must be set prior to registering the
> > vfio_device. =20

