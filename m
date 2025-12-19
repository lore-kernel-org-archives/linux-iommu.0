Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915EC2475E3
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 18:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766170483; cv=fail; b=SboMs9prsZYTUnyzpPmt839CubznJ9UKEtU8Qk00uOMsOS0veAl4GNdfGPECysFi3EVmag29xHmjJ5XwQMEBQvsv55g0bDDTM6Hr/iQLOBvI2paF6XDyDi8L5jefbIyWb4Rx+YH1otDNZwP+UaaB81fRmjg7ncfmMToVo4J5mAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766170483; c=relaxed/simple;
	bh=phjsehllVictj4/vHB/irOHnX7xJLlBYF4jwqLsI6Qs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMtrzZZyWw5KBceimbw0oKpOh2Cfm2eHUwqwuPc/PmxNbilz1D0jROPXHGqBNmWfWz7Dwhgrgwla9+xUONAhp/vy3rEihyQAIlqq+6sWz4TcK+lfzDAcX/iK6H3ncIQ87RfZyob/lOlhBmY6mIx9aZwuH+xZB1PgLrMN7ml09cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oJFTOEYy; arc=fail smtp.client-ip=40.107.209.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oJFTOEYy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhZsTy1wbzWauFCh4xobGFK4Lh21KoWbMFYg/0CPo8+y7ANfGpAC6OsEzuAeyzwXBvRV9vA4NZocUQM29DBdbG1OR8kAWkecVfAzAvFjRYg0C0stst6c6kjIQKt2rK05fevP10cKCcUwISt7ZtwMEC7cmowdl63ECInyvD3w+kHW2X7RvA2Pwisfbr1b4R0Sv+gT7BcUkMr/GpabYu8+9Rfxx/nVuapC+uy5xaUW6xsRu0XGLP6QujjpPApWWFSyxBfPn0GF7jM0tlX87LSrEN3lmtO5doPJfGHotNOIsJdFbkmCXbd3F9s/2k1NpWpcO+FAIDR68zHYVtcAhCZn1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/vDCpy5G6dBP1TdJyR72ebdLEtaTQUJuYOuQ1+WOTA=;
 b=Db4y0xqieKWlR8L5leagGL5P3pa9lWek+v6ZQBm44IX1grRZgQCHMN0rFSSxdY7Znb1U65dG5JevAgXe1VWsAL21EsK8qEL1LVaAQ7lEmGfE1yUvCJQKfUXVmCOx1T8JwPGpKeq5FKual5/bLjyHUUAaS63s02HegBKZ5auPtDodO6fPbz2AmPLPvIfr9Od9aWuhD9B0YnHRPrWNq4v22ELLqfCNvIyl9ktpUqXd5H+SiRm9GqwVsIGYUfONfLBNsrE/vAIVPpZIJd5sfICbmv8itZ31YPPbMOxct0M+dI2xkN2pTTXZqW97uS3GDKJUZMWgp3bSmyZhRF+SZZMbXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/vDCpy5G6dBP1TdJyR72ebdLEtaTQUJuYOuQ1+WOTA=;
 b=oJFTOEYyOFqMQxn7yz9l6+mezBaaSy9tV2Yr/srpUzIRQwcUkNc4nPd1r3NZIfYX5Mij2JEFuKqT8tqSzAnwi/KhE+8Oi69TMX5Sz9JVsjCID3E5SMZY/GyGZglmjCgHynTpp8IV0damOF8z3+YkeKld9jfNtHvu5dXITAq31MKliVwrhYQaa4z7RN4dP0RmDPQZGm33RP4fGaeUQfBOvUuFd/ruzBzHZLERlY5NK9RarbTRibvEjBPnvNhhng+eE5QHVdoRxRL0+btgoh6pQL4idNIMyR5fDzpJ+XaF7ZsvJfdCWpg09BhEWQNwFVzLfzsDvV3tHi06Xevciagr0w==
Received: from CH0PR03CA0049.namprd03.prod.outlook.com (2603:10b6:610:b3::24)
 by SA1PR12MB9002.namprd12.prod.outlook.com (2603:10b6:806:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Fri, 19 Dec
 2025 18:54:36 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::b6) by CH0PR03CA0049.outlook.office365.com
 (2603:10b6:610:b3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Fri,
 19 Dec 2025 18:54:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Fri, 19 Dec 2025 18:54:36 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 19 Dec
 2025 10:54:18 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 19 Dec 2025 10:54:17 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 19 Dec 2025 10:54:17 -0800
Date: Fri, 19 Dec 2025 10:54:15 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <jean-philippe@linaro.org>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 5/7] iommu/arm-smmu-v3: Populate smmu_domain->invs
 when attaching masters
Message-ID: <aUWfVzhVZ+Qo1efT@Asurada-Nvidia>
References: <cover.1766013662.git.nicolinc@nvidia.com>
 <79cd18a1a959ee2e54683e8c465b799d49ec48b5.1766013662.git.nicolinc@nvidia.com>
 <20251219155151.GA373575@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251219155151.GA373575@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|SA1PR12MB9002:EE_
X-MS-Office365-Filtering-Correlation-Id: 714b9857-dc04-43fe-4528-08de3f300e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kUSV5U/AlRYhxtiV5jEViO5495JvqlfS81W+oqRBFJvMnXf05LgT+icaixws?=
 =?us-ascii?Q?tKJxRRjZfkZmdsEKIKjY33n/MVRfdFjjnmQxtGqDfckEO5RZq+XatET+hBoP?=
 =?us-ascii?Q?vA49Pq7p03vXotfJlxCSpjVqPisufPqZd//Av2ZIqkN644DTBc8crQm2ia/A?=
 =?us-ascii?Q?c4+uvOi4LrAK244ZJjeHj3CQClEhRBTk1R8h262q+dgKDYzsmGAsnGkPZX+A?=
 =?us-ascii?Q?me5XxD/ozo7Dmda2+bGNYcbzJnoMIbS6p1bPymh/J5aH13yGsCbWuVzEBT/s?=
 =?us-ascii?Q?UZsbopmTbhU2hwm6OTveSBdwPmh6kxQcZIoJC1jAXYKUBDhtwU2z4NLfAWPI?=
 =?us-ascii?Q?XPk7oKz8UunnLZP2VXRSTW+6tvXyqb/FwXi2OFSR6giBybPNCym7i29Sr00I?=
 =?us-ascii?Q?NLWVy5qmE5xCbGsTMKn75ssyqnQmlVilUHFsH5q+iLwd0+y0ez934ky6LgR1?=
 =?us-ascii?Q?FtMqCEx4G2UMi45Juz9s0RS0k6ApiFbDzFlJOtzPJsM/GZtiCdP55XoWM/BF?=
 =?us-ascii?Q?uEwGb9Hak1jHBm3j7zoWeRkn/8iqHRhqSDBZu5FIvP8Xz6ICtROIfErGahSe?=
 =?us-ascii?Q?obQL7ABCrp7MZpVlTXJVOl41wA8sfmuLWEfYw1V7SL39ShHTbBpUTAVDVWj1?=
 =?us-ascii?Q?izKn3HgEL0pyXiPSEazdfndg3CRqvfKMPiWPixUIQCbKpJUFh8oCqncIsnEZ?=
 =?us-ascii?Q?DSxtBJXjotw30e/pCZvbKznZv79aYevKIkqDyiFFAQwmoJ04p/qS/Ft9YF7g?=
 =?us-ascii?Q?YYgJh4P2I1ow1BMx0B4iwOfea6fAm7F588LIb7v8amJr0uzEsQ5PoXMMs+Bq?=
 =?us-ascii?Q?UngPxXSixff4tcvKdTkiYysndB1kZo5h5HYvE937vWUVzvV7RmcV8JhQ3W2t?=
 =?us-ascii?Q?wIBS+qufCk9Z/xFi6b5MvgdzYs5elwn7t77AK3IlsUqa+MDl6+gMqr+Bvmoc?=
 =?us-ascii?Q?GlwAAAHlBltDgPeVcvqOrCF3GdgAhgzRjytjTgIAKkfHohoKcegH+FLnGOWO?=
 =?us-ascii?Q?GAKYTOx4oK/8sMSv5Dpu3UXpnqw/npJxpMFJJM4V724ipvOcy0HTqQubKaJl?=
 =?us-ascii?Q?6RYKlRDTu3qozhZZWf1fA7WGxg3/Z2sshIGPwrGAxH21JQb08Ux/5P16CmYj?=
 =?us-ascii?Q?GQEZCYG2pPuOdWow+yig8aORx5gHS1AmKSLc2RhFuNAwZVPY498TIQzXObfK?=
 =?us-ascii?Q?e9nTk2C2tRxwTPdnLnRNN9Rbpl15EpmPyKHVDwtZomkTAkXfzWKhjJfVIEx0?=
 =?us-ascii?Q?1vV9FioA16Fo+Nqz5o5s1ilM31k2Z6B5UAN8GPaJwmm6x8fhR+zN4MvyHTpe?=
 =?us-ascii?Q?zVDEe3A9PP/WbpL5yPZwBcTZB0Cvj6fr1AZVd9upR/S+FCXqxM0mA2C/fc2+?=
 =?us-ascii?Q?eliKkdk1u34Cw1Ff1h8WeZFfVI47vGAwe7SiALs2t1zVNKm+FVXasY7RoBsk?=
 =?us-ascii?Q?amSIm085jBQaB2eZh/sVvP0VTboR6jeORzvpY9j3rCVWFsOERxucTTEvGR1r?=
 =?us-ascii?Q?ZPPK4gczNPpD+0dNd2MdCo0AIhtWT8tJPRXIt0Xu6Qk5KVQ1E9ovR8ojfw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 18:54:36.3477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 714b9857-dc04-43fe-4528-08de3f300e51
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9002

On Fri, Dec 19, 2025 at 11:51:51AM -0400, Jason Gunthorpe wrote:
> On Wed, Dec 17, 2025 at 03:24:30PM -0800, Nicolin Chen wrote:
> > +	*cur = inv;
> > +	switch (type) {
> > +	case INV_TYPE_S1_ASID:
> > +		if (master->smmu->features & ARM_SMMU_FEAT_E2H) {
> > +			cur->size_opcode = CMDQ_OP_TLBI_EL2_VA;
> > +			cur->nsize_opcode = CMDQ_OP_TLBI_EL2_ASID;
> > +		} else {
> > +			cur->size_opcode = CMDQ_OP_TLBI_NH_VA;
> > +			cur->nsize_opcode = CMDQ_OP_TLBI_NH_ASID;
> 
> There is a tricky little gotcha here that probably requires a comment.
> 
> NH_VA and NH_ASID both take (VMID,ASID) as input since the ASID is
> always scoped to a single VMID.
> 
> In this case the invalidation logic always wires the VMID to zero,
> which is also the VMID the driver uses for S1 tables when the S2 is in
> bypass.
> 
> Which is fine, we don't support an actual S1 table on top of a S2
> table where we issue invalidations through the invs array.
> 
> So maybe:
> 
>  For S1 page tables the driver always uses VMID=0, and the
>  invalidation logic for this type will set it as well.

Ack. And I will drop that ssid too.

Thanks
Nicolin
