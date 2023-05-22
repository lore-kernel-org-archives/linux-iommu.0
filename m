Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E07B107A6
	for <iommu@lists.linux.dev>; Mon, 22 May 2023 12:18:33 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-96f66fbd770so64961566b.1
        for <iommu@lists.linux.dev>; Mon, 22 May 2023 05:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684757911; x=1687349911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6loFUA9mZTaBhksiYSDr//MIYwSKmH+WH5P5CiDYiw=;
        b=hnOb8JJTQ/WFy6FCCGZW0Ot9rm6JYMBPhfopJz2bWgVoPDPqsFLfEhuutQVqsHDd8f
         PtUmBg2+tNIKNhpEBfpQZtO/ONBrAoCtsJ+W4caiar2yH+el/EaPTMn38V3SpA0eZHDV
         cXKu9XFKT+odQP6V6VRy0YUnNWsBKonA8V6Fb0EgyAV/Ms1qz6356hbYN3h8bBox/ij8
         7vBMM8LakrNhR0TmMsxcGN3werSvKbhTlpYgJXGqLuoaP6/JSgt91qw0xJ1xgkXO+jTp
         Ak3HzN87fGFL6l7SjnuOHIBgfmb5MYfeJ1bcwj1lD3TUfNzHP8N+c3Tn/QxFRSwRafqi
         HsBA==
X-Gm-Message-State: AC+VfDyApWte34H0suvHULnkjelyoMgjncq4ZMwA3OxVp2iA0cfEncva
	wUTMGTh0jVDEPXiqIO+Hs213l1MwFWwbq5JSSbM=
X-Google-Smtp-Source: ACHHUZ6M5NMrb+OBmOGW1h/Os0NMQMNGTVGnzskp0Gbc9OhXhbS6nhThOOS730m1iI0OfkjZODVuNeGRoegPixYdLNY=
X-Received: by 2002:a17:906:2218:b0:96f:4c38:4b1a with SMTP id
 s24-20020a170906221800b0096f4c384b1amr9027269ejs.5.1684757911056; Mon, 22 May
 2023 05:18:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com> <1-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
In-Reply-To: <1-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 May 2023 14:18:19 +0200
Message-ID: <CAJZ5v0hu+=TpAOGnh5gyz685t6DV2LRJwN7Rrq=j3rMdtQHgHw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] iommu: Have __iommu_probe_device() check for
 already probed devices
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 8:42=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> This is a step toward making __iommu_probe_device() self contained.
>
> It should, under proper locking, check if the device is already associate=
d
> with an iommu driver and resolve parallel probes. All but one of the
> callers open code this test using two different means, but they all
> rely on dev->iommu_group.
>
> Currently the bus_iommu_probe()/probe_iommu_group() and
> probe_acpi_namespace_devices() rejects already probed devices with an
> unlocked read of dev->iommu_group. The OF and ACPI "replay" functions use
> device_iommu_mapped() which is the same read without the pointless
> refcount.
>
> Move this test into __iommu_probe_device() and put it under the
> iommu_probe_device_lock. The store to dev->iommu_group is in
> iommu_group_add_device() which is also called under this lock for iommu
> driver devices, making it properly locked.
>
> The only path that didn't have this check is the hotplug path triggered b=
y
> BUS_NOTIFY_ADD_DEVICE. The only way to get dev->iommu_group assigned
> outside the probe path is via iommu_group_add_device(). Today the only
> caller is VFIO no-iommu which never associates with an iommu driver. Thus
> adding this additional check is safe.
>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the ACPI change in scan.c.

> ---
>  drivers/acpi/scan.c         |  2 +-
>  drivers/iommu/intel/iommu.c |  7 -------
>  drivers/iommu/iommu.c       | 19 +++++++++----------
>  drivers/iommu/of_iommu.c    |  2 +-
>  4 files changed, 11 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 0c6f06abe3f47f..945866f3bd8ebd 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1579,7 +1579,7 @@ static const struct iommu_ops *acpi_iommu_configure=
_id(struct device *dev,
>          * If we have reason to believe the IOMMU driver missed the initi=
al
>          * iommu_probe_device() call for dev, replay it to get things in =
order.
>          */
> -       if (!err && dev->bus && !device_iommu_mapped(dev))
> +       if (!err && dev->bus)
>                 err =3D iommu_probe_device(dev);
>
>         /* Ignore all other errors apart from EPROBE_DEFER */
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index b871a6afd80321..3c37b50c121c2d 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3763,7 +3763,6 @@ static int __init probe_acpi_namespace_devices(void=
)
>                 for_each_active_dev_scope(drhd->devices,
>                                           drhd->devices_cnt, i, dev) {
>                         struct acpi_device_physical_node *pn;
> -                       struct iommu_group *group;
>                         struct acpi_device *adev;
>
>                         if (dev->bus !=3D &acpi_bus_type)
> @@ -3773,12 +3772,6 @@ static int __init probe_acpi_namespace_devices(voi=
d)
>                         mutex_lock(&adev->physical_node_lock);
>                         list_for_each_entry(pn,
>                                             &adev->physical_node_list, no=
de) {
> -                               group =3D iommu_group_get(pn->dev);
> -                               if (group) {
> -                                       iommu_group_put(group);
> -                                       continue;
> -                               }
> -
>                                 ret =3D iommu_probe_device(pn->dev);
>                                 if (ret)
>                                         break;
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4d7010f2b260a7..6d4d6a4d692893 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -351,9 +351,16 @@ static int __iommu_probe_device(struct device *dev, =
struct list_head *group_list
>          * but for now enforcing a simple global ordering is fine.
>          */
>         mutex_lock(&iommu_probe_device_lock);
> +
> +       /* Device is probed already if in a group */
> +       if (dev->iommu_group) {
> +               ret =3D 0;
> +               goto out_unlock;
> +       }
> +
>         if (!dev_iommu_get(dev)) {
>                 ret =3D -ENOMEM;
> -               goto err_unlock;
> +               goto out_unlock;
>         }
>
>         if (!try_module_get(ops->owner)) {
> @@ -399,7 +406,7 @@ static int __iommu_probe_device(struct device *dev, s=
truct list_head *group_list
>  err_free:
>         dev_iommu_free(dev);
>
> -err_unlock:
> +out_unlock:
>         mutex_unlock(&iommu_probe_device_lock);
>
>         return ret;
> @@ -1711,16 +1718,8 @@ struct iommu_domain *iommu_group_default_domain(st=
ruct iommu_group *group)
>  static int probe_iommu_group(struct device *dev, void *data)
>  {
>         struct list_head *group_list =3D data;
> -       struct iommu_group *group;
>         int ret;
>
> -       /* Device is probed already if in a group */
> -       group =3D iommu_group_get(dev);
> -       if (group) {
> -               iommu_group_put(group);
> -               return 0;
> -       }
> -
>         ret =3D __iommu_probe_device(dev, group_list);
>         if (ret =3D=3D -ENODEV)
>                 ret =3D 0;
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 40f57d293a79d4..157b286e36bf3a 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -159,7 +159,7 @@ const struct iommu_ops *of_iommu_configure(struct dev=
ice *dev,
>          * If we have reason to believe the IOMMU driver missed the initi=
al
>          * probe for dev, replay it to get things in order.
>          */
> -       if (!err && dev->bus && !device_iommu_mapped(dev))
> +       if (!err && dev->bus)
>                 err =3D iommu_probe_device(dev);
>
>         /* Ignore all other errors apart from EPROBE_DEFER */
> --
> 2.40.1
>
