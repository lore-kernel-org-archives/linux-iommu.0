From: Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] amd_iommu: IO_PAGE_FAULTs on unity mapped regions during
	amd_iommu_init()
Date: Thu, 7 Feb 2013 11:49:05 +0100
Message-ID: <20130207104905.GC8945@gmail.com>
References: <1360205603.2615.19.camel@lorien2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1360205603.2615.19.camel@lorien2>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Shuah Khan <shuah.khan-VXdhtT5mjnY@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


* Shuah Khan <shuah.khan-VXdhtT5mjnY@public.gmane.org> wrote:

> When dma_ops are initialized the unity mappings are created. The
> init_device_table_dma() function makes sure DMA from all devices is
> blocked by default. This opens a short window in time where DMA to
> unity mapped regions is blocked by the IOMMU. Make sure this does not
> happen by initializing the device table after dma_ops.
> 
> Reference: http://www.gossamer-threads.com/lists/linux/kernel/1670769
> 
> Signed-off-by: Shuah Khan <shuah.khan-VXdhtT5mjnY@public.gmane.org>
> CC: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org 3.0
> ---
>  arch/x86/kernel/amd_iommu_init.c |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

That file does not exist anymore, it died 2.5+ years ago:

  403f81d8ee53 iommu/amd: Move missing parts to drivers/iommu

Thanks,

	Ingo
