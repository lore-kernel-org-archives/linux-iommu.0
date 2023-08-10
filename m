Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7B11E1A2
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 14:56:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpEjoBNuXlhdI8tg5tp+msXqwLJlHj2kjh/P3GKfDA1AwKbOqnAuUMHwcBQC8GWTHVSlHqi8w/h3qrrWU3jIaVQegJSp821Pl18Nphspxo41VdpyIv7NXrlSBgXDszs9g4eoI3SiSxNRcfVLrjx6q4UAlKcET5a3Os43uPNOC4aXSp7/QexiNY/hz0RLsp46Qvo+j6bSlYxA5XUAivyWrCkQC1yCsrNFSEKej72HOc1XIa8OynQl0qUrtUu90J92aAXMSfRPy29duLe/b0FTR1vkYAQsd/aL8U4BjJ7OYvwS5wD8skVnxwe/CIoyg3YHULKeK1G6Lwfv1a4gnag11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22BjX5xyE+9wOwujgjTrCsMMOr6eGwh8A4I9lgwo2WQ=;
 b=iVO+k3ElBBQ3s4e+hU8cxn7uH72UNImVbW6MJmacS3HD7tL4j9imLu6SDUJQ/ahrq8aUil1mhG9QSFOUsDiIGaCbW5+nlF5UdekV2Q3/FWP95RppENfXwYfW2xdy6Ndw4ZLM2OPmm84JMHjYaQqRLYyvuft8FRTzn+sOCsDS5sY0nKIlUuZmBWBp/Ruw6XoTCWEgMxQqZsoHg87N89SSuLtA4GGnacxEH2AkWQUXl5xeFCtmrfnVytDEFSfYOHSjudhxQjw1nfL2Zly8en+/uf9FDJwYCQ8rodLU9me1O2fWi92gnDK3egsLn+OMx6OW8kRIhYD7WtBKO+SxzEXEoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22BjX5xyE+9wOwujgjTrCsMMOr6eGwh8A4I9lgwo2WQ=;
 b=mZ6UulFQ3uvZIPT/VMUaidZ/HlOHPJe0amW18lrugalv4vWslL03zcVqcFW8YF8q7rxFuUAMuiRDKoeETpQtDSnbNJIac7TdWPUht2BrtmHguvhgPafSsHCGOFc+cGKOIKUqcJ/qAhLkix6LvSGkkLfoq10VfBybMDw/eHyGUI/Xd2kX6+MY5aa6mTSdO3Lu+mE8dMJJCQBSD7kFEVby0p0l/cL5jiJ4vdsAMr65973ZJzProlMzcfcUUY8arysvxh/mESs7QzHKxABQjL5tEqEXsNEy8OrnNHMJdF733yNDclN2NJp8SyXyBZs/bTlFPkcSg+J+220dj40aa377aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB8370.namprd12.prod.outlook.com (2603:10b6:8:eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 14:56:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 14:56:03 +0000
Date: Thu, 10 Aug 2023 11:56:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v5 6/9] iommu/arm-smmu-v3: Move CD table to
 arm_smmu_master
Message-ID: <ZNT6gFHtURU8HnJe@nvidia.com>
References: <20230808171446.2187795-1-mshavit@google.com>
 <20230809011204.v5.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
 <20230809135024.GD4226@willie-the-truck>
 <CAKHBV27uY3TK3bWX8q1VHPo-ejeNmY53RAVNH_VqyYwZASKsNg@mail.gmail.com>
 <20230810143448.GB5795@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230810143448.GB5795@willie-the-truck>
X-ClientProxiedBy: SJ0PR03CA0131.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a938c5-21dd-4239-fe5a-08db99b1eadc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VMt1yE+53WQpmg/v7EtUV71y35WES3bGdk00we+RFK2Kbt8ai/ayCGf8q7dd2/EKv2skPlisckpiRP2zXBqtAto0gU+jhUiAy8MQGUIM+/JWNX+0zpSTmvY8iPg28FmOqOLkRYOgS6F6znPRV52wHgn4HrKk6i2ElkGXxfAnceUPO26jf9Md1ip3ZR8m1qqTnyuMNcW1Q8wMXmP4PuVArGbz8v6/lLsHBPb9sz+jLzlhXdrDH506+kF4TKbRgt4j+yKSfY+g4/vXSvqbE030j396UzLFvFaRw7R32/tplPITxIZx8VGNVSMPLMU5rSZvTq2RSNFMkTwSmyAMETMnrw7OoUNVVLpGPcxstytRHLp+PNQcDDuGHamRazYP+o4I6jeIbk6csAdPoOvLa1af2XW5VIPxRzojFfRJf9JKo9ekQxHFH64+Ixe/cnmX3ATTf2S/DT2B8RLm9cLC3stLIhUM0HDtymH2qX5VuFVgpndMAHnWzyVzWzKmybN9N7zly7Wsya91mCrDHFbYX8xmrdm0c7Xh7YevrxvgFWmSBwHxEfBSAeEQxorRb3iVmSHlsbf1nIOf/eEhth8TjhZ4/4lD3jFUp5GTF0wA9/VvIPkldWOg7520/QHMgHcVsZmDCR6w319KjbvAO+7CsbFcrA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199021)(186006)(1800799006)(2616005)(316002)(86362001)(478600001)(53546011)(6506007)(26005)(36756003)(5660300002)(6486002)(8676002)(8936002)(41300700001)(6512007)(2906002)(66556008)(66476007)(6916009)(66946007)(4326008)(38100700002)(414714003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWxTejltOXBmMUg2dURjVDdnMElnd3pISHgvM2JCTEIrdDdYbGdpZzdJdXB6?=
 =?utf-8?B?eXM3VHZheFBXMzBNd25SeklkbFdISlRlUHZHZWZkc2hnRzdHRUxVUWxDNEZh?=
 =?utf-8?B?eGlnSERpNlNzaDdua2JtUVVWUlc3UGFTbDAzMng3MEtucmowa1lCY2VnYjR3?=
 =?utf-8?B?SkdLWGlDMHJFdi9QeUdkOXVBbC8zRjQ1TGJsdnlWMGNWTWRLVDF5NTROMVht?=
 =?utf-8?B?eE9QQUgxdjNXVERNN3pvaU5jelAzMVZ5YTFTQ0VWUnduQktXd3dUZlAvZW1J?=
 =?utf-8?B?RXJYUkZhU3o5dS95MmxaYUFyMndVMEFIcVdhZjIydlRhbDRzbGVkbkxHY2ZT?=
 =?utf-8?B?MEpia2JhTjhVQXd1b2VRWFhNaDdQS2VyakNsQjdlNm5icHkzSDFLNUczSmNP?=
 =?utf-8?B?TDZtNFZPL1FZWkNxL0Zabk5uUlNXNUVoNy9JOXJqQ01mVTlYUVN5Q29jZkUv?=
 =?utf-8?B?TFh5d05wUFlwbHZPcXlKcVcrZ1RENW8wWnJZRHg4eW9GZzdnS1ZqVDU4a0JN?=
 =?utf-8?B?SGNmOEU3M0t6WDZHSGhvSm1mL0lBWm4vTXovWHlrdmJCbUd6RXFkcVg2b1By?=
 =?utf-8?B?UTUvUXhZbW9KT0dMS3Rpa1dGYlJ3V1habVJqTlZGRDE1RVpTWmZYWXNaVytK?=
 =?utf-8?B?bFVoWmM0WFRnS3F5eGdRdkdIRFpCN2drV0hsclJTQ2d3TlhVWWtONFdPSmF0?=
 =?utf-8?B?YTc4UU1SalVZdHhxeWZFNmNla05IZ0Y2bVU1WS9UUUxDT0lhMXZUTmR3RU1z?=
 =?utf-8?B?K2psWmkwVXpEcklRMHpGeXBwaEx1Y29Vb0x2aFBrK3E3V1Jab0RxL09IT3dO?=
 =?utf-8?B?aXlVZklydFBVUEVNN3R1ZWVEdTBNazE3VDRmUDFpRk9Cc0Z1aVkxREhwY2Q3?=
 =?utf-8?B?S3FIcWdPYzRmN2IzUU05bVJFTDhCL2l1MDNTeWxCZWhoS0dUWUp2RXFXQWVj?=
 =?utf-8?B?MXNqV3A2eCtJUkZDUWZ1RnpEWGZqVkdqL3BUK2g5U2gvSDJOWEtHMFBtU1RV?=
 =?utf-8?B?d1hRYVl5OTZyOCsvd0VtSi9GK0gvdnAvNmJyQ1hNK2xpd3lnQURudVF0bnJl?=
 =?utf-8?B?SXRHdU1yTUFtSWc0Y1NRS21adjd4VTNTWW9NMGZYeURGZGtvd0dya0dpTHVr?=
 =?utf-8?B?SHNxWmJzNW9rRHpkWDZEeHNLa0RGOTZqUVpKZGNXbWx2ZDZYdGR2NHdSTnVy?=
 =?utf-8?B?MHJSKzJDVDNINXJieEw0Q1FrSVc5RFp1TjY1a3VCTTUrMHJOcVZ4elVKLzYy?=
 =?utf-8?B?Z2RLRGtnWmNvVzd5RU84Q2R2Rm45V2dzMnhPaXpVaVdzU2JyR1MxajZtbW04?=
 =?utf-8?B?K1hobmZSOWRLU3QxYWNsVE40bFdHdnZYcE9NWkphVmxid3EwMjkzVVBndmM0?=
 =?utf-8?B?VC8rSk02bzJjTjV3NERLNmxYQXB1d3hycVNuNGFPV2tPejI1ajU5NC9pM1Qz?=
 =?utf-8?B?VlZtQ1RwRGVTNlpWclJ2WTVsRlpVS29YY3R0emp0bGhVbnN3bkpEeDVYNW9M?=
 =?utf-8?B?RzByVlVhUThrUlh3bEI3VUNTaE9OV3BSV2VjNGRnb3JYZC8ySFJEZmpaNENi?=
 =?utf-8?B?NkNZZ3pKZ3VjN2ExMUZUSUtabjlSRWZMcEtjUEFCTzJvSmZWZnhKcDVzT2E5?=
 =?utf-8?B?ajByeEdLYXl0MkU4blpIU3hRL0ZTWGlsQnlLVDJDQ2VQZ0x5K0NxekZ4czJT?=
 =?utf-8?B?T2I1NkZHOGJwdmEzRVBMTlpRVHRqV2ZhUmtMSGZZTTdLb3VxZVVqcCtlM1NR?=
 =?utf-8?B?ZFdIY3pxaFUwQlJreWU5ZVBVeEFVc3ptOFFERDZIQ0UreHhYbU9BYzBRdzk2?=
 =?utf-8?B?UkVYVlI0VXREMnMvN2p0MlFoc3QrN1Z1dXJsdUlBVUsxNWdMalZKY0Q3ZGtN?=
 =?utf-8?B?NGZQbVJiTGhtZnF5N3UvaGtvVGV0MkpndU16alRaYllFam0xZjBOWUl6WjEw?=
 =?utf-8?B?NEZQLzRIc1RrUERrbzExb1piQ25USVNIakM1RVdld2lmTThlck5Zblh2Y1d1?=
 =?utf-8?B?YXdUQ2h0NE00dnlEWVpUTkFtUUZCV0dyZ3F0bHBYZklLcGZ6UTFsUVFxVUlk?=
 =?utf-8?B?S0RmSDlKQjdzOHRKMDI4MEovZjBvaytidnl6REFIVFVuOXd1cUhMazUyeExl?=
 =?utf-8?Q?k3+tP7gv20hZOIkUH66FoNpmo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a938c5-21dd-4239-fe5a-08db99b1eadc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 14:56:03.3216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VNUsp1BV3B6Nw/EUIyrItEP0KsTZw8nLznMoXcn2Gwfh+l/IsusoLV+c9qZgxMU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8370

On Thu, Aug 10, 2023 at 03:34:49PM +0100, Will Deacon wrote:
> On Thu, Aug 10, 2023 at 05:45:03PM +0800, Michael Shavit wrote:
> > On Wed, Aug 9, 2023 at 9:50 PM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Wed, Aug 09, 2023 at 01:12:02AM +0800, Michael Shavit wrote:
> > > > @@ -2203,7 +2186,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
> > > >               ias = min_t(unsigned long, ias, VA_BITS);
> > > >               oas = smmu->ias;
> > > >               fmt = ARM_64_LPAE_S1;
> > > > -             finalise_stage_fn = arm_smmu_domain_finalise_s1;
> > > > +             finalise_stage_fn = arm_smmu_domain_finalise_cd;
> > >
> > > Why is this a better name? Now we have inconsistency with
> > > arm_smmu_domain_finalise_s2().
> > 
> > There was a time where s1cfg represented the entire STE and carried
> > the entire cd table. We've gotten rid of s1cfg, and now only store
> > arm_smmu_ctx_desc in the arm_smmu_domain for stage 1 domains.
> > arm_smmu_domain_finalise_cd is IMO more clear, especially given the
> > historical baggage around `s1`.
> 
> Ok, but it's the inconsistency I object to. I don't think it's clear at
> all to have arm_smmu_domain_finalise_cd() and arm_smmu_domain_finalise_s2().
> 
> The easiest thing is to leave it as-is.

Well the names have become wonky.

arm_smmu_domain_finalise_cd() is filling in the struct
arm_smmu_ctx_desc which is mostly the precomputed value for the CD
table entry, which is mostly redundant copies of the values of the
underlying pgtbl_cfg :\

But I agree keeping it named s1 is more consistent with the naming I
think we should use - domains are called S1 or S2 domains depending on
their IOPTE format. 

But arm_smmu_domain_assign_asid/vmid is a generally clearer name for
both :\

Jason
