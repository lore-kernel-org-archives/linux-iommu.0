Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012070.outbound.protection.outlook.com [40.107.200.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D802DDC5
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 20:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000126; cv=fail; b=r/YuWVhNBTMMPAd6tx5nYHLLJ816gLmeOzdIEpb6JR8aEKEB7M2FJ31W28tLk+eDxQ4/m1j+pjOP2/tVwRn2Pc1QeOAaulLvPgVrD7fTKM/9z878i83z3Q3SjScRwwDdqhQcztdaE838uTJf46F9UN2IlKG5GS2YkIWhQZ8+K64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000126; c=relaxed/simple;
	bh=JJN/YimAmHtPyY814sHYmIZxGm2rcpJeO7fxCg3fJoo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVR1BLxMPVtfBUJThp7AWUiZHbIJayg6F3tjNFiEJJVS6Kd6TDxR19nGkoZrKzf0iDULMujY5imvFsE2suWepNk+rFEKKh3wu8psq1QVpkwPFwnn9L/jGSbiyiKSbUP1WY4LxMh1wD7f6DfB0dvfWCgfAV1IyRFC4oO525nGyzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YPNOq9r0; arc=fail smtp.client-ip=40.107.200.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YPNOq9r0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3/N6a3GVeXd8/FCMehuCRd57krhTXyAxulHLt74VkylEftsAzHzk74f87ioWxzb+5HLvd6wZ7VE6w2S3RPeKmoex+O0l0NbjeFAC8hTBulf6nEmKbUDg6YBkhrPiPkotUDZx/t2ZBWdx8yMgCzQWdHZENqyNH5eRAFlryK9N3+8LYXuqiNXCA8qb/jEli1ZittTBb6dXDQzMmfRHVlAcywdPx463K6D+z1Gz10EhN2c71V4GMBunrmvXtGrZlXAdRYDW5vCrlmmWAVTW+Dk17b3neUMcMbz/F7J01pw969xQCtUMAF6HegXicP+CFYQbMjtl6vweQvtshtmfPPJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJN/YimAmHtPyY814sHYmIZxGm2rcpJeO7fxCg3fJoo=;
 b=dBYI6XaKWoRWCHC+u63om8/+zoNLKqkgUqnhfs8k9DbX/bDpDs5gr02dp2k4DIcpqxMOhjXz8DjNC+qwj1173rP0fTWMMVZeT4ZaoAdbwBASr293QrSMfbPlOV5U3BqVblnwu5dTKEd4IWYL7GWdypshzMLs3GDLkWjCsItUG9P26mo9mH0ArVQOsuZnjY9Gmsglm2DpAsul+iTfuIqF57s56MX5URjvJDqcs39KnP5Zjyj2p30a91r9zWhZbs0U1wR5V6SGbF0lXHGb5D9g9Qyapi7H3TvAozH//go/0DhexzKSux1itLU2kAB9NK44GYgXWhZMSlqhYR0lIqYDzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJN/YimAmHtPyY814sHYmIZxGm2rcpJeO7fxCg3fJoo=;
 b=YPNOq9r0J2MxmEwHR1XuyhREmlG1lAjSdj4DhcKHh9hm9Jmb4PCdxQytlE/Y1AFB+ZJwoMyMQ/g4VVDsS041TuUQO50JZWGxPHSS2prWMQ36rEI9t4R3k0NiWKG4AJdoDrhbotFuqmr5QdgrFTnw8/l1kXfq01WdXlUpkWWoom3tBYhwT3u7gNelCmbmhCPWfjhXGCvcz4kMG5GDonLgTJ6TKtk3Ot1MW52rnbOrGjkgivRcfICYI1MdAIXvBkK0brbWLO4OhCH0nf5tKDNuaEVQtthAfJJew4PK5b1xQm323gm6Wi56wYdOWsuE5DccSc9Zb0mm9T+qZdpq+zGn3Q==
Received: from SJ0PR03CA0337.namprd03.prod.outlook.com (2603:10b6:a03:39c::12)
 by CY3PR12MB9630.namprd12.prod.outlook.com (2603:10b6:930:101::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 28 May
 2026 20:28:39 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::4b) by SJ0PR03CA0337.outlook.office365.com
 (2603:10b6:a03:39c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 20:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 28 May 2026 20:28:39 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 13:28:18 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 13:28:17 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 28 May 2026 13:28:17 -0700
Date: Thu, 28 May 2026 13:28:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Daniel Mentz
	<danielmentz@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 10/11] iommu/arm-smmu-v3: Invoke pm_runtime before hw
 access
Message-ID: <ahilX8Za1NRCH3ik@Asurada-Nvidia>
References: <20260527221407.1756491-1-praan@google.com>
 <20260527221407.1756491-11-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260527221407.1756491-11-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|CY3PR12MB9630:EE_
X-MS-Office365-Filtering-Correlation-Id: 884e8271-9a8b-45f0-9057-08debcf7b3ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|56012099006|4143699003|22082099003|18002099003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	4GhxW1b1xxVQutcwnuy7lsA/yXYLgWs9GffD3w3/UX0+dvA5y6z2LXG8XiESXZFVTsjvmQQx+IXPqDItqJlaW8j623TTjrSy76EcJ75uR4rpaGPtZN6vHySt3oBxzjux+4f/b+x/ffpkaR8AtVTi9uJEi3guHAqCQciNkKmpFf2PZmXJk4T6IomNHOhLLkJiy2KO48I24QLQIMxqEg68gZVMx9LXHybOa9w0ZwsB6G8FnSGuDI8f5eo1X/aL9JWMKcF+OP3JP7nhSSr2Vv5E2HL2H/GU3daOk4i/vWAelQg2tF3kYPlKi88oEZnRMCwkHZBEnbgUoEwIRKy7KAuu3lcQEwqU5voNwPL2sw96nRK+wPvHR5SMJMtvdV4LkAnOybx7O44ykZf/okx8oNtK3tfDjMqNK47herTKqUVMEhk/8j9ElGY8PI0a4uPBKsAVUA1cIOO3Yx1V3Yh4LFw9t0iRYBOKyy0YSUAjjN8rPS8lmmwq1QX/eqvSvSfX71lvrIIhqh36AyAXTMpux5c+1bXkMdbJzzE8uCfEy6Uw69MQbS5XWxpeArgVPj9ST+bVxHMCCioShMKy8tqHBuSddSPtCG35ZAZWCXgeLO/Kac3ZSNzqSIA4vlMXJqkzRbmLOOHkPFJ25VOtWEO/l911OZlDheY3OK1KqzCMrucpAFbXSw0GjzpdV5ybsX4RbZFIz2bhKXjjKR6VRHnwnShcU4Gid7fegkcCCu2FvxWkfnQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099006)(4143699003)(22082099003)(18002099003)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QdYYajr/Y3kNOq/Yp27l2Cf85SX+mo6JjoojyKAvv7LxjYQHJRVbasnf2U5L+yGxB+iY4tBdvpb+ukJlZSgKK5q/ndwzwWL5AEWozUvSot8s5l7Cy/DsOIicF+3qQRwjc4c9uHDRDUSdjINQXvxwYcXHE0I/iliSWmB9RpEfvCZZG5acBxr7dpJVKcq5XRdp1VzGwvKP0y7AHweACL92U6u9r5aepIUEN+bXvsR5rqBFAgtbmk3a5i9q74jeaW8uHoAuwOfgC/7CGGQs+jWOCwW/8bZx2/O74Oj1AsYtbO9iY6G43QVuOd69gI/XXrWfiWzh913w3se4XRmXbIuHQjmxeWZ+llHMuvz1WzRaW4VQEwXTWTmXSfGfjy02V3pyvzC7hXxXE0mQG/B9cJ1FZlTMNqR0irB41xf7WnYPnyvwcczihPq2gNNah3mK/G6C
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 20:28:39.0128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 884e8271-9a8b-45f0-9057-08debcf7b3ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9630

On Wed, May 27, 2026 at 10:14:06PM +0000, Pranjal Shrivastava wrote:
> TLB and CFG invalidations are
> elided if the SMMU is suspended by observing the CMDQ_PROD_STOP_FLAG via
> the arm_smmu_can_elide() helper.

All the arm_smmu_can_elide() call sites here would eventually elide
the commands in arm_smmu_cmdq_issue_cmdlist() that is already gated
by CMDQ_PROD_STOP_FLAG? It doesn't seem necessary to gate again?

Nicolin
