Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C9915C2
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oDjagqCA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E49ao/H0eg44t3k0qDQHb8J2gwuFeDz40JVkqWRyEuZ+xFA7ykoRyVQUYBUz0vIWnyGatXuv40EQA0bCAyX28fuab4BOjCsjerU8nDtxjsL2JMBld71AqTGx47MxBIvazPeQUpfr4SiZhsDwIRREm6HSlJxvwIA70E3xFusassH6zuyVDZCvf2/IAubBtipmSi963xS7cUoKpJn9+jTlLOdnvh6R4eiUgATQn6G492wcVOpudUvTvsbdttXBYhy1j8oGG6wyqyhdWZ0iDSaLvilEbfNiUNv18DjvvrJw1BmCOAaxeFQjaNbBbJ86cG8TEqPmzaOf7LjuphNLAR6uvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mP9t7oumil7QUvyr4hl9IfrsKEN91SDS2/FUoZOQTJE=;
 b=FAbt93IIWRDwTrqYWfloRszOdSQUHPuXAx6YoLJ9m7vhyNBqiMpgU3GOjwvuVeD/Cwj30uBJ0kNeRpCd9M7Q/S3Rzw8MnAzf6wx1mtiD9yecdLT9xpYRfGo5usCOY0EfCaS5qkk5p8XijDHQIh+6gF0DrzWOKJl5c8w6Rh63PaFPj/6wdlVFf+u0IUg3x7e9Nwu4BarfEH700BBER3uL5R6dpUPiNHNIEyXK0FkU03WoFk4KYttBIFzrqVbrua57pWkvpNIYBPlBNapFQLdIZTy9Ee98tl42B1jjeFwQ92F59TVYcRpE5iDeLO+jvdai7ONr73mSfn2qMeefnyljBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mP9t7oumil7QUvyr4hl9IfrsKEN91SDS2/FUoZOQTJE=;
 b=oDjagqCA/YK/F3M45dNIgZvkhc+sJ88T9TcIXKF7f9fvjC5MTkK/IgqjDgtO6ud9ENW5JTpmiygLI4l4H1WFyeMA7EVNBwLtSPNDF8NjN0niDZwZW3alYg9fdpsdL7/U+n4lVdodArDnaxrgiGPu852dUvCNg/ytUz6og7xU4aI=
Received: from SJ0PR13CA0240.namprd13.prod.outlook.com (2603:10b6:a03:2c1::35)
 by PH8PR12MB7375.namprd12.prod.outlook.com (2603:10b6:510:215::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Fri, 6 Oct
 2023 10:18:48 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::e4) by SJ0PR13CA0240.outlook.office365.com
 (2603:10b6:a03:2c1::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Fri, 6 Oct 2023 10:18:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 10:18:48 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 05:18:45 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v1 07/13] iommu/amd: Consolidate device IOTLB flush code
Date: Fri, 6 Oct 2023 10:16:18 +0000
Message-ID: <20231006101624.5912-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006101624.5912-1-vasant.hegde@amd.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|PH8PR12MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b244ff3-8376-4645-8e24-08dbc655a163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gO5+YyS9XOSGE2PJYsRZVYvhJJIOfUqUzh51r95PCqyQzwgZpcPW7yjnui0lbxkLqsXMHh9tB/yTKR8ZIFtRDpAFmvQfU/KpkBPXhuGOXKKd4VcMrr2SZtqWORRe055Ds5S7uv7Pph1tBLVpE/dQBTLIdnp1bnuEccF4I+lvmI5KHnRIK89LZn7fKCkYQ8g1Xpv3xUDprwoOYqAbRSIKrtgskcocWcdFaSL9n+8qYskEw5ILxjSmMOuEtgSgktXtahSX9EBa5aFWWs0Q7gzzSPw7vvwZv4d/hgv7bL1NW/Nj5Hgc86Jyh1SCpOdYV8ztNKdLLLsB9o2FmG71ApAaQZKhexB/0qY465pH6Eg3qbaW7UhMtYA27bi24b4hZKxbLA4RmfuA+xhTlmLzjk+4507YFV9z7xT7DLVXcoOk0FS1d7izzDARB8sdpFiZee6taxSzpb6HwGa9yDdzRpmUQGyVf39QZ7nVLtnSG2jVyZyBlk76XI9CIIhhDYrTWISM0m/yIc9FSWCzWi9atSdYBAC1YB2FvRuS/PX/zIHSNUT2BCAA6YB4XX5+oknoQfhU8nWBPMhDmc2fsGt6LHUpqnsAD0+YYZ7eNmfrp2g2nrKtCfmDwzGdZD04w5DSECvqlaujepHgOMWvIra64MP6+QRFROju5hF1qFGRr2Cg7TF8eji8WaP6LszupZNjFXLMPp5X0qqfR7ND6iBTUuZSJHbzPs/sTvaJv8JZfaoCZGs2SvtwScuZ5JB3d/SA7Dyd7RTDY+0LmiEQUSIFGtHPjA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(46966006)(40470700004)(36840700001)(2906002)(316002)(44832011)(41300700001)(4326008)(54906003)(8936002)(8676002)(110136005)(70586007)(70206006)(5660300002)(6666004)(478600001)(26005)(2616005)(1076003)(426003)(40480700001)(336012)(16526019)(40460700003)(7696005)(83380400001)(47076005)(82740400003)(86362001)(36756003)(356005)(36860700001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 10:18:48.3670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b244ff3-8376-4645-8e24-08dbc655a163
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7375

Currently we have separate code path to flush device IOTLB for host and
guest page table (PASID table). Consolidate device IOTLB flush code in
device_flush_iotlb_range().

Introduce helper function to find page table mode, decide whether to
flush host/guest page table.

Finally rename device_flush_iotlb() -> device_flush_iotlb_range().

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2e7360fbc3c4..9a7f0f571862 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -83,6 +83,22 @@ static void detach_device(struct device *dev);
  *
  ****************************************************************************/
 
+/*
+ * For invalidation request without PASID, get the pasid based on
+ * domain page table mode.
+ */
+static inline ioasid_t pdom_get_default_pasid(struct protection_domain *pdom)
+{
+	return (pdom && (pdom->flags & PD_IOMMUV2_MASK)) ?
+		IOMMU_NO_PASID : IOMMU_PASID_INVALID;
+}
+
+/* Used to select host/guest page table for invalidation */
+static inline bool is_pasid_valid(ioasid_t pasid)
+{
+	return (pasid != IOMMU_PASID_INVALID) ? true : false;
+}
+
 static inline int get_acpihid_device_id(struct device *dev,
 					struct acpihid_map_entry **entry)
 {
@@ -1380,12 +1396,13 @@ void amd_iommu_flush_all_caches(struct amd_iommu *iommu)
 /*
  * Command send function for flushing on-device TLB
  */
-static int device_flush_iotlb(struct iommu_dev_data *dev_data,
-			      u64 address, size_t size)
+static int device_flush_iotlb_range(struct iommu_dev_data *dev_data,
+				    ioasid_t pasid, u64 address, size_t size)
 {
 	struct amd_iommu *iommu;
 	struct iommu_cmd cmd;
 	int qdep;
+	bool gn = is_pasid_valid(pasid);
 
 	qdep     = dev_data->ats_qdep;
 	iommu    = rlookup_amd_iommu(dev_data->dev);
@@ -1393,7 +1410,7 @@ static int device_flush_iotlb(struct iommu_dev_data *dev_data,
 		return -EINVAL;
 
 	build_inv_iotlb_pages(&cmd, dev_data->devid, qdep, address,
-			      size, IOMMU_NO_PASID, false);
+			      size, pasid, gn);
 
 	return iommu_queue_command(iommu, &cmd);
 }
@@ -1439,8 +1456,11 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
 			return ret;
 	}
 
-	if (dev_data->ats_enabled)
-		ret = device_flush_iotlb(dev_data, 0, ~0UL);
+	if (dev_data->ats_enabled) {
+		ioasid_t pasid = pdom_get_default_pasid(dev_data->domain);
+
+		ret = device_flush_iotlb_range(dev_data, pasid, 0, ~0UL);
+	}
 
 	return ret;
 }
@@ -1476,7 +1496,8 @@ static void __domain_flush_pages(struct protection_domain *domain,
 		if (!dev_data->ats_enabled)
 			continue;
 
-		ret |= device_flush_iotlb(dev_data, address, size);
+		ret |= device_flush_iotlb_range(dev_data, IOMMU_PASID_INVALID,
+						address, size);
 	}
 
 	WARN_ON(ret);
-- 
2.31.1

