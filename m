Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D576D377
	for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 13:31:53 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so65758425e9.3
        for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 06:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694525512; x=1695130312; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15fMag9VX7XAPE7WmbOLmSr+PWzruauhSVe+u6uS4NU=;
        b=RTl1IP6lgR2rvtVZFUGUl39zgqxP3jDvmCLprAEV22SGP52dAp+Ybq47YD3ZyGbGA1
         gufsHTZpy7KAYQkFFteFqN7yFaUpsb2rMuUtAsulPhm0BkV6crzMRj6uo/vyHLN9sA87
         tt6EKVtAntRuZoNflJuhpcy86KtrKm6pGBPw09NKN7neGnc4HuHsqF5Pjnj7wuNwX0PU
         Zsa/RIRHFJ+L2iTRRyrAMZvvpm6G2JpAshj+iufKWVrApKI+BQYqnmxdVmnMYJyUBeAR
         iCgzsFOebNq5tdGcIyk4BzJjwCebGqe8MjRB09rjHKX1bW6lS+Fin21f5S3gZBH3zdfs
         jioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694525512; x=1695130312;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15fMag9VX7XAPE7WmbOLmSr+PWzruauhSVe+u6uS4NU=;
        b=WbIAfj3IpXUGjvNxYfXNjaat4Gx8FaCBBu+WQ41bh9HZHc73Em31/zuzLoyLnKdqPO
         lLs2ia1ATCYFNoG2ZYI7LtC0KLPNO3hPMno1U8I8mpOIK3UjVv2Fg9dwuJ1gY7oH1d5R
         hrJWUgFAV3XbNX4aGDhGiqYfpa5tgb81qFD5wO8rU+efW8NeT85BmJ3msr7y5sxrKQb9
         ITEFLFeOBflCAPrdJwMsIzUn0i4BYzSF+FHwAK2GMuEFLpM9J+Eqd4KA8njz1Vivelgm
         RcB/LdUb3Qzqpx1f5E7znm/ttn+KQClS26cwo4rkEv9rzhmcfASySXkYH59RpEkLa4Bh
         QC2Q==
X-Gm-Message-State: AOJu0YycUDcPO18yL1vhOdktoYU5DFOVQXXopSEffOeicbZieA+vdXUN
	SOzvFWnoq0TvAEbIWVQNoKixzg==
X-Google-Smtp-Source: AGHT+IHd3ESe9Shu68oMdeAkDreczDIAgdPhaKrNx9GOH0Mj5Uh2yWT/aRZ1vr4DmjfizwKtYKk2IQ==
X-Received: by 2002:a5d:6ace:0:b0:318:fa5:d84e with SMTP id u14-20020a5d6ace000000b003180fa5d84emr10328320wrw.70.1694525512184;
        Tue, 12 Sep 2023 06:31:52 -0700 (PDT)
Received: from [10.167.154.1] (178235177248.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.248])
        by smtp.gmail.com with ESMTPSA id j2-20020aa7ca42000000b0052a401d8ef6sm5983830edt.71.2023.09.12.06.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:31:51 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 12 Sep 2023 15:31:41 +0200
Subject: [PATCH v2 03/14] arm64: dts: qcom: qcs404: Drop RPM bus clocks
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-rpm_clk_cleanup-v2-3-1e506593b1bd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694525501; l=1392;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=pDVqi5u1eyS8PF+LLrKBDGtxabkYLIBhlo/it+9/q/s=;
 b=eEGSlqgAFu1mD7wz/jcb6jk10/d5zKRZp1o3SpDMYtk0OyzPD6rNVhhHK0f3HqD1/bzDhdFIi
 AqQmWf6aqv4C1tlXP+J+YqtrCmf/Jp3XN73wYwld8apbiDkMHA3h8+o
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

These clocks are now handled from within the icc framework and are
no longer registered from within the CCF. Remove them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 2721f32dfb71..317a0df30b83 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -558,9 +558,6 @@ bimc: interconnect@400000 {
 			reg = <0x00400000 0x80000>;
 			compatible = "qcom,qcs404-bimc";
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
-				<&rpmcc RPM_SMD_BIMC_A_CLK>;
 		};
 
 		tsens: thermal-sensor@4a9000 {
@@ -601,18 +598,12 @@ pcnoc: interconnect@500000 {
 			reg = <0x00500000 0x15080>;
 			compatible = "qcom,qcs404-pcnoc";
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
-				<&rpmcc RPM_SMD_PNOC_A_CLK>;
 		};
 
 		snoc: interconnect@580000 {
 			reg = <0x00580000 0x23080>;
 			compatible = "qcom,qcs404-snoc";
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
-				<&rpmcc RPM_SMD_SNOC_A_CLK>;
 		};
 
 		remoteproc_cdsp: remoteproc@b00000 {

-- 
2.42.0

