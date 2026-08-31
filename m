Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013056.outbound.protection.outlook.com [40.107.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7966139CD0E
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 05:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155491; cv=fail; b=H7YrJ5nXDRVP8OtUZUFqVzSfga4KnQlTIxsWEXhB7bCjNc7Tx40KpTKhNM3VtP9taZ0o22E/njZAMXBSgUtc47aqNJrQY8tto1T5S+EW6rU1RcVOPE12NILIer/CepF5M9b2Cy6PdHQXeoTD+xL/xfyvoGLEurbnVJsBbW3S6NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155491; c=relaxed/simple;
	bh=HehnQ7vEZtUeoSjZTyDQo08x5rgo/yUkBdiEP9ybdAU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Au7f0JNx75I/e0yxJGf+d/jUt2pq9osLVZlUsYPlmilno070OnClXuZq3nkmJqzaZNeneDZfxEY7/8VCnaaCsrttX2m/c2OAQrdz7L+OYHuWHxktHooBmni13aVUGCgS/VhdDJuS7LgFv9Tl9I/4iMtkfKh/neLWZMGgTQUEfGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cTsGE/to; arc=fail smtp.client-ip=40.107.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cTsGE/to"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aD7IGTZ+tLUJjsZotr6Ig0ZC6zzKWCCTtNodC1RydhCjcvf6JV45T++5+o/74VwWCSCvhjm5FagIAUfZ7o+bxhDgOQO7gqkhbXfX/RSRSSBUAS2CrKSRLcCQ+IQCLR6t2Mx8E42FvkH6HAyum2GusiEXfYFZ7REjg4QFEoXGxbMflIwLNh5ttJQmyraLaOhsmlmterg4QlzLdvZOOqRnP7r4u2hROd4UpTtHbdQkTvc/JoJGjwOI3RwwVrFEjgHBVdlDxMilZVd8GSFBR+IH3ht/0qyGuJv+aeTwKh2soG8wbYC+ovcGJzP+FP18LNYT3YPsrngYyQTw+zV99j4UUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWqvdZy3tlppvsJH8574PeHeCrsYH9eKkCEetyElq4w=;
 b=OOWgfJKT74tvcxRCTvgZ++ZnpRVy3Q9t7H6CP5B64jkzvDiSCDjFFcbVWfQiEF/mUPZiErMz9KAPKO76BxtdoztOgo7rmaFPdwBjgKaXlYwZkAYlvQtsfqi79iydi0MMIY2k+Jwvl9XEeBJEGEu6K4jIEARZGLT6WMynHW3ADbVghtAu/7oA+KH9PTFv+BsVtrElWtRazMkLVOW140713ZEXxLLDjn20RuMC7cTWK/U74ub4HGKRoHqfnVfbLVV+JMILXdD75RkB8f2V43sL0maUrFSDf3iX30SG58jCWoXVaPyHkPEg4TsbiaP3bbpX/gKXAcucl6LIAGWxb3ip9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWqvdZy3tlppvsJH8574PeHeCrsYH9eKkCEetyElq4w=;
 b=cTsGE/toleqZUIb9sb6HTko9g8n7tyz+s78/eN0zzVxliNTnMtz9Oa39NrY557L311/mUbx4Pt6Z2U+sI9VPtqL13mtcHTez7Ys/oJNs9uSz1LtXpJ8c32DluHlSUTjjzjUgWMcICVK79tLyzQnp5yY8JLUJZEPt81oRlHGq2cI=
Received: from SJ0PR13CA0215.namprd13.prod.outlook.com (2603:10b6:a03:2c1::10)
 by SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Mon, 31 Aug
 2026 05:51:25 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::88) by SJ0PR13CA0215.outlook.office365.com
 (2603:10b6:a03:2c1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Mon,
 31 Aug 2026 05:51:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 05:51:25 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 00:51:24 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Joerg Roedel <joro@8bytes.org>
CC: <amd-gfx@lists.freedesktop.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "open
 list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>, Jatin Kataria
	<jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH 0/2] IOMMU Performance Optimization support
Date: Mon, 31 Aug 2026 00:51:06 -0500
Message-ID: <20260831055108.1893285-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|SJ0PR12MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: d807bb65-8cac-4470-21dc-08df0723e515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|10067099003|56012099006|11063799006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info:
	KB9U2rYmt716712aK5Wc9D3NNmbBxwrvboVtUfSiwD3QjVTcIkj1RG4a1B5kPgl1sskzWHsjoQXhbBI4U+/ad01SAmHFUK0LGk/uKcRejw1TCA9c2bU7lLdQ/yG7q6Oa7bCVEul+HcWlDsFcUiO58gvGL2eKADrl1p6XbjYcYJBUM56imQUtVEz4L0+P4+B1Yo/k64Pq+v+8LSmbSn/NOPGDD4h7M6TnSleFad4GmqJ3X81PSniwvaoovPXxRLmeUVU6aSxax3x/SB6Ovz52hVHkPIPxWkTBjByVMfJ5748F17tfe38ciqQtx/DPkT3molvH7M2n6iPQuEtr7YsGYdCoz9sfKKuwtatdB7oLYUSUPhhfs+4OSS6gwVIsGVYYLrQKVdsYVBCOZvA97QaAGf9IVy2Ii98iZtyddbfweLdTDdpgJMZI60xWXtsJvh8GAhCJtKcXT1y6TXMGfADXrTDqP+O618vSQaCKKaYx8sTIv/HVHDHUXFqh8IzbTR3DsM3NDhaWKa7pZ+499FiooAANMlOpCFY+zfrnVR+HIiePAkT9IXWFnR7u0fliklg+HgqGMBYtY9uZIluOvjQ+HVZ9H1Nyvet/98EZytB9nHNUW+mvmglijPYY/gz+QjdYCdqrpFoFUM33wGwqayjxYFZGtuPaaAmzMmYrgcUa9wRMHJ6AcDAflshAUsqa8yiIsNbEOgyZV1Jr+xrxUHBYDw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(5023799004)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MuT2SWc1SCyzaQoRh36AGb+3T1F5XatbByFo11r9wRmfDk8nl8hSD+R+2KT7k9qJrtqPK+dNBUyw3sm0rUF/X8Z+JfAnGRoX+5W8xPykFFLF+brsx9frc+CbiQmuOv+ZB2OSf/MH5dO0LxRoHpVZKllOU1+FA9lTc+HyjKivGqiTU037jQMSDbWHu5SJ3dAj+sWuSznZCi8yOiIX07ft1VxCvqJUp2JdwHc9ZuGNeGWyr7mQxTYHVNGfhqud4+5Vr0/walsfYgqiDxZ3yE6MRJn5BhhQxGnlnUqCfYCFRBFEjt8d687SrbfbzLLGl5azjZAc+8V9N2NA5h0dtPCJiytWkpYBhqslLWPpAfr8wsynHCAdjU9tcV2Bu9E76zO3QTbDTqPjn00KV+r+hHmfAJwGmPwhPv/gKVO8aXXUZg1tM0eQr2XY4is7G7rN/LmU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 05:51:25.7224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d807bb65-8cac-4470-21dc-08df0723e515
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6967

Add support for the AMD IOMMU Performance Optimization (PerfOpt)
feature as defined in the AMD I/O Virtualization Technology (IOMMU)
Specification, Section 3.4.9 (MMIO Offset 016Ch).

This feature allows privileged integrated I/O devices (GPUs) to bypass
the IOMMU when directly accessing system memory.  The IOMMU only
enforces the IR/IW permission bits without GPA->SPA translations.

Drivers will opt into this behavior, and enable amdgpu to turn this
feature on when an integrated GPU is already in identity mode.
If a user prefers to keep it always off (even with identity mode)
there is also a module parameter to force it off.

Mario Limonciello (2):
  iommu/amd: Add PerfOpt IOMMU performance optimization support
  drm/amdgpu: Enable PerfOpt IOMMU perf optimization when GPU in
    identity domain

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  41 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  12 ++
 drivers/iommu/amd/amd_iommu.h              |   3 +
 drivers/iommu/amd/amd_iommu_types.h        |   7 +
 drivers/iommu/amd/init.c                   |  43 +++++
 drivers/iommu/amd/iommu.c                  | 214 +++++++++++++++++++++
 include/linux/amd-iommu.h                  |  11 ++
 8 files changed, 332 insertions(+)

-- 
2.43.0

