Return-Path: <SRS0=hwFB=ER=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98F2C5517A
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 22:34:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56B432168B
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 22:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlwsqDqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B432168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1D275875EE;
	Wed, 11 Nov 2020 22:34:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fYjbDXlvh7Fy; Wed, 11 Nov 2020 22:34:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AC06E875EB;
	Wed, 11 Nov 2020 22:34:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9146FC0889;
	Wed, 11 Nov 2020 22:34:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE2D2C016F
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 22:34:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A5C7686C83
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 22:34:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1YHFZgOYyEkT for <iommu@lists.linux-foundation.org>;
 Wed, 11 Nov 2020 22:34:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BEE5B86C8E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 22:34:48 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id w6so2658833pfu.1
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 14:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/zDY1txU9YKSfZBMxX5zBFPuLz5WqGhiHVEhwalxC/s=;
 b=UlwsqDqzWFZ79M8Fw7RxcklsuwDjf5UXKrNC47sCENdlujbBC5k1ybowNyIA9Y92Uo
 C5icN7prkQNh9nmAUXG5Si8jtnFMMEW/4NO3oKYESc+Bzu9yJcNqLlY+x6wt7nEEZbHt
 HnphqJEFV7i1TerWRZD0IdyY8l0Jzl2qnJIaELzwIph9k9oJ/Iu/MsDm+qoHZKMEzV7c
 ATxMqHuNf1+JiRGfNmf5gLio6+YsfwndcOc0n/Jwfm1U3HjURlEpB8YPJxSYYxh6BC1D
 QXW/+KckNB/eGCnK68Pel26Hk1y1Pvq1bIzKeJ5KqKwiqkmFA8nXFrcSHzvrYkj+vA9l
 QDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/zDY1txU9YKSfZBMxX5zBFPuLz5WqGhiHVEhwalxC/s=;
 b=TDJ/gJbZCtKKDYwnnHkABdRqlcu0a+ODY4Ppedvlrl1Ko/rwREh0XYxs4+zbQaCV4O
 NjouVvUWIsGP4Nb2YlX/I94XZhDqsNNJxxtR8eVlrY4y5CjLyecnD7TND6OWXNKwv46N
 PqmNzpgWsbscoIOBkoPHPJmthGgPJF8K/fCaHfFRYiLLr9Md7Y+tCe7jtnAUrTGfsgWk
 zTe7SeL2vIh8/m9OUkfmU9WhB++97RamAA0goaLdyZIjvjVL80WvJvK58rGmRu5It/Yh
 7ViGVxO+nEdhiqOngQegBaCUwe52JEKVu3rPtaUFZbUCh6Nlv4ll0ITdF+9GYW6FwYhN
 L44Q==
X-Gm-Message-State: AOAM533/ROTK2O2ZqnbUKGyYD3UGNQCKDdsqTjOZpvtPRWAkoCzhi0yZ
 32Qpck0dQ/kXBB4UYTBjpd8=
X-Google-Smtp-Source: ABdhPJxd9Q9AnaCOoG+ZhCtsAd/jU8tGhe/KqjdM2axh75mPJwCkLVtJyOJYzZwYVRBhIToy4m9pDA==
X-Received: by 2002:a17:90a:f00a:: with SMTP id
 bt10mr5693143pjb.91.1605134088440; 
 Wed, 11 Nov 2020 14:34:48 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id a20sm3605096pff.118.2020.11.11.14.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 14:34:47 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com,
	joro@8bytes.org
Subject: [PATCH RESEND 5/5] iommu/tegra-smmu: Add PCI support
Date: Wed, 11 Nov 2020 14:21:29 -0800
Message-Id: <20201111222129.15736-6-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111222129.15736-1-nicoleotsuka@gmail.com>
References: <20201111222129.15736-1-nicoleotsuka@gmail.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com
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
