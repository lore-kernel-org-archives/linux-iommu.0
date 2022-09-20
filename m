Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D1F2570
	for <iommu@lists.linux.dev>; Tue, 20 Sep 2022 22:41:13 +0000 (UTC)
Received: by mail-io1-f42.google.com with SMTP id z191so3601346iof.10
        for <iommu@lists.linux.dev>; Tue, 20 Sep 2022 15:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=acW7PJVhTdYkBA5AQtbnFebc9arCNth7+PSPtDUOpfo=;
        b=Z7MfnCYcIcim+qqGvphgdH4M33YcLAgeUBN/vd7YOmveeq0iFnPxHE7TpTg7DEDD6+
         uYFuiywHF3WYbOmv+QL9m+J2pz58MmH7KMs3mF6vE8GyVuJ5Vpkx3/16RgCRPKl1fk7k
         pRqbgW9P6rMxskMJZc1687WQPqkXx9/rN4UwYu9j+PfxKEKGR6V2uJ1Tyar9NIPcuyet
         7jclsmn1PGvzS9U8bK7IUVmoW2ZoGB69YO+HFm6ZlodFQkvXRmqyz0CftzZlF//Zj01j
         oDvuYWgP3FdKx/9DoP8pEwdSJAzQMXJJdLv42/DJ6gUizhZAn9Ig8HZGHHffIi5m7lNR
         h8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=acW7PJVhTdYkBA5AQtbnFebc9arCNth7+PSPtDUOpfo=;
        b=oHevKDYbjNEJEkJgFJ4Rj6dariiBBHQioPvscP+gafpQpuRFNxYAqJ9bvrf5oXygGD
         ksFIYXRccX0U4mnRayrRIMOzd0th6HxlX9USs/oeOl7G9eV3uYkTJncsMtKvnY6KRIOM
         O8igj8rqEbURJ7ykA8RN4hnXQIOWwJsJQAG+daun0Vyy6lWQzjPf325+kpAr+8NgS3fQ
         R/FxjKAWzLoFW3CEZOynBVgtAFoWBb9SOrV2UpXjwrF/dfwlDz/CgMU64L7tCv00i8c4
         yFaH8zNUr8RPVSL/CCBQAfmAuWD2SQVInBn4cyqWP1JYRE2HKeSmN8YZ6bs4PY2Mdm51
         Da+A==
X-Gm-Message-State: ACgBeo309PqalV1W6CbB9C6IcNa1G/bjFoCaYxkjl7eEK/WLI6I65907
	UKYsiyKj/iEDgO6ly/Pb0IE=
X-Google-Smtp-Source: AMsMyM4+jkCURRFCGrTl3ABYsRbi62hzjYjzbfVsh34hPDSBdB4BV1fhwMex+w5glFTMlUA8vM0n+Q==
X-Received: by 2002:a05:6638:24c8:b0:35a:41e1:856b with SMTP id y8-20020a05663824c800b0035a41e1856bmr11958362jat.99.1663713672301;
        Tue, 20 Sep 2022 15:41:12 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::a533])
        by smtp.gmail.com with UTF8SMTPSA id t5-20020a026405000000b00349be675e76sm367177jac.131.2022.09.20.15.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 15:41:11 -0700 (PDT)
From: Richard Acayan <mailingradian@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Rob Clark <robdclark@chromium.org>,
	Sibi Sankar <sibis@codeaurora.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH 1/2] dt-bindings: iommu: arm-smmu: add sdm670 compatible
Date: Tue, 20 Sep 2022 18:39:55 -0400
Message-Id: <20220920223955.151507-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920223955.151507-1-mailingradian@gmail.com>
References: <20220920223955.151507-1-mailingradian@gmail.com>
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
index 9066e6df1ba1..5ad6dc64e1c4 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -38,6 +38,7 @@ properties:
               - qcom,sc7280-smmu-500
               - qcom,sc8180x-smmu-500
               - qcom,sc8280xp-smmu-500
+              - qcom,sdm670-smmu-500
               - qcom,sdm845-smmu-500
               - qcom,sdx55-smmu-500
               - qcom,sdx65-smmu-500
-- 
2.37.3

