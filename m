Return-Path: <SRS0=oIyp=GY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15764C43381
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 12:39:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A4A6239FD
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 12:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4A6239FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 008CC86283;
	Thu, 21 Jan 2021 12:39:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hj2_7RUVVnzZ; Thu, 21 Jan 2021 12:39:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 98F7A8626B;
	Thu, 21 Jan 2021 12:39:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FFB3C08A1;
	Thu, 21 Jan 2021 12:39:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBAA6C013A
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 12:39:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C5DFE871D5
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 12:39:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eAZjTc9PqHuH for <iommu@lists.linux-foundation.org>;
 Thu, 21 Jan 2021 12:39:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by hemlock.osuosl.org (Postfix) with ESMTPS id F377587060
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 12:39:43 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id i63so1318913wma.4
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 04:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=34NOfBoAQbhC4EqUo+bMrvAxSDfvSBJrgTwiEwqrJqM=;
 b=jh49AsG8Ku0X4MhQbeMX7gD6G5UG3nPk0+s0Syjj6Dy+TDWxpcfUm1e3LYSB6p4OvM
 Kg7SYcQuula7b+NVb/TXvcqksYjq2JPVI+6D1CxevtRxa9tZYqhap6+zOMQBpd649qPu
 zaQFYlaVbzfUOo3p1I61spJduaApW3KsUwNjJLUqaBOV7hqUtwjm9KtGxYIFztBX1RNI
 zbgYMQFWzDmEv+XcAHZckcAKOvqzmBgM1inzWfUawY2CEgxYMsTNSC+E/Z93Z1mv+ka6
 VEMPecgh4nyCWC/EWc1m7jDWKJD8cj6xR21JNGmxdyy9qYq6kAm5HvjThelK7GRoVVtx
 bR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=34NOfBoAQbhC4EqUo+bMrvAxSDfvSBJrgTwiEwqrJqM=;
 b=r1yzvK0sJSh+7KLUC63LZp2FdhYu/z0VxhuPW36LjNWac+elBINqyvGS25lIpn9X0j
 yM+zNrKYetFtN8TjlDkiCj5WWH0d9URQjPtaqBjfRgymOCFiko3EQyVseAs1uOQIQ0dd
 kixwxBl4AJTzmAsCXDO8dZlO5xUcxJS3tcawxYTXQzaBOaT6TdBkVcbYeovDsp0nTLkY
 7xysNdcd41oJyab0Fe0MtDpXb0KyKiNaYkLgolZV/mJFE5bfN2gi62icXsfBbf6ciiPe
 VZDWaIjIIJF17n3CU/i92iMHU/yg3C7DzynCcif+48v9QUq3GGGXxbV6QgUXyo4frN7g
 T+Sw==
X-Gm-Message-State: AOAM532h/CGA6a0ayl1sm9pjLFcqPlZneMQ6fFfj9T5hpG9520uuPjT+
 orZDRhqduBC2M2wTnRZFXVs1iw==
X-Google-Smtp-Source: ABdhPJy4aVE7nUGRBVsnvQda65l+P+gt53hIs8sV+GNjymDZ9tsnP67X7H+cf54+VmJof+s0v8IZkw==
X-Received: by 2002:a1c:5403:: with SMTP id i3mr8695684wmb.87.1611232782538;
 Thu, 21 Jan 2021 04:39:42 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id p18sm7979248wmc.31.2021.01.21.04.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jan 2021 04:39:41 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v10 09/10] ACPI/IORT: Enable stall support for platform devices
Date: Thu, 21 Jan 2021 13:36:23 +0100
Message-Id: <20210121123623.2060416-10-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121123623.2060416-1-jean-philippe@linaro.org>
References: <20210121123623.2060416-1-jean-philippe@linaro.org>
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

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/arm64/iort.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index c9a8bbb74b09..42820d7eb869 100644
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
2.30.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
