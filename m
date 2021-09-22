Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A24C433FE
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 22:26:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54AC36120E
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 22:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 54AC36120E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3152783FFD;
	Wed, 22 Sep 2021 22:26:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z58hS3JFSydQ; Wed, 22 Sep 2021 22:26:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D8A3383F8E;
	Wed, 22 Sep 2021 22:26:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABA1DC0011;
	Wed, 22 Sep 2021 22:26:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAF97C000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 22:26:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D9BEF404EC
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 22:26:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bQiyTJnOr1EN for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 22:26:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 597CF402A6
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 22:26:07 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id k23so3136360pji.0
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 15:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8WCMLDltvC1dKxSIyIZE+6LP/jkA86h78VZKD3EckBc=;
 b=b5c8dDz/0BcqZE9GwtAt4HpSoosfgotGxcZwmzujhaXxCwVfhCo2bdn7iyVRlEb61b
 kdt2MOu8E+1DMHgipjJn1MkAnHAtXdCyQRD3QAXzW2QjmEV0BmxPLmCVTu5XJrBuFlSQ
 6x6jgRisFnXeZ6UnVTWHT7/89jxZkyH2bE4K2HxlOin8SJzd7x5li2akSGznh/8bvat5
 T8vpPncPw7Fo0/QUZrkWp0QbtDtLIW20bThzkVVVxE+FKBO2QVAbo5/INjs8zbDBfIpK
 zHrK6E7VRc+C1w4tK3wkx+LwRBrjvJmBnwgHqLYfqV1QzEUb2WvyH3bE8m9UJBCachi7
 v6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8WCMLDltvC1dKxSIyIZE+6LP/jkA86h78VZKD3EckBc=;
 b=JQZVuXwwQ+t4WvsyMMzkcZvn4jN520dyQ1yy/FPze0XBpdta7Kv66zDnMA0OgjgD74
 nHYzC8wIwDecMyi7wtpu6l3/cQhwRsQ19AeXJrBs4rKzuo8eiyAf511idmU7KB9Y/1Lv
 e5ZQSCNOO2366FWjUj4Wm6efs+j4shLrkNDsdTwYrmU7bDibDUTqzcPkuRsLuy6zlmcF
 hyyRzPnWIRXi7dnTUQivYZd18jRZ9NqzXc/Cx6sJjpitn1xlDGnH9sDujMWQb3x68OVr
 5uuFN9d0YNmgXUyFYbEyRyderz8HG8l971GvuN+XaGmhVQwJR0DPy7Zlw02IUUBSdWLo
 1FDA==
X-Gm-Message-State: AOAM533bBgahrjvptzP3Y2WS9vkGGOZJsk97zb6nfNXC6eAEiI4YidJ7
 q3OgTNEhENS6W0kGAk5RkvA=
X-Google-Smtp-Source: ABdhPJx8Fk6wSe3f+aWLKeQPr0N9oabkoKmJ78CFl91xbk6olyNUWDYxhgku5teAj53kgszlMATrBg==
X-Received: by 2002:a17:90a:9291:: with SMTP id
 n17mr1452308pjo.243.1632349566778; 
 Wed, 22 Sep 2021 15:26:06 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
 by smtp.gmail.com with ESMTPSA id
 e7sm3246999pfv.158.2021.09.22.15.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Sep 2021 15:26:06 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 1/3] iommu/io-pgtable-arm: Add way to debug pgtable walk
Date: Wed, 22 Sep 2021 15:30:21 -0700
Message-Id: <20210922223029.495772-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210922223029.495772-1-robdclark@gmail.com>
References: <20210922223029.495772-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>,
 linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 freedreno@lists.freedesktop.org
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
index 87def58e79b5..5571d7203f11 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -638,38 +638,61 @@ static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
 	return __arm_lpae_unmap(data, gather, iova, size, data->start_level, ptep);
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
@@ -752,6 +775,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 		.map		= arm_lpae_map,
 		.unmap		= arm_lpae_unmap,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
+		.pgtable_walk	= arm_lpae_pgtable_walk,
 	};
 
 	return data;
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 4d40dfa75b55..6cba731ed8d3 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -145,6 +145,13 @@ struct io_pgtable_cfg {
  * @map:          Map a physically contiguous memory region.
  * @unmap:        Unmap a physically contiguous memory region.
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
@@ -156,6 +163,8 @@ struct io_pgtable_ops {
 			size_t size, struct iommu_iotlb_gather *gather);
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
