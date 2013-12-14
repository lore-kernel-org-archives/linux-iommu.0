From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv7 04/12] driver/core: populate devices in order for
 IOMMUs
Date: Sat, 14 Dec 2013 15:28:59 +0100
Message-ID: <20131214.162859.271135324424271489.hdoyu@nvidia.com>
References: <20131212113920.70E8BC40637@trevor.secretlab.ca><20131213021402.GB14192@kroah.com><20131214122421.GB17467@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131214122421.GB17467@mithrandir>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Sat, 14 Dec 2013 13:24:22 +0100:

> * PGP Signed by an unknown key
> 
> On Thu, Dec 12, 2013 at 06:14:02PM -0800, Greg KH wrote:
> > On Thu, Dec 12, 2013 at 11:39:20AM +0000, Grant Likely wrote:
> > > On Thu, 12 Dec 2013 09:57:05 +0200, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> > > > IOMMU devices on the bus need to be poplulated first, then iommu
> > > > master devices are done later.
> > > > 
> > > > With CONFIG_OF_IOMMU, "iommus=" DT binding would be used to identify
> > > > whether a device can be an iommu msater or not. If a device can, we'll
> > > > defer to populate that device till an iommu device is populated. Then,
> > > > those deferred iommu master devices are populated and configured with
> > > > help of the already populated iommu device.
> > > > 
> > > > Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > > > Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
> > > > ---
> > > > This is related to the following discussion:
> > > >   [RFC PATCH] Documentation: devicetree: add description for generic bus properties
> > > >   http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/215042.html
> > > > 
> > > > v6:
> > > > Spinned off only driver core part from:
> > > >   [PATCHv5 2/9] driver/core: populate devices in order for IOMMUs
> > > > 
> > > > v5:
> > > > Use "iommus=" binding instread of arm,smmu's "#stream-id-cells".
> > > > 
> > > > v4:
> > > > This is newly added, and the successor of the following RFC:
> > > >   [RFC][PATCHv3+ 1/2] driver/core: Add of_iommu_attach()
> > > >   http://lists.linuxfoundation.org/pipermail/iommu/2013-November/006914.html
> > > > 
> > > > Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > > > ---
> > > >  drivers/base/dd.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > > 
> > > > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > > > index 0605176..0605f52 100644
> > > > --- a/drivers/base/dd.c
> > > > +++ b/drivers/base/dd.c
> > > > @@ -25,6 +25,7 @@
> > > >  #include <linux/async.h>
> > > >  #include <linux/pm_runtime.h>
> > > >  #include <linux/pinctrl/devinfo.h>
> > > > +#include <linux/of_iommu.h>
> > > >  
> > > >  #include "base.h"
> > > >  #include "power/power.h"
> > > > @@ -273,6 +274,10 @@ static int really_probe(struct device *dev, struct device_driver *drv)
> > > >  
> > > >  	dev->driver = drv;
> > > >  
> > > > +	ret = of_iommu_attach(dev);
> > > > +	if (ret)
> > > > +		goto probe_failed;
> > > > +
> > > 
> > > As discussed before, I really don't think hooking in to dd.c is the
> > > right thing to do here, and certainly not as a device tree specific
> > > function. ACPI or PCI described devices may have the same constraints
> > > and those won't have DT descriptions.
> > 
> > I agree, this shouldn't be in the driver core.
> 
> Okay, so what would be an alternative? Grant's objection makes sense and
> we could easily just wrap the call to of_iommu_attach() within a generic
> iommu_attach() that could decide at runtime which exact implementation
> to call, depending on whether the device is DT, ACPI, PCI or whatnot.
> 
> If we don't want something like that in the core either, then the only
> other alternative would be to call this from each driver. However given
> the desire to handle IOMMUs completely transparently for device drivers
> that would be missing the point.

What about using "bus_notifier" to send -EPROBE_DEFER?

The current bus_notifier framework doesn't have the ability to defer
the probe, but I may think that this change is acceptable relatively.

The fundamental problem is that IOMMU doesn't follow the exact bus
model like "chained IOMMU" cases, but this discussion may take long to
be solved. I think that "bus_notifier" with send -EPROBE_DEFER would
cover most of the normal cases, like normal IOMMU device probe
population order.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
