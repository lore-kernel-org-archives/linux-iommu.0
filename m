Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575EA15AC0
	for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nx9bHc7p"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-332c0c32d19so3557332f8f.3
        for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 00:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701160887; x=1701765687; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FArHvLSE7t70Dxa/JAUxZleZFl01Zkt3aczR0p4djvo=;
        b=Nx9bHc7pHxrrXFiFQSu+jXuYxxQsyGUeZd9Epvi+XV9C6IJXaxcit5BZh/SzBV20Hy
         vhtep0DPGOnudUZ85oshx7bv2lihxk9g557atC7yzCimuar3EHHGf1C5gTWq5BxcV+mk
         mRF9LQ6IEAlARTKqrJciuupq6xYCma5EdFox8NUJgo8GkbcC/n3rvFwYLtJYZt/TqqWH
         kRCyoW2Y3IBxUD1Le8RKu0NwA9DOHlcV6VWmKjssFi9UE8NCRTnWuOkdb8o/RDsxqE05
         nUZX0z+4+xXeRtrAZUU0mq2twEtZAk/RGJaJCp1dX68OeSmtCkH/Y9Jtjv/2csEwSI23
         iUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701160887; x=1701765687;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FArHvLSE7t70Dxa/JAUxZleZFl01Zkt3aczR0p4djvo=;
        b=ioyN94RoCopT762+VzCNUO2s2st1h4Oo8OtD68nkTcOsFvHC7dvCPI5fyTalh793x2
         Kkx2N/3yY1VD/XPF4NiY4IHiWiWHnKPpJ0VbN7CAsHm/hcq5OXWqhd7qYw1at+GHvpex
         FMsEvs5UgnjKUCupIPJ3tCnsBk5Za94IsWsSdqpRPlaOxMWsBs9s/R81rFa1ysx8KP6i
         ZonUu5aQydRVZ6QG/qimc1sv0dc4kaExWTaIms8LvAkoGV1/CUMszp/0w3jM1ZmdAoxE
         QuD3QaZmct+ZP8XoBBuCTloTTga7N8INoKDAPZAecwUqXZYkhsVp6KQCp6P3LLw5VYr6
         agNw==
X-Gm-Message-State: AOJu0Yxdbw817FaSUmQsqyPjVxSDsNLaNX/zW602u0seUJILBqZMpBxG
	jxLzcq4vg88pXNELpuA0jHtNxg==
X-Google-Smtp-Source: AGHT+IGSwQZaP4dBVCrX35EPpPiEYt2lAGGRRqwQ84D4zrY7KQq1APLCHRYcHamkS+UEOeJz5gN9aw==
X-Received: by 2002:a5d:4d51:0:b0:333:2ac:33f2 with SMTP id a17-20020a5d4d51000000b0033302ac33f2mr3654000wru.4.1701160887549;
        Tue, 28 Nov 2023 00:41:27 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id cp12-20020a056000400c00b00333040a4752sm4092435wrb.114.2023.11.28.00.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:41:27 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 28 Nov 2023 09:41:23 +0100
Subject: [PATCH v2] dt-bindings: iommu: arm,smmu: document the SM8650
 System MMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-topic-sm8650-upstream-bindings-smmu-v2-1-d3fbcaf1ea92@linaro.org>
X-B4-Tracking: v=1; b=H4sIALKnZWUC/42NQQ6CMBBFr0K6dkxb00pceQ/DopQpTCIt6QDRE
 O5uJR7A5fs/eW8TjJmQxa3aRMaVmFIsoE+V8IOLPQJ1hYWW+qKksjCniTzwWFsjYZl4zuhGaCl
 2FHsux7jAtTPa13XrbQiimKaMgV5H5dEUHojnlN9HdFXf9efX5i//qkBBG5w2wTlpFd6fFF1O5
 5R70ez7/gFHIvud1wAAAA==
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1614;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=4QQJrLSwqX11gi0iupHS+1VQiYE7nq7ckVQvq7PgbkY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlZae2K4EuU5HHOy3yOrVOFC/hyVZ/UP2kxvwjxoS+
 Qjmj96+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZWWntgAKCRB33NvayMhJ0fQID/
 9QXxJsBhGGxdq8/cPw1x800aIV3EZMCXGPn6wp0VLcMvY/vIMaufbgB0X8U1lfRI5bD0BKFY+qSY7j
 SfBHfxjAAWARTXMsgrpTpaDjVF+rkIz63bNrspJ+uXxIgxitP4pLYr8MUSwG3e8hNPO486Ld1m360H
 DB/qweMGYH2hzVKe1sWpBnVBUpHx8VIVZ8dcmx9FujAYkCu6IkGjLJnGeVziGZDbUriaBqsdatWh8d
 vTeRUWAm0Qksg72Axxq/ac0rzWEnem3ySLoPh/N8AhmDlwpWsnDlvZrnalmqOAz/HdmNknhHBFo0tH
 eW+SrEZw/5UUQLkJ4fBHh3U+VJT1JOtm3w3H3TNzwUlsvh0EevlkAyf2JibtgC/Bbfmj797dezfjGO
 VTQMGXFD0OzDI9n4Pah88zuGboPyDdvsF9MCf8uPQq/iXrvMaW/R5tPuAjXQi5jxDLE5RCYltzyyQ0
 UEt3E2oEBVUh7QF636gt3yfjOTQidO4bqberGm/I2YaWyFz1K7nFPD/owQ/iD8oItSaBIe7yHUmUz+
 8D1/4yH6MxuEBYRQwpwPIfyT6yUqJL/ft/wTojTX0SKd3RLKB4uLZvdCilIYAlujFewCAwRVdos61I
 9fB6CSPqqkSLlORTh+wHaNDo6kePazDYT3u6v3bUlzOXwY1Tf0wgEtxcVcaQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the System MMU on the SM8650 Platform.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm8650/upstream/integ
---
Changes in v2:
- Collected Rob's Ack
- Link to v1: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-bindings-smmu-v1-1-bfa25faa061e@linaro.org
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index aa9e1c0895a5..157de0d0a24d 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -56,6 +56,7 @@ properties:
               - qcom,sm8350-smmu-500
               - qcom,sm8450-smmu-500
               - qcom,sm8550-smmu-500
+              - qcom,sm8650-smmu-500
           - const: qcom,smmu-500
           - const: arm,mmu-500
 
@@ -475,6 +476,7 @@ allOf:
               - qcom,sm8350-smmu-500
               - qcom,sm8450-smmu-500
               - qcom,sm8550-smmu-500
+              - qcom,sm8650-smmu-500
     then:
       properties:
         clock-names: false

---
base-commit: 48bbaf8b793e0770798519f8ee1ea2908ff0943a
change-id: 20231016-topic-sm8650-upstream-bindings-smmu-7d52c88bc6ff

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

