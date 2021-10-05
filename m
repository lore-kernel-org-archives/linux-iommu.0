Return-Path: <SRS0=ORUS=OZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB78C433F5
	for <iommu@archiver.kernel.org>; Tue,  5 Oct 2021 15:12:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1BDA61502
	for <iommu@archiver.kernel.org>; Tue,  5 Oct 2021 15:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D1BDA61502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9AF864033F;
	Tue,  5 Oct 2021 15:12:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SP5h6U3gGCh4; Tue,  5 Oct 2021 15:12:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 37545400EF;
	Tue,  5 Oct 2021 15:12:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 215A1C000F;
	Tue,  5 Oct 2021 15:12:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25F71C000D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Oct 2021 15:11:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 15ED940652
 for <iommu@lists.linux-foundation.org>; Tue,  5 Oct 2021 15:11:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VcGkp-9Gc0lN for <iommu@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 15:11:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6988840502
 for <iommu@lists.linux-foundation.org>; Tue,  5 Oct 2021 15:11:58 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id w11so2507480plz.13
 for <iommu@lists.linux-foundation.org>; Tue, 05 Oct 2021 08:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E82Cx5NdqaUuINJgQKibCVb+p6vXVPNvYvc2YfkgoB0=;
 b=cO+hkCLv/qSB++cn/DXwauppsy55Fnhvf4U6BCC68I1drgBLrT1Su9mjLqMZi92k8Y
 OGrveJGXv9eQRBPFPFsCqxqjAkTJvw5Nne1uwY0HkR/OO01F1PBW/SupEJ6Jx5uAe1p3
 RCfpKtVGke/y9UxOQf4XrTUIPSyXYSBIRG6ODAJSSeMXQwOwl+OS8BahYkPFfMADDLyu
 n1LQVLqIo+Zc5VB6dUUuu/gnyabOtE8I1ewZhOHEhfvVyUno8FSe14fE64hVgaVMhX/v
 3mKqq80UnMiG15hK+vpvWGdXl81aVI8K3o834+/+GKdohFijqGKPd89NXig7WhdJIgdS
 tlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E82Cx5NdqaUuINJgQKibCVb+p6vXVPNvYvc2YfkgoB0=;
 b=mnwUAqRw+nKHK4hI5pI/2hqBa+7UWymkI5nnqW5l3WB0fjNprbq55a0SVnjlN6qjat
 AtgwHJ7Y03ppYojQD17vlxoUYUiu7CKcmLRLUioo2tnZ2w98abIY1IzPtqEp/TRivPMi
 YTZ+Qo7Z/uzr3mDD6j+DLsNYkxYh9/I78nYRxOrxeJfk1UmuA/IqW84+Qd6R78R8qEpw
 mxoCt5NDrxclmrxEz7/yKFbo10KoN9EVJ5aoggDhT0JSD8cc38eL7OOgP4Iku0IXa4h+
 kpHNq7W2IHPJ1AaSJeDUXOfWLGspEQZuWTzfOgpDZ0MR7/bjbupAMxCT/qyhSJZz6bhT
 C9/Q==
X-Gm-Message-State: AOAM530cK8H9wjRFJ65iD1uO8n0m7GQ4irDCcXTP/g4L34ZlUNAmypiR
 rl1ZmYfYYpdL4vrvl75V76g=
X-Google-Smtp-Source: ABdhPJwHxECxSN9lHmDRg12ksn5Q+7p33RRlUTZ5arcREYmllLsReuMFC1PvuycX4zOgeQE+9jnoIg==
X-Received: by 2002:a17:90b:38d2:: with SMTP id
 nn18mr4521074pjb.110.1633446717886; 
 Tue, 05 Oct 2021 08:11:57 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
 by smtp.gmail.com with ESMTPSA id
 a12sm2275639pjq.16.2021.10.05.08.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Oct 2021 08:11:56 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH v2 1/3] iommu/io-pgtable-arm: Add way to debug pgtable walk
Date: Tue,  5 Oct 2021 08:16:25 -0700
Message-Id: <20211005151633.1738878-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211005151633.1738878-1-robdclark@gmail.com>
References: <20211005151633.1738878-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, freedreno@lists.freedesktop.org,
 Will Deacon <will@kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
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

From: Rob Clark <robdclark@chromium.org>

Add an io-pgtable method to retrieve the raw PTEs that would be
traversed for a given iova access.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/io-pgtable-arm.c | 40 +++++++++++++++++++++++++++-------
 include/linux/io-pgtable.h     |  9 ++++++++
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index dd9e47189d0d..c470fc0b3c2b 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -700,38 +700,61 @@ static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
 	return arm_lpae_unmap_pages(ops, iova, size, 1, gather);
 }
 
-static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
-					 unsigned long iova)
+static int arm_lpae_pgtable_walk(struct io_pgtable_ops *ops, unsigned long iova,
+				 void *_ptes, int *num_ptes)
 {
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	arm_lpae_iopte pte, *ptep = data->pgd;
+	arm_lpae_iopte *ptes = _ptes;
+	int max_ptes = *num_ptes;
 	int lvl = data->start_level;
 
+	*num_ptes = 0;
+
 	do {
+		if (*num_ptes >= max_ptes)
+			return -ENOSPC;
+
 		/* Valid IOPTE pointer? */
 		if (!ptep)
-			return 0;
+			return -EFAULT;
 
 		/* Grab the IOPTE we're interested in */
 		ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
 		pte = READ_ONCE(*ptep);
 
+		ptes[(*num_ptes)++] = pte;
+
 		/* Valid entry? */
 		if (!pte)
-			return 0;
+			return -EFAULT;
 
 		/* Leaf entry? */
 		if (iopte_leaf(pte, lvl, data->iop.fmt))
-			goto found_translation;
+			return 0;
 
 		/* Take it to the next level */
 		ptep = iopte_deref(pte, data);
 	} while (++lvl < ARM_LPAE_MAX_LEVELS);
 
-	/* Ran out of page tables to walk */
-	return 0;
+	return -EFAULT;
+}
+
+static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
+					 unsigned long iova)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	arm_lpae_iopte pte, ptes[ARM_LPAE_MAX_LEVELS];
+	int lvl, num_ptes = ARM_LPAE_MAX_LEVELS;
+	int ret;
+
+	ret = arm_lpae_pgtable_walk(ops, iova, ptes, &num_ptes);
+	if (ret)
+		return 0;
+
+	pte = ptes[num_ptes - 1];
+	lvl = num_ptes - 1 + data->start_level;
 
-found_translation:
 	iova &= (ARM_LPAE_BLOCK_SIZE(lvl, data) - 1);
 	return iopte_to_paddr(pte, data) | iova;
 }
@@ -816,6 +839,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 		.unmap		= arm_lpae_unmap,
 		.unmap_pages	= arm_lpae_unmap_pages,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
+		.pgtable_walk	= arm_lpae_pgtable_walk,
 	};
 
 	return data;
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 86af6f0a00a2..501f362a929c 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -148,6 +148,13 @@ struct io_pgtable_cfg {
  * @unmap:        Unmap a physically contiguous memory region.
  * @unmap_pages:  Unmap a range of virtually contiguous pages of the same size.
  * @iova_to_phys: Translate iova to physical address.
+ * @pgtable_walk: Return details of a page table walk for a given iova.
+ *                This returns the array of PTEs in a format that is
+ *                specific to the page table format.  The number of
+ *                PTEs can be format specific.  The num_ptes parameter
+ *                on input specifies the size of the ptes array, and
+ *                on output the number of PTEs filled in (which depends
+ *                on the number of PTEs walked to resolve the iova)
  *
  * These functions map directly onto the iommu_ops member functions with
  * the same names.
@@ -165,6 +172,8 @@ struct io_pgtable_ops {
 			      struct iommu_iotlb_gather *gather);
 	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
 				    unsigned long iova);
+	int (*pgtable_walk)(struct io_pgtable_ops *ops, unsigned long iova,
+			    void *ptes, int *num_ptes);
 };
 
 /**
-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
