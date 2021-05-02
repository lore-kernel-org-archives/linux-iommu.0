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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F0BC433B4
	for <iommu@archiver.kernel.org>; Sun,  2 May 2021 07:05:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C27756101C
	for <iommu@archiver.kernel.org>; Sun,  2 May 2021 07:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27756101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A343C60E37;
	Sun,  2 May 2021 07:05:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5NYHOfCQfGAP; Sun,  2 May 2021 07:05:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B73560AF0;
	Sun,  2 May 2021 07:05:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BC1AC0024;
	Sun,  2 May 2021 07:05:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 073A8C0001
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 07:05:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EBD13403A3
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 07:05:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bwjYNaK5XigC for <iommu@lists.linux-foundation.org>;
 Sun,  2 May 2021 07:05:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6894D4039E
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 07:05:16 +0000 (UTC)
Received: by mail-pg1-x52a.google.com with SMTP id z16so1539117pga.1
 for <iommu@lists.linux-foundation.org>; Sun, 02 May 2021 00:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IHTsdU2vfU5Wpq72nptCBLFongQuhd4/qiJ01bkzxDc=;
 b=aBDqkxDC0vcKuNSD5lKBp9yytX2lw8gij6ncyAJK8EZqXbfXJyxKa4HlR4UUGOZLEg
 daX7I3oXZBk8JOC8q9fKBvuCtSRmwz4VqIdreVswAf0fRBU6XUx2sM4K66Y0BI3Rfl2T
 I1YzWYWXzwBYvcdGsC7CWGc8c96zjEp1LuF7Ji8iEypvykWDA1aFLV9dCk0xTscTCQO4
 f5u+ak2SzecGcLQK7q8duOo2c40jtQmdjiVXJngbYXVTls36Alwhk9ubXh07/r8TBO9N
 0aIpxs1UgdSNTjZBZzTbwR6TxbG5j02gXn0m58Orxsfxi9fh8+Um+WlN7WiQvvfCTE+0
 NxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IHTsdU2vfU5Wpq72nptCBLFongQuhd4/qiJ01bkzxDc=;
 b=ip5XLDNmJlv2L5Q9ysGjcb4pcHq3ihuFhC4tuMQEMrbhxYM9iU1CdgEBGaA3qyzyZS
 pltPzaPrjDTO4OKAs22lTzYjY59qaBOD/lxEZ4KC0AVqCahWMNjXH65Ho4g57EgTQwlF
 7ui+foRqeMvDoqBogfs4ddvcxCExx2SuMI7wNgyJwnYVYNrnOviXHj9tKuIIo5mwv+R4
 Ww/VnBqS4SHjDzCWEJtBU3T83hVoEwT7/VLP4LgWu/DLsPm/XSevz4S2PmNfo3GY2mYQ
 UY5a0RoYcd9hjqosfaNHuCZkkcx5PWiy9NxcloP9hcPIeugnaPqcvRM33BD1RoEAkwEa
 3HjA==
X-Gm-Message-State: AOAM532TDtcKsuRj9m+E2WFycH6gITs2eO51M2/G+lCuuc8KBju8C1f3
 BXyrMokuoomjJIeO0/b9tIo=
X-Google-Smtp-Source: ABdhPJyXpX1JGNTK5UlbEjpgZqyaBFGalwAGyRgOkA5CWK1tYgbtXN9KoSapMP+nUITKESJanl6B7g==
X-Received: by 2002:a63:1b10:: with SMTP id b16mr12476471pgb.308.1619939115817; 
 Sun, 02 May 2021 00:05:15 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id r18sm14345713pjo.30.2021.05.02.00.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 May 2021 00:05:15 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 3/4] iommu/amd: Selective flush on unmap
Date: Sun,  2 May 2021 00:00:00 -0700
Message-Id: <20210502070001.1559127-6-namit@vmware.com>
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
index 8a71ad477c34..1849b53f2149 100644
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
