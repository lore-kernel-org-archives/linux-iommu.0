Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C2E1C2323
	for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906285; cv=none; b=gvkm6sTCVi8g63CFpFlALwePgbZwaJoLPltfmZdug5jd0lZ46+OFvoQe5sqAtf9L3U4vdc/r6mhSj15WxNOD4CLb0T+5uS34jZ/3mf7h08eicgZ86vZKkUoMxBjMEv8sHkjXXv6vkoT6nGMFtDn3vBre8sNVeYBaYIGIo5MbJvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906285; c=relaxed/simple;
	bh=G8SsYV8VKhk+1kr8G6gSzRlXENvMiu+vYX15iq0TH0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLChtDLWWHgwWu1QLR7jWpR/z68QZD3uCg7NR7FEDp2ivPp9U48uGI9VytDdZ2I133KZopKKMXTflGeKidk4WShJ0XNpW7+ARQireikVth6ZJQFnFfD0Zeda8pIP7x6wN2bqDhV4bXB848AaL0OlyFVwPbFYLhkqt9LUlexY6u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=By5z7liQ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="By5z7liQ"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-701b0b0be38so1100098b3a.0
        for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 10:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906283; x=1719511083; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voUtFDbfyXxYSLuhMxY/5Es179PR05W0y6qbv62GFHo=;
        b=By5z7liQpVQPVcqEsqrJyMSaFIVHo/Y8m4twS3lRJUDG+quWr5mC5oh+vgSZ+7E/rU
         WeIiqhL2Z4r0P8Ik9sjkFCh0fCmtkcfmIKT6/PtO7Kfm1KWyxrvgO2CtYVskSOimh1kD
         1NqTI2csMbuHD8SgUfg2t9TOszhyJjylDYQZQlLvhur+0Za/OrieKf9h8LsX7iixO99Q
         eWmHyh2a5TA0dvsLaf++eWLTH7+mUfu3kPiCaK+kOTZu1ESmqkYd26ZOb9Cxns7TPUrM
         igSGkK8V6TtYXfyjQd/38MrBuWk9i0rTaAioucz0+UcLbQBJUI4Wn26agZ53B6aKVsZw
         igdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906283; x=1719511083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voUtFDbfyXxYSLuhMxY/5Es179PR05W0y6qbv62GFHo=;
        b=KlQ95b/7sSrDf2c8wLgiNHWcA57hgfbxb9sQGILmLNkCZnfetjkJPjhd4HQjAUUHGP
         zJ4FTSpdsdBcgDiLxBuIjkf6TgF44npWmqKuYHODSgaAso6HYV9Uz87TbCszZVGKFvP5
         5HaBSLPO0+QhdWSNipfnzBqEkq51/9DL4W6itnv8iqFGCt1DJDHJsheqHZKYVZTCgOSN
         gXDS3YpQU/ZuAK2uwoD2U+Jw47VCofVozDpe8EJB0H1+0tS5PhQYAPMPQq4vADt10usI
         ZG3EjjpGkUgaiVUC7p7Lw5m07Za6jk3RlZ6Tlanjfi1z3sSxJjpwSrD0lyco8IH5mxid
         4hFw==
X-Forwarded-Encrypted: i=1; AJvYcCUa6dFHyv3zNSLWUwJ2xtrfT3odiEnTeQ2KnuaBc8SShJjVxbULYOIVgqSqNG7L0qJRxN7MwJwUmybZr48RoIMns3Y3yw0=
X-Gm-Message-State: AOJu0YypcG/f2D3yuj5DM8YQoKBRRYBitvTL3jgKxtTAf4tfToNX64b5
	WQnZPam8JGIP2izB//rx8Ajh3cTWZ40d5AGylRVEyBmFEkrKlncy
X-Google-Smtp-Source: AGHT+IFuFY8WsrUaBevsclcxusM/Sc7ZvIAfPxrnCGbXlGrdTSyKJ0ahnS/qbGoRPvPpSuP7Wt6hDQ==
X-Received: by 2002:a05:6a00:4d07:b0:706:3514:2d6c with SMTP id d2e1a72fcca58-70635142dd9mr3899791b3a.29.1718906283409;
        Thu, 20 Jun 2024 10:58:03 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb6adb5sm12628100b3a.155.2024.06.20.10.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:58:02 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v4 19/40] iommu: optimize subsystem by using atomic find_bit() API
Date: Thu, 20 Jun 2024 10:56:42 -0700
Message-ID: <20240620175703.605111-20-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify __arm_smmu_alloc_bitmap() and msm_iommu_alloc_ctx() by using
a dedicated API, and make them nice one-liner wrappers.

While here, refactor msm_iommu_attach_dev() and msm_iommu_alloc_ctx()
so that error codes don't mismatch.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.h | 11 +++--------
 drivers/iommu/msm_iommu.c             | 19 +++++--------------
 2 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 4765c6945c34..c74d0300b64b 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -15,6 +15,7 @@
 #include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/find_atomic.h>
 #include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/io-pgtable.h>
 #include <linux/iommu.h>
@@ -455,15 +456,9 @@ struct arm_smmu_impl {
 
 static inline int __arm_smmu_alloc_bitmap(unsigned long *map, int start, int end)
 {
-	int idx;
+	int idx = find_and_set_next_bit(map, end, start);
 
-	do {
-		idx = find_next_zero_bit(map, end, start);
-		if (idx == end)
-			return -ENOSPC;
-	} while (test_and_set_bit(idx, map));
-
-	return idx;
+	return idx < end ? idx : -ENOSPC;
 }
 
 static inline void __iomem *arm_smmu_page(struct arm_smmu_device *smmu, int n)
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 989e0869d805..4299e6a5b2ec 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/errno.h>
+#include <linux/find_atomic.h>
 #include <linux/io.h>
 #include <linux/io-pgtable.h>
 #include <linux/interrupt.h>
@@ -185,17 +186,9 @@ static const struct iommu_flush_ops msm_iommu_flush_ops = {
 	.tlb_add_page = __flush_iotlb_page,
 };
 
-static int msm_iommu_alloc_ctx(unsigned long *map, int start, int end)
+static int msm_iommu_alloc_ctx(struct msm_iommu_dev *iommu)
 {
-	int idx;
-
-	do {
-		idx = find_next_zero_bit(map, end, start);
-		if (idx == end)
-			return -ENOSPC;
-	} while (test_and_set_bit(idx, map));
-
-	return idx;
+	return find_and_set_bit(iommu->context_map, iommu->ncb);
 }
 
 static void msm_iommu_free_ctx(unsigned long *map, int idx)
@@ -418,10 +411,8 @@ static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 					ret = -EEXIST;
 					goto fail;
 				}
-				master->num =
-					msm_iommu_alloc_ctx(iommu->context_map,
-							    0, iommu->ncb);
-				if (IS_ERR_VALUE(master->num)) {
+				master->num = msm_iommu_alloc_ctx(iommu);
+				if (master->num >= iommu->ncb) {
 					ret = -ENODEV;
 					goto fail;
 				}
-- 
2.43.0

