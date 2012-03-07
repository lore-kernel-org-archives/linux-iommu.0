From: KyongHo Cho <pullip.cho@samsung.com>
Subject: Re: [PATCH v10 3/3] iommu/exynos: Add iommu driver for Exynos Platforms
Date: Wed, 7 Mar 2012 15:22:33 +0900
Message-ID: <CAHQjnOOQKS1EU-3zWDDq2sLxPucY9CRZyrnaT5cyyrSa9-k9Nw@mail.gmail.com>
References: <002201ccfb73$93311520$b9933f60$%cho@samsung.com>
	<CAAQKjZNJHeApuiyh467w8wGaY8VFb_PqLrvHGUxmE8-+a4yRTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAAQKjZNJHeApuiyh467w8wGaY8VFb_PqLrvHGUxmE8-+a4yRTA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: InKi Dae <daeinki@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Joerg Roedel <joro@8bytes.org>, Subash Patel <subash.ramaswamy@linaro.org>, Younglak Kim <younglak1004.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Sanghyun Lee <sanghyun75.lee@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 7, 2012 at 2:28 PM, InKi Dae <daeinki@gmail.com> wrote:
>> +static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
>> +{
>> + =A0 =A0 =A0 /* SYSMMU is in blocked when interrupt occurred. */
>> + =A0 =A0 =A0 struct sysmmu_drvdata *data =3D dev_id;
>> + =A0 =A0 =A0 struct resource *irqres;
>> + =A0 =A0 =A0 struct platform_device *pdev;
>> + =A0 =A0 =A0 enum EXYNOS_SYSMMU_INTERRUPT_TYPE itype;
>
> how about to change EXYNOS_SYSMMU_INTERRUPT_TYPE to small letter? jus=
t
> for code clean.
>
I will. please refer to the my reply to Kyungmin Park.

>> + =A0 =A0 =A0 unsigned long addr =3D -1;
>> +
>> + =A0 =A0 =A0 int i, ret =3D -ENOSYS;
>> +
>> + =A0 =A0 =A0 read_lock(&data->lock);
>> +
>> + =A0 =A0 =A0 WARN_ON(!is_sysmmu_active(data));
>> +
>> + =A0 =A0 =A0 pdev =3D to_platform_device(data->sysmmu);
>> + =A0 =A0 =A0 for (i =3D 0; i < pdev->num_resources; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 irqres =3D platform_get_resource(pdev,=
 IORESOURCE_IRQ, i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (irqres && ((int)irqres->start =3D=3D=
 irq))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 }
>
> is there any reason that it should get irq resources in interrupt
> handler? if not so then how about to move it into probe()?
>
The platform device of ISP has a lot of IRQ sources.
The above for clause determines which IRQ source (System MMU)
generated the interrupt.

>> +
>> + =A0 =A0 =A0 if (i =3D=3D pdev->num_resources) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 itype =3D SYSMMU_FAULT_UNKNOWN;
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i /=3D 2;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 itype =3D (enum EXYNOS_SYSMMU_INTERRUP=
T_TYPE)
>
> ditto.
>

Thank you.

Cho KyongHo.
