From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] dt-bindings: mediatek: add descriptions for mediatek
	mt2701 iommu and smi
Date: Mon, 9 May 2016 15:22:36 -0500
Message-ID: <20160509202236.GA23951@rob-hp-laptop>
References: <1462780816-5288-1-git-send-email-honghui.zhang@mediatek.com>
	<1462780816-5288-2-git-send-email-honghui.zhang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1462780816-5288-2-git-send-email-honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kendrick.hsu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, May 09, 2016 at 04:00:12PM +0800, honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org wrote:
> From: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> 
> This patch defines the local arbitor port IDs for mediatek SoC MT2701 and
> add descriptions of binding for mediatek generation one iommu and smi.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  .../devicetree/bindings/iommu/mediatek,iommu.txt   | 13 +++-
>  .../memory-controllers/mediatek,smi-common.txt     | 21 +++++-
>  .../memory-controllers/mediatek,smi-larb.txt       |  4 +-
>  include/dt-bindings/memory/mt2701-larb-port.h      | 85 ++++++++++++++++++++++
>  4 files changed, 115 insertions(+), 8 deletions(-)
>  create mode 100644 include/dt-bindings/memory/mt2701-larb-port.h
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> index cd1b1cd..9a4a5b5 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> @@ -1,7 +1,9 @@
>  * Mediatek IOMMU Architecture Implementation
>  
> -  Some Mediatek SOCs contain a Multimedia Memory Management Unit (M4U) which
> -uses the ARM Short-Descriptor translation table format for address translation.
> +  Some Mediatek SOCs contain a Multimedia Memory Management Unit (M4U), and
> +this M4U have two generations of HW architecture. Generation one use flat

s/use/uses/

> +pagetable, and only support 4K size page mapping. Generation two uses the

s/support/supports/

> +ARM Short-Descriptor translation table format for address translation.
>  
>    About the M4U Hardware Block Diagram, please check below:
>  
> @@ -36,7 +38,9 @@ in each larb. Take a example, There are many ports like MC, PP, VLD in the
>  video decode local arbiter, all these ports are according to the video HW.
>  
>  Required properties:
> -- compatible : must be "mediatek,mt8173-m4u".
> +- compatible : must be one of the following string:
> +	"mediatek,mt2701-m4u" for mt2701 which use generation one m4u HW.
> +	"mediatek,mt8173-m4u" for mt8173 which use generation two m4u HW.
>  - reg : m4u register base and size.
>  - interrupts : the interrupt of m4u.
>  - clocks : must contain one entry for each clock-names.
> @@ -46,7 +50,8 @@ Required properties:
>  	according to the local arbiter index, like larb0, larb1, larb2...
>  - iommu-cells : must be 1. This is the mtk_m4u_id according to the HW.
>  	Specifies the mtk_m4u_id as defined in
> -	dt-binding/memory/mt8173-larb-port.h.
> +	dt-binding/memory/mt2701-larb-port.h for mt2701 and
> +	dt-binding/memory/mt8173-larb-port.h for mt8173
>  
>  Example:
>  	iommu: iommu@10205000 {
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> index 06a83ce..80c0e22 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> @@ -2,16 +2,31 @@ SMI (Smart Multimedia Interface) Common
>  
>  The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
>  
> +Mediatek SMI have two generation HW architecture, mt8173 use the secondary

s/generation/generations of/
s/use/uses/
s/secondary/second/

> +generation of SMI HW while mt2701 use the first generation HW of SMI.

s/use/uses/

> +
> +There's slight differences between the two SMI, for generation 2, the
> +register which control the iommu port is at each larb's register base. But
> +for generation 1, the register is at smi ao base(smi always on register
> +base). Besides that, the smi async clock should be prepare and enabled for

s/prepare/prepared/

> +SMI generation 1 to transform the smi clock into emi clock domain, but no

s/no/that is not/

> +needed for SMI generation 2.
> +
>  Required properties:
> -- compatible : must be "mediatek,mt8173-smi-common"
> +- compatible : must be one of :
> +	"mediatek,mt2701-smi-common"
> +	"mediatek,mt8173-smi-common"
>  - reg : the register and size of the SMI block.
>  - power-domains : a phandle to the power domain of this local arbiter.
>  - clocks : Must contain an entry for each entry in clock-names.
> -- clock-names : must contain 2 entries, as follows:
> +- clock-names : must contain 3 entries for generation 1 smi HW and 2 entries
> +  for generation 2 smi HW as follows:
>    - "apb" : Advanced Peripheral Bus clock, It's the clock for setting
>  	    the register.
>    - "smi" : It's the clock for transfer data and command.
> -  They may be the same if both source clocks are the same.
> +	    They may be the same if both source clocks are the same.
> +  - "async" : asynchronous clock, it help transform the smi clock into the emi
> +	      clock domain, this clock is only needed by generation 1 smi HW.
>  
>  Example:
>  	smi_common: smi@14022000 {
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
> index 55ff3b7..21277a5 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
> @@ -3,7 +3,9 @@ SMI (Smart Multimedia Interface) Local Arbiter
>  The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
>  
>  Required properties:
> -- compatible : must be "mediatek,mt8173-smi-larb"
> +- compatible : must be one of :
> +		"mediatek,mt8173-smi-larb"
> +		"mediatek,mt2701-smi-larb"
>  - reg : the register and size of this local arbiter.
>  - mediatek,smi : a phandle to the smi_common node.
>  - power-domains : a phandle to the power domain of this local arbiter.
