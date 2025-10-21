Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB66B27511A
	for <iommu@lists.linux.dev>; Tue, 21 Oct 2025 01:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011137; cv=fail; b=HElSi2pUNeQfRFJSFhZj5y7odH3pctjV48Ix1FcPBB9b3njt0pQ6dGuek6wNcmv2rVTDH1m/b/CNWFNhh2McTDgJjXUK+zcjFOrgEZdD6/jTts4HcfnrDGzNTLeYmIinVaRMSG7Np06OF1eTqUcCuINT/zkMrI7fZh4Svj81kX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011137; c=relaxed/simple;
	bh=ksOZ5oN2Peys8fw9zVDSAx2LdScVjUSndKEkXZHykfY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fm0Ju0Jitf41Sq65xpfufe1y5EgIClMM7bttcY2ljmmABCYFPKj3AwuiS9qfkqxxsDIhI3yOounJGz7JzF7YZePc5/FC5FPvmgz7rl8j+X14RuqiouSyRlLyf4HHT7YAKlcHyQ5iza2cNcaC7/5Dpmq5CNp6kKf6ZMyEEPtvDBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lZHfBl1M; arc=fail smtp.client-ip=52.101.56.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lZHfBl1M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5SWMISwPfUcbscYJv+HDVxR6HT4CTFiML7AWZENrPiCzXdOUrAK2HtjMbi4QlcnjKtlytD2DEXsMGV/pBYhXxM+mhol3+CEaIgVWXx6M2lIVtqTa30E/SiblaQzmQTYLr4W+KsZ1lqNVFMjXRIilYNaTNoCVnA2t5W4IYpzT60TYZAOqFdEqRCaQgZFwMDMEL0CRO1KLNgoTEdRw6pg7JqCtlMYXWgFoVAuoTm2YlyvCMdv3p+k5tyTDzZrErLQ78vp6LodnlFfYW9LKTDGr/v2/GIbpEnithAvsV4hQUkiBn981eR049kLot2UTwpMtbulJuSNWPZGP8Mw9RJe8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0N7WvBW607L/SUf6h3Dz0uzebohbQ5B2KbJ3YqgXXk=;
 b=sgwWcQx2CM31ynQXgC8UoSNFHlW519kWDQ0Vr/2c4QDWoRhKUWbVTWM0R2c85AsPWGkkJQYqX3g+hQn/32h5A8VEAT3+6AFBanGjf3jPEmFHeovclflBRdUMvwFF5R32MsxolIzrJsDIqErVZiqtdggGBh1WcVvKktpQ8xf159C3+PvASv7p5I1uXuXHHzIzYNYNvhBmKRPYKzhdppwLktmpVFeocHjAIbzW2KrEHQNicWkhkms/cVBhhdWjxDGrxOzQ+hvJcPKj2TrWs513UCiC2tLDb82fgdcwC2XiinJ/dp4hej3mY/nM8Arf2Y9YE91gRUeYur/tjlNilzAwwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0N7WvBW607L/SUf6h3Dz0uzebohbQ5B2KbJ3YqgXXk=;
 b=lZHfBl1MJjCOZH01te++oFmXMFtEblI1YSf3CF7NJwZlQMrU9MfewQzz/2rVlJFBVWr7JUb0GFin0bEdHX3p4LKf6ghl89N+d1a6eWlJc40hVirfwc0v17ry6o67Uv3KTJZ/r9CiVPJjPYs544vxhFq8GIFV6ERTQMSOMp7Osh0=
Received: from BN9PR03CA0875.namprd03.prod.outlook.com (2603:10b6:408:13c::10)
 by SA5PPF634736581.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Tue, 21 Oct
 2025 01:45:31 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:13c:cafe::8a) by BN9PR03CA0875.outlook.office365.com
 (2603:10b6:408:13c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Tue,
 21 Oct 2025 01:45:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 01:45:31 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 18:45:08 -0700
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
Subject: [PATCH v4 15/16] iommu/amd: Refactor logic to program the host page table in DTE
Date: Tue, 21 Oct 2025 01:43:23 +0000
Message-ID: <20251021014324.5837-16-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|SA5PPF634736581:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b9ccd5-0a0c-4178-e68c-08de10438526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uHSq2LzDy2W+2OOpeIV37NJxgNYMjrjV8HS/Lue0qSLEWA3aW5onna6j80bO?=
 =?us-ascii?Q?uFU5H78L0RPuauuuk2gESjTJdQ34cEWbcovE7R5jbYjAZv8+OGbkJZXwYcvl?=
 =?us-ascii?Q?4XzyMrzwqr1hLA26IzCoP9VBVF+81ZHrV6Aoeq7peMBP4B6Jubgc/DdbfpRY?=
 =?us-ascii?Q?Ayotg93OTGtNfCeey/kYHQGR9BAJ4BASBm1GWC5fllEmxwmXdV8xFOjeQbG7?=
 =?us-ascii?Q?UahzxgGB54fOx3HC3NNl5//euw6TJLeU7GLQtdNt1nvUKGd//xH5sxy3TtTm?=
 =?us-ascii?Q?QN5rsCTpCf83alNq2ayzELwL1NrzkHyZNhbbmfGkExmvCffediHc20F3ingM?=
 =?us-ascii?Q?P3+O0KH8mQ5RH/xHkLKabpVQWtak34bwxcnTAhgXpq2wo+PRzuhqatT6UnE3?=
 =?us-ascii?Q?xITQ/fubrfuGy8xtDSkYtkT+JP55xT59rfiXqo+nWA7eNehULN4CxJXX80zR?=
 =?us-ascii?Q?25+T+myRpYnOCGhoiTkoJAtjU6eQ3lOgVMZGh1V+HFJdywVcrRc+oCeFWk8O?=
 =?us-ascii?Q?b6QYAa1LZLMdzvsFXS08pUZBdPD2EYhrD8QRVjTMNvE3eQ0dNw0ewboueKWo?=
 =?us-ascii?Q?k6dqz1Tww5FnQ2P8EHMXVeVK9gn/Ik97u7y+HwAZHzYgdfQoU7vhrsQSocjD?=
 =?us-ascii?Q?VSj8dzIE4Il+ROVRPzkPMUX7ooyD87eRDnMPPOgBs30i2a/lc/gz7CBt8C94?=
 =?us-ascii?Q?MfQ0P+G0+2qboT4ixDm/8eVCxMNPIfBgGbBVXXtT9GcMxmm0j0SL2rKJxeIe?=
 =?us-ascii?Q?DEVgaJz6Uqv/9PhLwJl8qqzGoceEa0uSKcENDreYXMpxxwtlK+O+T3Fhs3eP?=
 =?us-ascii?Q?NVNGZaDTrTc6P03BPKtTHFZO+E2ZPJIoSyK8qdlgtIMj62UILPn8iHBR6w/I?=
 =?us-ascii?Q?WcUgwk7iNuP6Zi7Z08Ywh0Dq9E+wCCx3RJGHNbW+rE1xmBYTtz00TFBrPsZf?=
 =?us-ascii?Q?KLig+EALJ8OfTEklfdReQDbjqmxWnyKS/CvuogXIhFYayPeIlH4v38QnayZ5?=
 =?us-ascii?Q?Mdod6bqLaBASfpedXhSluFxRVNZvH7l3sskrn4TkZVAC6DqX5vSflZfNGafe?=
 =?us-ascii?Q?Dw+/tGV9hVM24YisG8wkVaknX+lMvfOAG7V40a9kkRqBszSPigt/bKhkqAIT?=
 =?us-ascii?Q?pSsGt6lzfU4zzUpsWzAgxFJ4IYatTBuKBLcrkdCgi8Yj2aU5lImV0NljZHjq?=
 =?us-ascii?Q?jlQvBTqJqq/avLQWL4uaIHd10B4gDnqnUleemGGQs54A5l/LDyZP4Sizf1oy?=
 =?us-ascii?Q?bPj3ctzTBNUt3EAy5t6Aqg2aUxbRzdmpDNavv1OOHWjxctuH8hrhcvGWRzOk?=
 =?us-ascii?Q?hDPdCZz8sZyi1QsSQDBXtK9HZOqqpzpFoY1IuMmpkx8u3Te2iZzO8z+ZWFH5?=
 =?us-ascii?Q?jprFTlqy3Q23ZfF9QjtIe2GTsf00wZwzHaTOOR7Bsv+geWWOMRRPZl6DElVb?=
 =?us-ascii?Q?+n4vh5mdIFe8UZJG/RjAYJR2EPihU40eGqr5wiadHn8J9WGYaiAfKZLOHymc?=
 =?us-ascii?Q?j+MilBq4+Ty6JGgVOSJVmuMM0haBlgYGICvy/uNi/SxegVRGsEbKoFhTDmqD?=
 =?us-ascii?Q?DD5L7S8kOdHQBLCllXk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 01:45:31.5536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b9ccd5-0a0c-4178-e68c-08de10438526
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF634736581

Introduce the set_dte_v1() helper function to configure IOMMU host (v1)
page table into DTE.

There is no functional change.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  3 ++
 drivers/iommu/amd/iommu.c     | 57 ++++++++++++++++++++---------------
 2 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index cfb63de7732a..5e61fdb2c6c0 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -190,6 +190,9 @@ struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid);
 int amd_iommu_completion_wait(struct amd_iommu *iommu);
 
 /* DTE */
+void amd_iommu_set_dte_v1(struct iommu_dev_data *dev_data,
+			  struct protection_domain *domain,
+			  struct dev_table_entry *new);
 int amd_iommu_device_flush_dte(struct iommu_dev_data *dev_data);
 void amd_iommu_update_dte256(struct amd_iommu *iommu,
 			     struct iommu_dev_data *dev_data,
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e3330f3b8c14..428008cff06a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2041,16 +2041,12 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
  * Note:
  * The old value for GCR3 table and GPT have been cleared from caller.
  */
-static void set_dte_gcr3_table(struct amd_iommu *iommu,
-			       struct iommu_dev_data *dev_data,
+static void set_dte_gcr3_table(struct iommu_dev_data *dev_data,
 			       struct dev_table_entry *target)
 {
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 	u64 gcr3;
 
-	if (!gcr3_info->gcr3_tbl)
-		return;
-
 	pr_debug("%s: devid=%#x, glx=%#x, gcr3_tbl=%#llx\n",
 		 __func__, dev_data->devid, gcr3_info->glx,
 		 (unsigned long long)gcr3_info->gcr3_tbl);
@@ -2071,6 +2067,26 @@ static void set_dte_gcr3_table(struct amd_iommu *iommu,
 		target->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_5_LEVEL);
 	else
 		target->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_4_LEVEL);
+
+	/* Note: PRI is only supported w/ GCR3 table */
+	if (dev_data->ppr)
+		target->data[0] |= 1ULL << DEV_ENTRY_PPR;
+}
+
+void amd_iommu_set_dte_v1(struct iommu_dev_data *dev_data,
+			  struct protection_domain *domain,
+			  struct dev_table_entry *new)
+{
+	u64 htrp;
+
+	new->data[0] |= FIELD_PREP(DTE_MODE_MASK, domain->iop.mode);
+
+	htrp = FIELD_GET(GENMASK_ULL(51, 12), iommu_virt_to_phys(domain->iop.root));
+	new->data[0] |= FIELD_PREP(DTE_HOST_TRP, htrp);
+
+	/* Note Dirty tracking is used for v1 table only for now */
+	if (domain->dirty_tracking)
+		new->data[0] |= DTE_FLAG_HAD;
 }
 
 static void set_dte_entry(struct amd_iommu *iommu,
@@ -2088,37 +2104,28 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	else
 		domid = domain->id;
 
-	amd_iommu_make_clear_dte(dev_data, &new);
-
-	if (domain->iop.mode != PAGE_MODE_NONE)
-		new.data[0] |= iommu_virt_to_phys(domain->iop.root);
-
-	new.data[0] |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
-		    << DEV_ENTRY_MODE_SHIFT;
-
-	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW;
-
 	/*
 	 * When SNP is enabled, we can only support TV=1 with non-zero domain ID.
 	 * This is prevented by the SNP-enable and IOMMU_DOMAIN_IDENTITY check in
 	 * do_iommu_domain_alloc().
 	 */
 	WARN_ON(amd_iommu_snp_en && (domid == 0));
-	new.data[0] |= DTE_FLAG_TV;
 
-	if (dev_data->ppr)
-		new.data[0] |= 1ULL << DEV_ENTRY_PPR;
+	amd_iommu_make_clear_dte(dev_data, &new);
 
-	if (domain->dirty_tracking)
-		new.data[0] |= DTE_FLAG_HAD;
+	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
 
-	if (dev_data->ats_enabled)
-		new.data[1] |= DTE_FLAG_IOTLB;
+	if (gcr3_info && gcr3_info->gcr3_tbl)
+		set_dte_gcr3_table(dev_data, &new);
+	else if (domain->iop.mode != PAGE_MODE_NONE)
+		amd_iommu_set_dte_v1(dev_data, domain, &new);
 
-	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
-	new.data[1] |= domid;
+	/* Note: The IR, IW, TV, DOMID are needed for both v1 and gcr3 table */
+	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_TV;
+	new.data[1] |= FIELD_PREP(DTE_DOMID_MASK, domid);
 
-	set_dte_gcr3_table(iommu, dev_data, &new);
+	if (dev_data->ats_enabled)
+		new.data[1] |= DTE_FLAG_IOTLB;
 
 	amd_iommu_update_dte256(iommu, dev_data, &new);
 
-- 
2.34.1

