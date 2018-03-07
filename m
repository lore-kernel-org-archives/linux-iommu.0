From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v7 09/14] dt-bindings: iommu/rockchip: Add clock property
Date: Wed, 7 Mar 2018 13:01:37 +0000
Message-ID: <b7b58e44-82d5-4f7d-5f49-69f8d1a93279@arm.com>
References: <20180306030252.3197-1-jeffy.chen@rock-chips.com>
	<20180306032113.22247-1-jeffy.chen@rock-chips.com>
	<20180306032113.22247-6-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180306032113.22247-6-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 06/03/18 03:21, Jeffy Chen wrote:
> Add clock property, since we are going to control clocks in rockchip
> iommu driver.

Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
> 
> Changes in v7: None
> Changes in v6:
> Fix dt-binding as Robin suggested.
> Use aclk and iface clk as Rob and Robin suggested, and split binding
> patch.
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>   Documentation/devicetree/bindings/iommu/rockchip,iommu.txt | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> index 2098f7732264..6ecefea1c6f9 100644
> --- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> +++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> @@ -14,6 +14,11 @@ Required properties:
>                       "single-master" device, and needs no additional information
>                       to associate with its master device.  See:
>                       Documentation/devicetree/bindings/iommu/iommu.txt
> +- clocks          : A list of clocks required for the IOMMU to be accessible by
> +                    the host CPU.
> +- clock-names     : Should contain the following:
> +	"iface" - Main peripheral bus clock (PCLK/HCL) (required)
> +	"aclk"  - AXI bus clock (required)
>   
>   Optional properties:
>   - rockchip,disable-mmu-reset : Don't use the mmu reset operation.
> @@ -27,5 +32,7 @@ Example:
>   		reg = <0xff940300 0x100>;
>   		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
>   		interrupt-names = "vopl_mmu";
> +		clocks = <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
> +		clock-names = "aclk", "iface";
>   		#iommu-cells = <0>;
>   	};
> 
