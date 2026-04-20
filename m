Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0495536A01D
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776704456; cv=fail; b=GOCj6i5twAm0cXpXa8j2L12D+bw2QhBCCctAltYnwMEt07+fFiq1xSDoEVk8H1/4KI/p6DV70/kiN1CU406TxCUnABt4pdnthsCo8lfloRrhBOlaMZcS0bs3KjGwnfcRm6p3jyVhxnxBs8jeDaYz8XzPASCnUPVB1fZbZEJHWjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776704456; c=relaxed/simple;
	bh=3knD+oFLxaufjyb17HH4G6W1TnKyTGRQUF0WmTjjs1s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t7Zyovo1YB15+CHPoqF9MDnhceUhwuO9lwYKFGGvfIsQyNmWOXoNur1jB5sJ6dTn6TrngrqVzEplvXw5BcsHbQ+qQ5MUs/QQDCw8LVaxL7R4Wh0bRAWTv1V6jwZ6Smu5BLiytJFrNnVSp2cWG3acdZ13TxhgG/LckuJxdTIXG3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oVKeIiLW; arc=fail smtp.client-ip=52.101.85.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oVKeIiLW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnQ+a2oXPmBhcyJIh0/VCi9iGyJNClPFvKShF9cqpO3YYo/UmO0jZ3b8xUOBCE5FuygswmKncAGWR+mPfooD2OaMOmzmLaEwkJNbF02AcK2bDDHc9UW/uDJ63WL/NHc26hSr/Div9HsWomRKb8ki8QcjVgbJ9QQJF/IoabucobyUR++GbmhoTl+qPAY/7rpgh283kuV5CceIdE/PJFdotACh9fB9om5wL+u6rhizpKM5OuDOErexg4fs8jnWvmlpWXnx1qcRm5qYV3lxTsD3LoJXsggZtd7e+ZbpE4GfIN9PXuzJn9jopkrfKKtpW3mdNhhAeIS7sQguAyThGs4sZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYV5ssuW1X3ilRRLNVbJndcIZBAaheTUbr/Jjc1FDAw=;
 b=TQpInnQ5eCkLh8K0sSPCcMofKaG8nEeFjPmxUYZlHGfmbwPpiXC1EhR8b330GpWBGPN5XeSphdWH5f5+Rhd8d4MHbmB5GTgNGv0ZyFq4eaVuI/ze/JnBAaZyfGTrjOWFu/nHQbvKrn1Wdxowx4IdcdJezXELa6l8cDoTQX1+A+WqPhiGA7gWySVrmU7FNvX3JECkjOzM/KRE3IFi90Hm6GF2eSVpCBUm/hrE/0m9XiVCxETBsnFjoz6gOHi95jOdaaEi1Dj+WCfQkknt87g1uIOdhg4YAnai0kwFQa7zCf1JiXGc5oK/KLyfMrQehyZpyL2VY7v+pnLKd5DO1rnSxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYV5ssuW1X3ilRRLNVbJndcIZBAaheTUbr/Jjc1FDAw=;
 b=oVKeIiLW6PS4ScOlVK9PxKQXl/9cNqb6tRfop4wBQIzZ34rSN8vRze/966KS4CAY4WHPSbEzpp5xPxYSWoPKqKeVn/qOwcg37mol6toJ3rYa6uAyEgfWsX9TyaIXnGlHkfyqIAKiqMRMEbBDN3IHvk3m+91MFS5Waj9tYIENAFY=
Received: from BN0PR04CA0186.namprd04.prod.outlook.com (2603:10b6:408:e9::11)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 17:00:51 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:408:e9:cafe::a6) by BN0PR04CA0186.outlook.office365.com
 (2603:10b6:408:e9::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 17:00:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 17:00:50 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 12:00:47 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <jon.grimm@amd.com>, <vasant.hegde@amd.com>,
	<frank.gorishek@amd.com>, <thomas.lendacky@amd.com>,
	<santosh.shukla@amd.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH 0/4] iommu/amd: IVMD handling cleanup and ivmd= boot override
Date: Mon, 20 Apr 2026 17:00:29 +0000
Message-ID: <20260420170033.6780-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 84552e19-97cd-4e29-b592-08de9efe605d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lsStp2vQPOG74exXuOZzOyT0KAzOkbSWLBxJiexYj3rdOSwAxj+emFvvlytOaWqbekmLQpoQyoECrItavgptKKDlR/yzCHHebip5wBMirVO1gVKgv97VDBHpp7Z746mK0Jsxsl3/W3k72aS+y7TVY1WbaUEa4Is4P+8hsNViYLVw26Tb0E7NRQ1ZJFMuB4u/ZT/VDl2Fr4I5fYbvrrntMGGmmPqSPhGfWcTrBrknJBoc1gGVlk4CtvGDS/n+DbTjJWhhfBi4pDnQU7wHFQu1xGUALoDb+4I/FCWxoBcULd+IrQcrUPAHVJVB+8Aiqbl2bG+/OyvWc865f1b6o9wkgpDsmQaIJ5gfYpNrZJd/JDSg6x4CNT1vB1LULXFxiuRaDOoE0cGmkh7o1B85uw26UdpTLt8spWCIKsba6svZm8UZ6QDNGP8byelez6v7x6tNehDb5+iZUvHtaWdTcNvD419qykGOMBqSWKUTb9aWstWtw5orjiYtk8icy1WE5hE+v/NhupE0u0QEUxjlX1ig1nJlZEumZOS+UGx8Gffpsyl3H64p8w2D3qLJTfOqU47qglTyZumaMuq7od6E4awJaUYPsxxXed6VqZ8MJCicydVWaUN83u9MmS3KYo5ywNKOWDsE9kEZEcPJ/leAreNNQkbGiH1N0bGe2Kp/uyaOOboQ52O9oR9AB1JGudhk0tVK2kAC+qcXrjP+jgaZjpVAbyz633ubPwJPoeKgLkUkafSJTtxEcYZIq9n0QCRVDQoIJEkFbpUnVtE+wAfs8w9LBQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DT4RiPUqaKs4p56nHxbqZY6UIVy3UUgqRAyslpAdJIr4to3zdBOkmOF9/oK5wYKUmTv7Lm8l/pdzRLDvgJ0A5nY5bixDrzwuEbvI943gNphhKQ5tSRJrcdw7CDXalk26kf4WJ5lc6lb4dR7qxmp1cbRuYLSaupbUcOiH5L7QAc6Q6JZY66YmhMV2A8wIjarc0dn9T6MW1smlBwuUqX9lKtA9GtOw7Ef1ESDiR215dbuZRUh7NPqt56XPI8hy06/bhi+PrGesivhIGj1ZhhbWbhRoT8RYlnqHmxe/cssw8/AFX0cfbdDtOH++yJR0/Wd8nQCGWiDcUnLDnhEdxRap0UQQQpxPIWmQtwi5xLqgz3pZq8ylPVKBpLFOyAfvo3HT8x1sR6z9oss8v/xyJkpirkQYJtvhbsrirEhkIfvgmGbYAdCFM0pnmz9OnpUSccwG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 17:00:50.8389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84552e19-97cd-4e29-b592-08de9efe605d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864

This series refreshes how the AMD IOMMU driver models IVRS IVMD entries
after the hardware exclusion range registers were repurposed.

The first patch removes unused per-IOMMU exclusion_start/exclusion_length
state and the MMIO exclusion programming path that never ran, and renames
the associated MMIO offsets to reflect completion-wait store base/limit.

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

Thanks,
Suravee

Suravee Suthikulpanit (4):
  iommu/amd: Drop unused global exclusion range fields and init
  iommu/amd: Do not convert IVMD exclusion range to unity range
  iommu/amd: Clean up and simplify IVMD entry handling
  iommu/amd: Introduce boot option ivmd=seg:bus:dev.fun,start,size,flags

 .../admin-guide/kernel-parameters.txt         |  16 ++
 drivers/iommu/amd/amd_iommu_types.h           |  47 +++--
 drivers/iommu/amd/init.c                      | 182 ++++++++++++------
 drivers/iommu/amd/iommu.c                     |  28 ++-
 4 files changed, 186 insertions(+), 87 deletions(-)

-- 
2.34.1

