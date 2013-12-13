From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCHv7 04/12] driver/core: populate devices in order for IOMMUs
Date: Thu, 12 Dec 2013 18:14:02 -0800
Message-ID: <20131213021402.GB14192@kroah.com>
References: <1386835033-4701-1-git-send-email-hdoyu@nvidia.com>
	<1386835033-4701-5-git-send-email-hdoyu@nvidia.com>
	<20131212113920.70E8BC40637@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131212113920.70E8BC40637-WNowdnHR2B42iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Dec 12, 2013 at 11:39:20AM +0000, Grant Likely wrote:
> On Thu, 12 Dec 2013 09:57:05 +0200, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> > IOMMU devices on the bus need to be poplulated first, then iommu
> > master devices are done later.
> > 
> > With CONFIG_OF_IOMMU, "iommus=" DT binding would be used to identify
> > whether a device can be an iommu msater or not. If a device can, we'll
> > defer to populate that device till an iommu device is populated. Then,
> > those deferred iommu master devices are populated and configured with
> > help of the already populated iommu device.
> > 
> > Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
> > ---
> > This is related to the following discussion:
> >   [RFC PATCH] Documentation: devicetree: add description for generic bus properties
> >   http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/215042.html
> > 
> > v6:
> > Spinned off only driver core part from:
> >   [PATCHv5 2/9] driver/core: populate devices in order for IOMMUs
> > 
> > v5:
> > Use "iommus=" binding instread of arm,smmu's "#stream-id-cells".
> > 
> > v4:
> > This is newly added, and the successor of the following RFC:
> >   [RFC][PATCHv3+ 1/2] driver/core: Add of_iommu_attach()
> >   http://lists.linuxfoundation.org/pipermail/iommu/2013-November/006914.html
> > 
> > Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/base/dd.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index 0605176..0605f52 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/async.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/pinctrl/devinfo.h>
> > +#include <linux/of_iommu.h>
> >  
> >  #include "base.h"
> >  #include "power/power.h"
> > @@ -273,6 +274,10 @@ static int really_probe(struct device *dev, struct device_driver *drv)
> >  
> >  	dev->driver = drv;
> >  
> > +	ret = of_iommu_attach(dev);
> > +	if (ret)
> > +		goto probe_failed;
> > +
> 
> As discussed before, I really don't think hooking in to dd.c is the
> right thing to do here, and certainly not as a device tree specific
> function. ACPI or PCI described devices may have the same constraints
> and those won't have DT descriptions.

I agree, this shouldn't be in the driver core.

greg k-h
