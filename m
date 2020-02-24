Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E217C11D36
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 16:59:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F74218AC
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 16:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RRx8U11v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F74218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D93BF20509;
	Mon, 24 Feb 2020 16:59:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3YPrIHQG5vLS; Mon, 24 Feb 2020 16:59:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 83106203F4;
	Mon, 24 Feb 2020 16:59:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78961C18DA;
	Mon, 24 Feb 2020 16:59:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9B52C18DA
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 16:59:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D015584AC5
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 16:59:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QFwoW9Rk_fQ1 for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 16:59:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 822FB84636
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 16:59:04 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id q9so31710wmj.5
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 08:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ffFCJH69MWS3gu5TdGiWJyiqlV+lu2ttPiLstT+myYY=;
 b=RRx8U11vMPRTlGnIGn4sCB8SnlGdKWqavfSqD6SR8YQbgWxZkfH48PSJ+5CDfsbk5S
 Ze+3wOWEkqnI8YBqOFSDJz5FBNrpacYvYZgTsDkmdA5n4wlRZVjddXIXMc1Swc0FusDG
 ID0exI27uMOdvgwnrKyEkHPZhPAkCE5/JcqFqErWtxLy03ZXcHvBaYquM+8n9pZzbnmf
 JF5yKMQAnnlPwCUdQ417vEY8sBmXYM2Du+VPCiVVgh3ewo9JEWYEU99AdEfFfMi7eRqo
 Nb3D2kPURsTnpbcyeQ1NnVKVHrxjKbWjHpk2O3LengMczoRsjyCdMZXBKdW27vABPch/
 uALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ffFCJH69MWS3gu5TdGiWJyiqlV+lu2ttPiLstT+myYY=;
 b=WNQVh/q4thqPOdiWqEyquwt+YQ1ewkTF3TEc0NkaNqLii+Clt3mQ5qSKBnnZbNPFRT
 sazBikmIKYN95abuxN/jdDLQS7/BBloVgvfYVj97LsVlZ/g3MkmN7f4gEqDlO3+shGAu
 jGNbHhulLHVpF8YByZuu/o86m+6NXn4duNn23uv6CpLWNlIPmY5BLFVhkr8JZegZJZbQ
 Vm5M+2ex25fBpzgDPm2cEejt6sUZ+rTwJRh+OP5O+MNViPrYsunnRjZIQBCabRHYB37G
 utFyl5PMwN8Qed3pkrABH2pjTzQpn4FBDbu340YHIUMuSslPbpJQX/UvpUZ2ToRhQgL+
 KYlw==
X-Gm-Message-State: APjAAAUuo8rVrpPrWKUohufHoe9B1cmjGAjtVLSBPwcnC6JEDEVGTx6H
 um2TUX7TIeQ2B4RazgbljoTRTMAsGgY=
X-Google-Smtp-Source: APXvYqzuI5JL7DJSxxC2MA8748RGx58CDQkzuT+eunhF/IfX/BLY+BsUCaKxLYTvlGXreVTEpIeERg==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr23887005wmi.51.1582563543020; 
 Mon, 24 Feb 2020 08:59:03 -0800 (PST)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id b10sm19473978wrt.90.2020.02.24.08.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 08:59:02 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, will@kernel.org, bhelgaas@google.com
Subject: [PATCH v2 1/6] PCI/ATS: Export symbols of PASID functions
Date: Mon, 24 Feb 2020 17:58:41 +0100
Message-Id: <20200224165846.345993-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224165846.345993-1-jean-philippe@linaro.org>
References: <20200224165846.345993-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: zhangfei.gao@linaro.org, robin.murphy@arm.com, robh@kernel.org
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

The Arm SMMUv3 driver uses pci_{enable,disable}_pasid() and related
functions.  Export them to allow the driver to be built as a module.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/pci/ats.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 3ef0bb281e7c..390e92f2d8d1 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -366,6 +366,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_enable_pasid);
 
 /**
  * pci_disable_pasid - Disable the PASID capability
@@ -390,6 +391,7 @@ void pci_disable_pasid(struct pci_dev *pdev)
 
 	pdev->pasid_enabled = 0;
 }
+EXPORT_SYMBOL_GPL(pci_disable_pasid);
 
 /**
  * pci_restore_pasid_state - Restore PASID capabilities
@@ -441,6 +443,7 @@ int pci_pasid_features(struct pci_dev *pdev)
 
 	return supported;
 }
+EXPORT_SYMBOL_GPL(pci_pasid_features);
 
 #define PASID_NUMBER_SHIFT	8
 #define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
@@ -469,4 +472,5 @@ int pci_max_pasids(struct pci_dev *pdev)
 
 	return (1 << supported);
 }
+EXPORT_SYMBOL_GPL(pci_max_pasids);
 #endif /* CONFIG_PCI_PASID */
-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
