From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 06/14] ARM: EXYNOS: add System MMU definition to DT
Date: Thu, 17 Jan 2013 16:39:41 +0000
Message-ID: <20130117163941.GL3699@mudshark.cambridge.arm.com>
References: <003601cdd790$082a1310$187e3930$%cho@samsung.com>
	<20130116115114.GB16543@mudshark.cambridge.arm.com>
	<20130116.184321.179736289870581833.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130116.184321.179736289870581833.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "subash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <subash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "sanghyun75.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <sanghyun75.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XWGXanvQGlWp@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Hiroshi,

On Wed, Jan 16, 2013 at 04:43:21PM +0000, Hiroshi Doyu wrote:
> Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote @ Wed, 16 Jan 2013 12:51:14 +0100:
> > Given that this information is not discoverable, it needs to be encoded
> > in the device tree, but where? I can see two approaches:
> > 
> >   1. For each IOMMU node, list phandles to the devices connected to it
> >      and have a corresponding list of StreamIDs.
> > 
> > or
> > 
> >   2. For each device wishing to use an IOMMU, have a phandle to the
> >      IOMMU node and a separate StreamID property. The IOMMU would then
> >      parse this information when the device is added to the bus.
> > 
> > Although I prefer the second approach, it has the downside of affecting
> > all device bindings that wish to use an IOMMU, so I'm open to any other
> > ideas.
> 
> Actually the above summarize tegra SMMU situation well too. For
> example, each IOMMU'able device has IOVA constraint that some of the
> address area isn't available because of its MMIO. This info needs to
> be described in DT. If <IOMMU phandle> + some parametes are embedded
> in a device node, that info could be dealt at a bus notifier(*1).
> 
> *1: http://lists.linuxfoundation.org/pipermail/iommu/2012-November/004934.html

I've been thinking about this a bit more and, unfortunately, my conclusion
is that method (2) above is problematic, so we do need something similar to
(1).

The reason for this comes about when dealing with chained IOMMUs. In this
case, each IOMMU in the chain needs to know about all of the masters hanging
beneath it (potentially behind other IOMMUs) but may also need to supplement
each device with additional data relevant to that point in the IOMMU chain.
In the case of the ARM System MMU, this could be StreamID information (as
the StreamID for a device can change as the transaction stream passes
through an SMMU) and for your case it could be that the DMA window is
widened along the chain.

So, extending the mmu-master property described in this thread to be
"mmu-masters : a list of phandles to device nodes representing bus masters
for which the IOMMU can provide a translation" is probably a good start.

Will
