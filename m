Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0C73A1DB
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 01:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759972160; cv=none; b=aPbsrJRx9M/XYeOvKXfMxAGfHK0ye7f8fNXLHNUuc86eW+F0lkjrwtBVlIJYNWVcGCBAvMSpJPS3XgLFjU/4bW1yEn7ImodsFDdQrZe/krQ4ZXoppZmy7K7/X6f2rvDsLyfuQ1jfccRqPgi5WBb4T/hYsLI7P/o3B+3o8cSDeQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759972160; c=relaxed/simple;
	bh=91+WbqIZVIOE4sofIpB0yEZNBPRPt4wB+LIzBkBCdpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CTpZYPBOtTqQ6ljLCZ0Y+6jwnlkAi3+iHAu/s3SuouJUcjog7MFDZr6jsw+ows8oqQFYamG7IQyKF1gqcNdH/V4U4CheWHwki8GhSbSRQd9O+LI3d+5PdzYC/kiw/F/Zk02ANDOHt1KSIc3eiyexwoQPoqXC3TFybAp5jMl19FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aashishsharma.net; spf=pass smtp.mailfrom=aashishsharma.net; dkim=pass (2048-bit key) header.d=aashishsharma.net header.i=@aashishsharma.net header.b=mz4UHB84; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aashishsharma.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aashishsharma.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aashishsharma.net header.i=@aashishsharma.net header.b="mz4UHB84"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-781001e3846so396247b3a.2
        for <iommu@lists.linux.dev>; Wed, 08 Oct 2025 18:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aashishsharma.net; s=google; t=1759972157; x=1760576957; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uf6SXDKqJICw08NoDh9xk9/MF/JYlGO1Q1LMu9XTd6E=;
        b=mz4UHB84IsuDp16tGA1fXydVN/6SBdj4stTACUtynrXCfrUcSnt0GlB+aRu51Viprv
         QR45S/zj2GISJLN4GAlj4XJHqnjtbEz/wzE5WhLeKRE7GtZdG+F+5kyIDTsfNeDXOwlY
         9K6daAq4wQ/xNcswDeGd6Bdwjt7GWQQiZR7Qe03iVKqjG13n2yFKM1QCaHcpDKFLGc2r
         W3F4A1GW1jVLi0LwcWo9Ur5NfgwCvzTvosVLAolv42GLINNsrETwfB1dbjsf41xncL4c
         DwdLBtVtY7aU40EijmrouFw6I1XFqzlfD74l28PrLX78I/TOWUbrKfqwSpTH5tRWb5Gj
         l2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759972157; x=1760576957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uf6SXDKqJICw08NoDh9xk9/MF/JYlGO1Q1LMu9XTd6E=;
        b=DTAf+eNqCVv+AF+9iMLzZlbAUb4wKs/IYIJ0DyAK7sGvoKILOpvp2f4xE4jrQBrYt3
         Lv/N+pzC5rQ+m05PSZS5/YbOtS/uKp0/42u4SQRnsn9pyZwZ8wWk1HQX/d62PZaKNFL8
         PRsFubi7aHES6DbXTCihIB5J9FoXd7wRIlIzclAA+59HGC1+fMGGHu10ilCGDf905Wta
         YOcErp5ZSBj0sXEB2DN3efKIkkhftS/9XZd+7Llyly/6j6GhYs4riWB/JJHPLtPz/o2c
         LLEUPLRwT/4vr+BkBqZZiaFLzfaqABAkxGU6pvagxygjfFeqQRZaLzxvFyzMrZV5Z2An
         a/GA==
X-Forwarded-Encrypted: i=1; AJvYcCViedCxqXbnVkARCrFudcU8UWv2W7DiUkinUVWfSvR97b6sDFc5y4pb/oAD35tPjTR6wCPDwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw88gamshOOBYlzsJbVfv1SyNwbg1oI9eTOVODxtkMmDOYYuZWG
	+pttoiLKysceoxBMVNvAhSCbYVEfImE5vVPVzfqKRJ7HLuPXTr49RMfX6r9td+DfEuY=
X-Gm-Gg: ASbGncu3ogMi4FN+C6lsA7jkQi4cHBudJzU63UvlQpvFt4E5ehRvXTXrBPdrOxTs7Dn
	kaOxT0Y26wfXLnJgvQmcbifjKF8Q3ri5WH0iRtywEwSADAd+koTI3egGvKiojO4OyqIkQ2TRJP1
	zNK79xX84BcIIrLLtFU6KE4wisQHZpL09ezgwD81MdWizs54tpIzIxRqk1pPF4RXopq8Hv4kjkJ
	z1+u5QcXskU+ZDC2F2M/4qGm0PgcXv6JdUCp3+RHVhFhsgt/XvP57/7CM8ift7X7vvKAtPpec4Y
	f60xuMIYL0yUXiGNGDF8SmenEa1s+mz0mL/G4FI2IXtMVWz1TJ6iOi8+4BVecv6NX/Nqs2pLmUQ
	4xV3oZSEMB0JtmLQHEKNH4iQ8omBszl5FE64hverjShrHOzj3ygYH4rSkgExi/LrP/CtianlbxT
	RQ80RCfdfjY/5CvVeK+iclOYzrkm48sh8u6p3Ja1rzIX5H
X-Google-Smtp-Source: AGHT+IG8Hn5ffuKifHjR9/YsygBkJPCAVUztAOOOJeVgTKeXeNze6yjiQg5d2xADPv3Ea5hlzzceZQ==
X-Received: by 2002:a05:6a00:cc9:b0:781:189:ae43 with SMTP id d2e1a72fcca58-79386e51126mr5418064b3a.20.1759972156874;
        Wed, 08 Oct 2025 18:09:16 -0700 (PDT)
Received: from shraash.sjc.corp.google.com ([2a00:79e0:2ebe:8:6608:a363:a036:abf1])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-794e33efc2bsm995186b3a.77.2025.10.08.18.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 18:09:16 -0700 (PDT)
From: Aashish Sharma <aashish@aashishsharma.net>
To: Vineeth Pillai <vineeth@bitbyteword.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Dmytro Maluka <dmaluka@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>,
	Tina Zhang <tina.zhang@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Aashish Sharma <shraash@google.com>,
	Aashish Sharma <aashish@aashishsharma.net>
Subject: [PATCH] iommu/vt-d: Fix unused invalidation hint in qi_desc_iotlb
Date: Wed,  8 Oct 2025 18:09:03 -0700
Message-ID: <20251009010903.1323979-1-aashish@aashishsharma.net>
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Invalidation hint (ih) in the function 'qi_desc_iotlb' is
initialized to zero and never used. It is embedded in the 0th bit
of the 'addr' parameter. Get the correct 'ih' value from there.

Fixes: f701c9f36bcb ("iommu/vt-d: Factor out invalidation descriptor composition")
Signed-off-by: Aashish Sharma <aashish@aashishsharma.net>
---
 drivers/iommu/intel/iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 3056583d7f56..dcc5466d35f9 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1097,7 +1097,7 @@ static inline void qi_desc_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 				 struct qi_desc *desc)
 {
 	u8 dw = 0, dr = 0;
-	int ih = 0;
+	int ih = addr & 1;
 
 	if (cap_write_drain(iommu->cap))
 		dw = 1;
-- 
2.51.0.710.ga91ca5db03-goog

