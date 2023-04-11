Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE93315A5
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 12:59:21 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id he11-20020a05600c540b00b003ef6d684102so2311858wmb.3
        for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 05:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1681217960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RxXk1daPTunKtbomjZDgpJNAfBR2cR6YhtK/lfK/SI=;
        b=jkNhgbAqj8TzggObBJHle31q6oTTOf6YNouhVEYNpiAFkPPJUDhi13yN2zkBMTkbCb
         Jd5LL4XnPSRxsSDR69wQwpMJgD4zo34dsiqtuEAPt4NiF2NT8t/t7DCs99RsrV+B6dS6
         5XiY/o/CZc+jl2jpa03WzBu9VUtl5mHZTBkr2+XDyGBBUdMDrxh8TWrj+MjV5qD6VCxA
         XbQaYuCghyZbRe+1pp9Zjjh2rkBoR2uj7oMsy3rtP21ly1JHx3AbPkhmLGsIinwE6795
         Oozk32Misl05fmnPFUTsf3I1UAbdm/7vd8B8DNMN5DXqVFhGJ4vh6P5BmQZnX4a9AP3W
         h0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681217960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RxXk1daPTunKtbomjZDgpJNAfBR2cR6YhtK/lfK/SI=;
        b=BE/8MeAdnPVKtAksfk7Xx9F+D3ia8CWgTCpuguCV0el7ISShUYS34L0mA9NATi7E5k
         up210qQ81sjfg/LxdbnFRvpQ4XAfdBOA6tx8DwhZBpmCtSrgby9pmuvXK3qgaKC9hFFz
         ccDGjVHlZw0z1srKDaCZmRACfrwcuM2zkRjQCDPegyVTL+r6UW2HGFBDYHiKsaBmSmFd
         AXhApvfV8YKn9ZmJqptO1+VwK8hhyGLqCtMSQQi9oGrNaLQmWwbwH9iPnc9Sn67Na0DQ
         D1d7tGhYj2LSzH+XOF+fLhQ9ubPEkpl2t8y+Pc3zTZpFNTy3dUcO4FRBC7mVOZ8xFLzh
         qLLw==
X-Gm-Message-State: AAQBX9dNc5kYD4BjMuMxWvBC3sLobaagXT9z/W4uaCy3yIsP2mhJnjhi
	otOaLdTevGJ5e3wXlTNiRJrZnA==
X-Google-Smtp-Source: AKy350YjbZY7jeWKHHTUtlE+U08TBjTTL9TQeEw/gUMD0lhQNwkuZRGNiz34nBSlMwOKYeudFtovUA==
X-Received: by 2002:a05:600c:4e44:b0:3ed:de03:7f0a with SMTP id e4-20020a05600c4e4400b003edde037f0amr9427917wmq.10.1681217960343;
        Tue, 11 Apr 2023 05:59:20 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a099:fc1d:c99a:bfc3])
        by smtp.gmail.com with ESMTPSA id e24-20020a05600c219800b003eae73f0fc1sm16944591wme.18.2023.04.11.05.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 05:59:19 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 5/7] arm64: dts: qcom: sa8775p: add the GPU clock controller node
Date: Tue, 11 Apr 2023 14:59:08 +0200
Message-Id: <20230411125910.401075-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230411125910.401075-1-brgl@bgdev.pl>
References: <20230411125910.401075-1-brgl@bgdev.pl>
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
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index a23175352a20..191b510b5a1a 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -591,6 +591,20 @@ tcsr_mutex: hwlock@1f40000 {
 			#hwlock-cells = <1>;
 		};
 
+		gpucc: clock-controller@3d90000 {
+			compatible = "qcom,sa8775p-gpucc";
+			reg = <0x0 0x03d90000 0x0 0xa000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
+				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+			clock-names = "bi_tcxo",
+				      "gcc_gpu_gpll0_clk_src",
+				      "gcc_gpu_gpll0_div_clk_src";
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

