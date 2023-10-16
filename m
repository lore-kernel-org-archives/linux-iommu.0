Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDAF18643
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WbpodRkW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7c+tBomiLEdJn8Uj0BFUkJyxf/d6k2tyKFlazMAMEyDjHtUDjbRnCmDklQTr0yjRdDu96+oOvjYw6LidkAuGH1OHluRZfsydETNXVK7XnCXNE60ayPiZ49Ph0xa518YLFBeKKi+1kikfVdHs8xjm3+sAPsr76wTkmPy3jhP4J+lkNBbjTOco/QRD6D/rLOSlJzrlci7oZHFV8GeTtG449qj6d/HaT+I2kKJug83B5gfHUEcRIuGC6fuFCUg9rmtwH7LmcqDUsLyuyK2eTJLbOPlOZmkA7G1Ywy+1cF6Y19hNBAzFXKylWP4Sv35lnBvI9q3AouR6/Go3ICE611WKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AFSXipWOMAdU5KASVKKybmn4tenZofRCqqzMjPdg1I=;
 b=h7ZZqVlgJdEFTqr/wGzkeknRUFOZa2GKFxYtYtsdMtt5HalwNYVD6vcy4n7hSMhnvU4qRsJqYmlttdg0GRtsVIQYz3kl06mAOVTIUr76527qdbSVeQF5P/WmhAyJYzN/PnQb+sZfg2F4QO/AtM2PaZV+cRcQqki23L8GVq64uxwaGKaGDOEGHmzybASbk3LTkBCQREpegOk09+hfkUA1kHQf1nqv7acegYzzJ6I0foFsIuvwjUO4GKm88RthY20QTKaNOJi2VAmHtJcN06ELtl7y2ydhCYkZv8NVe3VOgpZpu5AE6UacF43UDt6Jy7AwzipmHCqFeEPlW51uEfeNDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AFSXipWOMAdU5KASVKKybmn4tenZofRCqqzMjPdg1I=;
 b=WbpodRkWab7nk+4wZLuHIczY3pKP4bs39OFAqZw9AaQy/F2NcfCvmVXVMOFNl9fJyBh5cvC22rzsXO2i166wsRyspP8K2UbRWJ9zT+/Yon6DJcM0N/wZsEZTEzyWhBITQFkCFtUWxGVekmDqpqC0B88JX9yu99goLy7MCAUHZts=
Received: from MN2PR15CA0061.namprd15.prod.outlook.com (2603:10b6:208:237::30)
 by MW4PR12MB7358.namprd12.prod.outlook.com (2603:10b6:303:22b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 10:45:02 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::e5) by MN2PR15CA0061.outlook.office365.com
 (2603:10b6:208:237::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 10:45:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 10:45:01 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 05:44:58 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 01/12] iommu/amd: Rename amd_iommu_v2_supported() as amd_iommu_pasid_supported()
Date: Mon, 16 Oct 2023 10:43:40 +0000
Message-ID: <20231016104351.5749-2-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|MW4PR12MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a45a69-2b26-4e42-b9f5-08dbce34f332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y2IWVgF3fBljKaGVuvACuFUfry9j4TGtQqBMyvLw+pcNk4SktypZUn3OrNwoQQ10xCMY6GpksOdMLSR9AC0Abnz9Mtv+atINhHpp9OvgVcX5kBABd0PkvxfxG+VRdJlX6r1pKakpyTc1jfzHxtufTriRd31ia8vii1L92RxIXjdUnegvq8+mIQxeCOkQWLsxf6tcusyuBJWhQ9AUKovtmVkCnmg7r+nDpE30QxAk36pKGDWUjimpEiugXuWNANDKo1d/tQnW+xQIwwFqvlwtPZWEsHtzg57nuvH3cMGkVsDxxrTQFxhIprQq9bwx9k833DV91xDlupGpj22rdIP5gfosd4yPbKQpXYXh99frWxBpSqzp+t7d7MMifXFgotuno9WVD6vRa3lrYmOg9kkkU5A5W8NryM1+oeILesPI//3rH1dZct4lI/hV62PjVecaDQrJ4OKLlHfaiKd2AXqOSsbHwc6SYjKTTqnw5UtJJhkFMShnicKuqjS7rPXEkxq4ZRq4A3jkvGIkhN9MzAUZg76rMSDDHYVzw34HUQiPyV61j2SZif38naNz4NWpkGtde5S2fXD2eaXkH6g49C/ClaYIdBwfRuoHDTKjMtYpRmYEL3Kx7VXHWTDZ0wz83mFz+HwEQCH18aWyLgZo9VADrcHIfiB9I/CddRBoFJXUWCdzKNjTck9+rD3dKfcWnMjUteGn5a8CC7q/xLeJ9adc5mBWczzQoJb+ywSbitn+5hjUX28jtTjIYBGnA6nP9vS3ek5Rvsj2AAd4yvBYHE/Cug==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(478600001)(70586007)(70206006)(110136005)(54906003)(6666004)(47076005)(83380400001)(36860700001)(86362001)(356005)(82740400003)(7696005)(316002)(336012)(16526019)(26005)(1076003)(2616005)(426003)(41300700001)(44832011)(36756003)(81166007)(4326008)(8936002)(5660300002)(8676002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 10:45:01.6397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a45a69-2b26-4e42-b9f5-08dbce34f332
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7358

To reflect its usage. No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 2 +-
 drivers/iommu/amd/init.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 1fceaf4a8229..0df0cb03329c 100644
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
index c83bd0c2a1c9..c8b2c8038829 100644
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

