From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] Docs: dt: Be explicit and consistent in reference to
	IOMMU specifiers
Date: Fri, 16 Dec 2016 11:33:17 +0000
Message-ID: <20161216113317.GB20265@leverpostej>
References: <1481847373-2602-1-git-send-email-stuart.yoder@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1481847373-2602-1-git-send-email-stuart.yoder-3arQi8VN3Tc@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Stuart,

On Thu, Dec 15, 2016 at 06:16:13PM -0600, Stuart Yoder wrote:
> The generic IOMMU binding says that the meaning of an 'IOMMU specifier'
> is defined by the binding of a specific SMMU.  The ARM SMMU binding
> never explicitly uses the term 'specifier' at all.  Update implicit
> references to use the explicit term.
> 
> In the iommu-map binding change references to iommu-specifier to
> "IOMMU specifier" so we are 100% consistent everywhere with terminology
> and capitalization.

Elsewhere, we always use lower case "xxx-specifier" or "xxx specifier",
e.g. Documentation/devicetree/bindings/gpio/gpio.txt defines
"gpio-specifier", ePAPR defines "interrupt specifier".

Given we're morstly consistent on "iommu-specifier" today, could we
please jsut update the ARM SMMU binding to match that? If we're going to
fix the dash mismatch, that's a more general, cross-binding thing.

Thanks,
Mark.

> Signed-off-by: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.txt | 10 +++++-----
>  Documentation/devicetree/bindings/pci/pci-iommu.txt  |  6 +++---
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index e862d148..6cdf32d 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -36,15 +36,15 @@ conditions.
>                    combined interrupt, it must be listed multiple times.
>  
>  - #iommu-cells  : See Documentation/devicetree/bindings/iommu/iommu.txt
> -                  for details. With a value of 1, each "iommus" entry
> +                  for details. With a value of 1, each IOMMU specifier
>                    represents a distinct stream ID emitted by that device
>                    into the relevant SMMU.
>  
>                    SMMUs with stream matching support and complex masters
> -                  may use a value of 2, where the second cell represents
> -                  an SMR mask to combine with the ID in the first cell.
> -                  Care must be taken to ensure the set of matched IDs
> -                  does not result in conflicts.
> +                  may use a value of 2, where the second cell of the
> +                  IOMMU specifier represents an SMR mask to combine with
> +                  the ID in the first cell.  Care must be taken to ensure
> +                  the set of matched IDs does not result in conflicts.
>  
>  ** System MMU optional properties:
>  
> diff --git a/Documentation/devicetree/bindings/pci/pci-iommu.txt b/Documentation/devicetree/bindings/pci/pci-iommu.txt
> index 56c8296..0def586 100644
> --- a/Documentation/devicetree/bindings/pci/pci-iommu.txt
> +++ b/Documentation/devicetree/bindings/pci/pci-iommu.txt
> @@ -32,17 +32,17 @@ PCI root complex
>  Optional properties
>  -------------------
>  
> -- iommu-map: Maps a Requester ID to an IOMMU and associated iommu-specifier
> +- iommu-map: Maps a Requester ID to an IOMMU and associated IOMMU specifier
>    data.
>  
>    The property is an arbitrary number of tuples of
>    (rid-base,iommu,iommu-base,length).
>  
>    Any RID r in the interval [rid-base, rid-base + length) is associated with
> -  the listed IOMMU, with the iommu-specifier (r - rid-base + iommu-base).
> +  the listed IOMMU, with the IOMMU specifier (r - rid-base + iommu-base).
>  
>  - iommu-map-mask: A mask to be applied to each Requester ID prior to being
> -  mapped to an iommu-specifier per the iommu-map property.
> +  mapped to an IOMMU specifier per the iommu-map property.
>  
>  
>  Example (1)
> -- 
> 1.9.0
> 
