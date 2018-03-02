From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/3] rpmsg: core: make rpmsg bus DMA capable
Date: Fri, 2 Mar 2018 16:14:44 +0000
Message-ID: <07503032-b08b-10ea-9d34-ddf85c682a9d@arm.com>
References: <20180302145531.20463-1-srinivas.kandagatla@linaro.org>
	<20180302145531.20463-3-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180302145531.20463-3-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org, linux-remoteproc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 02/03/18 14:55, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> Many of the rpmsg clients like audio drivers need to allocate
> dma memory. Make this bus DMA capable so that the child devices
> can use dma apis.

AFAICS after 15 minutes in the docs and code, the rpmsg "bus" is a 
virtual one based around shared-memory mailbox communication, so I don't 
really see how DMA exists in that context - I think maybe that 
abstraction needs looking at.

However, from grepping through the DTs it seems at first glance like the 
non-trivial things under the "qcom,smd" bus mostly map to actual 
platform devices via the "qcom,smd-edge" property - if those platform 
devices are the physical DMA masters, they should be the ones used for 
DMA API operations.

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>   drivers/rpmsg/rpmsg_core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index e84c71f8d6ab..540a3f3567b8 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -472,6 +472,7 @@ struct bus_type rpmsg_bus = {
>   	.uevent		= rpmsg_uevent,
>   	.probe		= rpmsg_dev_probe,
>   	.remove		= rpmsg_dev_remove,
> +	.force_dma	= true,

Regardless of the above, would you really need to use this brute force 
hack instead of just fixing the DTs? I'm struggling to find which 
drivers might currently be relying on this :/

Robin.

>   };
>   EXPORT_SYMBOL(rpmsg_bus);
>   
> 
