Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05211BF7E8
	for <iommu@lists.linux.dev>; Thu,  3 Oct 2024 22:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727996016; cv=fail; b=W7StCRklFEcwPRAMhp+DdFg3N1N/h1lNix2WMbTSfvNh91XL5diftLsEXxYGYMv67eebr9s4LA9vYH2MlXm80I4rk+61CTxszv8OQNXDwYS+LUBsctQGuXF3bA8f7TjK3N2juHUJ5zAeDAP+2GoRt4gAu/UaxyjYPcaITA9UU+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727996016; c=relaxed/simple;
	bh=yjblXPRkT5Z4Cbf4hcMxRGAPnQwUcP9K5qwpgGRkDjs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYWRLKzzsXT+gO49G1dFiEffXiZpcY/00pY2rcnwOdn9qb2DuwiyitrLuiVZFw/cI/fr35wSrYAvX48HfYzkViAnT47r85ssqmahptQygLomit7RpSnnB4lztgPdU7j1s2hhOrtWqOV9gvzhYpOd4qpxRdwN/bHsav0xh7KQSNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l2L3bjPH; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l2L3bjPH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwLbrN7V4a6N0g7Y3YIhK2bqOAMyPdFNDyGt7WVrGmRl+its0Rs/ErQlNheQ3yY/blap6ZX97SP00fTJdvpUf+y/pIasJE63CA82wJMysnoFINc/MDRgyFDPhJweKMNPOCimYrILJaBaPa5o1+xEfeK91XFyc/dAaby80IpjzFKh6vME7WcZJiFxSjbQrO+keeay+ZwRRC3GcXlHwxAYKi4uyQxsj9c6UBCGBd4IjZSHPmGKVKxVMbNBQ0LbkFKS17Fup6EAWEPs8cAPB0yu7/HH4FCL88Rr9Q0TXnl0XnkIEu3yhyq9n6uVW/J3kANMRsSRA2mE9QG39UH4r8RehQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWTijxoVo8C4iwSWR1bJDFUda8CQJyg6UcRdKLrpD5s=;
 b=oPQrfWJVRDRDwmE0UpQATdp1k+MoCVFj5QzInILg4sBoxISGjp7xwFquq9ZHL0l7449b2/nC5KYLPy+4BLZUR45cFb3HRnC+MMFjaXONvxeZzVUdyoLnH+fwkOFeagU7a+R3cPdIO/LkX2yMl0ele9IIR7sIgSh+Xfk9fL4wSs36klucgoshiHL3ugSozxS1M0RfpVcm3ZZygO2pLbeyiflmH131TfkSh5pY3q6Bxj/Kd76fyrscImH9xXkHwUsobMIFK5AOa9OmtxAWjD/6ZP9vEpxQ/k9s6oH9Lnir9jmnNGVN9qjT4DfqkulHDLFUmniZkWFvG/2hqlouc8WnXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWTijxoVo8C4iwSWR1bJDFUda8CQJyg6UcRdKLrpD5s=;
 b=l2L3bjPHlw47cXPvxTgpro2CdYYKxXJC7+wtYokLMmfjLrjgx/jFfn9jaN60sJnsElqVFR7Mlfz7ltNFf4/k2uD6Y2qZQnCsZ5F5YlmhARy0bGEo0JXPIe72LaD5qFX0Oenhu1YroOzZYkduTkt0U/7IcYtuNhABk4Sux+EPS1h/jGid4VZnFWHRc8ji3idgOQFdCqg3X0HJy9j+IvRRWT/RkHjuqfRT45oIkIqlFfyhMTrh4LV86AejuLqMuIwLsy8epg6bYgHJq08k1WrArIuXYNS8b7TVV3So4woMUlu1rupWtGgRABJHy+a48rykERpbpxoMhbGKKWwZLMN1HQ==
Received: from BL0PR02CA0032.namprd02.prod.outlook.com (2603:10b6:207:3c::45)
 by SN7PR12MB8028.namprd12.prod.outlook.com (2603:10b6:806:341::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Thu, 3 Oct
 2024 22:53:29 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:207:3c:cafe::a7) by BL0PR02CA0032.outlook.office365.com
 (2603:10b6:207:3c::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.17 via Frontend
 Transport; Thu, 3 Oct 2024 22:53:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.1 via Frontend Transport; Thu, 3 Oct 2024 22:53:29 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 3 Oct 2024
 15:53:18 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 3 Oct 2024
 15:53:18 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 3 Oct 2024 15:53:17 -0700
Date: Thu, 3 Oct 2024 15:53:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>,
	<iommu@lists.linux.dev>
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Adopt arm_smmu_event in
 handlers
Message-ID: <Zv8gW9KjTcktgve1@Asurada-Nvidia>
References: <20240928005143.2378938-1-praan@google.com>
 <20240928005143.2378938-3-praan@google.com>
 <Zvr8xUEHNg1GiA8V@Asurada-Nvidia>
 <ZvxjcpQCFM5SU9P-@google.com>
 <Zvx+6qBY3og8lRWe@Asurada-Nvidia>
 <Zv8N6yIeNXao_Yqm@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zv8N6yIeNXao_Yqm@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|SN7PR12MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b2e207b-9ee1-4018-fb97-08dce3fe32ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qvQ/wCzcXZAROCl1nqB5BL3X3sJkfxyIl1/SeSqvZ9S0O/32HBDbuLg8qIZj?=
 =?us-ascii?Q?gTbgdjbiU7vGBNm36lgSbIC2gFqLqVrPuj0ZmO9ZQXSoTAWBbpISGsYMrsnZ?=
 =?us-ascii?Q?PHpWmLFy9tvckS2Y8aRQJMeKkt8rlUdVWiOtp3AhVaN6VFrlUsldLXTUGaQ3?=
 =?us-ascii?Q?VQ/3sXYFJmqDVOvPUJFAoYJRzxZqbel8UELkGtmG95AAF3a7Pdh9I8O15/qN?=
 =?us-ascii?Q?8Z7S2U6v0yXw8hpjRnttCveRZ6Qqq7gsRMdZLRTj2ZCpHEV+8x9gkBMA1sPF?=
 =?us-ascii?Q?6/TN315y8KHsP1ActGo94Dx8DPWCGQglAhxYh0C4FtyaUleiShnbQXEh8fCq?=
 =?us-ascii?Q?2Ysb/v5M1VZNWV/2njH/Y8QreUXFJLOGO7PQ51QkmZiJ9oFnhEHlohk1wMb0?=
 =?us-ascii?Q?J2nPXwciZp2PEGhtfxifqoyhWNCZT9UqR+iqGV1MUs+9WQ+0p45o1VXGAedH?=
 =?us-ascii?Q?5qgbqFN7KyYyCAIi/J6KECQGxuMHoxE4ShHU9tNDaG6tV6CrrP59VEYFTx10?=
 =?us-ascii?Q?Rr/d0nzv0ldvUUjHAPwE8XG+gK60sUTDAs3iR/7Lkfm6IVMDOnx5DifYAulE?=
 =?us-ascii?Q?avjdq7SK8hHoQ9ySltwsCrHS1dQdgEO5mAvvP1Jj9dFIdt3ZdQXEkn+VWCHV?=
 =?us-ascii?Q?sWrBhnHPhWa19oHyw5m/5DnsD9bVlmNjUjIy98U/+F91foW2SYkf8bVvW31q?=
 =?us-ascii?Q?ik1NsQ2LewWaKa5yBDlvLRDoXITaiX42ohduOlSaVqKkzVwjlFqQtDoBtoid?=
 =?us-ascii?Q?jUuVupmE0Fp6xkPydpWbnhJTYt+UjJkuV6EnRiEpWzBhNJxCaDH2bz0XzB+w?=
 =?us-ascii?Q?2RItqvqVjFVx+27jQHaJZ4AbwAfKDeNs4TQR+Z53sv9V5cdqGBBm/Z1zjBc5?=
 =?us-ascii?Q?1kA/qIjZhCi151OpnKChMmffefaxHS+V30Y+seWF2DEqQphEpsIZ/pGwzy0Z?=
 =?us-ascii?Q?HM3JGqJPidE1fxzkHKQxWgy/iGieCLq/04ORDxY61smIAaWF2IVoS07kodup?=
 =?us-ascii?Q?ZnIZD2mq+o5UUC9wNRkoDtlvpR3TVtmF6eirZOs8GrAME8KXVAeMeH/mgFY2?=
 =?us-ascii?Q?od5uFGyqjMkNI6B/fI0fzEieJs3Vgh5p1oNz+CJNoY4cAKyU2THgLU5uwnzn?=
 =?us-ascii?Q?KVjXT3d2B9aR1dQ/tG8/0e/fq7F1aGwf83hNt/DiQUqBASw2B39DAxaJJZqe?=
 =?us-ascii?Q?QQbUiHcJXxKUa24gBqUmmVSc2dEDfxOaVxEx+oIZyo3aO5xsiMBFp6emBi3K?=
 =?us-ascii?Q?XHQP49yhLAOL5q7h7FjRGgh0p/K/yF9BlSsOn3uDcwCiX7TJzCObgNK4BBEr?=
 =?us-ascii?Q?h0BnBJB2mDioGjtTYGvALRWW3ctttaeNrSo5W3xBIHF8L5A3qRunsNLiTJCI?=
 =?us-ascii?Q?7RAelPokilf363pHRoqjXBMUPDWM?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 22:53:29.3392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2e207b-9ee1-4018-fb97-08dce3fe32ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8028

On Thu, Oct 03, 2024 at 09:34:35PM +0000, Pranjal Shrivastava wrote:
> > The master and master_name are not that necessary to be in the
> > arm_smmu_event. I would keep both of them as local variables in
> > arm_smmu_handle_evt and pass master_name in to dump().
> 
> Hmm, right or maybe ONLY have the master_name in arm_smmu_event?

Just move both out of arm_smmu_event. Keep the master_name as a
local variable like the "master". You'd just need to pass it in
to the dump(). They both are in that same handle_evt().

> > > Also, shall we rename it to `arm_smmu_read_evt_info` ?
> >
> > I'd probably use arm_smmu_event_get_from_raw()? Trying to high-
> > light struct arm_smmu_event v.s. u64 evt[EVTQ_ENT_DWORDS]. Yet,
> > no strong feeling about that.
> >
> 
> Ack. How about `read_arm_smmu_event` :)
> Unless, we wanna follow the arm_smmu_<func> convention?

I think it'd be nicer if we do.

Nicolin
