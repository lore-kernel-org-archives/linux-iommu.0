Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ECF26293
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GbPN88We"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbO+QI8agEosTgnXh6jm56S0U8VS6LG1vkYjq3MN9Qx2nIme26gAZBJLMZNPjVBYBMoR0PucEtMURibhq1L1kcRPjiEW/C9x+8lWL2Q3rmqhs1/plBKiolVdQFGCSMkENWFCKCimKTOQ/+hHQsfqmCCkonjRCQ5zf5jB5ZG7V62S81HYOQSRnEy7l6cwUPJDc9o4pTx5UdjZETlxbrf1goLTQkvmBJPD3lbDzNYuBEYLV9teXC58ruPTquNnwPevX3TzH+11Owbzmp4bagMSgO1hv1KZ1qCCbpk9mzKWSaOKQnLHeBR3EiljFMZqsrZpd0tR4zfh8oXR0qtYDVlYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6MOT9zEjrKZo8zDsimBfpmKzVSO024bd+eDgKIFlxs=;
 b=QDZUd0yFXLS32nXsr+Pct62szf2L6vXtS7wOf1AaMlkOsJ5lF+P0BnJX7TEBxAZbGoPZ4qSckZGj012lqpV35lrlUxccLzrbCAkYtPJC7p4Ow7dCnUnBgii1UixFz3zyt36x9hsnNAA7fpWyBNQNah6PHp6wquAcBGeXgjgyi4I9YkOYOQka3RpMGAQ8uh6d8A032Vq37/QWP7OwTOXBu43zTKP/N0m1kfyyumuo2r4XgwsMxH2vuWuxUMbYruEf33iVZ//NhIHNVqPKvgq6hTkFQghBWv7vXq+PGIelcarbiEvl1iC7g2JIHGeLMvcCmhMUaeqVGgyS6nT3ikcrag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6MOT9zEjrKZo8zDsimBfpmKzVSO024bd+eDgKIFlxs=;
 b=GbPN88WeLn0VKb4qgOtcTkCAz3o9oesXPiZobKUnthv77Z/awctQzIpmkp8J6o8GT1ni4e4m0beZOQgGQKLA4UZfhvFnBZiDs9wTrMz/L+laZ9gHW1sKzUICBmYuRdwOkJa3Om/D0tuOMF1gFLoccg46HGzHMlxLfRWiRBIJvuXJPyq43qJ5MGlLkqqGtqbi+wpl6GGka9vQC0j3OR1Zcj82ItF/ejrjHju+wuUUUD9FKeXZiUZMWLnINFfAiUqbgsHABCVkggZl329OaZBwpNkwJ2EbNrcO3T8sxOkchDzQwHmk/gG4y1YxUqGZHqJlMWIIlmNCl0OlWhVjlNwr1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6105.namprd12.prod.outlook.com (2603:10b6:930:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 24 Oct
 2023 11:52:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 24 Oct 2023
 11:52:22 +0000
Date: Tue, 24 Oct 2023 08:52:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 10/27] iommu/arm-smmu-v3: Move the CD generation for SVA
 into a function
Message-ID: <20231024115221.GB911568@nvidia.com>
References: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
 <10-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
 <CAKHBV26n-Fy=GseasjYG_7TNKoDDYBcCx-DPC86yetQe057f6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV26n-Fy=GseasjYG_7TNKoDDYBcCx-DPC86yetQe057f6w@mail.gmail.com>
X-ClientProxiedBy: SN7PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:806:f2::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: d5bffc11-1c80-436b-a4bd-08dbd487aef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zv/PHzKIhOKl9wyjWf1Lr1AJPmvDH5VcBRkki62eYnBzyCD/lwgcex5Ll1Fd9/2pZke8pIRfEu1AvIccSODpu7dAfCJLUzAFVpQD6VMEM94FxgunOo7CzbaodLDVFPKOeZUc71fIOoCJm1NOfTtMW73N22bCfAFN2nEiyZxSvYGekyjWqtKCIkSDmgRUOTQw8MZwE+PyPjicnz9thOm5GwbhZYPQeQ3EK5+COgCYKk3YoM7S2uaryBT3H0nyFusqetze3UUkHMuoMxGe6QOB9aL4gc4X4ruI1sRMtXI9YNHF2ZUo0toxLtECRcq8YJ7tkBayEPTv8KaP+rdTFXyUvjxPADDfAi9Dsrkd04GTbSPedTbD5YUTCS4lfOlXj3R0LExl8Ave1J+/GDlhlZc1VxWMpbyxgH3mqwJ51C3cDY5bPcZm46ZqnqNodS+DodaqSxHdUzIl4T0nDz4SqtvbxWToeBaxd8KAK7NKNticlg3IT5DqRvFdlvjLpG/YFvADKHBeFCliG9I98aKGh/+p+qz1Vs3v2p6/y/+VRlGhz77x/n5xBs3I6+g77wz7s0fq2PMv+yuMJ/74bsL+Mys/LCpNVznlVqInRMcID/7JZEWnBtj8z6MHhcyLEYotH4Ri
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(396003)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(478600001)(1076003)(6512007)(86362001)(6506007)(316002)(6916009)(54906003)(38100700002)(66946007)(66556008)(66476007)(36756003)(33656002)(2616005)(6486002)(107886003)(2906002)(83380400001)(8936002)(8676002)(4326008)(5660300002)(41300700001)(53546011)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVJjOEJ4U1RUeUJaOGUrYkt2ODRBU0dMaWlYYjFJakVONUZORmhSSi8xbHJO?=
 =?utf-8?B?T25tODJqdWE0K3c0MmZrV1VORURicUJaMktlTFExQ3laUWVLZ0Z4QTJXYVNI?=
 =?utf-8?B?YnVGU2txNnVhMGVPVVJBYmtKWS9LRHFVSVEyMnRxU3RtbnZvZmZDNDRmSjFO?=
 =?utf-8?B?bUtzVzYyVlByU21hai95NnZYQ09ha1hzayt6OVZISm5QYkNlYWFiS0phVU9s?=
 =?utf-8?B?RXYxc01mQ0tsT3BEM0UzYXpXeTJxUyt0Mis5dkIzbHB6NW03dE5FYXdTcSt1?=
 =?utf-8?B?aXNadXF1UUNFUDhBUkgrd0lFbGlOWENaeExFWnN3NjFOVW56ako2K1FISGlU?=
 =?utf-8?B?cm1WMU5ZRVBlQS9iOTlxelRreHRBeU5sbDJPTDVaTW0rbFdHcUFKczFRWG93?=
 =?utf-8?B?bGx5VkVySlpwYjJDZnY3d0h0RkxPQnh3dFZpNzlSVHh4NVNrWkRMMUxWQm94?=
 =?utf-8?B?NnI2dmZsYUs1bStmendTWTUxY1greDl0Y0c5VmRETmRvVGIwclhGOTZIeGpH?=
 =?utf-8?B?cGFlaFYrV1oyeUQ2K0xScEFQV1YxVDdPYWlmaVdWZEUxb1ZyeHBoVHBCQnN6?=
 =?utf-8?B?V0ticjNPd1NwcCt5TGg5WFJRc2piQytwL3YyaVIrU0lXQmFjOFpsVmdQVFZP?=
 =?utf-8?B?SFZHRTJoYytQQjNlL0x3QktIM3hpWEkxbWwvTEpJelZKeVdFMVpZNGFRUm1Z?=
 =?utf-8?B?RHRaVXYrMzE1RmlDUUdUeTVuOFVFY3dCcDBlNHVlQVNvZW0wWVZYK09KUk5n?=
 =?utf-8?B?TzlSMG5KTk9SL09GSVBnbzVHcXd2YkZmT3FFS0x1eWFQQVRaWVRucm5kOFVI?=
 =?utf-8?B?TGcwM2lvaHJJbXErYWt3TklwQ1g4aGFvVHR1OGxOTzNSVUhXSFJ3bnJVb0ow?=
 =?utf-8?B?TlN1SHM3VTJGNnhIbVF1VWRsNGt0ZExrWDJGTjBOU0I1dDRsNzNUcG1tL1Qx?=
 =?utf-8?B?WmE3OW1zOHo1d00yYitFUEZiMTg4enByM2oyaHhKVWVsZE51bDlMbUJxSmFm?=
 =?utf-8?B?ZXMvK0ljcXBPeHk0NmlNaTJ2TGpHSXNnQ05jMEp2R2pPeE9TUXQ0d0ZVaHJY?=
 =?utf-8?B?TWVHTlIwR2doc0NEVkRGTDNIeHZyL0o3dU5nNHVXN1BOYUhmTzdwNzMzVGhx?=
 =?utf-8?B?b09TMG5zRUwweXZyU25saWY0L29IbjVobzJWVUdVRVlNMHJHV3lIVit0VDE2?=
 =?utf-8?B?TmFvOXhlNVlEN0paU20raDcyemJzV2M0QS9INUMwUnVYSlpFckFEaURjRzNJ?=
 =?utf-8?B?L0thalhJQjErMVI3c01HeXhHUHYvSEZaNEdpTGVyUkhiMEJBRnNSU3lPOHZU?=
 =?utf-8?B?bnZ1ZWdCL3R2aXdNSktiWEhYZFpURCtDZ2JOc3M4azNCb2lYOVUvSmEyb3FH?=
 =?utf-8?B?dXQwdENxaWsrVnFxT1NrOTVSS2pkZkt3Wmt5VUFHYmdnbWYrTHo1R0tuRGFT?=
 =?utf-8?B?REtGVlFIVWNoN0pGNDNsbHBYVnFucUFzWHdzWUErR3VkVFRaRHF0bTNXRnMv?=
 =?utf-8?B?R2ZFdHZBejZhWWxaYkM2Yk5KV2xkK1BkZ2Mra1BQQWR4Sy9CSXU5ekl6ZWJT?=
 =?utf-8?B?NUVpNG9vVml2ZHV6QmVrT1JqR3ZTNzVFTVMvT292UHBKQ0hldEloZStNbzcw?=
 =?utf-8?B?b0V1c2Uyd1AvQnJpMVE1cmg3czhTUXVVaCtUSmtkTmVTdloxWTZzTFVnMDZT?=
 =?utf-8?B?YW0zVHI5Y0NvLzJFNFpDVHp1QzRyRHRjTnBrUFlna2dKRTA3YjZkRjc0L2Jt?=
 =?utf-8?B?Y1diUUE3STJNYk9FaSt1K0VOWERsVGc0bU9COUVNZjJFbEZpb3JmcmFqaXRT?=
 =?utf-8?B?YlpGY2JRdXFrQzRLN2hrRUhJL0t6RCtweE96VWxGek1CbGtaT2ZwSnBmSXJR?=
 =?utf-8?B?VGZ6SjFiWndHN0FYOHNLeHBLVndHUXhZaVNaQSs3U2Zja0pzeHFvQm1RN1Y2?=
 =?utf-8?B?VWVabnhTckc0bjJmQ2s0WDIyaHFTb1EwcEdLMCtrYS9obzlER1VkOUIwOE82?=
 =?utf-8?B?UjBZbnJYSHA4MTZwcFI5YVVkZEgrLyt1MjB1YnN1UlNvakMzeUJCbW85bmZm?=
 =?utf-8?B?cTRrdjFQVCtTWTRsekNRTDhySG4wdytHaEowQy9vMjMyRDJhWGlPc291Tjdn?=
 =?utf-8?Q?r3MWH7cggLG4LewKvs4vyGYAk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5bffc11-1c80-436b-a4bd-08dbd487aef3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 11:52:22.5386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TF0wMLmPiQMr9XyFXW5M0s28AU6DZJy+5w64GojJkWIAdjHfLv9lRyLmqX+OOm+/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6105

On Tue, Oct 24, 2023 at 12:12:28PM +0800, Michael Shavit wrote:
> On Thu, Oct 12, 2023 at 7:26 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > Pull all the calculations for building the CD table entry for a mmu_struct
> > into arm_smmu_make_sva_cd().
> >
> > Call it in the two places installing the SVA CD table entry.
> >
> > Open code the last caller of arm_smmu_update_ctx_desc_devices() and remove
> > the function.
> >
> > Remove arm_smmu_write_ctx_desc() since all callers are gone.
> >
> > Remove quiet_cd since all users are gone, arm_smmu_make_sva_cd() creates
> > the same value.
> >
> > The behavior of quiet_cd changes slightly, the old implementation edited
> > the CD in place to set CTXDESC_CD_0_TCR_EPD0 assuming it was a SVA CD
> > entry. This version generates a full CD entry with a 0 TTB0 and relies on
> > arm_smmu_write_cd_entry() to install it hitlessly.
> >
> 
> Is this change observable? AFAICT this will behave the same way but
> with an extra CD sync operation to null TTB0 after setting EPD0.

AFAIK it should not be observable, setting EPD0 is the key operation.

If we want to drop the zeroing of unused fields is a decision we can
make globally in the step function..

None of this is a performance path so I've been inclined to keep the
explicit zeroing.

Jason
