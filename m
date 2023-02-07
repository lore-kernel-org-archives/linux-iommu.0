Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE45D33C8
	for <iommu@lists.linux.dev>; Tue,  7 Feb 2023 13:40:42 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id ba1so9521970wrb.5
        for <iommu@lists.linux.dev>; Tue, 07 Feb 2023 05:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=urkAIxuw0vH+tmqjpky10ko8VbPTxFMdI1E8QACAnss=;
        b=hQRx+/nCyCWiqMX210IH4LQUymrymE1yjavw4Lt99bs0YUHEqoLJOtRQXNJ9F6siXO
         r7+l7weL97KXIAddry/5olN+KHoBgjycgv1KrZpqx61bYgYV9z+dD/FMhSoksTf/NEnq
         LOsWAUzXOX89eomlIg5UkpXmrd7SJ2tvun4XhFXeQOvibDXmOU3m075KMB2wX0RBsasr
         7np4HCk1WWgbQPyo/trnok0BJ4mFBgeyUbPrf1q43oxiPs6IONiEqEELwD/+FncxVJTN
         B0/l6n1J/uTSXiDrtinlPrkuwRbB/w5eBiiwBr8Mlu+tNkoAjAceFnQZJyc9YNeVMBke
         ehfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urkAIxuw0vH+tmqjpky10ko8VbPTxFMdI1E8QACAnss=;
        b=SA3RDqME4YXp/BiHLai2P3V3qnThCxX9fS90czkSMdGxEvhZ5rH0jb9h4p/+rwmLzu
         o3uIwQUpEXqA7F4yer0gGqP8CMcRci+gmmgE3SkM1NV12Ihfd1pe2IElzdsaJGxInW15
         3Ip2HXpNMWk0Se21CkNaQrT7ihvWd/Xp0vvFepiEtVzygYPFGoeLajUW/B8kd9uXIidp
         8qCmFJKnelGWD1Jl0N93I6EMVBYkki4smIeONtR9zY73OwtFyMjONA8vj7UDf+R1gJz2
         I0N1vihe94rJhVUpwtRMDgVe5maGekQFQFdF8UMpZyGgFxEJUL/F4YddhNNn08eSg06z
         sGwQ==
X-Gm-Message-State: AO0yUKUg5+HnMhgwTuXQgF6uqH5ddxTDX/3nIFieBPyUulaeJXvhpQsJ
	TfcidK4Sl4HdTJjU4aZQkawR1Q==
X-Google-Smtp-Source: AK7set9e1f+KMJDJ5s1jQQQtxkd8i0niz6R2HKOrVZkG+bItiOLwyLcSPAi3KM9YcZ2sW5cGUxsiWw==
X-Received: by 2002:adf:f6cc:0:b0:2c3:e356:694e with SMTP id y12-20020adff6cc000000b002c3e356694emr2916605wrp.22.1675777240965;
        Tue, 07 Feb 2023 05:40:40 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id o1-20020a5d4a81000000b002c3d67aac74sm10866280wrq.88.2023.02.07.05.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 05:40:40 -0800 (PST)
From: neil.armstrong@linaro.org
Date: Tue, 07 Feb 2023 14:40:39 +0100
Subject: [PATCH v2] dt-bindings: arm-smmu: Add compatible for SM8550 SoC
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-topic-sm8550-upstream-smmu-bindings-v2-1-680cbfae6dac@linaro.org>
X-B4-Tracking: v=1; b=H4sIANZU4mMC/x3NywqDMBCF4VeRrDuQTiq9vEpxkcuoAyZKxpSC+
 O4duvzO4j+HEapMYl7dYSp9WHgtCrx0Js6+TASc1AYtOov2Dvu6cQTJj7630DbZK/mszg0Cl8R
 lEkhhfOINY3RXZ7QUvBCE6kuctVXasui4VRr5+79+D+f5A05+/BGKAAAA
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0

From: Abel Vesa <abel.vesa@linaro.org>

Add the SoC specific compatible for SM8550 implementing
arm,mmu-500.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Rebased on new bindings using qcom,smmu-500 & arm,mmu-500
- Dropped driver changes since we rely on qcom,smmu-500 fallback
- Link to v1: https://lore.kernel.org/all/20221116114001.2669003-1-abel.vesa@linaro.org/
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 807cb511fe18..bc27919ab9f9 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -53,6 +53,7 @@ properties:
               - qcom,sm8250-smmu-500
               - qcom,sm8350-smmu-500
               - qcom,sm8450-smmu-500
+              - qcom,sm8550-smmu-500
           - const: qcom,smmu-500
           - const: arm,mmu-500
 

---
base-commit: 49a8133221c71b935f36a7c340c0271c2a9ee2db
change-id: 20230207-topic-sm8550-upstream-smmu-bindings-dbf9242cc313

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

