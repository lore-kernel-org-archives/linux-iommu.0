From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH/RFC 2/2] iommu/ipmmu-vmsa: Opt-in slave devices based on
	ES version
Date: Mon, 23 Jan 2017 13:50:18 +0100
Message-ID: <CAMuHMdWyV4DWN5pKsp+Z6C0MhZF5fKch4T1g1_Hbk3oxrR6_zw@mail.gmail.com>
References: <148517349585.18128.10696161017872202809.sendpatchset@little-apple>
	<148517354599.18128.1970642879780864733.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <148517354599.18128.1970642879780864733.sendpatchset@little-apple>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

On Mon, Jan 23, 2017 at 1:12 PM, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
>
> Match on r8a7795 ES2 and enable a certain DMA controller.
> In other cases the IPMMU driver remains disabled.
>
> Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> ---
>
>  drivers/iommu/ipmmu-vmsa.c |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> --- 0001/drivers/iommu/ipmmu-vmsa.c
> +++ work/drivers/iommu/ipmmu-vmsa.c     2017-01-23 20:57:02.620607110 +0900
> @@ -23,6 +23,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> +#include <linux/sys_soc.h>
>
>  #if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
>  #include <asm/dma-iommu.h>
> @@ -1002,16 +1003,39 @@ static void ipmmu_domain_free_dma(struct
>         }
>  }
>
> +static const struct soc_device_attribute r8a7795es2[] = {
> +       { .soc_id = "r8a7795", .revision = "ES2.*" },
> +       { /* sentinel */ }
> +};
> +
> +static int ipmmu_slave_whitelist(struct device *dev)
> +{
> +       /* Opt-in slave devices based on SoC and ES version */
> +       if (soc_device_match(r8a7795es2)) {
> +               if (!strcmp(dev_name(dev), "e7310000.dma-controller"))
> +                       return 0;
> +       }

I have two comments about the construct above:
  1. IPMMU will be disabled on all non-r8a7795 SoCs.
     Is that what you want?
  2. Usually we match on the old broken versions instead (e.g. against
     "ES1.*"), as (1) it marks more clearly support for old SoCs, and
                (2) it makes it easier to remove the check later when these
                    old SoCs are deemed extinct later.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
