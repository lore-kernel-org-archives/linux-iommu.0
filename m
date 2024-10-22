Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6384317C98
	for <iommu@lists.linux.dev>; Tue, 22 Oct 2024 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729621974; cv=fail; b=Mu/lWV9ruQoYsS4eIW31SKSrvbSgd503pNsdQ5n94p83XjXuaFbEyzZcE3hR4q9XQhJyI6VU73xETCFhd3fNW5/KQg2Dsz1lgLxE83xSRuLBomObRdjDzsQ1zyJupyDDe4jYQ+oMMgZwyJnl/mHltctG4Wz/C/JJiVLh5vQuMyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729621974; c=relaxed/simple;
	bh=dLdfGAByM1BD/3QOaBCp5BNaHdwahEaNP0JHwOp9S5Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHlCpuzmOPhabVqZ3leGjilJF+HHYS950fAXyY0wY319ZzcZFO8bidXj33lICge4ksuJgPke1eH7Iv6/qZsm83hAe6GRbg1Dmjm8ko18gxYG6LCJbbfwgL7dmwRV7g5dabDIXAqj/A5AEekJCIywwDEvvilZE4PM0gWMJob4utU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HkHB5baq; arc=fail smtp.client-ip=40.107.102.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HkHB5baq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKKHdqXn8Ki+GDZaaWBff1KBjcVcq5lmY0ldFpOWcs+Ki4xJtJb+o+iC2VMOtmSwL4JEpYwKmjZNFharQJiUUAfmh9/sJaefQ/ZVW4zbNw19pv921DRtp/vzcWGb1glq4l1Q9+C50xvA21YUt0IgLzlD26N8OGl+FfeahiFQ4zFOr94+oSTbFiGFrcB0RbVnuUEIyWiTTBCCFvkpaSgmAgDPOf1seIZZKhNdfcxjIwuFaZlg4GUd0T/ncQRHrHgNC92ElBdFgXWbPansQumYswlgMYTcj5LK7syc5uYf5VkTmnOcIvYs3372M9VC9P+SQvlAkXuwps68FjxcV8VMlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbYk2OY4NNpqebM5qpTlwxzpjR5xQ6TAbdepuwz0Tm8=;
 b=TojShvT1yqpU7slOVcRdt5J9zlpNxP2nL5DSr71J/BU3FeHVRTOhNVNc8CwoWW3zE8q4j02VrgL5rOKdIPEtJP4Wq/5SEZLNMvrBR4QOJKjDBOabnUxbYiI+KDesAuKATSaUT03jLtzxngkNN/9FxYdMsngEJvuzlQClhP7FgnpK3BRbPit4BzGgL5jOsgY2X4yy4BDv9zKAJlV2Y5l0PIjO8XUF3ltEIDA6DGlo3uP/QoMNg8n6OIIGh/9pt/RJ3efc5yXtpM8auSOjg1adh8J+Vu1BBJaVmcieVqbjvxVD3T/y6dKbZ7UVrTyycS65u2yB8jYLpB3FqaQ1otWiYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbYk2OY4NNpqebM5qpTlwxzpjR5xQ6TAbdepuwz0Tm8=;
 b=HkHB5baqMHKmk4zQhbSoP5mUfJNDHFHlQA0ijuTWVN++XgneIxOBOTgTyRRk7Hi403LFEJ+9vTTuqufYCjIJHSXaxTCW+kGPJdcw8culngY4vKWgUKZI4srftgZ12J2hZEzZJYDJIiDNo5sZ7iDql/hNFQOinVl7Nlptm4ONpdJOn8PU5LK4xHADnAiq5ImvDGCc2m5sQMAxCzFSw6rrjYrCDy045PLF4gWGixBoKrQIaoQW0cVFZRhScgkcHg9E4RW6FeDSsrvCmoKWQF5UCwcemSPwRmL+tnuu/T7MbBUXESdvVcisKsyOnyzRTvekm/F6HzJLxR7F684LkTU8Gg==
Received: from BN9PR03CA0887.namprd03.prod.outlook.com (2603:10b6:408:13c::22)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Tue, 22 Oct 2024 18:32:46 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::ce) by BN9PR03CA0887.outlook.office365.com
 (2603:10b6:408:13c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Tue, 22 Oct 2024 18:32:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 18:32:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Oct
 2024 11:32:25 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Oct
 2024 11:32:25 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 22 Oct 2024 11:32:24 -0700
Date: Tue, 22 Oct 2024 11:32:23 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
CC: <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>
Subject: Re: [PATCH V4 2/9] iommufd: rename uptr in iopt_alloc_iova
Message-ID: <Zxfvtx71Ej8znb2u@Asurada-Nvidia>
References: <1729286856-127844-1-git-send-email-steven.sistare@oracle.com>
 <1729286856-127844-3-git-send-email-steven.sistare@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1729286856-127844-3-git-send-email-steven.sistare@oracle.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: 082e7fb4-5436-41b1-3976-08dcf2c7ec63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bO69/LwarqGTy3/tJN5IBvQMUsZMsDMplf69xN9a0OCQlL46IIVjwpTB/Qdx?=
 =?us-ascii?Q?3HlktVVq/h2+wxxQ7YsTVf8VOmVvaHB5k9o4+bcM6szm3WM979XyeH7wRnhE?=
 =?us-ascii?Q?aTXcDbfBYi+aZci4Sq4mXeaG1AD47+8990ZiNMhFy9om4aYgQF3aEA0WSbhm?=
 =?us-ascii?Q?Zhj2JgpsbOz83E2MRv/TlSArUMIr745SBmVDg7ff265y7KO3FJz72/Gl+UmB?=
 =?us-ascii?Q?+I0JCylo3Pw1OBeVX7woDfJfOEevNq+MZx2tsk8giqQqpKbTT+mycxPKahgt?=
 =?us-ascii?Q?JuSpUwhKWxLDNSdnEGUvefbyBBcMvXO5e2akf92Nt8/cQVG6rjyohb+eQ2Od?=
 =?us-ascii?Q?4ae3E3gxafPh2R4XTkPw3anuLKp+EfRuNaJvY+8hPsZKmZi41IKG8/QU05Nv?=
 =?us-ascii?Q?aWzloLc0gfLcNRFWPWgIyMUWCJd8DwR82bklJYWJT0BorumztPDzmQeiNVIf?=
 =?us-ascii?Q?VJLvNZMpluZWr6bPP/NcKRhDHiFk9L0vdbTsHsd5e8x2LaVet2c5d00Pa7nQ?=
 =?us-ascii?Q?2iHx349T6eZfOWmB9OSSKEw4EJfR5ceINX+Sq58+Ate8MG1QL+alLTERvw2F?=
 =?us-ascii?Q?zeBwctrJbyADc2lrCCdj3VOGRde0EGYpG4gp4HG+Q98ireL6+C1ilkvZMNTf?=
 =?us-ascii?Q?QxpyA6U8/aFfh7o33Q6OvuWORLDDEhkxMxbC2ir69BmmQJ8DOBEKCntdnskO?=
 =?us-ascii?Q?uzgh4Rh0WA6HLiJK4uGNg0O5m3gwN0dic4qAPjGs8vq94+Uq2YPsm9Xyht4q?=
 =?us-ascii?Q?gx8AYGeMy8N8vc6W7+X8RwGlFx/7a8RzG7dh96MpayWkvzuXdwl2GawYPmHC?=
 =?us-ascii?Q?BWvPLyxckHDXDlksSiF8quXxPi+B9ca9vvb22bGVlMQ4+vFpZ0SyCLidRzGi?=
 =?us-ascii?Q?YvH1LZM5CNOZEFq83xQDQY2NcfPCBkf7CjI12TZSvOQGcrd2jfg5WOdhyJTL?=
 =?us-ascii?Q?twS1NbCA4l0IVoRKyLQBM3e6TOEZt62NRzU4dOYs0lKlcboczvUb/Ml8SW8Z?=
 =?us-ascii?Q?UgnkfaHMVGRApt5t/icEtG16e2iRGEMSM3PmIPs3n8FAblVJt3adI+zOFR3a?=
 =?us-ascii?Q?L9m6Y7aV/EgmC6i47jOH5TKa6aSiul6bOLi813FzUJ9vmu8WtEMBscgARt+J?=
 =?us-ascii?Q?Wr0YyYOi9atzzp73ap8e6SkdiiqEJPvsaINTUDjH9sDpGgRi5YWTudScn0uB?=
 =?us-ascii?Q?155oSpK7PWURQarFMfbdEvmgOnel2Ms89MQQNf3PUoyyqxsoW4PMOU63pggv?=
 =?us-ascii?Q?HrXBWJdKYNHLpLpMvu9NzxQdgMwZ1DE6o2Zxsg3QhitZyNfsDzuAP5hJSmxv?=
 =?us-ascii?Q?5xlYKtJMEgLSnnsuYvuYj1LZRj4oScfVbro8v+RrWK3dEA3HzgBbGHNuL8M4?=
 =?us-ascii?Q?cWDhTqokGuQihMLKNQ7TsMZmAYStTKcbmYJFpDiw/AElNgm3Xw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 18:32:45.6075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 082e7fb4-5436-41b1-3976-08dcf2c7ec63
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6021

On Fri, Oct 18, 2024 at 02:27:29PM -0700, Steve Sistare wrote:
> iopt_alloc_iova takes a uptr argument but only checks for its alignment.
> Generalize this to an unsigned address, which can be the offset from the
> start of a file in a subsequent patch.  No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com> 
