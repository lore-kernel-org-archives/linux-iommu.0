Return-Path: <SRS0=E6XH=VT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78DCC76191
	for <iommu@archiver.kernel.org>; Mon, 22 Jul 2019 00:25:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB46520828
	for <iommu@archiver.kernel.org>; Mon, 22 Jul 2019 00:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB46520828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 75400AC8;
	Mon, 22 Jul 2019 00:25:02 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D27E1AC7
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Jul 2019 00:25:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CFC0CF1
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Jul 2019 00:24:52 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	21 Jul 2019 17:24:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,292,1559545200"; d="scan'208";a="344262887"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
	by orsmga005.jf.intel.com with ESMTP; 21 Jul 2019 17:24:46 -0700
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/vt-d: Print pasid table entries MSB to LSB in debugfs
Date: Sun, 21 Jul 2019 17:22:07 -0700
Message-Id: <20190722002207.22649-1-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
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

Commit dd5142ca5d24 ("iommu/vt-d: Add debugfs support to show scalable mode
DMAR table internals") prints content of pasid table entries from LSB to
MSB where as other entries are printed MSB to LSB. So, to maintain
uniformity among all entries and to not confuse the user, print MSB first.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 drivers/iommu/intel-iommu-debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu-debugfs.c b/drivers/iommu/intel-iommu-debugfs.c
index 73a552914455..2b25d9c59336 100644
--- a/drivers/iommu/intel-iommu-debugfs.c
+++ b/drivers/iommu/intel-iommu-debugfs.c
@@ -162,9 +162,9 @@ static inline void print_tbl_walk(struct seq_file *m)
 			   (u64)0, (u64)0, (u64)0);
 	else
 		seq_printf(m, "%-6d\t0x%016llx:0x%016llx:0x%016llx\n",
-			   tbl_wlk->pasid, tbl_wlk->pasid_tbl_entry->val[0],
+			   tbl_wlk->pasid, tbl_wlk->pasid_tbl_entry->val[2],
 			   tbl_wlk->pasid_tbl_entry->val[1],
-			   tbl_wlk->pasid_tbl_entry->val[2]);
+			   tbl_wlk->pasid_tbl_entry->val[0]);
 }
 
 static void pasid_tbl_walk(struct seq_file *m, struct pasid_entry *tbl_entry,
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
