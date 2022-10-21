Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5AB7E
	for <iommu@lists.linux.dev>; Fri, 21 Oct 2022 16:55:39 +0000 (UTC)
Received: by mail-lj1-f169.google.com with SMTP id by36so4546886ljb.4
        for <iommu@lists.linux.dev>; Fri, 21 Oct 2022 09:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMEQSClTRMQsJD+9t3DdUS4Nt9IsdcSTttNc0HG6j6A=;
        b=hzxB0eJP28Iu8l61VnMXnzjgEYOcymrj2maH7pE0gMP+UfyFToDoOWqpSa1aZHcoCd
         Qh0MYZ9qNGXwQS/UOuaEh5fFU0AQwfSbunDmPS5lJcNPN/4tXvqysZxQGqpbQKWMy0wf
         Hc1QszhEz7CNu7AC+gHOcU6R0poMUeUyBAUr50qCLfHnxqMqFv37JKYFIizAHlYyWJly
         B9/rwEJniab2HXPeZVRfUFZwyDzyeMceDx9h4yWVKHHYUkuoxsAHBHdMMPGf62jUlLyE
         SQzfR5TNWZK32IATo92wvu32BqbJeEFSiX9cd7KlqGmGPmAmQoXrvlPyAGbrn84UWMqQ
         fb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMEQSClTRMQsJD+9t3DdUS4Nt9IsdcSTttNc0HG6j6A=;
        b=6cKzy3uoiCfZKlu4PX8wMYZfBMQDGRvzUU4YHV9+y0KXuJU2jP9OJxSESZ9TbIaLI6
         S+nOTVYErNNFk8mEOAuoA++qwsgYbz1sYGhfRut8CqPzXdWJfgbOZc0yN3L4ikozbGng
         jjj3pHp0RANbbjmo/qFqEue+xz1jCApup/pykSPuxTI6x7NuRm72NkhQjoejXTH1C0yM
         EgtWDa0mE40sjpm86kibv1NQ0g3M7LLf9OFWHjxRIria3/XRxXtUFayITpmVoREttsmK
         PlVT/DQgna5+A3Qd3jLrQGHYloqtQ8z2F2P0izCXyh4FDf7ZJ/I3fUFAijlSKm0mvNXz
         U7oA==
X-Gm-Message-State: ACrzQf3kDXMeOl9aDnvHCdJXlz6RXRM3R75xJa8Z7NnSIx11BAqbc1Du
	j6OZVmTj+wCtwAKqRAJDguWGPw==
X-Google-Smtp-Source: AMsMyM445/+JMKypTBG8ttI3XH+cJ8iJV4lWsSKuySjmPLbykrki037KJsfLDkwsQljw/8mOaq82iw==
X-Received: by 2002:a2e:9859:0:b0:26f:cdad:e00d with SMTP id e25-20020a2e9859000000b0026fcdade00dmr6819009ljj.419.1666371337583;
        Fri, 21 Oct 2022 09:55:37 -0700 (PDT)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id x4-20020a056512078400b004946e72711bsm3218532lfr.76.2022.10.21.09.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:55:37 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Rob Clark <robdclark@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	freedreno@lists.freedesktop.org
Subject: [RFC PATCH 3/9] dt-bindings: arm-smmu: Add generic qcom,smmu-500 bindings
Date: Fri, 21 Oct 2022 19:55:28 +0300
Message-Id: <20221021165534.2334329-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221021165534.2334329-1-dmitry.baryshkov@linaro.org>
References: <20221021165534.2334329-1-dmitry.baryshkov@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add generic bindings for the Qualcomm variant of the ARM MMU-500. It is
expected that all future platforms will use the generic qcom,smmu-500
compat string in addition to SoC-specific and the generic arm,mmu-500
ones. Older bindings are now described as deprecated.

Note: I have split the sdx55 and sdx65 from the legacy bindings. They
are not supported by the qcom SMMU implementation. I can suppose that
they are using the generic implementation rather than the
Qualcomm-speicific one.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/iommu/arm,smmu.yaml   | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index bae9fb3ffadb..796dc7d4dbdd 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -31,7 +31,7 @@ properties:
               - qcom,sdm630-smmu-v2
           - const: qcom,smmu-v2
 
-      - description: Qcom SoCs implementing "arm,mmu-500"
+      - description: Qcom SoCs implementing "qcom,smmu-500" and "arm,mmu-500"
         items:
           - enum:
               - qcom,qcm2290-smmu-500
@@ -40,8 +40,34 @@ properties:
               - qcom,sc8180x-smmu-500
               - qcom,sc8280xp-smmu-500
               - qcom,sdm845-smmu-500
+              - qcom,sm6350-smmu-500
+              - qcom,sm6375-smmu-500
+              - qcom,sm8150-smmu-500
+              - qcom,sm8250-smmu-500
+              - qcom,sm8350-smmu-500
+              - qcom,sm8450-smmu-500
+          - const: qcom,smmu-500
+          - const: arm,mmu-500
+
+      - description: Qcom SoCs implementing "arm,mmu-500" (non-qcom implementation)
+        deprecated: true
+        items:
+          - enum:
               - qcom,sdx55-smmu-500
               - qcom,sdx65-smmu-500
+          - const: arm,mmu-500
+
+      - description: Qcom SoCs implementing "arm,mmu-500" (legacy binding)
+        deprecated: true
+        items:
+          # Do not add additional SoC to this list. Instead use two previous lists.
+          - enum:
+              - qcom,qcm2290-smmu-500
+              - qcom,sc7180-smmu-500
+              - qcom,sc7280-smmu-500
+              - qcom,sc8180x-smmu-500
+              - qcom,sc8280xp-smmu-500
+              - qcom,sdm845-smmu-500
               - qcom,sm6350-smmu-500
               - qcom,sm6375-smmu-500
               - qcom,sm8150-smmu-500
-- 
2.35.1

