Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013017.outbound.protection.outlook.com [40.93.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEBB2DAFCA
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 06:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768457381; cv=fail; b=n01YA8NjUIJNs1pFyHWJxdfI5ekH+1ME5YZGGuC0H5gNQLNOz5IaiU+g0f6xksnnEb/eAh3qd0IDKNiWJZnOSoHEwU9yhZNyQ9DwXdr2xMDnP7g7uWEZSnnlLYljjIwoypn1mUuckWmTTBojIQO0+gfpwlS+dyR3CvzOwk7+IMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768457381; c=relaxed/simple;
	bh=TSCpMNvWM+S5bXNtHobB0vGpG2c+90HJVIsNziEVnxk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R8f2KwBxB64uM1N+WO8PZxGmyzlCRjuFCnsmSnMHusrhc6TSHJDdOEWs1FIbJE0/7trVnOsVamwJfZAEaDnVED4z741qUW8/WTyNsoEE1FyxGpa5SBh35bu06jDE5PJMusBglHPUU3qXOfI8x7Gi5JlaDO0DtGWki5VhzvtfhfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zyo1CqcQ; arc=fail smtp.client-ip=40.93.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zyo1CqcQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3EL6p7IkLl+L75XwcE2NNZ6VSuxXZafq7flNjT7iQGLGsAhwt7W7d77yoiLQj4gadF8aOWVTBtw6S9P36QsPFQLeOQTvfgI0UC2rkR+S6TNiJzHY5IxhsPucUYvw+gvZZY3UFNAOGrm1ZOR4IYJGLovVpoDxa5+KXwlUUAg7C3y3SNT3LENPI2nOmSiyIuLBs6GCnt5p/KUZUZL+N86ZxrEBWGaWP6wJseRV+Ly16DBg/S9x5gp3PJh6gs875G2l20e++TdfN7NVUjy34amwamPW3AE883ShuDUYmmd5HTs27ZbL90J5zlzTbvCzv8foiHYa3NOrBDTl7WEeijq1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDkxCW1V4hB9SWI62MwGMWB8/A1widW1fbznhUdklM4=;
 b=uoqkjXvzVjmyqPp4rNzMQ9gKI+7xH+nqkkMG9Qz3r6QQNt7pWv2iycYogWgdznzLXRdCLvoNCZNsENwPpjb9Go3HMo4tLWu6TwcRcIldPot2wEL6QY7u8+quzYJ68M7J0yFVLvfGyl3xftAeB6qyB1ZujRmbOEBBopO9m80TeZS7Z/5bjavOORi1wgPNZoSzMNMm5seFiBd4YFyUJrv6NHxyvA0nCAg/DjNVMMuLZ3HYbSknsH0RysPV069LLzFnHxEyR01Z1W0nbQzp5Z7EqdLIkYEgcKYXow5e4QPrEWwYVipYu7a1BUiDQ2uxZ6j6BnSMtqf5cWJ6g6TJCupJKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDkxCW1V4hB9SWI62MwGMWB8/A1widW1fbznhUdklM4=;
 b=Zyo1CqcQKk0c6GGyS9wOhHRs8jtWXQzYUq3AFxIrsRKpBzzO3xmWn0EdwgccSjpJq/iLH0Mqz+tHnVxL/Aijuu8ugeqRL0eIdN3plGOtVJOD7ect2cKKI5u/yHn1fNlOHjtYUcAsGt0ICbe0uSbaGKhDDrsIMJs68ijxyTabrQU=
Received: from SN7PR04CA0217.namprd04.prod.outlook.com (2603:10b6:806:127::12)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Thu, 15 Jan
 2026 06:09:34 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:127:cafe::5) by SN7PR04CA0217.outlook.office365.com
 (2603:10b6:806:127::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Thu,
 15 Jan 2026 06:09:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 06:09:33 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 00:09:27 -0600
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
Subject: [PATCH v6 10/13] iommu/amd: Introduce gDomID-to-hDomID Mapping and handle parent domain invalidation
Date: Thu, 15 Jan 2026 06:08:11 +0000
Message-ID: <20260115060814.10692-11-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
References: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|MW3PR12MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b06b0e0-0650-4c4b-453c-08de53fca76b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z7YwVNLLlQ2dr+ObnNSNOXmYdSou+GBguzZvH7fFsazfRGn8PcDPnKklAHe3?=
 =?us-ascii?Q?Hb2luRi4bnvcIBb1Qk/M0W0vnpzoketJXmG4n6hiUiEc8NbTygG6uNtH9xbH?=
 =?us-ascii?Q?JXCd8CkWOkS1Oc3HMjqqALy2yEdOM0C8bbxQoBiZ6TjGS7Tq3gPWcapkqSS7?=
 =?us-ascii?Q?zOml72l+E7sHg+vjdyAS4WDj1ngnvtNtY5H+MXuf62iQCOJcSRZeP1weH1FZ?=
 =?us-ascii?Q?8r4qfjmlSBuGHIEGFD9j1P+/Yk9PEarXc9dKUdGfOpO3M20IBHHMyr4nxa13?=
 =?us-ascii?Q?4T4iEypVzszcdiGR6iA2JxH5ovkeoD8JEFFNLZmmzhAYOErcGQcoNnpi3OjY?=
 =?us-ascii?Q?kF2GdRdVfAK6mDErQUpJLVJQ0elppB/xdF7qqHfazglQPND0ILfBBukj1LVU?=
 =?us-ascii?Q?Pg+cuwp1B/YeXB+kZf4dKbnjkpbCvDJ9Fk4+WyyuyeXWkAmngiFaXDberuZn?=
 =?us-ascii?Q?g4lAVjl5q73+DM2Ei6Ztv1ge4pPWltXhEDFlqq3jBj84+kwpqHMe5bVhcUPc?=
 =?us-ascii?Q?FuT1my1UyOflyLEteuR2J7jXDBCohNH4fe7gGeLBwS0FdN1xeGhv0wzZ2BTe?=
 =?us-ascii?Q?ihstLT2WyVZqzDaOcYzkonVubExwhGnB/Z/LuSfCilmNwp252V/3CGtalR45?=
 =?us-ascii?Q?McvmcKkCA1H/FfX24C0t17v6f6WbJuqpZxAnQixS6JpbEDZPgdV9DddOUuNN?=
 =?us-ascii?Q?A9OPbqCL+9KiWJCsfoM+P5ulCi+Vyl4ZHC1KLgLb7hX40yAmvtDTpj6McUfD?=
 =?us-ascii?Q?cM9P0ZXMlS09O/4kJU591R/v9nbf9EbEPSW5AYjnyhn8HAD0uIh0JuVSeIo7?=
 =?us-ascii?Q?AVeO7NfUKNP6Q8+Yp+wvYEKI1RKZB3BUDNRLgXfDVS5WjTdl4XRf1L7AvOJV?=
 =?us-ascii?Q?PE4+WCBIi/0uq+p32ZxSamSUobiRF5Fcu5pY9KuTI4I8k+xxm1rMYbJYK991?=
 =?us-ascii?Q?/EfJcCDoibDLr24BFrqCtAm7ny0aV7Poh8Ac2gkiJxCD6QE8UHzertLKSkQZ?=
 =?us-ascii?Q?WRyZHkWy4yWX+PXBFnAWfvj1w87uyfaa/jG+kWBbj5fbM5+Bxll4IHdj6QhI?=
 =?us-ascii?Q?RqNQv9b8xdB+5SnLoLT0SYZYoPQ74AeljXgWRWVQ+Ym5JeIpiE7KSqepVIga?=
 =?us-ascii?Q?bik+i2GWH2ceZiAeIk9WmnL4VGtUx+1ZQMxCyMoyTrGIcok91ojQOYs9w6St?=
 =?us-ascii?Q?1wEciG1zUkSIKTfxFl2rZIMkFRgJXCs847yBu5WxO9CwVj8eiRgJKcWDWfMU?=
 =?us-ascii?Q?PQGqBDu6CizmR048YKkkeH8ABcDKxjwsQ9k+GHAJMkAfv4sKEPzaXzFqeZsv?=
 =?us-ascii?Q?B0jlnOenN5WpzkgCkLZNG1zANWKzwb7d0tlkr566Csq9EJzkARFmmL76FuXh?=
 =?us-ascii?Q?88QiZLXmm/7YbkuUbcDIWRlTtX0Re0s2Gcr8JP6atiT89p8l/lW7nD3pyZmU?=
 =?us-ascii?Q?F0YJ5KgKvQkbDCU89IFGVE5i+96+QWukxvOCVvgO0iuNi9JfaWH8rXnlXlKa?=
 =?us-ascii?Q?db2DBZ35GDo1p7y70uov4qNiCFkOSmsJmaxwl4ms0OWozj49+c8yJpYSg3Gv?=
 =?us-ascii?Q?f7EQD+EKqG1LvREpEUKhhBprMb3pNUm4gpH0cDWhwTu0qpPV+KSJcr8ynLEY?=
 =?us-ascii?Q?32fmuiMKk5sILYp1x1BBRl62nzW320HTkC4r2+SZEiS8q+a/yjLAZdgc+PUN?=
 =?us-ascii?Q?8hB95Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 06:09:33.8178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b06b0e0-0650-4c4b-453c-08de53fca76b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492

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

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  23 ++++++
 drivers/iommu/amd/iommu.c           |  38 ++++++++++
 drivers/iommu/amd/iommufd.c         |  31 ++++++++
 drivers/iommu/amd/nested.c          | 111 ++++++++++++++++++++++++++++
 4 files changed, 203 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 487ee6123de5..4a98ac7dca0f 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -503,6 +503,22 @@ struct pdom_iommu_info {
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
@@ -511,6 +527,7 @@ struct amd_iommu_viommu {
 struct nested_domain {
 	struct iommu_domain domain; /* generic domain handle used by iommu core code */
 	u16 gdom_id;                /* domain ID from gDTE */
+	struct guest_domain_mapping_info *gdom_info;
 	struct iommu_hwpt_amd_guest gdte; /* Guest vIOMMU DTE */
 	struct amd_iommu_viommu *viommu;  /* AMD hw-viommu this nested domain belong to */
 };
@@ -535,6 +552,12 @@ struct protection_domain {
 
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
index ebc96f1f564f..e33076b99aac 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1539,6 +1539,32 @@ static void amd_iommu_flush_tlb_domid(struct amd_iommu *iommu, u32 dom_id)
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
+		struct amd_iommu *iommu = container_of(aviommu->core.iommu_dev,
+						       struct amd_iommu, iommu);
+
+		xa_lock(&aviommu->gdomid_array);
+		xa_for_each(&aviommu->gdomid_array, i, gdom_info) {
+			struct iommu_cmd cmd;
+
+			pr_debug("%s: iommu=%#x, hdom_id=%#x\n", __func__,
+				 iommu->devid, gdom_info->hdom_id);
+			build_inv_iommu_pages(&cmd, address, size, gdom_info->hdom_id,
+					      IOMMU_NO_PASID, false);
+			ret |= iommu_queue_command(iommu, &cmd);
+		}
+		xa_unlock(&aviommu->gdomid_array);
+	}
+	return ret;
+}
+
 static void amd_iommu_flush_all(struct amd_iommu *iommu)
 {
 	struct iommu_cmd cmd;
@@ -1687,6 +1713,17 @@ static int domain_flush_pages_v1(struct protection_domain *pdom,
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
 
@@ -2504,6 +2541,7 @@ static void protection_domain_init(struct protection_domain *domain)
 	spin_lock_init(&domain->lock);
 	INIT_LIST_HEAD(&domain->dev_list);
 	INIT_LIST_HEAD(&domain->dev_data_list);
+	INIT_LIST_HEAD(&domain->viommu_list);
 	xa_init(&domain->iommu_array);
 }
 
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index eb6119bdcf12..2e50633d9c72 100644
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
@@ -38,10 +40,39 @@ size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type vi
 int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *parent,
 			    const struct iommu_user_data *user_data)
 {
+	unsigned long flags;
 	struct protection_domain *pdom = to_pdomain(parent);
 	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
 
+	xa_init_flags(&aviommu->gdomid_array, XA_FLAGS_ALLOC1);
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
+	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
+	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
+	struct protection_domain *pdom = aviommu->parent;
+
+	spin_lock_irqsave(&pdom->lock, flags);
+	list_del(&aviommu->pdom_list);
+	spin_unlock_irqrestore(&pdom->lock, flags);
+	xa_destroy(&aviommu->gdomid_array);
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
index a8c0bb4dd733..8154a773eed8 100644
--- a/drivers/iommu/amd/nested.c
+++ b/drivers/iommu/amd/nested.c
@@ -6,6 +6,7 @@
 #define dev_fmt(fmt)	"AMD-Vi: " fmt
 
 #include <linux/iommu.h>
+#include <linux/refcount.h>
 #include <uapi/linux/iommufd.h>
 
 #include "amd_iommu.h"
@@ -58,6 +59,33 @@ static int validate_gdte_nested(struct iommu_hwpt_amd_guest *gdte)
 	return 0;
 }
 
+static void *gdom_info_load_or_alloc_locked(struct xarray *xa, unsigned long index)
+{
+	struct guest_domain_mapping_info *elm, *res;
+
+	elm = xa_load(xa, index);
+	if (elm)
+		return elm;
+
+	xa_unlock(xa);
+	elm = kzalloc(sizeof(struct guest_domain_mapping_info), GFP_KERNEL);
+	xa_lock(xa);
+	if (!elm)
+		return ERR_PTR(-ENOMEM);
+
+	res = __xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
+	if (xa_is_err(res))
+		res = ERR_PTR(xa_err(res));
+
+	if (res) {
+		kfree(elm);
+		return res;
+	}
+
+	refcount_set(&elm->users, 0);
+	return elm;
+}
+
 /*
  * This function is assigned to struct iommufd_viommu_ops.alloc_domain_nested()
  * during the call to struct iommu_ops.viommu_init().
@@ -68,6 +96,7 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 {
 	int ret;
 	struct nested_domain *ndom;
+	struct guest_domain_mapping_info *gdom_info;
 	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
 
 	if (user_data->type != IOMMU_HWPT_DATA_AMD_GUEST)
@@ -92,7 +121,63 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 	ndom->domain.type = IOMMU_DOMAIN_NESTED;
 	ndom->viommu = aviommu;
 
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
+	xa_lock(&aviommu->gdomid_array);
+
+	gdom_info = gdom_info_load_or_alloc_locked(&aviommu->gdomid_array, ndom->gdom_id);
+	if (IS_ERR(gdom_info)) {
+		xa_unlock(&aviommu->gdomid_array);
+		ret = PTR_ERR(gdom_info);
+		goto out_err;
+	}
+
+	/* Check if gDomID exist */
+	if (refcount_inc_not_zero(&gdom_info->users)) {
+		ndom->gdom_info = gdom_info;
+		xa_unlock(&aviommu->gdomid_array);
+
+		pr_debug("%s: Found gdom_id=%#x, hdom_id=%#x\n",
+			  __func__, ndom->gdom_id, gdom_info->hdom_id);
+
+		return &ndom->domain;
+	}
+
+	/* The gDomID does not exist. We allocate new hdom_id */
+	gdom_info->hdom_id = amd_iommu_pdom_id_alloc();
+	if (gdom_info->hdom_id <= 0) {
+		__xa_cmpxchg(&aviommu->gdomid_array,
+			     ndom->gdom_id, gdom_info, NULL, GFP_ATOMIC);
+		xa_unlock(&aviommu->gdomid_array);
+		ret = -ENOSPC;
+		goto out_err_gdom_info;
+	}
+
+	ndom->gdom_info = gdom_info;
+	refcount_set(&gdom_info->users, 1);
+
+	xa_unlock(&aviommu->gdomid_array);
+
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
@@ -100,8 +185,34 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 
 static void nested_domain_free(struct iommu_domain *dom)
 {
+	struct guest_domain_mapping_info *curr;
 	struct nested_domain *ndom = to_ndomain(dom);
+	struct amd_iommu_viommu *aviommu = ndom->viommu;
+
+	xa_lock(&aviommu->gdomid_array);
+
+	if (!refcount_dec_and_test(&ndom->gdom_info->users)) {
+		xa_unlock(&aviommu->gdomid_array);
+		return;
+	}
+
+	/*
+	 * The refcount for the gdom_id to hdom_id mapping is zero.
+	 * It is now safe to remove the mapping.
+	 */
+	curr = __xa_cmpxchg(&aviommu->gdomid_array, ndom->gdom_id,
+			    ndom->gdom_info, NULL, GFP_ATOMIC);
+
+	xa_unlock(&aviommu->gdomid_array);
+	if (WARN_ON(!curr || xa_err(curr)))
+		return;
+
+	/* success */
+	pr_debug("%s: Free gdom_id=%#x, hdom_id=%#x\n",
+		__func__, ndom->gdom_id, curr->hdom_id);
 
+	amd_iommu_pdom_id_free(ndom->gdom_info->hdom_id);
+	kfree(curr);
 	kfree(ndom);
 }
 
-- 
2.34.1

