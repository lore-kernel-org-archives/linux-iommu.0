Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766353D75;
	Fri, 21 Jul 2023 12:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESiCmpHu+CO2gPntqsalspQtc0OQN+oXRWaUw1EEOPGddXDWjurpde0FnSlSt2HBY0bOJVnTMLjGDweGiO3SqzfUXG1DhVuyXG2bvsxr+H5jef7Ilk2SFhvSLkMBpj2cMzuvyYb6tMQVexi75E7JFQD2fKrM5AhH7QLEMWPB78XgzjhpiCBpDbDoaSTPDZbEMtyX62vTokyM5i6WM/jZ6bywxqI/mWHeuZoAeydEv3gibA0QPlEB7bnxJ0A7rVfA39zHwq+/V0pX8CbJj9AByUoMILx5d/BcM8Hz/Z6GRZcoMl1dQZ9EnElk3WDBiwdGFuxRpX2SAXsgvLtj4WQLxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2TF8sPftjHhRvEpYgHc9KsCMvNukQ4dRQOUlpjcON0=;
 b=XFAIRy7/J8JNnD6ppbXRfyCwvdtbKeT/RosPYmK6OID8VM+gmzJVxmO4E2H3UYotvUJag+dpSdc+6ynudwS8P2wAnhKiKnX8eQMp0+i68rRSYmUTzxiGZlFiLlhEnpCe0O6mxGJN/wjSTKgJB6/OR99JZ5l67WrNN57mS/KaheuDbS8O/sxMVDYLCZITClanbe8I687kPvIqn/WRItRNwBDI7QHyHxWgd3BvLEcJqJ81pMT0sus6yhVw5CFcU3s5iH4geArf4AXSdB9jJvTnoGhul8sy8rVitWRPexLq6zPcVFZoxUykskCuoWI1Fu5S1cQpuQdqif0jFmh72fym3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2TF8sPftjHhRvEpYgHc9KsCMvNukQ4dRQOUlpjcON0=;
 b=BthwQWw4YOSd4hSP16y5zLORfid5RRU+7LsCEhHwNr3H8fRBy8nBO9IUcAd92t19YE5zXcDhIyoKHk8HCwIKD8//3RNik1Su3PdZ8XaCLXss3v6FX2nlD+l8lMGqHX2UoUXyeCg6wfxjAnnLI9+Ml5wfLxTw5A0YiXzRVKbrDkDJKqZEzAUO2waB9TJuR1hO4Gw87DeoOLExGd1s/mQ9vx86DpKWHd7Z7CgKWm3NUyk8OnI8AvS3A9WQlUnyR521Iepu1hx8cjbG53pfDGn6u8HqjNOXLG0RrIJUr4zrZkDnuy3QnyrNeWHlz9iJHFbSF8dkckSQNN5gCkiECpXgkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Fri, 21 Jul
 2023 12:04:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 12:04:08 +0000
Date: Fri, 21 Jul 2023 09:04:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
	"linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
	Orson Zhai <orsonzhai@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 07/10] iommu/ipmmu-vmsa: Convert to
 generic_single_device_group()
Message-ID: <ZLp0NwPJBCTHh7dX@nvidia.com>
References: <0-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
 <7-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
 <BN9PR11MB52761FF5AA9D8A24C30A12CA8C3FA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52761FF5AA9D8A24C30A12CA8C3FA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: CH0PR03CA0447.namprd03.prod.outlook.com
 (2603:10b6:610:10e::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a511224-9be1-4ec3-d9f3-08db89e296b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mcMdAZKbAUmzCog4dIvWK2GR7MK+Z9zbhHvV7Y3P/E8wkZRp8xgcYq6cRAU48MvC7ANMoKIoKoEFkAilJfvXcVSrNGEw5Dq9Ar99qtGTpBDcFn8PhCNKzqW6hjvYPPvoTR2yxRXSBjK0iuk7WPD3rI28PlOGeBo8IwqnIP7G7uydwpyxWOR8sak3PBvv7TOl/hzVLo88Lyed1ohto1yLseP69TfQyjFjnzwcGop1hcww4WdOXSPTxeyZ9gg1f36KZ/s7vfilgTuVZjvTsK9nQS0b3/WFkErIzMte0Pwp+ZsTiDar7Q0ngTsDmZ7iWzT5SyLxyX0R22tx7eKGtls0rtgcXuXd3PhQTK4Tiyx8Chkw5FFq1vVkSDcJWmE0RVaJRS3PiLC+VGa1imzTJrZgv1ArcCRzHYehZg21Zsvzwz7TVKxHSwz8s5eUoj1dZ/1RTKLahSg2u8R+JsbKbsyHQh5rNXx90mfs/ZXWTlJkCbtb2NNh0alIvVKnFt6MOd6ViTtSpuc+BcDpVH5xUUanDzSPQJL9IHj2AaLgt4llBNNSSCVZhSW9lUDbMEgaM4rP4KlO6Dp/csZ1dHdiRYZsbOTXjlxg7gxC0269TxWNFpc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199021)(6486002)(54906003)(66556008)(478600001)(4744005)(86362001)(2906002)(6506007)(36756003)(2616005)(186003)(316002)(6512007)(5660300002)(26005)(6916009)(8936002)(66476007)(66946007)(41300700001)(38100700002)(7416002)(8676002)(4326008)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NmzvTQXRE03BrTEoGwlKLiE6+RYFVQ8sYxgCaMsUcQh/vytQ/3Okxu6IA3ou?=
 =?us-ascii?Q?F9yqNCXmTtzmLA0pEvlTLCdtJ0RoEgA0dQZaU8rdP7Qd18ywfIjsVOYTWqlP?=
 =?us-ascii?Q?LmNAEuSjUSVgoc3v4LE1wW9eeckkzPSH4z55Vo1KLIqksvWF6wLC+DKRMVCH?=
 =?us-ascii?Q?8OFAgmG2C7vT3kGpB21v1bKb+NSIC6Qfsn5GbzAD/jsHSl39MiOkmus1xGyR?=
 =?us-ascii?Q?VpdALRZV+3P3GqIh0gPb42FEKIEiKUakFZy+FKLiLlHSIefw0QGVC5ewWp8d?=
 =?us-ascii?Q?O1pmSn7/Wq9wTibEsOTYFw1ooFLPx+CaUWQ6w7dZd3RRw4VZuSdVt4E+AXDH?=
 =?us-ascii?Q?LzMe15uE2DPisxk4FU2pg8YmYqbY3MlW0CGutqDe8XLR/dGTr2k2T+gDq8tH?=
 =?us-ascii?Q?d+mpjcy0LTqOaCBd9pIQHJPJcUrorYu2AceF+B7hM/VLNrUUIw4V1phFA+7I?=
 =?us-ascii?Q?VQnSOG3d/f0hzMu5hXYRkSp9n3SkSfopvjKghhYwtVSJZfjIYcb/0eiNO66V?=
 =?us-ascii?Q?V/aQGNWoSDzewUPqkStZsjCcEYcg/gB2n/hWqwA4jPZPBIOxV1xe5y7rDMma?=
 =?us-ascii?Q?Xal3VZ+c4+DX6t7voCsf59Xb3T7g5PQG+gpp9Ulw9sFbDL/8ozhG6D0J9YoS?=
 =?us-ascii?Q?LvLLLDOLgdZ/2EMS+QKjl6SsQoNX8iz6cdvzz8SouOW3alD/hmxHM/lQco33?=
 =?us-ascii?Q?TOOx3EM/rVIdGTmrdMs1oioYY0uca0AXecvO8R4md6XvY6rkHOfKeWfxuAdC?=
 =?us-ascii?Q?C3dw3+mRJeI1wVmZvZMLLVZRXLlD7TcKe+zzPjvJcAQCO7HEhwk/nxxSANPA?=
 =?us-ascii?Q?IT0i+c6TI5WfAzWGggRI5yiyl+B1rtbtqcMVqrcQ8iFW300WIDX2aWuTCyfy?=
 =?us-ascii?Q?OFxzKzhkbhJuYY4iC1JCAgAgeCbKXbC/vcYaDhxz34dPpMaZhl6b57SyqHIi?=
 =?us-ascii?Q?rtNeUyGD/oqDUDQdMs8m0MWg9WDPrtYSM/9faAjT7ApOZ55YGJn9sXfb7vH3?=
 =?us-ascii?Q?1YxoNLlNV0oBk8lwrL7KFQVv1rY/pAo+YS4j7bgwwFBZmW2N/6X0Rpy4YNSz?=
 =?us-ascii?Q?vCYjGSSQ8JO+aLaJwtHdkDRpxx6ZzIq59RcuFjeHxc5pWd8qc+K8z7lV6X6B?=
 =?us-ascii?Q?LXIMXqrgtjAhhUuYKGBT+FxOScHV8mSFDqO6/n+kHv+g+sLPVw/GbYm/48js?=
 =?us-ascii?Q?bqR4C0HNTxH8NeXNmBuxY/0AX5tc5dCC5PtzcxgSeDWW2qeUyFpOlsVGhT2d?=
 =?us-ascii?Q?xaQHA+N4ZlkZv0ud0rgOY2nmo40a+2qMdR3/bN7wNt/bFnJv8P//l04dKZZ3?=
 =?us-ascii?Q?5Zp1SwsEok2b6HJwPyO3U8VoG6hCxM3wkN04jrERjSQAhITUIjsW8c+rf6GR?=
 =?us-ascii?Q?HzvLdBXrPFViYV9JNfIUKmQffZEU/mHTRnDXlYtxCBBM9Xd0FonMZuDeP5GM?=
 =?us-ascii?Q?725dao/eMr+gQyxljOh+0jUakRjqpw1X6gpBuI3LCiPtXgg+DZ4T2M8n1HNp?=
 =?us-ascii?Q?UsvtHr+OWMRPfgCy9ArYvgLQNm6u52ody6nuo/N+lKVh0St2hLJmKgR4QIXQ?=
 =?us-ascii?Q?WvXad6wpVW791zXtFpLJioIzt6Jg84UOVxWCFyjy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a511224-9be1-4ec3-d9f3-08db89e296b3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 12:04:08.7979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/PElE4rOeKvqMun/18zGAfzhttpUHLeLnHC7fCc4VPzXAv6cxbm8FjF+st1CKc9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455

On Fri, Jul 21, 2023 at 07:20:21AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, July 19, 2023 3:06 AM
> > 
> > -static struct iommu_group *ipmmu_find_group(struct device *dev)
> > -{
> > -	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
> > -	struct iommu_group *group;
> > -
> > -	if (mmu->group)
> > -		return iommu_group_ref_get(mmu->group);
> > -
> > -	group = iommu_group_alloc();
> > -	if (!IS_ERR(group))
> > -		mmu->group = group;
> > -
> > -	return group;
> > -}
> 
> Looks existing code has a leak w/o freeing the group in ipmmu_remove().

IIRC many of the drivers had this, or other bugs here.
 
> While at it could you add a patch to fix it allowing backport and then this
> patch to convert to the generic helper?

It isn't worth it, these drivers are never removed, so it is a bug
that nobody will ever hit.

Jason
