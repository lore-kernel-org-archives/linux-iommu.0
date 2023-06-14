Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AB5101EC
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 15:44:31 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-56fffdea2d0so11289967b3.1
        for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 08:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686757471; x=1689349471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=omVhI9NBPuwnuDBL2dAuwy0d7VVlvqTslf6ohlhvBoo=;
        b=jMlnk/MKenoGoe+vncInH3bNLbjsOY0Xrv5py/yEVhJC0Voa9L6CSXUuAVOi6fmYCJ
         Tgf0uByedAMjl4kDugva5Z7ex59EM1z4IazeM7oUL8ziiQDhW3iZaQ0JG9Qm40ngiaZL
         +M5Dg5le9q5NHjjTl7k9QZk59/KC3EuCDrBCsL0bF4lycPrvzpsN0P/LhUKYz/tUyV0x
         isJj8aPRjzh8meDpJOrtJNeFlx8yvD55tCSLvcLBEnDtcXfsEbJZtuB1BwtuBcopqymr
         /Rvz8IKzzGTFog5Cr0gOu/QV8fyEzYweTi1tUgmgmlB4M3eES0bWGS4bsAPec9Qi8ALG
         4M8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686757471; x=1689349471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omVhI9NBPuwnuDBL2dAuwy0d7VVlvqTslf6ohlhvBoo=;
        b=WKHKsrLeZBxpxsKcA15hyETf43fdVp6+BvgnqFSJ9qYzz7W0KcQzo/ZAiZSLPFEbcY
         ekF1XwlBVV9Bma8FZBTQtWtKBqzfaOW+hjUsrgAdrqD9aa9ORGKbrkV9m+G/LoDJJ2H9
         Dr4qllWvxh4SJWlYB50iALZoO4oH6aJAh2VduA4x6OgXUc2iF/Df04JIBThNXhQpXDE3
         UgUbq/TsmsDQuagyvLAb15TUOqF1FoGRm03pATIWL7EyMn8KAbmxQUn2h4WuM+3T/cjN
         iZ1ZyNvChNnLW4Li6GXBKSJsab+wqnrDGfmojkkY99GaSR8fbSAdXcFIjJgabujnFSR2
         UDmg==
X-Gm-Message-State: AC+VfDyv4yDvJhMTDWnmI2HMiFrRPskFYzzfrYU6+9vouwczOKodVN08
	+0vKXwarfEMQyIUQNcAMf2REy2iZszrG
X-Google-Smtp-Source: ACHHUZ6qWrQixYgUn/5HtahtJSL3blxJF6JctRnT69qFj5a4lL50PstwAlMR8K47HQ216a2/pWujMLt858mE
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:c6e6:49bf:5c44:5965])
 (user=mshavit job=sendgmr) by 2002:a81:4426:0:b0:568:c4ea:ce66 with SMTP id
 r38-20020a814426000000b00568c4eace66mr971778ywa.5.1686757470875; Wed, 14 Jun
 2023 08:44:30 -0700 (PDT)
Date: Wed, 14 Jun 2023 23:42:00 +0800
In-Reply-To: <20230614154304.2860121-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230614154304.2860121-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614154304.2860121-9-mshavit@google.com>
Subject: [PATCH v3 08/13] iommu/arm-smmu-v3: Add helper for atc invalidation
From: Michael Shavit <mshavit@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This will be used to invalidate ATC entries made on an SSID for a master
when detaching a domain with pasid.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
v1->v2: Make use of arm_smmu_atc_inv_cmd_set_ssid
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 70580ba7065dc..176013bb974b8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1784,13 +1784,15 @@ arm_smmu_atc_inv_to_cmd(unsigned long iova, size_t size,
 	cmd->atc.size	= log2_span;
 }
 
-static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
+static int arm_smmu_atc_inv_master_ssid(struct arm_smmu_master *master,
+					int ssid)
 {
 	int i;
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_cmdq_batch cmds;
 
 	arm_smmu_atc_inv_to_cmd(0, 0, &cmd);
+	arm_smmu_atc_inv_cmd_set_ssid(ssid, &cmd);
 	cmds.num = 0;
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.atc.sid = master->streams[i].id;
@@ -1800,6 +1802,11 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
 }
 
+static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
+{
+	return arm_smmu_atc_inv_master_ssid(master, 0);
+}
+
 /*
  * If ssid is non-zero, issue atc invalidations with the given ssid instead of
  * the one the domain is attached to. This is used by SVA since it's pasid
-- 
2.41.0.162.gfafddb0af9-goog

