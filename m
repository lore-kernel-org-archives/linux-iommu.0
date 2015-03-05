From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 0/5] arm64: IOMMU-backed DMA mapping
Date: Thu, 05 Mar 2015 15:31:04 +0100
Message-ID: <54F868A8.7070103@samsung.com>
References: <cover.1421086706.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <cover.1421086706.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello,

On 2015-01-12 21:48, Robin Murphy wrote:
> Hi all,
>
> Whilst it's a long way off perfect, this has reached the point of being
> functional and stable enough to be useful, so here it is. The core
> consists of the meat of the arch/arm implementation modified to remove
> the assumption of PAGE_SIZE pages and ported over to the Intel IOVA
> allocator instead of the bitmap-based one. For that, this series depends
> on my "Genericise the IOVA allocator" series posted earlier[1].

I've tested your patches on Exynos 5433 based system and I have a few
comments. To get them working I had to do some fixes. Most of them
are already reported in this thread, the remaining I will send in a few
minutes.

Do you plan to send an updated patchset?

> There are plenty of obvious things still to do, including:
>
>   * Domain and group handling is all wrong, but that's a bigger problem.
>     For the moment it does more or less the same thing as the arch/arm
>     code, which at least works for the one-IOMMU-per-device situation.
>   * IOMMU domains and IOVA domains probably want to be better integrated
>     with devices and each other, rather than having a proliferation of
>     arch-specific structs.
>   * The temporary map_sg implementation - I have a 'proper' iommu_map_sg
>     based one in progress, but since the simple one works it's not been
>     as high a priority.

Well, for ARM arch this was the main feature of IOMMU and DMA-mapping
integration. It is heavily used by some multimedia devices and dma-buf
realted stuff to get a scattered buffer mapped into contiguous IO address
space.

>   * Port arch/arm over to it. I'd guess it might be preferable to merge
>     this through arm64 first, though, rather than overcomplicate matters.

I think that the code in arch/arm is already quite well tested and can be
almost directly reused for common dma-mapping helpers.

>   * There may well be scope for streamlining and tidying up the copied
>     parts - In general I've simply avoided touching anything I don't
>     fully understand.
>   * In the same vein, I'm sure lots of it is fairly ARM-specific, so will
>     need longer-term work to become truly generic.
>
> [1]:http://thread.gmane.org/gmane.linux.kernel.iommu/8208

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
