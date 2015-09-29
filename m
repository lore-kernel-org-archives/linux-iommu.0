From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] iommu: Add range flush operation
Date: Tue, 29 Sep 2015 17:27:12 +0100
Message-ID: <560ABBE0.8020805@arm.com>
References: <1443504379-31841-1-git-send-email-tfiga@chromium.org>
 <560A9E36.9030903@arm.com> <20150929143241.GI21513@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150929143241.GI21513-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Nicolas Iooss <nicolas.iooss_linux-oWGTIYur0i8@public.gmane.org>, Vince Hsu <vince.h-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 29/09/15 15:32, Russell King - ARM Linux wrote:
> On Tue, Sep 29, 2015 at 03:20:38PM +0100, Robin Murphy wrote:
>> A single callback doesn't really generalise well enough: If we wanted to
>> implement this in the ARM SMMU drivers to optimise the unmap() case [ask
>> Will how long he spends waiting for a software model to tear down an entire
>> VFIO domain invalidating one page at a time ;)], then we'd either regress
>> performance in the map() case with an unnecessary TLB flush, or have to do a
>> table walk in every flush() call to infer what actually needs doing.
>
> And this is the problem of frameworks.  They get in the way of doing
> things efficiently.
>
> Fine, we have the DMA ops, and that calls a map_sg() method.  What we
> then need is to have a series of standardised library functions which
> can be called to perform various actions.
> Consider this: an IOMMU driver gets the raw scatterlist which the
> driver passed.  The IOMMU driver walks the scatterlist, creating the
> IOMMU side mapping, and writing the device DMA addresses and DMA lengths
> to the scatterlist, possibly coalescing some of the entries.  It
> remembers the number of scatterlist entries that the DMA operation now
> requires.  The IOMMU code can setup whatever mappings it wants using

... and making that elided "setup whatever mappings it wants" step more 
efficient is the sole thing that this patch set is trying to address. I 
apologise for not really following what you're getting at here.

> whatever sizes it wants to satisfy the requested scatterlist.
>
> It then goes on to call the arch backend with the original scatterlist,
> asking it to _only_ deal with the CPU coherency for the mapping.  The
> arch code walks the scatterlist again, this time dealing with the CPU
> coherency part.
>
> Finally, the IOMMU code returns the number of DMA scatterlist entries.
>
> When it comes to tearing it down, it's a similar operation to the above,
> except reversing those actions.
>
> The only issue with this approach is that it opens up some of the cache
> handling to the entire kernel, and that will be _too_ big a target for
> idiotic driver writers to think they have permission to directly use
> those interfaces.  To solve this, I'd love to be able to have the linker
> link together certain objects in the kernel build, and then convert some
> global symbols to be local symbols, thus denying access to functions that
> driver authors have no business what so ever touching.
>
>> Personally I think it would be nicest to have two separate callbacks, e.g.
>> .map_sync/.unmap_sync, but at the very least some kind of additional
>> 'direction' kind of parameter would be necessary.
>
> No, not more callbacks - that's the framework thinking, not the library
> thinking.

Eh, swings and roundabouts. An argument denoting whether the flush is 
being called on the map or unmap path would be fine, it just means some 
implementations will be doing an extra no-op function call half the 
time. On closer inspection, the code in patch 3 _is_ using a table walk 
to figure out if the IOVA has been mapped or unmapped, it just happens 
that this particular implementation needs to do that walk anyway to sync 
the PTE updates, so gets away with it.

Robin.
