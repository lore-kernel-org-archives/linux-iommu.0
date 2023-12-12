Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F130915AFD
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 02:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns3dZ/nZ"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5d8a772157fso44761747b3.3
        for <iommu@lists.linux.dev>; Mon, 11 Dec 2023 18:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348102; x=1702952902; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRgDjRdiQ3wMwyUy9FFnN6Mv3fA6CH+t16OZs0Rwzhk=;
        b=ns3dZ/nZKnSAFMnOKOmhPoEQxBxemg6QpF5wbf99XliannBk6QZLkncurVs2XMkU5J
         JEOsO9n2mWAlwgGYYhL6WQrhqKPJ+/QW8iMUXV6Oubu4NlP2SFNbHkZEEe3wUUfotEu+
         gFHqQeQ7JAhqDMDpNFnxgc1cXDq0jM39eZT3ENsK9Gyue96kCQwozeklEWu0Gr8Jdydf
         j9AJxqmmLi0VKhtYEF5u5CXBF43MnBIzQBFkM9zq5tamOLHdvLi3YSiCf4Axs3jf0TAF
         cUaWm5QxG8nCvdYY7pKsiGPSPX4X5KttKpvFV6hVNeuZnq3ckXJdvFRH0Y+6oYTGc0YH
         j1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348102; x=1702952902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRgDjRdiQ3wMwyUy9FFnN6Mv3fA6CH+t16OZs0Rwzhk=;
        b=pFT5KYiG8HVf4XtGE8hQDlsG5dDi655IutTq3faho0GqPubtoMQV4hHpVCPcxjV6cq
         CekwUxDzj8gcqPYG8dnp4VGlcuUpABYiqnwkynqmwELFYnzfJu/dVuFC53ibWfr9DJ8g
         qNX91LFYoujlKwXuU3DE14DUQlUkamlTxd2ajlX3+BeBrw1G0URE2ZhY3Cxinj41+UHM
         cdqMIylsRuUNN04Ld/T3ibFaGn4nnhJozKTWAlXyjk/CXFSgnT+06+ozo7/rScRI2jfW
         Z4mJcuYkZZex35hnl0IEuewSRcY+dYtVSou4e6H5fg96AQPY+7JelEuO+FzWqoD/oP2m
         h9Jw==
X-Gm-Message-State: AOJu0YyUI2BYCzsLfc22nmih3JSh6CSE+guHOob53VUZRAmwvNj8lM/m
	mfr2XfHDbLzmo8I6sCS1i+M=
X-Google-Smtp-Source: AGHT+IGMwceB9+j1udge1W4cal0kKbCSQgG5Yh316/EdKS360cK7bZCjDy7dckWdtEwCMNE+mk/JJA==
X-Received: by 2002:a05:690c:2c0a:b0:5e1:8405:8b3e with SMTP id eo10-20020a05690c2c0a00b005e184058b3emr1116070ywb.44.1702348101890;
        Mon, 11 Dec 2023 18:28:21 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id ff9-20020a05690c320900b005e184771849sm519809ywb.93.2023.12.11.18.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:21 -0800 (PST)
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
Subject: [PATCH v3 19/35] iommu: optimize subsystem by using atomic find_bit() API
Date: Mon, 11 Dec 2023 18:27:33 -0800
Message-Id: <20231212022749.625238-20-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212022749.625238-1-yury.norov@gmail.com>
References: <20231212022749.625238-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify  __arm_smmu_alloc_bitmap() and msm_iommu_alloc_ctx() by using
a dedicated API, and make them nice one-liner wrappers.

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

