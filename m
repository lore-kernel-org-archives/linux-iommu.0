Return-Path: <SRS0=7D56=DK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BB8C4363D
	for <iommu@archiver.kernel.org>; Sat,  3 Oct 2020 07:06:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D88DC206B8
	for <iommu@archiver.kernel.org>; Sat,  3 Oct 2020 07:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHy0PuL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88DC206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 69C882036E;
	Sat,  3 Oct 2020 07:06:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HYnWS2oNwfxb; Sat,  3 Oct 2020 07:06:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C440720420;
	Sat,  3 Oct 2020 07:06:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE0F6C1AD4;
	Sat,  3 Oct 2020 07:06:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D963C0051
 for <iommu@lists.linux-foundation.org>; Sat,  3 Oct 2020 07:06:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 59FF2868A8
 for <iommu@lists.linux-foundation.org>; Sat,  3 Oct 2020 07:06:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wjGoP3tTTNtX for <iommu@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 07:06:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
 [209.85.216.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3CE788665F
 for <iommu@lists.linux-foundation.org>; Sat,  3 Oct 2020 07:06:02 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id a17so1787883pju.1
 for <iommu@lists.linux-foundation.org>; Sat, 03 Oct 2020 00:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3PXF6Unc+l1IUCbIelHhHwgXAVYs8b+XwVuG2K0k6GQ=;
 b=pHy0PuL7omLy4ih8GOtsTuICUP772YVVOdNFUWGcvKlHEePtO9aywHJvzn7dP0KXU/
 WEW1S7rZiETjXKak9dkWx8rOlpVgY0YI0XVUy1e1FiKX32NP6scL0KOj+LsJT35ZNe3A
 o3LIdvmcXG8a+8iVS+rEZiMgkKpXy83Ec8rtg+Mr9KUIcHlOvoM+U6iMJvml/YroLfTw
 d/0wM82xgNyWQbgqSiOocgHbhurZytagxazwWX0WKjTphDlEl8ELVyeKqxXPiVBlXiwt
 KF6mh5hIXDVpy5ILIaBflou8TY2akbtboxQjRb1UtAxesPxa1pobS/bzSWnBzuG2K5v9
 nZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3PXF6Unc+l1IUCbIelHhHwgXAVYs8b+XwVuG2K0k6GQ=;
 b=sYEWh8EnrfAtYajMPUe3TqGchIuEUW9lN9/54dhWYyNyLwF7GTl/8eQ2UVRPqX4Fol
 FRjHHFreSWysxoOS5AmqPo5pjkzTDbmAPWCXFIW85QzrDhilVo8qMVYnTK+qGkVIXs7/
 wxLJmk5rhtPCLe53KqdGaWjlWhbTS7ZpahvEdeQRVY0/jzgTvtNpwpmx676qKoia+Xck
 y+wXog/oSSNvhb9sRoWa+DVr4YaE9nWtS0z0+1K0DJaCG4dYtOe4otOOcDfm4QuuebMM
 E99YJar4MR2O81PmmvbKf9YKp4fH9pOXZ0mm2FCvIYklo5AX0kmVJ8yL4i93PU8TDh3x
 FNtw==
X-Gm-Message-State: AOAM5317loeDCa6C9rU14ueScVm6L6A7sEsA917Xg31JlR17pYEoO+/M
 m+8rU37jt15e0/sIDrVPqE0=
X-Google-Smtp-Source: ABdhPJxIox5RHrFqR5hJPSA2WIstUsXbf+7RQUNblMWemn+U44s1lGzWruUEJbzhCz5WaeLpa0bHDg==
X-Received: by 2002:a17:90a:6705:: with SMTP id
 n5mr6422902pjj.72.1601708761858; 
 Sat, 03 Oct 2020 00:06:01 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id d25sm3854498pgl.23.2020.10.03.00.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2020 00:06:01 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com,
	joro@8bytes.org,
	digetx@gmail.com
Subject: [PATCH v5 3/3] iommu/tegra-smmu: Add PCI support
Date: Fri,  2 Oct 2020 23:59:47 -0700
Message-Id: <20201003065947.18671-4-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201003065947.18671-1-nicoleotsuka@gmail.com>
References: <20201003065947.18671-1-nicoleotsuka@gmail.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com
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

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog
v4->v5
 * Added Dmitry's Reviewed-by
v3->v4
 * Dropped !iommu_present() check
 * Added CONFIG_PCI check in the exit path
v2->v3
 * Replaced ternary conditional operator with if-else in .device_group()
 * Dropped change in tegra_smmu_remove()
v1->v2
 * Added error-out labels in tegra_smmu_probe()
 * Dropped pci_request_acs() since IOMMU core would call it.

 drivers/iommu/tegra-smmu.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 73b091facae0..babab6d51360 100644
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
@@ -1071,22 +1076,32 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 	iommu_device_set_fwnode(&smmu->iommu, dev->fwnode);
 
 	err = iommu_device_register(&smmu->iommu);
-	if (err) {
-		iommu_device_sysfs_remove(&smmu->iommu);
-		return ERR_PTR(err);
-	}
+	if (err)
+		goto err_sysfs;
 
 	err = bus_set_iommu(&platform_bus_type, &tegra_smmu_ops);
-	if (err < 0) {
-		iommu_device_unregister(&smmu->iommu);
-		iommu_device_sysfs_remove(&smmu->iommu);
-		return ERR_PTR(err);
-	}
+	if (err < 0)
+		goto err_unregister;
+
+#ifdef CONFIG_PCI
+	err = bus_set_iommu(&pci_bus_type, &tegra_smmu_ops);
+	if (err < 0)
+		goto err_bus_set;
+#endif
 
 	if (IS_ENABLED(CONFIG_DEBUG_FS))
 		tegra_smmu_debugfs_init(smmu);
 
 	return smmu;
+
+err_bus_set: __maybe_unused;
+	bus_set_iommu(&platform_bus_type, NULL);
+err_unregister:
+	iommu_device_unregister(&smmu->iommu);
+err_sysfs:
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
