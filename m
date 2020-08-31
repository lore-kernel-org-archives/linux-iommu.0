Return-Path: <SRS0=U/E5=CJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC15C433E7
	for <iommu@archiver.kernel.org>; Mon, 31 Aug 2020 18:18:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74E2C208DB
	for <iommu@archiver.kernel.org>; Mon, 31 Aug 2020 18:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2QVwZKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E2C208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5B68685EEF;
	Mon, 31 Aug 2020 18:18:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z-qm1x2f297b; Mon, 31 Aug 2020 18:18:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D06D185DF6;
	Mon, 31 Aug 2020 18:18:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD9E9C07FF;
	Mon, 31 Aug 2020 18:18:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A0F6C0051
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 18:18:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C8B2F81F23
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 18:18:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MN3J420ebxKv for <iommu@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 18:18:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6DE3486787
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 18:18:15 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id u20so1043818pfn.0
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 11:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zhfWRuMAC0h3yTxzMXK1MISpXcAtHaGkV3wqBPhKFow=;
 b=T2QVwZKLA97etHb33FpJHEn6QSQxD3HpzujRLfGVewfLlcTmSxoUa5jaafruS/a/il
 UBLpV1Sn+et8B/3xeFIJ+3pqwWeTLocv9rQGophHUKqQZjda00dUqtiS5Kck54a1cnkf
 hhIcTMRudy50LwtKiuskjgQNGwo5Fwhd+/qZERrosbQOBU9g/O3KE/FWoF9sgLuV7dg1
 LwXbypaifzYZzF0hf106XZ9KPRe5bkbk6Pde/NQgzPLyoA1BWd/UXqQP+YrEitW2Sj9D
 Jj68hS/lh1kZ6EWzVHAvKcbE2s9h9HemN01VTCmnbCiEXBFIxKzkT8FTubaZeHkL3GcN
 4+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zhfWRuMAC0h3yTxzMXK1MISpXcAtHaGkV3wqBPhKFow=;
 b=TCjbAFpKv3IPYNg9TivlqHn1Bvl47Sb/vw0u4/2WKiu0PCgUOBbQ3S31vFIyoLmdMr
 3n13t3FymhzSz2yQ0oPuHClG0gOOphkBcCOkJ42J5B6/b6plmfuuftdUrEqe0fApQ6ec
 BQtxLHY8FcAoAyUWaGeq2dUx5/YGonilLspIa/X//eorQzWSXpUoKc5GAQMdiEYr3aaI
 XHxmiAkrVvObg6GNO9pViSPsmaoK1w+mg5Z9qwd94uyRR6uQoJmNUccX3LpN2gUKMoAA
 RXfQp1DsnIKB2XNCS28WAynmoN/x2xy+7Aex0Wv8OJnFXsEW45ZNZ3lUtpeyqys7EMtk
 s34g==
X-Gm-Message-State: AOAM533Epa/TG6gBzHnQxgoCK5vD9y+anSyTJNogFyR8X5y1CxSRoStZ
 QW2rNzHqFeQrTRsPmqwtTheIcpKT0rw=
X-Google-Smtp-Source: ABdhPJxsK2ct8InmpGsFlLAXl+XtzboovwxrqUXOZxkOuMq31W1i210n5cvLZ7jQeDVfw6p5JFtEcA==
X-Received: by 2002:a62:8c4b:: with SMTP id m72mr2203116pfd.306.1598897894724; 
 Mon, 31 Aug 2020 11:18:14 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com.
 [134.134.137.73])
 by smtp.gmail.com with ESMTPSA id y128sm8672547pfy.74.2020.08.31.11.18.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Aug 2020 11:18:14 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v8 4/7] iommu/uapi: Use named union for user data
Date: Mon, 31 Aug 2020 11:24:57 -0700
Message-Id: <1598898300-65475-5-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598898300-65475-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1598898300-65475-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Christoph Hellwig <hch@infradead.org>, David Woodhouse <dwmw2@infradead.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

IOMMU UAPI data size is filled by the user space which must be validated
by the kernel. To ensure backward compatibility, user data can only be
extended by either re-purpose padding bytes or extend the variable sized
union at the end. No size change is allowed before the union. Therefore,
the minimum size is the offset of the union.

To use offsetof() on the union, we must make it named.

Link: https://lore.kernel.org/linux-iommu/20200611145518.0c2817d6@x1.home/
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/intel/iommu.c | 22 +++++++++++-----------
 drivers/iommu/intel/svm.c   |  2 +-
 include/uapi/linux/iommu.h  |  4 ++--
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e9864e52b0e9..43f16f0cebde 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5425,8 +5425,8 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 
 	/* Size is only valid in address selective invalidation */
 	if (inv_info->granularity == IOMMU_INV_GRANU_ADDR)
-		size = to_vtd_size(inv_info->addr_info.granule_size,
-				   inv_info->addr_info.nb_granules);
+		size = to_vtd_size(inv_info->granu.addr_info.granule_size,
+				   inv_info->granu.addr_info.nb_granules);
 
 	for_each_set_bit(cache_type,
 			 (unsigned long *)&inv_info->cache,
@@ -5447,20 +5447,20 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 		 * granularity.
 		 */
 		if (inv_info->granularity == IOMMU_INV_GRANU_PASID &&
-		    (inv_info->pasid_info.flags & IOMMU_INV_PASID_FLAGS_PASID))
-			pasid = inv_info->pasid_info.pasid;
+		    (inv_info->granu.pasid_info.flags & IOMMU_INV_PASID_FLAGS_PASID))
+			pasid = inv_info->granu.pasid_info.pasid;
 		else if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
-			 (inv_info->addr_info.flags & IOMMU_INV_ADDR_FLAGS_PASID))
-			pasid = inv_info->addr_info.pasid;
+			 (inv_info->granu.addr_info.flags & IOMMU_INV_ADDR_FLAGS_PASID))
+			pasid = inv_info->granu.addr_info.pasid;
 
 		switch (BIT(cache_type)) {
 		case IOMMU_CACHE_INV_TYPE_IOTLB:
 			/* HW will ignore LSB bits based on address mask */
 			if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
 			    size &&
-			    (inv_info->addr_info.addr & ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
+			    (inv_info->granu.addr_info.addr & ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
 				pr_err_ratelimited("User address not aligned, 0x%llx, size order %llu\n",
-						   inv_info->addr_info.addr, size);
+						   inv_info->granu.addr_info.addr, size);
 			}
 
 			/*
@@ -5468,9 +5468,9 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 			 * We use npages = -1 to indicate that.
 			 */
 			qi_flush_piotlb(iommu, did, pasid,
-					mm_to_dma_pfn(inv_info->addr_info.addr),
+					mm_to_dma_pfn(inv_info->granu.addr_info.addr),
 					(granu == QI_GRAN_NONG_PASID) ? -1 : 1 << size,
-					inv_info->addr_info.flags & IOMMU_INV_ADDR_FLAGS_LEAF);
+					inv_info->granu.addr_info.flags & IOMMU_INV_ADDR_FLAGS_LEAF);
 
 			if (!info->ats_enabled)
 				break;
@@ -5493,7 +5493,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 				size = 64 - VTD_PAGE_SHIFT;
 				addr = 0;
 			} else if (inv_info->granularity == IOMMU_INV_GRANU_ADDR) {
-				addr = inv_info->addr_info.addr;
+				addr = inv_info->granu.addr_info.addr;
 			}
 
 			if (info->ats_enabled)
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 95c3164a2302..99353d6468fa 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -370,7 +370,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	spin_lock(&iommu->lock);
 	ret = intel_pasid_setup_nested(iommu, dev,
 				       (pgd_t *)(uintptr_t)data->gpgd,
-				       data->hpasid, &data->vtd, dmar_domain,
+				       data->hpasid, &data->vendor.vtd, dmar_domain,
 				       data->addr_width);
 	spin_unlock(&iommu->lock);
 	if (ret) {
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 7cc6ee6c41f7..c64bca5af419 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -267,7 +267,7 @@ struct iommu_cache_invalidate_info {
 	union {
 		struct iommu_inv_pasid_info pasid_info;
 		struct iommu_inv_addr_info addr_info;
-	};
+	} granu;
 };
 
 /**
@@ -337,7 +337,7 @@ struct iommu_gpasid_bind_data {
 	/* Vendor specific data */
 	union {
 		struct iommu_gpasid_bind_data_vtd vtd;
-	};
+	} vendor;
 };
 
 #endif /* _UAPI_IOMMU_H */
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
