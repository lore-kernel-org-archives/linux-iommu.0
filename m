Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD034693
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 06:23:49 +0000 (UTC)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-44756c21105so384099137.1
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 23:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691562229; x=1692167029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x205JUcJrdy6m56y4SI/bATaq/jXQ34fSODElN8AHdQ=;
        b=e19zKhoYV55naGiVnudOxqRuT0re9tn8S5WtJPpQ7tFI5AygaaQAjILiNVsy225faM
         eUxnUdVr8WbE4DlezutIV8haej6wF5Fq9/rYKFzBciN0Z3RJSVPzCEoE/yhiRYSmx6JC
         0NJjF8lXwkxXxYmcSUqf9AfX3RMcV9Nkx3ycs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691562229; x=1692167029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x205JUcJrdy6m56y4SI/bATaq/jXQ34fSODElN8AHdQ=;
        b=SqU7+EA3Lrp4esS6qVi458RDOghfa8OnPgkJ10YGx2lk0TCNcY+UVsNjIY29jrN0M3
         6JdvOV5v5OP7ESwX31Ij2DZOvN57KW/G/ONASHDDzWkf2FruYlHOqjUIMwXhRT3JWfL/
         foc5wyQi8a1KrRNyjjE4ge8EeRUaxUSL17Xs2V0P2PYgjhpkJvo2mEzmS8QkfMQvpoEx
         PAWzgLujGLhxMHYGe6dUpH3VXvj7yV94Yr1ed8LZ0gh2M+RVlD83o9cfqNWOgDo49wlK
         xr3mJJBp7mROACDH4+DKHq0hhAxK9lO5LnMQ/S+4quM+j35ucdUpUUnaknkpmdL76qbC
         c4Pg==
X-Gm-Message-State: AOJu0Yzb2ivkwAasgEfiNo3qAcZFtsQl/v59F1MYJgGU8bCW9GiiLc9m
	lNNI/AhnrWWe3QSn1KihWNz6FYRXJLkXk/B2EYeqUA==
X-Google-Smtp-Source: AGHT+IEc5P222J1KE8zztcdL/OSdAcdJI1HUp7Z4XJj8Xf1Y7WGImgrKazxHV7M733PBjz+ApvUwUa0wGHUCjzyzRXA=
X-Received: by 2002:a67:f4c8:0:b0:43f:3426:9e35 with SMTP id
 s8-20020a67f4c8000000b0043f34269e35mr2048632vsn.12.1691562228737; Tue, 08 Aug
 2023 23:23:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
 <ZNDpfCoeFxA56ZlU@8bytes.org> <CAGXv+5E-f9AteAYkmXYzVDZFSA_royc7-bS5LcrzzuHDnXccwA@mail.gmail.com>
 <CGME20230808123250eucas1p19d12a9ae0e530c123ba625189f593b36@eucas1p1.samsung.com>
 <7483d18e-d06f-53eb-92af-beed50674ab0@samsung.com> <ZNI8W0hTXraSi/Ne@nvidia.com>
 <4d56203e-b602-07ee-ab74-2825c110c36d@samsung.com> <ZNJCRhGGxS+63Dnr@nvidia.com>
 <bc5d6aa8-e8ca-c896-2f39-af074d55e436@samsung.com> <ZNJRf4Xp8rY1+iT4@nvidia.com>
In-Reply-To: <ZNJRf4Xp8rY1+iT4@nvidia.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 9 Aug 2023 14:23:37 +0800
Message-ID: <CAGXv+5GKKskhnwboGUFi0tq=iES9L+wCawTDEh_9mkDmt=qKBQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Refine the locking for dev->iommu_group
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Woodhouse <dwmw2@infradead.org>, 
	Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Orson Zhai <orsonzhai@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>, Will Deacon <will@kernel.org>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 8, 2023 at 10:30=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Aug 08, 2023 at 04:02:40PM +0200, Marek Szyprowski wrote:
> > Hi Jason,
> >
> > On 08.08.2023 15:25, Jason Gunthorpe wrote:
> > > On Tue, Aug 08, 2023 at 03:08:30PM +0200, Marek Szyprowski wrote:
> > >>> Any of the drivers that use platform device as the iommu_device wil=
l
> > >>> have a problem, please try:
> > >>>
> > >>> https://lore.kernel.org/linux-iommu/ZNIz%2FNVLb6WqqvQx@nvidia.com/
> > >> I've checked and it doesn't help in my case. I will soon check why.
> > > Oh, I botched it. Forgot that the iommu_device->dev is the sysfs
> > > handle not the HW device. Maybe this:
> >
> > This fixed the early lockup, but then system hangs again a bit later. I=
t
> > looks that this device lock in __iommu_probe_device() is really
> > problematic,
>
> Yes, I expected we'd hit something like this - I checked alot of call
> paths but missed these two. The self-probe is sneaky, but here the
> device_lock is held way up the call chain, I just missed it.
>
> The fix is to just annotate that we already hold the lock when calling
> iommu_probe_device(), since we know in those cases that we must be
> holding it:

This fixed things for me, so

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index daa64dd687524b..3fc5e12f2f1c09 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1582,7 +1582,7 @@ static const struct iommu_ops *acpi_iommu_configure=
_id(struct device *dev,
>          * iommu_probe_device() call for dev, replay it to get things in =
order.
>          */
>         if (!err && dev->bus)
> -               err =3D iommu_probe_device(dev);
> +               err =3D iommu_probe_device_locked(dev);
>
>         /* Ignore all other errors apart from EPROBE_DEFER */
>         if (err =3D=3D -EPROBE_DEFER) {
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 7dbbcffac21930..b867d7f22954e9 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -264,6 +264,7 @@ int iommu_device_register(struct iommu_device *iommu,
>                 return -EBUSY;
>
>         iommu->ops =3D ops;
> +       iommu->hwdev =3D hwdev;
>         if (hwdev)
>                 iommu->fwnode =3D dev_fwnode(hwdev);
>
> @@ -273,7 +274,7 @@ int iommu_device_register(struct iommu_device *iommu,
>
>         for (int i =3D 0; i < ARRAY_SIZE(iommu_buses) && !err; i++) {
>                 iommu_buses[i]->iommu_ops =3D ops;
> -               err =3D bus_iommu_probe(iommu_buses[i]);
> +               err =3D bus_iommu_probe(iommu_buses[i], iommu);
>         }
>         if (err)
>                 iommu_device_unregister(iommu);
> @@ -452,24 +453,23 @@ static int __iommu_probe_device(struct device *dev,=
 struct list_head *group_list
>         struct group_device *gdev;
>         int ret;
>
> -       if (!ops)
> -               return -ENODEV;
>         /*
>          * Allow __iommu_probe_device() to be safely called in parallel,
>          * both dev->iommu_group and the initial setup of dev->iommu are
>          * protected this way.
>          */
> -       device_lock(dev);
> +       device_lock_assert(dev);
> +
> +       if (!ops)
> +               return -ENODEV;
>
>         /* Device is probed already if in a group */
> -       if (dev->iommu_group) {
> -               ret =3D 0;
> -               goto out_unlock;
> -       }
> +       if (dev->iommu_group)
> +               return 0;
>
>         ret =3D iommu_init_device(dev, ops);
>         if (ret)
> -               goto out_unlock;
> +               return ret;
>
>         group =3D dev->iommu_group;
>         gdev =3D iommu_group_alloc_device(group, dev);
> @@ -505,7 +505,6 @@ static int __iommu_probe_device(struct device *dev, s=
truct list_head *group_list
>                         list_add_tail(&group->entry, group_list);
>         }
>         mutex_unlock(&group->mutex);
> -       device_unlock(dev);
>
>         if (dev_is_pci(dev))
>                 iommu_dma_set_pci_32bit_workaround(dev);
> @@ -519,12 +518,10 @@ static int __iommu_probe_device(struct device *dev,=
 struct list_head *group_list
>         iommu_deinit_device(dev);
>         mutex_unlock(&group->mutex);
>         iommu_group_put(group);
> -out_unlock:
> -       device_unlock(dev);
>         return ret;
>  }
>
> -int iommu_probe_device(struct device *dev)
> +int iommu_probe_device_locked(struct device *dev)
>  {
>         const struct iommu_ops *ops;
>         int ret;
> @@ -540,6 +537,16 @@ int iommu_probe_device(struct device *dev)
>         return 0;
>  }
>
> +int iommu_probe_device(struct device *dev)
> +{
> +       int ret;
> +
> +       device_lock(dev);
> +       ret =3D iommu_probe_device_locked(dev);
> +       device_unlock(dev);
> +       return ret;
> +}
> +
>  static void __iommu_group_free_device(struct iommu_group *group,
>                                       struct group_device *grp_dev)
>  {
> @@ -1784,12 +1791,26 @@ struct iommu_domain *iommu_group_default_domain(s=
truct iommu_group *group)
>         return group->default_domain;
>  }
>
> +struct probe_iommu_args {
> +       struct list_head *group_list;
> +       struct iommu_device *iommu;
> +};
> +
>  static int probe_iommu_group(struct device *dev, void *data)
>  {
> -       struct list_head *group_list =3D data;
> +       struct probe_iommu_args *args =3D data;
> +       bool need_lock;
>         int ret;
>
> -       ret =3D __iommu_probe_device(dev, group_list);
> +       /* Probing the iommu itself is always done under the device_lock =
*/
> +       need_lock =3D !args->iommu || args->iommu->hwdev !=3D dev;
> +
> +       if (need_lock)
> +               device_lock(dev);
> +       ret =3D __iommu_probe_device(dev, args->group_list);
> +       if (need_lock)
> +               device_unlock(dev);
> +
>         if (ret =3D=3D -ENODEV)
>                 ret =3D 0;
>
> @@ -1858,13 +1879,16 @@ static void iommu_group_do_probe_finalize(struct =
device *dev)
>                 ops->probe_finalize(dev);
>  }
>
> -int bus_iommu_probe(const struct bus_type *bus)
> +int bus_iommu_probe(const struct bus_type *bus, struct iommu_device *iom=
mu)
>  {
>         struct iommu_group *group, *next;
> +       struct probe_iommu_args args =3D {};
>         LIST_HEAD(group_list);
>         int ret;
>
> -       ret =3D bus_for_each_dev(bus, NULL, &group_list, probe_iommu_grou=
p);
> +       args.group_list =3D &group_list;
> +       args.iommu =3D iommu;
> +       ret =3D bus_for_each_dev(bus, NULL, &args, probe_iommu_group);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 157b286e36bf3a..b5b7d4bd2cefb9 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -160,7 +160,7 @@ const struct iommu_ops *of_iommu_configure(struct dev=
ice *dev,
>          * probe for dev, replay it to get things in order.
>          */
>         if (!err && dev->bus)
> -               err =3D iommu_probe_device(dev);
> +               err =3D iommu_probe_device_locked(dev);
>
>         /* Ignore all other errors apart from EPROBE_DEFER */
>         if (err =3D=3D -EPROBE_DEFER) {
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 97c45f50bf4332..828679abef7503 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1234,6 +1234,10 @@ static int omap_iommu_probe(struct platform_device=
 *pdev)
>                 if (err)
>                         goto out_sysfs;
>                 obj->has_iommu_driver =3D true;
> +       } else {
> +               /* Re-probe bus to probe device attached to this IOMMU */
> +               obj->iommu.hwdev =3D &pdev->dev;
> +               bus_iommu_probe(&platform_bus_type, &obj->iommu);
>         }
>
>         pm_runtime_enable(obj->dev);
> @@ -1242,9 +1246,6 @@ static int omap_iommu_probe(struct platform_device =
*pdev)
>
>         dev_info(&pdev->dev, "%s registered\n", obj->name);
>
> -       /* Re-probe bus to probe device attached to this IOMMU */
> -       bus_iommu_probe(&platform_bus_type);
> -
>         return 0;
>
>  out_sysfs:
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index f1e18e81fca78b..96782bfb384462 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -361,6 +361,7 @@ struct iommu_domain_ops {
>   * @list: Used by the iommu-core to keep a list of registered iommus
>   * @ops: iommu-ops for talking to this iommu
>   * @dev: struct device for sysfs handling
> + * @hwdev: The device HW that controls the iommu
>   * @singleton_group: Used internally for drivers that have only one grou=
p
>   * @max_pasids: number of supported PASIDs
>   */
> @@ -369,6 +370,7 @@ struct iommu_device {
>         const struct iommu_ops *ops;
>         struct fwnode_handle *fwnode;
>         struct device *dev;
> +       struct device *hwdev;
>         struct iommu_group *singleton_group;
>         u32 max_pasids;
>  };
> @@ -465,7 +467,8 @@ static inline const struct iommu_ops *dev_iommu_ops(s=
truct device *dev)
>         return dev->iommu->iommu_dev->ops;
>  }
>
> -extern int bus_iommu_probe(const struct bus_type *bus);
> +extern int bus_iommu_probe(const struct bus_type *bus,
> +                          struct iommu_device *iommu);
>  extern bool iommu_present(const struct bus_type *bus);
>  extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap)=
;
>  extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
> @@ -709,6 +712,7 @@ static inline void dev_iommu_priv_set(struct device *=
dev, void *priv)
>  }
>
>  int iommu_probe_device(struct device *dev);
> +int iommu_probe_device_locked(struct device *dev);
>
>  int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features=
 f);
>  int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_feature=
s f);
>
>
