Return-Path: <SRS0=uxOK=4L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8478AC35671
	for <iommu@archiver.kernel.org>; Sun, 23 Feb 2020 01:20:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5334A20702
	for <iommu@archiver.kernel.org>; Sun, 23 Feb 2020 01:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5334A20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1AA2E2275F;
	Sun, 23 Feb 2020 01:20:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9hD0QbMg6lKp; Sun, 23 Feb 2020 01:20:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CAFEA2002E;
	Sun, 23 Feb 2020 01:20:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A04E9C1AE2;
	Sun, 23 Feb 2020 01:20:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B109FC013E
 for <iommu@lists.linux-foundation.org>; Sun, 23 Feb 2020 01:20:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 970FB8329B
 for <iommu@lists.linux-foundation.org>; Sun, 23 Feb 2020 01:20:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dW7prQMVn29X for <iommu@lists.linux-foundation.org>;
 Sun, 23 Feb 2020 01:20:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2CE9A8673C
 for <iommu@lists.linux-foundation.org>; Sun, 23 Feb 2020 01:20:21 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Feb 2020 17:20:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,474,1574150400"; d="scan'208";a="255213589"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.230])
 ([10.254.212.230])
 by orsmga002.jf.intel.com with ESMTP; 22 Feb 2020 17:20:17 -0800
Subject: Re: [PATCH V2 3/5] iommu: Add support to change default domain of an
 iommu_group
To: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
 iommu@lists.linux-foundation.org
References: <cover.1581619464.git.sai.praneeth.prakhya@intel.com>
 <5aa5ef20ff81f706aafa9a6af68cef98fe60ad0f.1581619464.git.sai.praneeth.prakhya@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b8b5ac1f-b736-531d-a621-030ec8e3e7b1@linux.intel.com>
Date: Sun, 23 Feb 2020 09:20:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5aa5ef20ff81f706aafa9a6af68cef98fe60ad0f.1581619464.git.sai.praneeth.prakhya@intel.com>
Content-Language: en-US
Cc: Ashok Raj <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

On 2020/2/17 5:57, Sai Praneeth Prakhya wrote:
> Presently, the default domain of an iommu_group is allocated during boot
> time (i.e. when a device is being added to a group) and it cannot be
> changed later. So, the device would typically be either in identity (also
> known as pass_through) mode (controlled by "iommu=pt" kernel command line

The default domain type is initialized according to the kernel build
option, and could be overrided by several kernel commands like iommu=pt
and iommu.passthrough.

> argument) or the device would be in DMA mode as long as the machine is up
> and running. There is no way to change the default domain type dynamically
> i.e. after booting, a device cannot switch between identity mode and DMA
> mode.
> 
> But, assume a use case wherein the user trusts the device and also believes
> that the OS is secure enough and hence wants *only* this device to bypass
> IOMMU (so that it could be high performing) whereas all the other devices
> to go through IOMMU (so that the system is protected). Presently, this use
> case is not supported. Hence it will be helpful if there is some way to
> change the default domain of a B:D.F dynamically. Since, linux iommu
> subsystem prefers to deal at iommu_group level instead of B:D.F level, it
> might be helpful if there is some way to change the default domain of a
> *iommu_group* dynamically. Hence, add such support.
> 
> A privileged user could request the kernel to change the default domain
> type of a iommu_group by writing to
> "/sys/kernel/iommu_groups/<grp_id>/type"
> file. Presently, only three values are supported
> 1. identity: all the DMA transactions from the devices in this group are
> 	     *not* translated by the iommu
> 2. DMA: all the DMA transactions from the devices in this group are
> 	translated by the iommu
> 3. auto: kernel decides one among DMA/identity
> 
> Also please note that a group type could be modified only when *all* the
> devices in the group are not binded to any device driver. Please see
> "Documentation/ABI/testing/sysfs-kernel-iommu_groups" for more information.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Sohil Mehta <sohil.mehta@intel.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> ---
>   drivers/iommu/iommu.c | 227 +++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 226 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3e3528436e0b..56a29076871f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -225,6 +225,8 @@ static int __iommu_attach_group(struct iommu_domain *domain,
>   				struct iommu_group *group);
>   static void __iommu_detach_group(struct iommu_domain *domain,
>   				 struct iommu_group *group);
> +static ssize_t iommu_group_store_type(struct iommu_group *group,
> +				      const char *buf, size_t count);
>   
>   static int __init iommu_set_def_domain_type(char *str)
>   {
> @@ -448,7 +450,8 @@ static IOMMU_GROUP_ATTR(name, S_IRUGO, iommu_group_show_name, NULL);
>   static IOMMU_GROUP_ATTR(reserved_regions, 0444,
>   			iommu_group_show_resv_regions, NULL);
>   
> -static IOMMU_GROUP_ATTR(type, 0444, iommu_group_show_type, NULL);
> +static IOMMU_GROUP_ATTR(type, 0644, iommu_group_show_type,
> +			iommu_group_store_type);
>   
>   static void iommu_group_release(struct kobject *kobj)
>   {
> @@ -2654,3 +2657,225 @@ int iommu_sva_get_pasid(struct iommu_sva *handle)
>   	return ops->sva_get_pasid(handle);
>   }
>   EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
> +
> +/*
> + * Changes the default domain of a group
> + *
> + * @group: The group for which the default domain should be changed
> + * @prv_dom: The previous domain that is being switched from

The previous domain is still kept in group->default_domain, so it's
unnecessary to pass it as a parameter, right?

> + * @type: The type of the new default domain that gets associated with the group
> + *
> + * Returns 0 on success and error code on failure
> + */
> +static int iommu_group_change_def_domain(struct iommu_group *group,
> +					 struct iommu_domain *prv_dom,
> +					 int type)
> +{
> +	struct group_device *grp_dev, *temp;
> +	struct iommu_domain *new_domain;
> +	int ret;
> +
> +	/*
> +	 * iommu_domain_alloc() takes "struct bus_type" as an argument which is
> +	 * a member in "struct device". Changing a group's default domain type
> +	 * deals at iommu_group level rather than device level and hence there
> +	 * is no straight forward way to get "bus_type" of an iommu_group that
> +	 * could be passed to iommu_domain_alloc(). So, instead of directly
> +	 * calling iommu_domain_alloc(), use iommu_ops from previous default
> +	 * domain.
> +	 */
> +	if (!prv_dom || !prv_dom->ops || !prv_dom->ops->domain_alloc || !type)
> +		return -EINVAL;
> +
> +	/* Allocate a new domain of requested type */
> +	new_domain = prv_dom->ops->domain_alloc(type);
> +	if (!new_domain) {
> +		pr_err("Unable to allocate memory for the new domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	new_domain->type = type;
> +	new_domain->ops = prv_dom->ops;
> +	new_domain->pgsize_bitmap = prv_dom->pgsize_bitmap;
> +
> +	/*
> +	 * Set these upfront here because iommu_group_add_device() and
> +	 * iommu_group_create_direct_mappings() needs these to be set
> +	 */
> +	mutex_lock(&group->mutex);
> +	group->default_domain = new_domain;
> +	group->domain = new_domain;
> +	mutex_unlock(&group->mutex);
> +
> +	iommu_group_ref_get(group);
> +
> +	list_for_each_entry_safe(grp_dev, temp, &group->devices, list) {
> +		struct device *dev;
> +
> +		dev = grp_dev->dev;
> +		iommu_release_device(dev);
> +
> +		ret = iommu_group_add_device(group, dev);
> +		if (ret)
> +			dev_err(dev, "Failed to add to iommu group %d: %d\n",
> +				group->id, ret);

Need to handle this error case.

> +
> +		ret = prv_dom->ops->add_device(dev);
> +		if (ret)
> +			dev_err(dev, "Error adding to iommu: %d\n", ret);

Ditto.

> +	}
> +
> +	iommu_group_put(group);
> +	iommu_domain_free(prv_dom);
> +	return 0;
> +}
> +
> +static int is_driver_bound(struct device *dev, void *not_used)
> +{
> +	int ret = 0;
> +
> +	device_lock(dev);
> +	if (device_is_bound(dev))
> +		ret = 1;
> +	device_unlock(dev);
> +	return ret;
> +}
> +
> +static ssize_t iommu_group_store_type(struct iommu_group *group,
> +				      const char *buf, size_t count)
> +{
> +	int ret = 0, req_type = 0, req_auto = 0;
> +	struct iommu_domain *prv_dom;
> +	struct group_device *grp_dev;
> +	const struct iommu_ops *ops;
> +	struct device *dev;
> +
> +	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
> +		return -EACCES;
> +
> +	if (WARN_ON(!group))
> +		return -EINVAL;
> +
> +	if (sysfs_streq(buf, "identity"))
> +		req_type = IOMMU_DOMAIN_IDENTITY;
> +	else if (sysfs_streq(buf, "DMA"))
> +		req_type = IOMMU_DOMAIN_DMA;
> +	else if (sysfs_streq(buf, "auto"))
> +		req_auto = 1;
> +	else
> +		return -EINVAL;
> +
> +	/*
> +	 * Check if any device in the group still has a driver binded to it.
> +	 * This might race with device driver probing code and unfortunately
> +	 * there is no clean way out of that either, locking all devices in the
> +	 * group and then do the re-attach will introduce a lock-inversion with
> +	 * group->mutex - Joerg.

Do you mean that we can't do below?

mutex_lock(&group->mutex);
for_each_group_device()
	device_lock(dev);

/* Default domain switch */
for_each_group_device()
	device_unlock()
mutex_unlock(&group->mutex)

> +	 */
> +	if (iommu_group_for_each_dev(group, NULL, is_driver_bound)) {
> +		pr_err("Active drivers exist for devices in the group\n");
> +		return -EBUSY;
> +	}
> +
> +	mutex_lock(&group->mutex);
> +	prv_dom = group->default_domain;
> +	if (!prv_dom || !prv_dom->ops || !prv_dom->ops->dev_def_domain_type) {
> +		pr_err("'dev_def_domain_type' call back isn't registered\n");
> +		ret = -EPERM;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Check if any user level driver (that doesn't use kernel driver like
> +	 * VFIO) is directly using the group. VFIO use case is detected by
> +	 * is_driver_bound() check above
> +	 */
> +	if (prv_dom != group->domain) {
> +		pr_err("Group assigned to user level for direct access\n");
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	/*
> +	 * If user has requested "auto", kernel has to decide the default domain
> +	 * type of a group. Hence, find out individual preferences of a device.
> +	 */
> +	ops = prv_dom->ops;
> +	if (req_auto) {
> +		int dma_devs = 0, idt_devs = 0, dev_def_dom;
> +
> +		list_for_each_entry(grp_dev, &group->devices, list) {
> +			dev = grp_dev->dev;
> +			dev_def_dom = ops->dev_def_domain_type(dev);
> +			if (dev_def_dom == IOMMU_DOMAIN_IDENTITY)
> +				idt_devs++;
> +			if (dev_def_dom == IOMMU_DOMAIN_DMA)
> +				dma_devs++;
> +		}
> +
> +		/*
> +		 * Default domain type of a group is undefined if some devices
> +		 * in the group should be in dma domain while other devices
> +		 * should be in identity domain
> +		 */
> +		if (idt_devs && dma_devs) {
> +			pr_err("Some devices need identity domain while other need dma domain\n");
> +			ret = -EPERM;
> +			goto out;
> +		}
> +
> +		/*
> +		 * Default domain type of a group is identity if
> +		 * 1. All the devices in the group need to be in identity domain
> +		 * 2. Some devices should be in identity domain while other
> +		 *    devices could be in either of dma or identity domain
> +		 */
> +		if (idt_devs && !dma_devs)
> +			req_type = IOMMU_DOMAIN_IDENTITY;
> +
> +		/*
> +		 * Default domain type of a group is dma if
> +		 * 1. All the devices in the group need to be in dma domain
> +		 * 2. Some devices should be in dma domain while other devices
> +		 *    could be in either of dma or identity domain
> +		 * 3. All the devices could be in either of the domains (namely
> +		 *    dma and identity)
> +		 */
> +		if (!idt_devs)
> +			req_type = IOMMU_DOMAIN_DMA;

Actually, There are four combinations:

			idt_devs==0		idt_devs!=0
dma_devs == 0		iommu_def_domain_type	identity		
dma_devs != 0		DMA			unsupported	

> +	}
> +
> +	/*
> +	 * Switch to a new domain only if the requested domain type is different
> +	 * from the existing default domain type
> +	 */
> +	if (prv_dom->type == req_type)
> +		goto out;
> +
> +	/*
> +	 * Every device may not support both the domain types (namely DMA and
> +	 * identity), so check if it's ok to change domain type of every device
> +	 * in the group to the requested domain. This check is not required if
> +	 * user has requested "auto" because it's already done above implicitly.
> +	 */
> +	if (!req_auto) {
> +		list_for_each_entry(grp_dev, &group->devices, list) {
> +			int allowed_types;
> +
> +			dev = grp_dev->dev;
> +			allowed_types = ops->dev_def_domain_type(dev);
> +			if (allowed_types && allowed_types != req_type) {
> +				dev_err(dev, "Cannot be in %s domain\n", buf);
> +				ret = -EPERM;
> +				goto out;
> +			}
> +		}
> +	}
> +
> +	mutex_unlock(&group->mutex);
> +	ret = iommu_group_change_def_domain(group, prv_dom, req_type);

Why do you want to put group->mutex before do the real domain switching?

> +	return ret ?: count;
> +out:
> +	mutex_unlock(&group->mutex);
> +	return ret ?: count;
> +}
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
