Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE4911CBD
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 10:49:05 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-584139b6b03so51160307b3.3
        for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 03:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690800545; x=1691405345;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TOLHkJaT+7H0fEwKCF1U6y0LUywm6xuO1oN6Y683ukY=;
        b=2yAiAhgTb2qyYsOoqtArsgCnaCd5Uv8mxLc4ijVXgwcIOa2YTzlRellLxA4j1Dw7YC
         LRez3OszdSE0zYnQJArYpPmIPSLMZxWITTSfSqHhJkF7b2uY6gyzoBYD0OB68HRD8k1C
         pMKQIrUbO3lu1nSfsEETkVruPcDHiD+iDQTJADMDyhAiir3EmdxkW2jEbO6olzC8+hh8
         4hWSFRz42BJ2t+HQgjtmHg1CMI1F1XFVwptKZtUOUV6VGFX2EapsVP/YokimQ7H2r13N
         wydubh5namDyrcte9BszqUla6fqlIEHAXqpXq6rcLujJUXiM11oc4M7aj6BI5vX7MSI4
         HD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690800545; x=1691405345;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TOLHkJaT+7H0fEwKCF1U6y0LUywm6xuO1oN6Y683ukY=;
        b=Zbh2whJ/SM7HXw5/1f+uEqO/arr1VQ4Rp3fB/ajBPKR1ItJuNgxoB45M/aLEhtlhDC
         Q6oWcWBOSCB0/Wjlh9zf9Sua2B6Hdn//bmkWLSkkn7PnizRNItOpU96qffPwEw9oDQDA
         OXUfkUVry7Nq5mtsG6Nb6e2nqwvcfI3gAXZ3P9x/gSn0To8Ec5Oa7XybLNKxGVs2fbS6
         pvoBWmdxtMdB8znEiImn6FVc87Ook0/Q9uNLobzjzLImYPOg+S+DcQS8dBmMR1FU1qPP
         u6HPhe1cvLyJy6D5K4VS9yNxCo14xbKEDEn5fSxaGHGARTVLAk+CCTHWywkfYAq7owGl
         COdA==
X-Gm-Message-State: ABy/qLa1U1okdmR2DXsT2UX66stLjr+CyURJMAWvg1ADvVR4YcyQD0u8
	fqz8dAUt5OwXpQBFjyM8MtN9v/4bNX8+mtbT6bAHa5AloxW+5Wly5uaYmx8J47u9GwKcGcn5z+b
	MSlo8bgLYjQuwCuicctzXrmKrdUG4jUeNHT7yG+1E0OGXjGAh37ZWmN0oAK2gNXE=
X-Google-Smtp-Source: APBJJlF6qpQSFj22+rJwXVfNU7jT8nG/y2QM0YsXib8x2omrgoE9ga/5alIh5ruNgPiD4/m0AgMZfZ9hXHhN
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:affc:ad1d:5cbb:3c6a])
 (user=mshavit job=sendgmr) by 2002:a81:ec0f:0:b0:576:6e4e:b87f with SMTP id
 j15-20020a81ec0f000000b005766e4eb87fmr72197ywm.10.1690800544479; Mon, 31 Jul
 2023 03:49:04 -0700 (PDT)
Date: Mon, 31 Jul 2023 18:48:15 +0800
In-Reply-To: <20230731104833.800114-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230731104833.800114-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230731184817.v2.5.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
Subject: [PATCH v2 5/8] iommu/arm-smmu-v3: Skip cd sync if CD table isn't active
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

Signed-off-by: Michael Shavit <mshavit@google.com>
---

Changes in v2:
- Store field as a bit instead of a bool. Fix comment about STE being
  live before the sync in write_ctx_desc().

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 +++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 654acf6002bf3..4f7fe19d88fda 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -987,6 +987,9 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 		},
 	};
 
+	if (!smmu_domain->cd_table.installed)
+		return;
+
 	cmds.num = 0;
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
@@ -1098,7 +1101,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 		cdptr[3] = cpu_to_le64(cd->mair);
 
 		/*
-		 * STE is live, and the SMMU might read dwords of this CD in any
+		 * STE may be live, and the SMMU might read dwords of this CD in any
 		 * order. Ensure that it observes valid values before reading
 		 * V=1.
 		 */
@@ -1368,6 +1371,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 				  cd_table->l1_desc ?
 					  STRTAB_STE_0_S1FMT_64K_L2 :
 					  STRTAB_STE_0_S1FMT_LINEAR);
+		cd_table->installed = true;
 	}
 
 	if (s2_cfg) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 05b1f0ee60808..3a56987a5fd0b 100644
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

