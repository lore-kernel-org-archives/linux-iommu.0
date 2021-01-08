Return-Path: <SRS0=te8u=GL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D57C433E9
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 15:02:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F296223A1E
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 15:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F296223A1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BDB8287336;
	Fri,  8 Jan 2021 15:02:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uyohFjqhuQqb; Fri,  8 Jan 2021 15:02:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1E74987360;
	Fri,  8 Jan 2021 15:02:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04A4AC0891;
	Fri,  8 Jan 2021 15:02:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6AA3C013A
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 15:02:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 94A18204FD
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 15:02:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B49YHWP+SsyG for <iommu@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 15:02:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by silver.osuosl.org (Postfix) with ESMTPS id 22CCE204FA
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 15:02:42 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id q18so9348856wrn.1
 for <iommu@lists.linux-foundation.org>; Fri, 08 Jan 2021 07:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M6xu+NZsefpfo8WqjQL32PlY8NL0QuBVkGqSt5snD+A=;
 b=kxuUCMV1WAqpwwvoibNUsWYrlPgddFb1B3XDtYKriSKJqhZ7YxBdz7idYeFiPEusdj
 oSxwzMXDVtdAhRbiUIPtiWxDXm3EOdY0B1oZ4RFYK1eN63WYymsf6s1QMgxe1Fp+XJLm
 7MYSyOGWzgv+FVOhkD8wVISPR0VlGxk9zmYIDuW8ATAmQ8SghsBmSoZJE31MhRs/IXU7
 jcMsXHSkhBXTuv9sJLCqbDDqfbxZnhaRfmDInXFrql1M/HVbnCpK9DeM9XJWQDFfFBiX
 CVAh4zvNMBGGzxZ42Xa9GLW4zEO7yuaspaFGL8sBAQLWZMjutowtPglRsb0G7rH8euGW
 4JKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M6xu+NZsefpfo8WqjQL32PlY8NL0QuBVkGqSt5snD+A=;
 b=UDEjev2Z2ay42zxOYZG5iVz4wnthLxTh1pMoHPRyDbynJLXmb8utJcuO14THBiAAxq
 hJTdm8/3YWruoEVvRqEA3Th6b74jVZn4dHh4DgCrxng+X3GvEVz8xiO0Xd6zxMQ4B21Z
 yoip4xdDZYc3A0A7dkbvq6hKJxddf7WyJ1Oh0PjTqDPWHCZREE9VEcLNvdJWgDdfoMkA
 pN0jebm/ikTd3FFopUAb9CiQL4IRkg1dMd6fsNs1W+kS2IcUVREjMcw5iwj7TxWWdpQi
 zmBMdDHqxb+R+Zd+Z+jgkGVY/59U/o4eIBmpBF7FUlVmzNR4XSRpP3fH9YsljLt7xxRA
 lupg==
X-Gm-Message-State: AOAM533vrSRea50zB4ORIYJAsqRrklcoiyBRxDHP+J4PXKi6GuSOnhEG
 +9RDKAoTaWzJEC0d2ZR7s1ZATQ==
X-Google-Smtp-Source: ABdhPJxXGloEPafSPINGJsoqaUcfHJIL8u06StaksnduujJItHcYtBuA/olK4ECauRMs3Zhmv7TwtA==
X-Received: by 2002:a05:6000:c9:: with SMTP id
 q9mr3946567wrx.259.1610118160590; 
 Fri, 08 Jan 2021 07:02:40 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id s13sm14258464wra.53.2021.01.08.07.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 07:02:39 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v9 09/10] ACPI/IORT: Enable stall support for platform devices
Date: Fri,  8 Jan 2021 15:52:17 +0100
Message-Id: <20210108145217.2254447-10-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210108145217.2254447-1-jean-philippe@linaro.org>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, guohanjun@huawei.com,
 rjw@rjwysocki.net, iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-accelerators@lists.ozlabs.org, sudeep.holla@arm.com,
 vivek.gautam@arm.com, zhangfei.gao@linaro.org, robin.murphy@arm.com,
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

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v9: dropped fwspec member in favor of device properties
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
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
