Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAEF30F92E
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945527; cv=fail; b=Nr6+Gmb1kZffy2wgIe0JhklKv3LpXMGKfdOhhnIiVPsbmmv7ZnluCvikJPxUWovEhX/wooZvIiVHnaMFZ28Ye1GW5EGiIRoj/U3KWePVdhT6LV8T7wu0BGbP65Wnnj99blo5xJ86vVNaARymuAgWdupHvU+j5DztOygs6GPZN8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945527; c=relaxed/simple;
	bh=Iu7xykQ7JWnHJ0W8K/LRh5dvL8Wy1SsJonrspCqEcTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kRiA+T0aSKfmTUEYomNH0IkYP6i+usnkGvxbGn6ww8Hne3vVoXKkH1uApLQGydpsSTJCijat9QCGXpRJM1dBp8bUftsy/V0+0gUXqIaqe/GFtgd1n2YfzfZDapQ1QDLmOTpRy/2sSi7nNHWa3iGQ4PL1Q7Lc/FRbXihEqplKOj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Me1TyGC4; arc=fail smtp.client-ip=52.101.61.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Me1TyGC4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/Dm+K+dlUP2P9aRkYqkyv4qFKDarNrkxLvV4HSUWsx3ayOgJGUzd0jCL2CknyQYdNdvO9NpxX1KIqzH89QTtsoSIYecHgdaVHRuNmKTl//kEa3gJhxE/Sx2KtdVuX+vKVmUD8oUTAPfhkvEiyzi91aQiyLyeJ7E0Gm72nUutxNlgg35fcYRMRhtFV84PJkP8lAKq9l9p4ZIWGlDKKpd+wzVMllnnTbUN8LYypKOS8Qj4S5et9A8R8oSxPIO68jDwZ5Ln25fbcjf4n1hgT30/eBjsUBCWwVJIGZtXsttpLM0gT4Tf63B1DkewfzWki/l5FB8mxLBLCKQO9VHon19vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LE+IAbsRSTYFbvCJ1lxiH4CWMjOTQS2v1uAwAIY05cA=;
 b=xy6wzd6NLYD98DbrVI/hHDEKtbI05xTc7mONExTc9ZFOmsIgQ/BC80DlRJzuY7uLbq9+OwJO+WLmgT8iF3XHvM6sUr4V0M/Xbva+ln0DCbVplJw4byR3dd/gSA5t/DLYnlgOj/0mHjwA3egPDg9z/8P1bjhlmDgWyszbNGNP6QwPN00cJkNRm+Bd5bxN99LxSQuQGn6AuyyHkxx2dpiTtc3brlBOhefCkgMljn5jYLT7ECsIVkVad4kP8ztbNZ/uhuwPprcJqIaz68j5QydFLTf+9LWP0qgqAdtU70+sJrwYif/EYJZ3vBKUkWK/BuB4MmbLCjYQqEuANANVV+NfwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LE+IAbsRSTYFbvCJ1lxiH4CWMjOTQS2v1uAwAIY05cA=;
 b=Me1TyGC4KfjZSm+o4dlU/g44d3xJdTFahp5BuBeR7Qtogmh1OvwP+GNl07g1jo+96/GVy88x9BaWLnvnpMW+YHK0CajuH096iaxMvET/c0cxW8UpxAoOyCemaa7zbVITsjlEmXhTBNlbWyXP5hKzq3BCTL2Wy/Oa7pnJhtys8Qc=
Received: from SN6PR05CA0001.namprd05.prod.outlook.com (2603:10b6:805:de::14)
 by SA1PR12MB999107.namprd12.prod.outlook.com (2603:10b6:806:4a2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 05:18:42 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::3e) by SN6PR05CA0001.outlook.office365.com
 (2603:10b6:805:de::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.4 via Frontend Transport; Thu, 28
 May 2026 05:18:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:18:41 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:18:36 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 08/26] iommu/amd: Introduce Reset vMMIO Command
Date: Thu, 28 May 2026 05:17:20 +0000
Message-ID: <20260528051738.596013-9-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|SA1PR12MB999107:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f43fec-4703-4c35-159e-08debc78953e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|22082099003|3023799007|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	3C3ITdZmCiIh7szXxS6EsQju2aPwxQrwqVnUDroZxX9m13IftvPBJ6shTAWeWDK5sMQHMPDbalmLTZwnjHO0S5CheLrNa84wa1MGRPtu6+Z482kpl6Sy+aW7V8PuFGv3WN31hM7GAmyFFMwtFDqa7jB10qpKXmSiDrkWyk2SmQYr2HrbAzrOPATZ9iSvGb+ZvAoMmneBpPzmQlmyzQxVwYDEfZSlCW9NN1kTWodPuGkX0tFXOiTPh+0/KWIjNQW82Az1ZUkrMaYMmuTd1L5Mw6Errtt/OCmbZM9TY6QUSvdBmfh9X4HbyLl+Y8UwK6SlSuntTIkgveo9ectd0+jsCgJ+Gx27p9OKQD9SuKG1C3neKmNtPbZLPYUDmffwDciclT7XiQzTiDWF3g24Vv6ommIWOkLfY3lN/i46EYYql7AeM0FB4ihZWUEw/lLuSsFfveWr/REQKpIwtf/+GW44Rr4wlx0CZD3yJrTk48+Wj3A6uKGvqAw3VZLNuJKlTo7hEf/QQXqIWAR/Hgw/M7Wp7a6FBhcrl7se+E2AYzAl6aeLfnya7kZDuznFpgjWPewe7ug1W2GVWAUIKVSxkpSVbflbOFBT5KUadNUr7kME8lsqEESh/n4EaoZcJ7P1xXmbJ6pwJfrXHfBv5BRGpYhifSVwPeI3Mg6b6n6nFIJk3R5uCqH3o6ZYc9p7bsdPj7pxRLFkedDGOwfMUzTxm6SnSmyNXVBn5cKvNzdMHMoBjho=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(22082099003)(3023799007)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Pm+izBQifFhFLoDw0ZY0JkfLBqw6EySFDefWgSvkAv3NewoQVxxozq11WYHMoccnZ1VBt0bytDo1WTd8U6rf8FbLoNI0fHanWgU916N6Eg1phMRW8+aJQLkV2xYXhrg4Kx4v/qQANIsVrm+y6edo4rZH+KcukE5a/dVt8DYK1gBc5t5GfVo0NMguyyB1rLmc0Fgi1SZv5an0G/EqV1yjGNBRUZNoMRbtiCLjwLUWV/Gpex4P9z1krQ8UpPocxOBs0ImozprQa01GDfM0fFw7rOB4tZIaqFKTOyjLFafKQSh2bsBN4bGLhH+dZt9yLfguutceXqN6KOe67hX8ouxFkDYugdM+0LtqQmrMIta/9Al/eWy3cHHVci4yQTT6CEAOgspH9ZSUBqGi9LeJZNgI6YULoFnlBIUJghwd637tr+qSZYhI/nc5uZAPhcm60m0P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:18:41.8530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f43fec-4703-4c35-159e-08debc78953e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999107

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
index 34524c1309c3..42307ae71b24 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -80,6 +80,9 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 
 	aviommu->vfmmio_mmap_offset = data.out_vfmmio_mmap_offset;
 
+	/* Reset vIOMMU MMIOs to initialize the vIOMMU */
+	iommu_reset_vmmio(iommu, aviommu->gid);
+
 	ret = iommu_copy_struct_to_user(user_data, &data,
 					IOMMU_VIOMMU_TYPE_AMD,
 					reserved);
-- 
2.34.1

