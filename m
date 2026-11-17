Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794899242;
	b=sBZEhIuWdzIdqJIqsOQwqprDrsOH8B/5TxFCDZvgA7usoYED9/j5jvDg1v7bKMEdAdY/
	 t/BkLC2nDQF0T8pD43Uz0Ypj1XixRyNgT1+UT7EfYoVBSUh5MZbXC4890xjVpPFA9MeKu
	 J6yyHcPPYQUMU2N9p5s2ihDpOahexCeTu+caaeVEmSI/YcYm5tGXmkYGk912Jz3uyiHUl
	 1mk7joTe9+JuWDyEO5nrf5AdI2Czyc2PE0nYMEu1neJo3ciKkc5dh86cqBHCEndRzUSTS
	 0m1+6vQEZ+GbhaiVD4rVHEgE3bcCK8zDzAdPHfIlFLA6YPVobt6qTx7RXA0q+Z4RzQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794899242;
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
	bh=24F6tuFMiPcOFy76Y/yFbwHuDW8u65Y2paniWuWNiwA=;
	b=Oqa8OgaxRpj7P0nrpEDP+w34A4o1LVpDjh4sqURaQ5fuInwleWtSSeFYFWz0ySKIFmz8
	 z4oXhBW4Pk9Ma5k49CzB/P0KnUM8/jTHi53a5upm1LgCQtwUOKZHir8UNHhji/R47uQiI
	 qsem0jzdX11C0WDRLLepEM/vRWrf9oSSgx9W1najLqFXEX19tAfxbNbmUlRD4SnGgcH/0
	 4Gv1SXR6g7Rl+zJeieBKP1g/7Yw2UfnCLQZpe8SpdLxmr6JhxPrigjhXWMX3dq5Zsbx6H
	 0p3b2hjBZ+BawhtOJWq1bikByZYUB3XGJdRSE2oF3T2xF/lu0qaUNq1p4xTzU+laNyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="mV/hVOun";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.2
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012002.outbound.protection.outlook.com [40.107.200.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA270606A329
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 07:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA270606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mV/hVOun
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snFrZZmDC8fBWQYDb9susjX20Ow23ZAm7m84BMOAQDPSgDmvawzJRmXiR7YsBB5ClYNaDWuebre/4U7/0uMEpR0prY56/w7QY4/jFOPeyQ9neHjYx2EbSA1F+Nr4VRY+fkVxR07brc1By6eI6r5KktI4LnX+Rda1vpxkK3OKtckKlbn2nMU7Ir2nj2Evf3oGDPrM3AU3YytZ/QQ/nt97eYeHswaUe5b+X9Hnm95YF/5eRUeAWXugEGqZdw+6kyWQ2IFyXAG5XnXZQVJSvRhSsk3q6R34PV2j0jRbr4qP+GUaGFJkUmLDHp/8hguxnQPVdFlbq3DueCEwQGh25lMghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24F6tuFMiPcOFy76Y/yFbwHuDW8u65Y2paniWuWNiwA=;
 b=Z8htYcR/OSEkvMkBYF7F0+Bb3gnAlyv/OJMov5VBMvbe78srN43/2EWFunueKnw+pnDNdCIl2qeMFa0fWooGXg3/oEirUbSJzdgjs/BoOSMmVpTrazQ4jP4IfOsRXc7pKb1Svf8uWp2QVvSM+d1nxOAgZInBcocPtUFHkfez4N2d91tSbk5XLcMoa4lFQ4SLcTANNTWmnOzgU7fpt/Ujf792Gps8hl36FPiKCQNX6uPTlkJG+ZfOFgB3Te27iLbKz2Rfg1mec9u2iRU1V8rRHoseIcz14h2MqRdEIjXD38ATa+41vLFFTGSd5UmrJWAY+/ONNfMYK9C9lgTfwXjBBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24F6tuFMiPcOFy76Y/yFbwHuDW8u65Y2paniWuWNiwA=;
 b=mV/hVOunZpbqSN0IcfgnQjlYnZHxM5DnIJbWywMtIYNOSeCpdH9B0/keqQCB0yo7LLLZpx9MH6rnQha09AZXkbqKk+SptGN+PG3iXq+fejXLxi30mVnBbBEG4XwE+SbzDjLzxKVYbNno4BVXz0kklbgW7KNBRW7tqDS4nLib99g=
Received: from BN9PR03CA0568.namprd03.prod.outlook.com (2603:10b6:408:138::33)
 by IA1PR12MB6556.namprd12.prod.outlook.com (2603:10b6:208:3a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 07:07:14 +0000
Received: from BL6PEPF0006C3DF.namprd02.prod.outlook.com
 (2603:10b6:408:138:cafe::a8) by BN9PR03CA0568.outlook.office365.com
 (2603:10b6:408:138::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Tue,
 17 Nov 2026 07:07:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0006C3DF.mail.protection.outlook.com (10.167.249.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 07:07:14 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 01:07:10 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Adrian Huang
	<ahuang12@lenovo.com>, Joerg Roedel <jroedel@suse.de>, Robin Murphy
	<robin.murphy@arm.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH v4 0/3] iommu/amd: IVMD handling cleanup and ivmd= boot override
Date: Tue, 17 Nov 2026 12:36:51 +0530
Message-ID: <20261117070654.3699-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3DF:EE_|IA1PR12MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: aee74a87-9a45-41e3-e6bf-08df4479687b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|56012099006|11063799006|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261021123027099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|261009221227099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	N1/RbtoQ7zlnB9oz1gme7V00Y5+5NJTtz4rWR/WH765qCv3973GFx0nhY5wCbJXE5E4c1XuqxCy41v3s6Ubv/OphamtYK5QWOy9BbozIl0SLTv4jBskXpLcy8nLEyBC1uC1vnuctwqdtd9lJpnmZibOq0zh/CoYiBwFp7P+FkYzrxfKthrDUhIwJBP8m2bmaZyLkqslSwLGFurfekiYZkoHHnZ/h32urZOxOnZR+p36yl5GKHy5/Y5GAQb1YvxP6jiIjMnYuCFXSWTd5upYK5zvyBDumLvpJ9qsTN3+2T7PbrAuxFXd5/NgZgt0L+6DO8H1jfSOFCsyWCwj7X3mEVvDhrlEo8V4cc2qdd0pj7QslHnuitEUx9d0milJ+TOZe7rreR+bkVLCV+Hd3sMqlGLrubgpf1Dr1ePWVBYZdALvsbmjFvRbZFQcbfZ9IBb7D2QH5POnujxOOeufNAOyj/ZpGhTCQopOULcE8jmZqeZlEih2roOwkKQdFAgc14GKOjZOwARh9MF1lZgjhIXGewxM4ZWZqDdxqO0LmvzTglJZRnev/5IVO4wzh3iHgCgmmjcquy4vyL2vTb+KFoQyD0wlF7QexIITt/mkgrRVgkjndeJxFuq4Bf+J15S0kEtt32ZQgtm4OEjtncxWDgLU9kA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(261009221227099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L5RS77RKtv2GNymmcxCtQsImKehspESSse6ZLznasBA4k6nDHFdUCTrINGsSqkpsHwGihKMAs1Lh23vqAET3VEJnj+VDvQgedD3giTzQKi/BjbGhCGskCPzcbPSdMewhAjR01eZ69ivIjKOYgHhRFGDDGfS2yHKA8inqYGzvEWPy2I+GC1czW9pk1dWVkK+1VMDptVD+Hzfuw7+5QN5gYJET22eNWUm76jQKOySKqnvnvsq/7mGTMau4m3nH7gga8h8AdgFS0QtC4mqRyiJn2Muc8X/HOgV+H3qsmYDYGyhSvSUlLgjQkH3IZfUNI+AfnzbXRa6EpvaRYu2ntyMpjdA6ihjNESIzJsSSIf4BnhPSn19LkXdNpByKKCcNja6Sms5SXOycr8CcYpIh8p1y9FSZyduODsUEiwQWd75SGP2bh0qp17xgCRNThhXzwT/X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 07:07:14.4148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aee74a87-9a45-41e3-e6bf-08df4479687b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0006C3DF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6556

This series refreshes how the AMD IOMMU driver models IVRS IVMD entries
after the hardware exclusion range registers were repurposed.

The first patch renames the associated MMIO offsets to reflect completion-wait
store base/limit.

The second patch drops the workaround that forced IVMD exclusion ranges to
r/w unity mappings; the driver no longer programs exclusion range
registers, so that the workaround is obsolete.

The third patch centralizes IVMD flag definitions, renames the unity-map
structures to ivmd_entry, stores the raw IVMD flags byte from ACPI, and
derives IOMMU reserved regions (including exclusion as IOMMU_RESV_RESERVED)
from those flags.


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
  iommu/amd: Rename unity_map_entry and unit_map to ivmd_entry and
    ivhd_entry_list

Suravee Suthikulpanit (2):
  iommu/amd: Drop unused global exclusion range fields and init
  iommu/amd: Do not convert IVMD exclusion range to unity range

 drivers/iommu/amd/amd_iommu_types.h | 22 ++++++-----
 drivers/iommu/amd/init.c            | 59 ++++++++++++++---------------
 drivers/iommu/amd/iommu.c           | 19 +++++++---
 3 files changed, 55 insertions(+), 45 deletions(-)


base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
-- 
2.34.1


