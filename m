Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795780709;
	b=4P4AbB+62PmtNeiGclpNti5EMyKcCisytElAV0kOVV3eaNS5LeMzGilsB7FYO2dOAkFG
	 PYJjxAgBgn3DPxEY+my5ZECfh9NNN/vLHn7+0JYMMPSvHZGrK4Ts6q30Tndn3xGoFknK0
	 B8FT9kgEv6vmzeUBRITKcyqHARWh20V8HvkYDN8sSRZCPSgGh44sWtdbCMAoWf/fjlqSZ
	 QmBM2S7SR7/Urh/TZFJUAESgW3u7vdzu+hkmdVvYof4DxR9j6n6oZJgYiD+I+sX15vH6x
	 Pv7uduCw6ngRcl0h5XuiV+3KTxtAE47LcVvLjBx0kNsZSHHVtuOfUS1/yLxsajGwcyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780709;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=5omYzkFKQ4OVrO7xzJrovzFh7otm5PWeRrgjTeR2z8M=;
	b=bNnm8jJ7LZfvVc4AVz9QMybvBx21pw6Rfk6Wfxu6kUssOMQG+K8WjjIa6YiWstT+VTv5
	 LLWnx9VWbJO7D4FyLu5lz9B6xDmuCyaarAMD7iZ7i6dKcTSbUaFoHGoCFTRLZjH48KIGJ
	 Z5lSTIYKtmHNuqWuN1hVpw847BrEtRz4pe5GhT04rvMHG2KR3EVE/BKSAJLTjYU7jtX0v
	 RRSMyDY5+bTFB0KDfNqbvoYpt12yQ9rlXuq4ct+HD2s4Y2zGjjiNF+0KNCGItsimjuBD1
	 /SfonmMiMg/FbEK6OqMpB5XVjUkB+l5jFU5PIzs2RKiBMxkAvuhoFbP82HKfvSnXYcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IZY7xfuE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.41
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DEA606A323
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52DEA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IZY7xfuE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVHgnrDKRtjNTXQDM1T5wg016so5U6cz+nyZNdQ/FSCYuOhfaVfRkDQ8G6F+8ECz8+pSITtO3mk4yjsUJklWfzCsyh+PCoPreeEv2ACfIsSWt53jLevJmo/bCWrSJ8OIPkJyiihbbw6VeMDoi7Ycraz3Rf8G3OBuus82Q5zUT8Xi8eMbMdb74RlscKSORkR5ifw9rNHyOz2fEoSFppZdh/kARLtkyof/Qvtz5a7Cy0Sm+W90qwKdwIOBINjKbCqnSoeOYIjHv7ArMTOEG4fgFWwEcARs39H5zZp1x9iOej4424vbW7QG+R6jXcG8SmqIab23bSTlB0IempQZNhUR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5omYzkFKQ4OVrO7xzJrovzFh7otm5PWeRrgjTeR2z8M=;
 b=MozD0jDUf6hlldCLz5OARmm0M7ZB6o0aZjrxuEYC3WtAQt9mfmYfcLIgMrOSKr+mnfNZcy04C41qx2e+Y1hAMnmI1XG2xxNcK90HorHo8/wCjS1o0bLY9RB2N4BbBvlX+aiGJE4LDfN9pmkIATbIX4PjsTOsdl3qkO//gc/XOIAUB03/Inula1HPJLaPVNIDm1Hr4HZzoupM0X4d8bACrzX8TC/QD3DISStoN127teTcL77kh59DTWJclSM7MRuh+Xzj9dwt/HSG8HW09WmbkPUDVxT5R9q/enk66kTHnw4zx/fS0Ac8tS++onhRJyGG1yd8yQQUGZAH577NQrbn+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5omYzkFKQ4OVrO7xzJrovzFh7otm5PWeRrgjTeR2z8M=;
 b=IZY7xfuEb1WhqwjbogrUff/rBPu1KLc9hD6ni2oT6CjCfA6PI+bPsaq7tK0x5p4VoRn4blHlsUrYF4RagPgHuuk9g8NvlCMZvMuPnGYe1VWOkYQZxF5usDWkXPYfoDgPHdSfobP4yZ04ns9LPwIUWo8aa6As3KV+Z2SNwi0ytJw=
Received: from PH8PR21CA0012.namprd21.prod.outlook.com (2603:10b6:510:2ce::6)
 by DS0PR12MB999266.namprd12.prod.outlook.com (2603:10b6:8:426::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Fri, 27 Nov
 2026 11:58:25 +0000
Received: from CY6PEPF0000004B.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::ae) by PH8PR21CA0012.outlook.office365.com
 (2603:10b6:510:2ce::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.6 via Frontend Transport; Fri, 27
 Nov 2026 11:58:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF0000004B.mail.protection.outlook.com (10.167.247.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Fri, 27 Nov 2026 11:58:24 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:58:21 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 10/12] iommu/amd: Drain the PPR log before detaching an SVA PASID
Date: Fri, 27 Nov 2026 11:54:45 +0000
Message-ID: <20261127115447.209792-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127115447.209792-1-vasant.hegde@amd.com>
References: <20261127115447.209792-1-vasant.hegde@amd.com>
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
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004B:EE_|DS0PR12MB999266:EE_
X-MS-Office365-Filtering-Correlation-Id: 3796646e-3569-4a60-b2da-08df4c7dbdb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|11063799006|261009223027099003|18002099003|22082099003|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	ITeSzFj0dWm3lv/rFJ5k6ZiWHCLyyNvI9WHcjgBPLGoNCXF1/9RMyAa00o8E+9YBb9WWo95XiRwUwKBGOn8wqqNNbRcmkNZIeE4+jE0W15PjpjixSEdZX0Vw9y0xXl9dN/YgwtoSVX+CMlUnhnfjwCB+e+XNYurgCEnneAwyW2AhBm09EXx6HSZLHWIbsTCYP7MclyT6rK3kE17LSvHMjCbXtK3ygIv0PbdXXPQkVrfYcsbyy4BRlvynzQUAFfCMr87mZ+PPyvmoBcRmUxe+OXkg/lr3ZU3+Q+UHkcFyzKTPsaJwAjQ2ttDYRIU4K1xv092pvefWbemza0i2mnlS3t3k8Uz2WUUekIRig0VbPwERGlkJV68/0B4o+yRgApEttWymBTIAxFJz69746a+MbHUkkJ+PAGAb1hviyvTeCPBFST+Av6DV5klbzP9tdvqt5nwmMaM1j6tp5WfJVLqKDBVNl/1QsGICWqc5twGZ9q8+YxgctKNz2umcJ4qdWyJoRwS1wRdSic1+u1PhWCVYf3QO7rGmkimuurO4Yl9MkR+sntdKvfcz6EABQunETrybXU2dnf9qzfZrR0UJpIUNrBCAkwbLUpd/IIX5aJWl0Dqla7oiTPFPvfSJmEZclsdEj0C06JTl9w/nSbVqfuECnmcHelGrLDJtTPXuDLbdv5TiS0R2fFvpYwoOSRBhDOvY2RBvSN4oc9xEuckTkl5ZXg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(11063799006)(261009223027099003)(18002099003)(22082099003)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aRyeSpj/wpb1cRIDUBmwjA91YKcV2dGPObg7SpKwF7R4IN8jnOGGjHY3k9BsVWK4xvyPNmVsd99agS20VI1Gc8wk8BqbXrRIvkOz5Q/pdXjK1G7kyVyD5VgL1+k39eFRUdJDUsycB0fVDsp9+6pGlBLn2uIDRNTUYTeBuDLZGbKodSczZfbRmq//LGycK6gFzjJ4uzvafw5zdH8ILiqeF45hSuXM57VhYSyHFsC48FV6M/LX55dXFRF/Eg2KdhW7uPl8+ot+pfGwn2Si7HTEbPxpZFhxBPrQfbbUgLli+NFn6RuRFHdn+s39Nr3wIMXuJQXPuEMxP4iG6HVpxWpaDg1zvBkko8wB3+noGlYl4NrKBx4zui07Ea3G1MvJV+M6zWW1FM5XlBIdjhjLAT59QKY3zoB2qiPzNKJgnddw7yU3DRWPJxlteqJHJapyzdVL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:58:24.6570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3796646e-3569-4a60-b2da-08df4c7dbdb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF0000004B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999266

amd_iommu_remove_dev_pasid() can return while a page request for that
PASID is still sitting in the hardware PPR log. The PPR thread may later
enqueue that request after the core has already freed the PASID attach
handle, and the IOPF worker then dereferences the freed handle -- a
use-after-free.

The device driver issues a PASID stop before unbind, so no new request is
generated for this PASID, but requests already posted remain in the log.
Process those entries and then flush the IOPF workqueue so that queued
work completes before the handle is freed.

Serialize PPR log consumption with a new per-IOMMU mutex (ppr_lock):
factor the existing poll into __amd_iommu_poll_ppr_log() under the lock,
and have both the PPR thread and the drain path take it.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h |  2 ++
 drivers/iommu/amd/init.c            |  1 +
 drivers/iommu/amd/pasid.c           | 10 +++++++++-
 drivers/iommu/amd/ppr.c             | 29 ++++++++++++++++++++++++++++-
 5 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index c6adaae048b5..bbfe92356b47 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -82,6 +82,7 @@ int __init amd_iommu_alloc_ppr_log(struct amd_iommu *iommu);
 void __init amd_iommu_free_ppr_log(struct amd_iommu *iommu);
 void amd_iommu_enable_ppr_log(struct amd_iommu *iommu);
 void amd_iommu_poll_ppr_log(struct amd_iommu *iommu);
+void amd_iommu_drain_ppr_log(struct iommu_dev_data *dev_data);
 int amd_iommu_complete_ppr(struct amd_iommu *iommu, u16 devid, u32 pasid,
 			   int status, int tag, bool gn);
 
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 30dc9495e3ee..4b683026e9ef 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -691,6 +691,8 @@ struct amd_iommu {
 
 	/* Base of the PPR log, if present */
 	u8 *ppr_log;
+	/* Serializes PPR log consumption */
+	struct mutex ppr_lock;
 
 	/* Name for PPR log interrupt */
 	unsigned char ppr_irq_name[16];
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 61e7b70fb063..7301359dcf4a 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1973,6 +1973,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 	iommu->pci_seg = pci_seg;
 
 	raw_spin_lock_init(&iommu->lock);
+	mutex_init(&iommu->ppr_lock);
 	iommu->cmd_sem_val = 0;
 
 	/* Add IOMMU to internal data structures */
diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
index a5ca5c2b8241..d0e2bf7921bf 100644
--- a/drivers/iommu/amd/pasid.c
+++ b/drivers/iommu/amd/pasid.c
@@ -154,9 +154,10 @@ void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 				struct iommu_domain *domain)
 {
 	struct protection_domain *sva_pdom;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	unsigned long flags;
 
-	if (!is_pasid_valid(dev_iommu_priv_get(dev), pasid))
+	if (!is_pasid_valid(dev_data, pasid))
 		return;
 
 	sva_pdom = to_pdomain(domain);
@@ -167,6 +168,13 @@ void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 	remove_pdom_dev_pasid(sva_pdom, dev, pasid);
 
 	spin_unlock_irqrestore(&sva_pdom->lock, flags);
+
+	/*
+	 * Queued faults reference the attach handle, which the caller
+	 * frees once this returns. Consume requests already in the log
+	 * and flush the work they queued.
+	 */
+	amd_iommu_drain_ppr_log(dev_data);
 }
 
 static void iommu_sva_domain_free(struct iommu_domain *domain)
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 795e31735fea..6d4b29905d40 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -203,10 +203,12 @@ static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
 	pci_dev_put(pdev);
 }
 
-void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
+static void __amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
 {
 	u32 head, tail;
 
+	lockdep_assert_held(&iommu->ppr_lock);
+
 	head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
 	tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
 
@@ -250,6 +252,31 @@ void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
 	}
 }
 
+void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
+{
+	mutex_lock(&iommu->ppr_lock);
+	__amd_iommu_poll_ppr_log(iommu);
+	mutex_unlock(&iommu->ppr_lock);
+}
+
+/*
+ * Consume PPR requests already logged for this device, then flush the
+ * IOPF work they queued. The caller is releasing a PASID attach handle.
+ */
+void amd_iommu_drain_ppr_log(struct iommu_dev_data *dev_data)
+{
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+
+	if (!iommu->ppr_log || !dev_data->ppr)
+		return;
+
+	mutex_lock(&iommu->ppr_lock);
+	__amd_iommu_poll_ppr_log(iommu);
+	mutex_unlock(&iommu->ppr_lock);
+
+	iopf_queue_flush_dev(dev_data->dev);
+}
+
 /**************************************************************
  *
  * IOPF handling stuff
-- 
2.31.1

