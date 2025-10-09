Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2E829B204
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 23:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054342; cv=fail; b=uLYe70sE5WzpW8unf+Iy2MZ9+yAf6KE6CupVPnceLJANxbi4FjGmZQMeLpH8Afvce1CzuZ1QKpua9BDasbZ3pLPTJFHxDL+IIU9BONMe6C+6WUiv0QGYvG+r5KU7pWRGcECwIFfQnpDgcaeuLmgQQyE8SBCcXeriXmfcW+Sfh80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054342; c=relaxed/simple;
	bh=Ok/cM8ese5HL4McIaRLtL77VpEJEHVsaHuaPBMt6gKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o84VOT0q0ReLGE//z3DBf4z4TI4wBflwMmbf63hMxkP/IHiJIL3FtO1dt6FR6kdyu67pBvoPNYouuzve8cLZzjKAqtZUjZbcFEbaWmCRNvH8KaXlJIyHxpNWnR7dKEydEJ+SGMsCXbxvwCLUv7sF76rAV7H5jR2GDiMEQE9+GcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YJHz6w6Y; arc=fail smtp.client-ip=52.101.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YJHz6w6Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vg5o/euQuR7/j2p384/JfAA1Jma6QmZDE3HV3R755yjSrdk7uxQxENZFSuXCci/1M5YgoDtYapfxF5kYk0dMuQEwBReuut2Scjt8315xI6h5OGdntENgHeELeS47DwjICNnBUrTg0TApURWMoMK0XAxAHGvyVZEUwcofoqP91lHI5U6eOK8baBLSRedrGbQU7bHgKziqmJCjwI4CHYJ0ToIQdO2DZG7Aor8qYoo1BF1R4H10D7vW6fD0mWtL7a7ya0N1vDwebtoE3LdnBIfctpB7Lra4refUBYlaW/E+QPEYkHLPnWgvGcp5Vs5eeSywrMxGrfasB0ZkTCYxNRLIIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3M28cYGNqz9F9QhqOm8yirZ+3BjaFb3Yd6KvB5xY6PE=;
 b=w+F4DyaBHc1yOWMwxJbplfAhmxn4KniviYT0TSsHt8rW1RObYtpa2iRLj3FmZq7HAQGjNo4apqw3YwvhJxGrBknXm89qk1uTb+Zn3n538aqj8+QSRb8VvPiqOUN9Ec+FGWUO2Degwy52IOWirRJhaCqvilufIAOYFZUTAm+P+/tgSmNPhLiJOZolWTPtABeDhPx1q49HyIxL/zw/zjU4lnpPKWbBed+2DLNCSR1GHktwbeguluI7OTstlTioFTJbdAJDqOWVtSiqG9PL6VLihwsF4tJN7YjBtEDgiqV2pzLf9vz5nSHGCPTqogAy7hzwM1tNKLiuRDJXC5VWKGD0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3M28cYGNqz9F9QhqOm8yirZ+3BjaFb3Yd6KvB5xY6PE=;
 b=YJHz6w6YVn80/6RdBRxr3i8wUaK6Ue9NmYdzjQSyyRvmKizk/wo4BQekqqpIdTT6wET2gWGYXAHGdNUuBhNlOWf2k7RdbKg9jNAA9xg/JYRThOkhobqIPLNCIYMERxynf/sYAhVbdtnEOpY2Pz5Tp38rvzu1Gzl3TpGl+o9rxP0=
Received: from CH5P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::18)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 23:58:54 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::4b) by CH5P220CA0020.outlook.office365.com
 (2603:10b6:610:1ef::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Thu,
 9 Oct 2025 23:58:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 23:58:54 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 16:58:47 -0700
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
Subject: [PATCH v3 07/15] iommu/amd: Make amd_iommu_completion_wait() non-static
Date: Thu, 9 Oct 2025 23:57:47 +0000
Message-ID: <20251009235755.4497-8-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
References: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: b2004135-56b7-4784-3bf6-08de078fcd71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HoLW2FRwWjoJGaC7E0UrO6Nc28X6W3C6ypyyzqFuuE20jAkX2NvLxOu8ivcf?=
 =?us-ascii?Q?wNL3bnaMaR7fxRQs3L93QoCRGaNx4xzxpwYN2aNbFVI2F1iOiOSW4510+4YL?=
 =?us-ascii?Q?eVFf71T0wY3dvn2Zy06sPrOtCJ16z93j2LsF3Sj0e+0kxSeT2Z09pmQcGImz?=
 =?us-ascii?Q?ziavGmElgmM/SRBBttZk34qHl5Bjvpmnxkt8PSWy7M4ZB5gSPcnHpWsp1Tsy?=
 =?us-ascii?Q?zygwdyDmD3s9D7lH0zJvgsEvY7NP690Zucm5DK05FUOsr1ldm6MsbR+2XCic?=
 =?us-ascii?Q?fwAdUQ5cagV/V7Jsoj9TNOJZQUTmtStB4iaxNG0f+INygQHvvTidNGGWMvPZ?=
 =?us-ascii?Q?RSlCpyPoKB7/Qmg06paDiX5mxxZXMh9o62AkcVbsmAIAD+qlRW/vrZrfeZ3w?=
 =?us-ascii?Q?At7cn2OZuyu377YugAaGUZ/ivimIvxRbAk7loEH5iOGZxsF0phxuTstKzT40?=
 =?us-ascii?Q?eC1mfZTQgGU+MaPdV5G5B7D/nwPbVvRISR5NuHDkiSZd1PpcPoUcjIklBmEP?=
 =?us-ascii?Q?rkvFhFvwviB2OrENVYYZofc/TTJKhkvLs92Mgho/+3k38pOyswfavcOvK8xE?=
 =?us-ascii?Q?4sGRJbiCCNFC4Y2GggN7sOpskfnYt0rM+JT06JHb+gX1QUky7JbszxBnedbm?=
 =?us-ascii?Q?5ZMQgfPdX+sR0a+Ysrv5gOC28NPI1D8IB/xYObgG1X0MXyT0/SqsD6TXoKie?=
 =?us-ascii?Q?a9BgCv362K4cIsq3KL4pEucYNJ4aqehZ300AtGON0CwmJoDKz/o5GEbbSpVC?=
 =?us-ascii?Q?bPN1B7B4AGSE0zJsuhy8JcjOs/Wv5EoUwkDR3pv2L9pCaJTNg4/tlH8AYIiP?=
 =?us-ascii?Q?dJGRhmwW2AFgsZADuon2oV/j8xZfDzu8GGM9XjBd2MmTMHJ3NoC4xWpZSb8H?=
 =?us-ascii?Q?Qi4fDNIayEtzAymnWF6X6NkzxRkDm/4xw6ssaWAb1oGs4yYZlmIxRDj5tjhk?=
 =?us-ascii?Q?lNlKAiPWkEkq6XFc6te3VuwcnI9PTQzOv/qImUNVnQggukhk5xQMR6ktQGZJ?=
 =?us-ascii?Q?d8SK3KzRUsaJnyvS5+0rGFm4XhraeYAyi/mLLwKTXYVkrD5zWOiq9FCdoGRD?=
 =?us-ascii?Q?JhA6c6gut2LKfxuzWcKhNrLlFe4GbCXcEu0pBzb9gFuRb3a9UExXRGlUNcwB?=
 =?us-ascii?Q?z5B+f4BUM69JF1Sy6+D/St6Q8uezOvfzVL3FjTCBdOpr8MskBu9d7Ip89yI7?=
 =?us-ascii?Q?Trwn3VmSLZKyr4nlysQy5hQnvPz3hiiI1QjhlJk1/PfbYI9fuCMtm/FaRfi6?=
 =?us-ascii?Q?TORLvho3osv4rU4g9MVgJEqBEDGvVOitc6jCiFKMQp+mHKpRlK15p7yeEDZL?=
 =?us-ascii?Q?7nJh08GGHKN0Wsg3W4HKd/0UUvciolk2YG1XdBC4baLANSuAsX2NRrVRyGgW?=
 =?us-ascii?Q?7iEgEdp49DI/Mp0pqX0MuI6RbGTn8tPPSeDND5vg3WCgNRIo4IjapYbuzR9p?=
 =?us-ascii?Q?wbkxQt9MY4TUuQSKVQmJHkan7cybxEImLS2Bcv2MRSFWXvCm0iROSmsn6bVS?=
 =?us-ascii?Q?I63Py5ci3wzyhyKtELhnzl3QxWLUXFAhFit/p06OmhTlZ2dQ7lAWDx9ZS/Vy?=
 =?us-ascii?Q?tueiKcpW09Zi+9MCE+k=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 23:58:54.0872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2004135-56b7-4784-3bf6-08de078fcd71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755

This will be reused in a new iommufd.c file for nested translation.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 +
 drivers/iommu/amd/iommu.c     | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index c7cb4a80d44a..d533bb8851ea 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -187,6 +187,7 @@ void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 				  u64 *root, int mode);
 struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid);
+int amd_iommu_completion_wait(struct amd_iommu *iommu);
 
 /* DTE */
 int amd_iommu_device_flush_dte(struct iommu_dev_data *dev_data);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 386ac96b2c02..e0bfcda678a8 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1392,7 +1392,7 @@ static int iommu_queue_command(struct amd_iommu *iommu, struct iommu_cmd *cmd)
  * This function queues a completion wait command into the command
  * buffer of an IOMMU
  */
-static int iommu_completion_wait(struct amd_iommu *iommu)
+int amd_iommu_completion_wait(struct amd_iommu *iommu)
 {
 	struct iommu_cmd cmd;
 	unsigned long flags;
@@ -1431,7 +1431,7 @@ static void domain_flush_complete(struct protection_domain *domain)
 	 * We need to wait for completion of all commands.
 	 */
 	 xa_for_each(&domain->iommu_array, i, pdom_iommu_info)
-		iommu_completion_wait(pdom_iommu_info->iommu);
+		amd_iommu_completion_wait(pdom_iommu_info->iommu);
 }
 
 static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
@@ -1449,7 +1449,7 @@ static void iommu_flush_dte_sync(struct amd_iommu *iommu, u16 devid)
 
 	ret = iommu_flush_dte(iommu, devid);
 	if (!ret)
-		iommu_completion_wait(iommu);
+		amd_iommu_completion_wait(iommu);
 }
 
 static void amd_iommu_flush_dte_all(struct amd_iommu *iommu)
@@ -1460,7 +1460,7 @@ static void amd_iommu_flush_dte_all(struct amd_iommu *iommu)
 	for (devid = 0; devid <= last_bdf; ++devid)
 		iommu_flush_dte(iommu, devid);
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 /*
@@ -1479,7 +1479,7 @@ static void amd_iommu_flush_tlb_all(struct amd_iommu *iommu)
 		iommu_queue_command(iommu, &cmd);
 	}
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 static void amd_iommu_flush_tlb_domid(struct amd_iommu *iommu, u32 dom_id)
@@ -1490,7 +1490,7 @@ static void amd_iommu_flush_tlb_domid(struct amd_iommu *iommu, u32 dom_id)
 			      dom_id, IOMMU_NO_PASID, false);
 	iommu_queue_command(iommu, &cmd);
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 static void amd_iommu_flush_all(struct amd_iommu *iommu)
@@ -1500,7 +1500,7 @@ static void amd_iommu_flush_all(struct amd_iommu *iommu)
 	build_inv_all(&cmd);
 
 	iommu_queue_command(iommu, &cmd);
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 static void iommu_flush_irt(struct amd_iommu *iommu, u16 devid)
@@ -1523,7 +1523,7 @@ static void amd_iommu_flush_irt_all(struct amd_iommu *iommu)
 	for (devid = 0; devid <= last_bdf; devid++)
 		iommu_flush_irt(iommu, devid);
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 void amd_iommu_flush_all_caches(struct amd_iommu *iommu)
@@ -1748,7 +1748,7 @@ void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
 	if (dev_data->ats_enabled)
 		device_flush_iotlb(dev_data, address, size, pasid, true);
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 static void dev_flush_pasid_all(struct iommu_dev_data *dev_data,
@@ -2137,7 +2137,7 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 
 	clone_aliases(iommu, dev_data->dev);
 	amd_iommu_device_flush_dte(dev_data);
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 /*
@@ -2421,7 +2421,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 
 out_err:
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 
 	if (FEATURE_NUM_INT_REMAP_SUP_2K(amd_iommu_efr2))
 		dev_data->max_irqs = MAX_IRQS_PER_TABLE_2K;
@@ -3255,7 +3255,7 @@ static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
 		set_remap_table_entry(iommu, alias, table);
 
 out_wait:
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 
 out_unlock:
 	spin_unlock_irqrestore(&iommu_table_lock, flags);
-- 
2.34.1

