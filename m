Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DEBC4741F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 08:48:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45DFA20738
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 08:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSmAL+uu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DFA20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CE8FF8720F;
	Wed, 30 Sep 2020 08:48:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fzZ-1gmz8Vss; Wed, 30 Sep 2020 08:48:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0C03187200;
	Wed, 30 Sep 2020 08:48:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDB7FC1AD6;
	Wed, 30 Sep 2020 08:48:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7595C016F
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:48:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C720B86FCF
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:48:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OQc+QOg5HpiO for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 08:48:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
 [209.85.216.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5662B87200
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:48:36 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id j19so529192pjl.4
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 01:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vyojCx1R+z/iL8Xt/dqLsO0bSZnbMhzjt6sea10xylU=;
 b=WSmAL+uuRBrBqhY6aSg0a6n68R+6EUbVEd7KHVPEeadOgBRDlwQl7NrWFHFJJFnLCB
 /4N7ul1+3j7PUNEhIVbKQ+schdNZaCR4wKp9YHyeCUwy4bmagSX9uYh9476zMmcGmUR2
 bbuwwEm0r5lyzFKbVUm7kpiOAgsWHqvxzB78R8gGQ8q7paS75IBvX8B55a3zFn7/On92
 uA/raz0ksuGckST24WaUMBCkiKoD2FfRDkhic+J6anV5WFZaPuGu6fGAt01NdfKo/ExK
 QR/xIOqR70bSoqN9AMagi4MqE1F49nQAbMclQVBPAEJF21xJp7FshEUy53l+xBfT33At
 Mq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vyojCx1R+z/iL8Xt/dqLsO0bSZnbMhzjt6sea10xylU=;
 b=pNkAJZM0iheRzQV3p875y1CiZpHNLzZtSPxuVKvUOKvxRzfari2aEAkUBJgFGjfAK1
 TRCSLhxss2eXULAlOYExtwxiVAMMFN9eDPVe0/wRkhArpktNRetQ36x/egddYMvbVfza
 qu869ephTuAlKkkWeXCzkeimrM3mrXOjTk3RAT2Yq2iU3D+kyTDBlDLWgtgf/nBZL4FB
 Oe5PwTPw82uXOhxDWoY1RfnRL/yBOZroVtrxJ/fP3s8IKMzV0UQGL76lWTd4Xj5Y2RYq
 YVQuI34VoC2Lx/nZX3AExTf/Lt1kT4kCxnPPaJ6Tr3bnhKzCAb19WbIxGmxlkWGbZPmg
 t3GA==
X-Gm-Message-State: AOAM531ksW/M04H4nF1CWcGG1FbqH81qV6P9phRqt49FqgINRqjsUJt2
 V69n+7Wfhd7C6wIgB+c3IDQ=
X-Google-Smtp-Source: ABdhPJxhDuDBMmsmY43fl1Hx+QRRN1XlKonCCkywZkb1zviPR+Xi+9EOx4fWjXPx8R8oSyE8F/m61Q==
X-Received: by 2002:a17:90b:f09:: with SMTP id
 br9mr1698101pjb.102.1601455715823; 
 Wed, 30 Sep 2020 01:48:35 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id d17sm1505830pfq.157.2020.09.30.01.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 01:48:35 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com, joro@8bytes.org, krzk@kernel.org,
 digetx@gmail.com
Subject: [PATCH v3 3/3] iommu/tegra-smmu: Add PCI support
Date: Wed, 30 Sep 2020 01:42:58 -0700
Message-Id: <20200930084258.25493-4-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930084258.25493-1-nicoleotsuka@gmail.com>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
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
---

Changelog
v2->v3
 * Replaced ternary conditional operator with if-else in .device_group()
 * Dropped change in tegra_smmu_remove()
v1->v2
 * Added error-out labels in tegra_smmu_probe()
 * Dropped pci_request_acs() since IOMMU core would call it.

 drivers/iommu/tegra-smmu.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 636dc3b89545..db98ca334eae 100644
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
@@ -882,7 +883,11 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
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
@@ -1079,22 +1084,34 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
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
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
