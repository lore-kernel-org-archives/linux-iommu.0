From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv5 2/9] driver/core: populate devices in order for IOMMUs
Date: Thu, 21 Nov 2013 11:01:11 +0200
Message-ID: <20131121110111.2a5c3ed92fa0e12efd5dcf44@nvidia.com>
References: <528BD6A7.3030908@wwwdotorg.org>
	<20131120.051708.396722414386125310.hdoyu@nvidia.com>
	<20131120131447.GA8279@ulmo.nvidia.com>
	<20131120.160359.1043627108929095327.hdoyu@nvidia.com>
	<528CE3AB.60806@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <528CE3AB.60806-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 20 Nov 2013 17:30:35 +0100
Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
...
> >>> Does the above mean the following?
> >>>
> >>> int of_iommu_attach(struct device *dev)
> >>> {
> >>> 	int i;
> >>> 	struct of_phandle_args args;
> >>>
> >>> 	of_property_for_each_phandle_with_args(dev->of_node, "iommus",
> >>> 					       "#iommu-cells", i, &args)
> >>> 		if (!args->np->dev->driver)
> >>> 			return -EPROBE_DEFER;
> >>> 	return 0;
> >>> }
> >>
> >> Not quite. The above would only check that a driver was bound to the
> >> device. But if that device isn't an IOMMU then this doesn't help you.
> > 
> > I thought that, as long as a device is a normal one, it's ok to let it
> > go to be populated.
> 
> I don't understand what that means.
> 
> > We only care about that, IOMMU devices comes
> > first, and clients should come later than IOMMUs, for population. In
> > the above if all IOMMUs are not populated, client devices are always
> > deferred. "args->np->dev" always points an IOMMU device in a
> > loop. Otherwise(no "iommus=") it goes out from the loop immediately.
> 
> I'm not sure what that means. Perhaps you're sauying the dev->driver
> isn't set until the driver is probe()d for the device, so if
> dev->driver!=NULL, then we know the driver probed() successfully for it?

Yes

> That does go most of the way, but as Thierry pointed out, it doesn't
> guarantee that the dev->driver is an IOMMU driver, just that it's *some*
> driver. Perhaps this won't actually make any difference in practice, but
> AFAIK, all other subsystems do perform the strict check, so I don't see
> why the IOMMU subsystem shouldn't.

Ok, now I got the one Thierry pointed out. Will implement that.
