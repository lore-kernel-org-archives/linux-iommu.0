From: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv3 01/19] [HACK] of: dev_node has struct device pointer
Date: Fri, 25 Oct 2013 20:01:36 +0100
Message-ID: <20131025190136.D55F5C403A7@trevor.secretlab.ca>
References: <20131025075652.GB19622@ulmo.nvidia.com> <20131025.112549.2040849946958069337.hdoyu@nvidia.com> <20131025091104.GG19622@ulmo.nvidia.com> <20131025.124905.1154427805530939055.hdoyu@nvidia.com> <20131025104937.GA25080@ulmo.nvidia.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131025104937.GA25080-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 25 Oct 2013 12:49:38 +0200, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Fri, Oct 25, 2013 at 11:49:05AM +0200, Hiroshi Doyu wrote:
> > Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Fri, 25 Oct 2013 11:11:05 +0200:
> > 
> > > > > This is actually "the other problem that I'm aware of that could benefit
> > > > > from [interrupt resolution at probe time]". My idea was that once we had
> > > > > a way within the driver core to resolve interrupt references at probe
> > > > > time it could be used for potentially many other resources as well. Some
> > > > > of the resources like GPIOs and regulators are obviously not something
> > > > > that the core can or should be requesting, but mostly resources that you
> > > > > don't actually need to control after probing (such as interrupts) would
> > > > > be a good fit because otherwise people would write the same boilerplate
> > > > > over and over again.
> > > > > 
> > > > > IOMMUs seem to me to be in that same category. As far as I can tell, an
> > > > > IOMMU driver registers the IOMMU for a given bus, upon which every
> > > > > device can simply be used (mostly transparently) with that IOMMU. While
> > > > > I haven't figured out how exactly, I'm pretty sure we can take advantage
> > > > > of the resolution of resources at probe time within the core to both
> > > > > keep drivers from having to do anything in particular and at the same
> > > > > time have code to determine if the IOMMU driver hasn't been probed yet
> > > > > and return -EPROBE_DEFER appropriately.
> > > > 
> > > > Can you explain the above a bit more?
> > > > 
> > > > Originally I thought that what Grant suggested would work ok with this
> > > > patch.
> > > 
> > > I think the objection to these patches is that they special case the
> > > instantiation of some devices. It's not a proper solution because it
> > > implies various things. For example merely instantiating the IOMMU
> > > device earlier than others is only going to work *if* the driver is
> > > actually probed before the drivers of other devices. If you want to
> > > build the driver as a module for example, probe order becomes entirely
> > > non-deterministic.
> > 
> > I understand the above limitation. What I thought for the solution is
> > that I can make use of iommu_bus even before IOMMU is
> > instanciated. iommu_bus has its notifier which calls
> > iommu_ops()->add_device(). This could return -EPROBE_DEFER when IOMMU
> > isn't ready. Only the problem is the current "bus_notifier" doesn't
> > have the ability to return error. I'll see if it can be modified. Even
> > with this, at least IOMMU *driver* needs to be init'ed enough earlier
> > to prevent devices from being registered without IOMMU.
> 
> The way notifiers work is that they run completely hidden from whatever
> triggers them. For instance you register the IOMMU bus notifier from the
> IOMMU driver (by calling bus_set_iommu()). That registers a function to
> be called when some event happens on that bus. When a device's driver is
> probed successfully, the driver core will notify the bus, which causes
> the IOMMU callback to be run.
> 
> Some of this code runs before the driver has successfully been probed,
> so I imagine it would be possible to use it to abort probing. But that's
> not possible at least with the current code.
> 
> > > Instead of handling such dependencies implicitly by making sure all
> > > resource providers are probed earlier than any of their consumers, the
> > > dependencies are handled more explicitly, which turns out to simplify
> > > things a lot. There's some additional work required in the core, but if
> > > done consistently no driver needs to care about the dependencies and it
> > > no longer matters where the resources come from. The problem is reduced
> > > to essentially this:
> > > 
> > > 	while (!resource_available())
> > > 		load_more_drivers();
> > > 
> > > So my proposed solution for the IOMMU case is to treat it the same as
> > > any other resources. Perhaps resource isn't the right word, but at the
> > > core the issue is the same. A device requires the services of an IOMMU
> > > so that it can be put into the correct address space. If the IOMMU is
> > > not available yet it cannot do that, so we simply return -EPROBE_DEFER
> > > and cause the probe to be retried later.
> > 
> > This looks somewhat similar to the above iommu_bus notifier.
> > 
> > Is there any way to implement the same mechanism rather than using
> > bus?
> 
> Yes, I think it should be possible to get this to work without using the
> bus notifier at all. I can try to code something up but wanted to wait
> for feedback from Grant first.

I've lost track. What feedback are you waiting for from me? I've not dug
into this entire series so I may not provide clueful feedback.

g.
