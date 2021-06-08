Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BDBC47082
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 16:46:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96CB46127A
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 16:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CB46127A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 625E583A15;
	Tue,  8 Jun 2021 16:46:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S-MiEfLSj8Vt; Tue,  8 Jun 2021 16:46:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54B0883342;
	Tue,  8 Jun 2021 16:46:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F2C2C000D;
	Tue,  8 Jun 2021 16:46:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EE0BC0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 16:46:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 66E0683408
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 16:46:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ikNp9miA_PQ4 for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 16:46:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B860683342
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 16:46:08 +0000 (UTC)
Received: by mail-pl1-x634.google.com with SMTP id e7so10955238plj.7
 for <iommu@lists.linux-foundation.org>; Tue, 08 Jun 2021 09:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2t+iT1aOdYCZU2AlXESXqTpbLz1wOUqv173mhLsP5Jc=;
 b=TY6Sk2eZt08YqlpdA2cn4pVa+JehYb0k4OUYb4sO8TTUbHYJeVSegoOB78bUraCAT/
 fv7Ic76M+WjKuz5VcW3wInudkLbyQLWyRjQQe2xT9eZ43uLOdX6MZU9CylSpv6oY01vN
 jLSx70QPKb7cIG8M+Vlb04dKoWfQNVS9rhla0EbeIKEOwAIgjMPC4AM5fI4mz1krklc8
 IpR+dokjcJ5myPc6sUULCwy1cOJoGF6+/2y+Gi41QP7SEmSzyV9xaSMmK3ahaLZAMBIh
 lif10rY7YaVrrZ/JD4GpT3udb6QZ3FvsVvbjQ0MQrVdBcyXVuTbPtI8iJOnwRS87Y78N
 BBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2t+iT1aOdYCZU2AlXESXqTpbLz1wOUqv173mhLsP5Jc=;
 b=ZFWgJzVkF/2xO8/QvXkYtIhQG2oO5yAFl7fgTdgEsNoYeof3KbBZWbn1WBbMlMwbus
 ltK5QFEu+Gw9KpIugmn6XwqdzQ0dsOP0UUWLQ15O+cxzkmHO7uv2ytTJRA4tg230o/+S
 Z1yc60+rF9wy01Dkg9a2irHXlJA6yRGjl+sUg7uNpgB7kvLjqOzReiFCs9DURekuPdkM
 kpKPY3t0CVUWbzPYIk1QZOZEGtS4AGynSCE6ZhZ7GA0rZlCIEwwKIChGW+uxZKDT89/B
 wKjEW9EJ5hC/fCUj4E/qK+YuXIsmam83noLKmTqpbF9F4xWGE9kzHrI5ULdkCoDjP5z2
 NSCA==
X-Gm-Message-State: AOAM531pHmtGJ1+xW8M2KCMCT8TrPggce1LMgcxcZFy/S66iojo/PA3c
 6S5JOVLoJx1jZ29hcOAwtlg=
X-Google-Smtp-Source: ABdhPJxo8z0gKm9nyddE2hgbA+4T56fMWkoWk4WJ05zb+Et72S0ZZzGhKucyCJluOysvsJpLM1gyLg==
X-Received: by 2002:a17:90a:5998:: with SMTP id
 l24mr7427786pji.169.1623170768185; 
 Tue, 08 Jun 2021 09:46:08 -0700 (PDT)
Received: from localhost.localdomain ([103.200.106.115])
 by smtp.googlemail.com with ESMTPSA id t6sm2864863pjo.4.2021.06.08.09.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jun 2021 09:46:07 -0700 (PDT)
From: Amey Narkhede <ameynarkhede03@gmail.com>
To: Rob Clark <robdclark@gmail.com>
Subject: [PATCH] iommu/arm: Cleanup resources in case of probe error path
Date: Tue,  8 Jun 2021 22:15:59 +0530
Message-Id: <20210608164559.204023-1-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Jon Hunter <jonathanh@nvidia.com>, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org, Amey Narkhede <ameynarkhede03@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

If device registration fails, remove sysfs attribute
and if setting bus callbacks fails, unregister the device
and cleanup the sysfs attribute.

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 ++++++++++++--
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 15 ++++++++++++---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 13 +++++++++++--
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 54b2f27b81d4..de2499754025 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3669,10 +3669,20 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
 	if (ret) {
 		dev_err(dev, "Failed to register iommu\n");
-		return ret;
+		goto err_sysfs_remove;
 	}

-	return arm_smmu_set_bus_ops(&arm_smmu_ops);
+	ret = arm_smmu_set_bus_ops(&arm_smmu_ops);
+	if (ret)
+		goto err_unregister_device;
+
+	return 0;
+
+err_unregister_device:
+	iommu_device_unregister(&smmu->iommu);
+err_sysfs_remove:
+	iommu_device_sysfs_remove(&smmu->iommu);
+	return ret;
 }

 static int arm_smmu_device_remove(struct platform_device *pdev)
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 6f72c4d208ca..88a3023676ce 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -2164,7 +2164,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	err = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
 	if (err) {
 		dev_err(dev, "Failed to register iommu\n");
-		return err;
+		goto err_sysfs_remove;
 	}

 	platform_set_drvdata(pdev, smmu);
@@ -2187,10 +2187,19 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	 * any device which might need it, so we want the bus ops in place
 	 * ready to handle default domain setup as soon as any SMMU exists.
 	 */
-	if (!using_legacy_binding)
-		return arm_smmu_bus_init(&arm_smmu_ops);
+	if (!using_legacy_binding) {
+		err = arm_smmu_bus_init(&arm_smmu_ops);
+		if (err)
+			goto err_unregister_device;
+	}

 	return 0;
+
+err_unregister_device:
+	iommu_device_unregister(&smmu->iommu);
+err_sysfs_remove:
+	iommu_device_sysfs_remove(&smmu->iommu);
+	return err;
 }

 static int arm_smmu_device_remove(struct platform_device *pdev)
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 4294abe389b2..b785d9fb7602 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -850,10 +850,12 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 	ret = iommu_device_register(&qcom_iommu->iommu, &qcom_iommu_ops, dev);
 	if (ret) {
 		dev_err(dev, "Failed to register iommu\n");
-		return ret;
+		goto err_sysfs_remove;
 	}

-	bus_set_iommu(&platform_bus_type, &qcom_iommu_ops);
+	ret = bus_set_iommu(&platform_bus_type, &qcom_iommu_ops);
+	if (ret)
+		goto err_unregister_device;

 	if (qcom_iommu->local_base) {
 		pm_runtime_get_sync(dev);
@@ -862,6 +864,13 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 	}

 	return 0;
+
+err_unregister_device:
+	iommu_device_unregister(&qcom_iommu->iommu);
+
+err_sysfs_remove:
+	iommu_device_sysfs_remove(&qcom_iommu->iommu);
+	return ret;
 }

 static int qcom_iommu_device_remove(struct platform_device *pdev)
--
2.31.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
