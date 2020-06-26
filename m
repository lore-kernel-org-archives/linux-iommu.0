Return-Path: <SRS0=GrUw=AH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA55C433DF
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 21:34:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD77A20B1F
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 21:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD77A20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 83A1A887F6;
	Fri, 26 Jun 2020 21:34:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Gor2lptsiC0; Fri, 26 Jun 2020 21:34:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C877188726;
	Fri, 26 Jun 2020 21:34:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD9C8C088C;
	Fri, 26 Jun 2020 21:34:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39BA8C016F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 21:34:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1ECB0864D2
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 21:34:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UFx8Sa8uRTuW for <iommu@lists.linux-foundation.org>;
 Fri, 26 Jun 2020 21:34:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4E2B086457
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 21:34:22 +0000 (UTC)
IronPort-SDR: fE2KOtrdv+E9DKJ1fGicpq6cipyiaTHPhnv4GTnYvj8V+PEv8Xqb+/BMNSji28YcYMK7jhiZTl
 vjU0rJ+MLy5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="133842874"
X-IronPort-AV: E=Sophos;i="5.75,285,1589266800"; d="scan'208";a="133842874"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:34:21 -0700
IronPort-SDR: a++6fBFK7atD9ZcXtrPiAu0l8r8tNUQ4peTnrp1rMS+EEahE+FrE4hqW15IM4jAHAeCVGDhAub
 0eJrtAIMQKwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,285,1589266800"; d="scan'208";a="453493954"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
 by orsmga005.jf.intel.com with ESMTP; 26 Jun 2020 14:34:21 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.167]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.92]) with mapi id 14.03.0439.000;
 Fri, 26 Jun 2020 14:34:20 -0700
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH V4 0/3] iommu: Add support to change default domain of
 an iommu group
Thread-Topic: [PATCH V4 0/3] iommu: Add support to change default domain of
 an iommu group
Thread-Index: AQHWOtmSgIgjlrIIO0iawkhNLbGcqajrjPUQ
Date: Fri, 26 Jun 2020 21:34:20 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F573D6E2C@ORSMSX114.amr.corp.intel.com>
References: <cover.1591290586.git.sai.praneeth.prakhya@intel.com>
In-Reply-To: <cover.1591290586.git.sai.praneeth.prakhya@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
MIME-Version: 1.0
Cc: "Raj,
 Ashok" <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>, Robin
 Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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
> From: Prakhya, Sai Praneeth <sai.praneeth.prakhya@intel.com>
> Sent: Thursday, June 4, 2020 6:32 PM
> To: iommu@lists.linux-foundation.org
> Cc: Prakhya, Sai Praneeth <sai.praneeth.prakhya@intel.com>; Christoph Hellwig
> <hch@lst.de>; Joerg Roedel <joro@8bytes.org>; Raj, Ashok
> <ashok.raj@intel.com>; Will Deacon <will.deacon@arm.com>; Lu Baolu
> <baolu.lu@linux.intel.com>; Mehta, Sohil <sohil.mehta@intel.com>; Robin
> Murphy <robin.murphy@arm.com>; Jacob Pan <jacob.jun.pan@linux.intel.com>
> Subject: [PATCH V4 0/3] iommu: Add support to change default domain of an
> iommu group
> 
> Presently, the default domain of an iommu group is allocated during boot time
> and it cannot be changed later. So, the device would typically be either in
> identity (pass_through) mode or the device would be in DMA mode as long as
> the system is up and running. There is no way to change the default domain type
> dynamically i.e. after booting, a device cannot switch between identity mode
> and DMA mode.
> 
> Assume a use case wherein the privileged user would want to use the device in
> pass-through mode when the device is used for host so that it would be high
> performing. Presently, this is not supported. Hence add support to change the
> default domain of an iommu group dynamically.
> 
> Support this by writing to a sysfs file, namely
> "/sys/kernel/iommu_groups/<grp_id>/type".
> 
> Testing:
> --------
> Tested by dynamically changing storage device (nvme) from 1. identity mode to
> DMA and making sure file transfer works 2. DMA mode to identity mode and
> making sure file transfer works Tested only for intel_iommu/vt-d. Would
> appreciate if someone could test on AMD and ARM based machines.
> 
> Based on iommu maintainer's 'next' branch.
> 
> Changes from V3:
> ----------------
> 1. Made changes to commit message as suggested by Baolu.
> 2. Don't pass "prev_dom" and "dev" as parameters to
>    iommu_change_dev_def_domain(). Instead get them from group.
> 3. Sanitize the logic to validate user default domain type request. The logic
>    remains same but is implmented differently.
> 4. Push lot of error checking into iommu_change_dev_def_domain() from
>    iommu_group_store_type().
> 5. iommu_change_dev_def_domain() takes/releases group mutex as needed.
> So, it
>    shouldn't be called holding a group mutex.
> 6. Use pr_err_ratelimited() instead of pr_err() to avoid DOS attack.

Could you please review this patch set and let me know if you have any comments?

Regards,
Sai
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
