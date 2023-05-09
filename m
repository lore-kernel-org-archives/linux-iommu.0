Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034FC14A81
	for <iommu@lists.linux.dev>; Tue,  9 May 2023 19:11:38 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1aafa41116fso43533045ad.1
        for <iommu@lists.linux.dev>; Tue, 09 May 2023 12:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683659498; x=1686251498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GiDsH8G1Ml9mu5sSlgFdINiWzY2jO1Z5sTjGCqCyfWM=;
        b=OHoAELdpBVUNdBcedKgaIrSzqY8mpapJQEE3me1X0GlYJxG1opVIZ82ANS24D8UPtG
         Pt2dawEt+S0ERzDZ8ezL8OcIOWWqO9L1eryK0o6pszAoxIMPuD+jhRqXzf4me//VM0PJ
         FOun4S3oDVIRhH/u1JmX6/c6pNlrGnzsUTZo/kz6gQSktOKQpHhNl8K+TyCsqJj2ZBJJ
         52ig+ToxXnJIEh0wyCZF8Mth2Ax7GsgmBOe53OpuwAyHtGFjM2n+j9PcppngFiyluFiP
         EBB4PWuxCYUiTExHMAvHAH8/2SO0zwGCGhatUE5MKIJDvVd7xgbPqD3z2bM8x5sGuxoY
         vSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683659498; x=1686251498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GiDsH8G1Ml9mu5sSlgFdINiWzY2jO1Z5sTjGCqCyfWM=;
        b=Z0AZ2rw+vDu9HuZ4jskbryuFtUSCvfTAeYQATvzmYx2iXGkSymvUSEt2YptHsyjEt2
         x/wHDkWMHOdZ05bSH29g1Uq4nGlpW2mzyWF7Rwup3U6LDWe4DQC42cnujwzetv/BcCOs
         rT4EwVsIhNb1IeZNNuB+HJrkMtt/K2Xdn9QdA5+qD1Ed1MSi+fZOtroz9npTIlua0hSH
         Vegb1bTH9ee6B0jVAl1dOWuptTDz5uu70ZmQw9jb0djL4wgNjlml2vh0CwyunpekZU6U
         I2737MeO71967CBLmJSAhdPxjuV67M8dUWtPP7epYNHgiJdzUPADOhafGiUz9J9L8IrL
         NcJQ==
X-Gm-Message-State: AC+VfDzjbIgylZt1r/7Wb+K61IF87u0r19AHroRzg8awmTsNC1KpOTDW
	iQtuOflVz99DnWT1Wl+8Qi6qa0cmrxE=
X-Google-Smtp-Source: ACHHUZ4c9dGsxc56Vq7d4bMsklNgYny1qzmRzvIIBCBIw/4YDrf9m4QoU1u18kmttsWz08c//8Vl+Q==
X-Received: by 2002:a17:902:d509:b0:1a6:51a6:ca76 with SMTP id b9-20020a170902d50900b001a651a6ca76mr18757686plg.11.1683659497972;
        Tue, 09 May 2023 12:11:37 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902b94600b001ac78ac2cafsm1955579pls.239.2023.05.09.12.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 12:11:37 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] iommu: Suppress empty whitespaces in prints
Date: Tue,  9 May 2023 12:10:48 -0700
Message-Id: <20230509191049.1752259-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If IOMMU_CMD_LINE_DMA_API or IOMMU_CMD_LINE_STRICT are not set in
iommu_cmd_line, we will be emitting a whitespace before the newline.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/iommu/iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f1dcfa3f1a1b..0dd6ed6bec47 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -176,16 +176,16 @@ static int __init iommu_subsys_init(void)
 	if (!iommu_default_passthrough() && !iommu_dma_strict)
 		iommu_def_domain_type = IOMMU_DOMAIN_DMA_FQ;
 
-	pr_info("Default domain type: %s %s\n",
+	pr_info("Default domain type: %s%s\n",
 		iommu_domain_type_str(iommu_def_domain_type),
 		(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API) ?
-			"(set via kernel command line)" : "");
+			" (set via kernel command line)" : "");
 
 	if (!iommu_default_passthrough())
-		pr_info("DMA domain TLB invalidation policy: %s mode %s\n",
+		pr_info("DMA domain TLB invalidation policy: %s mode%s\n",
 			iommu_dma_strict ? "strict" : "lazy",
 			(iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
-				"(set via kernel command line)" : "");
+				" (set via kernel command line)" : "");
 
 	nb = kcalloc(ARRAY_SIZE(iommu_buses), sizeof(*nb), GFP_KERNEL);
 	if (!nb)
-- 
2.34.1

