Return-Path: <SRS0=Yw80=4G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B06C34047
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 17:28:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F68C20801
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 17:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zI6wXDoQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F68C20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D64DD85D45;
	Tue, 18 Feb 2020 17:28:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VvAvLO0TcVLR; Tue, 18 Feb 2020 17:28:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9745D85C97;
	Tue, 18 Feb 2020 17:28:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64EB4C1D8E;
	Tue, 18 Feb 2020 17:28:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0773FC013E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:28:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F202720489
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:28:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ebgd6vOTULuw for <iommu@lists.linux-foundation.org>;
 Tue, 18 Feb 2020 17:28:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 49E482000E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:28:02 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B8DD620801;
 Tue, 18 Feb 2020 17:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582046882;
 bh=e/0/QBFAJAIo5CwD35f4PXrGqg/igQwC2ROF02xxNwI=;
 h=From:To:Cc:Subject:Date:From;
 b=zI6wXDoQIKN5e6XvH8RdVqnBChySi3ghBpaLo9kUZMkfzlNiYCVy/e82Rug5Dcc00
 EvObfdCSBIBGrY/4eKnlHIzn4bf4kFcczX8Rzvgea6pfIOwmCkwdkzf/rWOCt9JS+5
 yqJGITjn4MJBEE/5zNKZbNR4ieavLpKDWKbgH4UQ=
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Subject: [PATCH] iommu/arm-smmu: Restore naming of driver parameter prefix
Date: Tue, 18 Feb 2020 17:27:56 +0000
Message-Id: <20200218172756.2131-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: kernel-team@android.com, Robin Murphy <robin.murphy@arm.com>,
 Russell King <linux@armlinux.org.uk>, iommu@lists.linux-foundation.org,
 Li Yang <leoyang.li@nxp.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

Extending the Arm SMMU driver to allow for modular builds changed
KBUILD_MODNAME to be "arm_smmu_mod" so that a single module could be
built from the multiple existing object files without the need to rename
any source files.

This inadvertently changed the name of the driver parameters, which may
lead to runtime issues if bootloaders are relying on the old names for
correctness (e.g. "arm-smmu.disable_bypass=0").

Although MODULE_PARAM_PREFIX can be overridden to restore the old naming
for builtin parameters, only the new name is matched by modprobe and so
loading the driver as a module would cause parameters specified on the
kernel command line to be ignored. Instead, rename "arm_smmu_mod" to
"arm_smmu". Whilst it's a bit of a bodge, this allows us to create a
single module without renaming any files and makes use of the fact that
underscores and hyphens can be used interchangeably in parameter names.

Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Reported-by: Li Yang <leoyang.li@nxp.com>
Fixes: cd221bd24ff5 ("iommu/arm-smmu: Allow building as a module")
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 2104fb8afc06..9f33fdb3bb05 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -14,8 +14,8 @@ obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o amd_iommu_quirks.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd_iommu_debugfs.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
-obj-$(CONFIG_ARM_SMMU) += arm-smmu-mod.o
-arm-smmu-mod-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-qcom.o
+obj-$(CONFIG_ARM_SMMU) += arm_smmu.o
+arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-qcom.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
 obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o intel-pasid.o
-- 
2.25.0.265.gbab2e86ba0-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
