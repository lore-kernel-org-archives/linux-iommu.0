From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/5] iommu: Allow taking a reference on a group directly
Date: Wed, 9 Nov 2016 17:25:43 +0000
Message-ID: <20161109172543.GI17771@arm.com>
References: <3922e1f14d8ecb50440b2d9b0d1123f3c9307fc5.1478695557.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3922e1f14d8ecb50440b2d9b0d1123f3c9307fc5.1478695557.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 09, 2016 at 12:47:24PM +0000, Robin Murphy wrote:
> iommu_group_get_for_dev() expects that the IOMMU driver's device_group
> callback return a group with a reference held for the given device.
> Whilst allocating a new group is fine, and pci_device_group() correctly
> handles reusing an existing group, there is no general means for IOMMU
> drivers doing their own group lookup to take additional references on an
> existing group pointer without having to also store device pointers or
> resort to elaborate trickery.
> 
> Add an IOMMU-driver-specific function to fill the hole.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/iommu.c | 14 ++++++++++++++
>  include/linux/iommu.h |  1 +
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 9a2f1960873b..b0b052bc6bb5 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -552,6 +552,20 @@ struct iommu_group *iommu_group_get(struct device *dev)
>  EXPORT_SYMBOL_GPL(iommu_group_get);
>  
>  /**
> + * __iommu_group_get - Increment reference on a group
> + * @group: the group to use, must not be NULL
> + *
> + * This function may be called by internal iommu driver group management
> + * when the context of a struct device pointer is not available.  It is
> + * not for general use.  Returns the given group for convenience.
> + */
> +struct iommu_group *__iommu_group_get(struct iommu_group *group)
> +{
> +	kobject_get(group->devices_kobj);
> +	return group;
> +}

This probably either wants sticking in a header or exporting to modules.
That said, why do we need the underscores and the comment about internal
group management? That's pretty much already the case for iommu_group_get.

Of course, removing the underscores gives you a naming conflict, but we
could just call it something like "iommu_group_get_ref".

Will
