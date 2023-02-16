Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02D1746E
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 14:56:52 +0000 (UTC)
Received: by mail-lj1-f169.google.com with SMTP id d8so2211451ljq.9
        for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 06:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ojDsOUx0QxlHwnKO3iv7w8jD6D1QkQboQ8A+JjRFmOI=;
        b=SondPCscTEEfrANSxAKrbtewG6FLTdvIPFAFYYLnp3D6+Sn+aQcShVMUm4krMOXcjZ
         zbo80ni77TnS8/+4ZDiNXLavjjm+yeKidHBAkz7jX3QA31vJzCCCIqi/Kuh9dzPDXXlM
         /hIpwe6+bwykNTXyuP24UuNpY2pgy2hRN5tf7u+OnnbVUZmXyC0Sif2c2hQyi2K7J93f
         qX3ZquTNqVEE2BsSD5RTSPRcD8CO6ir6oJc7acuOYeiHpd1yUmdEvLFQoRF4sdnHisA1
         a0csh6t9NnYQ6mi2jZwM7GMJ3HXYDMvMBOdq8newuRzxiAUWyrfbywABB9wT0OFft/jD
         lPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojDsOUx0QxlHwnKO3iv7w8jD6D1QkQboQ8A+JjRFmOI=;
        b=Lb0tlmLIZtVmm8wssYfF2LaRNHbwxUqaJBJc2cSqrk7hFCfOj//H7CTHRlq6UDLgfj
         8T+zop1PRvkiyt5I/AU3OL2U5uC2XW7a/YvNvsNYFWpIjaD+M3XqYgMMk8FFvVBTrGEt
         cUMUvfzy2ZWE5xwmwF2Nwch7ykcWIYdBRCu+f8RhzTOUhxwF1hXZIw7iWULHi1kZGX+u
         HXs5T1U7hbduZ+J04JWJzTWN4JKuPna5+9XllnVZ93sdejUQDj9HXY1WCJFftHvL13/f
         CKPrqFpdims0ANIGx2oJCNYoN7AVhKPfEOJoZ+PZKlLdcdYh6gaYHIsVVfknxNFmx8fc
         KMaQ==
X-Gm-Message-State: AO0yUKViuQE5uVKRBGTq4p1d78u0bUAX7ybj9/KVhP01o8MKcH1Qz56P
	fy9R7+HlQ3RNvM0zTOAdD5MLPA==
X-Google-Smtp-Source: AK7set9+IAinWnvv0qZQ8rLV8eYgth93ol6l9oBQDHdUVVXXttEPDYhOnNeijW8y7UR22spzLJj41Q==
X-Received: by 2002:a2e:a365:0:b0:28e:732e:206a with SMTP id i5-20020a2ea365000000b0028e732e206amr1548884ljn.12.1676559410725;
        Thu, 16 Feb 2023 06:56:50 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id f2-20020a2e1f02000000b00294619d902dsm230012ljf.112.2023.02.16.06.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 06:56:50 -0800 (PST)
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
Subject: [PATCH 1/5] dt-bindings: arm-smmu: Add SM8350 Adreno SMMU
Date: Thu, 16 Feb 2023 15:56:42 +0100
Message-Id: <20230216145646.4095336-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
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

