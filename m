Return-Path: <SRS0=eEOj=7H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B505C433E1
	for <iommu@archiver.kernel.org>; Mon, 25 May 2020 13:56:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F9282071A
	for <iommu@archiver.kernel.org>; Mon, 25 May 2020 13:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F9282071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E7FD9203BE;
	Mon, 25 May 2020 13:56:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S4wtoGBpJuq9; Mon, 25 May 2020 13:56:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C235520104;
	Mon, 25 May 2020 13:56:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2FB6C088D;
	Mon, 25 May 2020 13:56:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E167FC016F
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 13:56:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DCB83203BE
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 13:56:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DulZ+xd-jwKQ for <iommu@lists.linux-foundation.org>;
 Mon, 25 May 2020 13:56:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 2BCB120104
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 13:56:49 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 7407A327; Mon, 25 May 2020 15:56:46 +0200 (CEST)
Date: Mon, 25 May 2020 15:56:45 +0200
From: Joerg Roedel <joro@8bytes.org>
To: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
Subject: Re: [PATCH] iommu: Remove functions that support private domain
Message-ID: <20200525135644.GC5221@8bytes.org>
References: <20200514131315.GJ18353@8bytes.org>
 <FFF73D592F13FD46B8700F0A279B802F573A6427@ORSMSX114.amr.corp.intel.com>
 <20200514183233.GO18353@8bytes.org>
 <FFF73D592F13FD46B8700F0A279B802F573A651E@ORSMSX114.amr.corp.intel.com>
 <20200514195615.GP18353@8bytes.org>
 <FFF73D592F13FD46B8700F0A279B802F573A6672@ORSMSX114.amr.corp.intel.com>
 <20200515095919.GQ18353@8bytes.org>
 <9d65b30a-d22e-d566-d740-601f8d638bfd@linux.intel.com>
 <20200515154616.GY18353@8bytes.org>
 <FFF73D592F13FD46B8700F0A279B802F573A6BD6@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F573A6BD6@ORSMSX114.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Sun, May 17, 2020 at 08:29:17AM +0000, Prakhya, Sai Praneeth wrote:
> iommu_bus_notifier()
> -> iommu_release_device()
>  -> ops->release_device() (Eg: intel_iommu_release_device())
>   -> iommu_group_remove_device()
>    -> mutex_lock()
> 
> But, I added print statements to iommu_bus_notifier() and
> iommu_group_remove_device() and noticed that
> iommu_group_remove_device() wasn't being called upon modprobe -r
> <driver_name> and iommu_probe_device() isn't called upon modprobe
> <driver_name> because

Calling modprobe is the device driver binding path, the release_device
event is called when a device is going away, e.g. on hotunplug or when a
VF of a PCI device is released.

This could also happen at runtime, and the code needs to protect against
that. My suggestion is still to limit runtime-changing of default
domains to groups with only one device. The flow would be as follows:


	1. device_lock(dev);
	   // Device can't be bound to a driver or hot-removed from now
	   // on.

	2. if (device_is_bound_to_some_driver(dev))
	           goto 6;

	3. mutex_lock(&group->mutex);
	   // group of dev

	4. Change the default domain

	5. mutex_unlock(&group->mutex);

	6. device_unlock(dev);

This avoids lock inversion and should be safe with regard to hotplug and
device driver probing.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
