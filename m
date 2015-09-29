From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] iommu: Add range flush operation
Date: Tue, 29 Sep 2015 14:20:05 +0200
Message-ID: <20150929122005.GG3036@8bytes.org>
References: <1443504379-31841-1-git-send-email-tfiga@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1443504379-31841-1-git-send-email-tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vince Hsu <vince.h-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Nicolas Iooss <nicolas.iooss_linux-oWGTIYur0i8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Tomasz,

On Tue, Sep 29, 2015 at 02:25:23PM +0900, Tomasz Figa wrote:
> This series tries to mitigate the two issues above, while acknowledging
> the fact that the .map_sg() callback might be still necessary for some
> specific platforms, which could have the need to iterate over SG elements
> inside driver code. Proposed solution introduces a new .flush() callback,
> which expects IOVA range as its argument and is expected to flush all
> respective caches (be it CPU, IOMMU TLB or whatever) to make the given
> IOVA area mapping change visible to IOMMU clients. Then all the 3 basic
> map/unmap operations are modified to call the .flush() callback at the end
> of the operation. 
> 
> Advantages of proposed approach include:
>  1) ability to use default_iommu_map_sg() helper if all the driver needs
>     for performance optimization is batching the flush,
>  2) completely no effect on existing code - the .flush() callback is made
>     optional and if it isn't implemented drivers are expected to do
>     necessary flushes on a page by page basis in respective (un)mapping
>     callbakcs,
>  3) possibility of exporting the iommu_flush() operation and providing
>     unsynchronized map/unmap operations for subsystems with even higher
>     requirements for performance (e.g. drivers/gpu/drm).

Thanks for the patches, I really like the idea. The VT-d driver probably
also benefits a lot from this.

In the past I also proposed something like this, it was called a new
iommu_commit() API function for making changes from map/unmap visible to
the hardware. But this requires updating all callers first, so your
approach of doing an implicit flush at the end of map/unmap is better.



	Joerg
