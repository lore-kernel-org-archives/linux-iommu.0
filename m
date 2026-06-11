Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F9B31326A
	for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 23:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781219700; cv=none; b=dO9g95sj57Pyu15IaDFJhvXO0Bwnh+XTsLEZFxS7WSVcBf9bqSbcP21QnCzsdn3N8tMyyxmiz9jG9BUzB6Uf0I2vL4zSJHh7Lvk4dteV4NQdlrqxHiaHYdyqwSC92DmjSQRcwUBRcKYkj7IT2S+4tVM3TNhtM4VdvR1bTVipyTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781219700; c=relaxed/simple;
	bh=H4u4IaIBaerSJF+C7wICYUqQQ5uuLMRdFOP40BjWnws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uAxGRMpCot0OWpSBXRfJBgaS7GIt2lzYm86Wz7BSu8kyHsmcUoq95njV32LE5uGxPtYc0Awamfxt5ivYZohvrb83937bJPvP6JqGId6gat68Fc3DV6k191+lrHo15tHGSidanrnB8nIw8WcmHiBhoRrz4iXZKjDvF21A2I1j4DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Ap9AWf7p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YDQQ9jz3; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Ap9AWf7p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YDQQ9jz3"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE729140005F;
	Thu, 11 Jun 2026 19:14:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 11 Jun 2026 19:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781219695;
	 x=1781306095; bh=hzxCJ8ujFvZLbi11oS7iTxWZll6hrx7DDCP2nVX8MlA=; b=
	Ap9AWf7pObAO8R9/hNWW/Hx1dk7ymyk8T89oTTF2dYlzmIECXZ+8YJZovg+n6+Za
	4UItT9Ce7Gt+kL+af/Qnz87BKy1OK83NX8XlBGyzY9v0VfskTKGwY/3p3uw9XoAN
	6ZGMZKHuwIYYyti2irYU2IshqguhmedAQr6VxbnR3QwGk245DmqYscwDEEDu30yJ
	gmMOC905FfukwUX6Qp3kzvS0Kx7KZjtzIA6eLvL+nyFiVv2T33QtFfWPUxSyhwAj
	liOJ1YQYyVdCLdX46xwIcGy7gOL5HBpI4hw6EMcr+F1HwrX5712FpnhB0hUO5m0e
	13gJilkVSIqnYw2LXrhITw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781219695; x=
	1781306095; bh=hzxCJ8ujFvZLbi11oS7iTxWZll6hrx7DDCP2nVX8MlA=; b=Y
	DQQ9jz3a3pQPpfit6CT7AYWX4zvZW5XzOXQaIkiVm5+zQAY7vAhp7jPgDH5jGGfS
	7KynuXovxDcHWzfRn0BGDauhn3c+q82lrbYqW6bECFtr+lt65/P+bj7eruv6b72o
	GQBCtf99Z28/Yf73SVQNKlm4n1KR6rmfroFkRL136Rkkg+nfcz63gB113LEEts3j
	rr09qnvXpJsIjHI8otip/YhiWVsZoie8ZvtuKYGkeDY+2ogxLF2KTm6OAK/D4kZo
	RPhN1/UFllBRB4TYWTy9hYmmwmKewVp3mI+cMH68gZUex007T1bDk/zzxUR3ZfDv
	VMTbwmCw0fnDeHvVIArdA==
X-ME-Sender: <xms:bkErakl33D3IiCPRm6kLGOg76Wg6lBMZf_nFqzSns8b7BHBXUp71uw>
    <xme:bkEravwem_iuDea1IqgJa4f8N-1WhVAZF0nVZPRclekUXPhps0vFECb5ECdgc0tLT
    oPEcbO5DCwLsIw5G8ETvOxi2ueQhHGc8K35pUM8T3GnnELvKc2ePg>
X-ME-Received: <xmr:bkEraow1FBPOr6hOJ2_nH6q2KpxSRkCObmk9PrCzz6Ya_HAipqLQgtbfv0U>
X-ME-Proxy-Cause: dmFkZTEgpNR/KQIUlGTr/ipY9s+5SQdrOulGLfe/g5E1yDjCfje/ipq60B/tq75AP5sCvO
    ruTGxLGd1ytZQz29eFdfZObA6I9cPAr9wxQEAmPHzI+mKLZRoiSdVgDm8GKt6uQs4wYMx4
    4hdn66srOax0hnnj5oJmjvRfY7mPMZ05ppts8vPT7uLRTWaPfjB7+WEu7qKJ7DqaF5++z4
    f0j89KOutNPQolHiLJRO+a1mrQ3PbFXqOSDzZdSRfJ4J/xKRzAIvafggAVrsRRQQ33IgsR
    xoJtp6vsum5N2sQPriimfGKTNtJVy8fXboW2ReR2m1wZntTAKtaqPHEZ/QD+vB8WByVGEu
    vwakvoI5wxmYH/++tdFFb/u6fJJ7U88qe4JqeK7ncSllHbm13sXckJiICwmvWhiS03xouo
    KszBwupviqw1JurpOPMsDchoEz4LdDpCIYYWLckuk/7bRJ+LOmQVhlQ165dbTY0g6nMkzA
    0PYADxi0d6Av1moLJqdTOBFmIejfccgQT0kFjMagUDmpDTXcaKeacSWm1wwfP7RGpUIKAE
    011BVpEpVLTvOKZhRJJaESxvsSUGJbzH6AC+WtMFr0D7kXj5M29oQfipbxnrUq7ufSCYtG
    KVsdhYZLX/ZL6kkG1eTLLT6Cjqxxy1rXM9JAWCkQhlYOa7sO66TacMJXb1iA
X-ME-Proxy: <xmx:bkEram9tbC_xHE3FN27W14ZmNmjJpp8Xoor97tfCFW1CVzoX2IMcmA>
    <xmx:bkErag8FkMze0Ok2C8AYwnVMbxhir-WUgaaMPA4_zpb_lWhXIORYEg>
    <xmx:bkErahc92sYqvFm7cWSCIOS7Ff4Nrj8N16PlDDGGuQVEIIJySTV3EQ>
    <xmx:bkErakvMoUsB5qGSrJEvTEabe1wGijb9TZIzJsiMeEhyPwPMJXX_fA>
    <xmx:b0ErajzgVbIo_GIeZTDyHX6glSZ1Foyl-9HYQb1sklKtlY9AtdJzLcWh>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 19:14:53 -0400 (EDT)
Date: Thu, 11 Jun 2026 17:14:51 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>, skhawaja@google.com,
 pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v9 5/6] vfio: Enable cdev noiommu mode under iommufd
Message-ID: <20260611171451.4873e4da@shazbot.org>
In-Reply-To: <20260611172658.3421138-6-jacob.pan@linux.microsoft.com>
References: <20260611172658.3421138-1-jacob.pan@linux.microsoft.com>
	<20260611172658.3421138-6-jacob.pan@linux.microsoft.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 10:26:57 -0700
Jacob Pan <jacob.pan@linux.microsoft.com> wrote:

> Now that devices under noiommu mode can bind with IOMMUFD and perform
> IOAS operations, lift restrictions on cdev from VFIO side.
> Use cases are documented in Documentation/driver-api/vfio.rst
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
> v9:
>   - Leave device->device.devt unset for no-IOMMU dev so cdev_device_add()
>     registers only the struct device and does not expose an unsupported
>     cdev. (Alex, Sashiko)
>   - Hold registration while checking cdev no-IOMMU access (Sashiko)
> v8:
>   - Fix warning message (Kevin)
> v7:
>   - Avoid treating emulated device as noiommu device (Sashiko)
>   - Keep platforms w/ GENERIC_ATOMIC64 to use VFIO group noiommu as
>     before (Sashiko)
>   - Restore order of group & cdev init for noiommu (Yi)
>   - Consolidate noiommu helper for cdev & group (Yi)
> v6:
>   - Revert back to unified VFIO_NOIOMMU Kconfig for both cdev and group.
>     Use Kconfig dependency to restrict usages and avoid null group
>     checks. (Alex & Yi)
>   - Add CAP_SYS_RAWIO checks for cdev open to maintain security parity
>     with the group noiommu path. (Alex)
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
>  drivers/vfio/Kconfig       |  7 ++++---
>  drivers/vfio/device_cdev.c |  9 +++++++++
>  drivers/vfio/iommufd.c     | 12 ++++++++----
>  drivers/vfio/vfio.h        | 23 +++++++++--------------
>  drivers/vfio/vfio_main.c   | 26 +++++++++++++++++++++++++-
>  include/linux/vfio.h       |  1 +
>  6 files changed, 56 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> index ceae52fd7586..b9d6e1c22aed 100644
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
> @@ -62,7 +61,9 @@ endif
>  
>  config VFIO_NOIOMMU
>  	bool "VFIO No-IOMMU support"
> -	depends on VFIO_GROUP
> +	depends on VFIO_GROUP || (VFIO_DEVICE_CDEV && !GENERIC_ATOMIC64)
> +	depends on !VFIO_GROUP || VFIO_CONTAINER || IOMMUFD_VFIO_CONTAINER
> +	select IOMMUFD_NOIOMMU if VFIO_DEVICE_CDEV && !GENERIC_ATOMIC64
>  	help
>  	  VFIO is built on the ability to isolate devices using the IOMMU.
>  	  Only with an IOMMU can userspace access to DMA capable devices be
> diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
> index 54abf312cf04..1d9515c967b0 100644
> --- a/drivers/vfio/device_cdev.c
> +++ b/drivers/vfio/device_cdev.c
> @@ -11,6 +11,10 @@ static dev_t device_devt;
>  
>  void vfio_init_device_cdev(struct vfio_device *device)
>  {
> +	if (vfio_device_is_noiommu(device) &&
> +	    !IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU))
> +		return;
> +
>  	device->device.devt = MKDEV(MAJOR(device_devt), device->index);
>  	cdev_init(&device->cdev, &vfio_device_fops);
>  	device->cdev.owner = THIS_MODULE;
> @@ -31,6 +35,11 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
>  	if (!vfio_device_try_get_registration(device))
>  		return -ENODEV;
>  
> +	if (vfio_device_is_noiommu(device) && !capable(CAP_SYS_RAWIO)) {
> +		ret = -EPERM;
> +		goto err_put_registration;
> +	}
> +
>  	df = vfio_allocate_device_file(device);
>  	if (IS_ERR(df)) {
>  		ret = PTR_ERR(df);
> diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
> index a38d262c6028..e9893d34d07b 100644
> --- a/drivers/vfio/iommufd.c
> +++ b/drivers/vfio/iommufd.c
> @@ -25,8 +25,8 @@ int vfio_df_iommufd_bind(struct vfio_device_file *df)
>  
>  	lockdep_assert_held(&vdev->dev_set->lock);
>  
> -	/* Returns 0 to permit device opening under noiommu mode */
> -	if (vfio_device_is_noiommu(vdev))
> +	/* Group noiommu via iommufd compat needs no device binding */
> +	if (df->group && vfio_device_is_noiommu(vdev))
>  		return 0;
>  
>  	return vdev->ops->bind_iommufd(vdev, ictx, &df->devid);
> @@ -40,7 +40,11 @@ int vfio_iommufd_compat_attach_ioas(struct vfio_device *vdev,
>  
>  	lockdep_assert_held(&vdev->dev_set->lock);
>  
> -	/* compat noiommu does not need to do ioas attach */
> +	/*
> +	 * Compat noiommu does not need to do ioas attach. This helper is
> +	 * only called from the legacy group/iommufd compat path, so no
> +	 * explicit df->group check is needed.
> +	 */
>  	if (vfio_device_is_noiommu(vdev))
>  		return 0;
>  
> @@ -58,7 +62,7 @@ void vfio_df_iommufd_unbind(struct vfio_device_file *df)
>  
>  	lockdep_assert_held(&vdev->dev_set->lock);
>  
> -	if (vfio_device_is_noiommu(vdev))
> +	if (df->group && vfio_device_is_noiommu(vdev))
>  		return;
>  
>  	if (vdev->ops->unbind_iommufd)
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index e4b72e79b7e3..7728bc99b63d 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -112,11 +112,6 @@ bool vfio_device_has_container(struct vfio_device *device);
>  int __init vfio_group_init(void);
>  void vfio_group_cleanup(void);
>  
> -static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
> -{
> -	return IS_ENABLED(CONFIG_VFIO_NOIOMMU) &&
> -	       vdev->group->type == VFIO_NO_IOMMU;
> -}
>  #else
>  struct vfio_group;
>  
> @@ -188,11 +183,17 @@ static inline void vfio_group_cleanup(void)
>  {
>  }
>  
> +#endif /* CONFIG_VFIO_GROUP */
> +
>  static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
>  {
> -	return false;
> +#if IS_ENABLED(CONFIG_VFIO_GROUP)
> +	if (vdev->group && vdev->group->type == VFIO_NO_IOMMU)
> +		return true;
> +#endif
> +
> +	return IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) && vdev->noiommu;
>  }
> -#endif /* CONFIG_VFIO_GROUP */
>  
>  #if IS_ENABLED(CONFIG_VFIO_CONTAINER)
>  /**
> @@ -358,19 +359,13 @@ void vfio_init_device_cdev(struct vfio_device *device);
>  
>  static inline int vfio_device_add(struct vfio_device *device)
>  {
> -	/* cdev does not support noiommu device */
> -	if (vfio_device_is_noiommu(device))
> -		return device_add(&device->device);
>  	vfio_init_device_cdev(device);
>  	return cdev_device_add(&device->cdev, &device->device);
>  }
>  
>  static inline void vfio_device_del(struct vfio_device *device)
>  {
> -	if (vfio_device_is_noiommu(device))
> -		device_del(&device->device);
> -	else
> -		cdev_device_del(&device->cdev, &device->device);
> +	cdev_device_del(&device->cdev, &device->device);
>  }
>  
>  int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep);
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 6222376ab6ab..8a540a4c9afc 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -321,6 +321,24 @@ static int vfio_init_device(struct vfio_device *device, struct device *dev,
>  	return ret;
>  }
>  
> +static int vfio_device_set_noiommu_and_name(struct vfio_device *device, enum vfio_group_type type)
> +{
> +	if (IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) && vfio_noiommu &&
> +	    !device->dev->iommu && type == VFIO_IOMMU)
> +		device->noiommu = true;
> +
> +	/*
> +	 * device->noiommu records no-IOMMU support for the standalone cdev
> +	 * interface. VFIO_NOIOMMU enables both group and cdev no-IOMMU; when
> +	 * cdev no-IOMMU is available, device->noiommu is set before
> +	 * vfio_device_set_group(), so the cdev is named noiommu-vfio%d up
> +	 * front. If IOMMUFD_NOIOMMU is unavailable, no-IOMMU devices are
> +	 * limited to the group interface and do not receive a device cdev.
> +	 */
> +	return dev_set_name(&device->device, "%svfio%d",
> +		     device->noiommu ? "noiommu-" : "", device->index);
> +}
> +
>  static int __vfio_register_dev(struct vfio_device *device,
>  			       enum vfio_group_type type)
>  {
> @@ -340,7 +358,7 @@ static int __vfio_register_dev(struct vfio_device *device,
>  	if (!device->dev_set)
>  		vfio_assign_device_set(device, device);
>  
> -	ret = dev_set_name(&device->device, "vfio%d", device->index);
> +	ret = vfio_device_set_noiommu_and_name(device, type);
>  	if (ret)
>  		return ret;
>  
> @@ -348,6 +366,12 @@ static int __vfio_register_dev(struct vfio_device *device,
>  	if (ret)
>  		return ret;
>  
> +	if (vfio_device_is_noiommu(device) && IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU)) {
> +		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> +		dev_warn(device->dev,
> +			 "Adding kernel taint for vfio-noiommu cdev\n");
> +	}
> +

Note that it seems like this will trigger a double taint when
VFIO_GROUP=y, VFIO_DEVICE_CDEV=y, IOMMUFD_NOIOMMU=y.  One option seems
to be changing the test to:

	if (device->noiommu && !IS_ENABLED(CONFIG_VFIO_GROUP))

Otherwise it looks correct and this can be a follow-up, the extra taint
is just noise.

Reviewed-by: Alex Williamson <alex@shazbot.org>

Thanks,
Alex

>  	/*
>  	 * VFIO always sets IOMMU_CACHE because we offer no way for userspace to
>  	 * restore cache coherency. It has to be checked here because it is only
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

