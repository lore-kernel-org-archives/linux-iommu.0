From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCHv4 5/7] iommu/tegra: smmu: Support "mmu-masters" binding
Date: Mon, 11 Nov 2013 11:35:10 +0000
Message-ID: <20131111113510.GG28302@mudshark.cambridge.arm.com>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>
 <1384158718-4756-6-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1384158718-4756-6-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Hiroshi,

On Mon, Nov 11, 2013 at 08:31:56AM +0000, Hiroshi Doyu wrote:
> Follow arm,smmu's "mmu-masters" binding.
> 
> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> Update:
> Newly added for v4. In v3, I used "nvidia,swgroups" and
> "nvidia,memory-clients" bindings.

[...]

> @@ -1151,6 +1152,77 @@ static void tegra_smmu_create_default_map(struct smmu_device *smmu)
>  	}
>  }
>  
> +static struct smmu_client *find_smmu_client(struct smmu_device *smmu,
> +					    struct device_node *dev_node)
> +{
> +	struct rb_node *node = smmu->clients.rb_node;
> +
> +	while (node) {
> +		struct smmu_client *client;
> +
> +		client = container_of(node, struct smmu_client, node);
> +		if (dev_node < client->of_node)
> +			node = node->rb_left;
> +		else if (dev_node > client->of_node)
> +			node = node->rb_right;
> +		else
> +			return client;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int insert_smmu_client(struct smmu_device *smmu,
> +			      struct smmu_client *client)
> +{
> +	struct rb_node **new, *parent;
> +
> +	new = &smmu->clients.rb_node;
> +	parent = NULL;
> +	while (*new) {
> +		struct smmu_client *this;
> +		this = container_of(*new, struct smmu_client, node);
> +
> +		parent = *new;
> +		if (client->of_node < this->of_node)
> +			new = &((*new)->rb_left);
> +		else if (client->of_node > this->of_node)
> +			new = &((*new)->rb_right);
> +		else
> +			return -EEXIST;
> +	}
> +
> +	rb_link_node(&client->node, parent, new);
> +	rb_insert_color(&client->node, &smmu->clients);
> +	return 0;
> +}
> +
> +static int register_smmu_client(struct smmu_device *smmu,
> +				struct device *dev,
> +				struct of_phandle_args *args)
> +{
> +	struct smmu_client *client;
> +	int i;
> +
> +	client = find_smmu_client(smmu, args->np);
> +	if (client) {
> +		dev_err(dev,
> +			"rejecting multiple registrations for client device %s\n",
> +			args->np->full_name);
> +		return -EBUSY;
> +	}
> +
> +	client = devm_kzalloc(dev, sizeof(*client), GFP_KERNEL);
> +	if (!client)
> +		return -ENOMEM;
> +
> +	client->of_node = args->np;
> +	for (i = 0; i < args->args_count; i++)
> +		client->hwgrp |= 1ULL << args->args[i];
> +
> +	return insert_smmu_client(smmu, client);
> +}

This code looks familiar ;)

If this approach makes it past the DT guys, I wonder if there's any scope
for factoring out some of the arm-smmu code so that basic client
parsing/searching/registration can be made into a library?

Will
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
