Return-Path: <SRS0=f0z+=4K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84999C35671
	for <iommu@archiver.kernel.org>; Sat, 22 Feb 2020 23:40:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57BE4206EF
	for <iommu@archiver.kernel.org>; Sat, 22 Feb 2020 23:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57BE4206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1733020439;
	Sat, 22 Feb 2020 23:40:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AsVGgYafFynI; Sat, 22 Feb 2020 23:40:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 093FC20369;
	Sat, 22 Feb 2020 23:40:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0F3AC1AE2;
	Sat, 22 Feb 2020 23:40:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF1F5C013E
 for <iommu@lists.linux-foundation.org>; Sat, 22 Feb 2020 23:40:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9E94F855D1
 for <iommu@lists.linux-foundation.org>; Sat, 22 Feb 2020 23:40:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IVP7gdKs26Ik for <iommu@lists.linux-foundation.org>;
 Sat, 22 Feb 2020 23:40:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 02D2485593
 for <iommu@lists.linux-foundation.org>; Sat, 22 Feb 2020 23:40:48 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Feb 2020 15:40:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,473,1574150400"; d="scan'208";a="236938335"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
 by orsmga003.jf.intel.com with ESMTP; 22 Feb 2020 15:40:48 -0800
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 22 Feb 2020 15:40:47 -0800
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.140]) by
 ORSMSX151.amr.corp.intel.com ([169.254.7.116]) with mapi id 14.03.0439.000;
 Sat, 22 Feb 2020 15:40:47 -0800
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH V2 0/5] iommu: Add support to change default domain of a
 group
Thread-Topic: [PATCH V2 0/5] iommu: Add support to change default domain of
 a group
Thread-Index: AQHV5RTLxSKuSu7lpkyBeW7ZrFy1z6gn59Eg
Date: Sat, 22 Feb 2020 23:40:47 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F57205156@ORSMSX114.amr.corp.intel.com>
References: <cover.1581619464.git.sai.praneeth.prakhya@intel.com>
In-Reply-To: <cover.1581619464.git.sai.praneeth.prakhya@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
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

> Presently, the default domain of a group is allocated during boot time and it
> cannot be changed later. So, the device would typically be either in identity
> (pass_through) mode or the device would be in DMA mode as long as the system
> is up and running. There is no way to change the default domain type
> dynamically i.e. after booting, a device cannot switch between identity mode
> and DMA mode.
> 
> Assume a use case wherein the privileged user would want to use the device in
> pass-through mode when the device is used for host so that it would be high
> performing. Presently, this is not supported. Hence add support to change the
> default domain of a group dynamically.
> 
> Support this through a sysfs file, namely
> "/sys/kernel/iommu_groups/<grp_id>/type".
> 
> Hi Joerg,
> Sorry! for _huge_ delay in posting a V2 of this patch set. Was stuck with some
> internal PoC work. Will be consistent from now.
> 
> Changes from V1:
> ----------------
> 1. V1 patch set wasn't updating dma_ops for some vendors (Eg: AMD), hence,
>    change the logic of updating default domain as below (because adding a
> device
>    to iommu_group automatically updates dma_ops)
>    a. Allocate a new domain
>    b. For every device in the group
> 	i. Remove the device from the group
> 	ii. Add the device back to the group
>    c. Free previous domain
> 2. Drop 1st patch of V1 (iommu/vt-d: Modify device_def_domain_type() to use
> at
>    runtime) because "iommu=pt" has no effect on this function anymore.
> 3. Added a patch to take/release lock while reading iommu_group-
> >default_domain->type
>    because it can be changed any time by user.
> 4. Before changing default domain type of a group, check if the group is
>    directly assigned for user level access. If so, abort.
> 5. Sanitize return path (using ternary operator) in iommu_group_store_type() 6.
> Split 2nd patch of V1 (iommu: Add device_def_domain_type() call back function
>    to iommu_ops) into two patches such that iommu generic changes are now in
> 1st
>    patch of V2 and vt-d specific changes are in 2nd patch of V2.
> 7. Rename device_def_domain_type() to dev_def_domain_type() 8. Remove
> example from documentation 9. Change the value written to file
> "/sys/kernel/iommu_groups/<grp_id>/type"
>    from "dma" to "DMA".

Just a gentle reminder, could you please review this patch set and let me know your comments?

Regards,
Sai
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
