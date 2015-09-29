From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] iommu: Add range flush operation
Date: Tue, 29 Sep 2015 18:13:17 +0100
Message-ID: <560AC6AD.3010307@arm.com>
References: <1443504379-31841-1-git-send-email-tfiga@chromium.org>
 <560A9E36.9030903@arm.com> <20150929143241.GI21513@n2100.arm.linux.org.uk>
 <560ABBE0.8020805@arm.com> <20150929164014.GL21513@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150929164014.GL21513-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Nicolas Iooss <nicolas.iooss_linux-oWGTIYur0i8@public.gmane.org>, Vince Hsu <vince.h-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 29/09/15 17:40, Russell King - ARM Linux wrote:
> On Tue, Sep 29, 2015 at 05:27:12PM +0100, Robin Murphy wrote:
>> Eh, swings and roundabouts. An argument denoting whether the flush is being
>> called on the map or unmap path would be fine,
>
> Sorry, that statement is wrong.  It's not about whether you flush before
> or after the DMA operation.  I'm afraid I'm probably going to tell you
> how to suck eggs here, because I don't think you quite "get it" with
> non-dma-coherent modern CPUs.
>
> Modern CPUs prefetch data into their caches, and they also randomly write
> back data from their caches to memory.  When performing a DMA operation
> from device to memory, you need to do two things with CPU caches which
> aren't coherent:
>
> 1. Before starting the DMA operation, you need to walk over the memory to
>     be mapped, ensuring that any dirty cache lines are written back.  This
>     is to prevent dirty cache lines overwriting data that has already been
>     DMA'd from the device.
>
> 2. After the DMA operation has completed, you need to walk over the
>     memory again, invalidating any cache lines which may have been
>     speculatively loaded from that memory while DMA was running.  These
>     cache lines may have been loaded prior to the DMA operation placing
>     the new data into memory.
>
> So, it's not a before-or-after, you have to always perform write-back
> cache maintanence prior to any DMA operation, and then invalidate cache
> maintanence after the DMA operation has completed for any mapping which
> the DMA may have written to (which means device-to-memory and
> bidirectional mappings.)

Yup, I'm well aware of all that; in fact you and I have already agreed 
elsewhere that we can only really get away with using the streaming DMA 
API to flush IOMMU page table updates _because_ they aren't written back 
to, thus data only ever goes from CPU->IOMMU and we can skip the problem 
of where to put an invalidation; you wrote the tegra-smmu code that does 
this. The coherency of whatever device which made a DMA API call for 
which the IOMMU API is creating/removing a mapping is irrelevant at this 
point - this is the DMA operation within the DMA operation.

None of which has anything to do with the point I raised, which is that 
if iommu_unmap() calls iommu_flush(), I want to issue TLB invalidations, 
but if iommu_map() calls iommu_flush(), I don't.
