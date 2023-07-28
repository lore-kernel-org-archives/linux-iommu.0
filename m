Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CA85696
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 05:40:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mP4PG3R2Pfw9LhmV2c1uxRTM43lji4wT6H6IpuHMn3QilS0Uw1CBScXqHm0s5HF4D3sijnJRHXOH5ElAcklxC2zOcsw/bMV4XO5SbAs8QW2TwPpoaBrOzAvOcdCJn+gG4DonX9eqSlAZ4RaPkXMhWNgUK/2Y0WI8SoRfCOE/Vavi+2Al4f9dZ6++4TivQS+d6/G3njv6b3EFV52miipvs4w5KNNa1U5Yniu0vh3i0o0+7AuVJaVVpZV/N8d4BI/i0sDmaCZUs5m9Vun7noluQ7YMC7t+2+Sp98gHAjD4JSrpG4JXRD01tt6KM7Pl5TH0YDg60RLzVLoWUqs5/Otx9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9k1hobK5lLDYt4TadS55H98PtXGuREA9YulCsSB5hVY=;
 b=CMLkS54U+rq0rkNq/L5Iz/lTX8S6zeWqwoCcX5hGkm0QZ8gYhIYjuAG65XOwJfxnRQMafpbJz4iuH1nkJ00cEGsNIrCa6qOjLvVytnEq2+2DQNV9iTCSiZxeeKmOEQMTCV00Oas1iC6rCKK/pnPLkvYhcNJ01vfW/r/h3erCjJIz6oafbf4vgNjDhjoTjlGHHYZkwTx+/VzgQh7bEM1OIvdP/pJ0u30lBVAzjc8CxPVoo78uLKttsRP3VmTF9fp0+9RqzOKOU5O8kmv4lPVLekWis8GzSMaifRhSeUTMeGERDwtOwXSC3PXWjKJIXgT+m8d5gKPP6FkaXiyOTwfRew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9k1hobK5lLDYt4TadS55H98PtXGuREA9YulCsSB5hVY=;
 b=GXDc0Vlt8xlTVSaUFkl2WAWsxpirrmK/1Q2fZYcNU+2MoDag/zPS9huCIhhH/SxHR5Mg1QB3L3f2YUgDKe1+4dS5pk2qQ1CKY9DL7W5lJMvg9pRzEAFLrgPtwFjK7VchcCMgYG3xnJ87enXduAuiQMDWmzZ8i/F1seKiZO7BkUg=
Received: from BN9PR03CA0810.namprd03.prod.outlook.com (2603:10b6:408:13f::35)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 05:40:55 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::df) by BN9PR03CA0810.outlook.office365.com
 (2603:10b6:408:13f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 05:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.35 via Frontend Transport; Fri, 28 Jul 2023 05:40:54 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 00:40:52 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 15/16] iommu/amd: Initialize iommu_device->max_pasids
Date: Fri, 28 Jul 2023 05:36:08 +0000
Message-ID: <20230728053609.165183-16-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728053609.165183-1-vasant.hegde@amd.com>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT011:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: b31cfc31-74df-4e7c-3320-08db8f2d3621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aHDBEXsY3jdVjNc9rtTbbVttxlN/qmPRfYg8ElofCiWtIPjGrWqplr7zKqy/Y27tislrt8LS69cjEqJENzjmXEH1HkNmnakp2gqmpcqvNGuybw+yKeYQ+E5QlXehL7ofaUHdQYKE23pCa4+0s6sxHeD7s8mpVWaKM4qRwzQfTePz9j2SeQ8iAcvLQAz8QyEY3lCSaFp/rTzlpHz64oFWP2MZOrPw7FAjvon7Sg6d2nOten0tmr+ctJwb1csOBt9TkqVTv3A9+MCbkscF74+wyysPVpIjQx2aKk4gUm66UVhSAEKWciku3IOb/HeNTXkffHndWVow3D/nn6oNRnNk29ZqWzV20EJe04+YYQ1D7dTWi8VRbYGHlZuX5esXGWhlKo4RPHi0t9BtIsa7GNyHitOsUnAwpX2FtKYxNVoeswsetOFtPq6dazq4nIWwpQl+mueAmAlt0kUZrIScC66/mrZajwyIoNwjdPEaEv9wD6Sov7wNHSo+Fcud6W9jXzOZHVyhFU4augKlBq/KZb+5VBzgg6aeTi/UzyK0GfO1BHbyYR8hYQY/F1UC2zoQ+Yy//lh/+scy2eB97z6KxutVb3zg7VVSXLmAv7zDC/AWkhfFpF+naQSlFmSyrHDir1IbtMhvEAXxPlqrrG2uz1B+L7rIUV5qmlCPFSgZpMHXCBTTMshYzjYJZUDaWvphj3HW2uXzihJhdJYvzgyu2xabm6nJETBJaxbXgRqma4yGM2c1ivy9I+Tk42hUahxvLf/3DwY/s/X3bmNIc19QqtKzaA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(54906003)(6666004)(110136005)(7696005)(478600001)(186003)(2616005)(47076005)(336012)(426003)(70206006)(26005)(16526019)(82740400003)(1076003)(2906002)(70586007)(316002)(44832011)(41300700001)(5660300002)(356005)(8676002)(4326008)(8936002)(81166007)(40460700003)(86362001)(36756003)(40480700001)(83380400001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 05:40:54.7034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b31cfc31-74df-4e7c-3320-08db8f2d3621
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768

Commit 1adf3cc20d69 ("iommu: Add max_pasids field in struct iommu_device")
introduced a variable struct iommu_device.max_pasids to track max
PASIDS supported by each IOMMU.

Let us initialize this field for AMD IOMMU. IOMMU core will use this value
to set max PASIDs per device (see __iommu_probe_device()).

Also remove unused global 'amd_iommu_max_pasid' variable.

Finally current code restricts max PASIDs to 16 bits and calls BUG_ON if
max PASID is more than 16bit. This patch replaces BUG_ON with WARN_ON
as system can continue to work with 16-bit PASID.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 ---
 drivers/iommu/amd/init.c            | 10 +++-------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 445b58c24d20..4c80075c0454 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -895,9 +895,6 @@ extern unsigned amd_iommu_aperture_order;
 /* allocation bitmap for domain ids */
 extern unsigned long *amd_iommu_pd_alloc_bitmap;
 
-/* Smallest max PASID supported by any IOMMU in the system */
-extern u32 amd_iommu_max_pasid;
-
 extern bool amd_iommu_force_isolation;
 
 /* Max levels of glxval supported */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 1f56478ae74e..6441c81467ab 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -185,8 +185,6 @@ static int amd_iommus_present;
 bool amd_iommu_np_cache __read_mostly;
 bool amd_iommu_iotlb_sup __read_mostly = true;
 
-u32 amd_iommu_max_pasid __read_mostly = ~0;
-
 static bool amd_iommu_pc_present __read_mostly;
 bool amdr_ivrs_remap_support __read_mostly;
 
@@ -2086,16 +2084,14 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 
 	if (iommu_feature(iommu, FEATURE_GT)) {
 		int glxval;
-		u32 max_pasid;
 		u64 pasmax;
 
 		pasmax = iommu->features & FEATURE_PASID_MASK;
 		pasmax >>= FEATURE_PASID_SHIFT;
-		max_pasid  = (1 << (pasmax + 1)) - 1;
-
-		amd_iommu_max_pasid = min(amd_iommu_max_pasid, max_pasid);
+		iommu->iommu.max_pasids = (1 << (pasmax + 1)) - 1;
 
-		BUG_ON(amd_iommu_max_pasid & ~PASID_MASK);
+		WARN_ON(iommu->iommu.max_pasids & ~PASID_MASK);
+		iommu->iommu.max_pasids &= PASID_MASK;
 
 		glxval   = iommu->features & FEATURE_GLXVAL_MASK;
 		glxval >>= FEATURE_GLXVAL_SHIFT;
-- 
2.31.1

