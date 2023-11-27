Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8F61C292
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 18:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RFWZ7aCi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtzOL9SNAES7NxZdyq9Die8EekZ0LS2CcArOIJ6QYLQKXj0MzGpicx5+xT2SbfxwsvIcHjhK/Ri2uSjWT/wN3mPuHa3LzcVz1McECioj6uqV6H6alRfjAcSj5jrNNdJm+oGCyjTaE9+jKB4zTsmy1b+NTawj5GstM58y59cEVblPmxVx1lB7ytsLLzfXsBjyBy4j9T3PJtosnLk2qAePbziZY6ZnZfHLSCkoAkxpTht62WoTylUABsLCNl/kag0HKvuj2LiC7UWX6pYZl5vkxpWLqgn9xwLTn3n6IvSsrbfvBpyGj2wM5D1al33VBjOJkUAPmUM75Ck4TqqPT8FQlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWYfGa0KlODfgTp+0x76+CMNCm8n88JtNCkmVfsRSgA=;
 b=QQmWbFyPDeY9owrNZV8nUT96HNptYlkNJkBWp/S0FCKpz5DjpnzBfrxBATEW8Cue3mCnyilgvYtRmsHaydzO/BDzWbc9KiORiX1+4tuLTeBQ/xARoA0GJgk/gvMzHB42yrAuNZMIqXCfId43FkHLCos/Sr7reocjZOjs3eXtzbFLDjhhlJE3kdZfx9HfrqskoUYQ1ETt6O41S/T+PAXhNirWaKfcbaTY1XLCkGCQxM5La0p2YGDERmUQquF+M/95XcxJGhPbOg1c8SFP6J/JKg99mApePpYz4GV7kICwwvZPfrIDENVRPKlLJTzRh8Mj2mmT8KWBkjwryyvtBt9HyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWYfGa0KlODfgTp+0x76+CMNCm8n88JtNCkmVfsRSgA=;
 b=RFWZ7aCiubAimz4glegS9YArOHi9g6oVqGuynY8kVVeznDyHLyKR/VAArZ9oxDEmW+gv7cQRrksArBSgs4YH+ZZ2+14sHuEyPHMc2BjaY7SSyktkkbyyHUCdml70nAJrM8Yjj7bGJrJ981mn2q0xiW8G0aZj1AnjFxPacBzNXoWTEBzdr4WdL0EkuEQ3frx/ivYo2pfoVWCOCUFE9e42XPpjoKUutSnmH2Cph7kJtgWrgGWzP21Lo9lYGUWUUgGEFNAY4YZQIL8Zt6A+tggz5c3zQRsqTfVa/k9sRD0K5Ri/8leom6nKE6NHP6Clk2Yh7e7wbk1bICzQzzphFUaC+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4464.namprd12.prod.outlook.com (2603:10b6:806:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Mon, 27 Nov
 2023 18:21:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 18:21:45 +0000
Date: Mon, 27 Nov 2023 14:21:43 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Eric Auger <eauger@redhat.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 01/19] iommu/arm-smmu-v3: Add a type for the STE
Message-ID: <20231127182143.GD1165737@nvidia.com>
References: <1-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <0a2a9fb5-0506-4a46-9c93-3c4001d0b966@redhat.com>
 <20231127174235.GA1165737@nvidia.com>
 <5ebcbd88-bd2a-4853-a0c7-1c2f0f7dc592@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ebcbd88-bd2a-4853-a0c7-1c2f0f7dc592@redhat.com>
X-ClientProxiedBy: SA1PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4464:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef5fbe4-2cd3-4e1b-756f-08dbef75b61c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b7Nte1XDvwY+9GCKbIcAO+awYiI6NpDccq5ti5R5UEiZ4W9mei3s1UryIP4lweAD1HsAye/xfHIqT4ts5YksRVaZk9YlwwdGFeRlcwgRF6aCDEt7b08nk+XMtx2b0sHsx0PLXrW84vzUyCun/fPGDo2yQW+kzDQ/UVHWrnipp169R2fkTfmppwrNJwT4P28cFEfbNK9UnHzmr6QSDMrGKyD3sPZq57JVMKk+7un25t/0R6RBZDJQe5qxEB4mKi63iEFvG7uywK+erJI3FPxiUgn5gQ/vORvqxlMW1y6lpZgMLrnF951HuV9EL71cZ21gZZCNvCllzbYQQBFitjkLd0+eG2dfqw0y4edUMM/x4NCVS9BRkIj4p71BcK8uKm/3mcHIA1L6QWl2TB5o9yLP3mHEwRRowvTbhwJag+nWqkhL3d/u46sFm07VIC3WaKuJIIBXf7BPznCGY0nwYyeMVh6ziE+fBAXISX6g+28zWBhMs4Jd+QBjagJkuh+NGLWxQZob+3K+lW5/UOrs9L18YRyaTRaso9gRzbfKxxqOobhja+xZthf401AnlFjaWQQy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(38100700002)(8936002)(6512007)(8676002)(6506007)(316002)(66946007)(66556008)(66476007)(54906003)(6916009)(53546011)(86362001)(4326008)(6486002)(478600001)(5660300002)(33656002)(2906002)(41300700001)(36756003)(1076003)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cbnq6A1bQ2lNIiCINEVyruqFyuAqlSPJAxKBCmnyq6fBqiC+fsqa8FX6D2tX?=
 =?us-ascii?Q?l4IuIFA+bs0Jc2rBTcvZV6rKj4ppdcmHO1HSshmf0FrlzBJNOLpjR+hADTlw?=
 =?us-ascii?Q?M941ON4CECZcv5KBo6HHXA8sMbreo2RWoGdopppIEIp88C4v+DIcaI9FOWz8?=
 =?us-ascii?Q?XHmzLkbnZ/OkHuHQkB/OHmdt0F+X6I/Su/rqLRmyTlsDmWocmRNZMdIttr2x?=
 =?us-ascii?Q?CZstdrAe9+82wSZH8o6k68pRTvHcFvXzU6hHPdk7aMqG0g6rCZkG3iR2OGDX?=
 =?us-ascii?Q?AU0jVwr34CkRERV0Nd8zitK/172Z6gAms9PoReYb8Oo4JO2R36VITJo5QjGN?=
 =?us-ascii?Q?oLhz5jIZ+oNxyhRCPHiMO8BAUdsmik0/AQX7206UiAWsdiBSzHKl4TJ2V9aq?=
 =?us-ascii?Q?6ZFAnFs10f2SKd+Q/Zq6LQzyJ7EZVK3f3M1RZ3jG8hBvB+kOLOhbXzfJ+ziq?=
 =?us-ascii?Q?ZU5WbYfcCmWS/2z7sCv4bMxeqDrQ6nvF4TP4yo1vzqj4JsoybUhywGnDUSH7?=
 =?us-ascii?Q?oV207HtY7K+IjJ9ojCmtZkMp2Ap/Vnaly+9KR220DjoW1TJE7ZcdvBQFKL2N?=
 =?us-ascii?Q?YbTrnDv03RNFlQrHKmXAArR4wMVyyjpzDLygZiU/80J48ylcCyFW8KwvrKpm?=
 =?us-ascii?Q?Lbn+ZOTUsTUTwZrnvM60NVONIXwemoVr06oG5mYI7nnA/kvQRXX3A80Omx/B?=
 =?us-ascii?Q?2mFLk9PkqgYiCmM0zRyXl6Dl59up9W00ejomcGZ0V3uU9bXUOMeJ1FbJBWGL?=
 =?us-ascii?Q?erF59bbpE5x/2f2+uYyYFYfyrly5XJH6W3OjuPyq1Adg/QTT82wVnxwJsSM7?=
 =?us-ascii?Q?W6reucmH2CZBOChE9v1+9jecagcO84vyZCIhyM4PwIQ22PH5crvX3DkSwjdi?=
 =?us-ascii?Q?eMfWTQpaS/kFlbYCnjuLFr6k4qLaCEOSQ5IUh9xE8jpj27dSxfVz3R0HBJ2g?=
 =?us-ascii?Q?Pnob9nl90oWkm96EtOpZ7ZGTIQ0yHVqAuLD6JY4P3xWC2IjbqR/BUza1zS2l?=
 =?us-ascii?Q?hv1pYJJtLg0aetyDKWc13kUzpwyRyBxN5oeatilNlxU9ME2VOqexRxqJ6EME?=
 =?us-ascii?Q?Nf2hheir5omxZTHVCp9FKWZezSeVeAS88kBiW4UqMI9sn2+L72QUEGQIfKPr?=
 =?us-ascii?Q?zNh9pIPSYORAz6X2KMBH3EIpjYNPAcsArsZpKo3kMxAm33Zv7Dv5e/VRDZM1?=
 =?us-ascii?Q?ch0VLal6NfVJ6dmv0TkOY8LVcJb7/bvgk26fzUGwtN40gAVXOA8yHVrlUtZe?=
 =?us-ascii?Q?eBoRBBQ0PgfcF/LZxebsSfDlyL4wdy9+jxGjcsCjrj07MFZEh9QpRtYljCFl?=
 =?us-ascii?Q?7lxWdEccb9qs7FIsadikHeQXIQaWe2eMWk9PB4SW/7GfnpDgppyK+P3wxgxX?=
 =?us-ascii?Q?+ZcIJBqbmcSi+JOVVSq2+0M+aPKGNYi5eUR4uLHKCLBXLdZagYXBRI1HM94Q?=
 =?us-ascii?Q?SxFDsYFpeC4Cd9Q/Awd8rAppwne8Nxq6m+vqqbh11jbsWGWAJNI14rqEupQg?=
 =?us-ascii?Q?p+OjKnJdzMFPMgreKm1qWUvyD4Kxty1VbF3B4DRDuhTYvEHU1joqbIhJw8Rl?=
 =?us-ascii?Q?ykQmIlN9v31IMXrPzn0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef5fbe4-2cd3-4e1b-756f-08dbef75b61c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 18:21:45.0039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCXzUIoSsf8/v/q8MpXuq0WRylUhZQU9zH+iVUxTBXZ3lIl0QRoeevvDsiq/mEh+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4464

On Mon, Nov 27, 2023 at 06:51:21PM +0100, Eric Auger wrote:
> Hi Jason,
> 
> On 11/27/23 18:42, Jason Gunthorpe wrote:
> > On Mon, Nov 27, 2023 at 05:03:36PM +0100, Eric Auger wrote:
> > 
> >>> -static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
> >>> +static struct arm_smmu_ste *
> >>> +arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
> >>>  {
> >>> -	__le64 *step;
> >>>  	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
> >>>  
> >>>  	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
> >>> -		struct arm_smmu_strtab_l1_desc *l1_desc;
> >>>  		int idx;
> >>>  
> >>>  		/* Two-level walk */
> >>>  		idx = (sid >> STRTAB_SPLIT) * STRTAB_L1_DESC_DWORDS;
> >>> -		l1_desc = &cfg->l1_desc[idx];
> >>> -		idx = (sid & ((1 << STRTAB_SPLIT) - 1)) * STRTAB_STE_DWORDS;
> >>> -		step = &l1_desc->l2ptr[idx];
> >>> +		return &cfg->l1_desc[idx].l2ptr[sid & ((1 << STRTAB_SPLIT) - 1)];
> >> This looks less readable to me than it was before.
> > 
> > You would like the idx calculation outside?
> > 
> >   		idx1 = (sid >> STRTAB_SPLIT) * STRTAB_L1_DESC_DWORDS;
> > 		idx2 = sid & ((1 << STRTAB_SPLIT) - 1);
> > 		return &cfg->l1_desc[idx].l2ptr[idx2];
> Yes this looks more readable to me

done

Jason
