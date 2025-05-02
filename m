Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D959E1DE4E7
	for <iommu@lists.linux.dev>; Fri,  2 May 2025 19:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746214373; cv=fail; b=BLJweAvwolS6Wy1/SZo61VzeOt7mKBHn00Vq1yy7pzJeG9KbCC9N4Yb0a7m8TBf9x44HD4dXTheOUpB5754F5G+nIWcJRcabgl0o1dNhK73hLp5EvZiP0JlI8l1jzvozIzjCOVJg4FsWP9vNORahKGTo8rvNPLCa5fpcAroH6Kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746214373; c=relaxed/simple;
	bh=lJmzI2b1c21Wx3n2y9TsGef1UgqaM0nQMqe7inVDNt8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEl3zj+zTm5ls41ZMCpeYWQZs9mX+IinXAuQ2ipi3MEWrzVkj60pMMgZ41FRt/8cPwgj0lYKPP3vLhJCIn9n6P3viDXjP6+cGN57erjudvr2Zt1A+NqDga7SBgSB0rEz81F7ukYySLztAd8YY1kDkx0EjXXnZz+j6Vbf7cfVCXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n6s9O0E1; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n6s9O0E1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKCM1wF+wvo6LAeTGqxatqos9wuEQdCaBxgG351cqjV8pD+w0KTxKrLoA/bT4LiHvggX5tKATMdVRsGAGBfrpTNcBIe0uX0Vg53kX6ywTERUjhpzE5HU1ePgIuRoCgjvJGUFz+aP9THRz5SvYEKKss1ctK/23jUIQTmNqbEGaopywLA8Dwo02i0SeEcH1Pa5TJn3vFrbLh+PIRTULyY87BlugAAo/APF2cO91tpoeMUNf93OY28tcr5AD+7f1OqpZqm2ug+iF91xjCgU2pEf5L5R71l1J8oiO/hUiLc618Nopi+OGgiQ5vkFEEAFJlreOIQmCAvp98sYfurztf5X7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1iIMhqdCaME6vrBU1SLCll357rUALJiUojzhLxORmY=;
 b=gyRBVjpxKnWIhA3Zmk+b8lKtJep7dmlPkj4b1wDe9saFFlzbC8nVYvUJOh8AN1K2Bcn1oBPzevHWxBzZb2wdCfVBqJCjRyWWlEGue5o+OiwZYBfCR7u1bOZBYyX8kZWwaXhiT345bpTWEvb9V8R5VRgWAOGahiYutm4hxJKZOlHCYZW0qP4qBUnlUdJvsnvUvNMz96g78As+mAQWEFE59TKQXs2og0GqVbZ3VPLV7nFPRLzlAR2GDDyjztOMDxjQ4ATQt0mKFv5hFe2Jj2NMsNP8/1CqslgUAvjSxZ/L3CULk+fHaY4zcSf7tpwHfD95xYEfLc9fTB+fQgHHSSooVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1iIMhqdCaME6vrBU1SLCll357rUALJiUojzhLxORmY=;
 b=n6s9O0E1YZkKO8k+yC7pemKhWa58G8HGg2Oqrh8mJcJ5/iGr4+V6Anb2vndqTcnfKB22t+c9QlK0YtjMqpxRaAsu3xiKJF2Y+5E3Bj9meEYZl3pvZZFh6l3/U9DCZ1XFOVDXH9+q5f0ykfXH5TqJU6LIp20LXI0RBsh2kIi6E6uLZ9B/f4fx1rKvMcOtOorQ7Zg94vQltGhvgLXYdWRqeJ6bMecxJBLywbpQtlMMHrAPsmLJZfhpt4RYusjsEh/X5gwR9pplzUjh1eUxaOnCkYre68NA4soDupwgbO0b5pEByj3zj7sXnmncazS93kyme/0dZ03yQFcP4RKEZw38sQ==
Received: from MN2PR15CA0060.namprd15.prod.outlook.com (2603:10b6:208:237::29)
 by CH3PR12MB9220.namprd12.prod.outlook.com (2603:10b6:610:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Fri, 2 May
 2025 19:32:47 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::31) by MN2PR15CA0060.outlook.office365.com
 (2603:10b6:208:237::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Fri,
 2 May 2025 19:32:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Fri, 2 May 2025 19:32:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 May 2025
 12:32:38 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 2 May 2025 12:32:37 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 2 May 2025 12:32:37 -0700
Date: Fri, 2 May 2025 12:32:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh
	<smostafa@google.com>, Daniel Mentz <danielmentz@google.com>,
	<iommu@lists.linux.dev>
Subject: Re: [RFC PATCH v2 02/10] iommu/arm-smmu-v3: Add a helper to drain
 all queues
Message-ID: <aBUd0/NmzFmeOosd@Asurada-Nvidia>
References: <20250418233409.3926715-1-praan@google.com>
 <20250418233409.3926715-3-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250418233409.3926715-3-praan@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|CH3PR12MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: 76278584-e71b-4bc8-b951-08dd89b01e21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wbiJwdzeeAXF5rhg5bCQY6n+KPBmZKi6reaDmg2/vxk2YZ99GF9TUd8eGzgD?=
 =?us-ascii?Q?F6KgblVrLi+0LkwbaU3e5kLJLWWP9K4FkGD4/jmUKgftC8SvBwDrapQSHbcR?=
 =?us-ascii?Q?h1DSIIr2uBuV1Rzxoumm+pepQ+xXuwrzTbNu7adgHOBCtx86hQSOgI4WJsd5?=
 =?us-ascii?Q?eTYzajZRKraO4LFPVIpm0RVn4yCXHJKX1+H/9sO5fxM/l0Xo/ZmOp9KsoYS6?=
 =?us-ascii?Q?/+Q2c5TxzWzLtezfBrHAdDseUWH0+ENVc4Mu4bsgQ4vhxJwam2WF30k/GXvi?=
 =?us-ascii?Q?htoxdISlRcTX+8zGMiJlTTuIm3K3dMojWHi2xlpOnPxWdHkz+xV6LbB4oTK8?=
 =?us-ascii?Q?4Ob1rkCprzHTcW7LlJWWzhGypTGICK6dKp+4/tobVyG3PjxYIB7DHa1bqzDT?=
 =?us-ascii?Q?EH11aLLEjaMXuCpa6VbVQ7HAgVdda1tsWiuIpAPG0BtYuBeZSKOrEEpXKc0C?=
 =?us-ascii?Q?T1iuSNIEY7RTxgtTZpNk5qCXNjx4I/6Ii5//3W0QZFl3CtMc0ghuuss9lZx2?=
 =?us-ascii?Q?7rq7ryqfhY64IxvSeuStnjF+prRqP1eZFoxMMi2T8+Nf4sC+cXhjVv0mHd0A?=
 =?us-ascii?Q?dEN9jFFwuXA1n0LEDUyWFP6cZVwM2GWGyz1CtnlSfSnkSQITCgWAFqInoInc?=
 =?us-ascii?Q?QrEASIaEE92nmnA0KBmPt/rZwQIAAnBtoujrW+23oFHXBvnD2g8fEnYVo6gz?=
 =?us-ascii?Q?lUQYQlve6H5zAG6WcgJxHqzV5DtJc+zUzaDghdlY1AVTK1AGZ858Iy3UYALT?=
 =?us-ascii?Q?m0r8rF3byeR3axlGiqTI3sFwtUTYJt8Fo2WMnlEIi6iR3Ru9JosmISiJgEjq?=
 =?us-ascii?Q?diV31Ltwht7NVsP2IMaPPMCmEBfHNDMtqVwHXskuPLebu1mJVS2MrhkHRghS?=
 =?us-ascii?Q?wre984L79OjWo5lhjzUmkt1+3/nQCer6B6Bb+E6p9cm4R8INN6XL0d/uL8RL?=
 =?us-ascii?Q?WAZh9h/zfqTn0XFke65L82JZRCRWCtBWLTIxE7+YVwbznP8qlhupFkSsrrHx?=
 =?us-ascii?Q?Mkcela5y5XrqHS03e3kBEpdJ+8Xue1lYuY8mQbfjWHgGQQlQSaZZ/S2UesB/?=
 =?us-ascii?Q?iEj5ADzVaVJbE2Z5mC+y2r4UuCdbw8ngsu6w/3yJMaxRKl4TGzoIdOcblddG?=
 =?us-ascii?Q?jDWl8MThaG1ix44tYa//EtNinjB/kgeIXqEmGLFGhz3QqfsTiLepLJi8RECM?=
 =?us-ascii?Q?RMR8zzxlYOxiTPX3I4RZn6xFPe3UV4J30H94app5Vx3/8ntvJGm4+6eXRu7K?=
 =?us-ascii?Q?odFH29y+hMEZWLmqmrlrll10wHqKfSJsbjCyRcN6FWOHDWC9O01asmKugyd6?=
 =?us-ascii?Q?T+UcO72/MkoGZjaaOgd/fdRWJrHny3CzFhYDKKK+WPPSDTH3eHEZuBTIue3c?=
 =?us-ascii?Q?ixEZ9cW//7JDPJtS2SwKBr9tAqrFdYFs8GbDr5BSo6+y43wDXd3SK3GNXLab?=
 =?us-ascii?Q?N6JmxSjxp1nRa5mun43vlPgSYc4NqfoHIpotUqXT1j0JFfQgdVntl9iYt9V/?=
 =?us-ascii?Q?Veaf9Ciz6/X/o2ZxC3lynENAkOBxVgvflqZi?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 19:32:46.7097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76278584-e71b-4bc8-b951-08dd89b01e21
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9220

On Fri, Apr 18, 2025 at 11:34:01PM +0000, Pranjal Shrivastava wrote:
> +static int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
> +					   struct arm_smmu_queue *q)
> +{
> +	struct arm_smmu_queue_poll qp;
> +	struct arm_smmu_ll_queue *llq = &q->llq;
> +	int ret = 0;
> +
> +	queue_poll_init(smmu, &qp);
> +	llq->val = READ_ONCE(q->llq.val);

llq points to q->llq, but here it overwrites the value from itself?

Nicolin
