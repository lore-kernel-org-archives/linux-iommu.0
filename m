From: Alban Browaeys <alban.browaeys@gmail.com>
Subject: Re: [PATCH v2 11/18] iommu: exynos: remove useless
 device_add/remove callbacks
Date: Tue, 21 Oct 2014 12:59:07 +0200
Message-ID: <1413889147.31696.1.camel@gmail.com>
References: <1410868485-4143-1-git-send-email-m.szyprowski@samsung.com>
	 <1410868485-4143-12-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1410868485-4143-12-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Le mardi 16 septembre 2014 =C3=A0 13:54 +0200, Marek Szyprowski a =C3=A9=
crit :
> The driver doesn't need to do anything important in device add/remove
> callbacks, because initialization will be done from device-tree speci=
fic
> callbacks added later. IOMMU groups created by current code were neve=
r
> used.
>=20
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>


The exyons iommu init fails if those are removed, that is it never reac=
h
init_done:
1. exynos_iommu_setup
2. - exynos_iommu_init
3. ---bus_set_iommu
4. ------ add_iommu_group

that is (4) add_iommu_group returns ENODEV to bus_set_iommu, the latter
doing so to exynos_iommu_init. Which thus error out before the init_don=
e
is set to true.

Mind restoring device_add/remove  is not that easy. Either I did not an=
d
modified add_iommu_group to return 0 if add_device was not defined. Thi=
s
works.
Otherwise I did revert this patch but had to also move the iommu_init
from iommu.c before of_iommu_init in arch/arm/kernel/setup.c (switching
iommu_init to global namespace in the process). This to avoid use of no=
t
yet initialized mutex  iommu_group_mutex and crash that follow suit.
This mutex is used in iommu_group_add_device called by
exynos_iommu_add_device.

The logs of the first issue, ie exynos_iommo_init and bus_set_iommu
returns ENODEV

[    0.602816] exynos_iommu_init: Failed to register exynos-iommu
driver.
[    0.603358] platform 13620000.sysmmu: device is not dma coherent
[    0.603384] platform 13620000.sysmmu: device is not behind an iommu
[    0.605243] exynos-sysmmu 13620000.sysmmu: genpd_dev_pm_attach()
failed to find PM domain: -2
[    0.606399] exynos_iommu_init: Failed to register exynos-iommu
driver.
[    0.607263] platform 13630000.sysmmu: device is not dma coherent
[    0.607290] platform 13630000.sysmmu: device is not behind an iommu
[    0.609111] exynos-sysmmu 13620000.sysmmu: genpd_dev_pm_attach()
failed to find PM domain: -2
[    0.609464] exynos-sysmmu 13620000.sysmmu: Unbalanced
pm_runtime_enable!
[    0.609868] exynos-sysmmu 13630000.sysmmu: genpd_dev_pm_attach()
failed to find PM domain: -2
(...)
[    0.946506] platform 10800000.g2d: device is not dma coherent
[    0.946553] platform 10800000.g2d: device is not behind an iommu
(...)



Mind the power domain failure comes from me not finding a way to apply
the power domain registration this early yet .


Best regards,
Alban Broweys


> ---
>  drivers/iommu/exynos-iommu.c | 28 ----------------------------
>  1 file changed, 28 deletions(-)
>=20
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iomm=
u.c
> index b271348a4ec1..1b3f00726cd4 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -1055,32 +1055,6 @@ static phys_addr_t exynos_iommu_iova_to_phys(s=
truct iommu_domain *domain,
>  	return phys;
>  }
> =20
> -static int exynos_iommu_add_device(struct device *dev)
> -{
> -	struct iommu_group *group;
> -	int ret;
> -
> -	group =3D iommu_group_get(dev);
> -
> -	if (!group) {
> -		group =3D iommu_group_alloc();
> -		if (IS_ERR(group)) {
> -			dev_err(dev, "Failed to allocate IOMMU group\n");
> -			return PTR_ERR(group);
> -		}
> -	}
> -
> -	ret =3D iommu_group_add_device(group, dev);
> -	iommu_group_put(group);
> -
> -	return ret;
> -}
> -
> -static void exynos_iommu_remove_device(struct device *dev)
> -{
> -	iommu_group_remove_device(dev);
> -}
> -
>  static const struct iommu_ops exynos_iommu_ops =3D {
>  	.domain_init =3D exynos_iommu_domain_init,
>  	.domain_destroy =3D exynos_iommu_domain_destroy,
> @@ -1089,8 +1063,6 @@ static const struct iommu_ops exynos_iommu_ops =
=3D {
>  	.map =3D exynos_iommu_map,
>  	.unmap =3D exynos_iommu_unmap,
>  	.iova_to_phys =3D exynos_iommu_iova_to_phys,
> -	.add_device =3D exynos_iommu_add_device,
> -	.remove_device =3D exynos_iommu_remove_device,
>  	.pgsize_bitmap =3D SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
>  };
> =20
