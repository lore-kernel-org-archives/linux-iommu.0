Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB463B796
	for <iommu@lists.linux.dev>; Tue,  9 Jan 2024 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dRTs2gtM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdhiH5NtWgOZjajDUoWRbBme5BovSPWRvGUgvk2LgMVz9BKcENF2CYz4RiWV/859HBEO9IsVPf53I5AoSvVOmHBfR3JdiNbtnKWksUxUBkyC5jyZXCA+oXUP14Knk+a11mMlWc7/rJEf/xsVCGbHagwFBofhr2/1QU9c/vT2KuSw90mPPim8o5O32RaWEKlZuifU7fKH2Xc30+upHtHBaMIXtUA56/K6hE6Oyf0vIVebvC4+4erEqtYnqv/WItPQ35LIgfujHwOzMNJRua+acuwCAKw1Nio1aKyZfdNFDqMRxeFAsuQl/Gz0rOBiJIhm/aZI+GoC/ObIs4mqfKzuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QUAaTxIDLj+fmRaFgGUsBFx44pZhXo35WvlGF2pZSw=;
 b=QixxqR4JWB10qGwoB7G14ZFpV1N7mLq4RoYjxdAaYVxeHuD8xHJ74PreRRTAo0+zFli+g5VS5jDWpZB1zt9aF2T8rxO0bbtg66Gv5ZhQKF6P42eOV87hMciIx4eOF9sCNXwAF4ag+q9MnVCsZMtFrQcgJGZ2VSTn/mTo1Q7EmF8hgAY+S0EOT5YaDw9vJ4xqM+hXe4/60YivG3Lk+tNsw7cMQZMCC5HNRvn7W31zHB0dwpsTNF97pSShISFegV2AJ/7SmRfglbMhf/bmCpTxBFPk90jb0Km3eIC2NLr2QdCslqx1qvyJmdHSCbkPNMAVJSTsdGbHSy0izHJCX6fQcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QUAaTxIDLj+fmRaFgGUsBFx44pZhXo35WvlGF2pZSw=;
 b=dRTs2gtMW1bKZ/hb+tBIcmff0TiYPYeWMtlPntEiEsk0ilVYTCaNSRrZ3srWNJXEUFwFYOazxu+w6Vl1s3ghvRokbxMXJwdrgs7HGbACSlERp+hloFn3cY1NsJerWnxXbcbui40fwe7mucAAXDdABzRZ8MNZiXjEYT/rohFdU++UnBeck39Y/qCCja4NxHmo66mPnWFAHbFU4F1ubTknh1AhjhsxEWab9+iEZZwj+/q9agjwNSZ+T5O98T/h5iu/kFsUwbpdjLlbPn2jjiFNGXdkHEAt30FxyIKWbdMESgDc7V7IJtuKBwdSfnAh1CxAt9DrKV9z9ETSvHVYVOMdOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7259.namprd12.prod.outlook.com (2603:10b6:510:207::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 17:50:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 17:50:50 +0000
Date: Tue, 9 Jan 2024 13:50:49 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v4 13/14] iommu: Add ops->domain_alloc_sva()
Message-ID: <20240109175049.GA502542@nvidia.com>
References: <20231221111558.64652-1-vasant.hegde@amd.com>
 <20231221111558.64652-14-vasant.hegde@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221111558.64652-14-vasant.hegde@amd.com>
X-ClientProxiedBy: BL1P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 335a3bb6-4784-4a98-a7a4-08dc113b846d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dfJ4ymakFHgXMs/DoYn2r+++FYYD38QZGZtdq/YxlHonDNOfbK8A/8UJaPc/TFvnJS/J82kTw0TpMgWngG+RK+i+gYSaUlf8aVG4SOZqA+iHXytMteV1MSl+laFu2tAu3M+jyWfkWRU1hDkTMEvf3Tz5GLj5+1WAWufl/uY4C5KA0K2CgYYr59aannIMChTuloYPgnxrFsQ92SK3dgEQt/ZaGeqw8swRjK87A46FfS22bwk6zHTqdfXH32U5uCcCA7J7vw8PUmOUhDb7xe3/uYE6vg1oXEj98I7wiV78IWe4VmJKN1EXc/0iyje2MhLJvq3hrIdgfZHgyXPGvrJn/AxtrfvjTMqnDWVDPnicJm3CrmWhWvNg8NDr+1NYKVLVTCYwmSTtXWxf1a8/ASitXtOf4eTCm/rVobEIc8ut3tP/waycGm4ujAk7X0GWg/Ml5+9814fPgG7zMGxVEUJMCm3vxv2JNvcKdrGmvostDKatrYHHKBSMJdgFmRbffwb2xRqlyOENG621/5SHfrm9GvCmnlLKqhfkHKo2uZakMoACiu93JeBhl43L5A4zrI/BO9t32KnK5NmyIVZ80nzBaMR2NULyxADdFsT3Y+d4CDGH9/VNXD7tdkYW5U8De2Nw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(346002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(41300700001)(36756003)(33656002)(86362001)(38100700002)(2906002)(26005)(1076003)(2616005)(6512007)(6506007)(478600001)(6916009)(66556008)(316002)(66946007)(6486002)(66476007)(4744005)(8936002)(5660300002)(4326008)(8676002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xVQWguWb1vw1YRv/WTEt31bFDfE3SFdMXrttaelXUwGv+7iw2Ry4YDahq6ar?=
 =?us-ascii?Q?jBHtFPb8sQmiwoDOHi0HSAYvYEjmxgDvzrnR375Mil4DI3g4Agiiod4NWghT?=
 =?us-ascii?Q?Xaraj9MUJ22V+Us8h1YxrlWroxwhI1UuwI4mtY+rw95i7a6cJJCrs2oYPcxq?=
 =?us-ascii?Q?nzlhdYd/dEY5ic4C0UTDNdXuPqzWiRvwC9V82+Ojkv9lzokRxmTUR208F0uK?=
 =?us-ascii?Q?zx3TipYXSHKf8rqFdimPSZ5FfhsT++bizrt88V5o+Oy4wHHTE3/JV2tsD9jL?=
 =?us-ascii?Q?Tn9MvRCyyaIm8T5S6dlWWPrHWdJryoEwKrY/RdDcdP2IgEZMwLcIWq+sm+8Q?=
 =?us-ascii?Q?cMfqniZ5hcXFmE27QsphoKemsURu3S6SGrTeofSY89qXQ3vNzZPXdzYk/BAO?=
 =?us-ascii?Q?molNGD6USxDKsobgvDKBko9QJeC/ZthBNI/9EMmu0d4Av7RnDEpJTUnZ3TB1?=
 =?us-ascii?Q?nN4/wMWqcRU+5VD34G0KWFZ/tO6f0O5vEhGzVGcKy04I+8cy6KKZ/tBIDCDz?=
 =?us-ascii?Q?k+clVNVeNs42DjMTNpqZ6H2f3/6TT0QMVV3mQ7ki9rRvuqGEUjU9LblKHW0Y?=
 =?us-ascii?Q?mgT4sVLLsTCjtgqUM8ryOyF0aHnWsaS3aHj6W2sNIWxKIfNyhqTpSfz9b2MV?=
 =?us-ascii?Q?8H5sV+MDasyQvT35mw1MB8XxG/WREGPcatDNigDIc2RDUIivDfKgVa5/FbRg?=
 =?us-ascii?Q?Z8UKgWYU6f5ojP4kLfY5bEC8WrW5FekthcXNKtpQj1FbtiGlkRVse5Wb1Dsr?=
 =?us-ascii?Q?2WHFK1JOoJpCDs1i56fH4JsZZk734NpoV+l66KDS6vBqjmef6XbH91WLxfAy?=
 =?us-ascii?Q?9v87Ubm8iZgF+zOpaWpjHq5xFI5MPbDcxZGHpVZ+NOfacoVx+m8xQUJ5iHGI?=
 =?us-ascii?Q?CcSbHZ059eivBibyh/AXBnZwv9Wkd/jZoWSvd732jk8tuwO8ZluFoANKdb85?=
 =?us-ascii?Q?q24YD9tXxcfADsafWa1yAYiIjbBcaC1FeEy+IwkRspr5WMfs4mwJMjHi/Bqk?=
 =?us-ascii?Q?YNxFjyLbQn/xDIgOYuJHzWS9w6M8VFQAYlwa/lLUTl6qBRWCU1RKLJnSbOdq?=
 =?us-ascii?Q?iSOTJPfqnwMZ4jRxus5S9Rc0UEpSyw18VJZPPyxBwab1t/03/kEUdOUee3Io?=
 =?us-ascii?Q?EIUJyoz29LPxVHzjOnHytwz31Et8hKwPXGqv34W2OaPE+uSq19J7ZFELVntf?=
 =?us-ascii?Q?48FE9ESB+Q/uJx6/CumAdpPEKlpRv5jiCSU3rqZWmHMGR+Uil4OptqG/5ncN?=
 =?us-ascii?Q?S+UHH4h1hn0CUK+dQZNa95W5+P0aDln6krmgduNOTEGmHcBE7VP661Vlw1kO?=
 =?us-ascii?Q?Sb/0efgMf6INePszh1I8aK1oSAsvWe96cSMvY2sWJenxdF9SqUfiB/0ZMxH7?=
 =?us-ascii?Q?UT726+469obPliwepPY6eA5NMkA9e+9ciftdJ9zM9Jr1wbKBF4QTKlkINn6W?=
 =?us-ascii?Q?/P98ErAjx0WkYwtzMdAsWtg+sPu7q8A6Ln8dYHpw7GLAp3VtwxyzQectsNOK?=
 =?us-ascii?Q?MJYxrZZF/N6qWHxTjlJr8aebr1UWRiGtdixrlcCBiiiXAsI6m4aiSS/5yeVE?=
 =?us-ascii?Q?GhrjjTEbWgl3D8fp4HKwDi0EPaH0gLQAMjm4bQ56?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335a3bb6-4784-4a98-a7a4-08dc113b846d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 17:50:50.3708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xolKNFu8H78Kq/DA1AKpVI7xzTs85XVppv2LIqDuzeshplgQbQ9UBqymHMT3f697
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7259

On Thu, Dec 21, 2023 at 11:15:57AM +0000, Vasant Hegde wrote:
> @@ -270,11 +270,18 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>  	const struct iommu_ops *ops = dev_iommu_ops(dev);
>  	struct iommu_domain *domain;
>  
> -	domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
> -	if (!domain)
> -		return NULL;
> +	if (ops->domain_alloc_sva) {
> +		domain = ops->domain_alloc_sva(dev, mm);
> +		if (IS_ERR(domain))
> +			return domain;
> +	} else {
> +		domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
> +		if (!domain)
> +			return ERR_PTR(-ENOMEM);
> +	}
>  
>  	domain->type = IOMMU_DOMAIN_SVA;
> +	domain->owner = ops;
>  	mmgrab(mm);
>  	domain->mm = mm;
>  	domain->iopf_handler = iommu_sva_iopf_handler;

This hunk is in commit 7be423336ecc ("iommu: Set owner token to SVA
domain") which is already merged to Joerg's tree. Make sure to drop it
from this patch when you rebase

Thanks,
Jason
