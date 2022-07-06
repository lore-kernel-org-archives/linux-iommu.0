Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D2C2F3A
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:45:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHwmm7ufS5bWsSNJjv25IHKZ6DsIIXFHUcpWVlRUn/Ith/gT8JsTMRuDh3gnYXXLNYbomY7lZwjDa3yiHU5568225tS3sJowEqLhhkcrxXeQ8vfatRm1xNibLuWujAe1NOTQKMpqFMrXSh08iRMZJfxx9eizy0K7fvuTA0FYCBwXtoQa/IWpVKSaztAuvhuq3Ofok6YtynSNz7iCx2IPA44EEKzMD7CwxWSfZLnHYEPYaJZ1Ebh5P2n8/voP/PS9D2tdUkaP5WV69cVjHvgLT/qb6+ljvx5Mi7FhAiosGXt3v+xdX8fT/MHnKdfzT/Pt/CArgWA//XA7IBxLjio0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HF71CcV6VEQRTk4bBQRFLJ/eDKiV8Xa27OI3QKnJBj4=;
 b=acKUuKOkg8UpSw6Na1iS0gPu138XJTG+6MXej6NN2/Kgf9s1sKgmmsdBN3weKjTfaZbbhTwerCePgo1W7zGP//X8mhPeW9WWHZfEZbz707eYOXDc3ShKOLQ7JU6rTcXITXAc4JkSXRC96CX7+yZA8PyyTZuRasss6o8UcNkE5KlWKARf/fgFcmD+Sut0KjmibjkSvcmeEzoIKBHAWEt/YY8FzlPeXkyfJ6E2EmR1vE5S4FgMDjll1MPeHVRHZkRzolOkVxZ1m7+RpYK62UA09j0qhVOAD1vKPetXs6hrF46VFRc9mzrGmAes9JxamgA3qIvYnx2ZOLMFsSnd+PQKBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HF71CcV6VEQRTk4bBQRFLJ/eDKiV8Xa27OI3QKnJBj4=;
 b=24odeKAWR8Rhw6NRkVX5dIfqIhv334RpV9SSO6IoqhWuWvl5yTi4JrToG7z6+ivLL0Zopm314qPMTSNsp2Mt+LAy2+TdhJF3/mf5HIYk1Skz8uC7qQwkYJNvQb75WD61aj+AlV2XOa2u+G6M1ijhD5kWOtNdv9zb+sP7PE+4/zc=
Received: from MWHPR11CA0030.namprd11.prod.outlook.com (2603:10b6:300:115::16)
 by BN6PR1201MB0018.namprd12.prod.outlook.com (2603:10b6:405:54::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 6 Jul
 2022 11:45:30 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::7f) by MWHPR11CA0030.outlook.office365.com
 (2603:10b6:300:115::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19 via Frontend
 Transport; Wed, 6 Jul 2022 11:45:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:45:29 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:45:26 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 12/35] iommu/amd: Introduce per PCI segment alias table size
Date: Wed, 6 Jul 2022 17:08:02 +0530
Message-ID: <20220706113825.25582-13-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220706113825.25582-1-vasant.hegde@amd.com>
References: <20220706113825.25582-1-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 01e7fbeb-fc2d-419b-402c-08da5f4506e4
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0018:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K5hxalQ/lNz0XPzgbhnmIUq9PZ8Ro4E80Z4Q0Q+534au8B5DU8J7d3QndYsm5LrzdOy8/z7BjsYSt21oeXaOF0tu8lVtfMkbVO8iS42aj0ZrMAYjuxoLrVT/sJHPe0Ygwi5/NSOGY7YCDA+8sDlSEPfE9Mru9QJwXhB+CbRzQXNBs2d3eve0ioUnGErt8b/nLJYtHa9MPTDUITewnaKCvi4jCkQVB7v7fhKTQ0VktaqtEwgprPQTVsL3QqlaiAUWZ8p/tFOZJh9Vst0gizcDGxHl3T/g7PyiVDI3sByutDPjGsN4gK9LwoX9oywr4CiYQdih669iAu8zCmDw3LHsi9UOzcuTlR3FLbasucJY222n8V+NAMrHjPG+9QP00aRIRqswe9l9SXwdna+oIJ2lkXMkH8sYoddEBaFlLHQGFsRih+vgtzaFDM4FV//8wzZ4lJAXhV2zIO4G02ZmDwgklCh5CJoUBualgAl1M88vOTJIeKskGHTL+Uw9O+A22wWv0k+pdjkAb+qkfCr8fAoeYyq8FUuE2ihiwHkrswA9wFzF9x7TdPKZ5WD4eygz2UVWBrCpDF8WkDcf0SNgiyHyXxE5CY3SiWK1jBkLzUT5sG3j4UqobPoHqVfy5xeqdmyLLFGEjJg0mXC+DtzlWnt3815L0ac8FmaIBW1bAhyOZRkm/KYkYo2PfWgHXDXARA7TMuSMDcGMhbQgbVpA63MvX9CL6W31oAnsrd4yPUXZ9LrkLTzvKOA1io53t4mfnM1cWBHaZFJHWm/aMHvFgKNTtqozXGLP50LsEFlULUzFVYdd+je4LPSY29FXEFaMSiHt+5lJFE6VM+xkqZpRO0pZwQvnS/te9Duh+X3Dv//e7R0TfoKKcjxDYHk+IjanhX7L
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966006)(36840700001)(40470700004)(36756003)(26005)(40460700003)(7696005)(2616005)(34020700004)(186003)(16526019)(83380400001)(82740400003)(336012)(1076003)(478600001)(40480700001)(2906002)(44832011)(4326008)(8676002)(70206006)(70586007)(54906003)(86362001)(82310400005)(41300700001)(8936002)(81166007)(5660300002)(426003)(36860700001)(6666004)(47076005)(316002)(356005)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:45:29.7475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e7fbeb-fc2d-419b-402c-08da5f4506e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0018
Message-ID: <20220706113802.5J8ea7mSG_9S3VuFS8dwifb8N4x5pBAKanZsc7fWCzI@z>

It will replace global "alias_table_size" variable.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 3 +++
 drivers/iommu/amd/init.c            | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 1dbe9c7f973d..8638b1107dd2 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -558,6 +558,9 @@ struct amd_iommu_pci_seg {
 	/* Size of the device table */
 	u32 dev_table_size;
 
+	/* Size of the alias table */
+	u32 alias_table_size;
+
 	/*
 	 * device table virtual address
 	 *
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 4a1807f7a8b9..22a632397818 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -712,7 +712,7 @@ static int __init alloc_alias_table(struct amd_iommu_pci_seg *pci_seg)
 	int i;
 
 	pci_seg->alias_table = (void *)__get_free_pages(GFP_KERNEL,
-						    get_order(alias_table_size));
+					get_order(pci_seg->alias_table_size));
 	if (!pci_seg->alias_table)
 		return -ENOMEM;
 
@@ -728,7 +728,7 @@ static int __init alloc_alias_table(struct amd_iommu_pci_seg *pci_seg)
 static void __init free_alias_table(struct amd_iommu_pci_seg *pci_seg)
 {
 	free_pages((unsigned long)pci_seg->alias_table,
-		   get_order(alias_table_size));
+		   get_order(pci_seg->alias_table_size));
 	pci_seg->alias_table = NULL;
 }
 
@@ -1583,6 +1583,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 	pci_seg->last_bdf = last_bdf;
 	DUMP_printk("PCI segment : 0x%0x, last bdf : 0x%04x\n", id, last_bdf);
 	pci_seg->dev_table_size     = tbl_size(DEV_TABLE_ENTRY_SIZE);
+	pci_seg->alias_table_size   = tbl_size(ALIAS_TABLE_ENTRY_SIZE);
 
 	pci_seg->id = id;
 	init_llist_head(&pci_seg->dev_data_list);
-- 
2.31.1

