Return-Path: <SRS0=CTmu=TY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=AC_FROM_MANY_DOTS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F26AC282E1
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 23:42:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E8E217F9
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 23:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E8E217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8CB9AF9B;
	Fri, 24 May 2019 23:42:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5D74F265
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 23:42:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6C6886C5
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 23:42:55 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	24 May 2019 16:42:54 -0700
X-ExtLoop1: 1
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
	by orsmga001.jf.intel.com with ESMTP; 24 May 2019 16:42:54 -0700
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH V3 0/3] Add debugfs support to show scalable mode DMAR table
Date: Fri, 24 May 2019 16:40:14 -0700
Message-Id: <cover.1558735674.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Presently, "/sys/kernel/debug/iommu/intel/dmar_translation_struct" file dumps
only legacy DMAR table which consists of root table and context table. Scalable
mode DMAR table adds PASID directory and PASID table. Hence, add support to dump
these tables as well.

Directly extending the present dumping format for PASID tables will make the
output look clumsy. Hence, the first patch modifies the present format to a
tabular format. The second patch introduces macros that are used during PASID
table walk and the third patch actually adds support to dump scalable mode DMAR
table.

Changes from V1 to V2:
----------------------
1. Make my name consistent in "From" and "Signed-off-by"
2. Fix comment regarding scalable mode context entries
3. Add reviewed by tags

Changes from V2 to V3:
----------------------
Presently, for V2 patches if kernel command line argument "iommu=pt" is passed,
dumping DMAR table seg faults. This happens because in pass through mode (for
non-scalable DMAR's) 3rd bit of context entry is set and it is misinterpreted as
PASID enabled by debugfs code and hence tries to dereference PASID directory
pointer which leads to seg fault (PASID directory pointer is undefined for
non-scalable DMAR's). To fix this, dereference PASID directory pointer only when
1. PASID is supported and
2. PASID is enabled.

This patch is tested on
1. Non-scalable DMAR with and without iommu=pt
2. Scalable DMAR with and without iommu=pt

Sai Praneeth Prakhya (3):
  iommu/vt-d: Modify the format of intel DMAR tables dump
  iommu/vt-d: Introduce macros useful for dumping DMAR table
  iommu/vt-d: Add debugfs support to show scalable mode DMAR table
    internals

 drivers/iommu/intel-iommu-debugfs.c | 137 +++++++++++++++++++++++++++++-------
 drivers/iommu/intel-iommu.c         |   6 +-
 drivers/iommu/intel-pasid.c         |  17 -----
 drivers/iommu/intel-pasid.h         |  26 +++++++
 include/linux/intel-iommu.h         |   6 ++
 5 files changed, 146 insertions(+), 46 deletions(-)

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
