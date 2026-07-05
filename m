Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D413A641D
	for <iommu@lists.linux.dev>; Sun,  5 Jul 2026 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278880; cv=none; b=mTBkTutGw05rVG7LVF0HGHtUKswt+TCQrCteN4EwUoCK0EiKjsyie5iWue2SBMNUUFfusuB5t3M6QpynRa9PfR+lhm18TOW1KZ9sRaHAOB62G1AfF/1+WNLxBq4/4zVqp2COto7vUBl5GpGo7S9meWHNHQvDMtroGqdq8hNqRi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278880; c=relaxed/simple;
	bh=GNmboLcpB1u+4sbu+20YXtJhFgR6gBIC5iE7jNeRoQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gN0iVNmR79qZ+jFr4ouToy2B2/b7h7KqXiDwxs07LxwnZVDEk/hw2hMMsBTNgR5EL+1Ue0saX3BDHZW714Mq/7Y8SpxXYAnNVVZFIpYDLaQKi0eEQ1MGttMCvCFOb1NjcLWgBWX17N9N9ADssvf1QxIak4973xIJs+IBuXnHHnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANw3Npnr; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANw3Npnr"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47d6c634f45so422217f8f.3
        for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 12:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783278877; x=1783883677; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZ84WH17cmaqhOLzZnVtdcV+4jwRY2Bo5WKI6TnLcX4=;
        b=ANw3NpnrbRvjJFiXr1DGZ+Q2fsTFRqfEh7MoLg8tm/2KduAOsGMc8erdq5IlD15PAi
         e9aG87ctXD0e1WtfFDd+3Pdc26SXMj5hps5X4SO/A3/i1U0Cr3Sq3SwOpXsT0ICIs56Q
         V15WSMj7ShW661+ku3YgINtioT5v8R1Jn/+pAjVychT44Uyu3L3qX9xi/p3aGT8csrRZ
         xbHKkFeUk/0TFgidAuE8FdhlCPogUEqqAvHAe/vdE7BInw0+DLwkIsVOl6kugXsjfTvg
         Ip6RE+/6MZZq+KBwvslbmzAwS6TdF8ZCOuA3Wnd2nvdnJNTP0FlZQKqjoMnO7e/e8FOI
         Zt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783278877; x=1783883677;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nZ84WH17cmaqhOLzZnVtdcV+4jwRY2Bo5WKI6TnLcX4=;
        b=TDdoMy5phRaA+f4LB8y05A2hJtHbPpP2rXRGCGwJNyg6ZmTgSbeE9VklzUz+Hro5Si
         n27zJpch3VTyLfNOh3Y5Fh/bZpPhjsJMngTOEr64r9EgNKyDIhPQD/fGqJr8bmJ59Z7a
         ds8eE//SYEhKC/+cblDQxhuN0U5NemndIOIfEhSSRhQgLQkw9eihUQ9oS/zmMBW49RBM
         qE9pMIVM/pY4Hu8fZB3KsB1sfgLb4fkLcE1qg/efvE2t3qVqQW2zgA38GanZvoQuc5rV
         1fs4BqDnlTo8Rx48sJMXK0zVGqhoN9hHOUWP08Ejx1St0VXcKmyKDiuLe+O4sDh+DfGO
         zNDw==
X-Gm-Message-State: AOJu0YyTqR+VuM/PequxGJ6QaFZGILrlTJqC1gJVAsRZNYUl5S2lKq19
	EHCycCBix4OyvizEmHJ6ReKEQaZBkUIYc2ccwj5wmuJnp/jDbn1Eg10=
X-Gm-Gg: AfdE7clv+STQBSoF0yIv9fqZyS9kewRKwVYn2O2W9Axb/aQUAU7VDKtVjGGcjfh7lRN
	wSRRUbr959zCag11Zd2pMRHf5U7n29XBLr2sKcftdduhKMJR+QP4Y2lW0ClOG1/YQH+chDDB/dC
	820fL/0LTNGF2am7taTcNQ0fUAYYHXJjtMu8KElKsAOegjzeG6npz+Piqk4eaAHjdliC+IgIS1d
	p194fjXRU47NtnYemFtbS7r2FkWo6/ue19JfdNV5InmEqJsvJ3ZjrgvvA8xoNN5waDwlMVzhTKB
	eDjYPpxWIftBinvKJ4GPAEY4PvuqSmqEZoc4lDCHwy/33CB9AK0ueBwJpcgAMVFwgkDq9LXFokB
	nD0a8+HMtYoDXFDl07v2AA5aZWUznKZz6FSY8gB8dcJrzUd1TdF7C39qQrPRbyGdapPWGYb0IZV
	Kh33cHbARqlE4byAUIKSfCzBFFkRk/HQ==
X-Received: by 2002:a05:6000:1846:b0:473:cefa:98da with SMTP id ffacd0b85a97d-47aaa60de86mr8534994f8f.10.1783278876921;
        Sun, 05 Jul 2026 12:14:36 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960634sm19209528f8f.26.2026.07.05.12.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:14:36 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Sun, 05 Jul 2026 21:13:46 +0200
Subject: [PATCH RFC 12/13] drm/msm: set ctxbank and asid based on ring
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-descriptive-name-lpac-upstream-v1-12-01d50c3e0c99@gmail.com>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Anna Maniscalco <anna.maniscalco2000@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783278851; l=1658;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=GNmboLcpB1u+4sbu+20YXtJhFgR6gBIC5iE7jNeRoQc=;
 b=rmC2QQUsBeGBctekJrkX9Bu4XpWytNrOy081NaDsxEdKs3EL5tzPk65CpjizWt1u9+G71Ip0Z
 pqDS3aq7HVdCwtuw5G8Lc0fcU6h3n5cTjmCTycxplXu/JrouOa8zMbf
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

qcom-arm-smmu always maps asid and ctxbank 1:1 and lpac is always 1

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 4417a9d04d7c..a8a061652ec2 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -247,7 +247,7 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	phys_addr_t ttbr;
 	bool is_lpac = ring == a6xx_gpu->base.base.lpac_rb;
-	u32 asid;
+	u32 asid, ctxbank;
 	u64 memptr = rbmemptr(ring, ttbr0);
 
 	if (ctx->seqno == ring->cur_ctx_seqno)
@@ -256,6 +256,9 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 	if (msm_iommu_pagetable_params(to_msm_vm(vm)->mmu, &ttbr, &asid))
 		return;
 
+	/* qcom-arm-smmu always maps asid and ctxbank 1:1 */
+	ctxbank = asid = is_lpac;
+
 	if (adreno_gpu->info->family >= ADRENO_7XX_GEN1) {
 		/* Wait for previous submit to complete before continuing: */
 		OUT_PKT7(ring, CP_WAIT_TIMESTAMP, 4);
@@ -313,7 +316,7 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 		CP_SMMU_TABLE_UPDATE_1_TTBR0_HI(upper_32_bits(ttbr)) |
 		CP_SMMU_TABLE_UPDATE_1_ASID(asid));
 	OUT_RING(ring, CP_SMMU_TABLE_UPDATE_2_CONTEXTIDR(0));
-	OUT_RING(ring, CP_SMMU_TABLE_UPDATE_3_CONTEXTBANK(0));
+	OUT_RING(ring, CP_SMMU_TABLE_UPDATE_3_CONTEXTBANK(ctxbank));
 
 	/*
 	 * Write the new TTBR0 to the memstore. This is good for debugging.

-- 
2.54.0

