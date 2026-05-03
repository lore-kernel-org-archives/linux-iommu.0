Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADA72D837C
	for <iommu@lists.linux.dev>; Sun,  3 May 2026 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777816475; cv=fail; b=frkkeWZNlczUYQ6pIGzJiXpBoHf/mwq6Rw0qabvyoQkwUqiWxQTXv9XOXPNf+fb1NWomGmcdUYgFSI/wvAYnbYanNPSNgtHPTiOIoL1ka08oPeHtPipU0Odu4YZbwoU2triDnwMQ54KLAls8pZSpf+6AT7w5iQuc5MnZkekuQEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777816475; c=relaxed/simple;
	bh=6h9qF37r396PmwWUHSTD+ZSW8/0v0ftJPY/C3iCEIfU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LYCg+1w/QnAY/4ADyp2UJ/n09JfZy+gciXYr+TNpd1MLDjOBVAfwOUb4qBKYuxK8nRUX4DMil6YcM2wXsM9377+kp9l8vHzQYsCF9WV/33d8thMO6iyP6ms9y2tpfVc2X/liCSGsNlQy074+nzifBf7w5ODlJjO1IRZeSveLXrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ft0ZHhvD; arc=fail smtp.client-ip=40.93.198.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ft0ZHhvD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fM6pE773XeUfy4QHK6mho0oV2uuwnApMzvnPO4qDwVSKa+3AJWA/S16OdQ3OXcMkodbvFLgb0mUIq5Q4Qkrzzb+6XaDFByIVmamb+CpR85bGXKIjlMDJfWRTCcvuiHGQWsVnI9A96o2gb4kRL/nQjdld6lOxnHz8MoigCniCCwl7dKhyWlFssT/0+WkYJV0a/LIOrMHequZByIxfn0dM4oeBYRgRaNymWtOM3rn+TXY6oc81y9OO8BWSjwT8XRkZvtVROtNNx2+wRjPp29r/fag+S7aMtOLub0edZPcfPg2rP/0bGr7P8kMnzN4dNkYqmpn/APfRNRkAZZEPHVI3HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tj2+hqYd1S8ulxN8n8VYNe5qA+wZFVHUron88tKCpqc=;
 b=AqRY9lUf6mb73MNmas8NmaWiVFS1hxNq9PZU/LbfKDeS/AGdQcoDYHS72TH9urwj7E2lJvtoDvlKP4KJ1hKCxUBmHOq4BMeZXpDk+ZNb5mYbRj/rk+4nGFlRVFYCChrl4M5NdHoBgZh9W9413UVzfmCY4lPPCMqmgslzNSbc6Ulc7jmy3yNEtl065rrSoo3h5s9QZXDp/GhIUc+Ub5/wC1peJNagj/mXO9vpNR63CQWTK2FTfq0bvRns+o07Hn4nLp3CcUS68b+4xWczpiCykPMCkTOfdL8urE54q+yKo6GbhmNKeDgN5j5lwfFThBESKk0Gw5sfVLzsIQodF9ABIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tj2+hqYd1S8ulxN8n8VYNe5qA+wZFVHUron88tKCpqc=;
 b=ft0ZHhvDur+EjZCBzuqqpbhQgkgmZBVBo+loX08PKSQzV8fMyFnamBxVFipATcCi/ptITmSx4Wat2rYGE2CeZhN8KrPQ4HjJ6xTceG0gTRfXOkrkgqGH5GmfB1vUiP1fQzS7GQEcDBeT32jxPTLTZosLShAXL97rOEkABooppcheUInu2Q6NDul/FBsDUA2ppuQ73dIeOM3qfed8goLL174F4s7HwUR0aKrh2bFmNeYrwkQPp6EyHSoinj4wqIP2VghAuPd4/SjsNGpJA/sj4i9XPwcMj4CBd9vQhdSVVvyu1OpClavXjzvOcodtTvIEcVpcqdkxJSruSmbf2Jxgeg==
Received: from BY5PR17CA0034.namprd17.prod.outlook.com (2603:10b6:a03:1b8::47)
 by DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.23; Sun, 3 May 2026 13:54:29 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::12) by BY5PR17CA0034.outlook.office365.com
 (2603:10b6:a03:1b8::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Sun,
 3 May 2026 13:54:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Sun, 3 May 2026 13:54:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 3 May
 2026 06:54:21 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 3 May
 2026 06:54:21 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 3 May 2026 06:54:20 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Joerg Roedel <joro@8bytes.org>, Jean-Philippe Brucker <jpb@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>, Catalin Marinas
	<catalin.marinas@arm.com>, =?UTF-8?q?Miko=C5=82aj=20Lenczewski?=
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iommu/arm-smmu-v3-sva: Enable Hardware Access and Hardware Dirty bits
Date: Sun, 3 May 2026 06:54:12 -0700
Message-ID: <20260503135413.1108138-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|DM4PR12MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3e7171-bafa-4001-01f5-08dea91b7e8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WJxGblC0gWUr8XzCgqCK4BixBVW8JH74WcDT5p2EIxUJRipM2Qm2z0wpI4IuloiDFqCKRda0w9Gdnl9y8nH5Tf6xAte9S2vOid3bVsBf25x69iKcU64RML0o/4kthOVX8Y2j4+NaLDSWmU8M40jzD8WfXL2pMr+vuLNwN+zNOIlUmcymkuA2/hVHSb11sEym7G295o20qFvnn4DxejVyhvK9FTyAe43k7bLIllKndohralbvJayuVu3NdKQzbZD3bU7tHI/mzxkEYm/CWaJO1ukuah63MPUS4+e1IUh0R674ebE0rUK+ftZJHU7wv+h02oE5AYyOjdRO/ko+xpfaDR8Kq1KcB1w835YRaTx72Owj6VDZFcCiAOi4odgHQB0W4TBsaNOF02Ig16JJ+GP53ai7IgHgdb8K5RNpAh0r+2/LdMxAlUefzrdTsb07VPQea1fQbXnSUw3gSk3wf4IcKp1dXBkC9WMIMevLbHLHbT+DGssk+dlOqQcVJmU8FmJzKlBlNn4WpbFCtgPRx35FugLQvaTfXBpjuPK9h6/52KCWi1WdCxSF7pASum2N54p9XuVdyNC0pNPq9RCGtu4w3BSm1OgNLyoHRN6xB7YUg+Lt/0n9xy/fUbFFeVvZZkcj5F176TU6HHuoIApa350nEBiUrqLvK0kP+JfNKcS1UqhzTbTTWpoPzVqX3SWLvHj4kx8DMC92xk+gOqsr1kBwWFXUlbZehWHkUt+rN6mlMXo=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F/WLmtxD6MMFSbzwMFAIFVr9NxTQsXUzLqUFb6crZglcG89UOTrMO6g+4Bkr94yBDn4aN/oSTVR8LpFoQoxPlNJ/51v0itxtKs13KPHlbFpy6UhHEcZw+SvewFz9gpmsN6cVtyB34ZVeBH9oFJyd3uq/r+rt0MMUzHDRkQehSbk5RQBoqy0BfFFWBgevPwfFSzwRgzwm/Pcj9gDUqn7lH7JocQJ8XQdTV9m6ugwpbAW1QwpwUTT8rLet0x/hM0H8nyxolWhcxZhM+c+9kSM8+CgfBPLxIxJ5W1VQeaDHSq5RjnBPNQ6fx5yDyLCZpddclNE/hZtoYZim/Wpj/abBZf/CY/Yw+rNXVwdy1DLRazMSJq4BLIIpDztWYkFC51tbhoFAI19iNg7EIftXqv9wFYUPbetNBQyHq8i8zo4gwOzL93N86Fpu6Cv0nNJU8OYa
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 13:54:28.5037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3e7171-bafa-4001-01f5-08dea91b7e8e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5769

HTTU is introduced by utilizing the Dirty Bit Modifier (DBM) in the PTE.
When kernel maps a clean but writable page, it will set PTE_READONLY and
PTE_DBM (aka PTE_WRITE) at the same time. When a write occurs, an HTTU-
capable MMU will automatically clear the PTE_RDONLY bit without software
intervention.

On the other hand, SMMU has the same HTTU feature, yet it is not enabled
in the SVA CD. As a result, SMMU will not clear the PTE_RDONLY bit while
sharing the CPU page table, resulting in unnecessary stalls.

Thus, enable CTXDESC_CD_0_TCR_HA and CTXDESC_CD_0_TCR_HD in the SVA CD.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index f1f8e01a7e914..1ed8a6f29dc44 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -92,6 +92,16 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
 
 		target->data[1] = cpu_to_le64(virt_to_phys(mm->pgd) &
 					      CTXDESC_CD_1_TTB0_MASK);
+
+		/*
+		 * Enable Hardware Access and Dirty updates (DBM) if supported.
+		 * This is safe to enable by default, as PTE_WRITE and PTE_DBM
+		 * share the same bit.
+		 */
+		if (master->smmu->features & ARM_SMMU_FEAT_HA)
+			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HA);
+		if (master->smmu->features & ARM_SMMU_FEAT_HD)
+			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HD);
 	} else {
 		target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_EPD0);
 
-- 
2.43.0

