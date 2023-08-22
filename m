Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B88944D
	for <iommu@lists.linux.dev>; Tue, 22 Aug 2023 10:58:22 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-58fc4291239so37589047b3.0
        for <iommu@lists.linux.dev>; Tue, 22 Aug 2023 03:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692701901; x=1693306701;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1xwW+v61rdPoCKQce2vPFjbmpLjAsPrfEpwPotlFF+U=;
        b=ih84672TYQ0uR36sTapzunrkuaUbWHstif3b6iKv7mV3HpIc9cWZ/oYc7uNRCSLHII
         2pHZd83QwfjJv/p3f29R0trlm8vijxENfi7yMuVBaY2+T5CCUyaUJS2KkqT9Jorm3XyA
         F4CKy9vVBhIcyEG+ZlJR3RgTozztbPtNsvxGcUzwgmX8MvrZ72+oxt2V2nNn9EAFgnZd
         eMI7hjX/T68tgwFc11i6TnaPMU0k2YP/zpC4v7zSsVJ90z2wWeWwpZtxjLTYUJzRvz1S
         uJ/x16oIz4Tkeb54hZV8Q6cD5KoMVbD2Mj8OWAieMWxQdl+7RGvaPgogdL6XCaL/ypW3
         BHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692701901; x=1693306701;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1xwW+v61rdPoCKQce2vPFjbmpLjAsPrfEpwPotlFF+U=;
        b=MIoiSdZikpVtlQG2AokbUnqLJaAy29UEsLn4Q0A/fjLY215NiFBkoQFpauXscXjjLq
         Tdoymvke+aS6RlDFydH7BAtyGRV2bs467V+tmRkUKRvYvpqcnUhe1eAtOhuPnpXLfXDH
         bBzcUyIhYwo1HS3pgVMxTZzxwFK0mebx8bURiHvCy1HIqbIRa4yR7hAO3hHLBy085pXr
         GbI1d1qUI6oaJxaFyRDT1oxhgUqifKBvIe+P0xrYij6KbioyjsJcOb3aPBDsz+qYSfK3
         zhnb1/OFeAOxnqZ7Rbwmr+jlYdQKRLHXoxOJcJV6xQ4L93nsfHlf4ldispeuIJ9NEG3i
         Od3Q==
X-Gm-Message-State: AOJu0Ywvgz3uHhnaGjq/8zlJRUVEPa8/prkBaYl7bkGQLhmlQwC7Calx
	wOyZh5gJKDbM9vmMFtIy9vRDBFNRbhJlm6d+e3KD19WMb3UMaDYbUiht5W22xC65haxo3Cba/qN
	wT1n0lZrVGHBvr6KbxAMgm516UowYsFrQPgfY8yz6mK9O47Ou1A8cO0HHZTEB4Cc=
X-Google-Smtp-Source: AGHT+IGuW/3tPdCQ3blX7ef1nckHZq80wU2cX1yfJoUAETquSTLyTg4Dg7WC4rSmY3PWOYxMSvKC8jV1/Uko
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:44ad:3968:8aaa:c4fe])
 (user=mshavit job=sendgmr) by 2002:a81:af23:0:b0:562:837:122f with SMTP id
 n35-20020a81af23000000b005620837122fmr87489ywh.9.1692701901552; Tue, 22 Aug
 2023 03:58:21 -0700 (PDT)
Date: Tue, 22 Aug 2023 18:57:04 +0800
In-Reply-To: <20230822105738.1607365-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230822105738.1607365-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230822185632.RFC.v2.8.I65dd382de382428dcb33333342b35405903ac768@changeid>
Subject: [RFC PATCH v2 8/9] iommu/arm-smmu-v3: check for domain initialization
 using pgtbl_ops
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: nicolinc@nvidia.com, tina.zhang@intel.com, jean-philippe@linaro.org, 
	will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, 
	Michael Shavit <mshavit@google.com>, Dawei Li <set_pte_at@outlook.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

In order to remove smmu_domain->smmu in the next commit

Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v1)

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7c9897702bcde..9f8b701771fc3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2894,7 +2894,7 @@ static int arm_smmu_enable_nesting(struct iommu_domain *domain)
 	int ret = 0;
 
 	mutex_lock(&smmu_domain->init_mutex);
-	if (smmu_domain->smmu)
+	if (smmu_domain->pgtbl_ops)
 		ret = -EPERM;
 	else
 		smmu_domain->stage = ARM_SMMU_DOMAIN_NESTED;
-- 
2.42.0.rc1.204.g551eb34607-goog

