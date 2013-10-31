From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv3 01/19] [HACK] of: dev_node has struct device pointer
Date: Thu, 31 Oct 2013 17:49:14 +0100
Message-ID: <20131031.184914.17297540571149044.hdoyu@nvidia.com>
References: <20131030224108.GA6939@mithrandir><20131031.101405.2229107340254709582.hdoyu@nvidia.com><52728754.60307@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <52728754.60307-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Thu, 31 Oct 2013 17:37:40 +0100:

> On 10/31/2013 02:14 AM, Hiroshi Doyu wrote:
> > Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Wed, 30 Oct 2013 23:41:09 +0100:
> > 
> >> My earlier proposal for deferred interrupt reference resolution actually
> >> tries to solve that problem within the core. Essentially what it does is
> >> add a new function that gets called right before the driver's .probe()
> >> function, so that it can parse standard resources and services from DT,
> >> such as the interrupts property. This could theoretically be done for
> >> other resources such as reg as well, but it really only matters where
> >> the resource can be dynamic (as is the case for interrupts).
> >>
> >> In this case I would envision a standard OF function to associate a
> >> device with its IOMMU. Perhaps something like:
> >>
> >> 	int of_iommu_attach(struct device *dev);
> >>
> >> That could be called by the core independent of the specific device and
> >> IOMMU. IOMMU-specifics can probably be handled using .of_xlate(), quite
> >> in a similar way to GPIO or regulators.
> >>
> >> That way drivers can remain agnostic of the IOMMU while still being able
> >> to take advantage of deferred probing.
> > 
> > This could be simpler than making "bus_notifier" return "-EPROBE_DEFER".
> > 
> > The disadvantage of this is that we may need to provide the similar
> > of_<"subsystem">_attach() per subsytem if needed.
> 
> Well, "per subsystem" here means per subsystem that is providing
> resources, not per subsystem that is consuming resources. How many
> subsystems are you expecting to provide resources like this? At present,
> I believe IOMMU is the only subsystem missing some kind of API for
> clients to acquire the relevant resource. I don't think there's any
> scalability problem here.

Honestly I have no idea for other subsystem which needs
of_<"subsystem">_attach(). But IIRC, it's almost similar one to the
following "pinctrl_bind_pins()"? Or something other way?

drivers/base/dd.c:

static int really_probe(struct device *dev, struct device_driver *drv)
{
	int ret = 0;

	atomic_inc(&probe_count);
	pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
		 drv->bus->name, __func__, drv->name, dev_name(dev));
	WARN_ON(!list_empty(&dev->devres_head));

	dev->driver = drv;

	/* If using pinctrl, bind pins now before probing */
	ret = pinctrl_bind_pins(dev);
              ^^^^^^^^^^^^^^^^^^^^^^^
