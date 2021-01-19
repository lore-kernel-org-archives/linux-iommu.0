Return-Path: <SRS0=ZMVL=GW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24760C433DB
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 09:09:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81FE123100
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 09:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81FE123100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1B532200ED;
	Tue, 19 Jan 2021 09:09:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eRlRCF9ov6ow; Tue, 19 Jan 2021 09:08:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6D4FC2000E;
	Tue, 19 Jan 2021 09:08:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 599F0C08A1;
	Tue, 19 Jan 2021 09:08:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BA7AC013A
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 09:08:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6840D200ED
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 09:08:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Q7E-dXa3egR for <iommu@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 09:08:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by silver.osuosl.org (Postfix) with ESMTPS id 4119A2000E
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 09:08:55 +0000 (UTC)
IronPort-SDR: DGdJ/46peEc8HgsN0LYO7900RL8EPIG/15qEofrikvAttGtkxyS32kvNyk3cdzc1y/mJnGCkXz
 M4YL8xBGzHrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="165989140"
X-IronPort-AV: E=Sophos;i="5.79,358,1602572400"; d="scan'208";a="165989140"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2021 01:08:44 -0800
IronPort-SDR: QvpGs/6lA3D3m8hEoqzMozZXigV0or+92o4ga5NlgK/bkD+AuAYvHZV/Cx+VZ5Uogtf7alJnMe
 Y2jhRhoHy2rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,358,1602572400"; d="scan'208";a="355507244"
Received: from test-kvm.bj.intel.com ([10.240.192.130])
 by fmsmga008.fm.intel.com with ESMTP; 19 Jan 2021 01:08:42 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: 
Subject: [PATCH] iommu/vt-d: debugfs: Check irq_remapping_cap before PI info
 dump
Date: Tue, 19 Jan 2021 13:25:26 -0500
Message-Id: <20210119182526.2927-1-tina.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Yi Sun <yi.sun@intel.com>
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

irq_remapping_cap() was introduced to detect whether irq remapping
supports new features, such as VT-d Posted-Interrupts", according to
commit 959c870f7305 ("iommu, x86: Provide irq_remapping_cap() interface").

The VT-d Posted-Interrupts support can be disabled by the command
line parameter "intremap=nopost".

So, it's better to use irq_remapping_cap() to check if the VT-d
Posted-Interrupts is enabled before any Posted Interrupt Descriptor
info dump.

Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reported-by: Yi Sun <yi.sun@intel.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index efea7f02abd9..87a4a76866f4 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -516,7 +516,8 @@ static int ir_translation_struct_show(struct seq_file *m, void *unused)
 	seq_puts(m, "****\n\n");
 
 	for_each_active_iommu(iommu, drhd) {
-		if (!cap_pi_support(iommu->cap))
+		if (!irq_remapping_cap(IRQ_POSTING_CAP) ||
+		    !cap_pi_support(iommu->cap))
 			continue;
 
 		seq_printf(m, "Posted Interrupt supported on IOMMU: %s\n",
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
