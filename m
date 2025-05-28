Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47955145B25
	for <iommu@lists.linux.dev>; Wed, 28 May 2025 00:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748392286; cv=none; b=hRdG53X2nW4uOL040ZW/WoxnlsOdt+zGNo4gqQsoM30bsvkOQ3fMLFFDR9zS7M71PwYPY96ad323PxdhgAIM8mnX3bAjOhRjwPo2RxNHAF8JzOUsSOtp52vAA+IfozF2lkFkvQ0C/4ejWAAqLEvw46GXapyeuPIe+dFca0G3IWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748392286; c=relaxed/simple;
	bh=UuFnSXXlBxca+WgwA6gh5QujHGrR6gMU9Nmu4VYu4/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VFCMPGgKN7C7MPD0hiAjBVyPDAwQ4N2Vz7M6Z9il3RYgKowlDP8BpnN8Uq4Jge7wO8waRBl1K1Qpz5eSNbgulwDFHczJ66nXB92QQA/vNd0nalGWPbjlR4IdxUf8+gXDLuBOZd/Yfpzp/PQqHdCPgs+OHDfd6+x9c4sj/J/X/K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=szaGr8JN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="szaGr8JN"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4c9024117so284924f8f.0
        for <iommu@lists.linux.dev>; Tue, 27 May 2025 17:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748392281; x=1748997081; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gIINLTUaLnUoGc/shiZVTfzJewFDLRIL07KX6BIkMJo=;
        b=szaGr8JNFeD6nFZFWDCjZoyxu1k4G17ZFzH3VGSZ5eIN3C6WO8H+QFqO40H09crioF
         ymydul2B/CSvxrOJ7qcT9eupybnBC0p8u9ATblqAIoTSGMPrVrti6NrRHArTgT6u8iVM
         ztjNmyjRzQFxCmW3KsU84wGa2lH0ob5iJ7lOnfiQXlcItPpcJX0uSiT2u7NJOIZO/wQd
         dEKoR1k21cmSfj1ArMcNKUm8Ae+KNGa6r9+7EbfSXy+5rt/us0YPyfT0uZD5LN+pdoUA
         a2O9jDu8z8j1Q17VjnXVZeGOmnWeGM4uV2LszPiB4ttYCTKMW5Ty3dgY2o/WLVM5t/5y
         6MWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748392281; x=1748997081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gIINLTUaLnUoGc/shiZVTfzJewFDLRIL07KX6BIkMJo=;
        b=KaKOAgcv9u6TiaLvrczplNNl5BuSACHIQWh//9xf2008g1zkhB/usrIOKCDpQmJA/y
         Sp1iAqu6g6L+BeeWZnlvek3FEEdAs8FBkbI4IRmEE3hAyG4QF2hVS3sOyqiqrn1I7dw+
         Np9H/Q4Kc4Zz6deJYZeWaf1mskymvozM94Td3yGgvmX8V/LIRchgRol02U6PYRStkV8k
         JJv/JWysRs9w7IdS/4pBM7Ltz73a2OhuhzaooH1osbOEZ3Y2ndD/6aoWCfWjddk+PDgY
         BSYDpC6++qFTaeG56Y0F/m1jREyQZGfpybTy/qqwCybJa2JX+l/VFG8xJGk9Y/K+TLdL
         l62A==
X-Forwarded-Encrypted: i=1; AJvYcCWFrc2wWyjNHbq+C3Gfu3jzfstCi+xweVLIZyd/g9z8jZDkdwkYeMT2zbDhgr6QmLZndCeM+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjUySyBIpoRl6DsFWC6w33W6tY62t7xD52Mg9cW5tUJ+9LMule
	QLjpUeyhx0pGSb/tFgHKLda+reYrdBTdRBG93eud0CbLkZUS+/6zpvX4hBRDSjZ9gBk=
X-Gm-Gg: ASbGncu0oyqkH+je1jwV8nb7Wwy8065vvbTbH/BhUx8BVtfH5Wz4S+aFq2OYdznI4Lg
	FoxwRpk9W/R0Q7jCxZ9jGnmLBcvZolhjz1bbsxXW9xbuGBUo6eR+tSysNi9m/UcwU//9vdQ24nM
	58ldAHyHDCKW5ZLl5JNWxdMI9vt4Le9Np+7849eHNkxyZXDy/Ql47P/6kFVXMAH7g6cwcMYXex2
	pu5wfDoK3cupGT7iKaGCdfEoKrpAFD1eYku28tL/cpzT9VMJ+Bar500B5mB/QVMEiFh8IPCgCb8
	u3feb71AxiSuq9iC8sWBwz3EGIwrKDCy+aocMt3EZQJ629Qia/9+7lE+Nb4=
X-Google-Smtp-Source: AGHT+IFxSGQLHHLXajXUw+l8QvUa1GNINdp2fs5C70KSEXMnzFvKtHMrwh3iyD2kg9WD2MSpHAJ4sw==
X-Received: by 2002:a05:6000:12ce:b0:3a4:e603:3d2 with SMTP id ffacd0b85a97d-3a4e60303f3mr1695166f8f.0.1748392281383;
        Tue, 27 May 2025 17:31:21 -0700 (PDT)
Received: from orion.home ([2a02:c7c:7213:c700:f024:90b8:5947:4156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4e8bc3444sm431020f8f.64.2025.05.27.17.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 17:31:20 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: robdclark@gmail.com,
	will@kernel.org,
	robin.murphy@arm.com,
	linux-arm-msm@vger.kernel.org
Cc: joro@8bytes.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	andersson@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH] iommu/arm-smmu-qcom: Add SM6115 MDSS compatible
Date: Wed, 28 May 2025 01:31:18 +0100
Message-ID: <20250528003118.214093-1-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the SM6115 MDSS compatible to clients compatible list, as it also
needs that workaround.
Without this workaround, for example, QRB4210 RB2 which is based on
SM4250/SM6115 generates a lot of smmu unhandled context faults during
boot:

arm_smmu_context_fault: 116854 callbacks suppressed
arm-smmu c600000.iommu: Unhandled context fault: fsr=0x402,
iova=0x5c0ec600, fsynr=0x320021, cbfrsynra=0x420, cb=5
arm-smmu c600000.iommu: FSR    = 00000402 [Format=2 TF], SID=0x420
arm-smmu c600000.iommu: FSYNR0 = 00320021 [S1CBNDX=50 PNU PLVL=1]
arm-smmu c600000.iommu: Unhandled context fault: fsr=0x402,
iova=0x5c0d7800, fsynr=0x320021, cbfrsynra=0x420, cb=5
arm-smmu c600000.iommu: FSR    = 00000402 [Format=2 TF], SID=0x420

and also leads to failed initialisation of lontium lt9611uxc driver
and gpu afterwards:

 ------------[ cut here ]------------
 !aspace
 WARNING: CPU: 6 PID: 324 at drivers/gpu/drm/msm/msm_gem_vma.c:130 msm_gem_vma_init+0x150/0x18c [msm]
 Modules linked in: ... (long list of modules)
 CPU: 6 UID: 0 PID: 324 Comm: (udev-worker) Not tainted 6.15.0-03037-gaacc73ceeb8b #4 PREEMPT
 Hardware name: Qualcomm Technologies, Inc. QRB4210 RB2 (DT)
 pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : msm_gem_vma_init+0x150/0x18c [msm]
 lr : msm_gem_vma_init+0x150/0x18c [msm]
 sp : ffff80008144b280
  		...
 Call trace:
  msm_gem_vma_init+0x150/0x18c [msm] (P)
  get_vma_locked+0xc0/0x194 [msm]
  msm_gem_get_and_pin_iova_range+0x4c/0xdc [msm]
  msm_gem_kernel_new+0x48/0x160 [msm]
  msm_gpu_init+0x34c/0x53c [msm]
  adreno_gpu_init+0x1b0/0x2d8 [msm]
  a6xx_gpu_init+0x1e8/0x9e0 [msm]
  adreno_bind+0x2b8/0x348 [msm]
  component_bind_all+0x100/0x230
  msm_drm_bind+0x13c/0x3d0 [msm]
  try_to_bring_up_aggregate_device+0x164/0x1d0
  __component_add+0xa4/0x174
  component_add+0x14/0x20
  dsi_dev_attach+0x20/0x34 [msm]
  dsi_host_attach+0x58/0x98 [msm]
  devm_mipi_dsi_attach+0x34/0x90
  lt9611uxc_attach_dsi.isra.0+0x94/0x124 [lontium_lt9611uxc]
  lt9611uxc_probe+0x540/0x5fc [lontium_lt9611uxc]
  i2c_device_probe+0x148/0x2a8
  really_probe+0xbc/0x2c0
  __driver_probe_device+0x78/0x120
  driver_probe_device+0x3c/0x154
  __driver_attach+0x90/0x1a0
  bus_for_each_dev+0x68/0xb8
  driver_attach+0x24/0x30
  bus_add_driver+0xe4/0x208
  driver_register+0x68/0x124
  i2c_register_driver+0x48/0xcc
  lt9611uxc_driver_init+0x20/0x1000 [lontium_lt9611uxc]
  do_one_initcall+0x60/0x1d4
  do_init_module+0x54/0x1fc
  load_module+0x1748/0x1c8c
  init_module_from_file+0x74/0xa0
  __arm64_sys_finit_module+0x130/0x2f8
  invoke_syscall+0x48/0x104
  el0_svc_common.constprop.0+0xc0/0xe0
  do_el0_svc+0x1c/0x28
  el0_svc+0x2c/0x80
  el0t_64_sync_handler+0x10c/0x138
  el0t_64_sync+0x198/0x19c
 ---[ end trace 0000000000000000 ]---
 msm_dpu 5e01000.display-controller: [drm:msm_gpu_init [msm]] *ERROR* could not allocate memptrs: -22
 msm_dpu 5e01000.display-controller: failed to load adreno gpu
 platform a400000.remoteproc:glink-edge:apr:service@7:dais: Adding to iommu group 19
 msm_dpu 5e01000.display-controller: failed to bind 5900000.gpu (ops a3xx_ops [msm]): -22
 msm_dpu 5e01000.display-controller: adev bind failed: -22
 lt9611uxc 0-002b: failed to attach dsi to host
 lt9611uxc 0-002b: probe with driver lt9611uxc failed with error -22

Suggested-by: Bjorn Andersson <andersson@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 59d02687280e..c919babcea75 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -365,6 +365,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sdm670-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
+	{ .compatible = "qcom,sm6115-mdss" },
 	{ .compatible = "qcom,sm6350-mdss" },
 	{ .compatible = "qcom,sm6375-mdss" },
 	{ .compatible = "qcom,sm8150-mdss" },
-- 
2.47.2

