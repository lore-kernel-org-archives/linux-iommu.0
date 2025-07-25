Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B052EE5F1
	for <iommu@lists.linux.dev>; Fri, 25 Jul 2025 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460683; cv=fail; b=tMRIEGMX1MYC0NnE8VZc+z97p/tPTlw0lGulC/vJxAOgqOvYSqx0aQlB3S+hJlSILuk8f6zeqaGhEN5QYUw63XAGvrBQbtp4nLBoIIR/pJbipi5Vr7wN6t08+DuumFEqbNaiBc1r/PVUGKQmRgPBCozAIxnHMwnKiPCNsLKfedY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460683; c=relaxed/simple;
	bh=Vyw8V+EPE4NsqiFlphF6WU4lWKwHzEtJbhUeTD88BzA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBEbaEdO279yYBaFwUIHbEeQAzlsQSpYjvTDQDySsaeAzw21ajHhr+K5zWQq5WZolE6QvcrlZmz8TbGoVQGHmPBV7sOD77O/1lKMrx4IjTOpARgV59/NVlR+IgONxiToYy517kjGaSkacTN+hfuQSoF3rJWDYAfq/UbnI/EYeDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jOftkMc1; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jOftkMc1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUZNGG/lTC/YMIbLm4FVlI8iLhpagU6Z6O/cF7bHR2rAUvZBW3YeXJFC36+/b8KnGgyOsQFK1fx6ogbxLZXkzkYo9RGL7UCmvrT4p1JKzhcxol2ALQ9bEY+owr2j2AjAHRrKGkCC0xahwA0N5xh5t5T3bVsyeHJ4JxbS24oUODbTuNm+E5E7ZJuCKNOM6RqSwTSMyIS067M5eN5VDFIICgG/1FR1jzI2vrWZ/VwI911bZhK4DSovwIlGbPoiF4fBkIfdcyoqnFSNigKR2q74t4zqk/kupAMmdprxi2pfxxHmBsrDJN8ufb9Av2I3VyURl45XRWLsLuPxiPgRt9MugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2Osc/J9AktKUOm2ESBbMztYe/5yoS/Ssd9ftnapSIc=;
 b=vxUKbsMsUBuDv8L5PaVq76hQRSL5CT5GZAp0NoaPHxG9ZE1N5huYgX6DKJkzEqkG7MiS9vXrSZkJqxIfoxbfR0TN1Dnk801Sb0k+ninGAbGOAc+TVihxSR7lNFvPYGIGjzb5Lm6ovoYfP1F9Ic5G1InD4RituuHZ0T1jYtx39o5jQsQStAuuTB9TYxnyclotA2oiSLpX9UlZNs+H4Zt9C234sSGpfSDQ9s4AfIAogvj5XEMXavta97qcQM9JwMDxaaoxeW8tGL+DLZsEqwMzrxGLthT6es4gCBXQzemy3OBTakWTw+R99Zc/EqNX2pbtTbl3YPD3o+Ij4hfPARy9DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2Osc/J9AktKUOm2ESBbMztYe/5yoS/Ssd9ftnapSIc=;
 b=jOftkMc1C+rre7LLqKK3FklcccKHjrNS4ddL4kyYPclHGhEBqrFNlJfp3kt9v6mEUOyAhW/afkX9/JOM6e3LLqkTY1ZnWj1MfdFONc/iXFDitnyuavfxaXj9GmkEZLD6bwba/0HgN+3Vu3F2IJJNnLzFOPzM1jNu8Vxl00IAhCZvmQO6cHsmwBA1OVsc7VQv65Uhwjq1vrP5sUCKpjWMKaD7AKXzzgKvQ+7mR+ei0L2YwGXUWkwn7kb0uBJe1asq9oSaohoEBVilxrZ/WDJH/pKLr61sybLp4BhCwsvaQLSuU+lKhhhco49Kw6eL5UJxeFJLyTppApkoor0qbtH+1w==
Received: from SA0PR13CA0024.namprd13.prod.outlook.com (2603:10b6:806:130::29)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 16:24:38 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:130:cafe::ad) by SA0PR13CA0024.outlook.office365.com
 (2603:10b6:806:130::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.7 via Frontend Transport; Fri,
 25 Jul 2025 16:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 16:24:38 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Jul
 2025 09:24:26 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Jul
 2025 09:24:25 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 25 Jul 2025 09:24:24 -0700
Date: Fri, 25 Jul 2025 09:24:23 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
CC: Pranjal Shrivastava <praan@google.com>, <jgg@nvidia.com>,
	<will@kernel.org>, <joro@8bytes.org>, <robin.murphy@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Replace vsmmu_size/type with
 get_viommu_size
Message-ID: <aIOvt+atxTQp57R/@Asurada-Nvidia>
References: <20250721200444.1740461-1-nicolinc@nvidia.com>
 <20250721200444.1740461-3-nicolinc@nvidia.com>
 <aIDlsUvF2Xbdelvx@google.com>
 <aIEkZoTOSlQ0nMKd@Asurada-Nvidia>
 <aIEwzM7mKUI8-h9U@google.com>
 <aIKd1owebUNQeN1-@google.com>
 <aIKqaGMMpsIuAVab@Asurada-Nvidia>
 <aINL66r_1NO3Nx-f@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aINL66r_1NO3Nx-f@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|CH2PR12MB4040:EE_
X-MS-Office365-Filtering-Correlation-Id: 504d02e5-a138-432c-3d65-08ddcb97c036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lwPbCUEoDWaT2re6UFvXZRBgFG29p9bExk3yTeUWwDKB2Uwyje9+0KWIJwAl?=
 =?us-ascii?Q?3iBjOdehbZihT1mVh4uescvJ6bDCJCme8Z4h9bBc2iTnmYrYYJzB6B3B4nwv?=
 =?us-ascii?Q?XW4ypHigodUGYd/VN4Xr8rwUAOoypYsJsVmL4W7yYHj9fE02QN3WFhN87xqq?=
 =?us-ascii?Q?w+ouUpgLYaqGo/zqBZRSDgxZmNkDVF4LD5QvIEMqwSDqig2KlLYIuvJUNpHJ?=
 =?us-ascii?Q?BjzAXyV257qnX4bu3q+1IRODbrL8PhfhEGt8VffiCE+Eo9imnKVUrnJcIka5?=
 =?us-ascii?Q?KQWE1Ee8cB9j+NCpvT3B9lLnT+4kcAjQ4mm1e9unZ2UKu7iI+8mkONFs5SG1?=
 =?us-ascii?Q?xHftrSrbylS+kc+RMD/tSxcfu5Wz9+ud1VKzDZ9o+kGe2JXSCUawwbbY2SNg?=
 =?us-ascii?Q?eHtxEEpNcOV7ePZwBrjQbTLy0nT7MxHstf9BUcL08QHL7ZN++wPNLO3N5cng?=
 =?us-ascii?Q?3DMT3WmRtBKYu6X1VLZhm/lBUENx6eFsSYjvcIjtxB9oOAi3F1EKYWE2ASG7?=
 =?us-ascii?Q?30RX9YGpkef0AYM5StOVpw/MsinECg+w4IyReJs7MJ2+gcY9hcvGhDCI2k67?=
 =?us-ascii?Q?YekiLjBcoqz2XQoBtDbozqbNzvEmAVrEK4px+CFJsBfZNyrCeegjFDWLf/LP?=
 =?us-ascii?Q?A2PB2TR0+4GPAD3D7nNpYSv65d0+eOKcULTHkpmIg92l/LFdAfXBPofn+cUi?=
 =?us-ascii?Q?X4MyTa6w1Bhp0aZLP0Jl/p8jB/f7ieDhiu2AktDKOWuIdP7mMhH8g3ettnoA?=
 =?us-ascii?Q?onJnPGqzytNdK8Ke6xlLiJCgGS7iuDANDgWAm5TIs7WjlpDqQPjcYE9q18T+?=
 =?us-ascii?Q?oeWRN/KtWThPLJrwPV9en2/fauVWY+cUWuRo/l94ontlRUgTGzz3SOOFVHDW?=
 =?us-ascii?Q?F8W858zwQDZKffbP3kIGdSUgeAAnVmbACDYm9WRkr0wYWbxtzmXq/YQGG08Y?=
 =?us-ascii?Q?P7bB5jXAk+DGzB5VDzW6qNJQOW7uHR5h5r1eaGm6hiRLVNBuYXa0gdIcTseT?=
 =?us-ascii?Q?z437n0AiMKF/xajhlJAWMbMopMG5nBmSmE9Qo+AwMI96Wy4kUf+ATwgTR4gH?=
 =?us-ascii?Q?CUC66qRsgfYtjQm+lw/A6b7yKnqTz/+ia+1LArtW8MFT/FzGvDBZkip90LGo?=
 =?us-ascii?Q?2WWnoUVn+T9pWZwm4tp4FMyDO70jRigMJTXqgWH4fsrg16zecRq7IAAZnseL?=
 =?us-ascii?Q?SEx8+/ruE1YXM0HunIIjhaVoUbnv34/UeXfWuS8PGtMte4Bc3+at1Pz33EKZ?=
 =?us-ascii?Q?7/h/yfbJD0hgbOilTfrIK7kPVyAyoBxDoUnaSRCt1STsfEvh01yztpNSCRVh?=
 =?us-ascii?Q?O7cqjR3hk9PI49ER0ojyu2Ff83EeBM0KM2KPL2t/9Z2iaFFAJOo7A8J4Iy2j?=
 =?us-ascii?Q?aUu1InAK1tWIWJ9Vh1Det4bvtPPqqc0vd9CH6Dh7KV/iU66ya6UbxSn9zMm0?=
 =?us-ascii?Q?FiPUk6EigxfD77LfLPsGRn56sIvGlOns2u4fiyTMwOUfHvQKE99J20Jwlnuz?=
 =?us-ascii?Q?yAcFcS5khneuvwdEGUYQcEPm9NbsYgKKmFvp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 16:24:38.0329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 504d02e5-a138-432c-3d65-08ddcb97c036
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040

On Fri, Jul 25, 2025 at 09:18:35AM +0000, Mostafa Saleh wrote:
> > > > > On Wed, Jul 23, 2025 at 01:37:53PM +0000, Pranjal Shrivastava wrote:
> > > > > > On Mon, Jul 21, 2025 at 01:04:44PM -0700, Nicolin Chen wrote:
> > > Had the
> > > vintf_size rejected it, we wouldn't be calling the init op.
> > 
> > A data corruption could happen any time, not related to the
> > init op. A concurrent buggy thread can overwrite the vIOMMU
> > object when a write access to its adjacent memory overflows.
> 
> Can you please elaborate on that, as memory corruption can happen
> any time event after the next check and there is no way to defend
> against that?

That narrative is under a condition (in the context) "when there
is a kernel bug corrupting data" :)

E.g. some new lines of code allocates a wrong size of memory and
writes above the size. If that memory is near this vIOMMU object
it might overwrite to this vIOMMU object that this function gets.

This certainly won't happen if everything is sane.

Nicolin
