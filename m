Return-Path: <SRS0=v902=AZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE3EC433E0
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F6FF223C6
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6FF223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 34DE887DF1;
	Tue, 14 Jul 2020 18:24:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id emY4YnEwmFGc; Tue, 14 Jul 2020 18:24:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 484CF87DE8;
	Tue, 14 Jul 2020 18:24:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B1FDC0888;
	Tue, 14 Jul 2020 18:24:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DE6AC0733
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 18:24:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EC50E89904
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 18:24:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eSKx5Wecc5YY for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jul 2020 18:24:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 01696898E2
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 18:23:59 +0000 (UTC)
IronPort-SDR: jguPGUBU6pCp/apq3Ub/OtbQpQyU7/O3/nFqUccFhY605TLcmz9tu2ki4zkE/eyoMWn/KQSDMv
 ozWSNQkd5kVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="148998317"
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800"; d="scan'208";a="148998317"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 11:23:59 -0700
IronPort-SDR: yNMA+u7GYO9qhbZluVuE5ZqROYtqaExlhPdQcKy4gGjyA9C8A1HfL7fem6ETRxDvEbJLrZZB+l
 jy5hgUuZTXsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800"; d="scan'208";a="324623275"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
 by FMSMGA003.fm.intel.com with ESMTP; 14 Jul 2020 11:23:58 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jul 2020 11:23:54 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.167]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.81]) with mapi id 14.03.0439.000;
 Tue, 14 Jul 2020 11:23:54 -0700
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>, Joerg Roedel
 <joro@8bytes.org>
Subject: RE: [PATCH V4 1/3] iommu: Add support to change default domain of
 an iommu group
Thread-Topic: [PATCH V4 1/3] iommu: Add support to change default domain of
 an iommu group
Thread-Index: AQHWOtmTukvBBP3jY0KXbmuvXXR7xajxfcqAgACfu2CAFYPMwA==
Date: Tue, 14 Jul 2020 18:23:54 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F573DB164@ORSMSX114.amr.corp.intel.com>
References: <cover.1591290586.git.sai.praneeth.prakhya@intel.com>
 <3d7f5cf067437593e681751108860ea692bb10b1.1591290586.git.sai.praneeth.prakhya@intel.com>
 <20200630091601.GB28824@8bytes.org>
 <FFF73D592F13FD46B8700F0A279B802F573D8042@ORSMSX114.amr.corp.intel.com>
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F573D8042@ORSMSX114.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
MIME-Version: 1.0
Cc: Robin Murphy <robin.murphy@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Will Deacon <will.deacon@arm.com>, "Raj, Ashok" <ashok.raj@intel.com>,
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

Hi Joerg,

Replying again because I noticed that I couldn't find this mail in the external iommu mailing list while I was able to find your comments on my patch. Also, could you please answer my two questions below?

> -----Original Message-----
> From: iommu <iommu-bounces@lists.linux-foundation.org> On Behalf Of
> Prakhya, Sai Praneeth
> Sent: Tuesday, June 30, 2020 8:04 PM
> To: Joerg Roedel <joro@8bytes.org>
> Cc: Raj, Ashok <ashok.raj@intel.com>; Will Deacon <will.deacon@arm.com>;
> iommu@lists.linux-foundation.org; Robin Murphy <robin.murphy@arm.com>;
> Christoph Hellwig <hch@lst.de>
> Subject: RE: [PATCH V4 1/3] iommu: Add support to change default domain of
> an iommu group
> 
> Hi Joerg,
> 
> > -----Original Message-----
> > From: Joerg Roedel <joro@8bytes.org>
> > Sent: Tuesday, June 30, 2020 2:16 AM
> > To: Prakhya, Sai Praneeth <sai.praneeth.prakhya@intel.com>
> > Cc: iommu@lists.linux-foundation.org; Christoph Hellwig <hch@lst.de>;
> > Raj, Ashok <ashok.raj@intel.com>; Will Deacon <will.deacon@arm.com>;
> > Lu Baolu <baolu.lu@linux.intel.com>; Mehta, Sohil
> > <sohil.mehta@intel.com>; Robin Murphy <robin.murphy@arm.com>; Jacob
> > Pan <jacob.jun.pan@linux.intel.com>
> > Subject: Re: [PATCH V4 1/3] iommu: Add support to change default
> > domain of an iommu group
> >
> > On Thu, Jun 04, 2020 at 06:32:06PM -0700, Sai Praneeth Prakhya wrote:
> > > +static int iommu_change_dev_def_domain(struct iommu_group *group,
> > > +int
> > > +type) {
> > > +	struct iommu_domain *prev_dom;
> > > +	struct group_device *grp_dev;
> > > +	const struct iommu_ops *ops;
> > > +	int ret, dev_def_dom;
> > > +	struct device *dev;
> > > +
> > > +	if (!group)
> > > +		return -EINVAL;
> > > +
> > > +	mutex_lock(&group->mutex);
> > > +
> > > +	if (group->default_domain != group->domain) {
> > > +		pr_err_ratelimited("Group assigned to user level for direct
> > > +access\n");
> >
> > Make this message: "Group not assigned to default domain\n".
> 
> Sure! I will change it
> 
> > > +		ret = -EBUSY;
> > > +		goto out;
> > > +	}
> > > +
> > > +	/*
> > > +	 * iommu group wasn't locked while acquiring device lock in
> > > +	 * iommu_group_store_type(). So, make sure that the device count
> > hasn't
> > > +	 * changed while acquiring device lock.
> > > +	 *
> > > +	 * Changing default domain of an iommu group with two or more
> > devices
> > > +	 * isn't supported because there could be a potential deadlock. Consider
> > > +	 * the following scenario. T1 is trying to acquire device locks of all
> > > +	 * the devices in the group and before it could acquire all of them,
> > > +	 * there could be another thread T2 (from different sub-system and use
> > > +	 * case) that has already acquired some of the device locks and might be
> > > +	 * waiting for T1 to release other device locks.
> > > +	 */
> > > +	if (iommu_group_device_count(group) != 1) {
> > > +		pr_err_ratelimited("Cannot change default domain of a group
> > with
> > > +two or more devices\n");
> >
> > "Can not change default domain: Group has more than one device\n"
> 
> Ok.. make sense. I will change this.
> 
> > > +		ret = -EINVAL;
> > > +		goto out;
> > > +	}
> > > +
> > > +	/* Since group has only one device */
> > > +	list_for_each_entry(grp_dev, &group->devices, list)
> > > +		dev = grp_dev->dev;
> > > +
> > > +	prev_dom = group->default_domain;
> > > +	if (!prev_dom || !prev_dom->ops || !prev_dom->ops-
> > >def_domain_type) {
> > > +		pr_err_ratelimited("'def_domain_type' call back isn't
> > > +registered\n");
> >
> > This message isn't needed.
> 
> Ok. I will remove it.
> 
> > > +	ret = __iommu_attach_device(group->default_domain, dev);
> > > +	if (ret)
> > > +		goto free_new_domain;
> > > +
> > > +	group->domain = group->default_domain;
> > > +
> > > +	ret = iommu_create_device_direct_mappings(group, dev);
> > > +	if (ret)
> > > +		goto free_new_domain;
> >
> > You need to create the direct mappings before you attach the device to
> > the new domain. Otherwise there might be a short time-window where
> > RMRR regions are not mapped.
> 
> Ok.. makes sense. I will change this accordingly.
> 
> > > +static ssize_t iommu_group_store_type(struct iommu_group *group,
> > > +				      const char *buf, size_t count) {
> > > +	struct group_device *grp_dev;
> > > +	struct device *dev;
> > > +	int ret, req_type;
> > > +
> > > +	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
> > > +		return -EACCES;
> > > +
> > > +	if (WARN_ON(!group))
> > > +		return -EINVAL;
> > > +
> > > +	if (sysfs_streq(buf, "identity"))
> > > +		req_type = IOMMU_DOMAIN_IDENTITY;
> > > +	else if (sysfs_streq(buf, "DMA"))
> > > +		req_type = IOMMU_DOMAIN_DMA;
> > > +	else if (sysfs_streq(buf, "auto"))
> > > +		req_type = 0;
> > > +	else
> > > +		return -EINVAL;
> > > +
> > > +	/*
> > > +	 * Lock/Unlock the group mutex here before device lock to
> > > +	 * 1. Make sure that the iommu group has only one device (this is a
> > > +	 *    prerequisite for step 2)
> > > +	 * 2. Get struct *dev which is needed to lock device
> > > +	 */
> > > +	mutex_lock(&group->mutex);
> > > +	if (iommu_group_device_count(group) != 1) {
> > > +		mutex_unlock(&group->mutex);
> > > +		pr_err_ratelimited("Cannot change default domain of a group
> > with two or more devices\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	/* Since group has only one device */
> > > +	list_for_each_entry(grp_dev, &group->devices, list)
> > > +		dev = grp_dev->dev;
> >
> > Please use list_first_entry().
> 
> Ok.
> 
> > You also need to take a reference with get_device() and then drop the
> > group->mutex.
> 
> Sure! I will change it.
> 
> > After device_lock() you need to verify that the device is still in the
> > same group and that the group has still only one device in it.

Q1:
> Presently, iommu_change_dev_def_domain() checks if the iommu group still has
> only one device or not. Hence, checking if iommu group has one device or not is
> done twice, once before taking device_lock() and the other, after taking
> device_lock().
> 
> I agree that the code isn't checking if the iommu group still has the _same_
> device or not.
> One way, I could think of doing it is by storing "dev" temporarily and checking
> for it.
> Do you think that's ok? Or would you rather suggest something else?
> 
> > Then you can call down to
> > iommu_change_dev_def_domain() which does not need to take the group-
> > mutex by itself.

Q2:
> The reason for taking iommu_group->mutex in the beginning of
> iommu_change_dev_def_domain() is that the function
> 
> 1. Checks if the group is being directly used by user level drivers (i.e. if (group-
> >default_domain != group->domain))
> 
> 2. Uses iommu_ops
> (prev_dom = group->default_domain;
> if (!prev_dom || !prev_dom->ops || !prev_dom->ops->def_domain_type))
> 
> 3. Sets iomu_group->domain to iommu_group->default_domain
> 
> I wanted to make sure that iommu_group->domain and iommu_group-
> >default_domain aren't changed by some other thread while this thread is
> working on it. So, please let me know if I misunderstood something.
> 
> Regards,
> Sai
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
