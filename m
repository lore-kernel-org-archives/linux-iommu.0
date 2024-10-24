Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB2F18784C
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 22:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729809277; cv=fail; b=cqxt+Vx4QZmIi9q/AUFPyMJtKzJ98yLD9NsJOikAbQlw+lhzWfQ1SCcv+Zi/elzDQU/Whw9E3T3h7nmn3k4Vzo8M8oibBqjKfQ9ZdxS4tLSlEvBmmuHYL4JL4iJk+y+d1rBeo9j/7zyW6oKiPbAu3t2A6HcoeXSiiI3AV/uQvb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729809277; c=relaxed/simple;
	bh=e+busQ/fit1RwHSgtgh4sTEvlhQ4Y2zfbMeY9eit0t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XfheYfPtOpxtGsH70MZ9zqEXX41KfbfGmzr0ashL4DI5b1kpfCw6Rmn40uEeJXpUYYUcVulDhsZ0qZ4m5hdsrBzVSk4dxiY+4J/qNQl+ERgPgQPd2nql0yzvqDBn9SLVmNvd967pR3xdOkIY4uaDV44RA6LmT9OjTe4nRhLA0KM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CNx9ThkL; arc=fail smtp.client-ip=40.107.101.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CNx9ThkL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/ANWAE3tB0vIdLFc2HMktvbXiuhlvEZGTZAN8zVPAMNnVq9D8/8q2yEZarXlyfKK56HA9CHKaACgHDsBFLEu4U/hV6KNtYP/G10dCVtwLGGbnUOc0BEpV3GHKPM1hKtVApGiR6rdzdSCJIFgAbLjyqL9Biwtdfoalgi+Y1NFjTTO2D/mZ/qy2JInKPvWhz8z6+UwVsKc2hK5zubWue3F2fg1AZvpZMrJ1YvKmX3jnRie1Rkde2IYHSnp9VUWfsPpo61IQ+70Y0uV+Xi4NqDa12McALba2JwqiXtDuFMzD8pxpGRjlAfdBDo15pGCRGWPgi5rz+ofQ45RD0gBmtTdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+busQ/fit1RwHSgtgh4sTEvlhQ4Y2zfbMeY9eit0t8=;
 b=GVAt5uDR+ezflK7QXOPEItkeJ3yn8QwdsuZ/S+AxORDEISc/k/wud9B/Bo4dPy+U4YRNAr6sngCwb7b5UsTHLiziKPHNcBwWzQhn5+IxN/+B196ZtV5MrRLz55HUZ3jLULejfLYLeDDy47SSEBgQU1C+shRKV6r7zU2o03OsViivK0L7WPomacCQZI9Lt3SKnrAjhVeqCRnurX6Gy+pdKAOL1mTj1MlYxCLzD462m20lpQe17ZGkOMRqMBWVZr3L53H+CmM9YqjqI5Bdwe4wpZQIpbwsZu9+NymOXk6j/xyLGP34/cJxSJ8uJVj6df+GybsyBsu4AP2g1Mhb5fRIew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+busQ/fit1RwHSgtgh4sTEvlhQ4Y2zfbMeY9eit0t8=;
 b=CNx9ThkL1efklV1291sutGyCfWplzRBumMvB2p7Ed6cOpVHAMhfhmQLCZ/ftFPerMe5RtiN5nEEd9ee2BuUtArJ6EnXfc52O/5ruElEaJgydxLfX1eMbTmm6KVEPEYwOX5HxpGjcjUWBEVA0gSMUNawf57HsLuM7Qmm+48o6uICPAnh/JH1vYx2m0nm7afIl4nbOvgWe25t2A3xWjwp1HJ3d4r2uAL8S+0OFkNjwaFiM/j2MPzZC+M3S94QMylL89d4oXCOTiAYMLYx8ZIufXRHNbC/oitNAfDUX1VY1n0txR9PV1mNDqanm6+Cgwl0W2Xw0UOrnwlGv3DtCicHEzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by CH3PR12MB8754.namprd12.prod.outlook.com (2603:10b6:610:170::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 24 Oct
 2024 22:34:31 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%4]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 22:34:31 +0000
Date: Thu, 24 Oct 2024 19:34:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH V6 9/9] iommufd: map file selftest
Message-ID: <20241024223415.GD6956@nvidia.com>
References: <1729783554-56916-1-git-send-email-steven.sistare@oracle.com>
 <1729783554-56916-10-git-send-email-steven.sistare@oracle.com>
 <ZxqXnnANqpeFq7XA@Asurada-Nvidia>
 <e5c4a3f6-594f-40f3-8c51-80d5d03e1ffd@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5c4a3f6-594f-40f3-8c51-80d5d03e1ffd@oracle.com>
X-ClientProxiedBy: MN2PR06CA0018.namprd06.prod.outlook.com
 (2603:10b6:208:23d::23) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|CH3PR12MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec4b36d-d001-4039-06f5-08dcf47c01d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y7FhNWzYBaTyxOkUQ9zblwj52WwKxez6kizyw3tacAubvZ9T62guW29w3ne8?=
 =?us-ascii?Q?m/sf789XC9W+4O12j13ab14K0kD1HvE/5rBRyV5u1bkLlrpSEuoYl9zpOTZx?=
 =?us-ascii?Q?8bYBYE5FtEp4LCYwBvIAgetDtwm92u6IYhjgkDg4OTDzcKjz6nq+WERkWu5Q?=
 =?us-ascii?Q?Lnh2UhCKA15Ocq/gLMWKjfVBhOojbWCFXtw4rSEAJQDXv7ImoLiQflnsN7A+?=
 =?us-ascii?Q?zOW/kOdtWdeypMmYHbBAcuGlxUfSO/Rm8OsQSjRP7D8Fwb7YyTw0EDlQM9ch?=
 =?us-ascii?Q?nTwVocGEU6ToJldiSwZvLbwSCY/9cmveKKLniC9je/I/+tggieXyUPb2w+2s?=
 =?us-ascii?Q?Ea0FOox/QWucOQUCZ+wxu6HujroQtFX6J4FgUaYvhOnoMi7RRrGrBkC+iLT5?=
 =?us-ascii?Q?6QWHB0+VZHlHrOGdwUSVqyaGVFLWD92F/5OInMerwy8ox/ejVUZu3J/9e9Mn?=
 =?us-ascii?Q?t0hxtZndSmmJofTl3Y0zzZvvVE0+mNgpvdZxtQ3JSt0I5Dn6xGWRxht6TSJA?=
 =?us-ascii?Q?uqPJB2pCrPFBX9AhmJlT7+ZxD5l1ZstC27PS92dKn+7juH1n03E7ooGuQYi4?=
 =?us-ascii?Q?rlFl3/lnWsJSFRhDEdcJYngonbVWNdPxINI6vq9oMhRTn+8CYM/gN1/Z95He?=
 =?us-ascii?Q?5BlkIG5NFRXaFN4PKj+oqQX5HspVXKPOckA2aWLfFopsejUEMFDDssQ+hBRJ?=
 =?us-ascii?Q?FfHLyEnnoG7wQbgqUifpUsyBDwjNEcAVL3nRQp2UqWPjqOra7Z7T7XmCGV6H?=
 =?us-ascii?Q?M4136W8CzrlVOT+RV1IcJaNsYVbEWfKcYiuqHQTuVJ1FmiMuboZHTgDX2ty7?=
 =?us-ascii?Q?h+v1Fx6dUhDKjf0zzJwzCb9sFV2C174xGZeCV38U7WSH0wRS2ObV24e0HOa3?=
 =?us-ascii?Q?8tEoZcmy6ZKazfxWS/lEQ7gLM9Gl+HeCCjVjGiigB8iWqY6je+/LOm6v52ox?=
 =?us-ascii?Q?AomuJD7IZHGPR7ScwNF4MtYpSdI40zj6YR3No2XiKDywqFk7F20y8V7kVgA+?=
 =?us-ascii?Q?bPFcVvt6P5JZf0OiXYIG1Ur/eagNHyasGlUe0OsKbECrLuMafszEo+gWWEHF?=
 =?us-ascii?Q?h8ZnNjUWV2iLZv8SvCiS/2KV2joCq6xpFMsQWHpJYqnTJ6MU3WJysL1gnkgo?=
 =?us-ascii?Q?67V/3sBrJV6dPl6LmDsOTYoh/FRu+bpQHIm0ZaFkvKfMbA97TnCCUlLaQ/K5?=
 =?us-ascii?Q?rXQBxfIBr+EthXh+0fc/MEwtFrvd5/beTo8MJl2eshVTVCMrIfsrQOxrDmlN?=
 =?us-ascii?Q?4Q0sN9mzSsJH21b+iFhKn3rAdQHfyEoTHinPEJp1L9XIriaabarlsmkMS828?=
 =?us-ascii?Q?ED5xijn+5Id95236+fQc8wyP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VOcY8JVaTrGGsHKV0exXZ64FHBNQ2/ZW18IZI16m9w3C2sm/I+8a8PU43akr?=
 =?us-ascii?Q?D5kcSln/9YSIWitQ6XmkgYbPaHbm3geO+sAfSHByqc4NpD3qzcIhRfO46hCi?=
 =?us-ascii?Q?qKbEXoopCq2eP+m/ZBRVljpYlYHRuFxz+KL5ztqeR/Msy2wUFzVFKjm21c3D?=
 =?us-ascii?Q?xeDk6pPXfHmZ4Bp6FM1Y8zKTJxguX/NW8RNtLvFFT8L63ZHE5Zl8JFe8mV2d?=
 =?us-ascii?Q?CzqF6ZGqQaNXpk1T5ryd4O4LGreEZAElNfRm3aPvZv4DnhyKY/lRR7fn89be?=
 =?us-ascii?Q?UbebeEiA0L87SFC0jOCq7nOfr/9NEgIB1XxBLXelMS6N/sDA9GLWSdING7Wr?=
 =?us-ascii?Q?9yS/Mw9YT0599POft/nmktJwnldGT4aVpNkg1f7qpvjqUlBt8+vyhRR/Jzjc?=
 =?us-ascii?Q?DCLxdBwPfrsC6ubmWBSEfN71RMEIPuOUz+tmsNd2t+EgsTfaPX48v0mTf4cV?=
 =?us-ascii?Q?lO6nNr4i3rm/G/YOevQnCRqUX7U0W9bhfiwpzBZv//t3mNGPHIIF5lUbV7jr?=
 =?us-ascii?Q?AM1rPvtNOniavVkoyQVN8erHAc35cxGoSkOTTL+hmmEbCq3kWV5/eaULRrYr?=
 =?us-ascii?Q?jLYr/Lsiv2MLQsJR6DxPVAaojYQCT8Bqohs2t2Cl6qLJSRVDakQf3Rp1BOa6?=
 =?us-ascii?Q?iPUMkgZb1kKoXSpqgM54rovAoKZl7WodNHFv5X/DyuJB6FH7Bn1PLJzH0+ab?=
 =?us-ascii?Q?/VC+9qWhdA+OwgfBZugugc+Ow/BI5VwznEXn0A2bVCQjVnwc+MXvGUEl523e?=
 =?us-ascii?Q?ultRWhHNdrq4k6LaIKHqX3ECXKZtL82qXScLLz60MDbzg81s6nkVTwtosuhi?=
 =?us-ascii?Q?nOpogvxwYzflTRJOusa9XgIgRC4DOzcxTHP65igz23Bn/Kh5en4a6UbAaUUB?=
 =?us-ascii?Q?qyhsCuVo/N8lkYeJBmwZpWnh/7QC8khx/0PGH+0Y+JsXMo4vJouUGRYfipsJ?=
 =?us-ascii?Q?COkJRooGEKgC5jgIOBCOoUHJB8gPBkK5vMseGta0Tc/D+Dd1kEuMCZ6sYBiw?=
 =?us-ascii?Q?xp9sAHFjGo4gZpqa8vr85TlZnW+gptx//ugV0O7/GMcC9GLlZS48Nu9DufuB?=
 =?us-ascii?Q?y3iLVmvyhE/A+7Mt8lmmkObQTQqb6nKX3iUBTXzpB9xH2yjM6F8vndRtnNA+?=
 =?us-ascii?Q?vMUnpxlXADLVIyLVMwgTTwgjKw7CLE2lq3P1krfYdUA1fTahXjgt6UKHyaSS?=
 =?us-ascii?Q?GCjVuPT4Pcxp6Hwpip3djWhfuDywoz5IAzo1gWdd+nlwefRN61Z454eI7o/r?=
 =?us-ascii?Q?HAVV5L/ic9JcN7Au+aiyMkSZPnppFiF/uGCPHq+IjY9tdIhsmpya9AHnRFMG?=
 =?us-ascii?Q?TG/7wip6Z+CWe9QENqN2dV0O5rV7zxDCC7Oj7774WoNz+ChbwlE8CCUE3o7r?=
 =?us-ascii?Q?Fbl9uuVYQPoE5TzbY8mBhbi7QikXMpVCFTd30T8huAOq/1EjDfICOOFh2Sdk?=
 =?us-ascii?Q?MD4wk4hjwsFq2GjpaODjHT/v2cY8O9ovYJSumHdeaEEl72EvemUeDSqVVMbI?=
 =?us-ascii?Q?FDaMIsWI7vLfmRPrJBGHh3veFJc/DUeCpVFBoLHCVdmAXQDPcMRagbSIsidq?=
 =?us-ascii?Q?kVuu5OoD/F5vx5sYkcg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec4b36d-d001-4039-06f5-08dcf47c01d6
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 22:34:26.8383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckIaVFRqjBa8f7fUgq8A37QIpH8oYdWfotAguTt9ruT7ScFnEFSV32PKtPdn8Cq6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8754

On Thu, Oct 24, 2024 at 03:14:17PM -0400, Steven Sistare wrote:
> Should I repost the whole series, or just this patch?

Yes please always the whole series it is easier to apply that way

Jason
