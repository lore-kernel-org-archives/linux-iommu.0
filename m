Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDB816433
	for <iommu@lists.linux.dev>; Wed, 31 May 2023 15:04:32 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4f5021faa16so4307612e87.2
        for <iommu@lists.linux.dev>; Wed, 31 May 2023 08:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685545471; x=1688137471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNLO4nYhnPqhn1ZR80So3i5u5QMBlsTPDRXJyuHPHdo=;
        b=IW4qp84ak6aVsS6ws9/7Pp8DqyEOrs+9UEeJvZNDjHNkRJK7ylKhyn9B4KH/8xtUuk
         cE91OGaDJx6+Zzq41GBxXXGz8LKhN80qTfwnbdmUIkeQ1bQKkcygFTXPriAqbveV9b+p
         a8hQWDqfha7UI+8c9SlmnWuMwoDlVmvIXxYbIzcNEnpyEED93dcAE7Wm+DTrplwjgKIr
         H6TKdN3632fu3RZGqhO8jPLMl37Th/dVXL07/DBVmJhHhH9YQ33k8I8iIWNj1GsTmDq8
         q/jX+UzpY7Vob0ZUDOuS02PYbsKl490VO7GuET7mNmgbeU1rF10H4mCApe0jB///9/27
         QuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685545471; x=1688137471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNLO4nYhnPqhn1ZR80So3i5u5QMBlsTPDRXJyuHPHdo=;
        b=fqJVlwdXDDqZO/XEBXkWt0GpaLn8P/KFsJ20MKPo7dZFX/S3mEg/HSUhKrY8eFNrVK
         QHmgWmY4AcwYCrFMOn1hlrqZDMu68/zNno93kvCtBtoWtM6i8Z/XDPxbr/8tKjtewzNi
         XUklFee05B6xkvUyHSZ/pM8VBC4kxEgow2fvnoRc+WkgLp/8UpawIo0+Uz+92Za5+ojK
         U2ii6teChI3FinihPbK4Teff95aISr2MgnNlEcqUVN4RGQVl2l1oQiu3zO3sCzGYFJ98
         36ruUCy92SN9CYMOAdIJaFYX+xgRyyi4hdOnQOKujF9VlNxKSeRkLg3PfLwnfIEpM+xF
         YoDg==
X-Gm-Message-State: AC+VfDzMaPoK/bTbLC139q22QSCYLmhbPwQ/PZ5aEbH1bFAnQUHnR2NV
	Ap+v0nne5+QeNZTXeGz8iRTMdg==
X-Google-Smtp-Source: ACHHUZ6isPAGGyNErW2TVjyf8oGAklK5h/wCFAwLXiR8DWB6O0Ru3p8wOQXRM0yqKVFYFrkgCrZ/ug==
X-Received: by 2002:a05:6512:3743:b0:4f2:7ce7:dcf3 with SMTP id a3-20020a056512374300b004f27ce7dcf3mr2862793lfs.17.1685545471043;
        Wed, 31 May 2023 08:04:31 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id v25-20020a197419000000b004f019d3eab4sm756325lfe.23.2023.05.31.08.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 08:04:30 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 31 May 2023 17:04:23 +0200
Subject: [PATCH 1/2] dt-bindings: arm-smmu: Add SM6375 GPU SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-topic-sm6375_gpusmmu-v1-1-860943894c71@linaro.org>
References: <20230531-topic-sm6375_gpusmmu-v1-0-860943894c71@linaro.org>
In-Reply-To: <20230531-topic-sm6375_gpusmmu-v1-0-860943894c71@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685545468; l=1196;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=gJOlh+EMoLh8KOQ53iJ7hyFLc362lflmhqV5kwupSas=;
 b=XwOLMmcbcNw6AK7Mgvhj4n75W9cOGfnCWczMCWaASiSS8xGuTRrID/XD8y6uvnCtSaElXVUmf
 0Guxw3Bd1nKAZP1Fh2z0QLkXI0IovjimDCL6++lgmi08X6H+GDD2kU7
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

SM6375 has a "Qualcomm SMMU V2" implementation for its GPU SMMU. It
does not however qualify for the qcom,adreno-smmu compatible, as it can
not do split pagetables. It consumes a single clock and a single genpd.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index ba677d401e24..aec9137713c9 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -29,6 +29,7 @@ properties:
               - qcom,msm8996-smmu-v2
               - qcom,msm8998-smmu-v2
               - qcom,sdm630-smmu-v2
+              - qcom,sm6375-smmu-v2
           - const: qcom,smmu-v2
 
       - description: Qcom SoCs implementing "qcom,smmu-500" and "arm,mmu-500"
@@ -267,6 +268,7 @@ allOf:
             enum:
               - qcom,msm8998-smmu-v2
               - qcom,sdm630-smmu-v2
+              - qcom,sm6375-smmu-v2
     then:
       anyOf:
         - properties:

-- 
2.40.1

