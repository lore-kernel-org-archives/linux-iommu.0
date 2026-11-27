Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795773894;
	b=5SW6HCgFkMMDJ+vAX/Pn2rBGbBGTuITfALmRBtN8TQSTshNy3uBO9X795h8Kia8ktRjL
	 tPhUx5PuNfusIlFpiaxikHIdNKk/uUw0uWaoJP45d3QL5DTrf7+Sm2NkX09DMolUWjGqI
	 A8O5G/vmudCupzcjfJ8k54RXZP0drPtG10KssOuQLZILxu0LapHRXLANNvhlWZc1pnXby
	 Aqw4rHbycgIopSXlkvlJhVB1fh1ZSNojdE1mQCD33vZ27t70/En0o3/4SR3vEJ+3PI4Qv
	 q6HvB2vPvyzLz/A2gNAq3pScn6GVYRIJBXUrzwrDvXP5B2Se8OKFJVwdQShMFOdogxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795773894;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=KXRFfIMUdEzv2NRtYBFXxOsBMx+uqGMgX7dsK6Qaswk=;
	b=ZAGoTaynh28thTlIh7PMELpdpk/Oc2pANiyOcYxSrRyiKF39R898sy48Qk/yNmxbKjsR
	 6NBAxt5HZqEfwfCOyJPRhqGY939O5e+KW7/F5KBqEONIva9DE4pkxSe47RdOOvSxZSkYf
	 T+10rewdNylYUEW2cw0rcP+HWK1OkOzzH8podIHNmorFrH79dUas/3NiWl87oYEIhbbwg
	 883stlWx7hCm5kZhqFeVr7uUhumeyGHpjlFleWpfhPqLKjheRQ3IYfWi0+Nl+jexEBo1M
	 pcZfUVVEGexV54HGjS3CFzr2QbdOi1Z0hDnxn/epqICWmh2oHITylVDKLWQahs+uAIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="ii+1/icJ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.2
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010002.outbound.protection.outlook.com [52.101.193.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970E5606A31C
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 10:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 970E5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ii+1/icJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+LZF01ZmPedITmIWiRxXmR7oqKtNbxRx3jNrUmfd/76VbdjA0MRN8M9tVkccG2MJCU9xZcq8XlD9Jn349f4eogmfQj3d5k2L36vVCsBiyph/5idoJMpMw9N2GKFkBn9uQdhDrxcH+ueKLByoAkN4vp+InQKO5atbzQKq9GYNcPgTKkpXdWRBZ+yOMXL7jZAPR0lP4a2HdBINi5j7cq8vgdDv06xTVhQCITs2I1KIZvkyH+8n6LXEaKMxjy8Tk6ziuYxU6dBcqFRThTGCaYiIfsbczVmHufLIi7/9GG5Qp8+/I3N60nnuE2O0tK1B5y0mdc7Am7Gw+MwBhxqy266TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXRFfIMUdEzv2NRtYBFXxOsBMx+uqGMgX7dsK6Qaswk=;
 b=rpRmTydihYXAFSXL5epA9/kOydx/MIcasXcHRG0sqZkgjNdBMLKQU40151Rt6vSZu9cuqxv/lPCwKBXK26qOoNvzYL0iN6GHKnNZ3WpkcFeUr3i7HRWFR+7Fk+LoTZi34o7ODpa1AnMBFYDoS4Ef607oP5h2VknNeMPFFvt61eB5UxgA1HNvJUwVeR5KLOrIH0qX7qQVIzwSM6lYW6hr3T2WyAB8lBYOZvOR/LPHrMSxf4FaeTssrI9q04xgQBcVszZskbDl77uy0GKxBB0g9fvTMwrYwYVTmyMvsZFadqynB/9dFZvpRSOHfgumFLgr6BTMUaIuIx/IHsPIDpcqgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXRFfIMUdEzv2NRtYBFXxOsBMx+uqGMgX7dsK6Qaswk=;
 b=ii+1/icJZ9SGk3ZdIn14e3xWPG5V/CrCpHAIArBsWg27eOX4wwKuRnoVwXf1gHpQ+KbFuV9e0oSDj/i/uM6rEayZ8+QoG3ouETEWzvwdhRdCpixSoPkxUtjX3vUXy+qfh3XCYVzN5O6oSSkNvvuEoUpEZsCtNXdIoAaS2F2mN2c=
Received: from BL1PR13CA0173.namprd13.prod.outlook.com (2603:10b6:208:2bd::28)
 by IA0PR12MB8227.namprd12.prod.outlook.com (2603:10b6:208:406::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 10:04:48 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:2bd:cafe::64) by BL1PR13CA0173.outlook.office365.com
 (2603:10b6:208:2bd::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.6 via Frontend Transport; Fri, 27
 Nov 2026 10:04:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.0 via Frontend Transport; Fri, 27 Nov 2026 10:04:46 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 04:04:43 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Adrian Huang
	<ahuang12@lenovo.com>, Joerg Roedel <jroedel@suse.de>, Robin Murphy
	<robin.murphy@arm.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, <iommu@lists.linux.dev>
CC: <Vasant.Hegde@amd.com>, <Suravee.Suthikulpanit@amd.com>, Sairaj Kodilkar
	<sarunkod@amd.com>
Subject: [PATCH v5 0/3] iommu/amd: IVMD handling cleanup and ivmd= boot override
Date: Fri, 27 Nov 2026 15:34:11 +0530
Message-ID: <20261127100414.6980-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|IA0PR12MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f88d30-fef1-4e10-bc05-08df4c6dddd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|10067099003|56012099006|11063799006|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261009221227099003|261028144727099003|261026121527099003|261026140227099003|261102123227099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	oZNVUbdcMgvfM7rs1xdyH9ICSdFwoD+xpJ/qqjhiGeu7QfcdAR6jkFMI1tWGUvuhuLNvvhffntZv16HrxN8BTKLHqwEcklsCg3bzdVKDliQF9M7onSlfswJXyvTZD1ksvKRl/ImR8R8o9qIlE5Q4Q+0nXvyxyKMiDXMTr7vfROAqg+ijTosBOqci0Rim1Yu6aPkqik4FVdDgMEZzxlOEHTseiK5mHOOrJe+aBQdFEQZ9uKKxfXTZcRAnbw/QGgVLL3B5oLJ3UkgJkVpx4AM5jKeCZoU3i9ViXOLc/DVslxZg+OqxrJHiZ6N5aEn+ZE/9AnoJQYWborxvuYOijti/AafMRnR9FTwrsQ8fUMJvr/ifk/rKYPg7k/torD3dT67r92vI49rC6MYSRi3csWARM3pYFOPGzF40Do6G5r0afKdiKP6Td5vB6/4KPZYzgeNlokg7GK/IJelUnNJLuds1dcO5itoaLkXG+Qq9FFZF75a+yaYOjILa4rMigmALRqDDWmuf6d2WtwQK3g2nhpCbNb0tuKH4ll3GDZA6ruOmadfkNEtemQQzJR+GubkbhMVbsC2fMmKWO+358TpgyZ5GpwVtRWTuzKq6/m1QFKwzJaGlU3tvvWar1gcIeYjw725cRd9KbgsCyOu+aEipiSFNeA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261009221227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261102123227099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	g9GNKu+OT1RefN6QFlBv0bHI7GgRSnOU2chCd8z19M6SEjG6naeWt3GtZRMt+88hmOygBvKVeYcoLQdCCpe+EBLqIxo/aNHP3qI7nKnb69a7hQG0RNwxbxoIbEFpuAzixApw6Saris/46Q9A5YLvl4N3Al520QYKsc2dgFCWDWMK+rBN8SM4Ic4URU2Yv5D6CehEfdxC1sECtOY82Ct17E9Ibo2CsH6pklO1SXqTzk1AZMhjUzWneQl5zoHojfGKTDcSWrQzhQd4zvekK1trWHSrq4zHeQq9/N44x/GsBgVgpbjRfcH3yO+DFjYmU7fVl0363XmfbkmR/3A1JmWecg/KCK2dzPLAYsDIv3i+NPnzVA/nLjLfXSdr9YRI1OUf2dWodB9kb9PNX6sNJ5XP6NkyWVVd/wgzbkbticP9ib9vG8fbu71PxpNeUhk9iIdM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 10:04:46.6655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f88d30-fef1-4e10-bc05-08df4c6dddd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8227

This series refreshes how the AMD IOMMU driver models IVRS IVMD entries
after the hardware exclusion range registers were repurposed.

The first patch renames the associated MMIO offsets to reflect completion-wait
store base/limit.

The second patch drops the workaround that forced IVMD exclusion ranges to
r/w unity mappings; the driver no longer programs exclusion range
registers, so that the workaround is obsolete.

The third patch renames the unity-map symbols to ivmd-entry
structures to ivmd_entry. 

Changes from v4:
https://lore.kernel.org/all/20261117070654.3699-1-sarunkod@amd.com/
* Patch 1: Rectify commit message [Vasant]

* Patch 2: Ignore IW,IR and Unity when exclusion range is set. [Vasant]
	   Add comment explaining why exclusion range is marked as reserved. [Vasant]
	   Move unknown flag check to init_unity_map_range(). [Vasant]

* Patch 3: Keep dev_err instead of using pr_err.

Changes from v3:
https://lore.kernel.org/all/20261106041650.24076-1-sarunkod@amd.com/

* Patch 2: rectify the flag checks and move it under init_unity_map_range(). [Akshay]

* Patch 3: Rename ivmd_entry_map to ivmd_entry_to. [Akshay]

Changes from v2:
https://lore.kernel.org/all/20260424092213.16976-1-suravee.suthikulpanit@amd.com/#t

*Patch 2: Report an IVMD exclusion range as IOMMU_RESV_RESERVED in this
	  patch, instead of leaving that for patch 3. This patch stops
	  forcing the exclusion to read/write unity, the range has no read
	  or write permission. iommu_map() rejects that, so a tree checked
	  out at patch 2 does not boot. Reserving the range in the same
	  patch keeps the series bisectable.

* Patch 4: Drop this patch, ivmd= command line does not have any real use and
	   complicates driver.


Change from v1:
(https://lore.kernel.org/linux-iommu/20260420170033.6780-1-suravee.suthikulpanit@amd.com/)

* Rebase on top of patch "[PATCH] iommu/amd: Remove dead code for exclusion ranges in IVMD"
  that was submitted by Yu Zhang <zhangyu1@linux.microsoft.com>.
  (https://lore.kernel.org/all/20260331152550.479841-1-zhangyu1@linux.microsoft.com/)

* Patch 1: Modified to only rename the marco.

* Patch 3: Reintroduce logic to parse IVMD exclusion flag to allow
  reserve region of type IOMMU_RESV_RESERVED.

* Patch 4: 
  - Update the sscan function to scan start, length, flags in hex format only.
  - Fix apply_ivmd_cmdline_entries() to not free the cmd, which points to
    the early_ivmd_cmdline_map[]  on failure path.


Sairaj Kodilkar (1):
  iommu/amd: Rename unity_map symbols to ivmd_entry

Suravee Suthikulpanit (2):
  iommu/amd: Rename exclusion range base and limit macros
  iommu/amd: Do not convert IVMD exclusion range to unity range

 drivers/iommu/amd/amd_iommu_types.h | 28 +++++------
 drivers/iommu/amd/init.c            | 72 +++++++++++++++--------------
 drivers/iommu/amd/iommu.c           | 30 ++++++++++--
 3 files changed, 78 insertions(+), 52 deletions(-)

Base: 4dce97c6c265544342e716e62fd24bbb232590c5
-- 
2.34.1

