Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDF23C343E
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 22:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920063; cv=none; b=Y9BXz3eurN5me94nvJ2FOjg3A5KawgwyBBOLxZzxscjwaCnmn/0SwmtYgxtZEOUXF+ZRqzv9yQwt/9Lo0VpdGMvtOJwCnQsD8kpTTsuqDXBIvzihHp81CLpmX4pokXTJDKFmA5QUbqjOsRO9zzvASdXVw5/+5wRn1iSwD/vbT+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920063; c=relaxed/simple;
	bh=F8ymmFatrNM1gbHP7oIxU2Sx/VtjhKxATbD29C8iej0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CnF/eEMrQv+R9yD986Flr2FiIIZzFvUS9zvc3iAnAIyuNnMxuno4C9hOkHTqpod/OEkhPdtLc41KHiX9iWTVgiJOjQ6oL6YjOO3YXY+C1EwHDg/UfTiTWPSHKYI0VhGUkSbsf6eoONsU2llulwelpBssAQ7B4acZBHZOTKl34EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y+bwDFQQ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+bwDFQQ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-368ac44b26dso10816668a91.2
        for <iommu@lists.linux.dev>; Wed, 27 May 2026 15:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779920062; x=1780524862; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p6TDU0bNZJfmPAor7skQm3oH9ixmiq5qVekBnZmHN1E=;
        b=Y+bwDFQQzNefZcSZO2gko7zuAHdBecgMuPR0ClRm6Ds9MHw/jbHZ+EuzirtTo2mVlT
         IeNCOUSRTp+47yNO2D6/poZHD5Yq1wyrY0CBXN2asmLS08D9Wknx0ikvpt4knab+KCM8
         R4zrdIi1TlSkU31WsNPX26lJFlDtpRHRyQddUKm3FDthg5/ZR2JwaVF0kgCgPDZJFr5a
         EOIdyIcfZrNwjlzww8Tze0sqt8uc85pa4ouoCgfA78osGZp8+z8U4MkeMZ8hdQ43FbvL
         J//r7/23/XRkkR7YnfOgE18KanMliZzYf2leP70HogYQzpxrkzrTtBQR1PdKMWgHBf3r
         NQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779920062; x=1780524862;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6TDU0bNZJfmPAor7skQm3oH9ixmiq5qVekBnZmHN1E=;
        b=GUEr+DusRIRXg9yoa7t9hFkuqFFBmlUQ6oxGz8/ZbxT80GWMsnyPgqHYvRkFZGLDWu
         PCMLMbokD0M7hoGH7taJo9m9RRuO+G/ydK6bxP67MmbFPSXXEFUeSFQQZLiZ32BOhrys
         FeQi4Rn9B1SbknD17qsnG1sUab2JxviVfLEtT3b6UCp0klko/jlerji1jyfJccMABpoJ
         mVvD6S1Xg4mAJtVAQYU1BZ0EjL0+/KiVBbjIsK5DWWnQehdLh1+7/MhhBU2G53YCWsJs
         xSCJAFEAbZTL1DEWe6U/0rFCpVzUS0opXyoyggfn4U54y7wfxGcCngWIaoVvJRvh+vOU
         WiRg==
X-Gm-Message-State: AOJu0YwzMkOgHzkk3gV04OSeUbwWCD+f4Cvu/+54shXwrd9kwEkKeXgI
	0iksFqoE810WPVs3lc2azenZyR9yT/ywFgmkz912pmLrtSPA5atvtUDYt1nQvsts02Jnfxp4nWt
	suISmWh5yIcZRUg5xcLfGs6GVHy3ZoWbkQEXq1N2xa0VFEyfQyud1yMUj4aaMhD+UFvsv1lZRkH
	rvHjTOWNaIZFelR8I/52rZciCVhM9EkA==
X-Received: from pjx15.prod.google.com ([2002:a17:90b:568f:b0:366:5767:4cda])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:58a8:b0:36a:cd8c:ad3d
 with SMTP id 98e67ed59e1d1-36acd8cb47amr9969892a91.22.1779920061831; Wed, 27
 May 2026 15:14:21 -0700 (PDT)
Date: Wed, 27 May 2026 22:14:00 +0000
In-Reply-To: <20260527221407.1756491-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260527221407.1756491-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260527221407.1756491-5-praan@google.com>
Subject: [PATCH v7 04/11] iommu/tegra241-cmdqv: Restore PROD and CONS after resume
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ashish Mhetre <amhetre@nvidia.com>

PROD and CONS indices for vcmdqs are getting set to 0 after resume.
Because of this the vcmdq is not consuming commands after resume.
Fix this by restoring PROD and CONS indices after resume from
saved pointers.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index cb1e75e4ee91..866cae7b73e5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -511,6 +511,8 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 
 	/* Configure and enable VCMDQ */
 	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
+	writel_relaxed(vcmdq->cmdq.q.llq.prod, REG_VCMDQ_PAGE0(vcmdq, PROD));
+	writel_relaxed(vcmdq->cmdq.q.llq.cons, REG_VCMDQ_PAGE0(vcmdq, CONS));
 
 	ret = vcmdq_write_config(vcmdq, VCMDQ_EN);
 	if (ret) {
-- 
2.54.0.794.g4f17f83d09-goog

