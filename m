From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: RFC: extend iommu-map binding to support #iommu-cells > 1
Date: Fri, 16 Dec 2016 11:34:46 +0000
Message-ID: <22b456c7-00d3-371c-1c4a-dd9cb9256349@arm.com>
References: <VI1PR0401MB2638DE2D30F8423F6F8C7A6E8D9C0@VI1PR0401MB2638.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <VI1PR0401MB2638DE2D30F8423F6F8C7A6E8D9C0-9IDQY6o3qQjcXZ0H4ZLnAo3W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 16/12/16 02:36, Stuart Yoder wrote:
> For context, please see the thread:
> https://www.spinics.net/lists/arm-kernel/msg539066.html
> 
> The existing iommu-map binding did not account for the situation where
> #iommu-cells == 2, as permitted in the ARM SMMU binding.  The 2nd cell
> of the IOMMU specifier being the SMR mask.  The existing binding defines
> the mapping as:
>    Any RID r in the interval [rid-base, rid-base + length) is associated with
>    the listed IOMMU, with the iommu-specifier (r - rid-base + iommu-base).
> 
> ...and that does not work if iommu-base is 2 cells, the second being the
> SMR mask.
> 
> While this can be worked around by always having length=1, it seems we
> can get this cleaned up by updating the binding definition for iommu-map.
> 
> See patch below.  Thoughts?

I really don't think defining a generic binding to have a magic
non-standard meaning for one specific use-case is the right way to go.

Give me a moment to spin the patch I reckon you actually want...

Robin.

> 
> Thanks,
> Stuart
> 
> -------------------------------------------------------------------------
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci-iommu.txt b/Documentation/devicetree/bindings/pci/pci-iommu.txt
> index 56c8296..e81b461 100644
> --- a/Documentation/devicetree/bindings/pci/pci-iommu.txt
> +++ b/Documentation/devicetree/bindings/pci/pci-iommu.txt
> @@ -38,8 +38,20 @@ Optional properties
>    The property is an arbitrary number of tuples of
>    (rid-base,iommu,iommu-base,length).
> 
> -  Any RID r in the interval [rid-base, rid-base + length) is associated with
> -  the listed IOMMU, with the iommu-specifier (r - rid-base + iommu-base).
> +  If the associated IOMMU has an #iommu-cells value of 1, any RID r in the
> +  interval [rid-base, rid-base + length) is associated with the listed IOMMU,
> +  with the iommu-specifier (r - rid-base + iommu-base).
> +
> +  ARM SMMU Note:
> +    The ARM SMMU binding permits an #iommu-cells value of 2 and in this
> +    case defines an IOMMU specifier to be: (stream-id,smr-mask)
> +
> +    In an iommu-map this means the iommu-base consists of 2 cells:
> +        (rid-base,iommu,[stream-id,smr-mask],length).
> +
> +    In this case the RID to IOMMU specifier mapping is defined to be:
> +    any RID r in the interval [rid-base, rid-base + length) is associated
> +    with the listed IOMMU, with the iommu-specifier (r - rid-base + stream-id).
> 
>  - iommu-map-mask: A mask to be applied to each Requester ID prior to being
>    mapped to an iommu-specifier per the iommu-map property.
> 
> 
> 
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
