Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013068.outbound.protection.outlook.com [40.107.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A620E2D8372
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 06:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768457333; cv=fail; b=TzyrD7Dxy49OMiGe/VM0ZIyx2RnDMv9YxxHxsPN4DP5QCypn1aovejY1e6CeMpQHCJALXnbNGUmmNY6oLR/Yplp8aVDSTM7ajRcFSfwaibsnDSANH5SgWBvvMuwweBYi0xwrRwI4SBYZ4uSSUjlnTyafJp7Hn/DgBL8DzfGFynA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768457333; c=relaxed/simple;
	bh=vQ6IoML/DhdYApLzeMC8xJuOI9IMVhN/sPzoem+g3Gk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cD9yiZ2iyVE49uOZhTXebmKrd7htamV6G0tHGYbwjLJtiNesPKaPVwfxwIz29H9OY7i3365pupM7nn5d7rKCo9oehRBJ+2BiuCLEOm4ufHNsS4K/LKT6cQKmVoEOATuiw84+AcM0q5k2O/aN8KaR/NoM+vMf9YVNL7JyhoLJl6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dNwtKqka; arc=fail smtp.client-ip=40.107.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dNwtKqka"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkGdoXjm7FGfeHdLFSUwQZEIXVcP2OnDsfj+55/phS/i/1tySyxQe5Vit7RC9fLRwqHFn1Xw+2aC+yLO1aI9ZPgQDSeKuiA1Foil371Lwt/ZjdgI/2yurNDxKpRMrILsCnIfKmFU0LM67O7+kkbSwyDvkQZ5vbIjJKWFXZ0ZqDPU16BInATcNQLftGVeeX1MPAynXF1F/uLIBr5eIchuuAcbUChTnUbfFnTcBaMrFYh9zYD5EBcInftXdGGi3VD7hHEFywiKdVEaHfIdNKC5mesxs7FM8PkaXWg1Bcv0wO66DTYqvBKnjzKVtvVIzjMxCwFuUOrYIzdrdthuRoeEnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11vXy0dUWmIsjTfMzv22F29PqkoHLYFUGa8M+x05V5I=;
 b=BfXgyVPRTJ+7lE609bca3YNT4ohgqjzTxCqy0jUekBDKnY+4mAt66mGY/9Cs8JPXjjHoxDxfv0Zg9IO8Ni3XnwqdKg+xeARjMe1C9bFpO/e7e2Pi5Pbyn1OGjkvtNhKfPgj+SOEIebcwQWGxywn9KnZfI02HrOba1IUxOpWLrNln4tmaMN5PHOZ9Du0aO/aQlwwuwtiqdpBpiTI3OX/4truSA3iD7TcVy2wjFxtvLOZvMM6MaVY4SwJEvrqtmKNIdQLkswVRTeYlMvDtYiC6mQT22YPrERqFLZW542/e9Of7XVo77En3g8D3WdsesWxY8KZD9wIFvtGIUM3GPYB0AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11vXy0dUWmIsjTfMzv22F29PqkoHLYFUGa8M+x05V5I=;
 b=dNwtKqkaxgASbC2U82zgcW3pIRaZpxwrKPY4oFtpNLeRzE1M6fdPOUzpv1wjHcno8gT1L1x2A7xbZoohnIlOsMENtjADoit22U48hTmbctjFU0sT87Q0RMUV4riJ6BzyMfR4nEmRCfY8dlNdZcsFW59XQOAsdEXuM8AYfqGLh3Q=
Received: from SA9PR13CA0050.namprd13.prod.outlook.com (2603:10b6:806:22::25)
 by IA0PPFAF4999BF6.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 15 Jan
 2026 06:08:48 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:22:cafe::72) by SA9PR13CA0050.outlook.office365.com
 (2603:10b6:806:22::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Thu,
 15 Jan 2026 06:08:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 06:08:47 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 00:08:41 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 02/13] iommu/amd: Rename DEV_DOMID_MASK to DTE_DOMID_MASK
Date: Thu, 15 Jan 2026 06:08:03 +0000
Message-ID: <20260115060814.10692-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
References: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|IA0PPFAF4999BF6:EE_
X-MS-Office365-Filtering-Correlation-Id: 6577963f-c5ac-4a2f-7e71-08de53fc8bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B3bJzS4BXfZuBx+DEPaiGajzhXBBizTXyLRxKGr4h0EFwtrjXJw7VwMPPu2J?=
 =?us-ascii?Q?v+hwYhzjx5pV7ab7blTwCF5GguoF457po9pNBkAZyrtSW+8ozQ2KOKuqbR9o?=
 =?us-ascii?Q?MMRXCh6IJEeylUcMy/RstemBYFvDq7UGOA79yNPkki6+3KP5BqWixbrkOxVr?=
 =?us-ascii?Q?U/zzgKnc4iANoaaxXsfQ7HJw05qiWrU0v8ERY2vBSoQf3aKFapPRu4mSgvqx?=
 =?us-ascii?Q?8xKsAGKWzO4SYRSxxtlUI/fAZOegEQ6xW6/mottJvBfsWs4nxA31+tQnlN7p?=
 =?us-ascii?Q?iUaYTskBYN6+LVI19IetE/GessKQPsSJyD6+Ox3x1p+ZvzVXoPp/f26XInB/?=
 =?us-ascii?Q?/9Zp6313o8eNvKtXLb2QMS0H8UkxCED9eATbOQXR2StE2YBG2Pvu99h4cb42?=
 =?us-ascii?Q?rD7oyWA1816xVvDqls05CwzlIti9MvklK3kLDh84o0nfxjb1eVl+oj14jtJc?=
 =?us-ascii?Q?tBvxMWTRa2aCl0TjeXfbw3SEq2peKS6KeVjh9pPcyxzZHRTkiVvPr2g0HgQt?=
 =?us-ascii?Q?t/iFb/V3tBLWla88Ts2rSiY+rAYKyUGz8fMHkwgMAZjc+ooMWHIaTZfCg29r?=
 =?us-ascii?Q?MnGAI0YfQypt88ru6YtwQr/itE6bXj0mZWHc47o22oVeUHK3afSzI7Zegx0F?=
 =?us-ascii?Q?c3uHkI+IWSPEHJyCfXFQW1B0PYcSRXjTbRwMQ52DCSnLOvsD/zrEfPRbafQ0?=
 =?us-ascii?Q?DVPjzIySDdOy6ief5SOIjraemVAso+WS3LVaH8882i/6yaeobB38Yf9E4e74?=
 =?us-ascii?Q?yDNLB+n7L+Q+68YtRrp3VZXcbwFxbNLTEBEWU+ID+GwYQCsWW7B7fSyP4Axa?=
 =?us-ascii?Q?oHlG+5p3tKszVpo/xfiKEd/EOo3Em+koWdA04KQ7/msmQ09KES/kW4fBVsbr?=
 =?us-ascii?Q?kR7e8heVGLnJEaoLNEf176FX/CZHudADUAtDZGe1M/yuEUyw5HoyceI1KwH4?=
 =?us-ascii?Q?Hi/hrHGqyyMrlUqim1QMldD6r84MW267XZ4Mb2VtzN9E3BIIVN10DWkI0nh6?=
 =?us-ascii?Q?NL2iboI3Jf+hBZdLf0FkE38mKupm+hw3uervKq9u+/wOrJ4IHg53UKD8brGL?=
 =?us-ascii?Q?8erd5R1ud2Sry/S19wIXhzxkjc1ta8aNfP5Pvr3bwhxr6ZhI0Pa8jY3j/IWh?=
 =?us-ascii?Q?xpBbEbABEhvl9KmE1phLer9eavpIez9arfiaCWOYfxTrAkxQDQAcR4Kayi9D?=
 =?us-ascii?Q?yUcRegrcrO7UBLgOteZIzJNqm4eMDyZkz5cWSDkBerGAx9WAnOU9JGvSPBpT?=
 =?us-ascii?Q?suRJJZp+AfPqyKY2zPmizHSJu5DLgJD4xmCkl+pPkhI8adw7LpdIzOllB4gq?=
 =?us-ascii?Q?4xOaer/iOzXMlD4P8ulDhG2derSeN+gxXD0ho/Xd6iDbDMvQ+i51nZqLajlf?=
 =?us-ascii?Q?tXW+LjYFmCt8fS278V9HPj9HXxjFKMJUjNwXPGDle4fdJyb/rSmaHk/Utsom?=
 =?us-ascii?Q?igJ6VIirttl3k6CZUOd9cc51KpnX7HZqhLt7srW6XOVrgvrTp5LdXaQES74D?=
 =?us-ascii?Q?AVJSH0eGjQV84qNSGswo6waohIdu/p99iY20QHnah63Neq0pHOFScw6kXzrr?=
 =?us-ascii?Q?QpbUvl08ZrLSmsE6RZUD1bE6SQRV2kqSQ4R+/pZWIAm2GfZdSnOhIioUDYzP?=
 =?us-ascii?Q?DBWt5JoqgXkkAR8rW0Su+qvj/uS8tOhVzks0tTGE2Ge9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 06:08:47.3935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6577963f-c5ac-4a2f-7e71-08de53fc8bbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFAF4999BF6

Also change the define to use GENMASK_ULL instead.
There is no functional change.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 2 +-
 drivers/iommu/amd/init.c            | 2 +-
 drivers/iommu/amd/iommu.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 320733e7d8b4..14801d734684 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -358,7 +358,7 @@
 
 #define DTE_FLAG_IOTLB	BIT_ULL(32)
 #define DTE_FLAG_MASK	(0x3ffULL << 32)
-#define DEV_DOMID_MASK	0xffffULL
+#define DTE_DOMID_MASK	GENMASK_ULL(15, 0)
 
 #define DTE_GCR3_14_12	GENMASK_ULL(60, 58)
 #define DTE_GCR3_30_15	GENMASK_ULL(31, 16)
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 384c90b4f90a..cfbc9ff105c3 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1179,7 +1179,7 @@ static bool __reuse_device_table(struct amd_iommu *iommu)
 	for (devid = 0; devid <= pci_seg->last_bdf; devid++) {
 		old_dev_tbl_entry = &pci_seg->old_dev_tbl_cpy[devid];
 		dte_v = FIELD_GET(DTE_FLAG_V, old_dev_tbl_entry->data[0]);
-		dom_id = FIELD_GET(DEV_DOMID_MASK, old_dev_tbl_entry->data[1]);
+		dom_id = FIELD_GET(DTE_DOMID_MASK, old_dev_tbl_entry->data[1]);
 
 		if (!dte_v || !dom_id)
 			continue;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b6154c73e514..2ab0f3c98425 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2116,7 +2116,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	if (dev_data->ats_enabled)
 		new.data[1] |= DTE_FLAG_IOTLB;
 
-	old_domid = READ_ONCE(dte->data[1]) & DEV_DOMID_MASK;
+	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
 	new.data[1] |= domid;
 
 	/*
-- 
2.34.1

