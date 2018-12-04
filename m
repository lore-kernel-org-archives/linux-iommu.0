From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [RFC 4/4] dma-debug: Make leak-like behaviour apparent
Date: Tue, 4 Dec 2018 15:31:06 +0100
Message-ID: <20181204143106.GD2767@lst.de>
References: <cover.1543856576.git.robin.murphy@arm.com>
	<7ec928f0bd92122f271c421e99aaeb593ccabdf5.1543856576.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7ec928f0bd92122f271c421e99aaeb593ccabdf5.1543856576.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: cai-0UDz38MK/Mo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 03, 2018 at 05:28:09PM +0000, Robin Murphy wrote:
> Now that we can dynamically allocate DMA debug entries to cope with
> drivers maintaining excessively large numbers of live mappings, a driver
> which *does* actually have a bug leaking mappings (and is not unloaded)
> will no longer trigger the "DMA-API: debugging out of memory - disabling"
> message until it gets to actual kernel OOM conditions, which means it
> could go unnoticed for a while. To that end, let's inform the user each
> time the pool has grown to a multiple of its initial size, which should
> make it apparent that they either have a leak or might want to increase
> the preallocation size.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
> 
> Tagging this one as RFC since people might think it's silly.

I think finding out the numbers is useful, but I'm a little worried
about claiming a possible leak.  Maybe we just need to print a log message
for each new power of 2 of entries reached?
