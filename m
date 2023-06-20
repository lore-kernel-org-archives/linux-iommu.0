Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF2E57B
	for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 09:51:34 +0000 (UTC)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 22A376606F8A;
	Tue, 20 Jun 2023 10:51:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1687254693;
	bh=CKq+lIos5lmp5IXI23bezl/YLNmNphPHjGKRjAumT9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c/7ZNKL9oxQI/8GLUCDiY/9wDR41k5QtZxRu6iP6nySvA2m3e2FnZ/JfVrXPZ57aY
	 Xr8XmkJgDhIvImA9ZmX5r+bf2H81btv2TRXrflFw+Gw4HlQjuyjEj2QRuM4iqnnpVt
	 DfDbDWTo7VcuQ7oAReldtF6sSWhmZlniHXUZIEgXsdUcKt0QlugWpalIb9ROBGYnkU
	 e339L2/Mey2des3PqlUxJYwxgg1S1py+4YZnCvrcbQ5phwPWniaSpHiKde9HMiVmJR
	 o6SrjokI91gaCEcfGwJ1k2cuy82bD32RsLabwuFPU50LZQBnazPW9HxO4WqFIhTZj7
	 flNQ7Jn8QEYMw==
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: agross@kernel.org
Cc: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	dmitry.baryshkov@linaro.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	robdclark@gmail.com,
	linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v4 1/6] dt-bindings: iommu: qcom,iommu: Add qcom,ctx-num property
Date: Tue, 20 Jun 2023 11:51:22 +0200
Message-Id: <20230620095127.96600-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620095127.96600-1-angelogioacchino.delregno@collabora.com>
References: <20230620095127.96600-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new "qcom,ctx-num" property to force an ASID number on IOMMU
contexts where required.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/iommu/qcom,iommu.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
index d9fabdf930d9..0446ccc4116e 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
@@ -71,6 +71,11 @@ patternProperties:
       reg:
         maxItems: 1
 
+      qcom,ctx-num:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          The ASID number associated to the context bank.
+
     required:
       - compatible
       - interrupts
-- 
2.40.1

