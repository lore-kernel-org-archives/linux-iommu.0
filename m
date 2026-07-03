Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBFE336897
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 05:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783056725; cv=fail; b=caMAQYSl7k+WhvIwIIwHP2bimIhAZp2iCrQ9k/1BhiVkPJ8P8AoUAtY6VH2Zhd3gBdMqqtBL2FpsYt5srUhLji8Nm2of6vM/ezCt/B4Zsb9c6eUkJarCqo+TIIeYontuEfKlKcAtPIff8uKNa2Dv/9cCTB7Bjr+cyM/xVE5ft5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783056725; c=relaxed/simple;
	bh=bHgtICmBUE4BIMSmGPahfKS4LI+QYxwc+FfYogE0LCI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCVQkMJ88/rIpBCjavS93aVQqc5q4ZTasPblJHjJjUeIFlDjuz8kOFoMPHJq2YkhzOL6b7gGed9xn4hX6Yj7ouHvLiaq8fKi86AO1TA/Mb75+0++gpQe+5m1LFLFOrKYk2Tlxgiha4v/tiV0VvOnkf1heBMSoi2YUbSjZDiDfDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RKsvP13V; arc=fail smtp.client-ip=52.101.43.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RKsvP13V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snXFZR4w/ijPoiYa5fPM8I/ax2hiPbh7NeYBcFi0rMgVy24/6Isb9wCzae2Tah+Y4q/KQludI5tiZkMB7rkZgpIDnTvZUZPMsdjCYRts+ur9s0w1PVXGkvDTKV2+MCOR1zU1vDIdY57cD7clBtECGgKIgOh2LdYDkZfQRzgtdMNy88YSdh+3uw/X+R61k++rPd9lS5EEyiheUB3XoHgUHORJvIb5kaMFLgzIbwf7FHxxnXhU0F+n6CFQ0M1EkmqhwfrjeNBiz7pLh67vGLAMDJcTyUdvmwHcTtvXVAqwGwt+Bw9VzeNQkqkKzZHsqIo6ZIhyiGYZEfSFUwlTr8C7VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MA+7HpBscRRKuEVDeL83ihJ4j9C5ymr5oo+IEq87FX8=;
 b=ACCzVmDpNsic90JhElDbcGtnqHL81/NYEP4RP/DaA5G3i+Z0pVUCPKRqjCFXgvw3c6QQUKXR/NO9OyreiTupiwwgYbNfMANnykZsehZC8M0RhKIEnj/S/+asYddt7Rpgsq0sdtjrYRQOtvu5iMtWI+FK/47YwxOQN+J2dn4TQCXrxDs7oXVlJ57hoIJGN+d2Cj4snHpjsnJ1icZoDSYpeqxgnoNjI+fKkegFe/QzkwfnOAt3ffGP8XE+SqvwKBJhYFapd/k+Hdnr8CMe98+dB3cPPDLXUbxTU+cmD7foeIKQu9IEXtOnYlT8iQ905+G8dfSeyVyoVXDGvE5YWde4yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MA+7HpBscRRKuEVDeL83ihJ4j9C5ymr5oo+IEq87FX8=;
 b=RKsvP13V/NEGnwLIlvbE8cN5fwe4LopQUgIYhEod3ZSkIsZC37+HPnpH2TZlIYyFRejP64FbuZl79AxgI9RqbtdLd8YfmnoSLrZx1Pp6O/Yel40BBG71FSUF9rbmUKsCUdWxCrvqVEZ0jj5b0JLiVHWZIUIxDR75IZ7JmTg9j+t90BbeayQ88mpOJmeSw1/FhL9gf/qzVM17Dxq0kNdm9stFL4r9KXAEePRsevCPdwpMVfA7SutnqxD3JefYFlZmeIcR1sUXSOa4uppgYCrJLClI8U1jijUnmm9OWVZRYqxRnsOsRR4guCg29rRT1891TyJjhVtfE94J4+QBF97omg==
Received: from SJ0PR13CA0060.namprd13.prod.outlook.com (2603:10b6:a03:2c2::35)
 by DS0PR12MB9040.namprd12.prod.outlook.com (2603:10b6:8:f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 05:31:55 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::9f) by SJ0PR13CA0060.outlook.office365.com
 (2603:10b6:a03:2c2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.3 via Frontend Transport; Fri, 3
 Jul 2026 05:31:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 05:31:54 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 22:31:43 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 22:31:43 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 22:31:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 01/11] iommu/tegra241-cmdqv: Publish an LVCMDQ only after it is fully initialized
Date: Thu, 2 Jul 2026 22:31:27 -0700
Message-ID: <3e0d9156cd7ade5a5ee0b9a63a326dc324866ddf.1783054570.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|DS0PR12MB9040:EE_
X-MS-Office365-Filtering-Correlation-Id: d485cd71-e594-454e-5427-08ded8c464c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HXZD5aEFStv2L0xHCfVBS1JnIXjcP6ffAnLoywKTIk5rUVZGVmCXHCza68OU1wCCUdaY5equkmdbXY0fh9bft+u/WVcNLen1GwuH+F1dW+/1CjNzZUml6kdXbAP/wiP7LuqhIGPxDyMHj9Jh1hh8uQF2mn6zGCFusrAQBRRPhBbwX1mFl901nrqKx8N0d+DypIsEfONY2IkGcMywgm58nPAj1bmKvVisf+CQx5rBFjhlfUZm7FjkdyTGLzPLjDQdCARrXiJ8V6N0/U/IBIaIhLXTENT6zMroQLGeGuv4kYke+GPDZn/hwjFARp4lTPFfp7ktmGGmIejqlJRgE8Oz88bBo8o/pYmmexv1UceR2NjmCNU6e72cs9weoX/JjN6mOzRJAzdy0jRbwPKfJLjJbqXxy3CtEOnUyf7i0V36Nv3l/Gzz7dKuPA6mJZi35jzXUoQY/axbNXQDiJqBsZnvEMqUFFbRQh5F3i4PfQpoPiPJG+cF/JOJi5/bqzGWa77Xen4ueqK2HthTbPoL4yoBrrYQ+Mf+JeFZpg5B8ygZkAUiatmDr7fal24cfWaq6Tk+VZ6cExANXNdkV4RGbN+Wia2GB6eT9lD3lxLQS59fGr4i/C+Crh3ogUrmBlWH4jdOldJn/6ZWMSalpzhlZ7of4oHHwHVIcDoXMatGy/027Zj6FINrAgY5qVibecN7jYEZzlhuHYmhFvfPNGVoRdQ0KA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AknsnEeJYtnhw2Gdv5DLR+xa/sSzT+mS1gLN85hJX5doH+v+lx5jxwZk1cJl7EKP6FZ5D+xhkpCs6P0z+gm8sPGhRLaglhYH0US8Wqe7MNyWoaeOIwpDZSud6ya3a17RTlEqUaUifBnIHMCrls02Pc9tnrSeneLdwKVVza1B6jgncjbNTfUMfKgqDzAhgWiNfSxCNuGSnlwB5euvD6Ekg9AAm4D/9ONb+BtLwjWarKtxPAk51U2pkZr9Bq0t95X+1l2nqo2HLcnFloZs7+nnnaSphIwCjwcnWQSQdp61aojp2dfDzSpCdP9V0GKk5xhcmQz2sQYsbdB2rYYt0hU3tBotxRkBp0JsIK6fEWkM8/MPBNMi54e0nDd07Buk2/H8UbaHjnICQoE4iU5X/A+OdLLpZVhtoiIKTFwibRMol67SQrYIkUzrAXclbwf2I3mB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 05:31:54.8438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d485cd71-e594-454e-5427-08ded8c464c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9040

tegra241_vintf_init_lvcmdq() stores the freshly allocated vcmdq pointer to
the vintf->lvcmdqs[] array, before tegra241_vcmdq_alloc_smmu_cmdq() builds
the vcmdq->cmdq. The error ISR dereferences that cmdq, so a latched LVCMDQ
error (e.g. one inherited across a kexec) firing in this window would make
tegra241_vintf0_handle_error() pass the still-zeroed arm_smmu_cmdq down to
__arm_smmu_cmdq_skip_err(), dereferencing NULL queue register pointers.

Drop the store from tegra241_vintf_init_lvcmdq() and publish the vcmdq at
the end of the allocation instead, with an smp_store_release() that pairs
with an smp_load_acquire() in the ISR, which can see a fully built LVCMDQ
or NULL.

The user-owned LVCMDQ allocation moves accordingly, publishing the vcmdq
once tegra241_vcmdq_hw_init_user() succeeds, using a plain store since a
user VINTF's lvcmdqs[] has no lockless reader -- the error ISR only walks
the VINTF0 array.

Fixes: 918eb5c856f6 ("iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace) CMDQV")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 67be62a6e7640..f843d607c8134 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -318,12 +318,19 @@ static void tegra241_vintf0_handle_error(struct tegra241_vintf *vintf)
 
 		while (map) {
 			unsigned long lidx = __ffs64(map);
-			struct tegra241_vcmdq *vcmdq = vintf->lvcmdqs[lidx];
-			u32 gerror = readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, GERROR));
+			struct tegra241_vcmdq *vcmdq;
+			u32 gerror;
 
+			map &= ~BIT_ULL(lidx);
+
+			/* Pairs with smp_store_release() publishing it */
+			vcmdq = smp_load_acquire(&vintf->lvcmdqs[lidx]);
+			if (!vcmdq)
+				continue;
+
+			gerror = readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, GERROR));
 			__arm_smmu_cmdq_skip_err(&vintf->cmdqv->smmu, &vcmdq->cmdq);
 			writel(gerror, REG_VCMDQ_PAGE0(vcmdq, GERRORN));
-			map &= ~BIT_ULL(lidx);
 		}
 	}
 }
@@ -666,7 +673,6 @@ static int tegra241_vintf_init_lvcmdq(struct tegra241_vintf *vintf, u16 lidx,
 	vcmdq->page0 = cmdqv->base + TEGRA241_VINTFi_LVCMDQ_PAGE0(idx, lidx);
 	vcmdq->page1 = cmdqv->base + TEGRA241_VINTFi_LVCMDQ_PAGE1(idx, lidx);
 
-	vintf->lvcmdqs[lidx] = vcmdq;
 	return 0;
 }
 
@@ -705,14 +711,15 @@ tegra241_vintf_alloc_lvcmdq(struct tegra241_vintf *vintf, u16 lidx)
 	/* Build an arm_smmu_cmdq for each LVCMDQ */
 	ret = tegra241_vcmdq_alloc_smmu_cmdq(vcmdq);
 	if (ret)
-		goto deinit_lvcmdq;
+		goto free_vcmdq;
+
+	/* Pairs with the smp_load_acquire() in the error ISR */
+	smp_store_release(&vintf->lvcmdqs[lidx], vcmdq);
 
 	dev_dbg(cmdqv->dev,
 		"%sallocated\n", lvcmdq_error_header(vcmdq, header, 64));
 	return vcmdq;
 
-deinit_lvcmdq:
-	tegra241_vintf_deinit_lvcmdq(vintf, lidx);
 free_vcmdq:
 	kfree(vcmdq);
 	return ERR_PTR(ret);
@@ -1130,13 +1137,15 @@ static int tegra241_vintf_alloc_lvcmdq_user(struct iommufd_hw_queue *hw_queue,
 	if (ret)
 		goto unmap_lvcmdq;
 
+	/* No lockless reader of a user VINTF's lvcmdqs[]; mutex-serialized */
+	vintf->lvcmdqs[lidx] = vcmdq;
+
 	hw_queue->destroy = &tegra241_vintf_destroy_lvcmdq_user;
 	mutex_unlock(&vintf->lvcmdq_mutex);
 	return 0;
 
 unmap_lvcmdq:
 	tegra241_vcmdq_unmap_lvcmdq(vcmdq);
-	tegra241_vintf_deinit_lvcmdq(vintf, lidx);
 undepend_vcmdq:
 	if (vcmdq->prev)
 		iommufd_hw_queue_undepend(vcmdq, vcmdq->prev, core);
-- 
2.43.0

