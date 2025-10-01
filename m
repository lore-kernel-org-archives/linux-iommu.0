Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011010.outbound.protection.outlook.com [40.93.194.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47E32D877F
	for <iommu@lists.linux.dev>; Wed,  1 Oct 2025 06:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299066; cv=fail; b=p3yFar1eczNaZofEjGp+ZUxljjd0e1zM8fPxX+mTGvScEyhiCs5w3BRceLpVn+l5TJ9fD5PcONWQdPK1qAYa7FpZnROzlphSkz+ohu5EOFkkFBpPHpF7fWHk4zIp0gx1QNyY82AkUYik+ILB4DAlC8rIoZZfxZUgZRMfSKcHSYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299066; c=relaxed/simple;
	bh=UXu207MFy3hT+h3VCB9gzBzQQwKHX159fiBtV04a7L8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NbSWQcv3YjAlPkC5SEqoRlnFwwuae1wB5WPoDDkLhSrj7UecbWen5DiOmPXo8ARs4Sh6lBLWx6Z/TFbuePXlfAdKM3k5LhfGMC+u44vGDwxarwtX43uYt4sGGgPWx6rZJ8SstnVejvrKFvdfWsNcvIDf9dsYHRCmPTAIjkVXFMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xGHR7/fL; arc=fail smtp.client-ip=40.93.194.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xGHR7/fL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnqWeSlOkt0aA1B2rcPnWgGbCWaeESAwRjgjyAr8h77jTyRl6V34huOS07f2QJFJ41tsoJdUD8VdKcpSX71I8wYvetj0qn0VWz4Yqljh2C5RxmWUwpqyHXho9YaVS8StinK3oRAJbRPAGOdReJXblVGez4UDetGdK1VlyR7KyQcMpEIPjjJ+hhv7/+NAK6AO1G8uIPD/m2ghANRDBfF9Zlpfjc+Vl0r9s1swe+kQkm2MV7v52pzKlLQOI23DIvFdu0u5DbnGw/O/K3hegrbiS+AzFNmJOoBXGkb9hvC72TvesnH2GVH1S1p1etM9dhOfamckkg9SJfEGgfg53E0UQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppxFeFPQFZ2xI9QATvtroKAV7qjeJbELVxqcppCnV+Y=;
 b=M+1noyXaF4EHqlWpg0HxVnL2ErLoaVGlhjZ91v8lm5RRiN0aM8+J9Tm09o80fIU0mqv+9gUZ3I/eHrdSQ+/4IsMSUlO9xS5KwUptVGxT95zuE4sdvBEPOmBZurGcGCDoz9zjTQUk7G3dIvZAU9FakGJzoaS7FgdnJziuNTVfmbZGZIxdSvH6fBuxfDri0kFQpVqJHPUHsnkfvJiich3XyvgimBTiylhfP1RrIjsF2KuYiS1K48w3zJZhaeG9GVCFAhILk/9e9V/LOcvvdT30sgt2NMTLRczwQqVGJo7nGMTtnz5shHpEVQs8k1SDoJs8l2LDP1eTA5RaemfzrRrGrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppxFeFPQFZ2xI9QATvtroKAV7qjeJbELVxqcppCnV+Y=;
 b=xGHR7/fL/6EOMA3Tx3BZ0C+/3zWZPmD8GizLD9zOXSL0Dtq5dGSCAAdG/dDAbR2KwHWkFXVzfFCEKsbDs04rPaw1QLq224IfMefaiZWjuFYaiL47Zwf/ujp35i1GftWk6JE3dGxMalRiV0lFjwD4CDa1Gkx9+53FZrchTHWi/LU=
Received: from SN7PR04CA0065.namprd04.prod.outlook.com (2603:10b6:806:121::10)
 by LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 06:11:00 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::e) by SN7PR04CA0065.outlook.office365.com
 (2603:10b6:806:121::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Wed,
 1 Oct 2025 06:10:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 1 Oct 2025 06:10:59 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 23:10:53 -0700
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
Subject: [PATCH v2 08/12] iommufd: Introduce data struct for AMD nested domain allocation
Date: Wed, 1 Oct 2025 06:09:50 +0000
Message-ID: <20251001060954.5030-9-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c3ee97-530a-4586-296a-08de00b14acb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sIpaaeYoJ/Z/nMFVkVqbvziGwHaUq65g/TjOCiQC8toa8JNR5LICR0K/1mcL?=
 =?us-ascii?Q?Qx/SswGLJCFYeVGJ7bv7tXjHZagFSzv8fvZVpm5vIrwRBKA3ezuY90Strr1v?=
 =?us-ascii?Q?zeryE8GUgJXx6UiTykoNAgiFQ3lyoRYGCbC918PAYyH48E/yLK9i05eepAOH?=
 =?us-ascii?Q?Ggg8PSVaEKbdHdylqEGn0LDtO9pNm3TzUAcR/FqSBUHu5cU33OmtTj4iBat7?=
 =?us-ascii?Q?AzuiO99bsv8N3k+4yCySiQCoe2n1MTMgekK7sntIxT49dLjrHDdTErgysefG?=
 =?us-ascii?Q?vDFdeYJL7gTdRp9JsoZyqPEkRG+kcvSm69PzOsJ0m/leI5QpJBSLrX1nE6au?=
 =?us-ascii?Q?mBZ4gpJyJUAEDW8td5j2HhUOLzORb9WO96zR4EebSedUb8oiPDmGLpj0Pc5K?=
 =?us-ascii?Q?yQ+xvu+ZTgzstD+e9ngKjVea8xtW/+ow4iqc+Na1puflnf6gVN1ugDuznOAm?=
 =?us-ascii?Q?nv9J8vI+l/fGokeooVoQ/vJbeGbz0WXvTITHnyXbKkSDjJkYde3rA7t0wSHm?=
 =?us-ascii?Q?Z/sf+hpa+DB8FXt+on0h7fF+rrJbw51J2Z+63X1cC9I8hb0n9Sh6R1q4bKL7?=
 =?us-ascii?Q?ZU7Kkqc7FAiX76z7BlUlrsyIrsojhg7juDVE8He3C4Pf2Smp9e2wbCFbbKmw?=
 =?us-ascii?Q?gJ92ZEM4b09ztTk696KX03VZr7XPVKgQC/zaDtVMmN3hAMlU/3kLVl8lcM3Z?=
 =?us-ascii?Q?CfJgh8pk+dBYhFtsHUaAs4aVg8rDECoIsmodnkUx+QuKOwy8DpusveOX0p3E?=
 =?us-ascii?Q?tupeM18m1i5ySg+xssScKdoELh/TJcPtA4dvbxiE1+CbFJznTfCHLhbaiOp/?=
 =?us-ascii?Q?Xf3ZsVCSvK53qEOcDL8htsjwFCjzXnb10GV6tm3V6sjlURFtGlEQ6KE8Ar02?=
 =?us-ascii?Q?IhySrwyAC//6BBwcqvAyVgciy8jNHsjFWhLK+zfrT+DIyb5JZc5pkoFnBKi5?=
 =?us-ascii?Q?T45eQfi5nYLGhSbpLnTIiOUKvSuTYYD6dAE/+vm+9yQ5k4IpP8n6Xw9F8VQf?=
 =?us-ascii?Q?JaOhrIUoqx13rRAHJB8yt2FQFpdX9RnJlVEd04qysplrPSDBP+iGH2J4UX+O?=
 =?us-ascii?Q?y1T9MsHgic9D4M7cgizvn9oJMgV2swgKhxwPKrLSa5Exk3solKv3TGVWWPCM?=
 =?us-ascii?Q?7rrQb/p2dqEDZcVaxm8699UaJTxAV3DgIc50byCQCh+WB3Xj+u7byMHdzwFu?=
 =?us-ascii?Q?owoSCKCT9bcBRvnydy0TrS+S7hMEaroXz7vLjbjouDUUqlE5bLQ2u1DeAEUd?=
 =?us-ascii?Q?ORzf4WVMwyvJSO+XKfpdClpr7dSFzHVwGQrEasFG0Ed3o74agNVK6xBzHfSX?=
 =?us-ascii?Q?W7ttL4wCjwbNf4oJTjjbLz3cqqDXE37jXcl6hu6HPytsKuaO/NousvTnYmlu?=
 =?us-ascii?Q?ZDWXD19QtkunFSdJd/qg1nSWBFvEgKO4bDy9rzPX/ZFcmV2p0TOVhg3wmuNm?=
 =?us-ascii?Q?G/Yywk2VdaWPt8xlqaRoqfMxuOh6dvAaio3qDH+NJe6Be5R95dYoejZxUFOZ?=
 =?us-ascii?Q?RmNeHnyd5kl14nofZJ2xJP381A+ZgHt6m1zQg7yAmXth6SHYWLUIUpmeMQjG?=
 =?us-ascii?Q?lEmUmM1M+fXxDjkJOJQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 06:10:59.6528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c3ee97-530a-4586-296a-08de00b14acb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232

Introduce IOMMU_HWPT_DATA_AMD_GUEST data type for IOMMU guest page table,
which is used for stage-1 in nested translation. The data structure
contains information necessary for setting up the AMD HW-vIOMMU support.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 include/uapi/linux/iommufd.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index efb52709c0a2..79d4ba43cd5f 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -455,16 +455,27 @@ struct iommu_hwpt_arm_smmuv3 {
 	__aligned_le64 ste[2];
 };
 
+/**
+ * struct iommu_hwpt_amd_guest - AMD IOMMU specific user-managed
+ *                               guest I/O page table data
+ * @dte: Guest Device Table Entry (DTE)
+ */
+struct iommu_hwpt_amd_guest {
+	__aligned_u64 dte[4];
+};
+
 /**
  * enum iommu_hwpt_data_type - IOMMU HWPT Data Type
  * @IOMMU_HWPT_DATA_NONE: no data
  * @IOMMU_HWPT_DATA_VTD_S1: Intel VT-d stage-1 page table
  * @IOMMU_HWPT_DATA_ARM_SMMUV3: ARM SMMUv3 Context Descriptor Table
+ * @IOMMU_HWPT_DATA_AMD_GUEST: AMD IOMMU guest page table
  */
 enum iommu_hwpt_data_type {
 	IOMMU_HWPT_DATA_NONE = 0,
 	IOMMU_HWPT_DATA_VTD_S1 = 1,
 	IOMMU_HWPT_DATA_ARM_SMMUV3 = 2,
+	IOMMU_HWPT_DATA_AMD_GUEST = 3,
 };
 
 /**
-- 
2.34.1

