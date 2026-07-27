Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E41E417BF5
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159065; cv=fail; b=WfLeChywWbcso6Jf2S58HFcOwzcJigw+8GA6LUSQifh0IMV20Gob5kv6EuXUvYveCnExK8pmOjINVrmSFOY3YmRrqdwl1xYOo3CqnFl8h1rTRF1kVlfOofL3ssMgbwETA9lpg7NjAkXWvQ/T/o+KnShXNhcR890d09uQRPglFQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159065; c=relaxed/simple;
	bh=7e69S+AMpYt+2560h9s7Q1qknBhYuowqC1Vy27vo7Ws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kocbF+VzzKGwEaQgXAJ8faeShmAYCkYxYK+sOHj/l+IwFl0ZXZ9qCOCjBUXfOBNYe2AP3m+t52pKmVcyxLYHzJQ+oUYbUoeATab5vzQjXPaiYMuNdG7Mpn1v83Et099uDjwY2lPTnOAVuBJ8KGykB08pJeHmT70ptJ86bvpivdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AII7KoO2; arc=fail smtp.client-ip=52.101.43.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AII7KoO2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EviqYbv4jPy02RiNIvcZvzamwP4QIwYpWQwpOUxl6PYE+CNBsaUnk4ecVXGTvS8MN8Qk6YV8uaA3DBCIQfUH6QQLrE4065vxJ5nKQtFaC1cme9LGyBJ4dtgUT1vH84+KL0hEW18wezxBiuRvtkrvbYL+eSzXr/4f8f98BzSgH479TIXK/d4WPwvxugmCmVQYNA+iU/hevPnZ5AUq8T8p+h+TWArf0PGtda4thR1dK4yW/VWbSnypoE8dh/45SFnH0F/vQkbbOXV+vHTxPlJO0S8jWNDmnRCklHVbZgB8WLv/4qSKWuQ6vLBbMnF0D7zYP+Xo/ckY59G4+yL8Db3Mvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WrJYWTck1PP/BcndWeTSXyBWvyfyteZocr9EmH75eQ=;
 b=lczYec1vsQUCqV9/XC8Ktu8kdZv7ixomtCGIhgzg+lgS/04QTMZ9NqL4CZTW3nYXW4FOh4PpCuxcuDMnE82E8TLH2LcJ0YrZb8HocKGHPc0IhFdzG1OMohG67dVj97+0i6jr137VzUA4MadnzYnnaupBcUhvV7u2P4eeAGlZjIgpoZOoEXi/QDVPPhHROj/tv9oYVzCO3/mMbILXhuXbLCkUbxqCRGCCQLAwut+Xt9GAsS3zsCxuuczShdIyMbYvuof+p88lKvKRiAdvJi+kTR2pmBhjkvCFnojq8Nj6sHBoCAmqgqBqubbccj1ox8UTXNW8pBfJvllKbcAtz52xMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WrJYWTck1PP/BcndWeTSXyBWvyfyteZocr9EmH75eQ=;
 b=AII7KoO2iRieGbkz0S20+Obw1PhSaXsFB4paOPZhbpiB2ZVJ+AyH+dfZM9WP5WlfoiestBVJmP7iMlyH3rd7RF82LUlIUwoeHeAEOoNyQGnXsZnnfU1+RH4XdANOvbsHYzwB+GafxEvKpXgacKjmvK8VlKav6U4yJIIzbWAKSXk=
Received: from SA1P222CA0184.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::29)
 by SA1PR12MB6847.namprd12.prod.outlook.com (2603:10b6:806:25e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:30:52 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::5c) by SA1P222CA0184.outlook.office365.com
 (2603:10b6:806:3c4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:30:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 13:30:52 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 08:30:43 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH 08/24] iommu/amd: Introduce Reset vMMIO Command
Date: Mon, 27 Jul 2026 13:28:57 +0000
Message-ID: <20260727132913.22475-9-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SA1PR12MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: ee0a8c84-c668-4746-2b38-08deebe347b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|82310400026|1800799024|36860700016|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	P670lUNBlH5hV55Znrv6hOafV2CHY71/nwRgcMi/Sfq/5C6mJ1vi3REisUzOgEhJcoDFVdU5f0HdNPnIE1uqmFzW+XKND/gexp3oOLuucRJMDlOfaKRCJkVIQV5CXlv5buZ2zEhN9t658I5Xq9Juh2D/haSLn3NZ3wIbjK9/ZbvffIA8RQ1xpKweZx+E4ji4q3OLxUZv6nhUNgriTumWOkgAGVMoMiy2r0XfYFAeqPw4D37vWfuXi44ALGuS9wctr4jNSK1U8jFKF3OoewpNz3az7s4MOL4sIN0sktlvih2IGfjYCzGoRZKK7teIlumpDGFIxsM5qWBNM5GHYbj0rIJcLoJ/YqBcmIE3tYJ3UFDzOhbmte5Z4K8Z12B3qFGWSLikHaY0dbL6dAti94gsKem3mCLZG1wktajY3KScxXp7MDbBTBugpoUH/UurDe3V99MJx8ME/SAtouHuZRvBeiRU15cnFySLlJc+MEUkzk/ERP6wjTjuHIhj+cQ9+3qN/Ke9dIqc2jziowMO0DI+TNLTmQDn2uwYqgctCXTPfof+c+eM4PmZMGd+vfaBCRCznpTf26flpxFqyAT7LEuUKoU5SXHg//Nhoz5YSyZ0im5IIz0/juIOLCDiSOuJyPG/uVSO0Nt47QX1qB31a9v43KpjmoklrT6rfh2zirW1VVWYeHzEaaA6xfmIBbu0/LtXIGrZchTcgDOKHkt3Ivwz0w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(82310400026)(1800799024)(36860700016)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZA8apYmU//t7bItIgTRokF3Vmik0nbCcibL6p/O9JB0+L7wS1n4h/DPEpX7+DpPhrbXV95k0kEhEt6CU/N+5nGG5cYxYwcB2s92yzKQoKbgiZwXe/GVgYT7P7pB/WqTlqcCEcDP2FZ51WH5nFQSNwzDCTayGMbtoufANwzyadLb3GEI4VFOCSm15yu+qfWoefE5b0n5LvSwrKfBQjGaXw5VGtoFLEmkk1q1ShyiIFaqBPxpolXHpYa/66SeND5JKFyPBYZbbSp/au6Ugrw9ZtvXz3zwxixSqOIVnmwJIS9QjbFRxYyTiLGKxCfeTuQjZVGSr3AjzTVPHDJZHr6JRIkwCHXEef+fOsc8sPSu60PMJ2e4lpMGGRMCkYUmnau/28ztdsp82UJpLxV5brtgKNtA1esYbt0vDdE8DvjT9UMW1fFY40rfpAu3elOcdXU/9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:30:52.5426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0a8c84-c668-4746-2b38-08deebe347b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6847

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

