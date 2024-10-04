Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E6E6F305
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 08:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728029909; cv=fail; b=C4lyLFU6TmSNIZ1A+kEJ1EdtJ0QX4Q5//BANnr080EtIHxwUYeKO9c0KVVZVuROWxk6e9pOw6qL2+meTsyY+/h+VXRB5SbAn5lNN+TrSvTxsp7NzITbCH4inWw7RaORj95x6uMT5RDiH1YlzUx37YsnXjA9TdNrrugUpSfMTKUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728029909; c=relaxed/simple;
	bh=NfdZBVGQdy1YF0MljVrNCXc/Fcw38WZ98uMlvUl+pzI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u0Ju9zNzIew62yceG/sB2tNFBBFV8fMiZoWO2XihPFZP1iMgTC7RlK5YoxW40NszFORaoVG0LdHJvNsbz0fzf1LxnnGsi+86ffkMKQdC5jTSKzzuCzzwdQvjRNeooEXDuKxxYb5r0rrDl3h5Av0jL0plstr2UhjiqzkwC5qEqdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n90ld2lj; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n90ld2lj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4JavJL4NnarmwYjbaGG/Sw6IxKbuhjv8lQXuFNOSFey2StEsL3kesUX6PgZe2Nswtni3UXZ64zYrULuUyVgiLE6jqeXzJ2Sg8/CjpQbipplJMKyoUt5F2dkihzrPD0seJyFY8jdhLXJxL4nmUWy0e+JEs5bVB7RuephHqec6Nc9eerJs/r3MsaVGo5tMm23LRozL/k76hae1Ekrc6DpsJQpO9Q0yPCP1DNSakkViENc48BckCAbawTCwfr0+hrOfJSLPfTUMjq5YZdeVPdxxcPv5FIkVlqMLHdoCgFW/0eqGOenh6QH+TrEP6r6ku0KCuxEFTst0U451O7nRfuWYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBdW4lSblCjzlOf/kRezuMexWq839tsbjUlmD7bfvvA=;
 b=ebjbZzuWC+iJyaUjICqIzmlGZz1RcKqjM5KuXD2nBwPSv+c86kOpBJigy3KP1P/edaPM/YD6VKaaHnVxFrRBVrlu/3wyumxHsKFcwnt1V7XYR5A8C25UxkozbiLxHESc5iBpcMOHqabN8l1c3OcJDPhRUBk0Zll+Uav/Bj8n1NN+HlLzBd3bUGyw2c+BBi+wGT7pAbcXEQ8ZPVjVZfVplxAG00pP58cKtmAVmsZ/oBg2tzKQWtgWM+HpekuwrPVzkSObPcm7x5+OtTCv+rHq1xDQ3XMe5CrtqM4g/HmSWDQDjyqT8XsZHJrOxljz3/qexZUHScZpLoAle4N1q/vqrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBdW4lSblCjzlOf/kRezuMexWq839tsbjUlmD7bfvvA=;
 b=n90ld2ljSvcteQj6ZzwxZk1cFfOZXcKj9zxvv7Tu/iBNgfzo4qNH3jRK03xcZVrUdqhuZFSKRuL2OU8m0NdFmtozAaPs6tA6kBi3VJNMdHgMdp9Yrt/qw0Inw0eGGJeya3iXtTXfQy1dVloBf2Sw3TfwWFV+Vv0b3o3lZlHbfNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.18; Fri, 4 Oct 2024 08:18:25 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 08:18:25 +0000
Message-ID: <ab325171-10b4-4bc9-978b-049f09c445a6@amd.com>
Date: Fri, 4 Oct 2024 13:48:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] iommu/amd: Enhance domain_alloc_user() to allocate
 PASID capable domain
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com, jacob.pan@linux.microsoft.com
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-7-vasant.hegde@amd.com>
 <20241002193116.GA2428925@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20241002193116.GA2428925@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::19) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY8PR12MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: 075c01b6-7844-4ac3-655d-08dce44d1df2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2xvZlV3ZnZWUE5Bc1VNc2FiMGJaYWtVTHJTYVFkdHpvc1hIOUVQOGdxakVN?=
 =?utf-8?B?SzJLVGYzaWc1MzRXUlprTjcwcmFNamVhdjY2L0VZbnVYNVVzbzNNR0dtSU1z?=
 =?utf-8?B?RG5USVpmbHJPRDMvK1RrUHp1ZjhUN3B0Q0p2bFFsTEFNd1JLNG05eU96Zjdz?=
 =?utf-8?B?T093MWliMlQwMTdYamZCRzJLMStUWmhYK3JIWXVjWHlJeEVCVlNGMEhtUDY1?=
 =?utf-8?B?RzlwSjlhYUkxdm5QcldWVmtCQ09xRnYzcC9RQTVLekNNTkRDOUt1THRZak8v?=
 =?utf-8?B?NkNaVlNDZWI3L2V6YnpXTVRrVVJ0VGZlMW9RdnBYa2dnK2pXYzRicUl1STYz?=
 =?utf-8?B?b3kreHg4L3c4NkRuRFNnUEtUQkJzRnJMSTVpTjlWVSszdHNreDM1U3NQaU5E?=
 =?utf-8?B?alEyVUkzODV4N3NDeTEwTjQvbzFHVzdwK2RxM01IcWo1eTA1bm9teDR2bWVl?=
 =?utf-8?B?MkpCcVhiT1hjU09QTFlZS3dwNzFIdEFnSVU2SXY4K2h6SGhnam1EN2srTnI5?=
 =?utf-8?B?YWZDUjgzVkMxQVdqOEg4b0ZSTUV4K3NFUUxGdHpRQld1WGwxby9LUEZ1ZW8y?=
 =?utf-8?B?S1ZwK0dZSHJDSURNR1lWb25VUC95VUt6aWVnQVlKT3RBWGpDMGQ2WTBzR3ZS?=
 =?utf-8?B?Y1oySE9SSmRlOHhyVlIrbzd5REo0U2pZempSbW9PaTU4dXRLWDU5TEYvK1Vr?=
 =?utf-8?B?NmVWTXM2TVB2a28xZlR2Y3hsUTY5UVJPNDlQcGhPTmhaZXlGNTk3WGEwSE9O?=
 =?utf-8?B?ZlVZSGVLYkNsdnIwWnpBc1hNeXk0NDVOWTZzRkJlMnQ1cGFKbDE5WFl6Y0F1?=
 =?utf-8?B?Nko4c0I1cWw5UmpuWUx2TDBZbXM1MkJ3SU81VXpBaStmRGM0cGg0UFk0VU1x?=
 =?utf-8?B?ckRWdXJ6NTQ3MnRCK1gwQ25MYlBOTHluK0R5UnBLYVp3YkxQdnZ2U0k0SWk1?=
 =?utf-8?B?T0NxSGxXdVFWWWY5OTJJS0pSK3k1c0JEWjlZMUtzbU5RU2lrYUNGVEhkUmJh?=
 =?utf-8?B?VjBBUlRRZFlIbnphOUxzUXlOa1pQWDBBcUo5VlFwR3NPQ0M4KzJOWjFuWG1V?=
 =?utf-8?B?SmpkRjVITVpDOTNGUmVlcWpjOGYyYUlySEFUNjd1djNZWm9XZVFMUVRHRXJv?=
 =?utf-8?B?eDJDWXAvRVJ5cUxCeWZ1dkFuRDhzemFPUTdwQWlGdUl6N3FyMHp3cGlNSDJi?=
 =?utf-8?B?Qlp3SklVMlpPUTk4Rnlyci9yMmVGc0M5WXRZSXBaYlprVi9UOWE1QmtkWmVh?=
 =?utf-8?B?a1B3SnlyVCsxUnBoOUlMTXlPa1RuN2lOWWwreVdtakZjbzZuZk5OYzhXUU1a?=
 =?utf-8?B?N3NNelFOVzlGQVdMc1NEVG9qelNrZWthQXg0MWIxVEZOcWxEZktKaFBBcjEx?=
 =?utf-8?B?RER1dVJ2d2dQTkp6c09KcXI4SjI5WkVDMm85VkRDalFqMDBuRFM2c3NWdUNk?=
 =?utf-8?B?M1J3V3ZMdFVyRDIrWGcydFFzQ3BhVnUxbGhPMlZlc2xGNE5ITW9UYUtBVTN4?=
 =?utf-8?B?VERIMmwwRjRiTHBVdWVuR0EyOGZtcXJRSnd5dmRiMFEyWkpLeEdMelhNcGtI?=
 =?utf-8?B?cEhHci9mNzhNaE03dVJLQ3VWbGFsRmRtcTl3SWVhdVo2ay9PZXVZVmUwRU16?=
 =?utf-8?B?WlJzVSs1OWVIMmpCQ3VTcEN5Yy9Ld0ZwQTdQcElvY2JVM083RVBpbGVycVRo?=
 =?utf-8?B?SGZFMG83K3c5aVN0aDZtbnFjUW5xVlJwcUY2dlQrOWh4eXhDN0JjTkh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkhuZDhIS0hod0lTT3FtZTJIRHNISGs1TWp4Y3dlWWE4V1NvcWEwVGVuRnpt?=
 =?utf-8?B?SlhNQ21LdmVDN0xvOXh2aHdTbXJ5OUZRMEc5RUZPUjNURjVYNkk1dEtiU05R?=
 =?utf-8?B?dmV3LzY2dytzNGIwbFA1ZXZBWmlUeTRuMm5ab29KaVhOUC9hczVFd3NvR0h5?=
 =?utf-8?B?Q3NaUWNBb2grQWoyT1gxdkQ2QkQ5MWlVVUFJUU80SWFaMU1Dck1ER3hsMTEz?=
 =?utf-8?B?SjFaNDU0ckJ4b2w0UmxiVGp4dE9NZkVCalNxYnZCQXpUU2pLdEUxVUZ2Tkk3?=
 =?utf-8?B?dHVCTnJjTHgvd0FkNFdTbFpXa1VVSDBIejNESEpqdkdBQ0xhTVlVRk02Qkt1?=
 =?utf-8?B?YU5TdGZTbFlCNTg5UlBrMlV5d0VQdkVvcDFwYjQ4S01xVzNtLy9UcFd5d3Rk?=
 =?utf-8?B?SWR4c2ZkeUJOdVdSNDN0aEhMZ2hBV1hZYzVEZGpQcG5rZ0liQmFkS1EzckFW?=
 =?utf-8?B?UU5zRUNLdGszS2xqSFFyWEVQT2t4VHUra2lpajdHOFAwaDM4RjR3UCtxQVA4?=
 =?utf-8?B?blZpMXZLMTU2NGtKc29SMlpsR1FkaVVJQ0hoWjVmdVRzaGp2SzdkbEc3ZWNP?=
 =?utf-8?B?M1RvK1FMRFppaG9hcDR0bnc0dnZwYlFEMGJFRE9aZkRWU21QNUphWER5Qk9M?=
 =?utf-8?B?aGxhLzBEWEhGWTAwMldJZmk1TVpZQXNwUm9pdGJtY2dZMDFPelQzTEY1a2J6?=
 =?utf-8?B?eHlmTHBYRndrTUgwWmdURkovaWFqT3B1TDkyNjdDRUtQOExBcmpPaXlibllU?=
 =?utf-8?B?TG9xRE50bjBUdU44YWpkRFIwQm1sZGxObDJTajA3VnA1MG84YlE2SHF6UWsv?=
 =?utf-8?B?NkN5RWdMWUtvNDRQSWVuTHc0WVFGbGtjK1dFUVhXM1JtMWRHT29YSXBoZ2Ri?=
 =?utf-8?B?dVpLKzczTEcrL2VneGJZYjZROWg1MWdrMWJQQ1plRUM2SmMzejhZU2tteWtz?=
 =?utf-8?B?bzNqeUEzN29LbkplbmZabmI0UDVYb3pIZDNiVWhZcmNUdUxZRWRGK25uRVRT?=
 =?utf-8?B?S2IxQUFlQ3g1bDZNdzRtZGdSZUFWdFR2N0x3OENxdzdHVE94R0hBcXpZZFdi?=
 =?utf-8?B?M2RxNEFYREpSSmR3U0VQZkhpWmc1dllXQ2VEMWdwcVp6OTBLcWdIUWdyUmNF?=
 =?utf-8?B?c011MXJsSE9mUC9WZTZtRHZTYnhBdUxQaGdzRnZtSFFUTUVFQUtKcG4vRklj?=
 =?utf-8?B?Zy9nRmNqZzd5NFBSdXRWd2I1UGd2L0puOXh3UngxbkZybmQ5QmhSeGF0TmV5?=
 =?utf-8?B?K2JjQS9XcWN5eHdmQnBjZ0F0dHVwWWpiQi9HZzZOZUNMYXZmdXJ1YzlMbjNX?=
 =?utf-8?B?VWFlMVhldE1Sckp4K1N2Q1JQM1dTRllQZDc4U2prNkFXeHhlSTc4N2VsQkh5?=
 =?utf-8?B?bVdqMDZFQ3Y1ak91cXRzbEhXeDkzVVplcjRxMXNBZmNubUFUQlRJa1lIY3Rz?=
 =?utf-8?B?UzVaUUw0bXJYL2ZvUHJFTXA4aWJMSEtRSXBiVE9uQU01blY3NXVLOXNIelZq?=
 =?utf-8?B?UGtYZzRnTVIrcENwT1BJaFNlZGVIOE9oWkx1ejJiTE5xcE9KYndmZkNJTC9s?=
 =?utf-8?B?TDQ5cHErZkkyRGVrT0lvNFd6Y0dkN1dlbEJNdXVndjBVUURSREt5RlRCcWI3?=
 =?utf-8?B?aEJ3d29oNkRiN1lwWGl2Tm93bTRkcHdNeGwvaHRqeVVha09TcUdzenowSmFV?=
 =?utf-8?B?ZDlhdGROd1FiOFYxNHFWL1pPbDl3M0s1OVd6ZDdDVnRaemRvVGFLZU5veHpB?=
 =?utf-8?B?UmlNUjQyUjNxUG16ZGJFVE9qR0dLL2hwalozU2d5N21rSTRCbmRCRlUvY0pE?=
 =?utf-8?B?UTQyenc5UWFEek5uV0VHZVJIVjJ6U3hnaGZVaThML2NCYTBmdkxaZUxKaFJm?=
 =?utf-8?B?aGt2dXhzRW5yNUpzQkUvcTlVMGJGWmdNVUFaTlBoTlhEbHNCSHhyek1PZ2li?=
 =?utf-8?B?czFYb0d3RldNbWkyUkxDU2diSUwwQUlxM0laTVNNSWJnMkhGcFZUTm5FTm5s?=
 =?utf-8?B?TUd6V09pSXk4WXJXRjljbW5BbVgyaktrazlkRUt0MitveVZLWWxzOTI2d3Bh?=
 =?utf-8?B?Qzk2RTVwTTdCWUtpc0Y1RUQxcHJEUGZlOVJoaFdROTJYeE4xTnlUTjBlbkVC?=
 =?utf-8?Q?tTBPF75CbBkC51kM8WahKJRwi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 075c01b6-7844-4ac3-655d-08dce44d1df2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 08:18:25.0095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWcf5ZxhcxglwqEBVweQHKqlRR4PYHqQ3FyOopB4uQFoZpUikLgx99JEHKmJU+gc50P0q0qIWt2sYTTbXM/GDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7171

Jason,


On 10/3/2024 1:01 AM, Jason Gunthorpe wrote:
> On Wed, Sep 11, 2024 at 10:19:09AM +0000, Vasant Hegde wrote:
>> Allocate domain with v2 page table if IOMMU_HWPT_ALLOC_PASID flag is
>> passed to ops->domain_alloc_user().
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/iommu.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index cfeb3202ceee..1c9e539f15a7 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2401,12 +2401,23 @@ amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
>>  			    const struct iommu_user_data *user_data)
>>  
>>  {
>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>>  	unsigned int type = IOMMU_DOMAIN_UNMANAGED;
>> +	int pgtable = AMD_IOMMU_V1;
>>  
>>  	if ((flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING) || parent || user_data)
>>  		return ERR_PTR(-EOPNOTSUPP);
>>  
>> -	return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V1);
>> +	/* Allocate v2 page table if IOMMU and device supports PASID. */
>> +	if (flags & IOMMU_HWPT_ALLOC_PASID) {
>> +		if (!amd_iommu_pasid_supported() ||
>> +		    !pdev_pasid_supported(dev_data))
> 
> The test to disable v2 support uses:
> 
> 	if (!check_feature(FEATURE_GIOSUP) ||
> 	    !check_feature(FEATURE_GT)) {
> 
> But this doesn't check FEATURE_GIOSUP, just GT? Is it OK?

Ah! You are right. To support V2 page table, yes. Will fix it.

-Vasant
