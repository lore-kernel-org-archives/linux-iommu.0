Return-Path: <SRS0=sOBO=QE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8931AC433FE
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 14:52:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5268561A3D
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 14:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5268561A3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D3BC60679;
	Wed, 17 Nov 2021 14:52:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yLySUtIZofF9; Wed, 17 Nov 2021 14:52:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2893A605F8;
	Wed, 17 Nov 2021 14:52:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03F13C001E;
	Wed, 17 Nov 2021 14:52:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 000BDC003C
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 14:52:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E1583401F4
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 14:52:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LP2ay82pF9ql for <iommu@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 14:52:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E005E40144
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 14:52:39 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id w1so12383943edc.6
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 06:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ve7xUdb+Hg9RyjwNTpj23ptdpIMs4Ic4sw4mtKsRCdI=;
 b=aCdXOLY+9NDzmRPSjazal00RnVkQVSTQqDf7QhIFc6VvfA28TXUiGJr2J19Hi/xU9F
 KNecCTvatmx6S8+we2pQXqPq4nGfHfj0oix8SjtSf1NFJ+KjyBD6UcWWT35Y1Iyu50Lv
 2ubSZutvglNIG4c6DENgdkquq9iYE6Mi6IVhLNGs/4fojWaa/bzD+SpSascqK30sFqmz
 mclY2y8z8f+LNV/hcAglYycYBNXAAfU34F2bFa48UqNCDtY49A1fuPCMOkwoyjRAPc+m
 oU+J6j1PsqD1Dz8CuO0KxEVNiIivrmdRKDCd0qJ58Wii7TBQRyYRsbnDGfsTDg7aXUY4
 VQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ve7xUdb+Hg9RyjwNTpj23ptdpIMs4Ic4sw4mtKsRCdI=;
 b=Crcm9SJ2t0x3CAbQb+kLL8sTaYEhYbGW6wfaCtXdL6VvIxMJ1gVhTpOALSkHin6hKN
 7fxqDV48q/TUK2p40eZMx9h8oYgN3PSX6gRGoa6+t9jAuzJrrrTRp9P9l4YF0HN5nmTP
 5t9dxeymnSpxTVDNMEldko8SZJfsqN9KT0n+U9xh5mJ8zzNO43EWz3vWScpsXX0H8lI2
 Nm6GUJLy+pNyrJxAFQEKJYnEyvHag5cEgDl7wz6udod1WVVp+1dS8lq5Avtllt78C1xd
 BehC8wYymsfUx4xZ/vM+IUJg+qpxP81Q9wuDrJG18W6j257DQIQgoK3/REmm/CPa1/lA
 lSxA==
X-Gm-Message-State: AOAM530AcSz3A837dPqcYcr44xP7ZpKEUPvTQXYXdT6ndBoNe0h9YpMm
 9fdo5rLZuKTzq0jcFA0zxbwE4g==
X-Google-Smtp-Source: ABdhPJxXDaM8+yb04iLwMEzyFoVFkjg3TtfgBGe99zo3k2qNu2dlD3sGtXI1PTF/PPYHNdu0Y6Bhlg==
X-Received: by 2002:a17:907:7805:: with SMTP id
 la5mr22724677ejc.188.1637160758136; 
 Wed, 17 Nov 2021 06:52:38 -0800 (PST)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id gs15sm63917ejc.42.2021.11.17.06.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Nov 2021 06:52:37 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: robh+dt@kernel.org
Subject: [PATCH v2 2/3] perf/smmuv3: Add devicetree support
Date: Wed, 17 Nov 2021 14:48:44 +0000
Message-Id: <20211117144844.241072-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211117144844.241072-1-jean-philippe@linaro.org>
References: <20211117144844.241072-1-jean-philippe@linaro.org>
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

Add device-tree support to the SMMUv3 PMCG driver.

Signed-off-by: Jay Chen <jkchen@linux.alibaba.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 226348822ab3..19697617153a 100644
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
@@ -834,7 +835,8 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	smmu_pmu_get_acpi_options(smmu_pmu);
+	if (!dev->of_node)
+		smmu_pmu_get_acpi_options(smmu_pmu);
 
 	/* Pick one CPU to be the preferred one to use */
 	smmu_pmu->on_cpu = raw_smp_processor_id();
@@ -884,9 +886,16 @@ static void smmu_pmu_shutdown(struct platform_device *pdev)
 	smmu_pmu_disable(&smmu_pmu->pmu);
 }
 
+static const struct of_device_id smmu_pmu_of_match[] = {
+	{ .compatible = "arm,smmu-v3-pmcg" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, smmu_pmu_of_match);
+
 static struct platform_driver smmu_pmu_driver = {
 	.driver = {
 		.name = "arm-smmu-v3-pmcg",
+		.of_match_table = of_match_ptr(smmu_pmu_of_match),
 		.suppress_bind_attrs = true,
 	},
 	.probe = smmu_pmu_probe,
-- 
2.33.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
