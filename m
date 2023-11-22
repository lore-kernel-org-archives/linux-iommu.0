Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492A41EA73
	for <iommu@lists.linux.dev>; Wed, 22 Nov 2023 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J599WBz9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJbx9Xwg5pAr1rxyyCrEy4qzyLB2OD4Rn4lfHDkjBJds//Q2KIBgHeooLphf8pgxaL5IjBP7AySzxI4unDU+02vGwUQR4gzDgA7S3IZmN9A5yc5+U6epSldGAbf5tSEVhzgrkqCgMkVXCv7MwBTb8rV8UwezBJhYPxf2M61g+5OaEEPWfo8U9dmSRkKa+/Pe7BYn7dAa1mKEfIz6QN5zuzBeB7A/+oXFzX4vsEnLtk7RkQ/Do68dJd94eRsl3T2ShEi4XJvvYZgt++2qs0pId1pc798wIikx/TYuoWKqSXBP8FqY+p/2CDpuhiuVxHYt5ug53jsM6snuOIdGIDfrvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8bTCxZ0ehkqH71t8sTzS+thg1CtABtvSkF1H5rHGbM=;
 b=ALYjmLpNhs7nlHdkQsODmrRQKjbor7zT8WQX+yusD/1wG/INp7Jnw5xGA76wIY/te/WAIdDO9A+sZ1SUEI+k6jg5CHylEI9pNN8fl45CCIHgyRiNTuWz3Iu4TEnxqGqQcRxusDXghSkglFcDe8zOo4iilyxkuFBIRKJDLDD2QCGaNHg700jaoRl427Q9sZenNzhmblJAAZgRmxCVbWxvspeIbRG9WXTBrVNZ8zbYoeW5/WLYMGgwVU9h1louhdHyaXEOTwzNPdV0+a9jbtAGh65Pjnb183DrWaPlhOmpzL+9U53qHUWChKNRnUyclHOXqhClLpNhIR+9LSw5jGelxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8bTCxZ0ehkqH71t8sTzS+thg1CtABtvSkF1H5rHGbM=;
 b=J599WBz9+GfLkzvaTVOU9XsOISCvFWnkRSIQAQgD5wJdKysx3SglOH3+nOeDVjUe+xfcICID64KvqehhC2oAjEgLiXKgwtgOCX1TaH2h2RJhQau7PrBsR8b9WWpHrtKU5YlNAr2AEtsoIrG7XJSL8LGHCCVDCY92vSsBMdb0S90=
Received: from PH8PR02CA0012.namprd02.prod.outlook.com (2603:10b6:510:2d0::24)
 by CY8PR12MB7561.namprd12.prod.outlook.com (2603:10b6:930:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 09:03:16 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::16) by PH8PR02CA0012.outlook.office365.com
 (2603:10b6:510:2d0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Wed, 22 Nov 2023 09:03:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 09:03:16 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 03:03:13 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 2/9] iommu/amd: Remove redundant domain flush from attach_device()
Date: Wed, 22 Nov 2023 09:02:08 +0000
Message-ID: <20231122090215.6191-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122090215.6191-1-vasant.hegde@amd.com>
References: <20231122090215.6191-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|CY8PR12MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e4b0a2-6b30-486e-ec10-08dbeb39dd78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9wDuNpOLa6cGd9AlAcPWUs/qtSnn1abLPBI66oEb9TGbXYrpRqa9Of7R0OCaBv5YqtN0sow4csk0ZMW69RIldJ4sz53NlnSe7Zbk2dR4HXrKilDlPCc+M23vnr1uRVxLkH5dKuxDDXAZ+AhfGMp5tjHvFZEPhEKkOS1fMBniKQXujqhDqh60UkZ3VuHWJMICFYvcnFMDQt1hFe4PsBghkk3m/R1IxaXV2/58CMZMI0wyVz1dh7VCbLHoLQTKiTyWx8vscrKnGxGmS4Mwiub3XBoJlWd8OsLTLsL9T35zCFxP26sOrBA7mrE19/CjwSk7m+ZIxpdwNorDzYIyeL9bwYDMzA03Arc6DYdsaKw1JQTZLB++GCjOp3/Txi1GnB9jIujxuKdvOUSiZm9LRo3tKvkmQ6rBQ6Df3/0cVzvfgdNOjFAfuDe1O93/4jqK/E5AtTkd8DDpC0CzE9X95AYFjq99QefT4A63CJ/IXTzxdIBVJhohnFo6Pa/namYfikysVHaMqZS5oErG83ZCCstpIFEhqPqBT1465dZ9m618EnxqLhWIMKFUN1Ump32qi0oV81fkAGrAn3PT6bazAxlxkLUEb6U1q+uQsdCE77v0pXOdzL8HSepER6Pegpup5p+eTv0qUUXwfDFMyMQ1pJmY6S81iWsNJ/GdT8mUFPxbZdM1H1Xklz/DIghQTvJhozkGkxujGekQ7zHRvt2EDl0vntwXhZ5jB/kAbJAbfZKRtzkV2wu0lwzuz5uzNQUPE6DSxjZt59k/03fGwyalFWnMzg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(36840700001)(46966006)(40470700004)(2906002)(5660300002)(44832011)(40480700001)(4326008)(8936002)(41300700001)(8676002)(70586007)(316002)(54906003)(110136005)(70206006)(40460700003)(86362001)(1076003)(81166007)(26005)(16526019)(6666004)(478600001)(36756003)(7696005)(2616005)(356005)(336012)(426003)(83380400001)(36860700001)(47076005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 09:03:16.3941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e4b0a2-6b30-486e-ec10-08dbeb39dd78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7561

Domain flush was introduced in attach_device() path to handle kdump
scenario. Later init code was enhanced to handle kdump scenario where
it also takes care of flushing everything including TLB
(see early_enable_iommus()).

Hence remove redundant flush from attach_device() function.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6a43ebddaf87..2d40bf5f406e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1896,15 +1896,6 @@ static int attach_device(struct device *dev,
 
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

