Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793938649;
	b=h9ziwGsLrKS+iuV8T1CQfYYsZb2ZFgH+sag+qZWaQY9hc1Ry+WjLZVWQdehf0s7xiXlw
	 Eo5ilnKWfw8Y7RwiTnKWaSLe/osM3NiLMI8DBEr7w06odp16UbTCkpmurtyMbot+tJ2Pj
	 9nppTT9i7EMSf2QwlCY7Qu0k8ngLXwm0sn8zhgM7nIwSzjl2RmAsAmnfA3krb13PAuHpe
	 eG9LsGqlyb23F+rY/8+vfqtGBTtD7QIoLempfy+8aOPBBlx7oXJ8KgoR7DX5rjRaQK+rw
	 cUiRkILUUVIrARWLeG2VaViCT4IrFAM8OTCUyQfpb/uc1u8n9ERDVCk9+TEio5k8FfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938649;
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
	bh=aYrh3OIIO524+lGjzB+aSnERtdRt9XvWe6eA55nHuTc=;
	b=pyOFbWP7iT7s2YtnARFLxTvCuVtcSqzy1hmy/ytnopAi0EJUqUeFuwkQoENKeG7dLSPQ
	 cK2oKNESGb8GXu8qQiqgrjAwJCBJjNgREQF2bYz1z7iLd0vzwDwyJU2OmqMy665vs+ay0
	 A3GkpKS+34MEiZbsLnDMltDUmTeTbdYuDqzFvdkv3iT5ob58nnMEIf7c6H98UoI7iRQuz
	 ioSg4bTDFbDb+64s+ofPrKzlHgBe2LO5cp5KRZQaiWq2P7Dp6d5Mj3ll5eJlofAxd9ixc
	 xsmhkShc8TxXYuo7h8OBD3JDs9GrGmx32XIZV8ebP9jAZ0Zz8Me2rN/iivqu/Msikdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=u5PsbHfm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.53
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013053.outbound.protection.outlook.com [40.93.196.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E8B606A329
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 04:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18E8B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=u5PsbHfm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guQ/ykeJvf7M7IGTZVr33MhMyHOkwh9Cn5SCvCWoCYE4/xR0Xst6oebXwsWGUfrJJHCZYmD+Qq7P85/DsYJLAGEquj48gr42r7Ysj+603t8fSnjVI1XdFmc85JrkTWWu0wYmmrL5Kn7XOH7W6tlTNjjk8TS5Li6NUNmPiEvJJoyqGCg6VS6ltWHYespS0omhO3Ww94wGzp/Tjy+7NMveAKf1M/kHHyBJAi+8J6jREI0+WFuTiP3Sof2zcu/0wwlxnCo7rKDfNrDMFk+5u/3W+cizMCAOIGjJ0n5qay1pSd2QgbjX4FCZiN/MWOcYQyKjrBBBmCp6AfcNi/EQzMj7oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYrh3OIIO524+lGjzB+aSnERtdRt9XvWe6eA55nHuTc=;
 b=XSD6mOhb8CPIf7Mc4XqfnDhu+uMXvSHVgoKYy2Y83B725jvKGHKWNDkNA1YESZE8p3+0uk6ZkIX8i8tZj+9aPyMG9QGpixxQHLvrtv+CHgY9E3qugFautH6ARbUBmHX/50KC51AbkYxkMmXjjDwKOH06TEFdSBqEueM1Ccx4xOud1JNKZwGwbI/V59Jd9hy4zNC/s6Otg+CQV6onPyVuy72hRsWMBCa/+xBMjTdBT29eWy6uY2nbKBjdWn6otg8IOt2wOQYW0U0BBquwKjUaoYKC6ld4dq9YK6d780xrgYE1oOQV6D1AOpekZGqiGeCfgvalvY6TpcQuJDrfI8p5lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYrh3OIIO524+lGjzB+aSnERtdRt9XvWe6eA55nHuTc=;
 b=u5PsbHfm9gUAQebBko6JGtKbwSdua2fDy7XyQ5a2uHXPVR4vghbvZIM7C25kOklfIZMMVp66YZi3iUjUf94RTpoo0m8k7YdgTu3r9pmf6/+96vc+TBvDBWOs8ux5A38ctkHXe0HiOSLkVmK3e+FgBP/QsfAiC8GD/YcEXpjpopc=
Received: from CH2PR04CA0002.namprd04.prod.outlook.com (2603:10b6:610:52::12)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 04:17:22 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::9b) by CH2PR04CA0002.outlook.office365.com
 (2603:10b6:610:52::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 04:17:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 04:17:21 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 22:17:17 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Adrian Huang
	<ahuang12@lenovo.com>, Joerg Roedel <jroedel@suse.de>, Robin Murphy
	<robin.murphy@arm.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH v3 0/3] iommu/amd: IVMD handling cleanup and ivmd= boot override
Date: Fri, 6 Nov 2026 09:46:47 +0530
Message-ID: <20261106041650.24076-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: ee76bf45-6b0a-41e6-1222-08df3bbcdaa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261026140227099003|11063799006|56012099006|261009223027099003|261022075727099003|261022105027099003|261021121427099003|261009221227099003|261021123027099003|261102123227099003|261028144727099003|261026121527099003|18002099003|13003099007|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	tr/nVEbVbZyRXmTxmK7xz5a6Q5Ss6uEEvkfIrh199BiiUG7Gi5Y0NXO7nnNNZWHFTe0LVg7bmaXe5d6J4b3addVYSDLKf5/K2TVC3UbyNAWrqcDSliN1G5MH1kB52/ZvX/PhLoQfKtHvZs5RDROEyKg8EONoPJBQt0BSFWAfIY+pB1sXMh8jCtSyas6JHdbOj/tdegQtDkpaao8Dvkb0FvGGHiwAk0seKHVyIHSVdScZwn0hO7J9xUlEkl4pgrYzqqcAzWYXxJvnFeOq5EeOhb3P4CYQMRDEwAhkTOTb5ZeiI8SjapB/cOcMZ4rTc6mhfTP95/Ts3XNfONxhdeJJ0Er+LSNRMpPzIyicOZVmh4hRkkv289n+YuWmKYj9lNEasI96tQG3Q/QuppoEMAKZyZmn8cP5BeBnZL/SpFF5bvVNa+QKTB08xuXpjeHzCAnZi21UCcpy6Z0A3kL8tQfxYTwqDHxok3Lf7f+7qiU3wTLd3Myo7kzzoKeDSlkl0OHqjk8qkc1Q8/1shHK98ihIk4D5u7vOyPXiMZYTC+kZuAtM/R2aImA6b9JWAWR7tFvZ9bLvFkdj5cN7LoQ9tjRdwjSzT2S812WSKhnjkRO3yIiTIOV9R2E1T5Yo0F+No+Fb+CyY3HmY/W+3ciX4zWxbF7yy069Yjde0BWqzP7vXJzw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261026140227099003)(11063799006)(56012099006)(261009223027099003)(261022075727099003)(261022105027099003)(261021121427099003)(261009221227099003)(261021123027099003)(261102123227099003)(261028144727099003)(261026121527099003)(18002099003)(13003099007)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ydxft8boGExaVSsn1cAjqiV9M5hryOG6BCC3lFDTwW4ltYy1c61dN6Z+YGMLMBrBN2Ad5iq/VKmWeEU0inzFQlNpAnTnNx6h8558IP3UOdtZnL/VBuJ6PXurRr1xjA4cLP5wkbnJWGv/cxonVc5VBce9oFDNgKmeyt+UBQDat29MSlQvKKkgDCf95LxgB1XEnvn/W7G+DEsbUorPRytpnA723R5ebK8mkZ0+7fc8ej7TiKGr4NhcbrVoHIKEpss/lL8CDIptG9IMRgXHvfeAewqPbl5rL57cpOLHTsG9eDo5jic+rZEJ3hkJmQRJQGb+q9/ZeNs0T+dgY4NRVZDqiwehTrkd0TgdPy3wafalXyQJ62CWyP6IBljgO4TMZlUfGjb0w91vnPiu0B2Upo6WUZMYaq8iXKXdj+f49lvYBJbSPA3PuW1NigIIH9/xf3Hi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:17:21.7300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee76bf45-6b0a-41e6-1222-08df3bbcdaa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930

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

The fourth patch adds an ivmd= kernel parameter so up to four per-device
IVMD-style ranges can be supplied from the command line when the IVRS
table is wrong or incomplete, documented in kernel-parameters.txt.

Changes from v2:
https://lore.kernel.org/all/20260424092213.16976-1-suravee.suthikulpanit@amd.com/#t

*Patch 2: Report an IVMD exclusion range as IOMMU_RESV_RESERVED in this
	  patch, instead of leaving that for patch 3. This patch stops
	  forcing the exclusion to read/write unity, the range has no read
	  or write permission. iommu_map() rejects that, so a tree checked
	  out at patch 2 does not boot. Reserving the range in the same
	  patch keeps the series bisectable.

* Patch 4: Drop this patch, ivmd= command line does not have any real use and
	   complicates driver


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


Suravee Suthikulpanit (2):
  iommu/amd: Drop unused global exclusion range fields and init
  iommu/amd: Do not convert IVMD exclusion range to unity range
  iommu/amd: Rename unity_map_entry and unit_map to ivmd_entry and
    ivhd_entry_map

 drivers/iommu/amd/amd_iommu_types.h | 22 ++++++------
 drivers/iommu/amd/init.c            | 54 ++++++++++++-----------------
 drivers/iommu/amd/iommu.c           | 28 ++++++++++++---
 3 files changed, 58 insertions(+), 46 deletions(-)

Base: 945b3729fca6176fdbb83e38c8116b0132c68fbe
-- 
2.34.1

