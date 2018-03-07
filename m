From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/6] Docs: dt: add fsl-mc iommu-parent device-tree binding
Date: Wed, 7 Mar 2018 16:40:19 -0600
Message-ID: <20180307224019.oowh74pkbi5izuft@rob-hp-laptop>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
	<1520260166-29387-2-git-send-email-nipun.gupta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1520260166-29387-2-git-send-email-nipun.gupta-3arQi8VN3Tc@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, leoyang.li-3arQi8VN3Tc@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Mar 05, 2018 at 07:59:21PM +0530, Nipun Gupta wrote:
> The existing IOMMU bindings cannot be used to specify the relationship
> between fsl-mc devices and IOMMUs. This patch adds a binding for
> mapping fsl-mc devices to IOMMUs, using a new iommu-parent property.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
> ---
>  .../devicetree/bindings/misc/fsl,qoriq-mc.txt      | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> index 6611a7c..011c7d6 100644
> --- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> +++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> @@ -9,6 +9,24 @@ blocks that can be used to create functional hardware objects/devices
>  such as network interfaces, crypto accelerator instances, L2 switches,
>  etc.
>  
> +For an overview of the DPAA2 architecture and fsl-mc bus see:
> +drivers/staging/fsl-mc/README.txt
> +
> +As described in the above overview, all DPAA2 objects in a DPRC share the
> +same hardware "isolation context" and a 10-bit value called an ICID
> +(isolation context id) is expressed by the hardware to identify
> +the requester.
> +
> +The generic 'iommus' property is cannot be used to describe the relationship
> +between fsl-mc and IOMMUs, so an iommu-parent property is used to define
> +the same.

Why not? It is just a link between 2 nodes.

> +
> +For generic IOMMU bindings, see
> +Documentation/devicetree/bindings/iommu/iommu.txt.
> +
> +For arm-smmu binding, see:
> +Documentation/devicetree/bindings/iommu/arm,smmu.txt.
> +
>  Required properties:
>  
>      - compatible
> @@ -88,14 +106,27 @@ Sub-nodes:
>                Value type: <phandle>
>                Definition: Specifies the phandle to the PHY device node associated
>                            with the this dpmac.
> +Optional properties:
> +
> +- iommu-parent: Maps the devices on fsl-mc bus to an IOMMU.
> +  The property specifies the IOMMU behind which the devices on
> +  fsl-mc bus are residing.

If you want a generic property, this should be documented in the common 
binding.

Couldn't you have more than 1 IOMMU upstream of a MC?

>  
>  Example:
>  
> +        smmu: iommu@5000000 {
> +               compatible = "arm,mmu-500";
> +               #iommu-cells = <1>;
> +               stream-match-mask = <0x7C00>;
> +               ...
> +        };
> +
>          fsl_mc: fsl-mc@80c000000 {
>                  compatible = "fsl,qoriq-mc";
>                  reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
>                        <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
>                  msi-parent = <&its>;
> +                iommu-parent = <&smmu>;
>                  #address-cells = <3>;
>                  #size-cells = <1>;
>  
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
