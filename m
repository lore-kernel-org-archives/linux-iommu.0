Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498B441C7C
	for <iommu@lists.linux.dev>; Wed,  7 Feb 2024 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324625; cv=fail; b=kXrbJJjuWKkE0fSiU9T7TuhzjztOOuSu8MLe3tNmxU2hBukLr1y/3Xpg/tUL4+oA9FEt2OiDgNArZ/Dnebwfi8rMTUnq7QEuMiA6PJwTj7qh+qa5uHLSBIufyzSb6nlFnG/iBflp50EkM7nxBVNKZv2vQGXmk/8Ji7g8y8GBp8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324625; c=relaxed/simple;
	bh=lsd9dcal7ZA6oXslNRdND9ziPO52HaRvXiywaPMVUKM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fPNxa35RrzC8IEZO3cudju+JDeTpdiZ6xui/3qXlxHl7/ysumx0+mwic2LH2fC7mkFEL1I0PZXMiQVdxlH3rC1RE+ehUpjoC+qXIa/99p/HtPT7Ds16dQTutnMOsPRfCqM3bjnwP26K5MY0FQRDK8WAXtZ4E6rX76mk64cP/vs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IslOBZ5N; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IslOBZ5N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqVVOosqmLUHD7qPjzUTLQU50/Sy3kxnOAasP228gxECAh8ddDy7aU4B9CX241xyEU8j2lslzuUfYfSN410bAeLD/Ywn09N0maW97Tf+DSC9gql4itYUtCLk1YmEA3amBB+N5euoP5lAleQ7ZvjrAiyKa+YZ2fjnMgJyoUytMJrzi7K4odOmUK/7K+8p27t4kINbGFzicUGQPEqTWLGkrfyttTp9kVsy0gztwx9jVPhgFyQmuP/BP3okiDPeHg7l2HaE2RGQlWdQDKXhB21JyHRB2qc//sSDJfqPtFg9Jm3OdpmlZ7sd1df4X5oHR+LygLzKm1rhCzK8ktFo+t8Sgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsd9dcal7ZA6oXslNRdND9ziPO52HaRvXiywaPMVUKM=;
 b=neBeaErvv+f1cUrlHiq9aa7FwFtRGOG/lY68sZIOC3KfGcjDxkmx59aBlSowCogc6Oyh6rSDP3tjmvFGoRnloyaUeCkSyJ0ODblG7LEZt1z4VWBAwKfsmBL5lAPUfn4cCKypWljsEnj4CNwJSRGBM/o7iBludo0A8arWlKVnG4h/i2URvQSl2kl48E+ZG7PKBornzVIeXq3sLczV64glacMfvccGMdW+d56Rmf7KbGpheGipbsdku7q4J7hlcwLPE6UCpuszyjFWQBhRVGDa4lPda6s89d8gih4tro3Xm7qjkheXBibN3dhLKbc+xJ3a7epWCQ8xY2Z+fmamQ9VcGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsd9dcal7ZA6oXslNRdND9ziPO52HaRvXiywaPMVUKM=;
 b=IslOBZ5Nx05I9F4ttcVkUb5JNRoUFB7IzcVItF/xmIgZFZArGIkqAVARWRHyfWFKoc+bp/sinqm1D/JQl7Coi4wXNdy8FnAydq2yHNgmeTEy4HIA3AFyuM16QvHDsN92YNmFLNa1sBFl3Xai2nMmNdWjmXfHqKQfGAFgOYeeESUCKcJwrovUtIclbKaeHK00zln8oyhNm3eCk9vCLFFZXaBtehVd4XBqdUNuuSBZFAWrnfjrvCGm5L/SeRTaHaBTGgOVl5SiHdMOHn9WCuZCqcM3q+EYxEvcKDPN9l0i4ig77Dv9YFIaZMgLaKOeXzmtDX92x9koTd7MonRKxRKK6A==
Received: from BL0PR12MB4850.namprd12.prod.outlook.com (2603:10b6:208:1c5::20)
 by CH2PR12MB4873.namprd12.prod.outlook.com (2603:10b6:610:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 16:50:19 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by BL0PR12MB4850.namprd12.prod.outlook.com (2603:10b6:208:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 16:50:17 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7270.016; Wed, 7 Feb 2024
 16:50:17 +0000
Message-ID: <cf178f06-a33d-42e3-854f-1a26c9b2c23f@nvidia.com>
Date: Wed, 7 Feb 2024 18:50:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/9] iommufd/iova_bitmap: Switch iova_bitmap::bitmap to
 an u8 array
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
References: <20240202133415.23819-1-joao.m.martins@oracle.com>
 <20240202133415.23819-3-joao.m.martins@oracle.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240202133415.23819-3-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::12) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	DM6PR12MB5549:EE_|BL0PR12MB4850:EE_|CH2PR12MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: 709676f2-291f-4a07-f4d0-08dc27fcdcf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	45UNxiuOlklw+aNovJH6kTmPOPu2UCRZ2sc+X36lnk4vxFMF8wCXI/qD85uJjXAyBbYsZ1Q+ZqgNdG+Ix8ZjRfOz2PEYWIx9H7wsh0cBEdeAK2XTbAd+EYiv9t9YhCYJiAS34cCJG2dCB3OROIYeTaXaG6syINw+DWnPgjm92JcASsaVZ9VPR7Ywn9balY46TVj2YzN0A+0D6Sr7pwUVAT8sRGEv9ghUbJkop79kScgWe/oFZmD+BV/XejWrwXl4i6kn3rMDxNixuRpDhssAsyUOdgDoBjiX+ongM8ltNSNPD7g5vI2KtwmFKfI6ixAPGUt/QOStsziJTm4DYi2HwWjVXtwnhdFNg30/tLbtnuBLR1JRKOHFIoV7nOEr1dv6xKwzDfDE94zADHczl0j+sRjLoPgd25ItDe4wgpjGj6USzyWyHSOyeq4BiNeAe4Mcof3lT4/t7bwQnh5wnSUwpfEfIsVE/XAs+KE7CWUxMRluJLPxi5eC1XSTPlfKUzV83/j0XHx0sXtrdWGwH7CBARXTiE1srTOD5qO/owuU2MLcVBtUBn5Dv06+mdkPJuyw6YMjp1hN1EWQRwKY4VNlgv1zY2Rt+JMAUl5F3YvHtxB9zgXtwKb5V3JEajw96l4Q1L0G9EmsOUGnjaopxBdhAQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4850.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230273577357003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(26005)(2906002)(31696002)(5660300002)(86362001)(38100700002)(66556008)(316002)(54906003)(66476007)(4744005)(6506007)(6512007)(2616005)(478600001)(53546011)(8676002)(66899024)(41300700001)(36756003)(8936002)(66946007)(6486002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGFqa0swWHBhSVptQ3JkS29EdXh4TUNrem1oSGJKY0toek92WFJnaDF5TkZw?=
 =?utf-8?B?dmtUU1hmSGlmTW05K2pVNzg2blAweXZnMUhlYUVjSE1PM1VCWWdIdGdLYUx0?=
 =?utf-8?B?dUF5RDlnYmZDTFpSSUNpWkJCTXA5WXNRUGd0Yyt4U0pKZTBzdk02a0tPNTZC?=
 =?utf-8?B?bW8wV3ZXRkxWSGZleDNIWlJHcVBTSHFvbE95YWFJSk5OTTMvZHNjV096MGxs?=
 =?utf-8?B?aGNQZUp0d3Y5bFlCSTFYb2syVHQvd3Z0TEhIelByeG5tT3VOWWxSaE0zT2Zv?=
 =?utf-8?B?dElKUk9TOFFYc1E0ZlM5YVNYdVBQUGNjamx3bHJBTFJGdnBOMFV4QTVvY2pw?=
 =?utf-8?B?cVhLbEh3MG4wVzdqcDloRkhaWXdDcmk0MWtYQW9yQ3ExMHVxcHAydjBLMmo2?=
 =?utf-8?B?VG1ZR3Mra25PMVo5R2x4TWlDOHZrVm0xY1IyU3Rub0JXcCt3SXB6ampRN2JG?=
 =?utf-8?B?bWlaSWtpZDgrbXgrMTNlRUwwakptZk1wVlNSUlRlbjVSQVdCNlorQXFpaUdY?=
 =?utf-8?B?MmpPWnVKZ1I1UjNOamdZYVp2YmY0Z3VRNGJYTm9MVUVHOURVR1FUdUx0Rnlz?=
 =?utf-8?B?TFhvRjNVS3ZDc3JydGtyaEpIOU9kWlk3TXMvd202RXhjUTIrNUNFSXdVWEoz?=
 =?utf-8?B?eXVyOEcxaStNVENiamhtTXlmTkdvT2RoNWhLekdWdldPZWNMTkNFbk42cjhI?=
 =?utf-8?B?OVhuZnU3KzgyOFVRdk5nenpOMDdPTFVVSUJNajZIcDJ1RVIxVmVJeFZZN3ZU?=
 =?utf-8?B?M0hjQUhxTWlGTnpDV0dtcEMzbDF6Q1ZpZEtJVDNLZU85eUg1eml3MDFQbElV?=
 =?utf-8?B?SXNBTVREWS9nZEJmQkYxQmI0Q1BGRWNmdGh1RVlrdjhVYXlVQ2hCakpTcWRY?=
 =?utf-8?B?Uk1CM3RheVZoZHozb240emZGQ0RVdVBkcXpKaDNlRWd3eGw1WmJ4NVc3Tzhj?=
 =?utf-8?B?cHdWUUY3eTJycWtOSW5zeEM2aXJtN3pkZHZRS3ZDQm9oaVhTd1VmajNyY21H?=
 =?utf-8?B?N2NYRzFuQ0kvNXFjbmE4M1NuM2Z6OXNSZThaWGdoVXkwcGdlT01qZ2NFYm9N?=
 =?utf-8?B?QXNxZzhsaGdwNHQwL1lWVE1UcHJNMWN2UzFGeVFKNVUzRzBEUDJwYUVzaW8v?=
 =?utf-8?B?ckZNTGFaWmV1WVJ2d0xrdldHV3FxcTFGdEtKZEFHWWxhbHplM3FoU2pQV0Y4?=
 =?utf-8?B?eURCNi9OaEgwN0V2S2k1cHF2RUUxVFZBN0VybXBGakhCSS8xZHhma2RNSHdZ?=
 =?utf-8?B?ZnlnbDNaWkNCZS9rclZQdUxrRkd5R3Q1NTUwSlpHemZHWUNTZXJPRVJEM054?=
 =?utf-8?B?dnhiRmtTQW05TDlpV2tmR1RTMTA1VHdvVW4zM1BnUTVUbVFsU0ZWQ2I1RlhZ?=
 =?utf-8?B?ME5WSmdmWnNpR3g3QkNFRmlpZk1vRGF1N3laUENQZmo0bGRkS1RoSG56Vm9M?=
 =?utf-8?B?WklzMy8zK3pVRXNkNVhUQzJKL2h6RktHekVHZU5ZRFgxL2FKdHBQWCtDUG53?=
 =?utf-8?B?YnJOdTNZOXg1aXN4UThod0dOZ1U0emgzY2doNFVNMkxBd3hEY0hsQm9hL1Nn?=
 =?utf-8?B?TVRmSU82UWZqbWlWSVBBMnl3NlZ4ZENNNTA2OW4yYjdJTExHUWFrQ01jaCtv?=
 =?utf-8?B?TnA5NlhKUlc0MXExSlFrZHB4dU5JazlhV3hFdmpNU2ZhVGZ2WmN0MURCR2Z4?=
 =?utf-8?B?VUd1UjQwSkwrVlpRZ1VEcENUVkVySkNHYXJxQ1dQOVVpWmhhSXlDeC9oZlJj?=
 =?utf-8?B?eWVOckF1amFzWnc0QWZ0R3hrQi9NNmJDN0xnRkhIZ3VuZHhtSDB6bnVGK2tK?=
 =?utf-8?B?ZUVBdVlVZlBmVjNPZmxGS0hnQVZxQkNhaE1OU2dRSkVCbHU1SC9HZDN0V2xv?=
 =?utf-8?B?dGVCSm9CMnNIblFFYytKYTd2aUo3NFJBNnBIaDBxL1haTDl0dWxic3BDc0tn?=
 =?utf-8?B?YXVRMW5jZXZlckF3eXFKTTFBVTNYeGc2clIzYnRiSU1wUUU1S2NnUmx3TlBx?=
 =?utf-8?B?RFk3OFhRYUdPTmNDZ1FaVkdrSGZjQWFXNUxkb0Z0RWN0dnBLMzJxZmFPVUhT?=
 =?utf-8?B?Zkl6ZFg3SGY1U2dOcUVzcC92T2FGUmoxb21WKzFLR0Q5UUxjN1lRYi9QSmtF?=
 =?utf-8?Q?YxTD5PNUuc3c7bHL1Rk6b098o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709676f2-291f-4a07-f4d0-08dc27fcdcf0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 16:50:17.3851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/fWoE1+qwzHzbtyTgpkmz+O9MKrXsWNjqvbKo9epNY+K7dgZggcI8GKwGQ11dtz5nHtAXWafuZmSfwe5BgsjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4873


On 02/02/2024 15:34, Joao Martins wrote:
> External email: Use caution opening links or attachments
>
>
> iova_bitmap_mapped_length() don't deal correctly with the small bitmaps
> (< 2M bitmaps) that the starting address isn't u64 aligned, leading to
> skipping a tiny part of the IOVA range. This is materialized as not
> marking data dirty that should otherwise have been.
>
> Fix that by using a u8* in the internal state of IOVA bitmap. Most
> of the data structure uses the type of the bitmap to adjust its indexes,
> thus changing the type of the bitmap decreases the granularity of the
> bitmap indexes.
>
> Fixes: b058ea3ab5af ("vfio/iova_bitmap: refactor iova_bitmap_set() to better handle page boundaries")
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>

Tested-by: Avihai Horon <avihaih@nvidia.com>

