Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1285534D38A
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971996; cv=fail; b=VSea5liNlduS+uRKwxNBTYq7D0qV+OEF1oHgTWNTbEr6A93lVLwHv9ppd3/Q16ZQ5+izlqlmeB4z9hkCAZuc6vUQzT0Z0EVdWfRT/UAsb99e0iVHrGBYmUUSCcY45IsXLUyn536OsN1WXQivUR2UESUbLR49f59MOC9EHrLEikI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971996; c=relaxed/simple;
	bh=8tgaHaKnUwf0uVu/1UWpmG6rP27yB/B3m4eo/IjU1Ls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mj0a/71LltaVyNF8mlLEIV/ZkpumQdtaCxsKehWN0JWmWccYBMHqnX3yJYyTy2xtwWBpOCW8bg7tlN5BhNYRGJchaVFqF4lXxqxJ0qppeZ1tLJPFsWVLR8mD2BuSZYip7EeCJ0H5dOWlcE6nuRE6HoVivmEdqm4ZdgDsQYP5pRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4v6S7u+9; arc=fail smtp.client-ip=52.101.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4v6S7u+9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqQa8Pwyn6Rg/FOpRu6xd2G/V+iCh7p8bewmMd0w4RYK+jiRSqpuyiXW+mNVlXq6hVOHdmzX/bA9XOtg0orBPg+pTv77NoVM9bsC5hkCSGRNIkeQH5SeCUEohCR8KodqPWlgu2HDstoZBw157phE84slBLJt45OWwtvsPkPGT12STDmqOkwhmKFtecTtjp6nx7Zhrx7x2kibFnkWS0KtrA9vV7pPSye+7iEM8ubsCXfsGp8l5w4Jdrgqc0Zz3kXctAHEqj5gGFv6aGBRrq+pNsDLCZ98CPBCGXjXes2k7nsfy9eG+b1Z9a5kV27F1mbmdmNi1Tq7d7bMfWMLjcJWcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsjfAULtnAx2M+fmVyzjBc6+Q00Sz9PnLE2jB8bk6BY=;
 b=BBg3KXfyJniaxEsUIYXe1VxHFjprCuJPjPQQi40e41iVHfkNSBlCRMH7dxh1AU73xk23rYPuYDfVatGyvEq+Epdf/7lJppNr7JbypYqOExNzoTJl+bH/3yLAlhZYus+CrCfH/TABd8JHMxZDiW5YLrre+Vi/OKsJpGyPlbHzmGXmhDE1e/ClCZZIM+ys4UtfIP+9RSthwSrnZ4v2mOn7AQx93dlvfpAlekiAzDsi+MKBKLjqqU6TdeTG2mReIiu31iodG9u6bWW4Zgoiy+MgdeHapvHoNWhrxOvsUw8YPy4PM5ibG9WUAlwhCy4jag+L+dmCZfRDX+yxzMMGQcEndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsjfAULtnAx2M+fmVyzjBc6+Q00Sz9PnLE2jB8bk6BY=;
 b=4v6S7u+9mZi08C3EpC35JTEcMNll7lj2g+TMElO0myUz8/iCfrcmoMRqI4SnbsSu/MaKwekU71DCnugvR6GiWEbf4H6CQQugJqzjAsmzr+xmt/zPeHlP05KFiPiusN8gnHfVmngPzpupPxdjbThPKQ8qn5idBbONB0TBPa2Pb8U=
Received: from BN9PR03CA0957.namprd03.prod.outlook.com (2603:10b6:408:108::32)
 by CH3PR12MB7546.namprd12.prod.outlook.com (2603:10b6:610:149::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 18:26:29 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:408:108:cafe::c9) by BN9PR03CA0957.outlook.office365.com
 (2603:10b6:408:108::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.10 via Frontend Transport; Wed,
 12 Nov 2025 18:26:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:26:28 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 10:26:23 -0800
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 11/14] iommu/amd: Introduce gDomID-to-hDomID Mapping and handle parent domain invalidation
Date: Wed, 12 Nov 2025 18:25:03 +0000
Message-ID: <20251112182506.7165-12-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|CH3PR12MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: a6f9de5b-cf66-4ca8-7dee-08de2218ff42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DX/2FaDExzMnZM/ZUMr3u9lW4NBHQyK7Yj+qblfdenuA4bmyRlS1NPi6vqgt?=
 =?us-ascii?Q?evkO2+bxDnwwMjcabT62srjT92ykfeWCtjlVLTKWJzwHW/Zziegif7QraI2L?=
 =?us-ascii?Q?75ALzjc4C3HPRvrNXIqRXkybRPaCPopv/m1iERd9CVGhkzCBUXeswshHhmqi?=
 =?us-ascii?Q?9aS75+r9cad8iUFbDJRIyt8TU4r1hM6RxhRLqIQPSLFvwk2o1/Fb44qetSd5?=
 =?us-ascii?Q?m/W7hJRp4uYcFLXAKvHh8SnzjcOke3e3apQ4HMBDmRlXgRQ5wTHSIPDnzMWS?=
 =?us-ascii?Q?rCLuwc5rDta73RXM08F+y0NKeOKebJh4a5xNH4Wvec/Xvf8oonyEFpDSiqp2?=
 =?us-ascii?Q?N51KJJz9ZaLNE/pZGtanBz6wBwsNZROMt2AJ//7X6uC1OYDIEwofDhYY1xrQ?=
 =?us-ascii?Q?XnsdIpqijIIfE63n3R+8VJ3oBAY5de94ZsD6ISUSoagFT59/1ccolVl56g09?=
 =?us-ascii?Q?CS2XPmc5mOBR2NsbzL5YTy//WXZq5RxxnpUzaVvDv+PClbMIP+H1dLltc9Gp?=
 =?us-ascii?Q?mt6+NMsDmcHkeQHz5ISkj6oC/XPfHdBGfwpJw6jB77WHaNTTQ4Va9YDSN0TS?=
 =?us-ascii?Q?bJ7NfUzH2j0w+6bXTQdiSfyORN+NKlQ3HzOVT/Vox1AAsao3VszT53n3vMFc?=
 =?us-ascii?Q?cxb9Q2qa5j591XQBgu1d63kJy4oP3edUQ26WLKWJ1iaRp54db70pyUi+tC8E?=
 =?us-ascii?Q?k64VIv4sDrHaCHx4tmNt+thCr34HinPS58fiGEJH0w5wN2A3K4vmq7Al5trk?=
 =?us-ascii?Q?vXay7T3crNajt0VBA/T9uxuDaAsGHvYmDHPiPSxvwFv935KVy3MSgMlO7yWE?=
 =?us-ascii?Q?ElbpNrw+k1Ym3x+2JVrtKnBw6SuHHr1zXE/fqhBv/HTaja+0HNKJ4GUAwP6N?=
 =?us-ascii?Q?U2ugvi0J423WlYPUD1WjwN9iJC6aOo2Iigox12ysu59zcDcFSDZZkXYCvgrS?=
 =?us-ascii?Q?rdWFtotUhLSwJxkyo7Brqpa4gZJCUfBdlnDwNtidf7ljjU6LAQw91+sr0bDQ?=
 =?us-ascii?Q?PHZVw06tc9feuXnZlSNQ7QL7kVxud8zus4vfYVzVOOXonHaQrClKajCl11Vq?=
 =?us-ascii?Q?MNuVsdb/PEkSmKiuNVz3KgUsTKJYuAXav3TX6OTSnTuxDJCoUyTae8C6L2Vm?=
 =?us-ascii?Q?8cl/sA1e/LGN9n1br4agQHfRK0Wix5UB+THWjowgG4SJwYclmo/eOacSaGLn?=
 =?us-ascii?Q?yJfvasokDw5VQYdCWfszLEKjMTDEGc415+q9bHNuTmS+UMQgUWWbXI1mCY5X?=
 =?us-ascii?Q?+BbVx7gr6gnNTEKUYi2Kw6m1AauH5qPATq124rpnyyBpRuxmVX8vWAyqopFJ?=
 =?us-ascii?Q?FPg+Iahe+B+9UVtheag+wKUNz/RkWnRaHrlUHNU8yFpSgwWzzTDvChu+TdTY?=
 =?us-ascii?Q?aemHUk79MqnUx34PGELAcesgxqLNs8cljiTA5D621UTJ4gfyISOHzlnRuBEE?=
 =?us-ascii?Q?OeYUbAtXGidb1G0EkMeQEL43pDHy94SJ7yjLebsCXhmgo54TgDu8V8UY1Ccb?=
 =?us-ascii?Q?NBtuGeIiHg43D9IKRYvGAEfhl81RlElXhaUU+VpbqlipluDMN9PdDwAEa1Gx?=
 =?us-ascii?Q?hKuezVmv0ct9kURfeQc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:26:28.8268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f9de5b-cf66-4ca8-7dee-08de2218ff42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7546

Each nested domain is assigned guest domain ID (gDomID), which guest OS
programs into guest Device Table Entry (gDTE). For each gDomID, the driver
assigns a corresponding host domain ID (hDomID), which will be programmed
into the host Device Table Entry (hDTE).

The hDomID is allocated during amd_iommu_alloc_domain_nested(),
and free during nested_domain_free(). The gDomID-to-hDomID mapping info
(struct guest_domain_mapping_info) is stored in a per-viommu xarray
(struct amd_iommu_viommu.gdomid_array), which is indexed by gDomID.

Note also that parent domain can be shared among struct iommufd_viommu.
Therefore, when hypervisor invalidates the nest parent domain, the AMD
IOMMU command INVALIDATE_IOMMU_PAGES must be issued for each hDomID in
the gdomid_array. This is handled by the iommu_flush_pages_v1_hdom_ids(),
where it iterates through struct protection_domain.viommu_list.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 23 +++++++++
 drivers/iommu/amd/iommu.c           | 35 +++++++++++++
 drivers/iommu/amd/iommufd.c         | 34 ++++++++++++
 drivers/iommu/amd/nested.c          | 80 +++++++++++++++++++++++++++++
 4 files changed, 172 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index e46f346fd6c5..734f6a753b3a 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -498,6 +498,22 @@ struct pdom_iommu_info {
 struct amd_iommu_viommu {
 	struct iommufd_viommu core;
 	struct protection_domain *parent; /* nest parent domain for this viommu */
+	struct list_head pdom_list;	  /* For protection_domain->viommu_list */
+
+	/*
+	 * Per-vIOMMU guest domain ID to host domain ID mapping.
+	 * Indexed by guest domain ID.
+	 */
+	struct xarray gdomid_array;
+};
+
+/*
+ * Contains guest domain ID mapping info,
+ * which is stored in the struct xarray gdomid_array.
+ */
+struct guest_domain_mapping_info {
+	refcount_t users;
+	u32 hdom_id;		/* Host domain ID */
 };
 
 /*
@@ -506,6 +522,7 @@ struct amd_iommu_viommu {
 struct nested_domain {
 	struct iommu_domain domain; /* generic domain handle used by iommu core code */
 	u16 gdom_id;                /* domain ID from gDTE */
+	struct guest_domain_mapping_info *gdom_info;
 	struct iommu_hwpt_amd_guest gdte; /* Guest vIOMMU DTE */
 	struct amd_iommu_viommu *viommu;  /* AMD hw-viommu this nested domain belong to */
 };
@@ -530,6 +547,12 @@ struct protection_domain {
 
 	struct mmu_notifier mn;	/* mmu notifier for the SVA domain */
 	struct list_head dev_data_list; /* List of pdom_dev_data */
+
+	/*
+	 * Store reference to list of vIOMMUs, which use this protection domain.
+	 * This will be used to look up host domain ID when flushing this domain.
+	 */
+	struct list_head viommu_list;
 };
 PT_IOMMU_CHECK_DOMAIN(struct protection_domain, iommu, domain);
 PT_IOMMU_CHECK_DOMAIN(struct protection_domain, amdv1.iommu, domain);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 724b8723b836..6a26e7a28141 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1513,6 +1513,29 @@ static void amd_iommu_flush_tlb_domid(struct amd_iommu *iommu, u32 dom_id)
 	iommu_completion_wait(iommu);
 }
 
+static int iommu_flush_pages_v1_hdom_ids(struct protection_domain *pdom, u64 address, size_t size)
+{
+	int ret = 0;
+	struct amd_iommu_viommu *aviommu;
+
+	list_for_each_entry(aviommu, &pdom->viommu_list, pdom_list) {
+		unsigned long i;
+		struct guest_domain_mapping_info *gdom_info;
+		struct amd_iommu *iommu = container_of(aviommu->core.iommu_dev, struct amd_iommu, iommu);
+
+		xa_for_each(&aviommu->gdomid_array, i, gdom_info) {
+			struct iommu_cmd cmd;
+
+			pr_debug("%s: iommu=%#x, hdom_id=%#x\n", __func__,
+				 iommu->devid, gdom_info->hdom_id);
+			build_inv_iommu_pages(&cmd, address, size, gdom_info->hdom_id,
+					      IOMMU_NO_PASID, false);
+			ret |= iommu_queue_command(iommu, &cmd);
+		}
+	}
+	return ret;
+}
+
 static void amd_iommu_flush_all(struct amd_iommu *iommu)
 {
 	struct iommu_cmd cmd;
@@ -1661,6 +1684,17 @@ static int domain_flush_pages_v1(struct protection_domain *pdom,
 		ret |= iommu_queue_command(pdom_iommu_info->iommu, &cmd);
 	}
 
+	/*
+	 * A domain w/ v1 table can be a nest parent, which can have
+	 * multiple nested domains. Each nested domain has 1:1 mapping
+	 * between gDomID and hDomID. Therefore, flush every hDomID
+	 * associated to this nest parent domain.
+	 *
+	 * See drivers/iommu/amd/nested.c: amd_iommu_alloc_domain_nested()
+	 */
+	if (!list_empty(&pdom->viommu_list))
+		ret |= iommu_flush_pages_v1_hdom_ids(pdom, address, size);
+
 	return ret;
 }
 
@@ -2469,6 +2503,7 @@ static void protection_domain_init(struct protection_domain *domain)
 	spin_lock_init(&domain->lock);
 	INIT_LIST_HEAD(&domain->dev_list);
 	INIT_LIST_HEAD(&domain->dev_data_list);
+	INIT_LIST_HEAD(&domain->viommu_list);
 	xa_init(&domain->iommu_array);
 }
 
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index eb6119bdcf12..bb53475f9171 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -9,6 +9,8 @@
 #include "amd_iommu.h"
 #include "amd_iommu_types.h"
 
+static const struct iommufd_viommu_ops amd_viommu_ops;
+
 void *amd_iommufd_hw_info(struct device *dev, u32 *length, u32 *type)
 {
 	struct iommu_hw_info_amd *hwinfo;
@@ -38,10 +40,42 @@ size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type vi
 int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *parent,
 			    const struct iommu_user_data *user_data)
 {
+	unsigned long flags;
 	struct protection_domain *pdom = to_pdomain(parent);
 	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
 
+	xa_init(&aviommu->gdomid_array);
 	aviommu->parent = pdom;
 
+	viommu->ops = &amd_viommu_ops;
+
+	spin_lock_irqsave(&pdom->lock, flags);
+	list_add(&aviommu->pdom_list, &pdom->viommu_list);
+	spin_unlock_irqrestore(&pdom->lock, flags);
+
 	return 0;
 }
+
+static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
+{
+	unsigned long flags;
+	struct amd_iommu_viommu *entry, *next;
+	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
+	struct protection_domain *pdom = aviommu->parent;
+
+	spin_lock_irqsave(&pdom->lock, flags);
+	list_for_each_entry_safe(entry, next, &pdom->viommu_list, pdom_list) {
+		if (entry == aviommu)
+			list_del(&entry->pdom_list);
+	}
+	spin_unlock_irqrestore(&pdom->lock, flags);
+
+}
+
+/*
+ * See include/linux/iommufd.h
+ * struct iommufd_viommu_ops - vIOMMU specific operations
+ */
+static const struct iommufd_viommu_ops amd_viommu_ops = {
+	.destroy = amd_iommufd_viommu_destroy,
+};
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
index dd3e53dd16ea..1bbcb16abecc 100644
--- a/drivers/iommu/amd/nested.c
+++ b/drivers/iommu/amd/nested.c
@@ -6,6 +6,7 @@
 #define dev_fmt(fmt)	"AMD-Vi: " fmt
 
 #include <linux/iommu.h>
+#include <linux/refcount.h>
 #include <uapi/linux/iommufd.h>
 
 #include "amd_iommu.h"
@@ -68,6 +69,7 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 {
 	int ret;
 	struct nested_domain *ndom;
+	struct guest_domain_mapping_info *gdom_info, *curr;
 	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
 
 	if (user_data->type != IOMMU_HWPT_DATA_AMD_GUEST)
@@ -92,7 +94,60 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 	ndom->domain.type = IOMMU_DOMAIN_NESTED;
 	ndom->viommu = aviommu;
 
+	gdom_info = kzalloc(sizeof(*gdom_info), GFP_KERNEL);
+	if (!gdom_info)
+		goto out_err;
+
+	/*
+	 * Normally, when a guest has multiple pass-through devices,
+	 * the IOMMU driver setup DTEs with the same stage-2 table and
+	 * use the same host domain ID (hDomId). In case of nested translation,
+	 * if the guest setup different stage-1 tables with same PASID,
+	 * IOMMU would use the same TLB tag. This will results in TLB
+	 * aliasing issue.
+	 *
+	 * The guest is assigning gDomIDs based on its own algorithm for managing
+	 * cache tags of (DomID, PASID). Within a single viommu, the nest parent domain
+	 * (w/ S2 table) is used by all DTEs. But we need to consistently map the gDomID
+	 * to a single hDomID. This is done using an xarray in the vIOMMU to
+	 * keep track of the gDomID mapping. When the S2 is changed, the INVALIDATE_IOMMU_PAGES
+	 * command must be issued for each hDomID in the xarray.
+	 */
+	curr = xa_cmpxchg(&aviommu->gdomid_array,
+			  ndom->gdom_id, NULL, gdom_info, GFP_ATOMIC);
+	if (curr) {
+		if (xa_err(curr)) {
+			ret = -EINVAL;
+			goto out_err_gdom_info;
+		} else {
+			/* The gDomID already exist */
+			pr_debug("%s: Found gdom_id=%#x, hdom_id=%#x\n",
+				 __func__, ndom->gdom_id, curr->hdom_id);
+			refcount_inc(&curr->users);
+			ndom->gdom_info = curr;
+			kfree(gdom_info);
+			return &ndom->domain;
+		}
+	}
+
+	/* The gDomID does not exist. We allocate new hdom_id */
+	gdom_info->hdom_id = amd_iommu_pdom_id_alloc();
+	if (gdom_info->hdom_id <= 0) {
+		xa_cmpxchg(&aviommu->gdomid_array,
+			   ndom->gdom_id, gdom_info, NULL, GFP_ATOMIC);
+		ret = -ENOSPC;
+		goto out_err_gdom_info;
+	}
+
+	refcount_set(&gdom_info->users, 1);
+	ndom->gdom_info = gdom_info;
+	pr_debug("%s: Allocate gdom_id=%#x, hdom_id=%#x\n",
+		 __func__, ndom->gdom_id, gdom_info->hdom_id);
+
 	return &ndom->domain;
+
+out_err_gdom_info:
+	kfree(gdom_info);
 out_err:
 	kfree(ndom);
 	return ERR_PTR(ret);
@@ -100,8 +155,33 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 
 static void nested_domain_free(struct iommu_domain *dom)
 {
+	struct guest_domain_mapping_info *curr;
 	struct nested_domain *ndom = to_ndomain(dom);
+	struct amd_iommu_viommu *aviommu = ndom->viommu;
+
+	if (!refcount_dec_and_test(&ndom->gdom_info->users))
+		return;
 
+	/*
+	 * The refcount for the gdom_id to hdom_id mapping is zero.
+	 * It is now safe to remove the mapping.
+	 */
+	curr = xa_cmpxchg(&aviommu->gdomid_array, ndom->gdom_id,
+			  ndom->gdom_info, NULL, GFP_ATOMIC);
+	if (curr) {
+		if (xa_err(curr)) {
+			pr_err("%s: Failed to free nested domain gdom_id=%#x\n",
+			       __func__, ndom->gdom_id);
+			return;
+		}
+
+		/* success */
+		pr_debug("%s: Free gdom_id=%#x, hdom_id=%#x\n",
+			__func__, ndom->gdom_id, curr->hdom_id);
+		kfree(curr);
+	}
+
+	amd_iommu_pdom_id_free(ndom->gdom_info->hdom_id);
 	kfree(ndom);
 }
 
-- 
2.34.1

