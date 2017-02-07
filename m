From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v2 05/11] iommu/ipmmu-vmsa: Make use of IOMMU_OF_DECLARE()
Date: Tue, 7 Feb 2017 13:59:11 +0100
Message-ID: <CAMuHMdWSDrcbrh5+hQ4SqwOxobG0b1zpRN0+Gpgopi+kzLOLQg@mail.gmail.com>
References: <20160606035723.31763.66500.sendpatchset@little-apple>
	<20160606035810.31763.53611.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160606035810.31763.53611.sendpatchset@little-apple>
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
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

On Mon, Jun 6, 2016 at 5:58 AM, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
>
> Hook up IOMMU_OF_DECLARE() support in case CONFIG_IOMMU_DMA
> is enabled. The only current supported case for 32-bit ARM
> is disabled, however for 64-bit ARM this is required.
>
> Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> ---
>
>  Changes since V1:
>  - Reworked slightly to fit updated patch order and
>    [PATCH v3 00/06] iommu/ipmmu-vmsa: IPMMU multi-arch update V3
>
>  drivers/iommu/ipmmu-vmsa.c |   26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> --- 0015/drivers/iommu/ipmmu-vmsa.c
> +++ work/drivers/iommu/ipmmu-vmsa.c     2016-06-06 10:57:26.790607110 +0900

> +#ifdef CONFIG_IOMMU_DMA
> +static int __init ipmmu_vmsa_iommu_of_setup(struct device_node *np)
> +{
> +       static const struct iommu_ops *ops = &ipmmu_ops;
> +
> +       ipmmu_init();
> +
> +       of_iommu_set_ops(np, (struct iommu_ops *)ops);

As of commit 65e251a4634c5644 ("iommu: Drop the of_iommu_{set/get}_ops()
interface"), this should become:

        iommu_register_instance(&np->fwnode, (struct iommu_ops *)ops);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
