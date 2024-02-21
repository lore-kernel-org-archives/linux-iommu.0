Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992C13D974
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513629; cv=none; b=T9Ku5dbu5MJsLMhyjs+19oePoxjorput/UjEuRGEr/OWWylZDN+ZCqL3coVcZiJB9+aadK94oNxjXi3SnywNN/apZYI7POrog5c9wBFZtSXjtIBUQRB85fMPnYwtL0am8bi2bu/YpvZjJuZ2H8weVcKq72ao9b8STtPorlcm6mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513629; c=relaxed/simple;
	bh=oeT8D95NKe7pIr4hfviYGvVnoPtzduZq0zmxcgxK1g0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LkT/hZFfDP5PaCxHsbn9B/4Dmt4Nk1CTIx8HkkslfyKXSe8wT6UwDWnYQvOzV74dw7RZ1JMiE97rW802LRGgS8dGBB1fE+srezsogw1as0h54OM7MwKUps3MbcsCT44e16hEe3fWEqf+6+iUo7rLdAqSXGoq53/coC7RJgAhVGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q/KK0Eij; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q/KK0Eij"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d911c2103aso36916045ad.0
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 03:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708513627; x=1709118427; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=brEb9TnfGp5/yuMw230xLgH6JsFOFAcbGsSGw6+DLbM=;
        b=Q/KK0EijAgg9izZI0QR8cMrHQSIMRHs4t7B4T1Mw2Bok8sivrxTXBTDnOyjpu345iv
         DY5sOOWDNeyOvXbPIKTWA/GbvHM6iaWzOFaXbHYwQeD11SN/V2/Ceh5bAFCfCbecCFKv
         CdNlt8UN98VDyW3PZRQ58/dgrCL/IfMpy/kh8Qtr5KR0isC+dsT5OuAcbuWgOJDwPC7n
         S8QOP6xX61oQ+09ZoOIo7hmiJebiQJop0HKIEDjSdcCZyP+0Pryef34wbmnPd8XMcXKg
         oux4OC6MKQR6JIGvc7dhKql8uZEafpdEblZTETjVgLSQxhpg6qqPKOjXWkjDop799ce6
         jl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708513627; x=1709118427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=brEb9TnfGp5/yuMw230xLgH6JsFOFAcbGsSGw6+DLbM=;
        b=E1toPIOsBQsZFSLUEhhZqztr1qLYs45CtQi3a7H92dAgmlseWkv9xKv3xAX5RzYfHf
         /sjEsEj3nYkehnScXu0PqdVdsqKBZzXA5/v4xY+Qt200+Sztc2eWuj18pHEJmvbEIXnk
         IS8n2EeiMbbbvG/noceTDOSODFiyHqBxO+NH3fgnm2j6jw2ePrnQEM6CKb8xqyGuRkYD
         PnhX4Mwj9ZaF5tlMfEpueVVL884G3h98XgTu6X4I3RZfEOw3jS9aI93HbJo/fSMsst12
         Ch4pJH/51ryQqu6/hvbeTJSMKYfJyPhG3ygKw2kEIMAzioy2GFmBUf7hGDSy+9aQ0jWW
         7pIQ==
X-Gm-Message-State: AOJu0YzYukE4EHUOi8danHqx4LkHiidQduXjLFr/1Dg1hJVkexVtcaqD
	COZeN1i75Js2jdV1UhB8SkITAWii2b9zQtCDcKszC/KQ2eX1bwzqFn1qeJAtGsE=
X-Google-Smtp-Source: AGHT+IFOfFUYOzmRcjcrUyMEhlZGMmrIiea4+cj0ZpJzxUHDRfvHzhLGB9dcIaitxNGbEeNYh65O8Q==
X-Received: by 2002:a17:902:e951:b0:1dc:1b14:dc9f with SMTP id b17-20020a170902e95100b001dc1b14dc9fmr4338016pll.67.1708513626789;
        Wed, 21 Feb 2024 03:07:06 -0800 (PST)
Received: from localhost.localdomain ([114.103.193.174])
        by smtp.gmail.com with ESMTPSA id ja12-20020a170902efcc00b001d9d4375149sm7873686plb.215.2024.02.21.03.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 03:07:06 -0800 (PST)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	jean-philippe <jean-philippe@linaro.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	baolu.lu@linux.intel.com,
	"Zhang, Tina" <tina.zhang@intel.com>,
	kevin.tian@intel.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v2] iommu: Fix iommu_sva_bind_device to the same domain
Date: Wed, 21 Feb 2024 11:06:58 +0000
Message-Id: <20240221110658.529-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The accelerator device can provide multi-queue and bind to
the same domain in multi-thread for better performance,
and domain refcount takes care of it.

'commit 092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")'
removes the possibility, so fix it

Fixs: '092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")'
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
v2: Instead of checking ret == -EBUSY, 
    change iommu_attach_device_pasid return value from -EBUSY to 0
    when pasid entry is found, and refcount++ when return

 drivers/iommu/iommu-sva.c | 2 +-
 drivers/iommu/iommu.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index c3fc9201d0be..20b232c7675d 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -141,8 +141,8 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 	struct device *dev = handle->dev;
 
 	mutex_lock(&iommu_sva_lock);
-	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
 	if (--domain->users == 0) {
+		iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
 		list_del(&domain->next);
 		iommu_domain_free(domain);
 	}
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d14413916f93..a16ade93db25 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3551,7 +3551,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	mutex_lock(&group->mutex);
 	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
 	if (curr) {
-		ret = xa_err(curr) ? : -EBUSY;
+		ret = xa_err(curr) ? : 0;
 		goto out_unlock;
 	}
 
-- 
2.34.1

