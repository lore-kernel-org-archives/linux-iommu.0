Return-Path: <SRS0=c0M2=2J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F988C2D0C1
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C3F24685
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z4buwxKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C3F24685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 62CB82326C;
	Thu, 19 Dec 2019 12:04:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id daYkhKnSBPUK; Thu, 19 Dec 2019 12:04:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AA370231EF;
	Thu, 19 Dec 2019 12:04:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EFD9C18DC;
	Thu, 19 Dec 2019 12:04:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C80BC077D
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:04:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 188BA87EFD
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:04:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sXGMK0LYj4+m for <iommu@lists.linuxfoundation.org>;
 Thu, 19 Dec 2019 12:04:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8EEB487EFB
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:04:35 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0272524684;
 Thu, 19 Dec 2019 12:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576757075;
 bh=ZWu/BRMh45ey2/+NOodYySlbK+BJsxdZgItFNtS2Vzs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=z4buwxKD9N1mp2Bklv1roxu3ObpRgjzsbf0LGyVbNONyxjW7apNDAHSTSbQb4Ht3Z
 HMkrmKiXWR56IInnoR70ShrQZkwW7+unCDsJCqcmBPIbaYB1tOEluqq9Ead3czW6k8
 0s5Mg90QZqAtzJh8+m4nAJ42Egl4Uk8mrGPrzmwM=
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linuxfoundation.org
Subject: [PATCH v4 12/16] iommu/arm-smmu: Support SMMU module probing from the
 IORT
Date: Thu, 19 Dec 2019 12:03:48 +0000
Message-Id: <20191219120352.382-13-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219120352.382-1-will@kernel.org>
References: <20191219120352.382-1-will@kernel.org>
MIME-Version: 1.0
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
 Robin Murphy <robin.murphy@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>
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

From: Ard Biesheuvel <ardb@kernel.org>

Add support for SMMU drivers built as modules to the ACPI/IORT device
probing path, by deferring the probe of the master if the SMMU driver is
known to exist but has not been loaded yet. Given that the IORT code
registers a platform device for each SMMU that it discovers, we can
easily trigger the udev based autoloading of the SMMU drivers by making
the platform device identifier part of the module alias.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: John Garry <john.garry@huawei.com> # only manual smmu ko loading
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/acpi/arm64/iort.c   | 4 ++--
 drivers/iommu/arm-smmu-v3.c | 1 +
 drivers/iommu/arm-smmu.c    | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 33f71983e001..4a560fdf7386 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -850,9 +850,9 @@ static inline bool iort_iommu_driver_enabled(u8 type)
 {
 	switch (type) {
 	case ACPI_IORT_NODE_SMMU_V3:
-		return IS_BUILTIN(CONFIG_ARM_SMMU_V3);
+		return IS_ENABLED(CONFIG_ARM_SMMU_V3);
 	case ACPI_IORT_NODE_SMMU:
-		return IS_BUILTIN(CONFIG_ARM_SMMU);
+		return IS_ENABLED(CONFIG_ARM_SMMU);
 	default:
 		pr_warn("IORT node type %u does not describe an SMMU\n", type);
 		return false;
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 46160a2fec3e..da9474a02668 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -3734,4 +3734,5 @@ module_platform_driver(arm_smmu_driver);
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
+MODULE_ALIAS("platform:arm-smmu-v3");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5cbee88a3b83..5d2f60bb9e50 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2281,4 +2281,5 @@ module_platform_driver(arm_smmu_driver);
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
+MODULE_ALIAS("platform:arm-smmu");
 MODULE_LICENSE("GPL v2");
-- 
2.24.1.735.g03f4e72817-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
