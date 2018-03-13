From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v9 1/5] driver core: Find an existing link between two
	devices
Date: Tue, 13 Mar 2018 15:28:47 +0530
Message-ID: <CAFp+6iH5E3qZNS65AHWEAypMwy7bfRg62_TFc3dBEYu_H-K0mg@mail.gmail.com>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
	<20180313085534.11650-2-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180313085534.11650-2-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, " <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, robh+dt <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>"list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>,
	" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 13, 2018 at 2:25 PM, Vivek Gautam
<vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> The lists managing the device-links can be traversed to
> find the link between two devices. The device_link_add() APIs
> does traverse these lists to check if there's already a link
> setup between the two devices.
> So, add a new APIs, device_link_find(), to find an existing
> device link between two devices - suppliers and consumers.
>
> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Cc: Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
> Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
> ---
>
>  * New patch added to this series.
>
>  drivers/base/core.c    | 30 +++++++++++++++++++++++++++---
>  include/linux/device.h |  2 ++
>  2 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 5847364f25d9..e8c9774e4ba2 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -144,6 +144,30 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
>         return 0;
>  }
>
> +/**
> + * device_link_find - find any existing link between two devices.
> + * @consumer: Consumer end of the link.
> + * @supplier: Supplier end of the link.
> + *
> + * Returns pointer to the existing link between a supplier and
> + * and consumer devices, or NULL if no link exists.
> + */
> +struct device_link *device_link_find(struct device *consumer,
> +                                    struct device *supplier)
> +{
> +       struct device_link *link = NULL;
> +
> +       if (!consumer || !supplier)
> +               return NULL;
> +
> +       list_for_each_entry(link, &supplier->links.consumers, s_node)
> +               if (link->consumer == consumer)
> +                       break;
> +
> +       return link;

My bad, this too needs fixing (didn't add the changes to the patch :( )

           list_for_each_entry(link, &supplier->links.consumers, s_node)
                   if (link->consumer == consumer)
                           return link;

           return NULL;

> +}
> +EXPORT_SYMBOL_GPL(device_link_find);
> +
>  /**
>   * device_link_add - Create a link between two devices.
>   * @consumer: Consumer end of the link.
> @@ -195,9 +219,9 @@ struct device_link *device_link_add(struct device *consumer,
>                 goto out;
>         }
>
> -       list_for_each_entry(link, &supplier->links.consumers, s_node)
> -               if (link->consumer == consumer)
> -                       goto out;
> +       link = device_link_find(consumer, supplier);
> +       if (link)
> +               goto out;
>
>         link = kzalloc(sizeof(*link), GFP_KERNEL);
>         if (!link)
> diff --git a/include/linux/device.h b/include/linux/device.h
> index b093405ed525..13bc1884c3eb 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1278,6 +1278,8 @@ extern const char *dev_driver_string(const struct device *dev);
>  struct device_link *device_link_add(struct device *consumer,
>                                     struct device *supplier, u32 flags);
>  void device_link_del(struct device_link *link);
> +struct device_link *device_link_find(struct device *consumer,
> +                                    struct device *supplier);
>
>  #ifdef CONFIG_PRINTK
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
