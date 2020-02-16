Return-Path: <SRS0=EPxn=4E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5C0C3B1BF
	for <iommu@archiver.kernel.org>; Sun, 16 Feb 2020 22:02:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E22AD20729
	for <iommu@archiver.kernel.org>; Sun, 16 Feb 2020 22:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22AD20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BC89586FE7;
	Sun, 16 Feb 2020 22:02:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H-etI7mlcYAE; Sun, 16 Feb 2020 22:02:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 83A8986E5B;
	Sun, 16 Feb 2020 22:02:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FA50C07FF;
	Sun, 16 Feb 2020 22:02:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25B07C013E
 for <iommu@lists.linux-foundation.org>; Sun, 16 Feb 2020 22:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1D1ED85A49
 for <iommu@lists.linux-foundation.org>; Sun, 16 Feb 2020 22:02:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S_zMdcJ_Ugym for <iommu@lists.linux-foundation.org>;
 Sun, 16 Feb 2020 22:02:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0ED8985A00
 for <iommu@lists.linux-foundation.org>; Sun, 16 Feb 2020 22:02:34 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Feb 2020 14:02:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,450,1574150400"; d="scan'208";a="268200649"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
 by fmsmga002.fm.intel.com with ESMTP; 16 Feb 2020 14:02:33 -0800
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH V2 0/5] iommu: Add support to change default domain of a group
Date: Sun, 16 Feb 2020 13:57:23 -0800
Message-Id: <cover.1581619464.git.sai.praneeth.prakhya@intel.com>
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

Presently, the default domain of a group is allocated during boot time and it
cannot be changed later. So, the device would typically be either in identity
(pass_through) mode or the device would be in DMA mode as long as the
system is up and running. There is no way to change the default domain type
dynamically i.e. after booting, a device cannot switch between identity mode and
DMA mode.

Assume a use case wherein the privileged user would want to use the device in
pass-through mode when the device is used for host so that it would be high
performing. Presently, this is not supported. Hence add support to change the
default domain of a group dynamically.

Support this through a sysfs file, namely "/sys/kernel/iommu_groups/<grp_id>/type".

Hi Joerg,
Sorry! for _huge_ delay in posting a V2 of this patch set. Was stuck with some
internal PoC work. Will be consistent from now.

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

Testing:
--------
Tested by dynamically changing storage device (nvme) from
1. identity mode to dma and making sure file transfer works
2. dma mode to identity mode and making sure file transfer works
Tested only for intel_iommu/vt-d.

Based on iommu maintainer's 'next' branch.

Sai Praneeth Prakhya (5):
  iommu: Add dev_def_domain_type() call back function to iommu_ops
  iommu/vt-d: Rename device_def_domain_type() to    
    intel_iommu_dev_def_domain_type()
  iommu: Add support to change default domain of an iommu_group
  iommu: Take lock before reading iommu_group default domain type
  iommu: Document usage of "/sys/kernel/iommu_groups/<grp_id>/type" file

 .../ABI/testing/sysfs-kernel-iommu_groups          |  29 +++
 drivers/iommu/intel-iommu.c                        |   8 +-
 drivers/iommu/iommu.c                              | 229 ++++++++++++++++++++-
 include/linux/iommu.h                              |   3 +
 4 files changed, 265 insertions(+), 4 deletions(-)

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
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
