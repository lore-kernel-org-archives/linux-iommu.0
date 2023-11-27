Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB4336AF8
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RhVhQQI3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+U+sGHp7glur8oa/YZsP4eL2gxP70lBNZ6QmAgn7XgGCgyYSHq/wS8HaEnHJ14Y0fGCOGKZOsn0ZcT/2MBvjSC921dw6laFHmkEiBaSRqdcxzoPXqOrnNr1ers2kRQThqrGEimnGMAMPJF5fF7qeBeagLp8Rx/4GLDzbR6vrShZ+6e2Tpa1LbWvupLyrZE2rGVbAskTyrPK2t+MaEc4+LGKdrfzLm3KJRvTX9rzfd1CtDxAyXSSlTDj/p38BBmkacDGgku5DjCXHM+DjvzQnhbFjmbq5uoTvFg+UAOCdy1sddvXar7jZxdp/LrgNqi6S0USWyi6K3a+NvmFSQDBNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtneVO4Iaq26XaOt5AJnMkGp4yo/PihJsC69qFRjBSQ=;
 b=AG/oc/6kQqJ1IUS9jf/VteWzAwDdaa6M79yKa4ILO6WohNotGMM5OD7eWuKiYWdqJLeZhFaW6nKS4NwBeC8s26tpAybBqYAnqJaJA11CzVQOjEeHqXSIkPGv9HLEAI52T13/Bbm30ICkN7doSd7chM92i4in0XkN7GZI1UCQaSgDpOiLdhQUdlLykwQzJpKxS1d+dPeVdq++yPLMbgY6xt6dneSF1z+rCxt69srfR7ZtGT0RoMQjnyA2uKkcOkPHNLkwNwbMEudoXsxEXs2bfzrREfrGgW8SxBp9YIFDjqvxKd41L65bIs1smalV6JJf0byGFXC17Dcxi6Ij/UUAgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtneVO4Iaq26XaOt5AJnMkGp4yo/PihJsC69qFRjBSQ=;
 b=RhVhQQI3RibOUK6GGLruyaaQ8SzTgRIKVk1kJPz5vgDFfuzCQ6eDXEZwWuoFBdo7kU3eDGtxTrKmyjp8V7p4F9ENiDqASEFfxg11sWqcE59suT3SFo+j6xbq0Y1Uhpi4g9J+fmBAbeL5wWWsxHTx2MotnPOkysaHCiyjjJbHXv1OTj02RJ0HwXxOFgP/Co+DzvQz69AdwcQkRjyTvjVXABc+pg7rxUXk8l6hDnBIuzuYW2Hv8JNAkM6T15QIW2OEerCsCe3Kzc3UqLaIEu+DciWH+BVYEIe72+XC+XH+YybJNO3jMZRNAUQzrgluFqMgmXC/wV/pbjRn9MEwrM0E1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV3PR12MB9268.namprd12.prod.outlook.com (2603:10b6:408:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 17:48:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 17:48:53 +0000
Date: Mon, 27 Nov 2023 13:48:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 00/19] Update SMMUv3 to the modern iommu API (part 1/3)
Message-ID: <20231127174852.GB1165737@nvidia.com>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <daa2f15d7f6b475d8388cbea7a9f4cb5@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daa2f15d7f6b475d8388cbea7a9f4cb5@huawei.com>
X-ClientProxiedBy: BL1PR13CA0146.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV3PR12MB9268:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aea037b-2403-4656-e5ee-08dbef711f22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1m2j7NpKxNVqmHK89KdWo46wzJn/mAEvTD2ZXrwnzYWTU7Ul0N8026j6lJnZ13z498aRdOndU3hL7C+olTleH8+sDN5K6w6nXB7yo8jG6NTvCDWqqKWbsCGyJETw51aLhuDeIXW+pS7joUmrEdN6QYp2iE4tQ9e1VzCcqLCsO1a4L9ghWrQJZC02paK2bijvuaNx5XTnuaMvE9uAnHhwD0RRCvfu5LowL85Q7JHiSM8AAhbBUqa3y3pzoFTZ3xFmozlgLtZP7Lqpm2xER3a8nurhkIdgsZLuzlKQUiu75LB+xYifzgpCUr8KOeEpZsBjTgMFLsR2I192BSsUvBzdyWIAD/h+juzYOn1OP0udz5GL2OuoEc4Eqiu6ixvcJd/VUi1KAGGSw1FihPlk6buuwF4q7HrxSLqHVdjhMHb5XncaUR7T0ETrqMTQ1yE1Wu7CQWAgZ9nB8UDxFa10hhwqjYOTy7FmappxcnXsBwdUbkwOXwbBVCdXQSVAtJOLwYMGFTExls5XdPrH0+md0FIw0PzSwiy/4PfRJ6Levv49Z43Q5rz8nZBzYxQERoRz2/lsiGTs4HnGIDZKkZf6XGnoyyd6f+DKq2KZuVPLgi6rIPo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(136003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(41300700001)(36756003)(86362001)(33656002)(1076003)(4744005)(5660300002)(26005)(107886003)(2616005)(2906002)(6512007)(6506007)(8676002)(4326008)(8936002)(478600001)(6486002)(966005)(54906003)(66946007)(66476007)(66556008)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uR1QjerxDiK3feHcd5LDxKZnmcjV7zA/0iQIXNAP+Bk9itr+VTHoTE7cD0vf?=
 =?us-ascii?Q?xnvhyRWVbgdvOEJX2S8iJLBQ3PrjGKGJrcIrY1YyDiN3J+v9f2e0qkLHp3cL?=
 =?us-ascii?Q?NfOmDb70UxKqn9hV95y5fFZ8m7XxImm2lrL+oCRcrG7hWUTAzbV+eAfe6g6Y?=
 =?us-ascii?Q?+Vi9X0AREVXe1JFsgyZ2D6uWUXqdteps6Mnhw67Mya6+Oan3UChpMfmxk0BW?=
 =?us-ascii?Q?JuwryRK4tCJrfc/TCatxQxbsQlHi/xAdqjA4DvTEIKf82LeKQWixoHLSiaIP?=
 =?us-ascii?Q?9+ANX1hb4yKSuamhH1B/5ka3VPh7NvTHuDZJxJlUqxaFMd7KDU0tTN9PCmW+?=
 =?us-ascii?Q?ylMYnTl5CT8G/kszBYuHh29d6hOTTNXG0RAdP9H7ZK3GowWXcKBMqzgA++l8?=
 =?us-ascii?Q?9GrPac8i1ZZoUl4qho/wrzcFBSMYW5MybgxWy/zwgJBSn6pN9S7EWjE0KDl/?=
 =?us-ascii?Q?CDpiP6f4tB35VhHVvBkFBWerFHJdfkhbm9N3PuAEOy36xD60u0GwFr1tZfUi?=
 =?us-ascii?Q?nQ6akCOUmYIS6RlfSwDswwiKs3Q8UNpdqbR9+xHeN2oGGnIgbZjJw4E746jM?=
 =?us-ascii?Q?ETsIjuUo8bvY5NBw4vhCSUqzAgO/wBmYpHG/xdb+rOu30qrwNPr+FCu2ySIy?=
 =?us-ascii?Q?VpVusVpoeQNn8Iz/H6/E2O8ES6riyBPe4otPYENOgiC+LtaFTwfS55UvUtPc?=
 =?us-ascii?Q?jSK4fFwuGKqEb/2H/E5YWozD5u4V7wqMNc3yIjtxM00XL4OWGYBmNutacZyc?=
 =?us-ascii?Q?fonOik9qHrd/EjQxpZTcBq+X1b1AOL59E+w8wyeoLHvrHq93qflJTHp7wqRa?=
 =?us-ascii?Q?h7ALQ+oYfd0U/nAWMlVKuYrHwiKVp1a+Fr8f7wk6gvzmb/zvRumoScTzCTYt?=
 =?us-ascii?Q?jlitg9gu9gbk+Q+CspcdgvwH6ELQ+X4Tkj2TnXW1rOrSUoO/UVXSzZ0HO5o1?=
 =?us-ascii?Q?r6HyHAqy88XvLIyJ4kFV5zBWlTFujjzWIQ9WscIBTNW1kXg/KOQrSMweXgSr?=
 =?us-ascii?Q?TSHVQQlELQCUWoSiARtziTRqYlVz4c/YIja1SVa8/pjkPnGQve4L11VkXCZf?=
 =?us-ascii?Q?AkK7KeXKkqZBD0zMGOG7Hp8pfI4JQv3n/eqGg8AWCOjR5f3FpLIZu/NdGliL?=
 =?us-ascii?Q?x5WuQJ5+IWSOLAz+d20xmNOU7lGfWpMVjydz/GPOAClptxuxPXt0FlKysvkx?=
 =?us-ascii?Q?1Jl7E5t1wHvSGOBMzeoRvjrHubgRzRYLUNc00yig3/+MX0IR0nJX8sU/Tl5j?=
 =?us-ascii?Q?vEsezLGay48YphpPH5/ruFYp8xVNEeXFvxQI3Pr02YGMJOo2om8DxvNsax0b?=
 =?us-ascii?Q?nDWYedJkXXPKgd6Q6fSkWk1lRTqbMC5WU8dq6q6Ui17+D0f1Ha2kwHf4mOQq?=
 =?us-ascii?Q?/HB1Yz4ZRPzZt4ogjkdsNn4nv927yyu7JQIskX37F/Npe4XZJEcJj8SsLL4S?=
 =?us-ascii?Q?O427AXLhtWNKPlYJPKUZlVyzri8aAuxxm/ESiydhGKko4PMpCZ9RtbhhZz1t?=
 =?us-ascii?Q?vOiML157a7DsQQa7kAM4cIVFy5JtgwvLrsmzbiywlZthpxelpCuLaMrBivcu?=
 =?us-ascii?Q?aGLX3CMwYH9iT/b7/Z9CwTphZq9nRdB3t1+kPBYR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aea037b-2403-4656-e5ee-08dbef711f22
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 17:48:53.7279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cAYMSQgAv0IsysJ+nKFI5jli9ZFobUdc0znwL1QnnP4F+1Mrpee2Oo47fxrB2aq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9268

On Mon, Nov 27, 2023 at 04:10:33PM +0000, Shameerali Kolothum Thodi wrote:
> 
> I had a go with the above branch on our HiSilicon D06 board(SMMUv3).
> 
> Basically covered the following functionality test runs:
> -Host kernel: boot with DOMAIN_DMA.
> -Host kernel: boot with DOMAIN_IDENTITY.
> -Host kernel: ACC dev SVA test run with uadk/uadk_tool benchmark.
> 
> And with Qemu branch: https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_cdev_v7
> 
> -Guest boot with a n/w VF dev assigned, legacy VFIO mode.
> -Guest boot with a n/w VF dev assigned, IOMMUFD mode.
> -Device Hot plug(add/del) on both VFIO and IOMMUFD modes.
> 
> All the tests seems to be fine so far.
> 
> FWIW:
> Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Great, thanks!

Jason
