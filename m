Return-Path: <SRS0=ASoY=BD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64219C433E1
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 19:54:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 343A7206F0
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 19:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343A7206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EBDEC24BFC;
	Fri, 24 Jul 2020 19:54:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WcswL+hPSlnq; Fri, 24 Jul 2020 19:54:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B3A6724C39;
	Fri, 24 Jul 2020 19:54:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97C1CC004D;
	Fri, 24 Jul 2020 19:54:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05376C004C
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 19:54:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E81B987216
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 19:54:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fxq69FryGB-x for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jul 2020 19:54:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D853A87212
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 19:54:02 +0000 (UTC)
IronPort-SDR: tcG6mQpExoEti4OT64UXUQ/E3D62CMOCU2OgCIiW6bZORQhL+A7bHDRzMhIk/TtLdw30KPgrPK
 d+3BeqQP+j/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="138833642"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; d="scan'208";a="138833642"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2020 12:54:01 -0700
IronPort-SDR: Exi8gN49T7BvWiwFLytk3bZn/qGrFE1Um/gwLgRDz7Y6qB2zs+fH7I4GzFg7kfyavR/5fdRzU3
 Zofj+tIqpX9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; d="scan'208";a="433183781"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
 by orsmga004.jf.intel.com with ESMTP; 24 Jul 2020 12:54:01 -0700
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: iommu@lists.linux-foundation.org,
	joro@8bytes.org
Subject: [PATCH V5 0/3] iommu: Add support to change default domain of an
 iommu group
Date: Fri, 24 Jul 2020 12:51:57 -0700
Message-Id: <cover.1595619936.git.sai.praneeth.prakhya@intel.com>
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

Changes from V4:
----------------
1. Created device direct mappings before attaching the device to the domain
2. Used list_first_entry() instead of list_for_each_entry() to get the first
   element of a linked list.
3. Used get_device() and put_device() before and after device_lock()
4. Passed device as an argument to iommu_change_dev_def_domain() to check that
   the device hasn't changed between calls.
5. Changed error message from "Group assigned to user level for direct access"
   to "Group not assigned to default domain".
6. Changed error message from "Cannot change default domain of a group with two
   or more devices" to "Cannot change default domain: Group has more than one
   device".
7. Removed printing error message "'def_domain_type' call back isn't registered"

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
  iommu: Add support to change default domain of an iommu group
  iommu: Take lock before reading iommu group default domain type
  iommu: Document usage of "/sys/kernel/iommu_groups/<grp_id>/type" file

 .../ABI/testing/sysfs-kernel-iommu_groups     |  30 +++
 drivers/iommu/iommu.c                         | 227 +++++++++++++++++-
 2 files changed, 256 insertions(+), 1 deletion(-)

Cc: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
