Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BE41FC4
	for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 13:19:32 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id o11so18060048ple.1
        for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 06:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1680182372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S6l/tdN4cMocc6YNsFbnVaBOI5uqYV8apPR4ELkkR1Q=;
        b=pPb+W1QgZUk+g/DFt0UfL4wvFYJaRRtQKymjwO8tr2syCrw2bxdSdsGsBmOTjBJJOU
         GRkmAqZZoHB6hOnkhqHnThpioBHtq3jivXAPFWke4uyOwhdORNZqKIRxvMGCS19DhfLI
         ggM0uxvrKrxdJXxG2mJiCNE9dRLCUBp2M7iFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680182372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6l/tdN4cMocc6YNsFbnVaBOI5uqYV8apPR4ELkkR1Q=;
        b=BH7uSgoDEtU2sdzcyFfTjGah6z9qjSvf6sR+4b5VqvQNeXMgU5yGoFnX9yAV5g3eT4
         FwTsQK6Daw3q4p1GkaFWw3NPRnznScoYF6wcNQ+SKZp5ADUFH6Kilfje4ZdD873FMb5d
         dvFZ9OiTYk+EqDKhoNhxhIvWwwM98Moxzh2ExYCvN+5JLfito4nCZqJUv/Jo0pjYadh/
         GwZ1cVxTj5+Cugp+Bf0GfjROGHhurVF3Mni2bpCpt8ZFHATIdT5wZ1ll+wRQpCCwKnij
         GGl6c94T1rggEGCjgPg19HaWmRV1+z/1hr2urG+c4F4P+gSLSNpP0iK03yM2D16UVMnJ
         mtpQ==
X-Gm-Message-State: AO0yUKVp0kQkfx796wS4tMt1Q3hSGytXRJVMi7iI3HzIv8VJhQVumMD/
	CJHfk/CnkbEfBoL6bJoJj2ZGFg==
X-Google-Smtp-Source: AK7set+nB3B4s6QuXUMw7fa8+aYurUZsFGiWJkTcqxFTLaUpIGoGauwzQvHyFwb4bsvlmviF5TolgQ==
X-Received: by 2002:a05:6a20:ce22:b0:d9:8b07:eb0a with SMTP id ic34-20020a056a20ce2200b000d98b07eb0amr22599282pzb.24.1680182372424;
        Thu, 30 Mar 2023 06:19:32 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c00a:a047:8bc3:c2fc:8dab:d912])
        by smtp.gmail.com with ESMTPSA id e15-20020a62aa0f000000b006259e883ee9sm22473622pff.189.2023.03.30.06.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 06:19:31 -0700 (PDT)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: iommu@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-amarula <linux-amarula@amarulasolutions.com>,
	Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 1/3] dt-bindings: iommu: rockchip: Add rockchip,disable-device-link-resume
Date: Thu, 30 Mar 2023 18:47:44 +0530
Message-Id: <20230330131746.1475514-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip iommu is trying to enable the associated device at runtime
resume however some devices might enable the iommu during their pm
runtime resume operation which indeed leads iommu to use the wrong
domain and this leads to device iommu page fault.

Add rockchip,disable-device-link-resume flag and give an option for
those devices to disable the device link during Rockchip iommu pm
runtime operation.

This makes the device enablement for that iommu domain ignored during
the rk_iommu_resume call as it assumes it handled iommu device
attachment in the associated device itself.

Document rockchip,disable-device-link-resume flag.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../devicetree/bindings/iommu/rockchip,iommu.yaml        | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
index ba9124f721f1..ac8b03806cb3 100644
--- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
@@ -58,6 +58,15 @@ properties:
       Some mmu instances may produce unexpected results
       when the reset operation is used.
 
+  rockchip,disable-device-link-resume:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      Do not link the device during runtime resume operation.
+      Some devices might enable the iommu during their pm runtime
+      resume operation, so disable the device link for those devices
+      otherwise iommu use the wrong domain and that leads to device
+      iommu page fault.
+
 required:
   - compatible
   - reg
-- 
2.25.1

