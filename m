From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/of: Only do IOMMU lookup for available ones
Date: Mon, 8 Jan 2018 11:45:03 +0000
Message-ID: <767a9f59-be14-2103-6675-a2028742e663@arm.com>
References: <20180103060920.23475-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180103060920.23475-1-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Jeffy,

On 03/01/18 06:09, Jeffy Chen wrote:
> The for_each_matching_node_and_match() would return every matching
> nodes including unavailable ones.
> 
> It's pointless to init unavailable IOMMUs, so add a sanity check to
> avoid that.

Even better would be to clean up the last remaining init_fn user and get 
rid of the whole business. With the probe-deferral mechanism, early 
initialisation hooks are no longer needed, and the IOMMU_OF_DECLARE 
section really only remains as a way of detecting builtin drivers long 
before their registration initcalls run.

Robin.

> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> 
>   drivers/iommu/of_iommu.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 50947ebb6d17..6f7456caa30d 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -240,6 +240,9 @@ static int __init of_iommu_init(void)
>   	for_each_matching_node_and_match(np, matches, &match) {
>   		const of_iommu_init_fn init_fn = match->data;
>   
> +		if (!of_device_is_available(np))
> +			continue;
> +
>   		if (init_fn && init_fn(np))
>   			pr_err("Failed to initialise IOMMU %pOF\n", np);
>   	}
> 
