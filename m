Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC23BA20
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 19:36:49 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id o24-20020a05600c511800b003ef59905f26so8209302wms.2
        for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 12:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680032207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPfw21v8gtigUsolrO+BT5/gzWDhSW7RBoQgHH2kESM=;
        b=kF/rxL6HVsDj9bfhViunjiZMJgAqenp9lJbX12wrq8Yc/fgJ8g49GZ0kyXOiZDhPAW
         RtiT3XhxPkHG6rKkRXIwSJ3OY4i8zohFaDdlohQd4v3swYbIXpN3Dvwi3NNDnpp8P2aQ
         LSdx8+DaFgSdbPPR7BaFVnf33vELH1KN+IzrN5/H2t/WVyWzu+rG70GR845QfAjZPvpd
         WrsoHv9vgSPYIjuNbGGW/ZoQ8k1J3/8/uAqsbsxJlpDB9/1qinc+McchbRalyADDZ4S6
         BQufyZmAInEnsTn+e4DVKB7OYQ8OlDd93qMvtDa4T5atUlBNK3Imc0zj8Cd9L+mOuGuz
         cgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680032207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPfw21v8gtigUsolrO+BT5/gzWDhSW7RBoQgHH2kESM=;
        b=UMVkmFLNjPQ+nG7ObhJVicI2XxkUQYxWM3Rx2lvZhhLNX+mFE8emPioEkWu7qnMxyG
         zXFJFjEfP9M6LrWXJehhR85cmU4E5MaZ7Puvxe0dMsWo7vBDn/Aq1Exn8TP4E6j4KOSH
         eVt3iGB7HbCEZBL+YPB2pXi99xSyJDukNZzIfoTVamk6i+B9V6GuqQQrR0qHMKlYzHaf
         nrdnzPESVTvGaup+mne7bBXJHwGhrLZ8VFUxX5qisasc5lYK5jCn8Xibz0qxlRFMjfWk
         0RzbLT9WywYdyd0GsFXtVr3GReJSE6XiiIYwZVV2UNtkuqMBtW6wsxC7kpRiEpWFBrKo
         3Hng==
X-Gm-Message-State: AO0yUKX0ISBrbevPChsNnkhOZlIYSDuexYLb5I0yHalTgNNl+ZIKHn3m
	uTxTsMsJ7VRYN+360mfVj8A5Sw==
X-Google-Smtp-Source: AK7set85YATpUqwBvEqs8LLDDBhARuvoL81CvF03dXRaHzkTq7Iz9KPPOE7V+3XqtJXXaSOETffEmA==
X-Received: by 2002:a7b:c392:0:b0:3ed:5d41:f998 with SMTP id s18-20020a7bc392000000b003ed5d41f998mr13708339wmj.15.1680032207394;
        Tue, 28 Mar 2023 12:36:47 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7b39:552d:b2f1:d7e8])
        by smtp.gmail.com with ESMTPSA id g23-20020a7bc4d7000000b003eb5ce1b734sm18060544wmk.7.2023.03.28.12.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 12:36:46 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 6/7] arm64: dts: qcom: sa8775p: add the GPU clock controller node
Date: Tue, 28 Mar 2023 21:36:31 +0200
Message-Id: <20230328193632.226095-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230328193632.226095-1-brgl@bgdev.pl>
References: <20230328193632.226095-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the GPUCC node for sa8775p platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 9ab630c7d81b..4c45ad1cc7ff 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -591,6 +591,18 @@ tcsr_mutex: hwlock@1f40000 {
 			#hwlock-cells = <1>;
 		};
 
+		gpucc: clock-controller@3d90000 {
+			compatible = "qcom,sa8775p-gpucc";
+			reg = <0x0 0x03d90000 0x0 0xa000>;
+			clocks = <&gcc GCC_GPU_CFG_AHB_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
+				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sa8775p-pdc", "qcom,pdc";
 			reg = <0x0 0x0b220000 0x0 0x30000>,
-- 
2.37.2

