Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB461CAA2
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134650; cv=fail; b=ltJOgj9P5d2k9c6dTEray77TBFdvG/2nUXpjYot7CI3+Bb8MxfSenMNE07dujyEfpHPW/Xpd/6eQB6Sn+S5es7HW/eD6BledL8g4DwC2GdMEDkPyXZjxhkbvdAdmU+1lngIdnQGZrcfrvOHz5bYp6FURNjkRJOqsTNibnqYhRSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134650; c=relaxed/simple;
	bh=TJ3dEUifZHoVlVCG3xtYZW3igX/8d9RubCWQ4qyCy9w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ntbLYFe5d/eqw4knf5DD63k1VZeu33eZRxSHqfkwYymLIoU9BrWk+Ne+PgrM15pWQLrgDbXRVbw+uApDpFoStjZcpTZNeUguryXLzG+1LlP7ZF7F3Z51iFLpeGJHjrYccWMZaPVxrafC+aTnCfMbLYTKFZYUv6MyjY5Wg3tqpLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z1cbPxIc; arc=fail smtp.client-ip=40.107.96.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z1cbPxIc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6uFMrrHgrQKive62boRq/CC6dhuCNAf97neLOdfEHB6H4cqROKEFvV+ebCq2V1ah8oMqbBHpwxUdLUe75JPUwhRrpgpY2aAJdBCByMxQnOgfI0as4kmOwuZsXzaN9v1zLQt37KdsKcbrlx0sN2+WIImtX1stuV6SLqZTw0CTUR8FXU+azoMLO/fWHtCj54h7tFzmJCpVZxdER6feNfBLn4Ud+/Ty9cKZXpWNqp29HfyjD3bw39uv0YQYNtyFnpPh2wpcoegOrOKVq4FxYwuUHrOs87FQsp6C6rg8eFVhGaPBuGgsJMC6n5sWJxWo7j/qfNq3kWQE76ZuVkwtwaB1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z84wgASlDf25O10GeAybiwdXZAF5jZtQRb6M9f36paM=;
 b=BGjnMqeGyC+EYA1M7gdsGe4TgqcfsgCdSyW7gHOK+UFG6inxFmZHoDbdlnITgRle9qAy+pXeT+glCMSpeAwlvg/axaFm01aND1fX9W+FRnh2H6ebCv9RXDyw8rEp/x5iNG6WsGBemX0cEmMXhH6snmbGj/Xik2vM+J3t0p5vnljCJYRXyA1/PyvoDruF1snXm3ZnC/vLGui+MqiGw+nbrPO2t2LOKnBem/g7zYOitWagKxlQNosqfQ5Lbykbpg8ab9nUnb1AJpKXlS5KuH2aGvngRXTp7pBA7Ixcp2N22VEBMVyDvpPd7RiXB/ZS9XavvRn102yM915BZdc62YAjAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z84wgASlDf25O10GeAybiwdXZAF5jZtQRb6M9f36paM=;
 b=z1cbPxIceBwKH22A3z736Bs89lQs8No/rfgL4s3UVuUpdbRKCFCit/1oUQjiRDDvYbRJeVoAO8TTmV3VdrnXnIQIqwRuRKZHb9pbY7JP5Z+E5K/MWJ/EKZwMwa8FB2P4Q2rmLEjHCKG4aJuTwQjHYZbUhSaHXwAdWqUf9WrmfXI=
Received: from BN0PR07CA0016.namprd07.prod.outlook.com (2603:10b6:408:141::21)
 by DS0PR12MB7631.namprd12.prod.outlook.com (2603:10b6:8:11e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Mon, 5 Feb
 2024 12:04:05 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::20) by BN0PR07CA0016.outlook.office365.com
 (2603:10b6:408:141::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34 via Frontend
 Transport; Mon, 5 Feb 2024 12:04:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 12:04:05 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 06:04:01 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 16/17] iommu/amd: Remove unused GCR3 table parameters from struct protection_domain
Date: Mon, 5 Feb 2024 11:56:14 +0000
Message-ID: <20240205115615.6053-17-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205115615.6053-1-vasant.hegde@amd.com>
References: <20240205115615.6053-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|DS0PR12MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a25808-4973-4eaf-b629-08dc26428d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BI92ebN2OljSflMrSy7lrmV9sTy0JyE5nv/xBL3OIk+aFu7Jga3JMDJQWqaTyVhpjcqZJtLIL/dMbbxvRLNbLeDK/yRomj5deIKIR0Wt/d5U+NrRqePcZJ7RfkqYcQUmd7YyQUov345unUrEcSgGOjCjK8UFaAEBTz68ne65+XrqRHA1zEMG4byPh9cJDi5zID2DdOv1aCL2gy3l0IrSBgJWv/iRFrkWzmWt/o3NtoECvnHU6/S9utzyyovw1PB7JTAliK321ZgrKJCYGtL6GmXoi57bfgnPTRj2sJykeQKW4PRImHMN/BtTl31cQtsfpJmsPYfPS9s59s9vNqOoKyajYugsIbzX5PQ4wcxKjvg6VQ+jFdg97OzXDFq79kxJZ8akuMHTL/QIXJmVBxKIFEB5ps7MSFENxmTtqLqfl3kVSudoO5NuWffzx+70dxof9xNcGjwJm8hipgHGTiqqrBHfvLIMJgOmZK0yDJUgjJ4gBONvEtiaWpB6njpYEdqcq9zuY8ba99LzByBiBoDHEo/gKtyXEMeDaWDsgL4z8levTUqbRdIWAFNpUNvsBMKEfsei3jxEzMnXAaRyptdLgvCml/OoZyWkowI1B2GnZOnsh9ZxsfkoI9oR+07YXOtSy6iHpJLUc1erUy3F1Gs5jXEYGMJttkmKcRxs38xujY/8wrwIl1ITE0XFbikopqPz3OXs6I1FKO1M9tUiRb486mbP/ibqS4DY9KQXQZ7vCKzYigwWnfRK1WfskqJDNnqmOpz6t0HowiHVn9aq+n84+g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(64100799003)(186009)(82310400011)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(36756003)(41300700001)(110136005)(6666004)(44832011)(5660300002)(8676002)(70206006)(70586007)(8936002)(4326008)(2906002)(82740400003)(47076005)(36860700001)(7696005)(81166007)(54906003)(86362001)(356005)(83380400001)(316002)(478600001)(336012)(2616005)(40480700001)(1076003)(26005)(40460700003)(16526019)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 12:04:05.5961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a25808-4973-4eaf-b629-08dc26428d25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7631

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Since they are moved to struct iommu_dev_data, and the driver has been
ported to use them.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 12 ------------
 drivers/iommu/amd/iommu.c           |  2 +-
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index fead9033796f..79a07a2e4bec 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -453,15 +453,6 @@
 
 #define MAX_DOMAIN_ID 65536
 
-/* Protection domain flags */
-#define PD_DMA_OPS_MASK		BIT(0) /* domain used for dma_ops */
-#define PD_DEFAULT_MASK		BIT(1) /* domain is a default dma_ops
-					      domain for an IOMMU */
-#define PD_PASSTHROUGH_MASK	BIT(2) /* domain has no page
-					      translation */
-#define PD_IOMMUV2_MASK		BIT(3) /* domain has gcr3 table */
-#define PD_GIOV_MASK		BIT(4) /* domain enable GIOV support */
-
 /* Timeout stuff */
 #define LOOP_TIMEOUT		100000
 #define MMIO_STATUS_TIMEOUT	2000000
@@ -571,10 +562,7 @@ struct protection_domain {
 	struct amd_io_pgtable iop;
 	spinlock_t lock;	/* mostly used to lock the page table*/
 	u16 id;			/* the domain id written to the device table */
-	int glx;		/* Number of levels for GCR3 table */
 	int nid;		/* Node ID */
-	u64 *gcr3_tbl;		/* Guest CR3 table */
-	unsigned long flags;	/* flags to find out type of domain */
 	enum protection_domain_mode pd_mode; /* Track page table type */
 	bool dirty_tracking;	/* dirty tracking is enabled in the domain */
 	unsigned dev_cnt;	/* devices assigned to this domain */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ae42b677480b..bcf8f44e0860 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -90,7 +90,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 
 static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
 {
-	return (pdom && (pdom->flags & PD_IOMMUV2_MASK));
+	return (pdom && (pdom->pd_mode == PD_MODE_V2));
 }
 
 static inline int get_acpihid_device_id(struct device *dev,
-- 
2.31.1

