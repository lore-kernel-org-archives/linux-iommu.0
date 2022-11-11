Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44289375
	for <iommu@lists.linux.dev>; Fri, 11 Nov 2022 00:36:16 +0000 (UTC)
Received: by mail-il1-f180.google.com with SMTP id e19so1887163ili.4
        for <iommu@lists.linux.dev>; Thu, 10 Nov 2022 16:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQmrxV8UAMx8aTkAdlv23yBJFQlgUNmii3sTAapLgyI=;
        b=By+u2s1zlMxrmcdLwoh001J8SribOcDyS7nZQpDSP6pEnWTPhIXGqKuoKdGgpVx0Ie
         m9KJiuMqABLulmOmezG5pmPlNwYgZz2dNc58kHp69zkdV7Vf7VQ/tqcoJAsAqdq5N2K2
         xI4u+XXNwkDCUBO+M19sMqbJnBHSz7Tim6llxRDwJUbAl3QN7Ph6vy4bmM1M9gN5mgwv
         bh6VjwDQsLjHK4hUwgnRm3BpS7JwW2ForNcfI+3y//TYLxQZtiuE9srQqdq1Oxl4jCtt
         HOiE/lv21om+670aij+fQ33k9rW5YUlTfavlSPgA2ky55GCsbQuLPYejHmg57/YUhk9s
         Hbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQmrxV8UAMx8aTkAdlv23yBJFQlgUNmii3sTAapLgyI=;
        b=ddoEJd/JuS5H7AoZqR9oKkEOYsj3KqAfhea1z1vXpAsHh45DnC0PC2nMG/l01y/bQg
         iOvBDApwPUPt0vWmpYM5g/ah09waJ0FzXTADRfsacdqApPLD4BUKaXEFZNM1Ijvj1aCQ
         jOoP5BHpgh4/t6LglV/Z61gDae1T5z3yh5DGa0agu957f+8oTZd/IQ4T2ieb0hTX7X2h
         zEfQQeDleYhTTfER9IAyxS4QK/tIF3rrw0HNmle6fo/WQFxNDCEBYqSvAlmAguJj+kQ/
         TcXQZ64JY782T2vSi7t0WJW8YcEWB5vBE1JRqWbpHZiv+8bKazNTx3uAXoSIHFi9w+RQ
         DAxA==
X-Gm-Message-State: ACrzQf0ddEoCRlJOUdT/MkdI2Y4GBhMtV82eCX8sy1/MK8AP0e4purYj
	uKz2cfQRz65q4Cqv061XwGs=
X-Google-Smtp-Source: AMsMyM71OO5VNIX7PmdMMq8lznWfKCNntmbM6yx3dhGyaXm81q8wjDKI1gErrOmwXTLw7P4RV00jPQ==
X-Received: by 2002:a92:d909:0:b0:2ff:e1b0:b150 with SMTP id s9-20020a92d909000000b002ffe1b0b150mr4087211iln.147.1668126975442;
        Thu, 10 Nov 2022 16:36:15 -0800 (PST)
Received: from localhost ([2607:fea8:a2e2:2d00::61cc])
        by smtp.gmail.com with ESMTPSA id a12-20020a027a0c000000b0034a6d12aa25sm343343jac.4.2022.11.10.16.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 16:36:15 -0800 (PST)
From: Richard Acayan <mailingradian@gmail.com>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v5 1/1] dt-bindings: iommu: arm-smmu: add sdm670 compatible
Date: Thu, 10 Nov 2022 19:36:06 -0500
Message-Id: <20221111003606.126795-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111003606.126795-1-mailingradian@gmail.com>
References: <20221111003606.126795-1-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Snapdragon 670 needs the IOMMU for GENI I2C. Add a compatible string in
the documentation to represent its support.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 796dc7d4dbdd..f77597e8ed39 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -39,6 +39,7 @@ properties:
               - qcom,sc7280-smmu-500
               - qcom,sc8180x-smmu-500
               - qcom,sc8280xp-smmu-500
+              - qcom,sdm670-smmu-500
               - qcom,sdm845-smmu-500
               - qcom,sm6350-smmu-500
               - qcom,sm6375-smmu-500
-- 
2.38.1

