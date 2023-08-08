Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6D08492
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 09:44:53 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so8928716e87.3
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 02:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691487891; x=1692092691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+614xtHjgD1nkm8xRBKqqyV2uZni5hqr1Y2F11sHVk=;
        b=QrrSZlNH7DwCjw8YYQSdqDs0bUcxQDorMEYEk7vp2qS6xl7os8OPuvCrC0lUCKxE8B
         gCB0QInnqHTXhGYWZmjvN8lVHlMjKq7ltiNhZ6kTxYXA5S9jh6gsfqL87TPRG2mcpBtv
         ekqBWdXMfFGCG4iWWYM1g9TcIvvhLxarkOIm/A7dZzYd3aXULM2jvMm/RprLZr8M7f3g
         X09MNDK2eCSehGh82bpEou5bqzlyLbwQNwBaC0rUhUz3jKJK5GkVFSMZgVXz3DxaNzE+
         AzW5XUnG8QwRY7CHGHNfJ9H4GDrLTFrIs9LfaOIaJD43UTB/K/ImFXjCIlebg8yDU4jO
         Echg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691487891; x=1692092691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+614xtHjgD1nkm8xRBKqqyV2uZni5hqr1Y2F11sHVk=;
        b=J+SWbf4xcPl0vFiTtWkcELIn4VygGpQWgGlBpz914GY+e703dCymejx1g+4u03sXJ7
         GfLiy4m3eCfD/9WQlUopOHsgsU6PW1L2Zun8VEYiYgHOQzKiBc6ijXWdW++vCSDAjDBo
         uhk7+aqFFzU0AOVcv102A3iSp3MOUhuZ/iNpN60Y8yrvK2MvjVMnK8rMhHcdtZY1xKy5
         qOnQFw/dxzj7GSoj86HtlWzTds+9PjvcLuXJ8HynZrvylxeaqtMOXVdxrPWYza/D5DvS
         WHsLjojZLOrv8HUK9ZsIX0ykjyjiM9N5fA8bG8SVc6AxgyxX0zQr16M1mnHFYfzFKlr+
         SQXg==
X-Gm-Message-State: AOJu0YwAKoQJB9r88YcQBRKFqzvh7TTUp8nggrksWeNBqERG3WLUysJS
	NvRsSPRk8UxCD8Cq8saGK1nYJA==
X-Google-Smtp-Source: AGHT+IFVMdcEkHvqjIMX5oEgG2oBE7nbsEMOVRk5VcpuTnRc1mcmt8mNUyLq7GYjCrQ3jyb2zmb5Gw==
X-Received: by 2002:a05:6512:e9b:b0:4fe:5680:db1f with SMTP id bi27-20020a0565120e9b00b004fe5680db1fmr7912704lfb.53.1691487891249;
        Tue, 08 Aug 2023 02:44:51 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id i6-20020a056512006600b004fdba93b92asm1818884lfo.252.2023.08.08.02.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 02:44:50 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 08 Aug 2023 11:44:42 +0200
Subject: [PATCH v2 2/6] arm64: dts: qcom: msm8998: Add missing power domain
 to MMSS SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-topic-8998_mmssclk-v2-2-34273e275c51@linaro.org>
References: <20230531-topic-8998_mmssclk-v2-0-34273e275c51@linaro.org>
In-Reply-To: <20230531-topic-8998_mmssclk-v2-0-34273e275c51@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691487885; l=854;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=/yznmFUOFfvt3H81R22ABUv0eOeLe9LUwSr+QNKzGV0=;
 b=6ok/LWtlPH6zSyy5UMAq/t5bgWP3Ud7Ij9vBySuwjh3vMiS1gJVjxUKw6nLHyS95ARxX+LJAd
 Ibm+ib3FKxpBIIhASbXVDOfZYxEwn1cNsRmJHG+sQTEmtuUOfL5elUO
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The MMSS SMMU has its own power domain. Attach it so that we can drop
the "keep it always-on" hack.

Fixes: 05ce21b54423 ("arm64: dts: qcom: msm8998: Configure the multimedia subsystem iommu")
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

