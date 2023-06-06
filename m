Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F8E15ACE
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 12:10:15 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-565a336caa0so97990397b3.1
        for <iommu@lists.linux.dev>; Tue, 06 Jun 2023 05:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686053415; x=1688645415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Q0Iu14cVZzOpWwfTMTOhF5XX3kNov0fzYqifn+D0GY=;
        b=Qj9FF129nefazp7rsEoZgyUDmzsW8Dl4oEfnoMt+BCvxl+NTWVy4OR8Ok5LqOWKaUx
         OH7Ra2Dk8NTJ1kmkTIH+GHrVJ6MooFUGr5V25M/4AriM4Cz8/19OmBMafzikZWYs40Qm
         Fm13HyQurOg1VgQWnI/LXtDi8eOJhMzFYZLUgVv4ltWLJ/xFS52hTWzsa+AUMGoRw701
         UWMML1rZU2decc6dYLad29aIonKRI1Ygob0M9Vxe7Oe5pnNn9zl3Yxvx8/CaB3mrwLhR
         DUfVGLtQJ2r9UdgtgOlHuFp9zLZ1wVr8e0hzTvXgagApF3nwANZv4uRM+s4bJO8+8g/o
         gfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053415; x=1688645415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Q0Iu14cVZzOpWwfTMTOhF5XX3kNov0fzYqifn+D0GY=;
        b=f0kzyYdAztXs8C+nM+c+h0MsQvgfv9iq2pRF0ZLuUbloxD1SBFFe2zDb659mi4KJGq
         0T8cE+Sv9ditfAPWe1hsYOnsTV5lztojPk1Tn+VINIPRXSB9ztT4QXcGf95H5nUhD19r
         m7vr+Ki3o49cCzPP9D4wEV3wmK/5yPZdo4HPEF8qDjkVp34qP/c9VzBuGZpNjzVawszs
         2uWn2bML0Y6PSMiFeWjNOfjmsF+9flsJueYPCCxQ6vkLAMbFLh5Ohf3adHDGR4XiyeJt
         3QDKyJAeHkUWxKJOUv+kYV6u7vdF9EBTBSTePXJc1zIof8Trl+3Wq4YyhtsW6rVRE6Kd
         DnaQ==
X-Gm-Message-State: AC+VfDxrj7S2FkJWAkH0RcLq/oIBjEdnWlF8MERZOcHvrIjB345n7K30
	YZkHZKAMXkTqbhc8inFxVGDeZWUsqh8T
X-Google-Smtp-Source: ACHHUZ7jK5Jjz1CVCGvoACxb+sx/xnsAJ9T0sjJSsJfmybQ9sFj4pmgNmu8oIVfJWJ4QZm4rznUCA24jkhkf
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a615:63d5:b54e:6919])
 (user=mshavit job=sendgmr) by 2002:a25:7d02:0:b0:ba8:1e72:2c88 with SMTP id
 y2-20020a257d02000000b00ba81e722c88mr941602ybc.13.1686053414834; Tue, 06 Jun
 2023 05:10:14 -0700 (PDT)
Date: Tue,  6 Jun 2023 20:07:44 +0800
In-Reply-To: <20230606120854.4170244-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606120854.4170244-9-mshavit@google.com>
Subject: [PATCH v2 08/18] iommu/arm-smmu-v3: Add helper for atc invalidation
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
2.41.0.rc0.172.g3f132b7071-goog

