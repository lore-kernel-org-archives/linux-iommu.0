Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013DB380FFD
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 05:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785130778; cv=fail; b=NJGW8lvdi/a//fyetyg1gOgwdFvCd9ZwylxWPu86Z2HD6esKBdlUeRIo4+z++blSvTo7b5ujoAwLL3LuLIqd/hpWHyzSQxSLiCNrUVs47dgFhQepCu1sKdaVGgKur+fbauk9N43CtBFhhv7uh6UYbdUJdkYhI5spNlkxZLzcK/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785130778; c=relaxed/simple;
	bh=uVw8kHsCCpt4h76xdwerzre+OJ++9V7/+Z46D923r9o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CUB+mMAAyCdOpXalBrEfk5macHyRDB2sz5wfsQRU4jsIeNGKDTv9iduSyjyUxmcKXpEGAZY+Lr/mT4UvbytlOulrtToqgSOMh0Aorc3YJjewbGuyC41tqSO4AuVGID8bdHm+UsafbFQ+8eTcUv8+GCGenpAZIjOrSzxe3y6W3Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AIndJD7C; arc=fail smtp.client-ip=52.101.61.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AIndJD7C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rF1RcJgCBr3fRUMq0CdZApqqkGe6Bv8B3PNjDwD+WCKcrW3aAJxbD1fdFkIzwroNAVx37SyAD6TDLaMXjMCOdALxU0fRLknrRiuyUZLfksrYex45eytjtHKFuwkh3i5b87QHnOZ3fi7cU4i6ka4jisxRf0mt2Zmh8aFsBs48UHxMXfbh2qUuFfsnLpKy1TpSzBzjQ111Fs6rrDpuip5u8EyIhgdQoYlbqhDodWcX6gVu0P3qR7zCrxxUeypcDmcvPJ0ywyo3a+q765hX2tcDxHDYTMIIh5yIRV/xPPxFw+4gsuszWItEjVgEKc/ZKlr39yyGqSk0f+it1kegboodIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhHcxvd7Mp3PDrarYtED0U08OioG3kc2nNrYU1MToMg=;
 b=oufpIJ51TsqtrudPBjBW8VhzmwMw97ADll7GRJtd4BtPpr9vs4ZAxBmDXZbokndRAw4kXW5H2+iljzHdXC1iL/SsxVbqcjPyDIbGTiGD2e4IJ7hqIHtf9mnRRmu5yuhx4ZWKceKO5j7f6zEIVTNXxHb0vr6+BKgMhW83+bGP9Cv7Dso+vw5zG7wYlAGRLNe1KqK3sZtdFvIish4XVvMzgx/d6jV3J6ectnTSP32vu3IfU3CJKyuziHOPeiJezyCUKI6rAsH28zkD/trQ5+6lYX1xWnClOZMpGpYHxTqPbsPzOb+rLWCZmAtGA1jmmw3OEkdsKnsEHYpoX+9U8hH6hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhHcxvd7Mp3PDrarYtED0U08OioG3kc2nNrYU1MToMg=;
 b=AIndJD7CfFwcr9ym3DdV5c6vi0iwQtb5s1OOeV+k45YcZv752dtJ6gqWn6nqjpIz8gFkTWolwoKjU+myy3TyRzZh7TXJUV/FuhJ5o8EKDAXng2hsetx22dtbY0Rr48IcflZsOtvPEQfedCqFMrvV9gAOQrHq3gq/uAWlGhcoCQ8=
Received: from CH0PR13CA0004.namprd13.prod.outlook.com (2603:10b6:610:b1::9)
 by SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 05:39:31 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::87) by CH0PR13CA0004.outlook.office365.com
 (2603:10b6:610:b1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.11 via Frontend Transport; Mon,
 27 Jul 2026 05:39:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 05:39:30 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 00:39:28 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 0/5] iommu/amd: PRI related cleanup and fixes
Date: Mon, 27 Jul 2026 05:39:02 +0000
Message-ID: <20260727053907.7622-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|SJ1PR12MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 567af677-af47-4708-40a9-08deeba16e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	Nex+UjyHjErSMmxOz+Kz6b6qQtEvkcoIyr5+792uf52wqKl7fh/QMjk2NJJbZjzcTDEnr8IItsbxD9kMoEMswaFSa4k+IJYSr79zdo12d0dmawFMLxS2uqXU/BCjkPPC82u3BvRru5pzLzkYf2QwIO3GyaAwVAMJnIYP3Y0mMlQHYhWL7w54uWji47JlwBPw4+nB0/GfFqWAKasjJn039nyu6vQ/BJArBWGQ0BRE1cBJo4mkfDp9JOOWlYzSMYSTuvgSC49ymIr8o8X6cPWqnzCntExJUm6pWboitKXkyNd4KUDZu/Is6HallGSnX2HG9bwryVvcIcU/Bw7ixim50w/UOMqbcHDhfJavXGYNmQPz5vX+Ud/KIq3l/IqwkFYpE1w2rFKiZI6GYcRzkgXs+iom9NkNQv66TaJJyHb/LggmACPLbBztnCz5QvApA/f0PiYL3Kbh75x29fXSCWiMmo2UvGLMdwi9lPE/Qy1GRdZ+IppWdJpEsow6Uij0JnVxNfiIu8kMLCy0Uf8Q9GyTL3wat9er7aN09Tr07fh+QJuqiSTukJuZd9it3Xod6KowBYaA3KbiAYjfSWPAy/w0Bae3DXpslZJb/1nEKH/Bqa11H56ZsWi81SNbCaGBAZy2o+KHh2FYrVmtJNYnEjGG0NcrpyFx8GdSHSQz2zmJtS4uPt++Ma6gLAmr7i/veQ1pbwWnqE/VzBshKqB3R+EwJA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(11063799006)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9PZ1lml9eoounl5R2pCB5PbemW6HGja4jmvTUIXP5SPEszpdxm2/Q6wOh2qnMqB1gXja48C/8Ril8MLu9iSw915qIUkqHiNLOelJqhRrKI0x3HSjnhhy565sMEb1DJOi9eHA4cZ3j9YdB9MqPxeJf7bC6t/TUl33lYYvJ2Sj9LgREsJmhwRWga4nnKcR3uEtL2f2VtYo7fkzZ9QamTi7TwGLT/I5GOWpCE1WAMcxqGwm42rCwCALlBFoNPLp1/wb+wahucVhfST5+6PsnEfp9gpO3fLTHbyt9bmd/P4JCI0gI7ATR01+JpzWT4XeAn2DU0CJjoj5+4RQzDYnv86NZcylmAcV5+qZ3VMxEtEcucTMpFKJom0Hg5Ex3PEiwlYSDeSnH4sZ3PzszPcmkSjpu8HWEMxE11Hg12a5k17nBCrPOIccjiWryCjzD1ZS73Vq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 05:39:30.6986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 567af677-af47-4708-40a9-08deeba16e61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075

This series does few cleanup and fixes to PRI related code.

I will have followup series to re-arrange PASID/PRI enablement code
and then eventually enable PRI support without PASID.


Vasant Hegde (5):
  iommu/amd: Fix incorrect device ID in invalid PASID error message
  iommu/amd: Introduce PPR_TAG_LAST_PAGE() macro
  iommu/amd: Fix missing CMD_COMPLETE_PPR response for invalid PPR requests
  iommu/amd: Rate limit INVALID_PPR_REQUEST error logging
  iommu/amd: Fix GN bit setting in COMPLETE_PPR_REQUEST command

 drivers/iommu/amd/amd_iommu_types.h |  5 ++-
 drivers/iommu/amd/iommu.c           | 63 ++++++++++++++++++++++++-----
 drivers/iommu/amd/ppr.c             |  9 ++---
 3 files changed, 61 insertions(+), 16 deletions(-)

-- 
2.31.1

