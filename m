From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] swiotlb: Update the comment of swiotlb
Date: Wed, 9 May 2018 10:21:18 -0400
Message-ID: <20180509142118.GA27814@char.us.oracle.com>
References: <1525691185-55657-1-git-send-email-xieyisheng1@huawei.com>
	<20180509073838.GA20874@lst.de>
	<b6246d95-7d9c-2904-6298-9c5ca3506a5f@huawei.com>
	<20180509113957.GA25787@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180509113957.GA25787-jcswGhMUV9g@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, May 09, 2018 at 01:39:57PM +0200, Christoph Hellwig wrote:
> On Wed, May 09, 2018 at 05:08:30PM +0800, Yisheng Xie wrote:
> > Hi Christoph,
> > 
> > On 2018/5/9 15:38, Christoph Hellwig wrote:
> > > Thanks,
> > > 
> > > applied to the dma-mapping tree.
> > 
> > Thanks
> > 
> > BTW, should lib/swiotlb.c also add to DMA MAPPING HELPERS, or
> > add yourself as a maintainer of SWIOTLB SUBSYSTEM ? It will make
> > get_maintainer.pl get you :)
> 
> Konrad is the maintainer, but due to me touching the file a lot
> lately I keep merging the patches for now.  But anything non-trivial
> absolutely requires an Ack from Konrad.

<nods>

Thank you for pulling this in your tree.
