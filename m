Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68C5291C
	for <iommu@lists.linux.dev>; Thu, 21 Jul 2022 10:48:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYPSbdofg3mXRX3okiS7S+OL+OMeqJr16kaDFJ5MnrycI+nPiA5loirNV/tD843rbAVirIO56AsVoZ5yAutiLUu63+9JrWvRUTZEbR/TibmLGbka7wwA+Lc2VHzcqYBX59AkQNbxLVDqmVuHSy8ww6Fglajd28uNU/px2dz0+q0zFYvv79v5zZSLakt2fxQYTN2BiUjU24r1mBuGsy/lH436zNMi6oc7F+08TtcmW90xGxP/EgMH83vFb/Kr8tjXo/+yX2Ua+TlgazpHnA3kPVZdo58H9hqUPFgqsromWiCBcaXii0K3Lm5Ad3NSmFtt99B6A68f57oU0IN8loVzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=794N26Y9exdQJFaU83U6HvhViKNlL1ud/vQhoIah7w4=;
 b=PWgS+DdKHOkRA41UKCyXiHwze9FIOtC+SIsBva+MMV80cX94aRhuNMRHKPLCuMnzREqyYU7Ztxegwo3y3CNFzQyiNznYmCGSsDyoUJa78jpA3XJ7GVq4o/ATIMDBNv4kwNz/cJ52VKLtlslGGAA9/CfF+ZKldbJBhEhQRwB4sb6nO1KQBJnKvYvB8eYaRW/v64ltt4QGJ+d5MFvF+IGcM/9T+625mDCDiyQkRf1jArYtvhQ0mB/Ez+h+uObxkcKv+N0BtKnpvqMwLHyrWEP22ynd+lz24pnIhokQSVPX4LeaG2ESjwDxtzDMHgwyAYYDqafr+k2xe9BAkl33CLzvAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=794N26Y9exdQJFaU83U6HvhViKNlL1ud/vQhoIah7w4=;
 b=M0LpKxbmps0g9mRvxE886PKCq9p3aoANvAoyQp7cBasweCJ2AIPq8eG+qldKylSvTaqvhscKSpWZ/K1ispdwtnPw5MKS/52SL1KPj88Jw+hRwptj+1E9JX0HfZCGfgNOGvQxAGhhme3pjYQJ2q5h64WemCIsT005cOSPFfcCg7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM5PR12MB1739.namprd12.prod.outlook.com (2603:10b6:3:111::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.20; Thu, 21 Jul 2022 10:48:20 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::edfb:ba9:c2e3:4347]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::edfb:ba9:c2e3:4347%3]) with mapi id 15.20.5458.018; Thu, 21 Jul 2022
 10:48:19 +0000
Message-ID: <da981c67-5405-b439-55dd-73522aedb5a2@amd.com>
Date: Thu, 21 Jul 2022 16:18:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 0/6] iommu/amd: Add Generic IO Page Table Framework
 Support for v2 Page Table
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com, robin.murphy@arm.com
References: <20220713053034.12061-1-vasant.hegde@amd.com>
 <YtEqEYMugGjoIo9e@8bytes.org>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <YtEqEYMugGjoIo9e@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::21) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a2a957c-f5cd-4d5d-8acd-08da6b06865b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1739:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VsrybEF+ydd6E/VwPwl/3ClXcdtkVB7xTb19DyLkpOYVUA6O7+hPgsUR70Q57lqTlDhCOakIxMWXSVYXgbIDh+ukK4xXIwCesjQbpOTzTiUggAzENWAKulzWCTrYgSXJfYHGNF4Vka/KmvlCtC4uF58tYE9U3PDR2fXqVZ318SoobqKIiEfPovehhSLbun18cVbhllzd4H0ljdc2LVZeqOncXC0kw7ZCZv+lkkOdeHgV5il/6pakbJEkiHLGcKvTEbN6/DciIsJ189Mmbi4KGjqTDCgBDvMAwGx69t4S8KuDB0FcqQgXDEhesBqikFp2k7iLbyFkRHyMMkFLvgmRLNAscngfyddHXoBQnt+JRyZvonrRBRqi+jZ3Zuz1zr1GtDp1mL4wZpKRgw0mXc9sR+7CsrWsEHeVTc+kMt6I83q4uoXx0Ig/kc0bwIl5xWm2uhMPvLsiH1qOLhQcE9ah33omN35Pph+r/mkq/FEopy6LVUfE2oLdnedp3LqbLX5ye+DcWsnS6ZCJWcgyTiDK+XdaNnYa6EVcYkaES3713Y9Vm9EjTHpG6oE/dq815T70W9+72LR4wClvZEkDyPiyJdZpYdu7rHXkUsYPHJRciKim2uNJpY4yNbi4erdK3OzPsfdi/rW4Fi3vqwObq/v56Bsk2n5AUy31AXxK2aIAO7Snu3Mlt6zSoLtd4UNeNAiWRac5AOTf1CmLalmVdLrrk+6yOoYxyLqgoep7T2///2H4h4iwaC0Ef6PAjexVApedM8EtaGVETlOjbJK3MvplDLb7JPB56a6D1kJC3oWDizfW47GwQVnU1MQ6YMSUn5bXHK36FTJaxm4yd1KgSZ56NptDGP4UcVhz2XZ2TJ+WxFE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(186003)(2616005)(6512007)(6666004)(31686004)(41300700001)(26005)(6486002)(478600001)(86362001)(5660300002)(83380400001)(44832011)(38100700002)(31696002)(36756003)(8676002)(66476007)(6506007)(8936002)(4326008)(316002)(2906002)(66556008)(6916009)(53546011)(66946007)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW1mekVhRzlTcDdBY3ZYaWJaaFYzcVQ3RzRTeTU3M00rdzFmVHlXdmNEQVYr?=
 =?utf-8?B?OStLUnk5MVhFcm96dWtGZ1ZjSXJ3cmNKeFJyYWRRNWNtY2JCZWpxVE4rNHpu?=
 =?utf-8?B?RFVKeVVJd29TdlVkM0h2MllXeGowcTdFaW1UTXNzRnIwQjRzdUJnOUhWbVVN?=
 =?utf-8?B?NFR2TWNvQzNIUW1CaVAwamsxWFRob00yQ1YzRFJocDg1WTIxVm1BdHQ0Y2dL?=
 =?utf-8?B?RG9zWnVWYnFsSTAyTVIrRFdWcmpaZ3VyWndqY2JncHIzUmZuemRBSHhwZEFQ?=
 =?utf-8?B?OXhjR2RRMmFTUGtGZHNHc3F6YWVWN3RvNURlUUhVRnkxY1JMcUNndUhic2hZ?=
 =?utf-8?B?MlgxY2xXYXc4L0E3VmRGSm52ZnFXdW9RZElLVWhMaHZNZFNvbWdpMkFkbWNT?=
 =?utf-8?B?NHJpQm81dzNISnNDWHdTeTN1a2krMm9sNFpLeHdQTDlkbE5Kc2dWeURVaGpH?=
 =?utf-8?B?c0kweGEyc3dGck1TOTVTVm1IaHNpWEY4SHpVVk9hVXYzYUIyblI0TExlbXZB?=
 =?utf-8?B?MTFqeVlrYUU2a3ZtdXZMTU9ZcUcyeGdxaWJZL1dQM0phcERCNm1RaFNNTitl?=
 =?utf-8?B?WkpvQXd0ZEl4RkZSMkI5a1BFbXVCN2x4cnNyTWg3TC9FalBFR1JQQnNpelZq?=
 =?utf-8?B?V1dhS3lvRFZySVNxbDdzRTlmbGJYcXNOVkZNalBLclB5NDFWUkxUUkl3N2Ez?=
 =?utf-8?B?a1dXc1dIV2t5MnU4eE12Z3pQSDNTMDZtVG1nK0psT2EzcVFuSStBQ3Z5WXh1?=
 =?utf-8?B?Y2p4VU83RlpEUTZ2TDcvU0ZPeU5ZR09vQVlPT3I0VVoxMkovL0s4bDd0OGVE?=
 =?utf-8?B?SW9LSHNQcnVzTWIzY0p1YTYvWHJWNkdXaFJTNWNQZDFPYkhsU2VSQ25IVUp1?=
 =?utf-8?B?MmxPRmE0dCs4UWhHdWl1MHU4cVBYenZWZU5tUXQyVEUxTVoyQ3FBLzV1clZv?=
 =?utf-8?B?Mk01QThGMmVEUUQ1Qnp6Rm1Ia0szTEYxOVd3cExHRGdMNmt3V0I5RFhlNEI5?=
 =?utf-8?B?RmlNQnRmVW95NTdLRTc2dUw2bXRPWlUyK2ZUZlR1RHpmckE4cVJ4YWtucnVV?=
 =?utf-8?B?L2NGMktCdEZ4cjI5czRZYmttK2FTRWFTK0hhN1pxOUxNK2wvMS9hSkxTUXBw?=
 =?utf-8?B?NEwzQWJQdnhyTDFGQTY0WFVvWDNLYThOdkc3bDJQbUhLMXF6c2tYeXd3Mkt5?=
 =?utf-8?B?RG55aUJ1OXVuVFFoazZvWmdSaDBJd2cvS2Qxb0xYaVFaY3hob2lDZ1RZZlMr?=
 =?utf-8?B?T2ZJRW5pU0NTaHpmbWR0cHVaeThUQUFDRHlzTGNDdnp0NStnam9lb1BSTDRh?=
 =?utf-8?B?dU9nTUdkRmpIUkVVL0JGZml4RTFkSFdRc0UzRERidWRYRFlSOXhlRlpzNk9p?=
 =?utf-8?B?RjFmQmtWZUlBTUo2TVhtd3QyL20xVnU4eVRCeHBTSzdoWlhqYU5hMzZrU2FK?=
 =?utf-8?B?UTZTY0l4TTJCcjlEYnVKWis2aC9HT1lOMFM4MG5CT3Jqa0hnK0Y4dUhqUzdj?=
 =?utf-8?B?NVFDcXRDZS9OeXZxT3Z5aS8wVmlvMVhXUmM0M05QSEVURUIwZ01tYW9wQkpx?=
 =?utf-8?B?STlnNkx1eUhTYTlqY0FFQTRWMmFUV1lvWTNYTEw1RXM1UmdoV29McktvdldG?=
 =?utf-8?B?V3I5Z0tpdkpKYUU5by8wU1VnT0RQTW1IeW5valNidStMMVIwRzVBaXB3cXJ2?=
 =?utf-8?B?empLZktSQnRRdGRsK0dJc0JKSlNtM25DcWc0azIzbDF5U3VLeG94VVFjTWVr?=
 =?utf-8?B?RFNaWHZWanU0cnh4VTJ3TUExVEtKSjJmZWYwYUNhanJuWnV2VXlvL2pjZDVH?=
 =?utf-8?B?UjlnV1hyN3ZFdFdXUGc5Yzd2L0c1UkN5eFhheFYvY3Yzemk4RDRGUmlHWkJh?=
 =?utf-8?B?S1c1TlBGYVJHaDBmOHAwbVpsam8xL2RJZ09UOTdxaXVZRm1uRy9MVEV2S0sw?=
 =?utf-8?B?ZGN0b2Y2dmVoZzA5UzhqNTRRNmNmWWJrdnpCcUhOVXJTNlY0VE1FMnptdjc4?=
 =?utf-8?B?MlkzYTVZczZ4T09Wc2ZtZkppZWZZb1ZrV0dLS0pKWlJhWXEvVjJRYTlRUzdL?=
 =?utf-8?B?WjVmNXNvbmpwK0p3UmVRdXVGQ05nNkZ5Y2tRVkNrMWZ4U2c4Ym0wV0hCQ1Jq?=
 =?utf-8?Q?McGTkQpEctzm0kjKBvvxAlwNL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2a957c-f5cd-4d5d-8acd-08da6b06865b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 10:48:19.8529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMaS9ailNzNu6VXomsd2IGCWgs3/UR3DtndstPwhYW5bNePr6IjYw54yV2CkoEyuigtEF6p/dtPqX1LFJ2MzmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1739

Hi Joerg,


On 7/15/2022 2:19 PM, Joerg Roedel wrote:
> Hi Vassant,
> 
> On Wed, Jul 13, 2022 at 11:00:28AM +0530, Vasant Hegde wrote:
>> Suravee Suthikulpanit (4):
>>   iommu/amd: Refactor amd_iommu_domain_enable_v2 to remove locking
>>   iommu/amd: Update sanity check when enable PRI/ATS for IOMMU v1 table
>>   iommu/amd: Add support for Guest IO protection
>>   iommu/amd: Add support for using AMD IOMMU v2 page table for DMA-API
>>
>> Vasant Hegde (2):
>>   iommu/amd: Initial support for AMD IOMMU v2 page table
>>   iommu/amd: Add command-line option to enable different page table
> 
> Thanks for the submission, but I have to defer it until the next cycle.
> With the PCI multi-domain support and the SNP-enablement there are
> already some intrusive patches queued up for the AMD driver, and I want
> to let the dust settle around those first.
> 
> Please remind me after the next merge window about this series.

Sure. Probably I will do v3 soon with map/unmap_pages interface.

Thanks
-Vasant

> 
> Thanks,
> 
> 	Joerg
