Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F114C7E
	for <iommu@lists.linux.dev>; Mon, 15 Aug 2022 10:12:43 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id u3so10000705lfk.8
        for <iommu@lists.linux.dev>; Mon, 15 Aug 2022 03:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=0aiK8oEVUknjQ/kFKM1Zoa7em7h8jPtDacZ1gsZezrs=;
        b=HWo1DgSkxhAANSjcWUOA0TiwznpZBpDvJCSJ7MjjR4jNaQQsaI1nJqZH6RPmtTNcUS
         PHEnklUIGr/0mptrSiTImNt4rMpRbXxv6WZ+fiwxpHBCP5HR7IDjLWBXGElqJMLxzcvY
         MoohSf5bqWRdzJptVhym4klsBeZXbkpvt1phXR9vzKHbn+lqKBBW/PaUO3dif4L49XFk
         3sueV0Hask46IHCv4HxlQzuDfVmJq06iq9osAUxyK+2pv6A4sl6x7Gyj/i/c995Ut7/Y
         T+3pMkdKK2sAlGhKGk/A1+cPv3/scbJJbFD2I1fM51MjdZkw5tq4brVKzDL5lp7lEq78
         Q+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=0aiK8oEVUknjQ/kFKM1Zoa7em7h8jPtDacZ1gsZezrs=;
        b=5h+yMwyYl5Q2NF/HDExKlE5qUNKWqqhHmT94zexpRYhiSOQ/l8zkRsN4RLEV7qg2DE
         uF0FaMlovkmIPA6AOiO+1WyVbpTUrKBcmANIuJgnTXbxNNnLfyXNYBF1kM5WkxP5vYT2
         ioomy/pc7qgblYdummC6CitXwgxYoCGwTUaUFRR3NXwo/0hFVuQld86iFaZDmkitoI9X
         74ATX3O7P3SuFPVhiBTwWq00s4udX7vp/WR9Iy/SfmO2hVT4cpuoSc1MOwkgG6pNn8vZ
         qCEGPJEXHTEQBs7/lPsv9hbR0HUwRjr+pFk6gdV4i0RTGiyhTB1XIKK1REa00PK/9/r/
         8yTw==
X-Gm-Message-State: ACgBeo1gj7raJo5Et2RQlUwfXUiDnUnRe7c0o681kaVO/71igJ3Ft0rF
	4eR9YTXKLD8AiV9s9q/JZ98=
X-Google-Smtp-Source: AA6agR7KF39lbkfwH+fJnTC4y2+jJqk2OXiZ7h/3q79X/zqHE9z1CvaR4+vorBEsi8CYQNY1FxLa1Q==
X-Received: by 2002:a05:6512:398c:b0:48b:a1e6:c631 with SMTP id j12-20020a056512398c00b0048ba1e6c631mr5171565lfu.229.1660558363510;
        Mon, 15 Aug 2022 03:12:43 -0700 (PDT)
Received: from localhost.localdomain (admv234.neoplus.adsl.tpnet.pl. [79.185.51.234])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b0048b1ba4d2a4sm1047264lfz.265.2022.08.15.03.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 03:12:43 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Emma Anholt <emma@anholt.net>,
	Rob Clark <robdclark@chromium.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 5/7] dt-bindings: arm-smmu: Add compatible for Qualcomm SM6115
Date: Mon, 15 Aug 2022 12:09:43 +0200
Message-Id: <20220815100952.23795-6-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220815100952.23795-1-a39.skl@gmail.com>
References: <20220815100952.23795-1-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible for the Qualcomm SM6115 platform to the ARM SMMU
DeviceTree binding.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 9066e6df1ba1..71f8f638a1f8 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -41,6 +41,7 @@ properties:
               - qcom,sdm845-smmu-500
               - qcom,sdx55-smmu-500
               - qcom,sdx65-smmu-500
+              - qcom,sm6115-smmu-500
               - qcom,sm6350-smmu-500
               - qcom,sm6375-smmu-500
               - qcom,sm8150-smmu-500
-- 
2.25.1

