Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F7A101EC
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 15:44:15 +0000 (UTC)
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-650cb5a6b0cso6469495b3a.1
        for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 08:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686757455; x=1689349455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kKyYB6nGtYqnelo6XDlWvQzY0JjgxL/I8n3xKSQjyKM=;
        b=ZreyidDpJbP1PBXH0/670/kPY2SsUh00/efeS6mDpY0HajYSURNuwl2jgv15mHAY+8
         BQnjoS82KZhUCP+ZW8JKdnnpOoil/pxglVP0s2csLwMNXQxHU51EaIYCRwcdKqquCh0q
         3bWW4wrsmrxasyohwzBecrXf6yKsHWQhn0bySkpCPo4xUAgaHO41cs19iiK6VFDnmGcL
         1z3TlJElBou8TAuRPKhYnjDJwUUqq75L0bf3w6VNMdMUoFGls32SxQ9iHK9xTnV32fN7
         YIabDW9594lEZ4404D02Bxq7KeKnTkNz75qnKx2pKgIU+oWiPHE0kF1iXqTgciI2k5V0
         H35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686757455; x=1689349455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKyYB6nGtYqnelo6XDlWvQzY0JjgxL/I8n3xKSQjyKM=;
        b=SMpOwaevBqTvnlNQdruEcG46bBmanpligHbo7j4Q1kah+fxrPRl3GUMonCvaBYkK6d
         9lut0va/XkvSMqeamdDhC+MF9dAgRJks3EKG4C3BgAFSzMqgqxwqRyuOzwOzOmIc4u0j
         QUz47HSGFkXbiYMDSGZKnq5H1OoyPP2Q+FEoJIZ6pa3GafAsoZWDdx9bVCdxhJh0BWNl
         Z/nml7Zmev4cUdtkbLdZd0A2qLGslEY20XAUvem2euXXyNj0PMdJv8xSzokxcvllc0WR
         I0nzYciPH0GvlR6/4x5d9Y1gJGz+6IMxr0Qe4XNEKgJ8Xe4XV3ht+KejfzZ1+gcW3IIQ
         MqPQ==
X-Gm-Message-State: AC+VfDyGZV8g3IoB/1aSVWgsYpfr9ceC44EFUKGWCWNa4msXq8Ru5Gyr
	gW5pXfLuY9zkwLjce3jkawlIAmPuGxHE
X-Google-Smtp-Source: ACHHUZ5hvf161DqxDEUjciWGgh2uDlHkYPKEsVFxC66gt2tXnPwcs58oZC95f7+2kSAq6UzNy1BZjwtxJnV7
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:c6e6:49bf:5c44:5965])
 (user=mshavit job=sendgmr) by 2002:a05:6a00:2e99:b0:654:424b:17d2 with SMTP
 id fd25-20020a056a002e9900b00654424b17d2mr664816pfb.2.1686757454862; Wed, 14
 Jun 2023 08:44:14 -0700 (PDT)
Date: Wed, 14 Jun 2023 23:41:58 +0800
In-Reply-To: <20230614154304.2860121-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230614154304.2860121-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614154304.2860121-7-mshavit@google.com>
Subject: [PATCH v3 06/13] iommu/arm-smmu-v3: Simplify arm_smmu_enable_ats
From: Michael Shavit <mshavit@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

arm_smmu_enable_ats's call to inv_domain would trigger an invalidation
for all masters that a domain is attached to everytime it's attached to
another ATS-enabled master. It doesn't seem like those invalidations are
necessary, and it's easier to reason about arm_smmu_enable_ats if it
only issues invalidation commands for the current master.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
v1->v2: Fix commit message wrapping
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 08f440fe1da6d..dc7a59e87a2b4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2286,7 +2286,7 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 	pdev = to_pci_dev(master->dev);
 
 	atomic_inc(&smmu_domain->nr_ats_masters);
-	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
+	arm_smmu_atc_inv_master(master);
 	if (pci_enable_ats(pdev, stu))
 		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
 }
-- 
2.41.0.162.gfafddb0af9-goog

