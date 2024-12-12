Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CB923EC08
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 18:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026779; cv=none; b=Hj93vYpDMi5djfJuDlf5YQ+iSUaRIIsRUfJqDDFbXPfKSCz5vNKR4YkwNh/vGsGr0+ZLS7BFtkUnyUOTpCiPmqVWEecpPBblkVHfBbYFVjg9k5sGLvWVWrct+T+gzWPv6GBWoOpitUWKZiSjf7BZSOfY3IiG/MGvqoHM2ifmgOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026779; c=relaxed/simple;
	bh=nldh58rc77hsjw5gSEOSIIELaTF6Cfi2Rvy9VG/QlTM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J52gyF0sRJpF1ziXC6bZrHwfHOmlFJmaKUno+VUd1V6/RxEyrjp47sazhbw6Aw5LPBRAo9osn6VqYgAnEuRz1YXvHljcFDxIQd+VXqjvkGPKnzuOjWyfjLEpnSr0esnyiCZTFB9Wx/TBkD9oFpfQaqZpxCZORJaFlrfLF+vu0x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D0stwn9D; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D0stwn9D"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4361d4e8359so7199765e9.3
        for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 10:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026776; x=1734631576; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iyTqVJhMppnYdv5NSdPsxpiQh63AvYUQ+byd2sEa6to=;
        b=D0stwn9Dc4sdvduOnQ+M+d4dGlDgnqM0EUjRR/XnMjsOAHa0avx2ac+oQ7tEdG1jzv
         IoVMPZlo0uZ91cG1QwuYClfMhm2Uom5h0Uyf+RDf+MwXNslmSO7B3KFFmZsdphYv/MRD
         5f71ztqW9ezU0uUJvdebTCf03bbFsx1SBDXdl7REzAoPv1CnpLfJSQ/kiI0S2Q0RYtPv
         3vcdIJLFTAXw5FiMq3e5hi+eDyUDffaH+hfcgkwseCLBMuK41wcPS6VG/sSxFlmLJnQ8
         PWtun2x/7RtIVhdsYV1VtvE5WPJCStS3FwJVhcSYoi93KEEHYbNBOYtMLs7rwwhaK2fk
         uU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026776; x=1734631576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iyTqVJhMppnYdv5NSdPsxpiQh63AvYUQ+byd2sEa6to=;
        b=jLp1Rx3pMjZ1NHOw6eqlHDx3b2jxIT2NYUgA8Qy+Ihg6A+gg8OWx3yNo87kaJelhi+
         2Uz0ZeVfULEylJw2E62vQWUpfaDt5l16aP9+J/IG/E1dtun7/ayG2kICmeZrEVo9GyEN
         ebiXvoF5QZduauNlvhggyW1koZoEW941uYEvv/0swNmTBlukyBwp8NmPrU/0USyk2dUu
         KHUJcvf8V0XXJ0EYk1+RshZCDt0hWBMdPVyBikVN42HjMWb1lJdY3621lANiG/0TN5hk
         RxLLEtdp7u7fp5G1XR/OjEp20RPvK2L4A1hZuLDtSegKYw3K2UQ6df4N/Z15NiJCAJ4t
         URvQ==
X-Gm-Message-State: AOJu0YzFMq0+33sBWbAHBdQ3DaPIjSsdE815aoLgv1vYS1e1N5KQNJ3r
	cnSjdPfzRgSBKyTFn5FU4Wp+Y33pyRY2L3cnfN55QuEcHQ0FDXtycsmImDPqXHCQUll0DGMtPQs
	4ob/dh/hF285qyRCN3qW25TSiyqCfLuP5mymnPQtmPZsLYATJFp1PYrad2BAIaNnoto/6HjHAGo
	rE6X9j+CPqQYikGYtdUYqRgKQJtWNAUZ2sKHrM8MD9hQ==
X-Google-Smtp-Source: AGHT+IFG8WA1Z2ObHa4JSTh7ZOJd26fn3uY6Vzk1iSlEnJuugWr6UhUgo2xrrDlr60JHvwlglh6D+X+h9Bswrg==
X-Received: from wmgf12.prod.google.com ([2002:a05:600c:154c:b0:42c:bfc2:aa72])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:64af:0:b0:385:f7ea:eb86 with SMTP id ffacd0b85a97d-38787685119mr4003192f8f.7.1734026775884;
 Thu, 12 Dec 2024 10:06:15 -0800 (PST)
Date: Thu, 12 Dec 2024 18:04:08 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-45-smostafa@google.com>
Subject: [RFC PATCH v2 44/58] iommu/arm-smmu-v3-kvm: Validate device features
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, robdclark@gmail.com, joro@8bytes.org, 
	robin.murphy@arm.com, jean-philippe@linaro.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, vdonnefort@google.com, qperret@google.com, 
	tabba@google.com, danielmentz@google.com, tzukui@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

The KVM hypervisor driver supports a small subset of features. Ensure
the implementation is compatible, and disable some unused features.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
index e2d9bd97ddc5..4b0c9ff6e7f1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
@@ -27,6 +27,45 @@ static size_t				kvm_arm_smmu_cur;
 static size_t				kvm_arm_smmu_count;
 static struct hyp_arm_smmu_v3_device	*kvm_arm_smmu_array;
 
+static bool kvm_arm_smmu_validate_features(struct arm_smmu_device *smmu)
+{
+	unsigned int required_features =
+		ARM_SMMU_FEAT_TT_LE;
+	unsigned int forbidden_features =
+		ARM_SMMU_FEAT_STALL_FORCE;
+	unsigned int keep_features =
+		ARM_SMMU_FEAT_2_LVL_STRTAB	|
+		ARM_SMMU_FEAT_2_LVL_CDTAB	|
+		ARM_SMMU_FEAT_TT_LE		|
+		ARM_SMMU_FEAT_SEV		|
+		ARM_SMMU_FEAT_COHERENCY		|
+		ARM_SMMU_FEAT_TRANS_S1		|
+		ARM_SMMU_FEAT_TRANS_S2		|
+		ARM_SMMU_FEAT_VAX		|
+		ARM_SMMU_FEAT_RANGE_INV;
+
+	if (smmu->options & ARM_SMMU_OPT_PAGE0_REGS_ONLY) {
+		dev_err(smmu->dev, "unsupported layout\n");
+		return false;
+	}
+
+	if ((smmu->features & required_features) != required_features) {
+		dev_err(smmu->dev, "missing features 0x%x\n",
+			required_features & ~smmu->features);
+		return false;
+	}
+
+	if (smmu->features & forbidden_features) {
+		dev_err(smmu->dev, "features 0x%x forbidden\n",
+			smmu->features & forbidden_features);
+		return false;
+	}
+
+	smmu->features &= keep_features;
+
+	return true;
+}
+
 static int kvm_arm_smmu_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -71,6 +110,9 @@ static int kvm_arm_smmu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (!kvm_arm_smmu_validate_features(smmu))
+		return -ENODEV;
+
 	platform_set_drvdata(pdev, smmu);
 
 	/* Hypervisor parameters */
@@ -79,6 +121,7 @@ static int kvm_arm_smmu_probe(struct platform_device *pdev)
 	hyp_smmu->ias = smmu->ias;
 	hyp_smmu->mmio_addr = ioaddr;
 	hyp_smmu->mmio_size = size;
+	hyp_smmu->features = smmu->features;
 	kvm_arm_smmu_cur++;
 
 	return arm_smmu_register_iommu(smmu, &kvm_arm_smmu_ops, ioaddr);
-- 
2.47.0.338.g60cca15819-goog

