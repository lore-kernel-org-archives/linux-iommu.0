Return-Path: <SRS0=1g3H=7S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D775FC433DF
	for <iommu@archiver.kernel.org>; Fri,  5 Jun 2020 01:35:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B47002074B
	for <iommu@archiver.kernel.org>; Fri,  5 Jun 2020 01:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47002074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9D8BE8879B;
	Fri,  5 Jun 2020 01:35:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MDb5vUtZAlqa; Fri,  5 Jun 2020 01:35:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BCB5D887AC;
	Fri,  5 Jun 2020 01:35:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9E80C0881;
	Fri,  5 Jun 2020 01:35:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAA51C016E
 for <iommu@lists.linux-foundation.org>; Fri,  5 Jun 2020 01:35:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D7F862043A
 for <iommu@lists.linux-foundation.org>; Fri,  5 Jun 2020 01:35:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E-uatfVyFa45 for <iommu@lists.linux-foundation.org>;
 Fri,  5 Jun 2020 01:35:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by silver.osuosl.org (Postfix) with ESMTPS id 4E8AC203E6
 for <iommu@lists.linux-foundation.org>; Fri,  5 Jun 2020 01:35:29 +0000 (UTC)
IronPort-SDR: y85r2OKIL933vAvW1Isyddo5Unq34t7xsiAAZVZNVkzbV6BlGNnKUrb3f8rMzha8EKq/BUNr//
 5TnROIIfz52Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 18:35:18 -0700
IronPort-SDR: DSjLfD4k3aXtGHh0XSesHgMLOOaUKTvWhETu+7wUIEExiPpEUjFZ79s1oMfQJey+RJCMmkYWYR
 WBxmgklAoUUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,474,1583222400"; d="scan'208";a="259050523"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
 by fmsmga008.fm.intel.com with ESMTP; 04 Jun 2020 18:35:19 -0700
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH V4 0/3] iommu: Add support to change default domain of an
 iommu group
Date: Thu,  4 Jun 2020 18:32:05 -0700
Message-Id: <cover.1591290586.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
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

Presently, the default domain of an iommu group is allocated during boot time
and it cannot be changed later. So, the device would typically be either in
identity (pass_through) mode or the device would be in DMA mode as long as the
system is up and running. There is no way to change the default domain type
dynamically i.e. after booting, a device cannot switch between identity mode and
DMA mode.

Assume a use case wherein the privileged user would want to use the device in
pass-through mode when the device is used for host so that it would be high
performing. Presently, this is not supported. Hence add support to change the
default domain of an iommu group dynamically.

Support this by writing to a sysfs file, namely
"/sys/kernel/iommu_groups/<grp_id>/type".

Testing:
--------
Tested by dynamically changing storage device (nvme) from
1. identity mode to DMA and making sure file transfer works
2. DMA mode to identity mode and making sure file transfer works
Tested only for intel_iommu/vt-d. Would appreciate if someone could test on AMD
and ARM based machines.

Based on iommu maintainer's 'next' branch.

Changes from V3:
----------------
1. Made changes to commit message as suggested by Baolu.
2. Don't pass "prev_dom" and "dev" as parameters to
   iommu_change_dev_def_domain(). Instead get them from group.
3. Sanitize the logic to validate user default domain type request. The logic
   remains same but is implmented differently.
4. Push lot of error checking into iommu_change_dev_def_domain() from
   iommu_group_store_type().
5. iommu_change_dev_def_domain() takes/releases group mutex as needed. So, it
   shouldn't be called holding a group mutex.
6. Use pr_err_ratelimited() instead of pr_err() to avoid DOS attack.

Changes from V2:
----------------
1. Change the logic of updating default domain from V2 because
   ops->probe_finalize() could be used to update dma_ops.
2. Drop 1st and 2nd patch of V2 series because they are no longer needed on
   iommu maintainer's 'next' branch.
3. Limit this feature to iommu groups with only one device.
4. Hold device_lock and group mutex until the default domain is changed.

Changes from V1:
----------------
1. V1 patch set wasn't updating dma_ops for some vendors (Eg: AMD), hence,
   change the logic of updating default domain as below (because adding a device
   to iommu_group automatically updates dma_ops)
   a. Allocate a new domain
   b. For every device in the group
	i. Remove the device from the group
	ii. Add the device back to the group
   c. Free previous domain
2. Drop 1st patch of V1 (iommu/vt-d: Modify device_def_domain_type() to use at
   runtime) because "iommu=pt" has no effect on this function anymore.
3. Added a patch to take/release lock while reading iommu_group->default_domain->type
   because it can be changed any time by user.
4. Before changing default domain type of a group, check if the group is
   directly assigned for user level access. If so, abort.
5. Sanitize return path (using ternary operator) in iommu_group_store_type()
6. Split 2nd patch of V1 (iommu: Add device_def_domain_type() call back function
   to iommu_ops) into two patches such that iommu generic changes are now in 1st
   patch of V2 and vt-d specific changes are in 2nd patch of V2.
7. Rename device_def_domain_type() to dev_def_domain_type()
8. Remove example from documentation
9. Change the value written to file "/sys/kernel/iommu_groups/<grp_id>/type"
   from "dma" to "DMA".

Changes from RFC:
-----------------
1. Added support for "auto" type, so that kernel selects one among identity or
   dma mode.
2. Use "system_state" in device_def_domain_type() instead of an argument.

Sai Praneeth Prakhya (3):
  iommu: Add support to change default domain of an iommu_group
  iommu: Take lock before reading iommu_group default domain type
  iommu: Document usage of "/sys/kernel/iommu_groups/<grp_id>/type" file

 .../ABI/testing/sysfs-kernel-iommu_groups     |  30 +++
 drivers/iommu/iommu.c                         | 217 +++++++++++++++++-
 2 files changed, 246 insertions(+), 1 deletion(-)

Cc: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
