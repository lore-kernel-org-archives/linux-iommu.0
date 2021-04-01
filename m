Return-Path: <SRS0=bVsO=I6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC79AC433ED
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 15:48:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C6A61378
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 15:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C6A61378
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A12D84ACA;
	Thu,  1 Apr 2021 15:48:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eVYg5XSCCsLX; Thu,  1 Apr 2021 15:48:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 401D584AC8;
	Thu,  1 Apr 2021 15:48:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F13D5C0014;
	Thu,  1 Apr 2021 15:48:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91BF0C000A
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 15:48:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 88C5F41851
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 15:48:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DsidwbgQ8g_p for <iommu@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 15:48:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 71EDA41845
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 15:48:24 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id j18so2303375wra.2
 for <iommu@lists.linux-foundation.org>; Thu, 01 Apr 2021 08:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Pua2Ae+rON0ZlDGkY5ERFS3L6AfCPNmqgc0wotIPcEI=;
 b=AQvPYJQL0dmJB8IZi8mOx5ajxcUoc5TP5FrCan7PcbU1GTN0XGGjNban28AqG/S1eT
 OudspSuh2Y3yKLRQat1UH9wPkhK7kK1V4/Nse8fGfuXTANeCQz/6GNyEkkuQ892jAlBN
 uLktlNmlJ+cpmtV+v1kZNPG9+f9Je/j0w4TkbAnbKuaTJsEudCj75aijL+6mht/qNUdC
 N3MdPwLKorkokFBX8FVIOAgztR5GGcUSmgB+MNc9zvwZOzl3Fl/HJ+GVNCrbohS5mLLd
 zQV/qSheXVl+YDvYbKfJ9D0XLZOoNDYB9n3zFvZmrgJ75fH8m/Xm/ZvqRNEWYW1jeHdB
 Vz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Pua2Ae+rON0ZlDGkY5ERFS3L6AfCPNmqgc0wotIPcEI=;
 b=iuLhAv/oUrl+oAB9EG7pS6o2RT7BmrN+tjJKJg38fNbXKsZHFCzqwS0yxdpAlxBoNy
 kr9cjxS7QiDeFNhmPDONPaJiZ7Ug9IPCIu2Pc0SRWgQSbZxqv0r5glePMukCF3Rbfe8/
 dmDXAp39aEW9kKI0WFLtrMwWhjphgFx0CRsnJhX8XF2kEPdLFm+EKg7LT/69x+A2eaNV
 oy0qA7kEnhC9k7TIOfZadpbtC8NZ3fcgucB4EfVW1n8yGZZFL+/0KEmiDns+Gc3yn985
 N22VJgFW6ytn13NntQkEPqG+ebEMlfHXMEZeHk4BxOkqPjBAeXx4XmpqwgxS2BQuIDxn
 G3bw==
X-Gm-Message-State: AOAM530XA2efMHmWSnA2kZLM+zX0IKJ4vsTe1/f1aAeBKsoIYcCND7oY
 /BIAtY8W6SttCeoN3mPNrS1xgQ==
X-Google-Smtp-Source: ABdhPJyrIah1qqCxNJvBbipg66vyVTPCXXhRfRjwHTQ1aqsgM2ee8hefPg9PttDsuRkr/f0yUE7kcA==
X-Received: by 2002:adf:d1c5:: with SMTP id b5mr10474358wrd.126.1617292102724; 
 Thu, 01 Apr 2021 08:48:22 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y8sm8722505wmi.46.2021.04.01.08.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Apr 2021 08:48:22 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v14 09/10] ACPI/IORT: Enable stall support for platform devices
Date: Thu,  1 Apr 2021 17:47:18 +0200
Message-Id: <20210401154718.307519-10-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210401154718.307519-1-jean-philippe@linaro.org>
References: <20210401154718.307519-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: vivek.gautam@arm.com, guohanjun@huawei.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-acpi@vger.kernel.org,
 zhangfei.gao@linaro.org, lenb@kernel.org, devicetree@vger.kernel.org,
 kevin.tian@intel.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 rjw@rjwysocki.net, iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
 robin.murphy@arm.com, linux-accelerators@lists.ozlabs.org
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

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
