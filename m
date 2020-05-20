Return-Path: <SRS0=jIn/=7C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230B2C433E2
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 15:32:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF4620708
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 15:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b1+kAgxl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF4620708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9A07B86E24;
	Wed, 20 May 2020 15:32:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Aj014rOByws; Wed, 20 May 2020 15:32:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EC14986AB6;
	Wed, 20 May 2020 15:32:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9BBBC07FF;
	Wed, 20 May 2020 15:32:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBA9CC0176
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 15:32:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D8B4786B8C
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 15:32:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gTnJ783Q0q2A for <iommu@lists.linux-foundation.org>;
 Wed, 20 May 2020 15:32:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8D5A9863E0
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 15:32:50 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id m185so3343624wme.3
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 08:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O7DYfmf9DoemFEeuQy4b1/2PVfJbeRti6n+bNE2Muts=;
 b=b1+kAgxlVIFzY855JbBQ3hVSAl1XF23bult0N08r/2anx/2IJpSyiTeLZvTGDFlMJs
 kxW+zFn4vcgsS4r9sUm4EYHwrkZ9Tg0qFyVPFCL4Ei7axkLs8Xz8iu/KwaDwd/0aDTlE
 auKYtUMu+kkUBxYKag7tDHR3M2Epl1b8yJ4t30NwXGMycp09zJuWWSbLyahKlGeMK0Cs
 y05Brx5BCk00/P/o7sIMUghv2YRZfX04PWxdoyZOvIF1FQraoo90+AFMzn9Z/c8ce8Wn
 szoeT1Umh1dlBNMbO49UHz1GVsrUNDFn6l1crMvIp0OP6YT3ZT/DdRc9/k5Ax9bdurLM
 Hevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O7DYfmf9DoemFEeuQy4b1/2PVfJbeRti6n+bNE2Muts=;
 b=FT1de8uZzL2/1iFU8axMTAOZQ692DFGulLRmUN2TCKnpFvGBtHSrxqp8mr3udH6REd
 LWrb6ge/SaGAXOkDVYkQ9ra6GzpjT9jRZtSZoMeWv+TKIR6ZaV7OmLOQ+BbLtdrlgd5f
 M9lvaMA5PUPoOtjFv3Qq1cNtxFrO0f6rLYAnrIGjSRiCNak+n8ZA+UHx96PRQJnX9OLA
 uDXcFHJjqT65mOBtzX41UeCaox69OuWRTEPkv15ZaV40+4rsoJrh3MdXa9H8+TUiZWz0
 DFgLT1b550FWz8ENhvB7b/G82y6dD1tqegH9yT3NdOLxC9Bq+biurjlPBv/TDjjsCkiB
 eJrw==
X-Gm-Message-State: AOAM531tucBcLu+hs9SeOuLtkS3YlXmrOoL2RFzRjAZqqIjzUGiP6Dmb
 r+p3I5z3FdyuyBTGvjWnWkuGrg==
X-Google-Smtp-Source: ABdhPJyXoBArE7O2LUY1bsFSdaSpMuGVZxxPnLVHJfCNkRrs/jqFwXfVXYVWBXsafD56aI42j7GbIg==
X-Received: by 2002:a7b:c651:: with SMTP id q17mr4787617wmk.167.1589988768756; 
 Wed, 20 May 2020 08:32:48 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id 5sm3395840wmd.19.2020.05.20.08.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 08:32:48 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, joro@8bytes.org, bhelgaas@google.com
Subject: [PATCH v2 2/4] iommu/amd: Use pci_ats_supported()
Date: Wed, 20 May 2020 17:22:01 +0200
Message-Id: <20200520152201.3309416-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520152201.3309416-1-jean-philippe@linaro.org>
References: <20200520152201.3309416-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Joerg Roedel <jroedel@suse.de>, ashok.raj@intel.com, will@kernel.org,
 hch@infradead.org, alex.williamson@redhat.com, robin.murphy@arm.com,
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

The pci_ats_supported() function checks if a device supports ATS and is
allowed to use it. In addition to checking that the device has an ATS
capability and that the global pci=noats is not set
(pci_ats_disabled()), it also checks if a device is untrusted.

A device is untrusted if it is plugged into an external-facing port such
as Thunderbolt and could be spoofing an existing device to exploit
weaknesses in the IOMMU configuration. By calling pci_ats_supported() we
keep DTE[I]=0 for untrusted devices and abort transactions with
Pretranslated Addresses.

Reviewed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/amd_iommu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1dc3718560d0..8b7a9e811d33 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -313,16 +313,15 @@ static struct iommu_group *acpihid_device_group(struct device *dev)
 static bool pci_iommuv2_capable(struct pci_dev *pdev)
 {
 	static const int caps[] = {
-		PCI_EXT_CAP_ID_ATS,
 		PCI_EXT_CAP_ID_PRI,
 		PCI_EXT_CAP_ID_PASID,
 	};
 	int i, pos;
 
-	if (pci_ats_disabled())
+	if (!pci_ats_supported(pdev))
 		return false;
 
-	for (i = 0; i < 3; ++i) {
+	for (i = 0; i < 2; ++i) {
 		pos = pci_find_ext_capability(pdev, caps[i]);
 		if (pos == 0)
 			return false;
@@ -3150,11 +3149,8 @@ int amd_iommu_device_info(struct pci_dev *pdev,
 
 	memset(info, 0, sizeof(*info));
 
-	if (!pci_ats_disabled()) {
-		pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ATS);
-		if (pos)
-			info->flags |= AMD_IOMMU_DEVICE_FLAG_ATS_SUP;
-	}
+	if (pci_ats_supported(pdev))
+		info->flags |= AMD_IOMMU_DEVICE_FLAG_ATS_SUP;
 
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
 	if (pos)
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
