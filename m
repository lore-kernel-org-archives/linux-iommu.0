From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 08/19] iommu: Implement reserved_regions iommu-group
	sysfs file
Date: Tue, 10 Jan 2017 17:20:34 +0100
Message-ID: <9ee5aa6b-6e63-c153-0727-729e0e9592c6@redhat.com>
References: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
	<1483969570-3154-9-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1483969570-3154-9-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 09/01/2017 14:45, Eric Auger wrote:
> A new iommu-group sysfs attribute file is introduced. It contains
> the list of reserved regions for the iommu-group. Each reserved
> region is described on a separate line:
> - first field is the start IOVA address,
> - second is the end IOVA address,
> - third is the type.
> 
> Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
> ---
> v6 -> v7:
> - also report the type of the reserved region as a string
> - updated ABI documentation
> 
> v3 -> v4:
> - add cast to long long int when printing to avoid warning on
>   i386
> - change S_IRUGO into 0444
> - remove sort. The list is natively sorted now.
> 
> The file layout is inspired of /sys/bus/pci/devices/BDF/resource.
> I also read Documentation/filesystems/sysfs.txt so I expect this
> to be frowned upon.
> ---
>  .../ABI/testing/sysfs-kernel-iommu_groups          | 12 +++++++
>  drivers/iommu/iommu.c                              | 38 ++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-iommu_groups b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
> index 9b31556..35c64e0 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-iommu_groups
> +++ b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
> @@ -12,3 +12,15 @@ Description:	/sys/kernel/iommu_groups/ contains a number of sub-
>  		file if the IOMMU driver has chosen to register a more
>  		common name for the group.
>  Users:
> +
> +What:		/sys/kernel/iommu_groups/reserved_regions
> +Date: 		January 2017
> +KernelVersion:  v4.11
> +Contact: 	Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> +Description:    /sys/kernel/iommu_groups/reserved_regions list IOVA
> +		regions that are reserved. Not necessarily all
> +		reserved regions are listed. This is typically used to
> +		output direct-mapped, MSI, non mappable regions. Each
> +		region is described on a single line: the 1st field is
> +		the base IOVA, the second is the end IOVA and the third
> +		field describes the type of the region.
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 640056b..0123daa 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -68,6 +68,12 @@ struct iommu_group_attribute {
>  			 const char *buf, size_t count);
>  };
>  
> +static const char * const iommu_group_resv_type_string[] = {
> +	[IOMMU_RESV_DIRECT]	= "direct",
> +	[IOMMU_RESV_RESERVED]	= "reserved",
> +	[IOMMU_RESV_MSI]	= "msi",
> +};
> +
>  #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
>  struct iommu_group_attribute iommu_group_attr_##_name =		\
>  	__ATTR(_name, _mode, _show, _store)
> @@ -231,8 +237,33 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
>  }
>  EXPORT_SYMBOL_GPL(iommu_get_group_resv_regions);
>  
> +static ssize_t iommu_group_show_resv_regions(struct iommu_group *group,
> +					     char *buf)
> +{
> +	struct iommu_resv_region *region, *next;
> +	struct list_head group_resv_regions;
> +	char *str = buf;
> +
> +	INIT_LIST_HEAD(&group_resv_regions);
> +	iommu_get_group_resv_regions(group, &group_resv_regions);
> +
> +	list_for_each_entry_safe(region, next, &group_resv_regions, list) {
> +		str += sprintf(str, "0x%016llx 0x%016llx %s\n",
> +			       (long long int)region->start,
> +			       (long long int)(region->start +
> +						region->length - 1),
> +			       iommu_group_resv_type_string[region->type]);
> +		kfree(region);
> +	}
> +
> +	return (str - buf);
> +}
> +
>  static IOMMU_GROUP_ATTR(name, S_IRUGO, iommu_group_show_name, NULL);
>  
> +static IOMMU_GROUP_ATTR(reserved_regions, 0444,
> +			iommu_group_show_resv_regions, NULL);
> +
>  static void iommu_group_release(struct kobject *kobj)
>  {
>  	struct iommu_group *group = to_iommu_group(kobj);
> @@ -247,6 +278,8 @@ static void iommu_group_release(struct kobject *kobj)
>  	if (group->default_domain)
>  		iommu_domain_free(group->default_domain);
>  
> +	iommu_group_remove_file(group, &iommu_group_attr_reserved_regions);

The /sys/kernel/iommu_groups/n directory seems to be removed before this
gets called and this may produce a WARNING when devices get removed from
the group. I intend to remove the call since I have the feeling
everything gets cleaned up properly.

Do you see any issue?

Thanks

Eric

[  350.753618] iommu: Removing device 0000:01:10.0 from group 7
[  350.759331] kernfs: can not remove 'reserved_regions', no directory
[  350.765603] ------------[ cut here ]------------
[  350.770216] WARNING: CPU: 3 PID: 2617 at fs/kernfs/dir.c:1406
kernfs_remove_by_name_ns+0x8c/0x98
../..
[  351.028154] [<ffff00000828819c>] kernfs_remove_by_name_ns+0x8c/0x98
[  351.034414] [<ffff000008289bf8>] sysfs_remove_file_ns+0x14/0x1c
[  351.040325] [<ffff00000856d918>] iommu_group_release+0x68/0x9c
[  351.046150] [<ffff0000083d152c>] kobject_cleanup+0x8c/0x194
[  351.051715] [<ffff0000083d13c8>] kobject_put+0x44/0x6c
[  351.056844] [<ffff0000083d1490>] kobject_del+0x40/0x50
[  351.061974] [<ffff0000083d1508>] kobject_cleanup+0x68/0x194
[  351.067538] [<ffff0000083d13c8>] kobject_put+0x44/0x6c
[  351.072668] [<ffff00000856df30>] iommu_group_remove_device+0x128/0x1d4
[  351.079187] [<ffff000008575eb0>] arm_smmu_remove_device+0x12c/0x158




> +
>  	kfree(group->name);
>  	kfree(group);
>  }
> @@ -310,6 +343,11 @@ struct iommu_group *iommu_group_alloc(void)
>  	 */
>  	kobject_put(&group->kobj);
>  
> +	ret = iommu_group_create_file(group,
> +				      &iommu_group_attr_reserved_regions);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
>  	pr_debug("Allocated group %d\n", group->id);
>  
>  	return group;
> 
