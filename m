Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF471D523
	for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568561; cv=fail; b=cPqeRiSk8UbRoUQwSZeHlhZPueoCBpuMWGBehAshYGGw4J97UpkJjhk5Iw9Buifli6B7HGxYpu8+SCPAL3Px6iUahE2MzGQfynsTrAwr8phO7G3QGf7yNY+Vpw83+FUDMopBgPtmoW/KvCqkaMlY3z8c2GR5xEzT8SaZNQrogxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568561; c=relaxed/simple;
	bh=q4tJGATeKWA/UGVJi/JUEPG+7T14HQIU/38M611nGJY=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=TB2ENFO9OwdkargAnHqlBwEerKHoUNJgIb7aH8VmoYDKR/wen7us5RjHfELjnuV7vnuLNczicYGzirDeM/3gsQkOjFE3JC5G9OwZULeiAOZso+8tQXjaWl96rCLeddWgtq8bFBymBBjENTwqw1AYPrZhjFqClEXMiNUGuCDjEuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3rPf2jJ+; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3rPf2jJ+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DI0A9BKIjGt+qrV2Pt4uPu/KmcfnK2cJJoCpVpXbJvSF0pTJuivQ1DvHq9IOI568i+j6okIATGEB2HtbYqtPQvyK82wcl/VNjt6Cy1pEOMwdRvvb9pvfs8PQRSSJnBvpG+dwRyJIn/M+QF6svLY1BI9PpaDNA6Qyxb2Z/fUKiBvVWswzCBuuoRJJ8UordpU1hbwu3IDAAWLs3OZsTEMI7LjLuMnGcrau/0FWulPvI7oohkEgkatmdq7dLTUrNlAHEzh9u/5lKaBagXVKXcEZd0F+RZzysccY7ZiAu6NKCnYdEBPd71bpWlYtVDoAVE94SkDGVTxUxLJl6mXcdJTZ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXKKyeU0tIAAvmmXHpShxaj2H1dSOO4baqFI/kWg8iw=;
 b=mTb3C4gGZA2PUAAM5GJAAdcDvI5ftzM45dQ3IOlj0ro20RKi6MuhiYtl+/cyBNYEDFUfZGkGbD79WwDB7N/QunZ8kBTsSn6j/SjIDdVFEd83QdDIOg0c/QM4X6nVXiY+NbOPuA8Iivs0AqxEJpjWkU/SBmz0XTKoiSU0YEZhTJmfTZhPTx691HS8cfsZAB47k6r9BB7thVzhXC2Q17Cz0JMdqBOBsH0MhX1zNvLf5zDLVgewgqJEtpZrWFQ5ULIXb8URCrzOOBS6/QmsKj2Vxd/9mNmdlpMa5ozy4GHjU+WSNwWCgep8/gUG6ADSGTvo9Kv21HmzKGz6pG99zDH4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXKKyeU0tIAAvmmXHpShxaj2H1dSOO4baqFI/kWg8iw=;
 b=3rPf2jJ+AF9L26sapQSmxz8ntUP6no1froFG/2Pe6rZHOxWmggpboLnTxQVdJk7NGw9ARne4/qDc2HlK6sLrWU8xhHwGS/SPsdeR8gxKeYBYaQABmGCv8UsvNIr5iEzq/DWD0Bl8rr1cSGL8znUiC+A9vU7Dz4KekpmF9cLhWpI=
Received: from BL0PR02CA0003.namprd02.prod.outlook.com (2603:10b6:207:3c::16)
 by DM4PR12MB5085.namprd12.prod.outlook.com (2603:10b6:5:388::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Thu, 18 Jan
 2024 09:02:34 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::81) by BL0PR02CA0003.outlook.office365.com
 (2603:10b6:207:3c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 09:02:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 09:02:34 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 03:02:32 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 1/6] iommu/amd: Remove unused PPR_* macros
Date: Thu, 18 Jan 2024 09:01:00 +0000
Message-ID: <20240118090105.5864-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118090105.5864-1-vasant.hegde@amd.com>
References: <20240118090105.5864-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|DM4PR12MB5085:EE_
X-MS-Office365-Filtering-Correlation-Id: 29152d7e-94cf-460f-eec6-08dc1804360a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QCYlM1DB1BQtChcwDogx5WwEbia1vTAqIZLs2pjKKpfk7X19B8gBrio9YSgxFs6OT5foOnYXWhD7FVvaF3unz9POQQgQCws5QPgBSnCGd6Nkzn75hSVg339xX5lk+JZkjJgCkQ5DSKuai7AzMneT4sALwPb6IJhFHcWCenLBZ6XIQctXNOv6AB+0E0ycqa7MegfrmH+gaNoc8G6eJRQkSgEEqz4n5IbXaiscxjd6dJEDG5nyAuwUcLYnS5MEIZNeUBDfqo2pi29ppzrkp+zzfHYzDcKiKl2Q0D69MSvU2KU33kOLsPf7dzRq7cYIyR5cg62HyDWEPTUm6DaGF+tbBDIbGc48fEYl1I/IjT+T9MR5bXKBMwuW0YJpoRR3AJM//H9cYSMkxm+Set8U4SVT8JpqkzJR2mbZOit6/hG0kdhM3M4hXbWJqd07hkY2AJbO967wfS+ZnOC7ACUffq5gfQTu97HpSgG8AusBKbSH3ZNcfkGT/W/OCXUraearHsIjFWm3c6OGSyj5M+0v1zlyj422aoZv+N1jAnrbm3cxO+YcBC/Ca55Ug5fYU7aJzYN4LlmORYTI7pAVAXCrnx6OZhPyNHfOmuTSKVLWvkSkDlp0xfNR3sS/yTJUxLlit3kHIqtW44YE9TsgxPUMgUc1JaySS20jv76/G2PsVMw8JltnGJe2Xe1dd6OPykZcpyym6Ndt7x2jxvO/adHDJAq28lk/pWN08UxHUxNHCAfqST++8WpM7yz3CHM6NrOk3f8e8cCqQQQZ2tSri6STCbUDOw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(47076005)(83380400001)(426003)(356005)(336012)(82740400003)(36756003)(86362001)(81166007)(1076003)(6666004)(44832011)(8676002)(4326008)(5660300002)(8936002)(26005)(7696005)(2616005)(16526019)(36860700001)(41300700001)(70586007)(54906003)(110136005)(70206006)(478600001)(4744005)(2906002)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 09:02:34.4921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29152d7e-94cf-460f-eec6-08dc1804360a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5085

Commit 5a0b11a180a ("iommu/amd: Remove iommu_v2 module") missed to
remove PPR_* macros. Remove these macros as its not used anymore.

No functional change intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 3008503513df..db983b8e572b 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -122,10 +122,6 @@ static inline int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 }
 #endif
 
-#define PPR_SUCCESS			0x0
-#define PPR_INVALID			0x1
-#define PPR_FAILURE			0xf
-
 static inline bool is_rd890_iommu(struct pci_dev *pdev)
 {
 	return (pdev->vendor == PCI_VENDOR_ID_ATI) &&
-- 
2.31.1

