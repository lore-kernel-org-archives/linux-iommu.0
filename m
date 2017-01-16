From: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu: Handle default domain attach failure
Date: Mon, 16 Jan 2017 18:02:58 +0000
Message-ID: <87tw8yopbh.fsf@e105922-lin.cambridge.arm.com>
References: <f5e5f1f1c3c37a36ea44eb8b2767b257ac97210d.1484571306.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <f5e5f1f1c3c37a36ea44eb8b2767b257ac97210d.1484571306.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
	(Robin Murphy's message of "Mon, 16 Jan 2017 12:58:07 +0000")
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

Thanks for the patch.

Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> writes:

> We wouldn't normally expect ops->attach_dev() to fail, but on IOMMUs
> with limited hardware resources, or generally misconfigured systems,
> it is certainly possible. We report failure correctly from the external
> iommu_attach_device() interface, but do not do so in iommu_group_add()
> when attaching to the default domain. The result of failure there is
> that the device, group and domain all get left in a broken,
> part-configured state which leads to weird errors and misbehaviour down
> the line when IOMMU API calls sort-of-but-don't-quite work.
>
> Check the return value of __iommu_attach_device() on the default domain,
> and refactor the error handling paths to cope with its failure and clean
> up correctly in such cases.
>

Booting with the patch, the boot time warnings I was seeing go away. I
also now see a bunch of messages when adding devices, such as -

[    4.805466] iommu: Failed to add device 0000:06:10.2 to group 10: -28


> Fixes: e39cb8a3aa98 ("iommu: Make sure a device is always attached to a domain")
> Reported-by: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

FWIW,

Tested-by: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>

> ---
>  drivers/iommu/iommu.c | 37 ++++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index dbe7f653bb7c..aed906a3e3db 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -383,36 +383,30 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
>  	device->dev = dev;
>  
>  	ret = sysfs_create_link(&dev->kobj, &group->kobj, "iommu_group");
> -	if (ret) {
> -		kfree(device);
> -		return ret;
> -	}
> +	if (ret)
> +		goto err_free_device;
>  
>  	device->name = kasprintf(GFP_KERNEL, "%s", kobject_name(&dev->kobj));
>  rename:
>  	if (!device->name) {
> -		sysfs_remove_link(&dev->kobj, "iommu_group");
> -		kfree(device);
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto err_remove_link;
>  	}
>  
>  	ret = sysfs_create_link_nowarn(group->devices_kobj,
>  				       &dev->kobj, device->name);
>  	if (ret) {
> -		kfree(device->name);
>  		if (ret == -EEXIST && i >= 0) {
>  			/*
>  			 * Account for the slim chance of collision
>  			 * and append an instance to the name.
>  			 */
> +			kfree(device->name);
>  			device->name = kasprintf(GFP_KERNEL, "%s.%d",
>  						 kobject_name(&dev->kobj), i++);
>  			goto rename;
>  		}
> -
> -		sysfs_remove_link(&dev->kobj, "iommu_group");
> -		kfree(device);
> -		return ret;
> +		goto err_free_name;
>  	}
>  
>  	kobject_get(group->devices_kobj);
> @@ -424,8 +418,10 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
>  	mutex_lock(&group->mutex);
>  	list_add_tail(&device->list, &group->devices);
>  	if (group->domain)
> -		__iommu_attach_device(group->domain, dev);
> +		ret = __iommu_attach_device(group->domain, dev);
>  	mutex_unlock(&group->mutex);
> +	if (ret)
> +		goto err_put_group;
>  
>  	/* Notify any listeners about change to group. */
>  	blocking_notifier_call_chain(&group->notifier,
> @@ -436,6 +432,21 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
>  	pr_info("Adding device %s to group %d\n", dev_name(dev), group->id);
>  
>  	return 0;
> +
> +err_put_group:
> +	mutex_lock(&group->mutex);
> +	list_del(&device->list);
> +	mutex_unlock(&group->mutex);
> +	dev->iommu_group = NULL;
> +	kobject_put(group->devices_kobj);
> +err_free_name:
> +	kfree(device->name);
> +err_remove_link:
> +	sysfs_remove_link(&dev->kobj, "iommu_group");
> +err_free_device:
> +	kfree(device);
> +	pr_err("Failed to add device %s to group %d: %d\n", dev_name(dev), group->id, ret);
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iommu_group_add_device);
