Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E24422F823
	for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 05:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736919950; cv=fail; b=B2CEh3K5kq73gCeYxxLsXuyQO2kgJYp9nNxBzp0p3sbFOAh1kf3/4c70BZjInqu0+GuinvBoPj8iCUNzdFokF1sesflHql+Sj4yM3faMgWktCc0ZbWLU+5lOaRar2jV9WOzaRoK9ic4JNlUkTwSOxgGzj/Iz8F0v2w1cP9cc4wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736919950; c=relaxed/simple;
	bh=6RaBNVKNRd3bkypiJogYZgN9pVWJrqvh18HlB66Yut0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHWSTiug3tzn5gdCwagRisLMA5n/iKtMJM37pYJUrC2BU+bEN01SEdGt6Umhvs861tkovTZKgJJsocq04VW4x4D4KqvSukVgPRwvzDUMPWRi3SzSol1qm2eqkjfts25oFKJxuYUmeE7EX30M0PqXRkWAVj+1PPLN6u+lYnlYG2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FMaeT9+u; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FMaeT9+u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXp4U5klbbwByr94KSZRfMkGEN/Sv1aEnKwVXDy3YyiJSyYRNIgOir2kuQPXozpH3RljJWxZuzCEZMyS5oeSFF9Cz3g4O80MNWTWgEZTPMwziacHBPLtCBBiIjPs8RUvhGyKKSvfW4CpEe5b89+5p0FnPlbXkgjIEBBVsX8Xur2n0vCy+y9iDsaV59+apGFt6+RjS+Unj8ZNdNNrYmW0ZCwh5WJVnD2I/bTNUcfAt4OILbwasVjA2W25JocJ6WP107hho0vEIz7zicKDnOj6w5LM5pnNNdKqCzEYiDuD4nFD6lGNk4fCnjR1xT6MUehQBZcHvWG7ccHRzfzTYtIGMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42NVpHSa0JvkqWRxP00rO0Ds8t6D694qmvYzCIiLItU=;
 b=JkXdmD3tSTrpqBxD4J89MLXi9HNluDtect5SE+8wewFQAPLzR2Dt8Nh8NH6NUCceKx1r29c9h0kMHZ71DMA9cYA1Dkk0Kz9b+ctFDKGIOUEwqMt+ohsKmvLwo1c7yhMgtG5S88KxlaggpU9BBb73etMc0h9RUePiz5GwMGtAGwD9huBznwKn7HhKLnEg5sVcsux5h4FSK0v4LHwXJxZPvuRuECvy+T3TYnel1Kuix1Lq+1+Hzi1s1iuv0aGEw0b3oYI2TI2ZBnearGS0m2z2ot1KjD24gLurf809vob72OyL1kiq21PquS3eqXgxW0UrMQ1z7X4Qwiir99FOMj89lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42NVpHSa0JvkqWRxP00rO0Ds8t6D694qmvYzCIiLItU=;
 b=FMaeT9+uKLOLG+9kk9hdwz1CWSvcBIweX0Q+q0U0Cj94HAXuagNmgmB0zRth2Ki3pH09JXh6h9a9bf6puOUV+6fhH0e9ziegcrXD14kdgx1Sc44TwiNz8o7Juf3vXqiT+l1EI19167gjHJAUzOwVVemQJ0sDIdimpM0jW0Xj+rAIelr/TVZRWYpjIsmcIoiYsgwwgbNt4raYt09pmESX1Bv4OGmbL+gvC1F2/K+c9OmeOv83TLQ9Yshv7Pqiyztv5tnQkxb16Gd3C3KeuS9SrLL6hu7r4OtRNqqZhQbf02G1I/otHTeW8aU42By+Y7LkKgS1dyOH6zft8HGKW8xLSA==
Received: from BY1P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::15)
 by PH0PR12MB7791.namprd12.prod.outlook.com (2603:10b6:510:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 05:45:45 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::32) by BY1P220CA0019.outlook.office365.com
 (2603:10b6:a03:5c3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.12 via Frontend Transport; Wed,
 15 Jan 2025 05:45:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 05:45:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 21:45:34 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 21:45:34 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 14 Jan 2025 21:45:34 -0800
Date: Tue, 14 Jan 2025 21:45:32 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>
Subject: Re: [PATCH rc 2/2] iommufd/fault: Use a separate spinlock to protect
 fault->deliver list
Message-ID: <Z4dLfHIs+rW0zAcu@Asurada-Nvidia>
References: <cover.1736894696.git.nicolinc@nvidia.com>
 <56c73c27b572e9c677182e99b5244184bdef7541.1736894696.git.nicolinc@nvidia.com>
 <1cbee44f-4fce-4e9c-8b95-cd1fa25f5921@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1cbee44f-4fce-4e9c-8b95-cd1fa25f5921@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|PH0PR12MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: 49fe33b8-2d97-4daf-1be1-08dd3527dad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EW6Mw7zbWZRviFvsMpIVd5+jeBo1+QsVsSt41qg59MSp++p4R5iZl7W9freP?=
 =?us-ascii?Q?dUjCFoZgIyRbvCXgCrTIy68Mr25Uh7ROzp7Qcznoh+nClEJLo933IbCGKI8b?=
 =?us-ascii?Q?dthstyKe9U8cgnp9SjkgGRci3QtuawWb/8fBt7t4gYLtmfTWwe7AGGDXAHih?=
 =?us-ascii?Q?AYICMVcBlnRe1o54LKZmdIifR9QJ9tKKyA2VVfuSZgnGErOcmlI5uIjswE4s?=
 =?us-ascii?Q?tQLykqHCq7Z9r3roAztQ6hAcnR5qRur7FN64fffaq8P1XuKHDuEtedHNqr4t?=
 =?us-ascii?Q?iL9Ctm3czWG45JjfQTJ4QnLsby8x89FozYTq3yts5kgw2mI+kwF1AkvbCh1u?=
 =?us-ascii?Q?6M1ypJz9lJKWG+4Ijnjq1qXze2gFAfc0W8Y3ioIgiJijq1itaTPSkW/7ZK0G?=
 =?us-ascii?Q?fyVQ3aRIxhp63KRQeqF4B/Tn2QhY12TxJcdZivey+v8CBbFefrPBI3Hihrx1?=
 =?us-ascii?Q?OkejsKCFs2/3uXU/sSAviK+gBvrmgFJSd37Fpsge30/i+ccenZRzMv8EIiUJ?=
 =?us-ascii?Q?qkkXL11dYVCCmkp3nRv9yjTbO2BrTKU8FokW6mlY/2mI99/UQwpGnhKLNvsE?=
 =?us-ascii?Q?jeSVh6db6be6DgylAvKC3CQsF0zc4bZsyPnZ7CsewJellSac8DB7cIyTbpL/?=
 =?us-ascii?Q?SxWA+scAss7nrCmCSbm6CtX2+XcuxD083yBdgIY0zvv10d6x6hn64FCcpI8C?=
 =?us-ascii?Q?Gga06ZFipcxApc8KDLW9uXOBGn4SBqkU45IkzyIBE5Tj/U44/GyMvEW0WtXU?=
 =?us-ascii?Q?4gk5QvKr1ELjPp8ZngxPk67Z0XRUX5scDNAkprEIx/nlNiJQwHQ+kpCgNk3Z?=
 =?us-ascii?Q?3M/O/B+Ccg/izgGdJquVsdulairDPPsKGiYeIL2D316MeeHnoiCGzL++fQo0?=
 =?us-ascii?Q?9KImqbPwW3PTOjluC8lrYTsxi91wpFo3Dl4HiATKfFy6uH4L/EThC7XcSsdK?=
 =?us-ascii?Q?gqIpiKnZLYx9mxJkf9PCWO3pPpuVqIOs6zuw3DjgAxc0lD/7WvH45szDoT43?=
 =?us-ascii?Q?9hUncYxf/aVZjJhyBxpQiXLlsAbWhp5HCKxV5gnTLUiM5LmoOVmGYSs6gnW6?=
 =?us-ascii?Q?FbnPwAsEwQglRLzxMJVUkCTfpNjE2oeeZkoHxaDfKV6LGo32C+jPtWosa8XN?=
 =?us-ascii?Q?0iPc2VODI3swU1k4Wkv29+AheMMlfFFmXBv7M61/19f17Awc3tJGP4HBMyo8?=
 =?us-ascii?Q?SU7Ak66sq+wsTbnsmlr1ye1bSK98Mo9hOdq0ZhpvknVFk3PNkl3bu2zhc9h7?=
 =?us-ascii?Q?owydCR0MaDPg53WlLf0qZZY/7fCgSQ83FzpOnxKjicK6xicRyx+t3o8oSjeW?=
 =?us-ascii?Q?Ufmx/wK+I6Ovglh5yLZHCq+nK6vFEnuaqIwqo6PjJfF6Qoc8mwCyDhWGN9jB?=
 =?us-ascii?Q?mHs3ST1v3Runaq/5frdEpwEMI9280+cesgMjj85KF6f8Krjrw68clgoa/pHR?=
 =?us-ascii?Q?9r7Amp6C3iyzOE4TbFrXBFghUD5tYxN9k9a4LncinpxNs4WuvPbqUQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 05:45:44.7431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fe33b8-2d97-4daf-1be1-08dd3527dad3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7791

On Wed, Jan 15, 2025 at 01:24:53PM +0800, Baolu Lu wrote:
> On 1/15/25 07:28, Nicolin Chen wrote:
> > @@ -445,12 +445,38 @@ struct iommufd_fault {
> >   	/* The lists of outstanding faults protected by below mutex. */
> 
> It's better to update above comment as well.
> 
> >   	struct mutex mutex;
> > +	spinlock_t lock; /* protects the deliver list */
> >   	struct list_head deliver;
> >   	struct xarray response;

Ack. I'll do:
-	/* The lists of outstanding faults protected by below mutex. */
-	struct mutex mutex;
+	spinlock_t lock; /* protects the deliver list */
 	struct list_head deliver;
+	struct mutex mutex; /* serializes response flows */
 	struct xarray response;

> >   	struct wait_queue_head wait_queue;
> >   };
> > +/* Extract the first node out of the fault->deliver list */
> > +static inline struct iopf_group *
> > +iommufd_fault_deliver_extract(struct iommufd_fault *fault)
> > +{
> > +	struct list_head *list = &fault->deliver;
> > +	struct iopf_group *group = NULL;
> > +
> > +	spin_lock(&fault->lock);
> > +	if (!list_empty(list)) {
> > +		group = list_first_entry(list, struct iopf_group, node);
> > +		list_del(&group->node);
> > +	}
> > +	spin_unlock(&fault->lock);
> > +	return group;
> > +}
> > +
> > +/* Restore a node back to the head in fault->deliver */
> > +static inline void iommufd_fault_deliver_restore(struct iommufd_fault *fault,
> > +						 struct iopf_group *group)
> > +{
> > +	spin_lock(&fault->lock);
> > +	list_add(&fault->deliver, &group->node);
> 
> This is not right. It should be
> 
> 	list_add(&group->node, &fault->deliver);
> 
> > +	spin_unlock(&fault->lock);
> > +}

Oh, right!

> Others look good to me. With above addressed,
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks!
Nicolin
