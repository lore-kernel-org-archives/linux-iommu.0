Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD338C47426
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 06:15:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D40206DC
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 06:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tbbxizGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D40206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2953D8734B;
	Fri,  2 Oct 2020 06:15:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XorUwyLL4i2H; Fri,  2 Oct 2020 06:15:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 03686872FD;
	Fri,  2 Oct 2020 06:15:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3CB8C0889;
	Fri,  2 Oct 2020 06:15:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 346E1C0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 06:15:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 25667204D9
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 06:15:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EK2fGfcR9Bzl for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 06:14:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by silver.osuosl.org (Postfix) with ESMTPS id 28DB3204EA
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 06:14:59 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id q123so557703pfb.0
 for <iommu@lists.linux-foundation.org>; Thu, 01 Oct 2020 23:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qXGNqQhVeWRXwkLxWO9NE32gvOp7FRxlv449PGRmjRE=;
 b=tbbxizGzyYFtEdkzs4ZhGsQfqdyil04FfDQWafr5IUghUdQh1JrSMv80UBgF91tLlp
 YGiRUA4QV07rT+oo8zMtVYMVCJo9PPrLeW8x5gBQ9QywFffChttS7ZPYxNwqVu+Sineh
 N4SeBNSIIls3mN8gckW/ay1r6YJMUcquuc/w1Jr4rBkbYXwLKZ0/RTcjyMLHLGr3Ysl9
 k5rfK6gUwA+Ga34MSF/28ccCyGYD2k92trgOT7MQbKEa+RJQVI5tCQwjvFOEZ2/bVSC1
 PUKkESd2Ul5A5a15HZ5iT/Ocn7/zM6mBmYeoex7E8rlhODvXEaM69BpF7xKQaAphm+T7
 yzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qXGNqQhVeWRXwkLxWO9NE32gvOp7FRxlv449PGRmjRE=;
 b=jBP43EzXkEaqotQoQFbWbufbywmBWpe9BANfN1YlHHGosgvcVw9elKSBpDQHnQNGF5
 N45cwYgQLugWVTUvB8yMCrtXPMXm4ztZLCPSxPlzjQblkMQx6qYjd6gMXk5y63HXZ2aB
 2zdee8DtoSnscBqfkWbJHnbRu2peXngbSwqMM2X703s5UFomu+NXw2Lv65cPVBRIHYCM
 t25AmHnh4VYg9tx1q1I7zX+oTpdxLn+WkUjkAQ8K8F7g1rdtr4ybW2BN3hZygIN4TAYx
 wG/zvJTFDuxTXjqeU5lYbEX02ly4H4S7mcS/bi+bqalCaV9ZzD9ha3fOOs3eU/PrhPJV
 oWJw==
X-Gm-Message-State: AOAM533dSFvEO9HWeepzxRYWWJL82XQpsErJQ30UuQPiStWGi+4sOoNS
 iez9UL80hopRaZmwUGoX4/Q=
X-Google-Smtp-Source: ABdhPJx7kP/IGJVxHPL9VMKDuHXuk9JMWkPkvbYeBcoIWDrtVw6kM5DcsnrPAnjzWnhKGye+xjddow==
X-Received: by 2002:a63:24c2:: with SMTP id k185mr611501pgk.421.1601619298768; 
 Thu, 01 Oct 2020 23:14:58 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id x4sm577429pfm.86.2020.10.01.23.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 23:14:58 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com,
	joro@8bytes.org,
	digetx@gmail.com
Subject: [PATCH v4 3/3] iommu/tegra-smmu: Add PCI support
Date: Thu,  1 Oct 2020 23:08:07 -0700
Message-Id: <20201002060807.32138-4-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002060807.32138-1-nicoleotsuka@gmail.com>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
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
v3->v4
 * Dropped !iommu_present() check
 * Added CONFIG_PCI check in the exit path
v2->v3
 * Replaced ternary conditional operator with if-else in .device_group()
 * Dropped change in tegra_smmu_remove()
v1->v2
 * Added error-out labels in tegra_smmu_probe()
 * Dropped pci_request_acs() since IOMMU core would call it.

 drivers/iommu/tegra-smmu.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 02d02b0c55c4..b701a7b55e84 100644
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
@@ -1069,22 +1074,32 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
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
