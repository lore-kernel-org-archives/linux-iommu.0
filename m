Return-Path: <SRS0=ZJ+1=4B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9FAC3B18A
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 10:14:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9442220873
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 10:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VOc/AgqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9442220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 78576203ED;
	Thu, 13 Feb 2020 10:14:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oTkZWkiI2JpA; Thu, 13 Feb 2020 10:14:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D873F203FE;
	Thu, 13 Feb 2020 10:14:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C28A3C07FE;
	Thu, 13 Feb 2020 10:14:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A18C0C0177
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 10:14:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8CEB786822
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 10:14:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U63B4N-UGILf for <iommu@lists.linux-foundation.org>;
 Thu, 13 Feb 2020 10:14:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8FA8F84EB9
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 10:14:46 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id y11so5909591wrt.6
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 02:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ffFCJH69MWS3gu5TdGiWJyiqlV+lu2ttPiLstT+myYY=;
 b=VOc/AgqCKj2uTb+3PxiP+vBussxkp9Xnkbwfwzzx43saT/PGOSRy1wb3R9u4IgsK4H
 QgtZXTOA8HRdd+QcPOE+4QaCBUzelwLymRIyf4YS4nbzZy999MRyw3Gmdb9+lqXo9o+x
 cSvl76aBS1KTII8O9Sjj1wtfsi3eqx84csvK9F4ALVE3r1MwmAJ7UnQYUyo+qXg44Ck7
 Rzm3M0YkppAGyWJDQjiKghiJpi3EopMafcdcxQQf7qBr5Su45pBtfRQMKyfT/Y3eL+ox
 drtFFFENjIz5kvdy+A9naZ5w8nxw6A1hFcgvMhUgOOBUMShrobEgffwcpxdcOXCLIE+l
 rAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ffFCJH69MWS3gu5TdGiWJyiqlV+lu2ttPiLstT+myYY=;
 b=dsCoCuRqW9i0Uyo5u7ID8cj+/5p7jsJzGy/2NJ+8crizbNXTJbrTSYCNI6AInpkkxr
 pvmYdxKAukJ0Wtq5wlTc8HxNBB8ZIc4/fMlqeT7XVd1GJzDtvNbgx/a/UFkgFo4y3d2F
 LVvHJFfIBAcupB9EOlAF4ydGddtJYache9e+M97HBJmvAOeVcr1uBP/TA7YjD7EqkQ5i
 jU+8XXJsZeyoYw6D6ymRgPc8ATM7e/7zIL6RMklyedqw2sRSVyxRgavSrmg6y0Ud8vAP
 T+i7aptpk2fD5XCwI45o13maP0qVxkt6gg6vflz+4ADBNaFpQJ6n9jYU4IIsloxkHOeK
 o0Ig==
X-Gm-Message-State: APjAAAX/QBgBP3QT80tTbp3sA9gcgchNxpHo2tsQF4or/rqlRB6j/cQK
 NwwHvZ76hD+82GHorP3Z7aEYOw==
X-Google-Smtp-Source: APXvYqyGI8je5B1PaESIUTiNN6WwNtME2/884yAwDWfvmieJ+C+jPQfGseYc8+Y0Ju3V7vGv/sHu1Q==
X-Received: by 2002:adf:b193:: with SMTP id q19mr20678957wra.78.1581588885058; 
 Thu, 13 Feb 2020 02:14:45 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y131sm2428059wmc.13.2020.02.13.02.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 02:14:44 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, will@kernel.org, bhelgaas@google.com
Subject: [PATCH 1/4] PCI/ATS: Export symbols of PASID functions
Date: Thu, 13 Feb 2020 11:14:32 +0100
Message-Id: <20200213101435.229932-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213101435.229932-1-jean-philippe@linaro.org>
References: <20200213101435.229932-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: zhangfei.gao@linaro.org, robin.murphy@arm.com
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
