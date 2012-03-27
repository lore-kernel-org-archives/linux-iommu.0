From: KyongHo Cho <pullip.cho@samsung.com>
Subject: Re: [PATCH v12 3/3] iommu/exynos: Add iommu driver for Exynos Platforms
Date: Tue, 27 Mar 2012 09:08:25 +0900
Message-ID: <CAHQjnONY9f6jNLWGH+JtVOfWT42YHJxMdHtEGnDoqAL3B0M-yQ@mail.gmail.com>
References: <000301cd0286$2f4310d0$8dc93270$%cho@samsung.com>
	<001401cd0b4f$bbf0e120$33d2a360$%szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <001401cd0b4f$bbf0e120$33d2a360$%szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Subash Patel <subash.ramaswamy@linaro.org>, Younglak Kim <younglak1004.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Sanghyun Lee <sanghyun75.lee@samsung.com>, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Mar 26, 2012 at 9:55 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hello,
>
> I'm sorry for a delay, I was quite busy recently, but I have finally =
found some
> time to review the code.
No problem. Thank you.

>
> On Thursday, March 15, 2012 9:33 AM Cho KyongHo wrote:
>
>> This is the System MMU driver and IOMMU API implementation for
>> Exynos SOC platforms. Exynos platforms has more than 10 System
>> MMUs dedicated for each multimedia accelerators.
>>
>> The System MMU driver is already in arc/arm/plat-s5p but it is
>> moved to drivers/iommu due to Ohad Ben-Cohen gathered IOMMU drivers
>> there
>>
>> Any device driver in Exynos platforms that needs to control its
>> System MMU must call platform_set_sysmmu() to inform System MMU
>> driver who will control it.
>> platform_set_sysmmu() is defined in <mach/sysmmu.h>
>>
>> Cc: Joerg Roedel <joerg.roedel@amd.com>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
>
>
> (snipped)
>
>> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iom=
mu.c
>> new file mode 100644
>> index 0000000..b8daf7c
>> --- /dev/null
>> +++ b/drivers/iommu/exynos-iommu.c
>> @@ -0,0 +1,1057 @@
>> +/* linux/drivers/iommu/exynos_iommu.c
>> + *
>> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
>> + * =A0 =A0 =A0 =A0 =A0 http://www.samsung.com
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + */
>
> (snipped)
>
>> +static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
>> +{
>> + =A0 =A0 /* SYSMMU is in blocked when interrupt occurred. */
>> + =A0 =A0 struct sysmmu_drvdata *data =3D dev_id;
>> + =A0 =A0 struct resource *irqres;
>> + =A0 =A0 struct platform_device *pdev;
>> + =A0 =A0 enum exynos_sysmmu_inttype itype;
>> + =A0 =A0 unsigned long addr =3D -1;
>> +
>> + =A0 =A0 int i, ret =3D -ENOSYS;
>> +
>> + =A0 =A0 read_lock(&data->lock);
>> +
>> + =A0 =A0 WARN_ON(!is_sysmmu_active(data));
>> +
>> + =A0 =A0 pdev =3D to_platform_device(data->sysmmu);
>> + =A0 =A0 for (i =3D 0; i < pdev->num_resources; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 irqres =3D platform_get_resource(pdev, IOR=
ESOURCE_IRQ, i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (irqres && ((int)irqres->start =3D=3D i=
rq))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (i =3D=3D pdev->num_resources) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 itype =3D SYSMMU_FAULT_UNKNOWN;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 i /=3D 2;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 itype =3D (enum exynos_sysmmu_inttype)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(__raw_readl(data->sf=
rbases[i] + REG_INT_STATUS));
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (WARN_ON(!((itype >=3D 0) && (itype < S=
YSMMU_FAULT_UNKNOWN))))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 itype =3D SYSMMU_FAULT_UNK=
NOWN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D __raw_readl(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->sfrb=
ases[i] + fault_reg_offset[itype]);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (data->domain)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D report_iommu_fault(data->domain, d=
ata->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr, ityp=
e);
>> +
>> + =A0 =A0 if ((ret =3D=3D -ENOSYS) && data->fault_handler) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned long base =3D data->pgtable;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (itype !=3D SYSMMU_FAULT_UNKNOWN)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D __raw_readl(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 data->sfrbases[i] + REG_PT_BASE_ADDR);
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D data->fault_handler(itype, base, a=
ddr);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (!ret && (itype !=3D SYSMMU_FAULT_UNKNOWN))
>> + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(1 << itype, data->sfrbases[i]=
 + REG_INT_CLEAR);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(data->sysmmu, "(%s) %s is not hand=
led.\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->dbgn=
ame, sysmmu_fault_name[itype]);
>> +
>> + =A0 =A0 if (itype !=3D SYSMMU_FAULT_UNKNOWN)
>> + =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_unblock(data->sfrbases[i]);
>> +
>> + =A0 =A0 read_unlock(&data->lock);
>> +
>> + =A0 =A0 return IRQ_HANDLED;
>> +}
>
> (snipped)
>
>> +static int exynos_sysmmu_probe(struct platform_device *pdev)
>> +{
>> + =A0 =A0 int i, ret;
>> + =A0 =A0 struct device *dev;
>> + =A0 =A0 struct sysmmu_drvdata *data;
>> +
>> + =A0 =A0 dev =3D &pdev->dev;
>> +
>> + =A0 =A0 data =3D kzalloc(sizeof(*data), GFP_KERNEL);
>> + =A0 =A0 if (!data) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "Not enough memory\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_alloc;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D dev_set_drvdata(dev, data);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "Unabled to initialize driver=
 data\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_init;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 data->nsfrs =3D pdev->num_resources / 2;
>> + =A0 =A0 data->sfrbases =3D kmalloc(sizeof(*data->sfrbases) * data-=
>nsfrs,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL);
>> + =A0 =A0 if (data->sfrbases =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "Not enough memory\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_init;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 for (i =3D 0; i < data->nsfrs; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct resource *res;
>> + =A0 =A0 =A0 =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESO=
URCE_MEM, i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!res) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "Unable to fi=
nd IOMEM region\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOENT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_res;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 data->sfrbases[i] =3D ioremap(res->start, =
resource_size(res));
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!data->sfrbases[i]) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "Unable to ma=
p IOMEM @ PA:%#x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->start);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOENT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_res;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 for (i =3D 0; i < data->nsfrs; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D platform_get_irq(pdev, i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret <=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "Unable to fi=
nd IRQ resource\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_irq;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D request_irq(ret, exynos_sysmmu_irq=
, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 dev_name(dev), data);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "Unabled to r=
egister interrupt handler\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_irq;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>
> Please look at those loops and the interrupt function above. Those fo=
r-loops over
> all the resources looks really ugly and makes the driver less portabl=
e. The previous
> version (v8 afair) had much cleaned design.
>
I agree.
It might look unclear and the previous version is straightforward desig=
n.
=46or some devices like MFC and ISP, many system MMUs pretend
that they are a single device.

> It would be better not to squash multiple sysmmu controllers into a s=
ingle instance
> of the driver. Please keep the driver simple. Sysmmu driver's resourc=
e should consist
> only of one io register area and one irq, nothing more. Such approach=
 will remove
> the need for all that custom data in platform_data and it also make t=
he future
> integration much easier for other non-samsung platforms (the sysmmu h=
ardware is also
> used by other hw vendors). Support for device tree is also easier to =
add if the device
> driver is kept simple (supporting only one instance of the hardware b=
lock).
>
The current change that a single device descriptor for many System
MMUs keeps all other
parts of this device driver simpler. The only 2 parts of the driver,
probe() and interrupt handler
look unclear. A disadvantages of this change is that this driver needs
platform_data
and the definition of the data structure stored in the platform_data.

> The only reason I can see, which might have suggested you to squash h=
ardware sysmmu
> controllers into one single instance was to provide the same virtual =
io mappings
> for all these sub-devices (it is mainly used by fims-isp complex bloc=
k).
>
True.
But there is another reason, atomicity.
Enabling and disabling System MMU is in race condition. MFC driver
enables System MMU
before decoding a frame and disables it after decoding a frame, for exa=
mple.
Enabling and disabling it can be performed in different process
contexts. System MMU is
enabled in normal context but disabled in interrupt context.
To protect enabling several system MMUs from racing, the entire region
that includes
from pm_runtime_get_sync() to accessing control registers must be
inside a spinlock
with IRQ disabled. Otherwise, a System MMU may be enabled while
another System MMU is
disabled at a moment even though they are in a block.
However, as you know, pm_runtime_get_sync() is a blocking function.

BTW, the problem can be solved in other way you may agree.

> This can be achieved in a much clearer design by using one, common io=
mmu domain
> and attaching all these separate iommu controllers to it. Of course t=
his will also
> require having a separate platform devices for each sub-device, but s=
ooner or later
> you will need them anyway. The good example here is the MFC module, w=
hich already
> have separate devices: mfc_l and mfc_r for each memory controller.
>
Ok. I will look into MFC driver about your opinion.

>> + =A0 =A0 if (dev_get_platdata(dev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 char *deli, *beg;
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct sysmmu_platform_data *platdata =3D =
dev_get_platdata(dev);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 beg =3D platdata->clockname;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 for (deli =3D beg; (*deli !=3D '\0') && (*=
deli !=3D ','); deli++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* NOTHING */;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (*deli =3D=3D '\0')
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 deli =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *deli =3D '\0';
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 data->clk[0] =3D clk_get(dev, beg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(data->clk[0])) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->clk[0] =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "No clock des=
criptor registered\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (data->clk[0] && deli) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *deli =3D ',';
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->clk[1] =3D clk_get(d=
ev, deli + 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(data->clk[1]))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->clk[=
1] =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 data->dbgname =3D platdata->dbgname;
>> + =A0 =A0 }
>
> Passing clocks via platform data is also considered as a bad idea, es=
pecially if
> you need to parse string to extract the clock names. It would be much=
 cleaner to
> have 2 (or more if required) variants of sysmmu driver, each one for =
a different
> version of the sysmmu hardware (I noticed only that some of the sysmm=
u units
> require one clock, the other require 2 clocks).

I agree. Thanks.
The reason of this approach is a block that has many System MMUs like I=
SP.
Their clock gating sources are spread into 2 control registers.

Thank you for review.

KyongHo
