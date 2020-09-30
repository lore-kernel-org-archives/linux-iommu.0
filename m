Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD75C4727C
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 00:35:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 010A52071E
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 00:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Czv7lJP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010A52071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8EE3D8700F;
	Wed, 30 Sep 2020 00:35:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BqH6NbwxkXIW; Wed, 30 Sep 2020 00:35:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B1D6687005;
	Wed, 30 Sep 2020 00:35:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98FC4C0891;
	Wed, 30 Sep 2020 00:35:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08042C0889
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 00:35:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EAF1B86004
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 00:35:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rafhjR0bvybT for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 00:35:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BC47485FEB
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 00:35:47 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id z19so6537946pfn.8
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 17:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=T6RkMef4n6SDIVMgJJ8cgrOCjBvonOscs59BNDVkkmE=;
 b=Czv7lJP2qKVAK/tsi9LxL5aMg7VImOQMCk30SvUz+hHVdh9QKVXkuaaoy6+rcTHyoh
 we9uAPnlcF6UDiDXAXO36DSEtA5ZoQ0dJQSN8GIlkmLY9RW1/NB5NKVT4wLR8+fOuVpg
 RqLMOmg5LqVDw9lEycOl2OxZ7zqbn/7Alcd03KhWPVLAscLsHtSb9S90cTAdBP040wUK
 umSF4jHx4sWI6dTprEYB4r1cVhYYkmwxJxFzeAe/4gw1XDvNiexZghSJ4MeGE0pK6k0j
 7Dd9CWl0B97PFhy3TcC4M3AB/59Wog+qhILI8nAB7L0n+FLU4uo2aGHZfSpy6WsTmO24
 GIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=T6RkMef4n6SDIVMgJJ8cgrOCjBvonOscs59BNDVkkmE=;
 b=mBFxxZrOqYOtED8pwpydI16c29sshooMBYoIEwyrAXOra3p7+3X83IAmpBKdH22EHa
 S2Un0Jb/0d1EUc2fZrZFAV6kM83T0LDR5Er0mJpRNcX3Ruf8sy11nZybYF/xiFlGIB9W
 +37ui75PaqpelmRFTr689HXSRdrzCzRDbpPqPSzH5tnhJ9ZAt6PDqnbNkkwCHA4DwvkU
 vrS+jDfPBQpb0Aa3u9k4YuJMXE/iIzOzgMpSsfCTm3s+MCqgW0QmqC0XibkLwJUXq745
 TuBaNnhi8z1omlffZW5Y8es9z9/+H7IQUcmosdZefYE9n4PcnV4XDiQ13HR1T7P66XEh
 G9hg==
X-Gm-Message-State: AOAM5300VmV0g7bFgCVsg5tlVNoKBBMteQzUsThxup1WeVdWOFRZrYmq
 KcMwWt6e2o9nYnud0622MoY=
X-Google-Smtp-Source: ABdhPJx3OjYAAoX2wmhV2QVQyvwp3Xov47Mvenoy4exyCMLCnbfuteJNwE361RmUZHOZ1/YYW3fMAA==
X-Received: by 2002:a63:de56:: with SMTP id y22mr152276pgi.166.1601426147352; 
 Tue, 29 Sep 2020 17:35:47 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id x185sm6904738pfc.188.2020.09.29.17.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 17:35:46 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com, joro@8bytes.org, krzk@kernel.org,
 digetx@gmail.com
Subject: [PATCH v2 3/3] iommu/tegra-smmu: Add PCI support
Date: Tue, 29 Sep 2020 17:30:13 -0700
Message-Id: <20200930003013.31289-4-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930003013.31289-1-nicoleotsuka@gmail.com>
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
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

This patch simply adds support for PCI devices. Also reverses
bus_set_iommu in tegra_smmu_remove().

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---

Changelog
v1->v2
 * Added error-out labels in tegra_smmu_probe()
 * Dropped pci_request_acs() since IOMMU core would call it.

 drivers/iommu/tegra-smmu.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index cf4981369828..74d84908679e 100644
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
@@ -856,6 +857,7 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 	const struct tegra_smmu_group_soc *soc;
 	unsigned int swgroup = fwspec->ids[0];
 	struct tegra_smmu_group *group;
+	bool pci = dev_is_pci(dev);
 	struct iommu_group *grp;
 
 	/* Find group_soc associating with swgroup */
@@ -882,7 +884,7 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 	group->smmu = smmu;
 	group->soc = soc;
 
-	group->group = iommu_group_alloc();
+	group->group = pci ? pci_device_group(dev) : iommu_group_alloc();
 	if (IS_ERR(group->group)) {
 		devm_kfree(smmu->dev, group);
 		mutex_unlock(&smmu->lock);
@@ -1079,26 +1081,39 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
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
+	if (err < 0)
+		goto err_unregister;
+
+#ifdef CONFIG_PCI
+	if (!iommu_present(&pci_bus_type)) {
+		err = bus_set_iommu(&pci_bus_type, &tegra_smmu_ops);
+		if (err < 0)
+			goto err_bus_set;
 	}
+#endif
 
 	if (IS_ENABLED(CONFIG_DEBUG_FS))
 		tegra_smmu_debugfs_init(smmu);
 
 	return smmu;
+
+err_bus_set:
+	bus_set_iommu(&platform_bus_type, NULL);
+err_unregister:
+	iommu_device_unregister(&smmu->iommu);
+err_sysfs:
+	iommu_device_sysfs_remove(&smmu->iommu);
+
+	return ERR_PTR(err);
 }
 
 void tegra_smmu_remove(struct tegra_smmu *smmu)
 {
+	bus_set_iommu(&platform_bus_type, NULL);
 	iommu_device_unregister(&smmu->iommu);
 	iommu_device_sysfs_remove(&smmu->iommu);
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
