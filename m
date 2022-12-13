Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7B27F
	for <iommu@lists.linux.dev>; Tue, 13 Dec 2022 00:26:31 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id j4so2409818lfk.0
        for <iommu@lists.linux.dev>; Mon, 12 Dec 2022 16:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ugTcOj9Npd/SMM1GNN3IBZ5YypTVeK9e1l/D45aeEQU=;
        b=QYVSM+NGhUbi/7aRxbymFXrovv+CUzYPcENl4GN7SIgV+MQg+wUXavYJZCsCWrvJot
         lFQH4r05WWl3ZV/hs3fyHPhK90GrK0ubW3Dfq/BP5BD/Qp2mT0kGtr6ufOF6Du6zQDFv
         DJPPlMBxYcWmWiLW1wjpsS/9/6IE3o/OLCW3r73bWzf18roRO9628xRSQrWbX0YRbyy/
         F3ce4rC6eKJDrd481mVsMrB2o9DEjzW111Ouuqa3ottXYLSmwbMqei2LWom6vcp5n909
         Yo04KYt+DLCWiPfXLHwMzDC9hcb8kZZNGaOoWNNLNvU59YoDL+SIkpCN21+SzI/3Fkbe
         /05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ugTcOj9Npd/SMM1GNN3IBZ5YypTVeK9e1l/D45aeEQU=;
        b=DLbKuqQ7YC0L0cjZQJpp7iEXOSmAMImOi/Ketu2nIKO9d/XxbXr7BWzwocjyhU+Kqq
         9bxdsUY7miafUSg1mIUc/hTnqTRNXsUSYa0Dy3nOmrSo+fKtBKa9G3rmJh/YXoYV2BJ2
         Jow3SbSqCp+5TKZd2bHay0hLVG7hqqFyz7E+wyEkmqF022EBWZd4Vz/Xbvh+NraxF3Fc
         sp+anhBsnzW/TkaFUSYTqpuT+Th1STNSENZtejV5VMh3li/M9RZYJibR4mD/tHMYfQc1
         9a+k8zwJaw72OeaMyOgZEqSqA1tn1pxLyise4xlan9eRTIFFgy8bdT3t8LZ8oW9eW6Jr
         C7sg==
X-Gm-Message-State: ANoB5plLkWFIK4Wk8GEPOJrwS4zVTMcAZp8VKLRVC0FL5T5AS7VYrfej
	EIK2qClJD/RUH47t0yDX+kUZ+A==
X-Google-Smtp-Source: AA0mqf4UdtCG6n/ULmv52B8o3H8MKIe/aZ4oTvNr2ISnyj/sS85Aq3S68jHLXpqqySkfR2zExz4Hmg==
X-Received: by 2002:a05:6512:41e:b0:4b5:7925:8707 with SMTP id u30-20020a056512041e00b004b579258707mr4923602lfk.26.1670891190110;
        Mon, 12 Dec 2022 16:26:30 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id y28-20020a19915c000000b00492dba3c85asm139371lfj.220.2022.12.12.16.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 16:26:29 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	andersson@kernel.org,
	agross@kernel.org,
	krzysztof.kozlowski@linaro.org
Cc: marijn.suijten@somainline.org,
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
Subject: [PATCH 1/2] dt-bindings: arm-smmu: Add sm8150-smmu-500 to the list of Adreno smmus
Date: Tue, 13 Dec 2022 01:26:25 +0100
Message-Id: <20221213002626.260267-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marijn Suijten <marijn.suijten@somainline.org>

sm8150 has an smmu-500 specifically for Adreno, where the GPU is allowed
to switch pagetables.  Document the allowed 3-compatibles for this,
similar to sc7280 and sm8250.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 895ec8418465..b97181d4a399 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -84,6 +84,7 @@ properties:
         items:
           - enum:
               - qcom,sc7280-smmu-500
+              - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
           - const: qcom,adreno-smmu
           - const: arm,mmu-500
-- 
2.39.0

