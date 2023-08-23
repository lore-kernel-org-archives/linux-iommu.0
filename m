Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6EAC131
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 14:06:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcTbi+PLYIwNSWn8OXRhCQJXaGool5Gmx78Y25FFs8h49LEAOnZIB2xPzqWow59MKOdm9c2TucAaouZMwGN7PKuf+6DHfPdJg6uUvYoES3V/OEu9zvex0SlV3Q/sMzbAM2AxHn4TGVNX5mq9vcjdGWa3/LK0qHk21zRFHMM/g7B2e2BvFvUS/Kh9LHdR40pvb5ViUKCsVhM90d3dE4tzJp8CpAAiLTYEWWZLNF1ggsAszQHG7Mo5CsS0RTd/vLWcDNoTIzW7c0XKqc4N5Vkf7a1IhFwZyh6q7GNuISa/01XLptOypAKF2b95Tl6Sqiq9T9v69ND2SjXoXhE+PWCukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohcy02d6leulUlaGhMTgKADr5lrjOkuMYJDJXu7VmJ0=;
 b=O46ZRaH1WGSiidMLn0dWytsH/nqxFdpYcA9iJNW/BZFUe7rDycEJnH07phaUMD39PcSXN3/jbLR6ncw4ikwJ/W6byYv/O9ojBdM+G8zaqJoiznzpwDOrXC9rY421ukYikg58COP58ZOYvbgYxyyk3xbvLdBx4MBox1b4+LyaAwDTPZ+T1z+Usf59WFqbRyAz74ylfFgb0cb2OHVA2kEwnbEVJ71RYcU0/0aqHUdcUPyeddGwP96iC9Tx1ryrTRY3wkuwBPb9RXtESBarsTifArwh39nJEolweIoxeOmtvTZCZNC3dAfa/kGP0+M2RuAWlhnj5ARPxC9oL+DPGAm7yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohcy02d6leulUlaGhMTgKADr5lrjOkuMYJDJXu7VmJ0=;
 b=5Gnc11c7YvH40IBVhwdf59/fnmg8eW2OANHYrpQdSbSwlQ/TBy11K/WyDExew9Zv8dQ966qXiB6HCsNH1SrAW6Fjcto2zHCdVSeuezWTqxz/hDi/0rXZPxu5rBfauxroXPIA3dr9z2+GVCLSnOK89UfWrVk15vIVbzB4hZNQeoo=
Received: from SJ0PR05CA0048.namprd05.prod.outlook.com (2603:10b6:a03:33f::23)
 by CYYPR12MB8963.namprd12.prod.outlook.com (2603:10b6:930:c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 14:06:44 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::db) by SJ0PR05CA0048.outlook.office365.com
 (2603:10b6:a03:33f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.15 via Frontend
 Transport; Wed, 23 Aug 2023 14:06:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 14:06:43 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 09:06:39 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH RESEND 07/10] iommu/amd: Add support for page response
Date: Wed, 23 Aug 2023 14:04:12 +0000
Message-ID: <20230823140415.729050-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823140415.729050-1-vasant.hegde@amd.com>
References: <20230823140415.729050-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|CYYPR12MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: 2825ec32-137b-4ad5-db90-08dba3e22e34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9jM12xZmJuDTYGItDB3WV4cSoxxGFvi14ATo2tyfeMaSJi1SLD3PgkbGKkxL7GAwlaUn2gyFfFiQdmH5JJNvpYLEeA/nWpIc93t5aBwKxn96bSMkSTblmlIcIu63/oSl3q4a+krnFUwhZnYVMjgLgkqRirobm7aLrqoSrNYOsw109W0PhwtvpGWYdoFZIotWgy5PHxOyzIhathKQqeEag2VefchJDTAnZWi5ttxwbDsmP/BpWXe2N5T5Ell8Cuz+Hge0UjGh1em/lZntKySl0P0kNH+3iduhlMVUteAYO6y/tRxcX0r4r2dpsgRHElNVHRNvoju0fM6BcB2Q1FItROQA4tSw2XmfZa5nrTd3MatoeE2e0oCwcwpBAvmLxhW8exO/w572vKmh2siffE9fF79FaEIn37wKOfAtUsMppCiPJz5wUrT9vUnpiC0Lr7pN+1uaJT6Hn4jDZdiFOCPWIYgBpF64unm8bUrjqJD6xN4IXbJ9q9PGtb+8LoXvFdNekf5Che5K4GPYAvBPsGYwSlG06wDFX/AtwMV2eYAkVPJ8rqRGY9ZG1hFTZak1+QDE9y1tLrCPuswhVUW4Nk930zmY4O6YnWpDYUEzUQiN+YZREGxj4lbhTJQRnhjzis0Mcb4quvdIE8IMVLU92zPjdOFCZeoktzXEJd2djqTFjqkm+GAQQoj0UId6q8ilzLlubg8/xyZ/iT3f40hfjw4gMTiPIHROTCyeOa5MGQ/0LONF7E+I/QNMEzchaCXKPyx0RL/BzrhVQeKXENXj+aYdVw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(186009)(1800799009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(54906003)(70586007)(70206006)(316002)(110136005)(8936002)(8676002)(2616005)(4326008)(1076003)(40460700003)(41300700001)(82740400003)(356005)(478600001)(81166007)(36756003)(6666004)(7696005)(40480700001)(2906002)(83380400001)(47076005)(86362001)(36860700001)(426003)(44832011)(5660300002)(16526019)(26005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:06:43.0896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2825ec32-137b-4ad5-db90-08dba3e22e34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8963

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

This generates AMD IOMMU COMPLETE_PPR_REQUEST for the specified device
with the specified PRI Response Code.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  3 +++
 drivers/iommu/amd/iommu.c     |  1 +
 drivers/iommu/amd/ppr.c       | 15 +++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 5395d97486c8..167541bdcf1d 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -60,6 +60,9 @@ int amd_iommu_sva_gcr3_uninit(struct iommu_dev_data *dev_data);
 /* IOPF */
 int amd_iommu_iopf_init(struct amd_iommu *iommu);
 void amd_iommu_iopf_uninit(struct amd_iommu *iommu);
+int amd_iommu_page_response(struct device *dev,
+			    struct iommu_fault_event *event,
+			    struct iommu_page_response *resp);
 
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5234b1ee8f8b..948f9bf47e68 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2622,6 +2622,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.dev_enable_feat = amd_iommu_dev_enable_feature,
 	.dev_disable_feat = amd_iommu_dev_disable_feature,
 	.remove_dev_pasid = amd_iommu_remove_dev_pasid,
+	.page_response = amd_iommu_page_response,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
 		.map_pages	= amd_iommu_map_pages,
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 2e8d55657cb5..8cbcdb9c1669 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -153,3 +153,18 @@ void amd_iommu_iopf_uninit(struct amd_iommu *iommu)
 
 	raw_spin_unlock_irqrestore(&iommu->lock, flags);
 }
+
+int amd_iommu_page_response(struct device *dev,
+			    struct iommu_fault_event *event,
+			    struct iommu_page_response *resp)
+{
+	struct pci_dev *pdev;
+
+	if (!dev || !dev_is_pci(dev))
+		return -ENODEV;
+
+	pdev = to_pci_dev(dev);
+
+	return amd_iommu_complete_ppr(pdev, resp->pasid, resp->code,
+				      resp->grpid);
+}
-- 
2.31.1

