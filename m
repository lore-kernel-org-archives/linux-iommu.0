Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB622C6A7
	for <iommu@lists.linux.dev>; Fri,  9 Feb 2024 11:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478310; cv=fail; b=GEE2pInggBp3p3zZk+KsUAG+9iIXXKmHXAZHaYq4owFnnRtKv48uQY122hS2FuI5tWmNLcISXmMtsNOwqLeD4/7FHPKlHzetXhuj0m2YWjRRk/kizMAC8c7ktALAQLeKFLd81TO30bQQ5nXHlmNYsSlgpr6dDROEZMy06LJoOjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478310; c=relaxed/simple;
	bh=oA6wA3dnOy0imbK6Jwp9nz/F87JjNoNzQEtdLT1i9oY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QRZc7egRJ8+mi3wFcRUNqrTl1ybpy3rk6hbTmD5/jEVZWxTInQ9XysB96ofp9g1zBd/xHtcUCxeaHzSfs/+PsTbafakil4AKqZCRFVtlJCZdiyTV7wT4V8uxq5uC3OvoWnGgATISP+bGtUbBOfqhjixF7qtGQnFx5iAOlkmQpbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G5l57ZB6; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G5l57ZB6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6fG7zS/FP9/T7XqC9GyWSzgl4zvHimtioFsShfsn6hiyDQvp6mfho/9knJEMiHsWXqXEYPK9RGfKm6w+uQe7fV2270OV7l12XFo8j1Kj4uOt4QazCTbgorXGw9egcwRnABuUfeDbtX4vYcRz+pldtNujurhIVfQi2trFJtEqJapP0S7ax1cmgaPTNhpdj7YbwC0hcPjekiG6SNEtR9mrTNeQlx5S+zcsL3E03pCju81s2/g3AnfJzzBYm+9HSeG40nVXzUZicXjQvtpY3yfK7OqUjffQxgYqw+Es5baKH928eGq+b3Wfirn6jACNSEpUT1Rgkc80Sk4RzSCrjK9og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcR/QdRF78h9m33V+DQV328SYZUSbYfGmJcBhucCkHM=;
 b=EcLOV00JR+IG6RxX+ZQi/VDVlDISF3XoZ8mxFcaep6pUOjLidADsK+5MGAGYifIgW/hBJGTPaljTQZtuCWQJXxXTHP75JCD4WO1blvxSByEnb+ckm5Xq4atcOV2KbrtmTC6gdXFpKT9NKDfUybMv+vcPwjA2tLwB1G5G4g+CzZMqzzK1qDNBlTiTSoPfixz1o41BK6i9SrQ0+qHFltamFcU6jPTkPeoeGerme1eF9ascf5iY4w7wX98UXc9x2EO8mmh+ixFSWD6tOKP0USVopgNYuHHKpTIkXUTejQhIWRVmVtVNz48l4UEJUvSWtYIfQ6wwYUK+jOOklpqybzr9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcR/QdRF78h9m33V+DQV328SYZUSbYfGmJcBhucCkHM=;
 b=G5l57ZB6vMK2/e8LZQeECcTo7vSVmIt/HGdXq+gVNkjX0seg8/M4xDnw+E4I83di98K8I2+9M87cyH/pdi/s/ulCVpM+/aNLdxfQ95JTeTPnVPuBK2mkW/J5tdSnsi4VZLtUFvKxJ90O7IlbLTkKbWN/NyqXGP98CI9OIsgMRjA=
Received: from CH2PR03CA0002.namprd03.prod.outlook.com (2603:10b6:610:59::12)
 by SN7PR12MB6910.namprd12.prod.outlook.com (2603:10b6:806:262::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.41; Fri, 9 Feb
 2024 11:31:45 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::36) by CH2PR03CA0002.outlook.office365.com
 (2603:10b6:610:59::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24 via Frontend
 Transport; Fri, 9 Feb 2024 11:31:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 11:31:45 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 05:31:42 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v6 07/15] iommu/amd: Setup GCR3 table in advance if domain is SVA capable
Date: Fri, 9 Feb 2024 11:29:22 +0000
Message-ID: <20240209112930.63663-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209112930.63663-1-vasant.hegde@amd.com>
References: <20240209112930.63663-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|SN7PR12MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bdcd0c4-86e6-4d25-4b87-08dc2962b212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HZbbgsYJZI0aaxuIxyvokLIl5A8KSvyR5oGexfDir/Iv4QzM2m8oUStcIWkt3i6+VuYbUwy3OaAPOD6hYCg9KXXe5LLXPTlmJUghturYO0sIi/8M2LuT8jJ7OtJYbftA82sP5Qp0LhEYeDxjJp73FMpyMjE6Cojtx71fIMoWzMh/mzYYh7Mbfmbc3fHxt0GxG7t9TXm85zEpLyBgBDA9C8oiYKk4qjejFX+P/yV3jxe+p1WjZgcl0e43I7m7uolfuhFH7oHJHhBl9AHN7+WJB800yMFF5/R3EQkfoh+GeZNF0apbYi1MvzSM/OYYePm+pvZtfhcOADwlLfBr79Luvu/eNnAGICmaGciYAepnFp/Ny6zX4dYNxofr1iUjNoCjAbGVR2U1tl3orJ5S1Cn0hUfOr1Xqgdg2NrlFxBCd9mXUYQHSSyOCzjfm7drDvEyA/XjsF9VwNUQkLN7khfl+bevCPPCPIpt4FCXEA58xuIiPh/VFEjoSEUPKfAfhgife2i172VOAKOeIJ2o2Mnbsw80WkwtfM9Tgny6SOVxjdhkx/b3pMxP0QZioRagrlABpvDhKityUyKGAd7sC/WnJPIwsB8VfjA9Xzaoom9uOWWs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(40470700004)(36840700001)(46966006)(36756003)(66899024)(7696005)(478600001)(4326008)(5660300002)(41300700001)(356005)(426003)(82740400003)(16526019)(26005)(83380400001)(1076003)(8676002)(336012)(2616005)(2906002)(316002)(70586007)(54906003)(6666004)(81166007)(86362001)(70206006)(8936002)(44832011)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 11:31:45.0220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bdcd0c4-86e6-4d25-4b87-08dc2962b212
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6910

SVA can be supported if domain is in passthrough mode or paging domain
with v2 page table. Current code sets up GCR3 table for domain with v2
page table only. Setup GCR3 table for all SVA capable domains.

  - Move GCR3 init/destroy to separate function.

  - Change default GCR3 table to use MAX supported PASIDs. Ideally it
    should use 1 level PASID table as its using PASID zero only. But we
    don't have support to extend PASID table yet. We will fix this later.

  - When domain is configured with passthrough mode, allocate default GCR3
    table only if device is SVA capable.

Note that in attach_device() path it will not know whether device will use
SVA or not. If device is attached to passthrough domain and if it doesn't
use SVA then GCR3 table will never be used. We will endup wasting memory
allocated for GCR3 table. This is done to avoid DTE update when
attaching PASID to device.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 86 ++++++++++++++++++++++++++++++++-------
 1 file changed, 71 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index fe9c00ed7e00..693b9ba9cef0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -93,6 +93,21 @@ static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
 	return (pdom && (pdom->pd_mode == PD_MODE_V2));
 }
 
+static inline bool pdom_is_in_pt_mode(struct protection_domain *pdom)
+{
+	return (pdom->domain.type == IOMMU_DOMAIN_IDENTITY);
+}
+
+/*
+ * We cannot support PASID w/ existing v1 page table in the same domain
+ * since it will be nested. However, existing domain w/ v2 page table
+ * or passthrough mode can be used for PASID.
+ */
+static inline bool pdom_is_sva_capable(struct protection_domain *pdom)
+{
+	return pdom_is_v2_pgtbl_mode(pdom) || pdom_is_in_pt_mode(pdom);
+}
+
 static inline int get_acpihid_device_id(struct device *dev,
 					struct acpihid_map_entry **entry)
 {
@@ -1965,6 +1980,58 @@ void amd_iommu_dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 	iommu_completion_wait(iommu);
 }
 
+/*
+ * If domain is SVA capable then initialize GCR3 table. Also if domain is
+ * in v2 page table mode then update GCR3[0].
+ */
+static int init_gcr3_table(struct iommu_dev_data *dev_data,
+			   struct protection_domain *pdom)
+{
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	int max_pasids = dev_data->max_pasids;
+	int ret = 0;
+
+	 /*
+	  * If domain is in pt mode then setup GCR3 table only if device
+	  * is PASID capable
+	  */
+	if (pdom_is_in_pt_mode(pdom) && !pdev_pasid_supported(dev_data))
+		return ret;
+
+	/*
+	 * By default, setup GCR3 table to support MAX PASIDs
+	 * supported by the device/IOMMU.
+	 */
+	ret = setup_gcr3_table(&dev_data->gcr3_info, iommu,
+			       max_pasids > 0 ?  max_pasids : 1);
+	if (ret)
+		return ret;
+
+	/* Setup GCR3[0] only if domain is setup with v2 page table mode */
+	if (!pdom_is_v2_pgtbl_mode(pdom))
+		return ret;
+
+	ret = update_gcr3(dev_data, 0, iommu_virt_to_phys(pdom->iop.pgd), true);
+	if (ret)
+		free_gcr3_table(&dev_data->gcr3_info);
+
+	return ret;
+}
+
+static void destroy_gcr3_table(struct iommu_dev_data *dev_data,
+			       struct protection_domain *pdom)
+{
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+
+	if (pdom_is_v2_pgtbl_mode(pdom))
+		update_gcr3(dev_data, 0, 0, false);
+
+	if (gcr3_info->gcr3_tbl == NULL)
+		return;
+
+	free_gcr3_table(gcr3_info);
+}
+
 static int do_attach(struct iommu_dev_data *dev_data,
 		     struct protection_domain *domain)
 {
@@ -1983,19 +2050,10 @@ static int do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_iommu[iommu->index] += 1;
 	domain->dev_cnt                 += 1;
 
-	/* Init GCR3 table and update device table */
-	if (domain->pd_mode == PD_MODE_V2) {
-		/* By default, setup GCR3 table to support single PASID */
-		ret = setup_gcr3_table(&dev_data->gcr3_info, iommu, 1);
+	if (pdom_is_sva_capable(domain)) {
+		ret = init_gcr3_table(dev_data, domain);
 		if (ret)
 			return ret;
-
-		ret = update_gcr3(dev_data, 0,
-				  iommu_virt_to_phys(domain->iop.pgd), true);
-		if (ret) {
-			free_gcr3_table(&dev_data->gcr3_info);
-			return ret;
-		}
 	}
 
 	/* Update device table */
@@ -2010,10 +2068,8 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 
 	/* Clear GCR3 table */
-	if (domain->pd_mode == PD_MODE_V2) {
-		update_gcr3(dev_data, 0, 0, false);
-		free_gcr3_table(&dev_data->gcr3_info);
-	}
+	if (pdom_is_sva_capable(domain))
+		destroy_gcr3_table(dev_data, domain);
 
 	/* Update data structures */
 	dev_data->domain = NULL;
-- 
2.31.1

