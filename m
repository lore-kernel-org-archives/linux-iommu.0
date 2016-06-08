From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 1/3] iommu/ipmmu-vmsa: Add r8a7796 DT binding
Date: Wed, 08 Jun 2016 03:17:34 +0300
Message-ID: <1576781.gBe1LZDnOQ@avalon>
References: <20160607033918.28687.98260.sendpatchset@little-apple> <20160607033927.28687.67122.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160607033927.28687.67122.sendpatchset@little-apple>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: iommu@lists.linux-foundation.org, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, joro@8bytes.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, horms+renesas@verge.net.au
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

Thank you for the patch.

On Tuesday 07 Jun 2016 12:39:27 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Update the IPMMU DT binding documentation to include the r8a7796 compat
> string for R-Car M3-W.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- 0001/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
> +++
> work/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt	
2016-06
> -06 11:27:37.560607110 +0900 @@ -16,6 +16,7 @@ Required Properties:
>      - "renesas,ipmmu-r8a7793" for the R8A7793 (R-Car M2-N) IPMMU.
>      - "renesas,ipmmu-r8a7794" for the R8A7794 (R-Car E2) IPMMU.
>      - "renesas,ipmmu-r8a7795" for the R8A7795 (R-Car H3) IPMMU.
> +    - "renesas,ipmmu-r8a7796" for the R8A7796 (R-Car M3-W) IPMMU.
>      - "renesas,ipmmu-vmsa" for generic R-Car Gen2 VMSA-compatible IPMMU.
> 
>    - reg: Base address and size of the IPMMU registers.

-- 
Regards,

Laurent Pinchart
