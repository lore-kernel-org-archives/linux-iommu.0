Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81305283C93
	for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 05:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759037857; cv=none; b=plok37aLdHA4FLmni95Ir0qaC5E718GiPnHW1FmMDRhBAtwTnelcDaMNE5JNjvIQSdo2ZqbJdELMQ/n05RILb/BnSblU40xYtUIastJ1JNO7NZ7YrcG6fSHb8gCSVcK5xhOT35drCUYLzHAEOso1Ejx3GNTHBCiDy4qblzqywjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759037857; c=relaxed/simple;
	bh=7bjA7esbKLfbNKm7N0blWR/6LMLQp5Zm2JjhopbxQdQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=oWkPI9bs0lo89vllr70TfTzGDom1J4tGEJqtDH3XYAf3sgogy22TljCKyoMq1uookgu/gPh0Hnrtq7zf7C5ig/WqIAPXz74pYmMWYW389N7EXk2u9gmIma0CIk34Pl/934R4EEAs2Hx68CJR3CU9WGtYcMXLt9wWzbmpSN8tJCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=czGH1nmU; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="czGH1nmU"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7811a02316bso1450900b3a.3
        for <iommu@lists.linux.dev>; Sat, 27 Sep 2025 22:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759037855; x=1759642655; darn=lists.linux.dev;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbNj4M1kQE90OhLGOYogUCLDjUCje1Z07F5N02X50EY=;
        b=czGH1nmUr22xYavdy0a+pLPOpHoG+KwX8KfDFTIXpHid9E/J+ojzyLoeNREIthMGh6
         g0fCMghXWEEIJFEkC+PyXXHyQfiZplscfsuMU0rEniE+51if0/tWunc7Up53FkST2QvT
         kEt3FAbwWowtJYTpmrz9X72TyS/tpvwrdUnJfNxGA4b864a6OEbzGbhtyI35hz/V6H33
         RGPPUCdOC/zc7MdrQMmw6e1x7EnAuloH0zXcB1cHOCl9F997Pd3h9MT0hImzbnMuOFZX
         jUbUeVREWxInVGrU8ElGQyfOBEe8c7UW//NwQ7BvIu/csKS9lFm2YK5ChG4yY7iZPPHd
         gFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759037855; x=1759642655;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbNj4M1kQE90OhLGOYogUCLDjUCje1Z07F5N02X50EY=;
        b=pHyJekVwbSMxHMuZRnPLLWr483tyMcwh2g1jr0qPQ8af9QEXHQQH3W+oSKO/4oLKps
         tdPr3hAlQoIZRYuepSYfdXTZiuBY6OPu1lEIGTXgeVQLw0z047YH3VEBYvY9bYkPWCMo
         eYgr+q7DVIvajgnxHN7KDON9GX02VjN/P4bFfNGRG5DmBXWbAUKtO2THc6E0Q1xzP3xx
         dSMSfYU0axoHXfd8sCPUqtYNMTDpzP6hJjz5J4wjCh46Xzo6Wefk7hCLy643LN39xy3L
         SkiKzAi/RM2I69taylQUdoT4KepfuMIu7FjiOPQQ8jkcHJXI6N3/5uzyYTWRlvOvatdk
         LlFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUPZcScx+C5S0V4O9ZZpO/OjvJH2K0/zeJYenYN7uyc95LkibvOoQm1eLzepElueHXinOYdw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyb7UksvVMiDTWd1y6Kd5HQBRpMtnFXrfAvy0y2xRZUh1ZQQb8n
	sOVX4AmxA4SIYHOvgWTFi4WAjl279iOxgPBWpy9DFoJlQPKLmPGz2UzgsyU7ikVHIVA=
X-Gm-Gg: ASbGncu7dNfNDHH4BM0jFjPpCdxQH3O5SG4Y1buQg/BRU4l6ySM9V7cv3NVvsGjXfqD
	RJNuU7RslX0X+rkw2xZBTrzP3NCtqXz7nDpzCBdBnlz5WT/M3NDfSviEEBqv1MunVVr1XxPF78f
	/dY31fy64CXvkWcArYMQ03DbASdTjaFuPIav7BgQm2KGjYVA7qXjkL1oZKxpQdR2E0ynSZY3xJb
	SCgkKuPj/VfTP2I7ODUWldcSRSMgatAw+Brb0nyLIfWd33rhiRK54YWTGfLhuGd4iyiBQlo8I8n
	88Z8y+v4vTbgFHdDyWgaZ76Ub1O2DtiKzEaoTvVavgTDOSyJBZu/E3z5QGMbtn+oJYdUopLFtTm
	DvcQunrQPQws7z+KdrFly4/mLTXa55PQveVDMDvpzsC1pB0GyduaqW95x
X-Google-Smtp-Source: AGHT+IGvLznIbL3Jv9TOfO8LsnXAXyMlehxo0ixhNotX4Er9QmV93PBHdrinkAV7m1NE6PfRgvb82g==
X-Received: by 2002:a05:6a20:3c8e:b0:2ff:3752:8377 with SMTP id adf61e73a8af0-2ff3761c70amr4968168637.59.1759037854607;
        Sat, 27 Sep 2025 22:37:34 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c27d3esm8144214b3a.97.2025.09.27.22.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 22:37:34 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com
Cc: guojinhui.liam@bytedance.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] iommu/amd: Fix pci_segment memleak in alloc_pci_segment()
Date: Sun, 28 Sep 2025 13:36:57 +0800
Message-Id: <20250928053657.1205-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Fix a memory leak of struct amd_iommu_pci_segment in alloc_pci_segment()
when system memory (or contiguous memory) is insufficient.

Fixes: 04230c119930 ("iommu/amd: Introduce per PCI segment device table")
Fixes: eda797a27795 ("iommu/amd: Introduce per PCI segment rlookup table")
Fixes: 99fc4ac3d297 ("iommu/amd: Introduce per PCI segment alias_table")
Cc: stable@vger.kernel.org
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/iommu/amd/init.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index ba9e582a8bbe..77afd5884984 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1608,13 +1608,22 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
 
 	if (alloc_dev_table(pci_seg))
-		return NULL;
+		goto err_free_pci_seg;
 	if (alloc_alias_table(pci_seg))
-		return NULL;
+		goto err_free_dev_table;
 	if (alloc_rlookup_table(pci_seg))
-		return NULL;
+		goto err_free_alias_table;
 
 	return pci_seg;
+
+err_free_alias_table:
+	free_alias_table(pci_seg);
+err_free_dev_table:
+	free_dev_table(pci_seg);
+err_free_pci_seg:
+	list_del(&pci_seg->list);
+	kfree(pci_seg);
+	return NULL;
 }
 
 static struct amd_iommu_pci_seg *__init get_pci_segment(u16 id,
-- 
2.20.1

