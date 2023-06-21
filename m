Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655758482
	for <iommu@lists.linux.dev>; Wed, 21 Jun 2023 06:44:05 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-bb2202e0108so5699063276.1
        for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 23:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687329844; x=1689921844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kKyYB6nGtYqnelo6XDlWvQzY0JjgxL/I8n3xKSQjyKM=;
        b=1gaS0SkW/Sq1tXITKeGmUGTrKdPbcpqB9xL6/exaE20A1NUvR9wFlTNBFxrCnmmx1W
         noltPOrcY64SY3zBIRAqGGfbitthNieh+upEIdv0gNliNAenwXtXVAvyOqY984mtAd6s
         nZgSwJLTL85y1xBHpiEsiHarlo3Bmr5RbJEloL0e473xQwEsJxKBB34H4CbuybmXI0iF
         wQwBCGVX4lZWA1O+4ztFmOn8qil9C1LlaOpKaRxZ4fVPxqw4z+x6RhcaqWte8IpC0cAV
         lWLdyIWdY+62QfGdY9MFUSCJ+NVCLxGu5r6cyaSOI9Fao6Wur1O0Gop63zLuED1qwKea
         cevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329844; x=1689921844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKyYB6nGtYqnelo6XDlWvQzY0JjgxL/I8n3xKSQjyKM=;
        b=beV6XJwfnuh/+GHEm5YyxbIMNIRowEkh0EA41LR6nCfbx4lj/3M2d/KohOylFdgZIU
         x+WWsScWdjp0U6YkFLzjN0zO4xCIE9uhOIAkWrwVCs6Z0wTtCbh8eEjJy1F7KGcC83td
         x40J1nK+CeQjHijYVmGserRIUi2bXbL+2ddiXbTSEAx1SbRqBEO8qNhz6GIPWT3xQcfI
         MEJMCjbQ+bdZ1nI2zw1nBtbp5KEkW8YtN2mQoigPQnd3bCaUslBM8IGP7KOl6uvE1JSh
         j6g34HG3b1BxrVoTPl/7mlG2HpwmSaahuyKOC26jeqtKCwG+P+lhCqP4A8dQOIHYSFOc
         w0Yw==
X-Gm-Message-State: AC+VfDzCLT6wOTLvgJ56ezPTNuZpe8+NdZm4PcQZM9GW13QE9kheLuxk
	H7s4DCZIjriheWGC2uxjR5PlpObbBnOu
X-Google-Smtp-Source: ACHHUZ6RcCmWn2rv5cCpEtepK8VPy5yY5wftqIvcrh1WvBJEI4R+LQYSq6Xo61BWKeoCrTmvyiGy/yG28bPE
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:384f:f7da:c61d:5a3e])
 (user=mshavit job=sendgmr) by 2002:a05:6902:1363:b0:bea:918f:2ef6 with SMTP
 id bt3-20020a056902136300b00bea918f2ef6mr1543181ybb.0.1687329844564; Tue, 20
 Jun 2023 23:44:04 -0700 (PDT)
Date: Wed, 21 Jun 2023 14:37:18 +0800
In-Reply-To: <20230621063825.268890-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621063825.268890-7-mshavit@google.com>
Subject: [PATCH v4 06/13] iommu/arm-smmu-v3: Simplify arm_smmu_enable_ats
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

