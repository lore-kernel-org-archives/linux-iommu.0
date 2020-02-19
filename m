Return-Path: <SRS0=JfOd=4H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3AAC35254
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 20:04:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC8124670
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 20:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Qpoc6v6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC8124670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8CD71863FD;
	Wed, 19 Feb 2020 20:04:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vtKGxYY+UXJ1; Wed, 19 Feb 2020 20:04:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AD2B285E5E;
	Wed, 19 Feb 2020 20:04:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 814C8C1D81;
	Wed, 19 Feb 2020 20:04:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 410CEC013E
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 20:04:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 25A3A861A2
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 20:04:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tbBn2zbD5lmH for <iommu@lists.linux-foundation.org>;
 Wed, 19 Feb 2020 20:04:45 +0000 (UTC)
X-Greylist: delayed 00:24:14 by SQLgrey-1.7.6
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com
 [209.85.166.202])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9B60585E5E
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 20:04:45 +0000 (UTC)
Received: by mail-il1-f202.google.com with SMTP id i67so1160472ilf.5
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 12:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=LhQugWcRIJnBiCo5sPUtpmjmiq165+wXiyQpGM1ghvc=;
 b=Qpoc6v6Kkkt/4h6Qp0vNZudJzadERAugv0sReBOvyKTPLj8/0n/qNMlGweInDDuPcN
 87YufxziuCTog8tdGQrAvE6zU1I3NNtenzNEa74eZbIPRkxhK2YXH1U/mymGU4SOnhPS
 DN5wJZ7j10Et5cF3oYIEIMDr+eNA73CgyYKcMGSBPJyq/UQmOWH6N4kgotslh3HDTyzb
 HSZapOVQTCJHmGH1cVZBzXFmdzBET4jV3NKVF61mOmCfUBtPa9VYM+2lXyVgBmRpmVlo
 tOoO/DJzWblWftTicKu7ZixU81/9lM2LZPv8ZpEL4Kl42aDJoh8TIe7PnYEV9WHVP6Wg
 iqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=LhQugWcRIJnBiCo5sPUtpmjmiq165+wXiyQpGM1ghvc=;
 b=g6yEPAFNtuhUghRE+vNsnUv8jSQTBi0/g2+aocYLnSlzQy47guzfFS1tWAyO9f4UnY
 CUflRpYMoCJRgsleDALpx7ZwEwQDPKMyDiRyEMROPXoSmddTd2WZ4kMsfsJaboind0hW
 39CgZqR24apLyhYWh/8BufLfvmfZrLoPHDEbgRxZY5VKeXAYNi24iLaDB7Hw5421AlIj
 3jk9u+IA19tDggY6jwFyhpsPP3W6q+EVaWcWN5tSuYHgwClXAaAKCkFGxMIDjO4ZaX7A
 BDxq/7brxwMrFXJU7sFBOxSitXqRjRaJgUfklJBvNVAD6bK/mNmuFVDTdfu9ckdOnVxn
 qEWA==
X-Gm-Message-State: APjAAAVUvri7fgkbEViuKiLrFXZg5aulNg5v2G2MNUx7CQ43PRLiQiYV
 QYrPVSQbJpFoB55sAreetJ3TXbGH6Pc+rw==
X-Google-Smtp-Source: APXvYqzM0CPkh/AZyjT3hJ/KHdeBU22XVBp5f7Csclt53C6Uva1qzK4At6CGLvs5am2zgNYxNZoopm+XQYml2w==
X-Received: by 2002:a63:7207:: with SMTP id n7mr10556061pgc.253.1582140744973; 
 Wed, 19 Feb 2020 11:32:24 -0800 (PST)
Date: Wed, 19 Feb 2020 11:32:21 -0800
Message-Id: <20200219193221.19799-1-yonghyun@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] iommu/vt-d: Fix a bug in intel_iommu_iova_to_phys() for huge
 page
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>
Cc: Yonghyun Hwang <yonghyun@google.com>, linux-kernel@vger.kernel.org,
 Havard Skinnemoen <hskinnemoen@google.com>, iommu@lists.linux-foundation.org,
 Moritz Fischer <mdf@kernel.org>, Deepa Dinamani <deepadinamani@google.com>
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
From: Yonghyun Hwang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yonghyun Hwang <yonghyun@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

intel_iommu_iova_to_phys() has a bug when it translates an IOVA for a huge
page onto its corresponding physical address. This commit fixes the bug by
accomodating the level of page entry for the IOVA and adds IOVA's lower
address to the physical address.

Signed-off-by: Yonghyun Hwang <yonghyun@google.com>
---
 drivers/iommu/intel-iommu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0c8d81f56a30..beff7ede41f4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5548,6 +5548,15 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 	return size;
 }
 
+static inline unsigned long pfn_level_mask(unsigned long pfn, int level)
+{
+	if (level > 1)
+		return pfn & (BIT_MASK(level_to_offset_bits(level)) - 1)
+			<< VTD_PAGE_SHIFT;
+	else
+		return 0;
+}
+
 static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 					    dma_addr_t iova)
 {
@@ -5555,13 +5564,15 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 	struct dma_pte *pte;
 	int level = 0;
 	u64 phys = 0;
+	const unsigned long pfn = iova >> VTD_PAGE_SHIFT;
 
 	if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
 		return 0;
 
-	pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level);
+	pte = pfn_to_dma_pte(dmar_domain, pfn, &level);
 	if (pte)
-		phys = dma_pte_addr(pte);
+		phys = dma_pte_addr(pte) + pfn_level_mask(pfn, level) +
+			(iova & ~VTD_PAGE_MASK);
 
 	return phys;
 }
-- 
2.25.0.265.gbab2e86ba0-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
