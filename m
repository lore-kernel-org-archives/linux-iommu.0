Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794943335;
	b=dfjve/sxebai/j8HlwJt1/LIxREUQMYvdUGHc1cXE7Y/JnaVx2HPSHnW8fHti6eHucXH
	 0yi3kPrqVUsZp2TGwiEmBJalzk01eVKY09c5d4TqUD9b6SOVktk+OvqBAXDuykZWuohq5
	 vxCl/Uq7V7u98s6ByYYyQLf/X4KyqjvS6kL/HjLRqYQJRAUke8viIjR9vSJq3rWxX+aI2
	 POg11kT4mMmtXu+dhcioOaoZnVaTXr+Q5KKbuToJ3SBgS+1EdxiO5Vh+DH5Ak2/6Qcmu4
	 5aDcPaznj0juGBRtVk4N7/IzExBKoHxlDMJUJ/jQ1IMjjB4xLGUTbgUXuq7NQexqZEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943335;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/WnWmzMeid1BEobaYOitWMfDTcR0Vi9V6wU946zQIXs=;
	b=IJPO8xLyFhF5OY55xseibQTstcShc2WFmPYa0eWGItIwo+jFtNDa/s6Dc74PXHabZmFk
	 oRDKUchFpriiEwJTK9Ar6mmdD8ODMwW/EnXwLmrY2Mu4lK3tiB6DNBowRdb/midv0xTEA
	 9I2RTqCsFbBL2Pj+/LSdOfuW7daGPYtgnzmaoUatrfKkF5//0eFpOyZtsJUYh/034bmqq
	 /MGWf6LG3WJWbedyJrQaM4d95hS9kdu8xBTSvTax/WUHQ9KNVM0i/VGif3QO6JS1ixI4Z
	 857ZUQh3iXUO9wzOX33DGgf3AGON48lfmGWPx25ZT96y/rVQPpDD/SysMTkkE64xlxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aTgGTcY0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.22
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010022.outbound.protection.outlook.com [40.93.198.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05E7606A89D
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 19:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B05E7606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aTgGTcY0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zpj5sa1syXjJqHjHmMRfLMB8J7TrGQ8X1MqUhkHOxjVOcx2X6fUs28zMSEql1hdqm31QEewjPcqZeVMti1/vsTYmEK2UBYxvDs4xDkd4pJLO+7TEJ1uNHfqWHrnvpygFAKCnWZO7vSU+NAr5v3WOS1Kx3sTXjcaNZKEIjkGGfIjxJh30RHLxftMModNei2hvm4o49htwQQZVYvsbiIeblaASzQEro5hpQyHITJWdpi9uRhk7e3Cn6GhqpFFy+HGyaKd1TwqjGFj+lo0pX0FG23Pesd8Jd8uTH7fTxoUI+8oVFpzmQll/4j4DwEPS67IYAoEwSh176riBAViNWoJuMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WnWmzMeid1BEobaYOitWMfDTcR0Vi9V6wU946zQIXs=;
 b=sGiUkepf1I7k20frYL9pJghC6VQZRItFTluA6VRXIT31bSd1TWuNkBJr2vd+3D9XVpzwMzR5V3w4e+97WMoSSB0xPUxcEAA2iZez6hsE1NQ0qU05wIcZoTc4pnSTciWe1hEZMlJkXQ1+Km/8gDvNwHwT7S1nHHNOla0FXdk6FsTYJmMoS6zroJQ5Mt2vNF0HlS1Wf2tJEZAch8n8P1hCKNsCXleshzUTdTJGkiR+qUaoZO3qR36CwLVqagNINia+ShlaNDyaeYlMklnPfoIS6loD6K65frrdf8fPMd49uktLkp4x5mI2PsU6FL3eR0nP5uTF7cnWMV4vCy09/wwq+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WnWmzMeid1BEobaYOitWMfDTcR0Vi9V6wU946zQIXs=;
 b=aTgGTcY02vpQDfVg2k3fGCfjKBB7TAs++WBb2tNidQNJ41uh55rZXlBbAXXpT7bXfIySGyEhZ4KMt0SoR8PAQrFwtWvkk0T6RRr2MlDaiufOWbe8rX7ql4sP0Je7QWAtHS/GzUZ6KbOvrCIKfzNuKW+wIZG4MsTGrOUdQpkwK0QBrqd+Q8YJI7eOzmpSYJ2hfry5eMA3kGMsXXe60Esib6vUXWpvOEr2CCGO3wvwZCEXkC74BS4LmuagamkSECnE0t+xCUWCR0DCLlSWkj03OTtPWRswDBY06xBh8WLvJ1OAh6GiD0zJE5a/9Zus6fvE34amz5tB3MiVnZ7w4S2Tfw==
Received: from MN0PR04CA0013.namprd04.prod.outlook.com (2603:10b6:208:52d::18)
 by LV9PR12MB9805.namprd12.prod.outlook.com (2603:10b6:408:2ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:22:09 +0000
Received: from BN2PEPF0000A991.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::3d) by MN0PR04CA0013.outlook.office365.com
 (2603:10b6:208:52d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 19:22:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF0000A991.mail.protection.outlook.com (10.167.248.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 19:22:09 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:21:44 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 17 Nov 2026 11:21:44 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 11:21:43 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <praan@google.com>,
	<kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
	<xueshuai@linux.alibaba.com>, <john.garry@arm.com>
Subject: [PATCH v13 09/12] iommu/arm-smmu-v3-kexec: Implement is_attach_deferred()
Date: Tue, 17 Nov 2026 11:21:26 -0800
Message-ID: <16f2e957b558f8ed917d270f37535645c470a845.1794942324.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794942324.git.nicolinc@nvidia.com>
References: <cover.1794942324.git.nicolinc@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A991:EE_|LV9PR12MB9805:EE_
X-MS-Office365-Filtering-Correlation-Id: 2adf3f7a-13c1-4c02-2d58-08df44e0134d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|7416014|22082099003|18002099003|6133799003|261009223027099003|11063799006|56012099006|261102123227099003|261026121527099003|261026140227099003|261021121427099003|261021135927099003|261021123027099003|261022105027099003|261022075727099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	lR/em4ksCIjEN0lYem6mKDLVg8dolJaVyo9rNd//Y8HnbgbVpclUGSrCWYRRq+UXPMdJzoX96DtO4IBmsmeeYlI9xwCbylZcJgemHO9J5oVi7u4mYdxHSzBcl7YZHKzk1FUPgqtgIrO9h8eXKIh5JffVx4bRcrcJ/OsyTWkr0hk/E1iG/nMKJtX0M0SFT8Fv8pxRljPj92HX4TlKKM3i5DsKShn93GmeBXiuMNp6a3tsuHkETz5AwK1a8xc676Bg1h+JotOA8H1RdaFbvPEIKcOmum9Rtqpp6bBQqNDXoKTO2tSyAb82npLgtIK022TxgU5bWo8EramBpId1aM7z04g0JmXnXgoPWIgfoJH9020+L6e23Rg6gDhq95PlYJ14OEMlOk29XIO/jUc5rihZyQFFaxVqTI7ds7BsSFRIKNjUyxufo+Oji00Su9cLNr/kArmiUkU9lnhVeWBUDxvFPxnsgNXlObU5x5gMRjfqMDJhgnIXaCwA1pt+tQHCPzD6Bj81lxr2f6+Vnqpl9XH2zPWkYClSzUqV7McibNx2sxQwMn7wQJDRKMzea4PGQ1iwor/r8MnMtg0D3FalpBqho9xNUa4uRrPj8/FEwxiAGYKqbhVWXOohPMHT1LZxues7GB0xMVNrqYOTRmfZS4em+khQM571Js6ILDfNiHq0X0YKlUz804Yg7EkS6u5JZT5Vag6GgLEbrmo2nHGFiP0Fmg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(7416014)(22082099003)(18002099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021135927099003)(261021123027099003)(261022105027099003)(261022075727099003)(261028144727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oa8uopbnaMLdIv0cPFUhZfAzveg+xmDNAVXw3silYbhcQdubcbKIUAVhKMfMMJ9NBlIJkEaxALah3IB5HEtBkaCMa20Z2/onXWsUTNlVOWSOAcfQ7sCna/M2G32FrtWWJHDviyEtfvxF8SKJJCwFnXl2hk8R19mIvgN26ytdGgysdKc+3QOR9fTIh0mrFRYvl7BBFWmyylAV2r3/jQ2pkaW7cml5jpZMRb2l6lKoTFW//VpgdHjoGGfuH5W2IrGl97q7Me4D9Bkuu8FL8hk0QuT9JfdzQrYPYfHdYqp5KrPQ9KcN3Ugb+NXj2jEKKYaHCtJCHn+MvBYU8wHY9uhQnT8ERDHFbZZeOSdelUp1GRrDKlZGQaDsf0AhSdYCb1VgacOKs/dUHibCfqHlxvJ4GpNZWmBx7BpdC6+hT4wqQxXmJTWcHctn+Rbn1SLRIMls
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:22:09.5312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2adf3f7a-13c1-4c02-2d58-08df44e0134d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A991.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9805

Though the kdump kernel adopts the crashed kernel's stream table, the iommu
core will still try to attach each probed device to a default domain, which
overwrites the adopted STE and breaks in-flight DMA from that device.

Implement an is_attach_deferred() callback to prevent this. For each device
that has STE.V=1 and STE.Cfg!=Abort in the adopted table, defer the default
domain attachment, until the device driver explicitly requests it.

Also, move arm_smmu_get_step_for_sid() to the header for the kdump function
to use.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: John Garry <john.garry@arm.com>
Tested-by: Breno Leitao <leitao@kernel.org>
Tested-by: Cristian Prundeanu <cpru@amazon.com>
Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 23 +++++++++++++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c | 19 ++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 25 ++++++++-----------
 3 files changed, 52 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 4ae8ab891857b..3bedc328a5cb0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1289,6 +1289,22 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				  struct arm_smmu_cmdq *cmdq,
 				  struct arm_smmu_cmd *cmds, int n,
 				  bool sync);
+
+static inline struct arm_smmu_ste *
+arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
+{
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
+		/* Two-level walk */
+		return &cfg->l2.l2ptrs[arm_smmu_strtab_l1_idx(sid)]
+				->stes[arm_smmu_strtab_l2_idx(sid)];
+	} else {
+		/* Simple linear lookup */
+		return &cfg->linear.table[sid];
+	}
+}
+
 int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				struct arm_smmu_cmdq *cmdq,
 				struct arm_smmu_cmd *cmds, int n,
@@ -1327,6 +1343,7 @@ int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu);
 int arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu,
 					    u32 sid, phys_addr_t base, u32 span,
 					    struct arm_smmu_strtab_l2 **l2table);
+bool arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master);
 #else /* CONFIG_CRASH_DUMP */
 static inline int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
 {
@@ -1340,6 +1357,12 @@ arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu, u32 sid,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline bool
+arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master)
+{
+	return false;
+}
 #endif /* CONFIG_CRASH_DUMP */
 
 struct arm_vsmmu {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
index 766d54c33de74..ce0cbd73f453f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
@@ -690,4 +690,23 @@ int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
 	smmu->options &= ~ARM_SMMU_OPT_KDUMP_ADOPT;
 	return ret;
 }
+
+bool arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master)
+{
+	struct arm_smmu_device *smmu = master->smmu;
+	int i;
+
+	for (i = 0; i < master->num_streams; i++) {
+		struct arm_smmu_ste *ste =
+			arm_smmu_get_step_for_sid(smmu, master->streams[i].id);
+		u64 ent0 = le64_to_cpu(ste->data[0]);
+
+		/* Defer only when there might be in-flight DMAs */
+		if ((ent0 & STRTAB_STE_0_V) &&
+		    FIELD_GET(STRTAB_STE_0_CFG, ent0) != STRTAB_STE_0_CFG_ABORT)
+			return true;
+	}
+
+	return false;
+}
 #endif /* CONFIG_CRASH_DUMP */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ac1aa83c69291..a8832a2c40037 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3136,21 +3136,6 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
-static struct arm_smmu_ste *
-arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
-{
-	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
-
-	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
-		/* Two-level walk */
-		return &cfg->l2.l2ptrs[arm_smmu_strtab_l1_idx(sid)]
-				->stes[arm_smmu_strtab_l2_idx(sid)];
-	} else {
-		/* Simple linear lookup */
-		return &cfg->linear.table[sid];
-	}
-}
-
 void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 				  const struct arm_smmu_ste *target)
 {
@@ -4592,6 +4577,15 @@ static int arm_smmu_def_domain_type(struct device *dev)
 	return 0;
 }
 
+static bool arm_smmu_is_attach_deferred(struct device *dev)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	if (master->smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT)
+		return arm_smmu_kdump_is_attach_deferred(master);
+	return false;
+}
+
 static const struct iommu_ops arm_smmu_ops = {
 	.identity_domain	= &arm_smmu_identity_domain,
 	.blocked_domain		= &arm_smmu_blocked_domain,
@@ -4600,6 +4594,7 @@ static const struct iommu_ops arm_smmu_ops = {
 	.hw_info		= arm_smmu_hw_info,
 	.domain_alloc_sva       = arm_smmu_sva_domain_alloc,
 	.domain_alloc_paging_flags = arm_smmu_domain_alloc_paging_flags,
+	.is_attach_deferred	= arm_smmu_is_attach_deferred,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
-- 
2.43.0

