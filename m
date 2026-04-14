Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F442853FD
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 19:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196043; cv=none; b=SKfXQuN4Y+b3q8b2x/44F8B46OHXZgn6fa7DTUlribFxW1wAlAEW+U484YQusxhwGMnD9B6UjwbQr5n1SdYEtOSbSdDKfFzzkHaBqd72F6C1sdiYhq8NDCsnINjaGC0ZLMj2sznWy+A+i4xn43id6HiS4Q678GnvHzqgG+obDJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196043; c=relaxed/simple;
	bh=F5XvvqwKO1+7+DxgahryeJWbov6a+DveEujAObl4Xuw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ATIbyivGljbtOiFKjwoJo3R6ckK5mMg6TTZmAuz2SIkOLhjr3F3gOx5HaZasILOT3uhk5rUVQzKFhlIpKNLW+uwO3KaJivpLYj7aLJAClIYjJ6j4D7lxJAvxGfsS6KMtumblhcthX1OobVl2xwcL31944CX6IoM9B6TtlopVE84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H+6MJn7b; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H+6MJn7b"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f460260cfso2503417b3a.2
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 12:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776196042; x=1776800842; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0izS3IIPHca+msfLc36PiyQLa4FD4ODkop3H25V1law=;
        b=H+6MJn7bdZ3lePksZT+6RUIqYTWqPOUQyKsq2Xlx5wX8rrC6t8skuiO1iCDGfoqErc
         El6ehRkGh4RzBi+OSBzQ47k1qgIpkrzLBg2A6w92eywS7Ud5NRGazaxfSfhN7g77FFtO
         PADkL4UwmoLfWnqgTbX854o4gjLn70eoq1p9+8HmNVBctyH8wSNIudf4FfykwQ2zBi5P
         cp1nNjrlFzFa18pIztGl0SYkRszLVsuVC0V1uHTUX/22PGW5MCw+7D0+mREDpAQCjrk4
         d7h+Fgm9r31TeknHlmFQxYzWNMcQOBMn7Y3ES1h+PgXwATkih7IASpOdL3TvV1qSy62q
         gX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776196042; x=1776800842;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0izS3IIPHca+msfLc36PiyQLa4FD4ODkop3H25V1law=;
        b=QcDYnAWS9bH0xOPivzmhVt9EJEhdUkKIlqkDe6B+A9ioRvDndRyYQgC2K8ZW84jhxV
         GtbN4bllOlakBrStO7UAwWqly9s1hIKHkVq9zNC0q9AyZolCYD1b2Wpk9pYPU7Vl/OiE
         oUgXBl5TdhwAEtk+YHJg2PvcVe8LYqwos0ZSQXQM43foZY1OQLUzyvQM03ORs7Q/k1ry
         G5+PkJCTVEZwZ3NVDVYs+l8nzeSOPc05I2/vH7DJ9xTeeinSWp72tXgzXK9GZHE741+5
         KAeJJrFxPIvvVjNr3rOjX92XkvddCkrDJE4HKOHEFyLVOLWOcDMiYSp/i8Slo/qX4qH0
         jsSw==
X-Gm-Message-State: AOJu0Yy6BT+jomzk1y2XqIofeZnycLn7pdtAM1BbaS95w6NlVkCouLMV
	fUxhb5TCFb/DVW21jRxGkzmm06YN7xcdj57IJeCvIoBvdGPdpGPLtQveQAgKGmwq1W7Xr/6R1tU
	FCnkCTAUU86+YS7YJoC/cJiVEXyNX5zx7w2lo4t9eM7KOlKwjEncRcpoKd8Fq8IASMYPXnNuDU/
	ABCHErsf4IbaZLE24mfEa9D5MIN5mdlQ==
X-Received: from pfbem35.prod.google.com ([2002:a05:6a00:3763:b0:82f:12e6:82f9])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3499:b0:82f:425b:4c27
 with SMTP id d2e1a72fcca58-82f425b6ac4mr7983409b3a.14.1776196041278; Tue, 14
 Apr 2026 12:47:21 -0700 (PDT)
Date: Tue, 14 Apr 2026 19:46:56 +0000
In-Reply-To: <20260414194702.1229094-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260414194702.1229094-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260414194702.1229094-5-praan@google.com>
Subject: [PATCH v6 04/10] iommu/tegra241-cmdqv: Restore PROD and CONS after resume
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, Pranjal Shrivastava <praan@google.com>
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
index b3ed2149f72b..eff6b7f6d52e 100644
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
2.54.0.rc0.605.g598a273b03-goog

