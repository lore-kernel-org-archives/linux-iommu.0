From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv3 01/19] [HACK] of: dev_node has struct device pointer
Date: Fri, 1 Nov 2013 11:05:13 +0100
Message-ID: <20131101.120513.982249212095400434.hdoyu@nvidia.com>
References: <52729912.9050800@wwwdotorg.org><20131101084909.5ed79987aa3aeb13b14e3f08@nvidia.com><20131101095223.GH27864@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131101095223.GH27864-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Fri, 1 Nov 2013 10:52:24 +0100:

> * PGP Signed by an unknown key
> 
> On Fri, Nov 01, 2013 at 08:49:09AM +0200, Hiroshi Doyu wrote:
> > On Thu, 31 Oct 2013 18:53:22 +0100
> > Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> > ...
> > > We're talking about memory-mapped on-SoC devices here, that generally
> > > only exist inside Tegra SoCs.
> > > 
> > > Even ignoring that (i.e. expanding the argument to arbitrary modules),
> > > having drivers that perform bus-master transactions call a function
> > > of_iommu_attach() or similar, which does nothing if the device isn't
> > > behind an IOMMU but otherwise does whatever is required, seems like it
> > > isn't much of an imposition.
> > 
> > Where do you expect of_iommu_attach() to be called?
> > I thought something below:
> > 
> > 	Modified drivers/base/dd.c
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index 35fa368..92ec2e9 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -278,6 +278,10 @@ static int really_probe(struct device *dev, struct device_driver *drv)
> >  	if (ret)
> >  		goto probe_failed;
> >  
> > +	ret = of_iommu_attach(dev);
> > +	if (ret)
> > +		goto probe_failed;
> > +
> >  	if (driver_sysfs_add(dev)) {
> >  		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
> >  			__func__, dev_name(dev));
> > 
> 
> The patches for late interrupt reference resolution introduced a
> separate function, of_platform_probe(), with the intent of having it
> call potentially many resource allocation hooks. The function needs to
> be platform_device specific, and therefore is called from within the
> platform_drv_probe() function. The reason is that interrupts are stored
> as resources within struct platform_device, so you need to have access
> to a platform device.

Ok.
Also I think that a special new /section/ with hooks[1] would fit with
this as well.

> I think that devices that require attachment to an IOMMU will always end
> up being platform devices too, so even if it isn't a strict requirement
> here it would still make sense to use a similar infrastructure to avoid
> cluttering the core code with too many loose function calls.

FYI: PCIe devices can also be IOMMU'able although not yet enabled yet.

[1] http://lists.linuxfoundation.org/pipermail/iommu/2013-November/006874.html
