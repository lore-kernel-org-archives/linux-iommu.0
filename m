Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504F08F72
	for <iommu@lists.linux.dev>; Wed,  9 Nov 2022 11:12:43 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id i21so26682218edj.10
        for <iommu@lists.linux.dev>; Wed, 09 Nov 2022 03:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdDDG+VwCgLPntFF4oa/ykOGwGyduN4fHiF8yU6o5TA=;
        b=w4s581JvQ2Mn8GOCY2YVAROxVhZovQ9F6aNxHdQUXuymakEOCP2ZNLp6bqPiYK7s6A
         4BW3fGjCZuZwV5NgN9p8Vg9pir2tqs3jr/ebZJPupmDhMxMXpJhTrMRCcVrYmypedaEE
         ee8A3Isajf/DU8pb9GPHuqc1u8s3bLijg/X/0inlV3eVtSSMl1mhQJZIdQQOknulHBFs
         6AgTOizdTJY77Iyilk3DbIagWrgza8v513pO8KYfT1CM6Z/spqAYZdDMZsXnlrP7RXt6
         qvl73H5cSVpXUFxRJFB/4qwcz/cBhYWfLKzvRdwr57mWPxV+Em9gbbnZUXecwwcYYkmG
         aLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdDDG+VwCgLPntFF4oa/ykOGwGyduN4fHiF8yU6o5TA=;
        b=0cOhfsDsFus1AXkdOuNvYh8v51KUcAYysKBIRzJ0PfQTQArfgy06q/MFwDrEu44Wdk
         df427s95EtC13zpHspFq6bjeaHPVqjZC/intViVSNTMFnNc3Q6jJWfJGc5PD3Jsiq/a0
         qtO/zBBVv+e3SPD2aZbHB9IXRVMFABdMX8RJCQFjErn6La18x3+ImYuSZVAV1vDYk7uR
         cSaiY9R2chvl8M9j0+3nRDNlj68ALx3TDVBqK2QNuFGF25tkNnluRg7PPwGgVez3OQrf
         51cE7ZpzwzFYiHVAq5ohsgErcJ5YabFERSC+D9bChqBgpQPyI+qfVQvRRaB/q/y1xaQq
         wJAQ==
X-Gm-Message-State: ACrzQf1hmkCTGSYeYfh9QDwZ/5ErTcopcKflBmS4a4uzAhdNO3Y6IgVJ
	b7uZKGd8QBYm0OU9t+MpoyXGCQ==
X-Google-Smtp-Source: AMsMyM6s7MoJlv0Fg8yZvsH1IMDvfa7NtIwgSGlQvWA4gVOn/ZBLMC2W12W0VttsA8gaNjq3FwuIZw==
X-Received: by 2002:aa7:ca50:0:b0:461:9845:d9d2 with SMTP id j16-20020aa7ca50000000b004619845d9d2mr59012120edt.163.1667992361655;
        Wed, 09 Nov 2022 03:12:41 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id k8-20020a1709062a4800b007ad9c826d75sm5825899eje.61.2022.11.09.03.12.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Nov 2022 03:12:41 -0800 (PST)
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
Subject: [PATCH 01/10] dt-bindings: arm-smmu: Allow up to 3 power-domains
Date: Wed,  9 Nov 2022 12:12:26 +0100
Message-Id: <20221109111236.46003-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221109111236.46003-1-konrad.dybcio@linaro.org>
References: <20221109111236.46003-1-konrad.dybcio@linaro.org>
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
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 9066e6df1ba1..1897d0d4d820 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -159,7 +159,7 @@ properties:
           through the TCU's programming interface.
 
   power-domains:
-    maxItems: 1
+    maxItems: 3
 
   nvidia,memory-controller:
     description: |
-- 
2.38.1

