Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F86C433F5
	for <iommu@archiver.kernel.org>; Wed,  5 Jan 2022 14:45:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5EABF82F8A;
	Wed,  5 Jan 2022 14:45:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 40c1edf24K7e; Wed,  5 Jan 2022 14:45:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6231F82E95;
	Wed,  5 Jan 2022 14:45:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3668AC002F;
	Wed,  5 Jan 2022 14:45:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E967C001E
 for <iommu@lists.linux-foundation.org>; Wed,  5 Jan 2022 10:16:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6C5134160D
 for <iommu@lists.linux-foundation.org>; Wed,  5 Jan 2022 10:16:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YExljyJbIyR1 for <iommu@lists.linux-foundation.org>;
 Wed,  5 Jan 2022 10:16:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DD83A4160B
 for <iommu@lists.linux-foundation.org>; Wed,  5 Jan 2022 10:16:24 +0000 (UTC)
Received: by mail-pf1-x429.google.com with SMTP id t123so34752226pfc.13
 for <iommu@lists.linux-foundation.org>; Wed, 05 Jan 2022 02:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=aJdy4Vc+2i7MVFq5AwmxIGlmluiA2uKFXYF4yxPWA3k=;
 b=m8i3JZa8/Qzk7foNf2srvzSS/UYiYgHXFUuMTKIsMO9diJn7tjVHXk9CQN6DtxIfhe
 r8ylwe+u/9YXo7T3upExqyAJ5R6iTQLOmy92bioX7VS27m69dO6DO8EnCFE0jH9oWHQi
 W5VNjqdKRChzbmteTOAJkAjOp42ZHMWMstfYdN0V8uDPnqpl9kEChpo2wQU9tVyzp/NY
 OWYGq2o4xc7czvdiWtDcqLgoXivT4AChq4M0YqOMi5RXOQ5sZ6CyhsZaVmJ8x1TWYS5S
 Irt6dVQbOOEFBP1he4J8TmYG55vpikU0pppjcLhzJUPVINMlvTvYA0L0cZd4cRqhqGD7
 WF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=aJdy4Vc+2i7MVFq5AwmxIGlmluiA2uKFXYF4yxPWA3k=;
 b=mN/0caw+lYTEPLrrPd/TNBNNXn4Jg88aPuNK8iTzsP3UwkjnC+8Qp6bPBnPBoNnUW9
 gVxRQmrYEpJzG+AZBb5UL0gtDaHdEIVHRfPnOzfIfOzeILQ3gGvmb0jb38bsCcEbQYeH
 KL8XS/kGpvtF+grOq7Z8HHq+uNK4qBK44HrUiRUwXgIOaD7gGhqfcryTa6Bzz2t93lww
 vbQZA7vAmvajs+b/GcUK/uGpo5BH1LgPJ9AQ5Xh/mXwxxMwqCMXOVZBV89KBlgQvV+BE
 fvHV8wZV6taOKHls2aHxUK6GfAbGDb6uTwtq02xZGHFE+yZkjtecflKLegHd8+k7uVr6
 QOpA==
X-Gm-Message-State: AOAM530K1eUC/bPnmFKH3HSYU93VMvUtihaLADnF1i5QWqoIMB28Z9MV
 bV3blIBr0ed07IrQlyIhNsc=
X-Google-Smtp-Source: ABdhPJxOXDyMm2E9v4ooUA8PevdQusz3K/Gvvk6H/GBdRD2sHCc8QDJKva4YpelLW/O5Fr+liNm0Zg==
X-Received: by 2002:a63:3c5e:: with SMTP id i30mr1564473pgn.397.1641377784410; 
 Wed, 05 Jan 2022 02:16:24 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
 by smtp.googlemail.com with ESMTPSA id y27sm47044320pfa.12.2022.01.05.02.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jan 2022 02:16:24 -0800 (PST)
From: Miaoqian Lin <linmq006@gmail.com>
To: 
Subject: [PATCH] iommu/arm-smmu: Add missing pm_runtime_disable() in
 qcom_iommu_device_probe
Date: Wed,  5 Jan 2022 10:16:19 +0000
Message-Id: <20220105101619.29108-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Wed, 05 Jan 2022 14:45:16 +0000
Cc: linmq006@gmail.com, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

If the probe fails, we should use pm_runtime_disable() to balance
pm_runtime_enable().
Add missing pm_runtime_disable() for error handling.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index b91874cb6cf3..2f227bc88bd9 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -827,20 +827,20 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 	ret = devm_of_platform_populate(dev);
 	if (ret) {
 		dev_err(dev, "Failed to populate iommu contexts\n");
-		return ret;
+		goto err_pm_disable;
 	}
 
 	ret = iommu_device_sysfs_add(&qcom_iommu->iommu, dev, NULL,
 				     dev_name(dev));
 	if (ret) {
 		dev_err(dev, "Failed to register iommu in sysfs\n");
-		return ret;
+		goto err_pm_disable;
 	}
 
 	ret = iommu_device_register(&qcom_iommu->iommu, &qcom_iommu_ops, dev);
 	if (ret) {
 		dev_err(dev, "Failed to register iommu\n");
-		return ret;
+		goto err_pm_disable;
 	}
 
 	bus_set_iommu(&platform_bus_type, &qcom_iommu_ops);
@@ -852,6 +852,10 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 	}
 
 	return 0;
+
+err_pm_disable:
+	pm_runtime_disable(dev);
+	return ret;
 }
 
 static int qcom_iommu_device_remove(struct platform_device *pdev)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
