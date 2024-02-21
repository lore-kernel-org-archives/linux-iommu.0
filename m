Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7215A35
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 06:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708496322; cv=none; b=Wp+QAOnVxpYctVOdjbEoGa9emw7YCxUWPwkbULjr9LMq1cMaONKrcfFWuX7Idkl+k0MjLUtH4p43sC/+f2bG2YNiTYBE08vb+PQ9bCZfB3+OQHXQSVkpwht0V9Ha0wEvrQjHzaGAERlJAvCK8uY1MpET3GUurBm6QH2eB5xx3Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708496322; c=relaxed/simple;
	bh=/4RHrvnMyEixH5aM1Nq8oXQ5flTobU8B+tYnhQcL4Os=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tG0EpkIl+7UgHdKSn+FKrDqd7aKpljRG+R4uMDRZc4xpi/Ot/MHwsC5+PzpvEDPfFtobwluFKBGuYOdKS5UbUMDvweO7BSpQKv67WTmHG5BDGJHc1ymMOQJsfg1owHlI+LY5/NkWj3g4efhgMWiA9D4rJHPIdjhq9tww3JkVFQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iuL+0f/X; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iuL+0f/X"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e0a37751cbso244934b3a.2
        for <iommu@lists.linux.dev>; Tue, 20 Feb 2024 22:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708496320; x=1709101120; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LntZkoOS3XoaCq85kDcQo9fQHTCSCfK6GDoagwWHxow=;
        b=iuL+0f/XAeW/j+H/LPqLn+/BaPAfzP8Ax8tDaF06jrNAOqcEXxVHgfxYcUqjYjET2L
         xXL3bCUCG7ocwFvisKu5LjJoSmV00N83gy/jcHDfcZezHhVrk2b7SCdoCIPtnEQXUpvq
         LAonLuOOaQYUJQ3vrIkRe52yYuVKeW+L/FhCR59LdWRtLidIIhVAmXvEPuH0KO5M4zjg
         Sl3CEuHaiithKDyi0LrZfg8qSFkHklWUvw/0etXdENr49U4WQkaipJLVoOa26p4QM+Q0
         sXiZmco1aqgvRUlwWC5U9sCZoNU7tD5WFKbezeLHkqyWeGpIMwsfEmU5ChAIsvap21/3
         0ySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708496320; x=1709101120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LntZkoOS3XoaCq85kDcQo9fQHTCSCfK6GDoagwWHxow=;
        b=BNbkvK6n1qOumTpaK7KbOKd3fDXxbWueaZ/OlyQYrIC+ozhDe1fEjVuD5zSWzVmzUj
         KvH0W0fM1pBkk/h98WZcF0RsY7ihz7jwNHBUEB60yMi+Kocaq8qlK8lL/es7mtHRlJVi
         93Cfx09EEt8RmXiJAtcs+42dLvBnoaEsUZzAxf655s0QX3hTdE1fEFg268JiwPqoECj4
         66KWXbMqCU6JVN1evrHg4CrUJxlW2BvUXlgG/5N5wjt/8kpwGJ3+3BN13g2LjteJMH0U
         TiD5s+I/CY+spLODX/T7y1MWFINerLB8XjTyIk7PVVcXgfxvzPBudGklnD9+iLC6aThG
         sv1A==
X-Gm-Message-State: AOJu0Yz35p6fRwvLDvKQTr5auhop07n/jP0+GS6j+E/WPCbIrL5rDtH6
	0AHKs4zmLFeAgPpxsz70KHJvxFQ2Oq+6Yxt0vwKMztnPDrWXQg4JNN9vSjxf/zQ=
X-Google-Smtp-Source: AGHT+IGT+S8AxMv9UxHFZdTHR/6lXjWjId5nAxpLnWFRYLl39FJzcYxcBUFoJ8SwJesdwsPw+N+U4Q==
X-Received: by 2002:a05:6a00:93a3:b0:6e4:8bb0:5f10 with SMTP id ka35-20020a056a0093a300b006e48bb05f10mr1788718pfb.17.1708496319949;
        Tue, 20 Feb 2024 22:18:39 -0800 (PST)
Received: from localhost.localdomain ([114.103.195.43])
        by smtp.gmail.com with ESMTPSA id r12-20020aa78b8c000000b006e3a9bdeb99sm6751342pfd.40.2024.02.20.22.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 22:18:39 -0800 (PST)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	jean-philippe <jean-philippe@linaro.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	baolu.lu@linux.intel.com,
	"Zhang, Tina" <tina.zhang@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH] iommu: Fix iommu_sva_bind_device to the same domain
Date: Wed, 21 Feb 2024 06:18:32 +0000
Message-Id: <20240221061832.430-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The accelerator dev can provide multi-queue and bind to
the same domain in multi-thread for better performance,
and domain refcount takes care of it.

'commit 092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")'
removes the possibility, so fix it

Fixs: '092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")'
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/iommu/iommu-sva.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index c3fc9201d0be..a95c8f3a5407 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -91,7 +91,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	/* Search for an existing domain. */
 	list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next) {
 		ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid);
-		if (!ret) {
+		if (!ret || ret == -EBUSY) {
 			domain->users++;
 			goto out;
 		}
@@ -141,8 +141,8 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 	struct device *dev = handle->dev;
 
 	mutex_lock(&iommu_sva_lock);
-	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
 	if (--domain->users == 0) {
+		iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
 		list_del(&domain->next);
 		iommu_domain_free(domain);
 	}
-- 
2.34.1

