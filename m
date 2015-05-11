From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/6] IOMMU/DMA map_resource support for peer-to-peer
Date: Mon, 11 May 2015 10:32:11 -0400
Message-ID: <20150511143211.GE20282@l.oracle.com>
References: <1430505138-2877-1-git-send-email-wdavis@nvidia.com>
	<20150508202134.GB26795@l.oracle.com> <554D2099.2030907@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <554D2099.2030907-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Hounschell <markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, tripperda-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, May 08, 2015 at 04:46:17PM -0400, Mark Hounschell wrote:
> On 05/08/2015 04:21 PM, Konrad Rzeszutek Wilk wrote:
> >On Fri, May 01, 2015 at 01:32:12PM -0500, wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org wrote:
> >>From: Will Davis <wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >>
> >>Hi,
> >>
> >>This patch series adds DMA APIs to map and unmap a struct resource to and from
> >>a PCI device's IOVA domain, and implements the AMD, Intel, and nommu versions
> >>of these interfaces.
> >>
> >>This solves a long-standing problem with the existing DMA-remapping interfaces,
> >>which require that a struct page be given for the region to be mapped into a
> >>device's IOVA domain. This requirement cannot support peer device BAR ranges,
> >>for which no struct pages exist.
> >>
> >>The underlying implementations of map_page and map_sg convert the struct page
> >>into its physical address anyway, so we just need a way to route the physical
> >>address of the BAR region to these implementations. The new interfaces do this
> >>by taking the struct resource describing a device's BAR region, from which the
> >>physical address is derived.
> >>
> >>The Intel and nommu versions have been verified on a dual Intel Xeon E5405
> >>workstation. I'm in the process of obtaining hardware to test the AMD version
> >>as well. Please review.
> >
> >Does it work if you boot with 'iommu=soft swiotlb=force' which will mandate
> >an strict usage of the DMA API?
> >
> 
> PCIe peer2peer is borked on all motherboards I've tried. Only writes are

:-(

> possible. Reads are not supported. I suppose if you have a platform with
> only PCI and an IOMMU this would be very useful. Without both read and write
> PCIe peer2peer support, this seems unnecessary.
> 

It is a perfect way to test the code to make sure the API works (or it
fails in the failure modes) _and_ that the drivers as well (use the
pci_map_sync, and so on).

> Mark
> 
> 
