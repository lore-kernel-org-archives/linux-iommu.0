Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDE7C47423
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 19:22:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6054A20878
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 19:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptxBmYGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6054A20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 386A786AF4;
	Thu, 24 Sep 2020 19:22:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YsmIpHraSRiY; Thu, 24 Sep 2020 19:22:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9FE7E86AD1;
	Thu, 24 Sep 2020 19:22:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82F3CC0859;
	Thu, 24 Sep 2020 19:22:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B121C0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 19:22:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7B1E886B8B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 19:22:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x3V59lYaRKWn for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 19:22:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
 [209.85.216.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4B02386AC4
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 19:22:42 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id b17so287232pji.1
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 12:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vUY73uGNXRdGBf6OJopom4ParHouExoa+/+ufyGwMqo=;
 b=ptxBmYGFgH3xB1TJjICkTimwjv9TfGzgR3lEbkBJVXxJGuGBwNq2Lgsc89eXxFqOCW
 Nlq89pFTqkKtCGf9LklXg127GoIbAX7wT41jtrk1RqTNV2k5UTPw0Pwxc9nB6C72l6rl
 uSyeA/Xjn4X+THjEdKsMllrqEFaImTdBHL59G4Qud+0rsvgOnHkWOErsLA7vXRPu+2+r
 tA9EmTqh3m9giLnrpHLLjuP+Rm2reKLe95Ed875a/Q1EX77oVeqlptcMMYMT3DSvx5Te
 CscNUbYJQaA8UXWbRokni4ehziS/rCE++WUYgkgKT0hZIYdrUEa2htM6cF1GfmaEscem
 evPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vUY73uGNXRdGBf6OJopom4ParHouExoa+/+ufyGwMqo=;
 b=FgncX7CZ7T10l2lXRepr3gJkkN3lvHIWUr6n10x6Itf4GOMGWWFik/uSff59Ft/I9d
 xYOvDqR/7YoPnRUqGvtRPyWj7rJ+DZQfhd2tSuehKPBPTWsATsWL6h3bQZ0lMAUSVLWp
 xXzWSDfnAWOQAo8bJedbao9lElqOp9fdb9PR0m7XxNKa7pT1N+Sj7sH0fZ1mamLPEnR8
 TV/yVYrYG6XeEye2OGdgBReD9sXkFgq5AxLqiUF6JcSZt90Kx1m2WRqwIy5TEra1qdMs
 23yWZkwzbQ585LN8CtVQKMF6i/0vM0UNwutwugwifsx1FBUMK5j5mOMfGc7XQwPbzSaO
 qAuA==
X-Gm-Message-State: AOAM530tO6Mh8SBR9qlFz2TbveMKG8q5wCPmLxjZIq0uD/b/6xxYcG5q
 l7jFId/kdl/Du9K2P02uEwWw5Lt1YFY=
X-Google-Smtp-Source: ABdhPJyhtA7fgREwj/cxIul3PhAArWJOGETpFvTcra4sXh19Ei0O57vlvC/sYw37rVMC81ojQtcnQg==
X-Received: by 2002:a17:90a:738d:: with SMTP id
 j13mr431808pjg.114.1600975361618; 
 Thu, 24 Sep 2020 12:22:41 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com.
 [134.134.137.73])
 by smtp.gmail.com with ESMTPSA id o15sm140918pgi.74.2020.09.24.12.22.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Sep 2020 12:22:41 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v11 3/6] iommu/uapi: Use named union for user data
Date: Thu, 24 Sep 2020 12:24:17 -0700
Message-Id: <1600975460-64521-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600975460-64521-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1600975460-64521-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 linux-api@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Yi Sun <yi.y.sun@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Wu Hao <hao.wu@intel.com>
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
index 87b17bac04c2..461f3a6864d4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5434,8 +5434,8 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 
 	/* Size is only valid in address selective invalidation */
 	if (inv_info->granularity == IOMMU_INV_GRANU_ADDR)
-		size = to_vtd_size(inv_info->addr_info.granule_size,
-				   inv_info->addr_info.nb_granules);
+		size = to_vtd_size(inv_info->granu.addr_info.granule_size,
+				   inv_info->granu.addr_info.nb_granules);
 
 	for_each_set_bit(cache_type,
 			 (unsigned long *)&inv_info->cache,
@@ -5456,20 +5456,20 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
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
@@ -5477,9 +5477,9 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
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
@@ -5502,7 +5502,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
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
index b42acc8fe007..5946779ac1f9 100644
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
@@ -333,7 +333,7 @@ struct iommu_gpasid_bind_data {
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
