Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9486A86ADC;
	Sat, 25 May 2024 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716659644; cv=none; b=YNNeFeRk5rH+JCHKVROjWztaLjan/bychKGcXt5Rep951AFoP2PeometjladAb6oB/7yw3Wh2htwtDOBkigkk0UXWyJZgTD+zeXJrxy9kMtxKeGqRQw2iZrAW9qKFEYMr31rHY+rmDw8pCwrhnUec7dvd1E9mSPiGwYUN7K8+kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716659644; c=relaxed/simple;
	bh=/9E54IUa5vKqZmcSc3DLwHGDSPhA2ETj0P/v7ZZUru0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ljic0iIM50V98u2tLBCMdCdX4qtHhJ1huJcwTKf8q0tpIKfqUmO/zixnKqhqAMzFaqXfis5iN5vBGDn3m5vkXyCrkOuo9Kb3xAzsGiBjYxy3tfNWd7EUyLeYX7WGmszJtbBRCzZqFKPiUCPSXdyMVJDBOVxWdW1R7wYt7XL9VME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkZP4p+C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkZP4p+C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621E2C2BD11;
	Sat, 25 May 2024 17:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716659644;
	bh=/9E54IUa5vKqZmcSc3DLwHGDSPhA2ETj0P/v7ZZUru0=;
	h=From:Date:Subject:To:Cc:From;
	b=dkZP4p+CKgUo2frJeR4ZNrwFaSroISb/+RALAfMT+9P7Qn3o1Fcho4RomV6G1SZ7S
	 AJCsj7mJvISR6+qDxDakuqufuUTgKWIVZ7q27lRjh5fp8LJvNGbty4Qj5BYVwO0908
	 DZpHIKMdtx/b/Pm7F3VQEzKsdnPbvXb8G9YdSf/1MbccBpJgcb5VIoA6ivCGJ96lew
	 WTI60mWQdDv/f2P0MCTxEP/ffXOf8ZK3ZZ8d8mPa7669LkyPQhIGT2tArUU7wGverI
	 2VluggiTpVRdSNabE1KehI60K+rr31FGIZ44DvLU4hXj78QpUhfNPF9R+qFv+NdW6F
	 R4nHQSKxPbMGw==
From: Bjorn Andersson <andersson@kernel.org>
Date: Sat, 25 May 2024 10:58:52 -0700
Subject: [PATCH] dt-bindings: arm-smmu: Fix Qualcomm SC8180X binding
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240525-sc8180x-adreno-smmu-binding-fix-v1-1-e3c00aa9b9d4@quicinc.com>
X-B4-Tracking: v=1; b=H4sIANsmUmYC/x2NywqEMAwAf0VyNtCHYtlfEQ+1jZqDcWlQBPHft
 +xx5jDzgFJhUvg0DxS6WPmQCrZtIG1RVkLOlcEZ15ne9agp2GBujLmQHKj7fuLMkllWXPhGb/1
 gbAqdjwPUyrdQ1f/DOL3vDy3NWTNxAAAA
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1620;
 i=quic_bjorande@quicinc.com; h=from:subject:message-id;
 bh=uqLaeur6Ki8/NC3RQKXPLAWlmHc2yAqNwMSVoGUCLyU=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBmUibc0PlVG63qaFlnc+puNVGs19t2Z7OG+HJS8
 FjWRWn9bi2JAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZlIm3BUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcWZJBAAtDfq5SYykwEK4mJdGQCrC4NB/TIa/FtbhGBXcsg
 YKsSK8uGfNsIZoecNB6CeCIhV35y6FzOljAdXNRmXUetjz8kdLUxHKUx6X9BBRiiJcqp8MITh6+
 WdjIva44w+5tKxoGrSn1y5j7vGAjmRf8UXuYUFQpvx0MiVqjpFuXFyUFZWrFBI+CBiawWNOzna1
 EgrkDbGZ7SRUNB8I4wGC010Z8L6xO1+BmlXm/5nCKv+LPxCNCT7NB5PGfpklWZixrywihLu1sB7
 y49ZSgfpTsS87yYvlkojkWbS/SjtS/4wDo+CQa8Qpw9SzOa9M8Y5/6DWGPwe4NNhd4KI6HA9N2N
 GV17QHtwlxEdZse+niZsCPWHcUyaaRQxDZOlNPZOR04VDsmAdo/ee9IpJLC26WMt5US9FxR5oix
 xTxn2R6pAUKL+6PgEwMZlkB7qu+RgvJ53iIIZ8vQY9CTefqe/AdUxcyjPinl3EAICyjI2vPC4oz
 CWlxxxJP+RSn/eKC6X9xYlaAt8t5VCuG7hiWjsMI7TeR8lbHajUXt+FjAAL9+4xXS1p3xT/BJw9
 CmzECvcD/8RiXlgY3mxMkp+6vzwSiPQlRKSSlPrHi9ztU6qVNlcZBTGVD5NgYjFUsJdzyki5S/I
 kbUf+sRdU9TXtYvY2lDRK3sEafmi6UgwjV8iJGKPwCVY=
X-Developer-Key: i=quic_bjorande@quicinc.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5

From: Bjorn Andersson <quic_bjorande@quicinc.com>

Update the Qualcomm SC8180X SMMU binding to allow describing the Adreno
SMMU, with its three clocks.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 5c130cf06a21..7f584ce4bb22 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -86,6 +86,7 @@ properties:
               - qcom,qcm2290-smmu-500
               - qcom,sa8775p-smmu-500
               - qcom,sc7280-smmu-500
+              - qcom,sc8180x-smmu-500
               - qcom,sc8280xp-smmu-500
               - qcom,sm6115-smmu-500
               - qcom,sm6125-smmu-500
@@ -415,6 +416,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,sc8180x-smmu-500
               - qcom,sm6350-smmu-v2
               - qcom,sm7150-smmu-v2
               - qcom,sm8150-smmu-500
@@ -550,7 +552,6 @@ allOf:
               - nvidia,smmu-500
               - qcom,qdu1000-smmu-500
               - qcom,sc7180-smmu-500
-              - qcom,sc8180x-smmu-500
               - qcom,sdm670-smmu-500
               - qcom,sdm845-smmu-500
               - qcom,sdx55-smmu-500

---
base-commit: 3689b0ef08b70e4e03b82ebd37730a03a672853a
change-id: 20240525-sc8180x-adreno-smmu-binding-fix-313701c843a7

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>

