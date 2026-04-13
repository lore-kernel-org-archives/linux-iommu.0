Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A193E3E022F
	for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091542; cv=fail; b=MwfRKe/OorBmdMNAdzSRkiMXlZ4J9e/teh+eICIHdMN2nsCMi1CpMoBHBkgW8DBczuMjO20UZ2kRji1Wk9dDMMh0HZ9Uc8z5QFUuERyED0CijohMFMzW2sTtpRSZIgv+ZY5QOPdY/BMfq9Gb9GF0fiYu71PKO1N+RlFSU+Hueec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091542; c=relaxed/simple;
	bh=dNfIJMybI1hQCbhDtXKE8iIsIHj0EV5C6qN4PfT+bUw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O+uNe2AZTiEWYnB9BZzBPGoa0hSw3jp+VKVLPWBkaGJV/UBs2DNxB//k+OGiuRb6sdI70I4PtSPMcyY+LbLbhij9qZmDLhwyTM/pg2rE2nPTsjxThVhxcX2GbI+9EOlnm93c91v2YjORxhnoJeP2e+/bj+9To1fVIvAR36/qfDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t2v5raro; arc=fail smtp.client-ip=52.101.85.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t2v5raro"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gALtX4rlkYreJt/PRyiFgH51EWp5RHU/pZUxYOd/T6naZgQBdZuNfsQr2SeganSH1C76wxZ/yik+fVMKoss/+bDtOfJUNCO29dugEylUUSRsUFgWp2aWZCrm77vX/JYWM1mtErUUsbAqQIr+N9wzV6NSrbhWNiE2J4Ok4rMobJ8CHUCKtZ2nVHlEh1Uaj5laNl7yG81tU3vkLFZrD9JSR0WWEQSk4l/QHH3ZxnpQ0tcGx9YYQunVee+/ypOu144zOD8r2MQUndmujg7fd9V5e2W66h2Meh4JVjS1C9BqV+1+kSXT+gEn/e1OPOJvHDzoHv32/b+mAGTMU/9GcrRS4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIZAJ/Zx2kqWZlz6ayMO44c4HU+1X+3RpqruIm7Y8s0=;
 b=xEYCVJpChbO/L28QtcRn1QMtZO+6nOkd8Njis1dRRWgc9EEBCaQYJK6UEI0qiM8QNxLc0A1O/cpWoJ9mqgScG9wxsTUvB2red6TEKPeEQrsrkJ8xL1Cviev9YSTwB/ax8On8Z9i9EtcnSH1c71IeR2yrSaa6H9w2yJXnx/2X+6o/RhUnmFht9QYKk3PeNp25zykTlzUYGrA/Tq4Pf/pi2A26WBtE//mkUeW+sOj/JRIseHWtVECMMfLkhxtEVE/ayH4ODMkX7g3VvMsl5w66iUtrcmxiriKQQpzsKEK0H6FnIi/miXp9rUJBzHfLqR8VfOCyhw0StEXRPahu+vErAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIZAJ/Zx2kqWZlz6ayMO44c4HU+1X+3RpqruIm7Y8s0=;
 b=t2v5raroQyX1rL4envXoZkA/CfNVTbpXw1LWOdcCHDkx2xSq8H/0jLyp1WZG1dfIcZ4JggsLIQOkLWg5KiacsYnMh1CDwWZDrKrD+oIgyLRDyDRYUuSK2b3j9pPKF4AMcOsq5dWtVjc4LvA3hWHKP9Ci1S3QX76Xt+UC72znvFw=
Received: from CH0PR04CA0066.namprd04.prod.outlook.com (2603:10b6:610:74::11)
 by DS0PR12MB7875.namprd12.prod.outlook.com (2603:10b6:8:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 14:45:36 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:74:cafe::ae) by CH0PR04CA0066.outlook.office365.com
 (2603:10b6:610:74::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 14:45:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.0 via Frontend Transport; Mon, 13 Apr 2026 14:45:36 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 09:45:31 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>, <jgg@ziepe.ca>
Subject: [PATCH v5 0/4] Respect VASIZE for address limits
Date: Mon, 13 Apr 2026 14:45:17 +0000
Message-ID: <cover.1776075533.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|DS0PR12MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: d7f2fb4c-8f86-428f-4f43-08de996b52ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HcnileEZSCbKGNdI0i2hdhn6SSLPUSE+NR9PXA2w61+GmJsooxWwQ6Bvf4M/KD9xWEguoGhw4esSOFp+o+Z+o7sryIhlLdrskSMACFsds0mkAlxZn8RAPa+nrhyUaa1nrSFh/kTilWD0sluBEX75Tn/Eht7JsgoRmT824zMbB3hZgb9msP6TfxaZyCdWhQqsmRmcl6IKd9irsIn87B7Tz8htsbgshjSuVXBPWZoM/48FSDBQcUcMz5G6BRhg/DjpmNRgkzHuUJ+ByEsD+Z86T220+uoIUTQfJgFlXZI4PzDUKJcUtlBVIV69pNDBHr9u5mJsOdeyWpMStm4m2rkqPyUsrs/nblVjIJdOYdsX/uGkDf5ACclJcdOmlL6NaTAAns5vM0mxXbNyuREsloXO6bul3c+69V+4hOdz4g3P/L4T1KAXHXBCAVu9Woztoeafeew1qdjRd6GBs/Vma4x32isZxrsPUxfvKGJqUZGO9o6ylGHvrVYWj5zlOEJ35ENuGHmtMpzx1yhzKu6sjixIZVLwEtIS0zvVNbnXsHGGyehII+mvaBmpDjQ8V+lzKRbxBP9PrkjN9ySVg5xy/6zsMT0kHH/uCOCQDKC5q7YJAl6cLiSTqKLpXgRh2nY9bDuRu7COPDVMSz7JVYBwE+fe6uZzTqGIm6FVkV5sdNBiHC253wOMBaWvJf0BkVXT6eDCrVvYkKplaAm+Z0vgM4SObrqX/CjDPgcwkR9cmZx1bCFOC8HrOPzL3BYwRI4DqINpzpmR/jQGSEc8wuUYdE6WkQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lfwdbLsArUbtV1cYfWMr3HvLuukNUiSL3CzYWfRnCXV0KKhAv0k+HS/Y3f0XUKDUP7SiNuess3oyhgCUzjE7b4OA4YqgOCnbYi3lVYBvbztRSZhsktuIudqq2Hm5hAqzojNq3Rjo0vFs3TsYRP14XDSDH3K5G4GPk14ssFa1XtEmeJ+eCZ8fM/+EZBYGVlq+dOjxqV/EDVdcyEPCx8cqFGdQI1Fn15bRbcUFK7N9AllMibBnfHLnZRAvVAB1Dfs8W7bmmlBQ60YE0NEUAuXN6iFlq1wi2H36TZ30c0R5YBARTXBHgLf5oaO6Yims/lz0K758ogQ+FWb0VgrioxhQFK4COcev9RB+YVgaAcFCOruDwYFzIEMxjy55hMhR+jDoLIEPdEuiOJ796wn4Y+TMX6iCa+EQHAN2Oy5DlGsSjen8qKzah73SOsy2ATr7qlp3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 14:45:36.2198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f2fb4c-8f86-428f-4f43-08de996b52ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7875

The AMD IOMMU driver was only using EFR[HATS] to derive the VA size,
ignoring the IVINFO[VASIZE] limit. This could create domains that
exceed the bounds advertised by hypervisor. With this series, driver
respects IVINFO[VASIZE] when determining the addressable VA range.

For a small VA size, domain initialization in the generic page table
framework can fail with -EOPNOTSUPP. This happens because the page table
clears the dynamic top feature from the force enabled feature set, as no
page table growth is needed beyond the current level.
This series also fixes this issue and adds KUnit test coverage for the
32-bit VA configuration.

Changes:
v5: - Added Jason's suggestion for modifying get_info().
v4: - Remove PT_FEAT_DYNAMIC_TOP check from pt_init_common().
    - Add test coverage in amdv1 for 32bit va size.
v3: - Remove specific value checking for vasize.
    - Add patch for PT_FORCE_ENABLED_FEATURES.
v2: - Mark ivinfo_vasize_bits() as __init.

Ankit Soni (4):
  iommu_pt: Fix pgsize_bitmap calculation in get_info for smaller vasz's
  iommu_pt: support small VA for AMDv1
  iommu_pt: add kunit config for 32-bit VA (amdv1_cfg_1)
  iommu/amd: Adhere to IVINFO[VASIZE] for address limits

 drivers/iommu/amd/amd_iommu.h               |  2 +-
 drivers/iommu/amd/amd_iommu_types.h         |  1 +
 drivers/iommu/amd/init.c                    | 13 +++++++++----
 drivers/iommu/amd/iommu.c                   |  3 +--
 drivers/iommu/generic_pt/fmt/amdv1.h        |  1 +
 drivers/iommu/generic_pt/iommu_pt.h         | 12 ++++++------
 drivers/iommu/generic_pt/kunit_generic_pt.h | 10 +++++++---
 drivers/iommu/generic_pt/kunit_iommu_pt.h   |  5 +++--
 8 files changed, 29 insertions(+), 18 deletions(-)

-- 
2.43.0

