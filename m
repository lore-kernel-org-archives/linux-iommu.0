Return-Path: <SRS0=kZfo=MF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF8BC11F68
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 17:25:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6360261358
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 17:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6360261358
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3435760AEF;
	Tue, 13 Jul 2021 17:25:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NFDIBg6KgA7x; Tue, 13 Jul 2021 17:25:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0E8B560ACD;
	Tue, 13 Jul 2021 17:25:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4D12C0024;
	Tue, 13 Jul 2021 17:24:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B05E5C001B
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 17:24:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A001C60AD8
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 17:24:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ar5lyln1hhlM for <iommu@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 17:24:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 28F3460AC9
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 17:24:57 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id y4so20258668pfi.9
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 10:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CGMXQG/SqUWotpOKfxzjkS1Emk7piwJc2wdJhidrZfg=;
 b=ZEV18InabLpWrAb67fVZJkuR2TAwzNK6FqkD40QkjWHrjwFIY9iEaxWbOvDlOZLJ+q
 yyoM7ONIbK40p50r9EuJyH0rqJ3YZrQX8pb0cfy2M+Acy4S9KTxg1tQct3gnHEsOsfFG
 oYKuTqDcNr/1QLaMfpXBQcq0PfzUbnImRYhh6A60fTrUJcihSLhxNx2c/z14SkPzljJL
 5KwM2+R6etqtZs2U/6eB8m5eOdfd4IM1nly2bgJApR/6AiBjno76ukTmMkLrwBPf/otD
 zUi58KVzB43GrTONwonJceDjKHprQVwzvkzX2c8YlHNdRVzxpKsAAZNIPsFx6qLHWAaj
 5PwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CGMXQG/SqUWotpOKfxzjkS1Emk7piwJc2wdJhidrZfg=;
 b=aLiZoGLxHyHO6BI3wox7hDFQNC+pyOQ03vILDZq3MGcXZt523LdLIBSayYsWrGB2wB
 y0Ovv2jDD2tqhb0n8Z+8228yEVjiXz/IKbezOQoak3qH3ussyROa2jzQY7FaKqfgmlzZ
 W3NBiPFuejWznyU3K8TOXLzhNfxse3F2Siaz21RioMkMMdSN2G4EnhBy2U3PEkA0mNYX
 EwPWeToZTUGgI8vhRpcWSfp5Rmcnicf7Mn43NHcfuqupio47IMODoa79uaSD9k/4ANeD
 tAOGSOMKRAIiTwTFs4d17rWYsgWkvLf+otWuptxlJpG7SBH6XAy938gu10O92XhWawFD
 eLyw==
X-Gm-Message-State: AOAM530Ar0KVjaD/w9aMyV+MHjug3PxN2iMxEYUhTb8Nh3Nfbv6BW9o9
 8wVl75HeOxN/SZ25bHnR2PA=
X-Google-Smtp-Source: ABdhPJz8tmgNddXfz/JOUXuDuG3No6nG/oP/t1VQKl8vVn8WD3JmEF4dP30YfBLvpzOKB6AqOWDETw==
X-Received: by 2002:a63:1622:: with SMTP id w34mr5265386pgl.354.1626197096460; 
 Tue, 13 Jul 2021 10:24:56 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id lt14sm18239032pjb.47.2021.07.13.10.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 10:24:56 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v5 6/7] iommu/amd: Sync once for scatter-gather operations
Date: Tue, 13 Jul 2021 02:41:50 -0700
Message-Id: <20210713094151.652597-7-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713094151.652597-1-namit@vmware.com>
References: <20210713094151.652597-1-namit@vmware.com>
MIME-Version: 1.0
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Nadav Amit <namit@vmware.com>,
 Jiajun Cao <caojiajun@vmware.com>, Will Deacon <will@kernel.org>
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

On virtual machines, software must flush the IOTLB after each page table
entry update.

The iommu_map_sg() code iterates through the given scatter-gather list
and invokes iommu_map() for each element in the scatter-gather list,
which calls into the vendor IOMMU driver through iommu_ops callback. As
the result, a single sg mapping may lead to multiple IOTLB flushes.

Fix this by adding amd_iotlb_sync_map() callback and flushing at this
point after all sg mappings we set.

This commit is followed and inspired by commit 933fcd01e97e2
("iommu/vt-d: Add iotlb_sync_map callback").

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/iommu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cc55c4c6a355..c1fcd01b3c40 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2022,6 +2022,16 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 	return ret;
 }
 
+static void amd_iommu_iotlb_sync_map(struct iommu_domain *dom,
+				     unsigned long iova, size_t size)
+{
+	struct protection_domain *domain = to_pdomain(dom);
+	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
+
+	if (ops->map)
+		domain_flush_np_cache(domain, iova, size);
+}
+
 static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 			 phys_addr_t paddr, size_t page_size, int iommu_prot,
 			 gfp_t gfp)
@@ -2040,10 +2050,8 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 	if (iommu_prot & IOMMU_WRITE)
 		prot |= IOMMU_PROT_IW;
 
-	if (ops->map) {
+	if (ops->map)
 		ret = ops->map(ops, iova, paddr, page_size, prot, gfp);
-		domain_flush_np_cache(domain, iova, page_size);
-	}
 
 	return ret;
 }
@@ -2223,6 +2231,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.attach_dev = amd_iommu_attach_device,
 	.detach_dev = amd_iommu_detach_device,
 	.map = amd_iommu_map,
+	.iotlb_sync_map	= amd_iommu_iotlb_sync_map,
 	.unmap = amd_iommu_unmap,
 	.iova_to_phys = amd_iommu_iova_to_phys,
 	.probe_device = amd_iommu_probe_device,
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
