Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E63C15AEF
	for <iommu@lists.linux.dev>; Thu,  3 Aug 2023 10:14:08 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-583b256faf5so13560627b3.1
        for <iommu@lists.linux.dev>; Thu, 03 Aug 2023 03:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691057647; x=1691662447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1wRhIRrggJAZYs6e7aV6RdIU6iSXzW0ONi/CWI4qUk=;
        b=v8M8EpvgykyvNj5+VFK4+5VS1GCx+4thN93X5qGdv2Q6mDg+Q9BprkKi/ZqVY1cMB5
         hgughi4UN1aYu/EXNqY13NPNEQutZvvu2GYwDAvr8QOh2o+EQF3P9BYp4pftEx0ox7R7
         H293Y2C2VTDWZWO6xMfqIKxlFoQitde1l6TRNNpWpcVfHJP20iQVEqHd2/LLHggfZnBa
         ZYsMt0hplLT0HqFF4jX+LVen+NA6yXSnT9/tIhVW1iyXGrZn3ULvFc83mH9XfV5ftRLp
         iOKnNntwlT0uTtypEVze4RGIkmvLieWvFRULXEHMTA02TJWP0zXal6LCAjTnDjAfnCr4
         3weA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691057647; x=1691662447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1wRhIRrggJAZYs6e7aV6RdIU6iSXzW0ONi/CWI4qUk=;
        b=TkfCWDu8NGLVaC6ZRL//Bwtwkm8WyByGcY/l4Yx20bQIr/I+ph56Otom1wSYuoFRPv
         6nqpWtDGrYKX7yUB0R5RKB21EW98mIeRduEslbR+zdjlK8ogxMTr41nZhQkxmalBZ0mS
         RivSbJzM2yy3FXKVmRib30RllHnw5cXcaOagzxW4a9xR/WY9YrwBJu6lqumjE4OniZTM
         G2r0jWQgNKpaZ2mnAOOSH57fZ90In8wjomWOuzziYBs/F+EcX3zSmEq3dihTah6At7Lw
         rCnrSlImCPe8Tgo3ywnnuNotB7nzL9/o3t+6K11dzZT7EDuyddN5Z51Yn58a87AR3BEQ
         ZZug==
X-Gm-Message-State: ABy/qLb+vQ0U/dtATPthEX3uNOu3024rRDxCJq0jJJeTQam05P8Bvf7T
	N5UnQL/cRf9MNQFU+pqu0lzHVOyPWm0iyWIhjcQs4uwl+80aPaWrkOTZqumHahpDelAfFHPVMRe
	aTmJeZpcKsSKB7aUa6gCem+ngnvolbo6czDj7GNbkfJ17VZu1TutUHAw3Bu4U3I0=
X-Google-Smtp-Source: APBJJlGq7z9/Y1wQFTi6d5yV5b9fzok7EZ8JGI+3DYlCHleYWyG2dZOEveRtsUS2kTL+q5mmdG0WEODi8+D8
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:39d1:8774:b733:6210])
 (user=mshavit job=sendgmr) by 2002:a81:b301:0:b0:573:54d8:e5be with SMTP id
 r1-20020a81b301000000b0057354d8e5bemr268745ywh.3.1691057647550; Thu, 03 Aug
 2023 03:14:07 -0700 (PDT)
Date: Thu,  3 Aug 2023 18:12:21 +0800
In-Reply-To: <20230803101351.1561031-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230803101351.1561031-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803181225.v5.1.I18d69f4908b8a9f801239117d2a6c3f5aa1e2e76@changeid>
Subject: [PATCH v5 1/6] iommu/arm-smmu-v3: Simplify arm_smmu_enable_ats
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: baolu.lu@linux.intel.com, will@kernel.org, jgg@nvidia.com, 
	jean-philippe@linaro.org, robin.murphy@arm.com, nicolinc@nvidia.com, 
	Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"

arm_smmu_enable_ats's call to inv_domain would trigger an invalidation
for all masters that a domain is attached to everytime it's attached to
another ATS-enabled master. It doesn't seem like those invalidations are
necessary, and it's easier to reason about arm_smmu_enable_ats if it
only issues invalidation commands for the current master.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v2)

Changes in v2:
- Fix commit message wrapping

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 61de66d17a5d5..4df335424b266 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2305,7 +2305,7 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 	pdev = to_pci_dev(master->dev);
 
 	atomic_inc(&smmu_domain->nr_ats_masters);
-	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
+	arm_smmu_atc_inv_master(master);
 	if (pci_enable_ats(pdev, stu))
 		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
 }
-- 
2.41.0.585.gd2178a4bd4-goog

