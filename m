Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66FB19FA7B
	for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.33.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644020; cv=none; b=IVz54TkaeePICVAzGSpgzPUCQZtULB/8yQ8LQfooynvH+YgH67Fu03AF8T0mfqTqYYTQeyQojAu5OXG7Cc4GqXV7fwxcRnoDNOKc/nQzNm0WMEEvYV1cfd9HeouSnXXcxD9xYJuNfngYsikppccokhhvqJtgVX+Jqr2/BJpHNgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644020; c=relaxed/simple;
	bh=RRdWvaaJjh2EukHMWmy8agmys/TF3UAfdsl3eILq5HQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IRqNBk0hdIivdjks3aLaRfXtAzwOlG99F3wQz3aDJ4sqPN2OHYqIcOwBjSziUrt+Is0KhbeV8iNcysM71Rh/X6aauqHyBceH/i3WW+SWK2iJc/eLboytJ69pNDv+7P+euO2XMw34wqmZlQLIr0MzfRk1UQZ0ONGdZRYgq3Z3tmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=srs.iliad.fr; arc=none smtp.client-ip=212.27.33.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=srs.iliad.fr
Received: from ns.iliad.fr (localhost [127.0.0.1])
	by ns.iliad.fr (Postfix) with ESMTP id DE9D42099D;
	Wed, 14 Aug 2024 16:00:09 +0200 (CEST)
Received: from [127.0.1.1] (freebox.vlq16.iliad.fr [213.36.7.13])
	by ns.iliad.fr (Postfix) with ESMTP id CE1972098C;
	Wed, 14 Aug 2024 16:00:09 +0200 (CEST)
From: Marc Gonzalez <mgonzalez@freebox.fr>
Date: Wed, 14 Aug 2024 15:59:56 +0200
Subject: [PATCH 2/2] iommu/arm-smmu-qcom: hide last context bank from linux
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-smmu-v1-2-3d6c27027d5b@freebox.fr>
References: <20240814-smmu-v1-0-3d6c27027d5b@freebox.fr>
In-Reply-To: <20240814-smmu-v1-0-3d6c27027d5b@freebox.fr>
To: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Arnaud Vrac <avrac@freebox.fr>, 
 Pierre-Hugues Husson <phhusson@freebox.fr>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Marc Gonzalez <mgonzalez@freebox.fr>
X-Mailer: b4 0.13.0

On qcom msm8998, writing to the last context bank of lpass_q6_smmu
(base address 0x05100000) produces a system freeze & reboot.

Specifically, here:

	qsmmu->bypass_cbndx = smmu->num_context_banks - 1;
	arm_smmu_cb_write(smmu, qsmmu->bypass_cbndx, ARM_SMMU_CB_SCTLR, 0);

and here:

	arm_smmu_write_context_bank(smmu, i);
	arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_FSR, ARM_SMMU_CB_FSR_FAULT);

It is likely that FW reserves the last context bank for its own use,
thus a simple work-around would be: DON'T USE IT in Linux.

If we decrease the number of context banks, last one will be "hidden".

Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 7e65189ca7b8c..e2e1fd9e2452b 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -282,6 +282,11 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 	u32 smr;
 	int i;
 
+	if (of_property_read_bool(smmu->dev->of_node, "qcom,last-ctx-bank-reserved")) {
+		dev_warn(smmu->dev, "hiding last ctx bank from linux");
+		--smmu->num_context_banks;
+	}
+
 	/*
 	 * Some platforms support more than the Arm SMMU architected maximum of
 	 * 128 stream matching groups. For unknown reasons, the additional

-- 
2.34.1

