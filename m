Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDE58476
	for <iommu@lists.linux.dev>; Wed,  2 Aug 2023 16:34:08 +0000 (UTC)
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-d052f58b7deso7105121276.2
        for <iommu@lists.linux.dev>; Wed, 02 Aug 2023 09:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690994047; x=1691598847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yNDoyQCVv3of8CbzD7UrBZ/J064WuiNsrQAu+4gPoJw=;
        b=COmmzr/ZrzYU67GXsaAkeCXcFTbuJ4N8bt6e/ulY4MJB1st5jFNkRFhT/96mRMHlz+
         nDJ0CKW6+HGNxd2G2NDaa+3+cbydrawx8InWmB8xrO4E/yMJBV42TKmhqE/Ydulfwzbc
         5f7EkEk6lU0H1/tArBx2LsVPEdl45hoKc0tDzDQTGPcORkHWZw3ESp1OUVk4MGPkpZ17
         xuz4LlVY+3IgMv9G21YFJ66iibwnU+0jp2Le7P3y3olqcOEoYLoh/sWwhQ/C5wY0w5wu
         reRZS2ocDr1HijC+xabhRJy5L71w9aKwcLgE52nPKM9ig6A8G87EtLRFx5j9s10DvhTM
         OdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690994047; x=1691598847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yNDoyQCVv3of8CbzD7UrBZ/J064WuiNsrQAu+4gPoJw=;
        b=kVYhwbxrOt53xFiyeNpZtnEbmwhifgVI6WPbmVQYChMWnientz8/kS3Gw4qusA0+px
         1aR0hbjdsYUf0dLaG5qQhnVq88erF/b1w/dIANhVbtuSG2LT3xgv2EWvxD6nq3CpwiFD
         BdewRvfrUeB2FeTIpDpssaM2leiT5YKAk9E9ajHsLjzBrLXRnKKNk+Gh8XnPcKIRyKzE
         xQ3HYN3WF+QeLe8QVcnzYA5U0KTLm29RZUItz5eV0HmJie4fzxsC61LBf23kXImuwKq1
         D3DxAUKAbmYpl/QWKA5+/rwFwJPpan6t0oAcsrRCk4H8MR154A3GmmdeSSFjmMDNDOut
         +0gQ==
X-Gm-Message-State: ABy/qLanD2DXS0EB1ZfZlk75kUkYIKd5hJUcOwi7eiBvSzDb3HgLEYFd
	7Wy16oj/TYt0B5MNE5oc7kl+wpITcp/WVSHzN7MbjndoyVGQiaLg7lCb6JP466+mOqN6oTpT6w7
	8p7i0vr7V9xQ56E4MMV9o8znRCdQGC20YIIW47nsHSYq+C+1DBoHtIq7ldo2MPQ4=
X-Google-Smtp-Source: APBJJlEsy+/m4IjjcjYGAp6bgcwwwvW6CNiqjOP+V/RjmxBEbdQ/ZzssDS1E1hx9GXz5q6Yk4d1bzfTzej4b
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:39d1:8774:b733:6210])
 (user=mshavit job=sendgmr) by 2002:a05:6902:160e:b0:d09:6ba9:69ec with SMTP
 id bw14-20020a056902160e00b00d096ba969ecmr129159ybb.4.1690994047546; Wed, 02
 Aug 2023 09:34:07 -0700 (PDT)
Date: Thu,  3 Aug 2023 00:32:35 +0800
In-Reply-To: <20230802163328.2623773-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230802163328.2623773-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803003234.v4.7.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
Subject: [PATCH v4 7/8] iommu/arm-smmu-v3: Skip cd sync if CD table isn't active
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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---

(no changes since v3)

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
index e2c33024ad85..00b602ae9636 100644
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
index 1f3b37025777..e76452e735a0 100644
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

