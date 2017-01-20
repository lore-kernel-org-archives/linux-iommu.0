From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH V5 05/12] drivers: platform: Configure dma operations at probe time
Date: Fri, 20 Jan 2017 11:55:40 +0530
Message-ID: <000f01d272e6$08eba070$1ac2e150$@codeaurora.org>
References: <1484838356-24962-1-git-send-email-sricharan@codeaurora.org> <1484838356-24962-6-git-send-email-sricharan@codeaurora.org> <327b5a9b-35f6-f6e0-4ef9-d2ed15bb4e49@arm.com> <20170119190250.GA11181@red-moon>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20170119190250.GA11181@red-moon>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>, 'Robin Murphy' <robin.murphy@arm.com>
Cc: will.deacon@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

Hi,

>
>> > pci_bus_add_devices    =
(platform/amba)(_device_create/driver_register)
>> >        |                         |
>> > pci_bus_add_device     (device_add/driver_register)
>> >        |                         |
>> > device_attach           device_initial_probe
>> >        |                         |
>> > __device_attach_driver    __device_attach_driver
>> >        |
>> > driver_probe_device
>> >        |
>> > really_probe
>> >        |
>> > dma_configure
>> >
>> > Similarly on the device/driver_unregister path =
__device_release_driver is
>> > called which inturn calls dma_deconfigure.
>> >
>> > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> > ---
>> >  * Removed the dma configuration for the pci devices in case of DT
>> >    from pci_dma_configure which was hanging outside separately and
>> >    doing it in dma_configure function itself.
>> >
>> >  drivers/base/dd.c           |  9 +++++++++
>> >  drivers/base/dma-mapping.c  | 32 ++++++++++++++++++++++++++++++++
>> >  drivers/of/platform.c       |  5 +----
>> >  drivers/pci/probe.c         |  5 +----
>> >  include/linux/dma-mapping.h |  3 +++
>> >  5 files changed, 46 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> > index a1fbf55..4882f06 100644
>> > --- a/drivers/base/dd.c
>> > +++ b/drivers/base/dd.c
>> > @@ -19,6 +19,7 @@
>> >
>> >  #include <linux/device.h>
>> >  #include <linux/delay.h>
>> > +#include <linux/dma-mapping.h>
>> >  #include <linux/module.h>
>> >  #include <linux/kthread.h>
>> >  #include <linux/wait.h>
>> > @@ -356,6 +357,10 @@ static int really_probe(struct device *dev, =
struct device_driver *drv)
>> >  	if (ret)
>> >  		goto pinctrl_bind_failed;
>> >
>> > +	ret =3D dma_configure(dev);
>> > +	if (ret)
>> > +		goto dma_failed;
>> > +
>> >  	if (driver_sysfs_add(dev)) {
>> >  		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
>> >  			__func__, dev_name(dev));
>> > @@ -417,6 +422,8 @@ static int really_probe(struct device *dev, =
struct device_driver *drv)
>> >  	goto done;
>> >
>> >  probe_failed:
>> > +	dma_deconfigure(dev);
>> > +dma_failed:
>> >  	if (dev->bus)
>> >  		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>> >  					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
>> > @@ -826,6 +833,8 @@ static void __device_release_driver(struct =
device *dev, struct device *parent)
>> >  			drv->remove(dev);
>> >
>> >  		device_links_driver_cleanup(dev);
>> > +		dma_deconfigure(dev);
>> > +
>> >  		devres_release_all(dev);
>> >  		dev->driver =3D NULL;
>> >  		dev_set_drvdata(dev, NULL);
>> > diff --git a/drivers/base/dma-mapping.c =
b/drivers/base/dma-mapping.c
>> > index efd71cf..dfe6fd7 100644
>> > --- a/drivers/base/dma-mapping.c
>> > +++ b/drivers/base/dma-mapping.c
>> > @@ -10,6 +10,7 @@
>> >  #include <linux/dma-mapping.h>
>> >  #include <linux/export.h>
>> >  #include <linux/gfp.h>
>> > +#include <linux/of_device.h>
>> >  #include <linux/slab.h>
>> >  #include <linux/vmalloc.h>
>> >
>> > @@ -341,3 +342,34 @@ void dma_common_free_remap(void *cpu_addr, =
size_t size, unsigned long vm_flags)
>> >  	vunmap(cpu_addr);
>> >  }
>> >  #endif
>> > +
>> > +/*
>> > + * Common configuration to enable DMA API use for a device
>> > + */
>> > +#include <linux/pci.h>
>> > +
>> > +int dma_configure(struct device *dev)
>> > +{
>> > +	struct device *_dev =3D dev;
>> > +	int is_pci =3D dev_is_pci(dev);
>> > +
>> > +	if (is_pci) {
>> > +		_dev =3D pci_get_host_bridge_device(to_pci_dev(dev));
>> > +		if (IS_ENABLED(CONFIG_OF) && _dev->parent &&
>> > +		    _dev->parent->of_node)
>> > +			_dev =3D _dev->parent;
>> > +	}
>> > +
>> > +	if (_dev->of_node)
>> > +		of_dma_configure(dev, _dev->of_node);
>> > +
>> > +	if (is_pci)
>> > +		pci_put_host_bridge_device(_dev);
>>
>> There's a fun bug here - at this point _dev is the *parent* of the
>> bridge device, so we put the refcount on the wrong device (the =
platform
>> device representing the host controller, rather than the PCI device
>> representing its insides), which frees the guy we're in the middle of
>> probing, and things rapidly go wrong afterwards:
>>
>> [    1.461026] bus: 'platform': driver_probe_device: matched device
>> 40000000.pcie-controller with driver pci-host-generic
>> [    1.471640] bus: 'platform': really_probe: probing driver
>> pci-host-generic with device 40000000.pcie-controller
>> [    1.481678] OF: PCI: host bridge /pcie-controller@40000000 ranges:
>>
>> ...
>>
>> [    2.158259] bus: 'pci': driver_probe_device: matched device
>> 0000:02:10.0 with driver pcieport
>> [    2.166716] bus: 'pci': really_probe: probing driver pcieport with
>> device 0000:02:10.0
>> [    2.174590] pci 0000:02:10.0: Driver pcieport requests probe =
deferral
>> [    2.180978] pci 0000:02:10.0: Added to deferred list
>> [    2.185915] bus: 'pci': driver_probe_device: matched device
>> 0000:02:1f.0 with driver pcieport
>> [    2.194366] bus: 'pci': really_probe: probing driver pcieport with
>> device 0000:02:1f.0
>> [    2.202237] pci 0000:02:1f.0: Driver pcieport requests probe =
deferral
>> [    2.208625] pci 0000:02:1f.0: Added to deferred list
>> [    2.213582] driver: 'pci-host-generic': driver_bound: bound to =
device
>> =
'=EF=BF=BD=EF=BF=BD=EF=BF=BDv=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD.pcie-co=
ntroller'
>> [    2.222293] bus: 'platform': really_probe: bound device
>> =
=EF=BF=BD=EF=BF=BD=EF=BF=BDv=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD.pcie-con=
troller to driver pci-host-generic
>> [    2.232041] Unable to handle kernel NULL pointer dereference at
>> virtual address 00000000
>>
>> I recall debugging this same issue before, and I seem to have a local
>> version of this commit dated about 6 weeks ago where dma_configure()
>> looks like this:
>>
>> --->8---
>> int dma_configure(struct device *dev)
>> {
>> 	struct device *bridge =3D NULL, *dma_dev =3D dev;
>>
>> 	if (dev_is_pci(dev)) {
>> 		bridge =3D pci_get_host_bridge_device(to_pci_dev(dev));
>> 		dma_dev =3D bridge->parent;
>
>This would break ACPI, dma_dev would be NULL here, so from
>this standpoint (ACPI) the current patch is correct (but those =
[dev,_dev]
>should be renamed, they are extremely misleading so naming as
>in this hunk, which fixes DT too, is very welcome).
>

Ya, I was also thinking about the _ variable names in first place.
So i will use the names that Robin showed in his hunk and fix the=20
DT case that he pointed out.

Regards,
 Sricharan

>On ACPI the DMA attributes are checked on the bridge's companion
>(ie its associated acpi_device).
