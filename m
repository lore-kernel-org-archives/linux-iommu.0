From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] dt-bindings: iommu: ipmmu-vmsa: Add r8a774a1 support
Date: Thu, 8 Nov 2018 13:45:30 +0100
Message-ID: <20181108124530.dgbucminxi3z63gx@verge.net.au>
References: <1534516265-10059-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1534516265-10059-3-git-send-email-fabrizio.castro@bp.renesas.com>
 <TY1PR01MB177011B91A9CA579E01760A4C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <TY1PR01MB177011B91A9CA579E01760A4C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 08, 2018 at 11:23:58AM +0000, Fabrizio Castro wrote:
> Dear All,
> 
> Who is the best person to take this patch?

I believe this one is also for Joerg.

> Thanks,
> Fab
> 
> > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Sent: 17 August 2018 15:31
> > Subject: [PATCH 2/2] dt-bindings: iommu: ipmmu-vmsa: Add r8a774a1 support
> >
> > Document RZ/G2M (R8A774A1) SoC bindings.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> > ---
> > This patch applies on top of next-20180817
> >
> >  Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
> > b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
> > index ffadb7c..68446dd 100644
> > --- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
> > +++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
> > @@ -13,6 +13,7 @@ Required Properties:
> >      - "renesas,ipmmu-r8a73a4" for the R8A73A4 (R-Mobile APE6) IPMMU.
> >      - "renesas,ipmmu-r8a7743" for the R8A7743 (RZ/G1M) IPMMU.
> >      - "renesas,ipmmu-r8a7745" for the R8A7745 (RZ/G1E) IPMMU.
> > +    - "renesas,ipmmu-r8a774a1" for the R8A774A1 (RZ/G2M) IPMMU.
> >      - "renesas,ipmmu-r8a7790" for the R8A7790 (R-Car H2) IPMMU.
> >      - "renesas,ipmmu-r8a7791" for the R8A7791 (R-Car M2-W) IPMMU.
> >      - "renesas,ipmmu-r8a7793" for the R8A7793 (R-Car M2-N) IPMMU.
> > --
> > 2.7.4
> 
> 
> 
> 
> Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
> 
