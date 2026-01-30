Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F637FF75
	for <iommu@lists.linux.dev>; Fri, 30 Jan 2026 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769800021; cv=none; b=Z1O8EkVLY805L+PEo9rF10CmORQFi9wjUSLRgp7zTMPxyURxljNJCB95AcvaEdZQDJ9nLUP/fj5szLosHFqWmMj6SHWs/j+cthafGR4jPw35TrgWXBdhEah45LYp7otucJO6KOwW3N+ng/zIhx8mhzjdMRr8R7ldAiIEmtIPMhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769800021; c=relaxed/simple;
	bh=hgt8Y1OAKB3dbGheBcK5jgTUMJt3sPVghRJ7H3Fi2hM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rBmk7ark7nvr9aVJDSDZvu8HzSLYNmf7zHRhYQzqeELyVxCHDy59LXkESc3l0ZbrzaoQggZqIurlh4It4wHXp7FbvwYKy47OvFtEd8W9Fy3SFzSN3Xj0TCFzM6JEHTbZYp/6RI4iLOyW2BUrKPkC6eATkZTNeg87ZMLAlrvcl3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=imR1ttsh; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="imR1ttsh"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d19d3c7208so1267380a34.0
        for <iommu@lists.linux.dev>; Fri, 30 Jan 2026 11:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1769800018; x=1770404818; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xqyo4QQAQ8EYGfOIWd+mkM8Yl9jqhuESn4SgAxk8u9M=;
        b=imR1ttshxekRmfFeA4eJ3YXFYa9xfMQ3805sgCaitdt5+eKkGmNYIMJKhq2VoXX0Nf
         Ind2ezueqo46aqxi+S9ZdUHr8Hqf21nEw0w+wDqT4hJPvLQ9LTl5ADSSa30iWqHJw04y
         Rj/Gd/+pygbC/AUN7p5yjGrInfLyrActjIjCWpjBXfhFEDD25pQKtSSSFik3b5gwQJ1l
         8z+pfxz1hr9pfGVptYkqixKC667U/W6S3HCHbUHibe/mSYgY7Z5m1x+qUlpWkDhLNjWr
         gcwXR32elyF42nPs1A7VMoIEXnQeVlDuL1C7QwHu+AvRn+rpuTckCjF7DzgeEBBczKI/
         W6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769800018; x=1770404818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xqyo4QQAQ8EYGfOIWd+mkM8Yl9jqhuESn4SgAxk8u9M=;
        b=gf3tOGAVOJXtH/7pex9ApOWIDzpAXuoOdEyJfB0lFOP31vmGJuoI/tYHL7JTzRJEbm
         htkpbCp6k/vSjQfiB4aOxreRqiytWpQ4VJKbtEchNRIL/GTdjEJeKq5GoUkesgJsEBvr
         G153d1Ku7w0Do7hNR3MD0S7px63XRbFkUH+Ior1RNgYFYwvE4tM4cH9OiGLGxsWyzvMP
         /WDzavh4BgOae9MGgpRaAa+peZMsTj8pXe90IdyBeq/n4vJaphX3uhKFWHCJaZaTTc9o
         VhH2nA0gKKsLCSWzzchX/4aiRKJwt9TSlZmmQvZznbNaTDe5e027Igqy4CvtkrG3WDc1
         EGbA==
X-Forwarded-Encrypted: i=1; AJvYcCUgwKK07cP5DbMvpXkJduqUbm9o/Kj5g3CZLVSCAVI5PZfCN7gTy07ViwErQu3yDweU107Vlw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxU53HA/+LfdaHu2o25RrhTKLzjM2csxeMnwufDGvsF5tLrgxsW
	AkEQrtN+KnRn6TfL/x2x40C582nwBtJ0kxBcyCF2o4fCxpFvlGQl3dlqh18kh6tnaiU=
X-Gm-Gg: AZuq6aKHC2YkV+ASbt4jIouh51btTZnT2MkozCgbjtKnZLJxcjVnCP/omj/0qX0307V
	j62gG6yVjseh9h3TERmGzwzqeTL3Hm0sxNNW+Ql5JQrn7CzsYOBLqxnIAxRaGVnhaKHs+ykGLGN
	1O7rnaRny+JGduaARDVatmItC4sLS7ZElUZmwP+W8QEv23AxHVoLAG6DHcejdNTf2Ap97yDHhu/
	UevWncJbMy99fyIsMVIYVtuPiLwuKCMGGCo+fYLoKcy+BTPJE+waPY5ad21zJf6YcRPaNDXEmwT
	tAmZuO+e4Vk9ut1hlX9d3hB/rS8CXCGhOldqHP+3+ygy1eIST1KOmweHl3Aeu7TsTdUMMYeru+h
	qEGFFmwyeYEjKh9pkJSimrEHeEIX7GznyOJGQARGAQktlhBE7MGad3ofyQBlV8Mwx0BkBoNFBZE
	YoZFuv5MbwLWitsB8r3wxpjGPKI+vGwyk0wbXCXzwDRkgR3x9CIl/xth05KOEMnbHtOqBnK2WiF
	QoUH5StkGruL5XLMNoyW85kzMicqXA=
X-Received: by 2002:a05:6820:f024:b0:662:f8a9:9fa with SMTP id 006d021491bc7-6630f3613ecmr1944922eaf.50.1769800017730;
        Fri, 30 Jan 2026 11:06:57 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662f9a18de2sm5511596eaf.11.2026.01.30.11.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:06:57 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH] iommu/vt-d: fix missing lock in intel_pasid_replace_*() functions
Date: Fri, 30 Jan 2026 19:06:55 +0000
Message-Id: <20260130190655.1622261-1-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_pasid_replace_first_level(), intel_pasid_replace_second_level(),
intel_pasid_replace_pass_through(), and intel_pasid_replace_nested()
call their respective pasid_pte_config_*() helpers before acquiring
iommu->lock. However, each config function has
lockdep_assert_held(&iommu->lock).

The corresponding intel_pasid_setup_*() functions correctly acquire
iommu->lock before calling the config helpers.

Let spin_lock(&iommu->lock) before the pasid_pte_config_*() calls to
fix the lockdep assertions and ensure consistent access to IOMMU state.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
 drivers/iommu/intel/pasid.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 3e2255057079..dd4c8287d354 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -431,9 +431,8 @@ int intel_pasid_replace_first_level(struct intel_iommu *iommu,
 		return -EINVAL;
 	}
 
-	pasid_pte_config_first_level(iommu, &new_pte, fsptptr, did, flags);
-
 	spin_lock(&iommu->lock);
+	pasid_pte_config_first_level(iommu, &new_pte, fsptptr, did, flags);
 	pte = intel_pasid_get_entry(dev, pasid);
 	if (!pte) {
 		spin_unlock(&iommu->lock);
@@ -542,9 +541,8 @@ int intel_pasid_replace_second_level(struct intel_iommu *iommu,
 
 	did = domain_id_iommu(domain, iommu);
 
-	pasid_pte_config_second_level(iommu, &new_pte, domain, did);
-
 	spin_lock(&iommu->lock);
+	pasid_pte_config_second_level(iommu, &new_pte, domain, did);
 	pte = intel_pasid_get_entry(dev, pasid);
 	if (!pte) {
 		spin_unlock(&iommu->lock);
@@ -686,9 +684,8 @@ int intel_pasid_replace_pass_through(struct intel_iommu *iommu,
 	struct pasid_entry *pte, new_pte;
 	u16 did = FLPT_DEFAULT_DID;
 
-	pasid_pte_config_pass_through(iommu, &new_pte, did);
-
 	spin_lock(&iommu->lock);
+	pasid_pte_config_pass_through(iommu, &new_pte, did);
 	pte = intel_pasid_get_entry(dev, pasid);
 	if (!pte) {
 		spin_unlock(&iommu->lock);
@@ -882,9 +879,8 @@ int intel_pasid_replace_nested(struct intel_iommu *iommu,
 		return -EINVAL;
 	}
 
-	pasid_pte_config_nestd(iommu, &new_pte, s1_cfg, s2_domain, did);
-
 	spin_lock(&iommu->lock);
+	pasid_pte_config_nestd(iommu, &new_pte, s1_cfg, s2_domain, did);
 	pte = intel_pasid_get_entry(dev, pasid);
 	if (!pte) {
 		spin_unlock(&iommu->lock);
-- 
2.34.1

