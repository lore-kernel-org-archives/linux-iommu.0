Return-Path: <SRS0=c0M2=2J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B72C2D0D7
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 16:31:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05620206EC
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 16:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KsJmWTGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05620206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C6F6923455;
	Thu, 19 Dec 2019 16:31:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H0iLXRb896kD; Thu, 19 Dec 2019 16:31:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 384B223376;
	Thu, 19 Dec 2019 16:31:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25F98C1D83;
	Thu, 19 Dec 2019 16:31:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE5B0C077D
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 16:31:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BE0AE86FDB
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 16:31:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OO0MgQl3B4kU for <iommu@lists.linux-foundation.org>;
 Thu, 19 Dec 2019 16:31:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B255986FD6
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 16:31:25 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id b6so6659919wrq.0
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 08:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SVox6K0aClSgQAj4ZePzlVYlKOAA5RM1JxWE0eeJ+CM=;
 b=KsJmWTGBulFgtHxInjLbvLy9PpRX0GteBfzNXmUrDZJrH+ZYaBQIa1dHh47VnHT3Us
 G2OJX3xgvKyS2XK3zuqcw1ZOXlKDVBJQRRMVF0nOr9xyj+lDw01Q6Jd6vR/rkeYccEHt
 yJOWYb/rjfBgXbMc7wgknxeamdVg+ZZN29ommW/LnpTHOjUz0VpuiDmfABbg1QOhKWEP
 BK79LYU2nE8gQz8QcvCdTDHowZsM7F9ia5UVAVVs4wcvu3pPH0s1tj25cZ4VQrLWBmC5
 SAfWsR+i6gOKs+s2DrspT9Ahp+NfOeXnTsawx79CvIM08A0Wu8V+jAyezZPtTeJVSYeM
 zLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SVox6K0aClSgQAj4ZePzlVYlKOAA5RM1JxWE0eeJ+CM=;
 b=CWMjvQbjwpPyck6Qd2HjgDckiERS6JkC7fSj7yQmrdJL8n3Tt5/9jZFELj454q9VOy
 BMG0pPBxVFufvob6agAJLYGTeL6p+m7tco9bWBUTHglXqT6Np8eZCibg5WPozNNtfkfL
 UsIEyWGYS2YoqzQzZpvU1/w3S4tIcrwkW/awJa1KyOPgEwSh9MIfkWwzYUBhajE7q9fZ
 xEzrZs62K1kVvjlib08tCiGfqYfgQc0a3W6XdoJE2bAg+Yec4oi7qXl3Q3FOO6Qddcbt
 tkC9iycJ1VPxX4pDofJ533Jt3w9cwtQ5rgFkPCsRPSDqScDfEOEK0LXpz4F0nBgVNSot
 Aypg==
X-Gm-Message-State: APjAAAUnvV7ibZOI+TgTpjNC5LUXiQLOm+qNrnqB8OX7MjkoG7V0xzKP
 viVpqBuJX3v6CCEH/nucjwzSmg==
X-Google-Smtp-Source: APXvYqzR3BRml1Osw8Pe6sNrf17z34IMgIAsII/16lKoUagOiEfpACFYNxRXRQ+jtWBFUTIlzmF8Sw==
X-Received: by 2002:adf:eb48:: with SMTP id u8mr9977279wrn.283.1576773084271; 
 Thu, 19 Dec 2019 08:31:24 -0800 (PST)
Received: from localhost.localdomain (adsl-84-227-176-239.adslplus.ch.
 [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id u22sm7092068wru.30.2019.12.19.08.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 08:31:23 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH v4 04/13] ACPI/IORT: Parse SSID property of named component
 node
Date: Thu, 19 Dec 2019 17:30:24 +0100
Message-Id: <20191219163033.2608177-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219163033.2608177-1-jean-philippe@linaro.org>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, robin.murphy@arm.com, guohanjun@huawei.com,
 rjw@rjwysocki.net, robh+dt@kernel.org, sudeep.holla@arm.com,
 bhelgaas@google.com, zhangfei.gao@linaro.org, will@kernel.org, lenb@kernel.org
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

Named component nodes in the IORT tables describe the number of
Substream ID bits (aka. PASID) supported by the device. Propagate this
value to the fwspec structure in order to enable PASID for platform
devices.

Acked-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/arm64/iort.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 33f71983e001..39f389214ecf 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt)	"ACPI: IORT: " fmt
 
 #include <linux/acpi_iort.h>
+#include <linux/bitfield.h>
 #include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -924,6 +925,20 @@ static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 	return iort_iommu_xlate(info->dev, parent, streamid);
 }
 
+static void iort_named_component_init(struct device *dev,
+				      struct acpi_iort_node *node)
+{
+	struct acpi_iort_named_component *nc;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	if (!fwspec)
+		return;
+
+	nc = (struct acpi_iort_named_component *)node->node_data;
+	fwspec->num_pasid_bits = FIELD_GET(ACPI_IORT_NC_PASID_BITS,
+					   nc->node_flags);
+}
+
 /**
  * iort_iommu_configure - Set-up IOMMU configuration for a device.
  *
@@ -978,6 +993,9 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 			if (parent)
 				err = iort_iommu_xlate(dev, parent, streamid);
 		} while (parent && !err);
+
+		if (!err)
+			iort_named_component_init(dev, node);
 	}
 
 	/*
-- 
2.24.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
