Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A684B1B1429
	for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.33.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644022; cv=none; b=h1Kt9y+cTLmfLP3ihDAflploN0hedeGDDUrXdatVDiCOBKY4KMjKpMjBP4y2+kWJWZuTwBXZdzsTxwQF9dNAwXJzHlgTdT+fI7+eZktWjW67cvJtmvPC/VpbxLNrDwH2GtgZyD0P12uDXNAbEI2Vm2VfxTbKPZNTbFMmjDuT6XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644022; c=relaxed/simple;
	bh=QcdrQflkqdM2QB3XA57RYn9/8XtctAhkT4I5lXhNgx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OrcPF3QWEblRqZDcxBKzkC7UsRrEwzYCdak1XRN6bPTUWqy8Lc5pZE0Hvd2fI04bL04Tn8kYa1avHU5SG3qegNog0/Dh283NQPVfzOppWntqbM/qLVollGDCh1r0MMVuk1P/01FZqMW9ZxnyS4EjIpSFRacaI4gP/wQVSHwKffw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=srs.iliad.fr; arc=none smtp.client-ip=212.27.33.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=srs.iliad.fr
Received: from ns.iliad.fr (localhost [127.0.0.1])
	by ns.iliad.fr (Postfix) with ESMTP id D8CC220998;
	Wed, 14 Aug 2024 16:00:09 +0200 (CEST)
Received: from [127.0.1.1] (freebox.vlq16.iliad.fr [213.36.7.13])
	by ns.iliad.fr (Postfix) with ESMTP id C755720989;
	Wed, 14 Aug 2024 16:00:09 +0200 (CEST)
From: Marc Gonzalez <mgonzalez@freebox.fr>
Date: Wed, 14 Aug 2024 15:59:55 +0200
Subject: [PATCH 1/2] dt-bindings: arm-smmu: Add qcom,last-ctx-bank-reserved
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-smmu-v1-1-3d6c27027d5b@freebox.fr>
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

Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 280b4e49f2191..f9b23aef351b0 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -204,6 +204,12 @@ properties:
       access to SMMU configuration registers. In this case non-secure aliases of
       secure registers have to be used during SMMU configuration.
 
+  qcom,last-ctx-bank-reserved:
+    type: boolean
+    description:
+      FW reserves the last context bank of this SMMU for its own use.
+      If Linux tries to use it, Linux gets nuked.
+
   stream-match-mask:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |

-- 
2.34.1

