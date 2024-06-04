Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25CE13D88D
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717527144; cv=none; b=KP2lrdNXZxSQXjpz/IA/UdeZ6Cma8dyVQmydH28hgmmLXNrb3QLa9WyeWMMbWjUOhu/Pw/Ni5oJpJMj2c4zdQqAim+XCoSCA2sTXFywSlIXRrhTJXrp/zFln6cNCEwp61GggUzD9hfKKMVUIz/HSsQyMf+v0dqViCHX9jKafHmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717527144; c=relaxed/simple;
	bh=diY4ZIMY6aWi1bFAy/EtmF9RZKTt4zuEne9BTdbHYFQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=H1lW7wz4JqKFaSl7kMKNHhEFi4QgM29Oem0B4TQ3C5HacGELffTCj1UXJ3UfEG5RTtFh6NjxPw5RsvlQ43GCDyk8tVecm5Jprt5//oaG8yqR2h6jY0rfIVtbpzKSu8smRWcpa5JFrvOcTjcznpTY3P4e4nSrT2jMNkYwVLjoRfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pJqv4pN0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pJqv4pN0"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62a1e9807c0so1977787b3.0
        for <iommu@lists.linux.dev>; Tue, 04 Jun 2024 11:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717527142; x=1718131942; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QinZc84Ac+qY0luma+PGFDFARquLnMN+4RLVb93myYU=;
        b=pJqv4pN0O2iW9eSwBGOBM1mw9V+BkQGW+i+WLrXvDMGhyL9qRPLXmbNclhhNQewYon
         bgKmUxgMjxEVAGNQLIY8fM5ahTVkoKIXHAxFY/Jcb2gezLXZR7tAcNd9Ywy9YYLi+OX3
         p8oLkEJEi4UsGzDjdJgKEMLUWj7feZpncFFej4i+OpHUXBFC5WqpNjujJ/UmAgHBeLjF
         DggaHDH1ZtibCAJzF0HnaezMXlkh3i+YegP9wPGlDiwG7aJTBtHTP4B2QKiyfKcV3zRh
         OApDgIQyyznTSKMsVSCbQ7C8STMfDOdCYlb+Ni44Po7JFR69RWQnOjBpBaifaB0cuytQ
         J/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717527142; x=1718131942;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QinZc84Ac+qY0luma+PGFDFARquLnMN+4RLVb93myYU=;
        b=lnvbFG9n8fu7uX+lt7k/8HimMHkIvh+oIlqYQ8Kluukg5kNED+x0ngu3cCm+oUBZER
         fX7tEPCQ4fI5OxAy9F4HrctTE2zadcTCYWUeg652LLa18+zCJXx7Wa7bl87IqbB/8AmZ
         J9tBR+kpQY2O4D84q8oX9CRLpBlYK/QtaES+uiOnqJVhZZttkTBQIPgZYBOlbXmJX72B
         wUDjfxluyH1n3+WlBAlPEcIyOkEZAsoVqzwCkXjrAYZjPg+ih67xVXXTy1OjvC92Putp
         za2DwB7TBykclPmSjRoPLULS5mLSbQWeS7tpCqBTh9zuIMtFk9D4Dgk/71ohIy10x20G
         ckxw==
X-Forwarded-Encrypted: i=1; AJvYcCW38wEgk1lnoSbivBddsZCiWw/VTVjD/fH0QbnEimfHQUrve67UfgEb1NbWxHBhyfmEcyHOd4IOOJ22fPccQOnQGpabbps=
X-Gm-Message-State: AOJu0Yxs1zdtjoz1aQqO3OUVz5dmj0QZmUDqWh/nYvGi3rJknrMe3QHq
	i7f20dQxwhXzMrbEiKE07L6083l9WrwjyjqX873M3B/PdQyaxMu93RBxm2HxDEClrM4/7g7QpW7
	dblkWB74Tkw==
X-Google-Smtp-Source: AGHT+IFBDAGlNKpuJe3KrEo6TBkztIdrl3oKDL7VgzxoduDyeuFK/R22rAhIGO60kwUm3nKcI1m8ohqSfRf3gg==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a81:4014:0:b0:627:de82:8077 with SMTP id
 00721157ae682-62cabc78cd1mr7092087b3.2.1717527141788; Tue, 04 Jun 2024
 11:52:21 -0700 (PDT)
Date: Tue,  4 Jun 2024 18:52:18 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240604185218.2602058-1-smostafa@google.com>
Subject: [PATCH] iommu/arm-smmu-v3: Avoid uninitialized asid in case of error
From: Mostafa Saleh <smostafa@google.com>
To: will@kernel.org, robin.murphy@arm.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, joro@8bytes.org, jgg@nvidia.com, 
	nicolinc@nvidia.com, mshavit@google.com, Mostafa Saleh <smostafa@google.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Static checker is complaining about the ASID possibly set uninitialized.
This only happens in case of error and this value would be ignored anyway.

A simple fix would be just to initialize the local variable to zero,
this path will only be reached on the first attach to a domain where
the CD is already initialized to zero.
This avoids having to bloat the function with an error path.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes:https://lore.kernel.org/linux-iommu/849e3d77-0a3c-43c4-878d-a0e061c8cd61@moroto.mountain/T/#u
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ab415e107054..f456bcf1890b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2302,7 +2302,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
 				       struct arm_smmu_domain *smmu_domain)
 {
 	int ret;
-	u32 asid;
+	u32 asid = 0;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 
 	refcount_set(&cd->refs, 1);
-- 
2.45.1.288.g0e0cd299f1-goog

