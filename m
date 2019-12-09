Return-Path: <SRS0=4RPJ=Z7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A77C2D0CA
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 18:12:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA77C222C4
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 18:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qz+VoZCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA77C222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AC60122005;
	Mon,  9 Dec 2019 18:12:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uU+d+cC8aOH7; Mon,  9 Dec 2019 18:12:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 271372155D;
	Mon,  9 Dec 2019 18:12:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13413C1D84;
	Mon,  9 Dec 2019 18:12:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 731DDC0881
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 18:12:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 60D4D86A8F
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 18:12:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UGHuVozoRtkE for <iommu@lists.linux-foundation.org>;
 Mon,  9 Dec 2019 18:12:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0880D85FD6
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 18:12:02 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id p17so300070wmi.3
 for <iommu@lists.linux-foundation.org>; Mon, 09 Dec 2019 10:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4K50bdfBGo5wv/ohbkLG+3JipC6XSwfSyXBMUuskNmE=;
 b=qz+VoZCi2ZkZPf4O3bdy8khdtdl8t/tUseUIY6WiqKbbJWekc5IUQKdpcypm5EMkel
 xqPdHX3CeThQc2N0RtPMuUniauvWEWGq40GoYXI0yVd8LbEWNP96eaGnT4QP070SobzJ
 zuv3qeO3/+eK+CLCq8+o3mKjEP3FAQTHumSHPD/d1MYdMravg1n14/mT+AUeE2Zn7uoy
 qC+fiL+l2N8Gkov7H0UAFhurlkzwGLezZQOw5F/R/0Cq3xJiG1q/d/Hb+9envEQ/tXGJ
 sCHDsfLiaL23XiTlMiAPMm2WhhcmLcB73I3Vk0eIJFuBaKHVAaglqEEM0v6qB0IqTR0A
 HDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4K50bdfBGo5wv/ohbkLG+3JipC6XSwfSyXBMUuskNmE=;
 b=Qx9CkrXnBVE4/Kfe4l9mnPVAQmZbYs7ZgZoSd6JKSPnfUMNTykw3WojsOB7FlC++QZ
 KmzXqAeT/Vrvn0jWD53ZzOELOu4qUEsZiFi7gfffLHpiiBxYCA/jmcu8IrYOfdiIgdQ4
 jtVcL+oyt3pZTjwpKwIMAxfsLkAIZK4zQeHp/Yw9dcIn8Fy+cVEYdO+HYI+qjkO5MqZV
 /wew21lZJVn0aKV4Ff2i8Hn8qRFkdoF+pP5FBxe+twz8967GZ7E2Vasue0ZJoPnhGZ5F
 W7bz9jw1XgAW4rzBAD6TgbG4Aq6hcMY/r0ckiu0lZ2nUzWcAxjZaWH+y9ph7ydxYNjBM
 0Qdg==
X-Gm-Message-State: APjAAAVVwewJL4XeNRZ602YInhUt/gC2sGkiwu9XjnW2ILmqgQaIIXA1
 i3/SKyMzBv6i4i06gVEhAikCcQ==
X-Google-Smtp-Source: APXvYqymGhua6k1UiWoRVt/h0So4MtX0nqsi2/M4ba7JykDOOETk0lX7gu+MYa5fgf+Qs3/UisNgYA==
X-Received: by 2002:a7b:c851:: with SMTP id c17mr337626wml.71.1575915120418;
 Mon, 09 Dec 2019 10:12:00 -0800 (PST)
Received: from localhost.localdomain (adsl-62-167-101-88.adslplus.ch.
 [62.167.101.88])
 by smtp.gmail.com with ESMTPSA id h2sm309838wrv.66.2019.12.09.10.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 10:11:59 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH v3 04/13] ACPI/IORT: Support PASID for platform devices
Date: Mon,  9 Dec 2019 19:05:05 +0100
Message-Id: <20191209180514.272727-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209180514.272727-1-jean-philippe@linaro.org>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
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
2.24.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
