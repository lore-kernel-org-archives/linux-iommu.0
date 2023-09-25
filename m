Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1934C107A7;
	Mon, 25 Sep 2023 11:42:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8I8d3Rh09yHqFp3wsAovoP4x1FaC9XJzdTNv8swsWnyt5UOfiKNUGFtbrRa9o95QIFy9X+Mu48+fIYXt3CGGOSx0KPv845eWvsq0OJm51geMIsO5TVHQAOkzGmQXPUHdP0Z/IUnlfKaosEMLjK+zxGBKK6Awvawe75R56RGRgUadyP/7XNBitTv43eCTJ0Xgt8jxz7+p2n7TSgJd5bIcNg+xbCqtx+U14kF/rPVly24IgFg3zbxCGh7CjPmh0d/IMyiwZvLWrGFgvtdejbT4D4BBDfEwrQadQ8aUdyV0ezUIJOZUdZDDuwWwKpvzw7PWqAcSbqWpqujLkqh/j2Cjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xm3TGBUZbWBFHOMVs7nGTsKwsA8wOlLmCMQGveh5LZA=;
 b=QJYsrfTPXJ3h4SLtv+ff06msKFxVtHzzRI+9ZAkFHKPhAK4XnLJK/N19UqTXeTnsYDMFMv5lWeS8Owit+Px8w9CbiYsWRnO+LAGKSCyA19vnhk1nHj/RjEI1LxAGT5pFTmitIswxSXczxyI2CC9JE1XiTqFH11jjrJVckCfHq6OYWeVYNjl9GgwkJnufr+x1ZudKU3OG97lE8CdoLVcZsVG8j/+iIlk9oBb3wUbaEfmyo98g6jxOiWn06WUIpC/B/051CqbZ7Pu7XFZAQX/Es7MHIVTtKPAZ0mvGaltM5L/TKZ5WT1wtpdSvFEdB0fl6O95+UkTpNpJSA0vjatQByw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xm3TGBUZbWBFHOMVs7nGTsKwsA8wOlLmCMQGveh5LZA=;
 b=T1NK//CzhpRvdruQAYGcO2U0H7KfqS16LB3ETB4VM6vno3ucRQCnW13IGQzrJJVzF0NzYmOKFLaPbIX4To885yim7I6cffoHqwYZRYkuj6jUL5Wknd3ugpqOY0OzeKhBoX6QtjvUjNzOrfkNnyqndNU/A9qsnM4DgFqPesZKf52OglE3/lQPvfjWJDdBQh4oEPZhiqEqhtPBXxslGa28R5wq8u+mV6YriF3pS1HJMCsxNfaYOxkCJwqWSHdlTWCG7u6QmqI8Ich5gDF8q3VMyNqu+bfHXxdJ8xOhjRlpf853C3Z+F3e8ldkLx//AeqJcu+3lbJqO2M0SjdQW6t2eqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5354.namprd12.prod.outlook.com (2603:10b6:408:103::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Mon, 25 Sep
 2023 11:42:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 11:42:25 +0000
Date: Mon, 25 Sep 2023 08:42:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Orson Zhai <orsonzhai@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 0/7] Introduce generic_single_device_group()
Message-ID: <20230925114224.GV13733@nvidia.com>
References: <0-v1-c869a95191f2+5e8-iommu_single_grp_jgg@nvidia.com>
 <ZRFYkYXUXFOpvk_T@8bytes.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRFYkYXUXFOpvk_T@8bytes.org>
X-ClientProxiedBy: BL0PR02CA0112.namprd02.prod.outlook.com
 (2603:10b6:208:35::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5354:EE_
X-MS-Office365-Filtering-Correlation-Id: 3422f985-9371-44dd-9f6a-08dbbdbc7cfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tTWNuh/YbRgBSumVaWQynelh42N2TtY0GAf/o+YU+Cloa+2RSpzWcl8gjGF65elmk2QX5Q8CsK0FJ0e+LRFtoYcpKqssNDL/QgJydYdqKwZptnlVUtcuHGufVMdukj5JUJttqJwFzv46rh4LJ1ouxgCI5cwcBuaJ8jHpysTRcC0fyCrJdynSW17uq7SqLzX/aNZ2gwzeDS/S8YK4VY/C1Xjs6eqFRFehA7Sl6ioIPdPmxNmYfACihKKvzxfCFsJ2ld7GC44dVrAhZGzM64AC/hQVxM/wPHUW7Ze63NwykFO+VKsC+b7sMaO5JGxGzBB0tPClRMXwzooaQLn18+jdtcmQbrgZ+GAh7FnU1YDdUePbAsyUkU0LwceJm9r6x7at/rugl6y9Et8yl8VzsTUEHBbRlDpQz8AmozfMIoGYlfwjELTNaO9OqADV6eZPBN5lDmrnAPZU4Ipx2MYAnC5GTvE13ig0rpba46e6mB7GAMOEF/fBAPUuKZdpqYk7E6s0jyS5jIcpILGr6wyi9AYrWd4oITKpXB2t6IzUtbNNXZ5BvnP861nHpY3IBojqKOJSjdG2IeiRKHAwb+nmf7RyWkLSv15yGpjTS4PUo6jsWWs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(38100700002)(33656002)(86362001)(36756003)(8936002)(6486002)(8676002)(2906002)(5660300002)(4326008)(6506007)(66946007)(4744005)(66476007)(2616005)(6512007)(478600001)(54906003)(66556008)(1076003)(26005)(316002)(6916009)(41300700001)(7416002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8TFkJFLBM3u7C0hltqVbH9g1zj3TGzdodxdT8totaBhrc1czhe1lVDGXAyE3?=
 =?us-ascii?Q?jzkxxG39eRoSxBH2hhlt0rXniFeMOP9psaXt6N7bEpKKmWCRUP1/fpXrvKa2?=
 =?us-ascii?Q?mFWez0aFF9U5KBDQWiWfEBt7ZkrFcLPDpFxJRjHVwgTnYFA7D3EOxggv0m58?=
 =?us-ascii?Q?rIA3bU19+r1H0fRI4ngb6SzRUZR4dGX3EmA2mHKutLTrZnyY1+3QaytiKcMx?=
 =?us-ascii?Q?TKmN3zvVEKh+TZJnF2OGmHjQjR5M05wxBkhve2VqvWeGwX7xU/LMikHpP7xR?=
 =?us-ascii?Q?QmJ90FZOi2GeMXvNxtzIiprMb6fN5EHfoFv9dWkgDN4oEPa6P9h1pl8wtHHg?=
 =?us-ascii?Q?WXDwhfzVwPUQVbK5vQhkVqBJAWfBvPKs9jXC2yX/ySYAmI/cN6VyH8MKZahc?=
 =?us-ascii?Q?l+jweWhE4Vh7pkYTqOKFp5L81hyFwvvqCvefh6Yc+d/wKKVLU4qvAqcnEiv4?=
 =?us-ascii?Q?6caoOqCf4G7Fjia9CQRN7H1WlWNLNy6O6NlZeAVwa/UV6BFqTHyX1WdmiHZX?=
 =?us-ascii?Q?qzusyJSJhIqTbCJcygop3v2ra9CErgn5vqI5xYEMVv/PJyixwLMqUFV8sf5D?=
 =?us-ascii?Q?tXjn6WMuZjWOoLPYXVEp7/uEP+Q0Mdi8Vf+CW8NbmbfYPRU7TGhvdAs3BBiD?=
 =?us-ascii?Q?2XtxiCSz4mRmgVw6vwE5+ObvlzbEH32vZI86ppMkVi4rVcYd058r3cVoqFXl?=
 =?us-ascii?Q?HMFubB2wHM3Vtj4alwJtFPu7voKtFrtoDbGPIrkxPca565sqVh5he7jTDVbm?=
 =?us-ascii?Q?s1Y1cUA9ScTmuyMY+XDeYSCmfbZ81fgUKy/7qlRIt+K2nT7ekakoiUiCf4r+?=
 =?us-ascii?Q?x62tN2vGE43u8fuuCJOd6EBVMMlKvSBSb6ip4nA/kX7oLoBLBeP4PmbyFQRO?=
 =?us-ascii?Q?k2TZVb98uec6E5nG4CFOD4XE2ZMtpdj3L//vRksHh4r/UJAoRYdw0y+nsCco?=
 =?us-ascii?Q?cbkFXG96KCO+fLZkN+GF1zE2NPNc9+Y2Z+Z/JICqNmD+73DUaCL2sID6twUH?=
 =?us-ascii?Q?3LSJbsqYlPzMCYDgTEYdrbd1KNEqpZ58h442KvQUCb7GW8bWDrRxy+nzmB1g?=
 =?us-ascii?Q?mP5vw1MfcbprfDpY1Fg4BJUSVFvJ2MWtnXTLDz3nb7qfIhNEYCtk4nvktSYs?=
 =?us-ascii?Q?95Q3IE7FNOUAGnEc4AkeBIlx7dMdS3hPzmYCIoinpTXDefEcnl5JfUZxY7hs?=
 =?us-ascii?Q?Pq2FwrX9apnngCKw80VcUVHSC/JripvWEvA5jj2oK5Dv5zPhyAwVvf8+/Cb9?=
 =?us-ascii?Q?NtNLEsfnv9XSnfCclNe90WnQp2FmYXc7fb1iAavgD0vAqxTgNtY08cmLmdld?=
 =?us-ascii?Q?6/M8i/a6E6Elp/xC0iu0kO1VXdNuPySyjIlrwy/FqWjnIDgkgX8wsCxaDTYL?=
 =?us-ascii?Q?M5ou6cXgmAeUmza0YiRsFMKGXdZozTegM+0VJMQtaAM194CEtcWfsrweJe/9?=
 =?us-ascii?Q?oAejPaWAopdhUYnruZOiPpBEogs6Nd7+JnFCFzGagR74zUBxvhx5asE/K/t4?=
 =?us-ascii?Q?MqUcZne/ISKHps0tzaKo0RW5IwpiYLBHN3M+s/nAeF/2GB+92iJ3E7VRyauE?=
 =?us-ascii?Q?MIdumEIKmVQtZTvyRf4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3422f985-9371-44dd-9f6a-08dbbdbc7cfd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 11:42:25.2771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eepmQeT2WWUlvuHulYsa2serPiSxUXwy5+jrjWCa0Kn8btWn7Z9S66mwTjfGNF3w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5354

On Mon, Sep 25, 2023 at 11:53:21AM +0200, Joerg Roedel wrote:
> On Tue, Aug 22, 2023 at 01:15:55PM -0300, Jason Gunthorpe wrote:
> > Jason Gunthorpe (7):
> >   iommu: Remove useless group refcounting
> >   iommu: Add generic_single_device_group()
> >   iommu/sun50i: Convert to generic_single_device_group()
> >   iommu/sprd: Convert to generic_single_device_group()
> >   iommu/rockchip: Convert to generic_single_device_group()
> >   iommu/ipmmu-vmsa: Convert to generic_single_device_group()
> >   iommu/omap: Convert to generic_single_device_group()
> 
> Applied on-top of the default-domain patch-set, thanks.
> 
> It caused some conflicts, but those were easy to resolve.

Thanks! I'll double check it

Jason
