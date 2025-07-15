Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E701EDA3C
	for <iommu@lists.linux.dev>; Tue, 15 Jul 2025 19:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606264; cv=fail; b=qzs8WL2F0KBJ6kPibNPZO0aaaLndgF0Xt+ptCZq47uD0cd5jON3qwzYJH1cTN9jvL/7ctMjpl4K6IQSK55RjDC8NtACvJttS/vDSzP+OXyvlsfrjmtYmJy5Cm964VbUMeZWoot+mIMmG7lYZ7urnAvYB5ogrQexZnlhhE273GQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606264; c=relaxed/simple;
	bh=2U69TkpsexgSMYvPMp8C0nTq64oVsTO/7BhHjPn+1uE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1k/XV5uWb4hUJB5igZ5jbRo1JsFIOMVduxhEZIWEiq30GY3hBArp692lQBRkTcmn0OMp0W7/D0A0sZkd9OAh5+Sm8GFDo6Xo3eiZqyCnnHXsjtqiS+MXtasDayyvfEsxRFpbd9GqVjuJfSmsaTYz2RNSnYWt1f0VjM4A0T6/yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CfwD5PTr; arc=fail smtp.client-ip=40.107.101.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CfwD5PTr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WoKlogD+YhEMLflcWjqhWHTHMmtzcIdc36QIW4r9YJzNYZUvoSC42e/TmqHd+4hipX1MfUYaUWzwhobjDHd4UDBdf/yyIRgxsphyW4ph2YITXNFzwY5euQO6Gx033i8EiLA8Z+lWG/NuPgjOXIH1VmvEDj8Uhx43itzEHtVCoBYiQXzSAK2USQSa++9YEbokSthiyCaFj/7Fq6lZIOYqW33YhNChfwMKDYbg+iBL5FWcDQkIK4JwVtm7O7LQb5ML9Pi0snjp/TugRLizx1+ViUDJz7fUCU6GqdDwt7lmZOvLGrpgymDgKmn6hgtwZ+M3ZI217tSDiB7SoRbeCz/30g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyYt51aoLmHBc3ki96jf4fNDDoHp4PW6GUfNAq5bcK8=;
 b=Ts1hD4YoWY280vWZDiR0GCVsnWlkZsjPgrDGn3b4IXnsiJcbvc/nkKkjZ+xVmP4Z9x5Ih4Rgp71gb10vxuv5mcS04GZpg0XQkwDBGTYhmOmW8gOx0mj4BPmb26ASZ4bGsUBfFLGU0VjDLHEdxuir44cfNjEEZ53Uq8CeCB2dCb8tr6+csnW5DVTYi2Q8U/TwWoIuO1FKCGs9dC9Jc4hsVGoBeX61TJJ4lxlYEU7HqZkCVooD1Bs6i//5neidu1ztWN3M/rH72ugEBWGCAr1WtvFH0TeDtcoWMM8FvTRbsnNTJmaTgEoT4DHaI95keUVpBXMDCT6T5ZWlyEdUPRSU/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyYt51aoLmHBc3ki96jf4fNDDoHp4PW6GUfNAq5bcK8=;
 b=CfwD5PTr2ji41gSzLHQz4q6ZDCJ9tmRFY+IxG7XQOr1lHbzNkxy3Ajl4ixzT4wEKwOQF11v07165GDM5XV2e13pjaeNV7aj4lbAIbyRZgA3I2pYpNOSax/BidGJhdfG7pldqOZEBiSiHDTzgocf7Ha5KyFXSe/igZJVnEvyMJLEG+Les0smRDG3vgJ6x4Q91ePRDvjExxPs4T+upTJgskWltezrQk7Di7BcVGzMHXXRjeST4Gcpfkvkd7d1LvP+bmg6pOM35FONcP2mpOaSjZVpWYP9FBICnYq52J+vUp4VjHA4tineF7CAe9aV0OBOKrVBLy1vm5cYRcueYy3r8sw==
Received: from MW4PR04CA0321.namprd04.prod.outlook.com (2603:10b6:303:82::26)
 by MN6PR12MB8515.namprd12.prod.outlook.com (2603:10b6:208:470::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Tue, 15 Jul
 2025 19:04:16 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:82:cafe::2c) by MW4PR04CA0321.outlook.office365.com
 (2603:10b6:303:82::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 19:04:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.1 via Frontend Transport; Tue, 15 Jul 2025 19:04:15 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Jul
 2025 12:03:59 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Jul 2025 12:03:58 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 15 Jul 2025 12:03:58 -0700
Date: Tue, 15 Jul 2025 12:03:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <jgg@nvidia.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<will@kernel.org>, <aneesh.kumar@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <joro@8bytes.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <aik@amd.com>, <dan.j.williams@intel.com>,
	<baolu.lu@linux.intel.com>, <yilun.xu@intel.com>
Subject: Re: [PATCH v5 7/8] iommufd/selftest: Add coverage for vdevice
 tombstone
Message-ID: <aHamHHUacDegNDdQ@Asurada-Nvidia>
References: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
 <20250715063245.1799534-8-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250715063245.1799534-8-yilun.xu@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|MN6PR12MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: d2601fc2-c3d1-4cc2-525a-08ddc3d264fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bvFRkj42IMG7NTKByoVf1NSaTtm1H+1tGSzf5WwKxZZNIlv49I1evAN1pyNz?=
 =?us-ascii?Q?lC72hN3FEueP/CIBOjcbXmnHENPVr6oV34K75vaKBO/OCfT5PklnPWw/5u+l?=
 =?us-ascii?Q?wGJjeUIV11VGI5pLqdfv88i3B5TmvrbxFrucPpMaHKB8Cos5pApQH3sEAQBK?=
 =?us-ascii?Q?2BGERxYDKHVblHqW4r9a6ANvPEV25jgYwZzBvXjYiGv13/AYCS5siheCBgai?=
 =?us-ascii?Q?3NiQkqFhJexBLA15yv2Oq0lsCNmg90LFh5rV4XyKImW8tJXcmJMig8zFWPqc?=
 =?us-ascii?Q?EXaHGs489j+P+1vY1wjUsB5u2tmGT9FetIftz6EOQJbcyVQuJ0F3aWZNqke2?=
 =?us-ascii?Q?Qj562VDpZGOWTa7hhun3NP6GtBR015kHRsP3yYxX5yBnLhH0Xe5BP/UTSrMK?=
 =?us-ascii?Q?wKCCKeX7ciNcXy/iTFwuCIXe7NzeLidZAnKRz5Zi2HabJ3L87W0TbHXvYzTF?=
 =?us-ascii?Q?JCV1Y6FCFbIwisT/0EyYPtB62wVUy1Vfir+Gdn8807eDp/5ysaJuMOP3dLml?=
 =?us-ascii?Q?HSh47mxhUJWYH/2YzbehG8sKN71N3KCglOhnY7Po20bU/4GhVQo0RNAa5cBr?=
 =?us-ascii?Q?d/zooMG6UIqnfq4h3IOhnsou/A/rY0/Ix7SSZ52sIYoZGve0vGabvpE0K1oR?=
 =?us-ascii?Q?gAT6biszsJhiEzKl+GK1y9ZlEt9ST6zd7sTe8I97MDPMlLzJxV8W6cq1hDvz?=
 =?us-ascii?Q?JO3kT9WXDi4MfYIENUTiC2AclT8rWiLZsgwknrr0JTgsza8FJUpqvcaEev/D?=
 =?us-ascii?Q?uHjcZYT3wahEbnoeVJiFFz0bZfzTgu+bTDFqteSv6bUNuhyZkW3Bg7TNBafw?=
 =?us-ascii?Q?I0546+WoStvB0QO9EqHzhSIGwKINWCGeohiOsHjlBoRHU39Sh7prQY9rD/AY?=
 =?us-ascii?Q?sH4s/AJfpAKkiBhMagEgAoZ+plyM+ktFW1lDnVxQxLJUzGdun4J/wMz17nCk?=
 =?us-ascii?Q?JXbs1bOwM89AEfXqbQsleW1GZ2Evhv3l6RkEeXNs3IisNQnMh97tlsP8St80?=
 =?us-ascii?Q?iy0jbkPB0XjN9d0rLTyHcm1xeyLHPiLUVCJy1z4Fby4Enui8GKvto/hysIKU?=
 =?us-ascii?Q?msWk8MSv7cKEigOygU2w7GozM+mp3S/G4mWJ5u9e0GZJFHKPimACHwfxKluO?=
 =?us-ascii?Q?CKbWIXpYciLm6Cm+bxKtXrp3Tyi0JdEVWxsIE/oFJ6F/Xm25Y+AapPXo9yJX?=
 =?us-ascii?Q?zzeSve9yVJueUd/6ZI3qDjn6v3u2PElvZITbkAmDaw8l0bckhTt6KHJqsedx?=
 =?us-ascii?Q?K+Y4oN0dNjMtc5sQbNhaAi52e62syCnSrcG7XpOioDWIx9Q5nhqSe81AHTGI?=
 =?us-ascii?Q?SJVTpMaz00QFNBfD03S0+J8PWn030GPgUGUQzW0wk68CTPOht8U/PEFT8H8r?=
 =?us-ascii?Q?3LbkcgCP4cNqDbdiFbi0m4ScZpxT9vE4Mefx+FRmlsqsiwmsQCWjc2rXk7Cb?=
 =?us-ascii?Q?6pbZmKnWAmwqseRVcdSZsWd+TWyXXaSabm/Eti6Zp/RnrODwNe/PCe2FgFgl?=
 =?us-ascii?Q?0RzMlDTNz/OwGX3CeQvXCf58hVT+M9KFqCms?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:04:15.8134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2601fc2-c3d1-4cc2-525a-08ddc3d264fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8515

On Tue, Jul 15, 2025 at 02:32:44PM +0800, Xu Yilun wrote:
> This tests the flow to tombstone vdevice when idevice is to be unbound
> before vdevice destruction. The expected results of the tombstone are:
> 
>  - The vdevice ID can't be reused anymore (not tested in this patch).
>  - Even ioctl(IOMMU_DESTROY) can't free the vdevice ID.
>  - iommufd_fops_release() can still free everything.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
