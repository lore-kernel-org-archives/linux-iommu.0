Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44C217C3
	for <iommu@lists.linux.dev>; Tue,  7 Nov 2023 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uJoy8Hpo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUXroFL5//Y7kKF7NgTHsecciJgnZ5fNXh6Nq06j4Zq6xRIlNN+dkdHmXNHdyFKxJ6+1K2TB1I++veXV5pAU2K/9yb+9aApPDntKFQrWrElrI0hd/+VV26dO9zvQ0nMZTegChXWXXBa2a1CPyo/cbDq2BObGNnukA634zLF8Mn5hyawx1BkmgN4Y5xtuqw6XnjrHywEx0oCKKJ068OkwuPqIU+QTisB3nJ9r78G4pfw+A+9YrCS6IAmC4W5lL/fO4fTCZkFIk7WaUj1+cYR6MkqZsao4LC/9CYhDzeIzKeI6q5am6NvRT7967+qWqwMIBL04YQ89dZZHLdp0GDESKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTeJ24Xhvz95NXIOI9Kd56MAUYDvR+v2St+/lz9tFzg=;
 b=CuWXwTG4JAtHaMWy1ags3TJc4S4u1oZ3WFCbI22Cm2yDQkAMyDfsQcBFqchF7t3/H2+avhI+nBL/rZ3LCRJkBwQus/adz/YNF2bE9YVmUrig+byv6fq2rah1MlrzCe6C7ceLqgaT2tM815JQT0CNTbSVb/tiA8KZY8cPB1+6hT9V8fqA74TRdZXfwTMutKKkrE0xCJ7M+2g8pm77T2OQNzI8uYlyKPd7JEbgkFuq1MzozngC4fcxezQrwbmX52af++h5aq3kmexQ3Y/vyIGagfKCPhMl53/RrTsw14rbyzLS29OAyWM2v7mhqM5eM6375ngWepCpw3jIqehGzeyo0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTeJ24Xhvz95NXIOI9Kd56MAUYDvR+v2St+/lz9tFzg=;
 b=uJoy8HpozxEthm93Bsf3Dyi79df1gSwugGcx0yUqvquVksdnZn3F4xDoZfhtK1/tt5U1xXUyge/bF8dQhTO+utI5TqUG1om0Xvy2a6HO9YbKxcx0oeSMM78LUfiL/rXXe/sV8riTSQICrcyufX1TIwhxlj2F9/ve+jhdRmfROq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM6PR12MB5005.namprd12.prod.outlook.com (2603:10b6:5:1be::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Tue, 7 Nov 2023 06:48:03 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af%3]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 06:48:03 +0000
Message-ID: <63fbb300-fd17-13b4-323f-fc65fc8d1c45@amd.com>
Date: Tue, 7 Nov 2023 12:17:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 03/12] iommu/amd: Introduce per device DTE update
 function
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20231016104351.5749-1-vasant.hegde@amd.com>
 <20231016104351.5749-4-vasant.hegde@amd.com> <20231106175456.GS4634@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231106175456.GS4634@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::30) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM6PR12MB5005:EE_
X-MS-Office365-Filtering-Correlation-Id: cf5530c6-b6fe-4714-5bdb-08dbdf5d7d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nexPw+7MTBSkEfO26zLAkgJK/cHy++pekx36PI+xfNGAXHgM3viPRfPF/Hk+IEejRkGEMs0pDE5jruSTfG9S9K/Zj6kkYIEOXnz4+dO71Cia6lj6u7HuNmwPmbysBmMLPQIHCGrjwRe1j+/B/2mjjwcfwepYH5PC7Lynh8IFxcfU0Q/LbpE1Qm57gGanma+6lrwzKNki9tV2s5zDCGT0floXqS5TpavQ09y+g3WWq+V3p+z5Kd02a6SkYndSh//0CX9/YOvoeAd8NjlQ+L53bjPAomyjN8xPJtmzivk1Yd5LNpyaJ1jhGGgQlp4jiCH6Um0FX/6PbHiITpC96IxgoQ8Pu6+JdXZwbF6WupzonvsMjNo6T2KrUi7ctDBzKB1nIEvBHomUumJc1VSE3LlWiSBjZ/C1dBLt+f654JmBOeiQit2Lix0IKyYxMm4O1B3znH9ueTYEonez3MT68myoAXOW8x2m3dkCUWnlmYxNW7zxBMppkz+wKGEegL8y3I1viTmR8rCIrBima0wSnwB+HlZrtbkaxikqK+d5PVNe8pIVK4tQ+Fzemo11VDTv12UrM5rGPuv9JqhpJIDI2RbGL4VROn4SLq2pdyBF6b9lu2zhe+FsJkOWSkziOM03BZZ/Z72ARG9Vmo+V90i/SDrcnw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(41300700001)(6506007)(53546011)(2616005)(6486002)(6512007)(6666004)(44832011)(316002)(4326008)(8936002)(83380400001)(8676002)(15650500001)(5660300002)(66556008)(6916009)(26005)(66476007)(66946007)(38100700002)(2906002)(31686004)(86362001)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVMyUEhGMTNtSDR0bUJmbnIzSkVabndVdk94UUJMZjYzSiswOFhjOGJsdkJB?=
 =?utf-8?B?L2VpUEdDSjhhNytLZkFvZUJVSm94dVg0Ri9ZeVMrS2IwRXdOVWpmMWhFQjhw?=
 =?utf-8?B?QmovWUlNRGVNSXprSzRncWg0cVh4V2o2NXRHK0pEUFZvWWw0cHMrb2Z2dEVH?=
 =?utf-8?B?d0xpWEFGS1MvS0p6TGNNTEtBZVB0MGxjNGhXbW5BMmdnVC84SEt2NWc4d3pM?=
 =?utf-8?B?bTVKVHlUNHk0YkFhRGxkblhEUVhWbmN6dW1RQklYUlpFQk45SHp1WUF2ODBs?=
 =?utf-8?B?Y05FS2JjbGowWlhjaU9RdmZjcGZPS0t1cDVIci9vSnpjZzBhWldRMjF6Vm5I?=
 =?utf-8?B?eTlWVmRwdWFxajNFRlhmSDZkaDFnUGZGQ3NQSStHdk1IZE02SXNFWDhHb09q?=
 =?utf-8?B?YmVEdHp0L0dXRG5NSWNBNVkzdVdTbWFhdDdQYlIvZVZHUmd1TktOdTVobzlT?=
 =?utf-8?B?RGo4OStyYTZzQVVnejdKMVpObk5kcFlzdWNYYkk2T2lKeWJoSmx1MVdsLzRK?=
 =?utf-8?B?U2RoMFVQeXdCT3d5YUt3KzMwUGRpczdsa0ZvZVV6dllSeU5sSjZRaFF3QnZq?=
 =?utf-8?B?L2hOL3BXZU9xS25kQk1ZMWpJRm00UlJycStBcWkrRjhwUGd5b1FlUVhmdUZy?=
 =?utf-8?B?NFI0SFRTNHVSYzFwdkZsdGNPb2lSTGZyQXdJNi81UG5UWEcwZVh6M3gzaE9j?=
 =?utf-8?B?d3dEcE9tVVdFVWFSQlVMaVdOd21FcFRBb2t6bkNKUkJTWm5ISDVSeXRIM1pC?=
 =?utf-8?B?Q3lycS9HTnpPVmtDM3FwUTQvTXVKcHpSdFBHdFBPbkV0SGZTMC8xdm5jRnRm?=
 =?utf-8?B?d2l5U2pLWFNJbDlkY056WDZCYUcraDFJZGlwKzUzbHVMaEJqZUpTdHBvZ3Yz?=
 =?utf-8?B?Y0dmTW9tS1hOVUJJcW9tSUdKOGRZOTlYL243Nk1jeUd4Ulpnd3dsdG9JOHJJ?=
 =?utf-8?B?a2dqbmNUbGlvUTVHSTFqamlDcTZ3Mzh1WWtPbjFOQ3pBcnRoejVCYmlpR3dO?=
 =?utf-8?B?aUJPcjdoNFZmMnZaUWdRVnd0SXlCR09sOFBXSTdDdTByNWhtVzg5endUM1cz?=
 =?utf-8?B?aGx5aFkxaktRL0s5WUlWcTZuOHRtTzRRQUw0WnBTUlFoa0drQVlDU3k5Y0RG?=
 =?utf-8?B?ajNUT0hkbDZEdGdUSWlwK090dGV1b1JwYXMyaGhZeE1malBuWFRXVS9BVlhS?=
 =?utf-8?B?dzBXRTVWTjhRNlRUa1FvR29jUnQ1YmRlU1dzcnZYWWswTzkrd2VtQnlWcE1l?=
 =?utf-8?B?U1RlZzJLR015REhSSFE1NDdNQ1RCbjBjL2pYVzhiZW1kN2hUN2Q1dk5CNmp5?=
 =?utf-8?B?MktxM3RoUGtrdEdFdXJYLzM1T2xobWsrbHJUcGhVVmxDNXhRZVVHaXo1UE5q?=
 =?utf-8?B?eUhwZUQwRzBlMkxnOEJhdzBOblVGVkJoY0UwMUVaQVFNNFJjck5qd0RIMUt2?=
 =?utf-8?B?VDFNc0FBUDRkZXN5Z1BORlpZZTVtYkFhZWNLbXJ4SWtYWUc2RmdKemNERWll?=
 =?utf-8?B?dU9ZYmRDRWREUDEzMWd3a0VLTkNiSy9SQkUzeFhBdzJ1L3VpWnVnQmV5RUVQ?=
 =?utf-8?B?YTV6QXJCaHdCWlJoTW9ReWNnRCthZ0wzZld1QS91dm1RSVlIYXNMNmhpVmxy?=
 =?utf-8?B?RGRJQXo5RWp4Sk9QZlZLR3hhZzJsMEZET2RjbVovcGxtb3JBbnpRT2dSYnpW?=
 =?utf-8?B?Zk5tYjdCNFRFK1UrSVk3dThWZkZ1bk1JbFI0NlhNODQ5RnVkWDYwQ0ZlRW5J?=
 =?utf-8?B?SjdDa1RDRzc0Y0xlOTlsNnIwWnVvam1mbkE4QXYzMEIwaDNaY09MOVB0dkxl?=
 =?utf-8?B?dHp1RWNzU1Q0TWo5OG9NdjVTT3RjUlZocm5VTzRCNVZCTzZFT3JSUXlLc2VL?=
 =?utf-8?B?SUFMTXRDWEc2RUdETWk3eTRxQ2xpaEpKem5OM3k2UEtLVWRyS0J1SlNNUUdB?=
 =?utf-8?B?SDZVWWxyM0xxRTNKeVlDVlpVS3pGbEdDN1hEY2dOUFp2VzhGL09RMjhVelV6?=
 =?utf-8?B?VEhCWkh6OU1YZEhma1I0TmtNYzZNT0h1QzhDY0k2bkN5RXhDMExBbm1aYTdT?=
 =?utf-8?B?a0NGdys3SmdyODBYZnJjNXNOanFyT3dKTDJac0RhOUIrWjAwdkg5MUhpSkx6?=
 =?utf-8?Q?4nx0RiTUg3wQQogr0XOT8ma+e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5530c6-b6fe-4714-5bdb-08dbdf5d7d62
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:48:03.5090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+VZGYW9TqpO5+eEIHL9P7uZhEqmYWyTscqEdc34lZERD6wpPwg6G+xZBwnBlmsYEG6KPPRks+90URXjFNbK/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5005



On 11/6/2023 11:24 PM, Jason Gunthorpe wrote:
> On Mon, Oct 16, 2023 at 10:43:42AM +0000, Vasant Hegde wrote:
> 
>> @@ -1679,6 +1680,24 @@ static void domain_flush_np_cache(struct protection_domain *domain,
>>  }
>>  
>>  
>> +/* Update and flush DTE for the given device */
>> +void amd_iommu_dev_update_dte(struct iommu_dev_data *dev_data, bool set)
>> +{
>> +	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
>> +
>> +	if (!iommu)
>> +		return;
> 
> Can't be null

Fixed.

> 
>> +	if (set)
>> +		set_dte_entry(iommu, dev_data);
>> +	else
>> +		clear_dte_entry(iommu, dev_data->devid);
>> +
>> +	clone_aliases(iommu, dev_data->dev);
>> +
>> +	device_flush_dte(dev_data);
> 
> This should take in iommu too..

Not required. Device is behind IOMMU and we can get iommu pointer from dev_data.


> 
>> +}
> 
> Makes sense though
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> My other note was to basically do this:
> 
> void amd_iommu_dev_update_dte(struct iommu_dev_data *dev_data, const struct amd_dte *dte)
> 
> Where the caller functions would generate the DTE content instead of
> having ste_dte_entry try to reverse engineer which caller is calling
> it.

dev_data has all required data to configure the DTE. So I dont think introducing
another structure is necessary.

-Vasant
