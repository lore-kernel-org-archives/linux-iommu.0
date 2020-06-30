Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6707FC433E0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 09:16:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3330020675
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 09:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3330020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2B10F87C41;
	Tue, 30 Jun 2020 09:16:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QVHBiAsnn4sQ; Tue, 30 Jun 2020 09:16:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 008DC87CD2;
	Tue, 30 Jun 2020 09:16:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBAB0C0865;
	Tue, 30 Jun 2020 09:16:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42D1BC016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 09:16:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2DFF620026
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 09:16:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Ea9BUZ+IpVF for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 09:16:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 1C9A720023
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 09:16:05 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 0C39326B; Tue, 30 Jun 2020 11:16:03 +0200 (CEST)
Date: Tue, 30 Jun 2020 11:16:01 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: Re: [PATCH V4 1/3] iommu: Add support to change default domain of an
 iommu group
Message-ID: <20200630091601.GB28824@8bytes.org>
References: <cover.1591290586.git.sai.praneeth.prakhya@intel.com>
 <3d7f5cf067437593e681751108860ea692bb10b1.1591290586.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3d7f5cf067437593e681751108860ea692bb10b1.1591290586.git.sai.praneeth.prakhya@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Ashok Raj <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

On Thu, Jun 04, 2020 at 06:32:06PM -0700, Sai Praneeth Prakhya wrote:
> +static int iommu_change_dev_def_domain(struct iommu_group *group, int type)
> +{
> +	struct iommu_domain *prev_dom;
> +	struct group_device *grp_dev;
> +	const struct iommu_ops *ops;
> +	int ret, dev_def_dom;
> +	struct device *dev;
> +
> +	if (!group)
> +		return -EINVAL;
> +
> +	mutex_lock(&group->mutex);
> +
> +	if (group->default_domain != group->domain) {
> +		pr_err_ratelimited("Group assigned to user level for direct access\n");

Make this message: "Group not assigned to default domain\n".

> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	/*
> +	 * iommu group wasn't locked while acquiring device lock in
> +	 * iommu_group_store_type(). So, make sure that the device count hasn't
> +	 * changed while acquiring device lock.
> +	 *
> +	 * Changing default domain of an iommu group with two or more devices
> +	 * isn't supported because there could be a potential deadlock. Consider
> +	 * the following scenario. T1 is trying to acquire device locks of all
> +	 * the devices in the group and before it could acquire all of them,
> +	 * there could be another thread T2 (from different sub-system and use
> +	 * case) that has already acquired some of the device locks and might be
> +	 * waiting for T1 to release other device locks.
> +	 */
> +	if (iommu_group_device_count(group) != 1) {
> +		pr_err_ratelimited("Cannot change default domain of a group with two or more devices\n");

"Can not change default domain: Group has more than one device\n"

> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* Since group has only one device */
> +	list_for_each_entry(grp_dev, &group->devices, list)
> +		dev = grp_dev->dev;
> +
> +	prev_dom = group->default_domain;
> +	if (!prev_dom || !prev_dom->ops || !prev_dom->ops->def_domain_type) {
> +		pr_err_ratelimited("'def_domain_type' call back isn't registered\n");

This message isn't needed.

> +	ret = __iommu_attach_device(group->default_domain, dev);
> +	if (ret)
> +		goto free_new_domain;
> +
> +	group->domain = group->default_domain;
> +
> +	ret = iommu_create_device_direct_mappings(group, dev);
> +	if (ret)
> +		goto free_new_domain;

You need to create the direct mappings before you attach the device to
the new domain. Otherwise there might be a short time-window where RMRR
regions are not mapped.

> +static ssize_t iommu_group_store_type(struct iommu_group *group,
> +				      const char *buf, size_t count)
> +{
> +	struct group_device *grp_dev;
> +	struct device *dev;
> +	int ret, req_type;
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
> +		req_type = 0;
> +	else
> +		return -EINVAL;
> +
> +	/*
> +	 * Lock/Unlock the group mutex here before device lock to
> +	 * 1. Make sure that the iommu group has only one device (this is a
> +	 *    prerequisite for step 2)
> +	 * 2. Get struct *dev which is needed to lock device
> +	 */
> +	mutex_lock(&group->mutex);
> +	if (iommu_group_device_count(group) != 1) {
> +		mutex_unlock(&group->mutex);
> +		pr_err_ratelimited("Cannot change default domain of a group with two or more devices\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Since group has only one device */
> +	list_for_each_entry(grp_dev, &group->devices, list)
> +		dev = grp_dev->dev;

Please use list_first_entry().
       
You also need to take a reference with get_device() and then drop the
group->mutex.

After device_lock() you need to verify that the device is still in the
same group and that the group has still only one device in it. Then you
can call down to iommu_change_dev_def_domain() which does not need to
take the group-mutex by itself.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
