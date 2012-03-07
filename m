From: InKi Dae <daeinki@gmail.com>
Subject: Re: [PATCH v10 3/3] iommu/exynos: Add iommu driver for Exynos Platforms
Date: Wed, 7 Mar 2012 14:28:13 +0900
Message-ID: <CAAQKjZNJHeApuiyh467w8wGaY8VFb_PqLrvHGUxmE8-+a4yRTA@mail.gmail.com>
References: <002201ccfb73$93311520$b9933f60$%cho@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <002201ccfb73$93311520$b9933f60$%cho@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: pullip.cho@samsung.com
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Joerg Roedel <joro@8bytes.org>, Subash Patel <subash.ramaswamy@linaro.org>, Younglak Kim <younglak1004.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Sanghyun Lee <sanghyun75.lee@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

> +static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
> +{
> + =A0 =A0 =A0 /* SYSMMU is in blocked when interrupt occurred. */
> + =A0 =A0 =A0 struct sysmmu_drvdata *data =3D dev_id;
> + =A0 =A0 =A0 struct resource *irqres;
> + =A0 =A0 =A0 struct platform_device *pdev;
> + =A0 =A0 =A0 enum EXYNOS_SYSMMU_INTERRUPT_TYPE itype;

how about to change EXYNOS_SYSMMU_INTERRUPT_TYPE to small letter? just
for code clean.

> + =A0 =A0 =A0 unsigned long addr =3D -1;
> +
> + =A0 =A0 =A0 int i, ret =3D -ENOSYS;
> +
> + =A0 =A0 =A0 read_lock(&data->lock);
> +
> + =A0 =A0 =A0 WARN_ON(!is_sysmmu_active(data));
> +
> + =A0 =A0 =A0 pdev =3D to_platform_device(data->sysmmu);
> + =A0 =A0 =A0 for (i =3D 0; i < pdev->num_resources; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 irqres =3D platform_get_resource(pdev, =
IORESOURCE_IRQ, i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (irqres && ((int)irqres->start =3D=3D=
 irq))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }

is there any reason that it should get irq resources in interrupt
handler? if not so then how about to move it into probe()?

> +
> + =A0 =A0 =A0 if (i =3D=3D pdev->num_resources) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 itype =3D SYSMMU_FAULT_UNKNOWN;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i /=3D 2;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 itype =3D (enum EXYNOS_SYSMMU_INTERRUPT=
_TYPE)

ditto.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(__raw_readl(data-=
>sfrbases[i] + REG_INT_STATUS));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (WARN_ON(!((itype >=3D 0) && (itype =
< SYSMMU_FAULT_UNKNOWN))))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 itype =3D SYSMMU_FAULT_=
UNKNOWN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D __raw_readl(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->s=
frbases[i] + fault_reg_offset[itype]);
> + =A0 =A0 =A0 }
> +
