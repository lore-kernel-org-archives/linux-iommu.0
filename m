Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BF1377
	for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 13:31:49 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5007abb15e9so9648360e87.0
        for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 06:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694525507; x=1695130307; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DABEF/G0wTiJLHQeIezECcYyIyidOzxpzwuEiL5oGQ8=;
        b=sEzhX84XlJPhJPpTeEt4a8CedXnSIuB8+WizkEVZWNr+HM2Skm0H6wkm4Dp/z0KCle
         CUFa6v+UrBMNY8ctnkLjH70PLAGtkAYsSNqzkTe+cokPedmGDCLQ26/Byhz+vJ7c/a1V
         rExFbwjJwLoDzcBE59guZca8ysbBn3leQr7egoHCDS2rH1BcadrGSv576E6Bq4edXdjF
         dBRfjcTO2TmG6OZM5r+5rxl+6DtcM9katINcNVP6Zac9+3wwKcaWLrRd/8RN9Lcq60vG
         UfkHB07MOOoCqI+Pi22x2tW8NsMdXNqPjyPCVhDIP7Vns+Lw8niJ+00oU6fBBcZg0kwW
         i/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694525507; x=1695130307;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DABEF/G0wTiJLHQeIezECcYyIyidOzxpzwuEiL5oGQ8=;
        b=E0YMxAA2VhQIeopS0ZybzAVbVMv7yNk+GXujau1xwsICAVBqK/KzmSY6KmXHaXhHFT
         4xZIPDApRJ+FSVgykonNAf7DVkES77i0k0LiNckS9nIgyb2VDqtARxLatMaqT5J0+cjA
         /ImLHFmkUBwfNX1586KDmeADc+UHn/Pc7Zta3GCOIwsr0EcSJDKl/XIj2Wc2AaWxtpBv
         Xwcrh2H8j/CvwyGvnT7BFcHJbNELACep/GktBP1qOD941H6Ye4fh6UfQPHAA8TTaSaTo
         W0nVbtq4tYf28TiyFmVjrXq8icTAUFRSnOdRQKXf3ZMtqjplLG5CaSk9X5i1jJESYjUe
         GYow==
X-Gm-Message-State: AOJu0YxLex9w63S/RZgwPZzGoDZN4gKQ/eHmtrZDkm+j4XC9bDvVFZzS
	bsHS89Nwqr1MMOwaNZyIi3+J4g==
X-Google-Smtp-Source: AGHT+IHEHh0RuaM89GO2hy33d9QpNiA2N0B89tFWDc2B23V2RZl4ySKvDHhVkP3r7XzN4VntItjF+g==
X-Received: by 2002:ac2:446f:0:b0:500:a08e:2fcf with SMTP id y15-20020ac2446f000000b00500a08e2fcfmr9054444lfl.47.1694525507137;
        Tue, 12 Sep 2023 06:31:47 -0700 (PDT)
Received: from [10.167.154.1] (178235177248.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.248])
        by smtp.gmail.com with ESMTPSA id j2-20020aa7ca42000000b0052a401d8ef6sm5983830edt.71.2023.09.12.06.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:31:46 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 12 Sep 2023 15:31:39 +0200
Subject: [PATCH v2 01/14] arm64: dts: qcom: msm8916: Drop RPM bus clocks
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-rpm_clk_cleanup-v2-1-1e506593b1bd@linaro.org>
References: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-usb@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694525501; l=1386;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=jgPLe87izszPiDVl35EMBCgsp6Vij2I7vaEdqKi1gBU=;
 b=2fKLEWzJA+nSA/bz6EqA9PkDhmKN7tvdi3UL3T8CJtwuqm+enkROCBJOZJCyfnGnGB+n0FMjD
 DM7sq1O8eOWDGxuI1JAPanQEN8YsRm7jUt5bJY+TEsyv1w4auLZg6gs
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

These clocks are now handled from within the icc framework and are
no longer registered from within the CCF. Remove them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 33fb65d73104..8c2ec09f57c4 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -519,9 +519,6 @@ bimc: interconnect@400000 {
 			compatible = "qcom,msm8916-bimc";
 			reg = <0x00400000 0x62000>;
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
-				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
 		};
 
 		tsens: thermal-sensor@4a9000 {
@@ -554,18 +551,12 @@ pcnoc: interconnect@500000 {
 			compatible = "qcom,msm8916-pcnoc";
 			reg = <0x00500000 0x11000>;
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_PCNOC_CLK>,
-				 <&rpmcc RPM_SMD_PCNOC_A_CLK>;
 		};
 
 		snoc: interconnect@580000 {
 			compatible = "qcom,msm8916-snoc";
 			reg = <0x00580000 0x14000>;
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
-				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
 		};
 
 		stm: stm@802000 {

-- 
2.42.0

