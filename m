Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98F25CB1
	for <iommu@lists.linux.dev>; Mon,  9 Jan 2023 17:45:53 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id w1so9010188wrt.8
        for <iommu@lists.linux.dev>; Mon, 09 Jan 2023 09:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuEV1y0ZHggJ2U74QXGSnhB+olrzqX7rJCa8R9xof/k=;
        b=1oK9bfmMzCrM5VhwOjGwAndfQGIzCwC3VXYACWKNETbxM5a7GL2wBMvu1a6Kg22aug
         SC5bKzhvhA8P+flr8W8deAx3rXBXEs6KS/ep2bLEoAepDeqs7Oyg+CFl1wXdT3KOxbKF
         8EUQpup92gBHy7k3g725NzS4w8LvmUZCCeFxOTGwYPqbNLxbtTFDo6TsCRfkFq+c0slf
         32XlDqP4ErJfQYUN8wHcsJnvYM3LEJ/NgzPjkm3Fb87t4kBx/p5zAaS7dihyuXnzI87N
         Qs+VpOGbRkObFPNYykq3a2chF3RwhO71q9J4WoIbH/0r/BvyaYTnVgGPO2HV/sWVp4HC
         86Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuEV1y0ZHggJ2U74QXGSnhB+olrzqX7rJCa8R9xof/k=;
        b=Ra80Lozj/Mg88Gj3gkaCmcKUqvMkMQ9RAGZTWS8XF59Dl2Lot65yn5bfbYX234UOcZ
         Pb2cv3c0ATE+LaPbiczIM8tKPWHupESB5OOvd4Q+hspkyphgkSbSeR+w+8OekgwpCZr9
         qpHxOhZLoWLVBJHcoQvOJlpBu07VUS1FWuKcYJIs5WwrDIl/mlfhbojUMkX4N4ZKZpi3
         XtBn2KmmGgqnJcMQaTe+6NwWEsVmhAh7afpSjOC+Vabtdenjw4zan5Z7aK9NC+9hq/OS
         KjifBUAg1jh5D3QvRb9mQzr+IkKY2mQR1MgfuzCb/Hd7Rx5z7BqKm6RMIZbuH2g0Ga6a
         MVXA==
X-Gm-Message-State: AFqh2kqXztbJde8HzTJdGMOuwVtWcMxoRlZdUdgSs5w5XvqDzvLuLAIF
	ynfXOtj/lJhiSPI1U7gNGw9zFQ==
X-Google-Smtp-Source: AMrXdXtkbZtNiskZEH7F3cw97ksGs6B9HyI1mJEQEKT2aOFe7MwmAwO0MBsrBK9a7hOzqXaVBJeO4g==
X-Received: by 2002:a5d:5910:0:b0:27c:7c2a:f700 with SMTP id v16-20020a5d5910000000b0027c7c2af700mr28717178wrd.8.1673286352284;
        Mon, 09 Jan 2023 09:45:52 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:c88:901e:c74c:8e80])
        by smtp.gmail.com with ESMTPSA id m1-20020a5d6241000000b002bbdaf21744sm6142902wrv.113.2023.01.09.09.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:45:51 -0800 (PST)
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
Subject: [PATCH 15/18] dt-bindings: arm-smmu: document the smmu on Qualcomm SA8775P
Date: Mon,  9 Jan 2023 18:45:08 +0100
Message-Id: <20230109174511.1740856-16-brgl@bgdev.pl>
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

Document the qcom,smmu-500 SMMU on SA8775P platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index b28c5c2b0ff2..95c5808456ea 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -36,6 +36,7 @@ properties:
           - enum:
               - qcom,qcm2290-smmu-500
               - qcom,qdu1000-smmu-500
+              - qcom,sa8775p-smmu-500
               - qcom,sc7180-smmu-500
               - qcom,sc7280-smmu-500
               - qcom,sc8180x-smmu-500
-- 
2.37.2

