From: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v10 3/3] iommu/exynos: Add iommu driver for Exynos
	Platforms
Date: Wed, 7 Mar 2012 10:24:56 +0900
Message-ID: <CAHQjnOOCFqSNtvvvvd54yFvrrnPJmZQhi3LXT8jZArcEhjePXQ@mail.gmail.com>
References: <002201ccfb73$93311520$b9933f60$%cho@samsung.com>
	<CAH9JG2W=E7xmEO3o+up5a5Vm1PrPp60w0cfzN7=bYQO2BX1teA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAH9JG2W=E7xmEO3o+up5a5Vm1PrPp60w0cfzN7=bYQO2BX1teA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Kyungmin Park <kmpark-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, =?UTF-8?B?64yA7J246riw?= <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Younglak Kim <younglak1004.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Subash Patel <subash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sanghyun Lee <sanghyun75.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 6, 2012 at 10:13 PM, Kyungmin Park <kmpark-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> wrote:
> On Tue, Mar 6, 2012 at 5:31 PM, KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrot=
e:
>> HAALgBjAGgAbwBAAHMAYQBtAHMAdQBuAGcALgBjAG8AbQA=3D;Tue,
>> =A006 Mar 2012 08:31:29 GMT;WwBQAEEAVABDAEgAIAB2ADEAMAAgADMALwAzAF0AIABp=
AG8AbQBtAHUALwBlAHgAeQBuAG8AcwA6ACAAQQBkAGQAIABpAG8AbQBtAHUAIABkAHIAaQB2AGU=
AcgAgAGYAbwByACAARQB4AHkAbgBvAHMAIABQAGwAYQB0AGYAbwByAG0AcwA=3D
>> x-cr-puzzleid: {CF0AAF04-8639-4D69-B4E1-BF71EA1B0A70}
> What's this?
I think it is inserted by Outlook and it was not found in the email editor
before sending this patch. I am unable to use sendmail due to security
reason in my company.
I will find a way not to insert the above message. Thank you.

>>
>> This is the System MMU driver and IOMMU API implementation for
>> Exynos SOC platforms. Exynos platforms has more than 10 System
>> MMUs dedicated for each multimedia accellerators.
>>
>> The System MMU driver is already in arc/arm/plat-s5p but it is
>> moved to drivers/iommu due to Ohad Ben-Cohen gathered IOMMU drivers
>> there
>>
>> Any device driver in Exynos platforms that needs to control its
>> System MMU must call platform_set_sysmmu() to inform System MMU
>> driver who will control it.
>> platform_set_sysmmu() is defined in <mach/sysmmu.h>
> Does it really required? if we can remove it. it can be compiled
> without arch dependency.
The function must be called while board initialization and all source files=
 for
the purpose is placed in 'mach' directory. Thus device driver is not depend=
ent
on arch except the definition of data structure conveyed in
device.platform_data.

Since our System MMUs are attached to each peripheral devices, it is requir=
ed
to define relationships between System MMUs and peripheral devices.
platform_set_sysmmu() defines the relationship.

>> +
>> +#ifdef CONFIG_EXYNOS_IOMMU_DEBUG
>> +#define DEBUG
>> +#endif
> If it's used only at here. you can add it at Makefile.
>
> ifeq ($(CONFIG_EXYNOS_IOMMU_DEBUG),y)
> =A0 =A0 =A0 =A0 CFLAGS-exynos-iommu =A0 =A0 =A0 =A0+=3D -DDEBUG
> endif
>
> Of course you can select as your preference.

Thank you for advice.

>> +
>> +#define lv2ent_fault(pent) ((*(pent) & 3) =3D=3D 0)
>> +#define lv2ent_small(pent) ((*(pent) & 2) =3D=3D 2)
> #define lv2ent_small(pent) ((*(pent) & 3) =3D=3D 2)?

The last bit is 'don't-care'.
It is intentionally ignored in the above comparison.

>> +
>> +#define REG_MMU_CTRL =A0 =A0 =A0 =A0 =A0 0x000
>> +#define REG_MMU_CFG =A0 =A0 =A0 =A0 =A0 =A00x004
>> +#define REG_MMU_STATUS =A0 =A0 =A0 =A0 0x008
>> +#define REG_MMU_FLUSH =A0 =A0 =A0 =A0 =A00x00C
>> +#define REG_MMU_FLUSH_ENTRY =A0 =A00x010
>> +#define REG_PT_BASE_ADDR =A0 =A0 =A0 0x014
>> +#define REG_INT_STATUS =A0 =A0 =A0 =A0 0x018
>> +#define REG_INT_CLEAR =A0 =A0 =A0 =A0 =A00x01C
>> +#define REG_MMU_VERSION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x034
> Please place it in order.

I found that a mistake while defining the offsets of control registers.
I will fix it.

>> +
>> +enum EXYNOS_SYSMMU_INTERRUPT_TYPE {
>> + =A0 =A0 =A0 SYSMMU_PAGEFAULT,
>> + =A0 =A0 =A0 SYSMMU_AR_MULTIHIT,
>> + =A0 =A0 =A0 SYSMMU_AW_MULTIHIT,
>> + =A0 =A0 =A0 SYSMMU_BUSERROR,
>> + =A0 =A0 =A0 SYSMMU_AR_SECURITY,
>> + =A0 =A0 =A0 SYSMMU_AR_ACCESS,
>> + =A0 =A0 =A0 SYSMMU_AW_SECURITY,
>> + =A0 =A0 =A0 SYSMMU_AW_PROTECTION, /* 7 */
>> + =A0 =A0 =A0 SYSMMU_FAULT_UNKNOWN,
>> + =A0 =A0 =A0 SYSMMU_FAULTS_NUM
> missing comma, "SYSMMU_FAULTS_NUM,"
Yes it is. I don't think that it is needed to appending comma after
the last element
unless it is predictable that adding elements after the last element
in the future.

>> +};
>> +
>> +typedef int (*sysmmu_fault_handler_t)(enum EXYNOS_SYSMMU_INTERRUPT_TYPE=
 itype,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long pgtable_base=
, unsigned long fault_addr);
>> +
>> +static unsigned short fault_reg_offset[SYSMMU_FAULTS_NUM] =3D {
>> + =A0 =A0 =A0 REG_PAGE_FAULT_ADDR,
>> + =A0 =A0 =A0 REG_AR_FAULT_ADDR,
>> + =A0 =A0 =A0 REG_AW_FAULT_ADDR,
>> + =A0 =A0 =A0 REG_DEFAULT_SLAVE_ADDR,
>> + =A0 =A0 =A0 REG_AR_FAULT_ADDR,
>> + =A0 =A0 =A0 REG_AR_FAULT_ADDR,
>> + =A0 =A0 =A0 REG_AW_FAULT_ADDR,
>> + =A0 =A0 =A0 REG_AW_FAULT_ADDR
> ditto.
Answered above.

>> +};
>> +
>> +static char *sysmmu_fault_name[SYSMMU_FAULTS_NUM] =3D {
>> + =A0 =A0 =A0 "PAGE FAULT",
>> + =A0 =A0 =A0 "AR MULTI-HIT FAULT",
>> + =A0 =A0 =A0 "AW MULTI-HIT FAULT",
>> + =A0 =A0 =A0 "BUS ERROR",
>> + =A0 =A0 =A0 "AR SECURITY PROTECTION FAULT",
>> + =A0 =A0 =A0 "AR ACCESS PROTECTION FAULT",
>> + =A0 =A0 =A0 "AW SECURITY PROTECTION FAULT",
>> + =A0 =A0 =A0 "AW ACCESS PROTECTION FAULT",
>> + =A0 =A0 =A0 "UNKNOWN FAULT"
> ditto.
Answered above.

>> +void exynos_sysmmu_set_prefbuf(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned l=
ong base0, unsigned long size0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned l=
ong base1, unsigned long size1)
>> +{
>> + =A0 =A0 =A0 struct sysmmu_drvdata *data =3D dev_get_drvdata(dev->archd=
ata.iommu);
>> + =A0 =A0 =A0 unsigned long flags;
>> + =A0 =A0 =A0 int i;
>> +
>> + =A0 =A0 =A0 BUG_ON((base0 + size0) <=3D base0);
>> + =A0 =A0 =A0 BUG_ON((size1 > 0) && ((base1 + size1) <=3D base1));
> It's bogus check. it's impossible. Do you think overflow case?
Yes I do.
It is prepared to detect invalid parameters from device drivers.

>> +
>> + =A0 =A0 =A0 read_lock_irqsave(&data->lock, flags);
>> + =A0 =A0 =A0 if (!is_sysmmu_active(data))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto finish;
>> +
>> + =A0 =A0 =A0 for (i =3D 0; i < data->nsfrs; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((readl(data->sfrbases[i] + S5P_MMU_VER=
SION) >> 28) =3D=3D 3) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_block(data->sfrbase=
s[i]);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (size1 =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (size0 =
<=3D SZ_128K) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 base1 =3D base0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 size1 =3D size0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 size1 =3D size0 -
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 ALIGN(size0 / 2, SZ_64K);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 size0 =3D size0 - size1;
> Umm I mis-understand this codes at first. it think size1 has 0
> already. so it's meaning-less but now it re-use the size1 above.

Let me explain how this function works.
This function can accepts 2 memory regions to specify in the registers
of System MMU.
It is simple a device driver defines 2 memory regions but this function all=
ows
it to define just one memory region and specify second regions as zero.
If the second regions is zero, this function divides the first region
into 2 regions
and specifies those regions into the registers of System MMU.

>> +void exynos_sysmmu_set_fault_handler(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 sysmmu_fault_handler_t handler)
>> +{
>> + =A0 =A0 =A0 struct sysmmu_drvdata *data =3D dev_get_drvdata(dev->archd=
ata.iommu);
>> +
>> + =A0 =A0 =A0 __set_fault_handler(data, handler);
>> +}
>> +
>> +static int default_fault_handler(enum EXYNOS_SYSMMU_INTERRUPT_TYPE ityp=
e,
> Can you use the small letter instead of large one? do you see codes like =
this?
Ok. I will make it lower case.

>> +static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *domai=
n,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 unsigned long iova)
>> +{
>> + =A0 =A0 =A0 struct exynos_iommu_domain *priv =3D domain->priv;
>> + =A0 =A0 =A0 unsigned long *entry;
>> + =A0 =A0 =A0 unsigned long flags;
>> + =A0 =A0 =A0 phys_addr_t phys =3D -1;
>> +
>> + =A0 =A0 =A0 spin_lock_irqsave(&priv->pgtablelock, flags);
>> +
>> + =A0 =A0 =A0 entry =3D section_entry(priv->pgtable, iova);
>> +
>> + =A0 =A0 =A0 if (lv1ent_section(entry)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phys =3D section_phys(entry) + section_off=
s(iova);
>> + =A0 =A0 =A0 } else if (lv1ent_page(entry)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 entry =3D page_entry(entry, iova);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (lv2ent_large(entry))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phys =3D lpage_phys(entry)=
 + lpage_offs(iova);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (lv2ent_small(entry))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phys =3D spage_phys(entry)=
 + spage_offs(iova);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 spin_unlock_irqrestore(&priv->pgtablelock, flags);
>> +
>> + =A0 =A0 =A0 return phys;
> What's happened if phys has -1? I mean it can't trigger any condition at =
above.
This function just follows page tables and finding corresponding
physical address
for the given IO virtual address.
-1 (0xFFFFFFFF in 32bit system) is just an error value
if no translation information is found.

But I found most IOMMU drivers return 0 for the case.
I will change it to 0.

Thank you for kind review.

Cho KyongHo.
