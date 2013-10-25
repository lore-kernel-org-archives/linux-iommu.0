From: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv3 01/19] [HACK] of: dev_node has struct device pointer
Date: Fri, 25 Oct 2013 01:12:08 +0100
Message-ID: <20131025001208.C239FC403B6@trevor.secretlab.ca>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com><1382092020-13170-2-git-send-email-hdoyu@nvidia.com><20131024085531.680A4C4039D@trevor.secretlab.ca> <20131024.122115.1035609747068925560.hdoyu@nvidia.com> <3E007970-C2E3-4A2E-B2E3-8388DB7A98F9@codeaurora.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3E007970-C2E3-4A2E-B2E3-8388DB7A98F9-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 24 Oct 2013 04:36:30 -0500, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> 
> On Oct 24, 2013, at 4:21 AM, Hiroshi Doyu wrote:
> 
> > Hi Grant,
> > 
> > Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote @ Thu, 24 Oct 2013 10:55:31 +0200:
> > ....
> >>> diff --git a/include/linux/of.h b/include/linux/of.h
> >>> index f95aee3..638a88a 100644
> >>> --- a/include/linux/of.h
> >>> +++ b/include/linux/of.h
> >>> @@ -60,6 +60,7 @@ struct device_node {
> >>> 	struct	kref kref;
> >>> 	unsigned long _flags;
> >>> 	void	*data;
> >>> +	struct device *dev;		/* Set only after populated */
> >> 
> >> Is this being used merely to indicate that a device has been processed
> >> by of_platform_device_create()? Or do you intend to dereference this
> >> pointer? I've avoided putting the struct device in to the device_node
> >> structure up to this point simply becuase there aren't any good clues
> >> for what /kind/ of device it actually points to. I worry that bad
> >> assumptions will get made when other subsystems try to use the
> >> same pointer. ie. if one subsystem creates its own device and sets this
> >> pointer, and then of_platform_device_create() comes along behind, sees
> >> that it is already created, and then returns a platform_device pointer
> >> *for something that isn't a struct platform_device*. This is very bad.
> >> 
> >> Instead of using a pointer to the struct device, would a flag be
> >> sufficient for your purposes? Would it be fine to return NULL if the
> >> device has already been created?
> > 
> > Yes, a flag would be enough for this purpose.
> > 
> > This patch is a part of HACK to control device instanciation order. We
> > have an IOMMU device(platform) which needs to be instanciated earlier
> > than other (platform)devices so that IOMMU driver would configure them
> > as IOMMU'able device.
> > 
> > Is there any better way to control device instanciation order from DT?
> 
> I was also thinking being able to call of_platform_populate multiple times and have explicit lists to control device init order might be a workable solution.  So might be worth continuing down this path to make device nodes that have already be created.

Does that actually solve the problem though? If the multiple calls to
of_platform_populate are all before the driver initcall, then the order
of probing is most likely going to be more influenced by kernel link
order.

g.
