Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26B83C3A
	for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 11:16:26 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id i14so2459762ljn.5
        for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 03:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0e01nddNNggomilaOmguOcFx036Ua8m431JWLUtouH8=;
        b=CFjALJfnxDN/Vkk/EMv9EpN+uCLAJekJSpOmCzBM9HXaRJ1JDo7s2RCA5W9MOFiU4O
         LSz8x1NWXU/in4bBl5bfF+OzpMaO0it5JqnthD7bg3demWpykgfsjuLvr9zKwHciV5wm
         ntBwFtaAAlAt3gNjbBxObFbRG1Mw+QvPpogE+FebZvekkA1XJuhO4OwosATUot/pcB39
         CdXW73vyWq+1LejmEunqRaXoQdvoAvZS653gC2SD1x+g4TwVsANDagPpvF42OqrznDVj
         6TUy8oUbhmODSfsNDQLct/ogTWOGCZMbxm8pCozighMcbny1GUQ1RQQ9uf+t7CHnHjXG
         jNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0e01nddNNggomilaOmguOcFx036Ua8m431JWLUtouH8=;
        b=UnYfd8bVoRBGr+4lkF5DqDqlZzqmZJsoAzTDWaJMOjERlVUTzYqwr9Y17ICPkQphDD
         GJZTu+b8fR6jNO2Rz+YZ/j+MnthbK2currPrap50OFFtDU8arAmLx9Z6hDlWF9u5Vjue
         pQGWm3nZ085y4bou0pDMA0RtSnJALt/EI5UiXldXhz5yfXAKqYTQZhfPj60A1bHxuzjY
         C2I6mMutLYGrDuQAnxnDMmW1z2DjN62Pi7aIZpjiuehY86h5ilaak9SHWPXMEFHkZCge
         zxMU1MxuyK2zlshWdlY993E995pe2efMQhp9mha9+1ZbQbTTKbtV86V/YpYrwIxwaBOc
         GIkA==
X-Gm-Message-State: AO0yUKXSjUW+pTzbibVW6Ble5Y6PC4Mn+alXn5De1A8WdbvIGqSQAZ+7
	6lqdZ9/dton9JuWQKjbKYoHWMQ==
X-Google-Smtp-Source: AK7set8UZtt/gDomOxIqtofjuy2wALx/F9R2DtKLK8ThMjlMdmnvCx7zhJ+vQFPf9RFthPrvueUFsA==
X-Received: by 2002:a2e:574b:0:b0:294:712a:5190 with SMTP id r11-20020a2e574b000000b00294712a5190mr739293ljd.28.1676632584963;
        Fri, 17 Feb 2023 03:16:24 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e9b15000000b002935899fe3fsm554818lji.116.2023.02.17.03.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 03:16:24 -0800 (PST)
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
Subject: [PATCH v2 4/6] arm64: dts: qcom: sm8150: Add qcom,smmu-500 to Adreno SMMU
Date: Fri, 17 Feb 2023 12:16:11 +0100
Message-Id: <20230217111613.306978-4-konrad.dybcio@linaro.org>
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

Add the fallback Qualcomm SMMU500 compatible to the Adreno SMMU.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:
No changes

 arch/arm64/boot/dts/qcom/sm8150.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index d94171f9b73d..3da77141a164 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2287,7 +2287,8 @@ gpucc: clock-controller@2c90000 {
 		};
 
 		adreno_smmu: iommu@2ca0000 {
-			compatible = "qcom,sm8150-smmu-500", "qcom,adreno-smmu", "arm,mmu-500";
+			compatible = "qcom,sm8150-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
 			reg = <0 0x02ca0000 0 0x10000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <1>;
-- 
2.39.1

