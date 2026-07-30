Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB38331ED2
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785435177; cv=none; b=Lf+6PbXCJelrrmr3j/H88UqYIkO8NAvw3i41sR4HlwVIZswPeENAFP6nAJg1coiXvGI/CMRAReLaKqy+iqNMhQ+DtK92Kwy9OwjPRHKw4pzB0e3dwJAysAdw+p2sPqF2w+cKY8rzGLhnRBHMECpZNExkzR5d7fGOzlpuSAWEVgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785435177; c=relaxed/simple;
	bh=nNTDXVztBRh+NwT9l9amUlw0+PAL2fZK5osZZO569lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfwaSujEFNdv5Rtd4nhHVkXVXf99R3qXyB7HHIfaq8MkX85r2MdbOhijDGGfcAKAV44I9DSpfzhxAiyTdEysVU6TPHyYi6nFei62+q6KrrTmOS+NayiOzwcWz+1Nii7sTdwOzaIFNU17fg+TcN5/ODhFgUr6ZirqiVSeaR9gbDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+lsRntB; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+lsRntB"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so73980a12.2
        for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 11:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785435169; x=1786039969; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JjZRp1nhDTDgCD+T8te9v5HqJu4svj9GdgkIOM/whNM=;
        b=k+lsRntBtmsp6zXnsfX99HX0woSCEXV203TootifmGpY9m6GKyXv3mDMV9WOyehNO3
         vWm/8ZJNP/VFOzh2p6gm3HYuj3HSJrn3Z3jhJu+4CnHB90ccXUGp9zOREcsLqKfrydxf
         3SlY+CJJ3Bvwi9k8GEZvKXB2rQ6vkrFSZgsIFEPFBtGzdwJO+ONoG7tIjRhesQ3aCkFz
         9rPXLBO0vzsUy3FFXlng6eeCAcnkIRp3i088JOajM21yhT1QImGsqfiMBDhzjDbs/yNv
         QFNfSxNuBAoF8ujLCjbouxFZXAWPgC3rBmXrAD9aCmImv9FfM/f0g6LzvKuBuUwnm/E/
         aU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785435169; x=1786039969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JjZRp1nhDTDgCD+T8te9v5HqJu4svj9GdgkIOM/whNM=;
        b=LqrSq2qdiS35mjen9eFk93+JsOeClrdEaGmGqlJLxmqzkLAZo1Ux/E9HiD8dXfoUfF
         Q/ONmiILl06IA/uHsNHFwFbc2nunHMIdmZIqR3C8EaCqE8ORyF/lMi8Yg/JyTeb5uURn
         R+5TrYJOCizEdsrGxMwk9rWQPg5myLS9CSvZhWAA70jqwOgSJvmS5H3fiEoEg7oLQ+lA
         zEbn31/WC8L3T8ch94XXr4GesoMFBOLhnu/EI8LHzurTW/JP1xczML1st50HitBYEqOD
         Y2oNUeXZZgoclPbHphRNulQ048y4wPi5SHe/Z981E1DmoeFPAmq7PQ5qZ54xnj2pvwAh
         a3xA==
X-Forwarded-Encrypted: i=1; AHgh+RqZfBBdIg7vO3feIl5uPzOMN/BmRM7EPxGphQdTXMaiUWZ3gcAe85SL9Xz2ugXpRQi5cTfHUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAU8O44QF4mpirbKSmvinexpx6Z+2adgBL3BLNlZyyk5o5rOgn
	hdTk3WJeVhAUVTtatvR69PnIQ9+Q94EQZdj9oocLknfh0vHLWaM8pXh0
X-Gm-Gg: AR+sD13Z4OY2Xch8oKZFvfCzI/31KKYHwpCZzcv94gkr3xMEM2t59ujMgacLopjPHk3
	5iS7VEJqnChei/nMYu9XMEStv9O2c9pRxpMUpILVX4NEwuHTfMQ29eggUAEjZ+IR8j1gtd/HiG5
	ow1i2wx2N3vM7ApPhXQFkwwIbPEEcuJHdSub3vKRyQHmdT0h/UUG+uzcXtPxe0jiRnaiT9VnwRI
	cxoaZc9sD3PQyLUyOZezqXngUJytvf5m6W0E81GAViIAOCRqO28TBIq92Zyvd/dX3mJBhlqEb4E
	Bv+q8Wl3FBEV/4yvCT6GI1wN1Orn6EL34QW+2rsfQkcVI9ZApy9l5S4651r+OVMcgpd1Y0PGe0A
	SHEWpY/2aLfv0PapHXarSPmQQAicf7BcBNeYy/yL+YmhLxyAQyYOuA/3WZGffAlYFyMLHk0WnMg
	qVAGqVRMxO6bCKH/1hjnR3q1gvXs/eoTbVYNvZEYwNtyYXLiLf3KmGo5xdcsRl/jk31+9Rik0IE
	GEnHnJxhCb4DXFV6nT0rYFJMWDrXLsrMaFQmPrBfstONixSG9I7HYNFRnQThP0=
X-Received: by 2002:a05:6a21:3397:b0:3c3:9835:e75e with SMTP id adf61e73a8af0-3c9008f9f05mr3638201637.70.1785435168997;
        Thu, 30 Jul 2026 11:12:48 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (131.197.81.34.bc.googleusercontent.com. [34.81.197.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b124e4sm21998197eec.6.2026.07.30.11.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:12:48 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: will@kernel.org,
	joro@8bytes.org,
	akpm@linux-foundation.org
Cc: robin.murphy@arm.com,
	nicolinc@nvidia.com,
	cychu@google.com,
	hhchung@google.com,
	amitamishra@google.com,
	marscheng@google.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 1/2] iommu/arm-smmu-v3: Replace sort_nonatomic() with sort()
Date: Thu, 30 Jul 2026 18:12:15 +0000
Message-ID: <20260730181216.2709088-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <20260730181216.2709088-1-visitorckw@gmail.com>
References: <20260730181216.2709088-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The number of master->num_streams per master device is typically very
small in practice. Sorting this array takes a very small amount of
time, so there is no practical risk of triggering a soft lockup that
would necessitate calling cond_resched() during the sort.

Replace sort_nonatomic() with the standard sort(). Since this is the
only remaining in-tree caller of sort_nonatomic(), this change paves
the way to eventually remove the unused sort_nonatomic() API from the
core library.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Build-tested only.

I'm not really familiar with this driver or smmu internals.
Based on my limited knowledge, master->num_streams should be small
enough to safely switch from sort_nonatomic() to sort(), but I could be
wrong. 

Please review carefully and let me know if there are any cases where
num_streams could actually be large enough to cause issues.

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a10affb483a4..dcb6be2df95e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4047,9 +4047,9 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	}
 
 	/* Put the ids into order for sorted to_merge/to_unref arrays */
-	sort_nonatomic(master->streams, master->num_streams,
-		       sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
-		       NULL);
+	sort(master->streams, master->num_streams,
+	     sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
+	     NULL);
 
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++) {
-- 
2.55.0.508.g3f0d502094-goog

