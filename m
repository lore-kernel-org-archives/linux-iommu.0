Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B3B192B75
	for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 05:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762838434; cv=none; b=rn1QAeLMSreX1b4LnCwmkXWWpZXjaozG4rhi4wFXV05NoOKPvMfxquq4nkwqesg5kinXCnNvS1KmWLR0Bz8PHJPocbSLOt2TNNQwpi+Aj+AbHiMHoYku65HrBzzACsswYelIkBgVATmjh6sexNJoMcZtFh9polr/VUcLl5bmULE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762838434; c=relaxed/simple;
	bh=MsGZR4CIigNxmVNtsBjkuslmczZOe3BUpgUHKm0cYkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jibfWKKaLvgI2FEv2Hj4ouphIKVKqs09WP5WZoI9MxlfNiHXOSG3pOsIiXmQ7tDflEBUPbpfdGq28D/AibfAvpT6UhAM+dS21LGmRRK1xM26m1s+EHKgO5sjkPQ6JSO2cAQHtxswT2a2tP8uvxvJgb3d2NIjw6fN4ZpXq3L8Md8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aashishsharma.net; spf=pass smtp.mailfrom=aashishsharma.net; dkim=pass (2048-bit key) header.d=aashishsharma.net header.i=@aashishsharma.net header.b=JkTswQgk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aashishsharma.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aashishsharma.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aashishsharma.net header.i=@aashishsharma.net header.b="JkTswQgk"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297d4a56f97so28636335ad.1
        for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 21:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aashishsharma.net; s=google; t=1762838431; x=1763443231; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x4H4gg2Lcobibmd978yXCBL5nbfbalKNhdhPRuAkriM=;
        b=JkTswQgk1UO39w/awG6Sp0CA6qUaiBPD1rxM9Yr6XJ+4wEQyCTHYWseliEehbr8m4S
         5NsVnTm1Nr3UjRZePqzxAmgqE7KOEFweOgrXSHCK1zUzMDWMvYF/IN8/rF/SXXBLaMLI
         oVRtjDZ11Lf9/NFM9IpZlmI2SQQKtl2itHhExgNvgMPc9myEAw9OIffP/Pzva8I3BpD5
         y35sCDIsdkLkYdPfx/0mGRlAh/rGHC9phBhJyvDNP2L66SVQbJP0UtzqUPXV7NNLLC0Z
         9rsBTh5tfBmIeu05yic9oUJjuZwGzj22kBlGtIxJteOJTyPZuXxYkl1O41MUeAM6cSbL
         YOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762838431; x=1763443231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4H4gg2Lcobibmd978yXCBL5nbfbalKNhdhPRuAkriM=;
        b=aQ9g7cCCIIjJ9lqRgZS+EjfIVed/c9mRouDJhtZXw9qKnyd1TnX967xHq+PG1ZZGM4
         w7L0WLA1BqPEZ/uqGiRZmMPVeccq+AlzlgN9VkJ0yWMtGVWR8szBOn1egWjn62ioTD7b
         VmH43Rvgxrv+cL5+ytROu2BMGwOUzyWd7TP2ut4ibf6wB3uG1WE9q9Mh1yJoLm2A23iU
         +AooOOe6EW0OF1jdnP44Od+AhhvYPn/kx9PfdeJhVyHa/8DS50aY4W2tlhx0vhJTyeiD
         U1qLpHyE9ptxm6htlIhzcwpabywFr700gFOmNOWeIcBcncOuD95wjq/pw0nIu2gKrgUw
         muMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjhjUfXzXiRQHFgdyvUSvz2lOPx3bU59QW4mT1vXxh+pKnZOu1uw8PiYCwp5W+I2zrJRu70g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwZ10SLIzuUXnD2/RMnCXOEYPjMvgRaaGjPaXHgS5hV8v+XPb4
	Fol83WLwSRYm41v+p+Z1tdWmkbDD9TtwXTasqQCNFS+o71YIXJmfakqeM0Q2OJu6aUo=
X-Gm-Gg: ASbGncubajLPzUr7LmCfnNjFYbc/AoN/GYPZbAJY8TqCuabHcRAEVqvyFGKv2OhqZPy
	jGOWWtxQik3VTBG7QAlAe+vMmX9phy3NHzh06AUrSXGjYV/MT1a9bqVqhSlDQKhxqiJVitYdsQP
	EZAZqgYttIc+mXmJsxq9a/PO2xNeq+EoHGwt+2dijkdbFAfoq+v6KoP3Ei/zq/SrJKRII+XSQl6
	4wSWBMWJH25H6FIe7HswgNe8739b8GyYkRkCsj16wTV8kguNjNWLNpTc2/3tyJGn0Xpx5cunxK0
	d8L5Hn7aT35/sLD0xUu3H09rUir7nV8MDTmv/UAPVbPDL+yd8On9AUnjgMfefJBHzJo6WR2RExd
	Nso+iebYhi/vNYzazUMUMDsiT61FKZx3NJq0mSdnaOgGekCDsR4SBCI30mw2vzGlm3jJqYbf7NH
	Xb6fMgWKNr8dWJEvHiTNHHwolGIFCU6uoQP7gH9zzybaHlSMb2XwAAK0mgY+mRbrXdUsnhTgFHY
	oOdepxMSooGKw==
X-Google-Smtp-Source: AGHT+IFEo8tXEL2NbUTNjumP8kGSLnsc6s+Aig2BEhXOkA8QpOXitP34VtROaAWnvoEDWGx0+ZxVFw==
X-Received: by 2002:a17:902:ec90:b0:295:560a:e474 with SMTP id d9443c01a7336-297e56c9f49mr148104925ad.32.1762838431237;
        Mon, 10 Nov 2025 21:20:31 -0800 (PST)
Received: from shraash.sjc.corp.google.com ([2a00:79e0:2ebe:8:d06b:bc4a:a8ce:4149])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-297e8d3f9easm95923785ad.106.2025.11.10.21.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 21:20:30 -0800 (PST)
From: Aashish Sharma <aashish@aashishsharma.net>
To: Vineeth Pillai <vineeth@bitbyteword.org>,
	Dmytro Maluka <dmaluka@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Aashish Sharma <shraash@google.com>,
	Aashish Sharma <aashish@aashishsharma.net>
Subject: [PATCH] iommu: Remove redundant null check in iommu_iotlb_gather_queued
Date: Mon, 10 Nov 2025 21:19:52 -0800
Message-ID: <20251111051952.1985154-1-aashish@aashishsharma.net>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The callers of 'iommu_iotlb_gather_queued' always have a non-null
'gather', so we don't need to check for the same in the function.

Signed-off-by: Aashish Sharma (Google) <aashish@aashishsharma.net>
---
 include/linux/iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c30d12e16473..f66f25051584 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1057,7 +1057,7 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
 
 static inline bool iommu_iotlb_gather_queued(struct iommu_iotlb_gather *gather)
 {
-	return gather && gather->queued;
+	return gather->queued;
 }
 
 static inline void iommu_dirty_bitmap_init(struct iommu_dirty_bitmap *dirty,
-- 
2.51.2.1041.gc1ab5b90ca-goog

