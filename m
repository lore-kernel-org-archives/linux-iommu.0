From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH] iommu/dma: Add support for DMA_ATTR_FORCE_CONTIGUOUS
Date: Sun, 15 Jan 2017 23:12:49 +0200
Message-ID: <1782501.BR5drHV8iS@avalon>
References: <1484305674-15018-1-git-send-email-geert+renesas@glider.be>
	<CAMuHMdWBfTm_QRuB7x-ZDh0bgGmHokqm7=F2b0rjQTYzizC9hA@mail.gmail.com>
	<0e5c066f-ddf6-30ce-392e-79bd0f401a18@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <0e5c066f-ddf6-30ce-392e-79bd0f401a18-5wv7dgnIgG8@public.gmane.org>
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
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Friday 13 Jan 2017 12:17:24 Robin Murphy wrote:
> On 13/01/17 11:59, Geert Uytterhoeven wrote:
> > On Fri, Jan 13, 2017 at 12:32 PM, Robin Murphy wrote:
> >> On 13/01/17 11:07, Geert Uytterhoeven wrote:
> >>> Add support for DMA_ATTR_FORCE_CONTIGUOUS to the generic IOMMU DMA code.
> >>> This allows to allocate physically contiguous DMA buffers on arm64
> >>> systems with an IOMMU.
> >> 
> >> Can anyone explain what this attribute is actually used for? I've never
> >> quite figured it out.
> > 
> > My understanding is that DMA_ATTR_FORCE_CONTIGUOUS is needed when using
> > an IOMMU but wanting the buffers to be both contiguous in IOVA space and
> > physically contiguous to allow passing to devices without IOMMU.
> > 
> > Main users are graphic and remote processors.
> 
> Sure, I assumed it must be to do with buffer sharing, but the systems
> I'm aware of which have IOMMUs in their media subsystems tend to have
> them in front of every IP block involved, so I was curious as to what
> bit of non-IOMMU hardware wanted to play too. The lone in-tree use in
> the Exynos DRM driver was never very revealing, and the new one I see in
> the Qualcomm PIL driver frankly looks redundant to me.

If two (or more) devices with different memory requirements are involved in 
buffer sharing, we need to either allocate and export buffers from the device 
with the strictest requirements, or to implement a central buffer allocator. 
In any case, I don't think DMA_ATTR_FORCE_CONTIGUOUS is the right solution to 
that problem.

Forcing contiguous allocation can however help with performance optimization, 
as mapping physically contiguous memory through IOMMUs can make use of larger 
page sizes.

-- 
Regards,

Laurent Pinchart
