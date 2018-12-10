From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH v3 5/7] x86/dma/amd-gart: Stop resizing dma_debug_entry
	pool
Date: Mon, 10 Dec 2018 22:26:30 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1812102226140.1667@nanos.tec.linutronix.de>
References: <cover.1544447601.git.robin.murphy@arm.com>
	<a967f11a3a4a862287c7dc180946df0067bdcf80.1544447601.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <a967f11a3a4a862287c7dc180946df0067bdcf80.1544447601.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, cai-0UDz38MK/Mo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, hch-jcswGhMUV9g@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 10 Dec 2018, Robin Murphy wrote:

> dma-debug is now capable of adding new entries to its pool on-demand if
> the initial preallocation was insufficient, so the IOMMU_LEAK logic no
> longer needs to explicitly change the pool size. This does lose it the
> ability to save a couple of megabytes of RAM by reducing the pool size
> below its default, but it seems unlikely that that is a realistic
> concern these days (or indeed that anyone is actively debugging AGP
> drivers' DMA usage any more). Getting rid of dma_debug_resize_entries()
> will make room for further streamlining in the dma-debug code itself.
> 
> Removing the call reveals quite a lot of cruft which has been useless
> for nearly a decade since commit 19c1a6f5764d ("x86 gart: reimplement
> IOMMU_LEAK feature by using DMA_API_DEBUG"), including the entire
> 'iommu=leak' parameter, which controlled nothing except whether
> dma_debug_resize_entries() was called or not.
> 
> CC: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> CC: Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> CC: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
> CC: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
> CC: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
> Reviewed-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Acked-by: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
