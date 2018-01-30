From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 08/13] iommu/rockchip: Control clocks needed to access
	the IOMMU
Date: Tue, 30 Jan 2018 11:05:15 -0600
Message-ID: <20180130170515.3g6wtadqgmehxh5b@rob-hp-laptop>
References: <20180124103516.2571-1-jeffy.chen@rock-chips.com>
	<20180124103516.2571-9-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180124103516.2571-9-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 24, 2018 at 06:35:11PM +0800, Jeffy Chen wrote:
> From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> 
> Current code relies on master driver enabling necessary clocks before
> IOMMU is accessed, however there are cases when the IOMMU should be
> accessed while the master is not running yet, for example allocating
> V4L2 videobuf2 buffers, which is done by the VB2 framework using DMA
> mapping API and doesn't engage the master driver at all.
> 
> This patch fixes the problem by letting clocks needed for IOMMU
> operation to be listed in Device Tree and making the driver enable them
> for the time of accessing the hardware.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
> 
> Changes in v5:
> Use clk_bulk APIs.
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  .../devicetree/bindings/iommu/rockchip,iommu.txt   |  8 +++

Please split binding patches to a separate patch.

>  drivers/iommu/rockchip-iommu.c                     | 74 ++++++++++++++++++++--
>  2 files changed, 76 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> index 2098f7732264..33dd853359fa 100644
> --- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> +++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> @@ -14,6 +14,13 @@ Required properties:
>                      "single-master" device, and needs no additional information
>                      to associate with its master device.  See:
>                      Documentation/devicetree/bindings/iommu/iommu.txt
> +Optional properties:
> +- clocks : A list of master clocks requires for the IOMMU to be accessible
> +           by the host CPU. The number of clocks depends on the master
> +           block and might as well be zero. See [1] for generic clock
> +           bindings description.

Hardware blocks don't have a variable number of clock connections. This 
needs to be a defined number of clocks (per compatible string if there 
are different implementations with different # of clocks).

> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>  
>  Optional properties:
>  - rockchip,disable-mmu-reset : Don't use the mmu reset operation.
> @@ -27,5 +34,6 @@ Example:
>  		reg = <0xff940300 0x100>;
>  		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
>  		interrupt-names = "vopl_mmu";
> +		clocks = <&cru ACLK_VOP1>, <&cru DCLK_VOP1>, <&cru HCLK_VOP1>;
>  		#iommu-cells = <0>;
>  	};
