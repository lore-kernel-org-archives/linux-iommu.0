Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593C937B03F
	for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 20:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776372564; cv=none; b=deKsNRX7U+n3pymygOJarm9k9NqSImrVvgBbHEX1txynwS52E7HnnWBl2F/jXwT3XuPiU88SvpPKbyCb/6Tw+ruy56CJPNHLqrxk2hs/bNsKXsqBgdyUSmLAdJnn+9oDIeE9hESDYUVLDkxkqZKaZtfRWaxVz1Ii9ZgUaLyeqOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776372564; c=relaxed/simple;
	bh=xiSLy8tBZNAprCbmgmeTBgqVzO4u9DEkxHiYtQj6nIs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nn0bM1um5N91C11FcxX9GvGyTfKOxjLgV1M3QFRIc8k29O7WYrMfhF2FzP3rBHDWNiDtB68qeWf5e04vUh9fwCLzMkwvjm1wwPvnM3s1uN1PYuJTii5XneSehKDmdhKfBOL578sjQxMglmdcvyF/798Rq2eCm4/C6NFYGjAhQAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=DQk0Mvwq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bbt75yDw; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="DQk0Mvwq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bbt75yDw"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F04557A02F6;
	Thu, 16 Apr 2026 16:49:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 16 Apr 2026 16:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776372559;
	 x=1776458959; bh=qygA9tpZwdt1526WMy4tGe0KgWbfleZUGPI3rouuvHI=; b=
	DQk0Mvwq3jHD6MXjppgAn1B/4pH8I1InroQI3kvwqgN4X+aJoUWzyQtjm58fKosQ
	Rv+EOG8iQ/23FnjlJmsPFasoY+B8+tOwj8aXqenIuDWPZm3X3d0PCu316+JIGZdq
	kpPejjbOoz3LSfPxcC7o2OFfliXQOG7+0bbVMSFPGmvUvolY1oAr5V0uNQDg7dGw
	GIwvO2VG20V43omhr8awXGKK6qtdgEbn7WGeNobJcAliFQ+bG74OZOMiQVVdSXaS
	DEYyRnnKCLJ9KHudCPmVF6Bat3S+B4PoESOF7klqu9lTLF5sXyz1IRm8gQem1sbU
	Qz6O94N+VOsG2dUyKSfbcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776372559; x=
	1776458959; bh=qygA9tpZwdt1526WMy4tGe0KgWbfleZUGPI3rouuvHI=; b=B
	bt75yDwwUh8fcQeJccVmC5fwIPM36nsdwxkK2pGKeObZLv1FdurikURz5qhvus0H
	8wG5Q1Awz2FxFZD+Vn7oMQp0378KsyP/xENmAAuEdR/90s81obsxJd6I+6H7hg6Y
	qDnwmoPZfvaalvFzZWyKtXXp/2lY2sQLhgCb0PZjBkm5t6ldv1Hlv+ZmtDBuleRE
	MQcq0C1ky1r/uoPrVQ1gS+eqGMMB3THRCo7WW69w9lA3CoNik39n+T+U86aPu0Wr
	bMZyxmG/lQSxtrWcx1ibUUeZ+o8L/Xg/S+3CqqiAuWmum1fi1v7HjHmYS+lvm5hy
	Goeq43iQl9I/JbqAyon4A==
X-ME-Sender: <xms:Tkvhabp3cbwOsay4t3f0YaQSwOfxXiAuB93hnVXsCZvObxE8KypPfQ>
    <xme:TkvhaUJU37hKwESIx2eOfTr2bhqQUG0iXAD6pS296m956yY4iflgFC5pV44b5naHg
    Otl9iaMu-lX7oC0kAViFTsVvXN3lfrxWb8qy_srqwlk2iZRbw0W>
X-ME-Received: <xmr:TkvhafBHnrswkTi68JjcJ6-YTMBUp18XPurpwZxe7HGYtyG-WF0BZNZ4wv4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegkedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhephfeghfetveffvdegudfhgefftedtkefgkeethffhuefggeegieevheefudel
    feffnecuffhomhgrihhnpehgrdguvghvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgt
    phhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrtghosgdrph
    grnheslhhinhhugidrmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehiohhmmh
    husehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepjhhgghesnhhvihguihgr
    rdgtohhmpdhrtghpthhtohepjhhorhhoseeksgihthgvshdrohhrghdprhgtphhtthhope
    hsmhhoshhtrghfrgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepughmrghtlhgrtghk
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopehrohgsihhnrdhmuhhrphhhhiesrghrmh
    drtghomhdprhgtphhtthhopehnihgtohhlihhntgesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:Tkvhae6MrFl-__NBHWdPTmsY47JCn1YrGdhf64Lgqqqpz5eHGncvdQ>
    <xmx:TkvhaTETfVRNCJlmIVEV79GoVkCq3FhjRx9cQHyQI0Xm7iRf_WACFA>
    <xmx:TkvhaRSw48MXw7EPv6VMhygmJtvPrpGUDuDBRK7PZXwIMa1CdfS0aw>
    <xmx:TkvhaVf2QIGXiyxy3qNKBye5N2GKOcImUfI42FtRMYrBkNwbr6QOgQ>
    <xmx:T0vhaZE2etcJAUh7oMspKkWoYNduo095_vsjLnhqn-UQgZhrku2ZunuQ>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 16:49:17 -0400 (EDT)
Date: Thu, 16 Apr 2026 14:49:15 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, skhawaja@google.com, pasha.tatashin@soleen.com, Will
 Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>,
 alex@shazbot.org
Subject: Re: [PATCH V4 07/10] vfio: Enable cdev noiommu mode under iommufd
Message-ID: <20260416144915.4fe38481@shazbot.org>
In-Reply-To: <20260414211412.2729-8-jacob.pan@linux.microsoft.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
	<20260414211412.2729-8-jacob.pan@linux.microsoft.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Apr 2026 14:14:09 -0700
Jacob Pan <jacob.pan@linux.microsoft.com> wrote:

> Now that devices under noiommu mode can bind with IOMMUFD and perform
> IOAS operations, lift restrictions on cdev from VFIO side.
> 
> No IOMMU cdevs are explicitly named with noiommu prefix. e.g.
> 
>     /dev/vfio/
>     |-- 7
>     |-- devices
>     |   `-- noiommu-vfio0
>     `-- vfio

The group interface already does this, so the "7" is not
representative.  In fact, since the no-iommu groups are created as
device are bound, chances are they'd be in sync for a single device, so
this would be 'noiommu-0'.  NB. it's correctly represented in the
subsequent patches.

> 
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> 
> ---
> v4:
>    - Move vfio_device_has_group() related out to 5/10
>    - Keep wait loop in vfio_unregister_group_dev (Jason)
> v3:
>    - Add explict dependency on !GENERIC_ATOMIC64
> v2:
>    - Fix build dependency on IOMMU_SUPPORT
> ---
>  drivers/vfio/Kconfig     |  8 ++++++--
>  drivers/vfio/iommufd.c   |  7 -------
>  drivers/vfio/vfio.h      |  8 +-------
>  drivers/vfio/vfio_main.c | 20 ++++++--------------
>  4 files changed, 13 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> index ceae52fd7586..c013255bf7f1 100644
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
> @@ -63,6 +62,11 @@ endif
>  config VFIO_NOIOMMU
>  	bool "VFIO No-IOMMU support"
>  	depends on VFIO_GROUP
> +	depends on !GENERIC_ATOMIC64 # IOMMU_PT_AMDV1 requires cmpxchg64
> +	select GENERIC_PT
> +	select IOMMU_PT
> +	select IOMMU_PT_AMDV1
> +	depends on IOMMU_SUPPORT

Cosmetic nit, group the depends together.

Noting my previous concern about why we keep group support for
non-container builds, what about making VFIO_GROUP_NOIOMMU and
VFIO_CDEV_NOIOMMU?

Also, vfio no-iommu is traditionally gated on CAP_SYS_RAWIO, but those
tests are all in the vfio group code and not replicated here for cdev,
afaict.  That would relax the usage requirements quite significantly.
Thanks,

Alex

>  	help
>  	  VFIO is built on the ability to isolate devices using the IOMMU.
>  	  Only with an IOMMU can userspace access to DMA capable devices be
> diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
> index a38d262c6028..26c9c3068c77 100644
> --- a/drivers/vfio/iommufd.c
> +++ b/drivers/vfio/iommufd.c
> @@ -25,10 +25,6 @@ int vfio_df_iommufd_bind(struct vfio_device_file *df)
>  
>  	lockdep_assert_held(&vdev->dev_set->lock);
>  
> -	/* Returns 0 to permit device opening under noiommu mode */
> -	if (vfio_device_is_noiommu(vdev))
> -		return 0;
> -
>  	return vdev->ops->bind_iommufd(vdev, ictx, &df->devid);
>  }
>  
> @@ -58,9 +54,6 @@ void vfio_df_iommufd_unbind(struct vfio_device_file *df)
>  
>  	lockdep_assert_held(&vdev->dev_set->lock);
>  
> -	if (vfio_device_is_noiommu(vdev))
> -		return;
> -
>  	if (vdev->ops->unbind_iommufd)
>  		vdev->ops->unbind_iommufd(vdev);
>  }
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 9e25605da564..ad9e09f6d095 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -376,19 +376,13 @@ void vfio_init_device_cdev(struct vfio_device *device);
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
> index 5d7c2d014689..3ae3d34c21cc 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -332,13 +332,15 @@ static int __vfio_register_dev(struct vfio_device *device,
>  	if (!device->dev_set)
>  		vfio_assign_device_set(device, device);
>  
> -	ret = dev_set_name(&device->device, "vfio%d", device->index);
> +	ret = vfio_device_set_group(device, type);
>  	if (ret)
>  		return ret;
>  
> -	ret = vfio_device_set_group(device, type);
> +	/* Just to be safe, expose to user explicitly noiommu cdev node */
> +	ret = dev_set_name(&device->device, "%svfio%d",
> +					   device->noiommu ? "noiommu-" : "", device->index);
>  	if (ret)
> -		return ret;
> +		goto err_out;
>  
>  	/*
>  	 * VFIO always sets IOMMU_CACHE because we offer no way for userspace to
> @@ -359,7 +361,7 @@ static int __vfio_register_dev(struct vfio_device *device,
>  	refcount_set(&device->refcount, 1);
>  
>  	/* noiommu device w/o container may have NULL group */
> -	if (!vfio_device_has_group(device))
> +	if (vfio_device_is_noiommu(device) && !vfio_device_has_group(device))
>  		return 0;
>  
>  	vfio_device_group_register(device);
> @@ -396,16 +398,6 @@ void vfio_unregister_group_dev(struct vfio_device *device)
>  	bool interrupted = false;
>  	long rc;
>  
> -	/*
> -	 * For noiommu devices without a container, thus no dummy group,
> -	 * simply delete and unregister to balance refcount.
> -	 */
> -	if (!vfio_device_has_group(device)) {
> -		vfio_device_del(device);
> -		vfio_device_put_registration(device);
> -		return;
> -	}
> -
>  	/*
>  	 * Prevent new device opened by userspace via the
>  	 * VFIO_GROUP_GET_DEVICE_FD in the group path.

