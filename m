Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA936D3F
	for <iommu@lists.linux.dev>; Fri, 11 Nov 2022 13:55:46 +0000 (UTC)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id A8CB66602A59;
	Fri, 11 Nov 2022 13:55:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1668174938;
	bh=8u6QC8ewCCF44b8mD8drMJBXX7SLVxPYUmHoC5zpU7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m/f3yPgSETReoDHMNiH1LRwE3tpH1o1EmyMH3Q0dnc6yVg30DS5GPvbOtdzfvDCvJ
	 gCf/LuKLQlnckAmR9Ba1jrq3PDZ4XhyF95Em1gz6En6GReyR/j6/dkuCFqkRcREP3c
	 xpSoLkSk1EBjMtqn73/g1bFqVgtApcgETdMUkmJc88HcQFOB3PLN0LqxOoir406tN8
	 xu/qahVv5ltwESbr5JUHwStAj8GweiFut91P6A75Q1QcPUUCDsUQ/1mdkVTKbtH2H1
	 o6PlxlTSviXhUppAq6TYz0AMBvlHHBemuEhL/ESQhN+F+y1hFmvnn7wcZ5eXil49rZ
	 nMkKycZLcMK4Q==
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
Subject: [PATCH 1/7] dt-bindings: iommu: qcom,iommu: Document qcom,ctx-num property
Date: Fri, 11 Nov 2022 14:55:19 +0100
Message-Id: <20221111135525.204134-2-angelogioacchino.delregno@collabora.com>
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

Add a new "qcom,ctx-num" property to force an ASID number on IOMMU
contexts where required.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/iommu/qcom,iommu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
index 059139abce35..7d4e0a18b08e 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
@@ -46,6 +46,7 @@ to non-secure vs secure interrupt line.
                      for routing of context bank irq's to secure vs non-
                      secure lines.  (Ie. if the iommu contains secure
                      context banks)
+- qcom,ctx-num     : The ASID number associated to the context bank
 
 
 ** Examples:
-- 
2.38.1

