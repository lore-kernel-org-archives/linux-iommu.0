From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH V3 4/8] drivers: platform: Configure dma operations at probe time
Date: Wed, 2 Nov 2016 12:35:06 +0530
Message-ID: <004101d234d7$753c8840$5fb598c0$@codeaurora.org>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org> <1475600632-21289-5-git-send-email-sricharan@codeaurora.org> <a77ab9da-1347-49e8-6c55-071bd712729a@arm.com> <003d01d22f9a$56477b80$02d67280$@codeaurora.org> <20161027104924.GA16905@red-moon>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20161027104924.GA16905@red-moon>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>
Cc: 'Robin Murphy' <robin.murphy@arm.com>, will.deacon@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, laurent.pinchart@ideasonboard.com, m.szyprowski@samsung.com, tfiga@chromium.org, srinivas.kandagatla@linaro.org
List-Id: iommu@lists.linux-foundation.org

Hi Lorenzo,

>-----Original Message-----
>From: linux-arm-msm-owner@vger.kernel.org [mailto:linux-arm-msm-owner@vger.kernel.org] On Behalf Of Lorenzo Pieralisi
>Sent: Thursday, October 27, 2016 4:19 PM
>To: Sricharan <sricharan@codeaurora.org>
>Cc: 'Robin Murphy' <robin.murphy@arm.com>; will.deacon@arm.com; joro@8bytes.org; iommu@lists.linux-foundation.org; linux-
>arm-kernel@lists.infradead.org; linux-arm-msm@vger.kernel.org; laurent.pinchart@ideasonboard.com;
>m.szyprowski@samsung.com; tfiga@chromium.org; srinivas.kandagatla@linaro.org
>Subject: Re: [PATCH V3 4/8] drivers: platform: Configure dma operations at probe time
>
>On Wed, Oct 26, 2016 at 08:34:59PM +0530, Sricharan wrote:
>> Hi Robin,
>>
>> >On 04/10/16 18:03, Sricharan R wrote:
>> >> Configuring DMA ops at probe time will allow deferring device probe when
>> >> the IOMMU isn't available yet. The dma_configure for the device is now called
>> >> from the generic device_attach callback just before the bus/driver probe
>> >> is called. This way, configuring the dma ops for the device would be called
>> >> at the same place for all bus_types, hence the deferred probing mechanism
>> >> should work for all buses as well.
>> >>
>> >> pci_bus_add_devices    (platform/amba)(_device_create/driver_register)
>> >>        |                         |
>> >> pci_bus_add_device     (device_add/driver_register)
>> >>        |                         |
>> >> device_attach           device_initial_probe
>> >>        |                         |
>> >> __device_attach_driver    __device_attach_driver
>> >>        |
>> >> driver_probe_device
>> >>        |
>> >> really_probe
>> >>        |
>> >> dma_configure
>> >>
>> >>  Similarly on the device/driver_unregister path __device_release_driver is
>> >>  called which inturn calls dma_deconfigure.
>> >>
>> >> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> >> ---
>> >>  drivers/base/dd.c           | 10 ++++++++++
>> >>  drivers/base/dma-mapping.c  | 11 +++++++++++
>> >>  drivers/of/platform.c       |  4 ----
>> >>  drivers/pci/probe.c         |  5 +----
>> >>  include/linux/dma-mapping.h |  3 +++
>> >>  5 files changed, 25 insertions(+), 8 deletions(-)
>> >>
>> >> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> >> index 16688f5..cfebd48 100644
>> >> --- a/drivers/base/dd.c
>> >> +++ b/drivers/base/dd.c
>> >> @@ -19,6 +19,7 @@
>> >>
>> >>  #include <linux/device.h>
>> >>  #include <linux/delay.h>
>> >> +#include <linux/dma-mapping.h>
>> >>  #include <linux/module.h>
>> >>  #include <linux/kthread.h>
>> >>  #include <linux/wait.h>
>> >> @@ -353,6 +354,10 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>> >>  	if (ret)
>> >>  		goto pinctrl_bind_failed;
>> >>
>> >> +	ret = dma_configure(dev);
>> >> +	if (ret)
>> >> +		goto dma_failed;
>> >> +
>> >>  	if (driver_sysfs_add(dev)) {
>> >>  		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
>> >>  			__func__, dev_name(dev));
>> >> @@ -395,6 +400,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>> >>  	goto done;
>> >>
>> >>  probe_failed:
>> >> +	dma_deconfigure(dev);
>> >> +dma_failed:
>> >>  	if (dev->bus)
>> >>  		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>> >>  					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
>> >> @@ -780,6 +787,9 @@ static void __device_release_driver(struct device *dev)
>> >>  			dev->bus->remove(dev);
>> >>  		else if (drv->remove)
>> >>  			drv->remove(dev);
>> >> +
>> >> +		dma_deconfigure(dev);
>> >> +
>> >>  		devres_release_all(dev);
>> >>  		dev->driver = NULL;
>> >>  		dev_set_drvdata(dev, NULL);
>> >> diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
>> >> index d799662..54e87f5 100644
>> >> --- a/drivers/base/dma-mapping.c
>> >> +++ b/drivers/base/dma-mapping.c
>> >> @@ -10,6 +10,7 @@
>> >>  #include <linux/dma-mapping.h>
>> >>  #include <linux/export.h>
>> >>  #include <linux/gfp.h>
>> >> +#include <linux/of_device.h>
>> >>  #include <linux/slab.h>
>> >>  #include <linux/vmalloc.h>
>> >>
>> >> @@ -166,6 +167,16 @@ void dmam_free_noncoherent(struct device *dev, size_t size, void *vaddr,
>> >>  }
>> >>  EXPORT_SYMBOL(dmam_free_noncoherent);
>> >>
>> >> +int dma_configure(struct device *dev)
>> >> +{
>> >> +	return of_dma_configure(dev, dev->of_node);
>> >> +}
>> >> +
>> >> +void dma_deconfigure(struct device *dev)
>> >> +{
>> >> +	of_dma_deconfigure(dev);
>> >> +}
>> >> +
>> >>  #ifdef CONFIG_HAVE_GENERIC_DMA_COHERENT
>> >>
>> >>  static void dmam_coherent_decl_release(struct device *dev, void *res)
>> >> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>> >> index 9cb7090..adbd77c 100644
>> >> --- a/drivers/of/platform.c
>> >> +++ b/drivers/of/platform.c
>> >> @@ -181,11 +181,9 @@ static struct platform_device *of_platform_device_create_pdata(
>> >>
>> >>  	dev->dev.bus = &platform_bus_type;
>> >>  	dev->dev.platform_data = platform_data;
>> >> -	of_dma_configure(&dev->dev, dev->dev.of_node);
>> >>  	of_msi_configure(&dev->dev, dev->dev.of_node);
>> >>
>> >>  	if (of_device_add(dev) != 0) {
>> >> -		of_dma_deconfigure(&dev->dev);
>> >>  		platform_device_put(dev);
>> >>  		goto err_clear_flag;
>> >>  	}
>> >> @@ -242,7 +240,6 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>> >>  		dev_set_name(&dev->dev, "%s", bus_id);
>> >>  	else
>> >>  		of_device_make_bus_id(&dev->dev);
>> >> -	of_dma_configure(&dev->dev, dev->dev.of_node);
>> >>
>> >>  	/* Allow the HW Peripheral ID to be overridden */
>> >>  	prop = of_get_property(node, "arm,primecell-periphid", NULL);
>> >> @@ -536,7 +533,6 @@ static int of_platform_device_destroy(struct device *dev, void *data)
>> >>  		amba_device_unregister(to_amba_device(dev));
>> >>  #endif
>> >>
>> >> -	of_dma_deconfigure(dev);
>> >>  	of_node_clear_flag(dev->of_node, OF_POPULATED);
>> >>  	of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
>> >>  	return 0;
>> >> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> >> index 93f280d..85c9553 100644
>> >> --- a/drivers/pci/probe.c
>> >> +++ b/drivers/pci/probe.c
>> >> @@ -1724,10 +1724,7 @@ static void pci_dma_configure(struct pci_dev *dev)
>> >>  {
>> >>  	struct device *bridge = pci_get_host_bridge_device(dev);
>> >>
>> >> -	if (IS_ENABLED(CONFIG_OF) &&
>> >> -		bridge->parent && bridge->parent->of_node) {
>> >> -			of_dma_configure(&dev->dev, bridge->parent->of_node);
>> >> -	} else if (has_acpi_companion(bridge)) {
>> >> +	if (has_acpi_companion(bridge)) {
>> >>  		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
>> >>  		enum dev_dma_attr attr = acpi_get_dma_attr(adev);
>> >
>> >It seems a bit awkward leaving pci_dma_configure here, doing DMA
>> >configuration at device add, after we've allegedly moved DMA
>> >configuration to driver probe. Lorenzo, do you foresee any issues if
>> >this probe-time of_dma_configure() path were to also multiplex
>> >acpi_dma_configure() in future, such that everything would be back in
>> >the same place eventually?
>> >
>> >Conversely, is there actually any issue with leaving pci_dma_configure()
>> >unchanged, and simply moving the call from pci_device_add() into
>> >dma_configure()?
>>
>> Ya i removed only the CONFIG_OF part out of this, and was hoping that
>> the acpi configure can also be called from the dma_configure during
>> probe later. I did not have an ACPI based platform though.  As you
>> said, if that looks right to the ACPI world, it can be moved out from
>> here. I can try mergin series (after fixing the vfio errors part) with
>> the ACPI IO port and see how it behaves.
>
>I do not expect any issue from this change, as long as, as Robin said,
>it is done consistently which means that I am not ok with this patch
>as it stands (ie you should defer pci_dma_configure() in its entirety,
>not just the DT bits, which obviously requires some ACPI testing too).
>
>CC me in please in the next posting since this affects the ACPI probing
>path too, we have to coordinate this series with my ACPI IORT SMMU
>enablement patches:
>
>https://lkml.org/lkml/2016/10/18/506

Ok thanks, i will have you in looped for the V4 i am posting
and we can have it tested on ACPI as well.

Regards,
 Sricharan
