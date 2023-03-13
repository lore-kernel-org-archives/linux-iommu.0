Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495112F55
	for <iommu@lists.linux.dev>; Mon, 13 Mar 2023 16:47:59 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id s20so16512229lfb.11
        for <iommu@lists.linux.dev>; Mon, 13 Mar 2023 09:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678726077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4EPxcSMKiqyNw8mJBAxwHQ7n6kIvPBes74o/rWBPSc=;
        b=WGT3m6Bq+FlMV89lAyG3qHtf4a7T1H74+Zt8ihSuVZidukp4nDaGzKHmFa6q8SuA7j
         EDSs201AUmv31A5BHRpq2n51b458N4EvR8I7r7vthkBwWOIpqQdu/JNLreVpqtMk09hq
         cU1aPHmMkWqVNY+nupjvZBQX7dOmxcd6PGVHAcgmndK6UGTIZr3YYfbnyKZj/LUma8Gb
         U4v0ehJ7U5kdnEnb4BpMvW2qB2X+SOzcuEY9V21ucFMBjdAjECYLzVG148tj4qUCkrvI
         EWB0khNY5ToBkHQS7WGdwCttlL7zYurFiuEjI4z8gpnMGiSq7lG8avHwuls7gAZTmaIF
         8meA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678726077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4EPxcSMKiqyNw8mJBAxwHQ7n6kIvPBes74o/rWBPSc=;
        b=DgCfLBIXXiEzjxc/fGtckA2/iPwxhpRIohNjOENI1dif62QH/BLEIS6ijfDAiBEmIF
         fA7QDAJFaUu009gDoxEJHr8rtbR8X+4EyI1gaxhwoKomAyMUy4o4K+oYgvmfBof0XRta
         8DMZFg0VmwdifEEfofbzFXMovllx2wtJ3RsJMWalkviZ/h5590azKQ/BPqW0L4tyAo7n
         RqqnD2MCUDtvA13wzwI4cOAh3kIEAkV2YzUvcziYK9WmhE6SXA2k38BU+evtE6372PG8
         boWMaCXNMPJ8OQN1VY3EB4Z7GC8Td013DaidfxHfgO8SRyHJYkMp2bix1IWyMFFuFgfW
         Uv2A==
X-Gm-Message-State: AO0yUKVllR/WAxW68Xp6BJPM/d0V2Onj71AJUtz8jvtdlPFgrKPHSRH2
	rF5/aCAbgNPzSpsbtWnbbGOdnw==
X-Google-Smtp-Source: AK7set/Jbk5EExCKOsl9LSNiNwUukfcT6PIrHp7lrdbYtZkzlEltDW1HfF8bJ5S6P8Vybs45H+Azog==
X-Received: by 2002:ac2:4859:0:b0:4e8:3f35:6844 with SMTP id 25-20020ac24859000000b004e83f356844mr1879171lfy.19.1678726077472;
        Mon, 13 Mar 2023 09:47:57 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id o9-20020a05651238a900b004db48ae69cbsm18134lft.206.2023.03.13.09.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 09:47:57 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 13 Mar 2023 17:44:21 +0100
Subject: [PATCH v3 6/6] arm64: dts: qcom: sm8350: Add qcom,smmu-500 to
 Adreno SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230313-topic-gpu_smmu_bindings-v3-6-66ab655fbfd5@linaro.org>
References: <20230313-topic-gpu_smmu_bindings-v3-0-66ab655fbfd5@linaro.org>
In-Reply-To: <20230313-topic-gpu_smmu_bindings-v3-0-66ab655fbfd5@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678726067; l=837;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=B33R6GkwOZUQE4WAkOBwxyKbh5vZSkdob4J+byg527A=;
 b=rbYRN3k+OOfapcGQJCdMVaFAS/giXvdxVEt4RJwwDV+/PVlnyaHmUoaBAJDQCYdc7LLb+ZIY3uwb
 Pd3VvH/pDaIRSt3IcFGDqmVWwr3M5IlEKmWKVPvQv/qNIJIohQhy
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add the fallback Qualcomm SMMU500 compatible to the Adreno SMMU.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 1c97e28da6ad..19a6a9785936 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1907,7 +1907,8 @@ gpucc: clock-controller@3d90000 {
 		};
 
 		adreno_smmu: iommu@3da0000 {
-			compatible = "qcom,sm8350-smmu-500", "qcom,adreno-smmu", "arm,mmu-500";
+			compatible = "qcom,sm8350-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
 			reg = <0 0x03da0000 0 0x20000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <2>;

-- 
2.39.2

