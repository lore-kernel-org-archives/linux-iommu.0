From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH RFC] dma-direct: Try reallocation with GFP_DMA32 if
	possible
Date: Fri, 20 Apr 2018 11:47:02 +0200
Message-ID: <20180420094702.GA6530@lst.de>
References: <20180416151819.27520-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180416151819.27520-1-tiwai-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 16, 2018 at 05:18:19PM +0200, Takashi Iwai wrote:
> As the recent swiotlb bug revealed, we seem to have given up the
> direct DMA allocation too early and felt back to swiotlb allocation.
> The reason is that swiotlb allocator expected that dma_direct_alloc()
> would try harder to get pages even below 64bit DMA mask with
> GFP_DMA32, but the function doesn't do that but only deals with
> GFP_DMA case.
> 
> This patch adds a similar fallback reallocation with GFP_DMA32 as
> we've done with GFP_DMA.  The condition is that the coherent mask is
> smaller than 64bit (i.e. some address limitation), and neither GFP_DMA
> nor GFP_DMA32 is set beforehand.
> 
> Signed-off-by: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
> 
> ---
> 
> This is a resend of a test patch included in the previous thread
> ("swiotlb: Fix unexpected swiotlb_alloc_coherent() failures").

I like the patch, but as-is it doesn't apply.  Can you resend it against
latest Linus' tree?
