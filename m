Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013055.outbound.protection.outlook.com [40.107.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D4452ED2F
	for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 21:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791926029; cv=fail; b=Kbel+ZQpnhqcFaFZ9vYi4vxmSH9yoYWJZWkRYbClLeQs2/WSlQZGRFYJ1gsDsvVlufABaQ2+l1w5IMW/pSe7rbyRkTX3YbLCgyQUNz8cI8CYPkCPK7MM2pXUxSpw2in95g9Mx5fHB8NUzFgnfqSSmCK/JFH7QG8t3DNNeCBqlqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791926029; c=relaxed/simple;
	bh=7ODyk2w7+7ifoUt9M6MCcY5QDmg0b/pGbqdvMVmONe0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twPZbJOHJ4ILjlH2aimlT1/yvNVy76m5qjy7iZdMrtWAY0UAFyOYyJApqdnICiiWkxKLdPE60IWPLh+tqg/ZLK7XgKlyzOOLTdn8wF2RtsxWlAt5uIbiB/y7O/lZMY1pph/51EjvlIutQ69W0GRbtBcRJ6RXYrh1bYKeVVvLKXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EZKhJvzO; arc=fail smtp.client-ip=40.107.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EZKhJvzO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=effe9uk1lT6NrDjpcWY65WgViE41jaNsEcyDxc3NHsWasQGr8ltec8XC1o3K+hAVnvupwM96KrtnEQq7sT/46byGMksSjE+V5Uaa84JveW2VOeUyAHJhNATFshjbZekQwaZ0bSBzrU+1T5A0rpvJLJKGxH1h6pBedoK16/EN0Bq12XKpVAhJJTST7zGjOm8jJGQqdnmonopyE3hdzXobGrunWKLSdF+EyqxMLChoNZQ8lq3+GP77SE60cJ0tet6UNea0wdB84riyKucgyG8Jr9Yq+954S7avsgVQ8czYX4SEfuSsVKKNDSyfg4cD//cArjjc9wmQteWjpoJfIhm8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCzf3nigzmj9p9zdvUwt7iy2Q/41o0sV7RMj8YsmQ6o=;
 b=vn635V38g5eSWZidtUjbvR540U9Zt3iNMjuN5jchefQfNyYuzoE75mGe4NLETDf9A7A9i6e6GodLcUSUwkxrOZIxhmYkk+oWqaA737lfVvaUPmRID8zpXM/kwWyH8kq2ZsNAYvvBBvs7zg8V9McioY5Kfw5gniZzFodGO/n3DrsK46McXg1EoymR4doGRR8aF4e8l9GBJIwmdlgf32nEcOd9FkIsRo9qQ9lxb2be2j1xsJVnllJfn903gJdYQKl99vNq4ty6mvQjULxp5z6xvSZD0Cfau3hC+pB2vAf8AklnhQ3m9hxlU45rr7HC40iMEF0RbNucZ7pdRjqHAEo2bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCzf3nigzmj9p9zdvUwt7iy2Q/41o0sV7RMj8YsmQ6o=;
 b=EZKhJvzOH5KXPWi/nJQUqcC+mvioTDf0nR3PHc0mJQFUw8hHEoTuGKGRa66hVF6hzD/JFgY6DWzYpJ2AIxdSYMPACnsm8nsDzcQ9XXBcBVUmzdk0qn14TytsEvqkPNKwiALvLTxN6xf4842PjRapXM0JmKdifdgo4UoCQlGGy3orDucSR0xZjCGzguvXvDdoY4lJ5aO0k3hiLy34QJeVcQQxZIdiGBSIJfnkvFAA/2wS0m24HVLThpIKn5wnQ/8J5UWNfxMv6raqXxu1MbkWiYZ7HqSGCkRZDf5q+mm1GQQL7qW81ywVGfixmcJwfIFWzhVqMQNvxb5GSxxL3RQFRA==
Received: from CH5P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::11)
 by CH2PR12MB4182.namprd12.prod.outlook.com (2603:10b6:610:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 21:13:36 +0000
Received: from BL6PEPF0006C3DB.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::16) by CH5P221CA0020.outlook.office365.com
 (2603:10b6:610:1f2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 13 Oct 2026 21:13:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0006C3DB.mail.protection.outlook.com (10.167.249.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 21:13:36 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 13 Oct
 2026 14:13:08 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 13 Oct
 2026 14:13:07 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 13 Oct 2026 14:13:05 -0700
Date: Tue, 13 Oct 2026 14:13:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Samiullah Khawaja <skhawaja@google.com>
CC: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy
	<robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, Alex Williamson
	<alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Pratyush Yadav
	<pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, "David
 Matlack" <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v5 02/18] iommu: Implement IOMMU Live update FLB callbacks
Message-ID: <as6e39WDQYmbW5Jn@nvidia.com>
References: <20260921004834.2601285-1-skhawaja@google.com>
 <20260921004834.2601285-3-skhawaja@google.com>
 <asWEtTcNJSbrY579@nvidia.com>
 <asmj6ErFqQMJe0_u@google.com>
 <as16hl29Kepg9AcT@nvidia.com>
 <as6YpZ7ShALy5dd_@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <as6YpZ7ShALy5dd_@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3DB:EE_|CH2PR12MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a109ba4-476a-4ef1-9368-08df296ed89c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|7416014|1800799024|82310400026|56012099006|11063799006|4143699003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kwvQY8faNH9vm/jQDsSwSMrgLc5weh6AqeJ8UWLP7vd/wTmvqMyPlhcrD9hbSnXow0bObS0O8p2N6OsRWYOFigJ8YOgRndlOgWLGT7PRhdtuvt3jPboukdSXXF1b+iDqOyvonp+M9/VK4qhnaS0L5st+IFWzPegMCEgibnfM9/bsIjvP+MHOKynlLNLAwD43O4g7/apiqxlKOKDm+fPmEdKbg1s8mp9Tpzi5jsrK4/v8q2tWADby6h0bLPKLt7rE/HLoPBjGaNR8tYuTWFOXZGrLQ7QfaLkwFaCM9Kc4etBnBpHfjjTLOLHofTkmPGRJPT9S6i9sABAGAvGKKfQooXyiPJ8RGl4BNEF7ceFPQqhZbbC8PU019+tj0jhnk9abXfWGgiBCVVn2LXKxYNaXHln9VrLLFowGrW/ogUHXil58yAETx+NbVYuuRuBkJadEL50SC0dpYuTnhkGeeQHapRspxR/2qrkwQzVajSGaBxphPcJ5COG2eh9AC9Dfeo+VZkf/ODHaCXUctYM+t6m6hbztvtD9DduP432I5Ay/VMARKl5qszG7QPvgyNERjfp/u4ug8iiiippDmGGU74yz23C32gQWMWZAIC9iOlACgz2TDhEpdosXioVvRiAzKFU0wr11bc+JXHcYA/I7YH/FN9psTAiPMnV1laKd+Wcxi1NdnwbtQhd2d0z/11TVQ34W3NyLdXLqXlRYKKQbbhDXwQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(7416014)(1800799024)(82310400026)(56012099006)(11063799006)(4143699003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XrM6IvCLkQUbA5Hu8GaaW3n0UFrfIxVB0mCTiuAlohiJ9jgJ7NnZK9T3Hr4gA3dHr5dgkieQ5GyZZIhQiI7u1gVyyZpyNhf0mwm3DYNYmEIWk7A1mlx+jUHyj64RIQ2B1zWfCwDF10b/Ajuz+oKCa0GDKs+ZV4oRrhQshukspDtKPjZXENvL2Dhei/5DsCZu2CYqPjIykHqSjofZ/0Pst9nM46/NhiEpzya2A6ZoC6BjWTA5xvFM8aIvWiTFTfOblU+GgVc2xmScdLeiVQYr7VFrdzBkUm9jo0RUERwbWGI1TUHwIO+U63ApA8kV/s3QjJne0Hu+0zdmOSjtOsINEgKK+W6bdEJuMntwGvTHvWeJ/N10IC8DbFV3fAZWNVSXIuQaERbPDW8xxkNVNJ0NUhADm6lAksH121e2to+CdHs05+Nf9ZG5Vl8v4pD1MMYG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 21:13:36.5757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a109ba4-476a-4ef1-9368-08df296ed89c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0006C3DB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182

On Tue, Oct 13, 2026 at 08:57:05PM +0000, Samiullah Khawaja wrote:
> On Mon, Oct 12, 2026 at 05:25:42PM -0700, Nicolin Chen wrote:
> > Could incoming and outgoing objects exist in the same time?
> > 
> > Correct me if I am wrong: I expect the lifecycle of an incoming
> > object will end once liveupdate completes, and the outgoing one
> > can only exist after that?
> 
> LUO can have incoming and outgoing at the same time. The incoming FLB
> stays until all the sessions from the previous kernel that use it are
> finished, and the outgoing FLB is created when the first FD that uses it
> is preserved in the current kernel. So if a new preservation starts
> before all the incoming sessions are finished, both exist.
> 
> Generally, it should be rare, as after the live update the userspace
> orchestrator (like systemd) would probably finish all the sessions. At
> the FD level it is mutually exclusive, but at the FLB level it is
> possible.

OK. It doesn't sound practically possible. Yet, fine if it's a
common practice to have separate objs for LUO.

Nicolin
