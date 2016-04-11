From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 1/5] iommu/msm: Add DT adaptation
Date: Mon, 11 Apr 2016 08:47:28 -0500
Message-ID: <20160411134728.GA21468@rob-hp-laptop>
References: <1459952975-1250-1-git-send-email-sricharan@codeaurora.org>
	<1459952975-1250-2-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1459952975-1250-2-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will.Deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 06, 2016 at 07:59:31PM +0530, Sricharan R wrote:
> The driver currently works based on platform data. Remove this
> and add support for DT. A single master can have multiple ports
> connected to more than one iommu.
> 
> 	  	      master
>         	        |
> 	                |
> 	                |
> 	   ------------------------
>            |  			  |
> 	IOMMU0			IOMMU1

You've got mixtures of tabs and spaces here. Either fully use leading 
tabs or use spaces everywhere.

>            |			  |
>       ctx0   ctx1	     ctx0   ctx1
> 
> This association of master and iommus/contexts were previously
> represented by platform data parent/child device details. The client
> drivers were responsible for programming all of the iommus/contexts
> for the device. Now while adapting to generic DT bindings we maintain the
> list of iommus, contexts that each master domain is connected to and
> program all of them on attach/detach.
> 
> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  .../devicetree/bindings/iommu/msm,iommu-v0.txt     |  59 ++++

It is preferred to split bindings to separate patch.

>  drivers/iommu/msm_iommu.c                          | 252 +++++++++--------
>  drivers/iommu/msm_iommu.h                          |  73 ++---
>  drivers/iommu/msm_iommu_dev.c                      | 315 +++++----------------
>  4 files changed, 296 insertions(+), 403 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
> 
> diff --git a/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt b/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
> new file mode 100644
> index 0000000..21bfbfc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
> @@ -0,0 +1,59 @@
> +* QCOM IOMMU
> +
> +The QCOM IOMMU is an implementation compatible with the ARM VMSA short
> +descriptor page tables. It provides address translation for bus masters outside
> +of the CPU, each connected to the IOMMU through a port called micro-TLB.
> +
> +Required Properties:
> +
> +  - compatible: Must contain "qcom,iommu-v0".

You need SoC specific compatible strings in addition.

> +  - reg: Base address and size of the IOMMU registers.
> +  - interrupts: Specifiers for the MMU fault interrupts. For instances that
> +    support secure mode two interrupts must be specified, for non-secure and
> +    secure mode, in that order. For instances that don't support secure mode a
> +    single interrupt must be specified.
> +  - #iommu-cells: This is the total number of stream ids that a master would
> +		  use during transactions which will be specified as a list
> +		  as a part of iommus property below.
> +  - ncb: The total number of context banks in the IOMMU.
> +  - clocks	: List of clocks to be used during SMMU register access. See
> +		  Documentation/devicetree/bindings/clock/clock-bindings.txt
> +		  for information about the format. For each clock specified
> +		  here, there must be a corresponding entry in clock-names
> +		  (see below).
> +
> +  - clock-names	: List of clock names corresponding to the clocks specified in
> +		  the "clocks" property (above). See
> +		  Documentation/devicetree/bindings/clock/clock-bindings.txt
> +		  for more info.
> +
> +Each bus master connected to an IOMMU must reference the IOMMU in its device
> +node with the following property:
> +
> +  - iommus: A reference to the IOMMU in multiple cells. The first cell is a
> +	    phandle to the IOMMU and the second cell is the list of the
> +	    stream ids used by the device.
> +
> +Example: mdp iommu and its bus master
> +
> +                mdp_port0: qcom,iommu@7500000 {
> +			compatible = "msm,iommu-v0";
> +			#iommu-cells = <2>;
> +			clock-names =
> +			    "smmu_pclk",
> +			    "iommu_clk";
> +			clocks =
> +			    <&mmcc SMMU_AHB_CLK>,
> +			    <&mmcc MDP_AXI_CLK>;
> +			reg = <0x07500000 0x100000>;
> +			interrupts =
> +			    <GIC_SPI 63 0>,
> +			    <GIC_SPI 64 0>;
> +			ncb = <2>;
> +		};
> +
> +		mdp: qcom,mdp@5100000 {
> +			compatible = "qcom,mdp";
> +			...
> +			iommus = <&mdp_port0 0 2>;
> +		};
