Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEC627F00;
	Fri, 21 Jul 2023 17:20:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oG5dmTtSGURwFxS4BJbjbWLqH3NdUIZg/WWxUihj7ala/yT0FMc3HSUDcOLOujUakfwXbQ8EZqNaF7zO2SHzpK9ALYa2iiUdK4u917E/daIzqmaouZh3qLudx51wUtgfPCbHsq6aqYmQWQtqX3/8Pn9JHscE9uCA8a4ReyNYTrpoSoDkQh5iNykZmb9Qr0NsMCkkiPxwnen7Ow4vWV64yjwTm2Y5oHASEctYM1eaSTsQhOw5GdUOJEqy0HFbY4olWOCRsZTdfSL2VEy2lGEhBGAcouxs7jfBH/y5xZaYgLbVh3hdVk9DS4Ta7cSF8KncJ5btqdvC68EG3WcKhLiYoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlG5vnS/MyaS/IjxxzSYf43yUdxCln6KmZcxuo+IotU=;
 b=LrXjE70HFes0/5M9koMbD1ilrdrvMsdWNzOgcADRMzzqI9LkQKwowloN/aNE2sgrrbDksCBAqnimhsAP4gd2LO0ApG6KDXX6kKOknwCkCj3Doht25r7jIApyvYXAaVc5k0CvE6sV6p6n12GrmVAOEh0MYF7hP2x+fEpaALidh7fj8XHrvin+CvjM1iunpS15zqTnvbSqy3kQ9irw0a4yARZ0yUh08uXz2XjG5D5xN+HvuwzSsCNzW1+hAHIdAOJerMMhoB711nmV0lK/vGhAllRhWGDRGkO61Bb9aNBRB1i4UfprKMf0QBN4zatuIGmuqUe5iMn1rwXSIL1M9l9dig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlG5vnS/MyaS/IjxxzSYf43yUdxCln6KmZcxuo+IotU=;
 b=Pem0uBisk5GlzYuuZyLG6HdI/fkLMiVovaQeiGXREGdkgk1Lk1jXYRFM5wZU+gDMZdAzQmfJfqTTvEn7riW8WhcaBCEXeA3kVB0VKZ7hOaJLL0Lk6sE9of7TC55lST1sUoT2X84Po3z91NVHIWoOB/9cMNZ8dNdk/ZxVYSibkGDnHXrkA1g14txMc6TkFt+mCW6nLyJ//1F+k+wu5L5YAmsBKJJY3OYKSB4CoYP3lMRA0a4li/3/+zTYlysPv2HRTuxQkJDynH1Eq3OlAeqZ2DKXBR/5GwA6ALI0/Nq0HFhT/sJzvpNIMgqL8qXFXmgfiZXvfVO+PfPWofCbZlmuMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 17:20:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 17:20:02 +0000
Date: Fri, 21 Jul 2023 14:19:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Orson Zhai <orsonzhai@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 03/10] iommu: Add generic_single_device_group()
Message-ID: <ZLq+PzR57D+RN2JF@nvidia.com>
References: <3-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
 <32eadc5b-bb39-5bb1-f124-44feead97ce9@linux.intel.com>
 <ZLkiu7IyimCckiFs@nvidia.com>
 <c98c37bb-57c5-faec-1d17-730f3ceb2b21@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c98c37bb-57c5-faec-1d17-730f3ceb2b21@linux.intel.com>
X-ClientProxiedBy: SJ0PR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:a03:333::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: d371aa43-b9c9-4b81-c6fc-08db8a0eb804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IUaEO9XHYOVyYz0/zdmLpgx3oMSlGx73Ez4lAXfW27C1VYGe7JdNTIt1A09VpiRoxMLxZOeOB2jGVj/bux4YkOMw9Nma/Gd261m3MSpfYz8SZPByy1H9NyCuqyGSQ3ghTwCw0ISsTjvx0f5EgoBlqyUk0C2j3q4puPvqGB4QexT95+di7KM5PjQUAaH7U5Vu2wh7zKqgupYR4lNcsVNGzTzRtB/T/q3I/OyHFwsYJ5n7HtRcPBH473+bF0+nXfBLtrlyjHyO94EWeTYx2tPfLkdndbv27gpKFZplj+5V4VH52FXS1FD0q3spcViOFE3xrONXAat3/bYhjJAy6w3YKj8rZXqR44k6VKzhctuT0p9vJc6xczLquqiUpsMIvj+l63n+O2efRLBuEzEbEQKG6I8ZyJcSOS2vg0zcYI1KN7TCafpe7ahlAP3KriTrd5+7/z/gxXak3vhOdb1CtsZ+z0B57yjBKpIxXsCUQPh4wz80WbwuEeMznTrySjNaydLkGzvRXcqcTQ493inikiOhfROgXb2LVYGW98mxkxeeguJ3eQaz08nksaPKhI80irc+srFs0gzHeOfmrYqxLLn+MthVMkRddFSsBRbVwv2H6dY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(346002)(396003)(376002)(366004)(136003)(451199021)(2906002)(4744005)(54906003)(478600001)(41300700001)(8936002)(7416002)(8676002)(5660300002)(66556008)(66476007)(66946007)(4326008)(6916009)(26005)(316002)(2616005)(36756003)(86362001)(186003)(6506007)(83380400001)(6486002)(6512007)(38100700002)(6666004)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NqVRzfUntqydxlR5czbOYX+hjPhnrACZNSbaC35bpE7N4eG6e1OoYZJSwjya?=
 =?us-ascii?Q?gvcP4FHEzG0XcFbVknNeT2xbpQ25ef6toZT1I2pPrKwK8keOo1fPo/9vgG6j?=
 =?us-ascii?Q?6swM51RWfGWki+qirjJGmhh2A5YdelDM8TdZgFjqcFIZRYiIw9vjTrNYRNf7?=
 =?us-ascii?Q?bAM6EIg7rWelHUHbt4PPYauQkL0XlwqjmGEfByacJv3OAXTrY1L9l23NHsIF?=
 =?us-ascii?Q?5V7ofwwcxbkYSR7j3Ixp8EZiaqzjqZcnBElg9JnGzWOcVTCsuKeMAOOHVzUy?=
 =?us-ascii?Q?Gmjhhg+NEjTdtA6yh28yB/XANERq8/xrFj2Lc5AwbV0WMNmL7cDuFL579aF8?=
 =?us-ascii?Q?WTvJJU6qBOor1Jw+Dk1lKTwDmoV/oA+j9VQRvJv2ib5vLhyUTrLXe6cyv+hI?=
 =?us-ascii?Q?MiukRVo84ZF9MP159V48FcyRUk1EiCFerIX08HRYgwBoIk8PFGQTuc0jXJXi?=
 =?us-ascii?Q?mH2/JvDllnhuOpIdm+ZuM6zV6HXHWTXdGFqIJqo9Zy81OEK5Tb/BeSFJ6qSs?=
 =?us-ascii?Q?IVo48QSk3lHdbHtO7fqwOS28nhJitSzk/mkI8aF+Pw+y2cZ6c1FA0t6j4BwL?=
 =?us-ascii?Q?+/q/+ckS7yLMekfTvNVOFkN6fVNyQdPO2C46EpK42EDkms59eKtf2IgNnfYv?=
 =?us-ascii?Q?jJW8hrEzop5ynfqu2O190z035F6UldcFs/+WM7xs07+m+olAjoA3SuzvEe7h?=
 =?us-ascii?Q?Vk+Q3MAOybYHHIz+qXKss4q+fAFNKCPfwqNFquHut1MACTp+zLtHzcmrHfp1?=
 =?us-ascii?Q?oci42XhtTsIacJmOZJOTyQBQwICRknabMQvy+ffO3whHLwviWkLmqr/ZR5Vu?=
 =?us-ascii?Q?nqtruEwiFVe3RrJda9fYUFNiGzMKSh7EDoQFvcuKGzdkLboo0zaz1K9utz+4?=
 =?us-ascii?Q?XSe9YgL3JMpIm4qew3nrYVawOq5BrxKLskIE3NfrcJ9s+69aLKYNIAKtvcP2?=
 =?us-ascii?Q?SXmOEVPxwVd7pwKTz3fR7xiul1WiEQE0ciRzG1UgFVQNlv+8s+JMvhc5DFHT?=
 =?us-ascii?Q?EpWHb8WRZIQdco1zjkBzIDEWjeGPP7+NgKgwvQDzwawq01EZKys2FStDMBya?=
 =?us-ascii?Q?Oa4TM3TQB5r2QkGRZ84g/OD13IF09aGV3dDKcb6glqPI/QQeI+7/NETyGdRL?=
 =?us-ascii?Q?68ayR39nfe+oxoBU8l2zrJRM5IHKy1jbVskQW7MA77JZ//pvXe3ceK0bsbsn?=
 =?us-ascii?Q?h+Y9qUeSn6DO+b/+qOrTfIQUVKK2VGvPr78qFPiDC5Z+YZ4qz5MIzcBNWwNa?=
 =?us-ascii?Q?II7KNzfRXUjHCOazRgXsLzeTkrOqxDm1Q4oW8UQ8eWr2BbYTdyy03kEIpVh5?=
 =?us-ascii?Q?24Wj22xOwQDVBzN7OWClVfvHLSPyOfkdWQEECqhOGA/6WF3HUdUVjl3xXuWW?=
 =?us-ascii?Q?pCh5OX/VlJDoqZikcYtJatn3jn+FlpBu2oWjlolXlWcNHMz852AQ6nZPHjyJ?=
 =?us-ascii?Q?3U/b7rYAeEmxm4Nd2oYyA6+fkTHIFIFjGEvg/dNegXp0CGpSW6Tqr1d9ABPj?=
 =?us-ascii?Q?ZN0ImmWhcTsKYpO9PQmfThHZiK/PzyWE2ocaK82pKBo3riYGIXDY9SsexmFc?=
 =?us-ascii?Q?0Xb74RgBix/U7y/uWsM1yC9XrnOjfdaSl1ZKhMwl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d371aa43-b9c9-4b81-c6fc-08db8a0eb804
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 17:20:02.6325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p515rP9P72N2ucEaO6mLiHPBgjjEEPmd+1MDVgpCe0WehfoSQsIxzdnx9h2jT98K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018

On Thu, Jul 20, 2023 at 10:01:54PM +0800, Baolu Lu wrote:

> Then, another small comment:
> 
> iommu->singleton_group will be freed with above put, right? Do you need
> to set iommu->singleton_group to NULL? Given that iommu_device is not
> freed here.

Well, I think the general API is we expect the caller to free the
iommu_device after calling unregister so this would be like all the
other places we free or put something then go on to release the
memory.

At the very least if the caller thinks it should re-use the
iommu_device then it needs to zero it.

Notice this also doesn't hold the lock while putting it, we require no
concurrent calls to probe with unregister.

Jason

