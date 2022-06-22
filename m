Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD391843
	for <iommu@lists.linux.dev>; Wed, 22 Jun 2022 22:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655936246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ztVNbSiA59Hqeo2EpfsBK2XPsXLM0PmWucdceMDBuI=;
	b=WViQlnwfQal9lFlBv+HhtBwQcDUUUfvjqrq0qLQ8VQgPMJqZ38lE5ppykuzf5IlWZUrVaj
	VprJu4YvEBGUrihq8z/QVkYpm07lQ8yEvo6ZiEcpO0A9OTFWekLUatJsKaNnGh763ZPOv4
	Um/WrWZw5x2+H/+ekEEMP9I76HWqQa8=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-WnfvXomXPDWtvgl2R6eapw-1; Wed, 22 Jun 2022 18:17:24 -0400
X-MC-Unique: WnfvXomXPDWtvgl2R6eapw-1
Received: by mail-il1-f197.google.com with SMTP id w7-20020a056e021c8700b002d3bc8e95cbso11851925ill.3
        for <iommu@lists.linux.dev>; Wed, 22 Jun 2022 15:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ztVNbSiA59Hqeo2EpfsBK2XPsXLM0PmWucdceMDBuI=;
        b=DZ89Bwf7dqisGCyrLIdaaolFrfxLVk58d4EPNUAT5fweH6SyY1B6eMAW4URsyXswMh
         FG4cQn0GM6HTcQ+H7z+WRqX/TC8lruXASfnO8n6KEtWqrtleFcAlzWK5obk2xmWXDBoc
         Z4pX4tf4QTp1sTNLvgCo6iN20TlgxYn/1mjZwpXPMlH1V3VWrUa9G2bb1Ewp2vwua3cV
         SY5OkNKJErHNXVuzD0rMtRCWY+BMHvTtgbmDAPzQe8iXhkPQN7+CAA9EP1JUSHy3t91e
         bsrVSbzduMb6qCY8X+sUE6h6Ry+pgqBP8Cflc/GZP2uD23fQl4c8T8lsjGCUB+2lTisI
         w5Rw==
X-Gm-Message-State: AJIora+LacI3y0PrMjZg7IuaNA45WLNXnV/cPLVptqPinwzqbcMh00G6
	iS15om3DNP4G8UPvtcjhAKSMg5Z6/EwgxCIO7PIjDblFVIhxsmfxG3sRe5HWSsNNPl+zckHKUZe
	kcceQxaAQ7fApDOo=
X-Received: by 2002:a05:6638:37a6:b0:339:c91c:76ba with SMTP id w38-20020a05663837a600b00339c91c76bamr3539216jal.103.1655936243561;
        Wed, 22 Jun 2022 15:17:23 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sBk2e/5rFsOWMh9xUh/TGTKZf6Tu5GiqsrJf9xiWIjDmO02kCQDr6xJWXr35eKHiS7z77HHw==
X-Received: by 2002:a05:6638:37a6:b0:339:c91c:76ba with SMTP id w38-20020a05663837a600b00339c91c76bamr3539199jal.103.1655936243237;
        Wed, 22 Jun 2022 15:17:23 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id s17-20020a02ad11000000b0032e36d3843fsm9058243jan.19.2022.06.22.15.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 15:17:22 -0700 (PDT)
Date: Wed, 22 Jun 2022 16:17:21 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: cohuck@redhat.com, jgg@nvidia.com, iommu@lists.linux.dev,
 iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] vfio/type1: Simplify bus_type determination
Message-ID: <20220622161721.469fc9eb.alex.williamson@redhat.com>
In-Reply-To: <b1d13cade281a7d8acbfd0f6a33dcd086207952c.1655898523.git.robin.murphy@arm.com>
References: <b1d13cade281a7d8acbfd0f6a33dcd086207952c.1655898523.git.robin.murphy@arm.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID: <20220622221721.bjmT3UIRjhUhu2j4bbKefovhVRHiSYs2Ub7zrJsKObA@z>

On Wed, 22 Jun 2022 13:04:11 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> Since IOMMU groups are mandatory for drivers to support, it stands to
> reason that any device which has been successfully be added to a group

s/be //

> must be on a bus supported by that IOMMU driver, and therefore a domain
> viable for any device in the group must be viable for all devices in
> the group. This already has to be the case for the IOMMU API's internal
> default domain, for instance. Thus even if the group contains devices on
> different buses, that can only mean that the IOMMU driver actually
> supports such an odd topology, and so without loss of generality we can
> expect the bus type of any device in a group to be suitable for IOMMU
> API calls.
> 
> Replace vfio_bus_type() with a simple call to resolve an appropriate
> member device from which to then derive a bus type. This is also a step
> towards removing the vague bus-based interfaces from the IOMMU API, when
> we can subsequently switch to using this device directly.
> 
> Furthermore, scrutiny reveals a lack of protection for the bus being
> removed while vfio_iommu_type1_attach_group() is using it; the reference
> that VFIO holds on the iommu_group ensures that data remains valid, but
> does not prevent the group's membership changing underfoot. Holding the
> vfio_device for as long as we need here also neatly solves this.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> After sleeping on it, I decided to type up the helper function approach
> to see how it looked in practice, and in doing so realised that with one
> more tweak it could also subsume the locking out of the common paths as
> well, so end up being a self-contained way for type1 to take care of its
> own concern, which I rather like.
> 
>  drivers/vfio/vfio.c             | 18 +++++++++++++++++-
>  drivers/vfio/vfio.h             |  3 +++
>  drivers/vfio/vfio_iommu_type1.c | 30 +++++++++++-------------------
>  3 files changed, 31 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index 61e71c1154be..73bab04880d0 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -448,7 +448,7 @@ static void vfio_group_get(struct vfio_group *group)
>   * Device objects - create, release, get, put, search
>   */
>  /* Device reference always implies a group reference */
> -static void vfio_device_put(struct vfio_device *device)
> +void vfio_device_put(struct vfio_device *device)
>  {
>  	if (refcount_dec_and_test(&device->refcount))
>  		complete(&device->comp);
> @@ -475,6 +475,22 @@ static struct vfio_device *vfio_group_get_device(struct vfio_group *group,
>  	return NULL;
>  }
>  
> +struct vfio_device *vfio_device_get_from_iommu(struct iommu_group *iommu_group)
> +{
> +	struct vfio_group *group = vfio_group_get_from_iommu(iommu_group);
> +	struct vfio_device *device;

Check group for NULL.

> +
> +	mutex_lock(&group->device_lock);
> +	list_for_each_entry(device, &group->device_list, group_next) {
> +		if (vfio_device_try_get(device)) {
> +			mutex_unlock(&group->device_lock);
> +			return device;
> +		}
> +	}
> +	mutex_unlock(&group->device_lock);
> +	return NULL;

No vfio_group_put() on either path.

> +}
> +
>  /*
>   * VFIO driver API
>   */
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index a67130221151..e8f21e64541b 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -70,3 +70,6 @@ struct vfio_iommu_driver_ops {
>  
>  int vfio_register_iommu_driver(const struct vfio_iommu_driver_ops *ops);
>  void vfio_unregister_iommu_driver(const struct vfio_iommu_driver_ops *ops);
> +
> +struct vfio_device *vfio_device_get_from_iommu(struct iommu_group *iommu_group);
> +void vfio_device_put(struct vfio_device *device);
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index c13b9290e357..e38b8bfde677 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1679,18 +1679,6 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
>  	return ret;
>  }
>  
> -static int vfio_bus_type(struct device *dev, void *data)
> -{
> -	struct bus_type **bus = data;
> -
> -	if (*bus && *bus != dev->bus)
> -		return -EINVAL;
> -
> -	*bus = dev->bus;
> -
> -	return 0;
> -}
> -
>  static int vfio_iommu_replay(struct vfio_iommu *iommu,
>  			     struct vfio_domain *domain)
>  {
> @@ -2159,7 +2147,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	struct vfio_iommu *iommu = iommu_data;
>  	struct vfio_iommu_group *group;
>  	struct vfio_domain *domain, *d;
> -	struct bus_type *bus = NULL;
> +	struct vfio_device *iommu_api_dev;
>  	bool resv_msi, msi_remap;
>  	phys_addr_t resv_msi_base = 0;
>  	struct iommu_domain_geometry *geo;
> @@ -2192,18 +2180,19 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  		goto out_unlock;
>  	}
>  
> -	/* Determine bus_type in order to allocate a domain */
> -	ret = iommu_group_for_each_dev(iommu_group, &bus, vfio_bus_type);
> -	if (ret)
> +	/* Resolve the group back to a member device for IOMMU API ops */
> +	ret = -ENODEV;
> +	iommu_api_dev = vfio_device_get_from_iommu(iommu_group);
> +	if (!iommu_api_dev)
>  		goto out_free_group;
>  
>  	ret = -ENOMEM;
>  	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
>  	if (!domain)
> -		goto out_free_group;
> +		goto out_put_dev;
>  
>  	ret = -EIO;
> -	domain->domain = iommu_domain_alloc(bus);
> +	domain->domain = iommu_domain_alloc(iommu_api_dev->dev->bus);

It makes sense to move away from a bus centric interface to iommu ops
and I can see that having a device interface when we have device level
address-ability within a group makes sense, but does it make sense to
only have that device level interface?  For example, if an iommu_group
is going to remain an aspect of the iommu subsystem, shouldn't we be
able to allocate a domain and test capabilities based on the group and
the iommu driver should have enough embedded information reachable from
the struct iommu_group to do those things?  This "perform group level
operations based on an arbitrary device in the group" is pretty klunky.
Thanks,

Alex

>  	if (!domain->domain)
>  		goto out_free_domain;
>  
> @@ -2258,7 +2247,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	list_add(&group->next, &domain->group_list);
>  
>  	msi_remap = irq_domain_check_msi_remap() ||
> -		    iommu_capable(bus, IOMMU_CAP_INTR_REMAP);
> +		    iommu_capable(iommu_api_dev->dev->bus, IOMMU_CAP_INTR_REMAP);
>  
>  	if (!allow_unsafe_interrupts && !msi_remap) {
>  		pr_warn("%s: No interrupt remapping support.  Use the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this platform\n",
> @@ -2331,6 +2320,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	iommu->num_non_pinned_groups++;
>  	mutex_unlock(&iommu->lock);
>  	vfio_iommu_resv_free(&group_resv_regions);
> +	vfio_device_put(iommu_api_dev);
>  
>  	return 0;
>  
> @@ -2342,6 +2332,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	vfio_iommu_resv_free(&group_resv_regions);
>  out_free_domain:
>  	kfree(domain);
> +out_put_dev:
> +	vfio_device_put(iommu_api_dev);
>  out_free_group:
>  	kfree(group);
>  out_unlock:

