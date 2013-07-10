From: Prathyush K <prathyush-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v7 9/9] iommu/exynos: add bus notifier for registering
	System MMU
Date: Wed, 10 Jul 2013 20:33:15 +0530
Message-ID: <CAH=HWYMg4cD5kisxj3uUj+2_DvvgihE09tDO=9-2cVjJrnhMSg@mail.gmail.com>
References: <003101ce797b$5418e8e0$fc4abaa0$@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0200447045818100348=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <003101ce797b$5418e8e0$fc4abaa0$@samsung.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hyunwoong Kim <khw0178.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Keyyoung Park <keyyoung.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Subash Patel <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============0200447045818100348==
Content-Type: multipart/alternative; boundary=047d7bd9158ec1930f04e12993b2

--047d7bd9158ec1930f04e12993b2
Content-Type: text/plain; charset=ISO-8859-1

I think this patch can be split further.
There is a lot more added in this patch (suspend/resume functions etc) than
just adding a bus notifier.

I will review further and also, test this patchset.

Regards,
Prathyush


On Fri, Jul 5, 2013 at 5:59 PM, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:

> When a device driver is registered, all constructs to handle System MMU
> is prepared by bus notifier call.
>
> Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/iommu/exynos-iommu.c |  778
> ++++++++++++++++++++++++++++++-----------
>  1 files changed, 569 insertions(+), 209 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index b151e51..51d43bb 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -27,6 +27,9 @@
>  #include <linux/memblock.h>
>  #include <linux/export.h>
>  #include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm_domain.h>
> +#include <linux/notifier.h>
>
>  #include <asm/cacheflush.h>
>  #include <asm/pgtable.h>
> @@ -80,6 +83,14 @@
>  #define CTRL_BLOCK     0x7
>  #define CTRL_DISABLE   0x0
>
> +#define CFG_LRU                0x1
> +#define CFG_QOS(n)     ((n & 0xF) << 7)
> +#define CFG_MASK       0x0150FFFF /* Selecting bit 0-15, 20, 22 and 24 */
> +#define CFG_ACGEN      (1 << 24) /* System MMU 3.3 only */
> +#define CFG_SYSSEL     (1 << 22) /* System MMU 3.2 only */
> +#define CFG_FLPDCACHE  (1 << 20) /* System MMU 3.2+ only */
> +#define CFG_SHAREABLE  (1 << 12) /* System MMU 3.x only */
> +
>  #define REG_MMU_CTRL           0x000
>  #define REG_MMU_CFG            0x004
>  #define REG_MMU_STATUS         0x008
> @@ -96,6 +107,9 @@
>
>  #define REG_MMU_VERSION                0x034
>
> +#define MMU_MAJ_VER(reg)       (reg >> 28)
> +#define MMU_MIN_VER(reg)       ((reg >> 21) & 0x7F)
> +
>  #define REG_PB0_SADDR          0x04C
>  #define REG_PB0_EADDR          0x050
>  #define REG_PB1_SADDR          0x054
> @@ -126,16 +140,6 @@ enum exynos_sysmmu_inttype {
>         SYSMMU_FAULTS_NUM
>  };
>
> -/*
> - * @itype: type of fault.
> - * @pgtable_base: the physical address of page table base. This is 0 if
> @itype
> - *                is SYSMMU_BUSERROR.
> - * @fault_addr: the device (virtual) address that the System MMU tried to
> - *             translated. This is 0 if @itype is SYSMMU_BUSERROR.
> - */
> -typedef int (*sysmmu_fault_handler_t)(enum exynos_sysmmu_inttype itype,
> -                       unsigned long pgtable_base, unsigned long
> fault_addr);
> -
>  static unsigned short fault_reg_offset[SYSMMU_FAULTS_NUM] = {
>         REG_PAGE_FAULT_ADDR,
>         REG_AR_FAULT_ADDR,
> @@ -159,6 +163,14 @@ static char *sysmmu_fault_name[SYSMMU_FAULTS_NUM] = {
>         "UNKNOWN FAULT"
>  };
>
> +struct exynos_iommu_client {
> +       struct list_head node;  /* entry of exynos_iommu_domain.clients */
> +       struct device *dev;
> +       spinlock_t lock;
> +       int num_sysmmu;
> +       struct device *sysmmu[0];
> +};
> +
>  struct exynos_iommu_domain {
>         struct list_head clients; /* list of sysmmu_drvdata.node */
>         unsigned long *pgtable; /* lv1 page table, 16KB */
> @@ -170,13 +182,13 @@ struct exynos_iommu_domain {
>  struct sysmmu_drvdata {
>         struct list_head node; /* entry of exynos_iommu_domain.clients */
>         struct device *sysmmu;  /* System MMU's device descriptor */
> -       struct device *dev;     /* Owner of system MMU */
> +       struct device *master;  /* Owner of system MMU */
>         int nsfrs;
>         struct clk *clk;
>         int activations;
>         spinlock_t lock;
>         struct iommu_domain *domain;
> -       sysmmu_fault_handler_t fault_handler;
> +       bool runtime_active;
>         unsigned long pgtable;
>         void __iomem *sfrbases[0];
>  };
> @@ -200,6 +212,20 @@ static bool is_sysmmu_active(struct sysmmu_drvdata
> *data)
>         return data->activations > 0;
>  }
>
> +static unsigned int __sysmmu_version(struct sysmmu_drvdata *data,
> +                                       int idx, unsigned int *minor)
> +{
> +       unsigned int major;
> +
> +       major = readl(data->sfrbases[idx] + REG_MMU_VERSION);
> +
> +       if (minor)
> +               *minor = MMU_MIN_VER(major);
> +       major = MMU_MAJ_VER(major);
> +
> +       return major;
> +}
> +
>  static void sysmmu_unblock(void __iomem *sfrbase)
>  {
>         __raw_writel(CTRL_ENABLE, sfrbase + REG_MMU_CTRL);
> @@ -235,7 +261,6 @@ static void __sysmmu_tlb_invalidate_entry(void __iomem
> *sfrbase,
>  static void __sysmmu_set_ptbase(void __iomem *sfrbase,
>                                        unsigned long pgd)
>  {
> -       __raw_writel(0x1, sfrbase + REG_MMU_CFG); /* 16KB LV1, LRU */
>         __raw_writel(pgd, sfrbase + REG_PT_BASE_ADDR);
>
>         __sysmmu_tlb_invalidate(sfrbase);
> @@ -292,34 +317,17 @@ finish:
>         spin_unlock_irqrestore(&data->lock, flags);
>  }
>
> -static void __set_fault_handler(struct sysmmu_drvdata *data,
> -                                       sysmmu_fault_handler_t handler)
> -{
> -       unsigned long flags;
> -
> -       spin_lock_irqsave(&data->lock, flags);
> -       data->fault_handler = handler;
> -       spin_unlock_irqrestore(&data->lock, flags);
> -}
> -
> -void exynos_sysmmu_set_fault_handler(struct device *dev,
> -                                       sysmmu_fault_handler_t handler)
> -{
> -       struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
> -
> -       __set_fault_handler(data, handler);
> -}
> -
> -static int default_fault_handler(enum exynos_sysmmu_inttype itype,
> -                    unsigned long pgtable_base, unsigned long fault_addr)
> +static int show_fault_information(const char *name,
> +               enum exynos_sysmmu_inttype itype,
> +               unsigned long pgtable_base, unsigned long fault_addr)
>  {
>         unsigned long *ent;
>
>         if ((itype >= SYSMMU_FAULTS_NUM) || (itype < SYSMMU_PAGEFAULT))
>                 itype = SYSMMU_FAULT_UNKNOWN;
>
> -       pr_err("%s occurred at 0x%lx(Page table base: 0x%lx)\n",
> -                       sysmmu_fault_name[itype], fault_addr,
> pgtable_base);
> +       pr_err("%s occurred at 0x%lx by %s(Page table base: 0x%lx)\n",
> +               sysmmu_fault_name[itype], fault_addr, name, pgtable_base);
>
>         ent = section_entry(__va(pgtable_base), fault_addr);
>         pr_err("\tLv1 entry: 0x%lx\n", *ent);
> @@ -340,25 +348,34 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void
> *dev_id)
>  {
>         /* SYSMMU is in blocked when interrupt occurred. */
>         struct sysmmu_drvdata *data = dev_id;
> -       struct resource *irqres;
> -       struct platform_device *pdev;
> +       struct exynos_iommu_client *client = NULL;
> +       struct resource *memres;
>         enum exynos_sysmmu_inttype itype;
>         unsigned long addr = -1;
> -
>         int i, ret = -ENOSYS;
>
> -       spin_lock(&data->lock);
> +       if (data->master)
> +               client = data->master->archdata.iommu;
>
>         WARN_ON(!is_sysmmu_active(data));
>
> -       pdev = to_platform_device(data->sysmmu);
> -       for (i = 0; i < (pdev->num_resources / 2); i++) {
> -               irqres = platform_get_resource(pdev, IORESOURCE_IRQ, i);
> -               if (irqres && ((int)irqres->start == irq))
> +       for (i = 0; i < data->nsfrs; i++) {
> +               struct resource *irqres;
> +               irqres =
> platform_get_resource(to_platform_device(data->sysmmu),
> +                                               IORESOURCE_IRQ, i);
> +               if (irqres && ((int)irqres->start == irq)) {
> +                       memres = platform_get_resource(
> +                                       to_platform_device(data->sysmmu),
> +                                       IORESOURCE_MEM, i);
>                         break;
> +               }
>         }
>
> -       if (i == pdev->num_resources) {
> +       if (client)
> +               spin_lock(&client->lock);
> +       spin_lock(&data->lock);
> +
> +       if (i == data->nsfrs) {
>                 itype = SYSMMU_FAULT_UNKNOWN;
>         } else {
>                 itype = (enum exynos_sysmmu_inttype)
> @@ -371,197 +388,263 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void
> *dev_id)
>         }
>
>         if (data->domain)
> -               ret = report_iommu_fault(data->domain, data->dev,
> +               ret = report_iommu_fault(data->domain, data->master,
>                                 addr, itype);
>
> -       if ((ret == -ENOSYS) && data->fault_handler) {
> -               unsigned long base = data->pgtable;
> -               if (itype != SYSMMU_FAULT_UNKNOWN)
> -                       base = __raw_readl(
> -                                       data->sfrbases[i] +
> REG_PT_BASE_ADDR);
> -               ret = data->fault_handler(itype, base, addr);
> -       }
> -
>         if (!ret && (itype != SYSMMU_FAULT_UNKNOWN))
>                 __raw_writel(1 << itype, data->sfrbases[i] +
> REG_INT_CLEAR);
> -       else
> -               dev_dbg(data->sysmmu, "%s is not handled.\n",
> -                               sysmmu_fault_name[itype]);
> +       else {
> +               unsigned long ba = data->pgtable;
> +               if (itype != SYSMMU_FAULT_UNKNOWN)
> +                       ba = __raw_readl(data->sfrbases[i] +
> REG_PT_BASE_ADDR);
> +               show_fault_information(dev_name(data->sysmmu),
> +                                       itype, ba, addr);
> +       }
>
>         if (itype != SYSMMU_FAULT_UNKNOWN)
>                 sysmmu_unblock(data->sfrbases[i]);
>
>         spin_unlock(&data->lock);
> +       if (client)
> +               spin_unlock(&client->lock);
>
>         return IRQ_HANDLED;
>  }
>
> -static bool __exynos_sysmmu_disable(struct sysmmu_drvdata *data)
> +static void __sysmmu_disable_nocount(struct sysmmu_drvdata *data)
>  {
> +               int i;
> +
> +               for (i = 0; i < data->nsfrs; i++) {
> +                       __raw_writel(CTRL_DISABLE,
> +                                    data->sfrbases[i] + REG_MMU_CTRL);
> +                       __raw_writel(0, data->sfrbases[i] + REG_MMU_CFG);
> +               }
> +
> +               clk_disable(data->clk);
> +}
> +
> +static bool __sysmmu_disable(struct sysmmu_drvdata *data)
> +{
> +       bool disabled;
>         unsigned long flags;
> -       bool disabled = false;
> -       int i;
>
>         spin_lock_irqsave(&data->lock, flags);
>
> -       if (!set_sysmmu_inactive(data))
> -               goto finish;
> +       disabled = set_sysmmu_inactive(data);
>
> -       for (i = 0; i < data->nsfrs; i++)
> -               __raw_writel(CTRL_DISABLE, data->sfrbases[i] +
> REG_MMU_CTRL);
> +       if (disabled) {
> +               data->pgtable = 0;
> +               data->domain = NULL;
>
> -       if (data->clk)
> -               clk_disable(data->clk);
> +               if (data->runtime_active)
> +                       __sysmmu_disable_nocount(data);
>
> -       disabled = true;
> -       data->pgtable = 0;
> -       data->domain = NULL;
> -finish:
> -       spin_unlock_irqrestore(&data->lock, flags);
> -
> -       if (disabled)
>                 dev_dbg(data->sysmmu, "Disabled\n");
> -       else
> -               dev_dbg(data->sysmmu, "%d times left to be disabled\n",
> +       } else  {
> +               dev_dbg(data->sysmmu, "%d times left to disable\n",
>                                         data->activations);
> +       }
> +
> +       spin_unlock_irqrestore(&data->lock, flags);
>
>         return disabled;
>  }
>
> -/* __exynos_sysmmu_enable: Enables System MMU
> - *
> - * returns -error if an error occurred and System MMU is not enabled,
> - * 0 if the System MMU has been just enabled and 1 if System MMU was
> already
> - * enabled before.
> - */
> -static int __exynos_sysmmu_enable(struct sysmmu_drvdata *data,
> +
> +static void __sysmmu_init_config(struct sysmmu_drvdata *data, int idx)
> +{
> +       unsigned long cfg = CFG_LRU;
> +       int maj, min = 0;
> +
> +       maj = __sysmmu_version(data, idx, &min);
> +       if (maj == 3) {
> +               cfg |= CFG_SHAREABLE;
> +               if (min > 1) {
> +                       cfg |= CFG_FLPDCACHE;
> +                       cfg |= (min == 2) ? CFG_SYSSEL : CFG_ACGEN;
> +               }
> +       }
> +
> +       cfg |= __raw_readl(data->sfrbases[idx] + REG_MMU_CFG) & ~CFG_MASK;
> +       __raw_writel(cfg, data->sfrbases[idx] + REG_MMU_CFG);
> +}
> +
> +static void __sysmmu_enable_nocount(struct sysmmu_drvdata *data)
> +{
> +       int i;
> +
> +       clk_enable(data->clk);
> +
> +       for (i = 0; i < data->nsfrs; i++) {
> +               BUG_ON(__raw_readl(data->sfrbases[i] + REG_MMU_CTRL)
> +                                                               &
> CTRL_ENABLE);
>

We are assuming that the REG_MMU_CTRL will be 0 in the beginning.
In the newer versions of smmus (e.g. FIMD's sysmmu in Exynos5420), the
reset value of REG_MMU_CTRL is 1.
So this BUG will be triggered when sysmmu gets enabled for the first time.

One way to fix this is to pass an additional parameter to this function
'init':
The BUG_ON should not be checked when sysmmu is enabled for first time i.e.
from __sysmmu_enable (init = true)
And the BUG_ON can be checked when this function is called from else where
(init = false)



> +
> +               __sysmmu_init_config(data, i);
> +
> +               __sysmmu_set_ptbase(data->sfrbases[i], data->pgtable);
> +
> +               __raw_writel(CTRL_ENABLE, data->sfrbases[i] +
> REG_MMU_CTRL);
> +       }
> +}
> +
> +static int __sysmmu_enable(struct sysmmu_drvdata *data,
>                         unsigned long pgtable, struct iommu_domain *domain)
>  {
> -       int i, ret = 0;
> +       int ret = 0;
>         unsigned long flags;
>
>         spin_lock_irqsave(&data->lock, flags);
> +       if (set_sysmmu_active(data)) {
> +               data->pgtable = pgtable;
> +               data->domain = domain;
>
> -       if (!set_sysmmu_active(data)) {
> -               if (WARN_ON(pgtable != data->pgtable)) {
> -                       ret = -EBUSY;
> -                       set_sysmmu_inactive(data);
> -               } else {
> -                       ret = 1;
> -               }
> +               if (data->runtime_active)
> +                       __sysmmu_enable_nocount(data);
>
> -               dev_dbg(data->sysmmu, "Already enabled\n");
> -               goto finish;
> +               dev_dbg(data->sysmmu, "Enabled\n");
> +       } else {
> +               ret = (pgtable == data->pgtable) ? 1 : -EBUSY;
> +
> +               dev_dbg(data->sysmmu, "already enabled\n");
>         }
>
> -       if (data->clk)
> -               clk_enable(data->clk);
> +       if (WARN_ON(ret < 0))
> +               set_sysmmu_inactive(data); /* decrement count */
>
> -       data->pgtable = pgtable;
> +       spin_unlock_irqrestore(&data->lock, flags);
>
> -       for (i = 0; i < data->nsfrs; i++) {
> -               __sysmmu_set_ptbase(data->sfrbases[i], pgtable);
> +       return ret;
> +}
>
> -               if ((readl(data->sfrbases[i] + REG_MMU_VERSION) >> 28) ==
> 3) {
> -                       /* System MMU version is 3.x */
> -                       __raw_writel((1 << 12) | (2 << 28),
> -                                       data->sfrbases[i] + REG_MMU_CFG);
> -                       __sysmmu_set_prefbuf(data->sfrbases[i], 0, -1, 0);
> -                       __sysmmu_set_prefbuf(data->sfrbases[i], 0, -1, 1);
> -               }
> +/* __exynos_sysmmu_enable: Enables System MMU
> + *
> + * returns -error if an error occurred and System MMU is not enabled,
> + * 0 if the System MMU has been just enabled and 1 if System MMU was
> already
> + * enabled before.
> + */
> +static int __exynos_sysmmu_enable(struct device *dev, unsigned long
> pgtable,
> +                                 struct iommu_domain *domain)
> +{
> +       int ret = 0;
> +       unsigned long flags;
> +       struct exynos_iommu_client *client = dev->archdata.iommu;
> +       int i;
>
> -               __raw_writel(CTRL_ENABLE, data->sfrbases[i] +
> REG_MMU_CTRL);
> -       }
> +       if (WARN_ON(!client))
> +               return -ENODEV;
>
> -       data->domain = domain;
> +       spin_lock_irqsave(&client->lock, flags);
>
> -       dev_dbg(data->sysmmu, "Enabled\n");
> -finish:
> -       spin_unlock_irqrestore(&data->lock, flags);
> +       for (i = 0; i < client->num_sysmmu; i++) {
> +               struct sysmmu_drvdata *data =
> +                               dev_get_drvdata(client->sysmmu[i]);
> +               ret = __sysmmu_enable(data, pgtable, domain);
> +               if (ret < 0) {
> +                       int j;
> +                       for (j = 0; j < i; j++)
> +                               __sysmmu_disable(data);
> +                       break;
> +               } else {
> +                       data->master = dev;
> +               }
> +       }
> +
> +       spin_unlock_irqrestore(&client->lock, flags);
>
>         return ret;
>  }
>
>  int exynos_sysmmu_enable(struct device *dev, unsigned long pgtable)
>  {
> -       struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
>         int ret;
>
>         BUG_ON(!memblock_is_memory(pgtable));
>
> -       ret = pm_runtime_get_sync(data->sysmmu);
> -       if (ret < 0) {
> -               dev_dbg(data->sysmmu, "Failed to enable\n");
> -               return ret;
> -       }
> -
> -       ret = __exynos_sysmmu_enable(data, pgtable, NULL);
> -       if (WARN_ON(ret < 0)) {
> -               pm_runtime_put(data->sysmmu);
> -               dev_err(data->sysmmu,
> -                       "Already enabled with page table %#lx\n",
> -                       data->pgtable);
> -       } else {
> -               data->dev = dev;
> -       }
> +       ret = __exynos_sysmmu_enable(dev, pgtable, NULL);
>
>         return ret;
>  }
>
>  static bool exynos_sysmmu_disable(struct device *dev)
>  {
> -       struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
> -       bool disabled;
> +       unsigned long flags;
> +       bool disabled = true;
> +       struct exynos_iommu_client *client = dev->archdata.iommu;
> +       int i;
> +
> +       if (WARN_ON(!client))
> +               return true;
> +
> +       spin_lock_irqsave(&client->lock, flags);
> +
> +       /* Every call to __sysmmu_disable() must return same result */
> +       for (i = 0; i < client->num_sysmmu; i++) {
> +               struct sysmmu_drvdata *data =
> +                               dev_get_drvdata(client->sysmmu[i]);
> +               disabled = __sysmmu_disable(data);
> +               if (disabled)
> +                       data->master = NULL;
> +       }
>
> -       disabled = __exynos_sysmmu_disable(data);
> -       pm_runtime_put(data->sysmmu);
> +       spin_unlock_irqrestore(&client->lock, flags);
>
>         return disabled;
>  }
>
>  static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long
> iova)
>  {
> -       unsigned long flags;
> -       struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
> +       struct exynos_iommu_client *client = dev->archdata.iommu;
> +       int i;
>
> -       spin_lock_irqsave(&data->lock, flags);
> +       for (i = 0; i < client->num_sysmmu; i++) {
> +               unsigned long flags;
> +               struct sysmmu_drvdata *data;
>
> -       if (is_sysmmu_active(data)) {
> -               int i;
> -               for (i = 0; i < data->nsfrs; i++) {
> -                       if (sysmmu_block(data->sfrbases[i])) {
> +               data = dev_get_drvdata(client->sysmmu[i]);
> +
> +               spin_lock_irqsave(&data->lock, flags);
> +               if (is_sysmmu_active(data) && data->runtime_active) {
> +                       int i;
> +                       for (i = 0; i < data->nsfrs; i++)
>                                 __sysmmu_tlb_invalidate_entry(
>                                                 data->sfrbases[i], iova);
> -                               sysmmu_unblock(data->sfrbases[i]);
> -                       }
> +               } else {
> +                       dev_dbg(dev,
> +                               "disabled. Skipping TLB invalidation @
> %#lx\n",
> +                               iova);
>                 }
> -       } else {
> -               dev_dbg(data->sysmmu, "Disabled. Skipping invalidating
> TLB.\n");
> +               spin_unlock_irqrestore(&data->lock, flags);
>         }
> -
> -       spin_unlock_irqrestore(&data->lock, flags);
>  }
>
>  void exynos_sysmmu_tlb_invalidate(struct device *dev)
>  {
> -       unsigned long flags;
> -       struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
> -
> -       spin_lock_irqsave(&data->lock, flags);
> +       struct exynos_iommu_client *client = dev->archdata.iommu;
> +       int i;
>
> -       if (is_sysmmu_active(data)) {
> -               int i;
> -               for (i = 0; i < data->nsfrs; i++) {
> -                       if (sysmmu_block(data->sfrbases[i])) {
> -                               __sysmmu_tlb_invalidate(data->sfrbases[i]);
> -                               sysmmu_unblock(data->sfrbases[i]);
> +       for (i = 0; i < client->num_sysmmu; i++) {
> +               unsigned long flags;
> +               struct sysmmu_drvdata *data;
> +
> +               data = dev_get_drvdata(client->sysmmu[i]);
> +
> +               spin_lock_irqsave(&data->lock, flags);
> +               if (is_sysmmu_active(data) &&
> +                               data->runtime_active) {
> +                       int i;
> +                       for (i = 0; i < data->nsfrs; i++) {
> +                               if (sysmmu_block(data->sfrbases[i])) {
> +                                       __sysmmu_tlb_invalidate(
> +                                                       data->sfrbases[i]);
> +                                       sysmmu_unblock(data->sfrbases[i]);
> +                               }
>                         }
> +               } else {
> +                       dev_dbg(dev, "disabled. Skipping TLB
> invalidation\n");
>                 }
> -       } else {
> -               dev_dbg(data->sysmmu, "Disabled. Skipping invalidating
> TLB.\n");
> +               spin_unlock_irqrestore(&data->lock, flags);
>         }
> -
> -       spin_unlock_irqrestore(&data->lock, flags);
>  }
>
>  static int __init exynos_sysmmu_probe(struct platform_device *pdev)
> @@ -622,8 +705,6 @@ static int __init exynos_sysmmu_probe(struct
> platform_device *pdev)
>
>         pm_runtime_enable(dev);
>
> -       __set_fault_handler(data, &default_fault_handler);
> -
>         data->sysmmu = dev;
>         data->clk = devm_clk_get(dev, "sysmmu");
>         if (IS_ERR(data->clk)) {
> @@ -647,6 +728,8 @@ static int __init exynos_sysmmu_probe(struct
> platform_device *pdev)
>                 }
>         }
>
> +       data->runtime_active = !pm_runtime_enabled(dev);
>

We are enabling pm_runtime in the probe itself. Is this check still
required?
We can directly set data->runtime_active to false since sysmmus get probed
first.

+
>         spin_lock_init(&data->lock);
>         INIT_LIST_HEAD(&data->node);
>
> @@ -656,6 +739,34 @@ static int __init exynos_sysmmu_probe(struct
> platform_device *pdev)
>         return ret;
>  }
>
> +#ifdef CONFIG_PM_SLEEP
> +static int sysmmu_suspend(struct device *dev)
> +{
> +       struct sysmmu_drvdata *data = dev_get_drvdata(dev);
> +       unsigned long flags;
> +       spin_lock_irqsave(&data->lock, flags);
> +       if (is_sysmmu_active(data) &&
> +               (!pm_runtime_enabled(dev) || data->runtime_active))
> +               __sysmmu_disable_nocount(data);
> +       spin_unlock_irqrestore(&data->lock, flags);
> +       return 0;
> +}
> +
> +static int sysmmu_resume(struct device *dev)
> +{
> +       struct sysmmu_drvdata *data = dev_get_drvdata(dev);
> +       unsigned long flags;
> +       spin_lock_irqsave(&data->lock, flags);
> +       if (is_sysmmu_active(data) &&
> +               (!pm_runtime_enabled(dev) || data->runtime_active))
> +               __sysmmu_enable_nocount(data);
> +       spin_unlock_irqrestore(&data->lock, flags);
> +       return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(sysmmu_pm_ops, sysmmu_suspend, sysmmu_resume);
> +
>  #ifdef CONFIG_OF
>  static struct of_device_id sysmmu_of_match[] __initconst = {
>         { .compatible   = "samsung,exynos4210-sysmmu", },
> @@ -668,6 +779,7 @@ static struct platform_driver exynos_sysmmu_driver
> __refdata = {
>         .driver = {
>                 .owner          = THIS_MODULE,
>                 .name           = "exynos-sysmmu",
> +               .pm             = &sysmmu_pm_ops,
>                 .of_match_table = of_match_ptr(sysmmu_of_match),
>         }
>  };
> @@ -720,7 +832,7 @@ err_pgtable:
>  static void exynos_iommu_domain_destroy(struct iommu_domain *domain)
>  {
>         struct exynos_iommu_domain *priv = domain->priv;
> -       struct sysmmu_drvdata *data;
> +       struct exynos_iommu_client *client;
>         unsigned long flags;
>         int i;
>
> @@ -728,11 +840,14 @@ static void exynos_iommu_domain_destroy(struct
> iommu_domain *domain)
>
>         spin_lock_irqsave(&priv->lock, flags);
>
> -       list_for_each_entry(data, &priv->clients, node) {
> -               while (!exynos_sysmmu_disable(data->dev))
> +       list_for_each_entry(client, &priv->clients, node) {
> +               while (!exynos_sysmmu_disable(client->dev))
>                         ; /* until System MMU is actually disabled */
>         }
>
> +       while (!list_empty(&priv->clients))
> +               list_del_init(priv->clients.next);
> +
>         spin_unlock_irqrestore(&priv->lock, flags);
>
>         for (i = 0; i < NUM_LV1ENTRIES; i++)
> @@ -749,41 +864,26 @@ static void exynos_iommu_domain_destroy(struct
> iommu_domain *domain)
>  static int exynos_iommu_attach_device(struct iommu_domain *domain,
>                                    struct device *dev)
>  {
> -       struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
> +       struct exynos_iommu_client *client = dev->archdata.iommu;
>         struct exynos_iommu_domain *priv = domain->priv;
>         unsigned long flags;
>         int ret;
>
> -       ret = pm_runtime_get_sync(data->sysmmu);
> -       if (ret < 0)
> -               return ret;
> -
> -       ret = 0;
> -
>         spin_lock_irqsave(&priv->lock, flags);
>
> -       ret = __exynos_sysmmu_enable(data, __pa(priv->pgtable), domain);
> -
> -       if (ret == 0) {
> -               /* 'data->node' must not be appeared in priv->clients */
> -               BUG_ON(!list_empty(&data->node));
> -               data->dev = dev;
> -               list_add_tail(&data->node, &priv->clients);
> -       }
> +       ret = __exynos_sysmmu_enable(dev, __pa(priv->pgtable), domain);
> +       if (ret == 0)
> +               list_add_tail(&client->node, &priv->clients);
>
>         spin_unlock_irqrestore(&priv->lock, flags);
>
> -       if (ret < 0) {
> +       if (ret < 0)
>                 dev_err(dev, "%s: Failed to attach IOMMU with pgtable
> %#lx\n",
>                                 __func__, __pa(priv->pgtable));
> -               pm_runtime_put(data->sysmmu);
> -       } else if (ret > 0) {
> -               dev_dbg(dev, "%s: IOMMU with pgtable 0x%lx already
> attached\n",
> -                                       __func__, __pa(priv->pgtable));
> -       } else {
> -               dev_dbg(dev, "%s: Attached new IOMMU with pgtable 0x%lx\n",
> -                                       __func__, __pa(priv->pgtable));
> -       }
> +       else
> +               dev_dbg(dev, "%s: Attached IOMMU with pgtable 0x%lx%s\n",
> +                                       __func__, __pa(priv->pgtable),
> +                                       (ret == 0) ? "" : ", again");
>
>         return ret;
>  }
> @@ -791,39 +891,27 @@ static int exynos_iommu_attach_device(struct
> iommu_domain *domain,
>  static void exynos_iommu_detach_device(struct iommu_domain *domain,
>                                     struct device *dev)
>  {
> -       struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
> +       struct exynos_iommu_client *client = NULL;
>         struct exynos_iommu_domain *priv = domain->priv;
> -       struct list_head *pos;
>         unsigned long flags;
> -       bool found = false;
>
>         spin_lock_irqsave(&priv->lock, flags);
>
> -       list_for_each(pos, &priv->clients) {
> -               if (list_entry(pos, struct sysmmu_drvdata, node) == data) {
> -                       found = true;
> +       list_for_each_entry(client, &priv->clients, node) {
> +               if (client == dev->archdata.iommu) {
> +                       if (exynos_sysmmu_disable(dev))
> +                               list_del_init(&client->node);
>                         break;
>                 }
>         }
>
> -       if (!found)
> -               goto finish;
> +       spin_unlock_irqrestore(&priv->lock, flags);
>
> -       if (__exynos_sysmmu_disable(data)) {
> +       if (client == dev->archdata.iommu)
>                 dev_dbg(dev, "%s: Detached IOMMU with pgtable %#lx\n",
>                                         __func__, __pa(priv->pgtable));
> -               list_del_init(&data->node);
> -
> -       } else {
> -               dev_dbg(dev, "%s: Detaching IOMMU with pgtable %#lx
> delayed",
> -                                       __func__, __pa(priv->pgtable));
> -       }
> -
> -finish:
> -       spin_unlock_irqrestore(&priv->lock, flags);
> -
> -       if (found)
> -               pm_runtime_put(data->sysmmu);
> +       else
> +               dev_dbg(dev, "%s: No IOMMU is attached\n", __func__);
>  }
>
>  static unsigned long *alloc_lv2entry(unsigned long *sent, unsigned long
> iova,
> @@ -940,7 +1028,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain
> *domain,
>                                                unsigned long iova, size_t
> size)
>  {
>         struct exynos_iommu_domain *priv = domain->priv;
> -       struct sysmmu_drvdata *data;
> +       struct exynos_iommu_client *client;
>         unsigned long flags;
>         unsigned long *ent;
>         size_t err_page;
> @@ -997,8 +1085,8 @@ done:
>         spin_unlock_irqrestore(&priv->pgtablelock, flags);
>
>         spin_lock_irqsave(&priv->lock, flags);
> -       list_for_each_entry(data, &priv->clients, node)
> -               sysmmu_tlb_invalidate_entry(data->dev, iova);
> +       list_for_each_entry(client, &priv->clients, node)
> +               sysmmu_tlb_invalidate_entry(client->dev, iova);
>         spin_unlock_irqrestore(&priv->lock, flags);
>
>         return size;
> @@ -1082,3 +1170,275 @@ static int __init exynos_iommu_init(void)
>         return ret;
>  }
>  subsys_initcall(exynos_iommu_init);
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int sysmmu_pm_genpd_suspend(struct device *dev)
> +{
> +       struct exynos_iommu_client *client = dev->archdata.iommu;
> +       int ret = 0;
> +       int i;
> +
> +       for (i = 0; i < client->num_sysmmu; i++) {
> +               ret = pm_generic_suspend(client->sysmmu[i]);
> +               if (ret)
> +                       break;
> +       }
> +
> +       if (!ret)
> +               ret = pm_generic_suspend(dev);
> +
> +       if (ret) {
> +               int j;
> +
> +               for (j = 0; j < i; j++)
> +                       pm_generic_resume(client->sysmmu[j]);
> +       }
> +
> +       return ret;
> +}
> +
> +static int sysmmu_pm_genpd_resume(struct device *dev)
> +{
> +       struct exynos_iommu_client *client = dev->archdata.iommu;
> +       int ret = 0;
> +       int i;
> +
> +       for (i = 0; i < client->num_sysmmu; i++) {
> +               ret = pm_generic_resume(client->sysmmu[i]);
> +               if (ret)
> +                       break;
> +       }
> +
> +       if (!ret)
> +               ret = pm_generic_resume(dev);
> +
> +       if (ret) {
> +               int j;
> +
> +               for (j = 0; j < i; j++)
> +                       pm_generic_suspend(client->sysmmu[j]);
> +       }
> +
> +       return ret;
> +}
> +#endif
> +
> +#ifdef CONFIG_PM_RUNTIME
> +static void sysmmu_restore_state(struct device *sysmmu)
> +{
> +       struct sysmmu_drvdata *data = dev_get_drvdata(sysmmu);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&data->lock, flags);
> +       data->runtime_active = true;
> +       if (is_sysmmu_active(data))
> +               __sysmmu_enable_nocount(data);
> +       spin_unlock_irqrestore(&data->lock, flags);
> +}
> +
> +static void sysmmu_save_state(struct device *sysmmu)
> +{
> +       struct sysmmu_drvdata *data = dev_get_drvdata(sysmmu);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&data->lock, flags);
> +       if (is_sysmmu_active(data))
> +               __sysmmu_disable_nocount(data);
> +       data->runtime_active = false;
> +       spin_unlock_irqrestore(&data->lock, flags);
> +}
> +
> +static int sysmmu_pm_genpd_save_state(struct device *dev)
> +{
> +       struct exynos_iommu_client *client = dev->archdata.iommu;
> +       int (*cb)(struct device *__dev);
> +       int i;
> +
> +       if (dev->type && dev->type->pm)
> +               cb = dev->type->pm->runtime_suspend;
> +       else if (dev->class && dev->class->pm)
> +               cb = dev->class->pm->runtime_suspend;
> +       else if (dev->bus && dev->bus->pm)
> +               cb = dev->bus->pm->runtime_suspend;
> +       else
> +               cb = NULL;
> +
> +       if (!cb && dev->driver && dev->driver->pm)
> +               cb = dev->driver->pm->runtime_suspend;
> +
> +       if (cb) {
> +               int ret;
> +
> +               ret = cb(dev);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       for (i = 0; i < client->num_sysmmu; i++)
> +               sysmmu_save_state(client->sysmmu[i]);
> +
> +       return 0;
> +}
> +
> +static int sysmmu_pm_genpd_restore_state(struct device *dev)
> +{
> +       struct exynos_iommu_client *client = dev->archdata.iommu;
> +       int (*cb)(struct device *__dev);
> +       int i;
> +
> +       if (dev->type && dev->type->pm)
> +               cb = dev->type->pm->runtime_resume;
> +       else if (dev->class && dev->class->pm)
> +               cb = dev->class->pm->runtime_resume;
> +       else if (dev->bus && dev->bus->pm)
> +               cb = dev->bus->pm->runtime_resume;
> +       else
> +               cb = NULL;
> +
> +       if (!cb && dev->driver && dev->driver->pm)
> +               cb = dev->driver->pm->runtime_resume;
> +
> +       for (i = 0; i < client->num_sysmmu; i++)
> +               sysmmu_restore_state(client->sysmmu[i]);
> +
> +       if (cb) {
> +               int ret;
> +               ret = cb(dev);
> +               if (ret) {
> +                       for (i = 0; i < client->num_sysmmu; i++)
> +                               sysmmu_save_state(client->sysmmu[i]);
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +#endif
> +
> +#ifdef CONFIG_PM_GENERIC_DOMAINS
> +struct gpd_dev_ops sysmmu_devpm_ops = {
> +#ifdef CONFIG_PM_RUNTIME
> +       .save_state = &sysmmu_pm_genpd_save_state,
> +       .restore_state = &sysmmu_pm_genpd_restore_state,
> +#endif
> +#ifdef CONFIG_PM_SLEEP
> +       .suspend = &sysmmu_pm_genpd_suspend,
> +       .resume = &sysmmu_pm_genpd_resume,
> +#endif
> +};
> +#endif /* CONFIG_PM_GENERIC_DOMAINS */
> +
> +static int sysmmu_hook_driver_register(struct notifier_block *nb,
> +                                       unsigned long val,
> +                                       void *p)
> +{
> +       struct device *dev = p;
> +
> +       switch (val) {
> +       case BUS_NOTIFY_BIND_DRIVER:
> +       {
> +               int i = 0;
> +               int size = 0;
> +               const __be32 *phandle;
> +               struct exynos_iommu_client *client;
> +
> +               phandle = of_get_property(dev->of_node, "iommu", &size);
> +               if (!phandle)
> +                       break;
> +
> +               size = size / sizeof(*phandle); /* number of elements */
> +
> +               client = devm_kzalloc(dev, sizeof(*client) * size,
> GFP_KERNEL);
> +               if (!client) {
> +                       dev_err(dev, "No Memory for
> exynos_iommu_client\n");
> +                       return -ENOMEM;
> +               }
> +
> +               client->num_sysmmu = size;
> +               client->dev = dev;
> +               INIT_LIST_HEAD(&client->node);
> +               spin_lock_init(&client->lock);
> +
> +               for (i = 0; i < size; i++) {
> +                       struct device_node *np;
> +                       struct platform_device *sysmmu;
> +
> +                       /* this always success: see above
> of_find_property() */
> +                       np = of_parse_phandle(dev->of_node, "iommu", i);
> +
> +                       sysmmu = of_find_device_by_node(np);
> +                       if (!sysmmu) {
> +                               dev_err(dev,
> +                                       "sysmmu node '%s' is not found\n",
> +                                       np->name);
> +                               break;
> +                       }
> +
> +                       client->sysmmu[i] = &sysmmu->dev;
> +               }
> +
> +               if (i < size) {
> +                       while (--i >= 0)
> +                               of_node_put(client->sysmmu[i]->of_node);
> +                       devm_kfree(dev, client);
> +                       return -ENODEV;
> +               }
> +
> +               i = pm_genpd_add_callbacks(dev, &sysmmu_devpm_ops, NULL);
> +               if (i && (i != -ENOSYS)) {
> +                       dev_err(dev,
> +                               "Failed to register 'dev_pm_ops' for
> iommu\n");
> +                       devm_kfree(dev, client);
> +                       return i;
> +               }
> +
> +               dev->archdata.iommu = client;
> +               break;
> +       }
> +       case BUS_NOTIFY_BOUND_DRIVER:
> +       {
> +               struct exynos_iommu_client *client = dev->archdata.iommu;
> +               if (dev->archdata.iommu &&
> +                               (!pm_runtime_enabled(dev) ||
> +                                        IS_ERR(dev_to_genpd(dev)))) {
> +                       int i;
> +                       for (i = 0; i < client->num_sysmmu; i++) {
> +                               struct sysmmu_drvdata *data;
> +                               pm_runtime_disable(client->sysmmu[i]);
> +                               data = dev_get_drvdata(client->sysmmu[i]);
> +                               if (!data)
> +                                       continue;
> +                               data->runtime_active =
> +                                       !pm_runtime_enabled(data->sysmmu);
> +                               if (data->runtime_active &&
> +                                               is_sysmmu_active(data))
> +                                       __sysmmu_enable_nocount(data);
> +                       }
> +               }
> +               break;
> +       }
> +       case BUS_NOTIFY_UNBOUND_DRIVER:
> +       {
> +               if (dev->archdata.iommu) {
> +                       __pm_genpd_remove_callbacks(dev, false);
> +
> +                       devm_kfree(dev, dev->archdata.iommu);
> +
> +                       dev->archdata.iommu = NULL;
> +               }
> +               break;
> +       }
> +       } /* switch (val) */
> +
> +       return 0;
> +}
> +
> +static struct notifier_block sysmmu_notifier = {
> +       .notifier_call = &sysmmu_hook_driver_register,
> +};
> +
> +static int __init exynos_iommu_prepare(void)
> +{
> +       return bus_register_notifier(&platform_bus_type, &sysmmu_notifier);
> +}
> +arch_initcall(exynos_iommu_prepare);
> --
> 1.7.2.5
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-samsung-soc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--047d7bd9158ec1930f04e12993b2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I think this patch can be split further.<div>There is a lo=
t more added in this patch (suspend/resume functions etc) than just adding =
a bus notifier.</div><div><br></div><div>I will review further and also, te=
st this patchset.</div>
<div><br></div><div>Regards,</div><div>Prathyush</div><div class=3D"gmail_e=
xtra"><br><br><div class=3D"gmail_quote">On Fri, Jul 5, 2013 at 5:59 PM, Ch=
o KyongHo <span dir=3D"ltr">&lt;<a href=3D"mailto:pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" t=
arget=3D"_blank">pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">When a device driver is registered, all cons=
tructs to handle System MMU<br>
is prepared by bus notifier call.<br>
<br>
Signed-off-by: Cho KyongHo &lt;<a href=3D"mailto:pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org">pu=
llip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt;<br>
---<br>
=A0drivers/iommu/exynos-iommu.c | =A0778 ++++++++++++++++++++++++++++++----=
-------<br>
=A01 files changed, 569 insertions(+), 209 deletions(-)<br>
<br>
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c<br=
>
index b151e51..51d43bb 100644<br>
--- a/drivers/iommu/exynos-iommu.c<br>
+++ b/drivers/iommu/exynos-iommu.c<br>
@@ -27,6 +27,9 @@<br>
=A0#include &lt;linux/memblock.h&gt;<br>
=A0#include &lt;linux/export.h&gt;<br>
=A0#include &lt;linux/of.h&gt;<br>
+#include &lt;linux/of_platform.h&gt;<br>
+#include &lt;linux/pm_domain.h&gt;<br>
+#include &lt;linux/notifier.h&gt;<br>
<br>
=A0#include &lt;asm/cacheflush.h&gt;<br>
=A0#include &lt;asm/pgtable.h&gt;<br>
@@ -80,6 +83,14 @@<br>
=A0#define CTRL_BLOCK =A0 =A0 0x7<br>
=A0#define CTRL_DISABLE =A0 0x0<br>
<br>
+#define CFG_LRU =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1<br>
+#define CFG_QOS(n) =A0 =A0 ((n &amp; 0xF) &lt;&lt; 7)<br>
+#define CFG_MASK =A0 =A0 =A0 0x0150FFFF /* Selecting bit 0-15, 20, 22 and =
24 */<br>
+#define CFG_ACGEN =A0 =A0 =A0(1 &lt;&lt; 24) /* System MMU 3.3 only */<br>
+#define CFG_SYSSEL =A0 =A0 (1 &lt;&lt; 22) /* System MMU 3.2 only */<br>
+#define CFG_FLPDCACHE =A0(1 &lt;&lt; 20) /* System MMU 3.2+ only */<br>
+#define CFG_SHAREABLE =A0(1 &lt;&lt; 12) /* System MMU 3.x only */<br>
+<br>
=A0#define REG_MMU_CTRL =A0 =A0 =A0 =A0 =A0 0x000<br>
=A0#define REG_MMU_CFG =A0 =A0 =A0 =A0 =A0 =A00x004<br>
=A0#define REG_MMU_STATUS =A0 =A0 =A0 =A0 0x008<br>
@@ -96,6 +107,9 @@<br>
<br>
=A0#define REG_MMU_VERSION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x034<br>
<br>
+#define MMU_MAJ_VER(reg) =A0 =A0 =A0 (reg &gt;&gt; 28)<br>
+#define MMU_MIN_VER(reg) =A0 =A0 =A0 ((reg &gt;&gt; 21) &amp; 0x7F)<br>
+<br>
=A0#define REG_PB0_SADDR =A0 =A0 =A0 =A0 =A00x04C<br>
=A0#define REG_PB0_EADDR =A0 =A0 =A0 =A0 =A00x050<br>
=A0#define REG_PB1_SADDR =A0 =A0 =A0 =A0 =A00x054<br>
@@ -126,16 +140,6 @@ enum exynos_sysmmu_inttype {<br>
=A0 =A0 =A0 =A0 SYSMMU_FAULTS_NUM<br>
=A0};<br>
<br>
-/*<br>
- * @itype: type of fault.<br>
- * @pgtable_base: the physical address of page table base. This is 0 if @i=
type<br>
- * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0is SYSMMU_BUSERROR.<br>
- * @fault_addr: the device (virtual) address that the System MMU tried to<=
br>
- * =A0 =A0 =A0 =A0 =A0 =A0 translated. This is 0 if @itype is SYSMMU_BUSER=
ROR.<br>
- */<br>
-typedef int (*sysmmu_fault_handler_t)(enum exynos_sysmmu_inttype itype,<br=
>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long pgtable_base, u=
nsigned long fault_addr);<br>
-<br>
=A0static unsigned short fault_reg_offset[SYSMMU_FAULTS_NUM] =3D {<br>
=A0 =A0 =A0 =A0 REG_PAGE_FAULT_ADDR,<br>
=A0 =A0 =A0 =A0 REG_AR_FAULT_ADDR,<br>
@@ -159,6 +163,14 @@ static char *sysmmu_fault_name[SYSMMU_FAULTS_NUM] =3D =
{<br>
=A0 =A0 =A0 =A0 &quot;UNKNOWN FAULT&quot;<br>
=A0};<br>
<br>
+struct exynos_iommu_client {<br>
+ =A0 =A0 =A0 struct list_head node; =A0/* entry of exynos_iommu_domain.cli=
ents */<br>
+ =A0 =A0 =A0 struct device *dev;<br>
+ =A0 =A0 =A0 spinlock_t lock;<br>
+ =A0 =A0 =A0 int num_sysmmu;<br>
+ =A0 =A0 =A0 struct device *sysmmu[0];<br>
+};<br>
+<br>
=A0struct exynos_iommu_domain {<br>
=A0 =A0 =A0 =A0 struct list_head clients; /* list of sysmmu_drvdata.node */=
<br>
=A0 =A0 =A0 =A0 unsigned long *pgtable; /* lv1 page table, 16KB */<br>
@@ -170,13 +182,13 @@ struct exynos_iommu_domain {<br>
=A0struct sysmmu_drvdata {<br>
=A0 =A0 =A0 =A0 struct list_head node; /* entry of exynos_iommu_domain.clie=
nts */<br>
=A0 =A0 =A0 =A0 struct device *sysmmu; =A0/* System MMU&#39;s device descri=
ptor */<br>
- =A0 =A0 =A0 struct device *dev; =A0 =A0 /* Owner of system MMU */<br>
+ =A0 =A0 =A0 struct device *master; =A0/* Owner of system MMU */<br>
=A0 =A0 =A0 =A0 int nsfrs;<br>
=A0 =A0 =A0 =A0 struct clk *clk;<br>
=A0 =A0 =A0 =A0 int activations;<br>
=A0 =A0 =A0 =A0 spinlock_t lock;<br>
=A0 =A0 =A0 =A0 struct iommu_domain *domain;<br>
- =A0 =A0 =A0 sysmmu_fault_handler_t fault_handler;<br>
+ =A0 =A0 =A0 bool runtime_active;<br>
=A0 =A0 =A0 =A0 unsigned long pgtable;<br>
=A0 =A0 =A0 =A0 void __iomem *sfrbases[0];<br>
=A0};<br>
@@ -200,6 +212,20 @@ static bool is_sysmmu_active(struct sysmmu_drvdata *da=
ta)<br>
=A0 =A0 =A0 =A0 return data-&gt;activations &gt; 0;<br>
=A0}<br>
<br>
+static unsigned int __sysmmu_version(struct sysmmu_drvdata *data,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 int idx, unsigned int *minor)<br>
+{<br>
+ =A0 =A0 =A0 unsigned int major;<br>
+<br>
+ =A0 =A0 =A0 major =3D readl(data-&gt;sfrbases[idx] + REG_MMU_VERSION);<br=
>
+<br>
+ =A0 =A0 =A0 if (minor)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 *minor =3D MMU_MIN_VER(major);<br>
+ =A0 =A0 =A0 major =3D MMU_MAJ_VER(major);<br>
+<br>
+ =A0 =A0 =A0 return major;<br>
+}<br>
+<br>
=A0static void sysmmu_unblock(void __iomem *sfrbase)<br>
=A0{<br>
=A0 =A0 =A0 =A0 __raw_writel(CTRL_ENABLE, sfrbase + REG_MMU_CTRL);<br>
@@ -235,7 +261,6 @@ static void __sysmmu_tlb_invalidate_entry(void __iomem =
*sfrbase,<br>
=A0static void __sysmmu_set_ptbase(void __iomem *sfrbase,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0unsigned long pgd)<br>
=A0{<br>
- =A0 =A0 =A0 __raw_writel(0x1, sfrbase + REG_MMU_CFG); /* 16KB LV1, LRU */=
<br>
=A0 =A0 =A0 =A0 __raw_writel(pgd, sfrbase + REG_PT_BASE_ADDR);<br>
<br>
=A0 =A0 =A0 =A0 __sysmmu_tlb_invalidate(sfrbase);<br>
@@ -292,34 +317,17 @@ finish:<br>
=A0 =A0 =A0 =A0 spin_unlock_irqrestore(&amp;data-&gt;lock, flags);<br>
=A0}<br>
<br>
-static void __set_fault_handler(struct sysmmu_drvdata *data,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 sysmmu_fault_handler_t handler)<br>
-{<br>
- =A0 =A0 =A0 unsigned long flags;<br>
-<br>
- =A0 =A0 =A0 spin_lock_irqsave(&amp;data-&gt;lock, flags);<br>
- =A0 =A0 =A0 data-&gt;fault_handler =3D handler;<br>
- =A0 =A0 =A0 spin_unlock_irqrestore(&amp;data-&gt;lock, flags);<br>
-}<br>
-<br>
-void exynos_sysmmu_set_fault_handler(struct device *dev,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 sysmmu_fault_handler_t handler)<br>
-{<br>
- =A0 =A0 =A0 struct sysmmu_drvdata *data =3D dev_get_drvdata(dev-&gt;archd=
ata.iommu);<br>
-<br>
- =A0 =A0 =A0 __set_fault_handler(data, handler);<br>
-}<br>
-<br>
-static int default_fault_handler(enum exynos_sysmmu_inttype itype,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long pgtable_base, unsign=
ed long fault_addr)<br>
+static int show_fault_information(const char *name,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum exynos_sysmmu_inttype itype,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long pgtable_base, unsigned long fau=
lt_addr)<br>
=A0{<br>
=A0 =A0 =A0 =A0 unsigned long *ent;<br>
<br>
=A0 =A0 =A0 =A0 if ((itype &gt;=3D SYSMMU_FAULTS_NUM) || (itype &lt; SYSMMU=
_PAGEFAULT))<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 itype =3D SYSMMU_FAULT_UNKNOWN;<br>
<br>
- =A0 =A0 =A0 pr_err(&quot;%s occurred at 0x%lx(Page table base: 0x%lx)\n&q=
uot;,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_fault_name[itype], fau=
lt_addr, pgtable_base);<br>
+ =A0 =A0 =A0 pr_err(&quot;%s occurred at 0x%lx by %s(Page table base: 0x%l=
x)\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_fault_name[itype], fault_addr, name, p=
gtable_base);<br>
<br>
=A0 =A0 =A0 =A0 ent =3D section_entry(__va(pgtable_base), fault_addr);<br>
=A0 =A0 =A0 =A0 pr_err(&quot;\tLv1 entry: 0x%lx\n&quot;, *ent);<br>
@@ -340,25 +348,34 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *d=
ev_id)<br>
=A0{<br>
=A0 =A0 =A0 =A0 /* SYSMMU is in blocked when interrupt occurred. */<br>
=A0 =A0 =A0 =A0 struct sysmmu_drvdata *data =3D dev_id;<br>
- =A0 =A0 =A0 struct resource *irqres;<br>
- =A0 =A0 =A0 struct platform_device *pdev;<br>
+ =A0 =A0 =A0 struct exynos_iommu_client *client =3D NULL;<br>
+ =A0 =A0 =A0 struct resource *memres;<br>
=A0 =A0 =A0 =A0 enum exynos_sysmmu_inttype itype;<br>
=A0 =A0 =A0 =A0 unsigned long addr =3D -1;<br>
-<br>
=A0 =A0 =A0 =A0 int i, ret =3D -ENOSYS;<br>
<br>
- =A0 =A0 =A0 spin_lock(&amp;data-&gt;lock);<br>
+ =A0 =A0 =A0 if (data-&gt;master)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 client =3D data-&gt;master-&gt;archdata.iommu=
;<br>
<br>
=A0 =A0 =A0 =A0 WARN_ON(!is_sysmmu_active(data));<br>
<br>
- =A0 =A0 =A0 pdev =3D to_platform_device(data-&gt;sysmmu);<br>
- =A0 =A0 =A0 for (i =3D 0; i &lt; (pdev-&gt;num_resources / 2); i++) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 irqres =3D platform_get_resource(pdev, IORESO=
URCE_IRQ, i);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (irqres &amp;&amp; ((int)irqres-&gt;start =
=3D=3D irq))<br>
+ =A0 =A0 =A0 for (i =3D 0; i &lt; data-&gt;nsfrs; i++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct resource *irqres;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 irqres =3D platform_get_resource(to_platform_=
device(data-&gt;sysmmu),<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 IORESOURCE_IRQ, i);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (irqres &amp;&amp; ((int)irqres-&gt;start =
=3D=3D irq)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memres =3D platform_get_resou=
rce(<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 to_platform_device(data-&gt;sysmmu),<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 IORESOURCE_MEM, i);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
=A0 =A0 =A0 =A0 }<br>
<br>
- =A0 =A0 =A0 if (i =3D=3D pdev-&gt;num_resources) {<br>
+ =A0 =A0 =A0 if (client)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&amp;client-&gt;lock);<br>
+ =A0 =A0 =A0 spin_lock(&amp;data-&gt;lock);<br>
+<br>
+ =A0 =A0 =A0 if (i =3D=3D data-&gt;nsfrs) {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 itype =3D SYSMMU_FAULT_UNKNOWN;<br>
=A0 =A0 =A0 =A0 } else {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 itype =3D (enum exynos_sysmmu_inttype)<br>
@@ -371,197 +388,263 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void =
*dev_id)<br>
=A0 =A0 =A0 =A0 }<br>
<br>
=A0 =A0 =A0 =A0 if (data-&gt;domain)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D report_iommu_fault(data-&gt;domain, d=
ata-&gt;dev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D report_iommu_fault(data-&gt;domain, d=
ata-&gt;master,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr, itype=
);<br>
<br>
- =A0 =A0 =A0 if ((ret =3D=3D -ENOSYS) &amp;&amp; data-&gt;fault_handler) {=
<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long base =3D data-&gt;pgtable;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (itype !=3D SYSMMU_FAULT_UNKNOWN)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D __raw_readl(<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 data-&gt;sfrbases[i] + REG_PT_BASE_ADDR);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D data-&gt;fault_handler(itype, base, a=
ddr);<br>
- =A0 =A0 =A0 }<br>
-<br>
=A0 =A0 =A0 =A0 if (!ret &amp;&amp; (itype !=3D SYSMMU_FAULT_UNKNOWN))<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(1 &lt;&lt; itype, data-&gt;sfr=
bases[i] + REG_INT_CLEAR);<br>
- =A0 =A0 =A0 else<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(data-&gt;sysmmu, &quot;%s is not hand=
led.\n&quot;,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_fault_=
name[itype]);<br>
+ =A0 =A0 =A0 else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long ba =3D data-&gt;pgtable;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (itype !=3D SYSMMU_FAULT_UNKNOWN)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ba =3D __raw_readl(data-&gt;s=
frbases[i] + REG_PT_BASE_ADDR);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 show_fault_information(dev_name(data-&gt;sysm=
mu),<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 itype, ba, addr);<br>
+ =A0 =A0 =A0 }<br>
<br>
=A0 =A0 =A0 =A0 if (itype !=3D SYSMMU_FAULT_UNKNOWN)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_unblock(data-&gt;sfrbases[i]);<br>
<br>
=A0 =A0 =A0 =A0 spin_unlock(&amp;data-&gt;lock);<br>
+ =A0 =A0 =A0 if (client)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&amp;client-&gt;lock);<br>
<br>
=A0 =A0 =A0 =A0 return IRQ_HANDLED;<br>
=A0}<br>
<br>
-static bool __exynos_sysmmu_disable(struct sysmmu_drvdata *data)<br>
+static void __sysmmu_disable_nocount(struct sysmmu_drvdata *data)<br>
=A0{<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i;<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i &lt; data-&gt;nsfrs; i++) {<b=
r>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(CTRL_DISABLE,<br=
>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0da=
ta-&gt;sfrbases[i] + REG_MMU_CTRL);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0, data-&gt;sfrb=
ases[i] + REG_MMU_CFG);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(data-&gt;clk);<br>
+}<br>
+<br>
+static bool __sysmmu_disable(struct sysmmu_drvdata *data)<br>
+{<br>
+ =A0 =A0 =A0 bool disabled;<br>
=A0 =A0 =A0 =A0 unsigned long flags;<br>
- =A0 =A0 =A0 bool disabled =3D false;<br>
- =A0 =A0 =A0 int i;<br>
<br>
=A0 =A0 =A0 =A0 spin_lock_irqsave(&amp;data-&gt;lock, flags);<br>
<br>
- =A0 =A0 =A0 if (!set_sysmmu_inactive(data))<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto finish;<br>
+ =A0 =A0 =A0 disabled =3D set_sysmmu_inactive(data);<br>
<br>
- =A0 =A0 =A0 for (i =3D 0; i &lt; data-&gt;nsfrs; i++)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(CTRL_DISABLE, data-&gt;sfrbases[=
i] + REG_MMU_CTRL);<br>
+ =A0 =A0 =A0 if (disabled) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;pgtable =3D 0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;domain =3D NULL;<br>
<br>
- =A0 =A0 =A0 if (data-&gt;clk)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(data-&gt;clk);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data-&gt;runtime_active)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_disable_nocount(data=
);<br>
<br>
- =A0 =A0 =A0 disabled =3D true;<br>
- =A0 =A0 =A0 data-&gt;pgtable =3D 0;<br>
- =A0 =A0 =A0 data-&gt;domain =3D NULL;<br>
-finish:<br>
- =A0 =A0 =A0 spin_unlock_irqrestore(&amp;data-&gt;lock, flags);<br>
-<br>
- =A0 =A0 =A0 if (disabled)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(data-&gt;sysmmu, &quot;Disabled\n&q=
uot;);<br>
- =A0 =A0 =A0 else<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(data-&gt;sysmmu, &quot;%d times left =
to be disabled\n&quot;,<br>
+ =A0 =A0 =A0 } else =A0{<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(data-&gt;sysmmu, &quot;%d times left =
to disable\n&quot;,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 data-&gt;activations);<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 spin_unlock_irqrestore(&amp;data-&gt;lock, flags);<br>
<br>
=A0 =A0 =A0 =A0 return disabled;<br>
=A0}<br>
<br>
-/* __exynos_sysmmu_enable: Enables System MMU<br>
- *<br>
- * returns -error if an error occurred and System MMU is not enabled,<br>
- * 0 if the System MMU has been just enabled and 1 if System MMU was alrea=
dy<br>
- * enabled before.<br>
- */<br>
-static int __exynos_sysmmu_enable(struct sysmmu_drvdata *data,<br>
+<br>
+static void __sysmmu_init_config(struct sysmmu_drvdata *data, int idx)<br>
+{<br>
+ =A0 =A0 =A0 unsigned long cfg =3D CFG_LRU;<br>
+ =A0 =A0 =A0 int maj, min =3D 0;<br>
+<br>
+ =A0 =A0 =A0 maj =3D __sysmmu_version(data, idx, &amp;min);<br>
+ =A0 =A0 =A0 if (maj =3D=3D 3) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 cfg |=3D CFG_SHAREABLE;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (min &gt; 1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cfg |=3D CFG_FLPDCACHE;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cfg |=3D (min =3D=3D 2) ? CFG=
_SYSSEL : CFG_ACGEN;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 cfg |=3D __raw_readl(data-&gt;sfrbases[idx] + REG_MMU_CFG) &a=
mp; ~CFG_MASK;<br>
+ =A0 =A0 =A0 __raw_writel(cfg, data-&gt;sfrbases[idx] + REG_MMU_CFG);<br>
+}<br>
+<br>
+static void __sysmmu_enable_nocount(struct sysmmu_drvdata *data)<br>
+{<br>
+ =A0 =A0 =A0 int i;<br>
+<br>
+ =A0 =A0 =A0 clk_enable(data-&gt;clk);<br>
+<br>
+ =A0 =A0 =A0 for (i =3D 0; i &lt; data-&gt;nsfrs; i++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG_ON(__raw_readl(data-&gt;sfrbases[i] + REG=
_MMU_CTRL)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp; CTRL_ENABLE);<br>=
</blockquote><div><br></div><div>We are assuming that the REG_MMU_CTRL will=
 be 0 in the beginning.</div><div>In the newer versions of smmus (e.g. FIMD=
&#39;s sysmmu in Exynos5420), the reset value of REG_MMU_CTRL is 1.</div>
<div>So this BUG will be triggered when sysmmu gets enabled for the first t=
ime.<br></div><div><br></div><div>One way to fix this is to pass an additio=
nal parameter to this function &#39;init&#39;:</div><div>The BUG_ON should =
not be checked when sysmmu is enabled for first time i.e. from __sysmmu_ena=
ble (init =3D true)</div>
<div>And the BUG_ON can be checked when this function is called from else w=
here (init =3D false)</div><div><br></div><div>=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">

+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_init_config(data, i);<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_set_ptbase(data-&gt;sfrbases[i], dat=
a-&gt;pgtable);<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(CTRL_ENABLE, data-&gt;sfrbases[i=
] + REG_MMU_CTRL);<br>
+ =A0 =A0 =A0 }<br>
+}<br>
+<br>
+static int __sysmmu_enable(struct sysmmu_drvdata *data,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long pgtable, stru=
ct iommu_domain *domain)<br>
=A0{<br>
- =A0 =A0 =A0 int i, ret =3D 0;<br>
+ =A0 =A0 =A0 int ret =3D 0;<br>
=A0 =A0 =A0 =A0 unsigned long flags;<br>
<br>
=A0 =A0 =A0 =A0 spin_lock_irqsave(&amp;data-&gt;lock, flags);<br>
+ =A0 =A0 =A0 if (set_sysmmu_active(data)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;pgtable =3D pgtable;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;domain =3D domain;<br>
<br>
- =A0 =A0 =A0 if (!set_sysmmu_active(data)) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (WARN_ON(pgtable !=3D data-&gt;pgtable)) {=
<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_sysmmu_inactive(data);<br=
>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 1;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data-&gt;runtime_active)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_enable_nocount(data)=
;<br>
<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(data-&gt;sysmmu, &quot;Already enable=
d\n&quot;);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto finish;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(data-&gt;sysmmu, &quot;Enabled\n&quot=
;);<br>
+ =A0 =A0 =A0 } else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D (pgtable =3D=3D data-&gt;pgtable) ? 1=
 : -EBUSY;<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(data-&gt;sysmmu, &quot;already enable=
d\n&quot;);<br>
=A0 =A0 =A0 =A0 }<br>
<br>
- =A0 =A0 =A0 if (data-&gt;clk)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(data-&gt;clk);<br>
+ =A0 =A0 =A0 if (WARN_ON(ret &lt; 0))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_sysmmu_inactive(data); /* decrement count=
 */<br>
<br>
- =A0 =A0 =A0 data-&gt;pgtable =3D pgtable;<br>
+ =A0 =A0 =A0 spin_unlock_irqrestore(&amp;data-&gt;lock, flags);<br>
<br>
- =A0 =A0 =A0 for (i =3D 0; i &lt; data-&gt;nsfrs; i++) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_set_ptbase(data-&gt;sfrbases[i], pgt=
able);<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((readl(data-&gt;sfrbases[i] + REG_MMU_VER=
SION) &gt;&gt; 28) =3D=3D 3) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* System MMU version is 3.x =
*/<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel((1 &lt;&lt; 12) =
| (2 &lt;&lt; 28),<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 data-&gt;sfrbases[i] + REG_MMU_CFG);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_set_prefbuf(data-&gt=
;sfrbases[i], 0, -1, 0);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_set_prefbuf(data-&gt=
;sfrbases[i], 0, -1, 1);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+/* __exynos_sysmmu_enable: Enables System MMU<br>
+ *<br>
+ * returns -error if an error occurred and System MMU is not enabled,<br>
+ * 0 if the System MMU has been just enabled and 1 if System MMU was alrea=
dy<br>
+ * enabled before.<br>
+ */<br>
+static int __exynos_sysmmu_enable(struct device *dev, unsigned long pgtabl=
e,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct io=
mmu_domain *domain)<br>
+{<br>
+ =A0 =A0 =A0 int ret =3D 0;<br>
+ =A0 =A0 =A0 unsigned long flags;<br>
+ =A0 =A0 =A0 struct exynos_iommu_client *client =3D dev-&gt;archdata.iommu=
;<br>
+ =A0 =A0 =A0 int i;<br>
<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(CTRL_ENABLE, data-&gt;sfrbases[i=
] + REG_MMU_CTRL);<br>
- =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 if (WARN_ON(!client))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;<br>
<br>
- =A0 =A0 =A0 data-&gt;domain =3D domain;<br>
+ =A0 =A0 =A0 spin_lock_irqsave(&amp;client-&gt;lock, flags);<br>
<br>
- =A0 =A0 =A0 dev_dbg(data-&gt;sysmmu, &quot;Enabled\n&quot;);<br>
-finish:<br>
- =A0 =A0 =A0 spin_unlock_irqrestore(&amp;data-&gt;lock, flags);<br>
+ =A0 =A0 =A0 for (i =3D 0; i &lt; client-&gt;num_sysmmu; i++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sysmmu_drvdata *data =3D<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_get_drvda=
ta(client-&gt;sysmmu[i]);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __sysmmu_enable(data, pgtable, domain=
);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret &lt; 0) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int j;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j &lt; i; j++)<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_disa=
ble(data);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;master =3D dev;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 spin_unlock_irqrestore(&amp;client-&gt;lock, flags);<br>
<br>
=A0 =A0 =A0 =A0 return ret;<br>
=A0}<br>
<br>
=A0int exynos_sysmmu_enable(struct device *dev, unsigned long pgtable)<br>
=A0{<br>
- =A0 =A0 =A0 struct sysmmu_drvdata *data =3D dev_get_drvdata(dev-&gt;archd=
ata.iommu);<br>
=A0 =A0 =A0 =A0 int ret;<br>
<br>
=A0 =A0 =A0 =A0 BUG_ON(!memblock_is_memory(pgtable));<br>
<br>
- =A0 =A0 =A0 ret =3D pm_runtime_get_sync(data-&gt;sysmmu);<br>
- =A0 =A0 =A0 if (ret &lt; 0) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(data-&gt;sysmmu, &quot;Failed to enab=
le\n&quot;);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
- =A0 =A0 =A0 }<br>
-<br>
- =A0 =A0 =A0 ret =3D __exynos_sysmmu_enable(data, pgtable, NULL);<br>
- =A0 =A0 =A0 if (WARN_ON(ret &lt; 0)) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(data-&gt;sysmmu);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(data-&gt;sysmmu,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Already enabled with pa=
ge table %#lx\n&quot;,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;pgtable);<br>
- =A0 =A0 =A0 } else {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;dev =3D dev;<br>
- =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 ret =3D __exynos_sysmmu_enable(dev, pgtable, NULL);<br>
<br>
=A0 =A0 =A0 =A0 return ret;<br>
=A0}<br>
<br>
=A0static bool exynos_sysmmu_disable(struct device *dev)<br>
=A0{<br>
- =A0 =A0 =A0 struct sysmmu_drvdata *data =3D dev_get_drvdata(dev-&gt;archd=
ata.iommu);<br>
- =A0 =A0 =A0 bool disabled;<br>
+ =A0 =A0 =A0 unsigned long flags;<br>
+ =A0 =A0 =A0 bool disabled =3D true;<br>
+ =A0 =A0 =A0 struct exynos_iommu_client *client =3D dev-&gt;archdata.iommu=
;<br>
+ =A0 =A0 =A0 int i;<br>
+<br>
+ =A0 =A0 =A0 if (WARN_ON(!client))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return true;<br>
+<br>
+ =A0 =A0 =A0 spin_lock_irqsave(&amp;client-&gt;lock, flags);<br>
+<br>
+ =A0 =A0 =A0 /* Every call to __sysmmu_disable() must return same result *=
/<br>
+ =A0 =A0 =A0 for (i =3D 0; i &lt; client-&gt;num_sysmmu; i++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sysmmu_drvdata *data =3D<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_get_drvda=
ta(client-&gt;sysmmu[i]);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 disabled =3D __sysmmu_disable(data);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (disabled)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;master =3D NULL;<br>
+ =A0 =A0 =A0 }<br>
<br>
- =A0 =A0 =A0 disabled =3D __exynos_sysmmu_disable(data);<br>
- =A0 =A0 =A0 pm_runtime_put(data-&gt;sysmmu);<br>
+ =A0 =A0 =A0 spin_unlock_irqrestore(&amp;client-&gt;lock, flags);<br>
<br>
=A0 =A0 =A0 =A0 return disabled;<br>
=A0}<br>
<br>
=A0static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned lon=
g iova)<br>
=A0{<br>
- =A0 =A0 =A0 unsigned long flags;<br>
- =A0 =A0 =A0 struct sysmmu_drvdata *data =3D dev_get_drvdata(dev-&gt;archd=
ata.iommu);<br>
+ =A0 =A0 =A0 struct exynos_iommu_client *client =3D dev-&gt;archdata.iommu=
;<br>
+ =A0 =A0 =A0 int i;<br>
<br>
- =A0 =A0 =A0 spin_lock_irqsave(&amp;data-&gt;lock, flags);<br>
+ =A0 =A0 =A0 for (i =3D 0; i &lt; client-&gt;num_sysmmu; i++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long flags;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sysmmu_drvdata *data;<br>
<br>
- =A0 =A0 =A0 if (is_sysmmu_active(data)) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i &lt; data-&gt;nsfrs; i++) {<b=
r>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sysmmu_block(data-&gt;sfr=
bases[i])) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D dev_get_drvdata(client-&gt;sysmmu[i]=
);<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&amp;data-&gt;lock, flags);=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_sysmmu_active(data) &amp;&amp; data-&g=
t;runtime_active) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i &lt; data-&gt=
;nsfrs; i++)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_tl=
b_invalidate_entry(<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 data-&gt;sfrbases[i], iova);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_unbloc=
k(data-&gt;sfrbases[i]);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;disable=
d. Skipping TLB invalidation @ %#lx\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iova);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
- =A0 =A0 =A0 } else {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(data-&gt;sysmmu, &quot;Disabled. Skip=
ping invalidating TLB.\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&amp;data-&gt;lock, fl=
ags);<br>
=A0 =A0 =A0 =A0 }<br>
-<br>
- =A0 =A0 =A0 spin_unlock_irqrestore(&amp;data-&gt;lock, flags);<br>
=A0}<br>
<br>
=A0void exynos_sysmmu_tlb_invalidate(struct device *dev)<br>
=A0{<br>
- =A0 =A0 =A0 unsigned long flags;<br>
- =A0 =A0 =A0 struct sysmmu_drvdata *data =3D dev_get_drvdata(dev-&gt;archd=
ata.iommu);<br>
-<br>
- =A0 =A0 =A0 spin_lock_irqsave(&amp;data-&gt;lock, flags);<br>
+ =A0 =A0 =A0 struct exynos_iommu_client *client =3D dev-&gt;archdata.iommu=
;<br>
+ =A0 =A0 =A0 int i;<br>
<br>
- =A0 =A0 =A0 if (is_sysmmu_active(data)) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i &lt; data-&gt;nsfrs; i++) {<b=
r>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sysmmu_block(data-&gt;sfr=
bases[i])) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_tlb_=
invalidate(data-&gt;sfrbases[i]);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_unbloc=
k(data-&gt;sfrbases[i]);<br>
+ =A0 =A0 =A0 for (i =3D 0; i &lt; client-&gt;num_sysmmu; i++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long flags;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sysmmu_drvdata *data;<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D dev_get_drvdata(client-&gt;sysmmu[i]=
);<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&amp;data-&gt;lock, flags);=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_sysmmu_active(data) &amp;&amp;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;runt=
ime_active) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i &lt; data-&gt=
;nsfrs; i++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sysmmu_bl=
ock(data-&gt;sfrbases[i])) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 __sysmmu_tlb_invalidate(<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;sfrbases[i]);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 sysmmu_unblock(data-&gt;sfrbases[i]);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, &quot;disabled. =
Skipping TLB invalidation\n&quot;);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
- =A0 =A0 =A0 } else {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(data-&gt;sysmmu, &quot;Disabled. Skip=
ping invalidating TLB.\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&amp;data-&gt;lock, fl=
ags);<br>
=A0 =A0 =A0 =A0 }<br>
-<br>
- =A0 =A0 =A0 spin_unlock_irqrestore(&amp;data-&gt;lock, flags);<br>
=A0}<br>
<br>
=A0static int __init exynos_sysmmu_probe(struct platform_device *pdev)<br>
@@ -622,8 +705,6 @@ static int __init exynos_sysmmu_probe(struct platform_d=
evice *pdev)<br>
<br>
=A0 =A0 =A0 =A0 pm_runtime_enable(dev);<br>
<br>
- =A0 =A0 =A0 __set_fault_handler(data, &amp;default_fault_handler);<br>
-<br>
=A0 =A0 =A0 =A0 data-&gt;sysmmu =3D dev;<br>
=A0 =A0 =A0 =A0 data-&gt;clk =3D devm_clk_get(dev, &quot;sysmmu&quot;);<br>
=A0 =A0 =A0 =A0 if (IS_ERR(data-&gt;clk)) {<br>
@@ -647,6 +728,8 @@ static int __init exynos_sysmmu_probe(struct platform_d=
evice *pdev)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
=A0 =A0 =A0 =A0 }<br>
<br>
+ =A0 =A0 =A0 data-&gt;runtime_active =3D !pm_runtime_enabled(dev);<br></bl=
ockquote><div><br></div><div>We are enabling pm_runtime in the probe itself=
. Is this check still required?</div><div>We can directly set data-&gt;runt=
ime_active to false since sysmmus get probed first.</div>
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">
+<br>
=A0 =A0 =A0 =A0 spin_lock_init(&amp;data-&gt;lock);<br>
=A0 =A0 =A0 =A0 INIT_LIST_HEAD(&amp;data-&gt;node);<br>
<br>
@@ -656,6 +739,34 @@ static int __init exynos_sysmmu_probe(struct platform_=
device *pdev)<br>
=A0 =A0 =A0 =A0 return ret;<br>
=A0}<br>
<br>
+#ifdef CONFIG_PM_SLEEP<br>
+static int sysmmu_suspend(struct device *dev)<br>
+{<br>
+ =A0 =A0 =A0 struct sysmmu_drvdata *data =3D dev_get_drvdata(dev);<br>
+ =A0 =A0 =A0 unsigned long flags;<br>
+ =A0 =A0 =A0 spin_lock_irqsave(&amp;data-&gt;lock, flags);<br>
+ =A0 =A0 =A0 if (is_sysmmu_active(data) &amp;&amp;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 (!pm_runtime_enabled(dev) || data-&gt;runtime=
_active))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_disable_nocount(data);<br>
+ =A0 =A0 =A0 spin_unlock_irqrestore(&amp;data-&gt;lock, flags);<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static int sysmmu_resume(struct device *dev)<br>
+{<br>
+ =A0 =A0 =A0 struct sysmmu_drvdata *data =3D dev_get_drvdata(dev);<br>
+ =A0 =A0 =A0 unsigned long flags;<br>
+ =A0 =A0 =A0 spin_lock_irqsave(&amp;data-&gt;lock, flags);<br>
+ =A0 =A0 =A0 if (is_sysmmu_active(data) &amp;&amp;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 (!pm_runtime_enabled(dev) || data-&gt;runtime=
_active))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_enable_nocount(data);<br>
+ =A0 =A0 =A0 spin_unlock_irqrestore(&amp;data-&gt;lock, flags);<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+#endif<br>
+<br>
+static SIMPLE_DEV_PM_OPS(sysmmu_pm_ops, sysmmu_suspend, sysmmu_resume);<br=
>
+<br>
=A0#ifdef CONFIG_OF<br>
=A0static struct of_device_id sysmmu_of_match[] __initconst =3D {<br>
=A0 =A0 =A0 =A0 { .compatible =A0 =3D &quot;samsung,exynos4210-sysmmu&quot;=
, },<br>
@@ -668,6 +779,7 @@ static struct platform_driver exynos_sysmmu_driver __re=
fdata =3D {<br>
=A0 =A0 =A0 =A0 .driver =3D {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,<=
br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot;exynos-=
sysmmu&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =A0 =A0 =A0 =A0 =3D &amp;sysmmu_p=
m_ops,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D of_match_ptr(sysmmu_of_=
match),<br>
=A0 =A0 =A0 =A0 }<br>
=A0};<br>
@@ -720,7 +832,7 @@ err_pgtable:<br>
=A0static void exynos_iommu_domain_destroy(struct iommu_domain *domain)<br>
=A0{<br>
=A0 =A0 =A0 =A0 struct exynos_iommu_domain *priv =3D domain-&gt;priv;<br>
- =A0 =A0 =A0 struct sysmmu_drvdata *data;<br>
+ =A0 =A0 =A0 struct exynos_iommu_client *client;<br>
=A0 =A0 =A0 =A0 unsigned long flags;<br>
=A0 =A0 =A0 =A0 int i;<br>
<br>
@@ -728,11 +840,14 @@ static void exynos_iommu_domain_destroy(struct iommu_=
domain *domain)<br>
<br>
=A0 =A0 =A0 =A0 spin_lock_irqsave(&amp;priv-&gt;lock, flags);<br>
<br>
- =A0 =A0 =A0 list_for_each_entry(data, &amp;priv-&gt;clients, node) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!exynos_sysmmu_disable(data-&gt;dev))<=
br>
+ =A0 =A0 =A0 list_for_each_entry(client, &amp;priv-&gt;clients, node) {<br=
>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!exynos_sysmmu_disable(client-&gt;dev)=
)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ; /* until System MMU is ac=
tually disabled */<br>
=A0 =A0 =A0 =A0 }<br>
<br>
+ =A0 =A0 =A0 while (!list_empty(&amp;priv-&gt;clients))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del_init(priv-&gt;clients.next);<br>
+<br>
=A0 =A0 =A0 =A0 spin_unlock_irqrestore(&amp;priv-&gt;lock, flags);<br>
<br>
=A0 =A0 =A0 =A0 for (i =3D 0; i &lt; NUM_LV1ENTRIES; i++)<br>
@@ -749,41 +864,26 @@ static void exynos_iommu_domain_destroy(struct iommu_=
domain *domain)<br>
=A0static int exynos_iommu_attach_device(struct iommu_domain *domain,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stru=
ct device *dev)<br>
=A0{<br>
- =A0 =A0 =A0 struct sysmmu_drvdata *data =3D dev_get_drvdata(dev-&gt;archd=
ata.iommu);<br>
+ =A0 =A0 =A0 struct exynos_iommu_client *client =3D dev-&gt;archdata.iommu=
;<br>
=A0 =A0 =A0 =A0 struct exynos_iommu_domain *priv =3D domain-&gt;priv;<br>
=A0 =A0 =A0 =A0 unsigned long flags;<br>
=A0 =A0 =A0 =A0 int ret;<br>
<br>
- =A0 =A0 =A0 ret =3D pm_runtime_get_sync(data-&gt;sysmmu);<br>
- =A0 =A0 =A0 if (ret &lt; 0)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
-<br>
- =A0 =A0 =A0 ret =3D 0;<br>
-<br>
=A0 =A0 =A0 =A0 spin_lock_irqsave(&amp;priv-&gt;lock, flags);<br>
<br>
- =A0 =A0 =A0 ret =3D __exynos_sysmmu_enable(data, __pa(priv-&gt;pgtable), =
domain);<br>
-<br>
- =A0 =A0 =A0 if (ret =3D=3D 0) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* &#39;data-&gt;node&#39; must not be appear=
ed in priv-&gt;clients */<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG_ON(!list_empty(&amp;data-&gt;node));<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;dev =3D dev;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&amp;data-&gt;node, &amp;priv-&=
gt;clients);<br>
- =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 ret =3D __exynos_sysmmu_enable(dev, __pa(priv-&gt;pgtable), d=
omain);<br>
+ =A0 =A0 =A0 if (ret =3D=3D 0)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&amp;client-&gt;node, &amp;priv=
-&gt;clients);<br>
<br>
=A0 =A0 =A0 =A0 spin_unlock_irqrestore(&amp;priv-&gt;lock, flags);<br>
<br>
- =A0 =A0 =A0 if (ret &lt; 0) {<br>
+ =A0 =A0 =A0 if (ret &lt; 0)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, &quot;%s: Failed to attach IOM=
MU with pgtable %#lx\n&quot;,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, _=
_pa(priv-&gt;pgtable));<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(data-&gt;sysmmu);<br>
- =A0 =A0 =A0 } else if (ret &gt; 0) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, &quot;%s: IOMMU with pgtable 0x%=
lx already attached\n&quot;,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 __func__, __pa(priv-&gt;pgtable));<br>
- =A0 =A0 =A0 } else {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, &quot;%s: Attached new IOMMU wit=
h pgtable 0x%lx\n&quot;,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 __func__, __pa(priv-&gt;pgtable));<br>
- =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 else<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, &quot;%s: Attached IOMMU with pg=
table 0x%lx%s\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 __func__, __pa(priv-&gt;pgtable),<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (ret =3D=3D 0) ? &quot;&quot; : &quot;, again&quot;);<br>
<br>
=A0 =A0 =A0 =A0 return ret;<br>
=A0}<br>
@@ -791,39 +891,27 @@ static int exynos_iommu_attach_device(struct iommu_do=
main *domain,<br>
=A0static void exynos_iommu_detach_device(struct iommu_domain *domain,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 str=
uct device *dev)<br>
=A0{<br>
- =A0 =A0 =A0 struct sysmmu_drvdata *data =3D dev_get_drvdata(dev-&gt;archd=
ata.iommu);<br>
+ =A0 =A0 =A0 struct exynos_iommu_client *client =3D NULL;<br>
=A0 =A0 =A0 =A0 struct exynos_iommu_domain *priv =3D domain-&gt;priv;<br>
- =A0 =A0 =A0 struct list_head *pos;<br>
=A0 =A0 =A0 =A0 unsigned long flags;<br>
- =A0 =A0 =A0 bool found =3D false;<br>
<br>
=A0 =A0 =A0 =A0 spin_lock_irqsave(&amp;priv-&gt;lock, flags);<br>
<br>
- =A0 =A0 =A0 list_for_each(pos, &amp;priv-&gt;clients) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (list_entry(pos, struct sysmmu_drvdata, no=
de) =3D=3D data) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 found =3D true;<br>
+ =A0 =A0 =A0 list_for_each_entry(client, &amp;priv-&gt;clients, node) {<br=
>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (client =3D=3D dev-&gt;archdata.iommu) {<b=
r>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (exynos_sysmmu_disable(dev=
))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del_init=
(&amp;client-&gt;node);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
=A0 =A0 =A0 =A0 }<br>
<br>
- =A0 =A0 =A0 if (!found)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto finish;<br>
+ =A0 =A0 =A0 spin_unlock_irqrestore(&amp;priv-&gt;lock, flags);<br>
<br>
- =A0 =A0 =A0 if (__exynos_sysmmu_disable(data)) {<br>
+ =A0 =A0 =A0 if (client =3D=3D dev-&gt;archdata.iommu)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, &quot;%s: Detached IOMMU with =
pgtable %#lx\n&quot;,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 __func__, __pa(priv-&gt;pgtable));<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del_init(&amp;data-&gt;node);<br>
-<br>
- =A0 =A0 =A0 } else {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, &quot;%s: Detaching IOMMU with p=
gtable %#lx delayed&quot;,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 __func__, __pa(priv-&gt;pgtable));<br>
- =A0 =A0 =A0 }<br>
-<br>
-finish:<br>
- =A0 =A0 =A0 spin_unlock_irqrestore(&amp;priv-&gt;lock, flags);<br>
-<br>
- =A0 =A0 =A0 if (found)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(data-&gt;sysmmu);<br>
+ =A0 =A0 =A0 else<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, &quot;%s: No IOMMU is attached\n=
&quot;, __func__);<br>
=A0}<br>
<br>
=A0static unsigned long *alloc_lv2entry(unsigned long *sent, unsigned long =
iova,<br>
@@ -940,7 +1028,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *=
domain,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0unsigned long iova, size_t size)<br>
=A0{<br>
=A0 =A0 =A0 =A0 struct exynos_iommu_domain *priv =3D domain-&gt;priv;<br>
- =A0 =A0 =A0 struct sysmmu_drvdata *data;<br>
+ =A0 =A0 =A0 struct exynos_iommu_client *client;<br>
=A0 =A0 =A0 =A0 unsigned long flags;<br>
=A0 =A0 =A0 =A0 unsigned long *ent;<br>
=A0 =A0 =A0 =A0 size_t err_page;<br>
@@ -997,8 +1085,8 @@ done:<br>
=A0 =A0 =A0 =A0 spin_unlock_irqrestore(&amp;priv-&gt;pgtablelock, flags);<b=
r>
<br>
=A0 =A0 =A0 =A0 spin_lock_irqsave(&amp;priv-&gt;lock, flags);<br>
- =A0 =A0 =A0 list_for_each_entry(data, &amp;priv-&gt;clients, node)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_tlb_invalidate_entry(data-&gt;dev, iov=
a);<br>
+ =A0 =A0 =A0 list_for_each_entry(client, &amp;priv-&gt;clients, node)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_tlb_invalidate_entry(client-&gt;dev, i=
ova);<br>
=A0 =A0 =A0 =A0 spin_unlock_irqrestore(&amp;priv-&gt;lock, flags);<br>
<br>
=A0 =A0 =A0 =A0 return size;<br>
@@ -1082,3 +1170,275 @@ static int __init exynos_iommu_init(void)<br>
=A0 =A0 =A0 =A0 return ret;<br>
=A0}<br>
=A0subsys_initcall(exynos_iommu_init);<br>
+<br>
+#ifdef CONFIG_PM_SLEEP<br>
+static int sysmmu_pm_genpd_suspend(struct device *dev)<br>
+{<br>
+ =A0 =A0 =A0 struct exynos_iommu_client *client =3D dev-&gt;archdata.iommu=
;<br>
+ =A0 =A0 =A0 int ret =3D 0;<br>
+ =A0 =A0 =A0 int i;<br>
+<br>
+ =A0 =A0 =A0 for (i =3D 0; i &lt; client-&gt;num_sysmmu; i++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pm_generic_suspend(client-&gt;sysmmu[=
i]);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 if (!ret)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pm_generic_suspend(dev);<br>
+<br>
+ =A0 =A0 =A0 if (ret) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 int j;<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j &lt; i; j++)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_generic_resume(client-&gt;=
sysmmu[j]);<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+<br>
+static int sysmmu_pm_genpd_resume(struct device *dev)<br>
+{<br>
+ =A0 =A0 =A0 struct exynos_iommu_client *client =3D dev-&gt;archdata.iommu=
;<br>
+ =A0 =A0 =A0 int ret =3D 0;<br>
+ =A0 =A0 =A0 int i;<br>
+<br>
+ =A0 =A0 =A0 for (i =3D 0; i &lt; client-&gt;num_sysmmu; i++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pm_generic_resume(client-&gt;sysmmu[i=
]);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 if (!ret)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pm_generic_resume(dev);<br>
+<br>
+ =A0 =A0 =A0 if (ret) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 int j;<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j &lt; i; j++)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_generic_suspend(client-&gt=
;sysmmu[j]);<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+#endif<br>
+<br>
+#ifdef CONFIG_PM_RUNTIME<br>
+static void sysmmu_restore_state(struct device *sysmmu)<br>
+{<br>
+ =A0 =A0 =A0 struct sysmmu_drvdata *data =3D dev_get_drvdata(sysmmu);<br>
+ =A0 =A0 =A0 unsigned long flags;<br>
+<br>
+ =A0 =A0 =A0 spin_lock_irqsave(&amp;data-&gt;lock, flags);<br>
+ =A0 =A0 =A0 data-&gt;runtime_active =3D true;<br>
+ =A0 =A0 =A0 if (is_sysmmu_active(data))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_enable_nocount(data);<br>
+ =A0 =A0 =A0 spin_unlock_irqrestore(&amp;data-&gt;lock, flags);<br>
+}<br>
+<br>
+static void sysmmu_save_state(struct device *sysmmu)<br>
+{<br>
+ =A0 =A0 =A0 struct sysmmu_drvdata *data =3D dev_get_drvdata(sysmmu);<br>
+ =A0 =A0 =A0 unsigned long flags;<br>
+<br>
+ =A0 =A0 =A0 spin_lock_irqsave(&amp;data-&gt;lock, flags);<br>
+ =A0 =A0 =A0 if (is_sysmmu_active(data))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_disable_nocount(data);<br>
+ =A0 =A0 =A0 data-&gt;runtime_active =3D false;<br>
+ =A0 =A0 =A0 spin_unlock_irqrestore(&amp;data-&gt;lock, flags);<br>
+}<br>
+<br>
+static int sysmmu_pm_genpd_save_state(struct device *dev)<br>
+{<br>
+ =A0 =A0 =A0 struct exynos_iommu_client *client =3D dev-&gt;archdata.iommu=
;<br>
+ =A0 =A0 =A0 int (*cb)(struct device *__dev);<br>
+ =A0 =A0 =A0 int i;<br>
+<br>
+ =A0 =A0 =A0 if (dev-&gt;type &amp;&amp; dev-&gt;type-&gt;pm)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 cb =3D dev-&gt;type-&gt;pm-&gt;runtime_suspen=
d;<br>
+ =A0 =A0 =A0 else if (dev-&gt;class &amp;&amp; dev-&gt;class-&gt;pm)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 cb =3D dev-&gt;class-&gt;pm-&gt;runtime_suspe=
nd;<br>
+ =A0 =A0 =A0 else if (dev-&gt;bus &amp;&amp; dev-&gt;bus-&gt;pm)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 cb =3D dev-&gt;bus-&gt;pm-&gt;runtime_suspend=
;<br>
+ =A0 =A0 =A0 else<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 cb =3D NULL;<br>
+<br>
+ =A0 =A0 =A0 if (!cb &amp;&amp; dev-&gt;driver &amp;&amp; dev-&gt;driver-&=
gt;pm)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 cb =3D dev-&gt;driver-&gt;pm-&gt;runtime_susp=
end;<br>
+<br>
+ =A0 =A0 =A0 if (cb) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret;<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D cb(dev);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 for (i =3D 0; i &lt; client-&gt;num_sysmmu; i++)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_save_state(client-&gt;sysmmu[i]);<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static int sysmmu_pm_genpd_restore_state(struct device *dev)<br>
+{<br>
+ =A0 =A0 =A0 struct exynos_iommu_client *client =3D dev-&gt;archdata.iommu=
;<br>
+ =A0 =A0 =A0 int (*cb)(struct device *__dev);<br>
+ =A0 =A0 =A0 int i;<br>
+<br>
+ =A0 =A0 =A0 if (dev-&gt;type &amp;&amp; dev-&gt;type-&gt;pm)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 cb =3D dev-&gt;type-&gt;pm-&gt;runtime_resume=
;<br>
+ =A0 =A0 =A0 else if (dev-&gt;class &amp;&amp; dev-&gt;class-&gt;pm)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 cb =3D dev-&gt;class-&gt;pm-&gt;runtime_resum=
e;<br>
+ =A0 =A0 =A0 else if (dev-&gt;bus &amp;&amp; dev-&gt;bus-&gt;pm)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 cb =3D dev-&gt;bus-&gt;pm-&gt;runtime_resume;=
<br>
+ =A0 =A0 =A0 else<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 cb =3D NULL;<br>
+<br>
+ =A0 =A0 =A0 if (!cb &amp;&amp; dev-&gt;driver &amp;&amp; dev-&gt;driver-&=
gt;pm)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 cb =3D dev-&gt;driver-&gt;pm-&gt;runtime_resu=
me;<br>
+<br>
+ =A0 =A0 =A0 for (i =3D 0; i &lt; client-&gt;num_sysmmu; i++)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_restore_state(client-&gt;sysmmu[i]);<b=
r>
+<br>
+ =A0 =A0 =A0 if (cb) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D cb(dev);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i &lt; client-&=
gt;num_sysmmu; i++)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_save_s=
tate(client-&gt;sysmmu[i]);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+#endif<br>
+<br>
+#ifdef CONFIG_PM_GENERIC_DOMAINS<br>
+struct gpd_dev_ops sysmmu_devpm_ops =3D {<br>
+#ifdef CONFIG_PM_RUNTIME<br>
+ =A0 =A0 =A0 .save_state =3D &amp;sysmmu_pm_genpd_save_state,<br>
+ =A0 =A0 =A0 .restore_state =3D &amp;sysmmu_pm_genpd_restore_state,<br>
+#endif<br>
+#ifdef CONFIG_PM_SLEEP<br>
+ =A0 =A0 =A0 .suspend =3D &amp;sysmmu_pm_genpd_suspend,<br>
+ =A0 =A0 =A0 .resume =3D &amp;sysmmu_pm_genpd_resume,<br>
+#endif<br>
+};<br>
+#endif /* CONFIG_PM_GENERIC_DOMAINS */<br>
+<br>
+static int sysmmu_hook_driver_register(struct notifier_block *nb,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 unsigned long val,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 void *p)<br>
+{<br>
+ =A0 =A0 =A0 struct device *dev =3D p;<br>
+<br>
+ =A0 =A0 =A0 switch (val) {<br>
+ =A0 =A0 =A0 case BUS_NOTIFY_BIND_DRIVER:<br>
+ =A0 =A0 =A0 {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i =3D 0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 int size =3D 0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 const __be32 *phandle;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct exynos_iommu_client *client;<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 phandle =3D of_get_property(dev-&gt;of_node, =
&quot;iommu&quot;, &amp;size);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!phandle)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 size =3D size / sizeof(*phandle); /* number o=
f elements */<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 client =3D devm_kzalloc(dev, sizeof(*client) =
* size, GFP_KERNEL);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!client) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, &quot;No Memory =
for exynos_iommu_client\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 client-&gt;num_sysmmu =3D size;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 client-&gt;dev =3D dev;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 INIT_LIST_HEAD(&amp;client-&gt;node);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_init(&amp;client-&gt;lock);<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i &lt; size; i++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_node *np;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct platform_device *sysmm=
u;<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* this always success: see a=
bove of_find_property() */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 np =3D of_parse_phandle(dev-&=
gt;of_node, &quot;iommu&quot;, i);<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu =3D of_find_device_by_=
node(np);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!sysmmu) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev,<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 &quot;sysmmu node &#39;%s&#39; is not found\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 np-&gt;name);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 client-&gt;sysmmu[i] =3D &amp=
;sysmmu-&gt;dev;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i &lt; size) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (--i &gt;=3D 0)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(c=
lient-&gt;sysmmu[i]-&gt;of_node);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devm_kfree(dev, client);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 i =3D pm_genpd_add_callbacks(dev, &amp;sysmmu=
_devpm_ops, NULL);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i &amp;&amp; (i !=3D -ENOSYS)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Failed =
to register &#39;dev_pm_ops&#39; for iommu\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devm_kfree(dev, client);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return i;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev-&gt;archdata.iommu =3D client;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 case BUS_NOTIFY_BOUND_DRIVER:<br>
+ =A0 =A0 =A0 {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct exynos_iommu_client *client =3D dev-&g=
t;archdata.iommu;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dev-&gt;archdata.iommu &amp;&amp;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (!pm_runtime_=
enabled(dev) ||<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0IS_ERR(dev_to_genpd(dev)))) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i &lt; client-&=
gt;num_sysmmu; i++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sysmmu=
_drvdata *data;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_di=
sable(client-&gt;sysmmu[i]);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D dev_=
get_drvdata(client-&gt;sysmmu[i]);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!data)<br=
>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 continue;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;runt=
ime_active =3D<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 !pm_runtime_enabled(data-&gt;sysmmu);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data-&gt;=
runtime_active &amp;&amp;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 is_sysmmu_active(data))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 __sysmmu_enable_nocount(data);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 case BUS_NOTIFY_UNBOUND_DRIVER:<br>
+ =A0 =A0 =A0 {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dev-&gt;archdata.iommu) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __pm_genpd_remove_callbacks(d=
ev, false);<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devm_kfree(dev, dev-&gt;archd=
ata.iommu);<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev-&gt;archdata.iommu =3D NU=
LL;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 } /* switch (val) */<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static struct notifier_block sysmmu_notifier =3D {<br>
+ =A0 =A0 =A0 .notifier_call =3D &amp;sysmmu_hook_driver_register,<br>
+};<br>
+<br>
+static int __init exynos_iommu_prepare(void)<br>
+{<br>
+ =A0 =A0 =A0 return bus_register_notifier(&amp;platform_bus_type, &amp;sys=
mmu_notifier);<br>
+}<br>
+arch_initcall(exynos_iommu_prepare);<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.7.2.5<br>
<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-samsun=
g-soc&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">major=
domo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
</font></span></blockquote></div><br></div></div>

--047d7bd9158ec1930f04e12993b2--

--===============0200447045818100348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0200447045818100348==--
