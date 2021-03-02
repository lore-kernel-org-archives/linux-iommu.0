Return-Path: <SRS0=VFJV=IA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7197C433E6
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 09:35:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F2B364F0E
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 09:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2B364F0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 967F683D87;
	Tue,  2 Mar 2021 09:35:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8EZnY9p_Lguk; Tue,  2 Mar 2021 09:35:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6140A83D9A;
	Tue,  2 Mar 2021 09:35:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B332C000B;
	Tue,  2 Mar 2021 09:35:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1874CC0012
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 09:35:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EC5FC4F12F
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 09:35:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BSdXkj9dEpAt for <iommu@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 09:35:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F2E224F14B
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 09:35:41 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id e10so18851140wro.12
 for <iommu@lists.linux-foundation.org>; Tue, 02 Mar 2021 01:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Tljaa6sLGzqVEkWTy8WFZ8+1JVN/U6naVu2IpICY8qc=;
 b=CUqHhZIYRju55gc+SgJJfVnY562fuTxugAA10rym5tTkb8g8m152o+DT++duK/z+Fp
 5E+eDlGNVXS5r3h4+KvyMUE9P96vilcFmZT+EnHNNa9MJl+MZ1zyKriTkgySFqJ8NoVM
 6Rt2AA3J3Kk2WMRXeGu9VXSp9tJHuj7/jS077RIVONKPfbBxA6kJHgZVfAhhszUAkLLJ
 gYael+2uxEimdDjb5FL2gB2UfzfmgCSRrAELmBRIepAtkUEQimQU/LFw6NJEfqsvhei5
 bWJl4B+z4JSM+OExnA+1C6+FYFU2kn+LWS556rFB6/W/5FQVf2A38rvwhRVQXW+Vc1Hb
 FOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Tljaa6sLGzqVEkWTy8WFZ8+1JVN/U6naVu2IpICY8qc=;
 b=gkFIopZRezj0MJvCJt8N6wslTQRpgNug4AJt9KD54ZXcFov4Yz0LtF3sqXzU8e8mnr
 QMow/JP5P9Gwez9Vxz3dLBougDS4eQfx2MPy5h9nExXxq+RLiqbRxZ7NhYim4HZQu0fl
 ycy+CDKO4Nf1EnMaH9XVE11skpA74+GTVAi8TB/u6jQkPUbnea+ioVxbSral2JiYwGeC
 x3TNNIB7N4oWCtom6TAirq75YeN/NeWVXibv00GAD76iAA6kc+7lFVnSoYi2OHQdpp5s
 4EHETyhkz1FZD02GcIWokkYHCNkwug3F5pRQaqoXnqEZhnuxTy5Wjr9str4+0Q6ATb/q
 eYmw==
X-Gm-Message-State: AOAM531+s+X3dglxEqt6YI7kJBJKGgCh2e1ppSVOrXyGIHkEDw3Yz5/Y
 XIlf9fzPpM113rwwMA6bWlZMvQ==
X-Google-Smtp-Source: ABdhPJy5shG4cAWZu1Stz095i3ckx38acnf/wOYqacuVRhrdrmVSW4ctRbes8RS7Kd/oDkBHRXqASA==
X-Received: by 2002:adf:f8cd:: with SMTP id f13mr20377429wrq.27.1614677740193; 
 Tue, 02 Mar 2021 01:35:40 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id w131sm1963818wmb.8.2021.03.02.01.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Mar 2021 01:35:39 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v13 09/10] ACPI/IORT: Enable stall support for platform devices
Date: Tue,  2 Mar 2021 10:26:45 +0100
Message-Id: <20210302092644.2553014-10-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302092644.2553014-1-jean-philippe@linaro.org>
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
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
2.30.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
