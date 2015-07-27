From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 00/18] Clean up exposure of arch-internal code
Date: Mon, 27 Jul 2015 15:16:54 +0100
Message-ID: <20150727141654.GI7557@n2100.arm.linux.org.uk>
References: <20150727122824.GH7557@n2100.arm.linux.org.uk>
 <20150727140905.GA16858@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150727140905.GA16858-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 27, 2015 at 04:09:06PM +0200, Thierry Reding wrote:
> On Mon, Jul 27, 2015 at 01:28:24PM +0100, Russell King - ARM Linux wrote:
> > This series of patches attempts to clean up the use of architecture
> > internal functions in drivers, and removes some functions from view
> > in the asm/ headers.  I'm also considering whether we need to add
> > some linker magic to hide symbols when building the built-in.o files.
> > 
> > This was triggered by 3rd party drivers "going under the covers" of
> > the DMA API and calling the dmac_*() functions directly, a practice
> > which I have always refused to allow.  This also breaks module
> > building (which is the big hint that they're doing something wrong.)
> > 
> > However, it also came to light that various drivers are using
> > __cpuc_* functions directly, which are non-portable, and is another
> > instance of "going under the covers" and tinkering with what should
> > be kept as architecture implementation details.
> > 
> > This series addresses some of these points.  It:
> > 
> > (a) moves dmac_map_area() and dmac_unmap_area() prototypes out of
> >     asm/cacheflush.h and into arch/arm/mm.
> > (b) provide a secure_flush() call for the Qualcomm secure monitor
> >     code.
> > (c) stop tegra smmu driver(s) from using __cpuc_flush_dcache_area,
> >     something which necessitates additional complexity to deal with
> >     the ARM vs ARM64 differences.  It should be using the DMA API.
> >     However, the Tegra SMMU driver is in really bad shape, and this
> >     isn't a simple conversion - it requires a lot of additional
> >     fixes to bring the code up to scratch.
> 
> Out of curiosity, did you have any hardware to test this on?

Nope - it only got build-tested, and it's partly why there's soo many
incremental small patches.

> I've given
> it a quick spin and haven't seen anything out of the ordinary. I have a
> couple of nitpicks towards the end of the series, but other than that,
> very nice work.

Good news.

> What's the plan for merging this? Should it all go in through Joerg's
> tree so that potentially other driver conversions can go in on top of
> this, or would you prefer to take it through the ARM tree?

I don't mind the series being split - there's nothing dependent between
the individual drivers, so all the Tegra SMMU stuff can go through
Joerg's tree if that'll be easiest.

> > It leaves the Rockchip IOMMU driver for the time being, but that is also
> > something which needs cleaning up in the same way as the Tegra SMMU
> > driver.
> 
> From a cursory look, MSM, OMAP and Exynos are in the same boat as well.

Yes.  There is a question here though:

Is it a good idea to use normal cacheable memory for the IOMMU page table
entries, or would DMA coherent memory be better?

If the latter, then we don't need to do any cache maintanence of the
tables, and all the hacks can go.  If the former, using the streaming
DMA API in all IOMMU drivers would be a good idea, like Tegra SMMU now
does as a result of these patches.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
