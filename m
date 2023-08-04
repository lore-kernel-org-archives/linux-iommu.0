Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829F91FC8
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 06:46:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7Evy1yOG7Fi9RGMTz9LklWG8XpdQsqxKLXmZjOMqEdHWb76ykUTRT7rxxt9jde6u3TM4YyKwIqWDLje8tWngo/LZk3SKmj6CICoUjE9LNsWmcyxdUWNWkVBCNgXzAOmMQXC6FuN9N6k3YRqAIL9uAbmWgtIf8q5X6b4HjTW3AyJ6+yhbErFw/yTOT197qHZtH9fRtWHj4M7jPvk214IZQ4h7MQsN+nLItCEaHFaUq5Tl+C9jskepECjL6tGtwDql0i23RA2+dEytC1OcyBhpYMrhbvb5f/Y/KBb6vZDb257MTI4uHO8LP8vNdFGSWitoEgQ6JVr2ar9bAYIV0bROw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBlvyUgWOmd7LFMRRoxfmO/aeJYP8hRCdrOeQZ/HQs4=;
 b=OPyWTGEu9OcAGnqMWvAaUtls58K0YzAmbxjKs+ZahZ1IQVxXDypXLOljWBfgsjUVsTSAQlyYC2VYYzYQ40SwLyOnfXOfJCpZx+UXOERf4FBaioUhWZqk7EvohPIZ2i2W9G59vUlL6NmfsrhcgBmMK7bgZpnIAq7CDc/+AAB11/5Mx+idSgxO2iYcBYJbIt849be4THjAKfa4tSqbt0hqSiLexRkoeoRTRSAfURSK/sQ8plGaUxYriY7TXFds/0h6i/BzFhHlA32jbhkhqAUNS+4ER9SDys6iXS/aREG7GXKlfia3TuOr9f0xRqWHioyfS+hvLwwU2fwzD3G3qpXVNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBlvyUgWOmd7LFMRRoxfmO/aeJYP8hRCdrOeQZ/HQs4=;
 b=xX253I71HVxYp2/Gawwxsdeec07grejydVOBq5y9HjNwflnXe7yAysrurHiw/B3yoru3J1eyu+C2PlF2RlHsJq53NeHfqqf5ocP26RO0PdGjyU0l4PhLf51QGdLT8P2FQln2xN1xzlIi4pOK6ZUbOraLyUW8Wb9yy1QWZELTNIw=
Received: from CY5PR15CA0223.namprd15.prod.outlook.com (2603:10b6:930:88::9)
 by MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 06:46:04 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:88:cafe::e6) by CY5PR15CA0223.outlook.office365.com
 (2603:10b6:930:88::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 06:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 06:46:04 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 01:46:00 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 11/16] iommu/amd: Rename ats related variables
Date: Fri, 4 Aug 2023 06:42:11 +0000
Message-ID: <20230804064216.835544-12-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|MW4PR12MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: 279fb05b-a3a0-4dd3-6685-08db94b67966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	De+WZM9dBB3iO8P4JF0ZEOOfA4yVKmKcd9wzeCb6P+Ss6PYSVPzZBMjVh6ZiRuVAI4YXwrEYTw4kAUKau4Uz3RiR2UEqxuu8pb+PWPkiCJOjyHTsydcdYFJO04aE9nzMd4YhA3MCrQbHrryyPmOU3rdtMnxC2Qa5OBcs/dbLU6rhivHJuKMV3OrCqDf9tivyCFhssXmkxpiN6yjkwW+L4nsnvCxLW+bMVv/OPvF/DLm6RNA95u1P/CXLKTP3On2N5QE+8k42YrL4EVAVrzSUmueszAortqpVu0trbgdTURUYNVjY2ZEBu0P8hD9SisYCrkNA19CaZcJxgzbpB4l820LS4b5fSv1IDly7iBxpyf0lc5Bf/QXUOLyf+Ti+IL1V4oKsh2u03l14WCr3em8E1C2JTQ0raYGjvfSs9Ag7VRvsSWIbdAsInYiyI5jGYuTVafbHdetgskLenc7SfKbePa93agMj0FcBoMI2SOFOcikqrAwYAWQGqMwGg+SZlnZYNaSHK7GJN1eBr9PoKg5BSzq9Rw7YdugsF4RjoikPFIxZZngTzhx/5TnmmGf8C4y797RWqSuyS6dTlorrwH7jyrJ69/n4PQqq8hdlgirzG10apXlYRvwtZpDjhfA23LRmRMTFaeXfpInBNVNlauiDD9u5Yf9wkZIbvqBv8ozkXTIC740Mq4W7M8Zr7jtXP8HJloGPGbalM4OInrYqjEFCoKlrvKLaS1Wv5NoZiM8IhGeqEjq4ro0EUyYV8N21sS0hRPDdgTOWJFJZ9/WAROek+w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(82310400008)(451199021)(1800799003)(186006)(40470700004)(46966006)(36840700001)(54906003)(40480700001)(40460700003)(41300700001)(7696005)(6666004)(82740400003)(70206006)(70586007)(4326008)(316002)(5660300002)(110136005)(478600001)(26005)(16526019)(36860700001)(1076003)(83380400001)(426003)(336012)(2616005)(81166007)(47076005)(356005)(36756003)(2906002)(44832011)(86362001)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 06:46:04.3676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 279fb05b-a3a0-4dd3-6685-08db94b67966
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753

Remove nested structure and make it as 'ats_{enable/qdep}'.
Also convert 'dev_data.pri_tlp' to bit field.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  8 +++-----
 drivers/iommu/amd/iommu.c           | 28 ++++++++++++++--------------
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index bbb5ac4f0d39..b79c6e10684d 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -816,11 +816,9 @@ struct iommu_dev_data {
 	struct device *dev;
 	u16 devid;			  /* PCI Device ID */
 	bool iommu_v2;			  /* Device can make use of IOMMUv2 */
-	struct {
-		bool enabled;
-		int qdep;
-	} ats;				  /* ATS state */
-	bool pri_tlp;			  /* PASID TLB required for
+	int ats_qdep;
+	u8 ats_enabled  :1;		  /* ATS state */
+	u8 pri_tlp      :1;		  /* PASID TLB required for
 					     PPR completions */
 	bool use_vapic;			  /* Enable device to use vapic mode */
 	bool defer_attach;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e5b2dbf841c6..5968eb8d265c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1086,7 +1086,7 @@ static void build_inv_iotlb_pasid(struct iommu_cmd *cmd, u16 devid, u32 pasid,
 }
 
 static void build_complete_ppr(struct iommu_cmd *cmd, u16 devid, u32 pasid,
-			       int status, int tag, bool gn)
+			       int status, int tag, u8 gn)
 {
 	memset(cmd, 0, sizeof(*cmd));
 
@@ -1309,7 +1309,7 @@ static int device_flush_iotlb(struct iommu_dev_data *dev_data,
 	struct iommu_cmd cmd;
 	int qdep;
 
-	qdep     = dev_data->ats.qdep;
+	qdep     = dev_data->ats_qdep;
 	iommu    = rlookup_amd_iommu(dev_data->dev);
 	if (!iommu)
 		return -EINVAL;
@@ -1360,7 +1360,7 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
 			return ret;
 	}
 
-	if (dev_data->ats.enabled)
+	if (dev_data->ats_enabled)
 		ret = device_flush_iotlb(dev_data, 0, ~0UL);
 
 	return ret;
@@ -1393,7 +1393,7 @@ static void __domain_flush_pages(struct protection_domain *domain,
 
 	list_for_each_entry(dev_data, &domain->dev_list, list) {
 
-		if (!dev_data->ats.enabled)
+		if (!dev_data->ats_enabled)
 			continue;
 
 		ret |= device_flush_iotlb(dev_data, address, size);
@@ -1714,7 +1714,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	iommu = rlookup_amd_iommu(dev_data->dev);
 	if (!iommu)
 		return;
-	ats   = dev_data->ats.enabled;
+	ats   = dev_data->ats_enabled;
 
 	/* Update data structures */
 	dev_data->domain = domain;
@@ -1852,14 +1852,14 @@ static int attach_device(struct device *dev,
 			if (pdev_pri_ats_enable(pdev) != 0)
 				goto out;
 
-			dev_data->ats.enabled = true;
-			dev_data->ats.qdep    = pci_ats_queue_depth(pdev);
+			dev_data->ats_enabled = 1;
+			dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
 			dev_data->pri_tlp     = pci_prg_resp_pasid_required(pdev);
 		}
 	} else if (amd_iommu_iotlb_sup &&
 		   pci_enable_ats(pdev, PAGE_SHIFT) == 0) {
-		dev_data->ats.enabled = true;
-		dev_data->ats.qdep    = pci_ats_queue_depth(pdev);
+		dev_data->ats_enabled = 1;
+		dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
 	}
 
 skip_ats_check:
@@ -1916,10 +1916,10 @@ static void detach_device(struct device *dev)
 
 	if (domain->flags & PD_IOMMUV2_MASK && dev_data->iommu_v2)
 		pdev_iommuv2_disable(to_pci_dev(dev));
-	else if (dev_data->ats.enabled)
+	else if (dev_data->ats_enabled)
 		pci_disable_ats(to_pci_dev(dev));
 
-	dev_data->ats.enabled = false;
+	dev_data->ats_enabled = 0;
 
 out:
 	spin_unlock(&dev_data->lock);
@@ -2009,7 +2009,7 @@ static void update_device_table(struct protection_domain *domain)
 		if (!iommu)
 			continue;
 		set_dte_entry(iommu, dev_data->devid, domain,
-			      dev_data->ats.enabled, dev_data->iommu_v2);
+			      dev_data->ats_enabled, dev_data->iommu_v2);
 		clone_aliases(iommu, dev_data->dev);
 	}
 }
@@ -2608,10 +2608,10 @@ static int __flush_pasid(struct protection_domain *domain, u32 pasid,
 		   There might be non-IOMMUv2 capable devices in an IOMMUv2
 		 * domain.
 		 */
-		if (!dev_data->ats.enabled)
+		if (!dev_data->ats_enabled)
 			continue;
 
-		qdep  = dev_data->ats.qdep;
+		qdep  = dev_data->ats_qdep;
 		iommu = rlookup_amd_iommu(dev_data->dev);
 		if (!iommu)
 			continue;
-- 
2.31.1

