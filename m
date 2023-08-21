Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CE74C6A
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 10:51:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjfHoKayEnf1EJOI8yyVX/jthHj873Qj7+gH7TvllGorqwfLyOnE3MWHGmB1ValjsXPHsim3f/0pd1SGIUJOIiGQxY/qJMXlRLGVy/ojQRc5RZ4vX2+CDy8R4Hl5x5rc4pU0Q9iqXxBqmqQUZXME/Auu1x0Zq8VJ1Tt2c4moO4edsAsizHMjIyM9tSQzGWsmTmAj1sUUFWA6yYoGjJSz8yD+9jPaYekcYLFzAsQqMK57BmX70/rKV0thg101rgappzkd+2vsuPj0aF0kN6mJCvW83ECVT74ndSV04zQquRoHEWizYcXdOCbXrNExR2zVRRKxmnaIHtSzbHzAPfA8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGvLBmswfGWHmx/NAtqwkT8WxecRxWcQ0BoFDMdk1DY=;
 b=kXBc5qMQxsoF3pvt7PLcWQ5TS+xsEoL8nRFTL4RwJJz3qgweEFf1rc2rHs+IxpZTRLD2MoBYTEJxVlChJsgXdLx6Eg39zj77xaFx1D3jSZWjuqxf2Kx2DLIcTjovGRFusFAfe/CpG895lz+sx0ilkW9UJH6VpG3uRpGa7XybSwg78+x71souTj8tmLUnkU82Gaf3DTCinhL6nqI3Q12V/K8J42ZkxmjRnAfIW4gZvPxGHpvkUYYr8gICRrn5zZpkbCjPirx4/xhlvhIh7BofNM+54uDLNjlKlZ7Sc/krzMn8r8VQ7QSqxYyOc/XqFJ5WA6kG2e/ugLwxhHA1Hwkwvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGvLBmswfGWHmx/NAtqwkT8WxecRxWcQ0BoFDMdk1DY=;
 b=ToXtXU/GWbPdXttiV3uqYj9gMYhjvdK5J5O6ZUfL20sA0IR5dn9+WbdiCUSYmpSp0Xii8a8AM6oWuM5IqBffAGtTsZWTFHtO4zwId+YBr0TzAnNc7pcqbq9zIUdRg5Dka8peUU5c40Z+y6cF2awak65ZzSLwVrh5aJNplyYJg6c=
Received: from MW3PR05CA0017.namprd05.prod.outlook.com (2603:10b6:303:2b::22)
 by CH2PR12MB4230.namprd12.prod.outlook.com (2603:10b6:610:aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 10:51:43 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:2b:cafe::f9) by MW3PR05CA0017.outlook.office365.com
 (2603:10b6:303:2b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Mon, 21 Aug 2023 10:51:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 10:51:43 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 05:51:40 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 4/5] iommu/amd: Remove unused EXPORT_SYMBOLS
Date: Mon, 21 Aug 2023 10:49:55 +0000
Message-ID: <20230821104956.707235-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821104956.707235-1-vasant.hegde@amd.com>
References: <20230821104956.707235-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|CH2PR12MB4230:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ad0b14b-234a-45e8-000a-08dba2349ba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F6iKD9CwTwspn152JO9sYvTQ3n2ALhK1OW1kcqpZpH2+2pF69ynaK8Qnkmq24IuwqzNZ38spxWvRPSYBolWEMRzYteI+3pfRSluhGq30WSzh/GNlmMf+HQHhdhp9PGBw+MjKETvZ1rzRd5vutOLOUozbGQ0aYLmub+yjknfaqugYsgGV7nkGAdFj/G3MCiOLTxNpSwS0XjHA53XduicvN948fSSLorvIYSJpZpRQ6IV2fh6LxPInX4NzjhDGDJjAhG2xvS8mbVpfpe6vdspLGRm6rIyJFg5p8A43te/tK+4FsCqmKKD72iL3ZwZwhTbvEZIUnGsFGwlN3+Mw5Juo5BLO7yXsctzA1ighpWy2EglvCM78zdVgcsgk32uqne1qKcX1npDetZu7uocCCrdVA6T6r/7bc+9Kw9l/tnP578tUhdesgJNoiRPuh4Kz2dtaYDofBCmBejpu66SGqaP+eqkQmqAbF+8aoga1d+WElmbav7SX/c4fgKefqEK9kFH0lCFQMQYILg4rlx5CwqS6la8Oce020D7HrqcUjOLJTgYQnFZ5aNsYVZy684kDWd56D75ktOgCwmql4YgE506huiEYywbdXz2uHUeEewvXmj+6nH0ZvGMDllvGHmWHu+kQXndY4/kNeZH2qFOl5ao1zYX2+kv21yEVrigt2+MVWdwf2V24Xz6AhJeDEdIstNDwBTL++GOQotxUG41wcgZmTKlLul11LxKkaSA5kldkbdOCMoq++bDV3nETi2JycQIlPQAHmEN2ebIXFYxRcVJIUw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(7696005)(40480700001)(5660300002)(44832011)(336012)(426003)(16526019)(26005)(86362001)(36860700001)(47076005)(8676002)(2616005)(8936002)(4326008)(70206006)(316002)(54906003)(70586007)(110136005)(478600001)(82740400003)(356005)(81166007)(6666004)(40460700003)(41300700001)(36756003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 10:51:43.4422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad0b14b-234a-45e8-000a-08dba2349ba2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4230

Drop EXPORT_SYMBOLS for the functions that are not used by any modules.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c  | 1 -
 drivers/iommu/amd/iommu.c | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 463e68a88b17..64bcf3df37ee 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3666,7 +3666,6 @@ bool amd_iommu_v2_supported(void)
 	 */
 	return amd_iommu_gt_ppr_supported() && !amd_iommu_snp_en;
 }
-EXPORT_SYMBOL(amd_iommu_v2_supported);
 
 struct amd_iommu *get_amd_iommu(unsigned int idx)
 {
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index fdb5b1362ba0..8e4f52d8bc9d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2446,7 +2446,6 @@ bool amd_iommu_is_attach_deferred(struct device *dev)
 
 	return dev_data->defer_attach;
 }
-EXPORT_SYMBOL_GPL(amd_iommu_is_attach_deferred);
 
 static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
@@ -2606,7 +2605,6 @@ int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid,
 
 	return ret;
 }
-EXPORT_SYMBOL(amd_iommu_flush_page);
 
 static int __amd_iommu_flush_tlb(struct protection_domain *domain, u32 pasid)
 {
@@ -2626,7 +2624,6 @@ int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid)
 
 	return ret;
 }
-EXPORT_SYMBOL(amd_iommu_flush_tlb);
 
 static u64 *__get_gcr3_pte(u64 *root, int level, u32 pasid, bool alloc)
 {
@@ -2706,7 +2703,6 @@ int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
 
 	return ret;
 }
-EXPORT_SYMBOL(amd_iommu_domain_set_gcr3);
 
 int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid)
 {
@@ -2720,7 +2716,6 @@ int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid)
 
 	return ret;
 }
-EXPORT_SYMBOL(amd_iommu_domain_clear_gcr3);
 
 int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
 			   int status, int tag)
@@ -2739,7 +2734,6 @@ int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
 
 	return iommu_queue_command(iommu, &cmd);
 }
-EXPORT_SYMBOL(amd_iommu_complete_ppr);
 
 #ifdef CONFIG_IRQ_REMAP
 
-- 
2.31.1

