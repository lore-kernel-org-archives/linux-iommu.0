Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4A215C2
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 10:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y0I5c7KB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiiNub/duCgoAioZoeggQUCLzLls6P7Oxp14CPI18SM354EYsp5VGKEJQ1gOPZog7B38ErFL6O0JytA/Yw0ekqxg5ekzihjhy/OquGlHJg5eSoI7aXVOWpXwn5rZb/OjmVbcA8Djw8VO+fBjLP8E+onlDi4rc0Fr/83E6G3UIWYp4YsSBwa83H5bUF5ucq9RHLmRyu7D+fbLIKjtqV7hiLo7Adcp++7yJ+iUPF/CIZK+KRRgamJ3CO0Iu08fNd7nOQsRctgvyr0DEJmYpJN9OMK6vmI2FhwcwypwUsz/3aLHTbrEPzQKNsyjK41WSW3YQlB2qFj061fxuJ/Zxkilxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=au0Xcx32mDCPwNVAtFShheuhnecdTyx5BkTm8WHeMcQ=;
 b=iVD7aCyUalok0eu42Edgqt2zrSpqcuoUV1ayuBGBAjo2Oq/K9RugB4zPShXog08sCnFSfOrHCJwJRdkq+QIA+wffjSx6N9vGCbd2SQ7o+E0WJUb6g+Hn6mi+/SVM7/1h3dK7OGNu+JOD6GNfEvUZbR6eW3DA6CEJ6l3k/QTRotf97tN3VMiDw7zgOCWfu6ERqP9Zv7bfPJ3/Lr5/F4oRX8hKLvmyDARLqkN2P8JinMsbyIH1x3L16elJHP1jRrL7uEFKfkLuOr2VL9FbF7xToTZXQRli/bBaiNR7vuReEH0QSPOUq9borkIje17bga8jLk9dKFZwZ9rFhnjSDMIjOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=au0Xcx32mDCPwNVAtFShheuhnecdTyx5BkTm8WHeMcQ=;
 b=y0I5c7KB6DMz5H+jdLDBmVCgWeHW4Be/tMGCHqiVCcaLgY2xya4XJs6s530tinoOgKV+jTlLJ75Nc3mQBvt5jvIl0gL9+N9GYlGxMRk3T9lDv1b28L4uNf2Ql9BTb06lJKPC38bnyHzuZxIbCs3ss8JPA6JDRWPV5cGb1r+xwjk=
Received: from MN2PR10CA0033.namprd10.prod.outlook.com (2603:10b6:208:120::46)
 by SN7PR12MB8132.namprd12.prod.outlook.com (2603:10b6:806:321::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Fri, 6 Oct
 2023 10:17:30 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:120:cafe::13) by MN2PR10CA0033.outlook.office365.com
 (2603:10b6:208:120::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Fri, 6 Oct 2023 10:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 10:17:30 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 05:17:28 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v1 02/13] iommu/amd: Remove redundant domain flush from attach_device()
Date: Fri, 6 Oct 2023 10:16:13 +0000
Message-ID: <20231006101624.5912-3-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|SN7PR12MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e4ace7-a133-4974-dacc-08dbc655730a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sotJIujSWezhQiSQ8euvVNqFrWfodPL7nNB8r61H5kIYEez18vSihE1KWMec53Gif1i91HJJIQGODhMka67panYZBzDp4JSfH6EiXoAClTuSF9ZdFi3lvrEFERG+VQvJw7HZVa+WsRkPA/hHVvXJJZJ1yHgJf1r1przPm7ngOfSG2SktJR3SVxjK4qC2yymQIIwoac1+kjV0pwI2MWYFA8CATPBRAEzaIlos7xWNo6MDaZiQCzQbC1wX6DR0WccFLp7/0aDKfEUVsWjzuwSb91L4iOHGzJeNuZxaeLOljLXwxP4jJ53DXyh/9r66PvlB3uGpnkeDP/A9qopTEI25xP8KL27LsXwzIvKthysbVUcnsMsrwj0RwmbTnoWmheC3K7vPicuz0tDNNkZKplCHTDv+Mbi/om0y9xDX4M0wQTwh7BjOABrpXnVpSItRk+HKogC5CRLpqU6Wmjv3w+MSZbossOpiWTkOWFWuLn7f0LeBI1jjw8PwJrn08zW/ce9KFrF6StUJm1vfGFnsJtktZO29QsQoJrK9qW+c+DV3eEPGVSP5jfZ4ToHJ4Zxa/u/ZCSUscxiC0qZcGkzCl8O8dOnEbwgn7vMjQlH2UbAvtO8UhcrOjETztQ5HVG8UMb7VysGjLyXQvJTlxFre2YZBJt+kFfzQzI6QpkirGiAU/loywYj99Idamk/M+bZgT7mboSEWqxjfyupvTorjlOzEJ2dit0Y6NLk119iCWT9OXAa4NzULm86a3sHSltP/C+nn2NZJsNIpf5u0i4P8N4okiA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(451199024)(186009)(82310400011)(1800799009)(64100799003)(46966006)(40470700004)(36840700001)(336012)(40460700003)(26005)(1076003)(16526019)(83380400001)(82740400003)(86362001)(356005)(36860700001)(36756003)(47076005)(426003)(40480700001)(478600001)(5660300002)(2616005)(81166007)(54906003)(70586007)(70206006)(44832011)(316002)(41300700001)(4326008)(8936002)(110136005)(7696005)(6666004)(8676002)(4744005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 10:17:30.7199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e4ace7-a133-4974-dacc-08dbc655730a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132

Domain flush was introduced in attach_device() path to handle kdump
scenario. Later init code was enhanced to handle kdump scenario where
it also takes care of flushing everything including TLB
(see early_enable_iommus()).

Hence remove redundant flush from attach_device() function.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index fd4154c2e770..bbbb7204b635 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1891,15 +1891,6 @@ static int attach_device(struct device *dev,
 
 	do_attach(dev_data, domain);
 
-	/*
-	 * We might boot into a crash-kernel here. The crashed kernel
-	 * left the caches in the IOMMU dirty. So we have to flush
-	 * here to evict all dirty stuff.
-	 */
-	amd_iommu_domain_flush_tlb_pde(domain);
-
-	amd_iommu_domain_flush_complete(domain);
-
 out:
 	spin_unlock(&dev_data->lock);
 
-- 
2.31.1

