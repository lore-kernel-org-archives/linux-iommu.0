From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH 04/13] x86: use generic swiotlb_ops
Date: Mon, 12 Mar 2018 09:26:33 +0100
Message-ID: <20180312082633.GA5724@lst.de>
References: <20180305174655.9878-1-hch@lst.de>
	<20180305174655.9878-5-hch@lst.de>
	<825d4b49-8fa2-e670-75e3-77a88258af3a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <825d4b49-8fa2-e670-75e3-77a88258af3a-5wv7dgnIgG8@public.gmane.org>
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
Cc: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Muli Ben-Yehuda <mulix-BzGcCpaT2IbYtjvyW6yDsg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 08, 2018 at 04:03:12PM +0000, Robin Murphy wrote:
>> Also fix the sta2x11 case.  For that SOC the dma map ops need an
>> additional physical to dma address translations.  For swiotlb buffers
>> that is done throught the phys_to_dma helper, but the sta2x11_dma_ops
>> also added an additional translation on the return value from
>> x86_swiotlb_alloc_coherent, which is only correct if that functions
>> returns a direct allocation and not a swiotlb buffer.  With the
>> generic swiotlb and dma-direct code phys_to_dma is not always used
>> and the separate sta2x11_dma_ops can be replaced with a simple
>> bit that marks if the additional physical to dma address translation
>> is needed.
>
> FWIW, last time I looked I got the impression that STA2x11 could just use 
> dma_pfn_offset - the comments and a2p/p2a logic in sta2x11-fixup.c 
> certainly imply that the underlying hardware situation is pretty much 
> exactly that for which dma_pfn_offset exists.

That probably is the case.  But without access to the hardware I don't
feel like doing this deeper surgery.  And even without that this case
provides a great simplification.
