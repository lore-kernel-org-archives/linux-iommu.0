From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Document R-Car V3H and E3 IPMMU DT
	bindings
Date: Tue, 22 May 2018 14:50:05 +0200
Message-ID: <20180522125005.cq7tmiaueoffjuoa@verge.net.au>
References: <152691369384.29456.13581918319106400529.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <152691369384.29456.13581918319106400529.sendpatchset@little-apple>
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
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, May 21, 2018 at 11:41:33PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> 
> Update the IPMMU DT binding documentation to include the compat strings
> for the IPMMU devices included in the R-Car V3H and E3 SoCs.
> 
> Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Reviewed-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>

> ---
> 
>  Developed on top of renesas-drivers-2018-05-15-v4.17-rc5
> 
>  Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- 0001/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
> +++ work/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt	2018-05-21 23:37:16.370607110 +0900
> @@ -20,6 +20,8 @@ Required Properties:
>      - "renesas,ipmmu-r8a7795" for the R8A7795 (R-Car H3) IPMMU.
>      - "renesas,ipmmu-r8a7796" for the R8A7796 (R-Car M3-W) IPMMU.
>      - "renesas,ipmmu-r8a77970" for the R8A77970 (R-Car V3M) IPMMU.
> +    - "renesas,ipmmu-r8a77980" for the R8A77980 (R-Car V3H) IPMMU.
> +    - "renesas,ipmmu-r8a77990" for the R8A77990 (R-Car E3) IPMMU.
>      - "renesas,ipmmu-r8a77995" for the R8A77995 (R-Car D3) IPMMU.
>      - "renesas,ipmmu-vmsa" for generic R-Car Gen2 or RZ/G1 VMSA-compatible
>  			   IPMMU.
> 
