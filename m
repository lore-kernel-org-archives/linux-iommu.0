From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4 2/7] documentation: iommu: Add bindings for
 msm,iommu-v0 ip
Date: Mon, 16 May 2016 11:44:14 -0500
Message-ID: <20160516164414.GA25899@rob-hp-laptop>
References: <1463381341-30498-1-git-send-email-sricharan@codeaurora.org>
 <1463381341-30498-3-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1463381341-30498-3-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, May 16, 2016 at 12:18:56PM +0530, Sricharan R wrote:
> The MSM IOMMU is an implementation compatible with the ARM VMSA short
> descriptor page tables. It provides address translation for bus masters outside
> of the CPU, each connected to the IOMMU through a port called micro-TLB.
> Adding the DT bindings for the same.
> 
> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  .../devicetree/bindings/iommu/msm,iommu-v0.txt     | 64 ++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
> 
> diff --git a/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt b/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
> new file mode 100644
> index 0000000..b22c607
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
> @@ -0,0 +1,64 @@
> +* QCOM IOMMU
> +
> +The MSM IOMMU is an implementation compatible with the ARM VMSA short
> +descriptor page tables. It provides address translation for bus masters outside
> +of the CPU, each connected to the IOMMU through a port called micro-TLB.
> +
> +Required Properties:
> +
> +  - compatible: Must contain "qcom,iommu-v0-apq8064".

qcom,apq8064-iommu would be the preferred order and I think you can drop 
the v0.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
