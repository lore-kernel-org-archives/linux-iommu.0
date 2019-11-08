Return-Path: <SRS0=V12C=ZA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADEBFA372C
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 15:27:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE572178F
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 15:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rk9za0j+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE572178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D2481E6D;
	Fri,  8 Nov 2019 15:26:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F0895D88
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 15:26:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 70353196
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 15:26:52 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id q70so6600096wme.1
	for <iommu@lists.linux-foundation.org>;
	Fri, 08 Nov 2019 07:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=+aAa3kHo6X36UARQ/hBD+CYIStSC9Mwak+bAj3lpxxM=;
	b=rk9za0j+DjrBF+nEQLw0UeApqKkWBCvgDbUXpotyR3WcOdSZUdqJemsRAUO0+HTGL1
	GUNs7bt4UgSxiL6f3ok4bdNmEamSc9EHDrNjbCyOo0oxmj2VNzcujqfH6kFCFjfZ1jQt
	hks2xi69COXdeSg2aAH4ow5jW7bVQgVZrQTOC+OPqBNFj6FssCrQTeUkL6YYO5NilsTS
	/qQBGPNk10VAvkFNz87SS5aKQnT2uWXfhGs90RxNw+Ls/MQBN9vtyfWpRtTWyVnn4706
	4oAPI5kC4UaL+xz9ryj+/AzkP48rL4NOmp9fynAASOANWZvjDBAghHTT1yBZyxAtJnha
	iLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=+aAa3kHo6X36UARQ/hBD+CYIStSC9Mwak+bAj3lpxxM=;
	b=lK1ItgPSjVeeA3X9YBCLNc2V9qwmzMHK9aayxHxOqM1Ruh76yX5uZpGcTq3qbFaVQr
	UC8R0wSHXl81I4dk5X9CLegNGRxMJbAj3mVfag5u5gqHZTvXfcdDbdaW6Zqp45WWqXnw
	Tz2oOmGxDUjjP6Jktgb5AKjcVcLDJSm1SrHNDPMoFUvS009rXhUn0Ddn36lGzy48JHhi
	/NBTxRC6nQA7hhc6bBkPtOG36pDL39YZgjroy5rE8ChzozDtf0Qir6d09hJ6mjlUPUn5
	cGeWCQIbI8TGUWnwGzvpJFM+UaM7/vv2gnXwSWv/V0NQSxLKfXZTGhxZUmt4Iiecq0/8
	qwYg==
X-Gm-Message-State: APjAAAVlYGEyQzq8e+iElDEpWgKchkDU5JsH538PPj6+xmerFKsxrRqr
	n38Iihi/i+q5nfsMvP4wBTgy3pA2+LRsNg==
X-Google-Smtp-Source: APXvYqyP1ODYLZACcAlafYthBHeI8vIQSuj7rdAG2X/KmYtzbQ1YGd6y/fT9+gj0hKuehN6KSufekQ==
X-Received: by 2002:a1c:7d47:: with SMTP id y68mr8658213wmc.157.1573226810884; 
	Fri, 08 Nov 2019 07:26:50 -0800 (PST)
Received: from localhost.localdomain ([85.195.192.192])
	by smtp.gmail.com with ESMTPSA id
	w18sm6579232wrp.31.2019.11.08.07.26.49
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 08 Nov 2019 07:26:50 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/8] ACPI/IORT: Support PASID for platform devices
Date: Fri,  8 Nov 2019 16:25:03 +0100
Message-Id: <20191108152508.4039168-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108152508.4039168-1-jean-philippe@linaro.org>
References: <20191108152508.4039168-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, robin.murphy@arm.com, guohanjun@huawei.com,
	rjw@rjwysocki.net, robh+dt@kernel.org, sudeep.holla@arm.com,
	zhangfei.gao@linaro.org, will@kernel.org, lenb@kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Named component nodes in the IORT tables describe the number of
Substream ID bits (aka. PASID) supported by the device. Propagate this
value to the fwspec structure in order to enable PASID for platform
devices.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/arm64/iort.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 5a7551d060f2..9aebb180744f 100644
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
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
