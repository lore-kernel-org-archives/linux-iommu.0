Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3380D56B9B
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 08:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xn4HXDJa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBseT5LfznBNB8u4BbGp+NZrnERn968pzX6hoNKCoAlwP3C169qB3WJjOAI+z5T47uy+a/nP1tJa3RwJdOICvvYfsSD+wlFzhc9RC0m/oLMjzGQLJTVDmWa6N6OWEkkN5PqhWKKzXAfYSZrTuY2l96KSaHxpjXy1tcR35wnO1BzRnnptE2QqA99XD7VM2Sn/IHbqw4CVTmPuQLn+8mHTvyAgh55SdtBR1Gqj3LeW5SDj9y+gWZo5bppj4Eknf7MZ3GOtfx4KOKxF7pboTCVCx5iXTewK+JOQhUMoqRhe6HWJmDpkG3kXW2x5jFAtRl/sOAquT8RCEziv/Lj8GwY1Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dqrQxhMb5cRqZPLdTl5dWnQ4enV73h6GbhoX44mKgE=;
 b=XN53cCzkab21vpVeRfZTHXpcw21ksJ26VmaIy+Fbd6X3icYBWEzdKry4lnqa8Ecj/TX2gTRH5qmY3t8WM9kSBkSFUQ+N9Kp6kJgxMArH5sdztpaXvnziOI6nm1Knpf8GNc/Ca9r4JIOroClLVaPwZYdNlCNiKKHHiq6K3Xv2bVczf8Am+cmm/MhoyvYidFI1BNQbVwI8r6/4d3d11SbqQ8nNhA61NescdPPoI8Oks83VtoHs6n8FB5n6HbdykBlJc46a3SY4rkn2uB5uZ9vW0Boujnd4sYgxe8lFqRbK4He2LUAAhhZ4yDIZPU76RWxa8gC03lVqBmV3+8i++Lw6Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dqrQxhMb5cRqZPLdTl5dWnQ4enV73h6GbhoX44mKgE=;
 b=Xn4HXDJauvEYNZymJ6B43WXkXW3rMa0wb4Ehz8h1K24/CakR2jfJ9jJrCtYH63tPxkV6vSptNCRN1AyamN4qgJ6mbpPwp2RK282mywKi5Eze1qYSF7IgAQby0jrXrSx+lJSl2aNOSe0jdo0ksfeUtfR/CqMo2oPh/5BcfVuCNHQ=
Received: from CY5PR22CA0055.namprd22.prod.outlook.com (2603:10b6:930:1d::12)
 by DS0PR12MB8527.namprd12.prod.outlook.com (2603:10b6:8:161::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 08:58:52 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:930:1d:cafe::d7) by CY5PR22CA0055.outlook.office365.com
 (2603:10b6:930:1d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Tue, 12 Dec 2023 08:58:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.19 via Frontend Transport; Tue, 12 Dec 2023 08:58:52 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 02:58:47 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 15/16] iommu/amd: Rearrange device flush code
Date: Tue, 12 Dec 2023 08:52:23 +0000
Message-ID: <20231212085224.6985-16-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212085224.6985-1-vasant.hegde@amd.com>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|DS0PR12MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a3e3fa-35b7-48f6-7c09-08dbfaf09094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	axREjE3ZDFczmK85tvfyAFQYX2GgOaqNVXE6HhMM976C0j+syqSdQzrqavNNGSsgsSf6e021nHh19UYEPyPIKJ8XskQUYSZwuYXAaBqG2DL8Utkj/Ezl0cUgXEDhYiLPqrvJIPv/FgxT28r7bajTG6xQtSvh3cw/LuLTlTKvNm1YA1fkdMMTU9yJCh4VkEk27Rm/arK2qocRqK9HsRAJIkDik35Q1K1SXfIEMRwfQcMU8w6k2QXQbVGOYzM8H1ZQHXi/6Ro9H5ar/+SHOkynF4eo/Gw1OF6AYT06txVH5ZNDvGRav9MtKqcZmvu97A23NuOPGvaSnvTRwanHz7uD/KIjJ9RcU8ncdN8yWh2s340ZMa7NaQ0LgNtzT6nO/gLSU6Bl7NFV1YuFIuyICAGhx8LNweffN8ayRfOrFmapQJSOJ/iqnamlAc7Tk6+yJfURkK5UujPpwCRUQGho4hTU1gwX61QgIYv224So9+SJPpTDutLHesIaB2UsxiOTtC+5fWVKV96HuCV3tUmQ5urQUx6vHhCS/+T6D0B0bhg5pu1vPSyHsbppcZ2ZJ64jdwz6Ttj9wUSvfvXeV4Eeqkju8yKMMBnA5t2wJxkp9TXa8GArqS0f4Qc7tSkd09VI1SqSbXGjtCq9T1GbRDzroXL3MNiLgwp0rWCeuQumz2BS0ir+3Iqu9/46cJ6K5cLEj1m/cZahPT761aJJrNOLAa2L9ZIuS7ua68ZWraItj9FeH7s1kssAeDgVF1CI/zdGAJ1XKCKKGlzbkCJB3Jlglj6s+Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(82310400011)(451199024)(186009)(1800799012)(64100799003)(46966006)(36840700001)(40470700004)(81166007)(5660300002)(40460700003)(2906002)(86362001)(41300700001)(356005)(82740400003)(2616005)(1076003)(478600001)(426003)(336012)(316002)(54906003)(70206006)(70586007)(110136005)(26005)(16526019)(6666004)(7696005)(36756003)(4326008)(8676002)(8936002)(47076005)(83380400001)(40480700001)(44832011)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:58:52.6708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a3e3fa-35b7-48f6-7c09-08dbfaf09094
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8527

Consolidate all flush related code in one place so that its easy
to maintain.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 92 ++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 49 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 13cfea126800..f2a748904eed 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1655,6 +1655,49 @@ static void domain_flush_devices(struct protection_domain *domain)
 		device_flush_dte(dev_data);
 }
 
+static void update_device_table(struct protection_domain *domain)
+{
+	struct iommu_dev_data *dev_data;
+
+	list_for_each_entry(dev_data, &domain->dev_list, list) {
+		struct amd_iommu *iommu = rlookup_amd_iommu(dev_data->dev);
+
+		set_dte_entry(iommu, dev_data);
+		clone_aliases(iommu, dev_data->dev);
+	}
+}
+
+void amd_iommu_update_and_flush_device_table(struct protection_domain *domain)
+{
+	update_device_table(domain);
+	domain_flush_devices(domain);
+}
+
+void amd_iommu_domain_update(struct protection_domain *domain)
+{
+	/* Update device table */
+	amd_iommu_update_and_flush_device_table(domain);
+
+	/* Flush domain TLB(s) and wait for completion */
+	amd_iommu_domain_flush_all(domain);
+}
+
+int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
+			   int status, int tag)
+{
+	struct iommu_dev_data *dev_data;
+	struct amd_iommu *iommu;
+	struct iommu_cmd cmd;
+
+	dev_data = dev_iommu_priv_get(&pdev->dev);
+	iommu    = get_amd_iommu_from_dev(&pdev->dev);
+
+	build_complete_ppr(&cmd, dev_data->devid, pasid, status,
+			   tag, dev_data->pri_tlp);
+
+	return iommu_queue_command(iommu, &cmd);
+}
+
 /****************************************************************************
  *
  * The next functions belong to the domain allocation. A domain is
@@ -2206,39 +2249,6 @@ static struct iommu_group *amd_iommu_device_group(struct device *dev)
 	return acpihid_device_group(dev);
 }
 
-/*****************************************************************************
- *
- * The next functions belong to the dma_ops mapping/unmapping code.
- *
- *****************************************************************************/
-
-static void update_device_table(struct protection_domain *domain)
-{
-	struct iommu_dev_data *dev_data;
-
-	list_for_each_entry(dev_data, &domain->dev_list, list) {
-		struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
-
-		set_dte_entry(iommu, dev_data);
-		clone_aliases(iommu, dev_data->dev);
-	}
-}
-
-void amd_iommu_update_and_flush_device_table(struct protection_domain *domain)
-{
-	update_device_table(domain);
-	domain_flush_devices(domain);
-}
-
-void amd_iommu_domain_update(struct protection_domain *domain)
-{
-	/* Update device table */
-	amd_iommu_update_and_flush_device_table(domain);
-
-	/* Flush domain TLB(s) and wait for completion */
-	amd_iommu_domain_flush_all(domain);
-}
-
 /*****************************************************************************
  *
  * The following functions belong to the exported interface of AMD IOMMU
@@ -2837,22 +2847,6 @@ const struct iommu_ops amd_iommu_ops = {
 	}
 };
 
-int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
-			   int status, int tag)
-{
-	struct iommu_dev_data *dev_data;
-	struct amd_iommu *iommu;
-	struct iommu_cmd cmd;
-
-	dev_data = dev_iommu_priv_get(&pdev->dev);
-	iommu    = get_amd_iommu_from_dev(&pdev->dev);
-
-	build_complete_ppr(&cmd, dev_data->devid, pasid, status,
-			   tag, dev_data->pri_tlp);
-
-	return iommu_queue_command(iommu, &cmd);
-}
-
 #ifdef CONFIG_IRQ_REMAP
 
 /*****************************************************************************
-- 
2.31.1

