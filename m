From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: Report from 2013 ARM kernel summit
Date: Fri, 15 Nov 2013 16:06:27 +0900
Message-ID: <20131115070627.6CF65C4079B@trevor.secretlab.ca>
References: <CACxGe6stYhZOc=MfGj8BgtG8zp6eh=jRFGUbFn1SSYRtw+zryA@mail.gmail. com> <20131111.114723.1885845500744256130.hdoyu@nvidia.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131111.114723.1885845500744256130.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "ksummit-2013-discuss-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org" <ksummit-2013-discuss-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "lwn-T1hC0tSOHrs@public.gmane.org" <lwn-T1hC0tSOHrs@public.gmane.org>, "paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org" <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 11 Nov 2013 10:47:23 +0100, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> Missed some MLs. Resending....
> 
> Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote @ Fri, 8 Nov 2013 14:20:46 +0100:
> 
> > Early Init, Deferred Probe and Init Order
> ...
> > The big problem with deferring to initcalls is that the kernel doesn?t
> > have any information about dependencies between devices and so doesn?t
> > know what order to call modules in. Right now driver probe order is
> > roughly determined by kernel link order first, and registration order
> > second for devices populated during or after initcalls. Olof commented
> > that the current driver model is based on the assumption that devices
> > live in a single hierarchy. There is no easy way to add in dependency
> > data with the current structure, and in most cases dependencies aren?t
> > specifically on other devices, but rather on the service provided by
> > another device (ie, a GPIO line).
> 
> I think that an IOMMU device is also the service provider for other
> devices, where an single IOMMU device resides in the bus to provide
> the address translation to the bus children.
> 
> > Kumar is concerned that deferred probe won?t work in all situations. For
> > instance, what about a device that has an optional dependency? Does it
> > fail to probe in the hope that the dependency will show up later? It was
> 
> Other devices don't know if the system has IOMMU or not. IOMMU'able
> devices' population can be deferred till IOMMU device is populated,
> but they don't know if there's really IOMMU device exists or not at
> their population time.

Deferring the population might complicate the common code by changing
the time that devices get created. Right now the code is oriented around
doing it all at once.

However, it would be possible to cause a probe deferal on devices that
requires an IOMMU in a way that it would be triggered by the bus instead
of by the individual device drivers.

I don't really know the details well enough to comment intelliently.
Craft up the patches and see what it looks like.

> > The suggestion was made that it would be a really nice to have the core
> > kernel sort out probe order rather than using deferred probe. Grant
> > replied that deferred probe was designed as the simplest possible
> > solution to the problem, and by no means is he attached to it if someone
> > can come up with a better approach. He did consider other options that
> > put dependency resolution into the core, but it ended up pulling all
> > kinds of GPIO, IRQ, Clock and DMA details into the core which made it
> > quite complex.
> 
> I have a problem to control the poplution order for IOMMU in Tegra
> SoC, and currently I haven't found any framework so that I inserted an
> IOMMU hook in the driver core[1] since I discussed with Stephen Warren
> and we thought that the number of those subsystem which requires this
> kind of control isn't so many. This patch depends on a certain DT
> bindings("#stream-id-cells") if a device has an dependency on IOMMU or
> not. But at least this doesn't require anything for a client driver
> side at all. The exsiting driver can be used as they are. The current
> design is:
> 
> 1, When a device is populated, it checks if that device is IOMMU'able
>    or not. This is identified by "#stream-id-cells" in DT. If
>    a device is normal(non IOMMU), a device is populated. If a device
>    is IOMMU'able, it continues to be checked.
> 
> 2, When an IOMMU device has been already populated,
>    "dev->bus->iommu_ops" is set. If so a device(client) is registered
>    as IOMMU'able, and the rest of population process continues. If not
>    set yet, a device population would be deferred til
>    "dev->bus->iommu_ops" is set.
> 
> 3, After an IOMMU device has been already populated, deferred
>    population will be continued.
> 
> I'm not so sure if this dependecy on "#stream-id-cells" is acceptable
> or not, but I haven't any better idea right now.

It seems a little fragile to me too. I'd rather the IOMMU requirement be
described more explicitly.

g.
