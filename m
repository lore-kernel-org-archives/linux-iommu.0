From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v2 01/22] [HACK] of: dev_node has struct device pointer
Date: Tue, 16 Jul 2013 16:57:03 -0600
Message-ID: <51E5CFBF.5080407@wwwdotorg.org>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
	<1373021097-32420-2-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1373021097-32420-2-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> To prevent of_platform_populate() from trying to populate duplicate
> devices if a device has been already populated.

You need to send drivers/of patches to the DT maintainer and
devicetree-discuss mailing list.

> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> Need to take care of early_platform_devices, or alternative solution.

I assume that's a TODO item... Are you planning on fleshing out this
patch to address that issue?

> diff --git a/drivers/of/base.c b/drivers/of/base.c

> +struct device *of_get_device(const struct device_node *node)
> +{
> +	struct device *dev;
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&devtree_lock, flags);
> +	dev = node->dev;
> +	raw_spin_unlock_irqrestore(&devtree_lock, flags);

The read (and write in of_set_device()) aren't atomic already? I guess
perhaps they aren't necessarily. It sure seems like some higher-level
locking is needed in of_platform_create_pdata() though, since there's
quite a window there between the get() and set() calls. Or, is there
already some locking in place above that, in which case, I 'm not sure
why there's a need for this level of locking here...

> diff --git a/drivers/of/platform.c b/drivers/of/platform.c

> +	tmp = of_get_device(np);
> +	if (tmp) {
> +		dev_info(tmp, "Already populated\n");
> +		return to_platform_device(tmp);
> +	}

Did you check all callers of this function to make sure that they also
don't do any kind of double-processing?


> diff --git a/include/linux/of.h b/include/linux/of.h

> @@ -60,6 +60,9 @@ struct device_node {
>  	struct	kref kref;
>  	unsigned long _flags;
>  	void	*data;
> +
> +	struct device *dev;		/* Set only after populated */
> +
>  #if defined(CONFIG_SPARC)

Are the extra blank lines needed?
