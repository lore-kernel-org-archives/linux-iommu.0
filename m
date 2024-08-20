Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25051C3F14
	for <iommu@lists.linux.dev>; Tue, 20 Aug 2024 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174235; cv=none; b=Imy5H09G/maR96vHbp7ROu2C4YsaVcrUtq8i0CiErXETR8iDKJJz/gYtJKCD22iteOx3pNGoIjiIumr8Rgipa0ofb1PlzR7b+jTY9NR10f7yMFvzzotBg+xDEactDGYxldEFTvi2btfSkFfMK0ixW3J7c8+nbK/UIMeocFMDf0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174235; c=relaxed/simple;
	bh=Jw5M9yB4qk/y8Z61fR27dXsfwJ+4Xe2LxgetVa5nwvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTucmgCi/W77aCS7VOhZp4qZVmoVoa1jYc1hKTfSSM/U0GfevkMwj2hdJjbyOsU3JfY2XF6c5q456PJDSuljrpkJEaSI/RwmEPo/5MA91ixH2A6lgnEMLDHzj9rpkRw1i2+RyQ6arKkT1U/gs80vIi+7qsURwRElrWv+ZIW5VrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4oXFZjE; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4oXFZjE"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20219a0fe4dso29775715ad.2
        for <iommu@lists.linux.dev>; Tue, 20 Aug 2024 10:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724174232; x=1724779032; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2hM9IXnWJCIXdGneHBR3ODZityq3OdYqAzA4dSYz3U=;
        b=g4oXFZjExZYXMJRlzjwWZWWPerkt+6zvc2qFefOIIGzG4cSx70xQ5y2/CbCE3gRb4J
         nw9gKpv6o7gwEwOUAA/W4GTvIlbc22WMTCGLWgvl9ot70D91ggyDM68CzEGUu/cu2xZN
         4hy1D7vx07Hsk26KCUXKAnSAD638V7+ZNge77BQDYg1VzdzhTJGm0JpeyH7eodB8fYQw
         W6I73e2MJyLZudGZniD11oKR5u+KMeMlwsUMgbSs03b/10gowJsrTUlNgc1L++8YmeSG
         uiPbmMqHsaiAOZrtxnQMfjDBPfUahn8T3pXDYzzMX8zqk0SIoDb1bEBZqpOQElVMYvCk
         51og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724174232; x=1724779032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2hM9IXnWJCIXdGneHBR3ODZityq3OdYqAzA4dSYz3U=;
        b=rmVwkfB1blDnG8eqBrgVYMfE035jbX2WIlTvBGs5/tywa2rnw2Pwr3w2cSow3fz/vn
         aaZhAFMlKQ8BDT0SatJYCtNGUEWzH3xWv7KTfnKQ5eP83zJN582xff5eyMVLJ1zdQmCu
         c6KtQC9Xa6sEDWc15D9RlQbVMeHkp+szJo/m7TQ4pw1rA192xXpYgkT4fwQsLAufy5Pq
         /I5qdeQ3mi0VYllgqgroeWapEuLw2xnSDzBIPn1KkS8/BP05QocLiXpq9MBfAvCIGxL7
         pLNd3FATxkiW5f4NqwgDKn4uWgDTcix3pY5ost4HCJCyFd6twoRVjpV45STa9USCgGDi
         CbkQ==
X-Gm-Message-State: AOJu0Yy3cYKJKMVmIZ1rny6SxfOgGPu6cRp1yM99EPCVspZWiYaa630b
	zFrPlt67xQWRp0KRi/NyVHcBFOSrYmJS2SSa50Tfl/ZsZ/VM4zBjpRF+Jg==
X-Google-Smtp-Source: AGHT+IHS+4WBqpl7XNll/ytEzf6YHrvGP09TiR7krwtGsSYQlPFlo0KfVRx52A+btS5AqAL/na8UQw==
X-Received: by 2002:a17:902:db10:b0:1fb:4a57:7cba with SMTP id d9443c01a7336-2031512dbbbmr29303395ad.34.1724174232313;
        Tue, 20 Aug 2024 10:17:12 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:bd02:d0ce:e791:dc08:a375])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0303285sm80066795ad.26.2024.08.20.10.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 10:17:11 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Mostafa Saleh <smostafa@google.com>,
	Will Deacon <will@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 2/4] iommu/io-pgtable-arm: Re-use the pgtable walk for iova_to_phys
Date: Tue, 20 Aug 2024 10:16:45 -0700
Message-ID: <20240820171652.145673-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240820171652.145673-1-robdclark@gmail.com>
References: <20240820171652.145673-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

Re-use the generic pgtable walk path.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/io-pgtable-arm.c | 73 +++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index b4bc358740e0..5fa1274a665a 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -710,42 +710,6 @@ static size_t arm_lpae_unmap_pages(struct io_pgtable_ops *ops, unsigned long iov
 				data->start_level, ptep);
 }
 
-static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
-					 unsigned long iova)
-{
-	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
-	arm_lpae_iopte pte, *ptep = data->pgd;
-	int lvl = data->start_level;
-
-	do {
-		/* Valid IOPTE pointer? */
-		if (!ptep)
-			return 0;
-
-		/* Grab the IOPTE we're interested in */
-		ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
-		pte = READ_ONCE(*ptep);
-
-		/* Valid entry? */
-		if (!pte)
-			return 0;
-
-		/* Leaf entry? */
-		if (iopte_leaf(pte, lvl, data->iop.fmt))
-			goto found_translation;
-
-		/* Take it to the next level */
-		ptep = iopte_deref(pte, data);
-	} while (++lvl < ARM_LPAE_MAX_LEVELS);
-
-	/* Ran out of page tables to walk */
-	return 0;
-
-found_translation:
-	iova &= (ARM_LPAE_BLOCK_SIZE(lvl, data) - 1);
-	return iopte_to_paddr(pte, data) | iova;
-}
-
 struct io_pgtable_walk_data {
 	void				*data;
 	int (*visit)(struct io_pgtable_walk_data *walk_data, int lvl,
@@ -760,6 +724,41 @@ static int __arm_lpae_iopte_walk(struct arm_lpae_io_pgtable *data,
 				 arm_lpae_iopte *ptep,
 				 int lvl);
 
+struct iova_to_phys_data {
+	arm_lpae_iopte pte;
+	int lvl;
+};
+
+static int visit_iova_to_phys(struct io_pgtable_walk_data *walk_data, int lvl,
+			      arm_lpae_iopte pte, size_t size)
+{
+	struct iova_to_phys_data *data = walk_data->data;
+	data->pte = pte;
+	data->lvl = lvl;
+	return 0;
+}
+
+static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
+					 unsigned long iova)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct iova_to_phys_data d;
+	struct io_pgtable_walk_data walk_data = {
+		.data = &d,
+		.visit = visit_iova_to_phys,
+		.addr = iova,
+		.end = iova + 1,
+	};
+	int ret;
+
+	ret = __arm_lpae_iopte_walk(data, &walk_data, data->pgd, data->start_level);
+	if (ret)
+		return 0;
+
+	iova &= (ARM_LPAE_BLOCK_SIZE(d.lvl, data) - 1);
+	return iopte_to_paddr(d.pte, data) | iova;
+}
+
 static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
 			    struct io_pgtable_walk_data *walk_data,
 			    arm_lpae_iopte *ptep, int lvl)
@@ -776,7 +775,7 @@ static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
 		return 0;
 	}
 
-	if (WARN_ON(!iopte_table(pte, lvl)))
+	if (WARN_ON(!iopte_table(pte, lvl) && !selftest_running))
 		return -EINVAL;
 
 	ptep = iopte_deref(pte, data);
-- 
2.46.0

