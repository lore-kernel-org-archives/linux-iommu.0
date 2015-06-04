From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 3/4] arm64: Add IOMMU dma_ops
Date: Thu, 4 Jun 2015 20:29:52 +0800
Message-ID: <1433420992.4270.86.camel@mhfsdcap03>
References: <cover.1432735420.git.robin.murphy@arm.com>
	<cd32131caab8833f48180ee1df79c9da020c5a48.1432735420.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cd32131caab8833f48180ee1df79c9da020c5a48.1432735420.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,
     Sorry to disturb you. When prepare iommu based on this dma-v3. I
meet some problem about how to use the dma-iommu.
     I list some sample code like below:
//========
int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
{
        if (args->args_count != 2) {            
                return -EINVAL;
        }

        /* save the private data from args  
         * the private data is larbid and portid in our platform */
        priv->larbid = args->args[0];
        priv->portid = args->args[1];

        /*list the private data */
        list_add_tail(&priv->client, &head->client);

        /* save the list to dev->archdata->iommu */
        ...
}
static int mtk_iommu_init_fn(struct device_node *np)
{
        of_iommu_set_ops(np, &mtk_iommu_ops);   
        return 0;
}

IOMMU_OF_DECLARE(mtkm4u, "mediatek,mt8173-m4u", mtk_iommu_init_fn);
//=======

Question :
  1: if there are 2 client devices use iommu, it will be like this in
dtsi,
                disp:testiommu@1400c000 {
                        compatible = "mediatek,mt8173-test";
                        iommus = <&iommu M4U_LARB0_ID 0>,
                                 <&iommu M4U_LARB1_ID 3>;
                };
                disp1:testiommu@1400D000 {
                        compatible = "mediatek,mt8173-disptest1";
                        iommus = <&iommu M4U_LARB0_ID 8>, 
                                 <&iommu M4U_LARB1_ID 2>;
                };
    Then both devices will enter arch_setup_dma_ops and their parameter
"struct iommu_ops *" is not zero, then it will create two
dma-iommu-domain.
    If we expect all the client device share a iommu domain, then how
should i do?

2. iommu_dma_attach_device will be called automatically in the notify
"__iommu_attach_notifier". But it run before the probe of our iommu
device.
    Then we can't write the register to enable iommu in *_attach_device
because we have not parsed the dtsi at that time.
   ->I have tried to move parse dtsi into mtk_iommu_of_xlate, in order
to read/write register in attach_device.
But it will be warning like this:
(150604_09:43:41.094)WARNING: CPU: 0 PID: 1
at /proj/mtk40525/upstreamdev/chromebook_kernelonly/kernel/mediatek/drivers/base/dd.c:286 driver_probe_device+0x25c/0x29c()

3.In mtk_iommu_probe, we can't get "struct iommu_domain *" from the
current iommu device, we should use it while devm_request_irq.
I have to use the global variable here?!

4.If I don't implement the of_xlate and IOMMU_OF_DECLARE, I call
iommu_dma_create_domain in the mtk_iommu_probe, but I can not
get the "iommu_dma_ops" which is static in arch/arm64/mm/dma-mapping.c
to assign to dev->archdata->dma_ops for the iommu client device.

If i miss something, please tell me and help give some suggestion.
Thanks very much.

On Wed, 2015-05-27 at 15:09 +0100, Robin Murphy wrote:
> Taking some inspiration from the arch/arm code, implement the
> arch-specific side of the DMA mapping ops using the new IOMMU-DMA layer.
> 
> Whilst proliferating per-device private IOMMU data via dev->archdata is
> less than ideal, it will do the job for now, especially since we can't
> easily handle the kind of problematic system topologies in the current
> IOMMU API anyway.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  arch/arm64/include/asm/device.h      |   3 +
>  arch/arm64/include/asm/dma-mapping.h |  14 ++
>  arch/arm64/mm/dma-mapping.c          | 342 +++++++++++++++++++++++++++++++++++
>  include/linux/dma-iommu.h            |   4 +-
>  4 files changed, 361 insertions(+), 2 deletions(-)
> 
[snip]
> +struct iommu_dma_notifier_data {
> +	struct list_head list;
> +	struct device *dev;
> +	struct iommu_dma_domain *dma_domain;
> +};
> +static LIST_HEAD(iommu_dma_masters);
> +static DEFINE_MUTEX(iommu_dma_notifier_lock);
> +
> +static int __iommu_attach_notifier(struct notifier_block *nb,
> +				   unsigned long action, void *data)
> +{
> +	struct iommu_dma_notifier_data *master, *tmp;
> +
> +	if (action != BUS_NOTIFY_ADD_DEVICE)
> +		return 0;
> +	/*
> +	 * We expect the list to only contain the most recent addition,
> +	 * which *should* be the same device as @data, so just process the
> +	 * whole thing blindly. If any previous attachments did happen to
> +	 * fail, they get a free retry since the domains are still live.
> +	 */
> +	mutex_lock(&iommu_dma_notifier_lock);
> +	list_for_each_entry_safe(master, tmp, &iommu_dma_masters, list) {
> +		if (iommu_dma_attach_device(master->dev, master->dma_domain)) {
> +			pr_warn("Failed to attach device %s to IOMMU mapping; retaining platform DMA ops\n",
> +				dev_name(master->dev));
> +		} else {
> +			master->dev->archdata.dma_ops = &iommu_dma_ops;
> +			/* it's safe to drop the initial refcount now */
> +			iommu_dma_release_domain(master->dma_domain);
> +			list_del(&master->list);
> +			kfree(master);
> +		}
> +	}
> +	mutex_unlock(&iommu_dma_notifier_lock);
> +	return 0;
> +}
> +
> +static int register_iommu_dma_ops_notifier(struct bus_type *bus)
> +{
> +	int ret;
> +	struct notifier_block *nb = kzalloc(sizeof(*nb), GFP_KERNEL);
> +
> +	/*
> +	 * The device must be attached to a domain before its driver probe,
> +	 * in case the driver allocates DMA buffers immediately. However, most
> +	 * IOMMU drivers are currently configuring groups in their add_device
> +	 * callback, so the attach should happen after that. Since the IOMMU
> +	 * core uses a bus notifier for add_device, do the same but with a
> +	 * stupidly low priority to ensure the appropriate ordering.
> +	 *
> +	 * This can hopefully all go away once we have default domains in the
> +	 * IOMMU core.
> +	 */
> +	nb->notifier_call = __iommu_attach_notifier;
> +	nb->priority = INT_MIN;
> +
> +	ret = bus_register_notifier(bus, nb);
> +	if (ret) {
> +		pr_warn("Failed to register DMA domain notifier; IOMMU DMA ops unavailable on bus '%s'\n",
> +			bus->name);
> +		kfree(nb);
> +	}
> +	return ret;
> +}
> +
> +static int __init arm64_iommu_dma_init(void)
> +{
> +	int ret;
> +
> +	ret = iommu_dma_init();
> +	if (!ret)
> +		ret = register_iommu_dma_ops_notifier(&platform_bus_type);
> +	if (!ret)
> +		ret = register_iommu_dma_ops_notifier(&amba_bustype);
> +	return ret;
> +}
> +arch_initcall(arm64_iommu_dma_init);
> +
> +static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +				  const struct iommu_ops *ops)
> +{
> +	struct iommu_dma_notifier_data *iommudata;
> +
> +	if (!ops)
> +		return;
> +
> +	iommudata = kzalloc(sizeof(*iommudata), GFP_KERNEL);
> +	if (!iommudata)
> +		return;
> +
> +	iommudata->dev = dev;
> +	iommudata->dma_domain = iommu_dma_create_domain(ops, dma_base, size);
> +	if (!iommudata->dma_domain) {
> +		pr_warn("Failed to create %llu-byte IOMMU mapping for device %s\n",
> +				size, dev_name(dev));
> +		kfree(iommudata);
> +		return;
> +	}
> +	mutex_lock(&iommu_dma_notifier_lock);
> +	list_add(&iommudata->list, &iommu_dma_masters);
> +	mutex_unlock(&iommu_dma_notifier_lock);
> +}
> +
