Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA8FAD5B
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 15:27:40 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id k2so36926555ejr.2
        for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 07:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OnIF5KJq38ydF7gLxLfsf0iN2iW7kEJTrwDz5/qCW8=;
        b=XeD7h1D85c6PELOSUkCRH42zXo6QrloEq7je/ihrbaWxuZGUSugvC6ZYCtZPrpYQ4C
         m0/ZoyjftHwJDvZSWFeHc7V1cB19WR8ouls1xE8wSHQj9ZSBG/zZdQbUr//U4Hz78NOh
         70ld40peqz55/qWelsXnefWszp8OMz/rpqmTbA6IjQrxu45BbDpIS0QzOQ2DFbGI6PtQ
         RNqBkZX2Prkbb3LIHpdKtx0PT/Q6nocYrCQXe9fVAYLrKU6ViBsbbJUZSQKlvvaQsi7f
         49WgjnxLy320wM2CPMu7og+jlX6VaL9gxSlfXHPthueLNUy/SEDBgRDH8QLQkHu54Wqp
         dG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OnIF5KJq38ydF7gLxLfsf0iN2iW7kEJTrwDz5/qCW8=;
        b=3hrz9V1N6i34r7HIFxqUFe5RgXncuJgO84Q4xxtrqernLGnzmFWgC1Ct41tH/Tmy9I
         OKIO1B9Ya39Y6NH9OXjpr1rzRqOxHArEJeDldFZfq1JGM/octKKsCu4zru++tJIL8nl/
         RWXR4V+tNtu1ZdG3S9yrcHOFtQDhW6CYsoIkT+XhpcyVIITTbYl8c8ta0NmgCdMey9hh
         a9epN/jxfW1Zq2Pq3hR/yoHre+ICnmmV8qm/aDKO05REpCl4kdJB5K11Qre9YzOzLY7P
         lumWGYFYv0yLS4ynUqEGx332m4tshvFGivOyy2cvGj+PM4hI3omR43It4ety8a3KpQR/
         gEkw==
X-Gm-Message-State: ANoB5pkZarQDXClm2iLP+RbhELtiHP3PoXBPRcjgDDtDh6oIOCibUpkw
	fPCcxqYJU29lodr1z9ZHFhugbQ==
X-Google-Smtp-Source: AA0mqf6t90H5G/NxFj6kZZ89Op+6k4zWLusxmbs0qlF4AQ2K0srx4P2Envtn5p5Sx3vJB9JOY4JsQw==
X-Received: by 2002:a17:906:d82:b0:7ad:8a7a:2343 with SMTP id m2-20020a1709060d8200b007ad8a7a2343mr13999054eji.225.1668526058653;
        Tue, 15 Nov 2022 07:27:38 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id ku21-20020a170907789500b007ae1ab8f887sm5750679ejc.14.2022.11.15.07.27.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Nov 2022 07:27:38 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	andersson@kernel.org,
	agross@kernel.org,
	krzysztof.kozlowski@linaro.org
Cc: patches@linaro.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/9] dt-bindings: arm-smmu: Allow 3 power domains on SM6375 MMU500
Date: Tue, 15 Nov 2022 16:27:19 +0100
Message-Id: <20221115152727.9736-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221115152727.9736-1-konrad.dybcio@linaro.org>
References: <20221115152727.9736-1-konrad.dybcio@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SMMU on SM6375 requires 3 power domains to be active. Add an
appropriate description of that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/iommu/arm,smmu.yaml   | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 28f5720824cd..348a73f3e5f0 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -200,7 +200,8 @@ properties:
     maxItems: 7
 
   power-domains:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
   nvidia,memory-controller:
     description: |
@@ -364,6 +365,26 @@ allOf:
             - description: interface clock required to access smmu's registers
                 through the TCU's programming interface.
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,sm6375-smmu-500
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: SNoC MMU TBU RT GDSC
+            - description: SNoC MMU TBU NRT GDSC
+            - description: SNoC TURING MMU TBU0 GDSC
+
+      required:
+        - power-domains
+    else:
+      properties:
+        power-domains:
+          maxItems: 1
+
 examples:
   - |+
     /* SMMU with stream matching or stream indexing */
-- 
2.38.1

