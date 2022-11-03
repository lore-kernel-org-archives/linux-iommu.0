Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14C33236
	for <iommu@lists.linux.dev>; Thu,  3 Nov 2022 23:26:53 +0000 (UTC)
Received: by mail-io1-f41.google.com with SMTP id e189so2672292iof.1
        for <iommu@lists.linux.dev>; Thu, 03 Nov 2022 16:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohmDTFUOiW1LyAxV3uDApErdTrUXX1i+ntWTEQeQjr8=;
        b=aNYK5b/3kxf+aOrZG2yNA0vsgLLaIGHSvzsd1HsFnACLhJKwVa8sKXF+hWUmAOXe+x
         Qh9jdyH5yFXMFgWfzSm6mLsyOb2afOy8/lc5hKPqoE9qgkd7fsyONF7zlNWWppc0z5yf
         JffjfCo3gzvChfdX1HpRVOscDik2AjqYoNaeleXNEqONDzYy9ld2mCKH6b0MtGSsOj99
         4aB2LMSzeXFuCPvKp915nylnXADhEHGHN64MWB1X8SWnD7aBF5RICIIfQf/hMejG/4nG
         J3s3zSWv8oEqbVlR3P5uEf2zkd/YvNli1W4MCakEVjsU0Jd1/JM4UijfX+bXJu8zjxmJ
         qCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohmDTFUOiW1LyAxV3uDApErdTrUXX1i+ntWTEQeQjr8=;
        b=12+pMFAsk44BzDeTIsqg25oyeEmqxkaQpGP1fWh1ugSmtvHO+bpfdk3DZSY2uul7zK
         za2hHkUKSW3P4MM0DOPilXZ57RvNgPyWL//5XFwysEbCqoBOuVWYB8vWtJF0SNi7RQra
         GbvonypQvnLuCgxjFJysyNwEcAvLNcRxQcH5CBGj1WOKa0apPgpe4zu71xhm4k8PFFNA
         M1mJJKekM0kQbhxMthegMnws3pSJqSR/SitjmLybKOVUuMESr3iE8lQASWIAFek0uTig
         DmD/R80I2nbNG8OsB7XtmmtvxRUdEXS93zR0LSPGyDRRRiayAn5YxdWKOp/sGHdG1AmJ
         kJVw==
X-Gm-Message-State: ACrzQf2QwSFn8wLweUOhnq2vxMrbHxfVO3QJ4tJwedx5QX0L0oxyakec
	WSfDnZMLlG966QwvxD/PElE=
X-Google-Smtp-Source: AMsMyM4Oo3hgepPcOeOftvCOU8Kuz/3EEh9yi+s+zFHU/43gUyWRZt2q2o0MWTMqVR2lSRhR8y6RlQ==
X-Received: by 2002:a05:6638:478b:b0:375:bbb:f642 with SMTP id cq11-20020a056638478b00b003750bbbf642mr20042428jab.129.1667518012782;
        Thu, 03 Nov 2022 16:26:52 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00:f1f0:c4d7:e39e:e2f])
        by smtp.gmail.com with ESMTPSA id f4-20020a02a104000000b00374ff5df5ccsm642866jag.167.2022.11.03.16.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 16:26:52 -0700 (PDT)
From: Richard Acayan <mailingradian@gmail.com>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Vinod Koul <vkoul@kernel.org>,
	Emma Anholt <emma@anholt.net>,
	Rob Clark <robdclark@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org
Cc: Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: iommu: arm-smmu: add sdm670 compatible
Date: Thu,  3 Nov 2022 19:26:31 -0400
Message-Id: <20221103232632.217324-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103232632.217324-1-mailingradian@gmail.com>
References: <20221103232632.217324-1-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Snapdragon 670 needs the IOMMU for GENI I2C. Add a compatible string in
the documentation to represent its support.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 796dc7d4dbdd..f77597e8ed39 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -39,6 +39,7 @@ properties:
               - qcom,sc7280-smmu-500
               - qcom,sc8180x-smmu-500
               - qcom,sc8280xp-smmu-500
+              - qcom,sdm670-smmu-500
               - qcom,sdm845-smmu-500
               - qcom,sm6350-smmu-500
               - qcom,sm6375-smmu-500
-- 
2.38.1

