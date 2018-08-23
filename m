From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/ipmmu-vmsa: Hook up R8A774A1 DT maching code
Date: Thu, 23 Aug 2018 10:43:40 +0200
Message-ID: <CAMuHMdUe=p42Bp6xgmvrNwPKs=VHUP2BezDBPPn9KgPawvOtgA@mail.gmail.com>
References: <1534516265-10059-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1534516265-10059-2-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1534516265-10059-2-git-send-email-fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Fabrizio Castro <fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Cc: Chris Paterson <Chris.Paterson2-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Fabrizio,

On Fri, Aug 17, 2018 at 4:31 PM Fabrizio Castro
<fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org> wrote:
> Add support for RZ/G2M (R8A774A1) SoC IPMMUs.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
> Reviewed-by: Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
> ---
> This patch applies on top of renesas-drivers-2018-07-31-v4.18-rc7
>
>  drivers/iommu/ipmmu-vmsa.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 51af2c5..cf5cfcf 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -761,6 +761,7 @@ static bool ipmmu_slave_whitelist(struct device *dev)
>  }
>
>  static const struct soc_device_attribute soc_rcar_gen3[] = {
> +       { .soc_id = "r8a774a1", },
>         { .soc_id = "r8a7795", },
>         { .soc_id = "r8a7796", },
>         { .soc_id = "r8a77965", },
> @@ -942,6 +943,9 @@ static const struct of_device_id ipmmu_of_ids[] = {
>                 .compatible = "renesas,ipmmu-vmsa",
>                 .data = &ipmmu_features_default,
>         }, {
> +               .compatible = "renesas,ipmmu-r8a774a1",
> +               .data = &ipmmu_features_rcar_gen3,
> +       }, {
>                 .compatible = "renesas,ipmmu-r8a7795",
>                 .data = &ipmmu_features_rcar_gen3,
>         }, {
> @@ -1143,6 +1147,7 @@ subsys_initcall(ipmmu_init);
>  module_exit(ipmmu_exit);
>
>  IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "renesas,ipmmu-vmsa");
> +IOMMU_OF_DECLARE(ipmmu_r8a774a1_iommu_of, "renesas,ipmmu-r8a774a1");
>  IOMMU_OF_DECLARE(ipmmu_r8a7795_iommu_of, "renesas,ipmmu-r8a7795");
>  IOMMU_OF_DECLARE(ipmmu_r8a7796_iommu_of, "renesas,ipmmu-r8a7796");
>  IOMMU_OF_DECLARE(ipmmu_r8a77965_iommu_of, "renesas,ipmmu-r8a77965");

The IOMMU_OF_DECLARE() lines will be gone v4.18-rc1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
