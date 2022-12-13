Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED29A7F
	for <iommu@lists.linux.dev>; Tue, 13 Dec 2022 00:26:33 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id b3so2350716lfv.2
        for <iommu@lists.linux.dev>; Mon, 12 Dec 2022 16:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64a16xm03GDRzSrRzGbHGfzDIJpeFaTeX77Wh7ttti4=;
        b=iuYfFxLfpTQ0Vm7Ok91YF8ZXJ4acYipdS6f7TntzmkZxAwjmS3B6lXk16+ACdini3E
         Mpo9Fp4hwU/4FxW/kfVEPlW3CVdI3XihyKrdCx4okSOSNMpSkP0z5s7tcVhzI2p/jy1L
         pIGrPvY6EyoZH1I2Z1qEnnkhKIlme/ueWzMN1RChyxFHhi2ziLKaphFjWM/1meO5wq2I
         uikUmwFHzKq9ERztMJAh1WhP2ZDPzW6lrDGYJ8baUPHr9rmFk8CQFcP92w035VA6XPbN
         B2AL2sahczhBh46UPTOSob/xyMDjC9B8yanWNcsjy/B+BJc229qMHS2p7sUPyGsIdhBL
         awuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64a16xm03GDRzSrRzGbHGfzDIJpeFaTeX77Wh7ttti4=;
        b=Z15cwOmyIPo3pV76wzurFxTdCttk6SEcMI0/ZMlhtWi1CszeEQPL1AFb/+yjn08A9Y
         SVHAEGHmQAFLMwI740NYBp/ceSWjbHb+RAUEZVyKAnJz7vV1rPFjKPk8NryZfzJaBAae
         Ineapq8nj3JzD8evBtxb+1dd3Nkl1qLT3bC5Ql/+abUJ9lZ8K/kdaT7ZSHGfLQ9towI2
         jraks5hxenlwxrM1Yh6tWzTdHPPcXIgRJTihPk7+V2Ya3YpUMxdnbVKWq5BYzUq+FEug
         yMtcU3HOoF7vRWQQVeo3AccomrTUcMqYohFb4LhFj/kOtxi/ygyofynBRKpqnMwS+ff9
         bizA==
X-Gm-Message-State: ANoB5pnh5f4VMGZmvnASqgqpHZzAXf6afSswJ4WjLZtlOEbfFaRtDSWU
	oj3446NCrSCJ9HYhbdhUT58GEw==
X-Google-Smtp-Source: AA0mqf7IM9a/qZExoPzn3FRqUdqlme93mvUre5klopIcd86b/7ZAfQ5P7d5H6I4XRQvzJRo/BoHueQ==
X-Received: by 2002:a19:ee11:0:b0:4b5:b6e8:bb53 with SMTP id g17-20020a19ee11000000b004b5b6e8bb53mr2934454lfb.24.1670891192101;
        Mon, 12 Dec 2022 16:26:32 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id y28-20020a19915c000000b00492dba3c85asm139371lfj.220.2022.12.12.16.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 16:26:31 -0800 (PST)
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
Subject: [PATCH 2/2] arm64: dts: qcom: sm8150: Enable split pagetables for Adreno SMMU
Date: Tue, 13 Dec 2022 01:26:26 +0100
Message-Id: <20221213002626.260267-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221213002626.260267-1-konrad.dybcio@linaro.org>
References: <20221213002626.260267-1-konrad.dybcio@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marijn Suijten <marijn.suijten@somainline.org>

Allow the Adreno GPU to access split pagetables specifically on the
dedicated Adreno SMMU via the qcom,adreno-smmu compatible.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 3f940cc3f32b..83b4450fb3eb 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2253,7 +2253,7 @@ gpucc: clock-controller@2c90000 {
 		};
 
 		adreno_smmu: iommu@2ca0000 {
-			compatible = "qcom,sm8150-smmu-500", "arm,mmu-500";
+			compatible = "qcom,sm8150-smmu-500", "qcom,adreno-smmu", "arm,mmu-500";
 			reg = <0 0x02ca0000 0 0x10000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <1>;
-- 
2.39.0

