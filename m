Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE19377
	for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 13:32:20 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-52a250aa012so7352900a12.3
        for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 06:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694525539; x=1695130339; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QbXnoaG8UM/xnuGoKiBDSZrOmSb2jf1llCbQVLffVMo=;
        b=JAzcn7As8+GA9bCT951fEV4qXkBflDHsyFLYLMXVLrde3o/xTcgYdenAYGpzBTqqyA
         qDcpuiDSHwiWLpT3Lz7YjM22LGvlN7DcRGZ0gzvVtMOrtgcdw/LeDTZCTC03wzdrBKGp
         18uZpMU4CBLU6rZOxxD80gLWvPQfklpOcB/S27zey8c5HCxNQSZ7Ixct0cWiD5Nnn3Xl
         Z7a5KXLshcRQJAWlTvjaWqXuX7IWZ+Ys1K1FSEWQkY9PT473FoGRsaiqV2nfSqtaYcOM
         GyHXuGlr76zhCybBvjEP0Q20cqAg62/dgHr85WUansqPFVQVhTjwTXRxqRNNMqUbM+LR
         eh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694525539; x=1695130339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbXnoaG8UM/xnuGoKiBDSZrOmSb2jf1llCbQVLffVMo=;
        b=RT4kzMd5TMGwonTfZNWuoWNFMAEu0IXuw9de4CE8JoZEcgiQfdpeovoYExAv3GA+Zu
         5cKkjsCS47M8N5fFP+MYLDD6LH2NjyblALvHwniS1ewppVhLQM/4nofYBgoXzePXGu2s
         ZPxSGQHvWKHDEr2006XSxw06O4PwDsJxsu8FB0mRVCzOfEeJbKcAZP5oVGw5Yacw8WDl
         fYw1okZqxZyKjLM/wjf7840DZSAgo5qQV2NBTSsIV4p5ml1+6YRv0y3IzKvNEyo3w25d
         QJxhm0A0T+iFtVUMkMJ5Yxq7oYaBSvafgc+WQRxy3Mrq1GUSM8vK9LoVjvfHn4dsnq4r
         u9bQ==
X-Gm-Message-State: AOJu0YxzRmSa71BiQzlbEdeiCyhOmL9gMkl3H+ys631ptBS5rZnARwMv
	mZnhkxIDlSWA8IryxrdydZ4sHw==
X-Google-Smtp-Source: AGHT+IHjyWCzW0ayXb0LJwcsgfnod96ca3muMqyfMqr31yt9brYBDxzKS84KHnsnwu97DkDO8oho6A==
X-Received: by 2002:a05:6402:c07:b0:52f:bb0b:57bd with SMTP id co7-20020a0564020c0700b0052fbb0b57bdmr281117edb.17.1694525538846;
        Tue, 12 Sep 2023 06:32:18 -0700 (PDT)
Received: from [10.167.154.1] (178235177248.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.248])
        by smtp.gmail.com with ESMTPSA id j2-20020aa7ca42000000b0052a401d8ef6sm5983830edt.71.2023.09.12.06.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:32:18 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 12 Sep 2023 15:31:52 +0200
Subject: [PATCH v2 14/14] arm64: dts: qcom: sdm630: Fix USB2 clock-names
 order
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-rpm_clk_cleanup-v2-14-1e506593b1bd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694525501; l=1150;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=xV/ZqPgMqaXSG0vXi80ddqfx5e4u+5Uywuqjc5SC6yQ=;
 b=JcTmOePKvRMjpiooocOU71gidr0+FDs8aF2A2fYneNgn3SUS4LV/RsG3oSoeLzyRJR5ZUAxgN
 oS5s69VDs47Dt+cXpXsmvMD6uFQgNYxxFQObqf8CfQ8l2zMKddqof+k
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The last 2 clock-names entries for the USB2 controller were swapped,
resulting in schema warnings:

['cfg_noc', 'core', 'mock_utmi', 'sleep'] is too short
        'iface' was expected
        'sleep' was expected
        'mock_utmi' was expected

Fix it and take the liberty to make the clock-names entries more
readable.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index f11d2a07508c..316c8fd224e0 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1394,8 +1394,10 @@ usb2: usb@c2f8800 {
 				 <&gcc GCC_USB20_MASTER_CLK>,
 				 <&gcc GCC_USB20_MOCK_UTMI_CLK>,
 				 <&gcc GCC_USB20_SLEEP_CLK>;
-			clock-names = "cfg_noc", "core",
-				      "mock_utmi", "sleep";
+			clock-names = "cfg_noc",
+				      "core",
+				      "sleep",
+				      "mock_utmi";
 
 			assigned-clocks = <&gcc GCC_USB20_MOCK_UTMI_CLK>,
 					  <&gcc GCC_USB20_MASTER_CLK>;

-- 
2.42.0

