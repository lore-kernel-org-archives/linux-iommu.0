Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D04732E6A2
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 19:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406906; cv=none; b=i+BThVRkAMBEPsEXeBb4HQGA44QLXW5wlMiJxtgVz4AtgBy7T1QyTBy5XDCX+IlUi6xtd2tbgrkS/u3rmmRUKz2IUBfkOEXQzke0Myip2HBQcsAyvlzRvvVo5yxb7Gtw6YuJB7v5g5RKwJa8zXXm8Wq4IBiaNmxEPe4siwEciXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406906; c=relaxed/simple;
	bh=PDmq4yF9OEa+fimKEWUZNpYNfzmH+uTlsvANG9bVB4s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KanUlUPOb/bZzgnaRVTFzmNarolcblXj6jGqZZMN/fyX8Kf2L8esPLjFGq9bG7M9m3uREuojdTFRw+0qGk7E1cC/Jmqm+sbJWMN9V+dAEF0RBKOK+EsZoNQg6oppi7XFB2CT5hfUqxigeVBp6105mZ+N/rdOn/1Qs1xc845svpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Thnp/pwX; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Thnp/pwX"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7bf15b82042so2402385b3a.1
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 11:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763406904; x=1764011704; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ye8CDiB5OVk7oeswPeV4C9Ezd3mpTWuMvHwm5hjTnxI=;
        b=Thnp/pwXhuZgbiQO/eI/gebVk8r4aWKM9fKaq8sKbhQoOWT92I1t5o+wJ2+M48abtm
         Gyn67OxNLYkyx3klbFii6CHNQv4NDUFEGCSlo6vsvaxdsoAlP1CisS/eXmn/emPKBvEG
         X0AIq40McAGZehTfvM+yyeqE8RI0/VzyrzTzDvY72ofgJbYQdB5k1jVN5vS54M8knNbR
         FWAy8TE+qMHZZF2hA0ZAMZirvOyRkcZ1VUHhNU1LrBjAh+XhGU2GhCpt+vvd8wxEhAma
         nylOrFSof78K26Dp6+CNratXFtMhy5HLL4LY/fwMrj7InAYPQuO4D2wR2g4o+lsf223h
         zxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763406904; x=1764011704;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ye8CDiB5OVk7oeswPeV4C9Ezd3mpTWuMvHwm5hjTnxI=;
        b=J+lRgUWoSIaa0HMdXdHVRseRKCIQ30RRaYsua7P4xIypFDKooQgSJZ1TBQAoyLWYrW
         zw/HYqFpKMPjBziXUgUoNh61ePPoqZ4tGAwZuCDu4vZhvGEc9qB7POto2X2GDkynYhtQ
         KNMnyRP8vEYQLwH8LoxKt3WjDXWdEF0FKelvOjBzuTU7A4GIpVK+rK9eXK4bXyTEjoEt
         IciKgBcggeV3ruMdGRL5igDT5aJ7EJScaNb4g2UbTj/gsyK1uyhVPjGTE2aWRkpcorLa
         KrX0kT7FD0aG7/DL5nLHbTyl7465ZDWrl/Ft9Vi6VqtFX+sJL2CRiAv9pXMJzSP18E60
         sTWQ==
X-Gm-Message-State: AOJu0YxoLorI+rFUtYNnH3xc+eowusODKgHk5f5HB+1cGkJCwhlzwYga
	ERzz0+oT+ajLTW4C907qso0fdSGjW1dIzplZxQjE9xkKsc/2YlwvjBjh4RPPOEqZC6SPpH3aiXU
	UFb9hOkVPAMXEehA9YC2vI/7KiBzAAmY+1FFslzGSuDG49j7WpP2aZRU1r4hvT4VN9aOxGzZ6pt
	hhAEpiATnrIxuFl5CSFczQyUrcaAccog==
X-Google-Smtp-Source: AGHT+IHwLX7T1Nxh7+OJcnSL4yufvU8ZqeYQ40pFKtSqcmbku/WP0o1Wd6SZjkl25UfWVIW36lBgNz0wBA==
X-Received: from pge1.prod.google.com ([2002:a05:6a02:2d01:b0:bc1:2894:388])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3951:b0:35d:5d40:6d86
 with SMTP id adf61e73a8af0-35d5d40750amr10939612637.40.1763406903439; Mon, 17
 Nov 2025 11:15:03 -0800 (PST)
Date: Mon, 17 Nov 2025 19:14:28 +0000
In-Reply-To: <20251117191433.3360130-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251117191433.3360130-1-praan@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251117191433.3360130-4-praan@google.com>
Subject: [PATCH v4 3/8] iommu/tegra241-cmdqv: Add a helper to drain VCMDQs
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

The tegra241-cmdqv driver supports vCMDQs which need to be drained
before suspending the SMMU. The current driver implementation only uses
VINTF0 for vCMDQs owned by the kernel which need to be drained. Add a
helper that drains all the enabled vCMDQs under VINTF0.

Add another function ptr to arm_smmu_impl_ops to drain implementation
specified queues and call it within `arm_smmu_drain_queues`.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  6 ++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 +
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 27 +++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c50cd975920e..31041ce93e03 100644
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
index b52ea821361e..2db0ec14b2ed 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -732,6 +732,7 @@ struct arm_smmu_impl_ops {
 	size_t (*get_viommu_size)(enum iommu_viommu_type viommu_type);
 	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
 			  const struct iommu_user_data *user_data);
+	int (*drain_queues)(struct arm_smmu_device *smmu);
 };
 
 /* An SMMUv3 instance */
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 378104cd395e..de15bc44f9b3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -416,6 +416,32 @@ tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
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
 
 /*
@@ -846,6 +872,7 @@ static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
 	.get_secondary_cmdq = tegra241_cmdqv_get_cmdq,
 	.device_reset = tegra241_cmdqv_hw_reset,
 	.device_remove = tegra241_cmdqv_remove,
+	.drain_queues = tegra241_cmdqv_drain_vintf0_lvcmdqs,
 	/* For user-space use */
 	.hw_info = tegra241_cmdqv_hw_info,
 	.get_viommu_size = tegra241_cmdqv_get_vintf_size,
-- 
2.52.0.rc1.455.g30608eb744-goog

