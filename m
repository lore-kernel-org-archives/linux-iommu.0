Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C1ABD24
	for <iommu@lists.linux.dev>; Sun, 29 Jan 2023 06:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674972141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G+y0lNUe2D3FZqvZZMcDdGneE6tCR0dFmD5Cj+Ac+co=;
	b=jGyshBpiuc7o4x6BkaXId/RJsmg5fjNiGBlrzg022tz6bNBIi7z79qil7jRDQL1K2ln7LY
	1Ee2iMaZ6oPQmVHZckJVNeRUcPB30MyPSke4O5lARXGUmmBU7uwv2bAH4rRdguEYKULXjq
	UGLEP9CaZrCexerYSJ/cuLvpl5ikr4I=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-458-ctow_CdrOY2qFHElFBlxRQ-1; Sun, 29 Jan 2023 01:02:20 -0500
X-MC-Unique: ctow_CdrOY2qFHElFBlxRQ-1
Received: by mail-oo1-f69.google.com with SMTP id i10-20020a4a900a000000b004f1f4aa7f3bso1920255oog.7
        for <iommu@lists.linux.dev>; Sat, 28 Jan 2023 22:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+y0lNUe2D3FZqvZZMcDdGneE6tCR0dFmD5Cj+Ac+co=;
        b=2gwN05JGbu7U5cprTyBfmlYMWD6k1xn1nF9XqtgaVF7MubEDETGbm5IreCNoDGJaIT
         m4m7gr1Dkge9NCpseliiSkxxeMBmfvU9JMWq/7R/jdeqXcZfaisOaO4ExP4wkFRAkZ0q
         M351qKfrDrdvmxujjjVrskI4nn2rsU0uOl6zz5T8Zuq3ZcJjPc38nPWZS4XQ3lyaIZkw
         a+uTOrVwJ2JyXudXgzGkXkMUAVycqKgeCA8q7mfHjZbckvYQLjGPrgShUQps19w+anYG
         U73xTtKwQtgF+Whw2miltZ2HLJrjhKGYV1vg+ESt1a8TD0CGRKc4IcctoZFue98QpWYs
         E/hA==
X-Gm-Message-State: AO0yUKXeAihZU3rHcf8ArWactkd98bnLtn3iFnS7tT8Wb4eVv0klIPVT
	zL+E1egK4Ulu8lVc5mFz+cs40MENXqpFyhkaslBrNDiRN5K+K8mlizJ18GTnWdLV7Scka1+RMT/
	usIkz33dJ4o1zUAR6rzD4YeYlqWGA/yg=
X-Received: by 2002:a4a:3457:0:b0:517:7850:6483 with SMTP id n23-20020a4a3457000000b0051778506483mr952oof.3.1674972139716;
        Sat, 28 Jan 2023 22:02:19 -0800 (PST)
X-Google-Smtp-Source: AK7set8mW0JZ/n8lyZTTpcC67kMpT2Kinp8/MANimSerBoRFqCNzWu7WVdXpOca4BzGXE3JkgQMmFmJ+hFInW8+aXt4=
X-Received: by 2002:a4a:3457:0:b0:517:7850:6483 with SMTP id
 n23-20020a4a3457000000b0051778506483mr940oof.3.1674972139474; Sat, 28 Jan
 2023 22:02:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230128031740.166743-1-sunnanyong@huawei.com>
In-Reply-To: <20230128031740.166743-1-sunnanyong@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 29 Jan 2023 14:02:08 +0800
Message-ID: <CACGkMEtMAFMbhPnaaTwGRFofPM-p8ceKzAUbD2AFBz=fbR6hYQ@mail.gmail.com>
Subject: Re: [PATCH] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
To: Nanyong Sun <sunnanyong@huawei.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, mst@redhat.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	wangrong68@huawei.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Sat, Jan 28, 2023 at 10:25 AM Nanyong Sun <sunnanyong@huawei.com> wrote:
>
> From: Rong Wang <wangrong68@huawei.com>
>
> Once enable iommu domain for one device, the MSI
> translation tables have to be there for software-managed MSI.
> Otherwise, platform with software-managed MSI without an
> irq bypass function, can not get a correct memory write event
> from pcie, will not get irqs.
> The solution is to obtain the MSI phy base address from
> iommu reserved region, and set it to iommu MSI cookie,
> then translation tables will be created while request irq.
>
> Signed-off-by: Rong Wang <wangrong68@huawei.com>
> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
> ---
>  drivers/iommu/iommu.c |  1 +
>  drivers/vhost/vdpa.c  | 53 ++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 51 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index de91dd88705b..f6c65d5d8e2b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2623,6 +2623,7 @@ void iommu_get_resv_regions(struct device *dev, struct list_head *list)
>         if (ops->get_resv_regions)
>                 ops->get_resv_regions(dev, list);
>  }
> +EXPORT_SYMBOL_GPL(iommu_get_resv_regions);
>
>  /**
>   * iommu_put_resv_regions - release resered regions
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ec32f785dfde..31d3e9ed4cfa 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1103,6 +1103,48 @@ static ssize_t vhost_vdpa_chr_write_iter(struct kiocb *iocb,
>         return vhost_chr_write_iter(dev, from);
>  }
>
> +static bool vhost_vdpa_check_sw_msi(struct list_head *dev_resv_regions, phys_addr_t *base)
> +{
> +       struct iommu_resv_region *region;
> +       bool ret = false;
> +
> +       list_for_each_entry(region, dev_resv_regions, list) {
> +               /*
> +                * The presence of any 'real' MSI regions should take
> +                * precedence over the software-managed one if the
> +                * IOMMU driver happens to advertise both types.
> +                */
> +               if (region->type == IOMMU_RESV_MSI) {
> +                       ret = false;
> +                       break;
> +               }
> +
> +               if (region->type == IOMMU_RESV_SW_MSI) {
> +                       *base = region->start;
> +                       ret = true;
> +               }
> +       }
> +
> +       return ret;
> +}

Can we unify this with what VFIO had?

> +
> +static int vhost_vdpa_get_msi_cookie(struct iommu_domain *domain, struct device *dma_dev)
> +{
> +       struct list_head dev_resv_regions;
> +       phys_addr_t resv_msi_base = 0;
> +       int ret = 0;
> +
> +       INIT_LIST_HEAD(&dev_resv_regions);
> +       iommu_get_resv_regions(dma_dev, &dev_resv_regions);
> +
> +       if (vhost_vdpa_check_sw_msi(&dev_resv_regions, &resv_msi_base))
> +               ret = iommu_get_msi_cookie(domain, resv_msi_base);
> +
> +       iommu_put_resv_regions(dma_dev, &dev_resv_regions);
> +
> +       return ret;
> +}
> +
>  static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
>  {
>         struct vdpa_device *vdpa = v->vdpa;
> @@ -1128,11 +1170,16 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
>
>         ret = iommu_attach_device(v->domain, dma_dev);
>         if (ret)
> -               goto err_attach;
> +               goto err_alloc_domain;
>
> -       return 0;
> +       ret = vhost_vdpa_get_msi_cookie(v->domain, dma_dev);

Do we need to check the overlap mapping and record it in the interval
tree (as what VFIO did)?

Thanks

> +       if (ret)
> +               goto err_attach_device;
>
> -err_attach:
> +       return 0;
> +err_attach_device:
> +       iommu_detach_device(v->domain, dma_dev);
> +err_alloc_domain:
>         iommu_domain_free(v->domain);
>         return ret;
>  }
> --
> 2.25.1
>

