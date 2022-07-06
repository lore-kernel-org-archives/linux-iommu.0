Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2088.outbound.protection.outlook.com [40.107.212.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B98033C6
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:46:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZG8fZ5sH6G3bYWH3MFnqogWUHbQ+QREZ4vad3kQ5TX+NCusthfvqtns5ToLA5OsV4L4oc5j5jGtxAnluwK/3h4010V6nSjENzB3tmVWjildNnRJ2/H/A/HBs+0rgWm70M7MWtZ25Z6tJa6q/j+JaXAuPuneSyHebvsHJEXY6IiCxwFHqs1xoY2cueNLfBu7YGPMgUf890rfuaw3BV0e514ip4RhupZrIF5+PWjWv3O/sOnljjispvMy7CWNDONZF35TH8A/aR7b7toow3XhtPxxVCz56N4fp/IsTF7gGVZy2eXlPNkRepe9Tp0X1RK1zqgjz7dSohZG0cUBHrQwXjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLdoH8cvN3xTorrnmwdMl4gsAx/NOcQkuV36oUTl++s=;
 b=ABFRXiZRNT+oQXoSp9U5dosM096Pp7xwROjf0fVdn+9mfjYGWurfQI9jRIVzzQmMkECktcR7I/27KpBya34U8ZazWEX59BXKf75T5sduDZuiSHzAmXENpY2HSKk2PvmjHbZmL+xLOK+vI4Okrs9+1CY6nEnSNgL6CrGJ54UMTDxqay0ebAoa3zvOSNQJOi6iWkhNOGnhvC/6B0/xSQDSuQc17XWwEHgf5nWnvbj3yQLz6TzDN1rZryOv1gLqV/wtzott43zyHW/0ySVzEPWuzH+XrbKKQ18Hgell6RZ9NVQx2C2TNNQlnpi7iMXcj7EZezOf6aakkjuuwEbbTn5hmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLdoH8cvN3xTorrnmwdMl4gsAx/NOcQkuV36oUTl++s=;
 b=qAMJG19LrLd9SWSFV0pNn7lLEdx3ZSKuqPAw+kx2BzZ8sAfm1rfYKkGlff9aqrtvZuLzDA2gb7Ps22vyLilDtksH2im87DcWae2FwQFSDHaeqM4/JqVevyCz87yVV4LoVV0vNJa8hrt6bHSAC2ZubKVOJ0EHICSF0BybLZF84HU=
Received: from CO1PR15CA0088.namprd15.prod.outlook.com (2603:10b6:101:20::32)
 by DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 6 Jul
 2022 11:46:17 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:20:cafe::f2) by CO1PR15CA0088.outlook.office365.com
 (2603:10b6:101:20::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Wed, 6 Jul 2022 11:46:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:46:17 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:46:12 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 15/35] iommu/amd: Convert to use rlookup_amd_iommu helper function
Date: Wed, 6 Jul 2022 17:08:05 +0530
Message-ID: <20220706113825.25582-16-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220706113825.25582-1-vasant.hegde@amd.com>
References: <20220706113825.25582-1-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b1ad2577-85dc-4d48-be0a-08da5f452354
X-MS-TrafficTypeDiagnostic: DM6PR12MB4043:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9qOoKjHqqvQPkdKt1PimbDnbMvmHzcvlqsIViXDKQP85EMlN/Bx1UFMaoDcz50vV/rYukfhIvA/PD0zzNjHWbiTipbW25gSUhP89fpPhwpsxr5feoT/Mu0JWFN1c/VxRP5ap9EachzQ1bCdFWOc+3D1nLhw6CiBjStzO+TXrGgjBC5490FbXvxIWvFoOxHPV0dGCq884XV5mt/xcILhuziskb/iOXPeafvn3u8yHUtNKInsAFQcHm/lzV0Zh3W0WzYl2N1IH3Fjg4LHf/LMUBbkA4gVB37RF9QRLcVN1A4jQPLrkcjSc6BBb+xo7cekvWZnLRY04gzu1MJ64c4byt9SDgNE2Pj+Sd6BJnPx3OzNgQIyir4dD22qFIH7F6D1lNj/Zp9PkKeURYjd2mlJya78GVwsIu4CEql0SXqUOi3b2DcKoHzMVrHVCxj9+wXvNZvPABIle2EDqfGFMpewb/TovuyK95WxsGzS21UMEbtIPucmTQWWXkD9ybKsIx7p63E8nbX0POO4+2TbnM/8YgUAgsRo3C2Iph9IEbxqwmlo4FZBvmiWqoHVrfSPmYQC6PEr0+NQa+GACcBsFVyuIkoyiReOgGlzLwDJ5N+SVQk+G0Hq6uUQFmlkMCaZZwkMjb1CoV7t7+tcJCBUfBvsQQwoDuIWAdz72rPVgZE6a7gF4MMK2xlrRzvvPxWgQODGtfG8RTBkMN72GE5iFusf2Xs8CXSsi6e+FQhVQdAnEqc8NF2WhcC9d1fqvAkYx6ZgVR33P6RDKm9lUVLWB2RZxtnghTGOCFU7GCbsvlSlpQTIh7znqi3Xgne2tbnHlLYJd2jjMDD2+I/CnP4FYTF5J+wI3rHz0MZRdFqbn8b2pwRwTVByj7F41UsjUxqp/gmFZ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(136003)(46966006)(40470700004)(36840700001)(7696005)(36756003)(356005)(81166007)(34020700004)(40480700001)(54906003)(36860700001)(110136005)(316002)(86362001)(82740400003)(6666004)(82310400005)(2906002)(8676002)(83380400001)(41300700001)(4326008)(44832011)(5660300002)(336012)(47076005)(26005)(70206006)(70586007)(426003)(40460700003)(16526019)(186003)(8936002)(1076003)(2616005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:46:17.4609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ad2577-85dc-4d48-be0a-08da5f452354
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043
Message-ID: <20220706113805.TlW6MbMMwu-6hp7MoMrvuq33Fdgm5vY6p5ixepkNTJo@z>

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Use rlookup_amd_iommu() helper function which will give per PCI
segment rlookup_table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 64 +++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cfecd072e7a6..19db4d54c337 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -229,13 +229,17 @@ static struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid
 
 static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 {
+	struct amd_iommu *iommu;
 	u16 devid = pci_dev_id(pdev);
 
 	if (devid == alias)
 		return 0;
 
-	amd_iommu_rlookup_table[alias] =
-		amd_iommu_rlookup_table[devid];
+	iommu = rlookup_amd_iommu(&pdev->dev);
+	if (!iommu)
+		return 0;
+
+	amd_iommu_set_rlookup_table(iommu, alias);
 	memcpy(amd_iommu_dev_table[alias].data,
 	       amd_iommu_dev_table[devid].data,
 	       sizeof(amd_iommu_dev_table[alias].data));
@@ -366,7 +370,7 @@ static bool check_device(struct device *dev)
 	if (devid > amd_iommu_last_bdf)
 		return false;
 
-	if (amd_iommu_rlookup_table[devid] == NULL)
+	if (rlookup_amd_iommu(dev) == NULL)
 		return false;
 
 	return true;
@@ -1270,7 +1274,9 @@ static int device_flush_iotlb(struct iommu_dev_data *dev_data,
 	int qdep;
 
 	qdep     = dev_data->ats.qdep;
-	iommu    = amd_iommu_rlookup_table[dev_data->devid];
+	iommu    = rlookup_amd_iommu(dev_data->dev);
+	if (!iommu)
+		return -EINVAL;
 
 	build_inv_iotlb_pages(&cmd, dev_data->devid, qdep, address, size);
 
@@ -1295,7 +1301,9 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
 	u16 alias;
 	int ret;
 
-	iommu = amd_iommu_rlookup_table[dev_data->devid];
+	iommu = rlookup_amd_iommu(dev_data->dev);
+	if (!iommu)
+		return -EINVAL;
 
 	if (dev_is_pci(dev_data->dev))
 		pdev = to_pci_dev(dev_data->dev);
@@ -1525,8 +1533,8 @@ static void free_gcr3_table(struct protection_domain *domain)
 	free_page((unsigned long)domain->gcr3_tbl);
 }
 
-static void set_dte_entry(u16 devid, struct protection_domain *domain,
-			  bool ats, bool ppr)
+static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
+			  struct protection_domain *domain, bool ats, bool ppr)
 {
 	u64 pte_root = 0;
 	u64 flags = 0;
@@ -1545,8 +1553,6 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain,
 		flags |= DTE_FLAG_IOTLB;
 
 	if (ppr) {
-		struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
-
 		if (iommu_feature(iommu, FEATURE_EPHSUP))
 			pte_root |= 1ULL << DEV_ENTRY_PPR;
 	}
@@ -1590,8 +1596,6 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain,
 	 * entries for the old domain ID that is being overwritten
 	 */
 	if (old_domid) {
-		struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
-
 		amd_iommu_flush_tlb_domid(iommu, old_domid);
 	}
 }
@@ -1611,7 +1615,9 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	struct amd_iommu *iommu;
 	bool ats;
 
-	iommu = amd_iommu_rlookup_table[dev_data->devid];
+	iommu = rlookup_amd_iommu(dev_data->dev);
+	if (!iommu)
+		return;
 	ats   = dev_data->ats.enabled;
 
 	/* Update data structures */
@@ -1623,7 +1629,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_cnt                 += 1;
 
 	/* Update device table */
-	set_dte_entry(dev_data->devid, domain,
+	set_dte_entry(iommu, dev_data->devid, domain,
 		      ats, dev_data->iommu_v2);
 	clone_aliases(iommu, dev_data->dev);
 
@@ -1635,7 +1641,9 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	struct protection_domain *domain = dev_data->domain;
 	struct amd_iommu *iommu;
 
-	iommu = amd_iommu_rlookup_table[dev_data->devid];
+	iommu = rlookup_amd_iommu(dev_data->dev);
+	if (!iommu)
+		return;
 
 	/* Update data structures */
 	dev_data->domain = NULL;
@@ -1813,13 +1821,14 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 {
 	struct iommu_device *iommu_dev;
 	struct amd_iommu *iommu;
-	int ret, devid;
+	int ret;
 
 	if (!check_device(dev))
 		return ERR_PTR(-ENODEV);
 
-	devid = get_device_id(dev);
-	iommu = amd_iommu_rlookup_table[devid];
+	iommu = rlookup_amd_iommu(dev);
+	if (!iommu)
+		return ERR_PTR(-ENODEV);
 
 	if (dev_iommu_priv_get(dev))
 		return &iommu->iommu;
@@ -1849,13 +1858,14 @@ static void amd_iommu_probe_finalize(struct device *dev)
 
 static void amd_iommu_release_device(struct device *dev)
 {
-	int devid = get_device_id(dev);
 	struct amd_iommu *iommu;
 
 	if (!check_device(dev))
 		return;
 
-	iommu = amd_iommu_rlookup_table[devid];
+	iommu = rlookup_amd_iommu(dev);
+	if (!iommu)
+		return;
 
 	amd_iommu_uninit_device(dev);
 	iommu_completion_wait(iommu);
@@ -1884,7 +1894,7 @@ static void update_device_table(struct protection_domain *domain)
 
 		if (!iommu)
 			continue;
-		set_dte_entry(dev_data->devid, domain,
+		set_dte_entry(iommu, dev_data->devid, domain,
 			      dev_data->ats.enabled, dev_data->iommu_v2);
 		clone_aliases(iommu, dev_data->dev);
 	}
@@ -2072,7 +2082,6 @@ static void amd_iommu_detach_device(struct iommu_domain *dom,
 				    struct device *dev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
-	int devid = get_device_id(dev);
 	struct amd_iommu *iommu;
 
 	if (!check_device(dev))
@@ -2081,7 +2090,7 @@ static void amd_iommu_detach_device(struct iommu_domain *dom,
 	if (dev_data->domain != NULL)
 		detach_device(dev);
 
-	iommu = amd_iommu_rlookup_table[devid];
+	iommu = rlookup_amd_iommu(dev);
 	if (!iommu)
 		return;
 
@@ -2108,7 +2117,7 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 	dev_data = dev_iommu_priv_get(dev);
 	dev_data->defer_attach = false;
 
-	iommu = amd_iommu_rlookup_table[dev_data->devid];
+	iommu = rlookup_amd_iommu(dev);
 	if (!iommu)
 		return -EINVAL;
 
@@ -2493,8 +2502,9 @@ static int __flush_pasid(struct protection_domain *domain, u32 pasid,
 			continue;
 
 		qdep  = dev_data->ats.qdep;
-		iommu = amd_iommu_rlookup_table[dev_data->devid];
-
+		iommu = rlookup_amd_iommu(dev_data->dev);
+		if (!iommu)
+			continue;
 		build_inv_iotlb_pasid(&cmd, dev_data->devid, pasid,
 				      qdep, address, size);
 
@@ -2656,7 +2666,9 @@ int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
 	struct iommu_cmd cmd;
 
 	dev_data = dev_iommu_priv_get(&pdev->dev);
-	iommu    = amd_iommu_rlookup_table[dev_data->devid];
+	iommu    = rlookup_amd_iommu(&pdev->dev);
+	if (!iommu)
+		return -ENODEV;
 
 	build_complete_ppr(&cmd, dev_data->devid, pasid, status,
 			   tag, dev_data->pri_tlp);
-- 
2.31.1

