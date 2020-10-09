Return-Path: <SRS0=yPDG=DQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0921EC433DF
	for <iommu@archiver.kernel.org>; Fri,  9 Oct 2020 16:27:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A151422277
	for <iommu@archiver.kernel.org>; Fri,  9 Oct 2020 16:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frsXM0EU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A151422277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 49FDA86C4B;
	Fri,  9 Oct 2020 16:27:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3ioqWexfFlGw; Fri,  9 Oct 2020 16:26:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CF71586C45;
	Fri,  9 Oct 2020 16:26:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C85D0C016F;
	Fri,  9 Oct 2020 16:26:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7951AC016F
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 16:26:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 68F95875FD
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 16:26:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qaNs0lR2r-bf for <iommu@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 16:26:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E26B4875DA
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 16:26:55 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id 7so7561530pgm.11
 for <iommu@lists.linux-foundation.org>; Fri, 09 Oct 2020 09:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=e2ontlidD6EdZ8raA0hQEJD/T47JB7SGf8j+YCwQsds=;
 b=frsXM0EU7dTqXI6MRRBIjk/BetJeA6yGcDp1wrrbIzpbobYXcBVkP1q18NIRbGzH7A
 3zE2Kf/Z2uYteZhZ7xk4d4yi3871gVqbwDCA0VPOGQdgMsBMu1zIxry/+ESB5oJk2BpX
 S9V4wGfcmuy//G6+Bqh42zDjcwfV0ktBJJN+f9OJFzybFvexTCdESXSeEdMxqUJ5B9d9
 RZTF6pq2TSP/5Z7HXCrFeghiDzos0cRst+9K4pVGaYD02WXahq5gOgiHJvOT4JRFkBdZ
 Ut1ERXygUKRXMjMHw0rmRtSUUT8zNAh61UVzLrw7iPBNTZu2D3rdwOWoXFuzOGKmJLVp
 rrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=e2ontlidD6EdZ8raA0hQEJD/T47JB7SGf8j+YCwQsds=;
 b=bpZG/LT1AW+pkmHLbvkBOiVx+W10KTVY9NNSY1H+4+jKTTcs6CVBU53oH4i+b5kxVZ
 vaEzBNp7AN5ZD8DzYVo9FJSYrKzd41DqIfkCP9AL1EAn82cpd4pzvNqfrhfdb/fJSLU1
 y1UTyR/bKUOPVkX9ZoTYXIHQaXI8NEyTKfZDGY9Bg/oBoZVkF4gR7l2TdOtejaqUkViq
 xX0Avxkbp2OY/C2pCFvcjnIqFTI6UZvqYSXLSDBQ66cHisGBL7bAB6zMQ9nVPG7ZYbPG
 R3KPTqU2lq1ffb0+ZdNh8IGXjKySjDY2hNvnFp3j+TM1EX3HI0gvQRIZBFxD9WUrVRHA
 Og0g==
X-Gm-Message-State: AOAM532ff1PzKfqiUxiwFZwknEIg00uWIxS5gpAR/lO1pDwUXr2/PiDG
 x1S7hAONTKpRQGR9IWqexZp8Hhq3oD4=
X-Google-Smtp-Source: ABdhPJz4W1TQO+OAe1kcSo/OeZxeY2bAfv8aXkkP9TODAbIqPSTwEtOHPYjBpy4gf6v9To5giAGqog==
X-Received: by 2002:a63:29c8:: with SMTP id p191mr3990445pgp.45.1602260815458; 
 Fri, 09 Oct 2020 09:26:55 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id q24sm9591229pgb.12.2020.10.09.09.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 09:26:55 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com,
	joro@8bytes.org,
	digetx@gmail.com
Subject: [PATCH v7 3/3] iommu/tegra-smmu: Add PCI support
Date: Fri,  9 Oct 2020 09:19:36 -0700
Message-Id: <20201009161936.23122-4-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201009161936.23122-1-nicoleotsuka@gmail.com>
References: <20201009161936.23122-1-nicoleotsuka@gmail.com>
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

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---

Changelog
v6->v7
 * Renamed goto labels, suggested by Thierry.
v5->v6
 * Added Dmitry's Reviewed-by and Tested-by.
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
index be29f5977145..2941d6459076 100644
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
