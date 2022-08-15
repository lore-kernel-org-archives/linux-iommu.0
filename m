Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAD57E
	for <iommu@lists.linux.dev>; Mon, 15 Aug 2022 10:12:34 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id d14so9989996lfl.13
        for <iommu@lists.linux.dev>; Mon, 15 Aug 2022 03:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=XFDcvvTwcmcM0SO0UVivfLd048EZbiPv12fEaB32GFw=;
        b=o+OXd0Wy23lss/jW6hPBvLsnqzCFBUKtzdGSITp2WzaIPHwI0NGfJgR/kI1/E53hbI
         34CjzmO0kyqXPFYarSNmRoqudHUIsRIctGZmGyLMTfCy7LHHX81NTRfiwfWOTMFjPoZs
         gYjNbnAAyYHCqZw3Mv+lMgYjRgWCeLHEojwrRhv0gNOWWb7ByxDoN9ivg0U0kUXZyfAp
         y1NbMbtwd0PybE0zHxx1uguT92fqTIRcf2uIRmttvp4JIJfLmW1QABXX4jc5WbMVv4cX
         o2qHkxBWF1Jkr7xpwOScU9ecMPo9bXScRqRuUTEERcY+QDX45AAJ1bmKiU3iZDRkLjiF
         2Ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=XFDcvvTwcmcM0SO0UVivfLd048EZbiPv12fEaB32GFw=;
        b=Rb+AXgrnecaIUglBbPFPC4uiS+ZTZBc0Y3XIik3LFgrshHIcrxwjuZA4JYQzzZ5T4r
         u00DErjmNNqZykxKq5DiTWDwLCoiNi8Pbn7uxKJ2joFPb4cXez+JLxXTZCL/xlJ6iGzf
         eEeSB0JzJHma7GFrLLGOVjskKBe1zUoTpeP4ale7MQsjsYwf+wK4DNEMKf0jWPCKCMgr
         vDJk8gkv2vfJ1g1TCs6WO5gmMlM+oTyL9V5ipyb41rearQot0qyeEo3/SRlSU7mElO2v
         q24wgydukQ6tpPbcF6JH8PJLJSzBisaSCENHNflZnK/Ad8nym7YqLrKRC0GWtVuup0X7
         KIQw==
X-Gm-Message-State: ACgBeo0Oz08DjICGqXspgT6vQpRMVVqc/48s/Ol2XBDV8cx4k6fN2Ga3
	rN/I8IG+G84ADsQ4dpi8exI=
X-Google-Smtp-Source: AA6agR5xdRZD5HfsRYV+hNt3a82Ms4B8JDZGHDd7e4DeGWYbF5JNn7TG5ajAnBGBqGuv6mEhTpy9Mw==
X-Received: by 2002:a05:6512:3d18:b0:48d:244d:2120 with SMTP id d24-20020a0565123d1800b0048d244d2120mr5149783lfv.387.1660558352372;
        Mon, 15 Aug 2022 03:12:32 -0700 (PDT)
Received: from localhost.localdomain (admv234.neoplus.adsl.tpnet.pl. [79.185.51.234])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b0048b1ba4d2a4sm1047264lfz.265.2022.08.15.03.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 03:12:32 -0700 (PDT)
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
Subject: [PATCH 2/7] dmaengine: qcom: gpi: Add SM6115 support
Date: Mon, 15 Aug 2022 12:09:40 +0200
Message-Id: <20220815100952.23795-3-a39.skl@gmail.com>
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

Add GPI compatible for SM6115 ee-offset is set to 0x10000 on downstream.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/dma/qcom/gpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 8f0c9c4e2efd..b7fc6e0168f3 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -2288,6 +2288,7 @@ static int gpi_probe(struct platform_device *pdev)
 static const struct of_device_id gpi_of_match[] = {
 	{ .compatible = "qcom,sc7280-gpi-dma", .data = (void *)0x10000 },
 	{ .compatible = "qcom,sdm845-gpi-dma", .data = (void *)0x0 },
+	{ .compatible = "qcom,sm6115-gpi-dma", .data = (void *)0x10000 },
 	{ .compatible = "qcom,sm8150-gpi-dma", .data = (void *)0x0 },
 	{ .compatible = "qcom,sm8250-gpi-dma", .data = (void *)0x0 },
 	{ .compatible = "qcom,sm8350-gpi-dma", .data = (void *)0x10000 },
-- 
2.25.1

