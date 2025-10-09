Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012008.outbound.protection.outlook.com [40.93.195.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA052BD5AF
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 23:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054384; cv=fail; b=Aasl3at19eM+5QI0/V7vPYvWqXJf4zJpfAhv7xEz6ubctpYH3Q6mvqBOU5eOHduxBAyHFLwxjhSmxDC1qWdGlEsw5m9ufvGIyIiDqguE2z9qeIXazVBViM3boQtJRcJoLiyp8udricj9sNlqQ7GQJ31B38nZFbCiN8ITMl4paTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054384; c=relaxed/simple;
	bh=ut6reaH0FEBHZjcIZ/bb7fV3yepkHmBPaJEowvHQC1U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q36jFmN8Nvb63sjvdw5gCucyMajSvP/ir44FG0GTRmpERsiBavQYjgPSQ0kOhfaliB8L7Ta6Eoqu880O5jHvLp0T5R0EpLqpSPuYjdAuNZGvTKx2HII1NPVIaLmTuzKjkpyFEMOKWsFT7fVqnKaly857kif52GiuxFb4wqwQaXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4xZiud3o; arc=fail smtp.client-ip=40.93.195.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4xZiud3o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2k4G6DKNPqDNUQZ5MNnd+hkxe2cwRJMM0TJ+F5OUqoY1ye0wLBwy3W/fzutFOCFbihUlFjD9nYbtdQydCPAAd2CtgCpwkvMiA3xz+lMWKKlrndRlyKXcI9aXDWA18daVY8zjBmHQhtsJHHn5twDaGeHane3pHVEacnKUJe3Cy2p/W9RYvbPGsOERijmYB9OSnoTzTBsI37eYQwAP4gDgRl9tklvoiNbUZ0cxTJUKsyqn35bTxH/sZ0+EREip8QzApcQZ5VDTyX3+QkHv6YdH5EMgC/CQeLGx8EawmPJZMHfXI6SQEHH7MSZkxAWJArYdS9N44GflXFXHNIKH+Z4ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVfpwYlhAZ24t32we4trRp1mV2NsC3725Che5nPL/JQ=;
 b=zKWYWXPy1UttMSgE2vnICpRTZbQGAPWqMf4u2p7RI8A4jXNNYXFl0uIV3gtq+YfUcU0W67O1zc2qPgD3artS/eXOOq6+rfvKD4iBKxyTGmBi5X/gfr38Sn8QiR7OxrTxwe9PRLKhcnS09RYTRz6QRUwDI+6NySGmrfiPOEYCrFjRde8K88BaZ+ZX/WYLzBYCcqhVbwvCk3Hm+B82QO5Ia2pyrM9DvE2vrKjtIAaW42XcvA1SXK7Qq6vCLZt7TnH7EsKUz13CfsReM6uDLdME13SgpB4nrdDn7ixbhyqygeXrF6YvY0hQvj+QPAkQC0oqwFVabPekIfL+0UnvjoSUmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVfpwYlhAZ24t32we4trRp1mV2NsC3725Che5nPL/JQ=;
 b=4xZiud3oFzIYhWtoFVqQZz8GCliCViiWE+K32K7P3nbQ858OVMcnWIvJyMw/OevxiU3z3JvJu0V2SfsBSoLM77OEsjqdMkQ6qN/k4GgJOuNl4TaW79rY3SByC0opA/2QmQCZrd4BahWboYCZt/GVffptmDCoWKyDY+LEg8sBBrc=
Received: from DM6PR03CA0053.namprd03.prod.outlook.com (2603:10b6:5:100::30)
 by MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 23:59:38 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::2c) by DM6PR03CA0053.outlook.office365.com
 (2603:10b6:5:100::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Thu,
 9 Oct 2025 23:59:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 23:59:38 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 16:59:32 -0700
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
Subject: [PATCH v3 15/15] iommu/amd: Add support for nested domain attach/detach
Date: Thu, 9 Oct 2025 23:57:55 +0000
Message-ID: <20251009235755.4497-16-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
References: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|MN2PR12MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cbd28ce-562a-4ef8-b574-08de078fe7a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e/iIP84tpbZkWa/C2uuhTfT7sUSXu0iotCcxyyr7BLLcMsvS4Txf56PlquIX?=
 =?us-ascii?Q?8hWezqq87Dz+1gErhT5GX5LCBnWqjvoTU+qOvwbNbSwAMI0j3n9Zu094uUq/?=
 =?us-ascii?Q?UR2ZAWs+nkFOJjX/ZMkqUGfZ7CymPJLIq7gDKHfqtShPXKRXPaATO1C6IJjR?=
 =?us-ascii?Q?8RMxj1WMe5lw48jCXd5kfuatMdZhiilFr9I0+QhiRTs+OmSUz+JSWJacTY3/?=
 =?us-ascii?Q?8VvzxSS2u88e95ok+e9nkoN4IM/un9yt1sWqVwIAVZ0l+ibwHpSFUj3FouMX?=
 =?us-ascii?Q?02ZOP/Lt5FBKQWdW0cySbnMErPhd/DbnS1A6TNMQ1r5lIxnBJpB5xhPC867S?=
 =?us-ascii?Q?sfr5FbrnSnhzbLoi4sN+KqFbA+TnGPfRx3dJNCq3ZctNB9n1SZjcNP0i90lg?=
 =?us-ascii?Q?3IO6DWWhZkzROf0AT1nxggDym3GTi9fTBDvkUr7XuIScbe2eQrQusbLHBJWD?=
 =?us-ascii?Q?J91ygrfQTtKRJM7ltZkfTskg9i4ZP8hoxSPcnKneSXo+lPbE2TMOONc5aXsP?=
 =?us-ascii?Q?uUOWBQ/1jqUen+206a0dDb1pkB/844/Qq6jvzBBoEguaZRJS0+ZEAsDWD4Ml?=
 =?us-ascii?Q?D3f3gI4EJzTLitsOIWt07YRFOeQk6QticnTV1wujKpwZxra1f2vLNtC+q2cS?=
 =?us-ascii?Q?lbjV6Idqq+lXMCb6WlVhSS2NhDQIBlxY5GZUSwGxziKa5sh9jJ3jlarmkxGN?=
 =?us-ascii?Q?SRUzFSqCMA4RyYo5D9gEx7Wwgow2iObM0OKgA0RaKOm78r5orwn2ioWUzOPx?=
 =?us-ascii?Q?2eKqEcvIwrrpKhMw8oPMrTRlmOBWDVpg/pScC75fhhHBHQVbkJroUWzCe9qA?=
 =?us-ascii?Q?M8MPOPhxqNxaOrU/4Mf3v/PcJ6BNHH+xa9tj8KxxJx6wTNqQ0jQ9BgfUy3Xt?=
 =?us-ascii?Q?/r8sAHdCDZ9f38BlzQS7++56aDIdTjy6mqRgg/PoKWTUYzBPRtcIVvaKjqt+?=
 =?us-ascii?Q?G2BM4zVm28bRoe2eKmeLq9Zw3+cW4dhij7iu86uPs1zFFYXmWVrb2G4/icMT?=
 =?us-ascii?Q?BArISjO4malsxRZNwX7ZFY+KrLKFkVLd1mSc94D41k4j1j2KSrlTsaoO1/Jx?=
 =?us-ascii?Q?MjbhvpNUWgrHeFExG6Zz5IuJvK1AAapiAn9aGRbkMP8kie7ciBS70fSY0oMh?=
 =?us-ascii?Q?MPQb8asnJoPGWm4LrtNsnV4CvZUHR7iOFoRkx1aNjp8LOpBEXPODW1diCAij?=
 =?us-ascii?Q?GRDgRFAczI3Z5YVq6FFxQxK6fuBDjhXQke2VAg6HmpA+LQ2IFPla0YyVvLB7?=
 =?us-ascii?Q?I+nh35QpyotCY1kXRLYDcKgh9Vp/zghPgo5byIHtcL70QrQhH9nEf4YYJNpP?=
 =?us-ascii?Q?I3jQkoqtHPCy8xOBEnTu33vcq0whWPkAJfFJgNzjOe7sd+drxJnwVuwuAmmL?=
 =?us-ascii?Q?1PSkpqsfHceopyMNw3IvBRm1TJgiFSeVJz05IHCOfdfMSmZuqm0HM7he6NYX?=
 =?us-ascii?Q?npLTA0XSbFDVLcmTmTfZidIDlRIhuFbo4xriFjCNp6whanw5H0YDO3hJrakF?=
 =?us-ascii?Q?RIb2HUh1IaTjg24iYOBe9rsg88AP5LswEzNBC120teAkNlz/P7QnvAZdG52H?=
 =?us-ascii?Q?mtJRkXzbitdQ8OCIb1c=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 23:59:38.0310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbd28ce-562a-4ef8-b574-08de078fe7a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173

Introduce set_dte_nested() to program guest translation settings in
the host DTE when attaches the nested domain to a device.

In addition, introduce struct amd_iommu_viommu, which stores reference to
the nest parent domain assigned during the call to struct
iommu_ops.viommu_init(). Information in the nest parent domain is needed
when setting up the DTE for nested translation.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  3 ++
 drivers/iommu/amd/amd_iommu_types.h |  8 ++++
 drivers/iommu/amd/iommu.c           |  8 ++--
 drivers/iommu/amd/nested.c          | 66 +++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index cfb63de7732a..98351b0cb9a0 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -190,6 +190,9 @@ struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid);
 int amd_iommu_completion_wait(struct amd_iommu *iommu);
 
 /* DTE */
+void amd_iommu_set_dte_v1(struct iommu_dev_data *dev_data,
+			  struct protection_domain *domain, u16 domid,
+			  struct dev_table_entry *new);
 int amd_iommu_device_flush_dte(struct iommu_dev_data *dev_data);
 void amd_iommu_update_dte256(struct amd_iommu *iommu,
 			     struct iommu_dev_data *dev_data,
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a68b5c2fc0a2..683ee288c636 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -17,6 +17,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/pci.h>
+#include <linux/iommufd.h>
 #include <linux/irqreturn.h>
 #include <linux/io-pgtable.h>
 
@@ -420,6 +421,7 @@
 #define DTE_FLAG_HAD	(3ULL << 7)
 #define DTE_MODE_MASK	GENMASK_ULL(11, 9)
 #define DTE_HOST_TRP	GENMASK_ULL(51, 12)
+#define DTE_FLAG_PPR	BIT_ULL(52)
 #define DTE_FLAG_GIOV	BIT_ULL(54)
 #define DTE_FLAG_GV	BIT_ULL(55)
 #define DTE_GLX		GENMASK_ULL(57, 56)
@@ -590,6 +592,11 @@ struct pdom_iommu_info {
 	u32 refcnt;	/* Count of attached dev/pasid per domain/IOMMU */
 };
 
+struct amd_iommu_viommu {
+	struct iommufd_viommu core;
+	struct protection_domain *parent; /* nest parent domain for this viommu */
+};
+
 /*
  * Structure defining one entry in the device table
  */
@@ -607,6 +614,7 @@ struct nested_domain {
 	struct iommu_domain domain; /* generic domain handle used by iommu core code */
 	u16 id;	                    /* the domain id written to the device table */
 	struct iommu_hwpt_amd_guest gdte; /* Guest vIOMMU DTE */
+	struct amd_iommu_viommu *viommu;  /* AMD hw-viommu this nested domain belong to */
 };
 
 /*
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2a536d02aeab..013914fc8a4f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2044,9 +2044,9 @@ static void set_dte_gcr3_table(struct amd_iommu *iommu,
 		target->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_4_LEVEL);
 }
 
-static void set_dte_v1(struct iommu_dev_data *dev_data,
-		       struct protection_domain *domain, u16 domid,
-		       struct dev_table_entry *new)
+void amd_iommu_set_dte_v1(struct iommu_dev_data *dev_data,
+			  struct protection_domain *domain, u16 domid,
+			  struct dev_table_entry *new)
 {
 	/*
 	 * When SNP is enabled, we can only support TV=1 with non-zero domain ID.
@@ -2089,7 +2089,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 
 	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
 
-	set_dte_v1(dev_data, domain, domid, &new);
+	amd_iommu_set_dte_v1(dev_data, domain, domid, &new);
 	set_dte_gcr3_table(iommu, dev_data, &new);
 
 	if (dev_data->ppr)
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
index 3307c925d3c1..ca3d3001c87f 100644
--- a/drivers/iommu/amd/nested.c
+++ b/drivers/iommu/amd/nested.c
@@ -63,6 +63,7 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 			      const struct iommu_user_data *user_data)
 {
 	int ret;
+	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
 	struct iommu_hwpt_amd_guest gdte;
 	struct nested_domain *ndom;
 
@@ -85,6 +86,7 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 
 	ndom->domain.ops = &nested_domain_ops;
 	ndom->domain.type = IOMMU_DOMAIN_NESTED;
+	ndom->viommu = aviommu;
 	memcpy(&ndom->gdte, &gdte, sizeof(gdte));
 
 	/*
@@ -111,6 +113,69 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 	return ERR_PTR(ret);
 }
 
+static void set_dte_nested(struct amd_iommu *iommu,
+			   struct iommu_domain *dom,
+			   struct iommu_dev_data *dev_data)
+{
+	struct protection_domain *parent;
+	struct dev_table_entry new = {0};
+	struct nested_domain *ndom = to_ndomain(dom);
+	struct iommu_hwpt_amd_guest *gdte = &ndom->gdte;
+
+	/*
+	 * The nest parent domain is attached during the call to the
+	 * struct iommu_ops.viommu_init(), which will be stored as part
+	 * of the struct amd_iommu_viommu.parent.
+	 */
+	if (WARN_ON(!ndom->viommu || !ndom->viommu->parent))
+		return;
+
+	parent = ndom->viommu->parent;
+	amd_iommu_make_clear_dte(dev_data, &new);
+
+	/*
+	 * Use nested domain ID to program DTE.
+	 * See amd_iommu_alloc_domain_nested().
+	 */
+	amd_iommu_set_dte_v1(dev_data, parent, ndom->id, &new);
+
+	/* Guest PPR */
+	new.data[0] |= gdte->dte[0] & DTE_FLAG_PPR;
+
+	/* Guest translation stuff */
+	new.data[0] |= gdte->dte[0] & (DTE_GLX | DTE_FLAG_GV | DTE_FLAG_GIOV);
+
+	/* GCR3 table */
+	new.data[0] |= gdte->dte[0] & DTE_GCR3_14_12;
+	new.data[1] |= gdte->dte[1] & (DTE_GCR3_30_15 | DTE_GCR3_51_31);
+
+	/* Guest paging mode */
+	new.data[2] |= gdte->dte[2] & DTE_GPT_LEVEL_MASK;
+
+	amd_iommu_update_dte256(iommu, dev_data, &new);
+}
+
+static int nested_attach_device(struct iommu_domain *dom, struct device *dev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	int ret = 0;
+
+	if (WARN_ON(dom->type != IOMMU_DOMAIN_NESTED))
+		return -EINVAL;
+
+	mutex_lock(&dev_data->mutex);
+
+	/* Update device table entry */
+	set_dte_nested(iommu, dom, dev_data);
+	amd_iommu_device_flush_dte(dev_data);
+	amd_iommu_completion_wait(iommu);
+
+	mutex_unlock(&dev_data->mutex);
+
+	return ret;
+}
+
 static void nested_domain_free(struct iommu_domain *dom)
 {
 	struct nested_domain *ndom = to_ndomain(dom);
@@ -120,6 +185,7 @@ static void nested_domain_free(struct iommu_domain *dom)
 }
 
 static const struct iommu_domain_ops nested_domain_ops = {
+	.attach_dev = nested_attach_device,
 	.free = nested_domain_free,
 };
 
-- 
2.34.1

