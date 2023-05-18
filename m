Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEFD29AD
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 20:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684441853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ks6xt/wC6E+ECyHt7NO8D94Kf2RxqGGaF/pXlLsIP+4=;
	b=hhMSrOa6g48vToxh/Dd/Meb0nIyRItdD3x56+Pvx4vZNW8lYpx/ZWFCIjE1Cibp0bRi47A
	Zr/qGc51mSJwItxCfv7n/Y46nuAHhstwqqch/hDYSZKOXXB482E9yU7pvvGLggl6It46OH
	y8rYAoxwjdM8kKq+GR4L4EaWLs0oNaU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-iKU1jcJNPO-FjERf98I9ZQ-1; Thu, 18 May 2023 16:30:51 -0400
X-MC-Unique: iKU1jcJNPO-FjERf98I9ZQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6238dcbc30bso11131826d6.1
        for <iommu@lists.linux.dev>; Thu, 18 May 2023 13:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684441851; x=1687033851;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UBHXSM6N4oYTfABvCGd3gPEAq2HM572bDIbMq8xh2Y4=;
        b=e13kcUvprwM9sIbEoqxxO4Y3n7fS4HC8JPtAwAoSRgygnqHOM8lugnRitSMlMtiGP7
         YJN3FDlQRCRa6GtWRJcs2EgKeWekDtWw6qHGI8vgT84NXjtIePVl1FFtVtB6yQey+KrV
         /jttcCVjf3XugXYeQ3uc87ZAKAFckWCOqCPlO82MyWTkEBCkLTKTXanp1Nv5uK5qIRCz
         eaHNoKmp7FMDVn7jHcc6dumcY2Ll829fn4lPv+l2dzLB6hu4HWIaJC5sEjvHUAQz4lI3
         +KsWrLNOotnSjY1cIwuZaBEWHnmXylbijvXfJpbLxW6U7MmEoQpevgapW0EMnolyfeJW
         Hzjw==
X-Gm-Message-State: AC+VfDw8WfOuRZHTiInxclpSJCoc5HGAdXIkvGr/B46h8IM6rWnb1VTY
	JOreViBZQ0AXbz+J80I37KxIEEbiZVS21DdNE4wlqubv06jTGL06VTHD15EChq4ZVaOm3DKr8yb
	7IXjJeoGxCxo+JjOVct/rIZE=
X-Received: by 2002:a05:6214:e4d:b0:5c7:d03c:f2b2 with SMTP id o13-20020a0562140e4d00b005c7d03cf2b2mr361304qvc.28.1684441851011;
        Thu, 18 May 2023 13:30:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7vnjCpdmwKeoU/jIRT/FUAUaf5A1UGyq52Jfrp1Qr7akRm4t7XVgexBhARVnPncRSkeITgNQ==
X-Received: by 2002:a05:6214:e4d:b0:5c7:d03c:f2b2 with SMTP id o13-20020a0562140e4d00b005c7d03cf2b2mr361277qvc.28.1684441850746;
        Thu, 18 May 2023 13:30:50 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c62:8200::feb? ([2600:4040:5c62:8200::feb])
        by smtp.gmail.com with ESMTPSA id cx3-20020a056214188300b006238f82cde4sm763000qvb.108.2023.05.18.13.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:30:50 -0700 (PDT)
Message-ID: <b07c93bc7cb71a32091794cd97f7c702c34539da.camel@redhat.com>
Subject: Re: [PATCH 3/4] drm/nouveau: stop using is_swiotlb_active
From: Lyude Paul <lyude@redhat.com>
To: Christoph Hellwig <hch@lst.de>, Juergen Gross <jgross@suse.com>, Stefano
 Stabellini <sstabellini@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,  Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Ben Skeggs <bskeggs@redhat.com>, Karol Herbst
 <kherbst@redhat.com>
Cc: xen-devel@lists.xenproject.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org
Date: Thu, 18 May 2023 16:30:49 -0400
In-Reply-To: <20230518134253.909623-4-hch@lst.de>
References: <20230518134253.909623-1-hch@lst.de>
	 <20230518134253.909623-4-hch@lst.de>
Organization: Red Hat Inc.
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Lyude Paul <lyude@redhat.com>

Thanks for getting to this!

On Thu, 2023-05-18 at 15:42 +0200, Christoph Hellwig wrote:
> Drivers have no business looking into dma-mapping internals and check
> what backend is used.  Unfortunstely the DRM core is still broken and
> tries to do plain page allocations instead of using DMA API allocators
> by default and uses various bandaids on when to use dma_alloc_coherent.
>=20
> Switch nouveau to use the same (broken) scheme as amdgpu and radeon
> to remove the last driver user of is_swiotlb_active.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/nouveau/nouveau_ttm.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_ttm.c b/drivers/gpu/drm/nouv=
eau/nouveau_ttm.c
> index 1469a88910e45d..486f39f31a38df 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_ttm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_ttm.c
> @@ -24,9 +24,9 @@
>   */
> =20
>  #include <linux/limits.h>
> -#include <linux/swiotlb.h>
> =20
>  #include <drm/ttm/ttm_range_manager.h>
> +#include <drm/drm_cache.h>
> =20
>  #include "nouveau_drv.h"
>  #include "nouveau_gem.h"
> @@ -265,7 +265,6 @@ nouveau_ttm_init(struct nouveau_drm *drm)
>  =09struct nvkm_pci *pci =3D device->pci;
>  =09struct nvif_mmu *mmu =3D &drm->client.mmu;
>  =09struct drm_device *dev =3D drm->dev;
> -=09bool need_swiotlb =3D false;
>  =09int typei, ret;
> =20
>  =09ret =3D nouveau_ttm_init_host(drm, 0);
> @@ -300,13 +299,10 @@ nouveau_ttm_init(struct nouveau_drm *drm)
>  =09=09drm->agp.cma =3D pci->agp.cma;
>  =09}
> =20
> -#if IS_ENABLED(CONFIG_SWIOTLB) && IS_ENABLED(CONFIG_X86)
> -=09need_swiotlb =3D is_swiotlb_active(dev->dev);
> -#endif
> -
>  =09ret =3D ttm_device_init(&drm->ttm.bdev, &nouveau_bo_driver, drm->dev-=
>dev,
>  =09=09=09=09  dev->anon_inode->i_mapping,
> -=09=09=09=09  dev->vma_offset_manager, need_swiotlb,
> +=09=09=09=09  dev->vma_offset_manager,
> +=09=09=09=09  drm_need_swiotlb(drm->client.mmu.dmabits),
>  =09=09=09=09  drm->client.mmu.dmabits <=3D 32);
>  =09if (ret) {
>  =09=09NV_ERROR(drm, "error initialising bo driver, %d\n", ret);

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

