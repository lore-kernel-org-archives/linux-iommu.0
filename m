Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292A63AA91
	for <iommu@lists.linux.dev>; Thu, 22 Jun 2023 09:27:58 +0000 (UTC)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 569016607074;
	Thu, 22 Jun 2023 10:27:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1687426077;
	bh=fpJa5/i7ldd76fzTKhs5pEq675tqrNBKbMuRtH+2cEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PDQrVoksQoaveDYzL5XafpXdVJMFaVhnz5DYCBKUIV7azGZHKZn2LmSUSy5uYZNbG
	 1qdJ7W7nL6/ov5F1B3RCBocVeBcv77FqVLZwT3TnU4QEmVaOhFlbD18pcKAjmqFIKR
	 9aKdYlx64bo+YZU0XI0LmZ9KHqod1Anx5FEATyyX+GlpvNawYKn4uhSELASGKfZyiQ
	 DAIN4PTPsm7MvCBfnFKmq5G8clpnGstxQcDM/ipC2IO0sEG5KH7qV5Ko7G8zjGAu86
	 sSjkE8LE2K50HiPpLldLvNmxDIitqG/qNP0h3nwt5ImX9NkvCvfRHdt28VOiQqpTsp
	 4XicTV7w097lw==
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: agross@kernel.org
Cc: andersson@kernel.org,
	luca@z3ntu.xyz,
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
Subject: [PATCH v5 1/6] dt-bindings: iommu: qcom,iommu: Add qcom,ctx-asid property
Date: Thu, 22 Jun 2023 11:27:37 +0200
Message-Id: <20230622092742.74819-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622092742.74819-1-angelogioacchino.delregno@collabora.com>
References: <20230622092742.74819-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new "qcom,ctx-asid" property to force an ASID number on IOMMU
contexts where required.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/iommu/qcom,iommu.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
index d9fabdf930d9..f7a64ad8a005 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
@@ -71,6 +71,11 @@ patternProperties:
       reg:
         maxItems: 1
 
+      qcom,ctx-asid:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          The ASID number associated to the context bank.
+
     required:
       - compatible
       - interrupts
-- 
2.40.1

