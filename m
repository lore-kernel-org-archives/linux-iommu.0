Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013032.outbound.protection.outlook.com [40.93.196.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F7E25A324
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425189; cv=fail; b=L7gTxj/+JghA6u1preJAZGJJvalNW6WT97IxQCbGLFcbITkXh6YXhGuBzekb5Z+t6rvE0NlaIGnoBs40LgyaAT3/hoO5KMcPBGT3vrgfUjlXxNRd48SoWTr6uui8cVk+cErSxw+wrxJfplvEsioy3CR8NHBQlKNJMskacq2ksH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425189; c=relaxed/simple;
	bh=i+9HwjUXM6WqRO0ZUGI/3ckzxXpxSSuBt2Q8wzUb9/E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKSlcr2AkZasUimYhwgOnk9NkPEoCKMnhSkqmseMlg/LCpJMBCdiabrx8vW90WIHOvbe9DB8OXGKogGFSlsemH82b0b79VO/phEf95PqbpAmBxP10HBMlj1mn9p2uTxbymY20/ettD0IiubBxzLw4NiXyudblCdWJ5cRxBKqqjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bFYeYwlg; arc=fail smtp.client-ip=40.93.196.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bFYeYwlg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsgrQ0pcWoW+1GniyFKejwbnXQtFaOsTygt/gvDOh4z8Nxljit6SuX6CRmhvJj/EAuzdXJI4m8qcCZd/lDX21ZtQ1bzNfOMb/MRkqKFn/Zn3itm/AApDAdK9hpKl2LQeHSdOTKnBvabaWTQm3dgAYAvI8sjcZUIN+q6Tn0X5gUNsrJCm2aEzPJU4ckypaifF0PMzBISsKrr3TwMD3wptRG/xCJetDSV+nGxGQkNA9cbfXr4xbM2Gh/DqLjqjySrJhmkKvOdULBuq+lw/5KFk7jbZzP4Bj4z8wLjfywyVNAQ7E/8Dy7Ccnnj2lDQiVflCQFkctR19HS2mavttJj2vNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQJrHIPaV4A5L8F/WApLJtVbNLAsgzz7WnF4MOaRZxI=;
 b=lX61SlKeater1HzJTV69Sgq+/bof+01BflQeriV/haXzQaXCD4ukhL8hJG9qphRqR51WfBTnNmeArIwEjvZn9/wlbzIjC0V/0AniFtjhFyP286sswdkQHTO3ihfbum/YHTWitJ0qwIQSyfasSB0yHfYoen8Jf5xmuJPBIxHLgVFbdlbWjCnzboc/wDmr7XkcawsXyWPsfyyZFmHi345IKSfiv11IPaRYzk/uviQZGG5FpZ4YDrtIcCT26If/7YtwlF2T5LTL+aU6veANUDAfGMpwPsgE/OUYH073qCKb2BKuqR1RMNvPU3Ldh2n9HfAx5yW5RV6KT2M8nWmkswcEjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQJrHIPaV4A5L8F/WApLJtVbNLAsgzz7WnF4MOaRZxI=;
 b=bFYeYwlgj6p7+DrHijrB7jko/XYslygYyu0e+IYJoRkvYEzguRwGV2i06jwt4zpIH9jolArR2q/V6sj+05K+aYZgW7xCh5pvDfSiw/iN2WMa4bvkURRENZ7wKyTS9pLiLjc3Oz8rz11exsVwWkx91bCUwigsxkifvX0ltleV9K9WdyHJkYDJ7BWFNjLm8Mm3RSyUxjL8ETcSdWIgCQepDwWjvy1CsumV3GPBl+doCR5MWVnqcMQIIzSlfwaPDPkvf8+5z5bejPZAPHbFdCmNM3D8Of6vqYyphK2DrD/vACGd3/agnnhIJByBKd5mQCdcIhWMjuSQyyjRj7DEq1jDwA==
Received: from SJ0PR03CA0057.namprd03.prod.outlook.com (2603:10b6:a03:33e::32)
 by PH7PR12MB6738.namprd12.prod.outlook.com (2603:10b6:510:1a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 17:12:59 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::18) by SJ0PR03CA0057.outlook.office365.com
 (2603:10b6:a03:33e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Thu,
 2 Oct 2025 17:12:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 17:12:59 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 2 Oct
 2025 10:12:49 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 2 Oct 2025 10:12:49 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Oct 2025 10:12:48 -0700
Date: Thu, 2 Oct 2025 10:12:47 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v2 02/12] iommu/amd: Make amd_iommu_pdom_id_alloc()
 non-static
Message-ID: <aN6yj5YYSw6n6szE@Asurada-Nvidia>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-3-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251001060954.5030-3-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|PH7PR12MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: 8709c0be-8988-4019-132c-08de01d6eff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GoUEPoR73ET32svK4scUhuN/Q53buRpcjRcMcyfl0n7xxhu+qgFBMBk31DKt?=
 =?us-ascii?Q?NiayDSQTieFw1dwwyKc5Sp43FEBSPivOB2XGYOhoRhTUdC11jmZTejjxtjYt?=
 =?us-ascii?Q?ChbWFV6+mN54hhzHuwRMT6eLtGiR7zxUfa5LjgDsAj23h08GDoLgA01ijHq+?=
 =?us-ascii?Q?qrWrkb7s/vZ5RwChpkMoaUv88EnYmVf0cnJKG/exFmGmmo8gy9rYGBQa1ehZ?=
 =?us-ascii?Q?ddxG+swK4JiX5E13fq14E1g8DcOD+t97EmZetgBqtCg/gBIWu61IEyiziiIC?=
 =?us-ascii?Q?x9loqoF6IWRiNBqnE85SkJCheX+8at0IDb9dagRrgyRqV1DfmhaNjQQsCazg?=
 =?us-ascii?Q?xVTqIlknP8IEkYgHP/Grtac9LoeppnDGXvgjWjox0Uh3DHDog+eay83jrL+T?=
 =?us-ascii?Q?jlAL6ls/CuzXN04Ow9K4Z0qwuxEm0P2bCa4jGBYJ8R3DWKunYWMKk97/mmaG?=
 =?us-ascii?Q?j4FGjkn2AW2elZ1aBAQozdeomgxhctaJjeMFURcESwUGvFJQkMk/g7aG20/G?=
 =?us-ascii?Q?WGNZva/I4rbpBSaI8nMiYH2x5bHvLyDuADPUVftRLMLdmyw2j0rn5V/HcTsM?=
 =?us-ascii?Q?A3izfD2tf7VoxzAHOOUUn49U5uV2hWzY98+OKVzscCnhKzCUsExtNsrak3Xh?=
 =?us-ascii?Q?miJG5ZuJ+4KXE/dxZnfKV/NHL0s93FCWqU814vX13HqDKrlzKfa5wwdldKDH?=
 =?us-ascii?Q?AJr9eXDjBFr7QlP4qO9RMUJcgEdU522iR9Tht4XFqMP3zl0b34bxCYzLtZZ7?=
 =?us-ascii?Q?+yGPGLWg0FNacw2/q1V5G+tNtHfRaAP0pDdz9OFGBNBwq128A+CDV7i7HW9l?=
 =?us-ascii?Q?KiJfU8Bbza/gNzRht2ZnEYQifkgab3Y2x1cw71al0PSQdp+n7nwLWGm+RAQl?=
 =?us-ascii?Q?/JqPgKJ6Uu8xHQcJnSe5UqsOJSHqD5MOoyj4/CKCt3UeX6TlboT27v/uqfTO?=
 =?us-ascii?Q?zBnkrvHxC1WqQHf6JXyrsw7TMrhGQsUMYThe57xHtPZzxdtgBl+TEYzwU8GG?=
 =?us-ascii?Q?zd+tpBUrAkm7/uiHlCx/10oKX/6EbZ6ygHqajbyK97hEC3Pz6pWUusrThlax?=
 =?us-ascii?Q?V8GRTx+1PP2NnnkdIbFpRow3vy0W+qRR0FzYIoFTdsNgYubomQLM3/znp9x2?=
 =?us-ascii?Q?ogEaqyFOxrj2lks2eJFEsaseRIX3EzMZnlwy2DFPv+G6QB03abg/8xCI+/JE?=
 =?us-ascii?Q?ICI3gLYt2QbKFLbFxtIKMqgEXiSsAzWfNRI6oJrdmcZSqZ/UrM3G/R+6doIc?=
 =?us-ascii?Q?11QkfVR5T3p5KdvdsdfCCqpVdoAtBKq+b/n6Wrb73Avm3FSVn4TpRUoUrtBW?=
 =?us-ascii?Q?XJ0ei2GWPBaE42WdahuqLfmc7CE6d0XOYTGuftFv+AL/+I9aY2XpUgR5Ga3+?=
 =?us-ascii?Q?eSWepp5fAChzzh4R1v/oE7m5RfMF0RPFIREBuYVrBGfqzOPJYrrdvNMLesC2?=
 =?us-ascii?Q?YsSKBcY0KEk0Cu9nV8R9HuRcN7eTH07mA9Di56nMAFxHcM1ZO7zgoyp8BmX9?=
 =?us-ascii?Q?tkAxITG0nqUz3+8W3ZgkS3Su4LvJqf4qTie5nEObXI0Bp5u0YNLXz4TCqQJ+?=
 =?us-ascii?Q?ZC0gwpk87SaIp/yo1o8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 17:12:59.2850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8709c0be-8988-4019-132c-08de01d6eff2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6738

On Wed, Oct 01, 2025 at 06:09:44AM +0000, Suravee Suthikulpanit wrote:
> To allow reuse in other files in subsequent patches.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
