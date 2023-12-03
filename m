Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF501CF94
	for <iommu@lists.linux.dev>; Sun,  3 Dec 2023 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tz6YZ5vq"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5d3efc071e2so27867337b3.0
        for <iommu@lists.linux.dev>; Sun, 03 Dec 2023 11:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632022; x=1702236822; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vguNRNHZWUrDOSu/TVKVOPIB86L1io3LlGEpKJkKhiw=;
        b=Tz6YZ5vqD5cpR4LPKgvBdf2ENl/yBzoRvVHo3VqILDg4n3Sw1fT00goaT3BOOx1Vgz
         gGpOaU7Hw/68DmnYvMX5/Mlw2Z/eLlpJsNiEq48IdinYP1C6GE73kMXj6B/Rps63n9qv
         SteKhqAYeLdWe7zz0qCECQg7m79vmWTGpvqiUiEY3gG9J3npSSkQI6baozN8zGdfUeli
         1FRG/6fB5WzHDqGC16kqGIl3RCcyaTuLaHK0xYJGdi41FRsmL2g5JMBdv/u0Q7joWqJW
         bf9hJ/AwAVOIweEQMfS7FnSLdrfo8qw38aQp7suOX9W/nJrg6DNsDAJEH8zUkU5jJOU3
         xGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632022; x=1702236822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vguNRNHZWUrDOSu/TVKVOPIB86L1io3LlGEpKJkKhiw=;
        b=W0WTlcfBArMs33+bWpiBVloeQYm3+w6oqMb71Y/+caa6JjV8T470bWkb4t8zgArxkq
         Nzkn0FbuJYwN024V05ZjYwVtJoeVPkCoeHAk2yqfvb6hPlfA27Yqy8rlE+8ddheYjjF2
         tnVVWefQ4lasIfuffJjd/gUXCK0efE9/hCn9LUZ2W2hhH7rJdegwIdVnHywHIN0FRwhx
         OSoNZMTlsm9K0PW3xl6EaDEvUwoSREqpxXPP+chYueRwZXtxWsIBD7238VKOI3EOn+2f
         VC6ktvnRIzMBPiQnHnqE0W0lb6+g9j9YASWU34T6nnqaZmp3VOykAWDI9MGShphaALqI
         90pw==
X-Gm-Message-State: AOJu0YyqfzWQ8lkYeo9zgH2VznTqn2uvzIEFRj7SPgRn3PTHxKRNCHV1
	fEVzRxRAa4GJXwhstCu9120=
X-Google-Smtp-Source: AGHT+IFSv+65IiQiN8WCGcLVQvQiuR6hHdW5qXQ7nf6ECXpLpXmmUxxmzvhwBggjw2vBz5nonWlXlg==
X-Received: by 2002:a05:690c:3745:b0:5d8:5fad:8dcc with SMTP id fw5-20020a05690c374500b005d85fad8dccmr507589ywb.29.1701632022542;
        Sun, 03 Dec 2023 11:33:42 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id m190-20020a0dfcc7000000b005463e45458bsm2765478ywf.123.2023.12.03.11.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:33:41 -0800 (PST)
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
	Alexey Klimov <klimov.linux@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 19/35] iommu: use atomic find_bit() API where appropriate
Date: Sun,  3 Dec 2023 11:32:51 -0800
Message-Id: <20231203193307.542794-18-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203193307.542794-1-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch opencoded find_and_set_next_bit() in __arm_smmu_alloc_bitmap()
and msm_iommu_alloc_ctx() to use dedicated API, and make them nice
one-liner wrappers.

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
2.40.1

