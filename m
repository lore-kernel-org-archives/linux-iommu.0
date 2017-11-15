From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFT v5 3/3] iommu/ipmmu-vmsa: Hook up r8a779(70|95) DT
 matching code
Date: Wed, 15 Nov 2017 15:19:50 +0100
Message-ID: <CAMuHMdWbpJ-EOyogaY+cWFozwp2QSmpbNoe6VtAPV6r3NjXTKA@mail.gmail.com>
References: <20171114083451.4052-1-horms+renesas@verge.net.au> <20171114083451.4052-4-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171114083451.4052-4-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <joro@8bytes.org>, Magnus Damm <magnus.damm@gmail.com>, iommu@lists.linux-foundation.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Simon,

On Tue, Nov 14, 2017 at 9:34 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Support the r8a77970 (R-Car V3M) and r8a77995 (R-Car D3) IPMMUs by sharing
> feature flags with r8a7795 (R-Car H3) and r8a7796 (R-Car M3-W). Also update
> IOMMU_OF_DECLARE to hook up the compat strings.
>
> Based on work for the r8a7796 by Magnus Damm
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2
> * Add reviewed-by tag from Geert Uytterhoeven
> ---
>  drivers/iommu/ipmmu-vmsa.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index f936f834984a..49c6fc0c1ae6 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -763,6 +763,8 @@ static bool ipmmu_slave_whitelist(struct device *dev)
>  static const struct soc_device_attribute soc_rcar_gen3[] = {
>         { .soc_id = "r8a7795", },
>         { .soc_id = "r8a7796", },
> +       { .soc_id = "r8a77970", },
> +       { .soc_id = "r8a77995", },

This array starts becoming a mirror of most entries in ipmmu_of_ids[].
As long as you don't need to match against a specific SoC revision, you could
store the whitelist check flag in struct ipmmu_features, as pointed to by
ipmmu_of_ids.data.

>         { /* sentinel */ }
>  };
>
> @@ -943,6 +945,12 @@ static const struct of_device_id ipmmu_of_ids[] = {
>                 .compatible = "renesas,ipmmu-r8a7796",
>                 .data = &ipmmu_features_rcar_gen3,
>         }, {
> +               .compatible = "renesas,ipmmu-r8a77970",
> +               .data = &ipmmu_features_rcar_gen3,
> +       }, {
> +               .compatible = "renesas,ipmmu-r8a77995",
> +               .data = &ipmmu_features_rcar_gen3,
> +       }, {
>                 /* Terminator */
>         },


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
