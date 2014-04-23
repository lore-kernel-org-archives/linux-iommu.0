From: Cho KyongHo <pullip.cho@samsung.com>
Subject: Re: [PATCH v11 20/27] iommu/exynos: allow having multiple System MMUs
 for a master H/W
Date: Wed, 23 Apr 2014 10:15:24 +0900
Message-ID: <20140423101524.4145e9f88300293e0cea92c4@samsung.com>
References: <20140314141050.c8bedcb66532d277c496796d@samsung.com>
 <CAOD6ATobD8HCJWXeRgoXYaBBuKxy_TPj_AuWOfdPhJRF=Gxz5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAOD6ATobD8HCJWXeRgoXYaBBuKxy_TPj_AuWOfdPhJRF=Gxz5w@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Shaik Ameer Basha <shaik.samsung@gmail.com>
Cc: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>, Linux DeviceTree <devicetree@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>, Antonios Motakis <a.motakis@virtualopensystems.com>, Grant Grundler <grundler@chromium.org>, Joerg Roedel <joro@8bytes.org>, Kukjin Kim <kgene.kim@samsung.com>, Prathyush <prathyush.k@samsung.com>, Rahul Sharma <rahul.sharma@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Varun Sethi <Varun.Sethi@freescale.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, 22 Apr 2014 18:53:51 +0530, Shaik Ameer Basha wrote:
> Hi KyongHo Cho,
> 
> 
> 
> On Fri, Mar 14, 2014 at 10:40 AM, Cho KyongHo <pullip.cho@samsung.com> wrote:
> > Some master device descriptor like fimc-is which is an abstraction
> > of very complex H/W may have multiple System MMUs. For those devices,
> > the design of the link between System MMU and its master H/W is needed
> > to be reconsidered.
> >
> > A link structure, sysmmu_list_data is introduced that provides a link
> > to master H/W and that has a pointer to the device descriptor of a
> > System MMU. Given a device descriptor of a master H/W, it is possible
> > to traverse all System MMUs that must be controlled along with the
> > master H/W.
> >
> > Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> > ---
> >  drivers/iommu/exynos-iommu.c |  534 ++++++++++++++++++++++++++----------------
> >  1 file changed, 333 insertions(+), 201 deletions(-)
> >
> > diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> > index 84ba29a..7489343 100644
> > --- a/drivers/iommu/exynos-iommu.c
> > +++ b/drivers/iommu/exynos-iommu.c
> > @@ -128,6 +128,10 @@
> >  #define __master_clk_disable(data)     __clk_gate_ctrl(data, clk_master, dis)
> >
> 
> [snip]
> 
> > +static int __init __sysmmu_init_master(struct device *dev)
> > +{
> > +       int ret;
> > +       int i = 0;
> > +       struct device_node *node;
> > +
> > +       while ((node = of_parse_phandle(dev->of_node, "mmu-masters", i++))) {
> >                 struct platform_device *master = of_find_device_by_node(node);
> > +               struct exynos_iommu_owner *owner;
> > +               struct sysmmu_list_data *list_data;
> >
> >                 if (!master) {
> >                         dev_err(dev, "%s: mmu-master '%s' not found\n",
> >                                 __func__, node->name);
> > -                       return -EINVAL;
> > +                       ret = -EINVAL;
> > +                       goto err;
> >                 }
> >
> > -               if (master->dev.archdata.iommu != NULL) {
> > -                       dev_err(dev, "%s: '%s' is master of other MMU\n",
> > -                               __func__, node->name);
> > -                       return -EINVAL;
> > +               owner = master->dev.archdata.iommu;
> > +               if (!owner) {
> > +                       owner = devm_kzalloc(dev, sizeof(*owner), GFP_KERNEL);
> > +                       if (!owner) {
> > +                               dev_err(dev,
> > +                               "%s: Failed to allocate owner structure\n",
> > +                               __func__);
> > +                               ret = -ENOMEM;
> > +                               goto err;
> > +                       }
> > +
> > +                       INIT_LIST_HEAD(&owner->mmu_list);
> > +                       INIT_LIST_HEAD(&owner->client);
> > +                       owner->dev = &master->dev;
> > +                       spin_lock_init(&owner->lock);
> > +
> > +                       master->dev.archdata.iommu = owner;
> >                 }
> >
> > +               list_data = devm_kzalloc(dev, sizeof(*list_data), GFP_KERNEL);
> > +               if (!list_data) {
> > +                       dev_err(dev,
> > +                               "%s: Failed to allocate sysmmu_list_data\n",
> > +                               __func__);
> > +                       ret = -ENOMEM;
> > +                       goto err;
> > +               }
> > +
> > +               INIT_LIST_HEAD(&list_data->entry);
> > +               list_data->sysmmu = dev;
> > +
> >                 /*
> > -                * archdata.iommu will be initialized with exynos_iommu_client
> > -                * in sysmmu_hook_driver_register().
> > +                * System MMUs are attached in the order of the presence
> > +                * in device tree
> >                  */
> > -               master->dev.archdata.iommu = dev;
> > +               list_add_tail(&list_data->entry, &owner->mmu_list);
> >         }
> >
> > -       data->sysmmu = dev;
> > -       rwlock_init(&data->lock);
> > +       return 0;
> > +err:
> > +       while ((node = of_parse_phandle(dev->of_node, "mmu-masters", i++))) {
> 
> Don't we need to reinitialize variable 'i' here before using?
> i = 0;
> 

Oh. You are right.

Thanks.

> 
> 
> 
> > +               struct platform_device *master = of_find_device_by_node(node);
> > +               struct exynos_iommu_owner *owner;
> > +               struct sysmmu_list_data *list_data;
> >
> > -       platform_set_drvdata(pdev, data);
> > +               if (!master)
> > +                       continue;
> >
> > -       pm_runtime_enable(dev);
> > -       data->runtime_active = !pm_runtime_enabled(dev);
> > +               owner = master->dev.archdata.iommu;
> > +               if (!owner)
> > +                       continue;
> >
> > -       dev_dbg(dev, "Probed and initialized\n");
> > -       return 0;
> > +               for_each_sysmmu_list(owner->dev, list_data) {
> > +                       if (list_data->sysmmu == dev) {
> > +                               list_del(&list_data->entry);
> > +                               kfree(list_data);
> > +                               break;
> > +                       }
> > +               }
> > +       }
> > +
> > +       return ret;
> >  }
> >
> 
> [snip]
