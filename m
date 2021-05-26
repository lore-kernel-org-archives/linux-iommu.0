Return-Path: <SRS0=mply=KV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88013C47082
	for <iommu@archiver.kernel.org>; Wed, 26 May 2021 16:21:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D6C613CA
	for <iommu@archiver.kernel.org>; Wed, 26 May 2021 16:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D6C613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0BE74066C;
	Wed, 26 May 2021 16:21:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rLNdERgTwKvE; Wed, 26 May 2021 16:21:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7EA524066B;
	Wed, 26 May 2021 16:21:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 635D2C000E;
	Wed, 26 May 2021 16:21:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2662C0001
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 16:21:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D08AA83E1F
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 16:21:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lX1WOK4Po7K7 for <iommu@lists.linux-foundation.org>;
 Wed, 26 May 2021 16:21:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C09B383E16
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 16:21:37 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id lg14so3353513ejb.9
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 09:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AKRl4agdQb3jtkg+VysQNU7Kzn0dH+xQTWOrQHzW2HY=;
 b=x7BoDKcPMf9PizrgqgcjzRKKfGmllOzwKzdaaX3UPgB3QI5dv56ITViep78v3Eh7H+
 eP6MDtp7cQwimaV/W8QYj6NVqqzPFKR0Ar+nzPDUa0vakwUOXLtlT6fHPj3h7BqLSZ0q
 3z6kNH0z4LR/3PfGuSmssDmJDyXq3BbbWyNPWdfGCL8E1ILFMDi8MXv3z+NFgxzgEW0P
 oX48LUzPUxvtkJ2t2nK6iTPjD1V/3h8l82JBh0I4OwefGwWmoneh5SX7nHbLiuiZGiUN
 izK+uNkWcnOXi1pX/KhuGev304wxSaRl9mSyIJrQZr6Ms2fkTKX0Nd96LMrGHrid18X5
 E9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AKRl4agdQb3jtkg+VysQNU7Kzn0dH+xQTWOrQHzW2HY=;
 b=K1Y/5Nh/GvU9pjys9dHW7WijOdaWb7PxMwQzD+K9N4cXouCB6N39rk6A+PBZeu8urg
 o/pB/BvmATovPoiYDbv+AADa2HgbukhJG5E9Fw66C9sX32IuAdZ7QbdJStlQE9Zdrtet
 WvQbW/E+g1ldWPoqWcu+HJliYvckjg40c3OHRYU0UTvfg3KJmo/jF3ZzJmvbOvnMfuMh
 QBdxE+H2f8nYQj/N9Nz8zhIYdn+B280Ckio00e7rMmHPO2Ro77+bk++7PM/Z7EIUaTOe
 buROeUxSQtZuMDxhOVDyi7c5w0eH44kyknYvC2Duj02uXebKmG8X/ButNo4aBgyzMDvS
 2ypg==
X-Gm-Message-State: AOAM5310rJ/gY5Gk7hFMAgAxngAIkbNnjfbyKRO83AL6p4Ay47MfwFDB
 Z/cQzXsssyBNZJeV9+cbVYFEzg==
X-Google-Smtp-Source: ABdhPJzziFGCZPNo+X7H2xQvWb9YNPVpQXThfZSV/V0nc1qoc/ySSYykIs+pLOKnLaLnkZzP4z7Nzg==
X-Received: by 2002:a17:907:7654:: with SMTP id
 kj20mr34813609ejc.439.1622046095954; 
 Wed, 26 May 2021 09:21:35 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-106-126.adslplus.ch.
 [84.226.106.126])
 by smtp.gmail.com with ESMTPSA id e6sm10497145ejd.31.2021.05.26.09.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 09:21:35 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v15 2/3] ACPI/IORT: Enable stall support for platform devices
Date: Wed, 26 May 2021 18:19:27 +0200
Message-Id: <20210526161927.24268-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526161927.24268-1-jean-philippe@linaro.org>
References: <20210526161927.24268-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, guohanjun@huawei.com,
 rjw@rjwysocki.net, iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 sudeep.holla@arm.com, zhangfei.gao@linaro.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

Copy the "Stall supported" bit, that tells whether a named component
supports stall, into the dma-can-stall device property.

Acked-by: Hanjun Guo <guohanjun@huawei.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/arm64/iort.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 3912a1f6058e..0828f70cb782 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -968,13 +968,15 @@ static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 static void iort_named_component_init(struct device *dev,
 				      struct acpi_iort_node *node)
 {
-	struct property_entry props[2] = {};
+	struct property_entry props[3] = {};
 	struct acpi_iort_named_component *nc;
 
 	nc = (struct acpi_iort_named_component *)node->node_data;
 	props[0] = PROPERTY_ENTRY_U32("pasid-num-bits",
 				      FIELD_GET(ACPI_IORT_NC_PASID_BITS,
 						nc->node_flags));
+	if (nc->node_flags & ACPI_IORT_NC_STALL_SUPPORTED)
+		props[1] = PROPERTY_ENTRY_BOOL("dma-can-stall");
 
 	if (device_add_properties(dev, props))
 		dev_warn(dev, "Could not add device properties\n");
-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
