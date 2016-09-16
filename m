From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCHv9 0/6] dmaengine: rcar-dmac: add iommu support for slave
	transfers
Date: Fri, 16 Sep 2016 16:01:27 +0300
Message-ID: <37825584.xpDRDpS72S@avalon>
References: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se>
	<1757972.L4qX7sAfEW@avalon>
	<cea119f1-18d5-675d-ee33-c22b0c8e7693@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cea119f1-18d5-675d-ee33-c22b0c8e7693-5wv7dgnIgG8@public.gmane.org>
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
Cc: hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Friday 16 Sep 2016 13:49:21 Robin Murphy wrote:
> On 16/09/16 13:05, Laurent Pinchart wrote:
> [...]
> 
> >>>> One concern I have is that we might get an awkward situation if we ever
> >>>> encounter one DMA engine hardware that is used in different systems
> >>>> that all have an IOMMU, but on some of them the connection between the
> >>>> DMA master and the slave FIFO bypasses the IOMMU while on others the
> >>>> IOMMU is required.
> >>> 
> >>> Do you mean systems where some of the channels of a specific DMA engine
> >>> go through the IOMMU while others do not ? We indeed have no solution
> >>> today for such a situation.
> >>> 
> >>> The problem is a bit broader than that, we'll also have an issue with
> >>> DMA engines that have different channels served by different IOMMUs. I
> >>> recall discussing this in the past with you, and the solution you
> >>> proposed was to add a channel index to struct dma_attrs seems good to
> >>> me. To support the case where some channels don't go through an IOMMU we
> >>> would only need support for null entries in the IOMMUs list associated
> >>> with a device (for instance in the DT case null entries in the iommus
> >>> property).
> >> 
> >> I think at that point we just create the channels as child devices of
> >> the main dmaengine device so they each get their own DMA ops, and can do
> >> whatever. The Qualcomm HIDMA driver already does that for a very similar
> >> reason (so that the IOMMU can map individual channels into different
> >> guest VMs).
> > 
> > That's another option, but it seems more like a workaround to me, instead
> > of a proper solution to fix the more global problem of multiple memory
> > paths within a single device. I have other hardware devices that can act
> > as bus masters through different paths (for instance a display-related
> > device that fetches data and commands through different paths). Luckily
> > so far all those paths are served by the same IOMMU, but there's no
> > guarantee this will remain true in the future. Furthermore, even today,
> > the IOMMU connected to that device has the ability to selectively enable
> > and disable its ports. I have to keep them all enabled due to the lack of
> > channel information in the DMA mapping and IOMMU APIs, leading to
> > increased power consumption.
> 
> Indeed, I think both the Exynos and Rockchip IOMMU drivers already do
> cater for a device mastering though multiple discrete IOMMUs, not being
> the fancy multi-port multi-context ones like yours and mine.
> 
> I guess what we could really do with is a decent abstraction of
> multi-master peripherals at the device level; a "threads within the same
> process" sort of granularity, as it were. I'd envisage it more along the
> lines of how we handle NUMA, i.e. dma_map_page_attrs(...) becomes a
> wrapper for dma_map_page_attrs_multi(..., CHANNEL_ALL), and trickier
> users can call the latter with the a more specific channel(s) argument
> (maybe it's a bitmask rather than an index).

That's pretty much what I've discussed with Arnd in the past, except that we 
were planning to add the channel to struct dma_attrs. Hence my disappointment 
seeing the structure go away.

> Meanwhile, dev->archdata.dma_ops may point to a device-specific array of
> dma_map_ops, which the DMA API backend iterates over if necessary.
> 
> Strangely, that doesn't actually sound too horrible.

-- 
Regards,

Laurent Pinchart
