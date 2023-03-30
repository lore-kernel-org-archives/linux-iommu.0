Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461578BE6;
	Thu, 30 Mar 2023 19:01:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPchAsmfcTYK/SPFd89mom3Yr77K/iL8YheYyY35FDjv8xpIwMDlVqbMXGEA9hTumr3pnwFwQ0IAd68Dm0gc049I8I+yLl2nJpZrYfvMATh8Oa1xNFIbgMy7mswERXnzCehr4KmGKI1oMhetot0wzJFKoDR9ms678UrdNlW2qqMJ4K+r1eigWmlmuXy8HJepteJASO+UYrvDur3tC2caUBEP4NErcxckpA/9TGpHOvjsI0EK0a6ETKX3ZEDXh1K+kr3XDvi/fuQZFRBN9ZpjgeA+I6ZVOE6bHF1W/OReccM6PsYo43MWrDI179auyfjRWnk1/HjKWX/yVyjAye3bnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEE4ajZfw1uh95hjxa5uZlG677e71ci+PQJJQzdq1GQ=;
 b=OFFT+Z683v/rMsyWsJEfJmV/UFiZUdNoxIyfjzzVK132CiTxtnCD2rqUvEu6EB4SWISxboCZKtzupRSkHk4GVC0uz8ERFlBpPVcJZAirJoo1kZYJwm2EXSVvgzt3+T/iDlz0WsiqsZ+c+9bE1Wb83QrzqQ9ArLiBxPasVRystFlVM1wFC/WRC4DgNMqucIG02CT1wuZIZ1KAZIAkoqaiSPDUSASmghQGyD78PGkaP7nPKinTxhSVZjkrzaXJIP3VIJlNKRlhmVKYHpX96YMH4FPg/VJi0a+OfczQTIP5WsA5c9q2CHqAWAijXJe6HWgr+gmBWh76Iw/DNqR9BGr8eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEE4ajZfw1uh95hjxa5uZlG677e71ci+PQJJQzdq1GQ=;
 b=c7HeI5Ey1gLMMA8rOpaGXdjVoCjFTmeEVxmfU3/2JRsmbDSk7P2NHmk+/xrMk7ga97KCjbR2A359g9/ZQOf2T1eYLdgj0ZdbkArPBsrzoqe4W3yujvB3HYrUH/R3j28Z4q540Gaoswd1jSTTKxZ9KzY2Czg3pJPH270vq1w+K2uerAllx2LOlRWKcYY/2CELrkPjjtmv7ooxdHXlYy6l4zhgIaQiuCYlHNICHhPvAIXtGoMaIFmBzC7m5OF51fqSamOgIGbE6pKcy4qPEXZ6UTspXI0NukWaVgNQsQBU/UQ0HScWzHEtFEN8HQLsOwackhuP22mapHQDqF8sGbpgNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4547.namprd12.prod.outlook.com (2603:10b6:5:2a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 19:01:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Thu, 30 Mar 2023
 19:01:04 +0000
Date: Thu, 30 Mar 2023 16:01:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 12/14] iommu: Consolidate the default_domain setup to
 one function
Message-ID: <ZCXcbxLfilYKAb60@nvidia.com>
Reply-To: "group, target_type" <eq_type=iommu_get_default_domain_type@nvidia.com>
References: <12-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
 <19197c52-139e-c3c5-2771-42323d38c045@linux.intel.com>
 <ZCWsdjM/21IPvjKi@nvidia.com>
 <5966bdf2-2a1a-2970-9f18-784b88f2f687@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5966bdf2-2a1a-2970-9f18-784b88f2f687@arm.com>
X-ClientProxiedBy: MN2PR15CA0044.namprd15.prod.outlook.com
 (2603:10b6:208:237::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4547:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe7be80-5fda-49d8-59ff-08db31511c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F82unYpGIG11o3H0AGbtND5KhfZ/n0E0Zihs+uGmNsQYf9j4r5Da2/kls+gWFHh5L45GBBQFlWxmpXoPubTVDL6y16Rl+mesr00HC3uBn1bU5UbSxrlCP26fwOP0aCAP80/b3zlH+pNBrknvu7mDCBx2ePDqmL797L05v8nA/OwngxpdAXHhZsoTsHmvTmIIb7h5ZGRl75sU2brgLI4YFYbuH8BxHRcD/IgnCAx8iNXb9gg1A5qqXKLKvpVyNlMvui6JtJbzu+BF3u8zX4UMuA9tTcM1lbHTAYOLRhUEz5te87sUVGMTTGK81IRr/N6OEl24DJVAItJrNT/rJS+WHWxwAdgUaiK3J58MND/j/eE3NMSM1XYqEJq9g1AfZueaQhRDA5RjtzpayYLgC/hrqRRUb9DEoHklKN3hiNBi4UTdNz0M8oq56aSDP4Hv4Gr3IXeMRiQLzBExDKR310DVtL/r/7sBSJ/ymcnqywl3wk87zLY2d4K15WDxIMRmm8EJlpr4hBf3m7qVjJk2kBwulYlZsq2/2D+UC46JuIgZHS8JXDh0O3721AljXOErqfTL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199021)(41300700001)(5660300002)(2906002)(7416002)(38100700002)(8936002)(4744005)(86362001)(36756003)(316002)(6486002)(54906003)(26005)(6506007)(107886003)(6512007)(2616005)(478600001)(4326008)(8676002)(6916009)(66476007)(66946007)(66556008)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c93zXEBFbzoExgwTOXtlbAJfisuc3KoRdooKsb8vkzMFJyn7ybD1C/ZzribT?=
 =?us-ascii?Q?NLt559nfLmu7zWZq7buz6bhCcQGonv4+pRSGzOm0qo7143WHyiavEyO5ylSR?=
 =?us-ascii?Q?whZBO0vRJMwaZpp24/V+nI2cJkqJw+xs9UMosDWDtaE0u4pHVZYFsTXYXJmH?=
 =?us-ascii?Q?NrfvDAyf/rhTGhnYhx9Xt7NfN9A5bqOQn8nEN9WBRU0SEf81dVjmrUoe/5/D?=
 =?us-ascii?Q?Y8H0HYA2XeglYPgbAfdxx/91nyoGmPzL+udZz455Ssl9FZ7mTXiHMNt7Xw1f?=
 =?us-ascii?Q?XgmSYKxFeASLo3H14O8lVaK/0Z4tZsTj/5yPDAajkLAEcB5vz2MtYCphCQpy?=
 =?us-ascii?Q?yy9PsRpkozXZD7zoZveQVSLgSShbp02oOGSwQ9Q35vkWfqu4VWVwI3+rqWlR?=
 =?us-ascii?Q?lntWyiFVt7Odb8CZzGEBZHCqnthsSHfm/t04idKRdpkNOS5FxbdEZj5vs4M6?=
 =?us-ascii?Q?PAveVCmFQk5oKYC8TEDAX+llJV4I56w+jEXrjvaYS5Ak6236ivAh7v4Q0Emm?=
 =?us-ascii?Q?yERe0FqReKH0pL5jA45S+evdn5yDbr/99qtjMTJKYM6ZYfFJfgJ3hIrTFrfh?=
 =?us-ascii?Q?XNa1ImnEvpRzY7L7xP/kIDwdU+doCV7S+cT3GjBFUgcpXAzu5xoA+6LqSWjP?=
 =?us-ascii?Q?WU8TL8Ll+nhXbwtKrcSdzIV8UBgoLQHJ15n+ob2X+aJE7Q7YRf2Zxy/vesOl?=
 =?us-ascii?Q?QtAhTVutvd+g9uzz2f0dYBo0GHqnJX9fwukNbBlUEJg4yGcrOX5uY8UoakVt?=
 =?us-ascii?Q?VSVmfUKX40Dfu1X2REwkuffLi7zV91onOBRV6PsfZwT24opIuhrl82sFp9jJ?=
 =?us-ascii?Q?LHQFUS/q4LCiZyChF3+QWXsM+D5wjdCdPsP/nB/hIjAsgtqdRYvlYXlR18g3?=
 =?us-ascii?Q?6YLGWiQ75zmzUjZD9hmdJkx16JRnr3ScM45bTMNiQKguNTVgkIPW6+dePdGS?=
 =?us-ascii?Q?cB2InVKyeq5kwo6VfbobbS7mK3OCfI6+dcA2AtxqivM072a5TopZXplqGriv?=
 =?us-ascii?Q?sVoShLlI4FlCIIlWKMGwgavbx+FiGivVz8t/CuT5GXmI1f9KCOCm59gnQ0/T?=
 =?us-ascii?Q?1PHRPBwCm+d0oB0Plu0gxr8samWsYD24VQRr3pid54KLxIL1Nuvz78K3nDcy?=
 =?us-ascii?Q?mMpDSjhy+lxJBfaaeIzjHOjsCaNbsj/hztjs1PV0P2WNGQ7kY0E9NTHfJ0aC?=
 =?us-ascii?Q?ksBp5A4s1F8iM3eS3iyusZ9wWOjDUy2Q9R8E4RuQ/QuGEyvw4onAvWCaWjRD?=
 =?us-ascii?Q?xf58AtMqBnaOyGByEXc+m0TfdVFAp8INScP1C+x3NGyXGhyu9xbM0ZT0qWFQ?=
 =?us-ascii?Q?SKYV6VPdOrR4aL31X5BodrGvt4DtzrbpEwHtR9fpVIZeaENVaGWQyNczIVHp?=
 =?us-ascii?Q?LNEHIeyG+z0A1oXfhzd3ENqEuSQm45NXYjAIvL7BuptbzVvim0CVA5oq6k+/?=
 =?us-ascii?Q?mdRZy93xRhyRvNgg/VW1j8DfGLP25pPA7CmtHiO30TaLDYe1Sm7vYiHlVjJl?=
 =?us-ascii?Q?BN4b0bejK0aoH7RQ4wKbSX6lRE9ocIDMDCmlFNF7NYdxb+TFnkb5TlrFelj1?=
 =?us-ascii?Q?lPode4wfVRDvbuHzthu3U0X6NELbGpP8WEr9qBD1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe7be80-5fda-49d8-59ff-08db31511c28
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:01:04.0075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TR9f+lIxLOJMWiNnpZF/qvzuz9Pdm8PR42kim54tCB/b/c+NnHVZGdIAZyAo3xVq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4547

On Thu, Mar 30, 2023 at 07:23:56PM +0100, Robin Murphy wrote:

> > I changed it like this:
> > 
> > 	dom = __iommu_domain_alloc(bus, req_type);
> > 	if (!dom && !target_type &&
> > 	    (req_type == IOMMU_DOMAIN_IDENTITY ||
> > 	     req_type == IOMMU_DOMAIN_DMA_FQ)) {
> > 		dom = __iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
> > 
> > So the auto selection only happens if the target_type is not automatic.
> 
> You mean "is automatic"?

Yep

> I'm missing how target_type and req_type are
> related here, but the general principle should be that if we have derived
> the type from iommu_def_domain_type, because we had nothing more specific
> from either a sysfs request or iommu_get_def_domain_type(), then a
> !IOMMU_DOMAIN_DMA failure can retry with IOMMU_DOMAIN_DMA. Otherwise any
> failure should be final.

Ok, can do

Jason
