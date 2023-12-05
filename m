Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FBC56472
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UTdISLdT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRfe9wYSPk8CfpB/TSTnzarw0/wGOLLqQ/+F0Nx+JCJ7XmrzB/jiTgl/Q4JuZ3jAXKLpZHdrWTUrNgs1dvPFK89HlxD4poG+ttA91z+jM1IW/f2Dy6SpMdmDBw22U+dLfm/Yp5+uQped5Q6ITtSKfTtNuPQR/qmOamVX4kClwCKYtmH2ahwcehJr0RHyL78J+bwYl3mFAxMbh3QMOABMGOywipc1skzfvHzsMBzG++VPhErD4uCcPUAbMjsORzC4NQMEy83pgVHyrTqulSsbA9ulw36B0oAHL3LlZzzsds2+d6cy+Wf2MmRr7gL7KiJokO9+ng6G+wY1bdk4Vrq2BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXqXBVzxloIiyZdwftqp4Kry6PMeD0xOjIe/jBJNaB0=;
 b=f9yBRhf5We6iwBAA0b5B88YvWhgDtAhUwl83Q+Uspmbk92qtV2FwdPywqmxMr7q//qvHOkK1ldztzv2i2t9/1DmHWAOBTG+uLnZzu4zq/g0RUIQ6h8WdrAQkdRZJIfizDCmlkuE2RAtUhsuRB9DoNpnWFE+t3qcjW4IHj0c3xKpfSDFnJ8LV5WtrD6JlLED+WRQz38QvrdJ5RBDWB0xiCzH6Ea06y/DsOP2iGoSqNud+bfXLeAN/GsBuaFofazokrB4Cpq2JhNFnigQe1dojvRTieeGixu9/smXYEasYh7YWJyrFukv3ZmFWwR4CW9vrZpjkLOLLfIJxrm9da7t1Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXqXBVzxloIiyZdwftqp4Kry6PMeD0xOjIe/jBJNaB0=;
 b=UTdISLdTGmmsj558eE4HvuTeioElYkm2vJKigmyU5te4EmVsLrfxYWylb7FoIql7JXhJJRuQRoXSZrRyScvAuBK7hZl8Ua8FIViEWKYV3k4uAKec0ODz1EDxyH64egoCkVDjx0Jf64LhShgB99MS25DMx+8XRVLfFjEY1NI9TcKZOfwFHoCkAJtLM/D1BzWMQwHu/H9D4xoDYoDMD7syruhSeR12vLoqn9IOT1XXUHALGEkdtcXBIHSMJ5Z8eMprYaaDWgiRnRqHs8zxeDqGjLSW2B24xGSc1TGDXY/ttMJAMZe1EaFuiU3CgOICjenHQkxVpm2HzK5QdjEJZy0duA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6579.namprd12.prod.outlook.com (2603:10b6:208:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 14:37:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 14:37:43 +0000
Date: Tue, 5 Dec 2023 10:37:42 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 15/19] iommu/arm-smmu-v3: Add a global static IDENTITY
 domain
Message-ID: <20231205143742.GB2787277@nvidia.com>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <15-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <ZW6m54yS2rpk65kE@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW6m54yS2rpk65kE@Asurada-Nvidia>
X-ClientProxiedBy: BL0PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:207:3c::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: e4aa63f5-e140-42eb-4d57-08dbf59fbdc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W48xaI/jjYf1/r/2g+PyrSoMNe5WxVSqWJO3qpb0okV+VONTMK/zxj0svkeyh4RyIUXM5M3EMs9UNyxMIOYJsvkvRaAYqh4bakkGbKRfgOjMB3POiFPu75ajgt5dqvpvwny7xeKUiyYQFBF5tDGFHi2bhe/qYaaSeoGg8RNCsXOit7kgiSIo6sZMjp3heiZsAxwSgg4TIjUg6QOlGnBNBMEfkzISo2v28/vG+2XxFK0vwAFkXHnkrs+upLXd/Xnh5MVnKIVsoGsYandTaoDrXQro4pv3+llgr4a39CxiUaGEtODnuzfb1u1vGEREF6XBB1q6Trc5TlmTdd3x2pFegbTbU4DSut+AqvpgkCPsy1T6+05Yi5NucZgdFg6YpSOwm2fvjiL8txLKzEA8cYwbImhp52JSvnEqqjdKcqcTqfJmZuSu7ek06q5n7lxbvJCSN/gHRVJ/3fUliZsaNaMK67Fu90XKrQp8LxumMbYOcNBZZtykCZFfxRJ3UNtbQBUveyA+cqUYXTL48zH37uuPrQwpsamQd+5biTQ5iwr8esCHnoFGqw8QjdBz2cxf219U
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6486002)(478600001)(38100700002)(66946007)(83380400001)(6512007)(2616005)(6506007)(33656002)(8676002)(6862004)(4326008)(2906002)(5660300002)(36756003)(86362001)(41300700001)(6636002)(54906003)(66556008)(66476007)(8936002)(37006003)(316002)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KZLzfXm4JKes280LoYl+dUn5UVRdcrEte4rN7yzcmh03wlETreJ+ELGkbLWF?=
 =?us-ascii?Q?8HOjCEjhFmmz+kMvchC1xigNdnFX5Xns2B6e7Tg5Mhlns5CZO3lxWqOS2PgS?=
 =?us-ascii?Q?prfCIWrjHQZkM5P/qcGleDHfAelKDAR5FAXv5fln5zz6L3QC/xaL/YKBGRP5?=
 =?us-ascii?Q?z69I8aaJglfQxTn0p5tOLKjAav2D97reVlzBMB6Jmx9grhBmTJFuAJWWFiMA?=
 =?us-ascii?Q?SXeaTjEX8PWDUmppJT5AC3qqwXM3iecSnt1EVnkERtoRzEZGbMydtHRbPvTI?=
 =?us-ascii?Q?Xt8Qzk2ioXjYtXI9QGXIxlVYxrv+A31wkledkUXH0VB6nxeUvR0j2vK63e8A?=
 =?us-ascii?Q?rv04rLjnq3KCSlDs4kR6+EDAdZrOf1cVKEAfUbCdO0TiUiWs3Ql2NwaQB2qN?=
 =?us-ascii?Q?BKYurifQL3QeK43KsxeOTo522Vtb938cLbs7/FbuOCexBb+X0AHNK4O86BAF?=
 =?us-ascii?Q?7bWo2OfC0AzjnzyBfGa+l5phgtUDhYVg6D1wty8KidLRjIShMBo61T15m0tE?=
 =?us-ascii?Q?UI0nGWGf5XV/Hai/+/VpdWGiVuuOY1Vn8chMm6lB1g8iCpd47yXsy9G2VSXq?=
 =?us-ascii?Q?PntXO9stj0l7lRTB2z1MPdHsG9tuHIsJHgz8K6IWDqQLSm1I8NpmjtxcyqBO?=
 =?us-ascii?Q?E5fZ8NiYcyCTJSmjg/r0SW0rFr52ZuT/syLPJyxLM1kH70G+uPI6Dd/w47Bq?=
 =?us-ascii?Q?wxXPxYKCrraEA7a3PbchVzYDLirmMGV44LA7rMLhB3kTn09q0jTtLP+mQKJK?=
 =?us-ascii?Q?zRw1s6w3aafbBGJI4o79vSFppN4UriI6nQQXw2LhffjtCxk9RqqWc3WfmCC/?=
 =?us-ascii?Q?w3vRMbb2ki0uDpyIPgyG3PKuH49QlvoifoJI3NkBGQK0905+6eEumtGsHHXM?=
 =?us-ascii?Q?ker/ox+J13RVyvxOAgc8eYEQb+dBfrQjSwJAEWiA5i+cydlTZwtwTShqFrKC?=
 =?us-ascii?Q?EInZXmxqdNugcCypovGsY50rxTdW1gk6yXzmwdYIU/+i2bcjl8tX34ioheLz?=
 =?us-ascii?Q?1gLZPfKlgjjq4rmhLF7Bgsj3580EynaoXCXDx0FDktZqarXgR72XXy9L6CjT?=
 =?us-ascii?Q?5ikbtn8K7mHfAtjY6aHPaUFZQXOoqgCICAyz30tXFJbfv0iBQrhn8iDkFNK6?=
 =?us-ascii?Q?5R6NBvccPkGRl5tv+6cJcLznoiwVvUqzbCvaXdLkIzFUYoWQanq2rJIzw/Rg?=
 =?us-ascii?Q?kh5AKcMP+xsdhPNMRZ3GSswkzd2gtQa02elmuQbPelYo6c57Pnaq8/wSvRl8?=
 =?us-ascii?Q?2R/h+CZfuMszr9+vhMAcPRrbgqNdsxAUt/yN08v8SD5bJ2BG0DkOJaklRDsh?=
 =?us-ascii?Q?zzGuqQW0D5k4mL4bVVKn3lgH05KakM5kkjJESooZFRKjPWm44ozkVW1FQpzR?=
 =?us-ascii?Q?WycWBF8lpUfFgfIdiRW4tUoFjh0qARxpyu0HnlD2DY8LBKNsuw5T1+y1lNDn?=
 =?us-ascii?Q?OAXZ8TGr75TKncywg6f5f2Uu6I8SBTxFr7tiPrGQKUxEG+WD4pbwClzWnYzJ?=
 =?us-ascii?Q?eO/s6ym1S4bN/GLlf9H6mdRL/wJgldOFeiphsx6j+0pDqFwATRiRsYfHPUmY?=
 =?us-ascii?Q?tRA6rUX9gCLDLWuJiJQVI4elKS/G62nj5FEOO7wo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4aa63f5-e140-42eb-4d57-08dbf59fbdc5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 14:37:43.7316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaz8HQ7Nr82d8L3gr0wlPJdl9T4H03riP91aS6uKpYu+oX8vCvI5qVNVtuIF+9Uk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6579

On Mon, Dec 04, 2023 at 08:28:23PM -0800, Nicolin Chen wrote:

> > +static int arm_smmu_attach_dev_ste(struct device *dev,
> > +				   struct arm_smmu_ste *ste)
> > +{
> > +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> > +
> > +	if (arm_smmu_master_sva_enabled(master))
> > +		return -EBUSY;
> > +
> > +	/*
> > +	 * Do not allow any ASID to be changed while are working on the STE,
> > +	 * otherwise we could miss invalidations.
> > +	 */
> > +	mutex_lock(&arm_smmu_asid_lock);
> > +
> > +	/*
> > +	 * The SMMU does not support enabling ATS with bypass/abort. When the
> > +	 * STE is in bypass (STE.Config[2:0] == 0b100), ATS Translation Requests
> > +	 * and Translated transactions are denied as though ATS is disabled for
> > +	 * the stream (STE.EATS == 0b00), causing F_BAD_ATS_TREQ and
> > +	 * F_TRANSL_FORBIDDEN events (IHI0070Ea 5.2 Stream Table Entry).
> > +	 */
> > +	arm_smmu_detach_dev(master);
> > +
> > +	arm_smmu_install_ste_for_dev(master, ste);
> > +	mutex_unlock(&arm_smmu_asid_lock);
> > +
> > +	/*
> > +	 * This has to be done after removing the master from the
> > +	 * arm_smmu_domain->devices to avoid races updating the same context
> > +	 * descriptor from arm_smmu_share_asid().
> > +	 */
> > +	if (master->cd_table.cdtab)
> > +		arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, NULL);
>  
> This arm_smmu_write_ctx_desc was previously within the asid lock
> protection, yet now it's moved out of that?

Yes, arm_smmu_write_ctx_desc() updates a CD table entry and that does
not need ASID lock protection. The ASID lock exists because of the BTM
code rewriting STEs asyncronously.

Jason
