From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] iommu: Add range flush operation
Date: Tue, 29 Sep 2015 20:54:19 +0900
Message-ID: <CAAFQd5CPJSnRdd8dtA4f4_GinM3mTBLcdMHVsYzqOr=ezAXs7g@mail.gmail.com>
References: <1443504379-31841-1-git-send-email-tfiga@chromium.org> <20150929092714.GD9460@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150929092714.GD9460-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vince Hsu <vince.h-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Nicolas Iooss <nicolas.iooss_linux-oWGTIYur0i8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 29, 2015 at 6:27 PM, Thierry Reding
<thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> On Tue, Sep 29, 2015 at 02:25:23PM +0900, Tomasz Figa wrote:
> > Currently the IOMMU subsystem provides 3 basic operations: iommu_map(),
> > iommu_map_sg() and iommu_unmap(). iommu_map() can be used to map memory
> > page by page, however it involves flushing the caches (CPU and IOMMU) for
> > every mapped page separately, which is unsuitable for use cases that
> > require low mapping latency. Similarly iommu_unmap(), even though it
> > takes a full IOVA range as its argument, performs unmapping in a page
> > by page manner.
> >
> > To make mapping operation more suitable for such use cases, iommu_map_sg()
> > and .map_sg() callback in iommu_ops struct were introduced, which allowed
> > particular IOMMU drivers to directly iterate over SG entries, create
> > necessary mappings and flush everything in one go.
> >
> > This approach, however, has two drawbacks:
> >  1) it does not do anything about unmap performance,
> >  2) it requires each driver willing to have fast map to implement its
> >     own SG iteration code, even though this is a mostly generic operation.
> >
> > This series tries to mitigate the two issues above, while acknowledging
> > the fact that the .map_sg() callback might be still necessary for some
> > specific platforms, which could have the need to iterate over SG elements
> > inside driver code. Proposed solution introduces a new .flush() callback,
> > which expects IOVA range as its argument and is expected to flush all
> > respective caches (be it CPU, IOMMU TLB or whatever) to make the given
> > IOVA area mapping change visible to IOMMU clients. Then all the 3 basic
> > map/unmap operations are modified to call the .flush() callback at the end
> > of the operation.
> >
> > Advantages of proposed approach include:
> >  1) ability to use default_iommu_map_sg() helper if all the driver needs
> >     for performance optimization is batching the flush,
> >  2) completely no effect on existing code - the .flush() callback is made
> >     optional and if it isn't implemented drivers are expected to do
> >     necessary flushes on a page by page basis in respective (un)mapping
> >     callbakcs,
> >  3) possibility of exporting the iommu_flush() operation and providing
> >     unsynchronized map/unmap operations for subsystems with even higher
> >     requirements for performance (e.g. drivers/gpu/drm).
>
> That would require passing in some sort of flag that the core shouldn't
> be flushing itself, right? Currently it would flush on every map/unmap.
>

Are you asking about 3) in particular? If so, I was thinking about
iommu_map_noflush(), iommu_unmap_noflush(), which could be then
wrapped by iommu_map() with call to iommu_flush() added at the end.

>
> >
> > The series includes a generic patch implementing necessary changes in
> > IOMMU API and two Tegra-specific patches that demonstrate implementation
> > on driver side and which can be used for further testing.
> >
> > Last, but not least, some performance numbers on Tegra210:
> > +-----------+--------------+-------------+------------+
> > | Operation | Size [bytes] | Before [us] | After [us] |
> > +-----------+--------------+-------------+------------+
> > | Map       | 128K         |         139 |         40 |
> > |           |              |         136 |         34 |
> > |           |              |         137 |         38 |
> > |           |              |         136 |         36 |
> > |           | 4M           |        3939 |       1163 |
> > |           |              |        3730 |       2389 |
> > |           |              |        3613 |        997 |
> > |           |              |        3622 |       1620 |
> > |           | ~18M         |       18635 |       4741 |
> > |           |              |       19261 |       6550 |
> > |           |              |       18473 |       9304 |
> > |           |              |       18125 |       5120 |
> > | Unmap     | 128K         |         128 |          7 |
> > |           |              |         122 |          8 |
> > |           |              |         119 |         10 |
> > |           |              |         123 |         12 |
> > |           | 4M           |        3829 |        151 |
> > |           |              |        3964 |        150 |
> > |           |              |        3908 |        145 |
> > |           |              |        3875 |        155 |
> > |           | ~18M         |       18570 |        683 |
> > |           |              |       18473 |        806 |
> > |           |              |       21020 |        643 |
> > |           |              |       21764 |        652 |
> > +-----------+--------------+-------------+------------+
> > The values are obtained by surrounding the calls to iommu_map_sg()
> > (with default_iommu_map_sg() helper used as .map_sg() callback) and
> > iommu_unmap() with ktime-based time measurement code. Taken 4 samples
> > of every buffer size. ~18M means around 17-19M due do the variance
> > in requested buffer sizes.
>
> Those are pretty impressive numbers.

I was surprised myself that there is so much difference on this
platform, but it seems to converge with downstream kernel. Moreover we
can supposedly get even better results by simply invalidating full TLB
above some length threshold.

Best regards,
Tomasz
