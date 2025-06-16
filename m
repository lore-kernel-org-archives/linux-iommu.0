Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6313ABA42
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750105952; cv=none; b=hfEQfEthBIi0b+Z/iAch6+WJ016HCrV05NSTIdmz8rS1bLO08N1fh3my2c4qyxe0S9Fqa9iO0pbHWcn2wVVtUrNIUjHZwoVAWMFmqjtr62+nOKmIwGnkZa07y83Zjrfz2DKGavjy05byL5AWr0g9/gZmPPMpOkkG6di7cyCX8KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750105952; c=relaxed/simple;
	bh=02wftbSszGkwBgxBX2qxo+ZI3Iv9XiHpXrAqhYo+fgg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BpsxMbBhoAFdJBgXe1lnmiJIBQX/kca3CBxEqcJDf2Ea+bRIhxY2kqc0q3dLsWhQB5Juj8AJPcDEYsv2VaXv1alvKV64F2LPCuFxcHFavOXjwLxNN3NMH1FQLRr4sN9ncOJS8RqKhfirkr0VMcUADJXJc/QFucoKz7KcITfHT40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d6pIJqA3; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d6pIJqA3"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2365ab89b52so32531105ad.2
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 13:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750105951; x=1750710751; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZifEqvGDwliCp9AHnBDWDTDfL/MiV8PCZen/lVHMVPk=;
        b=d6pIJqA3bk/Zc//ve/wLVltNTXrHfYqqxVhN+27j93uivMwjlhkMOkO1hl/ZFKgUz1
         rmQV32SYEEUmX8HFiWliA7+6nnRTQ/zHY5r8H1mv2cHU4SkTZCeeya44xyNpQSSM3rC0
         alzWaoTCZKYXZaD/VD+i203cnxUpplMAUDaqn6X/rIjfoybD89Zw6WVmEjZbzSk9hW8d
         ghmamwLTmRKcWuave/WGualyn2Fm/lDqvYPohUCZNIIgKpwBnp39D78radXzWjt5TtFs
         KuUrWZx5GcjlenByfoXqkEQt8jhPP3S79cEwjsfTz8OGW+v22UfGm5Rlah36tZq7Ed7Z
         s3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750105951; x=1750710751;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZifEqvGDwliCp9AHnBDWDTDfL/MiV8PCZen/lVHMVPk=;
        b=NgDXQRHaMXmQy2va00wDFX0Qw8VtgA0u5h3bTQAy96bptfbGDxXv2sT8U68xDsn1pC
         tqTCYNuLmSnckNZ+eu3lIgMh3BhV57IXYSybUCCz1h5Vom2ia+XTWSYXN30qm0MFsr56
         mj2wqFoLNRCotRidK6P88dlxc1g8/MsfuTZCupJqzRL6RnPLgvKh3W+UhsQwR/C2gE5i
         ba1YgrPHnaC+LLIgfAGmezX8ZHzE5H33omWGCwib+LFKI/7UwtjxrXWNUXmGvA3f/mZk
         ShjPMMjneJNJjrM4U4IBm5U/OFqTFLAIB6N9OLYYlDTWdTB2bK0Nty3m7S3z/XlZpPTI
         dFjA==
X-Forwarded-Encrypted: i=1; AJvYcCUSGjY/0/HpCdqPlmL1Ifgl2/wx/247pLzBOQa774XxT/9qFrGurNr+BcikG6UjbyLsbVJNcA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGMGyKoA61EFEDn2kxWFKnYpAZDVzTyz7BGzAQXOpJYcmtRf1Y
	y81mZAXalwx4tXJHQZP9UQ2Z1JToCSyyv7mnR8que7BtCIpHOJNwEtG3xRyJkIs0GWgjVse/tiT
	+Zg==
X-Google-Smtp-Source: AGHT+IEns81lD418kj6nrT6kN3Jd+xPiu4d+NAP4MAKFbLH7LDx5ebeDQpv4oXiR30LjJHObKAbtstt/UQ==
X-Received: from pgah22.prod.google.com ([2002:a05:6a02:4e96:b0:b2d:249f:ea07])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fac7:b0:236:6fbb:a5f3
 with SMTP id d9443c01a7336-2366fbba753mr90884305ad.40.1750105950799; Mon, 16
 Jun 2025 13:32:30 -0700 (PDT)
Date: Mon, 16 Jun 2025 20:31:44 +0000
In-Reply-To: <20250616203149.2649118-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250616203149.2649118-1-praan@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250616203149.2649118-4-praan@google.com>
Subject: [RFC PATCH v3 3/8] iommu/tegra241-cmdqv: Add a helper to drain VCMDQs
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

The tegra241-cmdqv driver supports vCMDQs which need to be drained
before suspending the SMMU. The current driver implementation only uses
VINTF0 for vCMDQs owned by the kernel which need to be drained. Add a
helper that drains all the enabled vCMDQs under VINTF0.

Add another function ptr to arm_smmu_impl_ops to drain implementation
specified queues and call it within `arm_smmu_drain_queues`

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  6 ++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 +
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 27 +++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0df1b17a09cc..9ce00c959034 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1018,7 +1018,11 @@ static int arm_smmu_drain_queues(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
-	return 0;
+	/* Drain all implementation-specific queues */
+	if (smmu->impl_ops && smmu->impl_ops->drain_queues)
+		ret = smmu->impl_ops->drain_queues(smmu);
+
+	return ret;
 }
 
 static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 461f1958e574..a950da2e7ed9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -720,6 +720,7 @@ struct arm_smmu_impl_ops {
 	int (*init_structures)(struct arm_smmu_device *smmu);
 	struct arm_smmu_cmdq *(*get_secondary_cmdq)(
 		struct arm_smmu_device *smmu, struct arm_smmu_cmdq_ent *ent);
+	int (*drain_queues)(struct arm_smmu_device *smmu);
 };
 
 /* An SMMUv3 instance */
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index dd7d030d2e89..95d34a8460b5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -349,6 +349,32 @@ tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
 	return &vcmdq->cmdq;
 }
 
+static int tegra241_cmdqv_drain_vintf0_lvcmdqs(struct arm_smmu_device *smmu)
+{
+	struct tegra241_cmdqv *cmdqv =
+		container_of(smmu, struct tegra241_cmdqv, smmu);
+	struct tegra241_vintf *vintf = cmdqv->vintfs[0];
+	int ret = 0;
+	u16 lidx;
+
+	/* Kernel only uses VINTF0. Return if it's disabled */
+	if (!READ_ONCE(vintf->enabled))
+		return 0;
+
+	for (lidx = 0; lidx < cmdqv->num_lvcmdqs_per_vintf; lidx++) {
+		struct tegra241_vcmdq *vcmdq = vintf->lvcmdqs[lidx];
+
+		if (!vcmdq || !READ_ONCE(vcmdq->enabled))
+			continue;
+
+		ret = arm_smmu_queue_poll_until_empty(smmu, &vcmdq->cmdq.q);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
 /* HW Reset Functions */
 
 static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
@@ -681,6 +707,7 @@ static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
 	.get_secondary_cmdq = tegra241_cmdqv_get_cmdq,
 	.device_reset = tegra241_cmdqv_hw_reset,
 	.device_remove = tegra241_cmdqv_remove,
+	.drain_queues = tegra241_cmdqv_drain_vintf0_lvcmdqs,
 };
 
 /* Probe Functions */
-- 
2.50.0.rc2.692.g299adb8693-goog

