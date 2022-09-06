Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E162786D9
	for <iommu@lists.linux.dev>; Tue,  6 Sep 2022 18:44:03 +0000 (UTC)
Received: from g550jk.arnhem.chello.nl (31-151-115-246.dynamic.upc.nl [31.151.115.246])
	by mail.z3ntu.xyz (Postfix) with ESMTPSA id 4F638C761F;
	Tue,  6 Sep 2022 18:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
	t=1662489316; bh=8D02+hHtP3O+A5EfJrULu2835893cFwV9lamnSBN2kI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qmC8T6uTSfeYva6WHMV0gTAvdHS/OBauEjcOB1n58WRDfp14woU9do0OlHqNsaV3B
	 L6I9MznFtU0JAVQTP8M66VF8vMT3+3f0z9Ml76JnLdX4IpdJgj4Zqbt/5cIrQ9pWTr
	 6ucejJrdepQbff+BwVbixbo3FDyqgB4VBxeOsNRY=
From: Luca Weiss <luca@z3ntu.xyz>
To: linux-arm-msm@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Luca Weiss <luca@z3ntu.xyz>,
	Rob Herring <robh@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: qcom-iommu: Add Qualcomm MSM8953 compatible
Date: Tue,  6 Sep 2022 20:33:32 +0200
Message-Id: <20220906183334.203787-2-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220906183334.203787-1-luca@z3ntu.xyz>
References: <20220906183334.203787-1-luca@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the compatible used for IOMMU on the msm8953 SoC.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes since v2:
- pick up tags

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
2.37.3

