From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 1/1] iommu/arm-smmu: Add support for multiple TBU
 child devices
Date: Tue, 19 Sep 2017 09:10:34 -0500
Message-ID: <20170919141034.ahhmuxfk6ldpegfp@rob-hp-laptop>
References: <1505217667-31184-1-git-send-email-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1505217667-31184-1-git-send-email-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: robin.murphy-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 12, 2017 at 05:31:07PM +0530, Vivek Gautam wrote:
> ARM MMU-500 implements a TBU (uTLB) for each connected master
> besides a single TCU which controls and manages the address
> translations. Each of these TBUs can either be in the same
> power domain as the master, or they can have a independent
> power switch.
> This design addresses the challenges to control TBU power.
> Adding child devices for each TBUs present in the configuration
> lets us control the power and clocks to TLBs having individual
> power domains. The device link between master devices (such as,
> display, and GPU) and TBU devices ensures that the master takes
> care of powering the smmu as long as it's available.
> When the master is not available, the TBUs are identified with
> sid and powered on.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
> 
>  - The idea behind this patch is to handle the distributed smmu
>    architectures, similar to MMU-500.
>  - Untested yet.
>  - There are still few instances where the correct tbu device has
>    to be referenced and thus powered on to handle TLB maintenance
>    operations.
> 
>  .../devicetree/bindings/iommu/arm,smmu.txt         |  27 +++
>  drivers/iommu/arm-smmu.c                           | 191 +++++++++++++++++++--
>  2 files changed, 205 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index d97a6bc8e608..7cf67e75022e 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -98,6 +98,18 @@ conditions.
>                    accessed before master gets enabled and linked to its
>                    SMMU.
>  
> +- child nodes:    ARM MMU-500 implements a TBU (page table cache or TLB) for
> +                  each connected master besides a single TCU that controls
> +                  and manages the address translations.
> +                  Each of the child nodes represents a TBU that is attached to
> +                  the master. This child node will have following property:
> +
> +  - compatibe:       must be "arm,mmu-500-tbu" for TBU child nodes of arm,mmu-500
> +                     smmu.
> +  - stream-id-range: array representing the starting stream id and the number
> +                     of supported stream-ids. This gives information about
> +                     the range of stream-ids that are supported by this TBU.

Needs a vendor prefix.

Also need to document reg property. What does reg represent? If just an 
index with no correlation to h/w numbering, then perhaps stream ids 
could be put into reg instead.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
