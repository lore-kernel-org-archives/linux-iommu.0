Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5669928DA7
	for <iommu@lists.linux.dev>; Fri,  9 Feb 2024 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478219; cv=fail; b=YTpctkeo2S94ow+bTb3xsF61M8lZHVYxo81L4xDW0cQxoIM5CBTVaQewsoEaMAwzrUY/uKluj429BRxuL0McTNOx0mXbpobCz0jCqtaSASRmT22Cn2vM4BLkBU/u8l+Pj3ChpxfrqUuXOPMdi5OnaR2ZSQJZBR/gFIqQp2ZsZx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478219; c=relaxed/simple;
	bh=8kneTi3aY2lFbMBdhnZ1aMgI4Sy8zZgFgMwJRHQc+VA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1cn6eKlCFVOb/b2AneLLP76TYC70D8LRsqukf1MPPL2sREKI4IiZAw1LF+/Q1E9lh7vlyDQhM2BKu7lgR10Ydp0mqM2S0IbZxa0oqhSMYSXpoWuNDPs6amzjxofewqnyFAn1Wvb9PIo565SS+o40o0BAgxbgYW3V4pNEldcqG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N5tF9HrU; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N5tF9HrU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+AAYXQ+NpbHv3R2iej81OklGhaKW8A+Fjm44OBNwZKQMIvqu5So6vVXUvHw2UukQaQxKqs/gf25p/Cseftz8XmOfrwn9XAEwD3dPCFD2z8cN2iW3/OmGiYEgiUDYQEjjhFBN0QZGnDFcJM8xHj39007t2l8IWVtbckX4YII6wWcmhc4gI4g4ophVPG9EEW5ouO+8ndJgUo86Z8eQXXXKVgFHth1sLNFyQrQuU1NEfXFvCtOdYsM0bx+uixzizDS69fwLOP8gi2bVa4PeyfrmuUZJJv9Eg8QtUgCDsgOwnIxgRpCyCuoC2E85IB6vMsu8opKRuYdFSjVRfrTQMRUFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRVcOQOUfSO6JXhvDDfP8gDNBCokOQ4rQWvbcppgRF0=;
 b=mSAnsqty6FF+LcPRDkWKktmlwMwMYkTyKgmJoM3Vl8gyLKJF4V79AUtK/Df74m0xAnDKbpUcKBENH9KQ0zlJKoaW+SEx60Ciao+7PcdSi00pEYjcUhgvDKaistU4cefy3bdb9GSDzfPmDzdd6QgnnDRkMA7TLPh58CoNZSGBpa+VDDg4/RF720Ms+CUDSsd4EbBAbMxGOxTyFMdcamP2ZRMxBtRAznIZrD/HcE0xFgfEzzu2dJ2UPZN8ouSTkOAsOfEKzlhBlNaNpVou8iveEGv4wr/OWtXWaU8RIMqWaoBwckWR4WLvXQ4VFnjG31gKtFISQmkrZqe1S+xNcA1HgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRVcOQOUfSO6JXhvDDfP8gDNBCokOQ4rQWvbcppgRF0=;
 b=N5tF9HrU4wZCCVMLecbuMI1HSVCLcZq55G8z6qWdZSQogVEDMEKmVbpFtF6s8zTO02UkJY3buZNptPRIErXsKNu0a9SIxOHtAPYx14tcVVThJHazSG0sFovszt6JXk7EGSXPdw5py5OGxw+cOr9jeH3DhahZpr8+czNlujImIY8=
Received: from DM6PR03CA0008.namprd03.prod.outlook.com (2603:10b6:5:40::21) by
 IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11; Fri, 9 Feb
 2024 11:30:15 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:5:40:cafe::d5) by DM6PR03CA0008.outlook.office365.com
 (2603:10b6:5:40::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37 via Frontend
 Transport; Fri, 9 Feb 2024 11:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 11:30:14 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 05:30:08 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 01/15] iommu/amd: Rename amd_iommu_v2_supported() as amd_iommu_pasid_supported()
Date: Fri, 9 Feb 2024 11:29:16 +0000
Message-ID: <20240209112930.63663-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209112930.63663-1-vasant.hegde@amd.com>
References: <20240209112930.63663-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|IA1PR12MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e3b491b-d528-4189-1eb0-08dc29627c3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KLBQra7dskR6QM+ASzx9fuAjIF0vH0GPgkcg+tyX26/oL3B17sIIbookyNZSbGQvvZnViDtiqDHA+drb5DkXT5fXkrxcjBhMcahJEH+0TGpvY8Gicj2TfGz0jD6Rx/v+BL0d1v8D9fdSTfNu5t/6Yzuu5FaWfhpY/iwt6mtlAUbnzSVIhJKZjh20f4DVJNHPxOeU7S9meaP/WULatQlIt1Yg1FiJ/DCPnMnzJKpcm4opZpbYYHRv5jJazKSPt5k8T0FMVFSmexz9vXJ+BAPXVK8/RGHg4d3vIrKpEoo/i4yaBfOUqOwnjMZPQMFZ4g8eIvFPW490gpktfFBhmEQEjmdAgkgRLxVfPFYiNp59LY74QBpCoPVNpegSELs09tVZwygI7xo3JDFpOAo/JSggdcv77nMHCOauAHvoo5hPTVl90hU9Xl7LsnlNznAzwvqpDNSLRJYbuBV4G3IEeSlfYH+Qw8xJPp/l/h+muCEGSP2qWxOQfqpR+L6RZcqQLOaXX/9yJcGkRlMU4JLUoNMAYyvd1X5P42TMiP/eA54L4rOz8XaK13CTECpbkdjAP1CX1pJ9xWBfWnHHx6SxMnZDlVRljN4+BSNQd9gaZApxNWE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(46966006)(40470700004)(36840700001)(82740400003)(5660300002)(44832011)(2906002)(86362001)(81166007)(356005)(6666004)(7696005)(83380400001)(336012)(426003)(1076003)(26005)(16526019)(70206006)(110136005)(36756003)(2616005)(54906003)(70586007)(8936002)(8676002)(4326008)(316002)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 11:30:14.6719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3b491b-d528-4189-1eb0-08dc29627c3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7736

To reflect its usage. No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu.h | 2 +-
 drivers/iommu/amd/init.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index b61293f2aef6..334394d14753 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -38,7 +38,7 @@ extern int amd_iommu_guest_ir;
 extern enum io_pgtable_fmt amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
 
-bool amd_iommu_v2_supported(void);
+bool amd_iommu_pasid_supported(void);
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
 bool amd_iommu_pc_supported(void);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 959820ccfbcc..62f695c519b5 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3652,7 +3652,7 @@ __setup("ivrs_ioapic",		parse_ivrs_ioapic);
 __setup("ivrs_hpet",		parse_ivrs_hpet);
 __setup("ivrs_acpihid",		parse_ivrs_acpihid);
 
-bool amd_iommu_v2_supported(void)
+bool amd_iommu_pasid_supported(void)
 {
 	/* CPU page table size should match IOMMU guest page table size */
 	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
-- 
2.31.1

