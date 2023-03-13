Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5EA2F21
	for <iommu@lists.linux.dev>; Mon, 13 Mar 2023 16:47:52 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id r27so16507274lfe.10
        for <iommu@lists.linux.dev>; Mon, 13 Mar 2023 09:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678726070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4lJzMktySZ0YxvT+SDsY5Au8uqrj62Y3kZlZfPHm68=;
        b=boTrP5jaTP5wbIyFAyc03VKpGq56wxAv8y3L6JK0HhCtMKCnCthoms15u9UxecLN1e
         zO+GLo35CV/xwd4jRcYV+6qAMKphmk1A2t8bxwScOYnI4pLfgwgMMPRFj9/mvGHdN/bw
         TSWSLqguTDna1QHgFLsOgn/64c+hd/FskGqHoWdetzK/6QPRYTrqzb/PgcfzdOePvhTV
         nyFuUfJFhJDs91+c9L74CpQ+im87k6prJymi0lKp6M5gs3gi5fZnfpbGve0LinigAV8X
         HYdkCCYbGuVYt2hK7JJH0oZksyi9Yshi94hPF6hsfxToOa1ZypSlWinG/JnxA1TEMZNr
         4pvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678726070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4lJzMktySZ0YxvT+SDsY5Au8uqrj62Y3kZlZfPHm68=;
        b=ZcVQ483HdqF8hwuuFCaL0sQee2o6KK97cOzk4IqNxu8UfVN7zL93cBLveypT9Rj9b9
         NDwStjc4gymClvI7R+trOBBu6pm45urcbPy3NVNbDmtPstUnrypSOZ25TItKb57EcMKZ
         60dFBVpKFCsfP03JNRk2+cPNnsC+94UYkphP49w/U4TEuxfOGz412Fs+z0xLXeTd5VDM
         PYXrjCf9MIT5t4sj6CztUmgWef0YVzOO6dhlWoJheuAhX9BKYCHIk4MPvKzVbOYjjC4+
         zmpqAMqopN6y5KVpm4QERkvsNEAh4Kbb5xD5aYokwEyjwS2Gnf1t2z89sJKN8zdtuxp+
         P4Tg==
X-Gm-Message-State: AO0yUKV3RKvw+1faBXncoRgMcdQORoQ/QGZDMOGBegkEMYL+eV2OngCI
	M354ct7pZqqoMzgDb3/NFMs8nA==
X-Google-Smtp-Source: AK7set8L7Mi+oCmpNq3mMebZrFl48jgH+xxOHYNzhp0MzeC9VmghXRGFTN0tznCtAYLpNwWejAPA+Q==
X-Received: by 2002:ac2:5106:0:b0:4db:3a92:2c85 with SMTP id q6-20020ac25106000000b004db3a922c85mr10136348lfb.67.1678726070516;
        Mon, 13 Mar 2023 09:47:50 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id o9-20020a05651238a900b004db48ae69cbsm18134lft.206.2023.03.13.09.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 09:47:50 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 13 Mar 2023 17:44:16 +0100
Subject: [PATCH v3 1/6] dt-bindings: arm-smmu: Use qcom,smmu compatible for
 MMU500 adreno SMMUs
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230313-topic-gpu_smmu_bindings-v3-1-66ab655fbfd5@linaro.org>
References: <20230313-topic-gpu_smmu_bindings-v3-0-66ab655fbfd5@linaro.org>
In-Reply-To: <20230313-topic-gpu_smmu_bindings-v3-0-66ab655fbfd5@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678726067; l=1686;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=w5BAPOiJsD8VMYsyYwieokILoy0RKIWq1n3EcNs9gfQ=;
 b=byr01MF2m7kfZjSutcFjM0A9eVqAI6FA1nVnvJNjcUzTwQWw3sBBCrUPKus0GYr/kwM1H/FC/ATf
 03em/rC4AziS0Q7TxG9YIjPp9C2QEiMb22PGrLeX+BXKvOO2MPSC
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

qcom,smmu-500 was introduced to prevent people from adding new
compatibles for what seems to roughly be the same hardware. Use it for
qcom,adreno-smmu-compatible targets as well.

While at it, fix the "arm,smmu-500" -> "arm,mmu-500" typo in the comment.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 807cb511fe18..40f91a2e5f3a 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -75,9 +75,19 @@ properties:
               - qcom,sm8350-smmu-500
               - qcom,sm8450-smmu-500
           - const: arm,mmu-500
-
-      - description: Qcom Adreno GPUs implementing "arm,smmu-500"
+      - description: Qcom Adreno GPUs implementing "qcom,smmu-500" and "arm,mmu-500"
+        items:
+          - enum:
+              - qcom,sc7280-smmu-500
+              - qcom,sm8150-smmu-500
+              - qcom,sm8250-smmu-500
+          - const: qcom,adreno-smmu
+          - const: qcom,smmu-500
+          - const: arm,mmu-500
+      - description: Qcom Adreno GPUs implementing "arm,mmu-500" (legacy binding)
+        deprecated: true
         items:
+          # Do not add additional SoC to this list. Instead use previous list.
           - enum:
               - qcom,sc7280-smmu-500
               - qcom,sm8150-smmu-500

-- 
2.39.2

