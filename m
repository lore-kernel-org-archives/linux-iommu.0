Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E9B155A5D
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 21:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272985; cv=none; b=CiUqqwn04gHrt46KOhRNrKrzA/2RQCMZTzoAYuMlH2bus+wv+geF6A56qZmKFyGnvQgfP3cF4Ogvtvb0Ml2bdjoX1xQ9Anx6ol2LtCWwKPGuKUPTY+ruvbZriQ+5LYlWJJPALh6tSNzkProcEVlrf0YF75/HgvFGzlzFYD1LgTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272985; c=relaxed/simple;
	bh=EwMv3MydiY0ClHrZYiEvOz14qeuLuGu//WaNcgKc28E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LSLAfI2n9p1H3KtZ54QC6vlckbSIZ1C/FdUg+HKAVGKmON1HO54v9pLeyEsV6Q4jiKsWPHTKAgNvFd3Bv/qIEAmCpX4UzHINRiZJBiDcV+JUpjgGUSjOviu8irY0t6Jb8fsJP0ocZ8cyZLRkySf7E2sM8T4ZCCquj2mCL7LnGz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=em4TSE8h; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="em4TSE8h"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cab041eced3so241999a12.1
        for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 14:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785272984; x=1785877784; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=niSdBLQKknGzg8N9jW+6lT5th349IdFmUhj+0zgN8x8=;
        b=em4TSE8hQh8Ct+tBSwnrNjHhKdWQ7B6b2BdQaPcr0ydD+dIQZqg7nttSP30JXWZ2rA
         s/ri6ult+WE17r0aqr1C2a/wXB06cBb9PQtPbvscZIYbu12JVVn4ErojQ6eqL1rVBb6n
         vOHdkseQqYWKTe62hs7+UxqyXDVEPuxgc+PrCUB6Ev4MZrrlmTe8kuvCzUWZjD+p9izq
         kX5SVHmpmtxnOqpbQBb1cnA2RYxqS/8cGmZ6DUI57KlV/vq8Oj4t/+gofrIpXev3pYYk
         aTeAmiOEeIzRHmYxiY+8CoW/Dlky/W8DWCmTWL5MaiRwVAN3LGCBXoHnxGxFzCBAO5LA
         /NYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785272984; x=1785877784;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=niSdBLQKknGzg8N9jW+6lT5th349IdFmUhj+0zgN8x8=;
        b=YKrGoJLj2PfZre1fqJxclraVGg/+hm3kW9XQyaIW7is11c7WSkgMzqwcPo5bqJ5Ijq
         P17wPE5hcb2TRs0CBQd63CIMjwVTd2a4nQI6FrgK8DqHyn+VH2029QjGGZLrlP3baWAi
         1i8UGKHbPrCm5GMwp1GpLjGGPfX7yjm2RMH4nrHbNDY8LrbDvoDATuLZYp1ZF5bsYOrr
         hPKubGgKmiR+2aQ4h/JQ1TfCcpNJvlg5t3FG+P/rC8zu9kAUDoRslT0KbDZHM1CNuqq2
         3eVrtEWJaPsEoJxYk2TH52p7rsB2JOnKWg73EAgx/PZY9wQt9/TZmQVGglwidGU7311/
         ndVA==
X-Gm-Message-State: AOJu0Yw0j4f6tc8RyQf5CHPnQ3haCP7IgpLsd9Xt6lLd3UJi388z5sAg
	8snFnTPT+NF/SjapXYTDETn4W/ps+4jSBsRVjb38tZzfkT6q8TpIrW4bZf2tBL45I9SbhImt8vl
	ER7DVUvwsDnqoG95TOXSAVCrGAM9fgyr63oWLer4UFvXXNNPgniIPcii7eqWszzgEkUH8RXMxNk
	EQx5IlUmyKkrVlsXvBPMENsFGKYQPsww==
X-Received: from pjbgx1.prod.google.com ([2002:a17:90b:1241:b0:38e:4a3c:2514])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b8b:b0:389:8f6c:4d58
 with SMTP id 98e67ed59e1d1-38f6a45d39bmr4419333a91.34.1785272983619; Tue, 28
 Jul 2026 14:09:43 -0700 (PDT)
Date: Tue, 28 Jul 2026 21:09:20 +0000
In-Reply-To: <20260728210928.1050849-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260728210928.1050849-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728210928.1050849-5-praan@google.com>
Subject: [PATCH v9 04/12] iommu/tegra241-cmdqv: Restore PROD and CONS after resume
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	linux-arm-kernel@lists.infradead.org, Ashish Mhetre <amhetre@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ashish Mhetre <amhetre@nvidia.com>

PROD and CONS indices for vcmdqs are getting set to 0 after resume.
Because of this the vcmdq is not consuming commands after resume.
Fix this by restoring PROD and CONS indices after resume from
saved pointers.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index f62e9bdabf8a..8ecd2052b6dd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -553,6 +553,13 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 	/* Configure and enable VCMDQ */
 	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
 
+	/*
+	 * HW Registers reset to 0 when power-cycled. Restore them from their
+	 * SW copies to prevent executing stale/ghost commands after resume.
+	 */
+	writel_relaxed(vcmdq->cmdq.q.llq.prod, REG_VCMDQ_PAGE0(vcmdq, PROD));
+	writel_relaxed(vcmdq->cmdq.q.llq.cons, REG_VCMDQ_PAGE0(vcmdq, CONS));
+
 	ret = vcmdq_write_config(vcmdq, VCMDQ_EN);
 	if (ret) {
 		dev_err(vcmdq->cmdqv->dev,
-- 
2.55.0.487.gaf234c4eb3-goog

