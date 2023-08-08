Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE168492
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 09:45:01 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so8799420e87.2
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 02:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691487899; x=1692092699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2UuNhIPZQtVYzGmtMAw0xH3Mxdy93w7NQpbLuvaKjSg=;
        b=NrsC+6SfK6rrKzds1RrsxA8Em04z6KSF6jwxNJkKNWfdT9aRNwpmjHnFS9gBgqtXis
         3dO/eSIliY7p/DzI8Ni3ODs5ut5E8pSf8uUpDGK1qS1vefoOck8jIYS4XE33QA/yggre
         NBegANHiapxeMUgfuRGPkAUmInRYZSLFPHEupPNC9ey35dcO/szxV/HvYjiZkaYsJ0P9
         7/Gq4Sg1atuhWYG1d74XTAq13ZqcVlQ4KCF9DMv/pXacWpbKA0/nQAs7XlXQql/RdfL8
         6QtYGgU7H7HuhT+YKoMgoDhVwGEOwynL0Z4Z0Dk+cos2BEyJ44OfZQtOhEW1QMBt2sKz
         qHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691487899; x=1692092699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UuNhIPZQtVYzGmtMAw0xH3Mxdy93w7NQpbLuvaKjSg=;
        b=CWblCp4oKLdRBJvNP28GGVI5x3O6Q4PSPfXiuKGgngqvkjt5yLhCeGGG7rVBbBUyy1
         lCcrEIOdlda7wU9tEPZE+oI/ofhsvw0KGEMj7MkEsVJRKH1mUMsUIXCAY6lBM4jp6bdc
         uNrfDF/J1d+SBtYO+M+gM1gfMyCi74MKH7wgLywEiRgA1xLxdrihSDTzMxkdk6Wkv7HR
         zJwmfd93jjzh/k6Z2gwCSAtULVhwx9E7LSKOVKBRqEKBxGoyHD5kiW1CyGjeMQs0B4Fa
         cHLUNzv7MwCNFDYJ1ZB1uh5xAMoJQhABAIiLQOgKnT44Jnp9uAVf6j32cIlvFBFrzopn
         WOhQ==
X-Gm-Message-State: AOJu0Yw4zekfc6VjkH4100SXKqlOzlfaUZCyehkfBUfxlmCsFnYE7eY0
	tuL9Wg6bQQvNTKew0f5EjT0hZw==
X-Google-Smtp-Source: AGHT+IHe6NP3MzfgZSWbkR7jxRMoFmcA9NIiePawh4EYEM7Q9mrKbCLB6JP4QQacs26mWD9MoLIIVw==
X-Received: by 2002:ac2:4ece:0:b0:4f8:5604:4b50 with SMTP id p14-20020ac24ece000000b004f856044b50mr7020474lfr.64.1691487899167;
        Tue, 08 Aug 2023 02:44:59 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id i6-20020a056512006600b004fdba93b92asm1818884lfo.252.2023.08.08.02.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 02:44:58 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 08 Aug 2023 11:44:46 +0200
Subject: [PATCH v2 6/6] dt-bindings: arm-smmu: Fix MSM8998 clocks
 description
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-topic-8998_mmssclk-v2-6-34273e275c51@linaro.org>
References: <20230531-topic-8998_mmssclk-v2-0-34273e275c51@linaro.org>
In-Reply-To: <20230531-topic-8998_mmssclk-v2-0-34273e275c51@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, 
 Imran Khan <kimran@codeaurora.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Joonwoo Park <joonwoop@codeaurora.org>, 
 Jeffrey Hugo <quic_jhugo@quicinc.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Jami Kettunen <jami.kettunen@somainline.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691487885; l=2406;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=GiTo3aHVWSJqXeRVvBwFrjMpXiRsIg5liCVx9M1P4EU=;
 b=Nxs8hOuPBNmdHqXrObFj394Ryc0kynWXqn1i40tZ53Cb01Hzw6WwtFi+3X0Jcw4BcgOd603j0
 ZWoh4q6XnKVBZvu54Q3HrIhvJNMsEM/z8rSRfzNPESDS1/k+Iq2OYtg
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

MSM8998 was abusingly referencing one of the internal bus clocks, that
were recently dropped from Linux (because the original implementation
did not make much sense), circumventing the interconnect framework.

Fix it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/iommu/arm,smmu.yaml        | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 3a31a979709b..cf29ab10501c 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -270,6 +270,47 @@ allOf:
           contains:
             enum:
               - qcom,msm8998-smmu-v2
+    then:
+      anyOf:
+        - properties:
+            clock-names:
+              items:
+                - const: bus
+            clocks:
+              items:
+                - description: bus clock required for downstream bus access and for
+                    the smmu ptw
+        - properties:
+            clock-names:
+              items:
+                - const: iface
+                - const: mem
+                - const: mem_iface
+            clocks:
+              items:
+                - description: interface clock required to access smmu's registers
+                    through the TCU's programming interface.
+                - description: bus clock required for memory access
+                - description: bus clock required for GPU memory access
+        - properties:
+            clock-names:
+              items:
+                - const: iface-mm
+                - const: iface-smmu
+                - const: bus-smmu
+            clocks:
+              items:
+                - description: interface clock required to access mnoc's registers
+                    through the TCU's programming interface.
+                - description: interface clock required to access smmu's registers
+                    through the TCU's programming interface.
+                - description: bus clock required for the smmu ptw
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
               - qcom,sdm630-smmu-v2
               - qcom,sm6375-smmu-v2
     then:

-- 
2.41.0

