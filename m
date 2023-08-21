Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEB71848
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 10:47:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=am1Z2Q9fBye+k6hO43fEgxx1D5D0TEyQ7AkN0ZHr9z8H61D/35orFt3pkI+ZHA/IHhCHhqLWkB2hievckfYCYTxQ4jLTeEu+fGktQZIdK1D5giK+t9kV1D8QlrVHDQRXtU6xx1/SiObEl94W7n2fh9Ul0Jy1MBHOr8RGxn6l4i/sirv5uMeRWqlFSG/6qe5whI1XgVEKlV6RnlriRbM/OO3UBrdiW7VP7dT4LQXsD+TUfcjZePcNVCg8iU7+X4WAh+ui7UnE8zjctOZ7yZaNObsy6/Ay8Kfz+qU+xyxvT5CWFww3DPZRWuJ6pxjwAtahui9A8MjmGfTgptXQVljXrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXCo3Bsaod+ttppR43e8tpWTIwPTD6yYIuk+8wPjalU=;
 b=S5FCHksvnmlSk6WA/9YTqpRBQ0kf/Q4XO/RqV4px7nao5rJqXn8dD/pK10Th9XwKSNl2ZmZhphsNbnWjRQkatx/QVP9PV1xM6xi9ip22/EH30vQ8nbAZnX2lShsTNDmivi727jcntDySU0hXa77LT3Or62a2WHvq9opmbxdGzXQ3Wm1uKvGN6GhLSDSHb3ZcbTlTL7FyhzFjc+0/jBccBw8le5dctTOavjJhtji0AaZ3fZS/msHr/8iRwaAeEghs6YoZFg9GShwDzF2Lv2wuI+DuWlh4Kf3Nm+Gjxi9GABoRK6KCeXnqwZrtJrgTP3UIda3YOKgggXLUAKCreOkMwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXCo3Bsaod+ttppR43e8tpWTIwPTD6yYIuk+8wPjalU=;
 b=yXaxUqkC232vN0hy6RhywRtoDLOfwbrwTJCkJw/DFY3oYCqlBmdNa8rp+Grv5eeLnXTwVb4TIywGs6XMeANEHYILqbM5aEpccRqSRcI/xgnEahbje4fRKB2jNM+Vv2JvsjkDXunCq4DeQrjr0e5GugaaV51HjKWlBxPFQFXa1Jk=
Received: from SN7PR04CA0207.namprd04.prod.outlook.com (2603:10b6:806:126::32)
 by PH0PR12MB8823.namprd12.prod.outlook.com (2603:10b6:510:28e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 10:46:58 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:126:cafe::c8) by SN7PR04CA0207.outlook.office365.com
 (2603:10b6:806:126::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 10:46:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 10:46:58 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 05:46:55 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 11/14] iommu/amd: Introduce iommu_dev_data.ppr
Date: Mon, 21 Aug 2023 10:42:24 +0000
Message-ID: <20230821104227.706997-12-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821104227.706997-1-vasant.hegde@amd.com>
References: <20230821104227.706997-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|PH0PR12MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: 407210f7-3280-46bf-d44f-08dba233f196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6L0DC6Ww+S4Y7nFAqpLeKWOY5MwOTvxIKHw0VJv8YgbUhxDdNuudqPascX8be/LoONSUms6ZoQ2cTxVW8/2bW9BeRvFImQ+U+Ouj0DOrvKJ2CKOkxvy+tsAHJb+QwYEVXNhxUP00ZNZb23qSq/T0a/sTS7yM84YHwIdaAZs8t0jR/en3185MHhp0C6z2XCFlmb7m54KDg0QH7Vi6bGdznWSSTBERvFii1WRlZmeH7gtfN11fWcH1a+aILXLMihUHoLqk4A6KiRT+ik65e69wFKJ+YABF6OlbcMmrqjq8xmLio2eNeq9aaLePxVP/fec6KTSe9c3DS6JHIqurACqmaPtmt6SsUks9T5slBjHHww7Ex/tJEghOvpQYBbp2Im7tv6PxAriELmX/y7EWK2FolKEJbDU7ciNIn7g2uvWTFFXafUS9K8rbRtHy9D3pWwNBUx75zXewxVL/7qmAM94NDWKUGRJhSOE8foTz1QWKAQaPPSa+r8Pseu+dFDC1iDriblugWIv2mGeusayu8S9BX1zppd60tXwZGVDliHBqL0IT8dnnj9bxiEDy29Y2DO4BtCMUuboolNIOFH/XNFFDTtqtfNg7ERZoFFIEqfJ9vokwP8bJIjli+w8tpzoFR9829U4Uh3Pdz+9QzlHql+UqYe5g3OrlTR+jbWf37n+drQ/zP/rnROOJIUeZ/hrIBEWkk/TCMUW/bjUzx5IZv07ie9Y8dxzv3Zju+/N+nUGNonb91mlsugMPuNX9advYohNem2oVtLf8YwYgcbRD5Ekk6g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(7696005)(40480700001)(5660300002)(44832011)(336012)(426003)(16526019)(26005)(86362001)(36860700001)(47076005)(8676002)(2616005)(8936002)(4326008)(70206006)(316002)(54906003)(70586007)(110136005)(478600001)(82740400003)(356005)(81166007)(6666004)(40460700003)(41300700001)(36756003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 10:46:58.2345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 407210f7-3280-46bf-d44f-08dba233f196
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8823

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

For AMD IOMMU, the PPR feature is needed to support IO page fault (IOPF).
PPR is enabled per PCI end-point device, and is configured by the PPR bit
in the IOMMU device table entry (i.e DTE[PPR]).

Introducing struct iommu_dev_data.ppr track PPR setting for each device.

Also iommu_dev_data.ppr will be set only when IOMMU supports PPR. Hence
remove redundant feature support check in set_dte_entry().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 10 ++++------
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 1c61dca63824..87fa39c490e8 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -816,6 +816,7 @@ struct iommu_dev_data {
 	u8 ats_enabled  :1;		  /* ATS state */
 	u8 pri_tlp      :1;		  /* PASID TLB required for
 					     PPR completions */
+	u8 ppr          :1;		  /* Enable device PPR support */
 	bool use_vapic;			  /* Enable device to use vapic mode */
 	bool defer_attach;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 44d53d2bd755..9163e3a9aab9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1638,10 +1638,8 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 	if (ats)
 		flags |= DTE_FLAG_IOTLB;
 
-	if (ppr) {
-		if (check_feature(FEATURE_EPHSUP))
-			pte_root |= 1ULL << DEV_ENTRY_PPR;
-	}
+	if (ppr)
+		pte_root |= 1ULL << DEV_ENTRY_PPR;
 
 	if (domain->flags & PD_IOMMUV2_MASK) {
 		u64 gcr3 = iommu_virt_to_phys(domain->gcr3_tbl);
@@ -1734,7 +1732,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 
 	/* Update device table */
 	set_dte_entry(iommu, dev_data->devid, domain,
-		      ats, dev_data->iommu_v2);
+		      ats, dev_data->ppr);
 	clone_aliases(iommu, dev_data->dev);
 
 	device_flush_dte(dev_data);
@@ -2013,7 +2011,7 @@ static void update_device_table(struct protection_domain *domain)
 		if (!iommu)
 			continue;
 		set_dte_entry(iommu, dev_data->devid, domain,
-			      dev_data->ats_enabled, dev_data->iommu_v2);
+			      dev_data->ats_enabled, dev_data->ppr);
 		clone_aliases(iommu, dev_data->dev);
 	}
 }
-- 
2.31.1

