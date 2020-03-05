Return-Path: <SRS0=kRV3=4W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB09C3F2D1
	for <iommu@archiver.kernel.org>; Thu,  5 Mar 2020 20:25:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D777207FD
	for <iommu@archiver.kernel.org>; Thu,  5 Mar 2020 20:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Q5g8rYEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D777207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7287C20134;
	Thu,  5 Mar 2020 20:25:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ptkEHvJjKf-l; Thu,  5 Mar 2020 20:25:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 427862151F;
	Thu,  5 Mar 2020 20:25:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DCE4C1AE2;
	Thu,  5 Mar 2020 20:25:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38766C013E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Mar 2020 20:25:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 346882151F
 for <iommu@lists.linux-foundation.org>; Thu,  5 Mar 2020 20:25:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8m0KQ0aXn+IF for <iommu@lists.linux-foundation.org>;
 Thu,  5 Mar 2020 20:25:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 by silver.osuosl.org (Postfix) with ESMTPS id 5B53220134
 for <iommu@lists.linux-foundation.org>; Thu,  5 Mar 2020 20:25:00 +0000 (UTC)
Received: by mail-qt1-f194.google.com with SMTP id h16so46454qtr.11
 for <iommu@lists.linux-foundation.org>; Thu, 05 Mar 2020 12:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=EtvUYpx/Z6jkOZvIKTGZ1YcNxmsRMa5tAVsSg5EuMhY=;
 b=Q5g8rYEbooZCweqZN9vq52DV5MrDA80j55ts6X0pDZ5lQA7onJ4ZLCWhc1Ih5wtCZn
 bDB9MUgEAa4hLg2LgEvy3EN3aBTsbXRTYXG5+b6DxpzxbCoZEtqESFI6uPAxr0h7Ok5Z
 ZDi2D8FmgdAPKe4MJHMGZP2fBtt9d9ZQoeFUes3aj/+EIscyYpBwFB+sZmx5Tjun42eb
 hUPY7LkUcH0cAIiAcSvecVxXJerpkQY26TU2F3Ck4RyJg50ydFcNnAG5Xkeye628LHDQ
 eACQJjlGaMUXaL2fOMqECgtEKRq9fI4SdQbtsf7neiVrjGBah0jSzkSoVgPgYSGyXuzz
 3lPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=EtvUYpx/Z6jkOZvIKTGZ1YcNxmsRMa5tAVsSg5EuMhY=;
 b=ojgxzzX2rinUpU98KVfWMTVIq0NtwzT4JMe0t4M5s3BbeVIZEfAtLu2cQbCLtXiXM5
 puZmyi0pnGqDwRHCLwtdegw35L8lLGMm9F5yNKOkgA3Z2ibm20NhGIRo4o5suC8WceaW
 AuTc/tHrMmhAIvAMsM81yZTdmg+X4k1FA8OHN/Sb1093P5+9QSdBAPOLtQS80ZC/4og5
 /9+dmk2lYMllFiKa8VGT74UugCDA6uO82lz+29He6UIHRuCcWeT1nRtcyYFCLCwO8tpM
 QCHnzSQzFq5NKffFEj8TXet+WsAnebdMWd8mQD3OHD21RrtQLADVdGX42RzPKkeEx4Fd
 2i8w==
X-Gm-Message-State: ANhLgQ3fypU0eBy9AC8OkNipKVAUXmpvUGyx0wdPGY5AI3UwSLcHWGIE
 93GD8ANELhXgf7ORFLbzPQ8imKfNbj4=
X-Google-Smtp-Source: ADFU+vs2fX0fSX8HT8ldaRkDqTnvkbe+A+L8CQ9JvxGCaw+F/gPTk0fICGkAht0UcmGT1kh4f+zKTA==
X-Received: by 2002:ac8:4cd1:: with SMTP id l17mr362984qtv.165.1583438476608; 
 Thu, 05 Mar 2020 12:01:16 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id w21sm17576346qth.17.2020.03.05.12.01.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Mar 2020 12:01:15 -0800 (PST)
From: Qian Cai <cai@lca.pw>
To: jroedel@suse.de
Subject: [PATCH] iommu/vt-d: fix RCU-list bugs in intel_iommu_init
Date: Thu,  5 Mar 2020 15:00:46 -0500
Message-Id: <1583438446-9959-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

There are several places traverse RCU-list without holding any lock in
intel_iommu_init(). Fix them by acquiring dmar_global_lock.

 WARNING: suspicious RCU usage
 -----------------------------
 drivers/iommu/intel-iommu.c:5216 RCU-list traversed in non-reader section!!

 other info that might help us debug this:

 rcu_scheduler_active = 2, debug_locks = 1
 no locks held by swapper/0/1.

 Call Trace:
  dump_stack+0xa0/0xea
  lockdep_rcu_suspicious+0x102/0x10b
  intel_iommu_init+0x947/0xb13
  pci_iommu_init+0x26/0x62
  do_one_initcall+0xfe/0x500
  kernel_init_freeable+0x45a/0x4f8
  kernel_init+0x11/0x139
  ret_from_fork+0x3a/0x50
 DMAR: Intel(R) Virtualization Technology for Directed I/O

Fixes: d8190dc63886 ("iommu/vt-d: Enable DMA remapping after rmrr mapped")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/intel-iommu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6fa6de2b6ad5..bc138ceb07bc 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5193,6 +5193,7 @@ int __init intel_iommu_init(void)
 
 	init_iommu_pm_ops();
 
+	down_read(&dmar_global_lock);
 	for_each_active_iommu(iommu, drhd) {
 		iommu_device_sysfs_add(&iommu->iommu, NULL,
 				       intel_iommu_groups,
@@ -5200,6 +5201,7 @@ int __init intel_iommu_init(void)
 		iommu_device_set_ops(&iommu->iommu, &intel_iommu_ops);
 		iommu_device_register(&iommu->iommu);
 	}
+	up_read(&dmar_global_lock);
 
 	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
 	if (si_domain && !hw_pass_through)
@@ -5210,7 +5212,6 @@ int __init intel_iommu_init(void)
 	down_read(&dmar_global_lock);
 	if (probe_acpi_namespace_devices())
 		pr_warn("ACPI name space devices didn't probe correctly\n");
-	up_read(&dmar_global_lock);
 
 	/* Finally, we enable the DMA remapping hardware. */
 	for_each_iommu(iommu, drhd) {
@@ -5219,6 +5220,8 @@ int __init intel_iommu_init(void)
 
 		iommu_disable_protect_mem_regions(iommu);
 	}
+	up_read(&dmar_global_lock);
+
 	pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
 
 	intel_iommu_enabled = 1;
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
