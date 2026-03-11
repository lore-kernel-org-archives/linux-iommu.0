Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9763C456E
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222296; cv=none; b=vBiR+Kc0WPmyj9bpFUhXSf3xFMfGO1L2DZ9QUSZjtB+J9+EPMgABvpSmRb1EPDtlcSxGFhSm3FoFudhTP/N3AMUAot7k/Xk/deJgTF6//muJaUbjifWAx9Gar85IOxLH97bsezW9ZOh6nL4mkHROBFyCs0NoCdYwqJ889/bjLjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222296; c=relaxed/simple;
	bh=uZIIQWrBQh0Ufkc71718w0sPMA3sRk0ktWBS835Dx/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CqzqxdnG8E1xS99lOjqrMaJx1rGyI2n5Bik7qNTAB9LqVfuMUQyq94cuG4PffyyNS5f9/u576l6Q3rQhEsgJ6S9BLefQWYw6OI6nQxfYQrhSdjfJt+3GjI+YL0aOKFU0Y23GPqi+bIHsOO18ks17vUpNLuzzINtyoieqm9pBfSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmPjCDId; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmPjCDId"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so152942795ad.2
        for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 02:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773222294; x=1773827094; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ttxazta4+9VArSIS1TYkCKSJ97bHw7VqLjcIgzTZGIg=;
        b=YmPjCDId/ng/OLdNLFjNp9Topai0kn9FavoPuZbzy7r+DYWTAcqFgGFLXSPK+hKXFP
         C5u3y/zHW+Wt90Vbm4fdzvbd+CCsWouuYw2ORsn4XffR0EM9iYVvKqE9kr0rnqwEB1m0
         7l+AAM1bf9ZuqU8eZrrj9FmtV5oir5iXnHO0DD82nlf40+UzK94zcvpXpdp6uCoSz1V4
         1LxpN0Z6npmtogmGLOjcdrk5CjXm5MsH/bbnS39DFH4yZnJl5y8lwOgwmVHQuojOQRAl
         QkmUbPYvhpkE4FT9B/03Ce0RuvhWRkLKVJNzHxukdQnLKv/8ArwsNUEvS3VLpbW/ClQK
         2ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773222294; x=1773827094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttxazta4+9VArSIS1TYkCKSJ97bHw7VqLjcIgzTZGIg=;
        b=Gz/YqLXzK2YSKj1oLr4uJd/iJgwk/X10k9mJjNSmowERW1wFN6o5G7oHt/BZf6fy1V
         G4jfT5R4olrIoDXXqWK4K1TkBwmuGzVc62V9aG+d5qwXQEinB+GG48mp9QG7VSQ4SGKG
         4MFnCVdef+Yw8dyzqXEZH2PdDiJA65psqY5T+lxPtVOApewLBHJgX9lLvwJqNMfvrrrv
         r1/MtaDEAPxjhq+7Cpj4kNbQ93sNh7hSqEZlg18Nz9ghl1FSom+JlTg6K4dLYxCZqRSZ
         j84tEZ/f955w59bGYxibHCZmH22g/yMVP2R5DJPPn+rhRxVSlw1Z2oFwv5uomOnsZONz
         HA6w==
X-Forwarded-Encrypted: i=1; AJvYcCUYgV/NtnyObxmo9CZO5msVJtUXYBKuzUu2kJ5DPCrYFJatD2HSZvKjjW+Y0pvWonwf7WraRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxAzS6+j25z80VjJl/407ulKrnT2tML36D6rGZYz7//utAWdnGe
	u1LW4MEgFN6s/mg/95XLTRjMU7BeVZeal3gpF4X+T3Q4ZXSBlAejr9Sc
X-Gm-Gg: ATEYQzwQZmfYDIq0zADIxUmS4jNMXnZautpmaW+F7+B7Q3Yn5BrF+botvGlg2t3q3dW
	JT61ra5VKkjz/vhy5NJCJbh1KkjANKeNv2PCG4D6pzv3lZVd7KHHtTtDYANsMDRIDGaNkx8g76O
	UDskEnimDsvNTOnDtY74gFIKCp6JkNc8RHyPlTMYEheMEkELF0rf8V9hnZNJ2KKJhu993DYQ9V0
	IdRBtfaBBnEk4JExxqUCHNFP1lgyf5yLpNSj6it8qC9zLxMQG/9ZsHYoeESMSnwXwgoWsCVtws1
	0yro9G1ArbfWkfyOkiVN9+KxHrp2FCYfy0cNqZPaxSj+9ZZ4YkdIr1uz9CNTp9K9ld5luj9/RCE
	kyhdhNGS+r4JhT4kMvO2geqQEdQ50t2pzaYSkqi7zwduaPMSj/8e18z3DmPihnUCVSmqOF42UGq
	aZDsptqRzb3x8Pmx1ILB3ZViPLWj6HHQ==
X-Received: by 2002:a17:902:d4c7:b0:2ae:4dce:7e99 with SMTP id d9443c01a7336-2aeae7b4ed9mr19716495ad.20.1773222294132;
        Wed, 11 Mar 2026 02:44:54 -0700 (PDT)
Received: from arm-server.. ([2001:288:7001:2724:1a31:bfff:fe58:b622])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae246751sm18109015ad.23.2026.03.11.02.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 02:44:53 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: will@kernel.org
Cc: robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	jserv@ccns.ncku.edu.tw,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH] iommu/arm-smmu-v3: Allocate cmdq_batch on the heap
Date: Wed, 11 Mar 2026 17:44:44 +0800
Message-ID: <20260311094444.3714302-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arm_smmu_cmdq_batch structure is large and was being allocated on
the stack in four call sites, causing stack frame sizes to exceed the
1024-byte limit:

- arm_smmu_atc_inv_domain: 1120 bytes
- arm_smmu_atc_inv_master: 1088 bytes
- arm_smmu_sync_cd: 1088 bytes
- __arm_smmu_tlb_inv_range: 1072 bytes

Move these allocations to the heap using kmalloc_obj() and kfree() to
eliminate the -Wframe-larger-than=1024 warnings and prevent potential
stack overflows.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 66 +++++++++++++++------
 1 file changed, 48 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4d00d796f078..734546dc6a78 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1281,7 +1281,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 			     int ssid, bool leaf)
 {
 	size_t i;
-	struct arm_smmu_cmdq_batch cmds;
+	struct arm_smmu_cmdq_batch *cmds;
 	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_cmdq_ent cmd = {
 		.opcode	= CMDQ_OP_CFGI_CD,
@@ -1291,13 +1291,23 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 		},
 	};
 
-	arm_smmu_cmdq_batch_init(smmu, &cmds, &cmd);
+	cmds = kmalloc_obj(*cmds);
+	if (!cmds) {
+		struct arm_smmu_cmdq_ent cmd_all = { .opcode = CMDQ_OP_CFGI_ALL };
+
+		WARN_ONCE(1, "arm-smmu-v3: failed to allocate cmdq_batch, falling back to full CD invalidation\n");
+		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd_all);
+		return;
+	}
+
+	arm_smmu_cmdq_batch_init(smmu, cmds, &cmd);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.cfgi.sid = master->streams[i].id;
-		arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
+		arm_smmu_cmdq_batch_add(smmu, cmds, &cmd);
 	}
 
-	arm_smmu_cmdq_batch_submit(smmu, &cmds);
+	arm_smmu_cmdq_batch_submit(smmu, cmds);
+	kfree(cmds);
 }
 
 static void arm_smmu_write_cd_l1_desc(struct arm_smmu_cdtab_l1 *dst,
@@ -2225,31 +2235,37 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
 static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 				   ioasid_t ssid)
 {
-	int i;
+	int i, ret;
 	struct arm_smmu_cmdq_ent cmd;
-	struct arm_smmu_cmdq_batch cmds;
+	struct arm_smmu_cmdq_batch *cmds;
 
 	arm_smmu_atc_inv_to_cmd(ssid, 0, 0, &cmd);
 
-	arm_smmu_cmdq_batch_init(master->smmu, &cmds, &cmd);
+	cmds = kmalloc_obj(*cmds);
+	if (!cmds)
+		return -ENOMEM;
+
+	arm_smmu_cmdq_batch_init(master->smmu, cmds, &cmd);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.atc.sid = master->streams[i].id;
-		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
+		arm_smmu_cmdq_batch_add(master->smmu, cmds, &cmd);
 	}
 
-	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
+	ret = arm_smmu_cmdq_batch_submit(master->smmu, cmds);
+	kfree(cmds);
+	return ret;
 }
 
 int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 			    unsigned long iova, size_t size)
 {
 	struct arm_smmu_master_domain *master_domain;
-	int i;
+	int i, ret;
 	unsigned long flags;
 	struct arm_smmu_cmdq_ent cmd = {
 		.opcode = CMDQ_OP_ATC_INV,
 	};
-	struct arm_smmu_cmdq_batch cmds;
+	struct arm_smmu_cmdq_batch *cmds;
 
 	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
 		return 0;
@@ -2271,7 +2287,11 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 	if (!atomic_read(&smmu_domain->nr_ats_masters))
 		return 0;
 
-	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds, &cmd);
+	cmds = kmalloc_obj(*cmds);
+	if (!cmds)
+		return -ENOMEM;
+
+	arm_smmu_cmdq_batch_init(smmu_domain->smmu, cmds, &cmd);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master_domain, &smmu_domain->devices,
@@ -2294,12 +2314,14 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 
 		for (i = 0; i < master->num_streams; i++) {
 			cmd.atc.sid = master->streams[i].id;
-			arm_smmu_cmdq_batch_add(smmu_domain->smmu, &cmds, &cmd);
+			arm_smmu_cmdq_batch_add(smmu_domain->smmu, cmds, &cmd);
 		}
 	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
+	ret = arm_smmu_cmdq_batch_submit(smmu_domain->smmu, cmds);
+	kfree(cmds);
+	return ret;
 }
 
 /* IO_PGTABLE API */
@@ -2334,7 +2356,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	unsigned long end = iova + size, num_pages = 0, tg = 0;
 	size_t inv_range = granule;
-	struct arm_smmu_cmdq_batch cmds;
+	struct arm_smmu_cmdq_batch *cmds;
 
 	if (!size)
 		return;
@@ -2362,7 +2384,14 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 			num_pages++;
 	}
 
-	arm_smmu_cmdq_batch_init(smmu, &cmds, cmd);
+	cmds = kmalloc_obj(*cmds);
+	if (!cmds) {
+		WARN_ONCE(1, "arm-smmu-v3: failed to allocate cmdq_batch, falling back to full TLB invalidation\n");
+		arm_smmu_tlb_inv_context(smmu_domain);
+		return;
+	}
+
+	arm_smmu_cmdq_batch_init(smmu, cmds, cmd);
 
 	while (iova < end) {
 		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
@@ -2391,10 +2420,11 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 		}
 
 		cmd->tlbi.addr = iova;
-		arm_smmu_cmdq_batch_add(smmu, &cmds, cmd);
+		arm_smmu_cmdq_batch_add(smmu, cmds, cmd);
 		iova += inv_range;
 	}
-	arm_smmu_cmdq_batch_submit(smmu, &cmds);
+	arm_smmu_cmdq_batch_submit(smmu, cmds);
+	kfree(cmds);
 }
 
 static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
-- 
2.48.1

