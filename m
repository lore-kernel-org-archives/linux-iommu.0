From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH URGENT] arm: dma-mapping: Set DMA IOMMU ops in
	arm_iommu_attach_device()
Date: Thu, 29 Jan 2015 10:57:25 -0800
Message-ID: <20150129185725.GA18628@quad.lixom.net>
References: <1422022909-31044-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<2085044.xTrZHjchoH@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2085044.xTrZHjchoH@diego>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 28, 2015 at 01:25:35AM +0100, Heiko St=FCbner wrote:
> Hi Arnd, Olof,
> =

> Am Freitag, 23. Januar 2015, 16:21:49 schrieb Laurent Pinchart:
> > Commit 4bb25789ed28228a ("arm: dma-mapping: plumb our iommu mapping ops
> > into arch_setup_dma_ops") moved the setting of the DMA operations from
> > arm_iommu_attach_device() to arch_setup_dma_ops() where the DMA
> > operations to be used are selected based on whether the device is
> > connected to an IOMMU. However, the IOMMU detection scheme requires the
> > IOMMU driver to be ported to the new IOMMU of_xlate API. As no driver
> > has been ported yet, this effectively breaks all IOMMU ARM users that
> > depend on the IOMMU being handled transparently by the DMA mapping API.
> > =

> > Fix this by restoring the setting of DMA IOMMU ops in
> > arm_iommu_attach_device() and splitting the rest of the function into a
> > new internal __arm_iommu_attach_device() function, called by
> > arch_setup_dma_ops().
> > =

> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.=
com>
> =

> in the original submission arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org was not included, but it looks =
like =

> the patch should go through arm-soc.
> =

> We have two tags
> 	Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> 	Tested-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
> =

> Can you find the original patch somehow or should it be resend to include =

> arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org ?

The patch was posted on a list that I am subscribed to, so it popped up in
the same thread this time. I've applied it to fixes for 3.19.

Thanks,

-Olof
