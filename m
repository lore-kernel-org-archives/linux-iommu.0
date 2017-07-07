From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 1/2] dt-bindings: pci: Add drop mask property for MSI
	and IOMMU
Date: Fri, 7 Jul 2017 14:30:52 +0100
Message-ID: <20170707133052.GB3425@leverpostej>
References: <1499411399-25103-1-git-send-email-srinath.mannam@broadcom.com>
	<1499411399-25103-2-git-send-email-srinath.mannam@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1499411399-25103-2-git-send-email-srinath.mannam-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Srinath Mannam <srinath.mannam-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 07, 2017 at 12:39:58PM +0530, Srinath Mannam wrote:
> This patch adds info about optional DT properties
> iommu-map-drop-mask and msi-map-drop-mask.
> 
> A drop mask represents the bits which will be
> removed/dropped by system from Requester ID before
> mapping it to msi ID or stream ID.
> 
> Signed-off-by: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Srinath Mannam <srinath.mannam-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Ray Jui <ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> ---
>  .../devicetree/bindings/pci/pci-iommu.txt          | 31 ++++++++++++++++++++
>  Documentation/devicetree/bindings/pci/pci-msi.txt  | 33 ++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci-iommu.txt b/Documentation/devicetree/bindings/pci/pci-iommu.txt
> index 0def586..499cb27 100644
> --- a/Documentation/devicetree/bindings/pci/pci-iommu.txt
> +++ b/Documentation/devicetree/bindings/pci/pci-iommu.txt
> @@ -44,6 +44,9 @@ Optional properties
>  - iommu-map-mask: A mask to be applied to each Requester ID prior to being
>    mapped to an IOMMU specifier per the iommu-map property.
>  
> +- iommu-map-drop-mask: A drop mask represents the bits which will be
> +  removed/dropped by system from Requester ID before mapping it to
> +  stream ID.

As mentioned in my reply to the cover letter, you're expecting this to
be handled as more than a mask, so this description is inadequate.

[...]

> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	iommu: iommu@a {
> +		reg = <0xa 0x1>;
> +		compatible = "vendor,some-iommu";
> +		#iommu-cells = <1>;
> +	};
> +
> +	pci: pci@f {
> +		reg = <0xf 0x1>;
> +		compatible = "vendor,pcie-root-complex";
> +		device_type = "pci";
> +
> +		/*
> +		 * The sideband data provided to the IOMMU is a 10bit
> +		 * data derived from the RID by dropping 4 MSBs
> +		 * of device number and 2 MSBs of function number.
> +		 */
> +		iommu-map = <0x0 &iommu 0x0 0x1024>;
> +		iommu-map-drop-mask = <0xff09>;
> +	};
> +};

... as this this example.

Assuming this was truly a mask of bits to drop, you'd have:

	RID	->	SID
	0xffff	->	0x00f6

... whereas from your cover letter it seems you want:

	RID	->	SID
	0xffff	->	0x3f

... and I've just realsied you have non-coniguous masks, so this is even
worse.

> diff --git a/Documentation/devicetree/bindings/pci/pci-msi.txt b/Documentation/devicetree/bindings/pci/pci-msi.txt
> index 9b3cc81..1de3f39 100644
> --- a/Documentation/devicetree/bindings/pci/pci-msi.txt
> +++ b/Documentation/devicetree/bindings/pci/pci-msi.txt
> @@ -49,6 +49,10 @@ Optional properties
>  - msi-map-mask: A mask to be applied to each Requester ID prior to being mapped
>    to an msi-specifier per the msi-map property.
>  
> +- msi-map-drop-mask: A drop mask represents the bits which will be
> +  removed/dropped by system from Requester ID before mapping it to
> +  msi ID.
> +
>  - msi-parent: Describes the MSI parent of the root complex itself. Where
>    the root complex and MSI controller do not pass sideband data with MSI
>    writes, this property may be used to describe the MSI controller(s)
> @@ -218,3 +222,32 @@ Example (5)
>  			  <0x0000 &msi_b 0x0000 0x10000>;
>  	};
>  };
> +
> +Example (6)
> +===========
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	msi: msi-controller@a {
> +		reg = <0xa 0x1>;
> +		compatible = "vendor,some-controller";
> +		msi-controller;
> +		#msi-cells = <1>;
> +	};
> +
> +	pci: pci@f {
> +		reg = <0xf 0x1>;
> +		compatible = "vendor,pcie-root-complex";
> +		device_type = "pci";
> +
> +		/*
> +		 * The sideband data provided to the  MSI controller is
> +		 * a 10bit data derived from the RID by dropping
> +		 * 4 MSBs of device number and 2 MSBs of function number.
> +		 */
> +		msi-map = <0x0 &msi_a 0x0 0x100>,
> +		msi-map-drop-mask = <0xff09>
> +	};
> +};

... likewise on all counts.

Your mapping can be expressed today using a number of msi-map entries,
which you can easily generate programmatically with a trivial perl
script, without requiring a new binding or any new kernel code.

Please do that instead.

Thanks,
Mark.
