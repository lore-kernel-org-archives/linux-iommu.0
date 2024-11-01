Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CC014F126
	for <iommu@lists.linux.dev>; Fri,  1 Nov 2024 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730446052; cv=none; b=aabIsNZoWU87wxtM3Ib2JSwVtw5GF1yZP+ySQvurO0MgKgzd6uNhijve9pmupoKQEC4eAR6DkqTJKVjhx7PIy/HDVEk+L8CnGYAXJDbVHjpDpkuam2LKrr7yoFOr3J+uwW/8CvmNO74qe/FIf6czLK2ZbeHk+vaPnJaAFbGqWQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730446052; c=relaxed/simple;
	bh=vbwCH43v+F+cqZSu7qSklVC9B4S9wbxwdeC8XG9OmJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nEuH/JGIGMO05EOt+GDUnI/UmD3vtuntdqwaPipL6+TGZoqqJYZvB+/Fk0QBWZ3g1JMy+olhsuH+uccAlr6ITSId/qu0PhO4vyoZRaV49jhiZkSs6W67WWBFoMsRByTgsLyGbSRXb0KhWXFayiyIOy81939PvUyZJuJor/B4gG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSMKE7TI; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSMKE7TI"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-720be27db27so1191527b3a.2
        for <iommu@lists.linux.dev>; Fri, 01 Nov 2024 00:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730446050; x=1731050850; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S5K5NRKTjgozwbq4TI9INicCOEVBgTK8ZAiuC+AN6Ug=;
        b=ZSMKE7TI0JWZ7L5jm8etlfzinRKzwlctfKr68U1bvo21hI+JcUTTDku/sSaWWxnRy3
         1h0DBc/DwPDapRMw4Hh1eMrKBP4UYD6Fy11AdmgW+uVUDizQOWLlsgukEsL6aR08FGEc
         GOvSvWskNKY2xawjVzE+/dUaSqlNkv680ptiR2i8gjgkrturzv4lm7rOOY4xoHRI4SbB
         p0+fjSNp5Fzi9bI14NUVCLwgxF8ynDbSI52NXZQ2tU54oo9u1hJAbmhVFzLCqHRfus2P
         6u4kZT2BC5qupg/C2OiD8UxgERpsEj0y6f1vc8JdZ+/+8ONZSzmPi81MguljxCm/p9Nc
         nfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730446050; x=1731050850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S5K5NRKTjgozwbq4TI9INicCOEVBgTK8ZAiuC+AN6Ug=;
        b=gA6G6McMZh0UM2dw0xVCWjtYjzJap9DWIgKmaMKeCmz6t3kUHjkYKMyD+IFuhTIcSg
         4khWWVqTY/4e6N+Gmc22VLoNKSlkoFdyBpLY6FetFzNOEK4yLAwWiTOkMbDcbm41rXxU
         psiLmBwdhckVyEP2sns8m0M76gY1EBo6qrjg++04INTAmnakcG02SCCCVkrToWfq/bSH
         LPToMs6ZVSzSykhDnbvAAIPmWH2TbSHm2d0EgHbIaoWx6klySIjZNHnc7BLRqnfJamWD
         BKTxW30CNSMIL5K+EH9Kvs8mWYeEJj5Z8BkFPFRAx2VEKMYN27AjKf/RJuz1R74sq+zw
         Y4jA==
X-Gm-Message-State: AOJu0YyALGSPcJbtJ6uP9Nk553liTEl9Pr7rMGGZE2qs7Xn6OeIpRpTt
	yh+bzOzHv184T3R4KIw0+vDziGg3EPngfbLWQmtkDtTJ+z7aPCmZ
X-Google-Smtp-Source: AGHT+IFkaQSma+gxqA7eJVlCs+LIM3I5FsMgjCZKd8hGaEuwwFW/ev+Eu/5LoRtR0gowvT/Uxfh8Zg==
X-Received: by 2002:a05:6a20:2d29:b0:1d9:2335:a893 with SMTP id adf61e73a8af0-1d9eece4daamr14904566637.28.1730446049556;
        Fri, 01 Nov 2024 00:27:29 -0700 (PDT)
Received: from localhost.localdomain ([2001:250:4000:8246:8007:bb90:49ad:3903])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc314670sm2162749b3a.191.2024.11.01.00.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 00:27:28 -0700 (PDT)
From: Gan Jie <ganjie182@gmail.com>
To: robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	trivial@kernel.org,
	ganjie163@hust.edu.cn,
	ganjie182@gmail.com
Subject: [PATCH] Driver:iommu:iova: Fix typo 'adderss'
Date: Fri,  1 Nov 2024 15:27:09 +0800
Message-ID: <20241101072709.702-1-ganjie182@gmail.com>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo 'adderss' to 'address'.

Signed-off-by: Gan Jie <ganjie182@gmail.com>
---
 drivers/iommu/iova.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 16c6adff3eb7..a28197b88c92 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -506,7 +506,7 @@ __adjust_overlap_range(struct iova *iova,
  * reserve_iova - reserves an iova in the given range
  * @iovad: - iova domain pointer
  * @pfn_lo: - lower page frame address
- * @pfn_hi:- higher pfn adderss
+ * @pfn_hi:- higher pfn address
  * This function allocates reserves the address range from pfn_lo to pfn_hi so
  * that this address is not dished out as part of alloc_iova.
  */
-- 
2.34.1

