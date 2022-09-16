Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC2D53A7
	for <iommu@lists.linux.dev>; Fri, 16 Sep 2022 13:35:09 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id z6so3574605wrq.1
        for <iommu@lists.linux.dev>; Fri, 16 Sep 2022 06:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Q+u3vJJCdtvHYMsR/8D/YKdbcNhhwJkcpVtrhevHRJU=;
        b=KtkJ0zlYTHdr8w9ecZHSBEttL6X54XVJatBquYt8bhD+cN5z1tKgQvOCCy0ot1qAhc
         OUzucDkFMxaOgUzCAwiDCfRvyDzRUq5n59d9hTqyvaOVVi+fiJBw2odpEiejgsiSrccA
         vXsLjnRUGeZu6HBAKeA7+B1w0mH+Mpm4xiP5LeRrM5SbgZiS5M8EomOIRF1FTHBxKTOW
         Kf2zcBc8IvmHOun+8eurgKCpeu4MzdYeSutDDAe5aTnCnS14aRtHi8Hc8KHDyK9m45+M
         DWiZrsbVZ83ioeRVZMGQziTg9yoXbDhhPun79u8kH0f5UpPxL2SbgAo0ITQMdMFLN549
         B2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Q+u3vJJCdtvHYMsR/8D/YKdbcNhhwJkcpVtrhevHRJU=;
        b=kJuYKPDNYtdbz7w6nCbMSlT2cIU+yfFBozlTrel2X1TrX3HouWQW+FDGQ4G+yipI31
         b1yZyS8dKOIuW6ncD2pqKAIgyIPyuLl56iQ1qkNQ7UJJksWgfZiTFrjs/4Dm53IZ02iI
         l4bOApv8mxkabs+MARDnHzePTjo0Y6uali5MilVHWx7JnGbtSfCnvV9bp8iryUAVD+3W
         I9FUXfsaMC2nrsRCj+82DHxSiLQcrA+tsG/5ll/xWSDwFzeePRhA8gCwDj5MCXU7zPON
         RenJxZTq2+bHjm052cOsWLTgPRp+LhqcqWzKF3UIZraR1RLo2TiGZG7ZXi330/cWxye4
         z8+g==
X-Gm-Message-State: ACrzQf1rsX2N8hAKakr1syznQvXSH4yOgX4MPXT4nCeaMu919IXHum/t
	JV9o0fH96NR1gW3Ir2KmW3A9EQ==
X-Google-Smtp-Source: AMsMyM7FzbYnuTvTdt0o24rsae8ko+gcNRtsmr3OrO40odBVknBSvcP5n7hDqiGItcM3+baBZLBV+A==
X-Received: by 2002:a5d:6784:0:b0:22a:e477:8fd4 with SMTP id v4-20020a5d6784000000b0022ae4778fd4mr463186wru.218.1663335307913;
        Fri, 16 Sep 2022 06:35:07 -0700 (PDT)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id fc9-20020a05600c524900b003a84375d0d1sm2369106wmb.44.2022.09.16.06.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 06:35:07 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: will@kernel.org,
	robin.murphy@arm.com
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] dt-bindings: iommu: arm,smmu-v3: Relax order of interrupt names
Date: Fri, 16 Sep 2022 14:31:47 +0100
Message-Id: <20220916133145.1910549-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The QEMU devicetree uses a different order for SMMUv3 interrupt names,
and there isn't a good reason for enforcing a specific order. Since all
interrupt lines are optional, operating systems should not expect a
fixed interrupt array layout; they should instead match each interrupt
to its name individually. Besides, as a result of commit e4783856a2e8
("dt-bindings: iommu: arm,smmu-v3: make PRI IRQ optional"), "cmdq-sync"
and "priq" are already permutable. Relax the interrupt-names array
entirely by allowing any permutation, incidentally making the schema
more readable.

Note that dt-validate won't allow duplicate names here so we don't need
to specify maxItems or add additional checks, it's quite neat.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 .../devicetree/bindings/iommu/arm,smmu-v3.yaml    | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
index c57a53d87e4e..75fcf4cb52d9 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
@@ -39,16 +39,11 @@ properties:
           any others.
       - minItems: 1
         items:
-          - enum:
-              - eventq     # Event Queue not empty
-              - gerror     # Global Error activated
-          - const: gerror
-          - enum:
-              - cmdq-sync  # CMD_SYNC complete
-              - priq       # PRI Queue not empty
-          - enum:
-              - cmdq-sync
-              - priq
+          enum:
+            - eventq      # Event Queue not empty
+            - gerror      # Global Error activated
+            - cmdq-sync   # CMD_SYNC complete
+            - priq        # PRI Queue not empty
 
   '#iommu-cells':
     const: 1
-- 
2.37.3

