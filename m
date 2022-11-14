Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6938C2F24
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 10:42:36 +0000 (UTC)
Received: by mail-lj1-f169.google.com with SMTP id d20so12547917ljc.12
        for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 02:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDzwDb0dnKoTPgCy4RBfiMpDFetmXY9OEGk9SR/WSLY=;
        b=FhlApcqDxCtCoupJ/TIS0Ykf65afLK30ejNB8v2zhMO/08W/KJGjo+jBHJsNqt10pm
         1GEqKtYy830ohGlIM91yJZR6N3HiLjwX/ldBqlIKM5vXM3kFSN+2IIvvYOj+qJ87LRfI
         dzDH0BAB4MOhdYEyvZ3udJabwEej8WLG14Mgf1O8L/LxHKjVqaxAvZpwi12vdDcBIVpu
         SuIQrLXvLUodif/creo1nAh7wOM3vGtIU/3ALCYbvqgi8SSmbsONxt+v709lJdR5zYEw
         fxJFr0c9PqfemGYKmEEvkXXlRTEeFlBCxfFC6xv+x98BZlO64aBbZ6833hVafWVYTAYD
         0eZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDzwDb0dnKoTPgCy4RBfiMpDFetmXY9OEGk9SR/WSLY=;
        b=NfWmaL0J/yqLsGayMuoYj1ZjiZh9LzYRU71FM7IileW0e+8dOjaywOb82saTBKjIiF
         lqx2EXbMRiUjoWxtgp59YF85HazE42j4ym+0gBZXqtjwL1FqNTaICj1leqFcLTuOfP4s
         8FRmtvyXB0o4aq96yorTOKgFGOkJrDqkeIsTtOQa2ZvKX0OyxyBS2Xb5+Y1Nx1HIESwq
         /nWzXNqh7kopPhO4zeCr4CFPT7dAs5GOY7jGoDMJyXFLr7flgutweFh8hmAGiE70YVVI
         B4kEx50/3mj7uCwDn7uB6jbbn01QGGQyZnO1quRUqNMYTOR96ttrRSLohkr3pDEtd8Cy
         v+kw==
X-Gm-Message-State: ANoB5pl08jOwCwXh8Q0N2Yj6k79v7wydxvOTUnLMmsofDRP3SB6S/prV
	AEMO6Z6VusQC5+x0LE1pOJHBpw==
X-Google-Smtp-Source: AA0mqf4qlxiMY3JDejy6a3SVEFC3TJHChXsZGfocnkqWhpRLRNPJLTzvyucW4mkNtj7j0c1yswAz8g==
X-Received: by 2002:a2e:960d:0:b0:277:4f:bd2a with SMTP id v13-20020a2e960d000000b00277004fbd2amr3622765ljh.341.1668422554455;
        Mon, 14 Nov 2022 02:42:34 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id bs21-20020a05651c195500b0026c4e922fb2sm1946486ljb.48.2022.11.14.02.42.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Nov 2022 02:42:34 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	andersson@kernel.org,
	agross@kernel.org,
	krzysztof.kozlowski@linaro.org
Cc: patches@linaro.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] dt-bindings: arm-smmu: Allow up to 3 power-domains
Date: Mon, 14 Nov 2022 11:42:14 +0100
Message-Id: <20221114104222.36329-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221114104222.36329-1-konrad.dybcio@linaro.org>
References: <20221114104222.36329-1-konrad.dybcio@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some SMMUs require that a vote is held on as much as 3 separate PDs
(hello Qualcomm). Allow it in bindings.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes since v1:
- Add minItems

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 9066e6df1ba1..82bc696de662 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -159,7 +159,8 @@ properties:
           through the TCU's programming interface.
 
   power-domains:
-    maxItems: 1
+    minItems: 0
+    maxItems: 3
 
   nvidia,memory-controller:
     description: |
-- 
2.38.1

