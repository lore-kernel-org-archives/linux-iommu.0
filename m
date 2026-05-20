Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF088369D67
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 03:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779248729; cv=none; b=DuLlqfDAlSXqbG6LYns9K/WwYz/qJIYmlEGmUBsB0SyAK3jWSR4OqB2pD+yQDOQGUL5AVgEhunnwMp2BFKkeoGke3R5FQMW1hdEUWXbUw5am7DzJCljujweLasbhLMvSKDZC4wK91VSk9iHYbwd3ioUcIKKCY3zEP8xyOVQ+nqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779248729; c=relaxed/simple;
	bh=U4I/YxL24LqlbIdbpIcetjkpvHeFCFoNhVKundUkUPA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bq2yCrXhG0Idp6QTfLzUnMuf9l06Ii512X8dTBYzdf98LRV+v1uTpsPLdnTSflpHlDXknaH51hS+QU0if1opd+mDFe6qnXBk0ztoxSj4KpWL1OmZrc7/GX24eK4EYDMzuQsdw3Oo+WYyfZPVqh6AAHJsq3bRa9WqEkNRuGMhu2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=aIlvAr66; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i/f5mOfN; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="aIlvAr66";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i/f5mOfN"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 856697A00FA;
	Tue, 19 May 2026 23:45:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 19 May 2026 23:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779248720;
	 x=1779335120; bh=6HGboVr3kFhd8YaIJllyKZraapOy4dNaifodkkgYQvY=; b=
	aIlvAr667L69taNGkN6U+eiLWVoXulGMiKjFsbKr4zqasplXeVMtQG49D8BTKSJT
	J3HDA8WK/fjNeSXIinK41VlBLxIpsaexP8vD4g7k97RVMmjmXWTFjbxcgy1rHPUQ
	OG4xk/TOTbwdhF8bhcEs7cBJ7jJjG3gYxsavZ7IvVF/htsVtzUmantrn4MFyoOlK
	+8bilssQ6Skse2SWdCLg+DDhRz16DynEpBkmffJG9oi0QjD6vk7vFbTnsTkJNofw
	UCBlUVLLm+Syo4DSnovKIs+sdKEUm3euwbcCDtGMCfsKpPxCkQoYVXZFkgNQXrPZ
	OuEy8h9FmOjissLU7IxTJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779248720; x=
	1779335120; bh=6HGboVr3kFhd8YaIJllyKZraapOy4dNaifodkkgYQvY=; b=i
	/f5mOfNZSkUYAtqjVjZNCeS8lmn3TpX7BTZUr62x3ifr2eRAiAAVPMB2QmNf5E8G
	vdbyCUwqS9Vg3v7Jn2MuNrFBiSgZnWF8gXVXLFyWlevmhgd4oVxM7GX2mlXvb9u/
	S1V49BiO8XhKAGLBEAKfL9ootfTnKHCAi7EjLpsl+KZhcFP8kQDzgUGGJiKynrMw
	4nuiElhssec4VhzbHJ3s5ShnoIKpip5mEuCtpn3ohkTq2Vk/VpM6N7IttWNhtiI1
	RLQuNF8U7i4T8qYQHB4LR1xlcfx3LYbHflS3klXfw/7y+HCQhC//NoOMn8uBKJtC
	+BbUVqstXz0iP7dfu5Chg==
X-ME-Sender: <xms:Ti4Nav02E1yxiTskqQD_rYB00y_RVOUVnwy1xPcFEPKGD4dvTdv8Tw>
    <xme:Ti4NaqB2FtiQbdv6TRUEGxZ50jb8ZW772d-q9h_j3sZfxrMWDAonze6v2_63ioIrT
    CMoDWGuaeXVj7HrYhMP3P1S42jrx9i5X3qyVqBQtbqGuQtKyOBCxA>
X-ME-Received: <xmr:Ti4NamDehQ5AZtKTYdjWBqKIIBMchDMHftCGrOhdOwXQ-Craj__SC1srzFU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeefheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeegudevhfejueefveduieeuueeifeettdekveekhffgvdetfeelueehgfdt
    heffhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepudejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjrggtohgsrdhprghnsehlihhnuhigrdhmihgtrh
    hoshhofhhtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhomhhmuheslhhishhtshdrlhhinhhugi
    druggvvhdprhgtphhtthhopehjghhgsehnvhhiughirgdrtghomhdprhgtphhtthhopehj
    ohhroheskegshihtvghsrdhorhhgpdhrtghpthhtohepshhmohhsthgrfhgrsehgohhogh
    hlvgdrtghomhdprhgtphhtthhopegumhgrthhlrggtkhesghhoohhglhgvrdgtohhmpdhr
    tghpthhtoheprhhosghinhdrmhhurhhphhihsegrrhhmrdgtohhmpdhrtghpthhtohepnh
    hitgholhhinhgtsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:Ti4NarPH79eS2wmtWeOFUPg_8vjG1fLEPrTBiE_4dXc4yIzKg6wBqA>
    <xmx:Ty4NagOMRr6S-YridlC5CFwWg2UZRPVtveANI-XFPQJscKdVtjg0tw>
    <xmx:Ty4NavvqwK-nqDNhIjqLDLGyjVzovySKCDHl72RbcAPqdj_tG-iQ-Q>
    <xmx:Ty4Nal-uRLz9--rwB4AqxDEAM7P72TQq_7dou4xeZZblnvNiz45kUw>
    <xmx:UC4NakfznxKFwl0r9AQNMbbufzeHAr0Svx6kB_ukykiUILeHxQHs5okc>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 23:45:17 -0400 (EDT)
Date: Tue, 19 May 2026 21:45:16 -0600
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
Subject: Re: [PATCH v5 6/9] vfio/group: Add VFIO_CDEV_NOIOMMU Kconfig and
 tolerate NULL group
Message-ID: <20260519214516.20864d3e@shazbot.org>
In-Reply-To: <20260511184116.3687392-7-jacob.pan@linux.microsoft.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
	<20260511184116.3687392-7-jacob.pan@linux.microsoft.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2026 11:41:11 -0700
Jacob Pan <jacob.pan@linux.microsoft.com> wrote:

> Add a new CONFIG_VFIO_CDEV_NOIOMMU option, independent of
> CONFIG_VFIO_GROUP, to support noiommu mode via the cdev interface.
>=20
> Since CONFIG_VFIO_GROUP can be enabled while CONFIG_VFIO_GROUP_NOIOMMU
> is not, guard the noiommu group allocation in vfio_group_find_or_alloc()
> with IS_ENABLED(CONFIG_VFIO_GROUP_NOIOMMU) to prevent creating spurious
> /dev/vfio/noiommu-N group files when only cdev noiommu is configured.
>=20
> For cdev noiommu devices that have no group, let vfio_device_set_group()
> return success with a NULL group pointer and add null guards in group
> functions that may be called during device lifecycle. These guards are
> contained within group.c and are dead code for IOMMU-enabled devices
> where device->group is always non-NULL.
>=20
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>  drivers/vfio/Kconfig | 17 +++++++++++++++++
>  drivers/vfio/group.c | 31 +++++++++++++++++++++++++++++--
>  2 files changed, 46 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> index 39939be2908e..b1b1633412a9 100644
> --- a/drivers/vfio/Kconfig
> +++ b/drivers/vfio/Kconfig
> @@ -75,6 +75,23 @@ config VFIO_GROUP_NOIOMMU
> =20
>  	  If you don't know what to do here, say N.
> =20
> +config VFIO_CDEV_NOIOMMU
> +	bool "VFIO cdev No-IOMMU support"
> +	depends on VFIO_DEVICE_CDEV
> +	select IOMMUFD_NOIOMMU

AIUI, config would warn but allow this to select IOMMUFD_NOIOMMU
even if the dependency on !GENERIC_ATOMIC64 in the Kconfig is unmet.
This should include that dependency as well.  Thanks,

Alex

> +	help
> +	  VFIO cdev no-IOMMU mode enables device access via the cdev
> +	  interface without hardware IOMMU backing. This relies on
> +	  IOMMUFD_NOIOMMU to provide a SW-only IO page table for
> +	  IOVA-to-PA lookups.
> +
> +	  Use of this mode will result in an unsupportable kernel and
> +	  will therefore taint the kernel. Device assignment to virtual
> +	  machines is also not possible with this mode since there is
> +	  no IOMMU to provide DMA translation.
> +
> +	  If you don't know what to do here, say N.
> +
>  config VFIO_VIRQFD
>  	bool
>  	select EVENTFD
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index 5b9329df04e5..c8a75ee28f20 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -386,6 +386,9 @@ int vfio_device_block_group(struct vfio_device *devic=
e)
>  	struct vfio_group *group =3D device->group;
>  	int ret =3D 0;
> =20
> +	if (!group)
> +		return 0;
> +
>  	mutex_lock(&group->group_lock);
>  	if (group->opened_file) {
>  		ret =3D -EBUSY;
> @@ -403,6 +406,9 @@ void vfio_device_unblock_group(struct vfio_device *de=
vice)
>  {
>  	struct vfio_group *group =3D device->group;
> =20
> +	if (!group)
> +		return;
> +
>  	mutex_lock(&group->group_lock);
>  	group->cdev_device_open_cnt--;
>  	mutex_unlock(&group->group_lock);
> @@ -641,7 +647,8 @@ static struct vfio_group *vfio_group_find_or_alloc(st=
ruct device *dev)
>  	struct vfio_group *group;
> =20
>  	iommu_group =3D iommu_group_get(dev);
> -	if (!iommu_group && vfio_noiommu) {
> +	if (!iommu_group && IS_ENABLED(CONFIG_VFIO_GROUP_NOIOMMU) &&
> +	    vfio_noiommu) {
>  		/*
>  		 * With noiommu enabled, create an IOMMU group for devices that
>  		 * don't already have one, implying no IOMMU hardware/driver
> @@ -686,8 +693,19 @@ int vfio_device_set_group(struct vfio_device *device,
>  	else
>  		group =3D vfio_noiommu_group_alloc(device->dev, type);
> =20
> -	if (IS_ERR(group))
> +	if (IS_ERR(group)) {
> +		/*
> +		 * Cdev noiommu devices don't need a vfio_group. When
> +		 * CONFIG_VFIO_GROUP_NOIOMMU is not set, the group alloc
> +		 * above returns -EINVAL for devices without an IOMMU.
> +		 * That's fine =E2=80=94 a NULL group is expected and iommufd
> +		 * handles these devices directly.
> +		 */
> +		if (IS_ENABLED(CONFIG_VFIO_CDEV_NOIOMMU) &&
> +		    vfio_noiommu && !device->dev->iommu)
> +			return 0;
>  		return PTR_ERR(group);
> +	}
> =20
>  	/* Our reference on group is moved to the device */
>  	device->group =3D group;
> @@ -699,6 +717,9 @@ void vfio_device_remove_group(struct vfio_device *dev=
ice)
>  	struct vfio_group *group =3D device->group;
>  	struct iommu_group *iommu_group;
> =20
> +	if (!group)
> +		return;
> +
>  	if (group->type =3D=3D VFIO_NO_IOMMU || group->type =3D=3D VFIO_EMULATE=
D_IOMMU)
>  		iommu_group_remove_device(device->dev);
> =20
> @@ -742,6 +763,8 @@ void vfio_device_remove_group(struct vfio_device *dev=
ice)
> =20
>  void vfio_device_group_register(struct vfio_device *device)
>  {
> +	if (!device->group)
> +		return;
>  	mutex_lock(&device->group->device_lock);
>  	list_add(&device->group_next, &device->group->device_list);
>  	mutex_unlock(&device->group->device_lock);
> @@ -749,6 +772,8 @@ void vfio_device_group_register(struct vfio_device *d=
evice)
> =20
>  void vfio_device_group_unregister(struct vfio_device *device)
>  {
> +	if (!device->group)
> +		return;
>  	mutex_lock(&device->group->device_lock);
>  	list_del(&device->group_next);
>  	mutex_unlock(&device->group->device_lock);
> @@ -786,6 +811,8 @@ void vfio_device_group_unuse_iommu(struct vfio_device=
 *device)
> =20
>  bool vfio_device_has_container(struct vfio_device *device)
>  {
> +	if (!device->group)
> +		return false;
>  	return device->group->container;
>  }
> =20

