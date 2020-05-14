Return-Path: <SRS0=Hf/t=64=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93684C433DF
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 23:13:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C6C204EA
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 23:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C6C204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 88D0188B71;
	Thu, 14 May 2020 23:13:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o1Uwx0gTjBvq; Thu, 14 May 2020 23:13:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 805AF88B68;
	Thu, 14 May 2020 23:13:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6534BC0178;
	Thu, 14 May 2020 23:13:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15667C016F
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 23:13:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EECDF88B70
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 23:12:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YgpP5i+60Nk4 for <iommu@lists.linux-foundation.org>;
 Thu, 14 May 2020 23:12:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DF88988B68
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 23:12:54 +0000 (UTC)
IronPort-SDR: sbegF5Iq0t0mY0o6Do5l2wiw1UoFYQMN+EfzTzhfrzCzOeqKfTXRx7kV9nscBT6SS5YxTNXXsA
 bxsr8nMOckQA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2020 16:12:54 -0700
IronPort-SDR: vPuW+oc/AbbRY7PSn+2snb7MWInAOtq+fZtr2h0Ep+IsB/TU3PVtMQdPHkAryR8DzuOBMHjj6D
 LcqI98wWDMIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,392,1583222400"; d="scan'208";a="253626149"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
 by fmsmga008.fm.intel.com with ESMTP; 14 May 2020 16:12:53 -0700
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 14 May 2020 16:12:53 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.99]) by
 ORSMSX112.amr.corp.intel.com ([169.254.3.248]) with mapi id 14.03.0439.000;
 Thu, 14 May 2020 16:12:53 -0700
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH] iommu: Remove functions that support private domain
Thread-Topic: [PATCH] iommu: Remove functions that support private domain
Thread-Index: AQHWKXk9fV5tekATV0S4blj7EpvL1KioBUCA///Q9SCAAIhBgP//i0rwgACMGYD//71zcA==
Date: Thu, 14 May 2020 23:12:52 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F573A6672@ORSMSX114.amr.corp.intel.com>
References: <20200513224721.20504-1-sai.praneeth.prakhya@intel.com>
 <20200514131315.GJ18353@8bytes.org>
 <FFF73D592F13FD46B8700F0A279B802F573A6427@ORSMSX114.amr.corp.intel.com>
 <20200514183233.GO18353@8bytes.org>
 <FFF73D592F13FD46B8700F0A279B802F573A651E@ORSMSX114.amr.corp.intel.com>
 <20200514195615.GP18353@8bytes.org>
In-Reply-To: <20200514195615.GP18353@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
MIME-Version: 1.0
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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
> Sent: Thursday, May 14, 2020 12:56 PM
> To: Prakhya, Sai Praneeth <sai.praneeth.prakhya@intel.com>
> Cc: iommu@lists.linux-foundation.org; Lu Baolu <baolu.lu@linux.intel.com>
> Subject: Re: [PATCH] iommu: Remove functions that support private domain
> 
> On Thu, May 14, 2020 at 06:44:16PM +0000, Prakhya, Sai Praneeth wrote:
> > Could you please explain why we shouldn't change default-domain for an
> > iommu group that has multiple devices?
> 
> Because you can't be sure that a device is bound to a driver while the default
> domain of the group is changed. As long as this race condition exists we can't
> change the default domains of groups with multiple devices at runtime.
> 
> > I am asking this particularly because the patch set I am working on
> > allows to change default-domain for an iommu group that has multiple
> > devices. The pre-requisite being that all the devices in the group
> > should already be unbounded from the device driver and the
> > default-domain preferences of all the devices in the group shouldn't
> > have conflicting types i.e. some devices cannot say they *only* need
> > identity domain while other devices in the same group say that they
> > *only* need to be in DMA domain. In this case, we will not be able to
> > decide upon a default-domain for the iommu group.
> 
> Yeah, but as I wrote above, this is racy and there is currently no way to fix that.
> So we can't support it.

Ok.. below is a previous *similar* comment that you had for one of my patches that change default-domain dynamically.. could you please elaborate it more so that I could have better understanding?
Specifically this one.. "locking all devices in the group and then do the re-attach will introduce a lock-inversion with group->mutex". I didn't get which function call chain would lead us to lock inversion. Could you please shed some light here?

+static int is_driver_bound(struct device *dev, void *not_used)
+{
+	int ret = 0;
+
+	device_lock(dev);
+	if (device_is_bound(dev))
+		ret = 1;
+	device_unlock(dev);
+	return ret;
+}

[SNIP]

+	/*
+	 * Check if any device in the group still has a driver binded to it.
+	 * This might race with device driver probing code and unfortunately
+	 * there is no clean way out of that either, locking all devices in the
+	 * group and then do the re-attach will introduce a lock-inversion with
+	 * group->mutex - Joerg.
+	 */
+	if (iommu_group_for_each_dev(group, NULL, is_driver_bound)) {
+		pr_err("Active drivers exist for devices in the group\n");
+		return -EBUSY;
+	}

Another question I have is.. if it's racy then it should be racy even for one device iommu groups.. right? Why would it be racy only with multiple devices iommu group?

Regards,
Sai
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
