Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284F2C433DB
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 15:44:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC70F20873
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 15:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC70F20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4CD1C85F5E;
	Wed, 27 Jan 2021 15:44:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I7i0X0z8OWqh; Wed, 27 Jan 2021 15:44:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CB68C85F4E;
	Wed, 27 Jan 2021 15:44:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC9D3C1E6F;
	Wed, 27 Jan 2021 15:44:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FE93C013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 15:44:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8A1EB85F51
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 15:44:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4WZTKHm0vw9t for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 15:44:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0247C85F46
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 15:44:47 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id y187so2073758wmd.3
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 07:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P/EAy3wFo2SkAvzlEqANsfgzLeO0MB9eAURTmLNsvNA=;
 b=mb07EcDaQibTEwHyo1+my09q6bkkLrDK+31eVBj3xeA3p0boN8Cnn6DHCFEjErg6ay
 1qVr03v/rFH29yu2BvCS2DbIo97LHYGyuv88KKQNM2MTQ2+U4Bl3vu4LuBfUSrrG7uak
 6aDNhLCw2Q8ymqA8LvqcjEjg/PNki0B2ltIM9AHHsXFIhulJH5o+h060GC3ZenURtkBN
 8ysP23TmFVJIj6bNYAQip6zL0bPvbTVeQPIGR30xGFngU0oajhJjG2BRFpYrUvvg5WBo
 NmGSP9P24o0UZJ3BVjroLLiiBev9KxkbokaPnFyaRq/BegljrmRMi+x5tle1qwRvtGKF
 m2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P/EAy3wFo2SkAvzlEqANsfgzLeO0MB9eAURTmLNsvNA=;
 b=N07FkaasXCRZOiKb81hCGWVbYR0lkfyIO30FAALq1fq8xdhKE4dlDgw0U9DtXHpHPg
 ytI28/v39kPONTsO1Fi9yGFkiGU7C22/O60EbbXovEDfE+Pkm5mCmY/cveoq23OGu376
 f8wKxjNu4d1H9wkzQ6Cd6BlvJe+K+awXtNOWzh1Ltq+upO/u0X8qtf+FNo/EyC1za2Mv
 L3TRRUTNOeyQo18V6PcK2u/y4R/Iv+bex8F6Fbi+t2ciE2pYkCu0oohs0EBijwqKDIhu
 fVEoV4GI3jFqyDCmpkuLJ+TqzgQDCPhKQoX0PuxeggpITxeLt2zsK5EpnOkh4WpTgK85
 3eAg==
X-Gm-Message-State: AOAM5319opPSd1eNzi9EYG0MxIhKR94QY/hPyVoLj5wgla+iqBXcEZaX
 tXVVUJPge66s0ylIWt3v7QKGnw==
X-Google-Smtp-Source: ABdhPJxDNGjMbngdefhVghUfb0JN88zaAJwQb8TwLjwsDCOpCI43m4o3Qu457Rvsh0CFa6Zcy7TnHA==
X-Received: by 2002:a1c:e407:: with SMTP id b7mr4745128wmh.46.1611762285528;
 Wed, 27 Jan 2021 07:44:45 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id r13sm3046921wmh.9.2021.01.27.07.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Jan 2021 07:44:44 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v12 09/10] ACPI/IORT: Enable stall support for platform devices
Date: Wed, 27 Jan 2021 16:43:22 +0100
Message-Id: <20210127154322.3959196-10-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210127154322.3959196-1-jean-philippe@linaro.org>
References: <20210127154322.3959196-1-jean-philippe@linaro.org>
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
