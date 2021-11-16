Return-Path: <SRS0=BhyV=QD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F961C433FE
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 11:52:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 052B161507
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 11:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 052B161507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CAAC240185;
	Tue, 16 Nov 2021 11:52:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yM7D0QKAvoJ9; Tue, 16 Nov 2021 11:52:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 703D94021C;
	Tue, 16 Nov 2021 11:52:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2AF0C0012;
	Tue, 16 Nov 2021 11:52:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 736AEC001E
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 11:52:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 53A7E401B1
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 11:52:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8GTg9ARZvkxq for <iommu@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 11:52:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B46F40185
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 11:52:16 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id n29so36958261wra.11
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 03:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v+QJmLY5BpY25I0rmG78uwWISNO+pZrvFRBP61oe3sw=;
 b=uTPfcujUExOV/32d5d9pSrPEzKYFf5z6TJEcXUumrFiczlKJgsd5gWhYVXEnWbQWkD
 Nt8svDH+tR6/Vny21lKjS0WIx/B3VDusxxiqOwiReFz5tj8CI0gJGH4B1wVSW8X+g8PM
 LrpWCwYB7cy7ZvlA/Oy5DVIJ5pmrFgnSaYs5lEvGgpy6K/WSaCNB1fOS+hcUuy+xGy2K
 9hSjun1Z8ndBPzf47bchnYkViBnhdaF18oPx6QW1W3GVVLvDo6Pu2B30vwJHIyC8NV2k
 4lbU7RZ1iuDMosa0hk6fCqaaGQoB2RYQzt5k6nBmJnsoYT6SFi03SX2y+zb5JKdW/7dq
 /erw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v+QJmLY5BpY25I0rmG78uwWISNO+pZrvFRBP61oe3sw=;
 b=1CC+GeYz4stjCkybqkG7eRdQXfDjs6pjsHNzkeJ43WSqkDT6nNyip+aY+0W4jkCe5v
 hJxDJEGI7pZ/htPmeTw/5t6MAQVcnG6vhDFqfZZejsdg/k041Bx4uCg52ldG8aSKXfLF
 oEJeH0Y1yc28bQuol9jVN6HG6xdr6IfOM7A6YjzZH0k0tU9seJg1pH5qEAt8X4bmfD+y
 Fof1RaZz9bw1rhig8UUPKAEl9FyIqShbh31d4L8675A0tu/Bppcw36Teb4jiYwrB2x+I
 i0KC6P0FXhMP0mP8iyVWGpq3gzyyPsKRi9bWN9gHqAIp8YVzXuk16GZ6uPq9oDynFCI4
 XGcw==
X-Gm-Message-State: AOAM530/F7fING9t1CZjqaskorOiTm1g+AiR2dDqPBNkc8k3bu3h6olo
 QR3c6QZApeLBV2NHmSRHTY1IBA==
X-Google-Smtp-Source: ABdhPJw0qnoPTZDC82Hez68IY85kWriu4gxeza20OUJa40OGiN4vAnqPql5KOwe325d01vJPGd55+g==
X-Received: by 2002:a5d:64ea:: with SMTP id g10mr8938553wri.242.1637063535219; 
 Tue, 16 Nov 2021 03:52:15 -0800 (PST)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id b6sm2232846wmq.45.2021.11.16.03.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Nov 2021 03:52:14 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: robh+dt@kernel.org
Subject: [PATCH 2/2] perf/smmuv3: Add devicetree support
Date: Tue, 16 Nov 2021 11:35:37 +0000
Message-Id: <20211116113536.69758-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211116113536.69758-1-jean-philippe@linaro.org>
References: <20211116113536.69758-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, robin.murphy@arm.com,
 iommu@lists.linux-foundation.org, uchida.jun@socionext.com, leo.yan@linaro.org,
 will@kernel.org, linux-arm-kernel@lists.infradead.org
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

Add device-tree support to the SMMUv3 PMCG.  One small cosmetic change
while factoring the option mask printout: don't display it when zero, it
only contains one erratum at the moment.

Signed-off-by: Jay Chen <jkchen@linux.alibaba.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/perf/arm_smmuv3_pmu.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 226348822ab3..958325ac103a 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -47,6 +47,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/msi.h>
+#include <linux/of.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
 #include <linux/smp.h>
@@ -750,8 +751,15 @@ static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
 		smmu_pmu->options |= SMMU_PMCG_EVCNTR_RDONLY;
 		break;
 	}
+}
+
+static void smmu_pmu_get_of_options(struct smmu_pmu *smmu_pmu)
+{
+	struct device_node *node = smmu_pmu->dev->of_node;
 
-	dev_notice(smmu_pmu->dev, "option mask 0x%x\n", smmu_pmu->options);
+	if (of_device_is_compatible(node, "hisilicon,smmu-v3-pmcg-hip08"))
+		/* HiSilicon Erratum 162001800 */
+		smmu_pmu->options |= SMMU_PMCG_EVCNTR_RDONLY;
 }
 
 static int smmu_pmu_probe(struct platform_device *pdev)
@@ -834,7 +842,13 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	smmu_pmu_get_acpi_options(smmu_pmu);
+	if (dev->of_node)
+		smmu_pmu_get_of_options(smmu_pmu);
+	else
+		smmu_pmu_get_acpi_options(smmu_pmu);
+
+	if (smmu_pmu->options)
+		dev_notice(dev, "option mask 0x%x\n", smmu_pmu->options);
 
 	/* Pick one CPU to be the preferred one to use */
 	smmu_pmu->on_cpu = raw_smp_processor_id();
@@ -884,10 +898,17 @@ static void smmu_pmu_shutdown(struct platform_device *pdev)
 	smmu_pmu_disable(&smmu_pmu->pmu);
 }
 
+static const struct of_device_id arm_smmu_pmu_match[] = {
+	{ .compatible = "arm,smmu-v3-pmcg" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, arm_smmu_pmu_match);
+
 static struct platform_driver smmu_pmu_driver = {
 	.driver = {
 		.name = "arm-smmu-v3-pmcg",
 		.suppress_bind_attrs = true,
+		.of_match_table = of_match_ptr(arm_smmu_pmu_match),
 	},
 	.probe = smmu_pmu_probe,
 	.remove = smmu_pmu_remove,
-- 
2.33.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
