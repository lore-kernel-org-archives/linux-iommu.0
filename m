Return-Path: <SRS0=4Gp4=44=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C32C33C97
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 12:47:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FE4B21D56
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 12:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="urRlNUx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE4B21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0CC3A87EA8;
	Wed, 11 Mar 2020 12:47:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y93541n3NZgV; Wed, 11 Mar 2020 12:47:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1372D87EC4;
	Wed, 11 Mar 2020 12:47:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D5FFC18D3;
	Wed, 11 Mar 2020 12:47:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C6D3C0177
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:47:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 361FF85F6E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:47:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K8Hp7eVoo1E6 for <iommu@lists.linux-foundation.org>;
 Wed, 11 Mar 2020 12:47:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6E42885F67
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:47:08 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id a132so1947291wme.1
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 05:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DVwcU8zMkbBCBeDrHNdhEC1RvSG6OG5A+AegDdk4FZg=;
 b=urRlNUx8hO97E3/ithv5W/xzktVGqA1nV8O5fFz7ObhKvbEb2aNkJgJoKBpnVdphl4
 5KBtdCKu/sgivS/hsjhVd9Sr/X1Un9ZKJ87q0cEtnZScW1Pc4HHzlnmW0o+AbOz4ueP5
 zyiCCpfL8vGbdiD9DgrSXZ7XaFDisGxPx0ysInpR3PAK89famZ8K8Fj1an2TBiXDAYaE
 fG3FqhhJJeNEsHKKygqVfcWKtxEwUnRFtGqa5ACIlECBWpovqJEGF/dZ+xZf9pivDmhr
 lMwE+AWqy9HFztiZU7KrWfM0WAPgUIHsjlIQ7vDYMmjWMwOOE+sv6p+UcxnGShNeQvLg
 e2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DVwcU8zMkbBCBeDrHNdhEC1RvSG6OG5A+AegDdk4FZg=;
 b=DPNSqrtHBjdsrnj1JH/l1RO0ba+43irUeAI3MdDRIVjITGWLI2sSqQCV/A2FrW/M+G
 AJg9qUf6kT2E+xWLD9PBM9kLUSMoiDq9OGkJF3L1AC5sXswKF/jrifVK6Gpsi2KUr5j+
 Zc3NWbXc4c8d5ZLGRZPAbQyzWUtFA4PHtX66i2saKfxw35gmBrX/9TiuUXD+ue5uOqih
 xoFBTxF3nTAOoE+hGM7rKItJNTi1pu2MdJzVJYtAbzpzthrmRJ8HxzVAvCZmouKawvCy
 sucJJnsKwLIkOxXR+OCKRdtWID+ys8W6MW+L1w3lwuFgoxQ115NrYxLNP909CjJFIJ14
 Rxew==
X-Gm-Message-State: ANhLgQ1B9JFYZXr92bKJ9E5SkAdH8zDkM+LV5eL33IM4k3hzrrMNJE8f
 Gqrq5pnmR6YoBxEE3fY/7CaRJA==
X-Google-Smtp-Source: ADFU+vsyF4i09IJC6n7a05lkPoLiRARiHxJM+vYgxp5oWnXx/+N85xAu8rhEuiSrwLrfj5KAr4l3Ag==
X-Received: by 2002:a05:600c:4114:: with SMTP id
 j20mr603263wmi.58.1583930826931; 
 Wed, 11 Mar 2020 05:47:06 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id c2sm8380020wma.39.2020.03.11.05.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 05:47:06 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org, joro@8bytes.org,
 baolu.lu@linux.intel.com, sudeep.holla@arm.com, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH v2 09/11] ACPI/IORT: Drop ATS fwspec flag
Date: Wed, 11 Mar 2020 13:45:04 +0100
Message-Id: <20200311124506.208376-10-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311124506.208376-1-jean-philippe@linaro.org>
References: <20200311124506.208376-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 frowand.list@gmail.com, corbet@lwn.net, liviu.dudau@arm.com, rjw@rjwysocki.net,
 guohanjun@huawei.com, amurray@thegoodpenguin.co.uk, robin.murphy@arm.com,
 dwmw2@infradead.org, lenb@kernel.org
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

Now that the ats_supported flag is in the host bridge structure where it
belongs, we can remove it from the per-device fwspec structure.

Acked-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/arm64/iort.c | 11 -----------
 include/linux/iommu.h     |  4 ----
 2 files changed, 15 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index d99d7f5b51e1..f634641b3699 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -924,14 +924,6 @@ static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
 	return ret;
 }
 
-static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
-{
-	struct acpi_iort_root_complex *pci_rc;
-
-	pci_rc = (struct acpi_iort_root_complex *)node->node_data;
-	return pci_rc->ats_attribute & ACPI_IORT_ATS_SUPPORTED;
-}
-
 static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
 			    u32 streamid)
 {
@@ -1026,9 +1018,6 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 		info.node = node;
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     iort_pci_iommu_init, &info);
-
-		if (!err && iort_pci_rc_supports_ats(node))
-			dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
 	} else {
 		int i = 0;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d1b5f4d98569..1739f8a7a4b4 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -589,15 +589,11 @@ struct iommu_fwspec {
 	const struct iommu_ops	*ops;
 	struct fwnode_handle	*iommu_fwnode;
 	void			*iommu_priv;
-	u32			flags;
 	u32			num_pasid_bits;
 	unsigned int		num_ids;
 	u32			ids[1];
 };
 
-/* ATS is supported */
-#define IOMMU_FWSPEC_PCI_RC_ATS			(1 << 0)
-
 /**
  * struct iommu_sva - handle to a device-mm bond
  */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
