From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH V3 8/8] arm64: dma-mapping: Remove the notifier trick to handle early setting of dma_ops
Date: Thu, 27 Oct 2016 10:49:40 +0530
Message-ID: <005501d23011$bba47420$32ed5c60$@codeaurora.org>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org> <1475600632-21289-9-git-send-email-sricharan@codeaurora.org> <e4643826-3aa8-1e34-79a8-9e1fcf0fcb69@arm.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <e4643826-3aa8-1e34-79a8-9e1fcf0fcb69@arm.com>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Robin Murphy' <robin.murphy@arm.com>, will.deacon@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, laurent.pinchart@ideasonboard.com, m.szyprowski@samsung.com, tfiga@chromium.org, srinivas.kandagatla@linaro.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

>On 04/10/16 18:03, Sricharan R wrote:
>> With arch_setup_dma_ops now being called late during device's probe after the
>> device's iommu is probed, the notifier trick required to handle the early
>> setup of dma_ops before the iommu group gets created is not required.
>> So removing the notifier's here.
>
>Hooray!
>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  arch/arm64/mm/dma-mapping.c | 100 ++------------------------------------------
>>  1 file changed, 3 insertions(+), 97 deletions(-)
>>
>> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
>> index faf4b92..eb593af 100644
>> --- a/arch/arm64/mm/dma-mapping.c
>> +++ b/arch/arm64/mm/dma-mapping.c
>> @@ -799,24 +799,6 @@ static struct dma_map_ops iommu_dma_ops = {
>>  	.mapping_error = iommu_dma_mapping_error,
>>  };
>>
>> -/*
>> - * TODO: Right now __iommu_setup_dma_ops() gets called too early to do
>> - * everything it needs to - the device is only partially created and the
>> - * IOMMU driver hasn't seen it yet, so it can't have a group. Thus we
>> - * need this delayed attachment dance. Once IOMMU probe ordering is sorted
>> - * to move the arch_setup_dma_ops() call later, all the notifier bits below
>> - * become unnecessary, and will go away.
>> - */
>> -struct iommu_dma_notifier_data {
>> -	struct list_head list;
>> -	struct device *dev;
>> -	const struct iommu_ops *ops;
>> -	u64 dma_base;
>> -	u64 size;
>> -};
>> -static LIST_HEAD(iommu_dma_masters);
>> -static DEFINE_MUTEX(iommu_dma_notifier_lock);
>> -
>>  static bool do_iommu_attach(struct device *dev, const struct iommu_ops *ops,
>>  			   u64 dma_base, u64 size)
>
>This should go as well...

 ok.
>
>>  {
>> @@ -837,79 +819,9 @@ static bool do_iommu_attach(struct device *dev, const struct iommu_ops *ops,
>>  	return true;
>>  }
>>
>> -static void queue_iommu_attach(struct device *dev, const struct iommu_ops *ops,
>> -			      u64 dma_base, u64 size)
>> -{
>> -	struct iommu_dma_notifier_data *iommudata;
>> -
>> -	iommudata = kzalloc(sizeof(*iommudata), GFP_KERNEL);
>> -	if (!iommudata)
>> -		return;
>> -
>> -	iommudata->dev = dev;
>> -	iommudata->ops = ops;
>> -	iommudata->dma_base = dma_base;
>> -	iommudata->size = size;
>> -
>> -	mutex_lock(&iommu_dma_notifier_lock);
>> -	list_add(&iommudata->list, &iommu_dma_masters);
>> -	mutex_unlock(&iommu_dma_notifier_lock);
>> -}
>> -
>> -static int __iommu_attach_notifier(struct notifier_block *nb,
>> -				   unsigned long action, void *data)
>> -{
>> -	struct iommu_dma_notifier_data *master, *tmp;
>> -
>> -	if (action != BUS_NOTIFY_BIND_DRIVER)
>> -		return 0;
>> -
>> -	mutex_lock(&iommu_dma_notifier_lock);
>> -	list_for_each_entry_safe(master, tmp, &iommu_dma_masters, list) {
>> -		if (data == master->dev && do_iommu_attach(master->dev,
>> -				master->ops, master->dma_base, master->size)) {
>> -			list_del(&master->list);
>> -			kfree(master);
>> -			break;
>> -		}
>> -	}
>> -	mutex_unlock(&iommu_dma_notifier_lock);
>> -	return 0;
>> -}
>> -
>> -static int __init register_iommu_dma_ops_notifier(struct bus_type *bus)
>> -{
>> -	struct notifier_block *nb = kzalloc(sizeof(*nb), GFP_KERNEL);
>> -	int ret;
>> -
>> -	if (!nb)
>> -		return -ENOMEM;
>> -
>> -	nb->notifier_call = __iommu_attach_notifier;
>> -
>> -	ret = bus_register_notifier(bus, nb);
>> -	if (ret) {
>> -		pr_warn("Failed to register DMA domain notifier; IOMMU DMA ops unavailable on bus '%s'\n",
>> -			bus->name);
>> -		kfree(nb);
>> -	}
>> -	return ret;
>> -}
>> -
>>  static int __init __iommu_dma_init(void)
>>  {
>> -	int ret;
>> -
>> -	ret = iommu_dma_init();
>> -	if (!ret)
>> -		ret = register_iommu_dma_ops_notifier(&platform_bus_type);
>> -	if (!ret)
>> -		ret = register_iommu_dma_ops_notifier(&amba_bustype);
>> -#ifdef CONFIG_PCI
>> -	if (!ret)
>> -		ret = register_iommu_dma_ops_notifier(&pci_bus_type);
>> -#endif
>> -	return ret;
>> +	return iommu_dma_init();
>>  }
>>  arch_initcall(__iommu_dma_init);
>>
>> @@ -920,18 +832,12 @@ static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>>
>>  	if (!ops)
>>  		return;
>> -	/*
>> -	 * TODO: As a concession to the future, we're ready to handle being
>> -	 * called both early and late (i.e. after bus_add_device). Once all
>> -	 * the platform bus code is reworked to call us late and the notifier
>> -	 * junk above goes away, move the body of do_iommu_attach here.
>
>...per this commment. It has no need to be a separate function once this
>is the only call site (plus it has a misleadingly inaccurate name anyway).

 ya, missed to remove that function as well. Will do it in the next.

Regards,
 Sricharan
