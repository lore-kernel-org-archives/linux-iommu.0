Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B028B14011
	for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 16:04:49 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-589f7d66f22so48407167b3.3
        for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 09:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692288289; x=1692893089;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nhmsuM5yHQfjgDqk/74LT3YBolDr49Ko8c7EPxuWM5Q=;
        b=zwXtsJpQ2Uvh3R4jdnGNp4J2U2xMpVYYSiEnlSuEv4pyxKjdgYkMy35a2OnllBS98O
         CxLGGdmFYKrxzagrokfu0stdBCqRMZQUx6vIqeQJPpzZpKxqPYJY6WdPnfsiB1iY6p+I
         7mdzilllc9HwJTCaVnWCMipw9c0YFFecZC2y2PamRwSW9xiFc5AthLx0ye6Wq95WKYj5
         DQJuzMMMraPXNzVlxzm1r9igzF+XxO2q+D29sBL8kpV+Vybpzs9ARohV5yPbnsovgq7s
         eikzG6SvOQOfixhXLCh+uxbHvbQYnywBXPNsp+KPrsbEeWOv60FrlrCPeXeuOGOByKxD
         7Nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692288289; x=1692893089;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nhmsuM5yHQfjgDqk/74LT3YBolDr49Ko8c7EPxuWM5Q=;
        b=IBtok4X1aJf8Hc3jYN2dQMPCePLEL0y3ayxBolH5LpTAqgSdwGN7dvWskSkBxw/bwe
         kOo5ZBFbCys3VVONj3XRGQAj8BfXbPwH+goGvPr/nzJJZfoiYYrQt9Z65cXIxZWoVUoo
         xrdVoeYQPQlGGclmU5wklgzDy1B2189P6e7YxpNOzdKx2FamNrS0qmFzgxVVlPxQbvDn
         Lewm1SK+9KKfa8rQt51J1/PWp8eVmUbYVZg2MlEMHWSmmJDmWAaW9bd2yu1AUL++QVhb
         KNtkbY20LyLTT6sc9Q+E01ubigC6EB1SwNLyXWe5EYBApXFkwmaTpr5njAvVadDitRSc
         f+eQ==
X-Gm-Message-State: AOJu0YxnoviflWKxke4VLR1JIotz4rdqgkpwlB5M3GAtkvVxkpcrjriY
	uywLjK/9XIFemyQzFbvMBq0Qk/nhggMHD60QQXLIybIaqXHK5OJ6/dN8uliJ/kBcqYboa97/p+r
	E//g1fxIJNHndRAJ/8IylCq9RYV0HJA+GetMv1mMwcN8Gubp7ulsqr0WTDXM2nmo=
X-Google-Smtp-Source: AGHT+IH/2ZEVO1MgS6IrCQGrdLUhLc7XCvX7bO1lPrLmBV6kXD7edJxFI23NCe5BR7m3R10h3YAQoKli5qWR
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:4a77:fd20:7069:bdf9])
 (user=mshavit job=sendgmr) by 2002:a81:ad1a:0:b0:576:8cb6:62a9 with SMTP id
 l26-20020a81ad1a000000b005768cb662a9mr76288ywh.6.1692288288309; Thu, 17 Aug
 2023 09:04:48 -0700 (PDT)
Date: Fri, 18 Aug 2023 00:03:30 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230818000321.1.Ibca43cc8d1bcad3ac3deef5726b9745128aea634@changeid>
Subject: [PATCH] iommu/arm-smmu-v3: Simplify stage selection logic
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev
Cc: Michael Shavit <mshavit@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Joerg Roedel <joro@8bytes.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Robin Murphy <robin.murphy@arm.com>, Tomas Krcka <krckatom@amazon.de>, Will Deacon <will@kernel.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It is invalid for an arm-smmu-v3 to have neither FEAT_TRANS_S1 nor
FEAT_TRANS_S2 bits set, and this is even checked in the probe.

Only set ARM_SMMU_DOMAIN_S2 if FEAT_TRANS_S1 isn't supported, otherwise set
ARM_SMMU_DOMAIN_S1. This is clearer as the existing code implies that
something more sophisticated is going on with the stage selection logic.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9b0dc35056019..e74c8c630adfa 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2206,7 +2206,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 	/* Restrict the stage to what we can actually support */
 	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
 		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
-	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
+	else
 		smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
 
 	switch (smmu_domain->stage) {

base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
-- 
2.41.0.694.ge786442a9b-goog

