Return-Path: <SRS0=4Gp4=44=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11C8C33C96
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 12:47:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 747CD2253D
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 12:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ncgLdDhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747CD2253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4262D87F8E;
	Wed, 11 Mar 2020 12:47:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W5u0R+a0b9p1; Wed, 11 Mar 2020 12:47:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C87C187EA8;
	Wed, 11 Mar 2020 12:47:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2ED5C0177;
	Wed, 11 Mar 2020 12:47:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3267FC0177
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:47:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 215B18758B
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:47:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n90GgGLV-Xnp for <iommu@lists.linux-foundation.org>;
 Wed, 11 Mar 2020 12:47:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1EDB787626
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 12:47:08 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id r7so3100595wmg.0
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 05:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vyt9EDLxonGbKc5hM6CKEH9sOA1tej8/GhDoeiFUKak=;
 b=ncgLdDhr1gsVmIKw0dva+fqrHBQurcK9VYJtWgeUva4PerBGhsr2pO3ugJ/2qoFzaL
 hJ4cpZqdwse98rHFRyhh1g1lpITEsUbmEXhQo14D6537GZNYohNkAXM780pcNZSb6KAY
 6YqQE0NBgJonQ1nQlVKvn8bzE+AGBtBekekgeJreU6AC+TPDfd2fFmNjvuSWoHZX43Ry
 ycWRsDcIClqWML7JkEMoUZWYnKJQj1wPDd/+M0iMm5rk9co3czS3fC1sA0RLqEeZboYU
 T6doJ9QG51osk860+l0/4JjAXGMjw8oJNmZwtUNWzuT4CqYVbatdc707pG60eCDpap2S
 DLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vyt9EDLxonGbKc5hM6CKEH9sOA1tej8/GhDoeiFUKak=;
 b=fpr9a+Nvs5IT6l/kEof3hCjuyqEmu9cj2+52+XgOQNIUbBZ3k8CgelZ7j51KW3vK0+
 I8iLuECZYOezouctBzngakEMGTQgtxj/VFXViGPrXViiayjmRhgmtvvQiNU1/0XODWHw
 u6qkiMo5zIDgWCxMdnlJE5+zbS+X6M0UN9BU/mJh54w0jAdne+yxIFXOHRBEl2Mz+G5U
 3vOZbb3sZcowLv0xxJxyQVe5qer2jCrVjtssXrQRZtOwYCWHGr8KIuZ9z6GxuP4t2dBc
 iiMpvWsbwShxYi+uqJKy0ZX+STW06H7gwKDkRBYpyQlZxQv/f6rNGU1bnaFLHQ8S04qC
 pQlA==
X-Gm-Message-State: ANhLgQ1XaYB32OuiOIVdRkYotya+05v+NfPDs4XSIB4Krc/AQuYY3aWJ
 8Cd5w5nNPqasz/+1yQUzi22VUA==
X-Google-Smtp-Source: ADFU+vuoGCMDLfkq5/GJN/4qTM7pYDQ3Wyic8sIgmIFqGMqHRI8BaekbHLoblPdIpK3Uqq6CChtTAg==
X-Received: by 2002:a1c:a908:: with SMTP id s8mr3841957wme.133.1583930825087; 
 Wed, 11 Mar 2020 05:47:05 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id c2sm8380020wma.39.2020.03.11.05.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 05:47:04 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org, joro@8bytes.org,
 baolu.lu@linux.intel.com, sudeep.holla@arm.com, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH v2 08/11] iommu/vt-d: Use pci_ats_supported()
Date: Wed, 11 Mar 2020 13:45:03 +0100
Message-Id: <20200311124506.208376-9-jean-philippe@linaro.org>
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

The pci_ats_supported() function checks if a device supports ATS and is
allowed to use it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/intel-iommu.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6fa6de2b6ad5..17208280ef5c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1454,8 +1454,7 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
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
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
