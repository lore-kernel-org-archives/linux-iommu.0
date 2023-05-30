Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6565E19516
	for <iommu@lists.linux.dev>; Tue, 30 May 2023 14:49:43 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3f68fc6b479so46938845e9.2
        for <iommu@lists.linux.dev>; Tue, 30 May 2023 07:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1685458181; x=1688050181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=udNghephkvKhPZuJBjEix+UuL920fK/8W/QzTCO5Pcg=;
        b=W+7ofkddfcWJ06zeU0Da9XAhr+E4Vfz4rR3jL63NhJI+86PbNPD1NqbIUy2FS+9h4p
         jbzV2VPtF3LhpyKSiJWN5UqkQmx5LK2/wCHSuLL5wy2qILsQ4nDcgQkrmCwY9n1rrOIr
         GlDCNJ6jgx3+e7ql8RJFM9G1LgUfgjr4Io1MCLTwjyBw+1ngsJy1uKqsGnkhcZR9GmWr
         zEU8kIuY6sMgHKNnu7tYrkVtm3OlR9kxLlWmtLGGb2X4v9nNMQ1Gv1BCp0H9b/nDi0EH
         4eY/QLB97/Jo6DF4CjJ/AToKbqAsAuxeydt6ifJBMflL9KnCYnQfLLB2LGwrvc2ZaVdG
         JLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685458181; x=1688050181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udNghephkvKhPZuJBjEix+UuL920fK/8W/QzTCO5Pcg=;
        b=GL/exeNF1mWqHNd1dezzyoOHIq01Ect1DrLb2UqnaoVLt4PdvaMGkEZYVg/YaH0kUg
         Pj0nLdkZfI/KN3pJr8bdLMUHvE5iu35jjXFGFSnzC2imktsCVqFXQdnUNlng3pH+GzgB
         xyN0heh3WLTP9i7p/Awws0XfAuLE7as6AfsX6S4VLpLsI/kqgZzYtQqDaj/ZOYQjhEmq
         56F9OQE6k9HebG/E5azBcTZkdOOUPaG07V/k3Xs9cDnnz1u5uhIYCymiy58yFtrKGabI
         Qz4F4OZpXuv7NPYjblK1Zyn3jy5Sp34bPA44aWXrqAlu1iv8FmHtl/7vFoKUsIWon/+S
         fdhw==
X-Gm-Message-State: AC+VfDycEmoI9sK97/werMtkwMyg0MH3CkbhcNjeGWv7Nk8abm0EOdJD
	lTZ3vS3GJ/VbFYiixKNGY5w47w==
X-Google-Smtp-Source: ACHHUZ75uX94LvL6Mu4X8bBwL6aHIfbExTPA32GAruz4VRZiaZa0LwAOuzBPJm+FdPrWQQgM8rwz0w==
X-Received: by 2002:a1c:790e:0:b0:3f6:72ec:5fc3 with SMTP id l14-20020a1c790e000000b003f672ec5fc3mr2087614wme.12.1685458181458;
        Tue, 30 May 2023 07:49:41 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:5bdd:98ce:604e:9cf0])
        by smtp.gmail.com with ESMTPSA id t19-20020a7bc3d3000000b003f423508c6bsm17323488wmj.44.2023.05.30.07.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 07:49:41 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH] dt-bindings: iommu: arm,smmu: enable clocks for sa8775p Adreno SMMU
Date: Tue, 30 May 2023 16:49:31 +0200
Message-Id: <20230530144931.188900-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The GPU SMMU will require the clocks property to be set so put the
relevant compatible into the adreno if-then block.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Resending with all IOMMU maintainers in CC.

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index ba677d401e24..53bed0160be8 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -79,6 +79,7 @@ properties:
       - description: Qcom Adreno GPUs implementing "qcom,smmu-500" and "arm,mmu-500"
         items:
           - enum:
+              - qcom,sa8775p-smmu-500
               - qcom,sc7280-smmu-500
               - qcom,sm6115-smmu-500
               - qcom,sm6125-smmu-500
@@ -331,7 +332,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: qcom,sc7280-smmu-500
+            enum:
+              - qcom,sa8775p-smmu-500
+              - qcom,sc7280-smmu-500
     then:
       properties:
         clock-names:
@@ -413,7 +416,6 @@ allOf:
               - nvidia,smmu-500
               - qcom,qcm2290-smmu-500
               - qcom,qdu1000-smmu-500
-              - qcom,sa8775p-smmu-500
               - qcom,sc7180-smmu-500
               - qcom,sc8180x-smmu-500
               - qcom,sc8280xp-smmu-500
-- 
2.39.2

