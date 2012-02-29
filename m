From: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v9 1/2] ARM: EXYNOS: Change System MMU platform device
	definitions
Date: Wed, 29 Feb 2012 09:25:54 +0900
Message-ID: <CAHQjnOO1aADVQWxNt-J3nb0bgJvc2dfk+6qTWKWx7w+-LUVSmw@mail.gmail.com>
References: <001901ccf5e3$6a363320$3ea29960$%cho@samsung.com>
	<CAH9JG2Uvh=_GWFWyBrE-hfGTvrwvs6n37bmKaHbCovJ++EeJ7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAH9JG2Uvh=_GWFWyBrE-hfGTvrwvs6n37bmKaHbCovJ++EeJ7g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Subash Patel <subash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Younglak Kim <younglak1004.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sanghyun Lee <sanghyun75.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 28, 2012 at 4:20 PM, Kyungmin Park
<kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> Hi,
>
> On 2/28/12, KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>> Handling System MMUs with an identifier is not flexible to manage
>> System MMU platform devices because of the following reasons:
>> 1. A device driver which needs to handle System MMU must know the ID.
>> 2. A System MMU may not present in some implementations of Exynos family.
>> 3. Handling System MMU with IOMMU API does not require an ID.
>>
>> This patch is the result of removing ID of System MMUs.
>> Instead, a device driver that needs to handle its System MMU must
>> use IOMMU API while its descriptor of platform device is given.
>>
>> This patch also includes the following enhancements:
>> - A System MMU device becomes a child if its power domain device.
>> - clkdev
>>
>> Signed-off-by: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> ---
>> =A0arch/arm/mach-exynos/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 11 +-
>> =A0arch/arm/mach-exynos/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A02 +-
>> =A0arch/arm/mach-exynos/clock-exynos4.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 79 =
++--
>> =A0arch/arm/mach-exynos/clock-exynos4.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 +
>> =A0arch/arm/mach-exynos/clock-exynos4210.c =A0 =A0 =A0 =A0 | =A0 11 +
>> =A0arch/arm/mach-exynos/clock-exynos4212.c =A0 =A0 =A0 =A0 | =A0 28 ++-
>> =A0arch/arm/mach-exynos/clock-exynos5.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 90 =
+++++
>> =A0arch/arm/mach-exynos/dev-sysmmu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0451
>> ++++++++++++-----------
>> =A0arch/arm/mach-exynos/include/mach/irqs.h =A0 =A0 =A0 =A0| =A0179 ++++=
+-----
>> =A0arch/arm/mach-exynos/include/mach/map.h =A0 =A0 =A0 =A0 | =A0 38 ++
>> =A0arch/arm/mach-exynos/include/mach/regs-clock.h =A0| =A0 =A05 +
>> =A0arch/arm/mach-exynos/include/mach/regs-sysmmu.h | =A0 28 --
>> =A0arch/arm/mach-exynos/include/mach/sysmmu.h =A0 =A0 =A0| =A0 84 +++--
>> =A0arch/arm/mach-exynos/mach-armlex4210.c =A0 =A0 =A0 =A0 =A0| =A0 =A01 -
>> =A0arch/arm/mach-exynos/mach-smdkv310.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
1 -
>> =A0arch/arm/plat-s5p/sysmmu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 13 +-
>> =A0arch/arm/plat-samsung/include/plat/devs.h =A0 =A0 =A0 | =A0 =A01 -
>> =A017 files changed, 618 insertions(+), 406 deletions(-)
> It's too big to cover these changes. Can you make it more small changes.
> 1. Remove existing ones since no user at this time.
> 2. Add new define and data structures.
> 3. Support new system mmu features based on generic iommu.
>

Your suggestion sounds good. Thank you.

>> =A0static int exynos4_clk_hdmiphy_ctrl(struct clk *clk, int enable)
>> =A0{
>> =A0 =A0 =A0 return s5p_gatectrl(S5P_HDMI_PHY_CONTROL, clk, enable);
>> @@ -679,61 +684,55 @@ static struct clk exynos4_init_clocks_off[] =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exynos4_clk_ip_p=
eril_ctrl,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 << 14),
>> =A0 =A0 =A0 }, {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "SYSMMU_MDMA",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMMU_CLOCK_NAM=
E,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_CLOCK_DEVNA=
ME(mfc_l, 0),
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exynos4_clk_ip_mfc=
_ctrl,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 << 1),
>> + =A0 =A0 }, {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMMU_CLOCK_NAM=
E,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_CLOCK_DEVNA=
ME(mfc_r, 1),
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exynos4_clk_ip_mfc=
_ctrl,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 << 2),
>> + =A0 =A0 }, {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMMU_CLOCK_NAM=
E,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_CLOCK_DEVNA=
ME(tv, 2),
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exynos4_clk_ip_tv_=
ctrl,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 << 4),
>> + =A0 =A0 }, {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMMU_CLOCK_NAM=
E,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_CLOCK_DEVNA=
ME(jpeg, 3),
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exynos4_clk_ip_cam=
_ctrl,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 << 11),
>> + =A0 =A0 }, {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMMU_CLOCK_NAM=
E,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_CLOCK_DEVNA=
ME(rot, 4),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exynos4_clk_ip_i=
mage_ctrl,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 << 5),
>> + =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 << 4),
>> =A0 =A0 =A0 }, {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "SYSMMU_FIMC0",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D SYSMMU_CLOCK_NAM=
E,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D SYSMMU_CLOCK_DEVNA=
ME(gsc0, 5),
> It's exynos4 series clock and don't have gsc name. I don't know LSI
> decides to use gsc instead of fimc for both exynos4 and exynos5. but
> there's no name gsc at Spec..

gsc0 is just a name of the platform device of FIMC0 in Exynos4.
It is also used for GSclaler0 in Exynos5.
I wanted to reduce waste of platform device definitions that do not exist
in an application processor.

If it looks confused, I will find another way.
>> +#define SYSMMU_RESOURCE_NAME(core, ipname) sysmmures_##core##_##ipname
>> +
>> +#define SYSMMU_RESOURCE(core, ipname) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 static struct resource SYSMMU_RESOURCE_NAME(core, ipname)[] __=
initdata =3D
>> +
>> +#define DEFINE_SYSMMU_RESOURCE(core, mem, irq) =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 DEFINE_RES_MEM_NAMED(core##_PA_SYSMMU_##mem, SZ_4K, #mem), =A0=
 =A0 =A0\
>> + =A0 =A0 DEFINE_RES_IRQ_NAMED(core##_IRQ_SYSMMU_##irq##_0, #mem)
>> +
>> +#define SYSMMU_RESOURCE_DEFINE(core, ipname, mem, irq) =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 SYSMMU_RESOURCE(core, ipname) { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 DEFINE_SYSMMU_RESOURCE(core, mem, irq) =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 }
>>
>> -struct platform_device exynos4_device_sysmmu =3D {
>> - =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "s5p-sysmmu",
>> - =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 32,
>> - =A0 =A0 .num_resources =A0=3D ARRAY_SIZE(exynos4_sysmmu_resource),
>> - =A0 =A0 .resource =A0 =A0 =A0 =3D exynos4_sysmmu_resource,
>> +struct sysmmu_resource_map {
>> + =A0 =A0 struct platform_device *pdev;
>> + =A0 =A0 struct resource *res;
>> + =A0 =A0 u32 rnum;
>> + =A0 =A0 struct device *pdd;
>> + =A0 =A0 char *clocknames;
>> =A0};
>> -EXPORT_SYMBOL(exynos4_device_sysmmu);
>>
>> -static struct clk *sysmmu_clk[S5P_SYSMMU_TOTAL_IPNUM];
>> -void sysmmu_clk_init(struct device *dev, sysmmu_ips ips)
>> -{
>> - =A0 =A0 sysmmu_clk[ips] =3D clk_get(dev, sysmmu_ips_name[ips]);
>> - =A0 =A0 if (IS_ERR(sysmmu_clk[ips]))
>> - =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_clk[ips] =3D NULL;
>> - =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 clk_put(sysmmu_clk[ips]);
>> +#define SYSMMU_RESOURCE_MAPPING(core, ipname, resname) { =A0 =A0 =A0 =
=A0 =A0 =A0 \
>> + =A0 =A0 .pdev =3D &SYSMMU_PLATDEV(ipname), =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 .res =3D SYSMMU_RESOURCE_NAME(EXYNOS##core, resname), =A0 =A0 =
=A0 =A0 =A0 =A0 \
>> + =A0 =A0 .rnum =3D ARRAY_SIZE(SYSMMU_RESOURCE_NAME(EXYNOS##core, resnam=
e)),\
>> + =A0 =A0 .clocknames =3D SYSMMU_CLOCK_NAME, =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> =A0}
>>
>> -void sysmmu_clk_enable(sysmmu_ips ips)
>> -{
>> - =A0 =A0 if (sysmmu_clk[ips])
>> - =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(sysmmu_clk[ips]);
>> +#define SYSMMU_RESOURCE_MAPPING_MC(core, ipname, resname, pdata) { =A0 \
>> + =A0 =A0 .pdev =3D &SYSMMU_PLATDEV(ipname), =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 .res =3D SYSMMU_RESOURCE_NAME(EXYNOS##core, resname), =A0 =A0 =
=A0 =A0 =A0 =A0 \
>> + =A0 =A0 .rnum =3D ARRAY_SIZE(SYSMMU_RESOURCE_NAME(EXYNOS##core, resnam=
e)),\
>> + =A0 =A0 .clocknames =3D SYSMMU_CLOCK_NAME "," SYSMMU_CLOCK_NAME2, =A0 =
=A0 =A0 =A0 \
>> +}
>> +
>> +#ifdef CONFIG_EXYNOS_DEV_PD
>> +#define SYSMMU_RESOURCE_MAPPING_PD(core, ipname, resname, pd) { =A0 =A0=
 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 .pdev =3D &SYSMMU_PLATDEV(ipname), =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 .res =3D &SYSMMU_RESOURCE_NAME(EXYNOS##core, resname), =A0 =A0=
 =A0 =A0 =A0 =A0\
>> + =A0 =A0 .rnum =3D ARRAY_SIZE(SYSMMU_RESOURCE_NAME(EXYNOS##core, resnam=
e)),\
>> + =A0 =A0 .clocknames =3D SYSMMU_CLOCK_NAME, =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 .pdd =3D &exynos##core##_device_pd[pd].dev, =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> +}
>> +
>> +#define SYSMMU_RESOURCE_MAPPING_MCPD(core, ipname, resname, pd, pdata) =
{\
>> + =A0 =A0 .pdev =3D &SYSMMU_PLATDEV(ipname), =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 .res =3D &SYSMMU_RESOURCE_NAME(EXYNOS##core, resname), =A0 =A0=
 =A0 =A0 =A0 =A0\
>> + =A0 =A0 .rnum =3D ARRAY_SIZE(SYSMMU_RESOURCE_NAME(EXYNOS##core, resnam=
e)),\
>> + =A0 =A0 .clocknames =3D SYSMMU_CLOCK_NAME "," SYSMMU_CLOCK_NAME2, =A0 =
=A0 =A0 =A0 \
>> + =A0 =A0 .pdd =3D &exynos##core##_device_pd[pd].dev, =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> =A0}
>> +#else
>> +#define SYSMMU_RESOURCE_MAPPING_PD(core, ipname, resname, pd) =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING(core, ipname, resname)
>> +#define SYSMMU_RESOURCE_MAPPING_MCPD(core, ipname, resname, pd, pdata) =
=A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 SYSMMU_RESOURCE_MAPPING_MC(core, ipname, resna=
me, pdata)
>> +
>> +#endif /* CONFIG_EXYNOS_DEV_PD */
>> +
>> +#ifdef CONFIG_ARCH_EXYNOS4
> Below definitions are almost __initdata. So don't need to use ARCH_EXYNOS=
4.
> and another reason is that it can detect the duplicated entry if it's
> used both exynos4 and exynos5.

True. I agree.
Thank you.

>> +SYSMMU_RESOURCE_DEFINE(EXYNOS4, fimc0, =A0 =A0 =A0 FIMC0, =A0FIMC0);
>> +SYSMMU_RESOURCE_DEFINE(EXYNOS4, fimc1, =A0 =A0 =A0 FIMC1, =A0FIMC1);
>> +SYSMMU_RESOURCE_DEFINE(EXYNOS4, fimc2, =A0 =A0 =A0 FIMC2, =A0FIMC2);
>> +SYSMMU_RESOURCE_DEFINE(EXYNOS4, fimc3, =A0 =A0 =A0 FIMC3, =A0FIMC3);
>> +SYSMMU_RESOURCE_DEFINE(EXYNOS4, jpeg, =A0 =A0 =A0 =A0JPEG, =A0 JPEG);
>> +SYSMMU_RESOURCE_DEFINE(EXYNOS4, 2d, =A0G2D, =A0 =A02D);
>> +SYSMMU_RESOURCE_DEFINE(EXYNOS4, tv, =A0TV, =A0 =A0 TV_M0);
>> +SYSMMU_RESOURCE_DEFINE(EXYNOS4, 2d_acp, =A0 =A0 =A02D_ACP, 2D);
>> +SYSMMU_RESOURCE_DEFINE(EXYNOS4, rot, ROTATOR, ROTATOR);
>> +SYSMMU_RESOURCE_DEFINE(EXYNOS4, fimd0, =A0 =A0 =A0 FIMD0, =A0LCD0_M0);
>> +SYSMMU_RESOURCE_DEFINE(EXYNOS4, fimd1, =A0 =A0 =A0 FIMD1, =A0LCD1_M1);
>> +SYSMMU_RESOURCE_DEFINE(EXYNOS4, flite0, =A0 =A0 =A0FIMC_LITE0, FIMC_LIT=
E0);
>> +SYSMMU_RESOURCE_DEFINE(EXYNOS4, flite1, =A0 =A0 =A0FIMC_LITE1, FIMC_LIT=
E1);
>> +SYSMMU_RESOURCE_DEFINE(EXYNOS4, mfc_r, =A0 =A0 =A0 MFC_R, =A0MFC_M0);
>> +SYSMMU_RESOURCE_DEFINE(EXYNOS4, mfc_l, =A0 =A0 =A0 MFC_L, =A0MFC_M1);
>> +SYSMMU_RESOURCE(EXYNOS4, isp) {
>> + =A0 =A0 DEFINE_SYSMMU_RESOURCE(EXYNOS4, FIMC_ISP, FIMC_ISP),
>> + =A0 =A0 DEFINE_SYSMMU_RESOURCE(EXYNOS4, FIMC_DRC, FIMC_DRC),
>> + =A0 =A0 DEFINE_SYSMMU_RESOURCE(EXYNOS4, FIMC_FD, FIMC_FD),
>> + =A0 =A0 DEFINE_SYSMMU_RESOURCE(EXYNOS4, ISPCPU, FIMC_CX),
>> +};
>> +
