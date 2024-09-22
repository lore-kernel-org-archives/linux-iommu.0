Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10781E56C
	for <iommu@lists.linux.dev>; Sun, 22 Sep 2024 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727020589; cv=none; b=ayVKTl8nlwa8FcoLVM1DANnvRCdGvY2BLPom8zPvxvNfbI+Iqj0S0mQzG/p3dY9c61sOyhdiAKgPwGxBsJcvUYYaJ5+S5EN8khBSlI2lojr3PvmMMc/6JDCRsGg3vJGk39Fj//aiWrAt9Jvznt6vTDPVxDHuMLfu8WrflG1+XD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727020589; c=relaxed/simple;
	bh=6rAG2HbdPWUawnusuplf/qRvlrBiXGqt6AAJlCc1uOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oVtXNQnFw/uUSv77ZV5xIlw1mwDKkE5bFItrQKhVTmCmp8bcnE+0306SUbugT+yfxlIE8Bn6IIL/csgrePbMFYnB4IIgLE9JhV0l/+fDb8ArQnZ1ucTilzMufLrLFfvXVLIuoOeuTtm3z+9EVmqWVSeQZEJZF/A4Fxq7vHfis0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtVaWMFs; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtVaWMFs"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2055136b612so43188435ad.0
        for <iommu@lists.linux.dev>; Sun, 22 Sep 2024 08:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727020587; x=1727625387; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/F7XfLo3ysA+PssKb5XpZBCohyL+HFkAA0NOY3jzaDw=;
        b=HtVaWMFszV4YOLUXv9s7ozde3/WKOOWL7sDjqRlZn7N8A4tEZQsxi3S2laDvIy9yIe
         qdFnsleXo+oAJ3huJ5m+ZZHOZIn7ewyJBtCtgqA5N9whTVr4Q+wfh9dkp8aDZFqzJUM4
         Ywjj7moHreqichRRUIRBjrDYD3Snn5yiOaxS49BGllv31P7QutNAv/gVDbtrwbv92wGP
         g8oqEQTWmuqjWU0liLPDTngd9/GSKs/j3D4/zHMA4bMcKMUulySGCTLrvsZvE4KO8ueJ
         KtkxhP4TukGmJn4UL6kaJZY3L6yyE6xD/tpwn3NhgnG1f1r6ikKPOUylU4qPVETMeroq
         IC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727020587; x=1727625387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/F7XfLo3ysA+PssKb5XpZBCohyL+HFkAA0NOY3jzaDw=;
        b=V+KG9O9W5JdY6sS4qjwUQkfTT5pVqc453KmOlPuP5ksQTxIOVTVajBBUqDt7QbiQPT
         ttGzK4tGVTG9A1oUS8SmMgRMHRXetBQskD2BfwfQmEARMPqN9XL0UPq/IXp8/8qd+7QW
         hZtMyv4co8AillWgAeR7pD8mLtDWBcYwZSwMGJlvgWxtcP7YtPKJ31y2sZvyuFtB5o22
         05Yunm+xuSraZREdhi07OCxU02BcgxJpssOBiHSmT6wZOwS85sr6quV+aUV+aNGxOhjq
         0TwGd9mKJfOAGHsgNSXsfN1zbevBNlR/012vxaETr1k8L+DJ9fONGYdDvFJGl/yepR2w
         VTIw==
X-Forwarded-Encrypted: i=1; AJvYcCWAXBWdFqp4ckyloRz5u9iWqwAAru+T75XGHkTL+xah34gQnMxS5MJXvbzuhtFSnTaXIetzGg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyOCO877uuIwUFsvAt8mqb9mPXtEYEQZ1C+BeK0iKcEUjyVNmQO
	WjbxRadJm2PTx/qS+R8Jx8JKvI5vTgXdfSTFxVVMuwYDcP4/SbJU
X-Google-Smtp-Source: AGHT+IFeIPn9oJi+TDTigduD/EWiuab7BSrpCBCtPwJUidQwjLEgVyoTM/MHjjnZYICgIzdFCb2Upw==
X-Received: by 2002:a17:902:e54c:b0:203:a046:c666 with SMTP id d9443c01a7336-208d97e4047mr111443625ad.3.1727020587317;
        Sun, 22 Sep 2024 08:56:27 -0700 (PDT)
Received: from ubuntu.worldlink.com.np ([27.34.65.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207947356d5sm120603445ad.273.2024.09.22.08.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 08:56:26 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	baolu.lu@linux.intel.com
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: iommu:  Replace null pointer check with IS_ERR in arm_smmu_domain_alloc_user()
Date: Sun, 22 Sep 2024 15:56:20 +0000
Message-ID: <20240922155621.49432-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The smatch reported following:
'''
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3065 arm_smmu_domain_alloc_user() warn: 'smmu_domain' is an error pointer or valid
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3068 arm_smmu_domain_alloc_user() error: 'smmu_domain' dereferencing possible ERR_PTR()
'''

The function arm_smmu_domain_alloc() handles the null pointer after
kzalloc and returns ERR_PTR(-ENOMEM).

Replacing condition check !smmu_domain with IS_ERR(smmu_domain) and
returning smmu_domain.

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a31460f9f3d4..19c53c6f7578 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3062,8 +3062,8 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
 		return ERR_PTR(-EOPNOTSUPP);
 
 	smmu_domain = arm_smmu_domain_alloc();
-	if (!smmu_domain)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(smmu_domain))
+		return smmu_domain;
 
 	smmu_domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
 	smmu_domain->domain.ops = arm_smmu_ops.default_domain_ops;
-- 
2.43.0

