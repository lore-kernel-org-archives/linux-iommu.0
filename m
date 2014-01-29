From: Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 08/11] of: Increase MAX_PHANDLE_ARGS
Date: Wed, 29 Jan 2014 10:11:46 -0600
Message-ID: <52E92842.3000001@amd.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>	<1389876263-25759-9-git-send-email-andreas.herrmann@calxeda.com> <20140117110830.GW3471@alberich>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140117110830.GW3471@alberich>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 1/17/2014 5:08 AM, Andreas Herrmann wrote:
>
> arm-smmu driver uses of_parse_phandle_with_args when parsing DT
> information to determine stream IDs for a master device.
> Thus the number of stream IDs per master device is bound by
> MAX_PHANDLE_ARGS.
>
> To support Calxeda ECX-2000 hardware arm-smmu driver requires a
> slightly higher value for MAX_PHANDLE_ARGS as this hardware has 10
> stream IDs for one master device.
>
> Increasing it to 16 seems a reasonable choice.
>
> Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Andreas Herrmann <herrmann.der.user-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> ---
>   include/linux/of.h |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 276c546..24e1b28 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -67,7 +67,7 @@ struct device_node {
>   #endif
>   };
>
> -#define MAX_PHANDLE_ARGS 8
> +#define MAX_PHANDLE_ARGS 16

Since the MMU-500 specify "Number of SMRs" upto 128 registers, shouldn't 
this be changed to be able to support 128 StreamIDs as well?  Although I 
am not sure if this would be too big to have on the stack per Rob's 
comment in the previous patch set.

Thank you,

Suravee

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
