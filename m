Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E00DDBF
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 10:07:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lykT1tw2c9ZxgKcQPGL+WWFuKalA6JJAMA/xVSL72na4QoT9LPk7A5L8oDnVokWS8NN45UJ1VC1ps+QLpanZgWbqPgECwpbq0N+H1v6yUtvu/jtW7vkMI9p7xbbIGHL8/bMKsoeuahkvnM7LSibUItGeYlqHWowIz4SYF/yzOCnxZIFE+PrLXYBSvHIB+2yFdewihqVJAAl13p9RZqk5l1RR687L+ZzPM/vIprnZxxFTATCpJxRhMYeJ1mUopy/JHnT7i6JjJMQHZnqfs+bRlyPR8uXjFOY0mVIbYRQrciBLMb9AZ7AYeAevnP+bBHpTPPHt9oVKMB6/S3qbdyT70w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sj9m1XiHkzYVOnzNy2t8lvT7IzAh8J4O2BV3QMxSNzQ=;
 b=bytMcABlz4qDwNV24Q6s2HYGaAFu4xr5OLEOlmU/ypQkSJVLL3l5gcwvq9FfJZoPFoF7nygj4YUxnIZdwX0kzeZarVBOtac3IWtTsVr/yApLgBtCItW4uCDOAFq2SvmCq1RJMHIgmR9s3gY+h7bjnp6o/X3dsuDo1q1eFXwoMoud7Ho7k0Wl4uxlhwnl5vSSZW8vliOpC9R/KuYd6EfRTLPq7zFQMGVyN8r9f+fMM76g4zTOVnPwxX1+N573u5zfFNP2ekcsF906SxZzG0Y44F0ZGq6/GSVpdApmadYzs+6bbAi0HEV+aV4NbMOn0HzUJmGyiORoZn9HYko4NPDn5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sj9m1XiHkzYVOnzNy2t8lvT7IzAh8J4O2BV3QMxSNzQ=;
 b=AtEDRYWRHNFAllMNvYN67HNYJ9SUHCoGMeC/Wj1jXHvvQe1CNebu+ppzJh7kOing7rSRWumPjqQwLAjWkPz2QzOqz8/xKXIcwemSjg5qEzE8cHNJ2lWTi7JwQ3meRwEzra/g8DPkEG6D34ZFpnLIDRNwLeCveCDTbaWg4QlriU4=
Received: from SN6PR2101CA0012.namprd21.prod.outlook.com
 (2603:10b6:805:106::22) by CYYPR12MB8854.namprd12.prod.outlook.com
 (2603:10b6:930:b8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 10:07:54 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::68) by SN6PR2101CA0012.outlook.office365.com
 (2603:10b6:805:106::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.18 via Frontend
 Transport; Tue, 8 Aug 2023 10:07:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 10:07:54 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 05:07:51 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 08/11] iommu/amd: Refactor GCR3 table helper functions
Date: Tue, 8 Aug 2023 10:02:29 +0000
Message-ID: <20230808100232.5977-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808100232.5977-1-vasant.hegde@amd.com>
References: <20230808100232.5977-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|CYYPR12MB8854:EE_
X-MS-Office365-Filtering-Correlation-Id: e8800049-a8d7-47e3-d280-08db97f75504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZAQAiQOJLwDoE4L3oeoQNJfeNKGsxGn6MkUrb993uI233OpiXOKo2ChENS8kXzLZMtZj/yiKcMPGeZQR3HDDULuKyk7RHe4r44UEbqiIYT63rAv+m2gkKpZ4EVLCvYCdIpu/L9FzOuBotVe1wiEkUA5B7VCyPdRMXFauJ/mtUa4tUdJBm9JJerMqlcHQ00ftSH8gBkSyjoml333objYMfEmD7G96ixYxR9dNxiXrholu06k0W6g96Pma41hjnbwSNIGJy4lXKA+P7Hi1KvwGYrtiGdMGTg1UnXhXpfFFLL3K88oJZmufX4Ndy1XgkDN2ZGIrJ7Ug03bfETzoV0YRr7EqLyxeHzenfTTf0dUIDhcFvY3hfED+zAbnTIBJbW7o1KujTB/h/sYXOT0o4T1J9BJGirZEsUP87YhsgVH+wjQkbbe7pDE8FGzGHMc2zc+m0spvrC0/dOcWtD25OoimZv3W//eoyx+XD/N85cIJROCdghxZhvWduArmkZJIq8t5iCxZz0nEDjfYSLjP+0Vjj5PyxYTV8TI1QVh8juMjxz/yDQpMrmTjXj9hO2fJ26tCdBnVworaWf0Wq6g5UOljQyUqkoNG08Oun3VIUN4dKPC4zG0ejR3k5Pr2cTtvaKBYpbyBAlXxMk7Eb6Nyq2DSQiKz0XT2va2toygcEQuaIyevhD8OuZAo/CKSJ58JXf5PD4YUdfxVfluiIQ060SRC/AIexlmfO26UpqzA9Y5SzejkGc8IGwUaczMu/FTGp2N26jmfLIjwumpL75egh7ChTQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(186006)(1800799003)(82310400008)(40470700004)(46966006)(36840700001)(478600001)(7696005)(6666004)(26005)(70206006)(336012)(70586007)(40460700003)(36860700001)(316002)(4326008)(47076005)(110136005)(54906003)(83380400001)(36756003)(5660300002)(2906002)(86362001)(40480700001)(2616005)(16526019)(81166007)(356005)(1076003)(41300700001)(426003)(82740400003)(44832011)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 10:07:54.1526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8800049-a8d7-47e3-d280-08db97f75504
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8854

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To use the new per-device struct gcr3_tbl_info. Also modify
set_dte_entry() to use new per device GCR3 table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 75 +++++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c9318be9fe4e..bba2034a28f6 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -78,6 +78,11 @@ struct kmem_cache *amd_iommu_irq_cache;
 
 static void detach_device(struct device *dev);
 
+static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
+			  struct gcr3_tbl_info *gcr3_info,
+			  struct protection_domain *domain, bool ats,
+			  enum ppr_handlers ppr);
+
 static int __set_gcr3(struct iommu_dev_data *dev_data,
 		       u32 pasid, unsigned long gcr3);
 
@@ -1679,16 +1684,27 @@ static void free_gcr3_tbl_level2(u64 *tbl)
 	}
 }
 
-static void free_gcr3_table(struct protection_domain *domain)
+static void free_gcr3_table(struct iommu_dev_data *dev_data)
 {
-	if (domain->glx == 2)
-		free_gcr3_tbl_level2(domain->gcr3_tbl);
-	else if (domain->glx == 1)
-		free_gcr3_tbl_level1(domain->gcr3_tbl);
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	struct amd_iommu *iommu = amd_iommu_rlookup_iommu(dev_data->dev);
+
+	if (gcr3_info->glx == 2)
+		free_gcr3_tbl_level2(gcr3_info->gcr3_tbl);
+	else if (gcr3_info->glx == 1)
+		free_gcr3_tbl_level1(gcr3_info->gcr3_tbl);
 	else
-		BUG_ON(domain->glx != 0);
+		WARN_ON_ONCE(gcr3_info->glx != 0);
+
+	gcr3_info->glx = 0;
+
+	set_dte_entry(iommu, dev_data->devid, NULL, dev_data->domain,
+		      dev_data->ats_enabled, dev_data->ppr);
+	clone_aliases(iommu, dev_data->dev);
+	device_flush_dte(dev_data);
 
-	free_page((unsigned long)domain->gcr3_tbl);
+	free_page((unsigned long)gcr3_info->gcr3_tbl);
+	gcr3_info->gcr3_tbl = NULL;
 }
 
 /*
@@ -1703,27 +1719,35 @@ static int get_gcr3_levels(int pasids)
 	return (DIV_ROUND_UP(get_count_order(pasids), 9) - 1);
 }
 
-/* Note: This function expects iommu_domain->lock to be held prior calling the function. */
-static int setup_gcr3_table(struct protection_domain *domain, int pasids)
+static int setup_gcr3_table(struct iommu_dev_data *dev_data, int pasids)
 {
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	struct amd_iommu *iommu = amd_iommu_rlookup_iommu(dev_data->dev);
 	int levels = get_gcr3_levels(pasids);
 
 	if (levels > amd_iommu_max_glx_val)
 		return -EINVAL;
 
-	domain->gcr3_tbl = alloc_pgtable_page(domain->nid, GFP_ATOMIC);
-	if (domain->gcr3_tbl == NULL)
+	if (gcr3_info->gcr3_tbl)
+		return -EBUSY;
+
+	gcr3_info->gcr3_tbl = alloc_pgtable_page(dev_to_node(dev_data->dev),
+						 GFP_ATOMIC);
+	if (gcr3_info->gcr3_tbl == NULL)
 		return -ENOMEM;
 
-	domain->glx      = levels;
-	domain->flags   |= PD_IOMMUV2_MASK;
+	gcr3_info->glx = levels;
 
-	amd_iommu_domain_update(domain);
+	set_dte_entry(iommu, dev_data->devid, &dev_data->gcr3_info,
+		      dev_data->domain, dev_data->ats_enabled, dev_data->ppr);
+	clone_aliases(iommu, dev_data->dev);
+	device_flush_dte(dev_data);
 
 	return 0;
 }
 
 static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
+			  struct gcr3_tbl_info *gcr3_info,
 			  struct protection_domain *domain, bool ats,
 			  enum ppr_handlers ppr)
 {
@@ -1755,9 +1779,9 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 	if (ppr != PPR_HANDLER_NONE)
 		pte_root |= 1ULL << DEV_ENTRY_PPR;
 
-	if (domain->flags & PD_IOMMUV2_MASK) {
-		u64 gcr3 = iommu_virt_to_phys(domain->gcr3_tbl);
-		u64 glx  = domain->glx;
+	if (gcr3_info && gcr3_info->gcr3_tbl) {
+		u64 gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
+		u64 glx  = gcr3_info->glx;
 		u64 tmp;
 
 		pte_root |= DTE_FLAG_GV;
@@ -1785,7 +1809,7 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 				((u64)GUEST_PGTABLE_5_LEVEL << DTE_GPT_LEVEL_SHIFT);
 		}
 
-		if (domain->flags & PD_GIOV_MASK)
+		if (gcr3_info->giov)
 			pte_root |= DTE_FLAG_GIOV;
 	}
 
@@ -1835,7 +1859,7 @@ static int default_gcr3_init(struct iommu_dev_data *dev_data)
 	 * By default, setup GCR3 table to support MAX PASIDs
 	 * support by the IOMMU HW.
 	 */
-	return setup_gcr3_table(dev_data->domain, -1);
+	return setup_gcr3_table(dev_data, -1);
 }
 
 static inline void default_gcr3_destroy(struct iommu_dev_data *dev_data)
@@ -1843,7 +1867,7 @@ static inline void default_gcr3_destroy(struct iommu_dev_data *dev_data)
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 
 	gcr3_info->giov = false;
-	free_gcr3_table(dev_data->domain);
+	free_gcr3_table(dev_data);
 }
 
 static int do_attach(struct iommu_dev_data *dev_data,
@@ -1884,8 +1908,8 @@ static int do_attach(struct iommu_dev_data *dev_data,
 	}
 
 	/* Update device table */
-	set_dte_entry(iommu, dev_data->devid, domain,
-		      ats, dev_data->ppr);
+	set_dte_entry(iommu, dev_data->devid, &dev_data->gcr3_info,
+		      domain, ats, dev_data->ppr);
 	clone_aliases(iommu, dev_data->dev);
 
 	device_flush_dte(dev_data);
@@ -2088,8 +2112,8 @@ static void update_device_table(struct protection_domain *domain)
 
 		if (!iommu)
 			continue;
-		set_dte_entry(iommu, dev_data->devid, domain,
-			      dev_data->ats_enabled, dev_data->ppr);
+		set_dte_entry(iommu, dev_data->devid, &dev_data->gcr3_info,
+			      domain, dev_data->ats_enabled, dev_data->ppr);
 		clone_aliases(iommu, dev_data->dev);
 	}
 }
@@ -2637,9 +2661,6 @@ int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
 	if (pdom->dev_cnt > 0 || pdom->flags & PD_IOMMUV2_MASK)
 		goto out;
 
-	if (!pdom->gcr3_tbl)
-		ret = setup_gcr3_table(pdom, pasids);
-
 out:
 	spin_unlock_irqrestore(&pdom->lock, flags);
 	return ret;
-- 
2.31.1

