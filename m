Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3C845947
	for <iommu@lists.linux.dev>; Wed, 27 Dec 2023 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sv0IcvN+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcv1O6hieJbgEAkH9O4813aTrqzhjfKoPD+f5jQOSgf0SvNRgJCcLYZW8OStaD8yOxHGUPCiMK25C+lpT1grMBg3qz+CMTl2MbP886F+2a6gW4R2mVO+lXxoUX+hE3TmUHzu7nr2h0zmnH/8MJDzIMFx2XdG0/tBxVNw7/e6OkIHkvhQA7w5IyGgMoGO62vNxUy0I1mw8zuTA/DJpWkh9jf/y5fxB3gX5hlwcdadfc6EIGXPk8qm+RaV/gfAxs5VHmLVkLL8P26Vt/cy54LJDIpeT8ptcquY1uw6/fiDxNVbH1z0NRK2NDoQyA2RfXr3tsEpxmx57Bqb29v1PVTwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C04bYCeQGwzEpM1m82McJgBeD9tLS/bbsbhvLYW9WQM=;
 b=B/2/4niFow3phS+63kH57HBZkwhR/q4Mo7CqaK2s4noWPNQasDl9WWUDL1YozyweZJLrZU4LtQ2nUbTjAxYnTYbt316TMpFmSTBe/obN9ZJw4zYTeDPyMKda1zB2HKHJxyUEBu8+hlAgAHHyP2eSqFq3mgz02ZLemoZSpNYH6blGUh7xYCuBRVr7JSKCtpyWYTlDUyrcqxkA4OaOq2RYnS0DLC7se93QmrjydYpwLOtgfHXGrWeZq6735Qqftd4gGtD2Da5Jb4+mor1md61biiIvqseZwfaT2HKmpI7CjCfupp5CTEgNlOOGp9CJKCWRtQDSrL2WKP8OkB0FprWprA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C04bYCeQGwzEpM1m82McJgBeD9tLS/bbsbhvLYW9WQM=;
 b=Sv0IcvN+5y09T+KFSNjXjPPW9x6WL9nY1DhoNFIQU5T0Udish08VIm8quF4J3pfcCJnRmHWe6L9kOTgSkS6LDbHQWW2Yc0PET3Q28S9uLY6TJAwjZKaoOVYoTSkw1lKJzXREOs44YXcV7Ak6i/lYPZXU6AL1EeGvG4RxgGoCAP+0Sb0xtGDQFQq3fyyguLVJdg9MsApapokIRE/MOZEgY066rzCAvZksZqxxLANR/3vIl8QoD4scA0mZpcVwhd319M7r8k2JVs07Qv9WAZzh085O9FBpuDy9K/5a+oaOCx14NVR6Chz2vIT+VxTMMK1YNByBPyyamD9cMVeuuyrJzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9140.namprd12.prod.outlook.com (2603:10b6:a03:55f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Wed, 27 Dec
 2023 15:33:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 15:33:14 +0000
Date: Wed, 27 Dec 2023 11:33:14 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming
 independent of the callers
Message-ID: <20231227153314.GA50406@nvidia.com>
References: <20231018130455.GU3952@nvidia.com>
 <CAKHBV270uJjdj4zeK-NNt+j3TiqoGDdLUQ5uRrLw9PN0ysCDbw@mail.gmail.com>
 <20231020113918.GD3952@nvidia.com>
 <CAKHBV274M-DDD+vJgO-k9s4MF=FLhKajPdphfBVofjyOS3vHbA@mail.gmail.com>
 <CAKHBV24nfdq1q76T+DRQGNYeA-kP7ONnSjDsRFGsQCJVSrSm0w@mail.gmail.com>
 <ZX7xu8jN/rBZ4A/d@nvidia.com>
 <CAKHBV26CRC8eWMuOk6EZYMHOZoR2FauP=NBazzOiWCmQYEa1vg@mail.gmail.com>
 <CAKHBV27qsgjgwPfn8OpSq30z1w203NDqBZ0s66bPgjp1XDnLOg@mail.gmail.com>
 <CAKHBV24ApTjc3hy-kbMD9Y7wVdb5OPTb8bU6AkZdCQPg+LWDSg@mail.gmail.com>
 <CAKHBV26kVYoXP-vNtQMhv3fBDYSmSCG5AU8eyU=D6fWUV1BCBQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV26kVYoXP-vNtQMhv3fBDYSmSCG5AU8eyU=D6fWUV1BCBQ@mail.gmail.com>
X-ClientProxiedBy: BL6PEPF0001641E.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:e) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: 60be599a-c54b-492e-b563-08dc06f12458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JqHW1EVSXj2gbdv1M8PiWtxMfLGuNOSoEypc3wAgNBM9x2Xnd8EphiT7rsfWtunbspGHHWwNk7E5eihPK80u0YsuCkfPc/PWe5jhoLdf3VGvugsDfjNuJHwCvCTHFfHKYbIPi4DrWiCqGcaSFWy0Us63XMDzU40Oh64KmZpRgPAjY2QNWGAHpVmkE4PTIKOkIE7AFPGmuTathnFfpA3a+O1pxKrQCweio5S278SsTumjtWw2Q9d+t2GFhsID/KdQ8Opc6RgAaNO+5U7435M07WZGyvI8zL9f2d0pajq55069h9dCCV32iGxHhFJR9b0jO7H3rbiebUkyQPXQqu5MhHUlxPuOONBBJpDWkrxABlwZp/hGkEvFbAiQPlLXNBoAcEg9c68frRzIH6Gk+mdLSrMXAo31U8Xu3hKDVtmdG+TS8MZ3c24QEuzGEolBV0AP75b3+NniT8B6Q0Om5uyp0yrvbL2sP+CjVB1JkGcdzDYvlgRpo1/+jqRkERJxsSVU2fesxxUohl/HTxYzZwQcyjQY6podskV4V56+VUBbiktmRBaJIA6YgfU3eAg1JwJy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(6916009)(66476007)(66556008)(66946007)(5660300002)(4744005)(4326008)(8676002)(8936002)(316002)(54906003)(41300700001)(36756003)(33656002)(6486002)(478600001)(2616005)(107886003)(6506007)(26005)(6512007)(1076003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cLw2DNB1zOEX6s5KiIp89Ezgf+hv57CaEd4iFJzS9wdkh1XzxTWjzXWEqTLK?=
 =?us-ascii?Q?oWZXSyVdIR+AsYzGGvLZxSbcYG+Oo99bs4iTSOQwFaFxG10mZ/pI74TXvs6X?=
 =?us-ascii?Q?0TkaSU7CVPsrN4FaQpOno4IY8wlKknA+Vft+XLC/wkNbjXnSKsqgv+00IMIq?=
 =?us-ascii?Q?Kz/O18vLaA2N5FQVtN/w3KSnua6+h1vjljmyR691AfuCvmNTkRPjY6jv73qo?=
 =?us-ascii?Q?fnlPLQqZ6zvRn7ozZXKcrWgURz6xwDiq02e8qDj11xohLysD8DN/pArwqpl9?=
 =?us-ascii?Q?ePbP4PzNGU2z/AaWXP3XONsR4g3ytJPwEfGG1Vm0bcQVCy/FGdA0kdHUtFF/?=
 =?us-ascii?Q?4V6Rwn6A8Ciw9j67L9nsvNxku3t0FjK+uIOLBro4ceAKHMznK+lqlCh9qmHg?=
 =?us-ascii?Q?ktbOBxlQ/FapkLbuh+i4N89QcJTKnbcF28N+xEEi0yDn2g7kYGhLVUojeWKD?=
 =?us-ascii?Q?pjmCGmoCcpJLhL5zw1ztrRgDCFSnBZb5b/iourfITFhu2LZuxLqxs3Le9Evd?=
 =?us-ascii?Q?xtVVmNpNIXe39kLj534+JgIpQuwQVyckY/wbyivueciSMHqkb7Il5RZd4Za8?=
 =?us-ascii?Q?yz7Wc7LUJe9+OvSWvpS0VOeFbiPAamIJktS7CAMidi2IBKgoKotYmy6RSZ25?=
 =?us-ascii?Q?3P7P/Jy31M3yCPAjHvIJqwTetVN9dQAckI9yU0mN0KzB505rcFcIJgiDJT8U?=
 =?us-ascii?Q?+kFx8+UjKSHszFJYfk5O9T+cVXic94LrKQ24/lbKsYekhS+AORPo9pQQM7fD?=
 =?us-ascii?Q?PJGi6rPyO26DsZYCE+XskXAvcnzIxmbG4Bw05yxk/0H5u40BtML4aOOf8Zfa?=
 =?us-ascii?Q?b5trOYBr7wfNWtXgfFACrKrbuT51U7sGAGyh67gPLiUjrLKKyjp5Q7XxB6Sg?=
 =?us-ascii?Q?3Js6Vg0u7Z53HSUPEkFuiQZVeXYY0DsemSG2DNvFy+DdSLbHPQnE1+VwIiSd?=
 =?us-ascii?Q?wWnY6dqklrOCzk96c3P7zji5A38YJjrpK7q2pXf1Dne6Ex69PKhkGSeaoYJq?=
 =?us-ascii?Q?DtSeW5/83RQ9yJVLNFgDKk5K4FE2eCB1DK0fhWzt8K4aaiwKEp8F7Ucm1gk/?=
 =?us-ascii?Q?9Z1pdDHalQZk5Oei1q7EjNLwuZ9OvYgSNk28+e7sZOyM+V3/JEPjuFVOvnGW?=
 =?us-ascii?Q?U2azJkw2ax7cmT8QGQY/es111ULCdBL5gyhK3t2E11HTTG/1DyZ+Pj2czOne?=
 =?us-ascii?Q?XSGkDMzakmlQMOqzfqoRbWzY91yorsyDqGhORJng9ieX+tpJU6H8noKPij4G?=
 =?us-ascii?Q?XomteVlU2yE5PHkCas2y/JYF7GvGqhfMImvka3E3Z8Z15vRmcjNIJZ6uwbvO?=
 =?us-ascii?Q?5qxQVqxp3uYxmSBfHDbgwZf3z1IAeBKMk1tILOaSXIuSUr5np8e9patX3QEx?=
 =?us-ascii?Q?LuaGIQHJDV3Q8h1TzvbwNzwavRQTYjTsjLH0skt3AXm+AbAUTHDeNFBJeRcp?=
 =?us-ascii?Q?+o9O/HhxEouY4p0gGs6rVh0XQzLRjTqMalnkLR/z/kgIgvUzJpvfvpFGMm7W?=
 =?us-ascii?Q?OAMgVd7Uc14im2LfYqB90j42RImALwImgD7aE8o7vzvN4D40gPARXYX79/2m?=
 =?us-ascii?Q?MR6Z2UnP1qi3+2TpWuY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60be599a-c54b-492e-b563-08dc06f12458
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 15:33:14.8201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lw0G1kTjfPFH1VwHOgoAcHfbCsES5Nf3RKi5lDsc4qSssnclzASvTuZNxc5l9wq9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9140

On Mon, Dec 25, 2023 at 08:58:06PM +0800, Michael Shavit wrote:
> Ok I'm probably getting ahead of myself here, but on an nth re-read to
> sanity check things I realized that this is pretty well suited to
> unit-testing. In fact that's how I caught the bug that this last email
> fixed.

Yeah, this is great! I was thinking of building it too! Especially I
think it helps with the concern over complexity if the whole thi   ng is
covered by a unit test. That is far more maintainable than most kernel
code.

I'll look at this in detail next week

Thanks,
Jason
