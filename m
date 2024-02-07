Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C0981ACA
	for <iommu@lists.linux.dev>; Wed,  7 Feb 2024 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324557; cv=fail; b=mMzJdY7kRT/G+E7J90Dc7n0wRvdxygg1k4HoMAlEWNrZ3OLK/3dVgwv0xGtwV9RDEEYcQE4HL/ZXNqTMZDQju12lr/sVWwNe/gZqVwOPrhBF3248/sXbXy1qad0QcXjjloFLQ4TL7LIz4jEwKfKwfH840SF6ovSc5eBk737M9hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324557; c=relaxed/simple;
	bh=5lbpwtCBkETC/wU0jHbjn9kzYqtWeZWwK8HmBowcnKM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tHJFuofZEoc5cclNhM43SHkEvlWnJdKA77Lot6mxp7tdEwZOB+Tl7wkaokGmXWAwPh5/4r6Z5Jk+Pr+L6ZRT5kut1k3cOwUeTw2BX1QYyH7cgSgz3auHgJO9rcTZCiqXivFjjbusBPFw5Sxz3WnRDeN/TGjwSUIJAZie3xihJfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ietuyrAS; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ietuyrAS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQGw8c1+E9dr0fvCdqgBJVSJNKoAcugDfAEHOUb+Id8N2g7lemHUOetznvyHWhmViCVEIOO4tWacmm8w/G4xoc99AXnJzy66r6zeOzg7ccNbUkbyKh7/ePEjCS9EGkp1csFUGyoJn7CENRAPD/RcvdwjPOSTGrGtCWAj56U1OUGBNuyENvK3MWTMLmHgKv/Y0lPzFx88sYfiZbmx04ABf80DGCjtdFop6rofHQDxYYfTbA0UkQNkCQrEuJueUsl7U6bIko5Ef5Udm1GuQz7Pw3QdOBBHeW8u7VsdZCyi07z5fmk8CLHmjQyhAF9R1T4zBQpavR0ZTdYD4yayc5vrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lbpwtCBkETC/wU0jHbjn9kzYqtWeZWwK8HmBowcnKM=;
 b=U80c2aXt4faKldrOGbC8vO/dzIa0UBV+cEZc4KZ+Xm2YQ+nBTACtYMsC6vcPyi2FefVQ3of3FdpuJZXDZ8hcayXZEci4XWVTZJ2I77nkamMmUFCsdlAQ4uiuZwhaJfrZWzBpPFXrx7P6rYjc8kVbc42rX4A7spJw3GcWTzKvzC1WDWxfziuFzYYZwzVEdXhh545x9snEkvcZFVFkVym333+8CJOp9juCD8oITA5oCd9GdmWm7b7DL1eGxxy9bzok+yXd9c0nco/KekeWYhAzMErTwT5eicaJAzqpLRXeezUcajFAF0tFGkuh4iYYtp46QXAOq0KWWdMYCufuz0ZVFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lbpwtCBkETC/wU0jHbjn9kzYqtWeZWwK8HmBowcnKM=;
 b=ietuyrASm4hVxNj4dXaujwOxT6njTNbXwt8l2JBSbjgddJB4E1/FRWkody44ukGZ3176vcR25r7F7qZ3zjjf6dkJKZzga3x8sZd+PaXISHUZjEu9hbgTjMxOPWDS5L6YoOkGOUHNzOBBviWUg+g4AzBH5RNYpKNXShGlKVohinTwq1bMm3iESP/gzmMQKFai03XC6OUnvuJVziTEVutOXj7iSQdgKhPOf9FUAqbo4tMS5VTmfRvGFPhxWdmhEovyLW3aokEzAidg9q1VEqtYVhyolCJY78GZKAsmUer2zPPq/K7T0uqBWpfaz+NxbymNEsORtaa85ljyrJ976mPlwQ==
Received: from PH7PR12MB8427.namprd12.prod.outlook.com (2603:10b6:510:242::8)
 by CYYPR12MB8990.namprd12.prod.outlook.com (2603:10b6:930:ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Wed, 7 Feb
 2024 16:49:13 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by PH7PR12MB8427.namprd12.prod.outlook.com (2603:10b6:510:242::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Wed, 7 Feb
 2024 16:49:10 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7270.016; Wed, 7 Feb 2024
 16:49:10 +0000
Message-ID: <e5274871-b514-42f1-9008-0da7027773e5@nvidia.com>
Date: Wed, 7 Feb 2024 18:49:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] iommufd/iova_bitmap: Bounds check mapped::pages
 access
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
References: <20240202133415.23819-1-joao.m.martins@oracle.com>
 <20240202133415.23819-2-joao.m.martins@oracle.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240202133415.23819-2-joao.m.martins@oracle.com>
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
	DM6PR12MB5549:EE_|PH7PR12MB8427:EE_|CYYPR12MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f9f7de-df98-4f16-6a89-08dc27fcb53b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	anUSJbqd/cTZSfgwNgEoz7lIe//ZHBcI5YDl4rvY/xn8rY0eIWFeP+pfOiI2gyMRmjRI1cYcioyaqxvU0AImrJ8S8+foyui0qwIJV7cfZNHvSgBN2xHWJaxKOqWHKFOcPl3elFBkXDpm9blB4FlZyeX03QZqD0MQ5G+plX+JuOgT0leNy4XUzDw4KBZOnJEVL8obvfOx1Wb7eb2tEAvImNb2JT3A7pPZh7l3Jon+Ks1VQwNB+AYM+B1JnO9EpLDjhTIFMQot3NcGUTos8WwmzthhIpzh9PnQ0NKzRpbMB0jCz0zewPJTd1DNXoQWtPjkw1gwXd1VHopkaHflBbBkFAzPdQNylLceG1SSZ4wecYBCi5/8T/qmV+CxQbA+D9685N+nv6uODBsXd12DwdEWQbGTbrcoSXoz2IlEa+b5NmMYCVTXyd2vf8KabRKxXUncVD7QAbYUW2tPZaDtDi/UYtMIheERplNYzC9Iee2/OW23711nc6xEabGSRr8Kpzzwgmn6a/EP5WWf46yTOwHunjkx8pKbaQuiBB4w2XiE0hEgpigQA//6zYm/YeTfYhA6m9yrTk0VfkKrVA5jmatygfQMe8AKclONDVpamrhsatRLG0v8aRE16T2oeGpU6w6BzOE8GawSfFejf01gZeB92w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8427.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(230922051799003)(230273577357003)(1800799012)(64100799003)(186009)(451199024)(31686004)(26005)(36756003)(2616005)(41300700001)(38100700002)(316002)(66556008)(6506007)(6666004)(6512007)(478600001)(83380400001)(66476007)(53546011)(66946007)(6486002)(86362001)(4744005)(31696002)(54906003)(5660300002)(2906002)(8676002)(8936002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0pVTzhkR2pDT20vbmNLYUtIenp5YlJ2d2ZXK1Zzdlc1SVRGcmh3akZhdzY4?=
 =?utf-8?B?Lzc1d1ovUE1rSlhseERuRVc4YnFuc09zUW5USWFseXNKVVJpT3R2R0RTV2VS?=
 =?utf-8?B?L3hQYXdiUm1Nd0tTSE5hMHpZeXNnV1NPQVlESTRNeXFjQlBnQnB6dURzcVVV?=
 =?utf-8?B?SWpyV21lSzhDR25naXlMRHFuZ2lnTGhVV0ZQRHZocjRoemYrN2gyUElqbDBx?=
 =?utf-8?B?UnZheUZ6UlB2SmZDVyttWExHalVIbXdJNlRvTFlrTG92L0hvblA1OVNlVmIw?=
 =?utf-8?B?TjYrMlljVVJpM0ZQZHgwTTFyU3Y4Sk1qZCtyN2RrL29zYm9vaENXZEVNMHhI?=
 =?utf-8?B?aEhwSXlKWWN5QkxYbWttdnRkT0kzL0VhaXZnL1dzSVFLOWMwMzI1dGIxbFJX?=
 =?utf-8?B?T0ZHN0xySngyamFpd2VwYWNqTXI4Qy9zTFNTYUs5OHljOXpXcUxVdmVJdTlS?=
 =?utf-8?B?WEJEdWFHa2FaZDZsUWVsY0pVWVg2V0tsWFh6NU05dnR5dzdwaFNKUnFweXhR?=
 =?utf-8?B?RThKYVpBK0RmM1Z0QkdQQXdPeVZzZENGRWxCeDFUa0VEUWNPQzJEa2hTejBw?=
 =?utf-8?B?TnI5dGk2ZE5HQUwzbTc3bnJrUXpOQTFiNEdNRmZWQ0R3STI2Z2pzdkI1VTVa?=
 =?utf-8?B?Nk9MM2xNamJtTlVJUzUzZUtBU3ZDaHIzZ2RxMFlVOHE0NEZvM3NFWEJCcENl?=
 =?utf-8?B?NkV4VzZFV1AxbFRkeFFqUURXMnJFdnpCZC9NeCs2cVROOVcxN2V5dllTU01q?=
 =?utf-8?B?dU5kRlpwbFdjTWc1ZlBIZDB3Y2hrVnFBN1RHaFltM0R3RFZ3ZU96RGtGRjBM?=
 =?utf-8?B?NThCN0QxZ01yNzBxQkwvMS9Obm5VKzRGZG1hTlJEZFBCQXRicHNVTTZtRW9Y?=
 =?utf-8?B?UGtDbHJhckpiR1ROK0xEMXZvYXpCTzMyRGxWOENla29NcXFzQkF3c1N6ejk4?=
 =?utf-8?B?MzVIR2FGaVI0NlZLWitPUjVmOFZWTGJkWDAvemxnRUtkcVhFdDdPdThES05J?=
 =?utf-8?B?b1JzZHA4bkFjUy9oNjUvRnJib2d0TUVEYm9MenpxdGlTa2ZpUmd4SEVtRHQz?=
 =?utf-8?B?Mk1xdzNORHNQZFB3MktBcVVwYlRSa0grOVVqdURvdFRid28wMjY3OTd5azlE?=
 =?utf-8?B?SWdFVE1oSXhZcldKK1BUSCtvYThmMUF5ZWlweThVdFM4Si8xUXg2Z2FQVTRW?=
 =?utf-8?B?V1I5WkxxS1Z0ZURqdzdTMTUwbjZPVStnQTRvU1BvL3JYUWRJRWhqdW5va2lT?=
 =?utf-8?B?TFhVVW42c25PTnN6L1pueU1BKzk2ZVhFdGxDaEg2eU9mOG5EZzAxb0hDMU96?=
 =?utf-8?B?NFZmSTZhNkpodmpNZmpRUFdZanlVK1AvMy8yRGw3b1RqajVOVGErOFYyaEFP?=
 =?utf-8?B?b3h3K3FJR3dka1ZqczA4elA0KzBhcVZuTTFUN1VoWnNSYmhxdmc1L25JQ0Jm?=
 =?utf-8?B?R2Fsdk8rQ01tekVYRmwreEgzTC94UXhsMHZTWjdTWVgxbDNHSXU1QytkeHo2?=
 =?utf-8?B?aHUwR1d3bmpsRnM3Y2lQVVBuMWxCQm9ydk9lN3puNDNSVFJ5Z1E3L0FiKzJj?=
 =?utf-8?B?d25PcXdmcm1Od1lQVTI3VEtxY3c4b0lIeUgySGhOOGFtcCtwam9WbVc4TDkz?=
 =?utf-8?B?TXN0UVdudFltR200bDJVa0J6bW85aWJ6YnJwcmF4NloybGpKYjEzYSt4Rm5h?=
 =?utf-8?B?ZVpQZWlVaFNtb1Jic1Jyd2RiZUJzbWYzNU44NGJFb2MvZGlwak02Q1ExRlE3?=
 =?utf-8?B?NzAvOGgvbUJYVlhwMU9lcCsvUVVSVTJwN2VSVVFnNUVXdUVwZlJNTGFaMHRm?=
 =?utf-8?B?dWcrdGFTWHhRc1BNRjVsTnc2RmhIZUFXN0V0Sks1T2pBQzFOdTlIVFFqRlRM?=
 =?utf-8?B?Wk02TGxSbnU4VDNlVUIzLysvcFdlbWxSNDVOU3BVenNDd2NMdlVacEZhTDND?=
 =?utf-8?B?WUF3K3hQOVRsQjkrT2g3bVZ5OGd3Zkh0a2UyYlNzK3BsMGg4Z0ZGVlRkWFdM?=
 =?utf-8?B?UnJNUDRZU2thLytPRFRxeXR1Z2hKNCs4emNrK0NRQnZJNTA5YWxWMGZBd3Zy?=
 =?utf-8?B?eGJXMk9Fem9TaURmM2t6NWxiOFRjUExib3N4Q1hmeGVTbzIxZSt5SjBzZHBQ?=
 =?utf-8?Q?pQLeU7iXYW56bzJPOIlMzYfQs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f9f7de-df98-4f16-6a89-08dc27fcb53b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 16:49:10.7509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZIAltOyWojgjjrU8bA7BBsJriQIrZPYjbLRJeBP9dhS/Cy2e649q6sjjAo3c1rF8+++ihTegpblmHOhf1oGeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8990


On 02/02/2024 15:34, Joao Martins wrote:
> External email: Use caution opening links or attachments
>
>
> Dirty IOMMU hugepages on a base page page-size granularity can lead to an
> attempt to set dirty pages in the bitmap beyond the limits that are pinned.
>
> Bounds check the page index of the array we are trying to access is within
> the limits before we kmap() and return otherwise.
>
> While it is also a defensive check, this is also in preparation to defer
> setting bits (outside the mapped range) to the next iteration(s) when the
> pages become available.
>
> Fixes: b058ea3ab5af ("vfio/iova_bitmap: refactor iova_bitmap_set() to better handle page boundaries")
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>

Tested-by: Avihai Horon <avihaih@nvidia.com>

