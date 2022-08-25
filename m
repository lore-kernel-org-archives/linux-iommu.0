Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF361C30
	for <iommu@lists.linux.dev>; Thu, 25 Aug 2022 06:43:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkOcie5VM9jqoeNLVxoI8ewU1CUv6QKOmK8UbJ0vErCq/+rQPK9z7iOxGCCd6+v13LPcbrRlljSOW2e3BDmmrTcG+59FcT2B9f2/oiYsHfTG3Vv0/+WhcfVp7+Rx7xE6XTl6jUyoW/QzZRauUZFlJolMSt4vZ358kpfg06InomNF/6n8gq44seIc6N4yIpUjWjh6PQfAihFLQLGO60y7E3i/26x+rn2gRjED7cDRX2/iCbxY8G441tPCwuUAhZClcaUnKbQBcVL4AjeMB8kapwNNNjpJWGR2YK0wOGGg03b+8+3JQEhim9ldTeyVzw/L252XWEVtqheCiPFHw+bZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMYYaUZPVkkdv5vSagmgCOf0HwtJQ5V2sRUDyJCSSxw=;
 b=eZTBkp6dM+rbHOwcpgK8B9+EKl454FkoneWuvG9lnpZEem6TaZkeuS2vAnF1f2JTsBdGY+gBu8umICC1tZPBjkJ+Zz7dR7dFQs6HI5Tg27ZgdydadXZARh9YLGZt39fxk8K8ToaB/JZfc8sRWn8zyCY3aawQ54r5l4wCBwllnVgLiDHVdeY6abFpCZm0iPH0ay0QhbmuFO2OdFIHB7vtO24cLBWbvj9AtyzS3ttFPewNe0KuR1DawkP/1IAdEnPvdWWfYCs5itBpHT572nULCr4WftRBpHwM44Wzya2Hzy5NXrreFvM8kMmlljbAqwaKcYlkmPu5S6lhdsbPHXI/IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMYYaUZPVkkdv5vSagmgCOf0HwtJQ5V2sRUDyJCSSxw=;
 b=SVQs+k4iAwfP8HLbtteGdZv/ng+xxSNpLsiaRJjiZXp/g+SU5uYy3vIwweNva3dLHl/QjFDDes10mquCASO/JeyM8SMfVIkFljVy/PoWeSUiarT93qja/9Hf/d9RbInrYZ7l8JmhrXo6ZxUy8c3zRUVsSEImCxzWN8RYbnnja9w=
Received: from DM5PR07CA0055.namprd07.prod.outlook.com (2603:10b6:4:ad::20) by
 PH7PR12MB5853.namprd12.prod.outlook.com (2603:10b6:510:1d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 06:43:36 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::eb) by DM5PR07CA0055.outlook.office365.com
 (2603:10b6:4:ad::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Thu, 25 Aug 2022 06:43:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 06:43:35 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 25 Aug
 2022 01:42:59 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>, <robin.murphy@arm.com>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 5/9] iommu/amd: Update sanity check when enable PRI/ATS for IOMMU v1 table
Date: Thu, 25 Aug 2022 06:39:35 +0000
Message-ID: <20220825063939.8360-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220825063939.8360-1-vasant.hegde@amd.com>
References: <20220825063939.8360-1-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: eaa30877-a496-4371-61ba-08da8665228a
X-MS-TrafficTypeDiagnostic: PH7PR12MB5853:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X+rvN0TDid1Gc8DuPXS0YIqH1UOIEVVNO5mrO7JmdAF+oAbbHh8lAV8TqAriGdkbdqImy2M6HsPV0nqnU1HEtJcL4B3U/EDV57ySk52VZgU9LeFuH80aG/7ogEFI4VoeWYbNt0DBNb0Edymo1uvqS7MQTqVmTkiSK11PBaFYHlCyBfaHQ1LYvxXGhywvf+zPQPX8iXqRS4djfDp1hFvgBmuGse00Juj0Hxy5Dl7OiIkdhCVvLRzUprxaNf53cKpXVSJjoOBA1rqSw0/gIiVauWwl3Z21oHvhyQbUoBEp9xhblarIjANGVsZNjS9yxsyMBwGAjIgAKWf+FFBAF38v93e+BUfkVUNtvMrThceci07PYiQTXaY6r2+g9exTWeRIk43o38X+LH+HQFE8WWBE++cjQzV2BP+E7OTdQdy2e8iD3ZSEzKreLplLp2Qwuo5kdHrloyFkOA0dvTP8DyN5heO0KwUF2AsxXzjmCpMqn0yqStlqwZKJfys8i8KgXRcul8gvb2tpPXrT/oNNJLxquhxnAvvvuWXBHAaq5KpyySjTLwNCErWsdJ7zOKqqWR2T5F58u7JW2+dc2+TX1IwTlTNgnq+sCic1JDfbd/uKdReX6xcFP6xi8iOi98GuszyjG5soFeeb2Iv4OSN5RfErUE1EVRmE25UBWVENxFC5+MOuVFgCjmgsXG6lDwi5bcMQRFgUqLF8rICODdk8VdzVB+TYW1M9yXCXcXjJiW9AElvM4VSUkKjGxQxeyRqUAo/iuJX5gqSvEdGc+3YJFpaSxr5pMRs6X4D1q7kx22QxEM8xYNykk2cEy5ZnIvLtbnVP
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966006)(40470700004)(36840700001)(8936002)(44832011)(41300700001)(5660300002)(478600001)(40460700003)(26005)(6666004)(2906002)(7696005)(86362001)(15650500001)(82740400003)(81166007)(40480700001)(82310400005)(356005)(16526019)(336012)(36860700001)(426003)(186003)(47076005)(83380400001)(1076003)(2616005)(54906003)(8676002)(110136005)(4326008)(70206006)(70586007)(36756003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 06:43:35.4722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa30877-a496-4371-61ba-08da8665228a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5853

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Currently, PPR/ATS can be enabled only if the domain is type
identity mapping. However, when allowing the IOMMU v2 page table
to be used for DMA-API, the check is no longer valid.

Update the sanity check to only apply for when using AMD_IOMMU_V1
page table mode.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1f8067615386..7d52ecea0298 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1694,7 +1694,7 @@ static void pdev_iommuv2_disable(struct pci_dev *pdev)
 	pci_disable_pasid(pdev);
 }
 
-static int pdev_iommuv2_enable(struct pci_dev *pdev)
+static int pdev_pri_ats_enable(struct pci_dev *pdev)
 {
 	int ret;
 
@@ -1757,11 +1757,19 @@ static int attach_device(struct device *dev,
 		struct iommu_domain *def_domain = iommu_get_dma_domain(dev);
 
 		ret = -EINVAL;
-		if (def_domain->type != IOMMU_DOMAIN_IDENTITY)
+
+		/*
+		 * In case of using AMD_IOMMU_V1 page table mode and the device
+		 * is enabling for PPR/ATS support (using v2 table),
+		 * we need to make sure that the domain type is identity map.
+		 */
+		if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
+		    def_domain->type != IOMMU_DOMAIN_IDENTITY) {
 			goto out;
+		}
 
 		if (dev_data->iommu_v2) {
-			if (pdev_iommuv2_enable(pdev) != 0)
+			if (pdev_pri_ats_enable(pdev) != 0)
 				goto out;
 
 			dev_data->ats.enabled = true;
-- 
2.31.1

