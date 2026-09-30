Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010023.outbound.protection.outlook.com [40.93.198.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9FD47ACF9
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760319; cv=fail; b=XVRqHUL0tWGMuIMYAYRIjgJmt6BXw4LJE3CY6wCYhfuC6Vl8nKrBPpd9F8b5L7iBqhqvAyvihPxHvrLSOmAaZ+9c+vCNRa9zrXhsxifZol++OPFtqckiFyY0Vg4vGvfT1aQgDykMr6wmHtomr1lf/LFpT6qaWt5QVn+d5eOvSMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760319; c=relaxed/simple;
	bh=puzGt46jXpDFo0Rhgj/1LRu47O8gL2Ltu9yPruH1mcc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DHUGExzSzZr5GXKoaX1xqh+qIUKqSqstFlctjjVDu4chUVN1cn/mPrb+mkcbDdBv8dJ6QmHuN5Tb13yg5Q8zpHmWm8zDsD6g4UM2mDsPcF3jWSKmAuNfnRsxVTErCQt5aaF6Heq/fobcgtWx3pi5PLRTdmStYP5SaDHmi89FXco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4CCN48Cz; arc=fail smtp.client-ip=40.93.198.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4CCN48Cz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgJFbWy/kdmTPdCdGCKLtYCxFCH/S2bye28X6NDUgzocnqSEQpqoGl5HaQUMPZsZpgkd+mWUsuzSQotjrhO23592VkW4hI8am9utjuCgSTRT69WUkkpXZciuVnv9P5tfPbv689OrL93eAwEw23ToKSHqpcIJ1NoqU7ju6j0JMtKgIIUcTLS/MraD0Kh6gT2V+LZH8v+Cnk4Uk1b85mmw8U6sW88530NEfBMfxOBZmDaVH8qTx+Ad1J3WaywLRx8WHgpugP3XGkYnaqTKsmMQZ6t7jjT2etcc7ikk7hiRITYbnIKf7LAVeY94pqjWXzYGujDHROVNhdJnxnBDsgcPyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzxz8lv3Wu/r/c5c83+AptQQTHoRfkla3UrWRDxQ620=;
 b=PS3UMGfj+lW6FXVZjW9r9AkNfiUDQvQ+zOE+s18LhQpXm9euzvy1ktGGgq/XuKO4AuBrmcoX0j/AZLs3lMEDVtQwzzPDK2sNRC5VgVCfh5fytNKtamED5vIV5xsb0aGayHQUWecYgyYYzaYAk6RXrSoasdXv0B7Y7mo4Nv5v9GdxD7bKrSKvw6b04E61rBp+Hdy+iThlMzuHB5d98Pqpzj5kLIWRGc03HW2PjGo2ch32xSBmMTva1K5/4qRYxuAfMZNBClZPzwx3QzcphPs1Veun/I3YmCQ2Kk0P47oyrNrqGxL27Ur/NEAt/J6v5umfGJBFVKUzlOBAthY/IH5q0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzxz8lv3Wu/r/c5c83+AptQQTHoRfkla3UrWRDxQ620=;
 b=4CCN48CzRCHhkxr+vfRsIcxZG/NsO6B53E9T08+lsmXtx4AA3TVgVFIusKC+vnVP1746K9O8wEmf2j3AziKj6zrrzACsPxAGS1O4bNef0xAIxX6LYo9ZP9WfJkRNjw+fOSpeRiFKorRRJmp1o2UgGXXkzoSSLVqXzkNdzdDIaZE=
Received: from CY5PR19CA0129.namprd19.prod.outlook.com (2603:10b6:930:64::27)
 by IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Wed, 30 Sep
 2026 09:25:13 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:930:64:cafe::b) by CY5PR19CA0129.outlook.office365.com
 (2603:10b6:930:64::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 09:25:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:25:13 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:24:59 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <Ming.Shu@amd.com>,
	<SooJin.Tan@amd.com>, <chrisl@kernel.org>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>,
	<guanghuifeng@linux.alibaba.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 10/24] iommu/amd: Pass iommu to device_flush_dte()
Date: Wed, 30 Sep 2026 09:23:30 +0000
Message-ID: <20260930092344.5616-11-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|IA1PR12MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: f310ff56-6fca-4ebf-5848-08df1ed4bb24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|23010399003|1800799024|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	j+X/dk2y8jA2JTvrzq5e2ynsc60eleOG5aKjPgtyL4UcBjTqiEWwsX2EdtnW9YgTeSsOyIQ+syWDLy7RNXBwarb5uf25JL9YL2GAJrINQLyYngzaKyuYVWx3S1McLxXJIbAwcmT8FZhzjQ8WDFvB4SYQpLTeUJExiY/qQAqIqwOGYcNxvjyoglngqzXQY9+qismWdjxdrrgwmG14crxaVNDrPfM8md3jxtpcaMOW7rqwYBTQXpJUWySxoszW/xgvKynkbpFSi1c+YXg25a3tbOy2KbE2OAbdXEWqWSK75WdEQR+WnZS+a5+5NNp9wk+q3eKlOWBJ0Cg7MDmDTkeaChtlrrI3/FCup/IVd06EoA+V/Pjq8i/j5MqcnDxNfi4OswzcJHZ2vrJR3H9ynQMZR5fOHsrc/s84BcXa9Gaiu+VJXCvnD2w1wgFHAoUhzhop421MMJWqlFpbZgDPM/x30QMF+rM1EuGkWb8fBhmGO3VCftC8gU+/z+nXArn9veEqgNzb+ldmJPV9C6yBpRZcC7g8pqzPeo+D/n0uGB1OLLcdV1y5qg4BszTW860oYNukq4adB7JMe5phapJ2b27X8EQHnx+GxUqtnHGQoiq7u+CoaXvk9oBuoe07XRTdVdwGWP4G4L3fJJZrfqm6nFldmNw/kpyLPAinlIaZe0B5XjcXnRGlZFqOfDFH3c+7YUXCLItz4RArA9Bz49F31SZi7Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YZlIi2KlO/92nr6J0djcDO3Jm+menczD0USi5viGZ2J84ZfTS/j+OgiDKFP/w+ATHbuGWsBpxmOB78yTPX1dK8FNt3inI6bc55cfsk5roe4+ON11VEg1Mja8VXPyiNy/8REeQg7wxk/U23JDTehzyqftVm7i1FkstvuycfJqGjMRwCE2XqMFHGnyuS1c5e2rZlSYqf23p6xuRgUqvoalwrpPDROwy8BlnWIeD7Zm3FnN99i0MQlKd+7KXUQ1gGNBMUELbxn7wL8juDxu59bY4jU9Go2LZxK2dgAwbtCHmuAAO2Qfx64HQfCcLlj2AMNsikXIKl2+C43/spBAJSQqNAWU/VTG38kLhRhERXnu+gMpgjceMuR17KbnCRjkWwnK4OoFmJsTniWOt0O60eKZJNG+xQjTeQz87JPXIC9QOrRj9MD0Ijn3dATa0ifbKWKG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:25:13.1117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f310ff56-6fca-4ebf-5848-08df1ed4bb24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434

Take struct amd_iommu explicitly so DTE invalidation is issued on the
same IOMMU instance used to program the DTE. Also, flush each device in
amd_iommu_change_top() immediately after updating its DTE.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index dfb9268f3c4e..a45044e1d423 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -76,7 +76,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data,
 			  phys_addr_t top_paddr, unsigned int top_level);
 
-static int device_flush_dte(struct iommu_dev_data *dev_data);
+static int device_flush_dte(struct amd_iommu *iommu, struct iommu_dev_data *dev_data);
 
 static void amd_iommu_change_top(struct pt_iommu *iommu_table,
 				 phys_addr_t top_paddr, unsigned int top_level);
@@ -218,7 +218,7 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
 {
 	update_dte256(iommu, dev_data, new);
 	clone_aliases(iommu, dev_data->dev);
-	device_flush_dte(dev_data);
+	device_flush_dte(iommu, dev_data);
 	iommu_completion_wait(iommu);
 }
 
@@ -1824,9 +1824,8 @@ static int device_flush_dte_alias(struct pci_dev *pdev, u16 alias, void *data)
 /*
  * Command send function for invalidating a device table entry
  */
-static int device_flush_dte(struct iommu_dev_data *dev_data)
+static int device_flush_dte(struct amd_iommu *iommu, struct iommu_dev_data *dev_data)
 {
-	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	struct pci_dev *pdev = NULL;
 	struct amd_iommu_pci_seg *pci_seg;
 	u16 alias;
@@ -2795,11 +2794,9 @@ static void amd_iommu_change_top(struct pt_iommu *iommu_table,
 		/* Update the HW references with the new level and top ptr */
 		set_dte_entry(iommu, dev_data, top_paddr, top_level);
 		clone_aliases(iommu, dev_data->dev);
+		device_flush_dte(iommu, dev_data);
 	}
 
-	list_for_each_entry(dev_data, &pdom->dev_list, list)
-		device_flush_dte(dev_data);
-
 	domain_flush_complete(pdom);
 }
 
@@ -3233,7 +3230,7 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 		spin_unlock(&dev_data->dte_lock);
 
 		/* Flush device DTE */
-		device_flush_dte(dev_data);
+		device_flush_dte(iommu, dev_data);
 		domain_flush = true;
 	}
 
-- 
2.34.1

