Return-Path: <SRS0=11OQ=YX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B217DCA9EC7
	for <iommu@archiver.kernel.org>; Wed, 30 Oct 2019 14:52:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85FE020856
	for <iommu@archiver.kernel.org>; Wed, 30 Oct 2019 14:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIjO0eEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85FE020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A3691CAA;
	Wed, 30 Oct 2019 14:51:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5A761CAA
	for <iommu@lists.linux-foundation.org>;
	Wed, 30 Oct 2019 14:51:26 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 05F338A
	for <iommu@lists.linux-foundation.org>;
	Wed, 30 Oct 2019 14:51:26 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
	[217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 783E320856;
	Wed, 30 Oct 2019 14:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572447085;
	bh=brW6fp/UFvGvOgU4UgFazFj3pgvjI/gIURAsSARgRYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XIjO0eEVu91Yt6zUTaoq86dVh4rXOhNOfTRdyapva17xNxBeD1C8H/vL3nxe2VIDQ
	af0e3xO8kIv9h6Hi5GsS9E9t6PDZMiuAUZEKfYHCXo+ScanHBfARinzpfWyZq5iNSJ
	mTpfaW3or5H5IYKOiF6DySxwfdLY4H6u0JDLz9Wg=
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] Revert "iommu/arm-smmu: Make arm-smmu-v3 explicitly
	non-modular"
Date: Wed, 30 Oct 2019 14:51:09 +0000
Message-Id: <20191030145112.19738-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030145112.19738-1-will@kernel.org>
References: <20191030145112.19738-1-will@kernel.org>
MIME-Version: 1.0
Cc: Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
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

This reverts commit c07b6426df922d21a13a959cf785d46e9c531941.

Let's get the SMMUv3 driver building as a module, which means putting
back some dead code that we used to carry.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 8da93e730d6f..2ad8e2ca0583 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -21,8 +21,7 @@
 #include <linux/io-pgtable.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
-#include <linux/init.h>
-#include <linux/moduleparam.h>
+#include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -384,10 +383,6 @@
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
 
-/*
- * not really modular, but the easiest way to keep compat with existing
- * bootargs behaviour is to continue using module_param_named here.
- */
 static bool disable_bypass = 1;
 module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
 MODULE_PARM_DESC(disable_bypass,
@@ -3683,25 +3678,37 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void arm_smmu_device_shutdown(struct platform_device *pdev)
+static int arm_smmu_device_remove(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
 	arm_smmu_device_disable(smmu);
+
+	return 0;
+}
+
+static void arm_smmu_device_shutdown(struct platform_device *pdev)
+{
+	arm_smmu_device_remove(pdev);
 }
 
 static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v3", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
 		.name		= "arm-smmu-v3",
 		.of_match_table	= of_match_ptr(arm_smmu_of_match),
-		.suppress_bind_attrs = true,
 	},
 	.probe	= arm_smmu_device_probe,
+	.remove	= arm_smmu_device_remove,
 	.shutdown = arm_smmu_device_shutdown,
 };
-builtin_platform_driver(arm_smmu_driver);
+module_platform_driver(arm_smmu_driver);
+
+MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
+MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.24.0.rc0.303.g954a862665-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
