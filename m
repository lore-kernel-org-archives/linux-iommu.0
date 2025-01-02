Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663E41B3954
	for <iommu@lists.linux.dev>; Thu,  2 Jan 2025 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735842758; cv=none; b=lzA6Fu948R3RVxv3FEDmTUrept7+bDlazD8IagBZ08b7xd7y6yLT07pdzW+rycQHOo0AzvRr3k5ojR2Y7cXj+555LHx4S8zwlVAXByWIZbNCduI1ikAj1WbeLyatsliMaODXxeXNpUbuEuO0kQw3qvV8I9i4v2RQoY4Xjrm6io8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735842758; c=relaxed/simple;
	bh=cN4J+UpgOxehArmN/mUgiApP4PZbJeqcXPOMBYKIKD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ed/SIF/90Ff3CHr2ei3f8DzSPuJJFzbs3vwLKcIYw7GvexaW51pQ+lr6R7ehiA+XLWePQUjUN3qD6jHrvi/D+oC0QiG1y2MF29yBAH3FxJYK//yv4JGaP8+PqLKe3fHKmIbdYrndLKDgD7HgAf3yBMDlFT8MOMrQdMviP0BfsnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYvGoe7T; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYvGoe7T"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so16392486a91.0
        for <iommu@lists.linux.dev>; Thu, 02 Jan 2025 10:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735842756; x=1736447556; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmBLyMaEsdOn4Q5STQE+mhdoJd5pHTPZlhfFO4wWcQY=;
        b=ZYvGoe7TLYQomqH5Q5PlYMT/bHg4hJrdYdxf3Uccb8JwMMLYEsD6+2+YDyEGhBny8Z
         UOpvqU172s4odAoiwPKRvQuSEloWQZZ19muQaFuFuG/qO4AxkoDkuQ1GVlJrTXon6i9k
         e5umFCR7szFwCAgsueY9TjCDMS5YhXbFA6xrIs9zpUZYCGOY6FlGVYsdUITqQTH9s2Wk
         Or9oLpXjty+rAgVSCo+FDOUFQBr0gU3sQ4rIECPrmkG/+tK6XTpPDi4Rtl8041vdqIYy
         pCbOxdX1Jiotjgo/uls+iMCtmz/nraBRVB34OpVBqdrUz9K95qvvPicD7jEjuTCduOVt
         ycGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735842756; x=1736447556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZmBLyMaEsdOn4Q5STQE+mhdoJd5pHTPZlhfFO4wWcQY=;
        b=VeE4xJJ22h3HB3a+loaLmbu5spFeriIMz/fi8+AZ18oqFrL8OoRNJMZjuacciY/fpx
         sQT7yXLYcD53pDoB/XsGWHVl05Z+ROA+c5rIyYBXZXsyIdt/YO64zQOXv+V7GJiTzzT6
         xuo0T63z6CcZ8EDyZivPdsomUsijiAyyiEkRKECBxLTNMDA3GBbF5tdRDPz+yMIW6+HS
         qELj02vVdWdJBZyEsHUGb6Zw2cYf6A6iVwLrKi3nFqm2M3ZFNlUz2gr965J1GAnxRP6x
         V8lq4iv6XvtmmEmbrK0AUHC49YCtkFjBe+9zqjfURsFrz1lLZ9aUA+BWb/nxw/B2lom2
         ItcQ==
X-Gm-Message-State: AOJu0YwI6Ivti/Xx2jKV31bz2RdHJzcn/YiJQ0aOgKxvi4fnWIMAwkbv
	E6dIFS6suRx9evpkJyegHPAQqyNkcjWTPvQmPU8/BBhiiLNYlGPd6wDD0A==
X-Gm-Gg: ASbGnctii6aSO93IH27N4yymQHTa9qNh78/HLp3I2FyResvDPoMn89taCgRYzaupCpG
	z75B0m4jHLykmMa2bfJuqp0aQzRj+JhH9KqP/D9ZOUXeopfxyU/qpQQGwRGxA3ecbVaTtYwq1T5
	+S+qOtvX9Fyxj8vv9MWdx3bH3DSSNT6vb4IQGwSOTxfY7QFP6ZBdvKra3/TqMqle0BKCG6osw9h
	HJPSFwX36bLrHOc/NVXpGkYlhOogwlQx/Pnulrab1syyeehUGs/EbtmMcalDuZgoNEz9kyr7FYp
	PjdhklRpftj6DK+ZRndRFPSsPZU2wlw=
X-Google-Smtp-Source: AGHT+IHpGOLVThnWV3UDWPVggKt9JZyqBWGCDD4mG3rXl7oRcepmQ9fGjP9tbJJ2H/XG2/M6m4kRPA==
X-Received: by 2002:a05:6a00:3406:b0:725:eacf:cfdb with SMTP id d2e1a72fcca58-72abdeeed6emr71219209b3a.24.1735842756061;
        Thu, 02 Jan 2025 10:32:36 -0800 (PST)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbbabsm25601698b3a.101.2025.01.02.10.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 10:32:35 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	Rob Clark <robdclark@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] iommu/arm-smmu-qcom: Only enable stall on smmu-v2
Date: Thu,  2 Jan 2025 10:32:31 -0800
Message-ID: <20250102183232.115279-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

On mmu-500, stall-on-fault seems to stall all context banks, causing the
GMU to misbehave.  So limit this feature to smmu-v2 for now.

This fixes an issue with an older mesa bug taking outo the system
because of GMU going off into the weeds.

What we _think_ is happening is that, if the GPU generates 1000's of
faults at ~once (which is something that GPUs can be good at), it can
result in a sufficient number of stalled translations preventing other
transactions from entering the same TBU.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
v2: Adds a modparam to override the default behavior, for debugging
    GPU faults in cases which do not (or might not) cause lockup.
    Also, rebased to not depend on Bibek's PRR support.

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 6372f3e25c4b..3239bbf18514 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -16,6 +16,10 @@
 
 #define QCOM_DUMMY_VAL	-1
 
+static int enable_stall = -1;
+MODULE_PARM_DESC(enable_stall, "Enable stall on iova fault (1=on , 0=disable, -1=auto (default))");
+module_param(enable_stall, int, 0600);
+
 static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
 {
 	return container_of(smmu, struct qcom_smmu, smmu);
@@ -210,7 +214,9 @@ static bool qcom_adreno_can_do_ttbr1(struct arm_smmu_device *smmu)
 static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
 {
+	const struct device_node *np = smmu_domain->smmu->dev->of_node;
 	struct adreno_smmu_priv *priv;
+	bool stall_enabled;
 
 	smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
 
@@ -237,8 +243,17 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 	priv->get_ttbr1_cfg = qcom_adreno_smmu_get_ttbr1_cfg;
 	priv->set_ttbr0_cfg = qcom_adreno_smmu_set_ttbr0_cfg;
 	priv->get_fault_info = qcom_adreno_smmu_get_fault_info;
-	priv->set_stall = qcom_adreno_smmu_set_stall;
-	priv->resume_translation = qcom_adreno_smmu_resume_translation;
+
+	if (enable_stall < 0) {
+		stall_enabled = of_device_is_compatible(np, "qcom,smmu-v2");
+	} else {
+		stall_enabled = !!enable_stall;
+	}
+
+	if (stall_enabled) {
+		priv->set_stall = qcom_adreno_smmu_set_stall;
+		priv->resume_translation = qcom_adreno_smmu_resume_translation;
+	}
 
 	return 0;
 }
-- 
2.47.1

