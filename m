Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C3B3FBA7
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762542565; cv=none; b=M1sDDleNO5mL49FKJNkF9IcnCWW0fh9qrpVyxfmSU3YW4IQT807n4kEWH370mwggxwAX36hu0nFqGN/PbH77cDR+bMokvAjUPh/9wjP/0oMJfilK+hibEE5exwpdJ3zjkmjT+8YX+pJ25sXAe3oFLCcZZ4PRw0GYm7Q0/ut5UPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762542565; c=relaxed/simple;
	bh=Jio0dLTMHWuJSbVzrU/hSMiGj/f2giYmy7YHRCXWFCk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ljXzqA8Fn1e5K3dHxOYOmw28RKwWbw6LuA7goEsDhbox2d0zqj80LYhZ8JYqIezTrefjDPc8t34ZIGm4sbVGacRNjsKa1YdqYVuuhhek6NPYM2gKYqea1zsEt0cjyNQViebsrQK+q11it8xbREEW5Sw6+9AjE12BD8IFcxFMGYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tzukui.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I7iXMsxz; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tzukui.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I7iXMsxz"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2952cb6f51bso26255665ad.2
        for <iommu@lists.linux.dev>; Fri, 07 Nov 2025 11:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762542563; x=1763147363; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0NVzA0RssgZmBwPsMPQrXHwqZYSq1RpFtucbk/ffCh4=;
        b=I7iXMsxzGokxPJJg0cjGly3OpCYV0+iYlrUXvk4FWjK87MFHBCGTGomyPaKJypn2dz
         T5h05DVsb8ehKweLPS4on5X8OtYhyVyScfxOxWI0i+OitEV7abTqSZ1ajKpO15cSkMua
         5Wu/zAhEsk9wtLQhg/sXB8nX93+wc8Z9eDwJvfdPT4yZHs22tc0+LT8HpK+R2+c90gEb
         zN928zsz0iBVs3k8m2Ab23khqjEapvjgoXSsi8oQiOCfLE1cvsZHmdDCUR5iAD6nggWV
         AGwrMv3bdLJBzySJDTbHLXz9gRTX0eaTO6Cjmm0jiqtisFbJaPxglFad8mL2ESuqe4QP
         75tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762542563; x=1763147363;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0NVzA0RssgZmBwPsMPQrXHwqZYSq1RpFtucbk/ffCh4=;
        b=CSqAtf1DB/cdWnMkol1CUCZlwx65iXEkgW3Jnph7GfoAA6GgRzMFcTnvqWgnRZl8wH
         VTaszCmO7hutqlznOVbflaqDmpZUB47Y8X3p2H6LB75JIa4gM5oAxeWAqCPVoj5IFrwN
         X1DLKwqpCldvih2PhJdcZu73ArVMFRarz7vMT5i4vu4yWVLibKVzx9x6frmbTjbk/ILY
         mLO+t2dEF2drdzkGEPzTRa5XUzSMR8kpiomGJ/g6JoCiLMiF/1r5NOVxOZbAGGWGiSkA
         +Senyg6fjua2UeW72QDwfcg7eRRZ4oox63aslA5kpF/jIWRjpEa4TVK4+BR3gpdyRff6
         hCtw==
X-Forwarded-Encrypted: i=1; AJvYcCXOlzsUThUPaiQe+jKHIkn8/UlrRfhuwBKoIoiuOEqZfDyomTikX/0lNjSwFbaJIMLJokH/aA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxyfi2wsJ+6ODi+aOXhAqa/Hfi7ofcGZNYxsWGdCXRjdswD9gC7
	5fLk7GVP2kk4Reynyi525DLts/GAcI5eUh91+HiXJQNh5Id2fUvC97vh97v9Va2glGTXf0NJJQ1
	4jtefDg==
X-Google-Smtp-Source: AGHT+IERV/3DbTV3WeqT5ErpZeSNkgmJgFP4LV8NkvrM2+uwaUCdMTQHV1trZquhgmdySuzjgVBwK8cSeuo=
X-Received: from ploc8.prod.google.com ([2002:a17:902:8488:b0:290:b156:3774])
 (user=tzukui job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:94e:b0:297:d6c0:90b3
 with SMTP id d9443c01a7336-297e564e7b0mr2374475ad.23.1762542563521; Fri, 07
 Nov 2025 11:09:23 -0800 (PST)
Date: Fri,  7 Nov 2025 11:09:17 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107190917.2858684-1-tzukui@google.com>
Subject: [PATCH] iommu/arm-smmu-v3: Fix error check in arm_smmu_alloc_cd_tables
From: Ryan Huang <tzukui@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ryan Huang <tzukui@google.com>, 
	Daniel Mentz <danielmentz@google.com>
Content-Type: text/plain; charset="UTF-8"

In arm_smmu_alloc_cd_tables(), the error check following the
dma_alloc_coherent() for cd_table->l2.l1tab incorrectly tests
cd_table->l2.l2ptrs.

This means an allocation failure for l1tab goes undetected, causing
the function to return 0 (success) erroneously.

Correct the check to test cd_table->l2.l1tab.

Fixes: e3b1be2e73db ("iommu/arm-smmu-v3: Reorganize struct arm_smmu_ctx_desc_cfg")
Signed-off-by: Daniel Mentz <danielmentz@google.com>
Signed-off-by: Ryan Huang <tzukui@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2a8b46b948f0..9780f40ba3e6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1464,7 +1464,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 		cd_table->l2.l1tab = dma_alloc_coherent(smmu->dev, l1size,
 							&cd_table->cdtab_dma,
 							GFP_KERNEL);
-		if (!cd_table->l2.l2ptrs) {
+		if (!cd_table->l2.l1tab) {
 			ret = -ENOMEM;
 			goto err_free_l2ptrs;
 		}
-- 
2.51.2.1041.gc1ab5b90ca-goog

