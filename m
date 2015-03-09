From: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH 3/5] dt-bindings: mediatek: Add smi dts binding
Date: Mon, 9 Mar 2015 20:32:26 +0800
Message-ID: <1425904346.13300.37.camel@mhfsdcap03>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
	 <1425638900-24989-4-git-send-email-yong.wu@mediatek.com>
	 <54F9BE55.90601@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54F9BE55.90601@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Rob Herring <robh+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, srv_heupstream@mediatek.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org, Daniel Kurtz <djkurtz@google.com>, Sasha Hauer <kernel@pengutronix.de>, linux-mediatek@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>, yong.wu@mediatek.com
List-Id: iommu@lists.linux-foundation.org

Dear Sergei,
	Thanks very much for suggestion.
        I will fix them in the next version.

On Fri, 2015-03-06 at 17:48 +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 3/6/2015 1:48 PM, yong.wu@mediatek.com wrote:
> 
> > From: Yong Wu <yong.wu@mediatek.com>
> 
> > This patch add smi binding document.
> 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   .../devicetree/bindings/soc/mediatek/mediatek,smi.txt   | 17 +++++++++++++++++
> >   1 file changed, 17 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt
> 
> > diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt b/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt
> > new file mode 100644
> > index 0000000..0fc9d1a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt
> > @@ -0,0 +1,17 @@
> > +SMI hardware block diagram please help check <bindings/iommu/mediatek,iommu.txt>
> > +
> > +Required properties:
> > +- compatible : must be "mediatek,mediatek,mt8173-smi-larb"
> 
>     One "mediatek," is enough. :-)
> 
> > +- reg : the register of each local arbiter
> > +- clocks : the clocks of each local arbiter
> > +- clock-name: larb_sub*(3 clockes at most)
> 
>     clock-names.
> 
> > +
> > +Example:
> > +	larb1:larb@16010000 {
> > +	        compatible = "mediatek,mt8173-smi-larb";
> > +		reg = <0 0x16010000 0 0x1000>;
> > +		clocks = <&mmsys MM_SMI_COMMON>,
> > +		        <&vdecsys VDEC_CKEN>,
> 
>     Please align with the < above.
> 
> > +                        <&vdecsys VDEC_LARB_CKEN>;
> 
>     Use tabs instead of spaces, please.
> 
> > +		clock-names = "larb_sub0", "larb_sub1", "larb_sub2";
> > +	};
> 
> WBR, Sergei
> 
