Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011035.outbound.protection.outlook.com [40.93.194.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB64718E9
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760301; cv=fail; b=NVWqW9u4PVFtt9NCl4bj4EFg0bFZMbP3doUGfBaAXKtK9HzJZYu+OdJOIE/Ab7XiU3p+e3sxjHfofYwk9RhXyd/+JNJg8sckKfzSoOq3h0m+qhHzGiQXxiRbVTrrdOtuq8klniejWk3gZzQjJ4wC/Y7aAudsWXGtGKalcP7NZKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760301; c=relaxed/simple;
	bh=0gELASiqvThuakt8gMZdQt5NVjluCXnd0SUFKO2p16A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WDdunp1nrUeatJOj6aBWtaBW+DgUqTDZ6OxDisuUveGp9Ll4i0ZAdSf5RKV5EwjukLe/TuWFoAhm98aKw56t3U6smW1fj/LJmIuCwG9i6RR3r/3W9otJ///qYIL99VXMtboLnwr5pqbSuW5MN+iXHzdcfmZcIQQgDvUhXNAV2z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AUiuIQbe; arc=fail smtp.client-ip=40.93.194.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AUiuIQbe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqHycHTwoVLJw1AL7UZtriW1w7JeMoFTNGT1efOhFdfMqc9HZpCgZ+GBkxT4vl/5WnwadUP3lZT/xi7jceJhCAqSae3qIZYtLluP9U2pA+UueC0OTr0KB16JUVkuMg6dVerZxNLAIX8RX80Jt91S3Gf/TuvM8ZovKpO8ah9M0Aquai2sPKRBUeLHaTAFW7ZTLjszKZhZEPLYMxmPyTMKgMOY4GH/HvyXr3MbMoCRWWt+tYzGmROWuYjgaL/FujqSTtLKjDUeoEuulpjtCoqqu9zszjajCLngVLlvh0y1qRJ0E5cKhKZdX+0pVaKcX9tl3UCkXr2cDJZv/0UqvjlTbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ze/KvWUm8Tv5LGCUNZwxCpojlRJ9WhKVATa3hlbgSCM=;
 b=NA4DJFPOalr55vuAgJCHsMh/8vfR3mIZL6e3NV5ZbvvaaZAVzrVuWg53R8s/lwX2R16t5kfjDMt0lcWsBsvPVsKHrY3Pjhp2ApZxKdi6uNANAeAEwG10GCZgzXyup3bs9EahlrttFSTHdzMbX7d1+JKthwHeDHzJFuVDUc4SXLLnfW1BLq7LetbABSQ0NPZCt3UIDvGtY2tOzPmiKPDAQ1LOWdjo5motvH09b9BF6dLTCDs2VQcdgV/kKoxbmp1iQ7Qbz+yw85NFIQpZ+EGZH3CukWsIZWTWdxdlW0GhiXItzlfFit96gCFHnmvhSuAR8U+O+GQc7r/WaVTDwTvIKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ze/KvWUm8Tv5LGCUNZwxCpojlRJ9WhKVATa3hlbgSCM=;
 b=AUiuIQbezop+mwh+wLLdRTjzjoxu8Y/0wxBpDbCKEoRDjJvma7n2uDGqJ67H8kP0xBOXWCjOsuV0SY5FiNWL0Xc5SvC/MCZVkv+AX5jURRgiQMoEV4doST6JyQfMAMAVheE8MPVUUzVWCpz+k3wknG6Ctg3x7ifyybmlM+wfCVU=
Received: from PH8PR20CA0003.namprd20.prod.outlook.com (2603:10b6:510:23c::16)
 by LV1PR12MB999330.namprd12.prod.outlook.com (2603:10b6:408:3f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 09:24:54 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::5e) by PH8PR20CA0003.outlook.office365.com
 (2603:10b6:510:23c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 09:24:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:24:54 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:24:47 -0500
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
Subject: [PATCH v6 08/24] iommu/amd: Introduce Reset vMMIO Command
Date: Wed, 30 Sep 2026 09:23:28 +0000
Message-ID: <20260930092344.5616-9-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|LV1PR12MB999330:EE_
X-MS-Office365-Filtering-Correlation-Id: 593b0017-5df7-42e3-3dab-08df1ed4afde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|7416014|376014|1800799024|10067099003|11063799006|3023799007|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	MrGRe45jWuTNyypyguXuo4Ty18dKSQulf1Kl/O1CbGXOvGWgGmCbZ6NalWCYuE8ZSIDLCYqhCgQfB0aM60xjENb4V9WNRBjudqyAfMXoHVXk0AvBOGapxtmcYUI0olNV0IBxhJ6tmyoY4dGupAHl01Kf7L2BMXxbI4z5lXt2pm6PeV73XE0LR6DZDEBhpOE9DMmKWQ3FHA+XDnYLNgTID0ni1TUbk8guxFPHtjl8y1Ubhp5TNtbdaypqA2oEJg4PJCEPD0FqGk0LmGDtjgWNSap3dO0D/FPzBLZArPHU/hNvllBoDZyxA3Yd1MGRCYecIFIhYJkec3NbtGKhmz4tmCtvSaI/7ZUibUzLdYl3SLUHpomc9uJJ9E0WUNdP/SSBtm3NEQezkxp8h89rdGyUTAO5hJnOdBtLD0tIdu1Sxw/cX4+USyWuCpUtElTMB4g+UJN7B7issrwYCHZRY8BSlkw4XU8XcDe01Ti9UHpvnhyWtgYDwy8Y6pmc4Qnnku4j4VOJjI50ao9VOvwseCR5DrpCgignj9Sr5OtxhbkqThcTL9EaqXk6BAldPpTqAAHDImShotECTP2YSJ3Ybel5BUdYxhEZGRVLxDB55rsIrD39FPpi1ufHvNpaQeneifc9uBRQp6kerYq6+CfoyzATuFzCFUDS5Feen5I136MAU3TUp3uuKDijBXtALfPSPRokZISXKdDhTQxvi6iLcr6Gmw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(7416014)(376014)(1800799024)(10067099003)(11063799006)(3023799007)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lOpcnkyc+qG/zRaOKBDLsHH/WB6kNwB6eZsr4/DRvY5zONScLgyJwNcC7IcjIi4ZcdVri/snicmB9+9Jd9jbofFcp8jtlaqJTwYd33HY4suxN811CqJ0XDLV7b9b8vE1NiaQuKVSE42xYN/o5MSlp6vTn1gc5f51tbPX5aBObmDRGq/K2RK7catg+OrXl3wleUq/1+ZwNT7auPZVR7kGZY8yashbkNVFToBlFLAFO49IYlTn5rpFCIjRn7+GmKZUbqmUA3xeXH9Jnl6deaX/yKQox52lwJGmbZ+9jkDejcmDB8kT1nwrM4WKu2sMs8NAmqRc2OFFFQ39Tfmq6nS+Prb55RgWC3sYioXwAd2va7XPABlQRSoz5Ik41VFQF4tWZ3QGP/mt/IF3KoTuMDsTu+Rl1/7WhpzdOzNULSDrjbqc/j9NYavSZFq619BPaWAA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:24:54.1782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 593b0017-5df7-42e3-3dab-08df1ed4afde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999330

Introduce new IOMMU commands for vIOMMU to reset
virtualized MMIO registers of a particular guest.

Always program RESET_MMIO_ALL_FLAG and RESET_MMIO_VCMD_FLAG.
Propagate iommu_completion_wait() errors to the caller.

Reviewed-by: Weinan Liu <wnliu@google.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h |  3 +++
 drivers/iommu/amd/iommu.c           | 21 +++++++++++++++++++++
 drivers/iommu/amd/iommufd.c         |  5 +++++
 4 files changed, 30 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 51e4364e8564..8c298e090889 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -233,4 +233,5 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 /* Guest ID for vIOMMU */
 int amd_iommu_gid_alloc(struct amd_iommu *iommu);
 void amd_iommu_gid_free(struct amd_iommu *iommu, int gid);
+int amd_iommu_reset_vmmio(struct amd_iommu *iommu, u16 gid);
 #endif /* AMD_IOMMU_H */
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 3aaaf69a1e7d..9eb9a0c190de 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -209,6 +209,9 @@
 #define CMD_INV_IRT		0x05
 #define CMD_COMPLETE_PPR	0x07
 #define CMD_INV_ALL		0x08
+#define CMD_RESET_VMMIO		0x0A
+#define RESET_MMIO_ALL_FLAG	BIT(28)
+#define RESET_MMIO_VCMD_FLAG	BIT(31)
 
 #define CMD_COMPL_WAIT_STORE_MASK	0x01
 #define CMD_COMPL_WAIT_INT_MASK		0x02
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d3378754cf87..ae44050fe86a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1524,6 +1524,13 @@ static void build_inv_irt(struct iommu_cmd *cmd, u16 devid)
 	CMD_SET_TYPE(cmd, CMD_INV_IRT);
 }
 
+static void build_reset_vmmio(struct iommu_cmd *cmd, u16 gid)
+{
+	memset(cmd, 0, sizeof(*cmd));
+	cmd->data[0] = gid | RESET_MMIO_ALL_FLAG | RESET_MMIO_VCMD_FLAG;
+	CMD_SET_TYPE(cmd, CMD_RESET_VMMIO);
+}
+
 /*
  * Writes the command to the IOMMUs command buffer and informs the
  * hardware about the new command.
@@ -1777,6 +1784,20 @@ void amd_iommu_flush_all_caches(struct amd_iommu *iommu)
 	}
 }
 
+int amd_iommu_reset_vmmio(struct amd_iommu *iommu, u16 gid)
+{
+	int ret;
+	struct iommu_cmd cmd;
+
+	build_reset_vmmio(&cmd, gid);
+
+	ret = iommu_queue_command(iommu, &cmd);
+	if (ret)
+		return ret;
+
+	return iommu_completion_wait(iommu);
+}
+
 /*
  * Command send function for flushing on-device TLB
  */
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 7f358e57efde..2e34491e3cf7 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -92,6 +92,11 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 
 	data.out_vfmmio_mmap_offset = aviommu->vfmmio_mmap_offset;
 
+	/* Reset vIOMMU MMIOs to initialize the vIOMMU */
+	ret = amd_iommu_reset_vmmio(iommu, aviommu->gid);
+	if (ret)
+		goto err_init;
+
 	ret = iommu_copy_struct_to_user(user_data, &data,
 					IOMMU_VIOMMU_TYPE_AMD,
 					out_vfmmio_mmap_offset);
-- 
2.34.1

