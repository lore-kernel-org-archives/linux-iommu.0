Return-Path: <SRS0=jIn/=7C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5FBC433DF
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 15:32:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B06AC206F1
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 15:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NyfejZCy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06AC206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7642E249CF;
	Wed, 20 May 2020 15:32:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jad5xXCJr3J4; Wed, 20 May 2020 15:32:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9CA6C24804;
	Wed, 20 May 2020 15:32:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8563CC07FF;
	Wed, 20 May 2020 15:32:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EB2BC0176
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 15:32:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 03F4D248A1
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 15:32:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WkT3tVoHtoCY for <iommu@lists.linux-foundation.org>;
 Wed, 20 May 2020 15:32:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 73E5D23A53
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 15:32:51 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id g12so2404688wrw.1
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 08:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1nOz9oJXJsBp0Pv8EAcijkkig9a/lDsRyH7fIHxuOyo=;
 b=NyfejZCyR749KuE+DWatqT6qWazMYFpQkVMGIdQXHn3J9NmjJ+p1lFrfTPgP0PVC1H
 J8UNAuCs6RSyO3blMwd6v8lsOM3dURZd9wwpYa/wafLuX9jxQrbUpAkNZ9qtjNrsb0GZ
 LgNprtlWLpVp/y9LR+luDthYcxWiTrK/pgxia+qcHs50IrUG8Li1TDTGzxpQ5aEPqDKk
 GZvkHBgYHD/Fwr/1k3LLSVABNaq3XRgGFSVGt6eww19sznOZORIHGMgZTvKpQe+Jf2kg
 shRdICnzO1febMCpv2zSlcrwr61fsX2iokq8z6WZ4PviE/lwxB7hsTooqBrRk+8CEoZG
 K4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1nOz9oJXJsBp0Pv8EAcijkkig9a/lDsRyH7fIHxuOyo=;
 b=OZQLTL8Lopl7mnaFwr2/SJJqQiWRwobzNjElnJ9/P8hKTPq5FXxTc78gjWqmMAykbj
 vNrBb4L7WknGc93q/smCm5L/zd6ev5gNQjV7G8cRi7NqToI3DgB0RTomFrQ3Pip1WjZc
 TVjIlIXjMT8O0d0MbcHNmI92t7RGjv3NPrP4cw3xBj/xSntunPO3tQvXpK5yy9EggFjM
 it0Gkbdnzac/MjhbjAGliYXtld/dKxjXMg2CzU9QFTPlJkNgKbsVvVARhXdQru1sFQlI
 scKRk27F6LUlPWKMWc9rG21e6ffmOM832F1ZCjMf3qfp+E/lLn8xQI0empc5ajfolNs8
 n9vw==
X-Gm-Message-State: AOAM532Ax93esrYOhS9lXWfbCCFBXmN+qQfNK3hn3kcjRXos3bVi9HPo
 01bdj5IcCHb5WNYqt9yZ+TR9mg==
X-Google-Smtp-Source: ABdhPJx59HlfNOzaBiKhlFJ/pYv623nu18Wd7KEcgzKhucQcQE/H44ghrIVuFl4DIUQ5qDA5jAQU/g==
X-Received: by 2002:a5d:684f:: with SMTP id o15mr4463346wrw.89.1589988769690; 
 Wed, 20 May 2020 08:32:49 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id 5sm3395840wmd.19.2020.05.20.08.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 08:32:49 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, joro@8bytes.org, bhelgaas@google.com
Subject: [PATCH v2 3/4] iommu/arm-smmu-v3: Use pci_ats_supported()
Date: Wed, 20 May 2020 17:22:02 +0200
Message-Id: <20200520152201.3309416-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520152201.3309416-1-jean-philippe@linaro.org>
References: <20200520152201.3309416-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, ashok.raj@intel.com,
 will@kernel.org, hch@infradead.org, alex.williamson@redhat.com,
 robin.murphy@arm.com, dwmw2@infradead.org
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
 drivers/iommu/arm-smmu-v3.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 82508730feb7..c5730557dbe3 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2652,26 +2652,20 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
 	}
 }
 
-#ifdef CONFIG_PCI_ATS
 static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 {
-	struct pci_dev *pdev;
+	struct device *dev = master->dev;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
-	if (!(smmu->features & ARM_SMMU_FEAT_ATS) || !dev_is_pci(master->dev) ||
-	    !(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS) || pci_ats_disabled())
+	if (!(smmu->features & ARM_SMMU_FEAT_ATS))
 		return false;
 
-	pdev = to_pci_dev(master->dev);
-	return !pdev->untrusted && pdev->ats_cap;
-}
-#else
-static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
-{
-	return false;
+	if (!(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS))
+		return false;
+
+	return dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));
 }
-#endif
 
 static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 {
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
