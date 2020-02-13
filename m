Return-Path: <SRS0=ZJ+1=4B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B907C3B1A3
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 16:52:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F054224650
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 16:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rI28DsCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F054224650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E2C7C86E89;
	Thu, 13 Feb 2020 16:52:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BUKM0+H1pKQk; Thu, 13 Feb 2020 16:52:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 77D1986F92;
	Thu, 13 Feb 2020 16:52:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6421DC07FE;
	Thu, 13 Feb 2020 16:52:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15A41C0177
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:52:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 02B4121546
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:52:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0w5V95or2oSj for <iommu@lists.linux-foundation.org>;
 Thu, 13 Feb 2020 16:52:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by silver.osuosl.org (Postfix) with ESMTPS id C4BD22153B
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:52:14 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id a9so7544922wmj.3
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 08:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0vxAgnwgCi5tQ5T4tG4I38wvW8TUR4SKTYQ5b+iyeZ4=;
 b=rI28DsCSktD93OGWztli5kHgpw2K88deSfarovudDtCGLfZder9iNg0E10dhs9fZpk
 eFTsc3Fn6EAr9ouNGbiVBRkKPPK69q7RPGGtMBnyQCpqnyYvLAyAZqdIG/GIsLmqRzzi
 12LIcEDQwvb3OQl7giRwQQNgiq+VK/5XXRBsF1abm2y1vArf+0wGRt0YpzwOshhxB9zM
 Ix4415qok1sXN1TmaKBbTV/JM8kQC5iCIQJ1JAAK2NX29bDiYAkyRr6OEhmiVI8n9MLc
 mqbryRMGESOmDUg+tOlIH5s27bZYFv0z5XJC5YvNUltOxU5Eij2jAeBJnEveZ7p4bVI3
 Dzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0vxAgnwgCi5tQ5T4tG4I38wvW8TUR4SKTYQ5b+iyeZ4=;
 b=AD93BLCQ1YPLDudq2/tNqPBXHZfWG+UJXLeT6OJOs6Xzn/lBFavGqIDf9hFbH1r6r4
 Wn1eyO2gdCV9p2b+3EBgxx8vIjEMeXMNNZFv2DXfVvx3FXCedJBMLnoVRPYGyJGCuBzg
 RjK4LiNkzWjJO1EhL5Qum4Kl+GQJFMsBRSAUjIA6gYg2DaDbleeYrDVYsM1y75UWhtwY
 8WPH7JxCcq1ovj76XcarTo8RisPjjpLyfohmyiwuhXefJ9eCf+NPHB6LBmqp/gDO9+yi
 bSRoV1qFA6jiu3tw3GJfX7ftWfbFG0IA4zT52DHjgIWIPPlZlktsjpwqk+7UlNbbOxjH
 EIOg==
X-Gm-Message-State: APjAAAXKLu4WksHO5iCG178i1cUE4ebfJ4FOhDix0IbM/qoOvotftdTX
 lglUnBxepAyKCb1rhEaUrh08DQ==
X-Google-Smtp-Source: APXvYqya188D5MEbRkey+kBb9V0Qc0uxPc2c2lngtBX0mBG9/xBeCp7D0V/fZbJc3uSzBYe3p4UBoQ==
X-Received: by 2002:a7b:c5d9:: with SMTP id n25mr7111336wmk.65.1581612733245; 
 Thu, 13 Feb 2020 08:52:13 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y6sm3484807wrl.17.2020.02.13.08.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 08:52:12 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org,
 lorenzo.pieralisi@arm.com, joro@8bytes.org, baolu.lu@linux.intel.com,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH 08/11] iommu/vt-d: Use pci_ats_supported()
Date: Thu, 13 Feb 2020 17:50:46 +0100
Message-Id: <20200213165049.508908-9-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213165049.508908-1-jean-philippe@linaro.org>
References: <20200213165049.508908-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, frowand.list@gmail.com, corbet@lwn.net,
 liviu.dudau@arm.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
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

The pci_ats_supported() function checks if a device supports ATS and is
allowed to use it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/intel-iommu.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 9dc37672bf89..668f1b99111b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1449,8 +1449,7 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, 32))
 		info->pri_enabled = 1;
 #endif
-	if (!pdev->untrusted && info->ats_supported &&
-	    pci_ats_page_aligned(pdev) &&
+	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
 	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
 		info->ats_enabled = 1;
 		domain_update_iotlb(info->domain);
@@ -2611,10 +2610,8 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	if (dev && dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(info->dev);
 
-		if (!pdev->untrusted &&
-		    !pci_ats_disabled() &&
-		    ecap_dev_iotlb_support(iommu->ecap) &&
-		    pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ATS) &&
+		if (ecap_dev_iotlb_support(iommu->ecap) &&
+		    pci_ats_supported(pdev) &&
 		    dmar_find_matched_atsr_unit(pdev))
 			info->ats_supported = 1;
 
-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
