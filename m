From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: RFC: extend iommu-map binding to support #iommu-cells > 1
Date: Fri, 16 Dec 2016 11:39:14 +0000
Message-ID: <20161216113914.GC20265@leverpostej>
References: <VI1PR0401MB2638DE2D30F8423F6F8C7A6E8D9C0@VI1PR0401MB2638.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
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
To: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Dec 16, 2016 at 02:36:57AM +0000, Stuart Yoder wrote:
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

To reiterate, I'm very much not keen on the pci-iommu binding having
knowledge of the decomposition of iommu-specifiers from other bindings.

As mentioned previously, there's an intended interpretation [1] that we
need to fix up the pci-iommu binding with. With that, I don't think it's
even necessary to bodge iommu-cells = <1> AFAICT.

I'm sorry that the patch I suggested never materialized; let me figure
out the wording now...

Thanks,
Mark.

[1] https://www.spinics.net/lists/arm-kernel/msg539357.html

> 
> See patch below.  Thoughts?
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
