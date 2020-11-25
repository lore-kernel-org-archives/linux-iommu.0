Return-Path: <SRS0=GPDh=E7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727A2C63777
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 10:12:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E18FD2083E
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 10:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvMPkn9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18FD2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9DD9387504;
	Wed, 25 Nov 2020 10:12:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5oftZYBT2G5k; Wed, 25 Nov 2020 10:12:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 272DB874FA;
	Wed, 25 Nov 2020 10:12:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E6A1C0891;
	Wed, 25 Nov 2020 10:12:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 130C0C0052
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 10:11:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0E97B86E0D
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 10:11:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VM86OMIwddHr for <iommu@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 10:11:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A222986E04
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 10:11:55 +0000 (UTC)
Received: by mail-pl1-f194.google.com with SMTP id u2so864199pls.10
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 02:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HoasHv3y6th/yvEKkLA5l4WpDaFfWmVWvaf3/EksU3s=;
 b=EvMPkn9iIXJjwCLoEKVFo7ymURGwzfJq3//6UucjvYZMhdT94vVL3PaXw5KMgtH2HG
 uagBLZTSmlFHKunUzHtH9QcFYVUU05ey9owWvW1hvNv7fkBImHGzgaSSwbWy0yLtMxfc
 N2+uhaUtRnvdgY2GqZ+hBHbezztseKyK+1ovIHrdUBPxS73skE92iEQyekAVXkC5+7gV
 OvwhIyFE6b6LL15TZxIXwgxpy0Qeg5b52qzI2jvUKTfCxK8iVBwtPQcQjsvy2p08YLzT
 GDxTbOFGldJO1Z8z/6VX//56QIOWV1vY56ZPlRHbDUyNXvUJ1kwLeOG8HxBiSErd08E7
 XRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=HoasHv3y6th/yvEKkLA5l4WpDaFfWmVWvaf3/EksU3s=;
 b=RJ2xcxnkhAKkRfDH+/6sjoXk8yK2xhwK9xnrPCcb8yH+703PJT3BZtdQX9vMWm/aUN
 1sfWXDRsAJuP1Z/+SLfoSgb0Qm8jBcC7Qhma6+9sk9Ji/7pDHZvTxaFds3QxSyJHN1SI
 xEPeTTHLUXZoZUkgW7TiiyneT3wZSk2nUUikhGZUkWzpYORZ3BVAkNrs8bBwVYtYW88t
 oAB1e/4n9o22Z/GftQn8amImwF7ek0KfJ/r+ueir8h8Bj93KYRfz7OE6s9E9QA0Nty3W
 U5jEuObAV/8XtsuIoWrubNjwbNKQLj7K+HL3vebMP71TglIN6FOcZa+bTc9smxNTl3O/
 KC9g==
X-Gm-Message-State: AOAM532Ek9U42jJwecdql96q1QErRyixEsARnTRR4KNsym2761LDb1Fr
 xgLFQR+KLGr+1FbWG7H+SUk=
X-Google-Smtp-Source: ABdhPJz3PNXjHZ4o8ksVTnfDjJM/nPQ95qM+ZuFYmYMwrcd6Ee1kfFaIhnNoAxNsf4nZTOLdl69xOw==
X-Received: by 2002:a17:902:26a:b029:d6:caca:620a with SMTP id
 97-20020a170902026ab02900d6caca620amr2527900plc.46.1606299115271; 
 Wed, 25 Nov 2020 02:11:55 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id r130sm1599496pfc.41.2020.11.25.02.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2020 02:11:54 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: will@kernel.org
Subject: [PATCH RESEND v2 5/5] iommu/tegra-smmu: Add PCI support
Date: Wed, 25 Nov 2020 02:10:13 -0800
Message-Id: <20201125101013.14953-6-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201125101013.14953-1-nicoleotsuka@gmail.com>
References: <20201125101013.14953-1-nicoleotsuka@gmail.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org, jonathanh@nvidia.com
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

This patch simply adds support for PCI devices.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index f45ed43cf8db..4a3f095a1c26 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -865,7 +866,11 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 	group->smmu = smmu;
 	group->soc = soc;
 
-	group->group = iommu_group_alloc();
+	if (dev_is_pci(dev))
+		group->group = pci_device_group(dev);
+	else
+		group->group = generic_device_group(dev);
+
 	if (IS_ERR(group->group)) {
 		devm_kfree(smmu->dev, group);
 		mutex_unlock(&smmu->lock);
@@ -1075,22 +1080,32 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 	iommu_device_set_fwnode(&smmu->iommu, dev->fwnode);
 
 	err = iommu_device_register(&smmu->iommu);
-	if (err) {
-		iommu_device_sysfs_remove(&smmu->iommu);
-		return ERR_PTR(err);
-	}
+	if (err)
+		goto remove_sysfs;
 
 	err = bus_set_iommu(&platform_bus_type, &tegra_smmu_ops);
-	if (err < 0) {
-		iommu_device_unregister(&smmu->iommu);
-		iommu_device_sysfs_remove(&smmu->iommu);
-		return ERR_PTR(err);
-	}
+	if (err < 0)
+		goto unregister;
+
+#ifdef CONFIG_PCI
+	err = bus_set_iommu(&pci_bus_type, &tegra_smmu_ops);
+	if (err < 0)
+		goto unset_platform_bus;
+#endif
 
 	if (IS_ENABLED(CONFIG_DEBUG_FS))
 		tegra_smmu_debugfs_init(smmu);
 
 	return smmu;
+
+unset_platform_bus: __maybe_unused;
+	bus_set_iommu(&platform_bus_type, NULL);
+unregister:
+	iommu_device_unregister(&smmu->iommu);
+remove_sysfs:
+	iommu_device_sysfs_remove(&smmu->iommu);
+
+	return ERR_PTR(err);
 }
 
 void tegra_smmu_remove(struct tegra_smmu *smmu)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
