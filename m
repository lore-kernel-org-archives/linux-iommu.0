Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CB82343A3
	for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849510; cv=none; b=GViO94/AyYdSinbp7GjkgjnVl2Q8aGdOD8on7cAgCt2GN3XHw3eRfUXf2AuwkjnGKgEN/zf2o6sv2REzzXNf/MbY+eNLDmBeo9F5I1PR2b3biu1KBR6EnIBBDpo3pVuUNAH8d50lX4okxSzx9ok3Wwx9es6qOyh92MKaExXGVO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849510; c=relaxed/simple;
	bh=kX0r99riBAaE8TpUV/flACMdXCRPn6tHp+x0bux6TeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVsOoqMyg25oxWWgMFUwZ8IiPjHvzGlq9UmIkypz+SAa0kC/PLYpdpdw6iWW1llSUviByumAb03HC4UA5ybB4J2e71FvZHIQCUVDePp6xY0klBICbvQ6hzvafkoECEx5iIQ3UCzned6GbnSir0vxu14JOODvIDSAZ4yD7edPVuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIdNN5tx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIdNN5tx"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2156e078563so43774785ad.2
        for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 08:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733849508; x=1734454308; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ldrDCueE7EtAyArj20F66jLgkk2NNyODodRKr0ilU8=;
        b=HIdNN5txZjT9UXUoB0wh58FUG8yU9PRTCmUAokCXLy+pOeqKMoZ+KyIkOwHjLTv789
         aXgS2IIiBZQA8h486GSpiYwCMl0YpBAvUNxvAinXGYMa3B3mZeFO477ldKDYT27hyZLz
         5j2AqWyNZhKHjKezpeWvpYOOAnp+gi4iNj/0DftFW76l3ZQs973CzN4YbcKMBEE1fu/P
         Kty4p+hFgkG+sLAh6+XnpSwGuhrlQU4eRHzzrJRwLhZAHr2V0HfJNAM2Tlvn6I+tE9cx
         w8+DdnPLjt39jn9Xu/52K4BK49C2NB3f4jlo9jGm+UWFK6N/SKUG0oX4Ju1TkOB7HjFV
         8T1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733849508; x=1734454308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ldrDCueE7EtAyArj20F66jLgkk2NNyODodRKr0ilU8=;
        b=ce+zsQOccBSactsMfDC2Si0QRZKWZxTRq7ZDfS92pWPiQ8NIA80TheWQ2jCvxB7ein
         aBJLkNRgJFiQKQMaD4S4m2expptnwtw2zrchjoWA9veY+JugdYG6X818RSkKlp8SCG4y
         dnafHcifnhQcXlFa48gWvDRxvGUKm3ZZmxZMx98Elg2+AV+EcgR1zRa6CNh6sa845IFB
         VdXQJ4afEXluOBMx7uEvw59HwQYTm9vEnhtaFyiDx5Ez4GRsKukpcuef8og8hyJpe61t
         ifXNL+UkgdABi9KZJb0ef7sHKpDJFu9ggdLrhoP5GQrsi88LLZwr0hGwY/58B35RbjtN
         RkbA==
X-Gm-Message-State: AOJu0Yx339ILquF7RfFsmJaZQmpw4QuNqQtFdJiiX5tF8X6za/lXVAoE
	oZAskbnqhVWxxdu+tmpD7SOf4XuHE3QA22Mh4eHAAlZTLctoWqbwddemrg==
X-Gm-Gg: ASbGncsBrRNWwC2T4v5bUp4WW0WskjEu65Jd9oVAg6psOu4pF5eukfB2nYIiZonMw+W
	W2J/LX1mpiekrzCkK9YWyT56Kq0zEYhWIgJo5l/jC95umm5wBb1PdMA99tb/1YRlJ07ryM7EXIa
	iho98vRaDWxcwosY93nvK6DJyBRv8pMKFDX8Hm8MQhBtSskLgzPMblhVOTDsurvIdnovF2pECa9
	9GGW7uRs5qBrhYJCpJ2nQICbDbhvHRb2SYPblpvT+2GF6lDWYFgtwuPGRQJ8FVbEqD/OhW+nFzm
	VQfEPA4SKkm8nRkX2+qNjlT4sZS7
X-Google-Smtp-Source: AGHT+IHS0LaxpkQDW28nSbT1wx8gEP6+R1uzXYbRGTNeVekseOAHAqPvkFtV0qVh9HekmfV/jSF44A==
X-Received: by 2002:a17:902:d2c5:b0:216:725c:a122 with SMTP id d9443c01a7336-216725ca362mr51995685ad.19.1733849508260;
        Tue, 10 Dec 2024 08:51:48 -0800 (PST)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f093a3sm91911265ad.192.2024.12.10.08.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:51:47 -0800 (PST)
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
Subject: [PATCH v11 2/4] iommu/io-pgtable-arm: Re-use the pgtable walk for iova_to_phys
Date: Tue, 10 Dec 2024 08:51:20 -0800
Message-ID: <20241210165127.600817-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210165127.600817-1-robdclark@gmail.com>
References: <20241210165127.600817-1-robdclark@gmail.com>
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
Reviewed-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 74 +++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 7e9c0f8ae138..88b128c77893 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -712,42 +712,6 @@ static size_t arm_lpae_unmap_pages(struct io_pgtable_ops *ops, unsigned long iov
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
 	struct io_pgtable		*iop;
 	void				*data;
@@ -763,6 +727,41 @@ static int __arm_lpae_iopte_walk(struct arm_lpae_io_pgtable *data,
 				 arm_lpae_iopte *ptep,
 				 int lvl);
 
+struct iova_to_phys_data {
+	arm_lpae_iopte pte;
+	int lvl;
+};
+
+static int visit_iova_to_phys(struct io_pgtable_walk_data *walk_data, int lvl,
+			      arm_lpae_iopte *ptep, size_t size)
+{
+	struct iova_to_phys_data *data = walk_data->data;
+	data->pte = *ptep;
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
@@ -780,8 +779,9 @@ static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
 		return 0;
 	}
 
-	if (WARN_ON(!iopte_table(pte, lvl)))
+	if (!iopte_table(pte, lvl)) {
 		return -EINVAL;
+	}
 
 	ptep = iopte_deref(pte, data);
 	return __arm_lpae_iopte_walk(data, walk_data, ptep, lvl + 1);
-- 
2.47.1

