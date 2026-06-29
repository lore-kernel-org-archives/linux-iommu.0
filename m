Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013026.outbound.protection.outlook.com [40.93.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868C630596F
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747705; cv=fail; b=DL3kC0iCPjwDRjmCxdrndcJSA2If9qL0TlnrQ9OgrJNzWJJ3gm9RuYwJnPU6uAq5mA1Tfv06ADgKDbIiqai0KHb1PQl0rU78/RVAPJg2HyxoVsgfDDFd82koR4ImxnMORndWyuKFO9puHH9yKivjcrE/qpLGO4sdBqQwYJtwX1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747705; c=relaxed/simple;
	bh=7e69S+AMpYt+2560h9s7Q1qknBhYuowqC1Vy27vo7Ws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=II9KIPXemIcSNaxhwoPrYVppeml5BIt3Kx7LX1KliR+nEXWUTEMzYmwjAAVxtpPH7LiC07emx8m9VnYrkHtzrsbmjDwcNyHtzabhMCjbR8YSiTAsECe9o9gZxs5atiPUsOdHMCnq0HGRi6jxeMZU/tJGMow4v1TsnQRwle1Vlv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jv2RLXSs; arc=fail smtp.client-ip=40.93.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jv2RLXSs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2MJwVa/pZYSP2oFkgGylb06QMqVD7JENsmhOCj3SUA4KVRUL3sX/KJa3YUV1WQiYr+EwZonmm5giGyfQLfKS9YWeV9pyZRk3bOgPAWarLku7vieeu8qJk1Fv3G6LqSKSsn+FOYrcZNSBg+Px3Q1/eiWDcT70ROXK9ZNLQ0iBXOx7xWTd/CcM98bqJtXD0mkhMlwX//kmmQeHrblbsSa+CqNoIB7nWy1Cr84k/GFomesr4yUboYIySsoD9N6u3Nb8MExXZmJ76mrfIjNxbMzFt7pnvEUaL2m7ucWWB1aq+Y0ZVpFHbE6o3pn8EBYKEBM2nZ220o5f7DSPRK5tVoReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WrJYWTck1PP/BcndWeTSXyBWvyfyteZocr9EmH75eQ=;
 b=qPCSnFOHQ63MsfQnOrJ5lyg1Xn9X1jWlrEd72IsMIWCc/OjG0Jex4fdfYgXSZ1RGksXD0kdXysqQmHrMI4Ra7kog3f3zdxAm5yKqwiq/bFmS47k+k/D4WbjPkZGCypVfl8zuxcYkKz24p7gXOK46JozkmoHR4+uRVi5r4lJXPMNgNaP6WD45fwcHI0U2weBf9sFfNZhTMz6snZpaAUUOaVx4DW4t2aMNDi+8o+rMNbUAjp5MEt5nc4QQx4Tl3q2R0GON9JOQgA7fqZAhu9cK6mMXs2rNfgTzN9P8uNkXprbHYT8EW1DhXxEPFnfUMVtTCyYHi2eh9KjiTt7np7eYAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WrJYWTck1PP/BcndWeTSXyBWvyfyteZocr9EmH75eQ=;
 b=Jv2RLXSsr304znZd8k9BUIT4iFAJ2uudJdn7Ax40Tuc9KyPUHvcZSese7YIXUAwKanH0TYyAqmCHsPnr6LtOkMpVw+25/CGoJ3piA81wcNi8dODWP8bNy9bl2sCnTrmHdhTN0YrsDt8cZjAkYi4E8mlPVfxEKxl3lKprEte2QfY=
Received: from BN0PR08CA0016.namprd08.prod.outlook.com (2603:10b6:408:142::35)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:41:38 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:142:cafe::10) by BN0PR08CA0016.outlook.office365.com
 (2603:10b6:408:142::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:41:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Mon, 29 Jun 2026 15:41:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:41:33 -0500
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 08:36:30 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 08/22] iommu/amd: Introduce Reset vMMIO Command
Date: Mon, 29 Jun 2026 15:35:21 +0000
Message-ID: <20260629153535.15775-9-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: d9cf510e-be7d-4dcd-6390-08ded5f4e8d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|23010399003|1800799024|82310400026|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	0DZ475ZYZgh6Itna/XqHt9xJYX31qOyHRexuhgrWaJLng4f4Taf7zlni2+UbbQw0E5Hp/QtJW+JRSCQr3W7dhQGubGzcyifR4dJEdBUNMbdYY6zmomDVF/nkSVk9EfZOstJcDO9adf5LAPYlJGDwgYDo6hFz/iGSDcz8Ro2kn0zTk8meHzs+7A1FnWMoKBF0+pb5iuEpMmLVthgOIlYuW/vo96daG4VPXAR31E1Bd7LmTjpqvJGtMoafXg3Ti7CU8mM6u9hsv7jVrlAWPJcPgvSN6+8wPAADv+wfZIz/+k6e57X1wEFaUqTqEHMBTI3YJL36/yO2SVeaGjoFtWm+kns0YTAchbVCb43xOXsLftnihq1dbvpJmsXVD/CjSEf4RbK+d9LLOpsXQebtZM9K9eDWtSrL/S7o1H0TtaQWl2xpux5hhr+9SAQk7WAxBhh5OJEy4B5s9lViAJkbfXwQIl5qrfwvtatNzna2kEWzWfS510X4ecfo411dN+KiHFCKE3hRaLclhQ/TYcRYHZbxgBtejzxwz4oVrDbpFzSAnaEJDsZvPcwh7DXOh65dwe2yeB6FUKjcq3BTnxJHguqCu6gczbs5Q4v/ERW9pDeqS9t6qoThQUoZFIGSpW4knhe99PN9FPwqCe3HXng0fiNZNWBTClLfnSZYannaevRgaSqIu63g3eaN/Y0P/y5qcLDQca7oyt3r3H3MW8wd8vtDeA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(23010399003)(1800799024)(82310400026)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HGptFcoOUYDLbCSkkxvuh22xgEaOA3eBAxCHF4Ti1b9JDhQbVq5jLDhYAtbvhGouHOzSrINTLdJqDMYeGpaElNl511qhjA1i+7SX0BfpGdhQp/WPjXe0SqhSJTiBXHDgCBr4UokCXPqyYXgwAuldracg8rM5wsG9JgXaPVi2GA+8ULQcei+/KQldCZ8E9q1bUTjnVW/AVI8oXqUrTIz1MPZ4N6NzxL+ChOzuO1IeEcNAnM3t6Nru4lwZvjCd9Ru3bEr9s0eV9cf99A4DITaa3rHDSTxn5Ae5GLpDvLytr+50n8fIQfrhxFQg5w2iuwssKcr2ytIHyOainUnIEY7Lb+pOSA+KZnT/w86VKKsCEOYSNeNRf02HQK+DLF205Q35ag0cD9dNz9xqUpsnfssN8KBgSGk9g0m9lAOuMGQbN3D3Eo5lTV6zhZBYzEje7Q+t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:41:38.7597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9cf510e-be7d-4dcd-6390-08ded5f4e8d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090

Introduce new IOMMU commands for vIOMMU to reset
virtualized MMIO registers of a particular guest.

Reviewed-by: Weinan Liu <wnliu@google.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 22 ++++++++++++++++++++++
 drivers/iommu/amd/iommufd.c         |  3 +++
 4 files changed, 27 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 044bc9a634a1..2ce207529ea0 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -11,6 +11,7 @@
 
 #include "amd_iommu_types.h"
 
+void iommu_reset_vmmio(struct amd_iommu *iommu, u16 gid);
 extern int amd_iommu_evtlog_size;
 extern int amd_iommu_pprlog_size;
 
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index cc7049bbfa14..44fa1d6c64d6 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -218,6 +218,7 @@
 #define CMD_INV_IRT		0x05
 #define CMD_COMPLETE_PPR	0x07
 #define CMD_INV_ALL		0x08
+#define CMD_RESET_VMMIO		0x0A
 
 #define CMD_COMPL_WAIT_STORE_MASK	0x01
 #define CMD_COMPL_WAIT_INT_MASK		0x02
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 73fba8be40d1..6f5ecc48f4ad 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1428,6 +1428,18 @@ static void build_inv_irt(struct iommu_cmd *cmd, u16 devid)
 	CMD_SET_TYPE(cmd, CMD_INV_IRT);
 }
 
+static void build_reset_vmmio(struct iommu_cmd *cmd, u16 gid,
+			      bool vcmd, bool all)
+{
+	memset(cmd, 0, sizeof(*cmd));
+	cmd->data[0] = gid;
+	if (all)
+		cmd->data[0] |= (1 << 28);
+	if (vcmd)
+		cmd->data[0] |= (1 << 31);
+	CMD_SET_TYPE(cmd, CMD_RESET_VMMIO);
+}
+
 /*
  * Writes the command to the IOMMUs command buffer and informs the
  * hardware about the new command.
@@ -1668,6 +1680,16 @@ void amd_iommu_flush_all_caches(struct amd_iommu *iommu)
 	}
 }
 
+void iommu_reset_vmmio(struct amd_iommu *iommu, u16 gid)
+{
+	struct iommu_cmd cmd;
+
+	build_reset_vmmio(&cmd, gid, 1, 1);
+
+	iommu_queue_command(iommu, &cmd);
+	amd_iommu_completion_wait(iommu);
+}
+
 /*
  * Command send function for flushing on-device TLB
  */
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 9f76bfa1d6ea..81e0244348a2 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -80,6 +80,9 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 
 	data.out_vfmmio_mmap_offset = aviommu->vfmmio_mmap_offset;
 
+	/* Reset vIOMMU MMIOs to initialize the vIOMMU */
+	iommu_reset_vmmio(iommu, aviommu->gid);
+
 	ret = iommu_copy_struct_to_user(user_data, &data,
 					IOMMU_VIOMMU_TYPE_AMD,
 					out_vfmmio_mmap_offset);
-- 
2.34.1

