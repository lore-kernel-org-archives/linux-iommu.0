Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F064C1A612
	for <iommu@lists.linux.dev>; Fri, 11 Nov 2022 13:55:49 +0000 (UTC)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 61DE06602A55;
	Fri, 11 Nov 2022 13:55:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1668174945;
	bh=MdaH8KbjjoGPf2cEN4UiKaUO79dviS/rWyElqvdnnE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cUJeBGFEK9tJM82NFtDomK6VlVFl04kG4uCim8R1xkWipIEew9uQ/HZDFlnir/yqY
	 fGPqhsB+aOqCFVBHhHxodATBSxgl2HIF9+oMqeBpGU8twu4lRcwLkC9g5dKiw8gFNN
	 xxIWq7+MDq9kDBNS+MxMfH3MyyUfBKuIXpjglktShKZYy0qx42pyPiTi3itAC37pbj
	 aclVnOKQUilTgZxJZPPP357Ay8LZaHvPGVvloLylvfoIeA9KmbCtmyB73gyAJbEb2d
	 OvYWNg5LNSK1iE44u+rGx6CtMyYIYJ0o9OLAbbstIoqcee77ZpxI8towd3g9+xvItM
	 w8aeQvrcrnlTg==
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
Subject: [PATCH 7/7] dt-bindings: iommu: qcom,iommu: Document MSM8976 compatible
Date: Fri, 11 Nov 2022 14:55:25 +0100
Message-Id: <20221111135525.204134-8-angelogioacchino.delregno@collabora.com>
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

Add "qcom,msm8976-iommu" to support IOMMUs on this SoC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/iommu/qcom,iommu.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
index b762772f80e7..b7a5822ac00d 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
@@ -9,7 +9,8 @@ to non-secure vs secure interrupt line.
 
 - compatible       : Should be one of:
 
-                        "qcom,msm8916-iommu"
+                        - "qcom,msm8916-iommu"
+                        - "qcom,msm8976-iommu"
 
                      Followed by one of:
 
-- 
2.38.1

