Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFBF359A89
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 04:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781672101; cv=fail; b=cLqVTecEqgbRvnyprAPVYHQwFc/HRNrlDui/plHFYCWbqTaouxDHWCnJAQjceAMxZ1+rjy64j9iLm12jqSh81KwlW1OMDe4ztQMKg1QLuPGp0EQEkwMghJ/nYe2kxbIyvGu/gzLrowmapsLbNDHJpEfbWsEfpu9lVU2QVi+tkb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781672101; c=relaxed/simple;
	bh=268ck9L48tXO8dDEXpAEwvb/Hyj2HZYV9ydlYgUWAY0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ls+Z8YTyw2U46QeVGL1WYgpGYEtMXgFd9V+If2Ok6STLRB5E5Ybv4gwG2ZfcQSg+6qMBip0WbNU74M/W/VIo57ikmAu5CQrxdlsx+twYQt3Kn4SnzCTq6AirO6LYMCOL7nCcLqablN3oG15mn2tbsLw7nCGI+f4z/dd0r5869yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EF6BrLty; arc=fail smtp.client-ip=40.93.198.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EF6BrLty"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuoU2Xm3iTbaxovgd5k5mro4CMz4BC0wYzhbFqkW6aqfa0WeJFs2B32soo6JEk37fI9jacA28259/ugM46cqlVcLp7Hu83yQYp6s3I7TZ2eSoy4hY/UmhwRthmKwpF9EgL32cMSBlIOX/YuZB2ta8ismfLYmgCIUVlYQxNrPaKwcstD5jx0hwVuIf/+Uah8JrjCutiyah4pYB9x7ty6Opsnr6UYBjoWvEkgavjW4YE8Q8WoG1ysNseVITQqo3f0MWU2C6H/HXuzNzmWg7H/Zi2wcl3Un3uPJ3Mj2+6tcmDCgpMHk1JmaQ/kX03U61uHrV3904VK/WmDkZQ2XUYSuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGjVQpYidlJu6H/8R+EnCqOFRjs70891uKWr9CY8ZKo=;
 b=GOd/F12EYfYpA42FImPQ29yFZi49rHoKpAR+MtyDMq+ZNXGUfbt4ABzf/2SzaIoRemqiy7nYj5+Jd8nSFBZsJC3DgeNMaRcWDXbp8k5X5RWGkRBQLT7hb0aHOTKw5CTrddPZfCSX9ZVBZxBjr+7ticBB+w8nPSw5Bz7l0xpY0qwvLZNp0xca3hrjDYF5wJ09P1Yu5KeLGBDEtTxynSVaSR0ciFqNF3Y+ht//UpALo30h+9WiUxptflB3F6/pGtIdbV1F7pWCXkaCVbqJIK0T/E2xrKu4HxT1SbCFbnZbdRKPRNG0Mvi9YbWDITzzIJr/B5XAbQaS5uEZ+cZ1L/8e/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGjVQpYidlJu6H/8R+EnCqOFRjs70891uKWr9CY8ZKo=;
 b=EF6BrLtyHUNqS0PgkZNTzdAf1pi3kcX+ZXkqeS3P3P5dHvEo0HuXr5wRvGClfymxOTFaYTVsCJ6IWWKJaIXtVuYj7BToHA+iEcpEl963ge+/HtN0ibaolkiQJ+f1x7Kkrvz5ILk3p/xrVm29tlEp98HNqRWofnNwsqIfA2RIULsPEpvhhDYshIlSJPEsWWmjrsAssXRCKJ4xFAXb1yAQedqn4f4upKhKFAm3dwILX0LF/g7Jyw4LrjSQaa0KRQK0EEPPz9eug2XF2+/v4zVyksZqqu41A6L1NDPqeYCxL6G5EjeCCrx/9/fkDu0H4fVIJJ7QCWrUeeomVtseMu6LUA==
Received: from SJ0PR03CA0354.namprd03.prod.outlook.com (2603:10b6:a03:39c::29)
 by BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 04:54:44 +0000
Received: from CO1PEPF00012E63.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::62) by SJ0PR03CA0354.outlook.office365.com
 (2603:10b6:a03:39c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Wed,
 17 Jun 2026 04:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E63.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 04:54:44 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Jun
 2026 21:54:27 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Jun
 2026 21:54:26 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Jun 2026 21:54:18 -0700
Date: Tue, 16 Jun 2026 21:54:11 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Ashish Mhetre <amhetre@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] iommu/arm-smmu-v3: Tegra264 invalidation
 workaround
Message-ID: <ajIoc+ek3S1Vycxk@nvidia.com>
References: <20260609073204.1760077-1-amhetre@nvidia.com>
 <97b4dcc7-3ed3-47eb-ac38-51fc2dfb6480@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <97b4dcc7-3ed3-47eb-ac38-51fc2dfb6480@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E63:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: a64973a9-945c-45e1-9daa-08decc2c8c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|30052699003|82310400026|23010399003|36860700016|13003099007|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	5OUIdOrwe47eAF2iWd0k3Tdn7cEWjb0emnMq743w7zXSkfnR71/Mge1p8z3ANBilu5H2n3yTffZnyHq41XmjXxhB3cbwb/tIsiabcBGZwW93vHETP49jLZ3rS+IBhcnHlTb93w4uTLnIQX86bQj4qM7g0DqRLlW8Qm7I48eZ6MHTb2UtvIlNXwGyhSGXIEGgqXEW3boQGvhXKysjRAzJy7aSqE/4uta6Ybr7gHf0K0NxlcXw3ejBkxbzqkZH2clWTSwaEeEhfL0fcMHO35gM/RtWdIjUQVSgxT5Wuf63ZyvB2Z7KP+vbh+WX8vRjrNvRxKOLHX2ZPrUr0OB0AScoUhpUi5s0veYP6tJ9oSrpker8nu6XnT97TRk+wgFiHnsae+LEo3vm6xMYDXAqE4bU2IUzP8uhbUil4ngnwlLoriJy1HLXXrHrxnQjO7nuz6Wc/WcKhMEEEa+wQMnuv9zPTiey9obBH4Xn6bR1qpoT/8CBBOe2oC/daTBvgqDrJ/BGjpuPaNDIogWxqrI6RZf2bJAdEYuyY5TBHsA/qS2xAX0L9ry08I/dZ0f4SvMvwtFpC9tJLlfP5A4GeuljXOwiQfTsURa9rdgJigu/TQZ0TIw4skEWZ3FcBhZE4qL5bQKqH+GSmouvgUTa0OVV+g/808jYyy2tPaSX6PgDVXI7QBlqovisGaPtFREpaGWPid2xokweR79cLzkNmZTopxLcyWhOeTMFS/4bXoe3E9sH49w=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(30052699003)(82310400026)(23010399003)(36860700016)(13003099007)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	i1vo1HyTbAVsfQkgtbcPXlLBDaEYyPV2mIuaJiJP1AowQmIhkavMGPD6AeaOelbRvsUgbjEGDNkcnMdvx80gBJnww65Yh/RksKxbQx9c3DrBKy/RRcp15ZEaKhMi6GPShJBwE9MhQ77gOh8yGvy4lJjrBLEplX4o7fD+YzMoyQYiXfXFTKqsSZBL13wBF6W/yNoEBTzl3gsu9rUEybDxZT63eadt1Sne7m9FRKLAEX07c/o8nBi//tDXrsPBE98mmT691akFmGT6PRNFyuW5sYR4SLARqCuJsJCKadSrn2P1q/YxAkZU4dbceyo6KYvARx26EFvUWbACtxpTY3HuPKF3hBLGGugZfKUc+qX2KM8BaDBm8YvBw+tAofCIBYNPWd3dQB+L5+FybEVZaylYoi0PFuebWAfoBU4EHZOLGCaB4jbZNSIp3JmPEIyNs2Uy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 04:54:44.0847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a64973a9-945c-45e1-9daa-08decc2c8c92
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706

On Wed, Jun 17, 2026 at 09:28:10AM +0530, Ashish Mhetre wrote:
> On 6/9/2026 1:02 PM, Ashish Mhetre wrote:
> Hi all,
> 
> A gentle reminder to review the patches and share your comments.

https://docs.kernel.org/process/maintainer-tip.html

"
4.2.9 Merge window

Please do not expect patches to be reviewed or merged by tip
maintainers around or during the merge window. The trees are closed
to all but urgent fixes during this time. They reopen once the merge
window closes and a new -rc1 kernel has been released.
"

I would wait for rc1 to rebase and respin.

Nicolin
