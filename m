Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F0236DA0D
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 03:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779248782; cv=none; b=THJ+uCQgCaXfFl53vxeR5BF6KLrnJtyfEw1bS3MPwaSRAb1y1vh3fTpZQIgys8WscEfXCobB7AHKn7nbnut7uF0W8eWyUgmJN0qz1joe/gPEeNmQcAkIhWvAOU5Jnixex+2+Cht6HuYEahQJ/Tban4xRBkppV8+XWB+iHehia08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779248782; c=relaxed/simple;
	bh=kx3N/sF136lHAXv30jB/koQH8AcEEfY2J3ecwUrx7WA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4uvy8a1tffmhUOPGdm/cq+NyhTw9pdVjkgrHacY/JTq8e1jK5HcbvemTNE387ANSr1TPZIaxKsVrXSHdqAOF2lk37PZRajiy0kqugVyp64o8bL9X3Zn3ARkd7Mi/V4MNBcCjaJ6ejH1pR/ejk3nsCuCmEwA1jhkahFt03idfhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=kH7hzUAY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tII8+cmo; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="kH7hzUAY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tII8+cmo"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 821C91D000E6;
	Tue, 19 May 2026 23:46:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 19 May 2026 23:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779248775;
	 x=1779335175; bh=rMONDyfWciVe1ovXFzWpVrWYtQU7cLauCfv1EYgZ4XI=; b=
	kH7hzUAYJnopikyamKANNplXYyuy1g1QjE8HKCvFb0LefKxWB8XCATEi99VlSXDc
	6eesbtoPpJfJDXc+pAiz7rlZgWYAFvy0nhQ56+l2cRr2FfH2sWP/gOnBzOscOKIK
	0nfLGTNeptiLtm3eUpcS0+lzRtkyTiSijYmXo9gSRUYjR8jCdFCQCYcYC1y1RdfT
	1Gdvoxn4Fe5msUVzvzAjk3k+34yKmeGJ3kWuzHfgkKnOmeQsCR+uPVdS/QPgxckz
	1NdKRe6GTD4cFentt+8S5q7/0M9V0ttMm+DJHpr+kUYjRIPnlpTgN614edCh7f5G
	nOjC9d+0atjVjEQ/q8ZIHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779248775; x=
	1779335175; bh=rMONDyfWciVe1ovXFzWpVrWYtQU7cLauCfv1EYgZ4XI=; b=t
	II8+cmoz0nTffDwJ6Y0y3f+xEVgN5Goz0H0PFT/EVCj3KC41OAHTiOmCft2a0Jxd
	XEHSzM+QwU2J3XoyZZmk9VbXK8p/li2dP5VYk41B2sh0MlhlSmqnl8qYSThycBMJ
	gbW7y1N6WrTczF8/DF4/UxheBy2fpmqAJ10D9VgDZyIcHOLHqrNFhWwjkLeiL//8
	FCqnwXWTCBM5prz/znoJUxjTDBSd5li9nWj/RSKrN9vTpp3D4YEPId8aIutniMWK
	PIIEVB4sdhzDmp5Nm+Imn+1fl7+MiqQaRthHl48MYQyG5hvQuRK9cpt2dUCeJDKX
	A28wTfOxgVKuGX/gMeTwQ==
X-ME-Sender: <xms:hy4NaixeH7vnUKlEl2JFSxOo83-iDfFbw72OYle07QTn1ZcEoN1fmQ>
    <xme:hy4Navw8aJatLyRuimarPjeTq4KDr6nYn2Jmxf-9VLpH-r-YsVFRkIRRNv9mcVdBA
    h6gZSXoaFbluSBgXtgKXhim-uGR5ze_h4sefNV3VpcbJ3OBmUkz_w>
X-ME-Received: <xmr:hy4Nah84IpSCUxdDIbWlWwOmDHrn36dJuSXZ1RL-3iWWBRZwhzZMu2Oksbc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeefheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpefhgefhteevffdvgeduhfegffettdekgfektefhhfeugfeggeeiveehfedu
    leefffenucffohhmrghinhepghdruggvvhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrlhgvgiesshhhrgiisghothdrohhrghdpnhgspghr
    tghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjrggtohgsrd
    hprghnsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhomh
    hmuheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehjghhgsehnvhhiughi
    rgdrtghomhdprhgtphhtthhopehjohhroheskegshihtvghsrdhorhhgpdhrtghpthhtoh
    epshhmohhsthgrfhgrsehgohhoghhlvgdrtghomhdprhgtphhtthhopegumhgrthhlrggt
    khesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhhosghinhdrmhhurhhphhihsegrrh
    hmrdgtohhmpdhrtghpthhtohepnhhitgholhhinhgtsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:hy4Nav9xUXyuGr-r1WC3MxvKYxpBCKj5_n9VDisdsLbsBogrRG4jcw>
    <xmx:hy4Nakc_VfF1j4aCY5wFQ_wLFQWtGqQi6I2SL2qrg1Idj4gBfqt6tg>
    <xmx:hy4NarvaOIqhKHfKuG5C_BuH-1oZlDsnj5n3XDPwdLMFYAfMHKK2hg>
    <xmx:hy4Nat26Nx-t2ywwsdc2SIVR2kavJ5lBNUnPr2LkDrTylCidHJoqNA>
    <xmx:hy4NalZNbnRi4nxDYaugYaNBvwgAQDRH2VzPMn8JpvIUHPM6t_2v5UCk>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 23:46:13 -0400 (EDT)
Date: Tue, 19 May 2026 21:46:13 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
 skhawaja@google.com, pasha.tatashin@soleen.com, Will Deacon
 <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>, alex@shazbot.org
Subject: Re: [PATCH v5 7/9] vfio: Enable cdev noiommu mode under iommufd
Message-ID: <20260519214613.167e8d5b@shazbot.org>
In-Reply-To: <20260511184116.3687392-8-jacob.pan@linux.microsoft.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
	<20260511184116.3687392-8-jacob.pan@linux.microsoft.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 11:41:12 -0700
Jacob Pan <jacob.pan@linux.microsoft.com> wrote:

> Now that devices under noiommu mode can bind with IOMMUFD and perform
> IOAS operations, lift restrictions on cdev from VFIO side.
> 
> Remove the vfio_device_is_group_noiommu() early returns in
> vfio_df_iommufd_bind() and vfio_df_iommufd_unbind() so that both
> group and cdev noiommu devices go through the standard iommufd bind
> path. This is safe because iommufd_device_bind() now handles noiommu
> devices via its own iommufd_device_is_noiommu() check.
> 
> Add CAP_SYS_RAWIO checks for cdev open and bind under noiommu to
> maintain security parity with the group noiommu path.
> 
> No IOMMU cdevs are explicitly named with noiommu prefix. e.g.
> 
>     /dev/vfio/
>     |-- devices
>     |   `-- noiommu-vfio0
>     `-- vfio
> 
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
> v5:
>    - Add Kconfig VFIO_CDEV_NOIOMMU to select IOMMUFD_NOIOMMU
>      and its dependencies
>    - Add comment to explain vfio_noiommu conditional definition (Alex)
>    - Removed early return for group noiommu in bind/unbind
>    - Use consistent wording referring to VFIO noiommu mode (Kevin)
>    - Update unsafe_noiommu Kconfig help text (Kevin)
>    - Change dev_warn to dev_info for noiommu enabling msg (Kevin)
> v4:
>    - Remove early return in iommufd_bind for noiommu (Alex)
> v3:
>    - Consolidate into fewer patches
> v2:
>    - removed unnecessary device->noiommu set in
>      iommufd_vfio_compat_ioas_get_id()
> ---
>  drivers/vfio/Kconfig       |  3 +--
>  drivers/vfio/device_cdev.c | 10 ++++++++++
>  drivers/vfio/iommufd.c     |  7 -------
>  drivers/vfio/vfio.h        | 22 ++++++++++++++--------
>  drivers/vfio/vfio_main.c   | 25 ++++++++++++++++++++-----
>  include/linux/vfio.h       |  1 +
>  6 files changed, 46 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> index b1b1633412a9..b1a260b6054c 100644
> --- a/drivers/vfio/Kconfig
> +++ b/drivers/vfio/Kconfig
> @@ -22,8 +22,7 @@ config VFIO_DEVICE_CDEV
>  	  The VFIO device cdev is another way for userspace to get device
>  	  access. Userspace gets device fd by opening device cdev under
>  	  /dev/vfio/devices/vfioX, and then bind the device fd with an iommufd
> -	  to set up secure DMA context for device access.  This interface does
> -	  not support noiommu.
> +	  to set up secure DMA context for device access.
>  
>  	  If you don't know what to do here, say N.
>  
> diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
> index 54abf312cf04..46a808244398 100644
> --- a/drivers/vfio/device_cdev.c
> +++ b/drivers/vfio/device_cdev.c
> @@ -27,6 +27,9 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
>  	struct vfio_device_file *df;
>  	int ret;
>  
> +	if (device->noiommu && !capable(CAP_SYS_RAWIO))
> +		return -EPERM;
> +
>  	/* Paired with the put in vfio_device_fops_release() */
>  	if (!vfio_device_try_get_registration(device))
>  		return -ENODEV;
> @@ -110,6 +113,13 @@ long vfio_df_ioctl_bind_iommufd(struct vfio_device_file *df,
>  	if (df->group)
>  		return -EINVAL;
>  
> +	/*
> +	 * CAP_SYS_RAWIO is already checked at cdev open, recheck here
> +	 * in case the fd was passed to a less privileged process.
> +	 */
> +	if (device->noiommu && !capable(CAP_SYS_RAWIO))
> +		return -EPERM;
> +
>  	ret = vfio_device_block_group(device);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
> index 39079ab27f92..bc80056c74d3 100644
> --- a/drivers/vfio/iommufd.c
> +++ b/drivers/vfio/iommufd.c
> @@ -25,10 +25,6 @@ int vfio_df_iommufd_bind(struct vfio_device_file *df)
>  
>  	lockdep_assert_held(&vdev->dev_set->lock);
>  
> -	/* Returns 0 to permit device opening under noiommu mode */
> -	if (vfio_device_is_group_noiommu(vdev))
> -		return 0;
> -
>  	return vdev->ops->bind_iommufd(vdev, ictx, &df->devid);
>  }
>  
> @@ -58,9 +54,6 @@ void vfio_df_iommufd_unbind(struct vfio_device_file *df)
>  
>  	lockdep_assert_held(&vdev->dev_set->lock);
>  
> -	if (vfio_device_is_group_noiommu(vdev))
> -		return;
> -
>  	if (vdev->ops->unbind_iommufd)
>  		vdev->ops->unbind_iommufd(vdev);
>  }
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 602623cacfc0..ac79b1a2fce9 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -36,7 +36,7 @@ vfio_allocate_device_file(struct vfio_device *device);
>  
>  extern const struct file_operations vfio_device_fops;
>  
> -#ifdef CONFIG_VFIO_GROUP_NOIOMMU
> +#if IS_ENABLED(CONFIG_VFIO_GROUP_NOIOMMU) || IS_ENABLED(CONFIG_VFIO_CDEV_NOIOMMU)

Have you considered what happens when these are y/n or n/y?

I think in the former case we can create cdev devices for group-noiommu
devices that are not labeled noiommu, skip the CAP_SYS_RAWIO test, but
will fail to bind.  In the latter case, I think we fail to setup an
iommufd_device and unbind will segfault.

We really don't need to support independently setting GROUP vs CDEV
NOIOMMU, the suggestion was to try to get NOIOMMU from depending on
VFIO_GROUP.  We can do that other ways though and I think we can do it
without the rename in patch 1 that will inevitably result in some lost
config options for NOIOMMU on upgrade.

The Kconfig may get messy, perhaps something like:

config VFIO_NOIOMMU
	bool "VFIO No-IOMMU support"
	depends on VFIO_GROUP || VFIO_DEVICE_CDEV
	depends on !VFIO_GROUP || VFIO_CONTAINER || IOMMUFD_VFIO_CONTAINER
	depends on !VFIO_DEVICE_CDEV || !GENERIC_ATOMIC64
	select IOMMUFD_NOIOMMU if VFIO_DEVICE_CDEV

Sorry if the previous suggestion sent us astray, but the subtleties of
independent support look tricky.  Thanks,

Alex

>  extern bool vfio_noiommu __read_mostly;
>  #else
>  enum { vfio_noiommu = false };
> @@ -358,19 +358,13 @@ void vfio_init_device_cdev(struct vfio_device *device);
>  
>  static inline int vfio_device_add(struct vfio_device *device)
>  {
> -	/* cdev does not support noiommu device */
> -	if (vfio_device_is_group_noiommu(device))
> -		return device_add(&device->device);
>  	vfio_init_device_cdev(device);
>  	return cdev_device_add(&device->cdev, &device->device);
>  }
>  
>  static inline void vfio_device_del(struct vfio_device *device)
>  {
> -	if (vfio_device_is_group_noiommu(device))
> -		device_del(&device->device);
> -	else
> -		cdev_device_del(&device->cdev, &device->device);
> +	cdev_device_del(&device->cdev, &device->device);
>  }
>  
>  int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep);
> @@ -420,6 +414,18 @@ static inline void vfio_cdev_cleanup(void)
>  }
>  #endif /* CONFIG_VFIO_DEVICE_CDEV */
>  
> +#if IS_ENABLED(CONFIG_VFIO_CDEV_NOIOMMU)
> +static inline bool vfio_device_is_cdev_noiommu(struct vfio_device *vdev)
> +{
> +	return vdev->noiommu;
> +}
> +#else
> +static inline bool vfio_device_is_cdev_noiommu(struct vfio_device *vdev)
> +{
> +	return false;
> +}
> +#endif
> +
>  #if IS_ENABLED(CONFIG_VFIO_VIRQFD)
>  int __init vfio_virqfd_init(void);
>  void vfio_virqfd_exit(void);
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 4d940ce6f114..1ba0f282d746 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -54,7 +54,7 @@ static struct vfio {
>  	int				fs_count;
>  } vfio;
>  
> -#ifdef CONFIG_VFIO_GROUP_NOIOMMU
> +#if IS_ENABLED(CONFIG_VFIO_GROUP_NOIOMMU) || IS_ENABLED(CONFIG_VFIO_CDEV_NOIOMMU)
>  bool vfio_noiommu __read_mostly;
>  module_param_named(enable_unsafe_noiommu_mode,
>  		   vfio_noiommu, bool, S_IRUGO | S_IWUSR);
> @@ -321,6 +321,20 @@ static int vfio_init_device(struct vfio_device *device, struct device *dev,
>  	return ret;
>  }
>  
> +static int vfio_device_set_noiommu_and_name(struct vfio_device *device)
> +{
> +	if (IS_ENABLED(CONFIG_VFIO_CDEV_NOIOMMU) && vfio_noiommu && !device->dev->iommu) {
> +		device->noiommu = true;
> +		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> +		dev_warn(device->dev,
> +			 "Adding kernel taint for vfio-noiommu cdev on device\n");
> +	}
> +
> +	/* Just to be safe, expose to user explicitly noiommu cdev node */
> +	return dev_set_name(&device->device, "%svfio%d",
> +		     device->noiommu ? "noiommu-" : "", device->index);
> +}
> +
>  static int __vfio_register_dev(struct vfio_device *device,
>  			       enum vfio_group_type type)
>  {
> @@ -340,20 +354,21 @@ static int __vfio_register_dev(struct vfio_device *device,
>  	if (!device->dev_set)
>  		vfio_assign_device_set(device, device);
>  
> -	ret = dev_set_name(&device->device, "vfio%d", device->index);
> +	ret = vfio_device_set_group(device, type);
>  	if (ret)
>  		return ret;
>  
> -	ret = vfio_device_set_group(device, type);
> +	ret = vfio_device_set_noiommu_and_name(device);
>  	if (ret)
> -		return ret;
> +		goto err_out;
>  
>  	/*
>  	 * VFIO always sets IOMMU_CACHE because we offer no way for userspace to
>  	 * restore cache coherency. It has to be checked here because it is only
>  	 * valid for cases where we are using iommu groups.
>  	 */
> -	if (type == VFIO_IOMMU && !vfio_device_is_group_noiommu(device) &&
> +	if (type == VFIO_IOMMU && !(vfio_device_is_group_noiommu(device) ||
> +				    vfio_device_is_cdev_noiommu(device)) &&
>  	    !device_iommu_capable(device->dev, IOMMU_CAP_CACHE_COHERENCY)) {
>  		ret = -EINVAL;
>  		goto err_out;
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 31b826efba00..45f08986359e 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -74,6 +74,7 @@ struct vfio_device {
>  	u8 iommufd_attached:1;
>  #endif
>  	u8 cdev_opened:1;
> +	u8 noiommu:1;
>  	/*
>  	 * debug_root is a static property of the vfio_device
>  	 * which must be set prior to registering the vfio_device.

