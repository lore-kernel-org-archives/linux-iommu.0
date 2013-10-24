From: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv3 01/19] [HACK] of: dev_node has struct device pointer
Date: Thu, 24 Oct 2013 09:55:31 +0100
Message-ID: <20131024085531.680A4C4039D@trevor.secretlab.ca>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com> <1382092020-13170-2-git-send-email-hdoyu@nvidia.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1382092020-13170-2-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 18 Oct 2013 13:26:42 +0300, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> To prevent of_platform_populate() from trying to populate duplicate
> devices if a device has been already populated.
> 
> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/of/platform.c | 6 ++++++
>  include/linux/of.h    | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 9b439ac..994cea4 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -208,6 +208,11 @@ static struct platform_device *of_platform_device_create_pdata(
>  	if (!of_device_is_available(np))
>  		return NULL;
>  
> +	if (np->dev) {
> +		dev_info(np->dev, "Already populated\n");
> +		return to_platform_device(np->dev);
> +	}
> +

This looks racy if the intent is to prevent a device from being created
twice. If two threads call of_platform_device_create() in parallel, this
will fail to properly protect against dual creation. Checking the node
and marking it as used needs to be atomic.

>  	dev = of_device_alloc(np, bus_id, parent);
>  	if (!dev)
>  		return NULL;
> @@ -232,6 +237,7 @@ static struct platform_device *of_platform_device_create_pdata(
>  		return NULL;
>  	}
>  
> +	np->dev = &dev->dev;
>  	return dev;
>  }
>  
> diff --git a/include/linux/of.h b/include/linux/of.h
> index f95aee3..638a88a 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -60,6 +60,7 @@ struct device_node {
>  	struct	kref kref;
>  	unsigned long _flags;
>  	void	*data;
> +	struct device *dev;		/* Set only after populated */

Is this being used merely to indicate that a device has been processed
by of_platform_device_create()? Or do you intend to dereference this
pointer? I've avoided putting the struct device in to the device_node
structure up to this point simply becuase there aren't any good clues
for what /kind/ of device it actually points to. I worry that bad
assumptions will get made when other subsystems try to use the
same pointer. ie. if one subsystem creates its own device and sets this
pointer, and then of_platform_device_create() comes along behind, sees
that it is already created, and then returns a platform_device pointer
*for something that isn't a struct platform_device*. This is very bad.

Instead of using a pointer to the struct device, would a flag be
sufficient for your purposes? Would it be fine to return NULL if the
device has already been created?

g.

>  #if defined(CONFIG_SPARC)
>  	const char *path_component_name;
>  	unsigned int unique_id;
> -- 
> 1.8.1.5
> 
