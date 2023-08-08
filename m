Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B60213FEE
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 17:15:33 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d43cca6499cso3832496276.2
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 10:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691514932; x=1692119732;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlBD+7PvoDhg41jrKYyWEK7ci2zLxvyOU6AJgUoKm4s=;
        b=TW3Soan/UyVtkLj9e3V9TL2NG58JntRmwZpTDHKv4J0UIWtkuXX8+30rVtgte8dZcL
         ved2RpyB9O2fIul744OJ1qVY8UdXNCrH3I/4Mym81B+yuP3trruh6EveFEeonMrHFykG
         RUO9gPYZUfwloT6QWn3Mbe7xgHhqRtCGiPV1j/c9iR+IyOSKfVU2IAus8J/kXrqBTx+t
         u/E1oyf1KPdvV31T+JDzOkK+IF5htyYXed6nJfNTIQEAwtboiLOTx+rgwuUuz/BeyNE/
         nCbLIkQL9jCq1ASoWVThVygeC96QTgEqRKIT5+2QViJO4GbMi0fo5tn2S7weNkNRbIOl
         20/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514932; x=1692119732;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlBD+7PvoDhg41jrKYyWEK7ci2zLxvyOU6AJgUoKm4s=;
        b=A8Vm4Qjwm4epfwQM/h6krgjnRDd7lBHI2kryLARnZx51dWak4hleb5sUe6e4YIpl+V
         PlKRk00FafMHxbVekS3JAxn/fsEKbddVrnLsdTvtPeuPJ7WVywR9BR8ERZ4UayRbjGve
         jKrIgzWV+NWaDUendsgpKmfE4ZwoZI+AaTTWL06z5OT9l33CnL39TNndUpl0AI3jYJ3O
         ILkiyTeAnW1GSyqgYflroUgt8bNwaersvbGpjeKB2USlI95y8JCiTP8aZcuM72w33MjG
         YxBWYw31IwG3O43d/tB5Es6XKPObOGQAuB/+Y5I6wTu1dBkkwdXh2JUUJ7IcdO4Wgg+s
         izWQ==
X-Gm-Message-State: AOJu0YyojF6yLVnbJNfAyywxx8qxNCRXWp0Hx639lP5QOqYVCQGo2CdK
	z3HF4BiJH6Lf4ACV8Dw+pwOhva6/yWd2NEQbIAmG9cAG0vKS8IQ3Hucz1lZkald06qbOKT0X1IR
	MNjB2a80nIgvgWycowCC5Y/a2rhJqdVL1NLfzY42oWpBJOMJf1PfdnyPAuFP06yI=
X-Google-Smtp-Source: AGHT+IFAXu3FH/zEWQzNGj/ih1neSthyomibWGyX08Oyjek2n/+brnMg9867DZUVuzOMgGo9SDKtkkw74MiE
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:986a:71d7:3b1e:ac1d])
 (user=mshavit job=sendgmr) by 2002:a25:d24d:0:b0:d4d:564d:8fbf with SMTP id
 j74-20020a25d24d000000b00d4d564d8fbfmr3401ybg.13.1691514932248; Tue, 08 Aug
 2023 10:15:32 -0700 (PDT)
Date: Wed,  9 Aug 2023 01:12:04 +0800
In-Reply-To: <20230808171446.2187795-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230809011204.v5.8.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
Subject: [PATCH v5 8/9] iommu/arm-smmu-v3: Skip cd sync if CD table isn't active
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com, jgg@nvidia.com, 
	jean-philippe@linaro.org, Michael Shavit <mshavit@google.com>
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

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f5ad386cc8760..488d12dd2d4aa 100644
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
@@ -1333,6 +1336,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		 */
 		if (smmu)
 			arm_smmu_sync_ste_for_sid(smmu, sid);
+		master->cd_table.installed = false;
 		return;
 	}
 
@@ -1360,6 +1364,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 				  cd_table->l1_desc ?
 					  STRTAB_STE_0_S1FMT_64K_L2 :
 					  STRTAB_STE_0_S1FMT_LINEAR);
+		cd_table->installed = true;
+	} else {
+		master->cd_table.installed = false;
 	}
 
 	if (s2_cfg) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1f3b370257779..e76452e735a04 100644
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
2.41.0.640.ga95def55d0-goog

