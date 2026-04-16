Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D670E38D686
	for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 20:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369975; cv=none; b=rnhZ7KmcLu5y817ci9bx8HeTGUl5tMN6yxsTQeFNyMaef5+Ga/W+2awGvMRUiOQ04304osutzkdejEsk5KTj1zJkuekrkeKL5mIgXdWk+HQ/ztbfZzNoAxLAqMDBYS04yjvkcd+lMnhIsqMe9wamRwZ6z4gHxqZK+755GMFVbFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369975; c=relaxed/simple;
	bh=5RB1vzOT5LDGmHa9fkCg+39mdw1IyES6vbyHtekUY+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LDNzbEMyfnP7LqRIPCCTujHqiKvG/8xAQN/F5FsQ7/SgxnFhOkGkYTBuMICOS+2p2/SXJHmNCdQ8M65njfvv9F1OCOo3iWDy8lnHV2Rqx9ZqStrA8j5ZtXJIY8K/AgETn10gE9lN2ZXqdMN5agmKn5uPEfsS9KPFffDOfnHBvus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=romMaOjB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NfXrVeRA; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="romMaOjB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NfXrVeRA"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D0DB27A0185;
	Thu, 16 Apr 2026 16:06:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 16 Apr 2026 16:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776369965;
	 x=1776456365; bh=/bsGkyiHwKqz6ql+lERRB98HHGEurnOzngJlowfRcMo=; b=
	romMaOjBo8Smz/+rwjY1iUhJxw7Wvh4LaooE1mj+LjMbsZaMOrUeK5X2z3z2M+aC
	XNWeetiRvurTVrV0X+NF2BRhZD/6AjoSE3RldBySFeOVqEOtDC8lFK90H98jyKu9
	Q6aTnBghptve3Odi+5GCYjEhR6xj4U7IXo60z9z00ERxBDuQ6/k27G3udVsWrY+D
	8rCYDYnRwNcKfcmEosWYaMhMwhz6R91J9SF29DBFwrDnqDdaW+CjYDezY0KixKAk
	WzSt0ruvduat3j2y6Awl5Mn7XQLR2pzC+XYk8V45qWz4NSt3WtZMLqyYZ+AzLuVn
	xzG2NNnK27UKpqkh8JU5jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776369965; x=
	1776456365; bh=/bsGkyiHwKqz6ql+lERRB98HHGEurnOzngJlowfRcMo=; b=N
	fXrVeRA53aCakOxncgqXVv3Q09KY5aS4cTF5TtMBBUFUJXT6nINSav6cae0+77oJ
	GmvNT4MlcnUNZHLCXcIJpTh+NgsGH1T1n3tMz3VV0hPAtVTE4RRTRvVTvsChhHFG
	1VKClFWJzeLs+/Z6fNYsTohdgMLgrTqnyQSPqk4vFDQ4ehgwMtJIDh8XBZjXL5it
	8FwxEedXY5S2pDPh3WikFmC5mxZ9tATZpctyBeX2XL/sLjTlsIt7eoo1DCNVoaQf
	NOCdmNv/UzDqMfdpfhyI3bA+/qfVDw7CvMNKxToLhss6OVqLi94as68A2+Zuh6pX
	vMcmzU36mmoBqwrggXgAA==
X-ME-Sender: <xms:LEHhadn9GnqskULVEjW1GacNhjN7PHVxUDidDdGy6wSjQLDoieeOYQ>
    <xme:LEHhaXVJIU_woiPM6MjQDD3qz79SVMzFhNJX0pNXrvggA4hWT9CvxMm47nlWs_Ncs
    ey_QK8Tgvjf_t_gaaEJWZMvOjuNviJb5MBw_HycKbFbWQb7AO9bHg>
X-ME-Received: <xmr:LEHhaaeAAz2KHvYH2m3tO383j5DCRkdNyvjwM5qFvSg2Vbqg41iJsllFReQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepvdekfeejkedvudfhudfhteekudfgudeiteetvdeukedvheetvdekgfdugeev
    ueeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopeduiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgrtghosgdrphgrnheslhhinhhugidrmhhitghroh
    hsohhfthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehiohhmmhhusehlihhsthhsrdhlihhnuhigrd
    guvghvpdhrtghpthhtohepjhhgghesnhhvihguihgrrdgtohhmpdhrtghpthhtohepjhho
    rhhoseeksgihthgvshdrohhrghdprhgtphhtthhopehsmhhoshhtrghfrgesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepughmrghtlhgrtghksehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehrohgsihhnrdhmuhhrphhhhiesrghrmhdrtghomhdprhgtphhtthhopehnih
    gtohhlihhntgesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:LEHhadkcbl36GaEe3PrDjTlM5BEp-xugq76l8EI8m1ISNgI-XfEnQg>
    <xmx:LEHhaUB82EsOm3goCX3lFryJDfZA7_EIhb7XiekFWm-YHLquBch9cA>
    <xmx:LEHhaXflBhJjNv5wH_LqtUKHv-4FG2m5tV8KsSVMluH7_klROw5RnA>
    <xmx:LEHhaX6jeXktWqEeM1DZGqGb8n02hfommbaQWXsI0sDxhSEB2vsazQ>
    <xmx:LUHhaRRCOcYjfbPbgzNZD2EjKPVtAhAaMEgGnaevcbd1psgTgX1BGarA>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 16:06:03 -0400 (EDT)
Date: Thu, 16 Apr 2026 14:06:01 -0600
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
Subject: Re: [PATCH V4 05/10] vfio: Allow null group for noiommu without
 containers
Message-ID: <20260416140601.255ec031@shazbot.org>
In-Reply-To: <20260414211412.2729-6-jacob.pan@linux.microsoft.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
	<20260414211412.2729-6-jacob.pan@linux.microsoft.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Apr 2026 14:14:07 -0700
Jacob Pan <jacob.pan@linux.microsoft.com> wrote:

> In case of noiommu mode is enabled for VFIO cdev without VFIO container
> nor IOMMUFD provided compatibility container, there is no need to
> create a dummy group. Update the group operations to tolerate null group
> pointer.
> 
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> 
> ---
> v4: (Jason)
>    - Avoid null pointer deref in error unwind
>    - Add null group check in vfio_device_group_unregister
>    - repartition to include vfio_device_has_group() in this patch
> ---
>  drivers/vfio/group.c     | 20 ++++++++++++++++++++
>  drivers/vfio/vfio.h      | 17 +++++++++++++++++
>  drivers/vfio/vfio_main.c | 14 ++++++++++++++
>  include/linux/vfio.h     |  9 +++++++++
>  4 files changed, 60 insertions(+)
> 
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index 0fa9761b13d3..451e49d851f8 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -390,6 +390,9 @@ int vfio_device_block_group(struct vfio_device *device)
>  	struct vfio_group *group = device->group;
>  	int ret = 0;
>  
> +	if (vfio_null_group_allowed() && !group)
> +		return 0;

I think this comes down to the fact that at the end of this series,
VFIO_NOIOMMU still depends on VFIO_GROUP.  vfio_null_group_allowed()
can only return true if CONTAINER support is entirely disabled.  Why do
we still select VFIO_GROUP for VFIO_NOIOMMU and build group.s when
there's no container support to use it?

Also note that vfio_noiommu is S_IWUSR, so it is mutable at runtime.
Thanks,

Alex

> +
>  	mutex_lock(&group->group_lock);
>  	if (group->opened_file) {
>  		ret = -EBUSY;
> @@ -407,6 +410,9 @@ void vfio_device_unblock_group(struct vfio_device *device)
>  {
>  	struct vfio_group *group = device->group;
>  
> +	if (vfio_null_group_allowed() && !group)
> +		return;
> +
>  	mutex_lock(&group->group_lock);
>  	group->cdev_device_open_cnt--;
>  	mutex_unlock(&group->group_lock);
> @@ -598,6 +604,14 @@ static struct vfio_group *vfio_noiommu_group_alloc(struct device *dev,
>  	struct vfio_group *group;
>  	int ret;
>  
> +	/*
> +	 * With noiommu enabled under cdev interface only, there is no need to
> +	 * create a vfio_group if the group based containers are not enabled.
> +	 * The cdev interface is exclusively used for iommufd.
> +	 */
> +	if (vfio_null_group_allowed())
> +		return NULL;
> +
>  	iommu_group = iommu_group_alloc();
>  	if (IS_ERR(iommu_group))
>  		return ERR_CAST(iommu_group);
> @@ -705,6 +719,9 @@ void vfio_device_remove_group(struct vfio_device *device)
>  	struct vfio_group *group = device->group;
>  	struct iommu_group *iommu_group;
>  
> +	if (!group)
> +		return;
> +
>  	if (group->type == VFIO_NO_IOMMU || group->type == VFIO_EMULATED_IOMMU)
>  		iommu_group_remove_device(device->dev);
>  
> @@ -756,6 +773,9 @@ void vfio_device_group_register(struct vfio_device *device)
>  
>  void vfio_device_group_unregister(struct vfio_device *device)
>  {
> +	if (!device->group)
> +		return;
> +
>  	mutex_lock(&device->group->device_lock);
>  	list_del(&device->group_next);
>  	mutex_unlock(&device->group->device_lock);
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 8fcc98cf9577..db1530bb1716 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -114,6 +114,18 @@ bool vfio_device_has_container(struct vfio_device *device);
>  int __init vfio_group_init(void);
>  void vfio_group_cleanup(void);
>  
> +/*
> + * With noiommu enabled and no containers are supported, allow devices that
> + * don't have a dummy group.
> + */
> +static inline bool vfio_null_group_allowed(void)
> +{
> +	if (vfio_noiommu && (!IS_ENABLED(CONFIG_VFIO_CONTAINER) && !IS_ENABLED(CONFIG_IOMMUFD_VFIO_CONTAINER)))
> +		return true;
> +
> +	return false;
> +}
> +
>  static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
>  {
>  	return IS_ENABLED(CONFIG_VFIO_NOIOMMU) &&
> @@ -190,6 +202,11 @@ static inline void vfio_group_cleanup(void)
>  {
>  }
>  
> +static inline bool vfio_null_group_allowed(void)
> +{
> +	return false;
> +}
> +
>  static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
>  {
>  	return false;
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index e5886235cad4..5d7c2d014689 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -358,6 +358,10 @@ static int __vfio_register_dev(struct vfio_device *device,
>  	/* Refcounting can't start until the driver calls register */
>  	refcount_set(&device->refcount, 1);
>  
> +	/* noiommu device w/o container may have NULL group */
> +	if (!vfio_device_has_group(device))
> +		return 0;
> +
>  	vfio_device_group_register(device);
>  	vfio_device_debugfs_init(device);
>  
> @@ -392,6 +396,16 @@ void vfio_unregister_group_dev(struct vfio_device *device)
>  	bool interrupted = false;
>  	long rc;
>  
> +	/*
> +	 * For noiommu devices without a container, thus no dummy group,
> +	 * simply delete and unregister to balance refcount.
> +	 */
> +	if (!vfio_device_has_group(device)) {
> +		vfio_device_del(device);
> +		vfio_device_put_registration(device);
> +		return;
> +	}
> +
>  	/*
>  	 * Prevent new device opened by userspace via the
>  	 * VFIO_GROUP_GET_DEVICE_FD in the group path.
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 7384965d15d7..ceb5034c3a2e 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -328,6 +328,10 @@ struct iommu_group *vfio_file_iommu_group(struct file *file);
>  #if IS_ENABLED(CONFIG_VFIO_GROUP)
>  bool vfio_file_is_group(struct file *file);
>  bool vfio_file_has_dev(struct file *file, struct vfio_device *device);
> +static inline bool vfio_device_has_group(struct vfio_device *device)
> +{
> +	return device->group;
> +}
>  #else
>  static inline bool vfio_file_is_group(struct file *file)
>  {
> @@ -338,6 +342,11 @@ static inline bool vfio_file_has_dev(struct file *file, struct vfio_device *devi
>  {
>  	return false;
>  }
> +
> +static inline bool vfio_device_has_group(struct vfio_device *device)
> +{
> +	return false;
> +}
>  #endif
>  bool vfio_file_is_valid(struct file *file);
>  bool vfio_file_enforced_coherent(struct file *file);

