Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ACEDF60
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 13:20:14 +0000 (UTC)
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-d1c693a29a0so7552556276.1
        for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 06:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692192014; x=1692796814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wahm0+n9syTK68V4+8/kXjO64+N5fjxBx7U2bn3Amxs=;
        b=PqLkE7UT1HlDZ+3DKZZvAjvVcYwJoUWCKt+e8XkSIOYnaKnpD/+vHKkgECS3qeiQY+
         Dqfua7nMmzEaaFdqWFup7V7pbKaqxMyubH1Mq9u86pgZMGLvUskAFWNEJA1itoDWY2vN
         +a7D1N0aC7ZrrOg87UGm9WMXgus6xAuKssroNhTYXo/SEsFx+KIQ+BpRxsfNp/ktsS4M
         4zDTy9GuM3T22ndktkkt88ab6jwxdpE1x41bn/4BrB0c7Qex3H4hdeZSIdpxNSiIs7VM
         5pvmZihvnYKZfUlw98iozYPiXV+HSMwU+fpc+AhvxY1do/nnbpxbmJbmmIpQzMIKy/pg
         mbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692192014; x=1692796814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wahm0+n9syTK68V4+8/kXjO64+N5fjxBx7U2bn3Amxs=;
        b=aOqGgWKaBfe1JypErYgPWUF+E6FnmJ3QSJLBD6yRHV5dequ6TCrVwqi2MPeur56Tyc
         5j56EUXQWNB5oZuzMUUVKYW4DNllgcJyaRCU+si2c10MAYGN4bTeswAAbPqIdlxytbuI
         3Y4Zx2PkpoNJyW/nnY9/veurVuTcYpW+h5ZUjB2O+VX8Pxo+D1Sa2ZxBG1MzEwEjt/17
         ynTRtHkpuKy3kKqWACCyhzM0taX1NpsAIsI6Wad+UDyIGFbg1DCyOG7amjxeARNYB+pB
         McpTm+fIqf/ecNpYmtP/KSEAei4mPlMZirfV8rVexCREDSWhoZH34Z+YO9NZfopp1572
         rY8A==
X-Gm-Message-State: AOJu0YysCfOlb05YjIHAbS7MwIZrcN5bz11stBaixlf2qyZO73XMWg5p
	oqLFL0wcnw5q4eOGVF3TsyGL54U9jproRMzyVV0dcofMIrxGGtn4zGKKjco1l+vLf9jX1nYfMsk
	57L2b7v+TwWOhGlqPI2VU2nm1kHr4WFZeQBKkrCVOrq4XTd8iF7404UEJB2CwsvE=
X-Google-Smtp-Source: AGHT+IGfrAEWxCBxWzZSyOwYafJU+OJBdmpgGQY9CJWSDxC54cz937JgjBYjmMiDVRGJsEgo8GrKs2p0hY4Z
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:ae98:2006:2abd:3434])
 (user=mshavit job=sendgmr) by 2002:a25:df07:0:b0:c78:c530:6345 with SMTP id
 w7-20020a25df07000000b00c78c5306345mr25973ybg.7.1692192013420; Wed, 16 Aug
 2023 06:20:13 -0700 (PDT)
Date: Wed, 16 Aug 2023 21:18:49 +0800
In-Reply-To: <20230816131925.2521220-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230816131925.2521220-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816211849.v6.9.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
Subject: [PATCH v6 09/10] iommu/arm-smmu-v3: Skip cd sync if CD table isn't active
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

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>
---
Happy to drop this commit if we don't think it's useful.

(no changes since v5)

Changes in v5:
- Fix an issue where cd_table.installed wasn't correctly updated.

Changes in v3:
- Flip the cd_table.installed bit back off when table is detached
- re-order the commit later in the series since flipping the installed
  bit to off isn't obvious when the cd_table is still shared by multiple
  masters.

Changes in v2:
- Store field as a bit instead of a bool. Fix comment about STE being
  live before the sync in write_ctx_desc().

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 +++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3c8bfeca89d5c..104b8d6ea5972 100644
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
@@ -1335,6 +1338,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		 */
 		if (smmu)
 			arm_smmu_sync_ste_for_sid(smmu, sid);
+		master->cd_table.installed = false;
 		return;
 	}
 
@@ -1358,6 +1362,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
 			FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax) |
 			FIELD_PREP(STRTAB_STE_0_S1FMT, cd_table->s1fmt);
+		cd_table->installed = true;
+	} else {
+		master->cd_table.installed = false;
 	}
 
 	if (s2_cfg) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 2f4b832e0deb4..b7a91c8e9b523 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -600,6 +600,8 @@ struct arm_smmu_ctx_desc_cfg {
 	u8				s1cdmax;
 	/* Whether CD entries in this table have the stall bit set. */
 	u8				stall_enabled:1;
+	/* Whether this CD table is installed in any STE */
+	u8				installed:1;
 };
 
 struct arm_smmu_s2_cfg {
-- 
2.41.0.694.ge786442a9b-goog

