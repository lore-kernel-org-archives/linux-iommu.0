Return-Path: <SRS0=wYjh=EZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02999C5519F
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 02:25:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D5B4246B0
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 02:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5B4246B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B4D92872F0;
	Thu, 19 Nov 2020 02:25:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3PIhviDJhmsO; Thu, 19 Nov 2020 02:25:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 96917872ED;
	Thu, 19 Nov 2020 02:25:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76F06C0891;
	Thu, 19 Nov 2020 02:25:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9FADC07FF
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 02:25:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A04C88638F
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 02:25:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yVY2FiFyP399 for <iommu@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 02:25:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 635788618D
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 02:25:17 +0000 (UTC)
IronPort-SDR: 87w1MFvRorJzDbRnjxuI3uHMDnSotDNs1n3P4eJwShkcdiKaC76IJKxo7JWFhcIjxc4EjdDHgv
 9FoRjYljqsHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="171318741"
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; d="scan'208";a="171318741"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2020 18:25:16 -0800
IronPort-SDR: Ib1CyAM7KTWfYsZGm2wGKEhTfXXdB/QTmuUktCrcuEWmUxM2/eWpLzrJx84m0dYdGQFTiRF4PS
 6Yt8+3FDBjSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; d="scan'208";a="431082326"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 18 Nov 2020 18:25:14 -0800
Subject: Re: [Patch V8 1/3] iommu: Add support to change default domain of an
 iommu group
To: Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>
References: <20200925190620.18732-1-ashok.raj@intel.com>
 <20200925190620.18732-2-ashok.raj@intel.com>
 <20201118135153.GB2177@willie-the-truck>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <568d4dee-ad10-ca4f-d51a-8909afb6b782@linux.intel.com>
Date: Thu, 19 Nov 2020 10:18:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201118135153.GB2177@willie-the-truck>
Content-Language: en-US
Cc: Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org,
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

Hi Will,

The original author of this patch series has left Intel. I am now the
backup.

On 11/18/20 9:51 PM, Will Deacon wrote:
> On Fri, Sep 25, 2020 at 12:06:18PM -0700, Ashok Raj wrote:
>> From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
>>
>> Presently, the default domain of an iommu group is allocated during boot
>> time and it cannot be changed later. So, the device would typically be
>> either in identity (also known as pass_through) mode or the device would be
>> in DMA mode as long as the machine is up and running. There is no way to
>> change the default domain type dynamically i.e. after booting, a device
>> cannot switch between identity mode and DMA mode.
>>
>> But, assume a use case wherein the user trusts the device and believes that
>> the OS is secure enough and hence wants *only* this device to bypass IOMMU
>> (so that it could be high performing) whereas all the other devices to go
>> through IOMMU (so that the system is protected). Presently, this use case
>> is not supported. It will be helpful if there is some way to change the
>> default domain of an iommu group dynamically. Hence, add such support.
>>
>> A privileged user could request the kernel to change the default domain
>> type of a iommu group by writing to
>> "/sys/kernel/iommu_groups/<grp_id>/type" file. Presently, only three values
>> are supported
>> 1. identity: all the DMA transactions from the device in this group are
>>               *not* translated by the iommu
>> 2. DMA: all the DMA transactions from the device in this group are
>>          translated by the iommu
>> 3. auto: change to the type the device was booted with
>>
>> Note:
>> 1. Default domain of an iommu group with two or more devices cannot be
>>     changed.
>> 2. The device in the iommu group shouldn't be bound to any driver.
>> 3. The device shouldn't be assigned to user for direct access.
>> 4. The vendor iommu driver is required to add def_domain_type() callback.
>>     The change request will fail if the request type conflicts with that
>>     returned from the callback.
>>
>> Please see "Documentation/ABI/testing/sysfs-kernel-iommu_groups" for more
>> information.
>>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
>> Cc: Sohil Mehta <sohil.mehta@intel.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
>> ---
>>   drivers/iommu/iommu.c | 225 +++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 224 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 6c14c88cd525..2e93c48ce248 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -93,6 +93,8 @@ static void __iommu_detach_group(struct iommu_domain *domain,
>>   static int iommu_create_device_direct_mappings(struct iommu_group *group,
>>   					       struct device *dev);
>>   static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
>> +static ssize_t iommu_group_store_type(struct iommu_group *group,
>> +				      const char *buf, size_t count);
>>   
>>   #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
>>   struct iommu_group_attribute iommu_group_attr_##_name =		\
>> @@ -525,7 +527,8 @@ static IOMMU_GROUP_ATTR(name, S_IRUGO, iommu_group_show_name, NULL);
>>   static IOMMU_GROUP_ATTR(reserved_regions, 0444,
>>   			iommu_group_show_resv_regions, NULL);
>>   
>> -static IOMMU_GROUP_ATTR(type, 0444, iommu_group_show_type, NULL);
>> +static IOMMU_GROUP_ATTR(type, 0644, iommu_group_show_type,
>> +			iommu_group_store_type);
>>   
>>   static void iommu_group_release(struct kobject *kobj)
>>   {
>> @@ -2849,3 +2852,223 @@ int iommu_sva_get_pasid(struct iommu_sva *handle)
>>   	return ops->sva_get_pasid(handle);
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
>> +
>> +/*
>> + * Changes the default domain of an iommu group that has *only* one device
>> + *
>> + * @group: The group for which the default domain should be changed
>> + * @prev_dev: The device in the group (this is used to make sure that the device
>> + *	 hasn't changed after the caller has called this function)
>> + * @type: The type of the new default domain that gets associated with the group
>> + *
>> + * Returns 0 on success and error code on failure
>> + *
>> + * Note:
>> + * 1. Presently, this function is called only when user requests to change the
>> + *    group's default domain type through /sys/kernel/iommu_groups/<grp_id>/type
>> + *    Please take a closer look if intended to use for other purposes.
>> + */
>> +static int iommu_change_dev_def_domain(struct iommu_group *group,
>> +				       struct device *prev_dev, int type)
>> +{
>> +	struct iommu_domain *prev_dom;
>> +	struct group_device *grp_dev;
>> +	const struct iommu_ops *ops;
>> +	int ret, dev_def_dom;
>> +	struct device *dev;
>> +
>> +	if (!group)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&group->mutex);
>> +
>> +	if (group->default_domain != group->domain) {
>> +		pr_err_ratelimited("Group not assigned to default domain\n");
> 
> This error is lacking any context. Can we use dev_err_ratelimited to make
> it a bit more useful? Same for the other errors you're adding in this
> function.

Yes. dev_err_ratelimited() is better. Will replace all of them.

> 
>> +		ret = -EBUSY;
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * iommu group wasn't locked while acquiring device lock in
>> +	 * iommu_group_store_type(). So, make sure that the device count hasn't
>> +	 * changed while acquiring device lock.
>> +	 *
>> +	 * Changing default domain of an iommu group with two or more devices
>> +	 * isn't supported because there could be a potential deadlock. Consider
>> +	 * the following scenario. T1 is trying to acquire device locks of all
>> +	 * the devices in the group and before it could acquire all of them,
>> +	 * there could be another thread T2 (from different sub-system and use
>> +	 * case) that has already acquired some of the device locks and might be
>> +	 * waiting for T1 to release other device locks.
>> +	 */
>> +	if (iommu_group_device_count(group) != 1) {
>> +		pr_err_ratelimited("Cannot change default domain: Group has more than one device\n");
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	/* Since group has only one device */
>> +	grp_dev = list_first_entry(&group->devices, struct group_device, list);
>> +	dev = grp_dev->dev;
>> +
>> +	if (prev_dev != dev) {
>> +		pr_err_ratelimited("Cannot change default domain: Device has been changed\n");
>> +		ret = -EBUSY;
>> +		goto out;
>> +	}
>> +
>> +	prev_dom = group->default_domain;
>> +	if (!prev_dom || !prev_dom->ops || !prev_dom->ops->def_domain_type) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	ops = prev_dom->ops;
>> +	dev_def_dom = ops->def_domain_type(dev);
>> +
>> +	/* Check if user requested domain is supported by the device or not */
>> +	if (!type) {
>> +		/*
>> +		 * If the user hasn't requested any specific type of domain and
>> +		 * if the device supports both the domains, then default to the
>> +		 * domain the device was booted with
>> +		 */
>> +		type = dev_def_dom ?: iommu_def_domain_type;
>> +	} else if (dev_def_dom && type != dev_def_dom) {
>> +		pr_err_ratelimited("Device cannot be in %s domain\n",
>> +				   iommu_domain_type_str(type));
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
> 
> Can we replace this with iommu_get_def_domain_type() ?

Of cause. I will do.

> 
>> +
>> +	/*
>> +	 * Switch to a new domain only if the requested domain type is different
>> +	 * from the existing default domain type
>> +	 */
>> +	if (prev_dom->type == type) {
>> +		ret = 0;
>> +		goto out;
>> +	}
>> +
>> +	/* Sets group->default_domain to the newly allocated domain */
>> +	ret = iommu_group_alloc_default_domain(dev->bus, group, type);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret = iommu_create_device_direct_mappings(group, dev);
>> +	if (ret)
>> +		goto free_new_domain;
>> +
>> +	ret = __iommu_attach_device(group->default_domain, dev);
>> +	if (ret)
>> +		goto free_new_domain;
>> +
>> +	group->domain = group->default_domain;
>> +
>> +	/*
>> +	 * Release the mutex here because ops->probe_finalize() call-back of
>> +	 * some vendor IOMMU drivers calls arm_iommu_attach_device() which
>> +	 * in-turn might call back into IOMMU core code, where it tries to take
>> +	 * group->mutex, resulting in a deadlock.
>> +	 */
>> +	mutex_unlock(&group->mutex);
>> +
>> +	/* Make sure dma_ops is appropriatley set */
>> +	iommu_group_do_probe_finalize(dev, group->default_domain);
>> +	iommu_domain_free(prev_dom);
>> +	return 0;
>> +
>> +free_new_domain:
>> +	iommu_domain_free(group->default_domain);
>> +	group->default_domain = prev_dom;
>> +	group->domain = prev_dom;i
> 
> Hmm. This seems to rely on all users of group->default_domain holding the
> group->mutex. Have you confirmed that this is the case? There's a funny
> use of iommu_group_get() in the exynos IOMMU driver at least.

Emm. This change happens within the area with group->mutex held. Or I
am not getting your point?

+free_new_domain:
+	iommu_domain_free(group->default_domain);
+	group->default_domain = prev_dom;
+	group->domain = prev_dom;
+
+out:
+	mutex_unlock(&group->mutex);
+
+	return ret;

> 
> Will

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
