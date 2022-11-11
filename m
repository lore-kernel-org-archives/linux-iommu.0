Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201151EA11
	for <iommu@lists.linux.dev>; Fri, 11 Nov 2022 14:59:32 +0000 (UTC)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 171966602A5B;
	Fri, 11 Nov 2022 14:59:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1668178770;
	bh=v/SdConwcLDUdB+vnhsUHtZDsg7PCN+jxysiLSvSwfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YuAw4h1USZuYNtGIaP6keEe/eLKOeSIf/5tQleLSFTXcIT42TOAqp9qF+GDluirO4
	 sCWOD1UqLTGVjNYDYV7Q1Qp5Mk0gj2FKqAWqhssUdLm4rLmktjE7r5amdn7qTJAUoe
	 8/1M807zf/RQTpzuJ1hD/XnJUcdnATFONhHpa5NuP1Vbvrn/lJWcoWEw9pryXo+aCO
	 PsP4MwitdKWT28YOvZW6YFTPrDkfwXCPHuknDNKEmX5CkSOyTtWRT4lG5HFYhYzI5d
	 53A/IdpRUNXN2e14DtX3IAI5LbusGdPKLIprYyzqRGNRvnCrqXIYLgX46jGtiIjx7J
	 3ZwBwtb3e2pZA==
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: agross@kernel.org
Cc: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robdclark@gmail.com,
	linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	marijn.suijten@somainline.org,
	kernel@collabora.com,
	luca@z3ntu.xyz,
	a39.skl@gmail.com,
	phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 3/8] iommu/arm-smmu: Add definition for ARM_SMMU_CB_FSRRESTORE
Date: Fri, 11 Nov 2022 15:59:14 +0100
Message-Id: <20221111145919.221159-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111145919.221159-1-angelogioacchino.delregno@collabora.com>
References: <20221111145919.221159-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding a proper context bank reset sequence in
qcom_iommu, add a definition for the implementation defined Fault
Status Restore register (FSRRESTORE).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 703fd5817ec1..5015138799c5 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -219,6 +219,7 @@ enum arm_smmu_cbar_type {
 					 ARM_SMMU_FSR_TF |		\
 					 ARM_SMMU_FSR_IGN)
 
+#define ARM_SMMU_CB_FSRRESTORE		0x5c
 #define ARM_SMMU_CB_FAR			0x60
 
 #define ARM_SMMU_CB_FSYNR0		0x68
-- 
2.38.1

