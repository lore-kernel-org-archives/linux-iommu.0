Return-Path: <SRS0=ta7q=7L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594D2C433E0
	for <iommu@archiver.kernel.org>; Fri, 29 May 2020 08:15:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246A1207BC
	for <iommu@archiver.kernel.org>; Fri, 29 May 2020 08:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246A1207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D53F2873FE;
	Fri, 29 May 2020 08:15:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id llzzjXH4dKty; Fri, 29 May 2020 08:15:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 62424873F3;
	Fri, 29 May 2020 08:15:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47796C088A;
	Fri, 29 May 2020 08:15:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14DAFC016F
 for <iommu@lists.linux-foundation.org>; Fri, 29 May 2020 08:15:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0F06E8934C
 for <iommu@lists.linux-foundation.org>; Fri, 29 May 2020 08:15:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rv24gJ4O4kXJ for <iommu@lists.linux-foundation.org>;
 Fri, 29 May 2020 08:15:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6C85F8203A
 for <iommu@lists.linux-foundation.org>; Fri, 29 May 2020 08:15:05 +0000 (UTC)
IronPort-SDR: Sp50WDDpwp+cq90DvFrT3tJ2CP8xQKw3J+yI1tCQopVAUkxjDafhHvTu8KPQICHxtoSUmNcHit
 BvyTp/RmjNAA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2020 01:15:04 -0700
IronPort-SDR: DDjgCYBU4tVn8J08IFKGlV+ahYyrpgE8+3pRHkzmriTgNtZZ0TijZSIxw+3SGA5WC9mKnlQjVI
 zums7uMRyOsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,447,1583222400"; d="scan'208";a="302762911"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
 by fmsmga002.fm.intel.com with ESMTP; 29 May 2020 01:15:04 -0700
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 29 May 2020 01:15:03 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.205]) by
 ORSMSX115.amr.corp.intel.com ([169.254.4.3]) with mapi id 14.03.0439.000;
 Fri, 29 May 2020 01:15:03 -0700
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH V3 1/3] iommu: Add support to change default domain of
 an iommu_group
Thread-Topic: [PATCH V3 1/3] iommu: Add support to change default domain of
 an iommu_group
Thread-Index: AQHWNSX5hlX1aBxI2U6/NBo1bvzkgai+0MoA//+xakA=
Date: Fri, 29 May 2020 08:15:03 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F573BC731@ORSMSX114.amr.corp.intel.com>
References: <cover.1590686413.git.sai.praneeth.prakhya@intel.com>
 <c76e3912c49d5a28bd9c8c30fb35d546a2f26724.1590686413.git.sai.praneeth.prakhya@intel.com>
 <f7a5d302-2dbe-29bd-0d1b-4560c6ae4688@linux.intel.com>
In-Reply-To: <f7a5d302-2dbe-29bd-0d1b-4560c6ae4688@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Baolu,

> -----Original Message-----
> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, May 28, 2020 7:43 PM
> To: Prakhya, Sai Praneeth <sai.praneeth.prakhya@intel.com>;
> iommu@lists.linux-foundation.org
> Cc: baolu.lu@linux.intel.com; Christoph Hellwig <hch@lst.de>; Joerg Roedel
> <joro@8bytes.org>; Raj, Ashok <ashok.raj@intel.com>; Will Deacon
> <will.deacon@arm.com>; Mehta, Sohil <sohil.mehta@intel.com>; Robin
> Murphy <robin.murphy@arm.com>; Jacob Pan <jacob.jun.pan@linux.intel.com>
> Subject: Re: [PATCH V3 1/3] iommu: Add support to change default domain of
> an iommu_group
> 
> Hi Sai,
> 
> On 5/29/20 3:23 AM, Sai Praneeth Prakhya wrote:
> > Presently, the default domain of an iommu_group is allocated during
> > boot time (i.e. when a device is being added to a group) and it cannot
> > be
>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> This is inaccurate as Joerg's code has deferred default domain allocation and
> attaching after group allocation. I'd suggest to remove this.

Ok.. makes sense. I will remove it. I think it should have been like below to accurately describe Joerg's changes, is that correct?

"Presently, the default domain of an iommu_group is allocated during
boot time (i.e. during device probe and after the device is added to a group) and it cannot
be"
 
> > changed later. So, the device would typically be either in identity
> > (also known as pass_through) mode (controlled by "iommu=pt" kernel
> > command line
>                                                ^^^^^^^^
> 
> There are other kernel parameters to put device in pass_through mode.
> I'd suggest to remove this.

Ok.. makes sense. I will remove it.
I think, you were talking about ARM parameters (iommu.passthrough).. am I right?

> > argument) or the device would be in DMA mode as long as the machine is
> > up and running. There is no way to change the default domain type
> > dynamically i.e. after booting, a device cannot switch between
> > identity mode and DMA mode.
> >
> > But, assume a use case wherein the user trusts the device and believes
> > that the OS is secure enough and hence wants *only* this device to
> > bypass IOMMU (so that it could be high performing) whereas all the
> > other devices to go through IOMMU (so that the system is protected).
> > Presently, this use case is not supported. It will be helpful if there
> > is some way to change the default domain of a B:D.F dynamically. Hence, add
> such support.
>    ^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Currently default domain is per iommu_group, we have no per device default
> domain yet. Probably, "default domain of an iommu group"?

Makes sense. I will change it.

> > A privileged user could request the kernel to change the default
> > domain type of a iommu_group by writing to
> > "/sys/kernel/iommu_groups/<grp_id>/type" file. Presently, only three
> > values are supported 1. identity: all the DMA transactions from the
> > device in this group are
> >               *not* translated by the iommu 2. DMA: all the DMA
> > transactions from the device in this group are
> >          translated by the iommu
> > 3. auto: change to the type the device was booted with
> >
> > Note:
> > 1. Default domain of an iommu group with two or more devices cannot be
> >     changed.
> > 2. The device in the iommu group shouldn't be bound to any driver.
> > 3. The device shouldn't be assigned to user for direct access.
> >
> > Please see "Documentation/ABI/testing/sysfs-kernel-iommu_groups" for
> > more information.
> >
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Ashok Raj <ashok.raj@intel.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Cc: Sohil Mehta <sohil.mehta@intel.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> > ---
> >   drivers/iommu/iommu.c | 211
> +++++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 210 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c index
> > a4c2f122eb8b..2b6cca799055 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -92,6 +92,8 @@ static void __iommu_detach_group(struct
> iommu_domain *domain,
> >   static int iommu_create_device_direct_mappings(struct iommu_group
> *group,
> >   					       struct device *dev);
> >   static struct iommu_group *iommu_group_get_for_dev(struct device
> > *dev);
> > +static ssize_t iommu_group_store_type(struct iommu_group *group,
> > +				      const char *buf, size_t count);
> >
> >   #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)
> 	\
> >   struct iommu_group_attribute iommu_group_attr_##_name =		\
> > @@ -524,7 +526,8 @@ static IOMMU_GROUP_ATTR(name, S_IRUGO,
> iommu_group_show_name, NULL);
> >   static IOMMU_GROUP_ATTR(reserved_regions, 0444,
> >   			iommu_group_show_resv_regions, NULL);
> >
> > -static IOMMU_GROUP_ATTR(type, 0444, iommu_group_show_type, NULL);
> > +static IOMMU_GROUP_ATTR(type, 0644, iommu_group_show_type,
> > +			iommu_group_store_type);
> >
> >   static void iommu_group_release(struct kobject *kobj)
> >   {
> > @@ -2847,3 +2850,209 @@ int iommu_sva_get_pasid(struct iommu_sva
> *handle)
> >   	return ops->sva_get_pasid(handle);
> >   }
> >   EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
> > +
> > +/*
> > + * Changes the default domain of a device
> > + *
> > + * @dev: The *only* device in the group
> 
> All devices in a group have been linked in group->devices, so you don't need to
> pass it in as a parameter. Otherwise, you also need some sanity check against
> @dev, right?

Yes, I agree that we could get "dev" from group->devices. But, I passed it as a parameter because it's already done by iommu_group_store_type() (as below) and I thought that I could save from duplicating code by passing it as a parameter. Also, iommu_change_dev_def_domain() is presently just a helper function (and not an API) for iommu_group_store_type() and hence thought that error checking for "dev" (i.e. if (!dev)) is not needed in iommu_change_dev_def_domain() because iommu_group_store_type()  may never pass a null value.

/* Since group has only one device */
list_for_each_entry(grp_dev, &group->devices, list)
	dev = grp_dev->dev;

Just wanted to put out the rationale behind why I decided to go this way rather than getting "dev" from group->devices. Please let me know if you think otherwise, I am happy to change it.

> > + * @group: The group for which the default domain should be changed
> > + * @prev_domain: The previous domain that is being switched from
> 
> The same as @dev, the default domain in use is saved in
> group->default_domain. No need a separated parameter to save space and
> sanity check.

Same as above. Just wanted to avoid the below check as it's already done by iommu_group_store_type()
if (group->default_domain)
	prev_dom = group->default_domain;

I am happy to change it if you prefer to see less parameters.

> > + * @type: The type of the new default domain that gets associated
> > + with the group
> > + *
> > + * Returns 0 on success and error code on failure
> > + *
> > + * Note:
> > + * 1. Presently, this function is called only when user requests to change the
> > + *    group's default domain type through
> /sys/kernel/iommu_groups/<grp_id>/type
> > + *    Please take a closer look if intended to use for other purposes.
> > + * 2. Assumes that group->mutex is already taken and releases before
> > + returning
> 
> You could assume that the caller should hold the group->mutex and shouldn't be
> released in this helper. A reference design could be found here.
> 
> https://lkml.org/lkml/2020/3/13/1164

Ok. I have looked at it.. and it does hold group mutex.
Just wondering if you would like me to change anything here?

> > + */
> > +static int iommu_change_dev_def_domain(struct device *dev,
> > +				       struct iommu_group *group,
> > +				       struct iommu_domain *prev_dom, int type)
> {
> > +	int ret = 0;
> > +
> > +	/* Sets group->default_domain to the newly allocated domain */
> > +	ret = iommu_group_alloc_default_domain(dev->bus, group, type);
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = __iommu_attach_device(group->default_domain, dev);
> > +	if (ret)
> > +		goto free_new_domain;
> > +
> > +	group->domain = group->default_domain;
> > +
> > +	ret = iommu_create_device_direct_mappings(group, dev);
> > +	if (ret)
> > +		goto free_new_domain;
> > +
> > +	/*
> > +	 * Release the mutex here because ops->probe_finalize() call-back of
> > +	 * some vendor IOMMU drivers calls arm_iommu_attach_device() which
> > +	 * in-turn might call back into IOMMU core code, where it tries to take
> > +	 * group->mutex, resulting in a deadlock.
> > +	 */
> > +	mutex_unlock(&group->mutex);
> > +
> > +	/* Make sure dma_ops is appropriatley set */
> > +	iommu_group_do_probe_finalize(dev, group->default_domain);
> > +	iommu_domain_free(prev_dom);
> > +	return 0;
> > +
> > +free_new_domain:
> > +	iommu_domain_free(group->default_domain);
> > +	group->default_domain = prev_dom;
> > +	group->domain = prev_dom;
> > +
> > +out:
> > +	mutex_unlock(&group->mutex);
> > +
> > +	return ret;
> > +}
> > +
> > +static ssize_t iommu_group_store_type(struct iommu_group *group,
> > +				      const char *buf, size_t count) {
> > +	int ret, req_type = 0, req_auto = 0, dev_def_dom;
> > +	struct iommu_domain *prev_dom;
> > +	struct group_device *grp_dev;
> > +	const struct iommu_ops *ops;
> > +	struct device *dev;
> > +
> > +	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
> > +		return -EACCES;
> > +
> > +	if (WARN_ON(!group))
> > +		return -EINVAL;
> > +
> > +	if (sysfs_streq(buf, "identity"))
> > +		req_type = IOMMU_DOMAIN_IDENTITY;
> > +	else if (sysfs_streq(buf, "DMA"))
> > +		req_type = IOMMU_DOMAIN_DMA;
> > +	else if (sysfs_streq(buf, "auto"))
> > +		req_auto = 1;
> 
> How about let req_type = 0 for auto case. This keeps it consistent with the
> return value of iommu_ops->def_domain_type(). With
> 
> if (!req_type)
> 	req_type = ops->def_domain_type(dev);
> 
> you don't need req_auto and dev_def_dom any more.

Please see below where you had comments for changing req_type.

> > +	else
> > +		return -EINVAL;
> > +
> > +	/* Lock the group to make sure that the device count doesn't change */
> > +	mutex_lock(&group->mutex);
> > +	if (iommu_group_device_count(group) != 1) {
> > +		mutex_unlock(&group->mutex);
> > +		pr_err("Cannot change default domain of a group with two or
> more devices\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Since group has only one device */
> > +	list_for_each_entry(grp_dev, &group->devices, list)
> > +		dev = grp_dev->dev;
> > +
> > +	/*
> > +	 * Don't hold onto the group mutex because taking group mutex first
> and
> > +	 * then the device lock could potentially cause a deadlock as below.
> > +	 * Assume two threads T1 and T2. T1 is trying to change default domain
> > +	 * of an iommu group and T2 is trying to hot unplug a device or release
> > +	 * [1] VF of a PCIe device which is in the same iommu group. T1 takes
> > +	 * group mutex and before it could take device lock assume T2 has taken
> > +	 * device lock and is yet to take group mutex. Now, both the threads
> > +	 * will be waiting for the other thread to release lock.
> > +	 *
> > +	 * [1] Typical device release path
> > +	 * device_lock() from device/driver core code
> > +	 *  -> bus_notifier()
> > +	 *   -> iommu_bus_notifier()
> > +	 *    -> iommu_release_device()
> > +	 *     -> ops->release_device() vendor driver calls back iommu core code
> > +	 *      -> mutex_lock() from iommu core code
> > +	 */
> > +	mutex_unlock(&group->mutex);
> 
> Since you only support single device group, how about
> 
> -> lock_device
>      -> lock group
>          -> change default domain
>      -> unlock group
> -> unlock device

Sure! I did the same thing below i.e. first take device_lock() and then take group mutex.
I acquired/released group mutex above to
1.  Verify that iommu group has only one device
2. Get "struct dev *" of that device.
Just wondering if you would like me to change anything here?

> > +
> > +	/* Check if the device in the group still has a driver bound to it */
> > +	device_lock(dev);
> > +	if (device_is_bound(dev)) {
> > +		pr_err("Device is still bound to driver\n");
> > +		ret = -EBUSY;
> > +		goto dev_unlock;
> > +	}
> > +
> > +	/*
> > +	 * iommu group wasn't locked while acquiring device lock. So, make
> sure
> > +	 * that the device count hasn't changed while acquiring device lock.
> > +	 *
> > +	 * Changing default domain of an iommu group with two or more
> devices
> > +	 * isn't supported because there could be a potential deadlock. Consider
> > +	 * the following scenario. T1 is trying to acquire device locks of all
> > +	 * the devices in the group and before it could acquire all of them,
> > +	 * there could be another thread T2 (from different sub-system and use
> > +	 * case) that has already acquired some of the device locks and might be
> > +	 * waiting for T1 to release other device locks.
> > +	 */
> > +	mutex_lock(&group->mutex);
> > +	if (iommu_group_device_count(group) != 1) {
> > +		pr_err("Cannot change default domain of a group with two or
> more devices\n");
> > +		ret = -EINVAL;
> > +		goto group_unlock;
> > +	}
> > +
> > +	/*
> > +	 * Check if any user level driver (that doesn't use kernel driver like
> > +	 * VFIO) is directly using the group. VFIO use case is detected by
> > +	 * device_is_bound() check above
> > +	 */
> > +	if (group->default_domain != group->domain) {
> > +		pr_err("Group assigned to user level for direct access\n");
> > +		ret = -EINVAL;
> 
> -EBUSY?

Ok.. I will change it.

> > +		goto group_unlock;
> > +	}
> > +
> > +	prev_dom = group->default_domain;
> > +	if (!prev_dom || !prev_dom->ops || !prev_dom->ops-
> >def_domain_type) {
> > +		pr_err("'def_domain_type' call back isn't registered\n");
> > +		ret = -EINVAL;
> > +		goto group_unlock;
> > +	}
> > +
> 
> --- start ---
> > +	ops = prev_dom->ops;
> > +	dev_def_dom = ops->def_domain_type(dev);
> > +
> > +	/* Check if user requested domain is supported by the device or not */
> > +	if (!req_auto && dev_def_dom && req_type != dev_def_dom) {
> > +		pr_err("Device cannot be in %s domain\n", buf);
> > +		ret = -EINVAL;
> > +		goto group_unlock;
> > +	}
> > +
> > +	if (req_auto) {
> > +		/*
> > +		 * If user requested "auto" and the device supports both the
> > +		 * domains, then default to the domain the device was booted
> > +		 * with
> > +		 */
> > +		if (!dev_def_dom)
> > +			req_type = iommu_def_domain_type;
> > +		else
> > +			req_type = dev_def_dom;
> > +	}
> --- end ---
> 
> Isn't this could could be simply replaced with:
> 
> if (!req_type)
> 	req_type = ops->default_domain_type(dev) ? :
> iommu_def_domain_type;

I think, replacing this has two issues
1. We might miss validating user request i.e. we need to make sure that when user requests for a specific type of domain (E.g: DMA), we need to validate that the device could actually be in that domain. This is done above by

/* Check if user requested domain is supported by the device or not */
if (!req_auto && dev_def_dom && req_type != dev_def_dom) {
	pr_err("Device cannot be in %s domain\n", buf);
	ret = -EINVAL;
	goto group_unlock;
}

2. req_type could end up having 0 if "ops->default_domain_type(dev)" returns 0.
But, after this point, req_type should _only_ be either DMA type or identity type and cannot be 0 because req_type is passed to iommu_ops->domain_alloc() to allocate domain of requested type and it cannot be 0.

Regards,
Sai
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
