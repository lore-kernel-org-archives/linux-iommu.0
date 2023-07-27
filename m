Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8872714D
	for <iommu@lists.linux.dev>; Thu, 27 Jul 2023 18:28:37 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d074da73c3eso1195228276.3
        for <iommu@lists.linux.dev>; Thu, 27 Jul 2023 11:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690482517; x=1691087317;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vgzcf7eJvMa0L22mwJ8xGuOSunsjGTMhpYNWJ+CiplE=;
        b=dZD6K0I5bipVs1gzuK1uObkaYaQyLdEMIZkDJ/j0WkSri5z/IPpDAIsfReU9E79XIf
         JvZF4nl48p7V63uxbMtHsxNesgZ/EVn5Gb3eXzI2Y0koDraKU0XbvzwjDMVkDZEiJxsd
         eP94cTL72rATgqT3uHFszDeTE4cSEl4jVJ+p5hryzT6An78Q+FevMU0YqIYnNEm7OsXf
         HhtHdFQsp+JSUJMwHpG23pvePH5QKg+3sk/FKabcuMA0aCFYQcTZJjrCzGDCQGrIFbaW
         pZrHD+9537u2zz/YW+ARTZgmMoT0yGDt5RdY0yRpVIeR9lcXxZx2IXmuAO1uftLU7/sQ
         B1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690482517; x=1691087317;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vgzcf7eJvMa0L22mwJ8xGuOSunsjGTMhpYNWJ+CiplE=;
        b=gYYuWj0VVXZNirS8RPdjRGGeEBl+kh3Fp4/hnntqOKfyplWAlLGsDUBc/KTYVzvIPz
         tmylcLsD4TIZa5TJyCfXMsXd4iNze+6uuGFdDF6GjnblAR/Imh0WdVbT1VBbqRNAge12
         C+/INT/qPHgKl9J2KHmdSprmkIg/Y7gZiHky4MX5t1u8hTjpTPGZ3zBzcTjGPQAMYZBO
         /ZQofBAwQBnzAIB4+/xyvg+ht6NfBgQDWQ3EvnEaO2uB36V1Lv+EjkzkFKIoMWss/uyF
         apzHl1qZqNlfPhTvP2fOH8eAh1llWyhQMtcnPbyoR32daFFUM5LuPgbR7Q94BAnjTNpk
         3jvQ==
X-Gm-Message-State: ABy/qLapl8JlzNvyvWIu5QDIKXzT0Ix7zKO+4LMWSkpZQ1vKbB0q/+h5
	8J90Bpqy4E7jBznJUwTsILMFe9X5SaxX
X-Google-Smtp-Source: APBJJlERZfhSdpF0IyVGRIpcLXk6aibm3Q4tCHGc1ITTizVFBO8EN2gQXnIpx5H10WTmZi/VGpUkp5kHkdIm
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:780f:26da:d952:3463])
 (user=mshavit job=sendgmr) by 2002:a25:4183:0:b0:d0d:4910:cf0b with SMTP id
 o125-20020a254183000000b00d0d4910cf0bmr1741yba.10.1690482517038; Thu, 27 Jul
 2023 11:28:37 -0700 (PDT)
Date: Fri, 28 Jul 2023 02:26:21 +0800
In-Reply-To: <20230727182647.4106140-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230727182647.4106140-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230727182647.4106140-6-mshavit@google.com>
Subject: [PATCH v1 5/7] iommu/arm-smmu-v3: Skip cd sync if CD table isn't active
From: Michael Shavit <mshavit@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This commit explicitly keeps track of whether a CD table is installed in
an STE so that arm_smmu_sync_cd can skip the sync when unnecessary. This
was previously achieved through the domain->devices list, but we are
moving to a model where arm_smmu_sync_cd directly operates on a master
and the master's CD table instead of a domain.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 654acf6002bf3..af7949b62327b 100644
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
@@ -1368,6 +1371,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 				  cd_table->l1_desc ?
 					  STRTAB_STE_0_S1FMT_64K_L2 :
 					  STRTAB_STE_0_S1FMT_LINEAR);
+		cd_table->installed = true;
 	}
 
 	if (s2_cfg) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 0e55ca0d40e6b..f301efe90b599 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -599,6 +599,8 @@ struct arm_smmu_ctx_desc_cfg {
 	u8				max_cds_bits;
 	/* Whether CD entries in this table have the stall bit set. */
 	bool				stall_enabled;
+	/* Whether this CD table is installed in any STE */
+	bool                            installed;
 };
 
 struct arm_smmu_s2_cfg {
-- 
2.41.0.585.gd2178a4bd4-goog

