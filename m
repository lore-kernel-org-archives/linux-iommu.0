Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51613C2F
	for <iommu@lists.linux.dev>; Mon,  9 Jan 2023 17:45:44 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso9708530wms.5
        for <iommu@lists.linux.dev>; Mon, 09 Jan 2023 09:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwVG2zKJ/ATnKV1RRIAAcFC3q+IIg4nUTLy7Tj+MQpo=;
        b=jRcoui9r2/TGb5E06Pt08Dc+Uc1+mBd6LO0MBj+k26OeFa3jjK0cIDHD8/8XsoPAqI
         3LP+MQD2XnrLYwYhvGUc8UynxOBJ+dHP/ud8CJzu4gORQbmMFWFF6QYKwC7A+YNmHN75
         Nfo+oaYvI9qCW1HtIi6tTF+cKfl9cPksZLNLFu5JIvjQtfUZiLsPFTk0ZTFwn2pTXVJq
         MYNGJslfzjz73lu0a2hRti5ckCpuYlA47/QI/w5l6c1A2ERT0lJt1gtHv5LJbUdCcDGk
         w/l2gRaAINL0s1Ml9gkebFIXoQOqm94NEl41Rk0FGJd2fs+bWpbkCXtsiDMINvG9+WGL
         7Bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwVG2zKJ/ATnKV1RRIAAcFC3q+IIg4nUTLy7Tj+MQpo=;
        b=RfBjIAFiu0qbtY1lDAw607XBFtuKZiXVpijdbAnxvvYXOGaIE1tQGr9GHOqInr+lbA
         ccJ5QRBwM1HO9LpzlMt7w0j5Qr/Ne7kMKnssClJNLYtINY1deHT4ofAIIkH2abTFWyGj
         GWyAgGJRa9xIa9ESx+jut4kBD8rHIBqypQV9vmJZOQqJYelObJ/jhcOB9cNcSQdy/3C6
         ZsDZpn1bEDE/7X4XcwTlHwaTm9U/WkD+9Fc+1H8rR8Hd5GfuRJJPQyy5XvPGauSnHohM
         COhIsaqug1Z3/JbLLK74v+e/FlC6oRbw319Tk13OaGxMMkPhniNCYDRpLnLHJGL23DJe
         DBwA==
X-Gm-Message-State: AFqh2kpNUeBtfxb6L0xAOvQM+OdW3IaOPJIgH4I3UvMQebb32ry0ewMv
	tSp7hyFoZrSfO+yP2K1DIBl00A==
X-Google-Smtp-Source: AMrXdXsd7xg1OeqEz9aF8XERiC/uKepz+bzckxBY0KixGFQPabm7W0wOVPMTz5D1vkIcHHcNUj0TnA==
X-Received: by 2002:a05:600c:4e90:b0:3cf:894f:964b with SMTP id f16-20020a05600c4e9000b003cf894f964bmr48650187wmq.16.1673286343174;
        Mon, 09 Jan 2023 09:45:43 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:c88:901e:c74c:8e80])
        by smtp.gmail.com with ESMTPSA id m1-20020a5d6241000000b002bbdaf21744sm6142902wrv.113.2023.01.09.09.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:45:42 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 08/18] arm64: defconfig: enable the interconnect driver for Qualcomm SA8775P
Date: Mon,  9 Jan 2023 18:45:01 +0100
Message-Id: <20230109174511.1740856-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230109174511.1740856-1-brgl@bgdev.pl>
References: <20230109174511.1740856-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Enable the Qualcomm SA8775P interconnect driver for arm64 builds. It's
required to be built-in for QUPv3 to work early which in turn is needed
for the console.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 1cb586125c46..d5c938adbd2d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1332,6 +1332,7 @@ CONFIG_INTERCONNECT_QCOM_MSM8916=m
 CONFIG_INTERCONNECT_QCOM_MSM8996=m
 CONFIG_INTERCONNECT_QCOM_OSM_L3=m
 CONFIG_INTERCONNECT_QCOM_QCS404=m
+CONFIG_INTERCONNECT_QCOM_SA8775P=y
 CONFIG_INTERCONNECT_QCOM_SC7180=y
 CONFIG_INTERCONNECT_QCOM_SC7280=y
 CONFIG_INTERCONNECT_QCOM_SC8180X=y
-- 
2.37.2

