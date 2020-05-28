Return-Path: <SRS0=4TkS=7K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048BAC433E0
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 19:31:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB9E22078C
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 19:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB9E22078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6C44C8721A;
	Thu, 28 May 2020 19:31:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jBJtQCQeOvKb; Thu, 28 May 2020 19:31:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7BE59871E1;
	Thu, 28 May 2020 19:31:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63C6CC07FF;
	Thu, 28 May 2020 19:31:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C50EC016F
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 19:31:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0864C8794F
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 19:31:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S4zHInwPe+Ui for <iommu@lists.linux-foundation.org>;
 Thu, 28 May 2020 19:31:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 56B1C8793D
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 19:31:42 +0000 (UTC)
IronPort-SDR: Lyb9IIB6jCEs8uCWuzJYEeW+QdpgeDRILG/y9lAr3ehHkMma87bSBWCXGpoid300VjoEGnN2WA
 /vl3k6HYCrig==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2020 12:31:41 -0700
IronPort-SDR: LPID61nf0BRNm0wfwGBNtRK7YUhzljIAGGuswAJUHJR8U11lj9qvWAHUctj+bkBbKIBEBO7m/O
 +qM1RhEEfZCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,446,1583222400"; d="scan'208";a="256268878"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
 by orsmga007.jf.intel.com with ESMTP; 28 May 2020 12:31:41 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 28 May 2020 12:31:41 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.205]) by
 ORSMSX151.amr.corp.intel.com ([169.254.7.2]) with mapi id 14.03.0439.000;
 Thu, 28 May 2020 12:31:41 -0700
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH] iommu: Remove functions that support private domain
Thread-Topic: [PATCH] iommu: Remove functions that support private domain
Thread-Index: AQHWKXk9fV5tekATV0S4blj7EpvL1KioBUCA///Q9SCAAIhBgP//i0rwgACMGYD//71zcAAlw0mAAAYo/gAABfT8AAAIODdwAereqYAAk8sDkA==
Date: Thu, 28 May 2020 19:31:40 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F573BC50C@ORSMSX114.amr.corp.intel.com>
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
 <20200525135644.GC5221@8bytes.org>
In-Reply-To: <20200525135644.GC5221@8bytes.org>
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
> Sent: Monday, May 25, 2020 6:57 AM
> To: Prakhya, Sai Praneeth <sai.praneeth.prakhya@intel.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>; iommu@lists.linux-foundation.org
> Subject: Re: [PATCH] iommu: Remove functions that support private domain
> 
> On Sun, May 17, 2020 at 08:29:17AM +0000, Prakhya, Sai Praneeth wrote:
> > iommu_bus_notifier()
> > -> iommu_release_device()
> >  -> ops->release_device() (Eg: intel_iommu_release_device())
> >   -> iommu_group_remove_device()
> >    -> mutex_lock()
> >
> > But, I added print statements to iommu_bus_notifier() and
> > iommu_group_remove_device() and noticed that
> > iommu_group_remove_device() wasn't being called upon modprobe -r
> > <driver_name> and iommu_probe_device() isn't called upon modprobe
> > <driver_name> because
> 
> Calling modprobe is the device driver binding path, the release_device event is
> called when a device is going away, e.g. on hotunplug or when a VF of a PCI
> device is released.
> 
> This could also happen at runtime, and the code needs to protect against that.
> My suggestion is still to limit runtime-changing of default domains to groups
> with only one device. The flow would be as follows:

Thanks for explaining how lock release path could be called at run time. It makes sense to me now.

> 
> 	1. device_lock(dev);
> 	   // Device can't be bound to a driver or hot-removed from now
> 	   // on.
> 
> 	2. if (device_is_bound_to_some_driver(dev))
> 	           goto 6;
> 
> 	3. mutex_lock(&group->mutex);
> 	   // group of dev
> 
> 	4. Change the default domain
> 
> 	5. mutex_unlock(&group->mutex);
> 
> 	6. device_unlock(dev);
> 
> This avoids lock inversion and should be safe with regard to hotplug and device
> driver probing.

Thanks for the steps. I have implemented "changing default domain" following the steps you gave above. Could you please review the patch set when you have some time and let me know your comments?

Regards,
Sai
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
