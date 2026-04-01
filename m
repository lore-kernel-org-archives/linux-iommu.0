Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011068.outbound.protection.outlook.com [40.93.194.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3901239DBCB
	for <iommu@lists.linux.dev>; Wed,  1 Apr 2026 14:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054672; cv=fail; b=VL5Xb1mn1T1q4fHYgvOiUAUaY6x/jNGnSjHl1p22T70RK4oL809EgIA8g/oWd5gGTsvz/+f57zfkRl3sECpidWZaneOA5AWE0qZMcO5Spwr60P+w3hfu4tqSRcO18PFPqFwx7v/g5mD5FvJo34UQxOqgVFjs2mbs5q7Y074SIQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054672; c=relaxed/simple;
	bh=yYGTK2py2/EazN9d1v2YdLwCCGjMlHnWDT/4PpugBMQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vAba9h26WUaZAsNP6LDw+U0xV1bkF4h7Kk4DPSx53HADbDm6tkPrvR3aT3n+2mW8IHgpybiI1MhAlpIm+uszvT5xQ+0Libk2fxBY/hT+bah5xaC9w83W3UjQtFi2RnXiF3WIzIVFnySZQgTeyPSrNLh42bV0dRAwFgF0pzXmBhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=del70aB4; arc=fail smtp.client-ip=40.93.194.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="del70aB4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWcRlUJq/UBVRmziPfeiCSrKyl9shrUCDRNiKMlxEgd1b0OblHfFgk78QtpJ63qaQN4x0m3HyWAorV4nRvdOAPPDqgCGCvGIt4EHgf+KVq2mA9cEzaHYje/3216nrPNwyDLZxauDsd9MxDeQkHGu1Hs5B7zGCTvZGVcbpCTH4gej98AlsIZCQPOm8nkPqJaF8RM9zyLMcPf7ne1joTBmwHlpkDVSWsKH82RNovR5dzYnSFmKn4ZffAcmT1eCI6Nl6VOOL07fIyTvAd2fZ+YkqsFCgg4yh+bctO53LnIBLEN+LYNzv79D5FNLIv9NWL2boZwd9H/O6/E63I2Y0woz7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvxyLhirexoBf2BYMtKEDtr+JstbU4k0iZ48fCWYJ/I=;
 b=PMI01FPYpDfSFs80BwFpVObKw/ccvY8I7AIX49ouCLZ20DcQVlk8VZJyIbmgxC/JrKeFLbTj3zbORWUtS24vBdHpPmfMFCQNgbbVsMbAlskqg+ZMbpjT87CjPnwNpKZsXvBVo1eNFmcAVPcJ8TOm1qXf1a2jMppdjDppcgK0TduFTmEUpOQV3KfYIdTacoDcBRs2SP16EDH0D/m5OWa+X7ekolTyNAXa/UI13oDlDlpRCfFrZM1iSomrsTZUoPWyAf4IShn3lgKC62qFuzN+hKTmEL2Huy4BX0qpMuiUETw1g2islErgb1m3XXnLbmyVggWx6dE4535qWsFyag9zzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvxyLhirexoBf2BYMtKEDtr+JstbU4k0iZ48fCWYJ/I=;
 b=del70aB4a7jahq6ipq5fQ/XeJJfzmzfOsgiJntMLTZSLLjebqLVSxXjigIDBkxumbp2WT4Nr3USzaXG8DKlM1fcoHEouVClbEmFrqPY6x4cI4dZtidETABsMe5D+IWJskgdGj1IZaRWb1+vo3MzO3sR+cqu88UmgrsdYa8oZ5zM=
Received: from BLAPR03CA0149.namprd03.prod.outlook.com (2603:10b6:208:32e::34)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 14:44:27 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::55) by BLAPR03CA0149.outlook.office365.com
 (2603:10b6:208:32e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 14:44:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 14:44:24 +0000
Received: from BLRANKISONI.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 09:44:16 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>, <jgg@ziepe.ca>
Subject: [PATCH v4 0/3] Respect VASIZE for address limits 
Date: Wed, 1 Apr 2026 14:43:54 +0000
Message-ID: <cover.1775045213.git.Ankit.Soni@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: 5927f13e-5966-4e53-658b-08de8ffd2b50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	3siEgRE33OrfizUiC4kQapElBqSPmn4o+Xi4ppzEt04DEXi1qEvIJiN1AHqdAFqsXPSygz4k7wh3oetJdKKnkvG85DEvZdphqcZ8AnUVIYSIKfXU1StjR+WahU9QjsHoQxjsAJp39jBM8MhEi9ZZF5EaWuTwCWN/TM79KMLLPn/SZB8DmQj8/VJFuNEOq5nApx1SHx+BN13LNYYiMJMTSV8ZysdSdV1hbn+65HlECJkqmN8ZT1XySBsGK1/JI7M6HIbNq6rzLDwGbeNjmd8CkR7AQr0jGcJMJ9Lpa0xAQ16tReNOgAkVyAMR0ERYkadoAoH1stPHqBK9+EOJY3UgTCab0MmPc8dRTRHQAbGOcERjQLHkdndkAym9JXuvisYacMW1YFn6UUk0CPZnuZiUtGWtFuvDxgirQRSwoz0P3kttpkWBW4Hz6Wx5UtO02a6438R833q2yqyB/sHuGMmG+X3WP2UcixyHOyd/vgqYY0NuhGPlLPr2gqXKOLtYypzRDHD/vb4yJnW3UfH9IMSkY5NJOH1Y30l2q1KdulH/GVhBNI2reGHN3xOqV9At2ly6kBWevD16IG66N7+BFpsb4rKAQizOL2HjgErsTizcEsHXaYGDsIx0ZOK3N2GmQBSDEmdj8iKC/FUCO/1ImVtZxZqix93VIr7WX39Q28M8OWpZWjk+mU1xNuLujZO4v5OkPtAK43SwxnZ0GybO7t3izDSkujkw3ofFcemsjSSxmUj1Gdpcez+5TFKxGiqMAurr3SmosHUASNAcHsvNARm7mw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uyjEHfVKdo1cOti56XYzGrF0s6KMURozNgiaCg7wYBKm6mwfgZ8eVHPjATUtBOHaj2nXtxyUMGUPyN4WCDZiDO+Zn8F6EjK229Okzjb5agwAcsw3MVP0F9fNOHMQz4k0OWsTBEtq8Wlb08FxBdpLgLluFGJvdRhcxxsBvaErezGzisU91Xj0JyWeDtljT9DfnmRIuiZ/ASYOw85rM6rV/LIawyHRzFeITF0iRz9PhsV18egFfIrtfTKTIFcDjTsK68VG//KC0NSQj3xSiH+qM50g+pHwLxzsqRYsBNwKu2efR6jwtsynV41dmMxnc+4fhVbYCTsdBKi/r0gtt7+Bq5JLDrU6CBypykRm52XVTfIqt++IPs31REqebciC2Q8NcmVndu9+TXCyc9cshuwXvOzST7F1X7ghHobqs9ZswjIDAt/LxJJ3G08NlZkLIoEL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:44:24.8921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5927f13e-5966-4e53-658b-08de8ffd2b50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813

The AMD IOMMU driver was only using EFR[HATS] to derive the VA size,
ignoring the IVINFO[VASIZE] limit. This could create domains that
exceed the bounds advertised by hypervisor. With this series, driver
respects IVINFO[VASIZE] when determining the addressable VA range.

And for a small VA size, domain initialization in the generic page table
framework can fail with -EOPNOTSUPP. This happens because the page table 
clears the dynamic top feature from the force enabled feature set, as no
page table growth is needed beyond the current level.
This series also fixes this issue and adds KUnit test coverage for the
32-bit VA configuration.

Changes:
v4: - Remove PT_FEAT_DYNAMIC_TOP check from pt_init_common().
    - Add test coverage in amdv1 for 32bit va size.
v3: - Remove specific value checking for vasize.
    - Add patch for PT_FORCE_ENABLED_FEATURES.

v2: - Mark ivinfo_vasize_bits() as __init.

Ankit Soni (3):
  iommu/generic_pt: support small VA for AMDv1
  iommu/generic_pt: add kunit config for 32-bit VA (amdv1_cfg_1)
  iommu/amd: Adhere to IVINFO[VASIZE] for address limits

 drivers/iommu/amd/amd_iommu.h             |  2 +-
 drivers/iommu/amd/amd_iommu_types.h       |  1 +
 drivers/iommu/amd/init.c                  | 13 +++++++++----
 drivers/iommu/amd/iommu.c                 |  3 +--
 drivers/iommu/generic_pt/fmt/amdv1.h      |  5 ++++-
 drivers/iommu/generic_pt/iommu_pt.h       |  4 ----
 drivers/iommu/generic_pt/kunit_iommu_pt.h |  5 +++--
 7 files changed, 19 insertions(+), 14 deletions(-)

-- 
2.43.0

