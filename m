Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49BF1B86D1
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724954902; cv=fail; b=pmIgrHib6tIGGgqz8vs7ug2fbX2yymhcRAuuHeffmkC3dwoUwQrVf8ldbWsHFquFp4GlmyAj0rFDqEae4VxRkOfZ2ISG3g8AZjLDXNDvnrRlDAEAl+rQZxsOuBR8lUbGSCrZ7wRK2rayg0UWx/Dl2FGue/DiMbN1d1S/mjLQAuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724954902; c=relaxed/simple;
	bh=QQeUaxo9BcJQdBNyLUwTRqO0jBCk7Gtjx3YfD/RChoc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vApNTt0/U4vdTsFmNWB3i7JVrWDvNgI/sinHKeG0mYZaNn5YyEHCHgeP1i+eOossKNgaylttOEK+x+gusDdNzLEQsA+DliM6KTMZBd1BmnBbXkhNKbv9s/25xPviF38FuwV4ewuzLlV9xz9sS+sOqrt5wZJzePRF/Xkgop6qA2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jrG/HZNE; arc=fail smtp.client-ip=40.107.212.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jrG/HZNE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRgJ1MIWCmow6xUxmycjFcWO2mqP56fSRwkN3hbY9udjZVZ0U7uFAok9TPzfoD1bUJjoK5/LsNbh6QY+eC/Mpepj+co0TKdC7c/vOmJ0UqiTvUZz6CX5lmSWGIDShm/NKCgrJ1h39VDUMUqqAeOiLCo6gZGVqjZ1lr1MmL2SkjMWDuEOVNxCnaEHQColEjkSuBMjv5PC2JJvnI3SNYh5rNTqNT6yJVGK3OI8Lgxfz9ZkESfQFuX1b0Rtk1Br6zdl9nah+8DoHuh54rJcDEsIDPutmEaqzhD7S1Zb2AESuAOi3gcvMFA/SkeVTVjxzbCUlHvxRf8/9mNlLvEsaQvtsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vek6uzcrlkQrVm1VPeOyDMoTvLA+7kc9SnzCJZUUGNw=;
 b=YY9hipx5BOMBarjs/g/bZMbyJz0nNot1SjcGURqg/f51ajoNILpWnpdWu++25hr+3tAJfPR/6aZjTsy+Vf/shaCm9znSJc0OT1nCqqCrejaTjZ32tBjcQyttCpKNs2ms/LkSdQuWgQCES7jGPTk7AXxhLiFvnMSLPI7SUt6HiXATEiKjKlVA0ccUS1YTopUDZ/bOMFFHziC/oUZagerdrNN5mPvdXnXYAKBHIyrq9Zzx7l2+/rgLBlB4v8G5dZMBXUwDuW8crXCm6aSpFqdeFy8+V2jAp9M0WDVe96m85kulfpIihHogBdsFoP8z+uprvbX9dhF+Jgt2W3GjSX9HqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vek6uzcrlkQrVm1VPeOyDMoTvLA+7kc9SnzCJZUUGNw=;
 b=jrG/HZNEWkqzqSdrl3lZ77bXmtM5zu0QPhFSOTIwJ/KtCd3YVeROC13NPGsjw76z/9CJLMlQpdKd82ts40V4vvGK9DzS/LzzUoanm6Ozzj5A8sDhOEErypa2nbQwfwA1FxXgsZMqSfF5enkki0mW8XnmrPtBVz6TRUsQpxjpgUo=
Received: from SA9PR10CA0026.namprd10.prod.outlook.com (2603:10b6:806:a7::31)
 by IA0PR12MB8694.namprd12.prod.outlook.com (2603:10b6:208:488::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 18:08:17 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::b5) by SA9PR10CA0026.outlook.office365.com
 (2603:10b6:806:a7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Thu, 29 Aug 2024 18:08:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 18:08:17 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 Aug
 2024 13:08:07 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<ubizjak@gmail.com>, <jgg@nvidia.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 5/5] iommu/amd: Use 128-bit cmpxchg in set_dte_irq_entry()
Date: Thu, 29 Aug 2024 18:07:26 +0000
Message-ID: <20240829180726.5022-6-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829180726.5022-1-suravee.suthikulpanit@amd.com>
References: <20240829180726.5022-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|IA0PR12MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: 49aaa959-2f01-4d47-d3c8-08dcc8558efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EbKql+TREVSBuYT0gTjvzQaWTd96OqVegWf7U3JejAtuEEDDNXaqf3+vwgWV?=
 =?us-ascii?Q?2t2U7xLJcREHJvV/XUoKqNQV14wmVc26tNVYBMkcgy4nLZiAjiV9E2tMUu48?=
 =?us-ascii?Q?klX8LDSqt7oKeqKgdEEkei9AXyABRNPmU+++Pyy/FLs/h/sVT50gJ8eqNfgp?=
 =?us-ascii?Q?5K5DGtMXPvZlqCBMV9dyOmrVMybVg0vyq2u5DdEAT1XYBlSzJKaS6ctbZXHx?=
 =?us-ascii?Q?DS5GlNmhAKsXUgoIXdPzeuEh8ayIE9O3A578EDTYlOaclPrxY6PBS8KINhgx?=
 =?us-ascii?Q?owclNEQoPFuXp+oUddT41noBj0TEWuIoq+g4TO/CPtNtBMscXrELNoOlcVHS?=
 =?us-ascii?Q?iELzbomjsr/u0ABgFGKh0LqEMcgQRhTKfcMOF8KHCdsPCl7mwenVx1MKO1dL?=
 =?us-ascii?Q?J+AI1s8pht2FJ4w9HMsfrNSWxbuG07l1IKFzhoa2G4leZzoyN7eIsC0abpIn?=
 =?us-ascii?Q?oSFg/ufoU2oHY8COJ2PMJD+g0cXL7dBusQJI+dBg4ma6mTBpcg1egRX/xB3l?=
 =?us-ascii?Q?3ixY5yH2WyYAj3TE6guXTIOTqfGmqnD33tUUom0akZst5EAJqcBPpOxMF2+z?=
 =?us-ascii?Q?GVn7O2c3GJtfagQ4pHMy/F8ZGf03M4LAjHG60WgsaIQN7btov7VnaaJnJY+V?=
 =?us-ascii?Q?hRl+E5MPyCa2oUl1S8LC+xIIicvk/1kbnApbiiBfTyvp0ohvHeecTjVdwJ7p?=
 =?us-ascii?Q?3pSteJKFhmmCRfMvEbcGjySOZRzvlv2s4RaH+UzKWYXNvQYljSUnwtcbO0Nf?=
 =?us-ascii?Q?30USomckXrkHtYbxqS7QPKGfLVlSvtjHBtIM46d5I7/Ho0Y+wXBc7sMF3blx?=
 =?us-ascii?Q?02Buz2aS3klM23ODkZ+EvHbvrl2iaq5GcOFelh6rIfd6JVgKy/88wj9PpZdR?=
 =?us-ascii?Q?y6rCzj/sqD10iO7UHF0x1KEw20T3hg7+cp40zu8AhCN2G/SLpPqj7QniCUP9?=
 =?us-ascii?Q?aYCjJPswI/SWPDpCGsXBOqQed+phmf6j/7/Rp9Ky9xB9d5o5I8hMbCkgZIdf?=
 =?us-ascii?Q?SerLz9p6mGBiLXysHH6Mbp+6FIZSfYJhkfbQ95svhnod1sIyKWEiEvtCq6jG?=
 =?us-ascii?Q?X044vgTWP7a29EKhmb8Kwj8+4G1EqW+iiAqawSZjfYPzkJGChm77tgtO2YyI?=
 =?us-ascii?Q?ELOZorjKSlwlpVYm2WA6rQkMyPKMURD2BS5rpuQa9qxiMi1vdei0uL0zIu3X?=
 =?us-ascii?Q?OT84JbFLA4au2YxXas3LNBJf52HiuSVqAaNKrjZYBdpRm9yyGDGnGVp9ygy3?=
 =?us-ascii?Q?O6buWSXV1J9uVk1/LusksIWjq2YZNgonWyfB0A3rxXBVAiU6+rdriR8yYKMP?=
 =?us-ascii?Q?b8Mx8FGgJH3RgRHEo0fP+rp7Mjg0O4d0USXnCP+MMbBtu/RIG3uGGnd1d2Lg?=
 =?us-ascii?Q?hwHNR+SQQGrnDkHWMlNlL+IapagqLwu2jjTF1sMTjYiAYYX60HJNPOgTD4BM?=
 =?us-ascii?Q?5bjd5t2MKB1LsAMCKL02K+V91R/quhgD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 18:08:17.3820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49aaa959-2f01-4d47-d3c8-08dcc8558efc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8694

Interrupt-remapping-related fields are in the top 128-bit of the Device
Table Entry (DTE), which should be updated using 128-bit write based on the
AMD I/O Virtualization Techonology (IOMMU) Specification.

Therefore, modify set_dte_irq_entry() to use 128-bit cmpxchg. Also, use
struct dev_data->dte_sem to synchronize DTE access.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a24986c2478b..4eb53bd40487 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3020,17 +3020,24 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 static void set_dte_irq_entry(struct amd_iommu *iommu, u16 devid,
 			      struct irq_remap_table *table)
 {
-	u64 dte;
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	u128 new, old;
+	struct dev_table_entry *dte = &get_dev_table(iommu)[devid];
+	struct iommu_dev_data *dev_data = search_dev_data(iommu, devid);
+
+	if (dev_data)
+		down_write(&dev_data->dte_sem);
+
+	old = new = dte->data128[1];
+	new &= ~DTE_IRQ_PHYS_ADDR_MASK;
+	new |= iommu_virt_to_phys(table->table);
+	new |= DTE_IRQ_REMAP_INTCTL;
+	new |= DTE_INTTABLEN;
+	new |= DTE_IRQ_REMAP_ENABLE;
 
-	dte	= dev_table[devid].data[2];
-	dte	&= ~DTE_IRQ_PHYS_ADDR_MASK;
-	dte	|= iommu_virt_to_phys(table->table);
-	dte	|= DTE_IRQ_REMAP_INTCTL;
-	dte	|= DTE_INTTABLEN;
-	dte	|= DTE_IRQ_REMAP_ENABLE;
+	WARN_ON(!try_cmpxchg128(&dte->data128[1], &old, new));
 
-	dev_table[devid].data[2] = dte;
+	if (dev_data)
+		up_write(&dev_data->dte_sem);
 }
 
 static struct irq_remap_table *get_irq_table(struct amd_iommu *iommu, u16 devid)
-- 
2.34.1

