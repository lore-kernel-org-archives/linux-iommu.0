Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9924DC89
	for <iommu@lists.linux.dev>; Tue,  1 Aug 2023 18:39:25 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-57320c10635so69966057b3.3
        for <iommu@lists.linux.dev>; Tue, 01 Aug 2023 11:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690915165; x=1691519965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zsOLF65GCnXc9xKNLgceJ3I7vQXpvGjuscvCrSUFmw0=;
        b=pKgQ2/uC42qnBLprx+7vS2a3y2hUvLPD2BSCAfIK/HA815XxMzvwVLCUBLA8Z7GBJi
         ASkRbSeBgPmgf2sUvyuuU06PgxE8knjeiZdLlypE5R4Ha+NPlqmOnME7Plh/HQaC4oqU
         zQcfenIIFKDotN+bJIy5WRWm2Sm45HjEn0OpXjj+lsDK+yUSkUVgyI8FGuKIY/JTXyHx
         Bg1xSylmDeVAdsvbLIWvaEvM5Au2RPA/9WvUOzOLtIvHx7sWfydM3cwE1xQ4LPxuQE6+
         c7WuctYphT1un5e90dtOsL3Nfpry0yyCp4F1HIlnmX44mz+jaLzwTxgMGsgzZ4EtYx7p
         pBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915165; x=1691519965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zsOLF65GCnXc9xKNLgceJ3I7vQXpvGjuscvCrSUFmw0=;
        b=QNBMby8JyRUzrX8v1kDVyDs3uygtPPc3BOwVwhc29YUtfQxtehwNAJAb0VmmWlNVNg
         yOFjzYZQbcQlBc+dZGEZ8MvZj3Cgx8fMCIiU/gxVINrYw+CyNfIoSCrJ4UBJdF2gcSdl
         qLejYSMz8qg+06ti5dYyQ0eNpn+uwiC+iGWcah7IvSCjldzhMgfycwkUAT7XlDsspJVw
         PvL3oGUSK3Cptm5l0Sc8WpEumKZzVOyMhTWxV21Kq1rBOJX0zllGFTzOjYtHJc2i//YA
         JmAdZny4FEUKcse6iZ0gyxnd6RxqXq+caxN7Yk/bWHUvmW9AaMQHhFjg+BYFwsWzq/Jv
         TQLQ==
X-Gm-Message-State: ABy/qLa4cBAh3t3II0URerM7oOPSmEfi29wo/44L9yhmSr3lxS9yUXBR
	a49UirZDjcJV5FUcMKGrCF/nk21tX8Mphcqw4oXeW4zZ9CyO4a5WAie0TaSzQqRxbJSQpzAp43A
	A3d8YdXB4PrjY5podw+MNJ7DzSto+9MxOls8E7xtIVQrRgDnkp3SL6e5752nw37Y=
X-Google-Smtp-Source: APBJJlFC5DrFlCuMVG6r3RiWa+1GW1f0S3XPuNPTV23mWgKkgY/ZZvlGX5pSPQKSNgSnocZ0RmLFDH5A2Uve
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a54:d53d:50e4:b5b8])
 (user=mshavit job=sendgmr) by 2002:a25:c712:0:b0:d0c:1f08:5fef with SMTP id
 w18-20020a25c712000000b00d0c1f085fefmr82652ybe.12.1690915164624; Tue, 01 Aug
 2023 11:39:24 -0700 (PDT)
Date: Wed,  2 Aug 2023 02:35:24 +0800
In-Reply-To: <20230801183845.4026101-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230801183845.4026101-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230802023524.v3.7.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
Subject: [PATCH v3 7/8] iommu/arm-smmu-v3: Skip cd sync if CD table isn't active
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, jean-philippe@linaro.org, 
	jgg@nvidia.com, nicolinc@nvidia.com, Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"

This commit explicitly keeps track of whether a CD table is installed in
an STE so that arm_smmu_sync_cd can skip the sync when unnecessary. This
was previously achieved through the domain->devices list, but we are
moving to a model where arm_smmu_sync_cd directly operates on a master
and the master's CD table instead of a domain.

Signed-off-by: Michael Shavit <mshavit@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---

Changes in v3:
- Flip the cd_table.installed bit back off when table is detached
- re-order the commit later in the series since flipping the installed
  bit to off isn't obvious when the cd_table is still shared by multiple
  masters.

Changes in v2:
- Store field as a bit instead of a bool. Fix comment about STE being
  live before the sync in write_ctx_desc().

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 +++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b05963cd4e5b5..94922d4ff7be0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -985,6 +985,9 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 		},
 	};
 
+	if (!master->cd_table.installed)
+		return;
+
 	cmds.num = 0;
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.cfgi.sid = master->streams[i].id;
@@ -1091,7 +1094,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 		cdptr[3] = cpu_to_le64(cd->mair);
 
 		/*
-		 * STE is live, and the SMMU might read dwords of this CD in any
+		 * STE may be live, and the SMMU might read dwords of this CD in any
 		 * order. Ensure that it observes valid values before reading
 		 * V=1.
 		 */
@@ -1360,6 +1363,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 				  cd_table->l1_desc ?
 					  STRTAB_STE_0_S1FMT_64K_L2 :
 					  STRTAB_STE_0_S1FMT_LINEAR);
+		cd_table->installed = true;
+	} else {
+		master->cd_table.installed = false;
 	}
 
 	if (s2_cfg) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index f2acfcc1af925..0ee3dc7291a15 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -599,6 +599,8 @@ struct arm_smmu_ctx_desc_cfg {
 	u8				max_cds_bits;
 	/* Whether CD entries in this table have the stall bit set. */
 	u8				stall_enabled:1;
+	/* Whether this CD table is installed in any STE */
+	u8				installed:1;
 };
 
 struct arm_smmu_s2_cfg {
-- 
2.41.0.585.gd2178a4bd4-goog

