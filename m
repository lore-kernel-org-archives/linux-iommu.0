Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6CB38DC57
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 18:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411771; cv=fail; b=EszmvUS2LVexvQTlAQ6NTczseFTEw6xxLJkuvgr0fPhBwWz4TPBXuidqQUmvcsquVXp4cKl+XtIaZDW93ZXB0+bCE4kWfNwEySXXTTb6JneY6DXRr4kjfBP4O2/LKKJWSwNGzfRMEWVBvFK240AOUmJ+FjKlad6qWIEoAFBIPAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411771; c=relaxed/simple;
	bh=L7oaWtICbm7/6chyS170IJAjX7Y5kYeU/29cdE5sLBI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SeddxV87o6GL9GxPMuy6ie8qVsSspu1PigAN8aY2eLvndeI4Zp/Qi1PJMBRlToYRL526d/aWVuK2BTCvLuY9tvnqVp1q+K5kTX0LjIuCyoShgcEA2VPOMKA4alsao6yYBNtBvZymTantgaY1PidoVlANWDbOz84mUVldwNGX5eE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SShUv2B1; arc=fail smtp.client-ip=40.107.209.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SShUv2B1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ni6yRajlQc3f3nXGC+XUCcfqzeVjuL7ri+1r6HkSpHc+YIw7pKXjWAtDME0wb4XYc/hvOISUqs03nopp0EtWIzku6oSVTd/3CL+kZ/ZxpftWTcZN4atqJHa82Ru8p9/1r7Mi2Kz8NChMqmKulTjf0VeaL/b+TlfFPSTpCuGmb6lJ/eA0OEj/hhWTznCS+FL0eUsMwzwXR0Jno818lmdBdwsjBJf+Fnf2IcsV3E68uqqQ6aUwhlDjp16l1Cg92RhinMb4tvmNh+fSUl2R3zQwkQwbICsvz2uLd5L0Lqhpn8O4JMqOAUxCuOQf3Yk1azHVkZ2ZDy5HurOKsHz+6ATeIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKr0yRZgqcIAqBuORLtP4ThqnAHxSU6/tq5G0i4Cqgo=;
 b=dHxnphx6K7qqKGhxr8bPdK5OneXVPDojwurl7uFXwBmMakC7vICFXTxZZUJUIphdHfsn12ncAshd8fdYaooqUe3Pi+qBaDnVodCYsiXKt5vmfVW6A/FMwZj4osshbJUc+WGrxiFm4dxY7YpfWLv8d1JjD2oDvgyc79dJmOin/NkdXW9WkafMVSwMeNYjApPcTj1DYNbFFQ6cC17700czJZ9n/XUhhedkz5j4ybAtG+Egi1ftrrcyu67KsK8ooM7Fkag5788UbaJx7vV5WUatS65Ykvg2lt3O9ErSKU/bppanoxQJvfsse9hwAqxadBd4xRmeZTlF7Sxkf66KIX/mYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKr0yRZgqcIAqBuORLtP4ThqnAHxSU6/tq5G0i4Cqgo=;
 b=SShUv2B1lhQTv90EZLakitn31PDBde+m5oa6x6/clPROaS9BZtf9CoFWnAeqM76aF6v7jS0+H+Y4HgVLrPA4uM8VdGuK/5wpFIrYPBFyFry9jhLLp3YPh4NY5UXUx3DLCkejbPNDEq1d98A1YSkYBUmgvbxoKqF1EFSw/wLzQwY=
Received: from BN9PR03CA0184.namprd03.prod.outlook.com (2603:10b6:408:f9::9)
 by DM4PR12MB6447.namprd12.prod.outlook.com (2603:10b6:8:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Mon, 14 Sep
 2026 18:49:23 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:408:f9:cafe::51) by BN9PR03CA0184.outlook.office365.com
 (2603:10b6:408:f9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 18:49:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 18:49:23 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 13:49:17 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <Ming.Shu@amd.com>,
	<SooJin.Tan@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>,
	<guanghuifeng@linux.alibaba.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 11/24] iommu/amd: Pass iommu and devid to amd_iommu_make_clear_dte()
Date: Mon, 14 Sep 2026 18:47:37 +0000
Message-ID: <20260914184750.222939-12-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
References: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|DM4PR12MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ca1931-66aa-4964-c0a0-08df1290e4e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|376014|7416014|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	X8gbrPkdFvV2W/ettTH+TYi2UWG+J6xpLYDo0tni+u+hEmhr0H1Ph8dDuHgP9DwtatFiOjBlsmyg1kUA4v6L7UlDsu58e1XBTJOY/tKUzjf4lY+ZzOw94vVCTomTxQ9L89cakwOlKrW6jksA38eUKKaadB/IJsu1tlZLXxsoTKz5u9yIcnJftWoaP8DHhz3t3smd/6zCTKmLbuU/jDWaoRuMC609lOdq+kJW/80eyP5wRF5x8+TaDpY7EC1bJC04mFtuOHSHPUEzJqR/BorWpzpKliXleRoBFQk4c5u+vNqkuYqRJ6QyS3Vz1BA/VOK+Yri1XAt6foztB/6vsdKZoeDhfZjbcJqACgVAnb0+CTgj01yARhRnLxesJPYhQmxQQ/I22Pqlb2gVDoe/rpUYrE2IIfYQipXPMy4bwOt3L4zosAeJFXaHVIlJn+neItxfafQbpDd2LVvCM3F2M+O20Xb1xth9/3dH3yah7dD6NbU8U6UVb7nTXJunL/gs+ww5xD1iu4leGBIvCFUggICWrLN4/1v67bPepTsMKb64OkMLRIMEe6OnGdzOe47FrmLK2CU9P6PT9AwOGnlxp6kdtDmSfi8umLgFbXa3mLGKLSdWNxYJeKMkKWJWdFuLp2JOZonAf/HAZyoaP0F9pfRzVpOZCSp9XT51ZgegbuBDaj0NO4vvrmNlcNVuFcAZoYGsIy07WuUevvoJ26amDy2jvQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(7416014)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uJfRCqdzFUNTixu1v/Eq4RoHZaEik85iEFqKAhL8e7aMZ5D6IreJ+3dh25GDXWLx+olR3uakA2OPsWr6IqCjeLuBIc0B4h6n9rh17Fb6Z7OGKwwnGEOL6S1JFkYSv4U+auVHHDwSNrnPgAbcjXz0cCD63nuLKDR+NJKNT8O2oG1cbRg+bj8ghBi4Bv6WuCAjBBZSnNKM5921TasaFJxgO3Iyi6uaw4gxBckwIJSskEtouPdrxKi4I2L/qk7ESHYCdCVTv8OQ+J4rCUBM6AKO2NzajLk5CamNfmBLerhNcAaZyAMLtwNunsL53UkopDIOnw/Nqr7+ag6mK7QSxvXHqK21zo3swnEqwOXXgpUH6HXdZgD91z8KqNvep6N5LEO1AzHPWQFU0v7oRXorfrgdtu2oumWAvZUB/kpkHwX7Qk67gSHvzpGEr+ZxBnz4SmLF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:49:23.4318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ca1931-66aa-4964-c0a0-08df1290e4e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6447

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
index c7b14842a6c7..dd2cb79d506f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2340,7 +2340,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
 
-	amd_iommu_make_clear_dte(dev_data, &new);
+	amd_iommu_make_clear_dte(iommu, dev_data->devid, &new);
 
 	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
 	if (gcr3_info->gcr3_tbl)
@@ -2372,7 +2372,7 @@ static void clear_dte_entry(struct amd_iommu *iommu, struct iommu_dev_data *dev_
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

