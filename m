From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/ipmmu-vmsa: Add r8a779(70|95) DT bindings
Date: Tue, 14 Nov 2017 14:11:03 +0100
Message-ID: <CAMuHMdU4ZM22iyeO0_Ub+XsOdoUCHUkTqTQiaRZUzgPZAnhGJQ@mail.gmail.com>
References: <20171110121520.23437-1-horms+renesas@verge.net.au>
	<20171110121520.23437-3-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171110121520.23437-3-horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Simon,

On Fri, Nov 10, 2017 at 1:15 PM, Simon Horman
<horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org> wrote:
> Update the IPMMU DT binding documentation to include the
> r8a77970 (R-Car V3M) and r8a77995 (R-Car D3) compat strings.
>
> Based on work for r8a7796 by Magnus Damm.
>
> Signed-off-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
> index 98ae900a7a76..9efa87dbcfdc 100644
> --- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
> +++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
> @@ -17,6 +17,8 @@ Required Properties:
>      - "renesas,ipmmu-r8a7794" for the R8A7794 (R-Car E2) IPMMU.
>      - "renesas,ipmmu-r8a7795" for the R8A7795 (R-Car H3) IPMMU.
>      - "renesas,ipmmu-r8a7796" for the R8A7796 (R-Car M3-W) IPMMU.
> +    - "renesas,ipmmu-r8a77970" for the R8A7770 (R-Car V3M) IPMMU.

s/7770/77970/

> +    - "renesas,ipmmu-r8a77995" for the R8A77995 (R-Car D3) IPMMU.
>      - "renesas,ipmmu-vmsa" for generic R-Car Gen2 VMSA-compatible IPMMU.
>
>    - reg: Base address and size of the IPMMU registers.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
