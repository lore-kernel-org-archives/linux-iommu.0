Return-Path: <SRS0=kXp2=FW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B428AC4361B
	for <iommu@archiver.kernel.org>; Fri, 18 Dec 2020 08:44:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BD13233E2
	for <iommu@archiver.kernel.org>; Fri, 18 Dec 2020 08:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD13233E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7DBA68799D;
	Fri, 18 Dec 2020 08:44:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jHL3HdLOLlDI; Fri, 18 Dec 2020 08:44:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C83C387A67;
	Fri, 18 Dec 2020 08:44:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6182C1787;
	Fri, 18 Dec 2020 08:44:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41D40C0893
 for <iommu@lists.linux-foundation.org>; Fri, 18 Dec 2020 08:44:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 26CFB2E103
 for <iommu@lists.linux-foundation.org>; Fri, 18 Dec 2020 08:44:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ullpvQB1Axgh for <iommu@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 08:44:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from so254-31.mailgun.net (so254-31.mailgun.net [198.61.254.31])
 by silver.osuosl.org (Postfix) with ESMTPS id EB0CC2E10C
 for <iommu@lists.linux-foundation.org>; Fri, 18 Dec 2020 08:44:14 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1608281054; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=R1+sdiecBPkdPUhA6bSf5mYFLSBm7PNyWnxgAPqB4pQ=;
 b=PuMUAjIFXy1nV8vLcPwAb2dbTLZg7gqhLaFlGfnWcAbaA5oxt3pITOC+I0mWW7Z4aXyffELc
 kAJ5Y4y4BiS0IKvs667oZtNhgy3YG0RMzk5hW7kta6EcD2NQR3ggWlnzg4U4f00E5GamxZEK
 k7Vy+hyPZEy8ZAkgknpPhoC4s+c=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5fdc6aa93d3433393db62ece (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Dec 2020 08:39:05
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 59349C43462; Fri, 18 Dec 2020 08:39:05 +0000 (UTC)
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 2990EC433C6;
 Fri, 18 Dec 2020 08:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2990EC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=isaacm@codeaurora.org
From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iommu/io-pgtable-arm: Prepare for modularization
Date: Fri, 18 Dec 2020 00:38:40 -0800
Message-Id: <1608280722-19841-2-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608280722-19841-1-git-send-email-isaacm@codeaurora.org>
References: <1608280722-19841-1-git-send-email-isaacm@codeaurora.org>
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, kernel-team@android.com,
 pdaly@codeaurora.org, will@kernel.org, robin.murphy@arm.com,
 pratikp@codeaurora.org
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

The io-pgtable-arm and io-pgtable-arm-v7s source files will
be compiled as separate modules, along with the io-pgtable
source. Export the symbols for the io-pgtable init function
structures for the io-pgtable module to use.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 4 ++++
 drivers/iommu/io-pgtable-arm.c     | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 1d92ac9..f062c1c 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -28,6 +28,7 @@
 #include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/kmemleak.h>
+#include <linux/module.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -839,6 +840,7 @@ struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns = {
 	.alloc	= arm_v7s_alloc_pgtable,
 	.free	= arm_v7s_free_pgtable,
 };
+EXPORT_SYMBOL_GPL(io_pgtable_arm_v7s_init_fns);
 
 #ifdef CONFIG_IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
 
@@ -984,3 +986,5 @@ static int __init arm_v7s_do_selftests(void)
 }
 subsys_initcall(arm_v7s_do_selftests);
 #endif
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 87def58..2623d57 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -13,6 +13,7 @@
 #include <linux/bitops.h>
 #include <linux/io-pgtable.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -1047,26 +1048,31 @@ struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns = {
 	.alloc	= arm_64_lpae_alloc_pgtable_s1,
 	.free	= arm_lpae_free_pgtable,
 };
+EXPORT_SYMBOL_GPL(io_pgtable_arm_64_lpae_s1_init_fns);
 
 struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns = {
 	.alloc	= arm_64_lpae_alloc_pgtable_s2,
 	.free	= arm_lpae_free_pgtable,
 };
+EXPORT_SYMBOL_GPL(io_pgtable_arm_64_lpae_s2_init_fns);
 
 struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s1_init_fns = {
 	.alloc	= arm_32_lpae_alloc_pgtable_s1,
 	.free	= arm_lpae_free_pgtable,
 };
+EXPORT_SYMBOL_GPL(io_pgtable_arm_32_lpae_s1_init_fns);
 
 struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s2_init_fns = {
 	.alloc	= arm_32_lpae_alloc_pgtable_s2,
 	.free	= arm_lpae_free_pgtable,
 };
+EXPORT_SYMBOL_GPL(io_pgtable_arm_32_lpae_s2_init_fns);
 
 struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
 	.alloc	= arm_mali_lpae_alloc_pgtable,
 	.free	= arm_lpae_free_pgtable,
 };
+EXPORT_SYMBOL_GPL(io_pgtable_arm_mali_lpae_init_fns);
 
 #ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST
 
@@ -1252,3 +1258,5 @@ static int __init arm_lpae_do_selftests(void)
 }
 subsys_initcall(arm_lpae_do_selftests);
 #endif
+
+MODULE_LICENSE("GPL v2");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
