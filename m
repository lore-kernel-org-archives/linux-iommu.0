From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu/mediatek: Add mt8173 IOMMU driver
Date: Wed, 18 Mar 2015 19:22:29 +0800
Message-ID: <1426677749.22581.38.camel@mhfsdcap03>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
	<1425638900-24989-3-git-send-email-yong.wu@mediatek.com>
	<CAAFQd5ASywTX7P9L8cogBbBTra0W1=oVxeWfK5=K7L+SR2xaFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAFQd5ASywTX7P9L8cogBbBTra0W1=oVxeWfK5=K7L+SR2xaFA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Tomasz,
   Thanks very much for your review. please help check below.
The others I will fix in the next version.

Hi Robin,
   There are some place I would like you can have a look and give me
some suggestion.

On Wed, 2015-03-11 at 19:53 +0900, Tomasz Figa wrote:
> Hi,
> 
> Please find next part of my comments inline.
> 
> On Fri, Mar 6, 2015 at 7:48 PM,  <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> 
> [snip]
> 
> > +/*
> > + * pimudev is a global var for dma_alloc_coherent.
> > + * It is not accepatable, we will delete it if "domain_alloc" is enabled
> 
> It looks like we indeed need to use dma_alloc_coherent() and we don't
> have a good way to pass the device pointer to domain_init callback.
> 
> If you don't expect SoCs in the nearest future to have multiple M4U
> blocks, then I guess this global variable could stay, after changing
> the comment into an explanation why it's correct. Also it should be
> moved to the top of the file, below #include directives, as this is
> where usually global variables are located.
@Robin,
     We have merged this patch[0] in order to delete the global var, But
it seems that your patch of "arm64:IOMMU" isn't based on it right row.
it will build fail.

[0]:http://lists.linuxfoundation.org/pipermail/iommu/2015-January/011939.html

> > + */
> > +static struct device *pimudev;
> > +
[snip]
> > +
> > +static int mtk_iommu_attach_device(struct iommu_domain *domain,
> > +                                  struct device *dev)
> > +{
> > +       unsigned long flags;
> > +       struct mtk_iommu_domain *priv = domain->priv;
> > +       struct mtk_iommu_info *piommu = priv->piommuinfo;
> > +       struct of_phandle_args out_args = {0};
> > +       struct device *imudev;
> > +       unsigned int i = 0;
> > +
> > +       if (!piommu)
> 
> Could you explain when this can happen?
	If we call arch_setup_dma_ops to create a iommu domain,
it will enter iommu_dma_attach_device, then enter here. At that time, we
don't add the private data to this "struct iommu_domain *".
@Robin, Could this be improved?
> 
> > +               goto imudev;
> 
> return 0;
> 
> > +       else
> 
> No else needed.
> 
> > +               imudev = piommu->dev;
> > +
> > +       spin_lock_irqsave(&priv->portlock, flags);
> 
> What is protected by this spinlock?
	We will write a register of the local arbiter while config port. If
some modules are in the same local arbiter, it may be overwrite. so I
add it here.
> 
> > +
> > +       while (!of_parse_phandle_with_args(dev->of_node, "iommus",
> > +                                          "#iommu-cells", i, &out_args)) {
> > +               if (1 == out_args.args_count) {
> 
> Can we be sure that this is actually referring to our IOMMU?
> 
> Maybe this should be rewritten to
> 
> if (out_args.np != imudev->of_node)
>         continue;
> if (out_args.args_count != 1) {
>         dev_err(imudev, "invalid #iommu-cells property for IOMMU %s\n",
> 
> }
> 
> > +                       unsigned int portid = out_args.args[0];
> > +
> > +                       dev_dbg(dev, "iommu add port:%d\n", portid);
> 
> imudev should be used here instead of dev.
> 
> > +
> > +                       mtk_iommu_config_port(piommu, portid);
> > +
> > +                       if (i == 0)
> > +                               dev->archdata.dma_ops =
> > +                                       piommu->dev->archdata.dma_ops;
> 
> Shouldn't this be set automatically by IOMMU or DMA mapping core?
@Robin, 
     In the original "arm_iommu_attach_device" of arm/mm, it will call
set_dma_ops to add iommu_ops for each iommu device.
But iommu_dma_attach_device don't help this, so I have to add it here.
Could this be improved?
> 
> > +               }
> > +               i++;
> > +       }
> > +
> > +       spin_unlock_irqrestore(&priv->portlock, flags);
> > +
> > +imudev:
> > +       return 0;
> > +}
> > +
> > +static void mtk_iommu_detach_device(struct iommu_domain *domain,
> > +                                   struct device *dev)
> > +{
> 
> No hardware (de)configuration or clean-up necessary?
I will add it. Actually we design like this:If a device have attached to
iommu domain, it won't detach from it.
> 
> > +}
> > +
[snip]
> 
> > +
> > +       piommu->protect_va = devm_kmalloc(piommu->dev, MTK_PROTECT_PA_ALIGN*2,
> 
> style: Operators like * should have space on both sides.
> 
> > +                                         GFP_KERNEL);
> 
> Shouldn't dma_alloc_coherent() be used for this?
     We don't care the data in it. I think they are the same. Could you
help tell me why dma_alloc_coherent may be better.
> 
> > +       if (!piommu->protect_va)
> > +               goto protect_err;
> 
> Please return -ENOMEM here directly, as there is nothing to clean up
> in this case.
> 
[snip]
> 
> > +               dev_err(piommu->dev, "IRQ request %d failed\n",
> > +                       piommu->irq);
> > +               goto hw_err;
> > +       }
> > +
> > +       iommu_set_fault_handler(domain, mtk_iommu_fault_handler, piommu);
> 
> I don't see any other drivers doing this. Isn't this for upper layers,
> so that they can set their own generic fault handlers?
     I think that this function is related with the iommu domain, we
have only one multimedia iommu domain. so I add it after the iommu
domain are created.
> 
> > +
> > +       dev_set_drvdata(piommu->dev, piommu);
> 
> This should be set before allowing the interrupt to fire. In other
> words, the driver should be fully set up at the time of enabling the
> IRQ.
> 
> > +
> > +       return 0;
> 
> style: Missing blank line.
> 
> > +hw_err:
> > +       arch_teardown_dma_ops(piommu->dev);
> > +pte_err:
> > +       kmem_cache_destroy(piommu->m4u_pte_kmem);
> > +protect_err:
> > +       dev_err(piommu->dev, "probe error\n");
> 
> Please replace this with specific messages for all errors (in case the
> called function doesn't already print one like kmalloc and friends).
> 
> > +       return 0;
> 
> Returning 0, which means success, doesn't look like a good idea for
> signalling a failure. Please return the correct error code as received
> from function that errors out if possible.
> 
> End of part 3.
> 
> Best regards,
> Tomasz
