Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7EB2CA2
	for <iommu@lists.linux.dev>; Thu, 22 Sep 2022 19:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663873856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cnhWouSde45ALHbYWXdy8WS/vwDNaUoNBSEjHAFskkU=;
	b=Ih1X0KUAOLeR6ad/SjqbSfWTSCyivip2NIcjMqL4vUq9rUWzZmeIjHYgzJg0J9smpFaIM0
	DiXGIYSZ8501SfANe1GNJraVjXWh5p49CMGDWWfW5gAby8LptRRGblGjg8S5q/PdKe4pTX
	LteEAVMijMNkMQ5/eZYdy6QK/zI07Bc=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-235-QWhRak9kNZKqBPWyF7Feng-1; Thu, 22 Sep 2022 15:10:53 -0400
X-MC-Unique: QWhRak9kNZKqBPWyF7Feng-1
Received: by mail-il1-f198.google.com with SMTP id c7-20020a056e020bc700b002e59be6ce85so6224229ilu.12
        for <iommu@lists.linux.dev>; Thu, 22 Sep 2022 12:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cnhWouSde45ALHbYWXdy8WS/vwDNaUoNBSEjHAFskkU=;
        b=wzjFNimWbLhNcSDuHp/dSR/BTsFuwF8OkyFP7pAp1+T/DoYg35v3a1o6q8akSVGhGO
         Up8ZOgtFHeVSURhgPjaQD6BJWHDZyG7s/zm83OxTB2rOIXvDrgleJ7YGJInKhi1s30+V
         SniRomj4o9Rl9whNthR1NHJ6Iew7cVgiEISIhmcAJvhdFR34hZoIxEpTyAdPrjZztYaH
         NGQHYXnyyMaoYA9CPy6z2hnGJPMFsyaW+Che2m0RyAjwqp6C21gISDTHw/P3D1ar3l4/
         QSrArjdpDpXOnMOZIO0jaMf+/vtBv8ujb7uziHEVy+2/Yvuvp9iD+jl1qWfVjY9xeiuC
         Worg==
X-Gm-Message-State: ACrzQf0DW9TN4qu4IIIs+qVyuRshbulcxGT/fK/2kJ98nAsziB6pEr/6
	sxHiY0IyqTY7AnzMijcdNylYtNgxTn21Ov863yIasHDs4ifld2v36fY2Yl/tEegfwX8jR9D/uHK
	ouF8i2006HtzJAT8=
X-Received: by 2002:a05:6638:1385:b0:35a:723c:2fb3 with SMTP id w5-20020a056638138500b0035a723c2fb3mr2605031jad.222.1663873852784;
        Thu, 22 Sep 2022 12:10:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7OOqQI1ZbCpUd9PIr2GP68ipI3WaHRHanmNIUyWftUVzE+2xlt4tzAiqmWoKUi9DkClCwqog==
X-Received: by 2002:a05:6638:1385:b0:35a:723c:2fb3 with SMTP id w5-20020a056638138500b0035a723c2fb3mr2605021jad.222.1663873852560;
        Thu, 22 Sep 2022 12:10:52 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id f12-20020a02a10c000000b0035b0eeeab89sm2402985jag.10.2022.09.22.12.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 12:10:52 -0700 (PDT)
Date: Thu, 22 Sep 2022 13:10:50 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>, iommu@lists.linux.dev, Joerg Roedel
 <joro@8bytes.org>, kvm@vger.kernel.org, Will Deacon <will@kernel.org>, Qian
 Cai <cai@lca.pw>, Joerg Roedel <jroedel@suse.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Robin
 Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/4] vfio: Move the sanity check of the group to
 vfio_create_group()
Message-ID: <20220922131050.7136481f.alex.williamson@redhat.com>
In-Reply-To: <2-v1-ef00ffecea52+2cb-iommu_group_lifetime_jgg@nvidia.com>
References: <0-v1-ef00ffecea52+2cb-iommu_group_lifetime_jgg@nvidia.com>
	<2-v1-ef00ffecea52+2cb-iommu_group_lifetime_jgg@nvidia.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Sep 2022 15:44:59 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> __vfio_register_dev() has a bit of code to sanity check if an (existing)
> group is not corrupted by having two copies of the same struct device in
> it. This should be impossible.
> 
> It then has some complicated error unwind to uncreate the group.
> 
> Instead check if the existing group is sane at the same time we locate
> it. If a bug is found then there is no error unwind, just simply fail
> allocation.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/vfio_main.c | 79 ++++++++++++++++++----------------------
>  1 file changed, 36 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 4ab13808b536e1..ba8b6bed12c7e7 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -306,15 +306,15 @@ static void vfio_container_put(struct vfio_container *container)
>   * Group objects - create, release, get, put, search
>   */
>  static struct vfio_group *
> -__vfio_group_get_from_iommu(struct iommu_group *iommu_group)
> +vfio_group_find_from_iommu(struct iommu_group *iommu_group)
>  {
>  	struct vfio_group *group;
>  
> +	lockdep_assert_held(&vfio.group_lock);
> +
>  	list_for_each_entry(group, &vfio.group_list, vfio_next) {
> -		if (group->iommu_group == iommu_group) {
> -			vfio_group_get(group);
> +		if (group->iommu_group == iommu_group)
>  			return group;
> -		}
>  	}
>  	return NULL;
>  }
> @@ -365,11 +365,27 @@ static struct vfio_group *vfio_group_alloc(struct iommu_group *iommu_group,
>  	return group;
>  }
>  
> +static bool vfio_group_has_device(struct vfio_group *group, struct device *dev)
> +{
> +	struct vfio_device *device;
> +
> +	mutex_lock(&group->device_lock);
> +	list_for_each_entry(device, &group->device_list, group_next) {
> +		if (device->dev == dev) {
> +			mutex_unlock(&group->device_lock);
> +			return true;
> +		}
> +	}
> +	mutex_unlock(&group->device_lock);
> +	return false;
> +}
> +
>  /*
>   * Return a struct vfio_group * for the given iommu_group. If no vfio_group
>   * already exists then create a new one.
>   */
> -static struct vfio_group *vfio_get_group(struct iommu_group *iommu_group,
> +static struct vfio_group *vfio_get_group(struct device *dev,
> +					 struct iommu_group *iommu_group,
>  					 enum vfio_group_type type)
>  {
>  	struct vfio_group *group;
> @@ -378,13 +394,20 @@ static struct vfio_group *vfio_get_group(struct iommu_group *iommu_group,
>  
>  	mutex_lock(&vfio.group_lock);
>  
> -	ret = __vfio_group_get_from_iommu(iommu_group);
> -	if (ret)
> -		goto err_unlock;
> +	ret = vfio_group_find_from_iommu(iommu_group);
> +	if (ret) {
> +		if (WARN_ON(vfio_group_has_device(ret, dev))) {
> +			ret = ERR_PTR(-EINVAL);
> +			goto out_unlock;
> +		}

This still looks racy.  We only know within vfio_group_has_device() that
the device is not present in the group, what prevents a race between
here and when we finally do add it to group->device_list?  We can't
make any guarantees if we drop group->device_lock between test and add.

The semantics of vfio_get_group() are also rather strange, 'return a
vfio_group for this iommu_group, but make sure it doesn't include this
device' :-\  Thanks,

Alex

