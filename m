From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH 08/20] powerpc/dma: remove the unused dma_nommu_ops export
Date: Wed, 22 Aug 2018 08:45:31 +0200
Message-ID: <20180822064531.GA19284@lst.de>
References: <20180730163824.10064-1-hch@lst.de>
	<20180730163824.10064-9-hch@lst.de> <20180731121625.GA29793@lst.de>
	<f7daffa5481ab82f345aa5bf9f63f40caa068456.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f7daffa5481ab82f345aa5bf9f63f40caa068456.camel-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
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
Cc: Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Aug 09, 2018 at 10:01:16AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2018-07-31 at 14:16 +0200, Christoph Hellwig wrote:
> > It turns out cxl actually uses it.  So for now skip this patch,
> > although random code in drivers messing with dma ops will need to
> > be sorted out sooner or later.
> 
> CXL devices are "special", they bypass the classic iommu in favor of
> allowing the device to operate using the main processor page tables
> using an MMU context (so basically the device can use userspace
> addresses directly), akin to ATS.
> 
> I think the code currently uses the nommu ops as a way to do a simple
> kernel mapping for kernel drivers using CXL (not userspace stuff)
> though.

Its still a horrible idea to have this in drivers/, we need some
core API to mediate this behavior.  Also if the device supports
using virtual addresses dma_nommu_ops seems wrong as it won't do
the right thing for e.g. vmalloc addresses not mapped into the
kernel linear mapping (which I guess can't currently happen on
powerpc, but still..)
