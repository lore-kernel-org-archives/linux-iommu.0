Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E88129A9A
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716556830; cv=fail; b=WM/aX9t4ChsE++gij3apDS41VyyzwcIJl/IdImWDXwBzyNlRtq4WcKw2trF1tVt5CbKYRYu09SOpX5YsASOfoJRYyzl6BnK8IIqI6TmbfCRajgTyykjoJg/Q4lp3zIgn36cUyNN2nKKKVbfgq9TspWGetieRcRrHynHGIzJ5ta0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716556830; c=relaxed/simple;
	bh=MGngmGFps8h6ie1n4VfMbvNPonmhEbAAKWwZkOj2pQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ycaw5z4+kbcRmZyTOFKf1mcT5eCpJvoAxdfeJklbPLe+fbr1vvcwSTr/6xnOEw4eUxUGL+6MT69QDPbPfSRIbEypFuQo6hMt/dOQufErgs303lYyXxGOKItbK7C/beNitFoZUjhoFdLDsMSmZkoyoVHKzTaiFo1VlSfFYEOCTGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kgmVnNUy; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kgmVnNUy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7qHOK32ghjxcTFfBBN/Gs+J7qqxAz03X5ovD2TampJ+U+mmMjaXoXQ60iO2ZXtLXQ2pt/5NoNghgpEAHSLplIyXI6/FjXQ7yzsVlJPFe4vyiRqzKZF2yMEWWl0L2Ye8GtTWLKtL8k5u68mbT7YOiAfJfrLWU2APwiAsUEsfzbTjV6ILDh5m2f6qSmx3r54J6of4yn94w+sEALRG9aV9YMYVzeIh4Dct2/sWAbidNkqx5BBcqIF6Q49Xnobt8hgL/1B/Rk7+Te5hYN25/OpQbffjIuoL5f6YpNlujHtmekAGYC7Kb9PdtNbtR03jS4L9PQNaqe+Lr2xQX2c2AbQbNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLu8/ugY0YeG3oL2kvjFML3moIZvhF2Ih6bb5mwQB9A=;
 b=oSG+2c6yr4Jkwk2b1Nf1WP7BMPOT8hjyAEgWxkKPbYUI7eZ5RZkqTqMo9XNw/Y6sZZW4sJRxFFk5BdzriExZO0jHitUtUOjdESirHbxFETq16msdSvyCFZA+1dJuFm60F6iQ1/Akjp7ScQw8JUyKeRB4L67BtiZEvAqsFH97RUlGDvIDUQD/Qjf0VKC7hByaFEH3PRj/neDeUFUv4HBl8tuFgwx0OxCEIZSQ9M6osWsENvsc4NjwVHdKsxOs41aC9YOXpzOOwMVoMEdotTBgdIWmeskfDuwQkPkY/fpJdqmtPziGw8NznZmao5MkxA1bF5w2Diw/54gm5pZ/9Gbdlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLu8/ugY0YeG3oL2kvjFML3moIZvhF2Ih6bb5mwQB9A=;
 b=kgmVnNUyPg/CSOyDcp+/ENQknD8/uYOBDpGQX0UgE8oVo8fsCRAlOp2qJieHLCEr/2W7fPnkW18cjaVqoHMexk4eFRlWT2d9ikdUF0qcL8RKuJoO08bwdsL2nriYiExwA8v8b/qmwHYz1DwCBne+RmVDOux68qruv6xF6at8kzDgmB5cIJVu129jfOACrksx5XCwS0xvfHYBFoojA6R1e1hYOfgGIrb/En7hBuWme/AYBVvI2yVURiZPoLDV6d09WdSysHuAG/jCeWIisaH0iV1WQoVqDN+KZEmnod34gFznjBvP01k/iREfUjh2CoPpuLXhuD9oqsyIFjDyaxXGDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 24 May
 2024 13:20:24 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 13:20:24 +0000
Date: Fri, 24 May 2024 10:20:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>,
	"Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Message-ID: <20240524132023.GU20229@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <c97a98a72ee3498c587e5898d6b899553ccd9b27.1712978212.git.nicolinc@nvidia.com>
 <BN9PR11MB5276A897A5386DFAC9A35F9D8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlAoN3s96HL7ROth@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlAoN3s96HL7ROth@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0174.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::18) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 73aea56d-09c0-4d47-3db2-08dc7bf44526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q1umko8Zv9zLCkldHDEF2yOAeHnArC+gtk57EkUlR8+zfETll52v8ysaF32p?=
 =?us-ascii?Q?Jt+JNZS3mSNa7Rax7NSH+wNmY6bQr3ZSOtq2bPp5gnhHRndcwS4xy0H7Pior?=
 =?us-ascii?Q?l5N00i4SLaejDck9aDH6/GpLuZQ2dlDOMgRBh4TIvoHZw9/2lJhmSsUpdE0T?=
 =?us-ascii?Q?n8/CJlntgEnYg2H8VmNtf2X02yYGvgVeuZmse2dAy9lIkYv6K8vU9OTpihQV?=
 =?us-ascii?Q?2oXLr62Sj6IEn7rNW4KuJJUnPS2U44W77ROYmB7UW1RVVfkEQ7mMpChfBeGp?=
 =?us-ascii?Q?lW0YaBeK+fr6S1EejciWYk+TuPunkfmNegYJ/wGE9u786AMWzOLF5EWzRJvL?=
 =?us-ascii?Q?YRoqInpRYrTOesDqHFIrRxne/cgYQGFHQKR/tiWLiM+ssmmjUr7j1SQNsNtc?=
 =?us-ascii?Q?9PyEyUnmUKjCzBU3lXTOgdKVu22Bl/AEnSZIbAzElhLPNeLjVg8VXV1l6/uD?=
 =?us-ascii?Q?+4+ZzI/PjcdrW4QQMiAxU2vyUHT9ZwLrAA6jRxgis8GFmuYPDFHYza7/7fVC?=
 =?us-ascii?Q?gNe9YAwih8a5xTwFGEIQr9ncdDIWbXFpythKvh61BAZTdsj0qP60n+tSmP8M?=
 =?us-ascii?Q?+41njHFGB71UZIPFdvERoQ2qMb3OxxXrcTtVDLQ0wE2QdX3Lyz0cm4Cygl8g?=
 =?us-ascii?Q?OQtnzGyZFuzEcHV82wVXvpS37TMtNCXxTTIOwItBkVfcPYh4eaOjKUCJRO41?=
 =?us-ascii?Q?qDsa4olNnUxOe3VeMV9DrGq9Gfj1gW5xC4FMIb5dOVkKsa6VptuUhE0f1u3M?=
 =?us-ascii?Q?McveQW61Ecff4/3Psdglu4eCR6MZLcgKztUV+bqW2B5X2T+xKe8xHdSoyVhm?=
 =?us-ascii?Q?fMAlv2+vuk64uyLhvn8hBWzLO7l3IEaDEZriDC17vz7EXkZWCjucCnqZSGay?=
 =?us-ascii?Q?kwkF/rJAR2kgEgtP+C16pRK8JVpvSq0hXCHVoMYnXaP/6SgenUGSk4LdrfbE?=
 =?us-ascii?Q?1Ije9P+BqP+J0a7gmibgaLJHj3nE8d+8xY1O0Kzp8iahox2UfdL3FA0dSQmc?=
 =?us-ascii?Q?QZGLTZ0XTM5S9SdeJRRU3zDdQ3EDlii8LbxMzsfig/ce05wzCDJg+MAUwH6J?=
 =?us-ascii?Q?s6sNNJg6kdjvWNFl/QAMWMQdZCqk1pX3fN03ak1V99Lo7SkAcy/gTIDvzR1K?=
 =?us-ascii?Q?upOkPtBe4ufZNaQEl95Odg2tFm1/YVwAamtLRPi4QpxdBvOa88wJ3kM/mcfk?=
 =?us-ascii?Q?G/EQ0rStcrQjCz6OJwjIwZMVjmdBk1n4sTPx5n12gAG95HXaWuEzD2sDQqWv?=
 =?us-ascii?Q?L0/2OOV32uqB5JYfqmp3wXESdOI8i8G1RZWbxz/9Mg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1X6otUY66Jcyv8MrxFErY1aF6wh+SjL5wLW0n4RR0UrHzIpH5RuVjOhXscxQ?=
 =?us-ascii?Q?Z/kNaa/GW/SKGsmd2gk0XFe5zNuNdAkkzy81eq6dGTTrqyu0N24UVj7aLBCw?=
 =?us-ascii?Q?2eWmsdNSZo9I3hfUfyvh76z9FFOVtJaZp/U/YDPm4lL0AEm6zsXPj5RLgIly?=
 =?us-ascii?Q?LzbWE75gxC2YWjL+LZ5Pr/IBUGtWJJo7EbgnX0R9CRtnOc/1/cgx1uBvElm7?=
 =?us-ascii?Q?b5YZZ+lRQPFbhS7S/8h6tPxdiBp+BY4ywWpvrBLv7yaHyFy6iUWUrxrbcIMV?=
 =?us-ascii?Q?iafkAoFoc8+1aOOMC0yDOB4B3pArK5w//8svbNEDlZJJNt/nMBlV0LrHfG7g?=
 =?us-ascii?Q?tmR+RkUUQG0tHj6tZPq3TBv7lEvrls9g8I/lypRvOajdQk0KdvrUYh6O73jP?=
 =?us-ascii?Q?6wGhF3egouvjmUC/Mnvv72R1sjmAcjiBWvdMBy4EB2ELVvokqGealun0/ECc?=
 =?us-ascii?Q?frwso6WwP38dTK+4h4auy0dBa6lTzzG4OP/mQttI098RqI2ztsH/hyT1hmNy?=
 =?us-ascii?Q?6bOAiGxg3HnRMNRji27+HoyHtY1MH92p01oXMumdB4fZsdVz0U+DDl8HeAJr?=
 =?us-ascii?Q?rj2Xnpsg+3H23hzXmaXAtFfCZno0qjLQQSXWgo5I/hxUI6fnyiKlIamtWwom?=
 =?us-ascii?Q?pgmf3gstTGBlxo2PtzXiAYUuMNtyg4z84OwDQOC/MwTCM0ftYLqNdQAvtfh/?=
 =?us-ascii?Q?3XeFr6FB0WZ9dJzxz5pY3SUs5wEOdGbCP+Xt94uLbCYarXKHKI628OOWXJzP?=
 =?us-ascii?Q?MOaWu8cIeXg/rDpyqQ+i8Z1vpQ9ou5it3h1KATYsIaQcicVEpowUWBnRJalH?=
 =?us-ascii?Q?yDjFd0J8tRULGUo+sLsY42hgbb5uNqLk3zKuxyEeXTzESZBRmWa3qnw11dz/?=
 =?us-ascii?Q?L1vamdnFyDL+oRjAQAdG0ShkvRGEsRuBOvEFgZINdcsqfREWOVHTPgEN5zzU?=
 =?us-ascii?Q?r9LRq6GDF0oEDHwzePjPWJ8NMZNABp0ZUgyhab6taEoiqTTdTHQJ8uHn+zUp?=
 =?us-ascii?Q?x30tipqpz8eTxyQswI3xTrXA3PQCxdfO1Zb+FV8qZQItG/vO2IF8dEshxt50?=
 =?us-ascii?Q?rLS9InYi8udf6F64gWZo+hnoVAVN/Da4/vBsjgXZomWAfKGrM12gBiJoscfx?=
 =?us-ascii?Q?RXV7h87/ktmbYf2pTQGEk09s4viQXwq4h1ots40uEtGz2PvGbFJ3bT1l9Mdc?=
 =?us-ascii?Q?u04bH8sdE+0ORbp+Fp9VdTmasq6J5ShTI1uM97Ja/pcIH+1D99P5vJjaWxiu?=
 =?us-ascii?Q?HxfYAE27foa6amJzz/QevTEssuKMVWwBxVwqxdLHmyilSNYbsy/jODB1Nzn5?=
 =?us-ascii?Q?KcSoszAsZefr2AsjOp66oxYc9I1QKkl6qGou6WvjcwTccRhgudZHp2AjdKXt?=
 =?us-ascii?Q?vZ0rwUTTf+g0ze7nvPMxx2usyTxsoHyD7GsbUPKDaI5sH0/eshJiqvBny1sP?=
 =?us-ascii?Q?oZCGDLaE2Scqnxj+/JAL92Xj+6dIpwJj/5jcUtkV2g/LEX+61dlUwPofKKYS?=
 =?us-ascii?Q?32JWeopzeg9vrw+5GaEM2uN2xd8597OxGcTUreimhqfRHE4+ZDMQkw8pfeWf?=
 =?us-ascii?Q?6dLX4sc9ieIcOYRx625SzxQfSeDyIGYkEMyQRc8X?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73aea56d-09c0-4d47-3db2-08dc7bf44526
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 13:20:24.3145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjrT/z9dsoj2HcvcRJgsXFhe1Lp3nQvkcCyiMUI61KEb5VxkBuqFTbeAyNkym59w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955

On Thu, May 23, 2024 at 10:40:07PM -0700, Nicolin Chen wrote:
> On Thu, May 23, 2024 at 06:42:56AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Saturday, April 13, 2024 11:47 AM
> > >
> > > Introduce a new ioctl to set a per-viommu device virtual id that should be
> > > linked to the physical device id (or just a struct device pointer).
> > >
> > > Since a viommu (user space IOMMU instance) can have multiple devices
> > 
> > this is true...
> > 
> > > while
> > > it's not ideal to confine a device to one single user space IOMMU instance
> > > either, these two shouldn't just do a 1:1 mapping. Add two xarrays in
> > 
> > ...but why would one device link to multiple viommu instances?
> 
> That's a suggestion from Jason, IIRC, to avoid limiting a device
> to a single viommu, though I can't find out the source at this
> moment.
> 
> Jason, would you mind shed some light here?

We could probably do it either way, it just doesn't seem like there is
a strong reason to limit a device to a single viommu even if in
practice that is how everyone will use it.

Jason
