Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC40291A
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 10:11:40 +0000 (UTC)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 459CA6602A42;
	Tue, 15 Nov 2022 10:11:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1668507099;
	bh=kUmZntOaNS58hkdHxPrKPiFeJBwDFkyN8sXE3Rzt6Xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R9f0SOhbFqDIhwFe9Bs0a+DQ7S6lr8+SQj/vjvIjhlQZs+tpDyXZH6Lr7sDiqWj7L
	 yeq0DiUsiNpw6TigMh5ubF0Y0hCmZW23CP+YSVwM0qyi3e7vhiHTODhCMfr/zZIXQR
	 kj9/+sn1yAz+ZrIgT3G8tAPIaozxme0LbdqdQIENM/LdqnzUxDh42ysOMJFGVO/yii
	 9HVZ/ceu02M7bugjqmTmzddvRKv+/sGCvUJAh+RcviMwGvr4LXAEPjB1a6Ar609fvB
	 AAXBZBJh2YOFEcvqbcM0fEFPm33PB+MddZMgNih7b+AJ1o+/ySyls8O42VH985hO8+
	 QHCH/Wp1hUsow==
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
Subject: [PATCH v3 5/6] dt-bindings: iommu: qcom,iommu: Document QSMMUv2 and MSM8976 compatibles
Date: Tue, 15 Nov 2022 11:11:21 +0100
Message-Id: <20221115101122.155440-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115101122.155440-1-angelogioacchino.delregno@collabora.com>
References: <20221115101122.155440-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible strings for "qcom,msm-iommu-v2" for the inner node,

Add compatible string "qcom,msm-iommu-v2" for the inner node,
along with "qcom,msm8976-iommu" as a first user of it and
"qcom,msm-iommu-v2-ns" and "qcom,msm-iommu-v2-sec" for the context
bank nodes to support Qualcomm's secure fw "SMMU v2" implementation.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/iommu/qcom,iommu.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
index 7d4e0a18b08e..a8b42fa45e2d 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
@@ -13,6 +13,12 @@ to non-secure vs secure interrupt line.
 
                      Followed by "qcom,msm-iommu-v1".
 
+                     Or it should be one of:
+
+                        "qcom,msm8976-iommu"
+
+                     Followed by "qcom,msm-iommu-v2".
+
 - clock-names      : Should be a pair of "iface" (required for IOMMUs
                      register group access) and "bus" (required for
                      the IOMMUs underlying bus access).
@@ -36,6 +42,8 @@ to non-secure vs secure interrupt line.
   - compatible     : Should be one of:
         - "qcom,msm-iommu-v1-ns"  : non-secure context bank
         - "qcom,msm-iommu-v1-sec" : secure context bank
+        - "qcom,msm-iommu-v2-ns"  : non-secure QSMMUv2/QSMMU500 context bank
+        - "qcom,msm-iommu-v2-sec" : secure QSMMUv2/QSMMU500 context bank
   - reg            : Base address and size of context bank within the iommu
   - interrupts     : The context fault irq.
 
-- 
2.38.1

