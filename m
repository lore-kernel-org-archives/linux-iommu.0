Return-Path: <SRS0=cxdO=AM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751EAC433DF
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 03:04:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30CF9206B6
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 03:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30CF9206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A320B25CBB;
	Wed,  1 Jul 2020 03:04:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bchUkAnpNUnL; Wed,  1 Jul 2020 03:04:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 601CD2544B;
	Wed,  1 Jul 2020 03:04:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42E56C088F;
	Wed,  1 Jul 2020 03:04:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D8A8C016E
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 03:04:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4C097889D4
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 03:04:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PwVM+O3fg2Jm for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jul 2020 03:04:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1933388AD8
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 03:04:28 +0000 (UTC)
IronPort-SDR: XuP74u1/l5BfZDK3ihEvl9yjlvLptH9SsO2G5ckbdAEAbTdk/VnzQaMsKWQurmx24qN91jxq96
 sQoAal8iYhQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="207964808"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; d="scan'208";a="207964808"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2020 20:04:26 -0700
IronPort-SDR: QtsvfEy9ysQT+p/717wpwDWZ6bRKI8eyVmQihmji50NiMzU/dqJ03vyyGGNsBYmplH3yYDHTPQ
 viTu9oEDU0lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; d="scan'208";a="266639598"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
 by fmsmga008.fm.intel.com with ESMTP; 30 Jun 2020 20:04:25 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.167]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.232]) with mapi id 14.03.0439.000;
 Tue, 30 Jun 2020 20:04:25 -0700
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH V4 1/3] iommu: Add support to change default domain of
 an iommu group
Thread-Topic: [PATCH V4 1/3] iommu: Add support to change default domain of
 an iommu group
Thread-Index: AQHWOtmTukvBBP3jY0KXbmuvXXR7xajxfcqAgACfu2A=
Date: Wed, 1 Jul 2020 03:04:24 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F573D8042@ORSMSX114.amr.corp.intel.com>
References: <cover.1591290586.git.sai.praneeth.prakhya@intel.com>
 <3d7f5cf067437593e681751108860ea692bb10b1.1591290586.git.sai.praneeth.prakhya@intel.com>
 <20200630091601.GB28824@8bytes.org>
In-Reply-To: <20200630091601.GB28824@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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

Hi Joerg,

> -----Original Message-----
> From: Joerg Roedel <joro@8bytes.org>
> Sent: Tuesday, June 30, 2020 2:16 AM
> To: Prakhya, Sai Praneeth <sai.praneeth.prakhya@intel.com>
> Cc: iommu@lists.linux-foundation.org; Christoph Hellwig <hch@lst.de>; Raj,
> Ashok <ashok.raj@intel.com>; Will Deacon <will.deacon@arm.com>; Lu Baolu
> <baolu.lu@linux.intel.com>; Mehta, Sohil <sohil.mehta@intel.com>; Robin
> Murphy <robin.murphy@arm.com>; Jacob Pan <jacob.jun.pan@linux.intel.com>
> Subject: Re: [PATCH V4 1/3] iommu: Add support to change default domain of
> an iommu group
> 
> On Thu, Jun 04, 2020 at 06:32:06PM -0700, Sai Praneeth Prakhya wrote:
> > +static int iommu_change_dev_def_domain(struct iommu_group *group, int
> > +type) {
> > +	struct iommu_domain *prev_dom;
> > +	struct group_device *grp_dev;
> > +	const struct iommu_ops *ops;
> > +	int ret, dev_def_dom;
> > +	struct device *dev;
> > +
> > +	if (!group)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&group->mutex);
> > +
> > +	if (group->default_domain != group->domain) {
> > +		pr_err_ratelimited("Group assigned to user level for direct
> > +access\n");
> 
> Make this message: "Group not assigned to default domain\n".

Sure! I will change it

> > +		ret = -EBUSY;
> > +		goto out;
> > +	}
> > +
> > +	/*
> > +	 * iommu group wasn't locked while acquiring device lock in
> > +	 * iommu_group_store_type(). So, make sure that the device count
> hasn't
> > +	 * changed while acquiring device lock.
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
> > +	if (iommu_group_device_count(group) != 1) {
> > +		pr_err_ratelimited("Cannot change default domain of a group
> with
> > +two or more devices\n");
> 
> "Can not change default domain: Group has more than one device\n"

Ok.. make sense. I will change this.

> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	/* Since group has only one device */
> > +	list_for_each_entry(grp_dev, &group->devices, list)
> > +		dev = grp_dev->dev;
> > +
> > +	prev_dom = group->default_domain;
> > +	if (!prev_dom || !prev_dom->ops || !prev_dom->ops-
> >def_domain_type) {
> > +		pr_err_ratelimited("'def_domain_type' call back isn't
> > +registered\n");
> 
> This message isn't needed.

Ok. I will remove it.

> > +	ret = __iommu_attach_device(group->default_domain, dev);
> > +	if (ret)
> > +		goto free_new_domain;
> > +
> > +	group->domain = group->default_domain;
> > +
> > +	ret = iommu_create_device_direct_mappings(group, dev);
> > +	if (ret)
> > +		goto free_new_domain;
> 
> You need to create the direct mappings before you attach the device to the new
> domain. Otherwise there might be a short time-window where RMRR regions
> are not mapped.

Ok.. makes sense. I will change this accordingly.

> > +static ssize_t iommu_group_store_type(struct iommu_group *group,
> > +				      const char *buf, size_t count) {
> > +	struct group_device *grp_dev;
> > +	struct device *dev;
> > +	int ret, req_type;
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
> > +		req_type = 0;
> > +	else
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Lock/Unlock the group mutex here before device lock to
> > +	 * 1. Make sure that the iommu group has only one device (this is a
> > +	 *    prerequisite for step 2)
> > +	 * 2. Get struct *dev which is needed to lock device
> > +	 */
> > +	mutex_lock(&group->mutex);
> > +	if (iommu_group_device_count(group) != 1) {
> > +		mutex_unlock(&group->mutex);
> > +		pr_err_ratelimited("Cannot change default domain of a group
> with two or more devices\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Since group has only one device */
> > +	list_for_each_entry(grp_dev, &group->devices, list)
> > +		dev = grp_dev->dev;
> 
> Please use list_first_entry().

Ok.

> You also need to take a reference with get_device() and then drop the
> group->mutex.

Sure! I will change it.

> After device_lock() you need to verify that the device is still in the same group
> and that the group has still only one device in it.

Presently, iommu_change_dev_def_domain() checks if the iommu group still has
only one device or not. Hence, checking if iommu group has one device or not is done
twice, once before taking device_lock() and the other, after taking device_lock().

I agree that the code isn't checking if the iommu group still has the _same_ device or not.
One way, I could think of doing it is by storing "dev" temporarily and checking for it.
Do you think that's ok? Or would you rather suggest something else?

> Then you can call down to
> iommu_change_dev_def_domain() which does not need to take the group-
> mutex by itself.

The reason for taking iommu_group->mutex in the beginning of
iommu_change_dev_def_domain() is that the function

1. Checks if the group is being directly used by user level drivers
(i.e. if (group->default_domain != group->domain))

2. Uses iommu_ops
(prev_dom = group->default_domain;
if (!prev_dom || !prev_dom->ops || !prev_dom->ops->def_domain_type))

3. Sets iomu_group->domain to iommu_group->default_domain

I wanted to make sure that iommu_group->domain and
iommu_group->default_domain aren't changed by some other thread
while this thread is working on it. So, please let me know if I misunderstood something.

Regards,
Sai
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
