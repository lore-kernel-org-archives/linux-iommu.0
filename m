Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54E23C3A
	for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 11:16:23 +0000 (UTC)
Received: by mail-lj1-f176.google.com with SMTP id r28so817749ljk.1
        for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 03:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGCuw3uwe0V6oqscB9N0Rq3Z525nB3A+PwU4IC7WMx8=;
        b=IRqdspaKxxru2mS25VhwBIjb6l4JPODitns9Jy7FcnIrhN3BeHKthhoUWS0rKxwvMU
         casSoMMTIoSwB9aZZhwh1pQDSIomHRPkMRtJ1XXy3R0Lh6dYKwcxKkRPs13GDMOXE9ZA
         4LeHOMung7XIrxs7xr9vz/BW5Kw3n4ONqKd6u0WS+ajn1ioQ8516b0LU/HuVwEqEy4IM
         Uhpp7a7pFwFSoMfYgTHLBqibbxrzomg9LopG4dlFSNXQNuWF9Yl/T0sJ5zGfF2/d9d5n
         lluJExUdu92I5JcOZVUPk6uUneZUtfy+bLUoq4sOPFqOUhFcQqlk3W8W6QHrJBlq9Yju
         1sVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGCuw3uwe0V6oqscB9N0Rq3Z525nB3A+PwU4IC7WMx8=;
        b=ZYqmnlBvbkC3QqKy0Kbz9TvYyypqXoZIBIlk5sWjuZNKycgUKILXbQ0ZQL/S0Nmvev
         zb+m7znDYoWfyig6nR09Bzd+nIu+b59UIFbGxY5o9e/dCVsIj0+QaT2/EScYXvGaxUv5
         VQ4MWAyPowLRpiP9uVtaou6Bwe+YBp8LaHyjt3l//UYcCd//wR6dUci6xBSTcPkOn/6U
         eUsqqKFspD+xlX7eu2eD/mUqUOWt6ivdWlyLwMCIYmiK39/toH8gC5WEnUCpNDu9LEIn
         WiiJItOus44UlcDq7XwPtsvLNFHBOOa+fQi6GrjS0dQ6AwtjBW5eGZbKDsE2eSjQqO0f
         GegQ==
X-Gm-Message-State: AO0yUKUfQWlTBCyNvpZQTkOK4nk3jEq8odP3F7JaaH6epYNIzIqNTAWn
	8GytmrAmBgOXlKXoDVMpT/uZZA==
X-Google-Smtp-Source: AK7set/4jLuiEe/dkxwX7Ld3pEHmvAPK2jaXOucN5kzuSE5zPUVFQ0gOwCvIaSp3lBaHr2blcgohMQ==
X-Received: by 2002:a2e:8250:0:b0:294:6ef3:f53d with SMTP id j16-20020a2e8250000000b002946ef3f53dmr1061603ljh.23.1676632581934;
        Fri, 17 Feb 2023 03:16:21 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e9b15000000b002935899fe3fsm554818lji.116.2023.02.17.03.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 03:16:21 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	andersson@kernel.org,
	agross@kernel.org
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
Subject: [PATCH v2 2/6] dt-bindings: arm-smmu: Add SM8350 Adreno SMMU
Date: Fri, 17 Feb 2023 12:16:09 +0100
Message-Id: <20230217111613.306978-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230217111613.306978-1-konrad.dybcio@linaro.org>
References: <20230217111613.306978-1-konrad.dybcio@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the Adreno SMMU present on SM8350.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:
- Drop Krzysztof's ack, as the patch was out of context..

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 4d7f61700cae..d89aa5b5c963 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -81,6 +81,7 @@ properties:
               - qcom,sc7280-smmu-500
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
+              - qcom,sm8350-smmu-500
           - const: qcom,adreno-smmu
           - const: qcom,smmu-500
           - const: arm,mmu-500
-- 
2.39.1

