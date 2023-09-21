Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE5D8F55
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 09:27:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsJEZsRR3atpa1C/puHffe613q0LBRP8A8Jyiqkujyx1R2zso8pjUwCbUT5Egbf8kiCuz+OMwkbsmAeCQlTCdxC/P7iKIQkZDJIfVa7jpO2zjMPVrxmWV1+zLFKJAqAI0Xt8WbeoxMvZh07cDnZ/b+eXUWKxMXH1L4hTu/qhFCmD5LjCS0LZCG7pyz0iJicg02vh2YCGe6KmdK615667e6ceAZl61tZYsMj53KnL29NP1qUtB2hGpltvltbIuu1TObr4ThZlCNey2lNeXRho5PBdf2alvrWREqRehE9R9IWbKMfavGmw7j1T9DLzzAHAGBvEWBx25dXZ1nOjW9bDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwhwWF2H39WpDjlmxm+tOAOEYQzwYJONiU9z/aoXG5I=;
 b=lygWtWDRPHgMQrY/wEGF+i0FAzgh3joqubgDgUXKfXbKcQrIAJ++S5EbboNk07Mr7T3e0DvA8po7Y8ZqJihjUGoaepxQ28xb6Pj+GBW34SRUa/+h3/nUb+ovis8l8U/Ht5WAQEvMgvNpgNn1vacqbUobaypMyQHEeE770zONgDAhnFQ3m6Fo7lkyykXk28FZQBXcUu0Z1Fw728+BVv/GfBgPIaztVb7HKSrKrer1DLncwglH/XUdakvSJCBWBZjo8AXlLjQzH/1a/jUjte9iUPT5hh9ewtb1+B3H1zhHTrirmRJr2MfZ6lraJEEr0ZtA/Dv0RXfxGyGhOry2+k/tUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwhwWF2H39WpDjlmxm+tOAOEYQzwYJONiU9z/aoXG5I=;
 b=hET4NXfylHm1rE19gzy09/PvQjgwjqaqbL6CFAHs9VZldDsNUWP+3E2Ut3oagwNGxrOLaw/kK20nRNxP3hUSU6tAsfr2kv25CQWiMIleirC+cPJaoeDX8CC5KO5OWT9Bh2yfLyPHLgludRk/AO2uOai0xzdAUUYgziujVEUCgOw=
Received: from DM6PR02CA0069.namprd02.prod.outlook.com (2603:10b6:5:177::46)
 by CH3PR12MB8075.namprd12.prod.outlook.com (2603:10b6:610:122::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 09:27:23 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:177:cafe::d1) by DM6PR02CA0069.outlook.office365.com
 (2603:10b6:5:177::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Thu, 21 Sep 2023 09:27:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 09:27:23 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 04:27:18 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 11/14] iommu/amd: Introduce iommu_dev_data.ppr
Date: Thu, 21 Sep 2023 09:21:44 +0000
Message-ID: <20230921092147.5930-12-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921092147.5930-1-vasant.hegde@amd.com>
References: <20230921092147.5930-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|CH3PR12MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: f6622a19-0481-45db-d91f-08dbba84f66a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u1Iv4c3jcituyWgXtRiMw9EOtZE0fPNP3aR5U5qCYG9OoQgNXAStwHPI+G/6c6KxmGT641V6VFs2qShbIK9iBgk2e0qWazdaFhb09alNFN5GChbkPGhr1XDMjwGoxPP97+T4cIc0QzhlUrHDcgVPktYtREMF1CGolMVZzYYI1Mf3KXbZ06dFUd60TPpa/YMHK5g9x3YiE18MKL/Tgqhmr7xwmDULhGjEA9yIhvBJrccZhC8YqsKc3GE5wVAoGXVBlDv+XuhX7dDdTv188CipTmdTuUjArvCRS6u+FKXnRH2P1qCMT/IXFmEQRUe6MriV5edXVtPwg2l0T+ij3VH0XyUCDuHxo1sx7u6kbMdABGGMNSwYE0gHEmJOF/0AWAk+jAFZixWkq4lJVQR8+MWYWL4RJj2kjAhVcTO8I1LheMsrc9+ehvHAD6ugxfV2BEy7DOVifwWkF8CLtLgBU36pLcviylYD3AF3R/M183mOuAtn0PwyJfTP5k+InIM73iJvxkYuInm34+4WVecAlP+HBWCmDKWDjiBMl+9xVxhcMw1ofdBuybg9AmVVmip9nDJM7+Kp2VEmo8hbv00F9EJTIo1fEkgK42m2kPT0GNEsc6iOL/qlW5p2a3g1qRxJfA2eCrCKc2bf0UoAvuIx1szN99tI5FYtHCQgxaU/ty4Zfg36prE4bX1cVbErOs2g1x8q3cg9gbC+IuZtSGFDWAFVhFAZdjCd7YPlPp7HHZWyPf+ye2lWs6ZQuCPO7vYhq4/2Uh5fXaej12z9cqn4SDs/nQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(1800799009)(451199024)(82310400011)(186009)(46966006)(40470700004)(36840700001)(36756003)(40460700003)(86362001)(41300700001)(40480700001)(8676002)(83380400001)(44832011)(36860700001)(16526019)(356005)(8936002)(4326008)(5660300002)(426003)(82740400003)(336012)(1076003)(26005)(2616005)(7696005)(47076005)(6666004)(81166007)(70586007)(478600001)(70206006)(2906002)(54906003)(316002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 09:27:23.4297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6622a19-0481-45db-d91f-08dbba84f66a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8075

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
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
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
index 433000276923..4ee69ccdc17b 100644
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

