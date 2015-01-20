From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v6 8/8] arm: dma-mapping: plumb our iommu mapping ops into
	arch_setup_dma_ops
Date: Tue, 20 Jan 2015 15:47:30 +0200
Message-ID: <1529759.XStvaeMLn3@avalon>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<2253719.6TRpaaEdiI@wuerfel>
	<20150119162111.GA7751@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150119162111.GA7751-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Thierry,

On Monday 19 January 2015 17:21:14 Thierry Reding wrote:
> On Mon, Jan 19, 2015 at 04:52:41PM +0100, Arnd Bergmann wrote:
> > On Monday 19 January 2015 13:36:24 Thierry Reding wrote:
> >> On Fri, Jan 16, 2015 at 01:18:21AM +0200, Laurent Pinchart wrote:
> >>> On Thursday 15 January 2015 11:12:17 Will Deacon wrote:
> >>>> On Thu, Jan 15, 2015 at 08:28:44AM +0000, Thierry Reding wrote:

[...]

> >>>>> The solution for me has been to completely side-step the issue and
> >>>>> not register the IOMMU with the new mechanism at all. That is,
> >>>>> there's no .of_xlate() implementation, which means that the ARM
> >>>>> DMA API glue won't try to be smart and use the IOMMU in ways it's
> >>>>> not meant to be used.
> >>> 
> >>> That will break when someone will want to use the same IOMMU type for
> >>> devices that use the DMA mapping API to hide the IOMMU. That might
> >>> not be the case for your IOMMU today, but it's pretty fragile, we
> >>> need to fix it.
> >> 
> >> No, there's absolutely no issue here. It simply means that you can't do
> >> this on Tegra. So far I'm not sure I even see an advantage in using the
> >> IOMMU for devices that don't care about it anyway. Consider the example
> >> of the SD/MMC or HDA. They typically allocate fairly small buffers, the
> >> order of a single page typically. They can simply use memory handed out
> >> by the CMA.
> >> 
> >> So as long as we don't add a .of_xlate() implementation or instantiate
> >> via the IOMMU_OF_DECLARE() mechanism we simply don't support IOMMU-over-
> >> DMA on Tegra.
> > 
> > It breaks as soon as you have a system with memory above the 4GB boundary,
> > which is the whole point of iommus for most users.
> 
> Why does it break? The IOMMU API simply gets a list of pages and gets
> the physical addresses from those pages when it maps them to the IO
> virtual addresses. How is .of_xlate() or of_iommu_configure() related?

Arnd's point was that using the IOMMU for devices that deal with small buffers 
is mandatory in case those devices only support a 32-bit DMA address space, 
and the system has memory over 4GB that you want to use for DMA purpose. 
That's the case of Renesas' platforms with LPAE support for instance.

Another use case for IOMMUs is device isolation, which is, depending on your 
use cases, something you might want for devices that are not IOMMU-aware.

It should also be noted that even DRM drivers don't need to be explicit IOMMU 
users. The rcar-du driver allocates large frame buffers through the DMA 
mapping API, without caring about whether an IOMMU is present or not.

> > CMA does not work for streaming mappings, only for the coherent API.
> 
> Why not? And if it doesn't I'm not sure we currently care on Tegra since
> we've gotten away with using CMA just fine so far.

-- 
Regards,

Laurent Pinchart
