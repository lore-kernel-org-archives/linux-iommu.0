Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6987D944A
	for <iommu@lists.linux.dev>; Wed,  8 Feb 2023 09:14:01 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so940538wms.1
        for <iommu@lists.linux.dev>; Wed, 08 Feb 2023 01:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q76atrdN5lNwUwTtNAyAzZW0HpZ1rC669DXhgQBSxwI=;
        b=RosM4Al94Jk84W6iyIuxHUm7Wd5ahYanI2QOHuYq+G2pGhsHsw6v7ZtzN+Gg8kO/1R
         +OGT8RB0/mpQIIY4m2ez1shWnrkVbuyHv7guAtKG/HbKn2Lf/BKeVEumLXxmOPzUkUCU
         l+OBNdQ8SljpOvhioGBlQaORWe5BfSljLT0vcVHyu1t8kjWyiUfv3J5X4YYj5oyQLXZd
         KzRZyAGnZN04IKgWwnYxCNM4sU3Q2mpRUih1TptD0BinJ/9JiyGPcMLCW2gLHFHZeSds
         yUbwQIs/rMBNt9biGpAVSY+Hsdxt9mDNXFGRfixe9u73dCefdMoug8R1AKbz+zJkpyV7
         Fwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q76atrdN5lNwUwTtNAyAzZW0HpZ1rC669DXhgQBSxwI=;
        b=SQOR9uORB7wvws8n4Mo/h9q+eLfTiG4vO84VsAuf6FqPaBqWDVSYANuN5ajZKWSM42
         dGRowybtJHH5+Q98wW4wP9kmFnUMEOJYjN1c2K5esK2Dx+h4jcOn45Uc2Mbgm8tfvy0C
         88HuwFgsYl0EU1QVme8EhdC08SUryRXU3aiXO/3VACw8Ua/BLt/dWbjoh9ukLOZyDbZK
         CesgE/1IWJsZTIy9PErluPVkvuEU8+CYkjnkv97oA0tgCCU+czMYiFPYUcc28GpGncMG
         K+N27Ds+KYG2cYmsoqSY4jl4xmRM7arQd2aM2fivomXNapUpMXI8ZjZ1j0P5K/NztPsD
         xLXg==
X-Gm-Message-State: AO0yUKWBhmdYEvsBR97PBG8Op7B+DXMHEJYMk/IV/F3zQw43YlTNUKHD
	WbPhVA4DI/Nh5ClwIXxISGwoaw==
X-Google-Smtp-Source: AK7set8+Y1xlrHgX7u++XnrCn/m0vu/iF9trmAFnUp+17Ry1FRzvYrHj5dkZ+bTIjkLApx9XWAoLkA==
X-Received: by 2002:a05:600c:319d:b0:3dc:5950:b358 with SMTP id s29-20020a05600c319d00b003dc5950b358mr6431731wmp.14.1675847639714;
        Wed, 08 Feb 2023 01:13:59 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f24-20020a05600c491800b003df245cd853sm1213939wmp.44.2023.02.08.01.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 01:13:59 -0800 (PST)
From: neil.armstrong@linaro.org
Date: Wed, 08 Feb 2023 10:13:58 +0100
Subject: [PATCH v3] dt-bindings: arm-smmu: Add compatible for SM8550 SoC
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-topic-sm8550-upstream-smmu-bindings-v3-1-cb15a7123cfe@linaro.org>
X-B4-Tracking: v=1; b=H4sIANVn42MC/5WOTQ6CMBBGr2K6dkxpBdGV9zAs+gdMAi2ZAaIh3
 N3KDVy+t/jetwkOhIHF47QJCisypphBn0/C9SZ2AdBnFkoqLZW8wZwmdMBjXZYSlolnCmbMPC5
 gMXqMHYO37V1dlXO60CIvWcMBLJno+rwVl2HIcqLQ4vtIv5rMPfKc6HM8WdXP/hddFRRQ1dLZ1
 oTKG/ccMBpKl0SdaPZ9/wJ6/ard7AAAAA==
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 iommu@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0

From: Abel Vesa <abel.vesa@linaro.org>

Add the SoC specific compatible for SM8550 implementing
arm,mmu-500.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- update allOf:if: for disallowing clocks
- Link to v2: https://lore.kernel.org/r/20230207-topic-sm8550-upstream-smmu-bindings-v2-1-680cbfae6dac@linaro.org

Changes in v2:
- Rebased on new bindings using qcom,smmu-500 & arm,mmu-500
- Dropped driver changes since we rely on qcom,smmu-500 fallback
- Link to v1: https://lore.kernel.org/all/20221116114001.2669003-1-abel.vesa@linaro.org/
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 807cb511fe18..ea81e9b1860c 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -53,6 +53,7 @@ properties:
               - qcom,sm8250-smmu-500
               - qcom,sm8350-smmu-500
               - qcom,sm8450-smmu-500
+              - qcom,sm8550-smmu-500
           - const: qcom,smmu-500
           - const: arm,mmu-500
 
@@ -389,6 +390,7 @@ allOf:
               - qcom,sm6375-smmu-500
               - qcom,sm8350-smmu-500
               - qcom,sm8450-smmu-500
+              - qcom,sm8550-smmu-500
     then:
       properties:
         clock-names: false

---
base-commit: 49a8133221c71b935f36a7c340c0271c2a9ee2db
change-id: 20230207-topic-sm8550-upstream-smmu-bindings-dbf9242cc313

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

