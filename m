Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6297B
	for <iommu@lists.linux.dev>; Tue, 18 Oct 2022 01:11:07 +0000 (UTC)
Received: by mail-io1-f49.google.com with SMTP id 137so10595917iou.9
        for <iommu@lists.linux.dev>; Mon, 17 Oct 2022 18:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWeBaf4vtBh0cPJaX5k0nGek3oH+mu0hsNkHok4Em60=;
        b=mkcuKsYn0rXGemNDvGkuFupOKalmcJ0P60eAkS/9oYH0wzoZs1Xs+679Fpq30y2+Jb
         dM4Pn8HMhjimex8la124juRsLZbDiUS5uD/AJj0fiHrvJ/cWUxAjhFy6BCfq/O0GQ/zJ
         IxlBjWVLhhAJ7miKYxqn0AJaqVkliwkcvWS75pWo4KTfJs6H3DEbPSMOsUCKatoTmDZT
         v04DQEvnafTWuI1icRCkLtdN0p4GzxDMAEGLy+1/TCFNjCSv6VbppeLUvLqybPxcNq7U
         vGECd+puBbGsIfdF9BZgz99PhmN+exrFrkqJ6fbjxWxG0KzlUZkibVadRPJTy7Fu41hN
         920A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWeBaf4vtBh0cPJaX5k0nGek3oH+mu0hsNkHok4Em60=;
        b=JsivaboRP2zEq3DoxOMqqXD5VxJkHKe4PI0+NhwxEIiwixw17apiqlx1SKAZ/F29qq
         8p1bDlFeExE0ws68dxN76/B387rFgQFb8XbEcYJW66X3MhTOtWbXAIiODJ38LJNwGZCI
         vkSXIjW1xlahKem9PEe92cRb3qkQ4dUPG8H8DL1YXK+bIfGV7iMdujBJRdsDEDWVq9Ms
         3tXXioTRYLko/gR49MeugZL7UJ/VHgjyFYBt91EEMFo7v+CFReo9sBUwqc1shJlqlPFK
         uneFVjuYvvPUVytBW3eUYYUUp8mynNt8njl+Z4UtCh/5f07sl6I+tSVzUQX6OXRTjkjt
         MJ3Q==
X-Gm-Message-State: ACrzQf0FqJ5ZXtetzK4CCbvMexYpebEZVjA26P9LRetP1RvcnPeOXocx
	S7ud8GrjaXK5XPr0fy7VOHk+oIQNzzHefA==
X-Google-Smtp-Source: AMsMyM5qtwsG4KsLgj7Pwc3v7Oq9oNHVveYH0vvYBdKuRfvk4/E/re3oXPgNRb43FCznKWskQZcBRQ==
X-Received: by 2002:a05:6638:3f0d:b0:363:ba76:7397 with SMTP id ck13-20020a0566383f0d00b00363ba767397mr527983jab.177.1666055466693;
        Mon, 17 Oct 2022 18:11:06 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::4a89])
        by smtp.gmail.com with UTF8SMTPSA id m47-20020a026d2f000000b003639ef62d08sm530797jac.84.2022.10.17.18.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 18:11:06 -0700 (PDT)
From: Richard Acayan <mailingradian@gmail.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Richard Acayan <mailingradian@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH v2 1/2] dt-bindings: iommu: arm-smmu: add sdm670 compatible
Date: Mon, 17 Oct 2022 21:10:47 -0400
Message-Id: <20221018011048.25371-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018011048.25371-1-mailingradian@gmail.com>
References: <20221018011048.25371-1-mailingradian@gmail.com>
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

