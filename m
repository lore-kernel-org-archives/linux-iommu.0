Return-Path: <SRS0=c7ON=67=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E14CC433DF
	for <iommu@archiver.kernel.org>; Sun, 17 May 2020 08:29:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2590C20735
	for <iommu@archiver.kernel.org>; Sun, 17 May 2020 08:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2590C20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 965FE886B4;
	Sun, 17 May 2020 08:29:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id itNj7Sa5NU9F; Sun, 17 May 2020 08:29:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5F86685344;
	Sun, 17 May 2020 08:29:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C2EDC0865;
	Sun, 17 May 2020 08:29:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6222BC07FF
 for <iommu@lists.linux-foundation.org>; Sun, 17 May 2020 08:29:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 59BE62037A
 for <iommu@lists.linux-foundation.org>; Sun, 17 May 2020 08:29:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SuHbFo+M09vD for <iommu@lists.linux-foundation.org>;
 Sun, 17 May 2020 08:29:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by silver.osuosl.org (Postfix) with ESMTPS id EDBF620377
 for <iommu@lists.linux-foundation.org>; Sun, 17 May 2020 08:29:19 +0000 (UTC)
IronPort-SDR: w1I8qKGd9RJ7Lox+nQYMbXT1cAHIKQ+OU8GwYn3tzN7pWTP9nzLhcPRfGTJ5HqiQtjdzgO/vts
 r8dTnrlzqNAQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2020 01:29:19 -0700
IronPort-SDR: ERZ1qLrtwfcxnioOmhVkBshkvkZ3Xum1yxukSkFlCoITmyB48j8XHsX3kF1kifUWZ/Y01USK1p
 DujqguLmlc3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,402,1583222400"; d="scan'208";a="263644372"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
 by orsmga003.jf.intel.com with ESMTP; 17 May 2020 01:29:19 -0700
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 17 May 2020 01:29:18 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.99]) by
 ORSMSX155.amr.corp.intel.com ([169.254.7.186]) with mapi id 14.03.0439.000;
 Sun, 17 May 2020 01:29:18 -0700
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>
Subject: RE: [PATCH] iommu: Remove functions that support private domain
Thread-Topic: [PATCH] iommu: Remove functions that support private domain
Thread-Index: AQHWKXk9fV5tekATV0S4blj7EpvL1KioBUCA///Q9SCAAIhBgP//i0rwgACMGYD//71zcAAlw0mAAAYo/gAABfT8AAAIODdw
Date: Sun, 17 May 2020 08:29:17 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F573A6BD6@ORSMSX114.amr.corp.intel.com>
References: <20200513224721.20504-1-sai.praneeth.prakhya@intel.com>
 <20200514131315.GJ18353@8bytes.org>
 <FFF73D592F13FD46B8700F0A279B802F573A6427@ORSMSX114.amr.corp.intel.com>
 <20200514183233.GO18353@8bytes.org>
 <FFF73D592F13FD46B8700F0A279B802F573A651E@ORSMSX114.amr.corp.intel.com>
 <20200514195615.GP18353@8bytes.org>
 <FFF73D592F13FD46B8700F0A279B802F573A6672@ORSMSX114.amr.corp.intel.com>
 <20200515095919.GQ18353@8bytes.org>
 <9d65b30a-d22e-d566-d740-601f8d638bfd@linux.intel.com>
 <20200515154616.GY18353@8bytes.org>
In-Reply-To: <20200515154616.GY18353@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
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

> -----Original Message-----
> From: Joerg Roedel <joro@8bytes.org>
> Sent: Friday, May 15, 2020 8:46 AM
> To: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Prakhya, Sai Praneeth <sai.praneeth.prakhya@intel.com>;
> iommu@lists.linux-foundation.org
> Subject: Re: [PATCH] iommu: Remove functions that support private domain
> 
> On Fri, May 15, 2020 at 08:55:42PM +0800, Lu Baolu wrote:
> > It seems that we can do like this:
> >
> > [1] mutex_lock(&group->lock)
> > [2] for_each_group_device(device_lock())
> > [3] if (for_each_group_device(!device_is_bound()))
> > 	change_default_domain()
> > [4] for_each_group_device_reverse(device_unlock())
> > [5] mutex_unlock(&group->lock)

>> A possible problem exists at step 2 when another thread is trying to lock devices in the reverse order at the same time. -> By Allen

Makes sense.. this could happen and we could prevent this if the iommu_group has only one device. So, going with Joerg's suggestion, if we support dynamic switching of default-domain of a group with only one device, I think we shouldn't hit this issue.

> The problem here is that I am pretty sure we also have:
> 
> 	device_lock() /* from device/driver core code */
> 	-> bus_notifier()
> 	  -> iommu_bus_notifier()
> 	    -> ...
> 	      -> mutex_lock(&group->lock)
> 
> Which would cause lock-inversion with the above code.

Thanks for this call chain, Joerg. It makes sense to me how lock inversion could happen

iommu_bus_notifier()
-> iommu_release_device()
 -> ops->release_device() (Eg: intel_iommu_release_device())
  -> iommu_group_remove_device()
   -> mutex_lock()

But, I added print statements to iommu_bus_notifier() and iommu_group_remove_device() and noticed that iommu_group_remove_device() wasn't being called upon modprobe -r <driver_name> and iommu_probe_device() isn't called upon modprobe <driver_name> because

	if (action == BUS_NOTIFY_ADD_DEVICE) {
		int ret;

		ret = iommu_probe_device(dev);
		return (ret) ? NOTIFY_DONE : NOTIFY_OK;
	} else if (action == BUS_NOTIFY_REMOVED_DEVICE) {
		iommu_release_device(dev);
		return NOTIFY_OK;
	}

"action" was != BUS_NOTIFY_ADD_DEVICE || BUS_NOTIFY_REMOVED_DEVICE upon modprobe. So (after booting [1]), I am wondering when would action be == to one of the above so that these iommu functions get called.

And,
	switch (action) {
	case BUS_NOTIFY_BIND_DRIVER:
		group_action = IOMMU_GROUP_NOTIFY_BIND_DRIVER;
		break;
	case BUS_NOTIFY_BOUND_DRIVER:
		group_action = IOMMU_GROUP_NOTIFY_BOUND_DRIVER;
		break;
	case BUS_NOTIFY_UNBIND_DRIVER:
		group_action = IOMMU_GROUP_NOTIFY_UNBIND_DRIVER;
		break;
	case BUS_NOTIFY_UNBOUND_DRIVER:
		group_action = IOMMU_GROUP_NOTIFY_UNBOUND_DRIVER;
		break;
	}

	if (group_action)
		blocking_notifier_call_chain(&group->notifier,
					     group_action, dev);

I also noticed that vfio is the only one that registers for group notifiers and from a first look it wasn't very obvious if vfio is trying to get group->mutex.

[1] I am interested in after booting because dynamic switching of iommu_group default-domain is supported only through sysfs.

Regards,
Sai
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
