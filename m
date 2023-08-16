Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BB8FC01
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 13:20:09 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-589e3ac6d76so51137077b3.1
        for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 06:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692192008; x=1692796808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JVOpA/yt+XB5fUDF/Igz/1o39LmIyoO6uf2H6LfppQ0=;
        b=YHx69WaUgdUHez2bpSsN8VAxs+M9Lh0EQC30duWKtyrWoU5UQTBl3GKL0LegsdUQVV
         kx+B6cCwadRkWKJfekVHY8VUMOO8F1S3vlM9rjxOBbKChwmPib7a3m2k4KzhrAJxFYgw
         SB+aN7HVCG4MkJ8rHCdQ8ueQEX1bw9HsxGgrwc8fSyopYuNcpKF4I2RiKLh05MUuIfhJ
         fj4IjCHt43Kdzkb1Kgdjzqu4Ah1mVPOuvAMLjXb19UTBxtnDlgXy+fTZ5T5/1PXc1lUp
         PR8annuG6JxdZAe1nvGiISguAQby7BJc8Ifl/RWJkwV53HZ4hMbYWb0Yg5IMbtnHEV7t
         x7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692192008; x=1692796808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVOpA/yt+XB5fUDF/Igz/1o39LmIyoO6uf2H6LfppQ0=;
        b=F9/H6+ISIxlo3yrIpB8XMy9dhZOrS/ID0/AYddoH4hA4wSKd2sZR4WjQFJPPxTZjz7
         6xL9Q8PhGJVMhgOg7U7XQgFSpEDL9v6ly3e8ArGaxobEVChOddo7cSEPWRZ3dAOhyZXz
         kHreEVAtGqvw0MqFOm8viesjI9tTLz05X2Ucd/NLvnDL3S2L69gEPes6XAm+KSLz0+KA
         Ca+7OAxf2Adj2OsWtkWgS2d9KqSjAWYYk2O86KWy05aVg2Jjp+MYjJgWBC5zhs4FMRNy
         ewJSzyFo9QGdCr7Pti/cRqc/qr9g2mfWy0/jYEju+mkG6YH5rWXXh4jmd1EcjWZOq/gY
         g04A==
X-Gm-Message-State: AOJu0Yxh4Enk3UUU6xihERkrmAcN7PMPAxaKXc6AVmYbfDV4RWPeAKry
	nrbf+KsjWMurOaKhqCdjgno5fl40XUa+sUYJfVKMn1QJrd64U9dAcd341rrgmeoGtrb8KrT+nWe
	kQvepWOYg9TROuKkwFl3CYlBMpodHaWMlCZtlByADvXx452oH0gDz7ZFUjgQ7Vaw=
X-Google-Smtp-Source: AGHT+IFpyLI55CA6xQKncSrPwnccVH+ac9drAor/x+DI/dKv5IqDhSwq+q3zlIdn3S0InwRjuxU5uhS9UAek
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:ae98:2006:2abd:3434])
 (user=mshavit job=sendgmr) by 2002:a81:4524:0:b0:57a:793:7fb0 with SMTP id
 s36-20020a814524000000b0057a07937fb0mr24462ywa.3.1692192008657; Wed, 16 Aug
 2023 06:20:08 -0700 (PDT)
Date: Wed, 16 Aug 2023 21:18:48 +0800
In-Reply-To: <20230816131925.2521220-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230816131925.2521220-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816211849.v6.8.I7a8beb615e2520ad395d96df94b9ab9708ee0d9c@changeid>
Subject: [PATCH v6 08/10] iommu/arm-smmu-v3: Update comment about STE liveness
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, jean-philippe@linaro.org, 
	jgg@nvidia.com, nicolinc@nvidia.com, Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"

Update the comment to reflect the fact that the STE is not always
installed. arm_smmu_domain_finalise_s1 intentionnaly calls
arm_smmu_write_ctx_desc while the STE is not installed.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

Changes in v6:
- New commit

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index de87150cd0242..3c8bfeca89d5c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1091,7 +1091,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 		cdptr[3] = cpu_to_le64(cd->mair);
 
 		/*
-		 * STE is live, and the SMMU might read dwords of this CD in any
+		 * STE may be live, and the SMMU might read dwords of this CD in any
 		 * order. Ensure that it observes valid values before reading
 		 * V=1.
 		 */
-- 
2.41.0.694.ge786442a9b-goog

