From: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv5 2/9] driver/core: populate devices in order for IOMMUs
Date: Thu, 21 Nov 2013 13:15:58 +0000
Message-ID: <20131121131558.E5B82C40A2C@trevor.secretlab.ca>
References: <1384853593-32202-1-git-send-email-hdoyu@nvidia.com> < 1384853593-32202-3-git-send-email-hdoyu@nvidia.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384853593-32202-3-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 19 Nov 2013 11:33:06 +0200, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> IOMMU devices on the bus need to be poplulated first, then iommu
> master devices are done later.
> 
> With CONFIG_OF_IOMMU, "iommus=" DT binding would be used to identify
> whether a device can be an iommu msater or not. If a device can, we'll
> defer to populate that device till an iommu device is populated. Once
> an iommu device is populated, "dev->bus->iommu_ops" is set in the
> bus. Then, those defered iommu master devices are populated and
> configured for IOMMU with help of the already populated iommu device
> via iommu_ops->add_device(). Multiple IOMMUs can be listed on this
> "iommus" binding so that a device can have multiple IOMMUs attached.
> 
> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> v5:
> Use "iommus=" binding instread of arm,smmu's "#stream-id-cells".
> 
> v4:
> This is newly added, and the successor of the following RFC:
>   [RFC][PATCHv3+ 1/2] driver/core: Add of_iommu_attach()
>   http://lists.linuxfoundation.org/pipermail/iommu/2013-November/006914.html
> ---
>  drivers/base/dd.c        |  5 +++++
>  drivers/iommu/of_iommu.c | 22 ++++++++++++++++++++++
>  include/linux/of_iommu.h |  7 +++++++
>  3 files changed, 34 insertions(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 35fa368..6e892d4 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -25,6 +25,7 @@
>  #include <linux/async.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pinctrl/devinfo.h>
> +#include <linux/of_iommu.h>
>  
>  #include "base.h"
>  #include "power/power.h"
> @@ -273,6 +274,10 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  
>  	dev->driver = drv;
>  
> +	ret = of_iommu_attach(dev);
> +	if (ret)
> +		goto probe_failed;
> +
>  	/* If using pinctrl, bind pins now before probing */
>  	ret = pinctrl_bind_pins(dev);
>  	if (ret)

I'm very concerned about this approach. Hooking into the core probe
path for things like this is not going to scale well. I'm not thrilled
with the pinctrl hook being here either, but that is already merged. :-(
Also, hooking in here is going affect every single device device driver
probe path, and a large number of them are never, ever, going to have
iommu interactions.

There needs to be a less invasive way of doing what you want. I still
feel like the individual device drivers themselves need to be aware that
they might be hooking through an IOMMU. Or, if they are hooking through
a bus like PCIe, then have the PCIe bus defer creating child devices
until the IOMMU is configured and in place.

g.
