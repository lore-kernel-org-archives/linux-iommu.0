From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH URGENT] arm: dma-mapping: Set DMA IOMMU ops in
	arm_iommu_attach_device()
Date: Wed, 28 Jan 2015 01:25:35 +0100
Message-ID: <2085044.xTrZHjchoH@diego>
References: <1422022909-31044-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422022909-31044-1-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Arnd, Olof,

Am Freitag, 23. Januar 2015, 16:21:49 schrieb Laurent Pinchart:
> Commit 4bb25789ed28228a ("arm: dma-mapping: plumb our iommu mapping ops
> into arch_setup_dma_ops") moved the setting of the DMA operations from
> arm_iommu_attach_device() to arch_setup_dma_ops() where the DMA
> operations to be used are selected based on whether the device is
> connected to an IOMMU. However, the IOMMU detection scheme requires the
> IOMMU driver to be ported to the new IOMMU of_xlate API. As no driver
> has been ported yet, this effectively breaks all IOMMU ARM users that
> depend on the IOMMU being handled transparently by the DMA mapping API.
> 
> Fix this by restoring the setting of DMA IOMMU ops in
> arm_iommu_attach_device() and splitting the rest of the function into a
> new internal __arm_iommu_attach_device() function, called by
> arch_setup_dma_ops().
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

in the original submission arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org was not included, but it looks like 
the patch should go through arm-soc.

We have two tags
	Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
	Tested-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>

Can you find the original patch somehow or should it be resend to include 
arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org ?


Thanks
Heiko
