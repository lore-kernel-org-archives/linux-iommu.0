Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F844A33F0
	for <iommu@lists.linux.dev>; Fri,  5 Jun 2026 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780649726; cv=fail; b=jMeqj9Mv4BjzlQpRer+8hTd1/P7ammXsG09gzn5lCIHMKqOsHnzy4g3UEfwR+AUsXX3XYjaHKgIusclrnV532vj0QCYbAe80Uo1W0bu311M6shIF92WfjmQhAzj9Af5IUi89CVd+gfZAAhAwFqnWZNhiZvyjKZ/Vs3UGWKz1O/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780649726; c=relaxed/simple;
	bh=g3Km3n4liJTwKo6Sf9KBNvbaXkONcNDgnbeNglUExKo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BEaObihBhrfg/z0EoqG2+7kZmCNbZbDHPnlDfAH5ULmZx6lfAoMtm1JvUt08BEIyK5xsmP145ntciFUuK9YZy/ZLMHAN91Ez6eaW2sTZ4P5orRWoNcc68EwV5qNKwf1RHfcLmHgDq7U+bdRBo5fL3toBhnZWfsgxhOxv2Yxt27U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4t4k2/Oe; arc=fail smtp.client-ip=40.107.208.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4t4k2/Oe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqoSlqSfzmdB0AywZD07z8rpEMvORmsgThZo+jbcnt5cXeHonfUv/lvtjc8W9E5IlpSLsy8lZ1kGele7MkNlPXE5t7MRhiEaSp0t1ZX3zIN+vJdsxQbn/s4AGg+Dl3BpZLYgkvwFZt+5ENZnbwRVt8fMrtiIKFEsV4y86e0eCYTnavtJOCuv7UUfVMGtEw4bbIhbA2gkm9sRtlVyGG5va9vqhsFbhQAKdlfrJx6P1WTA7OOT9HepFciUhxqHKUNyX/P2U28NIGsXfvszSWOKeRh0o8XI9EP4zfSx4rbm09CIxFi3XUh8exp1rTk3cKAzfwV3hvSdN0SZTKPBg9IYZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uB3d0IWwZmVccRHsdojjIZNwb3OqSDLunr8PY/CZjl0=;
 b=hJz3jz6Yyojx+yUAQwdr95W/Tc06I7MTp1YNT1Bd0zyFiCYNWKlByaRSjFw05yqlPgFN4hKxWEImQbYXg9+X3t7Uz7oFOo34QbVwUzFicTv0AqXHyDx1IAWQh67gCyQQwAQf/h1ywzEDBGf+nPs9iaofK2VJyjKsuV6XkYHEFlaNEvAaCqgoPE0Q/+EBYBAy4SB1qM3GEUx82M2aNEZWRFnEuVfMjd4lPokC8ppXEkGotsJio+Ign7QjFgRAtZdxChD5a5mma9DzGEgl7JO20TsyLWIa5j1pSQ/vASVvTXO/LvnVWr4pNYSNVzbf5Kl95J1YkK0Ue4ydiaaYw1F2Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uB3d0IWwZmVccRHsdojjIZNwb3OqSDLunr8PY/CZjl0=;
 b=4t4k2/Oebf8ePRWhQIyVlNHT8iV4GRdkmLfd4tiSG7T+SFoQzkiSWkbAanVsKV00HKVkrGt0axB5Dek0CCCZIwUj9l+GyZTMcgI+oDFH+P/heL6uoyD0gIPbpq7Ww+99eHNoJr9JMX3u2mb8b3Ka5pNS9spOHR3QbJABRAR3Vjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSSPR12MB999236.namprd12.prod.outlook.com (2603:10b6:8:374::10)
 by DS2PR12MB9712.namprd12.prod.outlook.com (2603:10b6:8:275::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 08:55:20 +0000
Received: from DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e]) by DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e%5]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 08:55:20 +0000
Message-ID: <0324270c-7609-421d-97ed-5f5d9eaa1869@amd.com>
Date: Fri, 5 Jun 2026 15:55:11 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/26] iommu/amd: Introduce IOMMUFD vIOMMU support for
 AMD
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
 wnliu@google.com, dantuluris@google.com, chriscli@google.com,
 kpsingh@google.com
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260528051738.596013-5-suravee.suthikulpanit@amd.com>
 <20260601124442.GI3195266@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260601124442.GI3195266@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To DSSPR12MB999236.namprd12.prod.outlook.com
 (2603:10b6:8:374::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSSPR12MB999236:EE_|DS2PR12MB9712:EE_
X-MS-Office365-Filtering-Correlation-Id: 18cee5f4-754d-4087-1796-08dec2e02be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	09MINdlHYIad7POwmQBL+Kc9C+WHeWyPvZTgL/tYKnRbmyqfs99FC+NsG16tJKqjWTduxfEL5o8t4QgN/UaZZaf3v4dM9BJPH9BHo7ymMonqAoy5nuve4+2iVXz78Qr9wMcx8FNbMr/tijN+gE08IpW1escTBlGMILXeyFrhXu67DBYdOW6gdvG/PzxbdwCDJwgd20saiaHL7FhkxXIYPAlev8/Jaxpjm9RD0gTBcIhRgGM8J/7Qx/P+7/gnu9riMVl0Rx+lXbf1OVU2+dOv8lUkbltRAmiOHVZS29lC0iVIVZoxrtPbsVWlRkm3xLTIKJ52WwEH1Z5n0+RihfxvGGDrwX0Jb+t6pe/TUpCsZwXjckU/cmQx5l1F0ZXrYEPDBu1kOa0X6BnZKMblUk2Z5KBx+35eEcLcqVAcT7kj+h8VU1nWnHmovsy1BgbVgOx/IYPI1hOJkVguYMWsIBfGtke6Z9F9tQt/XvjBeX9RSdYX84h40GanyfF2JnCJz35Pn0BbFpbhtOVKVZaRws5NOs7vw9IWbq3Jd0QVlhThANc/fcZjJD3PG4kCfC2MgKuCRbJTAl4PY8SCTKnGvMk60RSTQqx19RBToKiginlvk0EuG5HeNXqrj7AxFl4wxV5XY3L2z04Fn+7qOX/pX0LqPddpmavMg0HhDkG4fi/xe+/c9Sxs1PO7Laythn6FQcF8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSSPR12MB999236.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S05VR3JpN08wajk4dFoycm5GN2ovZzFja2VxM1RnVmgvVmN3T1lqYytYWjdD?=
 =?utf-8?B?b3VhSTVTcjVRM3dpdGtMTjBVUHVyL1BncnNtOEZoa1VwN1F2RlRZS3lIclhp?=
 =?utf-8?B?Z1NxeFg0Qytzb1lkZ0tNc0tJejZYSDNWOENsd1BtTXVJMDgwcG85S3BuMGc3?=
 =?utf-8?B?emh4YiszUlRKRTNvSDhLRElBaXBybGtJZVhteExTMEc1NWRpQXE3V3hmemNx?=
 =?utf-8?B?VGZ6UzFUUVo2c0EwbHh3dWFPbGVyS29yZjdjcXlxK1RnU05YZ3QxZHMvMEZE?=
 =?utf-8?B?MGM2aTVuaENkWmJkckxoUWFtbWdtOXdRMS8zSmlYeFpPSEc2TUJYOXhSaTFm?=
 =?utf-8?B?SExNUXRmaVNOKzdxU1JOTllDOEVxeUp2Q1FoVDU4TGMraFJXSzM4S3VNS1J0?=
 =?utf-8?B?dHdrRUVXb3VWeGZWWE13ZWlJcDl3SDVXRCsrcVB1NDJEeE9jQ1VzODZhTnB5?=
 =?utf-8?B?ellLa0MzaXNQRlUzbmowbTlmSzRiQW0ybXhpQVhlMm1DbXhZQ2trZnFrRi9L?=
 =?utf-8?B?bTZzOU1VdDVSaG15Tzg0eWVtRHVhTytvblRqcjdJNXM2eks2SUhLMTVXUlE0?=
 =?utf-8?B?dHJqZ1ZkM3FTRzZjR3hlampKcjhlS0VUYlloSXRJWldFdk9VN3g1bzhlWmx1?=
 =?utf-8?B?bDdQVCtJWG0wWDVBK3piRnFMUXFPSElHemxzeTNnVW1GNktOT0IvT1VLRTgw?=
 =?utf-8?B?TEwrY2N5MnptYnZVRlBnSFRyeTF5bk1YblVucEMyd1dPSWUyKzY1TDZTc1F3?=
 =?utf-8?B?WEZIbThndEhhNDl6V01aOTViUHRmb1l4eERObXVmc1ZUbEo3YjdEQWtRUG5W?=
 =?utf-8?B?VzM2amJ2ci93bUhKSm9qZUlxTVNqRmtBVHYzaEk3RU1yUlhiSTV4SkRkYU5P?=
 =?utf-8?B?TmUzMWlmbFFocFJvRW5wSCtYeTg3cFB1aVVZNUtMbWk4eUpkbTdhVGVpaEVD?=
 =?utf-8?B?VzRza1ZRandicXFKVUtQM045bXM4QXRraG9ETnNCK0RwMnE3aGtyeUFaWnAy?=
 =?utf-8?B?eDdoU3NEcnpqLy9hQ2Y4dFN2MDRjdVZQbWxqVlJxVy91a2Q5Z0dPTVZQZlVK?=
 =?utf-8?B?YjE4REtQZ0ZGKzdRVVVNME5sT1hZSE50V3E2NFNjSGtZSmh1ZGc5UnBmWCt2?=
 =?utf-8?B?Ykl3Ukw0TU5mN3o1bml5QzQ3VVZDMFBrYy9YQlJqalRQNDZlcitpSVJWZ0Za?=
 =?utf-8?B?Qml6b0RGZnVpWGZDcUxocThCWXFwTzBrdUhuL0ppdUJEd2NlMmhYWVpxWUpq?=
 =?utf-8?B?R1ZBUXMvOEN1ZFNRWjNDb3FwTDJPS2RxMWhKUWUvcTJIRGNTTjBlV1krMXcv?=
 =?utf-8?B?VEdIbzFkOGdvT1d5WUpkVU5FTjlaT3NWem8vMnU2QThmdjZ6UldtUFVtRXBV?=
 =?utf-8?B?SGs4RGxPZ2kzbWhlU1BSVXcvcGx2djhXWElYVys4ejhjVHVDV1pvK290N1Mr?=
 =?utf-8?B?SmFMN3RjMjY5YkREV2t0aldlYkV6NDA0Ly9xMlI5Snk3TWdCNW9RS2Jaekgv?=
 =?utf-8?B?RVVmL2RzRWNTQXptaFVDKzJNejRZOHZVNVl5VTBMd0c2ZStYcDhvc294Skx2?=
 =?utf-8?B?RDZ5alZNQVY0OFhSSXc4aG1jTHJsczAralpPNkV1K0JaQlFRRmxKazFXL2pv?=
 =?utf-8?B?Z3hRY2hPdEdURWF3NmExMmg3WUVpa2VhbURoNkRjUE5nVys3N0FZVWx5M3VZ?=
 =?utf-8?B?VFdZRDNlZFI3T3diYzMwWnFycEw4VlI1TWI0Vk5QWVV3a0dkaEdsOTVYbkNZ?=
 =?utf-8?B?V3pQa1VESVBzbkQzc1dGZnpURUQ3dXBmeW0yajFUb3R4NisyK1ZTZENvNG9N?=
 =?utf-8?B?WGg5ZlRBWnFKNW1tTVZjM0swQjgrMWRLdy9MSkorWGVNbFBCWlRBUVFLNTZF?=
 =?utf-8?B?Sk9KQVJkWmhOQ1QybVoydnViYW1rckp0MGU0aEsxanRjTjJYZVZDOGUyMjl4?=
 =?utf-8?B?Uk5rTlVlb2R1a3dEaVQ3bmdUbWMvU0J1SEZWOEhmQW0rR215ZG80ZGtrZVdZ?=
 =?utf-8?B?VkRnWi9VVEw2cDhYYWlianEySEFoL21CWFZ1dit6WG5BN3RQVDJrNktCc2ZH?=
 =?utf-8?B?Skh1UWlwcldBWjIzYzNNUDcvWk5aQXdvODh0aTZnQUVxK0loQXJhcXYrK2JI?=
 =?utf-8?B?U1p5UGFKbUVZeUVEUjc5NXhYM0o0dnVSbmY1RnplcEVpcUxDa3NTRkQwbnZW?=
 =?utf-8?B?UjVydlAvM3RYUVpSM3k5Z2lFdndNZGhmL05ScllaeVAvQ01wb21Va0d6ZzhQ?=
 =?utf-8?B?WkMvVHhlaWNFSlBlamhsQWZ1K0QxTkZRL2hvek5JWC9FVTIzYWpOeEU0Q3h0?=
 =?utf-8?Q?bxL8lVl5LupCPXURCH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18cee5f4-754d-4087-1796-08dec2e02be6
X-MS-Exchange-CrossTenant-AuthSource: DSSPR12MB999236.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 08:55:20.0865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDUos3dlLjg/ygiNVJn8pYXDwOtEq/GtCWjs4SzATGRlIgq2ujvC6E9x8w+CZDoXY5fffigR7OWqLItxJZQq9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9712



On 6/1/2026 7:44 PM, Jason Gunthorpe wrote:
> On Thu, May 28, 2026 at 05:17:16AM +0000, Suravee Suthikulpanit wrote:
> 
>> +/**
>> + * struct iommu_viommu_amd - AMD vIOMMU Interface (IOMMU_VIOMMU_TYPE_AMD)
>> + * @reserved: Must be zero
>> + */
>> +struct iommu_viommu_amd {
>> +	__u32 reserved; /* must be last */
>> +};
> 
> Do not structure patches like this, introduce the full and complete
> ABI structure here.
> 
> Jason

Noted. Thanks.
Suravee
