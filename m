From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH 02/20] kernel/dma/direct: refine dma_direct_alloc zone
	selection
Date: Thu, 23 Aug 2018 07:26:04 +0200
Message-ID: <20180823052604.GB14388@lst.de>
References: <20180730163824.10064-1-hch@lst.de>
	<20180730163824.10064-3-hch@lst.de>
	<7177553cdb5cd1b968f653a52d7e88bd71aae4d8.camel@kernel.crashing.org>
	<20180822065856.GC19284@lst.de>
	<d9866d44704073ecc418f62da0ba7587ce7c9af8.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d9866d44704073ecc418f62da0ba7587ce7c9af8.camel-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Aug 23, 2018 at 10:01:45AM +1000, Benjamin Herrenschmidt wrote:
> > The general scheme that architectures should implement is:
> > 
> > ZONE_DMA:	Any memory below a magic threshold that is lower than
> > 		32-bit.  Only enabled if actually required (usually
> > 		either 24-bit for ISA, or some other weird architecture
> > 		specific value like 32-bit for S/390)
> 
> It should have been ZONE_ISA_DMA :-)

For most of these use cases it should have been indeed, and that
would avoid a lot of confusion where people use GFP_DMA just because
they do DMA.

Anyway, switching powerpc to this scheme would be great, but I don't
think it is required - GFP_KERNEL will silently fall back to ZONE_DMA,
so except for an additional GFP_DMA fallback allocation when the
GFP_KERNEL one fails the code should just work.
