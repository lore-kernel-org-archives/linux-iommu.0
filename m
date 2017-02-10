From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 01/11] iommu: Rename iommu_get_instance()
Date: Fri, 10 Feb 2017 14:12:54 +0000
Message-ID: <baf8d059-8c74-baa4-1806-ca1e3733cd93@arm.com>
References: <1486639981-32368-1-git-send-email-joro@8bytes.org>
	<1486639981-32368-2-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1486639981-32368-2-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

I'm really liking this series! Superficially it doesn't seem to break
anything on my Juno, but I'll give it a more thorough workout soon.

Just a few comments from skimming through...

On 09/02/17 11:32, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> Rename the function to iommu_ops_from_fwnode(), because that
> is what the function actually does. The new name is much
> more descriptive about what the function does.
> 
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/acpi/arm64/iort.c | 2 +-
>  drivers/iommu/iommu.c     | 2 +-
>  include/linux/iommu.h     | 4 ++--
>  include/linux/of_iommu.h  | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index e0d2e6e..3752521 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -536,7 +536,7 @@ static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
>  		if (!iort_fwnode)
>  			return NULL;
>  
> -		ops = iommu_get_instance(iort_fwnode);
> +		ops = iommu_ops_from_fwnode(iort_fwnode);
>  		if (!ops)
>  			return NULL;
>  
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index dbe7f65..0ee05bb 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1653,7 +1653,7 @@ void iommu_register_instance(struct fwnode_handle *fwnode,
>  	spin_unlock(&iommu_instance_lock);
>  }
>  
> -const struct iommu_ops *iommu_get_instance(struct fwnode_handle *fwnode)
> +const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
>  {
>  	struct iommu_instance *instance;
>  	const struct iommu_ops *ops = NULL;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 0ff5111..085e1f0 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -354,7 +354,7 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
>  int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
>  void iommu_register_instance(struct fwnode_handle *fwnode,
>  			     const struct iommu_ops *ops);
> -const struct iommu_ops *iommu_get_instance(struct fwnode_handle *fwnode);
> +const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
>  
>  #else /* CONFIG_IOMMU_API */
>  
> @@ -590,7 +590,7 @@ static inline void iommu_register_instance(struct fwnode_handle *fwnode,
>  }
>  
>  static inline
> -const struct iommu_ops *iommu_get_instance(struct fwnode_handle *fwnode)
> +const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
>  {
>  	return NULL;
>  }
> diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
> index 6a7fc50..66fcbc9 100644
> --- a/include/linux/of_iommu.h
> +++ b/include/linux/of_iommu.h
> @@ -39,7 +39,7 @@ static inline void of_iommu_set_ops(struct device_node *np,
>  
>  static inline const struct iommu_ops *of_iommu_get_ops(struct device_node *np)
>  {
> -	return iommu_get_instance(&np->fwnode);
> +	return iommu_ops_from_fwnode(&np->fwnode);
>  }

Note that you've already got Lorenzo's patch queued to remove these of_
wrappers.

Robin.

>  
>  extern struct of_device_id __iommu_of_table;
> 
