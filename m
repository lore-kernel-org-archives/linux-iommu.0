Return-Path: <SRS0=fY2N=J5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0918CC433B4
	for <iommu@archiver.kernel.org>; Sun,  2 May 2021 07:05:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B76EC6101C
	for <iommu@archiver.kernel.org>; Sun,  2 May 2021 07:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76EC6101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 917F241D2E;
	Sun,  2 May 2021 07:05:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4sF6_5V1SXfz; Sun,  2 May 2021 07:05:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4018941E5F;
	Sun,  2 May 2021 07:05:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12F78C0025;
	Sun,  2 May 2021 07:05:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73CCEC000E
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 07:05:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5647084C77
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 07:05:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k9ADJ1fhp0Rx for <iommu@lists.linux-foundation.org>;
 Sun,  2 May 2021 07:05:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C0CCE84C6F
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 07:05:13 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 f2-20020a17090a4a82b02900c67bf8dc69so3994552pjh.1
 for <iommu@lists.linux-foundation.org>; Sun, 02 May 2021 00:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sNLrC3xn/EJ4tCCyd6W1ssXumNURL3TkwWzu/8GDQlU=;
 b=jIJhKOykgtuz5dFxlmHmjr8R7ZNjI3JmrRl8qXjFjaiMAC+Qod5blL/Dt1dHYxVBug
 e+tu3dty9eQvp0qTcqJZ1+YSJEeawPLg3YfR2rALmHV1vCV6x6ZtiAUMT0uLILtLYvFX
 RHe04nZWiWiAjLygU1kyAmPSmWBab/zd9c6C1FDwNBlV0V7wBnYfIxBdOGwEdoYQnuHj
 iOc9+MvgA52agmf2ngid4Tbw0tcPyGUuUTd/JY+M91LXR+qZT+ajJjB84XLTFVvqC4wN
 9kZtn2C99u6xycq834JpGyC7BWuohjZ5vF4wfPeurG6b/bdIKvg9NnNPzt8FDYeSjKLo
 zNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sNLrC3xn/EJ4tCCyd6W1ssXumNURL3TkwWzu/8GDQlU=;
 b=BtGfz/nBRTy7S1aZ/40jhFg+3cFwd+pPSHneCxY+fHgw4MydHJ2Lglcb2mFiNuNDOP
 jziUwsNiUco8ezih7n2Q7eqZQ9I0vLiyP9abaDrw2l/X5HoKtz/cUoYAzPzHsgZkqcmb
 yfBVxsZhvDCTWoDFzjq53vOpISIW1Hsq82gRAjLlARe28YwNBLyyQXWrXiiajDYKbJS9
 P4p9C5QbaO89YtoqHVIR101hPczN5BeVtbe4GQilE5pEkwJ7HscDsEgFV2oH1M6FTHEa
 FrzefQf9Rj6nPQyaKn9y8O3XUr5Jp6zNkwKb+XaAll7ykJbGMKY4v6zdi2GytlWdp6Og
 d1HA==
X-Gm-Message-State: AOAM533bMaEXeTtZvjtsr3/K33W4kSMGVvwTSuhjpdh07K7W9fp2qwJX
 uAfRHXRoS1vBerMEnJepPm0=
X-Google-Smtp-Source: ABdhPJyGZHP8Y357IdwlflXZ5qUHrsA2va+/5mQC0lhFLhMkwedRyoHGdqPtOYKXOvzPdBRP11YiJA==
X-Received: by 2002:a17:90a:390a:: with SMTP id
 y10mr11765295pjb.9.1619939113139; 
 Sun, 02 May 2021 00:05:13 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id r18sm14345713pjo.30.2021.05.02.00.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 May 2021 00:05:12 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 2/4] iommu/amd: Selective flush on unmap
Date: Sat,  1 May 2021 23:59:58 -0700
Message-Id: <20210502070001.1559127-4-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210502070001.1559127-1-namit@vmware.com>
References: <20210502070001.1559127-1-namit@vmware.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Nadav Amit <namit@vmware.com>,
 Jiajun Cao <caojiajun@vmware.com>, linux-kernel@vger.kernel.org
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

From: Nadav Amit <namit@vmware.com>

Recent patch attempted to enable selective page flushes on AMD IOMMU but
neglected to adapt amd_iommu_iotlb_sync() to use the selective flushes.

Adapt amd_iommu_iotlb_sync() to use selective flushes and change
amd_iommu_unmap() to collect the flushes. As a defensive measure, to
avoid potential issues as those that the Intel IOMMU driver encountered
recently, flush the page-walk caches by always setting the "pde"
parameter. This can be removed later.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/iommu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6723cbcf4030..b8cabbbeed71 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2057,12 +2057,17 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 {
 	struct protection_domain *domain = to_pdomain(dom);
 	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
+	size_t r;
 
 	if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
 	    (domain->iop.mode == PAGE_MODE_NONE))
 		return 0;
 
-	return (ops->unmap) ? ops->unmap(ops, iova, page_size, gather) : 0;
+	r = (ops->unmap) ? ops->unmap(ops, iova, page_size, gather) : 0;
+
+	iommu_iotlb_gather_add_page(dom, gather, iova, page_size);
+
+	return r;
 }
 
 static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
@@ -2165,7 +2170,13 @@ static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
 static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
 				 struct iommu_iotlb_gather *gather)
 {
-	amd_iommu_flush_iotlb_all(domain);
+	struct protection_domain *dom = to_pdomain(domain);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dom->lock, flags);
+	__domain_flush_pages(dom, gather->start, gather->end - gather->start, 1);
+	amd_iommu_domain_flush_complete(dom);
+	spin_unlock_irqrestore(&dom->lock, flags);
 }
 
 static int amd_iommu_def_domain_type(struct device *dev)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
