Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1002207A27
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 12:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301707; cv=fail; b=FCqF+8thi/kizYIexiD9yToOu+nTGUtb6E3gWkIJbQG7ra7FgkOuFq5xBY3QNSJIWefGVhaFpNp4TRwBf3TpRRBzTYhF5ULESOosEaO41UBnkSV+llVLy/qoxK+XOO2N2nv+vdGOpAUmS0kPWjXJM1Pu2WPWBRUTy/A5QV41EUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301707; c=relaxed/simple;
	bh=+++CCbeCty4VGMP1XehXY/EQXZDRGBRz6TeWnX0IvzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hIOoN8Rkeot3ua9Y6YbJX4dwZ+n/DsEqk6npZ0WexDt/vk/8Lg5dbzxOk53AhVR8riGrLhS6irkS/0pkyrjf0oR8XeXQn5xIomUOtkfcQG6xxWnN4W5Nwj2uWTiiEOpsTj+OCL7r5jwluFRjJWL8PMxYR5ixYt8jeu370R5+mQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gN7Tr5xY; arc=fail smtp.client-ip=40.107.102.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gN7Tr5xY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxY4VCpcCaUPTh/CqIXYbESMwfwR6Nvtf/8+HL06pMmv6PJa+IzEzMFDd1ErsY5P5i03oSHvwmQcADRqgRwdZrCaUg0KS+Z/7n1/mrwTzSrrEwzy/UjTtQYUY/TD2k2jpt6Mhzw4d0wlOuxbrzEZ+hFH1uu8/BsrPzAio+0HrFuyPNIbD8MXIgVgzztn/x7zCw/kD882VTejvpVMSlhDOa1zcF1Mdls7pJp8ovEva1Q/TldZwXPlTDHMPygJq+A8u0HD3aJonUeqY+PyeYaVSirfZbhSaTphyw0vzmalKLK929Vicg+hNZfyeeQtWFYE/xqmMXD3/mxT6gP13kNjGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+++CCbeCty4VGMP1XehXY/EQXZDRGBRz6TeWnX0IvzI=;
 b=FRKKAzsCHNbZCG49yiV8uHj0bHU0GPFV+rjvz8CWDJHEijkY9goB304+bQnQm3LfnQtax9EdgDqEDSHEmJehiK4BwKKkipHdO1SoezbacwiiFZzrk9rlebER3gmqM0a63SALq8umLkjg3sxoOL2K+wE68DiV2B0BIBbAGDlf+9w+xsSvd/+syuCKvUxHb0TBtSecp+Mq0nF0kXvs1zXCZCvT8odCz7pO+cZb8f2IXcFzXLUjOzPzHKVuQOaY0Y5sTjWzg/lv9x9fsZzjsDE0ePdwEXePwz+1p4EJMuRML0Aj8cGngZtPRwnqobqM3UjpjOWXi9DKg90jODKKTJR5Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+++CCbeCty4VGMP1XehXY/EQXZDRGBRz6TeWnX0IvzI=;
 b=gN7Tr5xY7E8ivuvakNWd+amQ4RfG1xZPt4UZmoXsjtjvpT1OWWi1TTuVOAZmQ1pQo8DECo4jvxJ7yNO1VpIFqrUxK3FtTPfaa+2pYo/ZINZkN7albaCk4MJ10x5O4/p+nktooTqXuADFQeLNH4o9dcQ1tP2D2n78wa1M5qar19glsF5h1hk0qSeG5QjCInr449mTsBybNFAPlQazgCqk39jmXcJIQnqNbPPdm7hfbMMZpYMVDKwvDtciVaNYqCrsYxmkXyXxwyCJR31XcLlZi/uj5I0M1aoxwCC75GArD2y/RVd2voPQuCXyBSh2oZ61Ck6fVq3vVYMln0/sC0vJkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 12:41:42 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 12:41:42 +0000
Date: Tue, 18 Mar 2025 09:41:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v9 00/21] iommufd support pasid attach/replace
Message-ID: <20250318124141.GN9311@nvidia.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313123532.103522-1-yi.l.liu@intel.com>
X-ClientProxiedBy: BN1PR12CA0026.namprd12.prod.outlook.com
 (2603:10b6:408:e1::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: d940cbc8-faae-437d-d033-08dd661a3c57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wiueyifDxMmiFSWlSoYFSPlPJfgZCLVPrc+cppdY7edj4070ilGQ4olcIctB?=
 =?us-ascii?Q?Q9pjKZumA0Qrdza8bEraYmjXjltNQMBeIP79IfOvF/a9LdN6nQR0bawt8vi8?=
 =?us-ascii?Q?nvGVWV23ByN/mZ2BBVmGd793nBvK7mZTh238trFuQZeqszVhrIIY+X+msg8Y?=
 =?us-ascii?Q?JMMY7lpX+FodFZPsuHVI546JGH+ac8Xdy2YlAbqvP+OelUkshekWOX/uLUv2?=
 =?us-ascii?Q?xYLQlbPpZxAOVAGbIToAkoSmhdeIiEi08H5ifvxs9Iw5UsJEPCbNhW0dTCDA?=
 =?us-ascii?Q?NxU3CKd3ivxl6/0twJwq28gzRPXdUXPAOSoS1iDINo6bo7IBUWSGjW+Qi5Us?=
 =?us-ascii?Q?/zde+CWe/3+cpRNrQ47tcOjb5FpmvKday/xivrgSjSCUVM0IkEjGC+WBM/fY?=
 =?us-ascii?Q?uxG0oripEHQqwaKb9OCTKWkWgJ3ov2fAQlsJrzAY+OwaV+xVObxvPDZw816d?=
 =?us-ascii?Q?PY/zdK2a0Eo2HO7QSKrwDxsEvZhFvpPBvcNxrIo7qGhxZSdRTlVIYZ1wgzbi?=
 =?us-ascii?Q?lWxIapwWIYN44pnt6UKNFrICza1iQBDh2a+6DtQRvrh5gLghbJct/bPXnNN0?=
 =?us-ascii?Q?qFkBWM135CzPoZqgxjNG93YrRQb75zDbVU6YE35LRSLth+rJ4pe4+q5cN0Fs?=
 =?us-ascii?Q?HpMYIyC+ZZxQnFM/JX6xLRQX6Rby26RULj/inkA/T//2xHH4sparDPbCwC31?=
 =?us-ascii?Q?igDoOxuDgQYVwihswIn2vsymlpQ6Krujtyr08wj93p50k/6ZU6DR58pbB/J+?=
 =?us-ascii?Q?lkqkjntMMaLH49DTyJyYFoMqyStFpKb7BiI6nQvTtTBWdFURk4Gtd8BD7kGr?=
 =?us-ascii?Q?z5ESCz5ckGm1Zk/ZyJVJBgIwscbKdHqVdV2G5KxRu+Bv26h67yfNcs9Ux11L?=
 =?us-ascii?Q?chElkf3NYhgGzh3UVFLB3XwhbiV5WaGuS/nIqYi1yK2fPAOXm1d7GzILWybn?=
 =?us-ascii?Q?r4MFoNC/tsM3BuoXg8mVkyhBfZ19GM9/fgUX2EVlzNpciZZSXr8lPyN9Dx2W?=
 =?us-ascii?Q?5HlaANYqDUDTO1lJ5wAUZErT8fwOQ3CkOTZu5lXNrO1AmoNS340ZB6cmBPNX?=
 =?us-ascii?Q?bHQdnbBMzJ1cnVVcv9tn6rjHU2uLp8ADTXB+n8nJHyNwWj2BU4grR/xrvBYr?=
 =?us-ascii?Q?He5pucKYoLrdnovsVIK7y+FEzmeSH9MMzYzxC6muhP+q6V1a1RiEoU23jGFv?=
 =?us-ascii?Q?M2YpJoLyVZ7MsCqhFTRxcb6p+4kV+1aRkPuYxSPB8wanfruN3GknqDf27p3i?=
 =?us-ascii?Q?yty0FjUC40AofYKXMJdHSFlbQRnhbHnU3TcB89SdT6KGVYKTGC9qU+RNFhCA?=
 =?us-ascii?Q?t9zVaJFIfF/ij05w8X3z2z2jN6eaBas+Yi8xgkoV7jrbYnw8C0vU+0JXOehW?=
 =?us-ascii?Q?mVdv44DWD+mxOWZnE595rAnijQuT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zm+ungaipZJqqgEkJC1g8h5Rl/Kjerav/By7ucBF7wxfNAkLcqRmoj51CxI4?=
 =?us-ascii?Q?ThVaCRfa1KBpOxUqLnbMcPvrAcffRlsWWurdpSxw4Av059vm4QVFZydZzN14?=
 =?us-ascii?Q?jNP7E+bunlwxG9D1S5vQuTC3m7ax5AgKGlm5g0brlM2exI2zr8xpX7hHawjp?=
 =?us-ascii?Q?hMPyfxHxFPUDJjhtQZdDQwF7JgrrcF5x+9e2fvfnXBfMl9B7XsyPKJlzsz8L?=
 =?us-ascii?Q?YHs4k0+EZR9ohMZa6WIEghEhJJdpFmyDK5ksFcVM/HEQXKh1DykgaNI/EuGX?=
 =?us-ascii?Q?dSkiHomaySQImA0pSw6taIF+L7ITblBvVvQZCoqo3nGTbdycHzRtMeXIDz2A?=
 =?us-ascii?Q?xsgqt6jhpQn0syVdCr2kCnZxBqxBUa4GaJLfBY7JI0kCYhsmuhTtIsJdlhQI?=
 =?us-ascii?Q?qSmWbIDW6D+GLCXa+RTqMHI0UfLF3IumQ8ivbzkWkW6I/Xh6ibrxsl7WtjaJ?=
 =?us-ascii?Q?ZFMr52PHzF6UZRv/HJZ6mhOsPALMUvowtEm7m9QJ41L4uBSAOPXeQxaz6dO9?=
 =?us-ascii?Q?Y9odkJ6HONSoW1fE46x2QLoGeVhddDIL4ybeMCqUIVFSUosyCm/qGKybVxoE?=
 =?us-ascii?Q?fSLq18t5FJIScgkLULCwYs9P0MVOQEEaaLLmzA/Hs+oJ3M8t40ID15+CmWkQ?=
 =?us-ascii?Q?hxkpGMyy2NJKVJq0ODwyuelTy+d3DwWTGyRK7/2jhMEtKYWmba+jgDE7Ewhu?=
 =?us-ascii?Q?vI6FKzW7VKYky5nyd8ygr9NYyKdR9gRN25TO8b8W7PfXsG+pIkSnP6h6294K?=
 =?us-ascii?Q?jp7orG4GHLdaNqKwCxMUnqlRxF+UzRTDQmapu7Cnl5PuTiyagbTGNxakq7f5?=
 =?us-ascii?Q?lK1bsqJQtjrtY6Lra37HDPSfoFi6Y4P0WO0o1z3lpiIIQfewFRFuJms3Z7vX?=
 =?us-ascii?Q?BMGmHMcmQePzHyNfk02rqengOiju8yDAwxySEQp/LxYL66SJdlkNXQgMwTWo?=
 =?us-ascii?Q?ibWKbl9WP+ZjkKFZ+9gKU2xIiojEjQSTqb39W5BtX8j6k7mTodbwFlnuo2uM?=
 =?us-ascii?Q?23p6Kua6SuGqL5S0lxePZLkrCOqfwDG+nGnRQRt9NgChqgHA5+Tt17Hp1hKA?=
 =?us-ascii?Q?hhkZ6CPaO8ZH+2wm/K7UWC+b342y414b43u5U9dCpbhAysBe0m54DS0XgoUB?=
 =?us-ascii?Q?h7LuUhn1ff7vvIxdTq1Zsq4CbFqMNgjDDdyYyGtmdVCavSaz2EMYcxXg4Gh3?=
 =?us-ascii?Q?UHX0nOmwgOfGISMEu4JXRkhsJz6XnEjNCvwRCiiEI82mbmI3gK1AfejAhOTB?=
 =?us-ascii?Q?BxPTCeExgXdkDp8z5Bhc2dkENO7zq1Ekp7qDiG1BU/NTzkeq3EQRVZwEBaHY?=
 =?us-ascii?Q?wo65xtmvKAAYkzX+xRwls8TUgxRAvDlmMj3tldjrZ3zjdsCi2IU4W+Pd/x1A?=
 =?us-ascii?Q?tAhbby3QZMMsB7ABCt2vepOpG1YLtB6Thugbt+hILFVD1tPnY4TryNGeLOxC?=
 =?us-ascii?Q?WJ4ppp/tmq6t/hlkwkQ6wQiJa4L8lu2rySrKCe4/ssQ2q6tPjU+8wREDN2EY?=
 =?us-ascii?Q?nBsvBYOCTWuUjerzIREE2rSjNM16RxneAavDczhIoGV15nljzYyhiCkcY7ft?=
 =?us-ascii?Q?R8A0hp/NrAOeXOQPCd4j9YP7yvciRaPhyIah5gtO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d940cbc8-faae-437d-d033-08dd661a3c57
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 12:41:42.5676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8acDCIxlgMJTlh8Evs8Pd0Q3WiHsb5UMklrqoVpriwgH7LqJ0BTqnBjzz+GTyL8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431

On Thu, Mar 13, 2025 at 05:35:11AM -0700, Yi Liu wrote:
> PASID (Process Address Space ID) is a PCIe extension that tags the DMA
> transactions from a physical device. Most modern IOMMU hardware supports
> PASID-granular address translation. This allows a PASID-capable device
> to be attached to multiple hardware page tables (hwpts, also known as
> domains), with each attachment tagged by a PASID.

I'm tempted punt the error case handling for PRI flushing to another
series as fixing it properly looks a bit big.. Maybe just code this
series to assume PASID attach success for now?

The attach handle locking thing needs fixing, I hope you can just
allocate new attach handles and not change that design, drop the first
two patches.

Jason
