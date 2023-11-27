Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD2E1C292
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sShpQ+Jq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ST/LL7X7AAO9qV6gInhyLZVUR9LL9c6ro9/pbFY195HgFNz8B1LGcCGcTMqoA3DzsJxkRrfh8YuTjfSARbyNdJ/Cn05LXkHvdv/cFPBPwrJsMOSskBAbEIsJoK+f2wj1WJiUe7KgbM1+m1tTUp3ptlt1fqhFr9PUqu7AdstLQPCMcbcy3lsmA9K6/ahSJqsygvJGKwXBWJ/Duna7nv/8tmsJ1jxE2xN2SzOOUvK2BGqUOSBPLAiSs3ScvylKhrRyDjhKoYvGE7xPYkTSMuxmRwA5DhbHj52Z8c0s11t4rHoifpefeguxSO8m68Cs0Zt0WRoaTIwTWdE6MAUq6kDVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiFdXiMUHy6K3dmu/ipO7vW/BoyoE5CyBs/qBkLM+YQ=;
 b=OH9QB6r49hJ8AIgkI/PwQ3Gkh57nnzkUBZny0DY/Ala3OJvW4Kiu9t1FTUGYciQvZoHwH27D9Q6FCRmqq6ydx4WLuh1WedwrYH5ZD5c2WQZlVghjskGz3Uj6RCk+XwBeINvgB2rsaXNLemx8XshuCO25hJPYpUesQMP3966rJXeK2oDOuul25LAstJBoyxqGAaKDS/A6Zr+WW4eqxxi/J4+Wr+MvOcbiDB4H7fU9do+DYpoi9H1t5vqLpSHfvXDgZp09NfWTLjxnJEEasI/dTxoJ0AYLeYD8O4HzeZrSJoRPFin3aYitzSBtrPdD/h6gXJ8/jSh5T+gnwAPSdglQuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiFdXiMUHy6K3dmu/ipO7vW/BoyoE5CyBs/qBkLM+YQ=;
 b=sShpQ+JqjVmqvoyEeoKvucr/UoRgrOGFujmdwUXm1qRyWaolAJPYGShPq5xIOWbXiOFB7pJYkszR+dOBUV/jn8ZE/PtsKP/dTrQZejIUth9KpcBsZxrq0MeyJc4eXDhcEwdmKhapzeeJQaDfSll56/ybwJbCTjNPWhK96My26tQziUb4sr1cJo/g3u8qTl5PWKfYspCdysZU6XZkSEeYKrc08w9H316qGUCBFdth+CblWGvp2u2pguCEldCbfLrsaScUXuEgfNMDUS69NAIGfTqIkl5H5ybTlMEWyYA0HAvbk0nXItEV6XivQoOyggKhq332HmsXmcFWX5l6yVBO6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Mon, 27 Nov
 2023 17:42:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 17:42:37 +0000
Date: Mon, 27 Nov 2023 13:42:35 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Eric Auger <eauger@redhat.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 01/19] iommu/arm-smmu-v3: Add a type for the STE
Message-ID: <20231127174235.GA1165737@nvidia.com>
References: <1-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <0a2a9fb5-0506-4a46-9c93-3c4001d0b966@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a2a9fb5-0506-4a46-9c93-3c4001d0b966@redhat.com>
X-ClientProxiedBy: BL0PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:207:3c::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a09bc2-e34b-4c56-0d61-08dbef703e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BDuI2p2TMvgAg6g/tZRdLO7NTLtsaQAA35yMOeTisR2At0TbokEkJXY/DOK8+sYQlrZEiTSLfRdJNfeHaFtO/VtK2MeZ17hW1AvAqINusZ+9lLsvfn9137hZp/+GJj1CL2LRslyRfL+mSAlDyOzZ+iu6T0aurBulV+d9RORAyvYVdQ/VPcMha0gABOl2YspV6O83IUu+szGAFtSy8Bng1vDVS7EAIbYjMVakMcodPzuy4z9HNqVjSJGWUH1mFDYntkY3xUQXRtkc4+6eGjTWAF3QYf/SlUpvHHXjCBq/oV2dSQ/PRdOS/HFYqWaV7d2S9h97ugskpXKoVOx669QU9LbM4yZaYM4V5YsUBiajeStcdEugHBU4kWp81tCvHayMg3wdNPVhERVSvzTqj5gM2BnIGAQoHbbhy8R7Ievw3c4tNShBJApPDV2UxxabtPefsrNg8m9jYUajkNl5FnRc5pkJmHxv/AXt05D2vo/jUkhV82dEb7tgWrimDfVjMo7j5l1pC34lOxFVbCPFuoqIGwda49ycqLYI193OWz8GVVIKaQAYW0Bo5GxQsuxe9D+V
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(8936002)(4326008)(8676002)(6512007)(6506007)(66476007)(54906003)(66556008)(66946007)(6916009)(316002)(6486002)(478600001)(2906002)(4744005)(33656002)(38100700002)(36756003)(41300700001)(1076003)(86362001)(26005)(2616005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HCKl+9/NHInlsInmxl2VBs1/Z+m1Z080JrEczO3RYaUwQ0Fbf/KocUAKTNJI?=
 =?us-ascii?Q?uk5RdBVqlxhLAznci/dfS7LIwJCyKfrLREBOxxads2NWKuSGpz6dYdbqoAjK?=
 =?us-ascii?Q?DPNv3ufazdNXcdfCIIpP+JJQhtpYZFr9iGOW/jCWc/llzceBbiv3dFTSvS98?=
 =?us-ascii?Q?4INoovxSQ/i4N2l3h3u8TfMDED1Y+wYpN0V/GNeaTEcDbrguFFXWb6r4e8A6?=
 =?us-ascii?Q?VW0is2+UWyTCoiOpTEMLBQNsxdzwkMWb2HIfRnO90EGfNTnUg+Lb30nMcnFA?=
 =?us-ascii?Q?eU5b7b2UX8v8+kTsDB930P6cKlDNfIFyv05RBImjRJGfBYyDCmPFsaZb5FQn?=
 =?us-ascii?Q?Ru4duHtxkpoc9WtP4Jny7Rsz7Jxj/6UJw4+Jlo0xlprMEwhUJOBJVZpJI8nf?=
 =?us-ascii?Q?M2r68OTN23n/wiQKUu2ppX4/ZFSTEiDAcyQi8GzJzffIHvfj6mYILrHFOKdF?=
 =?us-ascii?Q?wi3v2cj23FGwtzI8fG6c0L74qREHCiLAgvqz2652HZjm/uT5235bVinFuzjH?=
 =?us-ascii?Q?p+xN82ayd0V4piuAwc+KaGE375Wmf7QKA7ou4dw7dqrqdWkGm40wd29MXxHY?=
 =?us-ascii?Q?8YooWRHqM7swj4coH1/AQESM+/QLRc0JyZZyjNk1gBfLjWmM3utXoCt8FOOY?=
 =?us-ascii?Q?e3q9b+QbMCHMAhPPXIer7g8vNSTV1Der4CFEP+7r/XgmrU0VB0O51tH1YST5?=
 =?us-ascii?Q?r5B8PbrKHcaNa6YzTkAEvtfq8DewAkAmAHqnZyAFHSMIo6p1as2DqB0EbQWt?=
 =?us-ascii?Q?EF5FBXC+9p76FTpLv3B4DM9E2GZtyGaK51ieTNC7OuLPvB4xTQVWKAPygR95?=
 =?us-ascii?Q?yBopd1nVy3vUAmwD0ufuPkceSn6kwCrbA7EFKaIoEPGaH5ub5RRIb19kA365?=
 =?us-ascii?Q?m95mZ9lfyNuCZP4NVYNsIlYtf+sBQcY10fSBNTe1M9rkY/RYF29DDzSWp6zA?=
 =?us-ascii?Q?THUER9oBlMbeANid2TbWQQAmnilCCjcVycmu5TjmxeE1l99Acy5cxsinbPvu?=
 =?us-ascii?Q?eUjzPstLcmSWINltaRjs0AnirjlHlSRr7NI6TQ+b0hISLlqcWGqRhLm5VsMW?=
 =?us-ascii?Q?oOh6+0zKlEFxrtS7d18sfV5oWQgBBEhsZw18jfFFjs3+dojleC3qkn1HGHBT?=
 =?us-ascii?Q?8tRO/75oWmca/aogPV4HLaJtrc2If2Jty8PK/6SMMpUXkFwI37DFUbwxDm8N?=
 =?us-ascii?Q?IpPl5Yx45vvnntyGxZQyzYkfdsJJwa2vOobNtt1al6RLwSn1JUJSMzf5nb0/?=
 =?us-ascii?Q?tmwCgFFs/B0O3PQX5rYP8xdO4sJjaCU7K4XXzIc0uHT/lWplNpbbKFm5aee5?=
 =?us-ascii?Q?K4NMcRzzHtyf6Czbj5qvqhMO6hDEQE9/VcMUSqfpXU0sdJvdPUdg52Qo3669?=
 =?us-ascii?Q?YAIsZE0EOQaKECXITe1St3vMdgEn28bhmFV6+YxzdCzveMgeSKaqTmq3ZLjq?=
 =?us-ascii?Q?N32+bjdcKhKygj8x+hCMmKIFnDGnFK3gAVlLkAwx/CN0ogxr/3M2xpmYK/Gg?=
 =?us-ascii?Q?Scb0p3QvnaTUquYJur8nW7oo3XdoHkovdc53L+gOc2esum67tMbd4iggqeWt?=
 =?us-ascii?Q?WVPApbsZtyg9oIqM1Y8sHp25KASskUylMDXHaPQS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a09bc2-e34b-4c56-0d61-08dbef703e87
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 17:42:36.9208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoZ0ikAnVVjhdoQTpdVvD/U+jde4xVgsOhEF0Cl3x9Tmw656IS0GG1MYQWNsRltu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935

On Mon, Nov 27, 2023 at 05:03:36PM +0100, Eric Auger wrote:

> > -static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
> > +static struct arm_smmu_ste *
> > +arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
> >  {
> > -	__le64 *step;
> >  	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
> >  
> >  	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
> > -		struct arm_smmu_strtab_l1_desc *l1_desc;
> >  		int idx;
> >  
> >  		/* Two-level walk */
> >  		idx = (sid >> STRTAB_SPLIT) * STRTAB_L1_DESC_DWORDS;
> > -		l1_desc = &cfg->l1_desc[idx];
> > -		idx = (sid & ((1 << STRTAB_SPLIT) - 1)) * STRTAB_STE_DWORDS;
> > -		step = &l1_desc->l2ptr[idx];
> > +		return &cfg->l1_desc[idx].l2ptr[sid & ((1 << STRTAB_SPLIT) - 1)];
> This looks less readable to me than it was before.

You would like the idx calculation outside?

  		idx1 = (sid >> STRTAB_SPLIT) * STRTAB_L1_DESC_DWORDS;
		idx2 = sid & ((1 << STRTAB_SPLIT) - 1);
		return &cfg->l1_desc[idx].l2ptr[idx2];

?

Thanks,
Jason
