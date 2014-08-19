From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Add new macros for invalidation event
Date: Tue, 19 Aug 2014 13:11:15 +0200
Message-ID: <20140819111115.GB26492@8bytes.org>
References: <1408067751-30754-1-git-send-email-zhen-hual@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1408067751-30754-1-git-send-email-zhen-hual-VXdhtT5mjnY@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Aug 15, 2014 at 09:55:51AM +0800, Li, Zhen-Hua wrote:
> According to intel's spec
>         Intel=AE Virtualization Technology for Directed I/O,
>         Revision: 1.3 , February 2011,
>         Chaper 10.4.25 to 10.4.28
> =

> There are four registers
> =

>         IECTL_REG   0xa0    Invalidation event control register
>         IEDATA_REG  0xa4    Invalidation event data register
>         IEADDR_REG  0xa8    Invalidation event address register
>         IEUADDR_REG 0xac    Invalidation event upper address register
> =

> Through they are not used in kernel in the latest version, the defination
>  should be added to kernel as well as other registers.
> =

> Signed-off-by: Li, Zhen-Hua <zhen-hual-VXdhtT5mjnY@public.gmane.org>
> ---
>  include/linux/intel-iommu.h | 4 ++++
>  1 file changed, 4 insertions(+)
> =

> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index a65208a..15fafd5 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -56,6 +56,10 @@
>  #define DMAR_IQ_SHIFT	4	/* Invalidation queue head/tail shift */
>  #define DMAR_IQA_REG	0x90	/* Invalidation queue addr register */
>  #define DMAR_ICS_REG	0x9c	/* Invalidation complete status register */
> +#define DMAR_IECTL_REG	0xa0	/* Invalidation event control register */
> +#define DMAR_IEDATA_REG	0xa4	/* Invalidation event data register */
> +#define DMAR_IEADDR_REG	0xa8	/* Invalidation event address register */
> +#define DMAR_IEUADDR_REG 0xac	/* Invalidation event upper address regist=
er */
>  #define DMAR_IRTA_REG	0xb8    /* Interrupt remapping table addr register=
 */
>  =

>  #define OFFSET_STRIDE		(9)

There is no point in adding register defines that are not used anywhere.


	Joerg
