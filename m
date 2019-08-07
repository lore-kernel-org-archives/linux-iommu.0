Return-Path: <SRS0=TgA1=WD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F567C433FF
	for <iommu@archiver.kernel.org>; Wed,  7 Aug 2019 08:27:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7705C217F4
	for <iommu@archiver.kernel.org>; Wed,  7 Aug 2019 08:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EL1NmTHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7705C217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EE169EEA;
	Wed,  7 Aug 2019 08:27:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8BD4AEE1
	for <iommu@lists.linux-foundation.org>;
	Wed,  7 Aug 2019 08:27:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B479E829
	for <iommu@lists.linux-foundation.org>;
	Wed,  7 Aug 2019 08:27:05 +0000 (UTC)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x778R1Wg084370;
	Wed, 7 Aug 2019 03:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1565166421;
	bh=dznvMtx8WlI/gsfrXFq/f0vIQODcMYaYbz6ngNv9Rzw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=EL1NmTHpqjeELOoHl4rax3jmZvpSjiA6oFJx3i2c23Ew0wdyJArIkEXW0oDe6HEBn
	M+x/V5HWz5lFAKxahoUn6MAgEzX3fhQ1DBldAFxPTrOSYiOCqPrCt0mY5suEFU9wc3
	8/QqxCvKue5fjzJmhRatCKyedNc9m9Ug+JVEF0W8=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x778R1Wt125366
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2019 03:27:01 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE110.ent.ti.com
	(157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5;
	Wed, 7 Aug 2019 03:27:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
	(157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
	Frontend Transport; Wed, 7 Aug 2019 03:27:00 -0500
Received: from gomoku.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x778QwO1046515;
	Wed, 7 Aug 2019 03:27:00 -0500
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH 1/8] iommu/omap: fix boot issue on remoteprocs with
	AMMU/Unicache
Date: Wed, 7 Aug 2019 11:26:45 +0300
Message-ID: <1565166412-31195-2-git-send-email-t-kristo@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565166412-31195-1-git-send-email-t-kristo@ti.com>
References: <1565166412-31195-1-git-send-email-t-kristo@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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
From: Tero Kristo via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tero Kristo <t-kristo@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Suman Anna <s-anna@ti.com>

Support has been added to the OMAP IOMMU driver to fix a boot hang
issue on OMAP remoteprocs with AMMU/Unicache, caused by an improper
AMMU/Unicache state upon initial deassertion of the processor reset.
The issue is described in detail in the next three paragraphs.

All the Cortex M3/M4 IPU processor subsystems in OMAP SoCs have a
AMMU/Unicache IP that dictates the memory attributes for addresses
seen by the processor cores. The AMMU/Unicache is configured/enabled
by the SCACHE_CONFIG.BYPASS bit - a value of 1 enables the cache and
mandates all addresses accessed by M3/M4 be defined in the AMMU. This
bit is not programmable from the host processor. The M3/M4 boot
sequence starts out with the AMMU/Unicache in disabled state, and
SYS/BIOS programs the AMMU regions and enables the Unicache during
one of its initial boot steps. This SCACHE_CONFIG.BYPASS bit is
however enabled by default whenever a RET reset is applied to the IP,
irrespective of whether it was previously enabled or not. The AMMU
registers lose their context whenever this reset is applied. The reset
is effective as long as the MMU portion of the subsystem is enabled
and clocked. This behavior is common to all the IPU and DSP subsystems
that have an AMMU/Unicache.

The IPU boot sequence involves enabling and programming the MMU, and
loading the processor and releasing the reset(s) for the processor.
The PM setup code currently sets the target state for most of the
power domains to RET. The L2 MMU can be enabled, programmed and
accessed properly just fine with the domain in hardware supervised
mode, while the power domain goes through a RET->ON->RET transition
during the programming sequence. However, the ON->RET transition
asserts a RET reset, and the SCACHE_CONFIG.BYPASS bit gets auto-set.
An AMMU fault is thrown immediately when the M3/M4 core's reset is
released since the first instruction address itself will not be
defined in any valid AMMU regions. The ON->RET transition happens
automatically on the power domain after enabling the iommu due to
the hardware supervised mode.

This patch adds and invokes the .set_pwrdm_constraint pdata ops, if
present, during the OMAP IOMMU enable and disable functions to resolve
the above boot hang issue. The ops will allow to invoke a mach-omap2
layer API pwrdm_set_next_pwrst() in a multi-arch kernel environment.
The ops also returns the current power domain state while enforcing
the constraint so that the driver can store it and use it to set back
the power domain state while releasing the constraint. The pdata ops
implementation restricts the target power domain to ON during enable,
and back to the original power domain state during disable, and thereby
eliminating the conditions for the boot issue. The implementation is
effective only when the original power domain state is either RET or
OFF, and is a no-op when it is ON or INACTIVE.

The .set_pwrdm_constraint ops need to be plugged in pdata-quirks
for the affected remote processors to be able to boot properly.

Note that the current issue is seen only on kernels with the affected
power domains programmed to enter RET. For eg., IPU1 on DRA7xx is in a
separate domain and is susceptible to this bug, while the IPU2 subsystem
is within CORE power domain, and CORE RET is not supported on this SoC.
IPUs on OMAP4 and OMAP5 are also susceptible since they are in CORE power
domain, and CORE RET is a valid power target on these SoCs.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/Makefile             |  2 ++
 arch/arm/mach-omap2/omap-iommu.c         | 51 ++++++++++++++++++++++++++++++++
 drivers/iommu/omap-iommu.c               | 17 +++++++++++
 drivers/iommu/omap-iommu.h               |  2 ++
 include/linux/platform_data/iommu-omap.h |  2 ++
 5 files changed, 74 insertions(+)
 create mode 100644 arch/arm/mach-omap2/omap-iommu.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 6006505..d4f11c5 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -229,3 +229,5 @@ include/generated/ti-pm-asm-offsets.h: arch/arm/mach-omap2/pm-asm-offsets.s FORC
 $(obj)/sleep33xx.o $(obj)/sleep43xx.o: include/generated/ti-pm-asm-offsets.h
 
 targets += pm-asm-offsets.s
+
+obj-$(CONFIG_OMAP_IOMMU)		+= omap-iommu.o
diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
new file mode 100644
index 0000000..1392a5b
--- /dev/null
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * OMAP IOMMU quirks for various TI SoCs
+ *
+ * Copyright (C) 2015-2019 Texas Instruments Incorporated - http://www.ti.com/
+ *      Suman Anna <s-anna@ti.com>
+ */
+
+#include <linux/platform_device.h>
+#include <linux/err.h>
+
+#include "omap_hwmod.h"
+#include "omap_device.h"
+#include "powerdomain.h"
+
+int omap_iommu_set_pwrdm_constraint(struct platform_device *pdev, bool request,
+				    u8 *pwrst)
+{
+	struct powerdomain *pwrdm;
+	struct omap_device *od;
+	u8 next_pwrst;
+
+	od = to_omap_device(pdev);
+	if (!od)
+		return -ENODEV;
+
+	if (od->hwmods_cnt != 1)
+		return -EINVAL;
+
+	pwrdm = omap_hwmod_get_pwrdm(od->hwmods[0]);
+	if (!pwrdm)
+		return -EINVAL;
+
+	if (request)
+		*pwrst = pwrdm_read_next_pwrst(pwrdm);
+
+	if (*pwrst > PWRDM_POWER_RET)
+		return 0;
+
+	next_pwrst = request ? PWRDM_POWER_ON : *pwrst;
+
+	return pwrdm_set_next_pwrst(pwrdm, next_pwrst);
+}
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index dfb961d..84b99d5 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -190,6 +190,14 @@ static int iommu_enable(struct omap_iommu *obj)
 	struct platform_device *pdev = to_platform_device(obj->dev);
 	struct iommu_platform_data *pdata = dev_get_platdata(&pdev->dev);
 
+	if (pdata && pdata->set_pwrdm_constraint) {
+		err = pdata->set_pwrdm_constraint(pdev, true, &obj->pwrst);
+		if (err) {
+			dev_warn(obj->dev, "pwrdm_constraint failed to be set, status = %d\n",
+				 err);
+		}
+	}
+
 	if (pdata && pdata->deassert_reset) {
 		err = pdata->deassert_reset(pdev, pdata->reset_name);
 		if (err) {
@@ -209,6 +217,7 @@ static void iommu_disable(struct omap_iommu *obj)
 {
 	struct platform_device *pdev = to_platform_device(obj->dev);
 	struct iommu_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	int ret;
 
 	omap2_iommu_disable(obj);
 
@@ -216,6 +225,14 @@ static void iommu_disable(struct omap_iommu *obj)
 
 	if (pdata && pdata->assert_reset)
 		pdata->assert_reset(pdev, pdata->reset_name);
+
+	if (pdata && pdata->set_pwrdm_constraint) {
+		ret = pdata->set_pwrdm_constraint(pdev, false, &obj->pwrst);
+		if (ret) {
+			dev_warn(obj->dev, "pwrdm_constraint failed to be reset, status = %d\n",
+				 ret);
+		}
+	}
 }
 
 /*
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index 09968a0..aac1ca6 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -78,6 +78,8 @@ struct omap_iommu {
 
 	struct iommu_device iommu;
 	struct iommu_group *group;
+
+	u8 pwrst;
 };
 
 /**
diff --git a/include/linux/platform_data/iommu-omap.h b/include/linux/platform_data/iommu-omap.h
index 44d913a..1ed6026 100644
--- a/include/linux/platform_data/iommu-omap.h
+++ b/include/linux/platform_data/iommu-omap.h
@@ -13,4 +13,6 @@ struct iommu_platform_data {
 	const char *reset_name;
 	int (*assert_reset)(struct platform_device *pdev, const char *name);
 	int (*deassert_reset)(struct platform_device *pdev, const char *name);
+	int (*set_pwrdm_constraint)(struct platform_device *pdev, bool request,
+				    u8 *pwrst);
 };
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
