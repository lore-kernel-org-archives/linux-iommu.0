Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8799C10788
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 10:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwu6BPP0EnRbUKL4jjuaC8tfeOqd6Eg2K5IHI2evwZrtBNVJd8oCuMKSvsuhNN754PSafx4rNyRo1jypuROqqtx+NmSYIVlcYEMPWNTKmZWAit6+RcNn3dh1JHVrFJZ56oO0l42lS9ZDeJ8FO/LBRWc0t5ztpiIaejFzNijV8+arMrxWO9flom9LQioLNbP52Wpipp5EIeFqXge1LVC5npEF5ciRWYIeVVh9wTNGXVVjZZjvqfcvJNjLiYHv8fX/A8kLEz1w+zzlc+Nw81PswB/i1NGfm7BOyGtJsTJLqmAf+tG6y5KykqWUBWcCpTBFOWaxp1v9Lb+clLDO8LZypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhZijRoBpQriwCbikSI43inZIxSFeeLOEjqiL3pDb/Y=;
 b=DHtBpmDa/3i4IxWqtd9MbCv1gOS0TuXJpofBJRX3Iz3T9IizZbh3IVm/XhTgaHtQgTR05Pf+8FwZaequE6lMrb5VoADIYrmWRnAYSX/cnseg2O8C31ZVHWExP07rg9RhDnQ8YOM/O5E4XcMbvj8xtbOuFpPcodKBg6zQxwKL0Hew0FeT4DDir1s+X+zOxnMZfb0jeu/y1i8gB87YSd4wBil4ScE7/9a2zLC1JjDkMoFqabye9+1yxCusoB3kjmln7GZCVGz61G06k3JlGecjrgmLPZJdwVBZzbzGyy/aOeQbDGW5x7k2jEopfQalrmYAx/jETVQw6g60uCjuy8Ln5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhZijRoBpQriwCbikSI43inZIxSFeeLOEjqiL3pDb/Y=;
 b=jhweJwzLrtosU812TAc13zTWMno0wa1IBTmhwVXsq1p7PSfsqCpRRXXVd3yJXoT1EwEQ6xoI7Fku3lTRVbSp32BqyVPljWpMxDjX30jqjGpjmUpNFUUW3WKFMOst4SBbDYNTgctIayquF8o0n34vYa029uDbmQzYtcS1SGS8zNI=
Received: from MW4P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::12)
 by DM4PR12MB5327.namprd12.prod.outlook.com (2603:10b6:5:39e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 10:25:53 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:8b:cafe::43) by MW4P221CA0007.outlook.office365.com
 (2603:10b6:303:8b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 10:25:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.3 via Frontend Transport; Tue, 15 Aug 2023 10:25:52 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 05:25:49 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 11/14] iommu/amd: Introduce iommu_dev_data.ppr
Date: Tue, 15 Aug 2023 10:21:59 +0000
Message-ID: <20230815102202.565012-12-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815102202.565012-1-vasant.hegde@amd.com>
References: <20230815102202.565012-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|DM4PR12MB5327:EE_
X-MS-Office365-Filtering-Correlation-Id: e740110b-cf90-4c0b-b97c-08db9d7a00fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bQ5C+O6xzdzZuiBZvNPBjUg7BgybSe40JpOjGSZ+KYMedq04+y3Vh3s+E1BlJ1iNf5FKT2vkzXs0VEaQdpFw72lAGgQeVPerFpvVZ8SwrgG1RIceRAFgnvIqLDq5ag/v3cTPrAKGDrLO8+nxNzC5D/+4wy8mBH5ufHFGCLFCMIB0rS7lJLRMcF0jwQS5AlZXoMj64lBUHkcH8Z3TAjk2+YylwlT2KRbAdXyXufTNIgyjrheGomakcrIN6QI+qym/rBw5WR4KKOUg3I8hDjNS68PUWKy4mDndY3BrFs80Q2k/RkGTAJdhDF6SGmcqNycFY3pI5JwhMjXh9UgP909UYorFrakrjttwSgNs8xtoxMSOxHFcWuCYC28AGH+XJ7ymh+G2RQSIu0J4WyuvdhgNPrA8aKl9xbaYRQUsglukSfsRbyufwo6TPIoJosTenDQKQj5E4YOXEu+QMgswXOMOLHDHYLUat+6ZzHy5kjV+7qeBEuzntqMb53ukL39zKLtSMFOIWSV/n80vmMjv/NEioLwGrvTTb35V+5z8Bo1/zRyFgq7Yuggl74fXxAQNjA51yvvIxvnRmNb6Lm17ovlsr9nGhApKM1Fx961eX0PTbPVco1RX95P6BH+crzi4X8TgtSBvqtdtgduebUrMgv4L+oaUvJjUmjzChGNI1DyKQlawYCrNQklHWGtmfWnJUbQXXevSHOW0eX54en0nu9kkLI843SxSFI6mxzw1QtJJxI9fHaXakqcuzpq65Bx6/AYh8ZzwbT0wK190DrSGfQXfMA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(82310400008)(186006)(1800799006)(46966006)(40470700004)(36840700001)(40460700003)(336012)(426003)(16526019)(1076003)(26005)(83380400001)(36860700001)(47076005)(7696005)(41300700001)(54906003)(2616005)(70206006)(70586007)(316002)(5660300002)(44832011)(8676002)(8936002)(4326008)(2906002)(6666004)(110136005)(478600001)(40480700001)(356005)(81166007)(82740400003)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 10:25:52.9406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e740110b-cf90-4c0b-b97c-08db9d7a00fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5327

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
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 10 ++++------
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 1c61dca63824..c9027119ab35 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -816,6 +816,7 @@ struct iommu_dev_data {
 	u8 ats_enabled  :1;		  /* ATS state */
 	u8 pri_tlp      :1;		  /* PASID TLB required for
 					     PPR completions */
+	bool ppr;			  /* Enable device PPR support */
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

