Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5D61FC8
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 06:46:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ev4pRXzqi2f6ggVZJfVpxgvpbVKYzcryXpNCdyLqktRkwokCoJpxdEMA6L5f2meQLFp8aJUfEEDiICY55KMroNs24WSa9CjTqIUodUjypyeYufa+xmFicfqA103hm5WgupVpX9b6kAwvQ9wlFqRT81aabJ6VLsM2GwMcbny6vofrIYonxAZtDPKf3uQON9cg4n+NZVlEJlC3qWI1kYasWlt7gZzAY4gFB87n/VgXYVMrLtouVUclnVjmVKp99D0K7bcA2q7Klji0ho5ZxvWuBGgx4EfwZVBLY4VAYtUvvi/BldTLTCx8yufjo3oPywStS05Pf3wZ4/Yhwl7ObDigFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztvTvjoT6tel7hlvpVjwnKx5mix4XynxahFOo4S0EIM=;
 b=i4gLRkN0bUFXZe8JlTGS+HqsSM9vQy18LlnPjSMxUoHqfGT3lQCcs6eqFUJCGC850T6uE58HV+SGsKcARTX6k3GXXIxtCXzHwjAdo8Yosh41PWptb3E1iqKpgSjvR36rQ9D8haJ9qpUKxQMArjsuAFEmZA50029LzK5Oa7ujwFuGdroBr47ZkUbQcMsdOtEwUn0n32wT3hwpBsAKAnQIcHxZHjYtigvotsf3LQyqSFi7Sa4K1SOlf03nFJ2rMqFy5IykBdD1CrJnuTZ7t49TOa8z3qgD7IGwi4wt5Fkm7/29t064utDtUkU5wZs66LsgiPvxvkqLOex7zwn3MoyEGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztvTvjoT6tel7hlvpVjwnKx5mix4XynxahFOo4S0EIM=;
 b=BWvaN6FvuQiGbqd3QmuYs1bbOYS2eBlA4uL9eg3mWVJiX9mB1TmZqVIbTMoTcRkjpbfndQK6AllxEWajuibwRU7nSEpkaSCQXV9SN/oZSfZDtEk1vvtkTh3qlUxWxj0uJEyxlVJ2P/7zs5ILacMZ4U1z22vuvuJwasp4KC34BWY=
Received: from CYZPR11CA0007.namprd11.prod.outlook.com (2603:10b6:930:8d::29)
 by CH2PR12MB4940.namprd12.prod.outlook.com (2603:10b6:610:65::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 06:46:43 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:8d:cafe::16) by CYZPR11CA0007.outlook.office365.com
 (2603:10b6:930:8d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Fri, 4 Aug 2023 06:46:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 06:46:43 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 01:46:40 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 13/16] iommu/amd: Introduce iommu_dev_data.flags to track device capabilities
Date: Fri, 4 Aug 2023 06:42:13 +0000
Message-ID: <20230804064216.835544-14-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804064216.835544-1-vasant.hegde@amd.com>
References: <20230804064216.835544-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|CH2PR12MB4940:EE_
X-MS-Office365-Filtering-Correlation-Id: f9445d98-98ac-47a5-186e-08db94b690a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WYdEvhLLPric4VRnSOQ9S3oo4Jb/VOp+9CdhNn/21QKqlor4wkWVscIarAzf7XdaLrp91t3ZoHxVhwVa/qddH5C45fy/4e79SCOpsUx06j+0Txjt20ShH1AnLm9s4eTPhHsHZ9M4W08or7DTDYzYZmluJ3lmlmoh76SKUXomV6gjkeJf7lZSM9+//Oz49TvBZqNf5d53KXOdGSbZkr9zi22LbgrGl5XuAIrDzE2WSQP+IOckNAB9ni4nf8BZ4xT1yxkYedu9Y/0Q6s2HW3kiXGrNC5FBXB/9ctKYuILkFsOLObJ1WeYbin9HHoBICGhdL8k1SXLtfVJIPfBrVfcXloinLExnDEwFeTz755Ixj+DHDgH1AAZMmoUwgI8z5AzgGKbmQo4gKz4Mq+6A2WCXm4LhLw11eNqnamFZanleuk7w29g+ePdH2PdTG/8K30zyidl7O+CpWpGbkR7b3ABD3mEa+sHMU5VB/Z/bPCKMpLiWoExCBxVUIv7RLiRPSCNQoNetHnTM1kd1xnHKIzJqXN05RbWESkmpwVQ+Eq78sdG+V8ExSnFW7O+qHC+legaE9+StkRbPiymlKc2pCsK5lPOHL4sizHTF7OBSGznd7VjAzmwSvbzFqUlr2w5+b1kejyBcypQI4n55gOFwWGeWO3dgJATsx9jgeLEJjFPlmdOaIwe7TirlkhQpNfkEYo/AUJt/RSrep2qLb0pDoxDLv1ExR0TajCgq/3B9FRPOQUYZj2VtazT86ZAovHVfZDXY3f1dXFKQQyiPe7uzstaKIg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(82310400008)(451199021)(1800799003)(186006)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(6666004)(7696005)(82740400003)(70586007)(70206006)(4326008)(316002)(54906003)(478600001)(41300700001)(5660300002)(110136005)(83380400001)(36860700001)(16526019)(426003)(1076003)(336012)(2616005)(26005)(47076005)(81166007)(356005)(2906002)(36756003)(8676002)(86362001)(8936002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 06:46:43.3791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9445d98-98ac-47a5-186e-08db94b690a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4940

Currently we use struct iommu_dev_data.iommu_v2 to keep track of the device
ATS, PRI, and PASID capabilities. But these capabilities can be enabled
independently (except PRI requires ATS support). Hence, replace
the iommu_v2 variable with a flags variable, which keep track of the device
capabilities.

Device PRI/PASID is shared between PF and any associated VFs (See commit
9bf49e36d718 ("PCI/ATS: Handle sharing of PF PRI Capability with
all VFs")). Hence use pci_pri_supported() and pci_pasid_features()
instead of pci_find_ext_capability() to check device PRI/PASID support.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 ++-
 drivers/iommu/amd/iommu.c           | 39 +++++++++++++++--------------
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 443b13b56235..89eb65117c1f 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -820,7 +820,8 @@ struct iommu_dev_data {
 	struct protection_domain *domain; /* Domain the device is bound to */
 	struct device *dev;
 	u16 devid;			  /* PCI Device ID */
-	bool iommu_v2;			  /* Device can make use of IOMMUv2 */
+
+	u32 flags;			  /* Holds AMD_IOMMU_DEVICE_FLAG_<*> */
 	int ats_qdep;
 	u8 ats_enabled  :1;		  /* ATS state */
 	u8 pri_tlp      :1;		  /* PASID TLB required for
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 888bce5abe56..490c19284a4b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -314,24 +314,25 @@ static struct iommu_group *acpihid_device_group(struct device *dev)
 	return entry->group;
 }
 
-static bool pci_iommuv2_capable(struct pci_dev *pdev)
+static inline bool pdev_pasid_supported(struct iommu_dev_data *dev_data)
 {
-	static const int caps[] = {
-		PCI_EXT_CAP_ID_PRI,
-		PCI_EXT_CAP_ID_PASID,
-	};
-	int i, pos;
+	return (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_PASID_SUP);
+}
 
-	if (!pci_ats_supported(pdev))
-		return false;
+static u32 pdev_get_caps(struct pci_dev *pdev)
+{
+	u32 flags = 0;
 
-	for (i = 0; i < 2; ++i) {
-		pos = pci_find_ext_capability(pdev, caps[i]);
-		if (pos == 0)
-			return false;
-	}
+	if (pci_ats_supported(pdev))
+		flags |= AMD_IOMMU_DEVICE_FLAG_ATS_SUP;
 
-	return true;
+	if (pci_pri_supported(pdev))
+		flags |= AMD_IOMMU_DEVICE_FLAG_PRI_SUP;
+
+	if (pci_pasid_features(pdev) >= 0)
+		flags |= AMD_IOMMU_DEVICE_FLAG_PASID_SUP;
+
+	return flags;
 }
 
 /*
@@ -391,8 +392,8 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 	 * it'll be forced to go into translation mode.
 	 */
 	if ((iommu_default_passthrough() || !amd_iommu_force_isolation) &&
-	    dev_is_pci(dev) && pci_iommuv2_capable(to_pci_dev(dev))) {
-		dev_data->iommu_v2 = amd_iommu_gt_ppr_supported();
+	    dev_is_pci(dev) && amd_iommu_gt_ppr_supported()) {
+		dev_data->flags = pdev_get_caps(to_pci_dev(dev));
 	}
 
 	dev_iommu_priv_set(dev, dev_data);
@@ -1846,7 +1847,7 @@ static int attach_device(struct device *dev,
 			goto out;
 		}
 
-		if (dev_data->iommu_v2) {
+		if (pdev_pasid_supported(dev_data)) {
 			if (pdev_pri_ats_enable(pdev) != 0)
 				goto out;
 
@@ -1912,7 +1913,7 @@ static void detach_device(struct device *dev)
 	if (!dev_is_pci(dev))
 		goto out;
 
-	if (domain->flags & PD_IOMMUV2_MASK && dev_data->iommu_v2)
+	if (domain->flags & PD_IOMMUV2_MASK && pdev_pasid_supported(dev_data))
 		pdev_iommuv2_disable(to_pci_dev(dev));
 	else if (dev_data->ats_enabled)
 		pci_disable_ats(to_pci_dev(dev));
@@ -2467,7 +2468,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
 	 *    and require remapping.
 	 *  - SNP is enabled, because it prohibits DTE[Mode]=0.
 	 */
-	if (dev_data->iommu_v2 &&
+	if (pdev_pasid_supported(dev_data) &&
 	    !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
 	    !amd_iommu_snp_en) {
 		return IOMMU_DOMAIN_IDENTITY;
-- 
2.31.1

