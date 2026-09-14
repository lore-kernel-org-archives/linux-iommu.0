Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E4A37F309
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411757; cv=fail; b=Twibpa62KSgyuECS8wNjzIYsS3sQ2FsrTid8Yyrhp22+vvilusyZWViFNC1W2WSPBNgFF+JpajGzCjCUY30bE36T1LXmJ4A/ZS90j+n9kuwd2/v/r3wvQv4MG5kjyfv+IWBG44AYnctTvl8URJSaOAEvrz2tn5tMhAAN8DKjG2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411757; c=relaxed/simple;
	bh=xGc/pmy15scfcGeTjUe85lSl4crWCKCra382F8eE16U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3x+nvZPGKMBfNngHrbdKH305HRrHf5FdqBv8UKeIQBP15vSTRVKX/rjeRatpm6otVQYTq/zenRn2rwxo3GhJQSRM46ZzQpW8Pc+J2H1XdVGeKXMFszhN6fe3lZSDHPRx7/D7UK+6vjA/JllSiYJ8YHpGSvbsuNjGJjeXGYtzvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xfP9s2ob; arc=fail smtp.client-ip=52.101.62.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xfP9s2ob"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzOtbeJwRYNdHAl097CtquX6QNv6tLp1MNLL+A5ZhDI7oarGaUU0NqkL4EL1thwiucGBHriZ9v202vVJNCm/WaeV0nXkVJJoqyIgl7UmATtMuG0WLfvgdajmRGr7egAj5UaEMV4OiJlxv91VEWBNJVx3s8J5HCf6pEvbFdXorTLDiN5pXM9vcjI8IBGTYrQQb1vYt0lJqQAaAg0ccKSO18UBAAt7NVgxHTeci/Nyn5MsneaDVWCwbHKhIPMbw0xN/NSHNjX5M/royOq6NuNfoDuveV14HYg81a4iu8kxTUto4nasYu+tBAlrne0JZ4b7fWBLKSXrjFxjBeSpRQdOug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LOt+HRyAlkQG8XL5+GFqVKis4E170MKrppumF39okc=;
 b=tWXikzNW6cfr/zVSR1A8X+eXSW0pJgbeg7VwmA3nY9Ido0wMZdb/UN/g8QF9cGXccQbL/wPFNdExYtpWpAgmht0MzA3FPaqo3YoTq5zXfUJkCh64ToTgO9rl3QEfv1v/uS8Tmzb/a3vU/wNdKv/YKtw/IJ80tpgxjvR0h/yq9yGt7SSjvrKnubQwg6PzgzWdrnY4kcGpN9tjoe7gEn/2aVqJqfUXYI1Ztwm8gFPICAgefUiwKd5WVndQfDUsmIfVdcc32dpYmIpR1XR6wpmIn06tpxj1UMkgMBuWljQqiBhWKDAcpjOYatF+Zr9vrZfWDz6KinYqZvqkJNhV/Nu1Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LOt+HRyAlkQG8XL5+GFqVKis4E170MKrppumF39okc=;
 b=xfP9s2ob4TKLAyaXU0Zmdss4+XpXRc76JOBmeOOBwcnWz3ybGO9ZZi22iEdbbc/xGoZQdfg3/iTMY0NjNXTubXRZEnntLvsouvBfM7fye0LLNYQCVpsC9mrGk7soxI3Dj2W6wUYArRvIr7dFL6MZykNigO+md6Qkw0ILhiHyLSE=
Received: from BLAPR03CA0128.namprd03.prod.outlook.com (2603:10b6:208:32e::13)
 by SN7PR12MB7809.namprd12.prod.outlook.com (2603:10b6:806:34e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:49:05 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::12) by BLAPR03CA0128.outlook.office365.com
 (2603:10b6:208:32e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 18:49:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 18:49:05 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 13:48:58 -0500
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
Subject: [PATCH v5 08/24] iommu/amd: Introduce Reset vMMIO Command
Date: Mon, 14 Sep 2026 18:47:34 +0000
Message-ID: <20260914184750.222939-9-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SN7PR12MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: 08286678-56d7-4487-9c62-08df1290da04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|7416014|10067099003|3023799007|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	7bnuyFOZ2wLf9fnp5S9Ju7y0Qbu1Wr8J6FueVMiqAfJ87iuuPCyuEtWuctCD9kn4+ZbBE7bcPIS4OlNpCOB6dzbnGX9bgWZWVaeLsuxtWau70OG80kwz1Rlpqh/y6hIl996nMc2TR00a+P8S01RNu4mfGIVLLmU1lmFo5fUfIfdgFnQ1ZJAR2NM8Hf5uFrrQjUuQrXBynE/BlCCU2AmXuZ3jC+tm8aZW26j/cOREvZV0sAnOFu+KP36ndOlrwBGke68DSEDVQya2akfGDlCo+8PyA1gcWD9J8gK1H/ezg3kGrE3g6FJRtC7X4VJNdZBFaIa8xZUZfBvFuiGw/ams7mmXlSNULcLyi8+czCPkTnfJwHtnjvhEcRsOpT6LEPiAFWyCeGCp/BoRCPyj9upnZChFpfpCExj7vtpdzJ7Q/r+0Mo8Aw+vkrBgbwghWjjeeYPFrwfXx+q2WkzSfIkW45m71H8RLEd2x0+C1z20If0QCQL594WqVSoUFtkMHf6N3joCjs69B580DIdSB4ER9ShoEPg7YNJKtlYDaR/CrqUM3BaaMKBKmhknW3dIw4he3KfCunsUWTYx+GIBCax//aQ8Fyo6ekyqQNfamsn22FoUm+aC2GTIt2VN7HhqUlcQhQhJey+AoDkI+S4i0ML2iOEpuCmVhqV4lz9ttDJCeI67nH0Qo9CvWPoz09MmLM5Tq3V+sbgvpizyBgP+OOJYpnA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(7416014)(10067099003)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W4kBT23Dt9d/1SeUoliWuNa0VOQMmrePLWGgZQ23SVThijz2aPBaj22nPw1mo17yqP7k20o60Pi3Mn6rgFjyys6s8cEm9uxaK99v46Dh9CqPUbTNTn/lL22en5PtYockBSqaAHF9OFwtvcYYyjJzZmDyab+XIuam4YoqZja/NyTexCKW+CeyHJpUs3O/OZc9wzCDbC15Z83eLv+oVdIMEivgZYuBedYwOUZSjCHXYnsUN3cMFZ47R5gNHhJFqpNwl0S/b7ehhJTR6q/66AiPtY2mvsnEWq8Trc0S572FcA8JKNjg79q3YLk4vwLtcSU4j/bskxtomGyhxDFav9/ZcEk9rIT6KwFOOjwO30wOrJGOKWogonJYH6RIKNH5CA6B+6ofd0/YpoSH4G1Y9BNVi1h1hwEyre0zHa93bjwwbfFIPIWfIcW3ndH5otXo0sNs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:49:05.1854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08286678-56d7-4487-9c62-08df1290da04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7809

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
index fa9708af258e..94c59f503662 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1517,6 +1517,13 @@ static void build_inv_irt(struct iommu_cmd *cmd, u16 devid)
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
@@ -1770,6 +1777,20 @@ void amd_iommu_flush_all_caches(struct amd_iommu *iommu)
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

