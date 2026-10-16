Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BABB3E558F;
	Fri, 16 Oct 2026 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144005; cv=none; b=nVvoZY9++uqM52jGfn+6MpRXInOPjEsnkpwU0CP4sjsabz4BVOv5YQR0Ifq3gUVGfJ9zQ8NoIWtLqofmW+QGUWt9guocTj/zrUdmjk9a2ZAYRyJX/poJkB+vDzLr7rX5LJzAFaflpyvG2meqRPEIPvq5pFuMpUKPPfgiHhyz6Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144005; c=relaxed/simple;
	bh=WN8ne8APJSKDOBLbnZQKiIgT1j4FX2dGzt2uRPetLwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DAN82xHrH/79gYtguf8p+Ey4R6m4x5Q77z+oHQ8XP7uC/7TYXMjS5Z6fvq21aqooK1/mpvTOHpeqCmCkrMU9gA3mSBFNed/LYyc/KDRPf4bOEsaGBHyrmwyrzSXEtxqzjSFni7wrudAWKO5N8+8TWu90wgyEAo24IeP4B3vSDgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoywHDUb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoywHDUb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DAFBC2BCFB;
	Fri, 16 Oct 2026 09:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792144005;
	bh=WN8ne8APJSKDOBLbnZQKiIgT1j4FX2dGzt2uRPetLwk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JoywHDUbBTIXhVgObe6+aS0RoLo4ClD6bdr4JQhQqy0ZJJmt0q+na2AI7VpyBvH+/
	 afzsUpgU5JK5+fmriEddiVYFFLp/zIv8cjhTs17tOS9vME/EHE3MTTXbVbeF1td5PT
	 PDFKoB9UTBMehdWYcm/W4clDpb92qQoZNMS/OQ1oYc+Ew8ttXJe+CGV/SeEfhnh9Xt
	 Tyg8HQ+bQJR0OUsZxpAGXhhc9oN3+o2aIaSoVv9TEjCFTDok+h4rstoqhZmmwEBiky
	 I1rfAgiNvvuJeR3DWMQVpIjnArJ1qf0lQG68cTo4QPESKCB9mrUDsgvqK/jzzzj0RN
	 FUjkwej4aGSzA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D152CCA48B;
	Fri, 16 Oct 2026 09:46:45 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Date: Fri, 16 Oct 2026 15:16:41 +0530
Subject: [PATCH 2/2] iommu/arm-smmu-qcom: Skip PRR setup on SM7250 GPU SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-smmu-sm7250-v1-2-e11fc0384cfa@brar.si>
References: <20261016-smmu-sm7250-v1-0-e11fc0384cfa@brar.si>
In-Reply-To: <20261016-smmu-sm7250-v1-0-e11fc0384cfa@brar.si>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Ishu Brar <patches@brar.si>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792144002; l=1110;
 i=patches@brar.si; h=from:subject:message-id;
 bh=VF/mGbM1EJsewrS92EWhHwKM9QYUxif31RQPsJ22WkY=;
 b=MgCQW+q+gdFxZtCWsk0t82jYnAc0w2/vWkXnNsoCO55m+Zt6MIUZx590bsXBO94tK74UYRbTg
 nMtTRX6V0tsDmJoW4NKUgkU3htbhLWlIwJGie3sIh3NVX6sdywqjsP2
X-Developer-Key: i=patches@brar.si; a=ed25519;
 pk=Ds+E23E3ntzjPzuBDyVRkOouclcNI5k75R+N42yJtCk=
X-Endpoint-Received: by B4 Relay for patches@brar.si/default with
 auth_id=1189
X-Original-From: Ishu Brar <patches@brar.si>
Reply-To: patches@brar.si

From: Ishu Brar <patches@brar.si>

As on SM8250, the firmware on SM7250 resets the device when the Adreno
SMMU PRR registers are written. This happened as soon as the first
per-process GPU pagetable was created. Do not install the PRR
callbacks for the SM7250 GPU SMMU either.

Tested on a OnePlus Nord (SM7250) with Vulkan.

Signed-off-by: Ishu Brar <patches@brar.si>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 795e8ec7e..55071eb03 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -394,6 +394,7 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 	priv->set_prr_addr = NULL;
 
 	if (of_device_is_compatible(np, "qcom,smmu-500") &&
+	    !of_device_is_compatible(np, "qcom,sm7250-smmu-500") &&
 	    !of_device_is_compatible(np, "qcom,sm8250-smmu-500") &&
 	    of_device_is_compatible(np, "qcom,adreno-smmu")) {
 		priv->set_prr_bit = qcom_adreno_smmu_set_prr_bit;

-- 
2.56.0


