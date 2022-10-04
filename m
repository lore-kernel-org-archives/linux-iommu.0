Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CCF4438
	for <iommu@lists.linux.dev>; Tue,  4 Oct 2022 22:46:27 +0000 (UTC)
Received: by mail-io1-f42.google.com with SMTP id h19so1032169iof.0
        for <iommu@lists.linux.dev>; Tue, 04 Oct 2022 15:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=yWeBaf4vtBh0cPJaX5k0nGek3oH+mu0hsNkHok4Em60=;
        b=YoAzhOO03Egp3FHUujgQzHEKSDWNLqpNscdSHNygvbUZ5ki+XmPvuw8P8ou3n5Z/Zl
         Lg2KMVtEvFl3lRBJD+mf6EaxSvuUPGR+ValK65R39/gSApJRB8Yv2Gj1sz65/svFdmU5
         rPudhPeLdTNMJcK+d8z/wy5nmrpGy9n6y/cOOV9Pg+XiJRt5v6deaMea2EMHBA7QNmls
         aRxXOZURLh6AXWfe/N6w411QkQgFWfQMYDoXhuvr7HOmmngPUVxb94rTwJemcQJw+uhX
         0sac+iHrBkfn9QYN5Q6N+tTa5IVTCb21Cfn6nF3URZvNlXOAl/wFKTrCh3SwRTc45dMG
         Ugwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=yWeBaf4vtBh0cPJaX5k0nGek3oH+mu0hsNkHok4Em60=;
        b=MDEvDwU1HQCQIpJgh2iSnyn7qUuDpXAswNs+cyAQxKvbKUimYzAad/uCrFfuhqwP7P
         QhiH7TiHGMoVS0cGL3pWEA9UbY9UMDvDxRTjZhnmCKQWqFs6U7A+jBAOYbb4bN1KIAqp
         l3yVIRiRHaXgWVVeIg03+w4IrZ2Xoc1BJMorj0/TnTMfKjkBmw2QWjTSXJvDyTjkqdlT
         VbZOwOeTN1i7pZ209u51Z6fDLZdL9ECBxvHTVLG5VpkRNP+jGAGV/YrVe/Vu87eJg5Ea
         FZcOjOGQnhrWT3oO93RcSD2Gt+NLhu0gq0e6yuNT1rxwWpBtu5BPObmgmrTkPD1C+M/k
         +JcQ==
X-Gm-Message-State: ACrzQf02NdlVBftmUFy8/8tsFx9Zh/tCn4jPfQFs+wo1nTGqCfaFxHzz
	WW68KM+Jmt97fAf9mEpbRPa99QK258Y3rg==
X-Google-Smtp-Source: AMsMyM4urdGES741Q8zKbHdKlQdf936iRlZhPZ8D9sTTiLsophwa7YUSDMy9KapgnWh181Cp52jkRg==
X-Received: by 2002:a05:6602:15ce:b0:6a5:22db:950b with SMTP id f14-20020a05660215ce00b006a522db950bmr12216256iow.183.1664923586566;
        Tue, 04 Oct 2022 15:46:26 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::1eda])
        by smtp.gmail.com with UTF8SMTPSA id v6-20020a922e06000000b002f5447b47f8sm5251047ile.33.2022.10.04.15.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 15:46:26 -0700 (PDT)
From: Richard Acayan <mailingradian@gmail.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Richard Acayan <mailingradian@gmail.com>,
	Emma Anholt <emma@anholt.net>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Rob Clark <robdclark@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iommu: arm-smmu: add sdm670 compatible
Date: Tue,  4 Oct 2022 18:46:18 -0400
Message-Id: <20221004224619.16406-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221004224619.16406-1-mailingradian@gmail.com>
References: <20221004224619.16406-1-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Snapdragon 670 needs the IOMMU for GENI I2C. Add a compatible string in
the documentation to represent its support.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 9066e6df1ba1..5ad6dc64e1c4 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -38,6 +38,7 @@ properties:
               - qcom,sc7280-smmu-500
               - qcom,sc8180x-smmu-500
               - qcom,sc8280xp-smmu-500
+              - qcom,sdm670-smmu-500
               - qcom,sdm845-smmu-500
               - qcom,sdx55-smmu-500
               - qcom,sdx65-smmu-500
-- 
2.38.0

