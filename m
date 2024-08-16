Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76AA1BDA94
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723823042; cv=fail; b=Q5xlmQJkG9YQojTXpld7QnYw8qbFzxScOEDrWVuhEZhgowdmBVzLkjq2J13LPgovhA27yRQYifr+BrVIBJxhRSrv/SOYmFnbTXJMd55GvAb/U7Mwuy/SnLFG4i+yXEVjs2AMVGDzKKjkQZiWoHXpzbp8+gNni6Y2BrqY+XO975w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723823042; c=relaxed/simple;
	bh=TAuiNx32GLZpJoNSVoNWdCGct1CduqZahh1D1f4ffzg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LbXvTRYfLDDPbLLIkoZTTESXeE2cIemc6XzuCTON8HwxfPGn8BWzBqp/1Edj+RmXLPAMroJbL+cygy2HJDmXEfvZkrtZ1/kwebjNd8b8tBtbTgH4STXrXncaTD8yuDUpCMuWOGojNvWw0AaFGZJRHZJvESxURRnuJhlwbrh+1/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CxP5uEwp; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CxP5uEwp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUtWWiaemHi6bAIl1k2P5V0LDcbJz04+XrN8N/5Hn88sqmfoOfYBdri8/2ENpn91zxEdUA6BeiNA+5czl2O63sDcOLHWHOP+gW+FzJV2ivWq4YPCNpbBrPiWnewdr6sQwRpvUhM0zyM/AsNYawi1YBWCdc9MGDxEEzKp4KhtOqXxmmo9VJka4bTlpf+TNgGfsDaREbplQueL8B8txQH/AUV5OZ6ZQFzuOIs0FrQ/CIlI8rgh5dR2s1T3Np2Y+HdDWoSxm1mwnZXkfXuaxAJUdkQoYsK6sKcGad8w/L+zffEfwdpor16LzoguTcaS+BEs95+yp7eViHYIxYgfeYAexg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qARkweA9UaAY199FMmdOTLzVcOdCTJ4XzFMMzNoqcNU=;
 b=RIDASNKwReuogPVVroGVQV2qO42POMzFhF0JeBn1gk9p9yhMr9K3LGbfcTRP1PFWZqIyVjROgw2e/QUCUGQNWJp53qKDrmMtCgO92BJ95ka00O3CsEYXMQOleqUQzaZEZLVBtI8G/avxS7zDneptbVsIdmRI0gZcSaD+s+sagFsmaxdBMHPpjL+OA2dMY0ga7oEG+ptMO6dFbB9nsZ5xng5G+zgdIZmETBCKYnR4n6EsFSJ1nVHogMDlFySJEiBd/b+1HZecR5Xpd/WoR8U9Qa1RSlyx/FO/qLhoIvshklDfJPQwGGVf591wTx8XfQbkYCm5H8sldzDT63hc1UC/vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qARkweA9UaAY199FMmdOTLzVcOdCTJ4XzFMMzNoqcNU=;
 b=CxP5uEwpbo2Fyrx9xNBGMkwBVy9yPdWzLNuh/Wtmnjfk2v91ZQ1fFiVBv4DGykigWxUJUtzKe1n6AxMZSxn36p3/YtM/EyiNDb4CFGBrZ8KxiwDIURYoQxUNxD3PpwX4GTM7MfTjG7RBr38ehf2E6uWNG5L/MuJarBP5PHP20E8=
Received: from MW4PR04CA0306.namprd04.prod.outlook.com (2603:10b6:303:82::11)
 by CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 15:43:55 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:303:82:cafe::8a) by MW4PR04CA0306.outlook.office365.com
 (2603:10b6:303:82::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24 via Frontend
 Transport; Fri, 16 Aug 2024 15:43:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 15:43:55 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 10:43:51 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jon.grimm@amd.com>, <santosh.shukla@amd.com>, <pandoh@google.com>,
	<kumaranand@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH 0/2] amd/iommu: Clean up DTE programming
Date: Fri, 16 Aug 2024 15:43:29 +0000
Message-ID: <20240816154331.5003-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|CH3PR12MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 27793fa2-c03c-4d37-889b-08dcbe0a3c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E+Q6EX5ipnVP80w8jlkSG4vH1P/i0O8CU/XDMeit76yIInfSZE7AvIurL6LP?=
 =?us-ascii?Q?ELhBMtlJ/KSzHFGxM2etYKMXLj2tQds91ccESL/nG6wh7isjt7QN/HJUORAB?=
 =?us-ascii?Q?MP/0UWFTGhwKXml4dVzgmuwqLlTFa/3vDshx4cCVCQMARmPL/Vf8WE2tQuNx?=
 =?us-ascii?Q?9HTYIZjZ5rIhnHaYel70C52fvV3CPNW9YI3aCDPhpsGBcNvbbA6xTQDVn23G?=
 =?us-ascii?Q?Oh40s4huwapJPoPYF3G1jGeCdQR9wWanB2R/APmSzY6+FFxic9/fre67Fnd8?=
 =?us-ascii?Q?CWiFviSQlNycgeRhW8+JVXTaL+5g09P4PD0Uvi4PcN+b72nrfVyOf0a8P5QC?=
 =?us-ascii?Q?L4iBH9x1XHXXayw8yCZ4Yz3u97b47Tfsiz9dacmwlTnz94NdlrI8C82bzRoV?=
 =?us-ascii?Q?u4xCyUlxm8ep48ij6GulWwrl7MlwzZ35hrsqoH97wkxWXwTH4jN0R5R3cQMn?=
 =?us-ascii?Q?4id3NMtpkdfuNeyKJnRyU8uFZMdir/oo+JEoiUaamqfBA6FTKtsOmTPF6P8E?=
 =?us-ascii?Q?I4UxEqmFmgsZuw7LzhquzHOwPRI13Mk0AX65yLyqL757SeCZXkhTJ9+4+cYH?=
 =?us-ascii?Q?5XYA+kdTQdCR0+m0PbzkEhrQM+8nkVk6JQFoI79TmVkml+QAsyXkk7v0zfp9?=
 =?us-ascii?Q?izht//l9zc4F4+quj7a+Tl4qUe/9Wk7AxC/Ea1dmzrIiljZmfWduEXCXm7lA?=
 =?us-ascii?Q?2H46Q8GiYcAKZ1wxSVx04qu70K4Jtooryg7Uiq7mvvqwF5uzMJfoZU8fj6XL?=
 =?us-ascii?Q?LVnzWyJcBwGO8zkkKcWH6bNd3h+8dqtO/+QI3dffu0SH3yUq9e1WDmloI966?=
 =?us-ascii?Q?9McTbT0BjpM7WLzEVla1HzqBqV7Z4HtXVGOmp/cA92NqARuIckWJrhdBw3X8?=
 =?us-ascii?Q?dmyA1uMrBFY+LX5Tvkab7tk2D/n8LVkoNEI9zGiY/AxeCBBkytDxekhKnVZD?=
 =?us-ascii?Q?sT7/1k/28d/l8JcxisjY83Gydy/he/RmyIcHmJ9DK5IzL7nI+fhpBl1cGFA7?=
 =?us-ascii?Q?w2Vl8cXAvm5kENGauhPyHslud4aqoxnusEz3m2axo5PHp7gKkL8ohI565Ygi?=
 =?us-ascii?Q?BrtrEn0mGFRgbCuhhB24NXTZJ2yedi0j90VRh9xAtcb0gEQ1YCpP58vf5RXO?=
 =?us-ascii?Q?B5GfCjkQjmKhEvX04VpDnKsYQ7NmFwjBq5CXZPC6yPVyKDk9yFOjgsga1Qum?=
 =?us-ascii?Q?yw/rhwFvQnzgiYxGzwlDfj/KFjqwS3PdiYcGiifx5gysuoBP7sic+8DwAfCy?=
 =?us-ascii?Q?gdTam+5mpajtUUPaKcv00QYAhskeprnKZYfFrKV0lCIQ8kNkNYUEWnxJvOli?=
 =?us-ascii?Q?qrem4+150ut27+aivF6dmZjKrxR7VO+XFK17qsOrLsvmHS4J8RKyazRMuefQ?=
 =?us-ascii?Q?nJyNFk3nwJi5KwFRR1Bn3AsND1EhirI6Ux89iI81QjQirgqb8JYk5wJkPmKd?=
 =?us-ascii?Q?sCBBd0yOtwOazlDdoAUnDSB2B8h9hwKY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 15:43:55.0155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27793fa2-c03c-4d37-889b-08dcbe0a3c63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643

Hi,

This series cleans up set_dte_entry () in AMD IOMMU driver.
This is also a preparation for subsequent nested translation
support series. 

Thanks,
Suravee


Suravee Suthikulpanit (2):
  iommu/amd: Introduce struct gcr3_tbl_info.giov
  iommu/amd: Refactor set_dte_entry to simplify GCR3 Table Root Pointer
    programming

 drivers/iommu/amd/amd_iommu_types.h |   1 +
 drivers/iommu/amd/iommu.c           | 131 +++++++++++++++++-----------
 2 files changed, 79 insertions(+), 53 deletions(-)

-- 
2.34.1

