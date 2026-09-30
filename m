Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012047.outbound.protection.outlook.com [40.93.195.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2351D3546FF
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760328; cv=fail; b=TVS0vzHc2ZtvNl+h9I5N45iXvS472+WWkquvCv/qppNHzkAaS612/ZaSltc9GzJe+V6VR3zjA20uTZ+VyFc9uRW2B/RHa51mPcFwL1d/IUZ0h22QAUZyTVd/mEoBav4JpGjKzIhIApxoOSR1cNfvccXDPSeqNI8b48x1TJQxyk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760328; c=relaxed/simple;
	bh=WcnfoQZFGNb1jF9TjArGHzbYFZLde8mc+NSrU/RER5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4/T+t+YOug9rKPsgPUe1Qqu9QGzeYqtDg+3X8Dd92FHIKT7lmAdILut9SCuGlHB2AyGaTz8zbuyP/1fktPcV6vAfdzPzs8uATjbndQmTwdVT9+U68JFIpI1ZP/Ws2+kl9wQf8qF3MpUfcjRUZo63LB3Lj7InLAJssI/kpLh5IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D2ZE27Wo; arc=fail smtp.client-ip=40.93.195.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D2ZE27Wo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBOY4jSu3XVGQHo0ZgTIB91+aj22c/nY1d9tZmIVKdz10Fs0jHeDOH8SlC6VL70rwEE+7xip5UI+gYYI8Fa4Pjwdxq+K3uCigC7Kn6yrKg7aa/2QGBLiMAdlmdwmGcFv9I76uDPE9TYvnPZvlXMl3zLkCdOpjFCWN/kYJGw2ksxTK5x6+7e4VhFpHRA/dlKyy4RxIbsXOSagj+i1+MsF5OiI+sffkrZazupoNtG7yJ5KXctXm7GLGmvSc0FGjf0Kv9SXmupgats/K50NRqNE2kdQNDaggl+2fHARDORrwRgsR0XKhlvwAxHe+0+lZzs5RucYpKrnUaVKFFQOVuQAdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjlhyfX+NHe5kz6lgSQsy2wv0oP45ZLACOfSQ+KhmAc=;
 b=r1dt/Y2HA90y2DsSA24m1mfHVZZlG3t65hLUhv5ICSeLDdqS2+WZB8Rq+oj7Y+44TCxGxnGmbODpH+NBOvOXUpSLnBFDVI4zxHF+kQf5sua8vc+tuTq8wFmFukQIVO1wSJbe0hkn6hxs9CLuhCVTEW47QwPsqTUr61hhhsGchU424hzgt0vqx9xnoH26O1a18IyKy414D/LxDkdSJD2SgkgppkHZoZc8AxN6OQ+ft65GLSRhEQsboZa0hzBS5QGIun0IFkek4cbT2PEuy5k193FDYU5vZQyx0MYoQYURDMnoVgvcZek8jN3Rl6hxhmZtjrOyzkSUZksn1KcQr/UfRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjlhyfX+NHe5kz6lgSQsy2wv0oP45ZLACOfSQ+KhmAc=;
 b=D2ZE27WoWGXW45c4g68JlKhl9W297UuWjTKuS+c9+myNJtwT/De4VZE7cq5w2L3DfxD/SoznTNNck7FvYGpGfWE/Zrxn6fQSmBJsDr09MhhQ8C4Pf37SWjeBmfNN3RcoKSWuotLVaT9XeVV+CQc1eNCFNxAidhmmgzw4eUqznc4=
Received: from PH8PR20CA0020.namprd20.prod.outlook.com (2603:10b6:510:23c::21)
 by SJ5PPF4D350AC80.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::993) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 09:25:19 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::5e) by PH8PR20CA0020.outlook.office365.com
 (2603:10b6:510:23c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 09:25:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:25:19 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:25:05 -0500
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
Subject: [PATCH v6 11/24] iommu/amd: Pass iommu and devid to amd_iommu_make_clear_dte()
Date: Wed, 30 Sep 2026 09:23:31 +0000
Message-ID: <20260930092344.5616-12-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|SJ5PPF4D350AC80:EE_
X-MS-Office365-Filtering-Correlation-Id: 00bca7f9-32e4-4454-2de2-08df1ed4bec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|7416014|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	22gMGnyJnMgGHf/RaxdE5gjhc6sd2HBeLjrJAO8doMECps0jBFCuhYGiyV5oLTGfk2uyjXUadUyD//ja7Q2WiLbdRD57kgRdfX/dJEkIbYbpx2XOtyWEuaLnoskjKzhi0Y/p7Bnv+n2RER4Q9Zv79PiKsxt/MsfXOLs9rMFK/GqXL9uYfjgc27dMLGvFG7WjgkRA6fBmcPTKL7ZEZjlMTa5905HJLBndE/WWGzI0JW2ABrLNZ/vIAM9mwHfAnHux8Rf6mzz0xgUlu0ihkchnnKpy1jPw9f0PXqi/u2txgjvmt2uuU4hSnD4EgEiKhFzcq2u3nRHaON7C9zH+SNyo1hs9YWFp1Vt8SG/Ss5FgSztqTGAFP31XzI00oYTkqhsfqjao7WR9jddsStib1Q76eix6MlSs08yJmwK63iWDFSJ1IY8EtHiuO3c60qKxi6TbR9ujefAt8LuRco+jR6b2SpKr/ckWwGYVPtmzKP52J1xwx1Zv8zE7FrsObCrksUJEWkmcEaw2hKTHHEnByyXjaMcjfa93W/E6PCSvKDiwMzZXOjLeRjo0ZUOnNf0HnZKVNoR6JOcv1Op3OnRvfll+9Ju7P+kzbwqR5ZGFqFbqy9Nr55tPFmd7ffwKTPTjKDg6I5qVBhkyCh7OL1ypPi9KoisnxGu7NcCLc0M241QKlIWyT1+hnLnkGbCk45RhQb8bOrxfUxoqpI6h8ZNVji/9KA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(7416014)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MnIblIl7B8c1uAwIqioc77qRBJzDIXjqfV5OU0v9ShGPPyy/SiN9+zTPYaSofs6sgnJbRU7pixfblpL9g0TURriPhiLtFS2j2tIFnqUOhCo8Zs6JYX25Y7CoHcvh+6G4WiqL21mNzdiETQdPHJ0goeRcPKsiA4RMQl9LUuTolRqAfs4H8u1vfv0254tJlCLkp+HKuCWXVbY/b+Wg5ebiauooHA4aEuhV78szbJ3cuiSO1sSBIbDTKyFARcFDdh2iRvYmCJLaeSEs3ISNK6aiVbs/Z8/ezrT2cS0QOxg5wiJ4Gkr4SmRVJf2nQJZW2egj2XW/fiqIym5ZfTTQy5Vk+yTlkZL1TZpFb5MG0kJxrQ++ts0B11vdA6o4EfmQ5YSC8jUaZWv/Crm3d7c+y12oD8p1OybB8F9cAu+W7+el5EB1Z67sy/SjhgqRr2hNFHGG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:25:19.1539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00bca7f9-32e4-4454-2de2-08df1ed4bec2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4D350AC80

Take struct amd_iommu and device ID explicitly instead of deriving
the IOMMU from struct iommu_dev_data.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 6 +++---
 drivers/iommu/amd/iommu.c     | 4 ++--
 drivers/iommu/amd/nested.c    | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index a0d5d7e34020..9cc5da745a73 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -210,10 +210,10 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
 			  struct dev_table_entry *new);
 
 static inline void
-amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *new)
+amd_iommu_make_clear_dte(struct amd_iommu *iommu, u16 devid,
+			 struct dev_table_entry *new)
 {
 	struct dev_table_entry *initial_dte;
-	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
 
 	/* All existing DTE must have V bit set */
 	new->data128[0] = DTE_FLAG_V;
@@ -223,7 +223,7 @@ amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry
 	 * Restore cached persistent DTE bits, which can be set by information
 	 * in IVRS table. See set_dev_entry_from_acpi().
 	 */
-	initial_dte = amd_iommu_get_ivhd_dte_flags(iommu->pci_seg->id, dev_data->devid);
+	initial_dte = amd_iommu_get_ivhd_dte_flags(iommu->pci_seg->id, devid);
 	if (initial_dte) {
 		new->data128[0] |= initial_dte->data128[0];
 		new->data128[1] |= initial_dte->data128[1];
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a45044e1d423..d4de87ded457 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2347,7 +2347,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
 
-	amd_iommu_make_clear_dte(dev_data, &new);
+	amd_iommu_make_clear_dte(iommu, dev_data->devid, &new);
 
 	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
 	if (gcr3_info->gcr3_tbl)
@@ -2379,7 +2379,7 @@ static void clear_dte_entry(struct amd_iommu *iommu, struct iommu_dev_data *dev_
 {
 	struct dev_table_entry new = {};
 
-	amd_iommu_make_clear_dte(dev_data, &new);
+	amd_iommu_make_clear_dte(iommu, dev_data->devid, &new);
 	amd_iommu_update_dte(iommu, dev_data, &new);
 }
 
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
index f1c7987fc585..8bb0d1596c6c 100644
--- a/drivers/iommu/amd/nested.c
+++ b/drivers/iommu/amd/nested.c
@@ -205,7 +205,7 @@ static void set_dte_nested(struct amd_iommu *iommu, struct iommu_domain *dom,
 		return;
 
 	parent = ndom->viommu->parent;
-	amd_iommu_make_clear_dte(dev_data, new);
+	amd_iommu_make_clear_dte(iommu, dev_data->devid, new);
 
 	/* Retrieve the current pagetable info via the IOMMU PT API. */
 	pt_iommu_amdv1_hw_info(&parent->amdv1, &pt_info);
-- 
2.34.1

