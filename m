From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH] swiotlb: Fix unexpected swiotlb_alloc_coherent() failures
Date: Thu, 12 Apr 2018 08:02:27 +0200
Message-ID: <20180412060227.GA30248@lst.de>
References: <20180410170513.22834-1-tiwai@suse.de>
	<20180410170615.GA27589@lst.de> <s5hzi2bat25.wl-tiwai@suse.de>
	<40618b9c-786d-7f5f-3f5b-fc1dd8375846@arm.com>
	<20180410181020.GA28565@lst.de> <s5h4lkib3rd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <s5h4lkib3rd.wl-tiwai-l3A5Bk7waGM@public.gmane.org>
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
Cc: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 11, 2018 at 09:28:54AM +0200, Takashi Iwai wrote:
> > But we should try a GFP_DMA32 allocation first, so this is a bit
> > surprising.
> 
> Hm, do we really try that?
> Through a quick glance, dma_alloc_coherent_gfp_flags() gives GFP_DMA32
> only when coherent mask <= DMA_BIT_MASK(32); in the case of iwlwifi,
> it's 36bit, so GFP_DMA isn't set.

Oh, yes - it is using an odd dma mask, and amdgpu seems to use an
just as odd 40-bit dma mask.

> We had a fallback allocation with GFP_DMA32 in the past, but this
> seems gone long time ago along with cleanups (commit c647c3bb2d16).
> 
> But I haven't followed about this topic for long time, so I might have
> missed obviously...

I think a fallback would be much better here rather than relying on the
limited swiotlb buffer bool.  dma_direct_alloc (which in 4.17 is also
used for x86) already has a GFP_DMA fallback, so extending this for
GFP_DMA32 as well would seem reasonable.

Any volunteers?
