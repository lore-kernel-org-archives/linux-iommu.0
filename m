From: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v6 05/12] iommu/exynos: support for device tree
Date: Wed, 2 Jan 2013 14:53:49 +0900
Message-ID: <CAHQjnOMav9A43m4=7=N9kzEHTHE_q_ygu8x6mzY6Cus=q0c06A@mail.gmail.com>
References: <003801cde30b$d9667b90$8c3372b0$%cho@samsung.com>
	<50E1E62B.3090501@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1158188284731154922=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <50E1E62B.3090501-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hyunwoong Kim <khw0178.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Subash Patel <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, devicetree-discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============1158188284731154922==
Content-Type: multipart/alternative; boundary=f46d0401fdffcb663704d247ded7

--f46d0401fdffcb663704d247ded7
Content-Type: text/plain; charset=ISO-8859-1

On Tuesday, January 1, 2013, Sylwester Nawrocki <
sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On 12/26/2012 02:53 AM, Cho KyongHo wrote:
>> This commit adds device tree support for System MMU.
>>
>> Signed-off-by: KyongHo Cho<pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>
> Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
>
> Please note any patches adding new device tree bindings should be sent
> to this mailing list. I have few comments, please see below.
>
Ok. I got it. thank you.
>> ---
>>   drivers/iommu/Kconfig        |   2 +-
>>   drivers/iommu/exynos-iommu.c | 282
++++++++++++++++++++++++++-----------------
>>   2 files changed, 174 insertions(+), 110 deletions(-)
>>
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index e39f9db..64586f1 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -168,7 +168,7 @@ config TEGRA_IOMMU_SMMU
>>
>>   config EXYNOS_IOMMU
>>       bool "Exynos IOMMU Support"
>> -     depends on ARCH_EXYNOS&&  EXYNOS_DEV_SYSMMU
>> +     depends on ARCH_EXYNOS
>>       select IOMMU_API
>>       help
>>         Support for the IOMMU(System MMU) of Samsung Exynos application
>> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
>> index 5847508..5b35820 100644
>> --- a/drivers/iommu/exynos-iommu.c
>> +++ b/drivers/iommu/exynos-iommu.c
>> @@ -1,6 +1,6 @@
>> -/* linux/drivers/iommu/exynos_iommu.c
>> +/* linux/drivers/iommu/exynos-iommu.c
>>    *
>> - * Copyright (c) 2011 Samsung Electronics Co., Ltd.
>> + * Copyright (c) 2011-2012 Samsung Electronics Co., Ltd.
>>    *          http://www.samsung.com
>>    *
>>    * This program is free software; you can redistribute it and/or modify
>> @@ -12,6 +12,7 @@
>>   #define DEBUG
>>   #endif
>>
>> +#include<linux/kernel.h>
>>   #include<linux/io.h>
>>   #include<linux/interrupt.h>
>>   #include<linux/platform_device.h>
>> @@ -25,11 +26,10 @@
>>   #include<linux/list.h>
>>   #include<linux/memblock.h>
>>   #include<linux/export.h>
>> +#include<linux/of.h>
>> +#include<linux/of_platform.h>
>>
>>   #include<asm/cacheflush.h>
>> -#include<asm/pgtable.h>
>> -
>> -#include<mach/sysmmu.h>
>>
>>   /* We does not consider super section mapping (16MB) */
>>   #define SECT_ORDER 20
>> @@ -161,14 +161,13 @@ struct sysmmu_drvdata {
>>       struct list_head node; /* entry of exynos_iommu_domain.clients */
>>       struct device *sysmmu;  /* System MMU's device descriptor */
>>       struct device *dev;     /* Owner of system MMU */
>> -     char *dbgname;
>>       int nsfrs;
>> -     void __iomem **sfrbases;
>> -     struct clk *clk[2];
>> +     struct clk *clk;
>>       int activations;
>>       spinlock_t lock;
>>       struct iommu_domain *domain;
>>       unsigned long pgtable;
>> +     void __iomem *sfrbases[0];
>>   };
>>
>>   static bool set_sysmmu_active(struct sysmmu_drvdata *data)
>> @@ -373,10 +372,8 @@ static bool __exynos_sysmmu_disable(struct
sysmmu_drvdata *data)
>>       for (i = 0; i<  data->nsfrs; i++)
>>               __raw_writel(CTRL_DISABLE, data->sfrbases[i] +
REG_MMU_CTRL);
>>
>> -     if (data->clk[1])
>> -             clk_disable(data->clk[1]);
>> -     if (data->clk[0])
>> -             clk_disable(data->clk[0]);
>> +     if (data->clk)
>> +             clk_disable(data->clk);
>>
>>       disabled = true;
>>       data->pgtable = 0;
>> @@ -385,10 +382,10 @@ finish:
>>       spin_unlock_irqrestore(&data->lock, flags);
>>
>>       if (disabled)
>> -             dev_dbg(data->sysmmu, "(%s) Disabled\n", data->dbgname);
>> +             dev_dbg(data->sysmmu, "Disabled\n");
>>       else
>> -             dev_dbg(data->sysmmu, "(%s) %d times left to be
disabled\n",
>> -                                     data->dbgname, data->activations);
>> +             dev_dbg(data->sysmmu, "%d times left to be disabled\n",
>> +                                     data->activations);
>>
>>       return disabled;
>>   }
>> @@ -415,14 +412,12 @@ static int __exynos_sysmmu_enable(struct
sysmmu_drvdata *data,
>>                       ret = 1;
>>               }
>>
>> -             dev_dbg(data->sysmmu, "(%s) Already enabled\n",
data->dbgname);
>> +             dev_dbg(data->sysmmu, "Already enabled\n");
>>               goto finish;
>>       }
>>
>> -     if (data->clk[0])
>> -             clk_enable(data->clk[0]);
>> -     if (data->clk[1])
>> -             clk_enable(data->clk[1]);
>> +     if (data->clk)
>> +             clk_enable(data->clk);
>>
>>       data->pgtable = pgtable;
>>
>> @@ -442,7 +437,7 @@ static int __exynos_sysmmu_enable(struct
sysmmu_drvdata *data,
>>
>>       data->domain = domain;
>>
>> -     dev_dbg(data->sysmmu, "(%s) Enabled\n", data->dbgname);
>> +     dev_dbg(data->sysmmu, "Enabled\n");
>>   finish:
>>       spin_unlock_irqrestore(&data->lock, flags);
>>
>> @@ -458,7 +453,7 @@ int exynos_sysmmu_enable(struct device *dev,
unsigned long pgtable)
>>
>>       ret = pm_runtime_get_sync(data->sysmmu);
>>       if (ret<  0) {
>> -             dev_dbg(data->sysmmu, "(%s) Failed to enable\n",
data->dbgname);
>> +             dev_dbg(data->sysmmu, "Failed to enable\n");
>>               return ret;
>>       }
>>
>> @@ -466,8 +461,8 @@ int exynos_sysmmu_enable(struct device *dev,
unsigned long pgtable)
>>       if (WARN_ON(ret<  0)) {
>>               pm_runtime_put(data->sysmmu);
>>               dev_err(data->sysmmu,
>> -                     "(%s) Already enabled with page table %#lx\n",
>> -                     data->dbgname, data->pgtable);
>> +                     "Already enabled with page table %#lx\n",
>> +                     data->pgtable);
>>       } else {
>>               data->dev = dev;
>>       }
>> @@ -504,8 +499,7 @@ static void sysmmu_tlb_invalidate_entry(struct
device *dev, unsigned long iova)
>>               }
>>       } else {
>>               dev_dbg(data->sysmmu,
>> -                     "(%s) Disabled. Skipping invalidating TLB.\n",
>> -                     data->dbgname);
>> +                     "Disabled. Skipping invalidating TLB.\n");
>>       }
>>
>>       spin_unlock_irqrestore(&data->lock, flags);
>> @@ -528,138 +522,208 @@ void exynos_sysmmu_tlb_invalidate(struct device
*dev)
>>               }
>>       } else {
>>               dev_dbg(data->sysmmu,
>> -                     "(%s) Disabled. Skipping invalidating TLB.\n",
>> -                     data->dbgname);
>> +                     "Disabled. Skipping invalidating TLB.\n");
>>       }
>>
>>       spin_unlock_irqrestore(&data->lock, flags);
>>   }
>>
>> -static int exynos_sysmmu_probe(struct platform_device *pdev)
>> +static int __init __sysmmu_init_clock(struct device *sysmmu,
>> +                                     struct sysmmu_drvdata *drvdata,
>> +                                     struct device *master)
>>   {
>> -     int i, ret;
>> -     struct device *dev;
>> -     struct sysmmu_drvdata *data;
>> +     char *conid;
>> +     struct clk *parent_clk;
>> +     int ret;
>>
>> -     dev =&pdev->dev;
>> +     drvdata->clk = clk_get(sysmmu, "sysmmu");
>> +     if (IS_ERR(drvdata->clk)) {
>> +             dev_dbg(sysmmu, "No gating clock found.\n");
>> +             drvdata->clk = NULL;
>> +             return 0;
>> +     }
>>
>> -     data = kzalloc(sizeof(*data), GFP_KERNEL);
>> -     if (!data) {
>> -             dev_dbg(dev, "Not enough memory\n");
>> -             ret = -ENOMEM;
>> -             goto err_alloc;
>> +     if (!master)
>> +             return 0;
>> +
>> +     conid = dev_get_platdata(sysmmu);
>> +     if (!conid) {
>> +             dev_dbg(sysmmu, "No parent clock specified.\n");
>> +             return 0;
>>       }
>>
>> -     ret = dev_set_drvdata(dev, data);
>> +     parent_clk = clk_get(master, conid);
>> +     if (IS_ERR(parent_clk)) {
>> +             parent_clk = clk_get(NULL, conid);
>> +             if (IS_ERR(parent_clk)) {
>> +                     clk_put(drvdata->clk);
>> +                     dev_err(sysmmu, "No parent clock '%s,%s' found\n",
>> +                             dev_name(master), conid);
>> +                     return PTR_ERR(parent_clk);
>> +             }
>> +     }
>> +
>> +     ret = clk_set_parent(drvdata->clk, parent_clk);
>>       if (ret) {
>> -             dev_dbg(dev, "Unabled to initialize driver data\n");
>> -             goto err_init;
>> +             clk_put(drvdata->clk);
>> +             dev_err(sysmmu, "Failed to set parent clock '%s,%s'\n",
>> +                             dev_name(master), conid);
>>       }
>>
>> -     data->nsfrs = pdev->num_resources / 2;
>> -     data->sfrbases = kmalloc(sizeof(*data->sfrbases) * data->nsfrs,
>> -
GFP_KERNEL);
>> -     if (data->sfrbases == NULL) {
>> -             dev_dbg(dev, "Not enough memory\n");
>> -             ret = -ENOMEM;
>> -             goto err_init;
>> +     clk_put(parent_clk);
>> +
>> +     return ret;
>> +}
>> +
>> +static int __init __sysmmu_setup(struct device *sysmmu,
>> +                             struct sysmmu_drvdata *drvdata)
>> +{
>> +     struct device_node *master_node;
>> +     const char *compat;
>> +     struct platform_device *pmaster = NULL;
>> +     u32 master_inst_no = -1;
>> +     int ret;
>> +
>> +     master_node = of_parse_phandle(sysmmu->of_node, "mmu-master", 0);
>> +     if (!master_node&&  !of_property_read_string(
>> +                     sysmmu->of_node, "mmu-master-compat",&compat)) {
>> +             of_property_read_u32_array(sysmmu->of_node,
>> +                                     "mmu-master-no",&master_inst_no,
1);
>> +             for_each_compatible_node(master_node, NULL, compat) {
>> +                     pmaster = of_find_device_by_node(master_node);
>> +                     if (pmaster&&  (pmaster->id == master_inst_no))
>> +                             break;
>> +                     of_dev_put(pmaster);
>> +                     pmaster = NULL;
>> +             }
>> +     } else if (master_node) {
>> +             pmaster = of_find_device_by_node(master_node);
>> +     }
>> +
>> +     if (!pmaster) {
>> +             dev_dbg(sysmmu, "No master device is specified.\n");
>> +             return __sysmmu_init_clock(sysmmu, drvdata, NULL);
>> +     }
>> +
>> +     pmaster->dev.archdata.iommu = sysmmu;
>> +
>> +     ret = __sysmmu_init_clock(sysmmu, drvdata,&pmaster->dev);
>> +     if (ret)
>> +             dev_err(sysmmu, "Failed to initialize gating clocks\n");
>> +
>> +     of_dev_put(pmaster);
>> +
>> +     return ret;
>> +}
>> +
>> +static int __init exynos_sysmmu_probe(struct platform_device *pdev)
>> +{
>> +     int i, ret;
>> +     struct device *dev =&pdev->dev;
>> +     struct sysmmu_drvdata *data;
>> +
>> +     if (pdev->num_resources == 0) {
>> +             dev_err(dev, "No System MMU resource defined\n");
>> +             return -ENODEV;
>> +     }
>> +
>> +     data = devm_kzalloc(dev,
>> +                     sizeof(*data)
>> +                     + sizeof(*data->sfrbases) * (pdev->num_resources /
2),
>> +                     GFP_KERNEL);
>> +     if (!data) {
>> +             dev_err(dev, "Not enough memory\n");
>> +             return -ENOMEM;
>>       }
>>
>> +     data->nsfrs = pdev->num_resources / 2;
>> +
>>       for (i = 0; i<  data->nsfrs; i++) {
>>               struct resource *res;
>>               res = platform_get_resource(pdev, IORESOURCE_MEM, i);
>>               if (!res) {
>> -                     dev_dbg(dev, "Unable to find IOMEM region\n");
>> -                     ret = -ENOENT;
>> -                     goto err_res;
>> +                     dev_err(dev, "Unable to find IOMEM region\n");
>> +                     return -ENOENT;
>>               }
>>
>> -             data->sfrbases[i] = ioremap(res->start,
resource_size(res));
>> +             data->sfrbases[i] = devm_request_and_ioremap(dev, res);
>>               if (!data->sfrbases[i]) {
>> -                     dev_dbg(dev, "Unable to map IOMEM @ PA:%#x\n",
>> +                     dev_err(dev, "Unable to map IOMEM @ PA:%#x\n",
>>                                                       res->start);
>> -                     ret = -ENOENT;
>> -                     goto err_res;
>> +                     return -EBUSY;
>>               }
>>       }
>>
>>       for (i = 0; i<  data->nsfrs; i++) {
>>               ret = platform_get_irq(pdev, i);
>>               if (ret<= 0) {
>> -                     dev_dbg(dev, "Unable to find IRQ resource\n");
>> -                     goto err_irq;
>> +                     dev_err(dev, "Unable to find IRQ resource\n");
>> +                     return ret;
>>               }
>>
>> -             ret = request_irq(ret, exynos_sysmmu_irq, 0,
>> +             ret = devm_request_irq(dev, ret, exynos_sysmmu_irq, 0,
>>                                       dev_name(dev), data);
>>               if (ret) {
>> -                     dev_dbg(dev, "Unabled to register interrupt
handler\n");
>> -                     goto err_irq;
>> +                     dev_err(dev, "Unabled to register interrupt
handler\n");
>> +                     return ret;
>>               }
>>       }
>>
>> -     if (dev_get_platdata(dev)) {
>> -             char *deli, *beg;
>> -             struct sysmmu_platform_data *platdata =
dev_get_platdata(dev);
>> -
>> -             beg = platdata->clockname;
>> -
>> -             for (deli = beg; (*deli != '\0')&&  (*deli != ','); deli++)
>> -                     /* NOTHING */;
>> -
>> -             if (*deli == '\0')
>> -                     deli = NULL;
>> -             else
>> -                     *deli = '\0';
>> -
>> -             data->clk[0] = clk_get(dev, beg);
>> -             if (IS_ERR(data->clk[0])) {
>> -                     data->clk[0] = NULL;
>> -                     dev_dbg(dev, "No clock descriptor registered\n");
>> -             }
>> -
>> -             if (data->clk[0]&&  deli) {
>> -                     *deli = ',';
>> -                     data->clk[1] = clk_get(dev, deli + 1);
>> -                     if (IS_ERR(data->clk[1]))
>> -                             data->clk[1] = NULL;
>> -             }
>> -
>> -             data->dbgname = platdata->dbgname;
>> -     }
>>
>> -     data->sysmmu = dev;
>> -     spin_lock_init(&data->lock);
>> -     INIT_LIST_HEAD(&data->node);
>> +     ret = __sysmmu_setup(dev, data);
>> +     if (!ret) {
>> +             data->sysmmu = dev;
>> +             spin_lock_init(&data->lock);
>> +             INIT_LIST_HEAD(&data->node);
>>
>> -     if (dev->parent)
>>               pm_runtime_enable(dev);
>>
>> -     dev_dbg(dev, "(%s) Initialized\n", data->dbgname);
>> -     return 0;
>> -err_irq:
>> -     while (i-->  0) {
>> -             int irq;
>> +             platform_set_drvdata(pdev, data);
>>
>> -             irq = platform_get_irq(pdev, i);
>> -             free_irq(irq, data);
>> +             dev_dbg(dev, "Initialized\n");
>>       }
>> -err_res:
>> -     while (data->nsfrs-->  0)
>> -             iounmap(data->sfrbases[data->nsfrs]);
>> -     kfree(data->sfrbases);
>> -err_init:
>> -     kfree(data);
>> -err_alloc:
>> -     dev_err(dev, "Failed to initialize\n");
>> +
>>       return ret;
>>   }
>>
>> -static struct platform_driver exynos_sysmmu_driver = {
>> +/*
>> + * Descriptions of Device Tree node for System MMU
>> + *
>> + * A System MMU should be described by a single tree node.
>> + *
>> + * A System MMU node should have the following properties:
>> + * - reg: tuples of the base address and the size of the IO region of
System MMU
>> + * - compatible: it must be "samsung,exynos-sysmmu".
>
> I think this compatible property is too generic. It should include
> specific SoC
> name in it, e.g. samsung,exynos4210-sysmmu. Please refer to this thread
> http://www.spinics.net/lists/linux-omap/msg83512.html, which discusses
> similar issue.

Ok, I got the point. BTW , I think this will cause adding a compatibility
property whenever a SoC is released even though it has completely
sameSystem MMU. Is it inevitable?

>> + * - interrupt-parent = specify if the interrupt of System MMU is
generated by
>> + *   interrupt combiner or interrupt controller.
>> + * - interrupts: tuples of interrupt numbers. a tuple has 2 elements if
>> + *   @interrupt-parent is '<&combiner>', 3 elements otherwise.
>
> It's probably enough to say that format of the interrupts property is
> dependant on
> the interrupt controller used.

I agree that :)

>> + *
>> + * 'mmuname', 'reg' and 'interrupts' properties can be an array if the
System
>> + * MMU driver controls several number of System MMUs at the same time.
Note that
>> + * the number of elements in those three properties must be the same.
>
> It might be useful to provide some example here.

examples are there in Documentations directory.

>> + * The following properties are optional:
>> + * - mmuname: name of the System MMU for debugging purpose
>
> Not sure if it is something that is supposed to be included in FDT. You
> could
> probably derive it from the 'compatible' property, if it is really
> needed. The device
> tree bindings should not be treated as direct replacement for platform
data
> structures.

actually it is just for debugging purpose.
I understand that it should not be there.
Thank you.

>> + * - mmu-master: reference to the node of the master device.
>> + * - mmu-master-compat: 'compatible' proberty of the node of the master
device
>> + *    of System MMU. This is ignored if @mmu-master is currectly
specified.
>> + * - mmu-master-no: instance number of the master device of System MMU.
This is
>> + *    ignored if @mmu-master is correctly specified. This is '0' by
default.
>
> Maybe device node aliases would be better alternative here ? But what
> would be
> a use case where you can't set 'mmu-master' and 'mmu-master-no' is needed
?

It is for platform devices that are not specified in FDT.
Don't we need consider that?

>> + */
>> +#ifdef CONFIG_OF
>> +static struct of_device_id sysmmu_of_match[] __initconst = {
>> +     { .compatible = "samsung,exynos-sysmmu", },
>> +     { },
>> +};
>> +#endif
>> +
>> +static struct platform_driver exynos_sysmmu_driver __refdata = {
>>       .probe          = exynos_sysmmu_probe,
>>       .driver         = {
>>               .owner          = THIS_MODULE,
>>               .name           = "exynos-sysmmu",
>> +             .of_match_table = of_match_ptr(sysmmu_of_match),
>>       }
>>   };

--f46d0401fdffcb663704d247ded7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tuesday, January 1, 2013, Sylwester Nawrocki &lt;<a href=3D"mailto:sylve=
ster.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>&gt=
; On 12/26/2012 02:53 AM, Cho KyongHo wrote:<br>&gt;&gt; This commit adds d=
evice tree support for System MMU.<br>
&gt;&gt;<br>&gt;&gt; Signed-off-by: KyongHo Cho&lt;<a href=3D"mailto:pullip=
.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org">pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt;<br>&gt;<br>&gt; Cc: <a hre=
f=3D"mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org">devicetree-discuss@lists.o=
zlabs.org</a><br>
&gt;<br>&gt; Please note any patches adding new device tree bindings should=
 be sent<br>&gt; to this mailing list. I have few comments, please see belo=
w.<br>&gt;<br>Ok. I got it. thank you.<br>&gt;&gt; ---<br>&gt;&gt; =A0 driv=
ers/iommu/Kconfig =A0 =A0 =A0 =A0| =A0 2 +-<br>
&gt;&gt; =A0 drivers/iommu/exynos-iommu.c | 282 ++++++++++++++++++++++++++-=
----------------<br>&gt;&gt; =A0 2 files changed, 174 insertions(+), 110 de=
letions(-)<br>&gt;&gt;<br>&gt;&gt; diff --git a/drivers/iommu/Kconfig b/dri=
vers/iommu/Kconfig<br>
&gt;&gt; index e39f9db..64586f1 100644<br>&gt;&gt; --- a/drivers/iommu/Kcon=
fig<br>&gt;&gt; +++ b/drivers/iommu/Kconfig<br>&gt;&gt; @@ -168,7 +168,7 @@=
 config TEGRA_IOMMU_SMMU<br>&gt;&gt;<br>&gt;&gt; =A0 config EXYNOS_IOMMU<br=
>
&gt;&gt; =A0 =A0 =A0 bool &quot;Exynos IOMMU Support&quot;<br>&gt;&gt; - =
=A0 =A0 depends on ARCH_EXYNOS&amp;&amp; =A0EXYNOS_DEV_SYSMMU<br>&gt;&gt; +=
 =A0 =A0 depends on ARCH_EXYNOS<br>&gt;&gt; =A0 =A0 =A0 select IOMMU_API<br=
>&gt;&gt; =A0 =A0 =A0 help<br>
&gt;&gt; =A0 =A0 =A0 =A0 Support for the IOMMU(System MMU) of Samsung Exyno=
s application<br>&gt;&gt; diff --git a/drivers/iommu/exynos-iommu.c b/drive=
rs/iommu/exynos-iommu.c<br>&gt;&gt; index 5847508..5b35820 100644<br>&gt;&g=
t; --- a/drivers/iommu/exynos-iommu.c<br>
&gt;&gt; +++ b/drivers/iommu/exynos-iommu.c<br>&gt;&gt; @@ -1,6 +1,6 @@<br>=
&gt;&gt; -/* linux/drivers/iommu/exynos_iommu.c<br>&gt;&gt; +/* linux/drive=
rs/iommu/exynos-iommu.c<br>&gt;&gt; =A0 =A0*<br>&gt;&gt; - * Copyright (c) =
2011 Samsung Electronics Co., Ltd.<br>
&gt;&gt; + * Copyright (c) 2011-2012 Samsung Electronics Co., Ltd.<br>&gt;&=
gt; =A0 =A0* =A0 =A0 =A0 =A0 =A0<a href=3D"http://www.samsung.com">http://w=
ww.samsung.com</a><br>&gt;&gt; =A0 =A0*<br>&gt;&gt; =A0 =A0* This program i=
s free software; you can redistribute it and/or modify<br>
&gt;&gt; @@ -12,6 +12,7 @@<br>&gt;&gt; =A0 #define DEBUG<br>&gt;&gt; =A0 #e=
ndif<br>&gt;&gt;<br>&gt;&gt; +#include&lt;linux/kernel.h&gt;<br>&gt;&gt; =
=A0 #include&lt;linux/io.h&gt;<br>&gt;&gt; =A0 #include&lt;linux/interrupt.=
h&gt;<br>
&gt;&gt; =A0 #include&lt;linux/platform_device.h&gt;<br>&gt;&gt; @@ -25,11 =
+26,10 @@<br>&gt;&gt; =A0 #include&lt;linux/list.h&gt;<br>&gt;&gt; =A0 #inc=
lude&lt;linux/memblock.h&gt;<br>&gt;&gt; =A0 #include&lt;linux/export.h&gt;=
<br>
&gt;&gt; +#include&lt;linux/of.h&gt;<br>&gt;&gt; +#include&lt;linux/of_plat=
form.h&gt;<br>&gt;&gt;<br>&gt;&gt; =A0 #include&lt;asm/cacheflush.h&gt;<br>=
&gt;&gt; -#include&lt;asm/pgtable.h&gt;<br>&gt;&gt; -<br>&gt;&gt; -#include=
&lt;mach/sysmmu.h&gt;<br>
&gt;&gt;<br>&gt;&gt; =A0 /* We does not consider super section mapping (16M=
B) */<br>&gt;&gt; =A0 #define SECT_ORDER 20<br>&gt;&gt; @@ -161,14 +161,13 =
@@ struct sysmmu_drvdata {<br>&gt;&gt; =A0 =A0 =A0 struct list_head node; /=
* entry of exynos_iommu_domain.clients */<br>
&gt;&gt; =A0 =A0 =A0 struct device *sysmmu; =A0/* System MMU&#39;s device d=
escriptor */<br>&gt;&gt; =A0 =A0 =A0 struct device *dev; =A0 =A0 /* Owner o=
f system MMU */<br>&gt;&gt; - =A0 =A0 char *dbgname;<br>&gt;&gt; =A0 =A0 =
=A0 int nsfrs;<br>&gt;&gt; - =A0 =A0 void __iomem **sfrbases;<br>
&gt;&gt; - =A0 =A0 struct clk *clk[2];<br>&gt;&gt; + =A0 =A0 struct clk *cl=
k;<br>&gt;&gt; =A0 =A0 =A0 int activations;<br>&gt;&gt; =A0 =A0 =A0 spinloc=
k_t lock;<br>&gt;&gt; =A0 =A0 =A0 struct iommu_domain *domain;<br>&gt;&gt; =
=A0 =A0 =A0 unsigned long pgtable;<br>
&gt;&gt; + =A0 =A0 void __iomem *sfrbases[0];<br>&gt;&gt; =A0 };<br>&gt;&gt=
;<br>&gt;&gt; =A0 static bool set_sysmmu_active(struct sysmmu_drvdata *data=
)<br>&gt;&gt; @@ -373,10 +372,8 @@ static bool __exynos_sysmmu_disable(stru=
ct sysmmu_drvdata *data)<br>
&gt;&gt; =A0 =A0 =A0 for (i =3D 0; i&lt; =A0data-&gt;nsfrs; i++)<br>&gt;&gt=
; =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(CTRL_DISABLE, data-&gt;sfrbases[=
i] + REG_MMU_CTRL);<br>&gt;&gt;<br>&gt;&gt; - =A0 =A0 if (data-&gt;clk[1])<=
br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(data-&gt;clk[1]);<br>
&gt;&gt; - =A0 =A0 if (data-&gt;clk[0])<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =
=A0 clk_disable(data-&gt;clk[0]);<br>&gt;&gt; + =A0 =A0 if (data-&gt;clk)<b=
r>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(data-&gt;clk);<br>&gt;&gt;=
<br>&gt;&gt; =A0 =A0 =A0 disabled =3D true;<br>
&gt;&gt; =A0 =A0 =A0 data-&gt;pgtable =3D 0;<br>&gt;&gt; @@ -385,10 +382,10=
 @@ finish:<br>&gt;&gt; =A0 =A0 =A0 spin_unlock_irqrestore(&amp;data-&gt;lo=
ck, flags);<br>&gt;&gt;<br>&gt;&gt; =A0 =A0 =A0 if (disabled)<br>&gt;&gt; -=
 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(data-&gt;sysmmu, &quot;(%s) Disabled\n&quo=
t;, data-&gt;dbgname);<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(data-&gt;sysmmu, &quot;Disabled\=
n&quot;);<br>&gt;&gt; =A0 =A0 =A0 else<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =
=A0 dev_dbg(data-&gt;sysmmu, &quot;(%s) %d times left to be disabled\n&quot=
;,<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 data-&gt;dbgname, data-&gt;activations);<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(data-&gt;sysmmu, &quot;%d times =
left to be disabled\n&quot;,<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;activations);<br>&gt;&gt;<=
br>&gt;&gt; =A0 =A0 =A0 return disabled;<br>&gt;&gt; =A0 }<br>
&gt;&gt; @@ -415,14 +412,12 @@ static int __exynos_sysmmu_enable(struct sys=
mmu_drvdata *data,<br>&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
ret =3D 1;<br>&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>&gt;&gt;<br>&gt;&gt=
; - =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(data-&gt;sysmmu, &quot;(%s) Already ena=
bled\n&quot;, data-&gt;dbgname);<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(data-&gt;sysmmu, &quot;Already e=
nabled\n&quot;);<br>&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto finish;<br>&g=
t;&gt; =A0 =A0 =A0 }<br>&gt;&gt;<br>&gt;&gt; - =A0 =A0 if (data-&gt;clk[0])=
<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(data-&gt;clk[0]);<br>
&gt;&gt; - =A0 =A0 if (data-&gt;clk[1])<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =
=A0 clk_enable(data-&gt;clk[1]);<br>&gt;&gt; + =A0 =A0 if (data-&gt;clk)<br=
>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(data-&gt;clk);<br>&gt;&gt;<b=
r>&gt;&gt; =A0 =A0 =A0 data-&gt;pgtable =3D pgtable;<br>
&gt;&gt;<br>&gt;&gt; @@ -442,7 +437,7 @@ static int __exynos_sysmmu_enable(=
struct sysmmu_drvdata *data,<br>&gt;&gt;<br>&gt;&gt; =A0 =A0 =A0 data-&gt;d=
omain =3D domain;<br>&gt;&gt;<br>&gt;&gt; - =A0 =A0 dev_dbg(data-&gt;sysmmu=
, &quot;(%s) Enabled\n&quot;, data-&gt;dbgname);<br>
&gt;&gt; + =A0 =A0 dev_dbg(data-&gt;sysmmu, &quot;Enabled\n&quot;);<br>&gt;=
&gt; =A0 finish:<br>&gt;&gt; =A0 =A0 =A0 spin_unlock_irqrestore(&amp;data-&=
gt;lock, flags);<br>&gt;&gt;<br>&gt;&gt; @@ -458,7 +453,7 @@ int exynos_sys=
mmu_enable(struct device *dev, unsigned long pgtable)<br>
&gt;&gt;<br>&gt;&gt; =A0 =A0 =A0 ret =3D pm_runtime_get_sync(data-&gt;sysmm=
u);<br>&gt;&gt; =A0 =A0 =A0 if (ret&lt; =A00) {<br>&gt;&gt; - =A0 =A0 =A0 =
=A0 =A0 =A0 dev_dbg(data-&gt;sysmmu, &quot;(%s) Failed to enable\n&quot;, d=
ata-&gt;dbgname);<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(data-&gt;sy=
smmu, &quot;Failed to enable\n&quot;);<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>&gt;&gt; =A0 =A0 =A0 }<=
br>&gt;&gt;<br>&gt;&gt; @@ -466,8 +461,8 @@ int exynos_sysmmu_enable(struct=
 device *dev, unsigned long pgtable)<br>&gt;&gt; =A0 =A0 =A0 if (WARN_ON(re=
t&lt; =A00)) {<br>&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(data-=
&gt;sysmmu);<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(data-&gt;sysmmu,<br>&gt;&gt; -=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;(%s) Already enabled with pa=
ge table %#lx\n&quot;,<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 data-&gt;dbgname, data-&gt;pgtable);<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 &quot;Already enabled with page table %#lx\n&quot;,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;pgtable);<br>&g=
t;&gt; =A0 =A0 =A0 } else {<br>&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&g=
t;dev =3D dev;<br>&gt;&gt; =A0 =A0 =A0 }<br>&gt;&gt; @@ -504,8 +499,7 @@ st=
atic void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iov=
a)<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>&gt;&gt; =A0 =A0 =A0 } else {<br>=
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(data-&gt;sysmmu,<br>&gt;&gt; -=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;(%s) Disabled. Skipping inva=
lidating TLB.\n&quot;,<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 data-&gt;dbgname);<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Disabled. Skipping=
 invalidating TLB.\n&quot;);<br>&gt;&gt; =A0 =A0 =A0 }<br>&gt;&gt;<br>&gt;&=
gt; =A0 =A0 =A0 spin_unlock_irqrestore(&amp;data-&gt;lock, flags);<br>&gt;&=
gt; @@ -528,138 +522,208 @@ void exynos_sysmmu_tlb_invalidate(struct device=
 *dev)<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>&gt;&gt; =A0 =A0 =A0 } else {<br>=
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(data-&gt;sysmmu,<br>&gt;&gt; -=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;(%s) Disabled. Skipping inva=
lidating TLB.\n&quot;,<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 data-&gt;dbgname);<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Disabled. Skipping=
 invalidating TLB.\n&quot;);<br>&gt;&gt; =A0 =A0 =A0 }<br>&gt;&gt;<br>&gt;&=
gt; =A0 =A0 =A0 spin_unlock_irqrestore(&amp;data-&gt;lock, flags);<br>&gt;&=
gt; =A0 }<br>&gt;&gt;<br>&gt;&gt; -static int exynos_sysmmu_probe(struct pl=
atform_device *pdev)<br>
&gt;&gt; +static int __init __sysmmu_init_clock(struct device *sysmmu,<br>&=
gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 struct sysmmu_drvdata *drvdata,<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device *master)<=
br>
&gt;&gt; =A0 {<br>&gt;&gt; - =A0 =A0 int i, ret;<br>&gt;&gt; - =A0 =A0 stru=
ct device *dev;<br>&gt;&gt; - =A0 =A0 struct sysmmu_drvdata *data;<br>&gt;&=
gt; + =A0 =A0 char *conid;<br>&gt;&gt; + =A0 =A0 struct clk *parent_clk;<br=
>&gt;&gt; + =A0 =A0 int ret;<br>
&gt;&gt;<br>&gt;&gt; - =A0 =A0 dev =3D&amp;pdev-&gt;dev;<br>&gt;&gt; + =A0 =
=A0 drvdata-&gt;clk =3D clk_get(sysmmu, &quot;sysmmu&quot;);<br>&gt;&gt; + =
=A0 =A0 if (IS_ERR(drvdata-&gt;clk)) {<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =
=A0 dev_dbg(sysmmu, &quot;No gating clock found.\n&quot;);<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 drvdata-&gt;clk =3D NULL;<br>&gt;&gt; + =
=A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>&gt;&gt; + =A0 =A0 }<br>&gt;&gt;<br>&g=
t;&gt; - =A0 =A0 data =3D kzalloc(sizeof(*data), GFP_KERNEL);<br>&gt;&gt; -=
 =A0 =A0 if (!data) {<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, &q=
uot;Not enough memory\n&quot;);<br>
&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;<br>&gt;&gt; - =A0 =A0 =
=A0 =A0 =A0 =A0 goto err_alloc;<br>&gt;&gt; + =A0 =A0 if (!master)<br>&gt;&=
gt; + =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>&gt;&gt; +<br>&gt;&gt; + =A0 =A0=
 conid =3D dev_get_platdata(sysmmu);<br>&gt;&gt; + =A0 =A0 if (!conid) {<br=
>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sysmmu, &quot;No parent clock sp=
ecified.\n&quot;);<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>&gt;&=
gt; =A0 =A0 =A0 }<br>&gt;&gt;<br>&gt;&gt; - =A0 =A0 ret =3D dev_set_drvdata=
(dev, data);<br>&gt;&gt; + =A0 =A0 parent_clk =3D clk_get(master, conid);<b=
r>
&gt;&gt; + =A0 =A0 if (IS_ERR(parent_clk)) {<br>&gt;&gt; + =A0 =A0 =A0 =A0 =
=A0 =A0 parent_clk =3D clk_get(NULL, conid);<br>&gt;&gt; + =A0 =A0 =A0 =A0 =
=A0 =A0 if (IS_ERR(parent_clk)) {<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 clk_put(drvdata-&gt;clk);<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 dev_err(sysmmu, &quot;No parent clock &#39;%s,%s&#39; f=
ound\n&quot;,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_name=
(master), conid);<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret=
urn PTR_ERR(parent_clk);<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 }<br>&gt;&gt=
; + =A0 =A0 }<br>&gt;&gt; +<br>&gt;&gt; + =A0 =A0 ret =3D clk_set_parent(dr=
vdata-&gt;clk, parent_clk);<br>
&gt;&gt; =A0 =A0 =A0 if (ret) {<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 dev_d=
bg(dev, &quot;Unabled to initialize driver data\n&quot;);<br>&gt;&gt; - =A0=
 =A0 =A0 =A0 =A0 =A0 goto err_init;<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 c=
lk_put(drvdata-&gt;clk);<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(sysm=
mu, &quot;Failed to set parent clock &#39;%s,%s&#39;\n&quot;,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_name=
(master), conid);<br>&gt;&gt; =A0 =A0 =A0 }<br>&gt;&gt;<br>&gt;&gt; - =A0 =
=A0 data-&gt;nsfrs =3D pdev-&gt;num_resources / 2;<br>&gt;&gt; - =A0 =A0 da=
ta-&gt;sfrbases =3D kmalloc(sizeof(*data-&gt;sfrbases) * data-&gt;nsfrs,<br=
>
&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL);<br>&gt=
;&gt; - =A0 =A0 if (data-&gt;sfrbases =3D=3D NULL) {<br>&gt;&gt; - =A0 =A0 =
=A0 =A0 =A0 =A0 dev_dbg(dev, &quot;Not enough memory\n&quot;);<br>&gt;&gt; =
- =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;<br>
&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 goto err_init;<br>&gt;&gt; + =A0 =A0 clk=
_put(parent_clk);<br>&gt;&gt; +<br>&gt;&gt; + =A0 =A0 return ret;<br>&gt;&g=
t; +}<br>&gt;&gt; +<br>&gt;&gt; +static int __init __sysmmu_setup(struct de=
vice *sysmmu,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct s=
ysmmu_drvdata *drvdata)<br>&gt;&gt; +{<br>&gt;&gt; + =A0 =A0 struct device_=
node *master_node;<br>&gt;&gt; + =A0 =A0 const char *compat;<br>&gt;&gt; + =
=A0 =A0 struct platform_device *pmaster =3D NULL;<br>
&gt;&gt; + =A0 =A0 u32 master_inst_no =3D -1;<br>&gt;&gt; + =A0 =A0 int ret=
;<br>&gt;&gt; +<br>&gt;&gt; + =A0 =A0 master_node =3D of_parse_phandle(sysm=
mu-&gt;of_node, &quot;mmu-master&quot;, 0);<br>&gt;&gt; + =A0 =A0 if (!mast=
er_node&amp;&amp; =A0!of_property_read_string(<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu-&gt;of_node, &quo=
t;mmu-master-compat&quot;,&amp;compat)) {<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0=
 =A0 of_property_read_u32_array(sysmmu-&gt;of_node,<br>&gt;&gt; + =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;mmu-m=
aster-no&quot;,&amp;master_inst_no, 1);<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 for_each_compatible_node(master_node, NU=
LL, compat) {<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pmaster=
 =3D of_find_device_by_node(master_node);<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 if (pmaster&amp;&amp; =A0(pmaster-&gt;id =3D=3D master=
_inst_no))<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<b=
r>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_dev_put(pmaster);<b=
r>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pmaster =3D NULL;<br>&=
gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 }<br>&gt;&gt; + =A0 =A0 } else if (master=
_node) {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 pmaster =3D of_find_device_by_node(maste=
r_node);<br>&gt;&gt; + =A0 =A0 }<br>&gt;&gt; +<br>&gt;&gt; + =A0 =A0 if (!p=
master) {<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(sysmmu, &quot;No ma=
ster device is specified.\n&quot;);<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return __sysmmu_init_clock(sysmmu, drvda=
ta, NULL);<br>&gt;&gt; + =A0 =A0 }<br>&gt;&gt; +<br>&gt;&gt; + =A0 =A0 pmas=
ter-&gt;dev.archdata.iommu =3D sysmmu;<br>&gt;&gt; +<br>&gt;&gt; + =A0 =A0 =
ret =3D __sysmmu_init_clock(sysmmu, drvdata,&amp;pmaster-&gt;dev);<br>
&gt;&gt; + =A0 =A0 if (ret)<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(s=
ysmmu, &quot;Failed to initialize gating clocks\n&quot;);<br>&gt;&gt; +<br>=
&gt;&gt; + =A0 =A0 of_dev_put(pmaster);<br>&gt;&gt; +<br>&gt;&gt; + =A0 =A0=
 return ret;<br>&gt;&gt; +}<br>
&gt;&gt; +<br>&gt;&gt; +static int __init exynos_sysmmu_probe(struct platfo=
rm_device *pdev)<br>&gt;&gt; +{<br>&gt;&gt; + =A0 =A0 int i, ret;<br>&gt;&g=
t; + =A0 =A0 struct device *dev =3D&amp;pdev-&gt;dev;<br>&gt;&gt; + =A0 =A0=
 struct sysmmu_drvdata *data;<br>
&gt;&gt; +<br>&gt;&gt; + =A0 =A0 if (pdev-&gt;num_resources =3D=3D 0) {<br>=
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, &quot;No System MMU resourc=
e defined\n&quot;);<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;<b=
r>&gt;&gt; + =A0 =A0 }<br>&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 data =3D devm_kzalloc(dev,<br>&gt;&gt; + =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(*data)<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 + sizeof(*data-&gt;sfrbases) * (pdev-&gt;num_resources =
/ 2),<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL);<br=
>
&gt;&gt; + =A0 =A0 if (!data) {<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_e=
rr(dev, &quot;Not enough memory\n&quot;);<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0=
 =A0 return -ENOMEM;<br>&gt;&gt; =A0 =A0 =A0 }<br>&gt;&gt;<br>&gt;&gt; + =
=A0 =A0 data-&gt;nsfrs =3D pdev-&gt;num_resources / 2;<br>
&gt;&gt; +<br>&gt;&gt; =A0 =A0 =A0 for (i =3D 0; i&lt; =A0data-&gt;nsfrs; i=
++) {<br>&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct resource *res;<br>&gt;=
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESO=
URCE_MEM, i);<br>&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!res) {<br>
&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, &quot;Unabl=
e to find IOMEM region\n&quot;);<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 ret =3D -ENOENT;<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 goto err_res;<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 dev_err(dev, &quot;Unable to find IOMEM region\n&quot;);<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOENT;<br>&gt;&=
gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>&gt;&gt;<br>&gt;&gt; - =A0 =A0 =A0 =A0=
 =A0 =A0 data-&gt;sfrbases[i] =3D ioremap(res-&gt;start, resource_size(res)=
);<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;sfrbases[i] =3D devm_requ=
est_and_ioremap(dev, res);<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!data-&gt;sfrbases[i]) {<br>&gt;&g=
t; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, &quot;Unable to m=
ap IOMEM @ PA:%#x\n&quot;,<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 dev_err(dev, &quot;Unable to map IOMEM @ PA:%#x\n&quot;,<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 res-&gt;start);<br>&gt;&gt; - =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOENT;<br>&gt;&gt; - =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_res;<br>&gt;&gt; + =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>&gt;&gt; =A0 =A0 =A0 }<br>&gt;&gt=
;<br>&gt;&gt; =A0 =A0 =A0 for (i =3D 0; i&lt; =A0data-&gt;nsfrs; i++) {<br>=
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D platform_get_irq(pdev, i);<br>=
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret&lt;=3D 0) {<br>
&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, &quot;Unabl=
e to find IRQ resource\n&quot;);<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 goto err_irq;<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 dev_err(dev, &quot;Unable to find IRQ resource\n&quot;);<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>&gt;&gt; =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>&gt;&gt;<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0=
 =A0 ret =3D request_irq(ret, exynos_sysmmu_irq, 0,<br>&gt;&gt; + =A0 =A0 =
=A0 =A0 =A0 =A0 ret =3D devm_request_irq(dev, ret, exynos_sysmmu_irq, 0,<br=
>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 dev_name(dev), data);<br>&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 i=
f (ret) {<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev=
, &quot;Unabled to register interrupt handler\n&quot;);<br>&gt;&gt; - =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_irq;<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, &quot;Unabl=
ed to register interrupt handler\n&quot;);<br>&gt;&gt; + =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 }<br>&gt;&gt; =A0 =A0 =A0 }<br>&gt;&gt;<br>&gt;&gt; - =A0 =A0 if (dev_get_=
platdata(dev)) {<br>
&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 char *deli, *beg;<br>&gt;&gt; - =A0 =A0 =
=A0 =A0 =A0 =A0 struct sysmmu_platform_data *platdata =3D dev_get_platdata(=
dev);<br>&gt;&gt; -<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 beg =3D platdata-=
&gt;clockname;<br>&gt;&gt; -<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 for (del=
i =3D beg; (*deli !=3D &#39;\0&#39;)&amp;&amp; =A0(*deli !=3D &#39;,&#39;);=
 deli++)<br>
&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* NOTHING */;<br>&gt;&g=
t; -<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 if (*deli =3D=3D &#39;\0&#39;)<b=
r>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 deli =3D NULL;<br>&gt;=
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 else<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 *deli =3D &#39;\0&#39;;<br>
&gt;&gt; -<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;clk[0] =3D clk_ge=
t(dev, beg);<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(data-&gt;clk[=
0])) {<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;clk[0=
] =3D NULL;<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(d=
ev, &quot;No clock descriptor registered\n&quot;);<br>
&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 }<br>&gt;&gt; -<br>&gt;&gt; - =A0 =A0 =
=A0 =A0 =A0 =A0 if (data-&gt;clk[0]&amp;&amp; =A0deli) {<br>&gt;&gt; - =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *deli =3D &#39;,&#39;;<br>&gt;&gt; - =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;clk[1] =3D clk_get(dev, de=
li + 1);<br>
&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(data-&gt;clk[=
1]))<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
data-&gt;clk[1] =3D NULL;<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 }<br>&gt;&g=
t; -<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;dbgname =3D platdata-&g=
t;dbgname;<br>
&gt;&gt; - =A0 =A0 }<br>&gt;&gt;<br>&gt;&gt; - =A0 =A0 data-&gt;sysmmu =3D =
dev;<br>&gt;&gt; - =A0 =A0 spin_lock_init(&amp;data-&gt;lock);<br>&gt;&gt; =
- =A0 =A0 INIT_LIST_HEAD(&amp;data-&gt;node);<br>&gt;&gt; + =A0 =A0 ret =3D=
 __sysmmu_setup(dev, data);<br>
&gt;&gt; + =A0 =A0 if (!ret) {<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 data-&=
gt;sysmmu =3D dev;<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_init(&am=
p;data-&gt;lock);<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 INIT_LIST_HEAD(&amp=
;data-&gt;node);<br>&gt;&gt;<br>&gt;&gt; - =A0 =A0 if (dev-&gt;parent)<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_enable(dev);<br>&gt;&gt;<br=
>&gt;&gt; - =A0 =A0 dev_dbg(dev, &quot;(%s) Initialized\n&quot;, data-&gt;d=
bgname);<br>&gt;&gt; - =A0 =A0 return 0;<br>&gt;&gt; -err_irq:<br>&gt;&gt; =
- =A0 =A0 while (i--&gt; =A00) {<br>
&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 int irq;<br>&gt;&gt; + =A0 =A0 =A0 =A0 =
=A0 =A0 platform_set_drvdata(pdev, data);<br>&gt;&gt;<br>&gt;&gt; - =A0 =A0=
 =A0 =A0 =A0 =A0 irq =3D platform_get_irq(pdev, i);<br>&gt;&gt; - =A0 =A0 =
=A0 =A0 =A0 =A0 free_irq(irq, data);<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =
dev_dbg(dev, &quot;Initialized\n&quot;);<br>
&gt;&gt; =A0 =A0 =A0 }<br>&gt;&gt; -err_res:<br>&gt;&gt; - =A0 =A0 while (d=
ata-&gt;nsfrs--&gt; =A00)<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 iounmap(dat=
a-&gt;sfrbases[data-&gt;nsfrs]);<br>&gt;&gt; - =A0 =A0 kfree(data-&gt;sfrba=
ses);<br>&gt;&gt; -err_init:<br>
&gt;&gt; - =A0 =A0 kfree(data);<br>&gt;&gt; -err_alloc:<br>&gt;&gt; - =A0 =
=A0 dev_err(dev, &quot;Failed to initialize\n&quot;);<br>&gt;&gt; +<br>&gt;=
&gt; =A0 =A0 =A0 return ret;<br>&gt;&gt; =A0 }<br>&gt;&gt;<br>&gt;&gt; -sta=
tic struct platform_driver exynos_sysmmu_driver =3D {<br>
&gt;&gt; +/*<br>&gt;&gt; + * Descriptions of Device Tree node for System MM=
U<br>&gt;&gt; + *<br>&gt;&gt; + * A System MMU should be described by a sin=
gle tree node.<br>&gt;&gt; + *<br>&gt;&gt; + * A System MMU node should hav=
e the following properties:<br>
&gt;&gt; + * - reg: tuples of the base address and the size of the IO regio=
n of System MMU<br>&gt;&gt; + * - compatible: it must be &quot;samsung,exyn=
os-sysmmu&quot;.<br>&gt;<br>&gt; I think this compatible property is too ge=
neric. It should include<br>
&gt; specific SoC<br>&gt; name in it, e.g. samsung,exynos4210-sysmmu. Pleas=
e refer to this thread<br>&gt; <a href=3D"http://www.spinics.net/lists/linu=
x-omap/msg83512.html">http://www.spinics.net/lists/linux-omap/msg83512.html=
</a>, which discusses<br>
&gt; similar issue.<br><br>Ok, I got the point. BTW , I think this will cau=
se adding a compatibility property whenever a SoC is released even though i=
t has completely sameSystem MMU. Is it inevitable?<br><br>&gt;&gt; + * - in=
terrupt-parent =3D specify if the interrupt of System MMU is generated by<b=
r>
&gt;&gt; + * =A0 interrupt combiner or interrupt controller.<br>&gt;&gt; + =
* - interrupts: tuples of interrupt numbers. a tuple has 2 elements if<br>&=
gt;&gt; + * =A0 @interrupt-parent is &#39;&lt;&amp;combiner&gt;&#39;, 3 ele=
ments otherwise.<br>
&gt;<br>&gt; It&#39;s probably enough to say that format of the interrupts =
property is<br>&gt; dependant on<br>&gt; the interrupt controller used.<br>=
<br>I agree that :)<br><br>&gt;&gt; + *<br>&gt;&gt; + * &#39;mmuname&#39;, =
&#39;reg&#39; and &#39;interrupts&#39; properties can be an array if the Sy=
stem<br>
&gt;&gt; + * MMU driver controls several number of System MMUs at the same =
time. Note that<br>&gt;&gt; + * the number of elements in those three prope=
rties must be the same.<br>&gt;<br>&gt; It might be useful to provide some =
example here.<br>
<br>examples are there in Documentations directory.<br><br>&gt;&gt; + * The=
 following properties are optional:<br>&gt;&gt; + * - mmuname: name of the =
System MMU for debugging purpose<br>&gt;<br>&gt; Not sure if it is somethin=
g that is supposed to be included in FDT. You<br>
&gt; could<br>&gt; probably derive it from the &#39;compatible&#39; propert=
y, if it is really<br>&gt; needed. The device<br>&gt; tree bindings should =
not be treated as direct replacement for platform data<br>&gt; structures.<=
br>
<br>actually it is just for debugging purpose.<br>I understand that it shou=
ld not be there.<br>Thank you.<br><br>&gt;&gt; + * - mmu-master: reference =
to the node of the master device.<br>&gt;&gt; + * - mmu-master-compat: &#39=
;compatible&#39; proberty of the node of the master device<br>
&gt;&gt; + * =A0 =A0of System MMU. This is ignored if @mmu-master is currec=
tly specified.<br>&gt;&gt; + * - mmu-master-no: instance number of the mast=
er device of System MMU. This is<br>&gt;&gt; + * =A0 =A0ignored if @mmu-mas=
ter is correctly specified. This is &#39;0&#39; by default.<br>
&gt;<br>&gt; Maybe device node aliases would be better alternative here ? B=
ut what<br>&gt; would be<br>&gt; a use case where you can&#39;t set &#39;mm=
u-master&#39; and &#39;mmu-master-no&#39; is needed ?<br><br>It is for plat=
form devices that are not specified in FDT.<br>
Don&#39;t we need consider that? <br><br>&gt;&gt; + */<br>&gt;&gt; +#ifdef =
CONFIG_OF<br>&gt;&gt; +static struct of_device_id sysmmu_of_match[] __initc=
onst =3D {<br>&gt;&gt; + =A0 =A0 { .compatible =3D &quot;samsung,exynos-sys=
mmu&quot;, },<br>
&gt;&gt; + =A0 =A0 { },<br>&gt;&gt; +};<br>&gt;&gt; +#endif<br>&gt;&gt; +<b=
r>&gt;&gt; +static struct platform_driver exynos_sysmmu_driver __refdata =
=3D {<br>&gt;&gt; =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D exynos_sysmmu_p=
robe,<br>&gt;&gt; =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MOD=
ULE,<br>&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D =
&quot;exynos-sysmmu&quot;,<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .of_match_=
table =3D of_match_ptr(sysmmu_of_match),<br>&gt;&gt; =A0 =A0 =A0 }<br>
&gt;&gt; =A0 };<br>

--f46d0401fdffcb663704d247ded7--

--===============1158188284731154922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1158188284731154922==--
