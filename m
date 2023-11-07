Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6AD2DF91
	for <iommu@lists.linux.dev>; Tue,  7 Nov 2023 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CXgFUNYp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBb2gHyiRt/Buu30ccy8IMEK5vkMNbf8mrCQ7p+u6uaByNSiVV/12+ytQlwaTTJqcBeGSWVnOvibTWkk69SoXb/rB38Aguyka5MP60EDSedRKzq7Kh+AcoUzfebDyh01RkA0Vw+Witg/eiKFkIRfeKMk3e4DSHCKHKO0Y9SwtBIRsJjJarnxAWamujyR9wR3cQ6EmcC45iVcSoA+iNtJnGWvt+7SnilVdxj2n7AJdtQ0D4rHEXCxC7tYYRJmtX52xUXrICfAVG8lx8XpoOP1qhjkswmLjcZeAtxbUiKf3adQMOXw41nUuHxcU0gMKmzxbmpv2fXEEVkCVJRqrk3NgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLHcO+UtWwXiAeIlrz/kwEnpbXxDfkAXopB77EOrUqk=;
 b=PfdGnRBuCsCrHwoIO5+E4e42rRNHqCgi1gI8BfPTIqZD0GCZJBhnk9XOS5bEGiqeefePSpSsnmC3ZL+IiZ6w1a2L+YcTShCqD6FCImrj8SJeTktZT5Gd683evL9MDIhCpCXy8r6uRiYhU0cmdmtq+t7M/u+fYwZ7ntpIFGQ9NmnyzBMJn7oej2vhw8vPUjp+nYpff5/zFWcXEAzxX4sPLv3sO3Jzq2hZMw6iawso2XbLwFKBlyRy0dEiBMGv3pBPVxNgGrskq92Hxuj5vHgmyami3vamsLGOo0hSKM4/lhrbr2Pf7K7Pf4Wt0UCFLUBuJQfIKmDLqM2qj2zVvLXwGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLHcO+UtWwXiAeIlrz/kwEnpbXxDfkAXopB77EOrUqk=;
 b=CXgFUNYpt3ZZb5rDSZCn2wULZsLFjxclkFedCivijTRhfk0yjOyjiu2Qzcd1WPmytHYCJ5Iw+eqJO4xHdKUA0i3QFl1Adh5p3YVlLPkRbq+vMKVim51JEA2SiJ3iKZbd7CE84cQ3gPQrd9/yolt+3z9j1BjaCprk1aVUvoNG6ziU+WmJWOm+RjRo+vMnKAxGwoBVjxgdUNPM7nu3GZaoQqSDvJrUpg2cKZhdV96+ofdt/a4pvSCfRd3bLBRV6R1UeO3NSYjl9SEAKhJ87pWHv5XU4zDyQL0Q1U10mL7noSq+sA38SHLGUtIeDj9Ag5mOhjnUpxn+sNRYYL40fwSNYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Tue, 7 Nov
 2023 13:11:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%5]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 13:11:23 +0000
Date: Tue, 7 Nov 2023 09:11:22 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v1 09/13] iommu/amd: Refactor domain flush global function
Message-ID: <20231107131122.GM4488@nvidia.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-10-vasant.hegde@amd.com>
 <20231105175228.GI223197@nvidia.com>
 <e4f69ac2-579a-ab71-653f-81af3c3bb3fb@amd.com>
 <20231106130139.GF4488@nvidia.com>
 <219f8020-68c5-358d-b101-db1f84468db1@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <219f8020-68c5-358d-b101-db1f84468db1@amd.com>
X-ClientProxiedBy: MN2PR16CA0030.namprd16.prod.outlook.com
 (2603:10b6:208:134::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e8f051-d295-46c8-83b3-08dbdf930abb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wJiISBi1jjCOYLPFsH65wAYUvI0Cledp3L5arAy58a82hndhj2jfqsrqb5VKIP7VaWPRX1GA0nysMo+eACPZ0xlKm4NldJc7DGpBJLv5dhDcBU+d86BfVyfeM7so7Pdxn9Gt/N0kvfF7gVyshpKD0Kn6jhDY40la3tx+2fI+4PBLPk4FHmUb0LOZhV8o2dYT3s4f/hrQ5inuwEzZ9ef/BVbUNnKTCZ9cyg6GNp0dWdQusDaoi14uemeJ6w/RnwKGvNDEzInmTrxm/zyFpvQrkpfEgic1NTOY19+/Tt6BQtxflaFYZFWbWmxFN9rC5i8bbGXdzqtF8YU441r6/MlY02zYZWUv+E0NasLUGQrlV8FhHRtHn/ZlxXeXdlPWyZ++xXa06AqMxNn/F+BECqypo+wXRMQYnhVC2pv+uvX7JWOlr8DBmHsnn99CbGQvPm/tUGytge6YvStVS3HaeuMwUg4I6SqNNRna1uxAHmZ+JiQ+fHqUQ04QFf7TJ/a8zQFvW4skSaqRxXA2rwggq9843YpPxAPkLD+hwr2sRufn9gnxBv+m/wHvfqEf60p+8KCq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(6512007)(2616005)(6486002)(6506007)(478600001)(38100700002)(36756003)(86362001)(33656002)(5660300002)(66556008)(66476007)(66946007)(83380400001)(2906002)(41300700001)(1076003)(26005)(6916009)(316002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OlFRz7I7kXLuvIqTORI+LHhhCdKNLa6/rSC6Am2LxlwrEbMzJENqeq9U2yZC?=
 =?us-ascii?Q?7v91Zd5R8hBWY6UdDWzgP/HTKFW4XISSezmQ1XR/EC52KTxuxdO8Q3gALyoY?=
 =?us-ascii?Q?1w476U6gH2u4488F0pRQ1aXcxlKZNEG7ZRnHB/8Jhp1TG0/23reCkGV5yqhQ?=
 =?us-ascii?Q?dsYzagIDNyTDqo3XNkqjK45SWR+VunxnOIO+VIoFPwc7lyk9HYJ4sr1q9H0A?=
 =?us-ascii?Q?p8iefzvJ2KFIHD8XEMsOr2q31/69pwSFjWkyVD+Qh2MJYiLYRISuC+z1CgUi?=
 =?us-ascii?Q?d6robsJBlTP7knEuH6oVVAovaL63XDl1pns+4V3ck7NBc5urN1wjts+9leh2?=
 =?us-ascii?Q?ZginRJAixC7NpCzlw1XJ6yk7b1sJTluIExfMKNZpEmL7uy+ZdbvOyU14MKGl?=
 =?us-ascii?Q?k7YtClrmVdWFxLNI2qr7h9Bd50pl8WEHj2Kem/m+b1UeNM4P3C1KzFugdtC0?=
 =?us-ascii?Q?M43hl9gADg9agm1Cvw7kVwQzSUNIZaXFcYGhOy2SSD44HLHSgy6a6uL0DpGS?=
 =?us-ascii?Q?WZiCoFajE70jjXqKS08nuS36nKVh5huMtxf2i3T+rQ+5x48t5OA6RLO53U11?=
 =?us-ascii?Q?cdRqs3tzKt9f4xJ2Zdx6CJGRZiPeEMdEVewMN3H7aRvOPMUaDA1R6d7oPB3O?=
 =?us-ascii?Q?D0B0kk1ge6oGXG8eReKo5tU50VVvSpvBF0CESRVgHpypGglu5TdBreOojPAm?=
 =?us-ascii?Q?jKXrcR1tyNlSH5MdjELDpfVzpiDOZUK0plbuhgqEPe7AG4feVwByokXHsb6v?=
 =?us-ascii?Q?kvS39WkjKET673SHOeNEWruqb7UvDV1zEGeVnWo74L+yfK8z5YeF7eRH+4Lj?=
 =?us-ascii?Q?Ktk3EsbNNGpxKI72rN7+nf6nVgCmoSN4cV064cf3a1VZdrs3fDwz8HTIqJ0V?=
 =?us-ascii?Q?ZNvFz4clchTE3gvu1st+W3nt1uqtMPvDqDzYVFukmU6jMdhJtBa9ioo2BEW+?=
 =?us-ascii?Q?xyaLz9Bd1ziEC8AuUrJvzoTsDS+y4+45G/5l2tPwEtMBreVfNmeQCNYV2kDJ?=
 =?us-ascii?Q?3w4fAiuRV9Dd+OVk0r3KUSMQeBmcuMhHl+dXiekRlm6eYLOicoi8UKhFJb3b?=
 =?us-ascii?Q?XKVehb7R4XDU6cNkZGIRi5PDnYAdX0sjW0iZBq2iWBsoyygzJRSL4rX9ex3p?=
 =?us-ascii?Q?PVBVS0NEoji+RdI+OGjd/M4nX50x2RvM7VpEACGg3HP+e89XEhj/uOQH1OhM?=
 =?us-ascii?Q?QxuDdeBnqOlk7I0jp6MwUIkvCZtoEhhPaGiCi8+2vgrRVpuej7GVXEKywToy?=
 =?us-ascii?Q?/hUfZATwMqd4GxUVniiRGAMS5yeujwVS+nckjnjam2uoSvI2ywy9odw0SmND?=
 =?us-ascii?Q?XDiuwTB/ip22rXLZXJTdeb9n6RlW1qFx7aMQ9mXzAdHOSlIOg6qQxcpxv0i3?=
 =?us-ascii?Q?tu6R7rja4+E1vE24nRi+1jx1b641NiOJqEpnKrKLw2mQYib7xi7sKZOsA4i3?=
 =?us-ascii?Q?MiZKtVTi1Naw7LYqDu5G6BUHSa8zCjRfcHCLqnu0kEqd1Bk5z3JJyR0jFQzA?=
 =?us-ascii?Q?Mcd4e3urtkamGnWxHLs0qnRKiaZ9GoP3jUfnghb8wf9jHrHWYKon3kkSgADs?=
 =?us-ascii?Q?zm2Z425IBtaJyYD+WWOMFVIxGIb4XQqemp6gfscj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e8f051-d295-46c8-83b3-08dbdf930abb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 13:11:23.7232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHu6lH9VwlkwQ1gP6FUcQj0ge2WY+vIsyfSNYyo0xQECGPM8xiBAJKnxCDYpFlXt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326

On Tue, Nov 07, 2023 at 10:23:16AM +0530, Vasant Hegde wrote:
> >>>> @@ -1859,7 +1867,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
> >>>>  	device_flush_dte(dev_data);
> >>>>  
> >>>>  	/* Flush IOTLB and wait for the flushes to finish */
> >>>> -	amd_iommu_domain_flush_tlb_pde(domain);
> >>>> +	amd_iommu_domain_flush_all(domain);
> >>>
> >>> This is weird.. The cache tag for a domain shouldn't necessarily be
> >>> flushed from the iotlb when a domain is removed from a dte, should it?
> >>
> >> In this path we need to flush IOMMU cache along with device IOTLB.
> > 
> > The iommu cache only needs to be flushed if the IOPTEs associated with
> > the cache tag change, and that doesn't happen during "detach".
> > 
> > Some of this is confusing because we've largely removed the word
> > 'detach' from the iommu language, we now just have attach, eg replace.
> 
> But we still need detach() function inside our driver so that we can safely
> remove it from current domain and attach it to new domain.

No, you don't. It is like that today, but it is a functional bug that
it works like this. The driver can't meet the core API expectations
with this design. Review the smmuv3 series I sent to undertand this
fully.

Please try to organize things so we are moving toward a direction of
correctness and not gaining more problems.

Jason
