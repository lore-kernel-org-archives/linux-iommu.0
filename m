Return-Path: <SRS0=hfNk=2U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5D4C3F68F
	for <iommu@archiver.kernel.org>; Mon, 30 Dec 2019 17:26:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C305E2071E
	for <iommu@archiver.kernel.org>; Mon, 30 Dec 2019 17:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ztprat6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C305E2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B3FA182998;
	Mon, 30 Dec 2019 17:26:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sCKPEL8of-t2; Mon, 30 Dec 2019 17:26:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 488C0822F7;
	Mon, 30 Dec 2019 17:26:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 367E2C1796;
	Mon, 30 Dec 2019 17:26:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05087C077D
 for <iommu@lists.linux-foundation.org>; Mon, 30 Dec 2019 17:26:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E872B81EBE
 for <iommu@lists.linux-foundation.org>; Mon, 30 Dec 2019 17:26:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U9t9Y8JStj8n for <iommu@lists.linux-foundation.org>;
 Mon, 30 Dec 2019 17:26:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4A47481B3B
 for <iommu@lists.linux-foundation.org>; Mon, 30 Dec 2019 17:26:33 +0000 (UTC)
Received: from localhost.localdomain (unknown [194.230.155.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EFD5E20730;
 Mon, 30 Dec 2019 17:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1577726793;
 bh=WI3AUEHv2mSX/rTgYvCDyLE6KFEp215twOVaWTDYKaU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ztprat6+2eMdb9X7G5j1siqsB9e3xMO55Md9+qDr8sGe7WzbaMmbqDQLhJXQmFm1j
 S9dq9mJqNu0mQ6fDQaBpjtww0njsAut5iW1wSFnt11UcrZZfYA11/Fcv+D10iQ8EIa
 Uzu15c6R1mhrOCXeLD595LB06GqLdoyu73tj33RY=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Douglas Anderson <dianders@chromium.org>, Suman Anna <s-anna@ti.com>,
 Tero Kristo <t-kristo@ti.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iommu: Enable compile testing for some of drivers
Date: Mon, 30 Dec 2019 18:26:19 +0100
Message-Id: <20191230172619.17814-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230172619.17814-1-krzk@kernel.org>
References: <20191230172619.17814-1-krzk@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
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

Some of the IOMMU drivers can be compile tested to increase build
coverage.  The OMAP, Rockchip and Exynos drivers use
device.dev_archdata.iommu field which does not exist on all platforms.
The sPAPR TCE and ARM SMMU have also restrictions where they can be
built.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/iommu/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 0b9d78a0f3ac..fa27192ad166 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -260,7 +260,7 @@ config IRQ_REMAP
 # OMAP IOMMU support
 config OMAP_IOMMU
 	bool "OMAP IOMMU Support"
-	depends on ARM && MMU
+	depends on ARM && MMU || (COMPILE_TEST && (ARM || ARM64 || IA64 || SPARC))
 	depends on ARCH_OMAP2PLUS || COMPILE_TEST
 	select IOMMU_API
 	---help---
@@ -278,7 +278,7 @@ config OMAP_IOMMU_DEBUG
 
 config ROCKCHIP_IOMMU
 	bool "Rockchip IOMMU Support"
-	depends on ARM || ARM64
+	depends on ARM || ARM64 || (COMPILE_TEST && (ARM64 || IA64 || SPARC))
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	select IOMMU_API
 	select ARM_DMA_USE_IOMMU
@@ -312,7 +312,7 @@ config TEGRA_IOMMU_SMMU
 
 config EXYNOS_IOMMU
 	bool "Exynos IOMMU Support"
-	depends on ARCH_EXYNOS && MMU
+	depends on ARCH_EXYNOS && MMU || (COMPILE_TEST && (ARM || ARM64 || IA64 || SPARC))
 	depends on !CPU_BIG_ENDIAN # revisit driver if we can enable big-endian ptes
 	select IOMMU_API
 	select ARM_DMA_USE_IOMMU
@@ -348,7 +348,7 @@ config IPMMU_VMSA
 
 config SPAPR_TCE_IOMMU
 	bool "sPAPR TCE IOMMU Support"
-	depends on PPC_POWERNV || PPC_PSERIES
+	depends on PPC_POWERNV || PPC_PSERIES || (PPC && COMPILE_TEST)
 	select IOMMU_API
 	help
 	  Enables bits of IOMMU API required by VFIO. The iommu_ops
@@ -357,7 +357,7 @@ config SPAPR_TCE_IOMMU
 # ARM IOMMU support
 config ARM_SMMU
 	bool "ARM Ltd. System MMU (SMMU) Support"
-	depends on (ARM64 || ARM) && MMU
+	depends on (ARM64 || ARM || (COMPILE_TEST && !GENERIC_ATOMIC64)) && MMU
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
 	select ARM_DMA_USE_IOMMU if ARM
@@ -415,7 +415,7 @@ config S390_IOMMU
 
 config S390_CCW_IOMMU
 	bool "S390 CCW IOMMU Support"
-	depends on S390 && CCW
+	depends on S390 && CCW || COMPILE_TEST
 	select IOMMU_API
 	help
 	  Enables bits of IOMMU API required by VFIO. The iommu_ops
@@ -423,7 +423,7 @@ config S390_CCW_IOMMU
 
 config S390_AP_IOMMU
 	bool "S390 AP IOMMU Support"
-	depends on S390 && ZCRYPT
+	depends on S390 && ZCRYPT || COMPILE_TEST
 	select IOMMU_API
 	help
 	  Enables bits of IOMMU API required by VFIO. The iommu_ops
@@ -431,7 +431,7 @@ config S390_AP_IOMMU
 
 config MTK_IOMMU
 	bool "MTK IOMMU Support"
-	depends on ARM || ARM64
+	depends on ARM || ARM64 || COMPILE_TEST
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select ARM_DMA_USE_IOMMU
 	select IOMMU_API
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
