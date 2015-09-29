From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] iommu: Add range flush operation
Date: Tue, 29 Sep 2015 17:40:14 +0100
Message-ID: <20150929164014.GL21513@n2100.arm.linux.org.uk>
References: <1443504379-31841-1-git-send-email-tfiga@chromium.org>
	<560A9E36.9030903@arm.com>
	<20150929143241.GI21513@n2100.arm.linux.org.uk>
	<560ABBE0.8020805@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <560ABBE0.8020805-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vince Hsu <vince.h-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Nicolas Iooss <nicolas.iooss_linux-oWGTIYur0i8@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 29, 2015 at 05:27:12PM +0100, Robin Murphy wrote:
> Eh, swings and roundabouts. An argument denoting whether the flush is being
> called on the map or unmap path would be fine,

Sorry, that statement is wrong.  It's not about whether you flush before
or after the DMA operation.  I'm afraid I'm probably going to tell you
how to suck eggs here, because I don't think you quite "get it" with
non-dma-coherent modern CPUs.

Modern CPUs prefetch data into their caches, and they also randomly write
back data from their caches to memory.  When performing a DMA operation
from device to memory, you need to do two things with CPU caches which
aren't coherent:

1. Before starting the DMA operation, you need to walk over the memory to
   be mapped, ensuring that any dirty cache lines are written back.  This
   is to prevent dirty cache lines overwriting data that has already been
   DMA'd from the device.

2. After the DMA operation has completed, you need to walk over the
   memory again, invalidating any cache lines which may have been
   speculatively loaded from that memory while DMA was running.  These
   cache lines may have been loaded prior to the DMA operation placing
   the new data into memory.

So, it's not a before-or-after, you have to always perform write-back
cache maintanence prior to any DMA operation, and then invalidate cache
maintanence after the DMA operation has completed for any mapping which
the DMA may have written to (which means device-to-memory and
bidirectional mappings.)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
