Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C1918E07
	for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ka/VvxGc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GonivFtARk0BoUSz2D2zOjkLTluOP3Mmo4FaVibj5sMWkk445G2W5g65HnSWqc4/6hDlbiW5HDtxtwoHf5SNui4jSYMkQ27s1qDFJCCGhzIhhqINTnYOnHGLS2cp3xAqNoq4BfSCYzIiB6DH+v/DooosqKlzygnVVIAsC5TT9Q1/o4HkS5O7KGgoshIGXbSpXH4TKWxceoUfBYeUKtSwSztB+H30PsocIJ480335pJ0OumZ6ejQspqitXL5EA+YxpOFuo2cazoblA1FF1JnHz2KBe7I6qGFEYQhZJvrtu6z6MrAZ0BgEl4cRrkQ9IAH8HiaMNbdzVOWZBALrRBeZdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVbdreM7XrVgYW12oxvQzFStbt3RzVKCkCKlxVUtPaM=;
 b=SclGq47pIYvJtDsFfVSgJ9iOaI0mpqRyQ9R4QJQvNL0OE1LUkWvRoNicJcKrSdzml6KVBqwENCQr2zFNh/wRVTVsnaAsHs/oLOC2vmbuZxe79dSekq0G89WMhk4ceRoX312wPKzzTNVPUQApT7tkWAlH4tfBv+izxz4FBRnrAlShsE7kW+CiXUrTcqoQj2j3zDneuVMF88z50BmfbkK/kikhWAtwpyyuNoyQIqryQWHu5n1G0B79pAfY4ZHdoWipCFG83/l9JRv7OIFdFaQw7PCsAIsoL5ksMuymD7DhLiJx5pqnoV85pGFge6hk5KfRvPnm/P9HrOHIbS8nK9ssmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVbdreM7XrVgYW12oxvQzFStbt3RzVKCkCKlxVUtPaM=;
 b=ka/VvxGcYyMziOQFNS2XvSFTFnplqXpNlLjRCMuLOJntiSTvyptbxVAQk0Fk5PTtd9AdS6UCw83vGrkuh/udGxmdvL4V9rA55JhEhj2Djmq1w2qsy65raAd9KE7UBN4KrRX93EtYsDSz60TBY1myCD/1vIPaF5cvbE30mH5PHea2N21+W9qCF9r74Epr3BaSOpVYz2VIMUA10yEE3Sb2eMgR0QQZyXuzm9tT8WNwYy3Gos0G7Sq+NyJWTiAFEv7bCA1XZz0GK54yQEl5k9OZ7sHKkY5dGy8wzgCcWSwkcsY9i4xR4ZPdyKxBVIQJ69Qjryc6NQwGaRThOjiCGmpBEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 12:54:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 12:54:14 +0000
Date: Thu, 30 Nov 2023 08:54:12 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"mshavit@google.com" <mshavit@google.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	jiangkunkun <jiangkunkun@huawei.com>,
	zhukeqian <zhukeqian1@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH 4/5] iommu/arm-smmu-v3: Add set_dirty_tracking() support
Message-ID: <20231130125412.GH1389974@nvidia.com>
References: <20231128094940.1344-1-shameerali.kolothum.thodi@huawei.com>
 <20231128094940.1344-5-shameerali.kolothum.thodi@huawei.com>
 <20231129194235.GC436702@nvidia.com>
 <d80cd067b57345609a198aac5780e6af@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d80cd067b57345609a198aac5780e6af@huawei.com>
X-ClientProxiedBy: DM6PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:5:bc::36) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd85186-29bd-4ef4-4740-08dbf1a37484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C0uJCYPXF3iEIWWAZ7TRFKno22U3d83+XL8Of0mTbOc1e/VDmGn5S3U56teH5x5KeL0uBivPXMvsgLl7jWqq0GSKzT/Aw+t/4u7diytfMIJxOwE85iRJNd1j6uXdvkcxObOQPGkSB4IiQHL6eEwYB+s6W7HgPWdVTBCws8rMHrtiyCwDrq1WnrTE7tfWT6roS3i1PJ9exLj7UMOkf+Mz/2NV2g8Gvn+jyt7llk8SHHFiA/YqLp+jWHRMSEKf1hA7CLoIUjc5oy5JKkNtyjlrAXrJ6YpBR5qEFXM1HnBRBFFdR7Hw79KqHatFqM1KASEqmGf6aolciKmnF3GBExnQ7hGFILuGquN8+NS+xPSjsaRH/FqRTjhLqqBzc0X9AWgEeznMdbPNYDORujjRgbfAP7Xrg6o5nVQn4FIjOH1Mci8jMCTMr3a07tx6uGHkblpvl4ievkMSo7o89deY7ZMWSjiuVJymqINhA7V3MyK3r2KsQbpeHsWuKdMnoA0WyDmcrHTz4z3n/1Vt5x2+3B2HEVnFH9K0YcWhZv/4U1s+jqreav/0fZh+ZZs3qzBSMSFsvxFM6QaGuFQJ5LjUKhfKKOaazBs2P/bJb/SRzZnPzLW3HJWnDtAWZOSExwjuZ6apjb91mDyuMAn+cBX/kDVQlg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(396003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(86362001)(1076003)(6506007)(26005)(83380400001)(2616005)(6512007)(5660300002)(4326008)(8676002)(8936002)(41300700001)(7416002)(2906002)(478600001)(6486002)(316002)(6916009)(54906003)(66476007)(66556008)(66946007)(33656002)(36756003)(38100700002)(478994003)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?33navjM0VKUfonE1w05Nva/KQZCyQ1YkLneXV+CtCMFJ64qYBJ/1PxtKUjHM?=
 =?us-ascii?Q?0gQ+1iKqKgUfl6SpJR9YWscf/gih0NIMsp7aTdu7vRMl1wV6Ac0u1U066FCR?=
 =?us-ascii?Q?cO208pHbfUFocHnmR7Gc435OSOWa4FLDN9wOgEtIobPOXdp8BUmDfxdRoHpl?=
 =?us-ascii?Q?MzZG7TupbJ0fI/BAC8Ut6N/vre+cBmlPlLgtkZyHa2ps7XgqSX3y8peJ7RFC?=
 =?us-ascii?Q?n2NcMLxkU8glTiV+l1Zn8I61Dsy6Gemq8q57oSNM4pF/MiTElri455V3Qf5t?=
 =?us-ascii?Q?y8QmdjzNUwjaUk2YrPqY/VqQqDBn0zxYb3urzGt2e5NeKmyEGWw0qkefFrjL?=
 =?us-ascii?Q?zSc09zwyLCbiq9hWPX4TUCwCqw3Iw06vmuTGYVpiFEtr+MrcR0d/apjKAK/g?=
 =?us-ascii?Q?Fg4FerA0mc8PJizokL2cSxi6Rl7U7Ju3O7/d8Eyp3HLfLLewCsYjQmFUzvM7?=
 =?us-ascii?Q?y3LEVV+97sSgRruTWmKxTSb6szr/XB380VaOETaq6ujkM1cBgetIdnPApY/q?=
 =?us-ascii?Q?sRTOUWi7+Q9UERLJDXJ+awJ9txiQ+YuQzFx6TRTh8THaNNkSlm9/88SRD3OT?=
 =?us-ascii?Q?YZtfqL0UZOHMoQ1zPT2LTsTHuyT18mq/3vrVCjQj7BCgHNOQKGsjoRIh+bSs?=
 =?us-ascii?Q?izUYQMNiZqdDzp9ySh69IqjCrdT1aCahjZPqzpT4pncko4BU/ASDpCXORpe1?=
 =?us-ascii?Q?f8k5yEJm6E84SPLHtrekqeAQU+ReJXKra0+tlAVZ5eXfwOVLigDbM/CFOPFL?=
 =?us-ascii?Q?bpjdXHTpioP4yjaosPKrNdcO+tUUmU7hhzDoGug+oyxc9dSvc2+QlmWcqfxN?=
 =?us-ascii?Q?jETkbY63lnpWg13ZvGN6vrv2zd8YTEMCnGFZSqGr6nAFazlfpBuqrWS7QSkb?=
 =?us-ascii?Q?JrCkqwJF8RwqMJy2MtgU1ZR0UaU32G8TDThwG+OoRp2665JlLj849g7OAlTI?=
 =?us-ascii?Q?Zt9NX9NSWXAjfnu6f8TJR4a3AyWzgyQ3OyiaoOMudbBd0ODIQCIrIJz9ieAe?=
 =?us-ascii?Q?RhvEMgvdtNR9au92rsCxcQRoMuMlmrUQzID86u2To9uqHm03u8uvWzF79m6F?=
 =?us-ascii?Q?cQCZZykzIxO1EhUvhfm6mT6C5E9lAFhm10RPRyqDrHsbf0KksXxqqlRViwyr?=
 =?us-ascii?Q?mFSyHFifpFmAon8IWoYDRNKk/0RRtEGiNaDBa+wrosZ/fdRMv1MkWo5BrCah?=
 =?us-ascii?Q?FpoCQU6tHy2+heAe8R3IocMzWWzLtvWxTaB16Ka1TrZwJ69s2FfeOkJVcsnD?=
 =?us-ascii?Q?k9k6xO5NpTGllmpSSeasC+2jzK6Zoi35pkwCSPeUYdxfT6YDz3ibePVxhLX+?=
 =?us-ascii?Q?xSoAx6PQTTrLAz5QtpU8n4zFIfNyxLmzXls5/bCmHoZRZl8sFUdfCyfxiDt3?=
 =?us-ascii?Q?9bdaN3gIq+w7re6wYNX7yCL2QgkQrlrt061EWMjQio87h9T6a1uHb78ZM1c/?=
 =?us-ascii?Q?ycXQp4gL6t2Lra3pcZfVZe0oT0P3bb2wjzCQw2EgQZP9huoLfVSH/ezjMBQV?=
 =?us-ascii?Q?p7b6Eq6qwXoMv6XAAyL6xQuhvoCcRJE+EG3/iI1buvC6aIj1QgmZCMG56Smi?=
 =?us-ascii?Q?f8A+mI9ZmcOGirONAlwjdcqsAQDLvl/4SCg7dBpr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd85186-29bd-4ef4-4740-08dbf1a37484
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 12:54:14.0585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQ1azpcOWVzgN1N+0+UmEl3LJYIcBusHwm2kx6ks/VcUrS2guuUz0aLVnhk+6TUg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801

On Thu, Nov 30, 2023 at 08:56:32AM +0000, Shameerali Kolothum Thodi wrote:
> > On Tue, Nov 28, 2023 at 09:49:39AM +0000, Shameer Kolothum wrote:
> > > From: Joao Martins <joao.m.martins@oracle.com>
> > >
> > > Dirty tracking will always be enabled with DBM=1 modifier enabled
> > > by default when HD is supported.
> > 
> > Is this trying to say that ARM doesn't have a per-table global enable
> > for dirty tracking but instead pre-sets the DBM bit to avoid the cost?
> >
> 
> Yes. SMMUv3 has per-PTE DBM control and I think the initial RFC had
> it walking the PTEs and setting the DBM on set_dirty_tracking().

set_dirty_tracking doesn't have access to the necessary locking to
touch the PTEs.

> > So on smmuv3 to enable we have to clear everything and disable
> > continues to pay a penalty since we don't go and mark all things as
> > dirty again?
> 
> Yes we clear everything on enable. Sorry I didn't get the second part.
> We don't mark dirty on disable. How is that different from Intel/AMD?

Intel/AMD have a global switch so they just turn off the tracking and
stop paying the cost.

This approach on ARM means once the tracking is logically turned off
the HW will continue to generate memory traffic to set dirty bits on
DMAs. There is no way to back to the at-start state where their is 0
memory traffic on DMAs. Not sure that it totally matters, but it is
worth noting someplace.

If we do want to solve this then ARM would need iommufd to make a pass
over the page table to set for disable similar to how we have to clear
for enable.

Jason
