Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CD3134BE;
	Mon,  5 Jun 2023 13:47:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFUsLXkfZQ061pDNWVPEtnWXF4T67GfY5JU+tL6LHGGd0NhteDAG0aEzXnRAHh8zePRNw4f/mimDB+W5rGah7/mI0pvvqEYeMV6c/gHMBsLO3JP8BWwWaVborDI1Fm0klZqYfuvGKbY7lKDDNufQncJXWezmsTbPl1RzbuZsLhFyuIZh7ZXqzEjEAJMyBmocYe2XYFqyqsAqU02F/XpjgJi7FBtIxVWGXR0Vqlikn6JegZbc8jnf6idzFgiF35dduerv6dJZCzDIj7LbXwrGaCMVMMcpbVKyYPOnjA9HLX3S4+c2AP/98Og0Uwy7OI6DJQnUVIWBWvgMdhrr3dZJ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxSyp8e7wYT6L91/rQMHv//Ck4GQsW5SdkRGsKDAP6E=;
 b=N7/ClIO108tmGf4T6UOwzEOpQB+kOXitQpJfYD7TUYn2gsqW87j710I9bi7axVU7kWRCZ+1jkGnvzgT0u35BPUZGQJ+ELetgNf6LobnKgtCu95YOcEsBslKfalNtVA3BFqej8/mWuyyDYK42GQe5m0JkWDOvnEc8IQPfQLH9+ACPYKe2loFzSHLDxDPajjOY4pWOdsf5hZu726lAy+A1J6aHvhRixJa4QLYpOV8/C3IfB1X7qBqPFppRwbDGBQ4OkrnKmjJMv9qP7gTsbzwgc5n2j5VZP47L0NfxSC06s1iY/7kiJ1Oda+dYRWlThe/t6Dta9bXB7mlNi0xXfWnc6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxSyp8e7wYT6L91/rQMHv//Ck4GQsW5SdkRGsKDAP6E=;
 b=orvtJ7M8p6Mm6zwdsBazqyNqLmrovykbdD/Xu5RI/GYt1qKnO9ufNFbXmF/FZWwUrz5RITJ6ceSkthdbieL+Gogj0gmCqT5rLZJX32BmFw9EZUI3M5EX8EvLt4RAPmMvyJin+kv03lf5PuQZVwfsAH41VfaeqIvdsRXAU1qsC3L+7+Dqz/Q9xM9vQ1jeX2SsS5D+3s2PGUvsOnXD4lw0KhqILgOgkx/SDQcrcXivK4XctkYgQp5/PSk3a4Hr5lav9dQknrXgIsQpq7Ls0DTrrtF7Qxvft+InBUVgtIubOqZg61SAl22R8g5ch/hyASBcisnmLH+MGzEriAD/DVs6ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 13:47:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.028; Mon, 5 Jun 2023
 13:47:12 +0000
Date: Mon, 5 Jun 2023 10:47:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
	Yong Wu <yong.wu@mediatek.com>, linux-mediatek@lists.infradead.org
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH v5 10/17] iommu: Do iommu_group_create_direct_mappings()
 before attach
Message-ID: <ZH3nXbVFR6JfUKpV@nvidia.com>
References: <0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
 <10-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
 <20230605070959.moupivvi7wr4nibu@rcn-XPS-13-9305>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230605070959.moupivvi7wr4nibu@rcn-XPS-13-9305>
X-ClientProxiedBy: SJ0PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e08b654-43ba-4de4-f86f-08db65cb5d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B5Xp/O0Iwbmth2lbSVkRPcfHxi7GuYGBImk62rLuy11XxFwiLtqVEByHQnHqEzDnbAHTLM2iVJkpCWSCS3rTkVrVqc/iUnze7pTouKDta91swqfwPh+J0YsWpDvdW9yua1mR45LZAfodRnw+wnyVYzq2CfMaaPxxlHbsUQQyUpC/nUDCtXQVblnIR2QdWgjt8WYAtFpiM0kQDi2AyZ9DA6x8nurk5tre15tBcjTN5obV5S0GWos7RaZRD9+4rwKPP9zqClMrvgGIJzezdv8Lm5xMiZy3TZC7S8lXr0r2Ht88SDWsgIvYAsXFgLirAsi61/j7bGg0vgiap0gf+54sarYjSnQi+rYhhKGzkwGbI52SpqbPRTgAf2Z3UQRL6zvAALxb3zZeIx936UD7MU1g4gCcmcOhznBf3ZKCCdYOTca+pootObqJC42afDmgRUIoUN9ULr4QInxRtof1fiaFAu5zXFrAsYf4RL+kfnAJgy9vHZ3gu12an6PeXM9wMxfN4u2M8FsZyQ4rFYw37bpQHim4GI43dZtzN7nSNamEgNrLB+AXk3p9s7dHb2aOTfTS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(6486002)(6666004)(26005)(6512007)(6506007)(83380400001)(66574015)(186003)(36756003)(2616005)(86362001)(38100700002)(7416002)(110136005)(54906003)(5660300002)(316002)(41300700001)(8936002)(8676002)(4326008)(66946007)(66556008)(66476007)(478600001)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDFPU3lnUGYzRWVSdWh5QitOMXRpZURoUFovNkE1QTR0QU84UHJPQXFBTHM3?=
 =?utf-8?B?S2lPMmRORTJaUTFoc2lXaW5TVHpRUGsramdwUkN0Wmd5OHpXbnVPZTEwY09x?=
 =?utf-8?B?VVo2QzJSbk8vUmtXSnRXaVJGMDdWOUR3aFFoZkJ4SjNjNGZHcWF4ZjFPU2JP?=
 =?utf-8?B?Z1NiWHQ2MnJ2NkFVT0dISFRXMXJRMG1JbVFmaERoVFIwSFhDcEdxb0k2YVpE?=
 =?utf-8?B?ditPNmlLM3lFWHplY2lENjc4ZzZxL3R5TmlTMCtLOC9uTmtHdVpFc2VvaVRH?=
 =?utf-8?B?SWt2akFGY0FEZXZqWTNnM3NrdEhIOUFRK2NFUkc3WlFxMjRFbmhNR2w1cU92?=
 =?utf-8?B?NU1oOXN3UUd1cjY5WGhwSHhnNWxFUHYrMlJwZ0hEeFpaUDhnVGVKanhoMzdl?=
 =?utf-8?B?UzVIOFNXTlNKWmM4Y3Ayc3I1MUpnNVYzOGpkNTBzZVRoMzl1S3RaMW9xVlMy?=
 =?utf-8?B?QjNpZVpENklTSlhDN0VZS3I5QkVNTHBzN3QrTUkvQm00N3FwalZLbXVwQytK?=
 =?utf-8?B?eHRSY3hHU0Vla2kydkc1c041U2F4QXFMLzA4RDJnSm4rM1V6U2hWNXZHZmhP?=
 =?utf-8?B?Mk9pRllkcWNINWFtT1RIbTU2NXVMdGwyZlJKaTdUL0ZWT0djRkZlYVdlZzdp?=
 =?utf-8?B?bnZURXhkWDJ2MFlkSk5yTEVML3ViL1ZkL0xIbVREWU53S3hqcVlHNkRPMm5L?=
 =?utf-8?B?OTQyMzBMS3lhdDN4VC9HNC9DdlIzS2JNMnNPazRKbTMreGRwTy81aDR3K0F0?=
 =?utf-8?B?alZ5cGtHMWdLcGdraWQ4RlNVOS90MkI4RnNDU3IreVQ1cDVQdWFkUHFuQlhT?=
 =?utf-8?B?MGZ2L3RSbW0yamJOZVN0MTZ2MXdxL1ppRENQaVV6ZlJBMWFNZi9JMFZOcis5?=
 =?utf-8?B?ZzQvRnRDeUhsbkIrZkwzT0hTWGEzWmNMdmNLRHNBTmVWVFVqeGl3TnJwWmRE?=
 =?utf-8?B?d1pUSGU0T2JTU0N2cnBScjM3UjJaaWtoZXZTaCs2bGFxbjRHOFN4WTVQMUpD?=
 =?utf-8?B?YjUrbFloQVlKRUFiTnJyaVRCVVo3bGVCTnVCMlZQZE5ZVDB1SEZCVlFtQVd4?=
 =?utf-8?B?Zy9xWm5xbGpaSDR2dldQTVFFSDFIZENsbGNPWVVPQ1FkQitYWkFmK1IxZnRw?=
 =?utf-8?B?NTlSZUk0VHVwUlR3WEJ3WVhxTzhiZjFyaThSSDIzcmdzRmpENmQ3TEJzcXl6?=
 =?utf-8?B?M21ZemlaenpOL2FNR21yWkhhR2JTVlFDRUdDbmNzck5xUVdnOTU5MWFiRE1p?=
 =?utf-8?B?V2tJandnMU9MNFhaTVZPdDBLdStYMngyQmJrRmJDdU1ONThUNURqWGFmS29L?=
 =?utf-8?B?TGIrZGdoQVI4dTNWRnhsRE5rVVFOV2g3RXF6QnZ6c2pHaFI0YUZiNHIxMy8z?=
 =?utf-8?B?eWdWclFjZHlic0szQ3ZEeDNjUlg1aXgwbjFtRUVsUVZJemREZkxYVmNjcDlH?=
 =?utf-8?B?bkZicHZ1cUozZTlxQ2RtbUQ4UjNablR4bENySnB3emNZbmcrL1NpY0plZlJv?=
 =?utf-8?B?STlmUEV2N1hXUzZZaHZtT2ZoSU9PcVN6V0NycUNWTlFocWtzRXpycHNQWmdv?=
 =?utf-8?B?VjVtNzUzYkZrc2lIZkJ2cnYxMWpPSXZzR0RqRUxvL3JCdGZMcDArVHQzU2M5?=
 =?utf-8?B?SnR6dDJIODRHTE44RmtsV3JPZURsdUpaUkhDMWc0LzJxQ0VXTTg5ZldLMXdn?=
 =?utf-8?B?RnFUVUlaQ2dYZGc3TGptS3RUdjZtQVl5RGZGMVZyVFRrZ0FEY3p4SmhKSEFU?=
 =?utf-8?B?SVdQam9HVXpGdGt1Q0t3TnYzTENadmFIa1BMNkd5b3k0RVAzNlJDY2lQd2tP?=
 =?utf-8?B?SWJvSGlJdUdGSlV0alhVRnI0QXRFQnJLZFljdm1RT1Z4Y1FRamYwazNoemdJ?=
 =?utf-8?B?cklKTmlRMmxyMHRaMWRGdGJjN2IwQU45WjIySzdSQTFpNlIxSTVWQy9MUXNT?=
 =?utf-8?B?VzJ2V2FSRUJvZUV1UnEzQzJndG1Id0Y0MHhPWWwwa0tqVVJpd1VZa2crYkFK?=
 =?utf-8?B?STc1aVpPZlJTT0ZlZEp0aEpMTHZaaGYrdSs5ejNaLzdIWEN1ZjltVWJHem9E?=
 =?utf-8?B?V1dsdFcxZHZvZEhadHlDU1FUOVJiazh1a0IzbVE5VEVVTTRtL2dDZ1FTTWFD?=
 =?utf-8?Q?UT5o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e08b654-43ba-4de4-f86f-08db65cb5d59
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 13:47:12.3382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ReLtKGvNnyMqs9gUsivt3G6CTL5sOlbsrxTnwnpFqy1/u0LmH3QI6etcoqUUJNyb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7982

On Mon, Jun 05, 2023 at 09:09:59AM +0200, Ricardo Cañuelo wrote:
> [   16.267594] Call trace:
> [   16.267597]  mtk_iommu_flush_iotlb_all+0x18/0x70
> [   16.267603]  iommu_create_device_direct_mappings.part.0+0x13c/0x21c
> [   16.267608]  iommu_setup_default_domain+0x27c/0x430
> [   16.267611]  iommu_probe_device+0x7c/0x144
> [   16.267615]  of_iommu_configure+0x114/0x200
> [   16.267619]  of_dma_configure_id+0x1e0/0x3b4

This is definitely some problem in the mtk driver.. But I can't guess
what is wrong:

static void mtk_iommu_flush_iotlb_all(struct iommu_domain *domain)
{
	struct mtk_iommu_domain *dom = to_mtk_domain(domain);

	if (dom->bank)
		mtk_iommu_tlb_flush_all(dom->bank->parent_data);
}

We know domain != NULL since the caller checked (and de-ref'd)
it.

dom->bank should either be NULL (if pre-finalize) or a devm tracked
pointer.

parent_data is always valid if bank is valid.

So I'm at a loss.. Can you debug a bit more and find out where mtk is
crashing?

Thanks,
Jason
