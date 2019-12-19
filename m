Return-Path: <SRS0=c0M2=2J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57285C3F68F
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C25C222C2
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGIC12Oy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C25C222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 130A387F0C;
	Thu, 19 Dec 2019 12:04:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zcUI6LcSlKRK; Thu, 19 Dec 2019 12:04:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 14BE187EFB;
	Thu, 19 Dec 2019 12:04:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02F20C18DC;
	Thu, 19 Dec 2019 12:04:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7087EC077D
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:04:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6D28186BE1
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:04:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CWkqXAt6dWwN for <iommu@lists.linuxfoundation.org>;
 Thu, 19 Dec 2019 12:04:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3170C87EF8
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:04:41 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A53A924688;
 Thu, 19 Dec 2019 12:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576757081;
 bh=Ou1QSenIX/ZPR01QhZ3Eov9oYA+rmJXBLNuMfDc7+GQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gGIC12OyAsd4qU9XFvo2hKhdFDR9Iq/fk+P3S0i7ojRAectu6hh+ois+Lzktyw5f/
 Ta74IyXCFRoLCd+dXC6b7ZYEVdYREYyDXK/htuqb69Ij06HpRZgVrePBtP9qT1l1ky
 9DyZQAGzSu+zJBQDSgrsS61n16Wrg8p2OIKFHAkU=
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linuxfoundation.org
Subject: [PATCH v4 14/16] iommu/arm-smmu: Unregister IOMMU and bus ops on
 device removal
Date: Thu, 19 Dec 2019 12:03:50 +0000
Message-Id: <20191219120352.382-15-will@kernel.org>
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

When removing the SMMU driver, we need to clear any state that we
registered during probe. This includes our bus ops, sysfs entries and
the IOMMU device registered for early firmware probing of masters.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/arm-smmu.c | 50 ++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5d2f60bb9e50..1f0c09bf112a 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2009,25 +2009,51 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	return 0;
 }
 
-static void arm_smmu_bus_init(void)
+static int arm_smmu_bus_init(struct iommu_ops *ops)
 {
+	int err;
+
 	/* Oh, for a proper bus abstraction */
-	if (!iommu_present(&platform_bus_type))
-		bus_set_iommu(&platform_bus_type, &arm_smmu_ops);
+	if (!iommu_present(&platform_bus_type)) {
+		err = bus_set_iommu(&platform_bus_type, ops);
+		if (err)
+			return err;
+	}
 #ifdef CONFIG_ARM_AMBA
-	if (!iommu_present(&amba_bustype))
-		bus_set_iommu(&amba_bustype, &arm_smmu_ops);
+	if (!iommu_present(&amba_bustype)) {
+		err = bus_set_iommu(&amba_bustype, ops);
+		if (err)
+			goto err_reset_platform_ops;
+	}
 #endif
 #ifdef CONFIG_PCI
 	if (!iommu_present(&pci_bus_type)) {
 		pci_request_acs();
-		bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
+		err = bus_set_iommu(&pci_bus_type, ops);
+		if (err)
+			goto err_reset_amba_ops;
 	}
 #endif
 #ifdef CONFIG_FSL_MC_BUS
-	if (!iommu_present(&fsl_mc_bus_type))
-		bus_set_iommu(&fsl_mc_bus_type, &arm_smmu_ops);
+	if (!iommu_present(&fsl_mc_bus_type)) {
+		err = bus_set_iommu(&fsl_mc_bus_type, ops);
+		if (err)
+			goto err_reset_pci_ops;
+	}
+#endif
+	return 0;
+
+err_reset_pci_ops: __maybe_unused;
+#ifdef CONFIG_PCI
+	bus_set_iommu(&pci_bus_type, NULL);
 #endif
+err_reset_amba_ops: __maybe_unused;
+#ifdef CONFIG_ARM_AMBA
+	bus_set_iommu(&amba_bustype, NULL);
+#endif
+err_reset_platform_ops: __maybe_unused;
+	bus_set_iommu(&platform_bus_type, NULL);
+	return err;
 }
 
 static int arm_smmu_device_probe(struct platform_device *pdev)
@@ -2173,7 +2199,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	 * ready to handle default domain setup as soon as any SMMU exists.
 	 */
 	if (!using_legacy_binding)
-		arm_smmu_bus_init();
+		return arm_smmu_bus_init(&arm_smmu_ops);
 
 	return 0;
 }
@@ -2187,7 +2213,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 static int arm_smmu_legacy_bus_init(void)
 {
 	if (using_legacy_binding)
-		arm_smmu_bus_init();
+		return arm_smmu_bus_init(&arm_smmu_ops);
 	return 0;
 }
 device_initcall_sync(arm_smmu_legacy_bus_init);
@@ -2202,6 +2228,10 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
 		dev_err(&pdev->dev, "removing device with active domains!\n");
 
+	arm_smmu_bus_init(NULL);
+	iommu_device_unregister(&smmu->iommu);
+	iommu_device_sysfs_remove(&smmu->iommu);
+
 	arm_smmu_rpm_get(smmu);
 	/* Turn the thing off */
 	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_sCR0, sCR0_CLIENTPD);
-- 
2.24.1.735.g03f4e72817-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
