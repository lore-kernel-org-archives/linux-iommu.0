Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010056.outbound.protection.outlook.com [52.101.193.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CD01E9B3A
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271230; cv=fail; b=VY2d0QL9ixI9EXvCH2C08CMpwH2VBZOangB0UPgb7r0tuV+xqkmrvYaRYoh8RywL83h3G35Eh7Z+NBc/TnVULZdBuaLOjtF7Nwn5hzDSpPxFo/ezSKQL9Onjp9w0VNffum2V9GMWjk4KzirNjf4rRHl7Ar8IR6AUPtBQ+y42HMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271230; c=relaxed/simple;
	bh=gWkdGVo5GkKGS5gZ+eJYaKWvuEBwyluWNlkNyMmyeyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XNS+Msl6Oe5pE3+aYTQqaVf1DqzrEs9kwVlBjRioCTCiZbiPwqSmqdG5UpFnIpxArGRAyLQAtkCcA2D9Rh4ujf/Egz52eSwwy6RnvpwT5zRUDJ2U8rqizm3nFlrP22I7NNGXaQhdHhXmAdUskpEokrtGkbQR6PiSZZoGsLnVyiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GDWOMy+P; arc=fail smtp.client-ip=52.101.193.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GDWOMy+P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tcj2stC1k6WHaxf8Y3097n6p1sEdadi1uRQBmXC6wFkndeQBGL+Gnr6wggfuX6HSLYr5s36i8zghqzFogUOROPkwGYuQTORYKpfINyIB3YDVVxWqmGc12urtbYqafeqa/5fE7axKzBz947/qCIhxfhTaverDfAhBXIYXWMEfkfUzkl9WQryUdCrdy6yz6cD6fKZYJgbpdJcg4Wuu5CbGL1FYObr2c7Eu15fjsYTi0h0bkdbC622X7LaVwiJhbEdpyDDZboQW0qeMgT+uzBf7tBmjw7QPWuRWheelZepH2hf3tqxBxg41qlkt5faZ3nw/yNr7iKKp9NXRKslBiVjozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+9vb+JEQzHLH7Lp9czUbrrJtru1v3dBv7LI8sp+e+c=;
 b=NTdzXdVoKBpd/iHFPUVL1mSQGGOD7GppNypLUDJGfMMbXFgXxpOIpD5rBNUtXr9gmSvelE/sOLjDIKbqm76sSQBTa1iAP5kY5IPqkwubz1h+b8wkx7sHhJykUaCp+EPrRLIdTkW8nn1eKylqAjshsST8vePmkq39VCQ3c2iO8/QBBaWmZRM4wbhsyPir9MA20ZUwny6PcCxhL4emzZesg/pAqSPczxiWyIv30eTVP1wx2E5An4mM+kE4tWlI4kFTGk6vE3ovwdC4OS6pk7p554315PKV5yugHlquqM94hcZ2ao/SBSxW21CsXNAzpxZHhaGskLezleBpfXXPtlt1PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+9vb+JEQzHLH7Lp9czUbrrJtru1v3dBv7LI8sp+e+c=;
 b=GDWOMy+PwxujlxA3ilIDJuXUu1rkOGFj7W3/rDU9LgXyh0JRWIKgapqvxNqsawY44jdosYuMxDKeZemRHlKd05lU8Cv1Smxuj1Fwp5Y7KhYe0vUXK98KSVQw+bqLGCyvIhXK2V8Q0cpGbux6cMe8Rf4fyrGLA1GKvYajOqad0nRAXAu5UBDkQ3dZIUjX6R2qIsR9nV60aFvm5s7ZuRv3DfxWIBWM+WF2acaByVmlEvO1Q0P6pMB9lQMUgUv+2aLJ+dvtsm7OzXsJLTlSMg0KqZ1RLDybdtAswfKGd9COjvhGRLpE6WR+YL9JmUAfa1XJ2UAKt5XiM9irJtS5MAYglA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB7848.namprd12.prod.outlook.com (2603:10b6:a03:4ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 13:07:01 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 13:07:01 +0000
Date: Mon, 23 Mar 2026 10:07:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>,
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] iommu/vt-d: Add entry_sync support for PASID entry
 updates
Message-ID: <20260323130700.GE7340@nvidia.com>
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
 <20260309060648.276762-3-baolu.lu@linux.intel.com>
 <20260309134116.GE3717316@nvidia.com>
 <4fbe6dcf-1105-4efc-b755-81a5bfb74090@linux.intel.com>
 <20260312114438.GG1448102@nvidia.com>
 <5c7503bd-e9e8-41b8-b275-3317912cc83c@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c7503bd-e9e8-41b8-b275-3317912cc83c@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: 043434f8-3eef-4ff6-a23e-08de88dd1254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LYDzXNsQIxOYRQNs8HL8a4R/upC9aAdc92e+WBpHQu+o2lB+h/W7Vgc6mYRoOIVTd3G7Daht8NL3khVmZR+7OeVRaDA9sOBajMXZwixkbfI/9AOHnxoN3fiLl4zHShyrREqFXhS40c44UbQgI2KJeJLOjYrIUX9wJCCvqzC1Bs6fEJ7ggVcDLv/X7TwCivyk5GTQWtyOy3H5eWm2QWaLPYfqjI9D1fYXCVmfMZT9W5raN8jsMOLtjmGfEko4sflmTtk5cZQxC3QK74ipTQ9+jwg/5v80NT+R2hplw4pzwrsa0hph8gXhn4agbavuofv8VFjFtNv8ZHh2OWewDZwF3zxedbeBEhj+vyqR082oHJ+QhuAKp5+z5p4XJTMgxCH7vETs5Z2WQ6NJzU2jadg0HczSFXUov+SfXMT7lk2kJvLkHB8lu0JuEnt51rSQHhuhRoiGoICJLUUgNi0jtZORDjbJrLcfLaZH59RP5LtDNVSwX8za79OIEt4tg9uKz186SQHWie34uiC95WAzXN7P3wyb1DMC72GvKMHqOBfiypQilrpzpk9l2iTrIc5K8c4U0HQs69JrWSs6JzDRCEDF4a5u4ADDePoLe33x6x/RrqkDqfjRecNNJvUBqx3QM9l7R3m/Tf5dOpKNOTis6efhAPSzx9hTtzoaVo1piC8+P9sYTAFO5Yw64jvYV6vDQ8oWTgOvnOe2l/Ci+9jMC8ZFMfO2nNcp45fLShvCEJUvbT8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T2W944/Ih22YCy7kOb5a2q/Ef9ikxeqdNFLDxhRZXsvR2w1QjUeZ1BpYKMMV?=
 =?us-ascii?Q?NuXih6ofIiNw2Xknt27vKQnSajNr20GQK727uDrkC4UjqhzB+XpbRplGE+d3?=
 =?us-ascii?Q?HmsjXwKhFQgClcLhHD5nJacC8Tv/azMD8wZO4YNwIfTxVHKHsEU75udoM69n?=
 =?us-ascii?Q?6KxkigQX0fPPzeAIQFjmI/KVxCf6hJD7TROZLkFxWVoigzRtkYPwWgpfyrjE?=
 =?us-ascii?Q?SzsKsbaPlBcYbAVzt0IAJdNQfQWnzFdxFED21FEBeFK8gpjL5XgUO6ZuYfsj?=
 =?us-ascii?Q?BpX/S+Hz8rwi9K0scVb28FaLYD383/EiZN+6FeVqYIadOj/QT2IYGRau3ESW?=
 =?us-ascii?Q?yW/tTyor8Of8tu8WcViTGry0k8Zd8uRqb7jX3qvzwNP86gwC257tdWpSbJLp?=
 =?us-ascii?Q?iKHTODeIskzmXZqYl+vi5w90+0ngJc2+6FKSQIYuWqat2n2soTC3YQ8h3Gzp?=
 =?us-ascii?Q?Os9BPn+Ac+8eKuR1IJqNsOGnr+rPHGHESeLqXbt5kV0l8dQMKdwFHmFqxyMe?=
 =?us-ascii?Q?LhooZTThjgOXIxH6EZxsVrZl6TofAlnzQXed3ri6MEjwLrspTsQDWgAEi45y?=
 =?us-ascii?Q?UO+vFm0QE3RFKYv+sCoNSP9oQGQKQl8WV6rnRbkoUdVYDsk2MVUAnmogXlcg?=
 =?us-ascii?Q?PGgDrOEvAqAe7reEyOTrX9bygJiq+jt6OxF1OANqI0pVlJXp2PzWHgLzte4g?=
 =?us-ascii?Q?DXbixZEhrO7coVZ6viEAfsGUZCpwj55e3XbTiuFuYNDyxsxtOMZGsL33UnIC?=
 =?us-ascii?Q?bUvlj7GT1vWuUT91OxZw3pPBfz7TzpuTbsIclA4fZfmK59X7Tegl4ooTZTx5?=
 =?us-ascii?Q?S9pvVl10j77h4RP/go+lkyAE5DgFNaHCarLuiZ+cn9Z1s2eB9+WMdAXTAhun?=
 =?us-ascii?Q?51nkeb09+oYwf9tyGy7D1KIhYzmdQWzC9wwldTsP7AvLcH5w+XXVecc8uPou?=
 =?us-ascii?Q?yCwDP2E/eo3CMc5iuH1vX5hxdH5Bt5gE+2LjrPDqQ3jrtLrOz8m6eQc4bzar?=
 =?us-ascii?Q?3AL4fdRJnYTinCzFPqlBt95L74JXKO6kFEMlsXhvaoDMIsTdHfNIs2e050JP?=
 =?us-ascii?Q?oGGWeTeeLYOs4XwEFQquduPXJ6hyNBOnf5xkeKfS21cb83eM6XCFUYQ14OfG?=
 =?us-ascii?Q?dQ0ab3lc4E/BcxoIZ4hBq6UhYObUoBwPhag4WQ+k+6SeycPX9ug67p/NyawE?=
 =?us-ascii?Q?fQSo0sZ2sDwwvRB0sY62hr05BC4eAKtOpy7656dU36rtRhHUSBezpIYUZFb0?=
 =?us-ascii?Q?4eOdgF9hhabTeo1gT41WvIpRtG1qmKLnOQdsECR155dtAi1Tn1D8jn7Pf8fu?=
 =?us-ascii?Q?qbcC8wd35E2bQhdP2l8ahSiluzMZFX45O5cWLxtQrEesY6dRlO7LIuOnoRek?=
 =?us-ascii?Q?kp4mFbmoqV0KI2du/rpB0Lo/3Bb3bbQBIWStCrgpkFtQwJhh8gMm4taE/hV9?=
 =?us-ascii?Q?TFpINYaBw1kJGVFSm6Ule9pcB8M4cdNw1j8CrfSa5CR17qxl6iagFl6SeXqu?=
 =?us-ascii?Q?CDPqq41oL51bn0XLCecv/OHktJA9Dp989KAFoXIdjBKJGHFtfYM3Ca4kJCOX?=
 =?us-ascii?Q?jMPErS+yutd4Ei/sCRSh6JziN4T6MtFna/rMb1ZmN0wnC6dL+GOw0Um4igj1?=
 =?us-ascii?Q?IhVaAYjHeAFpH4uxZSQ5Vc15U3Td7nyHf2s0bcD/0hbSheWF7+00s9APTCFr?=
 =?us-ascii?Q?MeoY6nEdtXh4AJzZwbeIJhNQQZtp4FcA+RS1/ztnHCcNKPkX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043434f8-3eef-4ff6-a23e-08de88dd1254
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 13:07:01.2743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0YOjq5Xr1GUfOz80xVRQ/LNjPVUgPIinBBj4BIUBbNImquqKtdJWFOpFzDSV05X5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7848

On Sun, Mar 15, 2026 at 04:11:36PM +0800, Baolu Lu wrote:
> > > > ATC invalidations should always be done after the PASID entry is
> > > > written. During a hitless update both translations are unpredictably
> > > > combined, this is unavoidable and OK.
> > > 
> > > The VT-d spec (Sections 6.5.2.5 and 6.5.2.6) explicitly mandates that an
> > > IOTLB invalidation must precede the Device-TLB invalidation. If we only
> > > do the device-TLB invalidation in the sync callback, we risk the device
> > > re-fetching a stale translation from the IOMMU's internal IOTLB.
> > 
> > It is a little weird that is says that, that is worth checking into.
> > 
> > The other text is clear that the IOTLB is cached by DID,PASID only, so
> > if the new PASID entry has a DID,PASID which is already coherent in
> > the IOTLB it should not need any IOTLB flushing.
> > 
> > ie flushing the PASID table should immediately change any ATC fetches
> > from using DID,old_PASID to DID,new_PASID.
> > 
> > If there is some issue where the PASID flush doesn't fence everything
> > (ie an ATC fetch of DID,old_PASID can be passed by an ATC invalidation)
> > then you may need IOTLB invalidations not to manage coherence but to
> > manage ordering. That is an important detail if true.
> 
> On Intel hardware, the PASID-cache and IOTLB are not inclusive. A PASID-
> cache invalidation forces a re-fetch of the pasid entry, but it does not
> automatically purge downstream IOTLB entries.

It doesn't matter, the updated PASID entry will point to a new DID and
the IOTLB (new DID,PASID) entry will be valid in the IOTLB.

We don't need to flush the IOTLB, we just need to ensure that all
lookups done with (old DID,PASID) are completed before sending any
invalidation.

> The spec-mandated IOTLB flush serves as a synchronization barrier to
> ensure that in-flight translation requests are drained and the
> internal IOMMU state is consistent before the invalidation request
> is sent over PCIe to the device's ATC.

A fencing requirement does make sense, but does it have to be done by
flushing the entire DID,PASID? It is ugly to have to drop the IOTLB
just because a context entry changed.

Can you do a 4k IOVA 0 invalidation and get the same fence?

Jason
