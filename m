Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC287C
	for <iommu@lists.linux.dev>; Sat,  5 Nov 2022 14:22:06 +0000 (UTC)
Received: from g550jk.. (unknown [46.183.103.8])
	by mail.z3ntu.xyz (Postfix) with ESMTPSA id A961CCE809;
	Sat,  5 Nov 2022 14:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
	t=1667658118; bh=F7ulIQSAklv8bkqHi8uNDnqlnBOKAGuuRsdUaEDvNcQ=;
	h=From:To:Cc:Subject:Date;
	b=fBfkCH8wlinKsUZlhD688lPYWopPmng88j89oXMNUUyJI6gZXV9cGXnh4EdRZlP7p
	 b4DuPvDOFxQoRLG7DXJ+4M21oC46e0whXaR5uN9pGtPCk9TWp+ObJ6SijI6M/BrjvR
	 47YEYzzpY17Rw6qblZEQL6XGti3MsACS7ghTzkQw=
From: Luca Weiss <luca@z3ntu.xyz>
To: iommu@lists.linux.dev
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Luca Weiss <luca@z3ntu.xyz>,
	Rob Herring <robh@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] dt-bindings: iommu: qcom: Add Qualcomm MSM8953 compatible
Date: Sat,  5 Nov 2022 15:20:17 +0100
Message-Id: <20221105142016.93406-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the compatible used for IOMMU on the msm8953 SoC.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v5:
* Change subject so it hopefully gets noticed by iommu maintainers
  (thanks Krzysztof, maybe this helps..)

 Documentation/devicetree/bindings/iommu/qcom,iommu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
index 059139abce35..e6cecfd360eb 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
@@ -10,6 +10,7 @@ to non-secure vs secure interrupt line.
 - compatible       : Should be one of:
 
                         "qcom,msm8916-iommu"
+                        "qcom,msm8953-iommu"
 
                      Followed by "qcom,msm-iommu-v1".
 
-- 
2.38.1

