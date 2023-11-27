Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC61364B9
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PPR+XOsR"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso6327275e87.1
        for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 08:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701102019; x=1701706819; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWgyzigPoAR+4Ex1d/u4hf1QcdRIIjXWN2uqL4LI7/Q=;
        b=PPR+XOsRPlC2UQAY7ZfKb4NAHlDMN8HHPdubF/eqTi74O0sTk8KZU83H86yML/wiEI
         WhWf/gKlI0gjGU8tqKy8XaI+C0sJCPIZTCnQbMuEdl5df5khJcaVtzQV0IX8XcK63evo
         af3GN0iwwI2qCZft63ABDZJCsxJc3hzPBNlSZUVoEvrdmRXi14ipci3l8ctA1EzX67Ti
         TNqavbvYuy+fxT/j5l+bcHzXz4+GiRRr8EFK+8zhZEPM39nwjZloKOKQ1Y/uAXPYP0LC
         8q8d4oiDV8+G/NEbhaM3bXF7YwsH7FIP9qLbYlJYg0sABXvi2ZPJZ9sxQabQa0gnaZwf
         sQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701102019; x=1701706819;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWgyzigPoAR+4Ex1d/u4hf1QcdRIIjXWN2uqL4LI7/Q=;
        b=XjUTU7Tr0tOghMklaxvPaum+QfrG1PPCp2z42TfgFI3f9jSmc9czm6Ja3HmXsNfTDY
         BtPoSMZMskRo8sr9Q0qIVgURlStYfhhVTqDO8ZphmsUBCDjCv5bh/n5WqT4XSxtE35v6
         3NcHTImJ8xmeOsFBFj3eBPiu/TCxZv5RuE11J5SCLIVLTWNwKdw5VOANMQYDWjTf5JAN
         3RsHi5mTG7ycOqhu7ZykFTJsen5QjJlFbsvRu2cG53iSx1V3vvulduqLZi9SwwUknUmT
         tZp1Swzrm1kRZ+EaobpMM3Shqt0qEAq+sCzbkGu4MeXFVyOO6ozoAMh6oFf/ZJ44RXIn
         nh1Q==
X-Gm-Message-State: AOJu0YyaivoiBQ9xDJVhnHYwdpNeQeliEsSMFrTzDGlisX2G14hrbKkE
	UYStRqNGFjcAGy5yZFSJNFMBFA==
X-Google-Smtp-Source: AGHT+IGw6vE+zL9Gh3AlVvTWxBmVd6/TxfPV1VqdSfmuraUROfoqa4jJjxDQMuwiJbHnGCOXV3K0hw==
X-Received: by 2002:a05:6512:10c6:b0:50b:b504:996e with SMTP id k6-20020a05651210c600b0050bb504996emr1650818lfg.31.1701102018884;
        Mon, 27 Nov 2023 08:20:18 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id m12-20020a1709062acc00b009c3828fec06sm5734760eje.81.2023.11.27.08.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 08:20:18 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 27 Nov 2023 17:20:06 +0100
Subject: [PATCH 4/6] arm64: dts: qcom: sm8550-qrd: Enable the A740 GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-topic-a7xx_dt-v1-4-a228b8122ebf@linaro.org>
References: <20231127-topic-a7xx_dt-v1-0-a228b8122ebf@linaro.org>
In-Reply-To: <20231127-topic-a7xx_dt-v1-0-a228b8122ebf@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701102008; l=737;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=WLJjkmxb1cqo6pbyXNVnfs/XlxQsP2z9isMMjjm728Q=;
 b=wL/heSXr/KYsRGVKMJh1kN+9cq9XComDpTkZuwSoUDRT8ZsOM9auMBIyT/xns5wFL6PAzP39X
 1A+nIrskDvcDYWvIhBLe1YI+d5KvvBVn0Q2oWYv8VOh9s/r5sTCzt4o
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Enable the GPU and provide a path for the ZAP blob.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index eef811def39b..9fe51d308675 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -596,6 +596,14 @@ &gcc {
 		 <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
 };
 
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		firmware-name = "qcom/sm8550/a740_zap.mbn";
+	};
+};
+
 &lpass_tlmm {
 	spkr_1_sd_n_active: spkr-1-sd-n-active-state {
 		pins = "gpio17";

-- 
2.43.0

