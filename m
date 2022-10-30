Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B35E23CD
	for <iommu@lists.linux.dev>; Sun, 30 Oct 2022 09:43:15 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id h9so12144081wrt.0
        for <iommu@lists.linux.dev>; Sun, 30 Oct 2022 02:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUpdkVpaImdCke90/hvYwepQ6uJUg8seHB9Am7OQuCE=;
        b=YDoaDcvGm5/74XBRKcUtgPnpzebTfHlZ9NG8NTgrAJ2M1ghiBCDB7AGgPG1pAg81Yl
         YOMTtbPi0eJgKr+Rwkih1doM8lSTYuIQ46Jxxwkxt+GH8LUlJaVmrLtXO+zOiDqkl6bG
         DQpgngULw570soTwcEqpYHV4zk8t35OllQP4rsjoVV7UMOaKLUYL22XmXgTHtnngmMO7
         OumsUKl8O1FxL9SvuX67lsSsLh+5wRYpqYaBWQGdS2D3cAnKJYsYhbseGzxg9O8IpY9C
         0C2XkF8bsPqHwgCPCBMUs96kC8PxxFEpwSlhZYqFVDhnpXKqlKefqCmxWBzl5asTl97U
         aJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUpdkVpaImdCke90/hvYwepQ6uJUg8seHB9Am7OQuCE=;
        b=0WWHTOUmDkJe1t9Z6uUuJ9vBcIO+m8CwVZsYjOp3lkPJedvdOL2pEKOnP+6vukAn5s
         4TlvR8uqJ0a9iu675g54k1F5UcWvtxEXhSwr3H3cja/q9HMSPtC962eWZjc0Cd8CnikB
         3owIE26Oa3yxOM+8H3JL+TgKrpb+G2R5z4BRYxD5aQeThR8nO5KqmId6Z3YLNkKBhaD9
         L5mx8RaURMgAsLNtby3hNlorfTbej5NT4RY45f9jH6i5071iaa670FCoJlE0bl+l3AFG
         oGgy0Rn9G/7Kf6se+BO9aY1rYi0Ez1x3EI2GmjtWw5MxdDfttQG4ixvpeYH5b9BMZoig
         W1dw==
X-Gm-Message-State: ACrzQf1O64p1vt5kSxvZ8n/NHcgE0Hl/bATN7g/M5KbUKKxKKMZVas/6
	USItTLlPzYCCbO7UvoalzLE=
X-Google-Smtp-Source: AMsMyM7heg9wKmi/oOgWiJ/mRAMCVBFekD7edTZFfwYWgxwAdc4pO/kOVbDCqV13pcsJDN0mRiNgfQ==
X-Received: by 2002:adf:b644:0:b0:236:59c7:c6de with SMTP id i4-20020adfb644000000b0023659c7c6demr4463776wre.186.1667122993833;
        Sun, 30 Oct 2022 02:43:13 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id k3-20020a05600c1c8300b003c6b7f5567csm18453039wms.0.2022.10.30.02.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 02:43:12 -0700 (PDT)
From: Iskren Chernev <iskren.chernev@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Adam Skladowski <a39.skl@gmail.com>,
	Iskren Chernev <iskren.chernev@gmail.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/8] dt-bindings: arm-smmu: Add compatible for Qualcomm SM6115
Date: Sun, 30 Oct 2022 11:42:54 +0200
Message-Id: <20221030094258.486428-5-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221030094258.486428-1-iskren.chernev@gmail.com>
References: <20221030094258.486428-1-iskren.chernev@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adam Skladowski <a39.skl@gmail.com>

Add compatible for the Qualcomm SM6115 platform to the ARM SMMU
DeviceTree binding.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 9066e6df1ba1..71f8f638a1f8 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -41,6 +41,7 @@ properties:
               - qcom,sdm845-smmu-500
               - qcom,sdx55-smmu-500
               - qcom,sdx65-smmu-500
+              - qcom,sm6115-smmu-500
               - qcom,sm6350-smmu-500
               - qcom,sm6375-smmu-500
               - qcom,sm8150-smmu-500
-- 
2.38.1

