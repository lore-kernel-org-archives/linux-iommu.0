Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5405B1A635
	for <iommu@lists.linux.dev>; Fri, 11 Nov 2022 13:55:48 +0000 (UTC)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 30BF46602A5C;
	Fri, 11 Nov 2022 13:55:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1668174943;
	bh=Zf7m6jLp2JACg2AkUZYo4eLC63C+UuS3mbPUkyrlclQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BPprOpb8mi3DmWEWvZ12B4yp7ibqJPZBoEBxhEIVSFmWqYAPhsNyS+8YW/Gqa4sP+
	 u3pKvDOTYeS6M53Ui+0IilQ46cSjbkzd+qAmyDakpo/zaX6Jid4O+/NfWyHhjEEH0G
	 AgChFR0zIvF0JO8LiO8Vmru5hqTLL75ATuJyWPD52NFIXtEj/9l8mxxIZOSuYQUacX
	 hpgXR4av8vVXYu8GnQ6nxfdnE8CYNA+U5mtv079QyWCjy6vqCT+XBlTgBOxIu7oXEh
	 nzOSIp7+mm6dvD3wCNrskSh53FzdTf1WSR+5O+LU2W6RuH80GtBOTw8KfzGbPEvUPm
	 Wpqsi3OISLNFw==
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
Subject: [PATCH 5/7] dt-bindings: iommu: qcom,iommu: Document QSMMU v2 compatibles
Date: Fri, 11 Nov 2022 14:55:23 +0100
Message-Id: <20221111135525.204134-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111135525.204134-1-angelogioacchino.delregno@collabora.com>
References: <20221111135525.204134-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible strings for "qcom,msm-iommu-v2" for the inner node,
"qcom,msm-iommu-v2-ns" and "qcom,msm-iommu-v2-sec" for the context
bank nodes to support Qualcomm's secure fw "SMMU v2" implementation.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/iommu/qcom,iommu.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
index 7d4e0a18b08e..b762772f80e7 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
@@ -11,7 +11,10 @@ to non-secure vs secure interrupt line.
 
                         "qcom,msm8916-iommu"
 
-                     Followed by "qcom,msm-iommu-v1".
+                     Followed by one of:
+
+                        - "qcom,msm-iommu-v1"
+                        - "qcom,msm-iommu-v2"
 
 - clock-names      : Should be a pair of "iface" (required for IOMMUs
                      register group access) and "bus" (required for
@@ -36,6 +39,8 @@ to non-secure vs secure interrupt line.
   - compatible     : Should be one of:
         - "qcom,msm-iommu-v1-ns"  : non-secure context bank
         - "qcom,msm-iommu-v1-sec" : secure context bank
+        - "qcom,msm-iommu-v2-ns"  : non-secure QSMMUv2/QSMMU500 context bank
+        - "qcom,msm-iommu-v2-sec" : secure QSMMUv2/QSMMU500 context bank
   - reg            : Base address and size of context bank within the iommu
   - interrupts     : The context fault irq.
 
-- 
2.38.1

