Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A03C2908
	for <iommu@lists.linux.dev>; Tue,  8 Nov 2022 02:59:10 +0000 (UTC)
Received: by mail-io1-f47.google.com with SMTP id s10so8651964ioa.5
        for <iommu@lists.linux.dev>; Mon, 07 Nov 2022 18:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQmrxV8UAMx8aTkAdlv23yBJFQlgUNmii3sTAapLgyI=;
        b=T7fKMlBHsf/SjC3hRWE+bmKrYjO5qAYLR6+c4ucn2jrIpPSWUyqBCLQm3NPTJcea1B
         IrOcGjMB8nJlqkwX8cqPGFV8j+WP+dfcpuaBnLyCZrK+HI+3tW/8pdV8jI5Ba1kYSGUq
         QLz/rciyMiNfUAz3//JrlufbwRPtyjJKxT9XKK4Cjp2hI4Pd6/LTMjqZlhxNNHjHqGfC
         BOmSItRWg4clR0YhMq99MezWQfwb/k/eOGCSP2HkVWRJsizyW3YW6qwO0x+crdUSsLNW
         838wmRGtG3c+qBEZnNAtoWvvQlY4dCOz+zSr7YOz9cCwGo7MLwi0+b3n8RDhVcoy4CWx
         dhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQmrxV8UAMx8aTkAdlv23yBJFQlgUNmii3sTAapLgyI=;
        b=ldV1LiG8frfWX9wlKLVFO4gkJ22ti6mG8Ys3zIFf/4c6rIgZ6xI8KoGT2mEK2HF7Tr
         x9evMJlfpc9hQEgqNd1KzER4HkK3MEokCvLLeRDwzQksMzNiXwP5lYSMRquWW6fBhzqx
         sTfFa43gLvQO3aiXAOnSKRCt6sI04pXKou5QrNzFhzERJM9C+zM7Mt9Fz+f0XIwHYgE/
         fCS6cFDFbvcAAM/PlUHo3qLZ3R2TLd7Ou8W76A2vngSFQag0YOEqkcNkPF3jJl85jmWC
         cGMKgBJbnXv7zjkvUNRZEnVzKYqQYj/dmjHPC0iESOy0hIel3DG97DA5wuHsS1YAV0Sj
         OroA==
X-Gm-Message-State: ACrzQf1OlIB7qam71xdsBmTJmJIJaMy2tw5fm9M8xGF8TM5x0z6u4dEC
	OrSPrxaXGRM6gknmRJXFUgg=
X-Google-Smtp-Source: AMsMyM7UeuJikzj7LIRlLxdJ3APD3Gi+t7E5Kh7yKxpgk7/fdMVy+3SOTwb4Qa8hPi400V+KW0I/Gg==
X-Received: by 2002:a05:6638:d84:b0:373:2ad5:232d with SMTP id l4-20020a0566380d8400b003732ad5232dmr31641007jaj.251.1667876349206;
        Mon, 07 Nov 2022 18:59:09 -0800 (PST)
Received: from localhost ([2607:fea8:a2e2:2d00::61cc])
        by smtp.gmail.com with ESMTPSA id z20-20020a05663822b400b00363ec4dcaacsm3365438jas.22.2022.11.07.18.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 18:59:08 -0800 (PST)
From: Richard Acayan <mailingradian@gmail.com>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v3 1/1] dt-bindings: iommu: arm-smmu: add sdm670 compatible
Date: Mon,  7 Nov 2022 21:58:49 -0500
Message-Id: <20221108025847.58352-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221108025847.58352-1-mailingradian@gmail.com>
References: <20221108025847.58352-1-mailingradian@gmail.com>
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
index 796dc7d4dbdd..f77597e8ed39 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -39,6 +39,7 @@ properties:
               - qcom,sc7280-smmu-500
               - qcom,sc8180x-smmu-500
               - qcom,sc8280xp-smmu-500
+              - qcom,sdm670-smmu-500
               - qcom,sdm845-smmu-500
               - qcom,sm6350-smmu-500
               - qcom,sm6375-smmu-500
-- 
2.38.1

