From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 8/8] arm: dma-mapping: plumb our iommu mapping ops
	into arch_setup_dma_ops
Date: Tue, 20 Jan 2015 15:19:11 +0000
Message-ID: <20150120151910.GD1549@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<1984907.uTqFPJnJpV@avalon> <20150119123058.GA7312@ulmo.nvidia.com>
	<2060841.mOvatXFir7@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2060841.mOvatXFir7@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 20, 2015 at 03:14:01PM +0000, Laurent Pinchart wrote:
> On Monday 19 January 2015 13:31:00 Thierry Reding wrote:
> > On Mon, Jan 19, 2015 at 01:34:24PM +0200, Laurent Pinchart wrote:
> > > On Monday 19 January 2015 11:12:02 Will Deacon wrote:
> > >> On Sun, Jan 18, 2015 at 11:18:51AM +0000, Laurent Pinchart wrote:
> > >>> On Sunday 18 January 2015 15:54:34 Alexandre Courbot wrote:
> > >>>> On 01/16/2015 08:18 AM, Laurent Pinchart wrote:
> > >>>>> On Thursday 15 January 2015 11:12:17 Will Deacon wrote:
> 
> [snip]
> 
> > >>>> I am arriving late in this discussion, but what is wrong with asking
> > >>>> drivers to explicitly state that they want the DMA API to be backed
> > >>>> by the IOMMU instead of forcibly making it work that way?
> > >>> 
> > >>> The vast majority of the drivers are not IOMMU-aware. We would thus
> > >>> need to add a call at the beginning of the probe function of nearly
> > >>> every driver that can perform DMA to state that the driver doesn't need
> > >>> to handle any IOMMU that might be present in the system itself. I don't
> > >>> think that's a better solution.
> > >>> 
> > >>> Explicitly tearing down mappings in drivers that want to manage IOMMUs
> > >>> isn't a solution I like either. A possibly better solution would be to
> > >>> call a function to state that the DMA mapping API shouldn't not handle
> > >>> IOMMUs. Something like
> > >>> 
> > >>> 	dma_mapping_ignore_iommu(dev);
> > >>> 
> > >>> at the beginning of the probe function of such drivers could do. The
> > >>> function would perform behind the scene all operations needed to tear
> > >>> down everything that shouldn't have been set up.
> > >> 
> > >> An alternative would be to add a flag to platform_driver, like we have
> > >> for "prevent_deferred_probe" which is something like
> > >> "prevent_dma_configure".
> > > 
> > > That's a solution I have proposed (albeit as a struct device_driver field,
> > > but that's a small detail), so I'm fine with it :-)
> > 
> > I think Marek had proposed something similar initially as well. I don't
> > see an immediate downside to that solution. It's still somewhat ugly in
> > that a lot of stuff is set up before it's known to actually be used at
> > all, but it seems like there's some consensus that this can be improved
> > later on, so I have no objections to such a patch.
> > 
> > Of course that doesn't solve the current breakage for the Rockchip DRM
> > and OMAP ISP drivers.
> 
> And, as I came to realize after a long bisect yesternight, the Renesas IPMMU 
> driver :-/ Basically any platform that relied on arm_iommu_attach_device() to 
> set the IOMMU DMA ops is now broken.

We could restore the set_dma_ops call in arm_iommu_attach_device as a
temporary hack (along with a big fat comment), since arch_setup_dma_ops
actually sets the ops correct *after* the call to
arm_get_iommu_dma_map_ops...

It doesn't provide any motivation for people to consider moving over to the
new framework, but it fixes the current issues affecting mainline.

Will
