Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB65818643
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 10:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LpIeTgL1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ylhm7HYtwyvW/5y2V5iU/lUhdTu6+iUCsQhjfVU9ZjdWMkgCyKhewt4MhWFHfXIjs0dp5xvDEgOkGbCRFmSNC5CtCxfb235qh3GL6e5T0eKB3jB2SN+UZBYSEBEgXdkKpVvw2L4Pi5gGE3H380tW4SLCi3VbhA+cMM7Ee8F0m3xc8OuqsT/CLQCi2Oop23E0mRKCbNusvD3KZE58sEw3qtG83hnfSO0+ONNSsr3/XWUg6XX9EWyL45HtI3QJ8hdaWF/l1J5Sb7YYDulpLZyGq1PemZLN9QTTYYu6ZgMfGTWrrP0s+73k2AgDmtogbh2ppFSJ66Xth55iBHdZ8AIvcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsyNVHwinYW7ZH1uJBz/oVxSqIZEKk1oXbcunh+Mm3k=;
 b=JCBO52g1ipKRiSKC+U84lQZTk2p+E+Ur8SJ60gCp5PqG+R6MeT1MiuVMd8+Yvgp3TOIrLFjmcRF4Otqopu86TblVftqz0+NSxHBXH6g8YGIrM70f/CXo88hfXcv/zn0ckFZK8SRkUTni0Dwy5Zq8ySUpYry1ikYGCXHZ9VTS9ln6pqNgITHDThk0Q/yOiQyre8l/qScl+oSTLSf4Em6KmeCbTl5EYR9Ru/+HnGKdeTdhLP6OCNSC7DZwkGAyvSpwmosoV9pSTIEeSW7pDiLqWgxxq4936+VfGmizxhNOdZ2mQBUQiGXOfnYWsyXBsZSX7ByPWxqealwqfykR6qmH3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsyNVHwinYW7ZH1uJBz/oVxSqIZEKk1oXbcunh+Mm3k=;
 b=LpIeTgL1hAdbHThXtn7nx326Pdev8V+KH4Bj603wDVA/OlZRueAUCRhrwmOOVmXwn/28JeJrET+wtfakLS+MZ7eNOZM+2WY7Pzw707zws6c/vpXkwYlzZrpqthcWSEfM1hnP9UidqkCtYPn6EoXCWwV9mhf5Thm2/tTdvmggBmY=
Received: from MN2PR20CA0053.namprd20.prod.outlook.com (2603:10b6:208:235::22)
 by CH2PR12MB4922.namprd12.prod.outlook.com (2603:10b6:610:65::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 10:45:18 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::4a) by MN2PR20CA0053.outlook.office365.com
 (2603:10b6:208:235::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 10:45:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 10:45:17 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 05:45:14 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 02/12] iommu/amd: Do not override PASID entry in GCR3 table
Date: Mon, 16 Oct 2023 10:43:41 +0000
Message-ID: <20231016104351.5749-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016104351.5749-1-vasant.hegde@amd.com>
References: <20231016104351.5749-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|CH2PR12MB4922:EE_
X-MS-Office365-Filtering-Correlation-Id: b73e77cf-4c82-4651-da9c-08dbce34fca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oO35Ypj9Qw8MA7BySVj3Nsinf367i2xLrzfgHsT8UyhqGIQ6VRuAvDnO/9amaz5vQ6MK+SAOvfrZrvacQVxCzWbkVacN2gTsBLOtCEpRqQuJ2mQk7Z1plMuJhx+wp+emTgxw7qVvX3jzZUAIdnZXwXzLJKCdWxRojLk9smdt+zL3t8p7M3PG7n41dfR4r6/If0Ah6nRFc5z8Pq2yLkfKvh0BVteD6NqlSJJ5TKHgnkslIMT5Hw7yb4PMWklLVYgK/Cpc3y0+Aw3TWB5m2WA29nvLFcHDHzGaG1UpmSaQtdD8UcJYAncdtuQ8zBPAge9wfwSk+I3D2UkfpqYkoBPjuDDaaBhvjkmx9+tRmAycxMhTxwiAXWITH2tq3OJmmLbIJzoMagsVmiY9Er/gaZ++Hhhq9HjQUVdsIDWIxxs6lBoBQclqdLfqCXsE+Zcp74UZxJA8skWC4lkdt02KXEU/+66lgiKwqBLDgTUtrQit8zOjh1GS0JW8fa0bT0s0C9mz+Wmz0QH+E2ctoR1T9Zm413jaR03HUo2tgkbiUvw9AOTg19Z7nwuyrevFiLEhAGkjNBcbk8hx1hKpPKEd/Rr2p/UD+GrX0hWgzYwHsVo13GmhKs5I6tJtH1dzedPf/M+HOrMbm5u9y91xYsw/38Z2SazQB5HYOBpcmAN9zdmv39FtSijMjU2UVeuo9UY71KjyjwC155JqZKZzPsKO55GXFch1wXWaFU66O5FiKp/Bimoq0mza50aiHvUXJcd3QoYRSx2JG8g3xkVaPrY8YLWo3w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(1800799009)(64100799003)(82310400011)(451199024)(186009)(36840700001)(46966006)(40470700004)(478600001)(110136005)(70206006)(70586007)(54906003)(6666004)(26005)(1076003)(16526019)(41300700001)(426003)(7696005)(316002)(2616005)(336012)(8676002)(8936002)(4326008)(4744005)(2906002)(5660300002)(36756003)(44832011)(81166007)(86362001)(47076005)(356005)(36860700001)(82740400003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 10:45:17.4403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b73e77cf-4c82-4651-da9c-08dbce34fca4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4922

Return error if PASID is already exists.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d6e9f1ebd1ea..8e5d1dcc50dc 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1945,6 +1945,9 @@ static int __clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
 	if (pte == NULL)
 		return -EINVAL;
 
+	if (*pte & GCR3_VALID)
+		return -EBUSY;
+
 	*pte = 0;
 	amd_iommu_dev_flush_pasid_all(dev_data, pasid);
 
-- 
2.31.1

