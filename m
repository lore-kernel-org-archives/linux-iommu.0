Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44835345CCA
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 05:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783056728; cv=fail; b=eXgOCX0Db3hmi9b4z+hJqH2BQcWo3QuOMB0tZzXXXN/Ayyw0ZfCGFwwtqd7i6+nKMdt48v/l6IPPqXNnUJPZ8SPpchS3MMUl1bq3DOmJxdM1ngAthnpROzU4BYXmCe1muD3r/grlqs3QeOBWabTs98PvMC4+X2O6GFftAZJ9X34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783056728; c=relaxed/simple;
	bh=dJkSFZuPyOCn2YqRnFknznUCjwRCLWqsZgJIXAcfyew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mReM1Zs9lWjI9n19K2xDLDrHzC7PL00P4+eF05B8SmgwUeH4BFTTED9tCygXh7Unr1mOz51Co2RffjtAw3PPqCsipCpNIbF80omz/ftkpCIn/kZbxg3pI35pptEAj5AE3diqHeQ3V72jXuCdhrtjwaZyMCy066c1lPsj08l/5kI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GHqz8Lwu; arc=fail smtp.client-ip=52.101.56.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GHqz8Lwu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/1MRzsVZpi/8dv+1rz0EVdrwnULZt5YcbYP8rbGm2ArB44nlnvkQdeXAy52Ovm/yqMnkyztWe2MUwmIKxA5NMRBqAPOVvvT+Klp4d+H7Eary79hK0Q/Dv50x3MAkwGOPFlxmLmvvTlm4D2farZrRLiRYqkx16psyu0MnlKAX9KNHq5hpYF/LWBBQXbIv8CIh4agmy51a77rApTRk3vgBpGQRZWiCQ0LoYuklrH4Ra9h338aibObiRh1OsziUFvXMf4xRb/MiLoaA/GaWTXOxrACFOrjfJp2g/arB7RestNoEZbEiSapvXCXjtQIOHVzv7xvKMA154fR1pg8TLEBMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9gAHke43E9NARCgwLis/EWSuaL8oNtcCDvUCs3PF3E=;
 b=h0jLVtnHZThDXgQLyaLcbXLO7WzJ/AAXHHU6xcghA73kyzm3RgwVcWekrN/4r+nBUSnoDci2rUz4ZIHbhH2s7XDrbEB9l5rwEIdi7aDTyn00lkloXUU7/qBnRZVRGvdNEch/GK/ouJamaUW7PH+dQeHlzHCVOjSTiH5x56JMmRuqvv9MRkcx3BWV7r244KDB/SpxSQorH2jDOdb8QgdYEb8clsyP+9TXofWFqBocgWls7XTsSkrHghh0XovLjSkVvVkX7VIJd13Y7VES2bzReWdhunuFpp/CaeMy0R6BgNz5dQMUQQJK0UXGQSib1GImMkhZTFuBPMBt/WNp7SuPnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9gAHke43E9NARCgwLis/EWSuaL8oNtcCDvUCs3PF3E=;
 b=GHqz8LwusBpXu3QlS4FMytmLEGEL21M+tPv2cMSPipaiwJuPh9LmLpc7t3zDJyx7xjkphGSOO5DNR8StcCHVmrL25BJOBugDLoGrjTkEymGZ11q6i6qQn/mtgzRiCzkjB98gew4avsmdiPmq/35DPg+2T9AGMkpjIqSuXTuJhDXAczkp6EWVP2NRIJgme9mv0oJJNJM69bkmygcdhmkpNc08Vxmez6XxhBAABo4HGPF1iKg+8ORpwme12VEbRxy/RQRbUvZIbZFbKlWUYf9Bci11MguqU4cgyoV3RuF6S+zYtRT5tezqfGio/yIPKrFTF3sEyiFrlFWXWwUfc/Bbvw==
Received: from SJ0PR13CA0060.namprd13.prod.outlook.com (2603:10b6:a03:2c2::35)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 05:31:57 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::34) by SJ0PR13CA0060.outlook.office365.com
 (2603:10b6:a03:2c2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.3 via Frontend Transport; Fri, 3
 Jul 2026 05:31:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 05:31:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 22:31:44 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 22:31:44 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 22:31:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 02/11] iommu/tegra241-cmdqv: Synchronize the error ISR against VINTF (de)init
Date: Thu, 2 Jul 2026 22:31:28 -0700
Message-ID: <0ed2144a80a3750ee6638336b575b5b968949be6.1783054570.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783054570.git.nicolinc@nvidia.com>
References: <cover.1783054570.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b5c4412-d252-466b-d08a-08ded8c4661f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|11063799006|5023799004|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	TZ2NbSXFg0CQ1EopYs6JMO5HBcqtI5I4QiNmb0gqhKQTxwoHiXO1/zw/ltYG1bf6bdiH0cudC8iaiBmOTW6swyT2RjjM/PjoGKu7Q8C/sah6qV0ZR2ZOs75zYRYXrg3gGcpclB1DMQ6YynVgyCPXnIZqkKrRRu7C4FXCPxbOSJSVEcurVYLS4naHIlnmfFteTZNTGSvLK3L/dcavmYl13gTSjuzjwpwCuaVHn01dvP0n3jzhTndObiRafWlbP90JGaGAZKCQMqvvPYHkCSUwmoPvtCJPnE9Wyq0hxfMxy3gKMUuEntkUnghbkatDUU77Nuph7M2XKQFn519IHeQuTlgKMweL2sitwoARl1b5tCEjOXYNTjOSsRPTdr9VgTZmtJBS5MHZIIGIflLIuWRDDFK2c/+Q6fA//tdNHum6/jySrt0j+Fp8PrJhSeFypyeHEQvnRSJMvXtUT9iUO5pnVBqrQCl99wp3JmOlppHKvlT287fgW1nhYSnnS2StDf5ltsmCtQBEZcT4sOZhUr1RyjgKSFdCKqgICkBLLuNFpH721JvmDpB3s5OgSVKpt0M4aXZ7anWO6pwmZeVHMa6lnv3GwDnYRb8y8/y7B8corTPennr52QME1algydaX200WiEuDTabpkmOwWwey7W63650+HZ93KZSZ2bbXhtd+MzMBVjsPqxFFqP+gvNjmh4HW/M/jbldNpN+zEZxFl9XnPg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/i5tA/BZgb39qlqAEHio6PRAMf+aaHPfLtEUrBtZEFKjq8Vfvw/6QNBDjvGqpMPBtHj4h7PbS46b0cQUj8IhyQUeK3SGlV7DzyqsGaEyr6e6Jt5fL3gXVYuyH6V/5RWIZbdZo9fKT09sQveH/cdzu27UVNyrqFMnxDUOE03WL78nALtw+lL9nCbW+KqYPg82u8NePGUabwvY6zCH0dQJzzn7q6pOnVd57ctTLb1MhlJp2IXO/K1kg8TFLPp3IqHUjd5+o50O+nNE4zt6oTIrzHUL1DRSZ+OXGLyaBQOpCKcRMKCGRiWrvTXuJu4BEq4ipcTiTcQ2mp/4z0MlVHGOVCaO9trGdMtDv7p2biKLqFals5antXrI03CX1ICTiwUAbcvE/aQ59JHNh5UCInJ3x5D2W6pKp/ga9tZ9ItFAzgxr7XE4Wotsj7zj4Y70Tdhe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 05:31:57.1348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5c4412-d252-466b-d08a-08ded8c4661f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932

A user VINTF is torn down by tegra241_cmdqv_deinit_vintf(), which runs from
the destroy callback and from the init-failure unwind in the alloc handler.
It clears the cmdqv->vintfs[] slot and lets the iommufd core free it, but
nothing serializes that against the error interrupt: tegra241_cmdqv_isr()
reads cmdqv->vintfs[idx] and dereferences the vintf. A concurrent error can
make the ISR read a slot mid-clear (a NULL deref) or use a vintf which is
about to be freed (a use-after-free).

deinit_vintf() also returns idx to the IDA before clearing the slot, so a
concurrent create that reuses idx can publish its new vintf into the slot,
only for this teardown to erase it again with the stale NULL store.

On the other end, tegra241_cmdqv_init_vintf() publishes a new vintf with a
plain store to the cmdqv->vintfs[] slot, and the ISR dereferences fields of
a published vintf such as vintf->base. A plain store gives no ordering on a
weakly-ordered CPU, and a stale VINTF_ERR_MAP bit on a reused idx can make
the ISR pick a vintf the moment it is published, before its fields are set
or tegra241_vintf_hw_init() runs.

The cmdqv->vintfs[0] slot stays NULL until tegra241_cmdqv_init_structures()
first creates VINTF0, so the slot 0 read needs the same NULL check.

Publish every slot with an smp_store_release(), and read each slot in the
ISR with an smp_load_acquire() under a NULL check, so the ISR always sees
a fully built vintf or NULL. Also make deinit_vintf() clear the slot, and
synchronize_irq() prior to returning idx to the IDA, so no vintf is freed
under a running handler and no reused idx is clobbered.

Fixes: 4dc0d12474f9 ("iommu/tegra241-cmdqv: Add user-space use support")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 37 +++++++++++++++++--
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index f843d607c8134..5fbc1c85874a5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -335,6 +335,13 @@ static void tegra241_vintf0_handle_error(struct tegra241_vintf *vintf)
 	}
 }
 
+/*
+ * The CMDQV error interrupt is edge-triggered, so a pending VINTF error fires
+ * this ISR once and does not re-assert. An unacked guest therefore cannot
+ * storm the host. The HW latches and forwards each new error event on its
+ * own, so an already-set ERR_MAP bit does not suppress the interrupt for a
+ * new error.
+ */
 static irqreturn_t tegra241_cmdqv_isr(int irq, void *devid)
 {
 	struct tegra241_cmdqv *cmdqv = (struct tegra241_cmdqv *)devid;
@@ -357,16 +364,27 @@ static irqreturn_t tegra241_cmdqv_isr(int irq, void *devid)
 
 	/* Handle VINTF0 and its LVCMDQs */
 	if (vintf_map & BIT_ULL(0)) {
-		tegra241_vintf0_handle_error(cmdqv->vintfs[0]);
+		struct tegra241_vintf *vintf0;
+
 		vintf_map &= ~BIT_ULL(0);
+
+		/* NULL until tegra241_cmdqv_init_structures() publishes it */
+		vintf0 = smp_load_acquire(&cmdqv->vintfs[0]);
+		if (vintf0)
+			tegra241_vintf0_handle_error(vintf0);
 	}
 
 	/* Handle other user VINTFs and their LVCMDQs */
 	while (vintf_map) {
 		unsigned long idx = __ffs64(vintf_map);
+		struct tegra241_vintf *vintf;
 
-		tegra241_vintf_user_handle_error(cmdqv->vintfs[idx]);
 		vintf_map &= ~BIT_ULL(idx);
+
+		/* The slot may be published or torn down (NULL'd) concurrently */
+		vintf = smp_load_acquire(&cmdqv->vintfs[idx]);
+		if (vintf)
+			tegra241_vintf_user_handle_error(vintf);
 	}
 
 	return IRQ_HANDLED;
@@ -730,8 +748,18 @@ tegra241_vintf_alloc_lvcmdq(struct tegra241_vintf *vintf, u16 lidx)
 static void tegra241_cmdqv_deinit_vintf(struct tegra241_cmdqv *cmdqv, u16 idx)
 {
 	kfree(cmdqv->vintfs[idx]->lvcmdqs);
+	/*
+	 * Clear the slot and drain any in-flight ISR before returning idx to
+	 * the IDA, so a concurrent create that reuses idx cannot have its
+	 * freshly published VINTF erased here. A plain WRITE_ONCE() suffices
+	 * since clearing the slot publishes no data. This also covers the
+	 * init-failure unwind, which reaches deinit_vintf() without the
+	 * destroy callback.
+	 */
+	WRITE_ONCE(cmdqv->vintfs[idx], NULL);
+	if (cmdqv->irq > 0)
+		synchronize_irq(cmdqv->irq);
 	ida_free(&cmdqv->vintf_ids, idx);
-	cmdqv->vintfs[idx] = NULL;
 }
 
 static int tegra241_cmdqv_init_vintf(struct tegra241_cmdqv *cmdqv, u16 max_idx,
@@ -757,7 +785,8 @@ static int tegra241_cmdqv_init_vintf(struct tegra241_cmdqv *cmdqv, u16 max_idx,
 		return -ENOMEM;
 	}
 
-	cmdqv->vintfs[idx] = vintf;
+	/* Pairs with the smp_load_acquire() in tegra241_cmdqv_isr() */
+	smp_store_release(&cmdqv->vintfs[idx], vintf);
 	return ret;
 }
 
-- 
2.43.0

