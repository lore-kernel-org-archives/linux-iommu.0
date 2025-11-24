Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5472D2F7456
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 22:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764024260; cv=fail; b=bvoBUX35niNSRJ95JFPxfjXVM7vYWwGfZbHWBFRIxCrtcUa2fTHCQVogRGjaqcON7GacSgiXZ8PqOK2t09XGVzXHJBf3dl3T/h83y6fRZD4nkcVcvSxrFKJKFkR3Nxcs7sBh+r8beKj6bC+jdIzh9HwEoLtrZcSZkU1bY/fawvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764024260; c=relaxed/simple;
	bh=7hqs9G77OUrZ9Zi5sUnEpINc4DnS4c6jdp1F9TVhcEM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2CuZbhXHG6H5Ea8cmmRS7wwitbJTfXdL2wondPr9l2JPAaCrm/XCBWIvrlbPYpzKMHlqXIYEWvHLqZVGy/wZFhmtn764x2sYsAuLOv8y0djb1CFIWQMuPSfSO2tqz4fXn8TryjZslbk3n1DkOJCHrqq1DpY5e1ayitlZGeVPSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=obceW/Eg; arc=fail smtp.client-ip=52.101.62.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="obceW/Eg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVpDLdi8Z2VS9vHOaujB1f3TfmFpEB1pjrdYXSOGJd7cyYg40uLwHHJcywGeOggcQbhCcfIfXlwuf6BtbrE2RDQA8O+mBrTCGZN/nCIl2a+CN4sstcuTjjT5DeAzwQimRs04QtA2QgK1h6EveLiWXStzKJJEDgCAuCDX11t+49gJXTxalUQhUBWHsmAjdfNXRzSkKpJbjdv7yYkmHvvR8Wd0Ep8WH4BjSDkufSR28cknYPLIZvgNUrvGdBx52zsviE+Ulm3YYgUPmTjlB31L2m45maS/knu8ZqTZD6nP82jDNW/bhdlAUXBaZC3oDhD56m53QkPD7RPRZcROLQCQ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJ0UuIIwRPps0Hl1qsqDtPlCU9+/lqATvKmsoQC1j44=;
 b=gttQQ3voTDCuhv33VpNl7MW7UAGvR5vCSf0GPS0Rw75jt4Lsma9ymYS7g+H7MEDhwSE6IuxppigR9kSJ0xH2voLUuyjc562THt09xgIUJm4RGYMj+7pHZFCemgGxcjEu6G4LXZ2G3ald8ItvT45XelobgjD4H7nwkORaGA7zBLP7Vq9w3jL6ufAEodVRrXs8w4h7ZcZJseGON88ujXkq1QT+XRSQzTP5Ju28vpUkplo+lPS+umnDQ6UrHaFn/fTwXdBEmC/YVNIuvmIATo+TU/vQ0K/9n0B4klrzZCPBMBRPhBoPzX6UGk1QabCgC1OBq21Db3qdlEomrDiMGB9gbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJ0UuIIwRPps0Hl1qsqDtPlCU9+/lqATvKmsoQC1j44=;
 b=obceW/EgPs1zroZC6m+e4IVKUHeucV0F5u13dbDCrBIzn+LpT2v8QJWcl1eGuI8slLpqoap0N/jspc4XHlkJITSbNMoNk2TwGYQj4h7NEsWiMlfiA95MR0kA1w0Eq9pHK3IiXObgSjhuILhAt8mS90VIugQAHoh4zKf0gdOK4NwyE/f/PHMjdjtsv+cpgBf498KcnX2Qp/mm+o2uUwmQGRe3rzUbHbIdl7R3X0ohXj8jETvXPTQRZGjGn3NAC6VjlD4k61kucrRVXn9C5TxLRGEo9R06w/81GMsPtbkI8tSTAOoxnvxt++hmsKum1986an9qtO0wy0SbKULyRQq+Fg==
Received: from CH2PR18CA0029.namprd18.prod.outlook.com (2603:10b6:610:4f::39)
 by DS0PR12MB9322.namprd12.prod.outlook.com (2603:10b6:8:1bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 22:44:15 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::98) by CH2PR18CA0029.outlook.office365.com
 (2603:10b6:610:4f::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 22:43:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 22:44:15 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 14:44:00 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 14:44:00 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 14:43:59 -0800
Date: Mon, 24 Nov 2025 14:43:58 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/7] iommu/arm-smmu-v3: Pre-allocate a per-master
 invalidation array
Message-ID: <aSTfrp9D7i03XhyU@Asurada-Nvidia>
References: <cover.1762588839.git.nicolinc@nvidia.com>
 <b6e1b5d0ac0157fc06b5cd20c5cd72caec892c47.1762588839.git.nicolinc@nvidia.com>
 <aSTRX5RJJhfNU6l3@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aSTRX5RJJhfNU6l3@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|DS0PR12MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: 0744bd3f-6ac3-403e-e1c9-08de2baafed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B3WmQnWEB/WX1V3rK6mkSRr0BLBVPHfs5ld7CqTHSNCWGV+5GNlNiEoQ7Baz?=
 =?us-ascii?Q?UoBRlQs+uQO2nppkZ43/iAErJpKro94pbsUojxHCW6DtQBvVDti+OhI5yKh9?=
 =?us-ascii?Q?+gt90wQTJFO8BDMbGe33sM54+9s7x2pIZkb7dz0stNer1xtWWTM5lmrBt7wT?=
 =?us-ascii?Q?7JwZxMDLWZe/mP2Y2sjetCEuKW/2Gb8wehD8qtvY5NgimQIFEqb7GfgvEKuY?=
 =?us-ascii?Q?Lbe8kzcB+m/TP+zsrql2ogSznnp0yBwG0ea3Pptn2zxhAXpoHi6a7h3UEf/T?=
 =?us-ascii?Q?Anr8D7RgF3afhqGKN35LwhpPzTcXqrVd3pCaZRKatFILhr77J2TftcaMJqfY?=
 =?us-ascii?Q?+Y1WYQQgt6rD0PQYbt/WW0TMk4VHl2gxcUDwvYYJI0jBrlaX4MTu+ekhiHB7?=
 =?us-ascii?Q?Zey5ODY/lpQmr5NBPR8QKrhdpxS8imHZ/cvc4GuJUIk1fPGO+177VEkg/fuA?=
 =?us-ascii?Q?TrXHNCxdK+EO1aGdcPn/rWFxUYQl9Um/gt8BBl7Umd4r57HIpOvoylJOixee?=
 =?us-ascii?Q?FwdcxXVyCwEW45kvi+x/xjQgA747SpNX/vavUAZl+lLMR6bX2nm0uFWvMS/x?=
 =?us-ascii?Q?WWLLxgqmkixDlNl+5GCZ+fMQ+Zv/vBqIyQbJSuVjy+FyBt27pbHLXXuYp4Vx?=
 =?us-ascii?Q?KYgbrN+Fz612KbkqYNQ5B0/QNiZ4UmmNH/lkmgrBfjuPqu1SlNidUuKickRS?=
 =?us-ascii?Q?IgeYUK5p+uRf7+r0lOfFvUcuFuFuVQGPG87eZeK0Y4gww1JJwCcacO19kEKs?=
 =?us-ascii?Q?ivEvVl2UJIy6dVteJQq13lkpuXlFAmgTXqObYbvoB19FKQUbY+a9OXQUZq00?=
 =?us-ascii?Q?nVaicR+4vC8lpx1qkXbav6QCo78PEKiZAqAHaEtwmlv9VqHn4RZZ1hZnKo+M?=
 =?us-ascii?Q?5FmOTKDoL/KYbhL74YZvjTJ66JbMn/HnXp+0ohn0AjwEi5B+YNkJn6IXEsYr?=
 =?us-ascii?Q?xd7X+1TDvY8cIUvvU9Yc464ll48zFCPx+b5zg7QKyOkPyyAjJg0iDJOlXYjs?=
 =?us-ascii?Q?3ysQaRR74WtF9ho0w7gliyyWD246MxDD3jHSmgNyZxhv65oIzi79tpUuy+3B?=
 =?us-ascii?Q?yauJ/qMxnFLCFrGgxke9bDOveaye0IlGLJ4v30N4RCu4ARWtM5XfsBls6uKy?=
 =?us-ascii?Q?Hogo1m3fiq4jsEz+zU55kaWzu/HJOaMjBPxxUqzUy+p+SYdnijmLa4HDfqJx?=
 =?us-ascii?Q?CCHGHeI8K8u0bsYLX6ojornykorEDy0ViUkmOP3P6ossTFtLN/rvcbsWiLR3?=
 =?us-ascii?Q?XALjhCStFxjTTPMzbE3ohhQI5oAGdDRX9Swh3Erk2gCnJbUwJx0DoaD76YGO?=
 =?us-ascii?Q?/YtpDqGUFlwkrEekqyUADoMfb8DKCFvYHNy91/diyOnodw+uQ/c9GsNdZRGX?=
 =?us-ascii?Q?+rSFeh0oPBR0JHEoK+r8ftnovE7RBpti2RKtfCtx1vZ19HhgQWVjkTSUw5se?=
 =?us-ascii?Q?30f7ZVX+0yiOm+KFwhPpAXdotKLEhZN+Mh/5L37iY3cHoaN6W1ixkwnHfLUe?=
 =?us-ascii?Q?BunUNb7duTWs7B5WIx7yvm+t+UyPnCQw+1EBvPfNL9chqAiDuuIrHF+ElCsX?=
 =?us-ascii?Q?OtOns0f6w/+Is0NTko4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 22:44:15.1262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0744bd3f-6ac3-403e-e1c9-08de2baafed2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9322

On Mon, Nov 24, 2025 at 09:42:55PM +0000, Will Deacon wrote:
> On Sat, Nov 08, 2025 at 12:08:05AM -0800, Nicolin Chen wrote:
> > +		/* Put the ids into order for sorted to_merge/to_unref arrays */
> > +		sort_nonatomic(fwspec->ids, fwspec->num_ids,
> > +			       sizeof(fwspec->ids[0]), arm_smmu_ids_cmp, NULL);
> > +		/* ATS case adds num_ids of entries, on top of the base case */
> > +		master->build_invs = arm_smmu_invs_alloc(2 + fwspec->num_ids);
> 
> Although I can't point at a specific issue here, I'm nervous about mutating
> the 'fwspec->ids' array from within the driver, The array isn't allocated
> or populated directly by the driver and so I don't think we really have any
> business sorting it. Could we hack iommu_fwspec_add_ids() to keep the array
> ordered instead?

Yea, I think it makes sense to do it in the core, once we have the
data structure provided by the core as well.

Thanks
Nicolin
