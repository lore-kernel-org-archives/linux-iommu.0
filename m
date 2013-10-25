From: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv3 01/19] [HACK] of: dev_node has struct device pointer
Date: Fri, 25 Oct 2013 01:10:38 +0100
Message-ID: <20131025001038.77299C403B6@trevor.secretlab.ca>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com><1382092020-13170-2-git-send-email-hdoyu@nvidia.com><20131024085531.680A4C4039D@trevor.secretlab.ca> <20131024.122115.1035609747068925560.hdoyu@nvidia.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131024.122115.1035609747068925560.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 24 Oct 2013 11:21:15 +0200, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> Hi Grant,
> 
> Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote @ Thu, 24 Oct 2013 10:55:31 +0200:
> ....
> > > diff --git a/include/linux/of.h b/include/linux/of.h
> > > index f95aee3..638a88a 100644
> > > --- a/include/linux/of.h
> > > +++ b/include/linux/of.h
> > > @@ -60,6 +60,7 @@ struct device_node {
> > >  	struct	kref kref;
> > >  	unsigned long _flags;
> > >  	void	*data;
> > > +	struct device *dev;		/* Set only after populated */
> > 
> > Is this being used merely to indicate that a device has been processed
> > by of_platform_device_create()? Or do you intend to dereference this
> > pointer? I've avoided putting the struct device in to the device_node
> > structure up to this point simply becuase there aren't any good clues
> > for what /kind/ of device it actually points to. I worry that bad
> > assumptions will get made when other subsystems try to use the
> > same pointer. ie. if one subsystem creates its own device and sets this
> > pointer, and then of_platform_device_create() comes along behind, sees
> > that it is already created, and then returns a platform_device pointer
> > *for something that isn't a struct platform_device*. This is very bad.
> > 
> > Instead of using a pointer to the struct device, would a flag be
> > sufficient for your purposes? Would it be fine to return NULL if the
> > device has already been created?
> 
> Yes, a flag would be enough for this purpose.
> 
> This patch is a part of HACK to control device instanciation order. We
> have an IOMMU device(platform) which needs to be instanciated earlier
> than other (platform)devices so that IOMMU driver would configure them
> as IOMMU'able device.

Ideally the drivers depending on the IOMMU would return -EPROBE_DEFER if
the IOMMU driver isn't set up so that you don't need to play games with
probe order. Creating certain platform devices early is a really ugly
and fragile solution.

Besides, probe order of device drivers is far more about link order of
the kernel than it is about when of_platform_device_create() is called.
Fiddling with the initcall level on the IOMMU driver (while not
recommended) may very well have the effect you desire.

g.

> 
> Is there any better way to control device instanciation order from DT?
