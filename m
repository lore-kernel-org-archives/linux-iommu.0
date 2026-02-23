Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012022.outbound.protection.outlook.com [40.93.195.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23783346792
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 06:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771827536; cv=fail; b=Ckiadhjmz0DMAwm+h7yTYa66RXcLJgIw0Tln9mPq4TTTVM2pt62uI6lsLvULAPIdeP7beaE5zF+Fc80HMJEypSwR/H8abCD31GKEd0S0gM2eYprVWibOqABUsTI1rp6cyjcDtlG5mPg6wxbfR3CjxCOUr0rkSlkxhyFVJjXHWJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771827536; c=relaxed/simple;
	bh=p6MMbo6japsnfKBCAxPi1l37izb099Eowk+EjIXMzLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i03pWWF8hpazkP7wSmIRg76nJ25XW8NMEbB4j1UO2AmEWFLxDAOXIFi2XR4pLzRn5Kjf5+3dgGLlBYKx1yF7Sd+nHUIZpfwmc23txrO7lpXvnj/PoJxnyaMaK4NxF5u4/DVUC9pHVEQ4e/uQ+P/peNyp/SFCebpQjih7jSRXCmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=flc0ICaN; arc=fail smtp.client-ip=40.93.195.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="flc0ICaN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9R1nV+qtj8QJXy+sxzjA5l0sSUw186ZJvIH/e8yanExkmNKaWGWHQohQOnGjJ9vojb3ZJlkSOy/yiIZ4kcGFUgTnyWX5H+3KHWlsQ/UCg1KiRwc5+wCK+Rk6FiST3aoH4TxlX63VbT8pjwyHa+lOcEwsfIyTSJftttBbzKuBzZUpVG2VcuqE7YTEIo4Nb3G1YN7po18/itkzuKBwSwFWunJMtcxci4fpDg8ksM8Lw9MRrwQUe+7YgOUHb0rINkHLHwi7XBKlTtTKE8s+xbQ88Pxq73F9PzL/kyXgO0Dce70tjgdDqBMsUf8OQHU/Xloc56jx+gIz7kW47UCUZNJew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXXFDvD3pOJqJsyASAe/277USTq0nHDpWgjIbmzZeTw=;
 b=ZUaZDBniuUvIsUAyx37ffdgnAJGfzmb2Xi9sxzOBdvz7At9MUfDhNru8zwSjfiPMyPz/o8MHQed0DzAVfDVsHthdYFKnvM0PQ7OSkRvHN+m89TIXyxWBfCsuhTlZMw67zTD4x2wKDPqBv4AwgWtheDe8jsErqN5ySFefdB0PaAageW4IAaUK34n87V5nX/1NEMXegzxb4eQFomufZw79wm+sNSRb/GwypKHY1wLqBlJcCoJmYSW2KRkZvgxhFVklOtuSJN/PYaQ+do4gLuZ/pazQRJxITMwJbtyRjfKXBWU6rKG0uA1IXcW6x3ltD0aB2Cn/G98pfupVSSXKQC3nNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXXFDvD3pOJqJsyASAe/277USTq0nHDpWgjIbmzZeTw=;
 b=flc0ICaNFe0NwUN/5f82oFivnZFmpUD8fZtbvTad5FcAMDHwlOpcBeLHwV7tr+55hZ9KLV1Qt/xD3Zyv4Xnd98GqO43oiu9EdqO9ah9qK3ELjHPn4hc7ur9pMuhZRZdRlmxxmbOXJWxCqT1iJINDMMRMHCto/KUD7IWw7kiKvErwTOPjDze9dm3fp+8Y88aooOEvR9ryrVnsvH5RAp8b59pxDcTqXdd9dyn+KdA5v47uMtzC9GDrE7kIuKO+0cuE60GvV5gnTfYwb7Rxut2YYAWiQVZ0cPOFtGCPIugfuShUQwoNVKsTwEYaVfE+yxR6BDo7Y9Y2MXrY1BOFUnWgQA==
Received: from SJ0PR03CA0215.namprd03.prod.outlook.com (2603:10b6:a03:39f::10)
 by SJ2PR12MB9139.namprd12.prod.outlook.com (2603:10b6:a03:564::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 06:18:46 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:39f:cafe::41) by SJ0PR03CA0215.outlook.office365.com
 (2603:10b6:a03:39f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 06:18:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 06:18:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Feb
 2026 22:18:23 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Feb
 2026 22:18:23 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 22 Feb 2026 22:18:22 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v12 5/8] iommu/arm-smmu-v3: Pre-allocate a per-master invalidation array
Date: Sun, 22 Feb 2026 22:18:06 -0800
Message-ID: <8bab9554b643bbdf93df2c819a535b9e14e91f77.1771815709.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1771815709.git.nicolinc@nvidia.com>
References: <cover.1771815709.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|SJ2PR12MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e2918d5-e875-49d3-7a49-08de72a366e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2dpe2c+wYblOlsQQL0XFrj02QTGhvB4MasWv1ow7PCYc0HX5gqh0o3K56uqp?=
 =?us-ascii?Q?XM97NL2aygrpEBzEA1EwHcgiXt1Av1rTeFi/jhjGMcQWIsLnSNGce+yr9sCb?=
 =?us-ascii?Q?733fMA+7xBL1YSTF4VAFv22qJsy2U/UWsVad7Ob7BRq02hx+0b4K5xVL1W2J?=
 =?us-ascii?Q?qCTMHb1CH6WF9+QXON6L3PH/55ufku3XDrDYaSwNYg254tGT3HmPYcyZw3zT?=
 =?us-ascii?Q?t0pXsOupPk3Lz0IKZnO/pDieSMg8cSIjnZ41q4rGcpgfmYn/pdZk5Q3ekO57?=
 =?us-ascii?Q?cya+eFtTzk8dtTbrnCYvQJHTVpAZw82hLWUV8p6qsH/i2bKNVYacR7FWbKSf?=
 =?us-ascii?Q?OOrP5iT69xXdV52V4fF62LGfyqC22/CTfw7KKHTIVpko2HbYU+LHDVWh8WTi?=
 =?us-ascii?Q?HEqGlTCi7yBKaeAIdrsxW2TvezIIMqig06bzp3iMta+Sl60wjV77qZ4qkBOb?=
 =?us-ascii?Q?lV5ZpyiSoQ9V7R5NmKfEna7TOLyTstoX7pDMCypecSekWygAehq29kp18T8y?=
 =?us-ascii?Q?XwxshYow0FKbg1ZzaGiSZ1OfP0N+sN6TSY+bVOoXc5Hdgb5JeK41QGUyLkJn?=
 =?us-ascii?Q?iOXN8V3e2Qlrcud4ZBOS15JRttzJF0PI7bjLXbB5ImPBIdOYcTEbNyMFgPMR?=
 =?us-ascii?Q?qnhyKhYZZlQnhL40GzHppmi/ojKJVUbPuj8UB/yiiV7meD/u+0RZNuQ4GmSs?=
 =?us-ascii?Q?XFx2Br+GG3Z8un0VkG2DrR+nzLZezkkp2mTEADeGBU1SZ/ji/PgmNJF8PM5Q?=
 =?us-ascii?Q?Uxr19VJRlQTEi7+32gGC2Wmu7OBFqou/xkVDirbxoQREX6FkoYWBUM6QY7od?=
 =?us-ascii?Q?oocpS5mBGTuLNcBU9qv4tYrvdcd0Wyqpfa/YIH3ZiO+TTtPeSgdsX8DFlu0P?=
 =?us-ascii?Q?9ZumeooCp2fVjRd5V1j+DlsOkqQxhiq8He5gjyywklO32yhCIA9bXdoz3S6G?=
 =?us-ascii?Q?etey0pGdfbTsvJOPwYzsKIH8AnMBanxoNH+kwXXdkWM8CzDORne3ozi80dGF?=
 =?us-ascii?Q?Z2c1yZZoo+rlYD3566to4tHCRzjIYi4sfZV69AQgG+aMMDPiacd+vW5z3juh?=
 =?us-ascii?Q?GjrILTnq3OzcZrnHSuTomPEIofdAAtPXOtM3jbS/xb8USgjOFg+NEKQgq0W8?=
 =?us-ascii?Q?UHEAb19rQCCkiggofvjRCJdjv0MSslqFVLdn4hemlsNS3j9Vmwy6KQ5NaYGZ?=
 =?us-ascii?Q?Q5KzhVYosq/Nk0ze5VC89eZVHMoQfWXTty2J4FM9grk8S63CTuJMcWTREb+6?=
 =?us-ascii?Q?qsHJXEwEWeVPuTEPnUiXZmsQPAje1ryuVjrZNmVkNFAvopW1gBlnpveA9NHP?=
 =?us-ascii?Q?snaAAx1zZhhqmsZqCS2HBdcm0F9a2u8ttGRgNu+XvPxDystK3yY/BPERWT3c?=
 =?us-ascii?Q?AOMLIZURQiZwv3DH6G5i1r9IKpXl6b1IYTlnKsVrvW5aD7IGgSWf5SSi3V09?=
 =?us-ascii?Q?2pC8G2kSiVREWJF0HafHeVAVrpq5ZzENkCEmei4hf8w6tk6jrfasKdAn3nhZ?=
 =?us-ascii?Q?Um91hKK02NKNuUjlktIwNbRBLOHHvv3iAli3WdGfnkbsxCwExlVwkG+tp3VB?=
 =?us-ascii?Q?i3tP69gzOXYMzUfX0byfuGjMxgVu8NDB7BRhf0syKKPau2h9u1MK/Dz68rK+?=
 =?us-ascii?Q?8nK8M294ZIA7eQwZAPH2p92+BnNtRrARvYNmWpY8yKbwp2+xkBWeo7VNTnzN?=
 =?us-ascii?Q?GN5acQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	erjgGIqYNbEo4j3AnCFcePtZ5fuWUbZuzpOOlo2IpmZAPe5uOAAcV3D3BEdtIajk2RxIfLGQYhDY9WUJMXNb0/eoEYaLdYG++6EAuTvxTmFrmS8msVY2ex+XUX8fsDhyUsmBaQBHq4vnlV6WWh9fmVHGQKERYcczxpYUrs7xIixC6eLTCC/AcxjYv4fIlI2S01SdMhgfPmXxjxUQT7fVwEEIaZc8Q+KNP6/d9J+w7HInN8Tj56FUzYwmDdgfpZlZZ2g/FDCoNLHBQp4YWSGyy2EQhaKRHlEht/gPfcAJ5hpkIIAH20pJarpxkG1kkXHllsMmxElJura/IZyl7BbU4+X/ZEfrp2wn1gJDGdYarvNXo7AD+/TQjcfVk95HS27dAdFS87CKHmG4BXKz5/vgiG6tfUhtBs42TqqDIOhf/+PVGM9Gqx0Y0aNuA0AAbaye
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 06:18:46.3235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2918d5-e875-49d3-7a49-08de72a366e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9139

When a master is attached from an old domain to a new domain, it needs to
build an invalidation array to delete and add the array entries from/onto
the invalidation arrays of those two domains, passed via the to_merge and
to_unref arguments into arm_smmu_invs_merge/unref() respectively.

Since the master->num_streams might differ across masters, a memory would
have to be allocated when building an to_merge/to_unref array which might
fail with -ENOMEM.

On the other hand, an attachment to arm_smmu_blocked_domain must not fail
so it's the best to avoid any memory allocation in that path.

Pre-allocate a fixed size invalidation array for every master. This array
will be used as a scratch to fill dynamically when building a to_merge or
to_unref invs array. Sort fwspec->ids in an ascending order to fit to the
arm_smmu_invs_merge() function.

Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  8 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 41 +++++++++++++++++++--
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ed8820f12ba32..5e0e5055af1eb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -928,6 +928,14 @@ struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct device			*dev;
 	struct arm_smmu_stream		*streams;
+	/*
+	 * Scratch memory for a to_merge or to_unref array to build a per-domain
+	 * invalidation array. It'll be pre-allocated with enough enries for all
+	 * possible build scenarios. It can be used by only one caller at a time
+	 * until the arm_smmu_invs_merge/unref() finishes. Must be locked by the
+	 * iommu_group mutex.
+	 */
+	struct arm_smmu_invs		*build_invs;
 	struct arm_smmu_vmaster		*vmaster; /* use smmu->streams_mutex */
 	/* Locked by the iommu core using the group mutex */
 	struct arm_smmu_ctx_desc_cfg	cd_table;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f6a423500ce1f..7d8377f6a6838 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3784,26 +3784,57 @@ static int arm_smmu_init_sid_strtab(struct arm_smmu_device *smmu, u32 sid)
 	return 0;
 }
 
+static int arm_smmu_stream_id_cmp(const void *_l, const void *_r)
+{
+	const typeof_member(struct arm_smmu_stream, id) *l = _l;
+	const typeof_member(struct arm_smmu_stream, id) *r = _r;
+
+	return cmp_int(*l, *r);
+}
+
 static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 				  struct arm_smmu_master *master)
 {
 	int i;
 	int ret = 0;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
+	bool ats_supported = dev_is_pci(master->dev) &&
+			     pci_ats_supported(to_pci_dev(master->dev));
 
 	master->streams = kzalloc_objs(*master->streams, fwspec->num_ids);
 	if (!master->streams)
 		return -ENOMEM;
 	master->num_streams = fwspec->num_ids;
 
-	mutex_lock(&smmu->streams_mutex);
+	if (!ats_supported) {
+		/* Base case has 1 ASID entry or maximum 2 VMID entries */
+		master->build_invs = arm_smmu_invs_alloc(2);
+	} else {
+		/* ATS case adds num_ids of entries, on top of the base case */
+		master->build_invs = arm_smmu_invs_alloc(2 + fwspec->num_ids);
+	}
+	if (!master->build_invs) {
+		kfree(master->streams);
+		return -ENOMEM;
+	}
+
 	for (i = 0; i < fwspec->num_ids; i++) {
 		struct arm_smmu_stream *new_stream = &master->streams[i];
-		struct rb_node *existing;
-		u32 sid = fwspec->ids[i];
 
-		new_stream->id = sid;
+		new_stream->id = fwspec->ids[i];
 		new_stream->master = master;
+	}
+
+	/* Put the ids into order for sorted to_merge/to_unref arrays */
+	sort_nonatomic(master->streams, master->num_streams,
+		       sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
+		       NULL);
+
+	mutex_lock(&smmu->streams_mutex);
+	for (i = 0; i < fwspec->num_ids; i++) {
+		struct arm_smmu_stream *new_stream = &master->streams[i];
+		struct rb_node *existing;
+		u32 sid = new_stream->id;
 
 		ret = arm_smmu_init_sid_strtab(smmu, sid);
 		if (ret)
@@ -3833,6 +3864,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		for (i--; i >= 0; i--)
 			rb_erase(&master->streams[i].node, &smmu->streams);
 		kfree(master->streams);
+		kfree(master->build_invs);
 	}
 	mutex_unlock(&smmu->streams_mutex);
 
@@ -3854,6 +3886,7 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 	mutex_unlock(&smmu->streams_mutex);
 
 	kfree(master->streams);
+	kfree(master->build_invs);
 }
 
 static struct iommu_device *arm_smmu_probe_device(struct device *dev)
-- 
2.43.0

