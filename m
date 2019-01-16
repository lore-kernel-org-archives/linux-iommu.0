From: Konrad Rzeszutek Wilk <konrad-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] swiotlb: clear io_tlb_start and io_tlb_end in swiotlb_exit
Date: Wed, 16 Jan 2019 09:57:47 -0500
Message-ID: <20190116145746.GA30966@localhost.localdomain>
References: <20190114201408.12270-1-hch@lst.de>
	<20190114202513.GG32038@char.us.oracle.com>
	<20190114203323.GA11412@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190114203323.GA11412-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Sibren Vasse <sibren-DLwv2wemLo05ZU0pBKPMFg@public.gmane.org>, michel-otUistvHUpPR7s880joybQ@public.gmane.org, freedesktop-DLwv2wemLo05ZU0pBKPMFg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 14, 2019 at 09:33:23PM +0100, Christoph Hellwig wrote:
> On Mon, Jan 14, 2019 at 03:25:13PM -0500, Konrad Rzeszutek Wilk wrote:
> > On Mon, Jan 14, 2019 at 09:14:08PM +0100, Christoph Hellwig wrote:
> > > Otherwise is_swiotlb_buffer will return false positives when
> > > we first initialize a swiotlb buffer, but then free it because
> > > we have an IOMMU available.
> > > 
> > > Fixes: 55897af63091 ("dma-direct: merge swiotlb_dma_ops into the dma_direct code")
> > > Reported-by: Sibren Vasse <sibren-DLwv2wemLo05ZU0pBKPMFg@public.gmane.org>
> > > Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> > > Tested-by: Sibren Vasse <sibren-DLwv2wemLo05ZU0pBKPMFg@public.gmane.org>
> > 
> > Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> 
> Do you want to send this to Linus, or do you want me to pick it up
> through the dma-mapping tree?

I will do it. Thanks!
