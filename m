Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13B77E
	for <iommu@lists.linux.dev>; Mon, 15 Aug 2022 10:12:30 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id o2so10038652lfb.1
        for <iommu@lists.linux.dev>; Mon, 15 Aug 2022 03:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=37hkLcdgNgubX4Qyk91CfdXf5mvcvwFudIhsOtr9EEw=;
        b=NYGLyQQqUqYkwf3Q3pX8yKdsheZJ3SvVkcE9UOn7QPgncXgUbQodtaSxUYtp027LAC
         ToSQcTy891ShBwIOFSDY+8UROK0Lt/NkgmVaD29EL9+uc1uVYGlgSOK2EiaWqYTClS+E
         whG5eU+xAkrtgSo/HHDcvA+J2Qea++Ex9Uy7PVLSMp47A6KhLKbmCuHaIOuh8xh8KbG1
         wSgsaf4YV1bkDgpg9oQlFreGWmyGHLHps0n8pFiWK1Vk5/eekQeTDdIwivOl2Qf1YZGR
         C9rb5KaviuBxn35NrtTQhqehcQ53EranXBUdupLctPpqoFV5VlyukQ2bnU7AgRb9HEnh
         cuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=37hkLcdgNgubX4Qyk91CfdXf5mvcvwFudIhsOtr9EEw=;
        b=Y9RkBCS2KWxR1JcWAoym19HSp4SXHttAsQyq6mo5Uro5AcYah+xNefJXIgwaeWTzDb
         VIeZ2VortWcbhj9LJs9KFF6uCmbNbmwHIM6uap/sk8NHlBPM41iElwiUjAh81FrrhWa/
         hIG5PKLu0dhWCaPcpCc3CmTsiaZufDDjnG60qCj1qzvpUgaCXs2let0wVOgyPTTQwGLZ
         92XpUV/DlJ2qb8QixaC3ItVsxC+k9L4Y54rAmEHkpYv3FyKAaw0hkIkTkU+ZlpUk77v8
         jg42qC6dIXkPrRnZLMu/rNpKK3ey0n10TZ9mUNostVE8s0csfsf7y1vO7ynguVb5Vw43
         VldA==
X-Gm-Message-State: ACgBeo27wX1Ta6JVKHUQKkVrkIcbe2VywdAJ7ZmrURAJFPe40LMXCgNP
	j2Oi8lowcyBxLgD4ualNKYE=
X-Google-Smtp-Source: AA6agR67Y7mKftzVsB+SIg6QPvZgzAK+AadkJqp6OVGpsZPfsnMVVn3NBr7IVazQjALdim1s3/TCZg==
X-Received: by 2002:a19:c21a:0:b0:48b:2a91:e70 with SMTP id l26-20020a19c21a000000b0048b2a910e70mr5101349lfc.585.1660558348637;
        Mon, 15 Aug 2022 03:12:28 -0700 (PDT)
Received: from localhost.localdomain (admv234.neoplus.adsl.tpnet.pl. [79.185.51.234])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b0048b1ba4d2a4sm1047264lfz.265.2022.08.15.03.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 03:12:28 -0700 (PDT)
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
	Stephen Boyd <swboyd@chromium.org>,
	Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 1/7] dt-bindings: dmaengine: qcom: gpi: add compatible for SM6115
Date: Mon, 15 Aug 2022 12:09:39 +0200
Message-Id: <20220815100952.23795-2-a39.skl@gmail.com>
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

Document the compatible for GPI DMA controller on SM6115 SoC.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 7d2fc4eb5530..fcfe8a373a16 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -21,6 +21,7 @@ properties:
     enum:
       - qcom,sc7280-gpi-dma
       - qcom,sdm845-gpi-dma
+      - qcom,sm6115-gpi-dma
       - qcom,sm8150-gpi-dma
       - qcom,sm8250-gpi-dma
       - qcom,sm8350-gpi-dma
-- 
2.25.1

