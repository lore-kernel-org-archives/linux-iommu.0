Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3341FC8
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 06:43:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pcc2uiMMF+2Vsh1mehhmuhlt/75vHf8a0ECPN3LRRr7xJV80683BWnH+YpNqsdwnHQfGa6vjEAkem/dt9CcM3eaqlVRDWMtj6gTxvOBavS4G+P240K8dEar/FIzfDueZ/VpNp0hu6k3xrnsR343/8cWtNUZFau0NMiudckBU8ERPr8rkwlPXpEPduuuh3v3ShE4YaHPGUVK+VgyiUzbKOcjNIM+d1oJKJctYyfdB9UpPmk9fnopG3AduGZnWCOWtlRjnTNj2d6Ha76xp4WMzyq+tNnZWAN41Bv1qGbugAhZUmjJr8IrzyIDPb/Y+qApCy2Mcqfsn7aDc9IKb6mpoDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGGdRJBU+ccU1ZFT2SxmaI5jYPKK7IQrmc1AGzaFvvs=;
 b=PZtC37SfH4z+pDzQg1DjhxWqCrhzfeN5Hmoj7ttWpdn9czgRRs3qrR2lSSmRg2mS37L2rdCi+68R+OeY+Am0ch33jH/faVN2z4DBwEcO40HwT+FT/TrVoQaiZVhOTwox95hXjTcpg0yvQa/jWDuHR1zxTsl2KL8L5sPPgwka/MDoUvUXo/verO5QdxDBy/6AjRe1emhpmR3g/QUGDFKh/yU3q+cv1wBh3vfNlbtINbXJxOAlM6XUspH9cr1C0BCjRzFvVWdvpzC889kblNO+63CYLRMN+0PUfogGF2QjoL8MM+Ze/5mHMc6K/zZoeKzrEAwCT/Epxn7D0ArVbcp4ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGGdRJBU+ccU1ZFT2SxmaI5jYPKK7IQrmc1AGzaFvvs=;
 b=wfS+Wa3IGjkYaBrIEq8VnQQr0NoenfILf8Z7IiiEEF2oayKMHUQ0WA/sLGObl1UH6krhVauTIe8vaDlpAZpF+hHmHPJjMKc2xehjM0+gqknrGE6nHwoHsxsO4Bn0eB05Yx3JufEqzzJ50/QYt3Oq0W5RtIGTI6SLBik37KMf4xw=
Received: from CY5P221CA0046.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::29) by
 BL3PR12MB6428.namprd12.prod.outlook.com (2603:10b6:208:3b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 06:43:00 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::d8) by CY5P221CA0046.outlook.office365.com
 (2603:10b6:930:4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Fri, 4 Aug 2023 06:43:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 06:43:00 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 01:42:57 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 01/16] iommu/amd: Remove unused amd_io_pgtable.pt_root variable
Date: Fri, 4 Aug 2023 06:42:01 +0000
Message-ID: <20230804064216.835544-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804064216.835544-1-vasant.hegde@amd.com>
References: <20230804064216.835544-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|BL3PR12MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: b21e0b98-d6f0-48be-34f9-08db94b60bb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j0oWr4uwqjah9jKoMl4Fnka93kmLSWjM4G1pubUv3NvlSPUfu/eTPxAWp9QBnlPRqG0tJNQ/dDMmWFVL7W5/FSaD6U2zhCHMmso3Q9HJ9pQaOas7a/CS2/8v8ppk/rlRt8XNz3HdO5b+Yy5t+oV55n6lInuv4wn9WiR9o7z0Tce4vrzb7uXiWL6gcKuxlhUU10XuXtpGPoQ7kt1ABcj5V7NCEGz9Pi0VsLmzhSqSz7Fp61Lxzz8L4OZ6vLJiBq51Zu3rmlVLYffw4d4Ay2QbkQglySiSnc1WTVkn9ZZY1g9YLEkWGsLR4cmmpARseRqAcUotnKwbTgcX2r8YxalELc0zkC/lWqPP7HfK9CJcGHuN9wpCMwJkdEuBNH9AsjafjmnjA9GetfWIaG0WhiE/J+cpI7b7257ympdvV+tB2exh5hGRSpGjYC5a40cL7fhnaVcsyjajl2pRbaiyXBh5q9VQakF97W4W884jh059z/x/lL/8yGwxGwZFD9gUUgffHyw9thCcknT/3s5nPTaL/HjdNCY4oL59DTwo+rJc/5kXavi0VT3qFrHiFQclId4yhb/5kWjT/g3dpNHfOAjO98G4kATdy+DfJZx7Pxce71H6KNVkRink0wP7C0FPuyq8EdP84W5oHJtXZRNUdwecffEE39yC/f8CnuW5TfegHlcseumHL0VVFPAT2y91wASMw7DsNxfr0NikOzxXHrn1dNdTWpeTVjnDCmMlvEJNPW8dUAXMo07zJWktrP14hEKF2RUL86UqYSE1etXSehe0oQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(186006)(82310400008)(451199021)(1800799003)(46966006)(40470700004)(36840700001)(44832011)(4326008)(40460700003)(70586007)(70206006)(2906002)(82740400003)(356005)(426003)(81166007)(2616005)(1076003)(16526019)(336012)(47076005)(83380400001)(36860700001)(54906003)(110136005)(40480700001)(86362001)(26005)(478600001)(36756003)(7696005)(6666004)(8936002)(8676002)(5660300002)(41300700001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 06:43:00.3543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b21e0b98-d6f0-48be-34f9-08db94b60bb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

It has been no longer used since the commit 6eedb59c18a3 ("iommu/amd:
Remove amd_iommu_domain_get_pgtable").

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu.h       | 1 -
 drivers/iommu/amd/amd_iommu_types.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index f23ad6043f04..6bf55de9fbeb 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -108,7 +108,6 @@ static inline void *iommu_phys_to_virt(unsigned long paddr)
 static inline
 void amd_iommu_domain_set_pt_root(struct protection_domain *domain, u64 root)
 {
-	atomic64_set(&domain->iop.pt_root, root);
 	domain->iop.root = (u64 *)(root & PAGE_MASK);
 	domain->iop.mode = root & 7; /* lowest 3 bits encode pgtable mode */
 }
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 781ab9c2ea70..1930e918188f 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -544,7 +544,6 @@ struct amd_io_pgtable {
 	struct io_pgtable	iop;
 	int			mode;
 	u64			*root;
-	atomic64_t		pt_root;	/* pgtable root and pgtable mode */
 	u64			*pgd;		/* v2 pgtable pgd pointer */
 };
 
-- 
2.31.1

