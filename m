Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A3A1C27
	for <iommu@lists.linux.dev>; Tue, 22 Oct 2024 04:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729572869; cv=fail; b=kaHo7K0lWc7Cf72q3lyRfE7RaS+UdvA8lso8h8FfAI31PXZO681u31wR8MIsycSj0lf3gxhgLkqqti0XywrDFxRPaj/xpiqGnC0PkjW7UHDWrqXUtW1bPgBgT8pyNPGHaNUtn1DQmXCUw5Q+ieWwKbiIeNTmt0uDRK1Yfju+UlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729572869; c=relaxed/simple;
	bh=BuJbfsY1fBPS7ex/M6Js7mmwqRPrGUc44kKXHYiUyC0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gZ9Fut62RxNCcolApHZRbq6a14eWeWnbAmCo2rqopHxN2R031jPdB29rLI1Gb3ebsBenDa8n4pIMLy89DcAPIECLBLe7X6R2wyQGQNuaQwEfYkFLbSeRhLVllL4T/J45EkqebxJlINAPqrpsqVprrLw1rkHWGXq364HB+yAGriQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k4hdqc4N; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k4hdqc4N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAubVR5YivZNOVsCg4fx0yuDELuH2MYU7VMSa48c2jfFwobV36Ur3rXbpetdCxmpRAI19Lh21TVciyNjLG7fNyq4cYsQI/gSp8RtaCRJuYrStlFwgxsquq3PbcsFcb7VZfQcf/vPzpdEhHXM23x7v8S31+sy2wPh3riVBeaF0QjpYlSb6Zsae5CVRjhEqnwYFk5MniV8/H8s9/siGu7YJ4I3L6ZCslC3to9NU3b8tWMdYBD3urTYgtw8ChsgNACKk1J8aXvuIXjP2rRHPm+bEpDMxD22kucCw/gpDQ8civPV6Y1qqrg1+kP5HDL/ONgaopwSEjoRp/zTHTBBxb+EDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GOvONrFoiyp5vErxbUfzLSNZDdZtdBibVNjLy0ukD0=;
 b=B8hbaAvrt0tTRzBxI3RQCM8dPsO3n59YFS9vfRk1Wq6xJBNHinNIRptGFjGZAOuNSNmCg6zm6gDNk2NdFh4FHH3v+QLuW11EsZ0Nqh59hHBrXk/dXU/jsDuR5LzwSoZ27jUpk933QrusFWt5sk4F4a1KaoGZrH/esgwlohD802EF0KcLeIcMMPRhUUwdJlANpGUNYkDuiu3ceGSNjPMcjPItTGQAFJDbHRpA36BzbQHA3kb0qxQ5NYFemhtL07dmuKYRFtC4AugSdAPUXGQ0hh7JR5FHhg+7aWhiBlF2CNMOzNGn0Xfnzxzbzz+EFy94rnFIk8a0/pwubVzSL/CRWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GOvONrFoiyp5vErxbUfzLSNZDdZtdBibVNjLy0ukD0=;
 b=k4hdqc4NqPkTnVHyzbBDLEPcpM1L1ccyrr6bHaGvFIEuyFiiIPYvqpl6qMk2JDGoPux9Y/T5bVNHXxwswFfEwZ95txLoxyweFaWSqF5FXmYNf/IMUW1J2GFsc0JihVanxXYoyTQQdZYIOKTY2EDE6RNhYCibauMjXEuqlgjXnmw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM3PR12MB9414.namprd12.prod.outlook.com (2603:10b6:0:47::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.28; Tue, 22 Oct 2024 04:54:23 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 04:54:23 +0000
Message-ID: <e17e82fe-f34d-4c21-8be5-3b55718edcc4@amd.com>
Date: Tue, 22 Oct 2024 10:24:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] iommu: Add new flag to explictly request PASID
 capable domain
To: Yi Liu <yi.l.liu@intel.com>, iommu@lists.linux.dev, joro@8bytes.org
Cc: will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 jgg@ziepe.ca, baolu.lu@linux.intel.com, kevin.tian@intel.com,
 jacob.pan@linux.microsoft.com, Jason Gunthorpe <jgg@nvidia.com>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-4-vasant.hegde@amd.com>
 <95ddde93-9cac-4067-a3ca-1ef02c2dcd09@intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <95ddde93-9cac-4067-a3ca-1ef02c2dcd09@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM3PR12MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: beb1a7ed-c131-48af-1e60-08dcf2559887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGYrQmNISmVHeDh0WE04TGJaUEd3ZU0rZ2xFRnJBQWxjVnU3TFdJbUpxbFo0?=
 =?utf-8?B?dElDV05qNktXcVRVUnJTb2FtcGJodHZuejQvRE1Od25xV1YvZVk1WnhIMTVl?=
 =?utf-8?B?UDJscVJZYUpDdUhST3dkRTkrS2JYR0JVMkRSRmRYbnpvVFIxNGJScUJGMzZr?=
 =?utf-8?B?TXlXUmc5MUlyY0lLbExDVkUybUhiVndqcmwwUHZXYnJWL3duek0yRXdRbXAz?=
 =?utf-8?B?SjhwRWJZazA2VEdLc254ZFZONnFEbWxXSEsyWGw2dXB0UUNXNDJ5SG9TWnNM?=
 =?utf-8?B?Z2ZPZzcvb0dyWlFQV1g5djg4bm96aFdMcWxqMGgxTUZsK0JjR25Cb2NwbzBG?=
 =?utf-8?B?NWV3SkU2Nlo2cUJ5YWxnL0s0Q1c5dWg5enJUcGtCWXNYQm5nazVab1krYVdr?=
 =?utf-8?B?LzhQTHBtV1VQS2RjbmFPa2s3RHNjeXNoZFYxSys0aGtxd2YzeUhvbUI2YWJT?=
 =?utf-8?B?bnQ1ZUY4LytYc3lxUzNXSzMxM0pQTmFCOCtwWjRLcW13ZkhpMGtrdWFlSlNh?=
 =?utf-8?B?NlFHeUc2c2lMSkpGOUxNdGk1dll2MTlURmRDbHA5UWFmTWV0aFNXd0hHZkJs?=
 =?utf-8?B?eXV3NUtJSUFUQ2RMNWJMeWRIODlkQjRWRWtvYmpzWEZQMVN1YXM5UmorQjU1?=
 =?utf-8?B?YlRjUDc2WXVBdlgzdkgveHlaSlUrWThjTk00c0w2Z0xYamRLOVpWbUNZcEJs?=
 =?utf-8?B?cG5SNW9adW5OVkdVVEpFdDRZazlOVk51azRlTGlzMExtVFpGc0hDWUVEZDJT?=
 =?utf-8?B?bCs2ZTNaYy8rV1pwWEhaRGJKZ0xsaDZ0ck9QVlR0V1BvRTZ1VFhmN1lmRmsv?=
 =?utf-8?B?cDFOQWdOZE9zWVNJU2FFcjNWdGdlTHg0NG1BUFEwUnpHOVFINDRmc2U2YjhL?=
 =?utf-8?B?cENHbGZ2aGYzam9lNnZHWkd1d3BZQ1h5REY5bFIxYXJwZ2ZwYkRob3gvamJj?=
 =?utf-8?B?YkEyWTdoUkpPY0NMMzFZY0o0MnE3SWtIV2t2QzYxYzJ4S3lTalZKRFc1c09s?=
 =?utf-8?B?cUVaQjAxU0FoQmI3SEZheWZ1akprS0dnSUg3K1pwQy9KTktzSU9ucGdFaFo1?=
 =?utf-8?B?SktFQko2ellSYjVCaEpBUlBZbnRKU0NTY0x4UWZ1eXFNeEd6SlA0ZnlmVTVC?=
 =?utf-8?B?dGdOdVZodFhSNTY4Um5Pb3ZGSlhlc2o4OEdGZFd3bGttYUhMcUkreFYxdnFQ?=
 =?utf-8?B?WkdPVy95WHBpQUJ4Zi93bFdDb3JuZTcwUU1OSjIvL2psYnBqeUk0K1VPV21k?=
 =?utf-8?B?N1UwbVpmZjRrN0NQcmE1WjdyMUFkQUxhbjR0OHJYQ1lWSlBXVkVwL2ZYRmth?=
 =?utf-8?B?K3pBNEo3b0kzM1hiYnY4ZzAxWFF2clNka21PQmJsMGxad20yRVAwTWppTTFj?=
 =?utf-8?B?UDBacG1LdDhLY2VMSzFhL2FBWUFTcVZJa0kyRHN2U1RVS1RoVWlhQW1HMTUv?=
 =?utf-8?B?RUZNNURXbUQ5NXFUQlVyRiswekxwVjVOUkRFV0E5OVY1eXRsV1ZRcG1iVzZE?=
 =?utf-8?B?T29ZWk9QR24xM1dmSXh2T05ZQUExNVdwV1FjK1pTcmNwVFVFbWRYdmlhUTM0?=
 =?utf-8?B?NVVYRnZtWXF4RC9tbWlCbW5vSjlTbFVGK2JiUjJ3TEdiSHU0TGVnT1RhWW5a?=
 =?utf-8?B?OXFTSTlNS09uMW9JWUgyV21WUFM3ajI4MGtoMEZqbFZyL283QW1FMFhTMVF5?=
 =?utf-8?B?U3VneVhrSXFVOWlKRUJFVUxRdm9JMHBvdjNjVDUxUHhSR3lqa1JmbnNScTFI?=
 =?utf-8?Q?UdrTzKr0uV5I1CBvVSsZvJ3WHPY5jE2XKPCQdre?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlE0Mk0rU1VvajZaZGlUU043bGNKSWRxUC9YK2xBOCtialQvZktpNVNUbnpN?=
 =?utf-8?B?L0Jsb2w2STM1RDVRT2xNZWI5bWdrcXoyZTZIaENvTm0ycEZzSGp2TDcyYVRa?=
 =?utf-8?B?MGNnZkZNYWpmZUkyQU14T0lWNE0wblByWHQzWmN5WEFxZlZyOVpoWThFbUxE?=
 =?utf-8?B?ZWZ6NHJPelZFNkVtR0lhOC9zQXVJNmtVcFk1amZNN1lOTHc2enQ5NGJNWWVO?=
 =?utf-8?B?YVpFeS9MYkNNb3ZLbVZJbzdmZmNWd1B5SDBtWDhuQXBhVFNxRDB1UlBqaktX?=
 =?utf-8?B?SjNjVjhZSnZ5KzhzQnBOVm1vZTNrZjRVYVFQQ1E1ZlI2SVdqRkNvYVRUK1ZB?=
 =?utf-8?B?ZmJaNkd2c3BBTkZkS0FtWmR3L3lpaUdvS0tjdG5vV0FybGZOVzJoL0JpWmR4?=
 =?utf-8?B?bFBLTjNoWExaWGJFZk5xWnJIQVNVWENzU29iRndvbVBvK0k3b2tJeWNuOTlz?=
 =?utf-8?B?ejg1Z2lxTjI3eUdrSXd5WVQrZTlBU3BBUWxzancwOEhqSFViUzh0WlU0UkVX?=
 =?utf-8?B?MDZ6YmRpWXRTN0lCQnpUZFQrYWdHU0dlb0hLdmVlUDI5UWRRY1hDOHRHakts?=
 =?utf-8?B?Z3FhcVVoUlJwN0RpYkpOenArU1FDa2dlM283eis4ejBGS010UUdXT2lnTVVD?=
 =?utf-8?B?QWFEdm5vRHRmWFZYS09vM2p5MEQ1blF0bGR3Szhrbkg1ZlB6M2Nybk9iR0VT?=
 =?utf-8?B?RFV3NEw0RGF0YmgzVldVVlk2SDNEcGhwY1Z6YUhXVmpubEpQeGFiWm9zTFBu?=
 =?utf-8?B?ZnZNTDd3YjhKdjlzUDgwb1ZjMjkrUGVaVXkzbTd0aUpKWFRPL1AxQTU0bGRL?=
 =?utf-8?B?ZFg5ZU40dWVlS0NWOEFTNHNkeWhwT2hEMnllRDByNU10Z1ZGMnVTdmdGeHg0?=
 =?utf-8?B?MitjRWo1SzBsa094cGFZd3N4RlE2NGFOTlQzOWtTVWlQcHVyaFo2SkxRbzRY?=
 =?utf-8?B?dXljbDI4N090YnhIcHYxSDZzMHZacisvNGZFOWswRUxKSmpmWFFKZ0IvcThh?=
 =?utf-8?B?allPQjZ5d0gxUUZnS0ZYSDNjWFk2bjllT1dUN0x4TVQ5bHFDZllkVURCc0FZ?=
 =?utf-8?B?d1o3QS9TTmZDd1ZJamFBT3pEbExYajVGdmJoaUh2dWhBcnhpQ1Rnd2h4bWJZ?=
 =?utf-8?B?MjI1WittY3lRc1oyNjBEcXdNZ0tCQlYrRndmbloxTGpvSDltQkpRMmxNUVEv?=
 =?utf-8?B?MW9CQTFLWXc2anlHU21ML2pYRFNKN2hPUktOKzJ1TW4yL2ZUQVl5bVBaZTFJ?=
 =?utf-8?B?K2FDNGhZb1VHNXVTTDcrUDJPN082OU1DaGM0TGFRWUpsRjdJbytmNm9FMFFs?=
 =?utf-8?B?UHBBa09nZUd4ZU1DaXBZVWN4VTh6NGZxS0VSZUNYMmpxMlZXTW9DNEoxbXc3?=
 =?utf-8?B?OUZRTlRBK2hST3U3OGF4QzdYK0luRXZHTUhHTVZvaURmRUFlY01IQmF6UUow?=
 =?utf-8?B?VElobjN6aVFQUlY0eHNjL0lsbmtuUlBBZkRicksrRzUvTitXZGRKd1lBakp0?=
 =?utf-8?B?RHY2QUpHOWpWL0ZjM2Z6Y24xc2hQWGUwRzlPVUNNUkdZbEZDQTZMTlB4TzQ2?=
 =?utf-8?B?MTk5N2haTU95WkF2anRiTVlwY1FweFlOQTUybElzYmxMYlg3QlNZd1hGOS9I?=
 =?utf-8?B?TDV5cGp2V0RjTy9US2JBVWMyWTlLV2c2TXN6SXduVE9DVEtsVmU3VU9NMEs0?=
 =?utf-8?B?TFBzRE1VOXNQaDRZV290eGY0R2hrTzZqbXE1QnZjNkhLM28rbWVka1c3NXhk?=
 =?utf-8?B?eGZoUm9rbDdQTTlLUy96dDlJZDNmSW52bFNTU3djQW9rZGMrOXJjVERTS2NZ?=
 =?utf-8?B?QkN4VExMTDhrRmVNM2w3UWUvNVNuL1o5UDg5TG9yeVl0QUhSdnRUSzNCZ3Nr?=
 =?utf-8?B?TkZ6dFZHZ3dORHVDdDVhRjBCUnVXWnhYR0RlNHE0enpUTXhVSm90MFJNSTFt?=
 =?utf-8?B?dlU2VkVRaGtSdjgya0loWTJRY2M3Uk0yZEd0aUpmKzB2YWoyVStUWE9GT0pt?=
 =?utf-8?B?Z3RGaERoVGx5ZGU1MmxEM2E4UkxYOFVrcDZyUy9FYXhDVEtnVWY2dlZ6SmV1?=
 =?utf-8?B?ZTlvOGNzSndvcUp6Zi92VEJHMGtrVEZjMkRrTXpiZTF2Y0dMdHd5WGlpUURD?=
 =?utf-8?Q?J01fo0nRx8j7PJqkzSPvZ+UOn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb1a7ed-c131-48af-1e60-08dcf2559887
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 04:54:22.8515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfbieVFxoYfr6PrPH5GRwfbiCLfg0OPvDGT6bw7Y8MuXnSkOkUudvalSWM0+zbMZUYQOAYnhT/JrfqMvljsb8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9414



On 10/21/2024 1:29 PM, Yi Liu wrote:
> On 2024/10/17 22:01, Vasant Hegde wrote:
>> From: Jason Gunthorpe <jgg@ziepe.ca>
>>
>> Introduce new flag (IOMMU_HWPT_ALLOC_PASID) to domain_alloc_users() ops.
>> If both IOMMU and device supports PASID it will allocate domain.
>> Otherwise return error.
>>
>> Also modify __iommu_group_alloc_default_domain() to call
>> iommu_paging_domain_alloc_flags() with appropriate flag when allocating
>> paging domain.
>>
>> Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
>> [Added __iommu_paging_domain_alloc_flags() and description - Vasant]
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>> ---
>>   drivers/iommu/iommu.c        | 45 +++++++++++++++++++++++++++---------
>>   include/uapi/linux/iommufd.h |  6 +++++
>>   2 files changed, 40 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index e13d64ffd14f..107016b3ba3d 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -32,6 +32,7 @@
>>   #include <trace/events/iommu.h>
>>   #include <linux/sched/mm.h>
>>   #include <linux/msi.h>
>> +#include <uapi/linux/iommufd.h>
>>     #include "dma-iommu.h"
>>   #include "iommu-priv.h"
>> @@ -99,6 +100,9 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>>                    struct device *dev);
>>   static int __iommu_attach_group(struct iommu_domain *domain,
>>                   struct iommu_group *group);
>> +static struct iommu_domain *__iommu_paging_domain_alloc_flags(struct device
>> *dev,
>> +                               unsigned int type,
>> +                               unsigned int flags);
> 
> nit:
> 
> +static struct iommu_domain *
> +__iommu_paging_domain_alloc_flags(struct device *dev, unsigned int type,
> +                   unsigned int flags);

Fixed.

Thanks
-Vasant

