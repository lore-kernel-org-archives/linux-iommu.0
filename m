Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5833624503
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 19:20:36 +0000 (UTC)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so2584321fa.3
        for <iommu@lists.linux.dev>; Wed, 09 Aug 2023 12:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691608834; x=1692213634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DE94Q6lf2K2gSTbQ4obZ5qNHgQeup5/EEo7g9MBB54w=;
        b=hVZmOV05FAUjR8G8bAhpPHpxnHhQ6DhH1iewP44ue5XrvSdFh1IvsOVHkaiJ8DJSlG
         OzOwcDv+13bnppTHDKixF9LK3nkTDiV+dt1xhzEyEn/hXtWbFalKXwbjBGPTqK7Ue3S8
         VhYQt8NK97pnxqSmf/IX2GvUWhC0cKQylUtb4hwZV6v8kC75kW3GRNvdZMrY65f6fawZ
         7C3wht1lSE7lEXy0viadI5LBdxGnHoIQCCj4TOjAruUiluS/U7PGpHbDEAzTBE2EGxXU
         cjejMJpG/6Fpud7Gbupf9gt48u1dP6b6fYzfGYNA6pQ7TfjjTFSA/AKGBIr86y1dWgRQ
         RZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691608834; x=1692213634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DE94Q6lf2K2gSTbQ4obZ5qNHgQeup5/EEo7g9MBB54w=;
        b=RdF9BmCa2q2Fai77uk/8RuYfsR77MWM3/zNBaQHYSALBpp6i+IwRbaIaa8CJESbcEd
         RgMgjZp7LhEUUKeR9+3mcUE+V0hNERf1gbmCB9NezJdhMP/7kcK64gVhTKzUgmB8kWOA
         eXBJgZ5mxADGk1Hx8DyJ3swV35J8PyiYMmnbY90Uw6M8+me5vAO5E90f/TeaHZe0Mrjk
         RHqNNyFIVWq0NsHCRTdfslyNIUsyv+QfZ/uTJmErRlaJbcokOZcEft8LIAJzzHdaEWPd
         DQEX2xBNmIJ7eUGRhdg2nyRGjhokLWSZwKRjKKINmcTqsgVJ7z4dokyI2TyV0kcTCy/f
         dzKQ==
X-Gm-Message-State: AOJu0YyV/qbtoLfWWPTzAIcLA4+8T2406E+ZD6dxXyfa4N4EkRVprss/
	m1Kmrg5wRg/E/4I/EktRADwoCw==
X-Google-Smtp-Source: AGHT+IH91D5GnSETRj0u3DPt3bzPi4croUy1p68YiToywW5aS9a6UlkxNDxyQkW6FnSr1PCZ1vpbrw==
X-Received: by 2002:a2e:8550:0:b0:2b9:b9c8:99 with SMTP id u16-20020a2e8550000000b002b9b9c80099mr104092ljj.22.1691608834133;
        Wed, 09 Aug 2023 12:20:34 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id o3-20020a2e9b43000000b002b9ed203af1sm2863218ljj.132.2023.08.09.12.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:20:33 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 09 Aug 2023 21:20:25 +0200
Subject: [PATCH v3 2/6] arm64: dts: qcom: msm8998: Add missing power domain
 to MMSS SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-topic-8998_mmssclk-v3-2-ba1b1fd9ee75@linaro.org>
References: <20230531-topic-8998_mmssclk-v3-0-ba1b1fd9ee75@linaro.org>
In-Reply-To: <20230531-topic-8998_mmssclk-v3-0-ba1b1fd9ee75@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, 
 Imran Khan <kimran@codeaurora.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Joonwoo Park <joonwoop@codeaurora.org>, 
 Jeffrey Hugo <quic_jhugo@quicinc.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Jami Kettunen <jami.kettunen@somainline.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691608824; l=906;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=EM5tWZgcQ/PtQiCuUMktQpuJVbPaCBzE0y/oEdPpoBk=;
 b=DgG5WM7aCnxlKKTKRxJyT1NXqA7+tx0CEHA0dPTjvPgAtp5Ajxf5aVQKXXHPrMj6JtpuzIu7l
 Adop0zBmFK0CA+8JhrdwrZpDm3sn/DQGCO1GR9TImxjwOVAXckjOEC3
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The MMSS SMMU has its own power domain. Attach it so that we can drop
the "keep it always-on" hack.

Fixes: 05ce21b54423 ("arm64: dts: qcom: msm8998: Configure the multimedia subsystem iommu")
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index e40f6461f4fd..39db67211fae 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2770,6 +2770,8 @@ mmss_smmu: iommu@cd00000 {
 				<GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+
+			power-domains = <&mmcc BIMC_SMMU_GDSC>;
 		};
 
 		remoteproc_adsp: remoteproc@17300000 {

-- 
2.41.0

