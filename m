Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251361BDC0
	for <iommu@lists.linux.dev>; Sat, 18 Nov 2023 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZ8XPFgc"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5a7dd65052aso33806647b3.0
        for <iommu@lists.linux.dev>; Sat, 18 Nov 2023 07:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322695; x=1700927495; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1XoIiNxFuF4VYuiH6Quz1F4aXv1fFJNE5bF8jDHsU4=;
        b=XZ8XPFgcC2bLlh6FQLC8oRMLgM58B0I2jKC2+Ir5Poh87VOPunp+vn8H1pEtExIGmc
         o9F0cqxQq5lFPKcLojAA+JPoBJG1q8IEVsqY+PZ28wQmaeuB6d4MEd3bqlF6CnxSfl2t
         giDQbSsK6e3VOv1tXLLJbfmtx3BLbAAlb2Yc7+G5kfhwlYFUdm4JwyCmw2SovwZQy4kI
         Aj3zYxClzFWrtOEyd3FkMLf+nWT/hZk4JlxNfKsnMqISwunL/eeJMN3ijxMeBPk5t4/B
         vlorlBOOM5dTOcxwhhXeLnt95+dB9xc7dpGBrOXy9ED9PUQBfN2of/eB6ZMugh4ZJNiD
         Sm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322695; x=1700927495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1XoIiNxFuF4VYuiH6Quz1F4aXv1fFJNE5bF8jDHsU4=;
        b=JrT9jdINU2609vio7ZLrO+CQ+DB7COxHgbaP55qbmYo8pN+1KRWXUzKcVMrDZPfftT
         2G2ORuDyJcI69QTqUyu+MhA6ojS923IaNs1Fsmx9L1cTsqGnlKo1XYYxPJSMMm/jUatW
         uQrj1yfoX7/U25KZqvguyEDIwDi952hmBSifYCjnDRycbI8+EbKFhLutWhklW5cZATuf
         Mf60S5r4/wdbqKOPfWKam+YSFHXDBrmTuVdBYFYgIJiK0NA7HxoCP7VN8egOzj1PLsZw
         VxMrBM0cWmNa2nzRFMSQgO2e59XRJwTBmW7PkcF+bXOMQz0ukGBwsSOTVV8LAii4YDv4
         3iiQ==
X-Gm-Message-State: AOJu0Ywgjm96ykAjeQ5789Uu7GE08lGn42yzRhBzQdIOnOyGHUETpDZa
	BXzG55Nmz0n92sUHgcG2dC8=
X-Google-Smtp-Source: AGHT+IEY1WAEs4kNKd75UVdANlei8VDfd1gVdWYThj+rx1F0zxh+1GBN8rubfJYMqdp79r+pN+9YDQ==
X-Received: by 2002:a81:8447:0:b0:5a7:a81d:e410 with SMTP id u68-20020a818447000000b005a7a81de410mr3105570ywf.18.1700322695050;
        Sat, 18 Nov 2023 07:51:35 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id h12-20020a816c0c000000b005c5a3f80239sm1158114ywc.88.2023.11.18.07.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:34 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Yury Norov <yury.norov@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
	Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 17/34] iommu: use atomic find_bit() API where appropriate
Date: Sat, 18 Nov 2023 07:50:48 -0800
Message-Id: <20231118155105.25678-18-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix opencoded find_and_set_next_bit() in __arm_smmu_alloc_bitmap()
and msm_iommu_alloc_ctx(), and make them nice one-liner wrappers.

While here, refactor msm_iommu_attach_dev() and msm_iommu_alloc_ctx()
so that error codes don't mismatch.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.h | 10 ++--------
 drivers/iommu/msm_iommu.c             | 18 ++++--------------
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 703fd5817ec1..004a4704ebf1 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -453,15 +453,9 @@ struct arm_smmu_impl {
 
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
index f86af9815d6f..67124f4228b1 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -185,17 +185,9 @@ static const struct iommu_flush_ops msm_iommu_flush_ops = {
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
@@ -418,10 +410,8 @@ static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
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
2.39.2

