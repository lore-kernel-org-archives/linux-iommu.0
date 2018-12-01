From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH] dma-debug: Kconfig for PREALLOC_DMA_DEBUG_ENTRIES
Date: Sat, 1 Dec 2018 17:36:57 +0100
Message-ID: <20181201163657.GA19557@lst.de>
References: <20181130175449.2625-1-cai@gmx.us>
	<b22d2ad6-2638-96d7-1df2-24701589202f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b22d2ad6-2638-96d7-1df2-24701589202f-5wv7dgnIgG8@public.gmane.org>
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
Cc: Qian Cai <cai-0UDz38MK/Mo@public.gmane.org>, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, yisen.zhuang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 30, 2018 at 07:39:50PM +0000, Robin Murphy wrote:
> I was assuming the point was to also add something like
>
> 	default 131072 if HNS_ENET
>
> so that DMA debug doesn't require too much thought from the user. If they 
> still have to notice the overflow message and empirically figure out a 
> value that does work, rebuilding the kernel each time is far less 
> convenient than simply adding "dma_debug_entries=..." to their kernel 
> command line and rebooting, which they can do today. If they do already 
> know up-front that the default will need overriding and what the 
> appropriate value is, then the command line still seems seems just as 
> convenient.

I'm not so fond of random drivers changing the defaults.  My idea
was rather to have the config option so that the defconfig files for
the Hisilicon SOCs with this hardware could select a larger number
without making a total mess of the kernel configuration.

If we really have to we could do different defaults, but I'd still
much rather do this on a arch/platform basis than specific drivers.
