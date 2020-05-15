Return-Path: <SRS0=PRYs=65=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD15C433E4
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 10:48:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132C82065C
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 10:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dkOgLaKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132C82065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E2D9787E57;
	Fri, 15 May 2020 10:48:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id poTiUfuX5Z2I; Fri, 15 May 2020 10:48:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1760887ED5;
	Fri, 15 May 2020 10:48:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECE30C0890;
	Fri, 15 May 2020 10:48:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2F0DC016F
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 10:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 92D0887BD3
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 10:48:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qDdIrQ2nyIZh for <iommu@lists.linux-foundation.org>;
 Fri, 15 May 2020 10:48:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3AB3587BD5
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 10:48:34 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id f134so1844992wmf.1
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 03:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a6JIJM0/qnszNf/C3W1cfcENgwZD3tV9sE5r5AxKEdg=;
 b=dkOgLaKZgNbakPSRP7Xg1d2JPezWp8Wzc1IN+YzL2ukDlFUygw/oa6EQT8M2XqlTCz
 ITuN9QV0ywXV4ofR0kNh80z4tPGwVKsquc97eBK0CNEg2BYVNSMTj1o2Yb6UmqWBZjlr
 emzsm96xD2Kux4hLaBarRZQBAp3yJfXZIivFaOPGiHJuYf54/TcIl8cjoir+CegBn4h5
 AUVDdqHMF39wOISbc3FOzNe14afan4JQcxWpHPjxTLLpCXVr5MCCJeKyux6V/PE1Vq06
 Yw2WLEGTT679r7+OHD3vu1UOAOa/JxgOgbnXPMPb4TRcdsa2DVkMDiz0+9UOx0d5UhRT
 +32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a6JIJM0/qnszNf/C3W1cfcENgwZD3tV9sE5r5AxKEdg=;
 b=gcMfDorzDfU5Ag2g6XyBdUE1EMhU3euobW1wgZbISkT/z/jX+r3D2D50+sh1ZIvwbV
 5MHch+VdjUzpO4m9sNPgKk2GMDDOWPL/jROkFR2ScIZkpeNiAEoUVF0stm1OdR2DEFlh
 JLuapj5QqFRJQKqHpFvcf8Jd5iVGrKE50rQ8LHKN8PzvVoV91t317h3qwppaI67GveyU
 NxRthaOt5XlCR06n8o3sG+mwlIPire4IhYCojQthbYDWSGllrsJmLQkwu3b9iokf4iEh
 SWIpYBixHnawxZy8wx/Zgzt05r79O6iz14/+BnVZj4aosY35FSDAKYAyzTsezUjTdBYD
 OOJA==
X-Gm-Message-State: AOAM530WXUOngDoJBZhCEvOnBvWSYWnb2ELn+2UfXSChtuUEGUjR31fC
 QhrmeuNzIvM/5eVnicrOj+mJHA==
X-Google-Smtp-Source: ABdhPJzAXq9W8ciuEA3yi7eG0GjsyM8zeMTSGluCiWiblbXlc1dMrCYhmrkIsv/zARo7bX3QPoZVEA==
X-Received: by 2002:a7b:c205:: with SMTP id x5mr3518890wmi.135.1589539712724; 
 Fri, 15 May 2020 03:48:32 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id h27sm3510392wrc.46.2020.05.15.03.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 03:48:32 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, joro@8bytes.org, bhelgaas@google.com
Subject: [PATCH 3/4] iommu/arm-smmu-v3: Use pci_ats_supported()
Date: Fri, 15 May 2020 12:44:01 +0200
Message-Id: <20200515104359.1178606-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515104359.1178606-1-jean-philippe@linaro.org>
References: <20200515104359.1178606-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, ashok.raj@intel.com,
 will@kernel.org, alex.williamson@redhat.com, robin.murphy@arm.com,
 dwmw2@infradead.org
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

The new pci_ats_supported() function checks if a device supports ATS and
is allowed to use it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
I dropped the Ack because I slightly changed the patch to keep the
fwspec check, since last version:
https://lore.kernel.org/linux-iommu/20200311124506.208376-8-jean-philippe@linaro.org/
---
 drivers/iommu/arm-smmu-v3.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 82508730feb7a1..39b935e86ab203 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2652,26 +2652,16 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
 	}
 }
 
-#ifdef CONFIG_PCI_ATS
 static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 {
-	struct pci_dev *pdev;
+	struct device *dev = master->dev;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
-
-	if (!(smmu->features & ARM_SMMU_FEAT_ATS) || !dev_is_pci(master->dev) ||
-	    !(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS) || pci_ats_disabled())
-		return false;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
-	pdev = to_pci_dev(master->dev);
-	return !pdev->untrusted && pdev->ats_cap;
+	return (smmu->features & ARM_SMMU_FEAT_ATS) &&
+		!(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS) &&
+		dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));
 }
-#else
-static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
-{
-	return false;
-}
-#endif
 
 static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 {
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
