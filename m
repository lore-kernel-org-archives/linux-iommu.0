Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18E2D277
	for <iommu@lists.linux.dev>; Thu, 12 Oct 2023 06:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jS9AAAPj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocFxkQLpuZ1r7CGs2EopwEFr656FohRJH/HOq2sO7uKBP8kW0O/Tr8rSbR7lRcnq78bv+Lz/ahhTgmrX5y4PwqjO3HOK0ztEZ/BmnGLeSY/xb6zC2DQ+CtLzlYS+sWU+Jkflw0JOmLJ7H6IUXfK26Uo1XMRVWXe5aWld5Pha3EwSlJm0u43TTanswxsALxhQHNEqCnA9b18altSzsBvvvzei1Xj4E9mrBA2hQLz7AM1rBGWrafFDRnbiAGFDQRHj+79LaetgTW/Jwd+OCTfZEnjrXOu7NXC+huJwN5SktiuwnCrlTQ1JWvRQ9lq1SPc7sUpKWe5epFtlh3czAcgK6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iur16LPz7uPjzZgMzaFpUfbsGTyyJ2nXUGcDZIouhX4=;
 b=QjFPY1SlpCVMWoVl2c57BzFFfM3/zvXug2U4ASb3peZaMlq6UmbjhgRq4smrNR2phkpo7Vq8/XCWce4K0pEgpWqM4sKWTZ/SvQYYhDuQ8YCqCUwB2G00+k9eCz3nHJlSZbC/AySdcVJ8A0usMWH0uBmmHwJhj87Gz7bkpSiLaPModl99WCBlDKHcPvXpIaIyHmNx0+ro/Wa+9HcN0rSCsGTax2X63UCqj3pbX6Y1P4IuQ4ehBuYjVN1GoyNuzcLpGziXSXBAqz2akyFo0DJ8GERT5CvG/u3BAQNVtjI4sIzJnrPw585zVDGhGZ83iuTs0rSrAvgwdwzJ34rXOwTVUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iur16LPz7uPjzZgMzaFpUfbsGTyyJ2nXUGcDZIouhX4=;
 b=jS9AAAPjInq+ig3jBqZ0JGfTK2RAIw/GDXvYw3xq4Q35BYHJBkPlbZEeIElFthrHcloL1egajlsMgCd+f409PrTM3Nc8OIYjGRYskVlKfQM32jc8wOC6qezZ1sIe7b/C/0HCd5uKcPaM/Gwtj1NwN43+u76imkJNPjaqc33zacQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 BL1PR12MB5364.namprd12.prod.outlook.com (2603:10b6:208:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 06:17:18 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::90d5:d841:f95d:d414]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::90d5:d841:f95d:d414%6]) with mapi id 15.20.6863.040; Thu, 12 Oct 2023
 06:17:18 +0000
Message-ID: <fbd9ec8c-1a91-95d0-4c6a-8d9b1840f861@amd.com>
Date: Thu, 12 Oct 2023 13:17:11 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v1 00/13] Improve TLB invalidation logic
Content-Language: en-US
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
References: <20231006101624.5912-1-vasant.hegde@amd.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20231006101624.5912-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0117.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::33) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|BL1PR12MB5364:EE_
X-MS-Office365-Filtering-Correlation-Id: b475d2fb-5a8e-49ec-bbc8-08dbcaeae2be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KDU8/af2y2+xksI+gR/ZE6q74fQO5WakiUi+JmErs13DVomSMLOYtSHEp3jjofsWQ2UnNDhjATu0ki7j7KePjAwMgizWWDlINZwZ5lLvKMt7To+mAIspFgxBrWARgnX03hx2PbELLiJmTqv8/9QTafx5m5oM3lSxBDNjg47SlYagwy77N7bSLR4MiY1M98PSvAnjD60kdI/F9UOF5PLQ6Yng+ng7Ujviq7SZ00FK9E355HVOD+/mDjHeSqiLxg1rXOuKseS5ELeFXbWt0T4qlWJv6yKqOGp3jO7n8/r2o6FDLLRCNzN3ovBTQhJIf+sqlFWNF5m5fL+/bDXbmo8MLr3m/w1KVWGU/p3V8jSEGrzasvoRLKlvyEyfFb+XZRGpZdjImDEuvigHSNBL2ntgNwbkQT4RrfRodnjp1h5pop7fnDfoeNt7tioacDhJGGCNnLBUf6orTiiSi5+LdrW+l1zfma+e7D3r/KCatdJbhnEFPfiBLjfNKinzQEUvJpLzY4Xz8tS5u+0p0nB0DF6cPaVizFruydBqxx8xDBcsEGlOapQz5gN97z1CJW+MjLXCWj78DlYcHS2mCC6SyU0JdUEdv6FHUC5GFyYDLKH0ZzPHO219JdX7ovFhGbGgEj7vq8d9J3kSvqy3ETRHlBKTtU/mnC8xmnYh3a7ZhMdpvZN6RlDJOE7C83PeVEZqOzH2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(83380400001)(316002)(38100700002)(8676002)(8936002)(86362001)(31696002)(36756003)(66476007)(66556008)(66946007)(31686004)(2616005)(6506007)(53546011)(2906002)(41300700001)(6666004)(6512007)(6486002)(966005)(5660300002)(26005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajVQTHF4SDNlUXZWMkY0MWpVTHNYRmlWdktjcUZsTDJTUm9IWkppV3JLNkZq?=
 =?utf-8?B?eXZvcG5tdU43bWdZZjZvdDErdEtUVWdsblpSamFOUHB2Q0J6TVZjTENEM2FD?=
 =?utf-8?B?SkwrVDVpK3RxMTRyMEN2alFmbTJ5Yk9NeXRrdUJ0bmlLWUtRNTQwam01dURW?=
 =?utf-8?B?OWtGUmg0TWU0MEdWYVFpS2tvMWFHOE1SdXBOUk5aWHFYQ2tIaWxSZXZDOHJ5?=
 =?utf-8?B?cUVsNHNnWUx5SHhrZHZzOE9sTnY1T29VdkthMnVYNTlDY3ZxaGxoTjl0Sm1X?=
 =?utf-8?B?OWduOUxTcUhzdk80cWlpYzJ1Q2VVcWt3WWRVSGpCdjJhMmxuNTNqZ1BONTBa?=
 =?utf-8?B?bkJWeGp2NTBlNitxazJUWjJ1bVVaRVJRaVIrVWU1cmc5ZEJsRkZvcWZwdUdw?=
 =?utf-8?B?RlVNMi9rUng1WG0xeVAyZyt1K1A2UUdaS1JXZWpjcFhsb3QzSk11cFdSYmxL?=
 =?utf-8?B?QzBpbE5IMWRaRWdnNC80Tm9nbHQycFBqR2thekJnTVgyWjJGRzByUytVRjFW?=
 =?utf-8?B?d2xvbmVqd2hBYlpuWFdHUzhITGF1MU1xTjV4SjNlZ1FVR201dVlPNldtRVV6?=
 =?utf-8?B?eExpLzdidm84RzJJMEpaRDY5WnlIVXhSUmhFWXRQZC9UMDJPSmc4M1hLczVC?=
 =?utf-8?B?S2NNODhRa2F5UjJqNFV6SGRFUlg1RGNPS0d3SWd4b1hNN2EydzYxVHloMm5T?=
 =?utf-8?B?cXcyemR3aFQ4Z0lYdHVJVFVVaDZUL3h3SWxsbEN3NGd5Q0U3WXlxM1JHMmhX?=
 =?utf-8?B?SFQrVm9aOW5NNy83bHpDaElXdmp2WkVQNFFPc1NaQlVQRnE2QU4rQ0VzRFRn?=
 =?utf-8?B?dWhWWlpRbkVXQTFpeUVjK2JYa3JrVVFIWGVxc0Eyd3BlcDRqbnJ0YVI1VlMv?=
 =?utf-8?B?VHNmNW9udmVrT2ovZHNIalJVNUt6RlFFdVZSejB0RTZ2RHd1bGtyR1d6ZnhR?=
 =?utf-8?B?emIvc3E3T3RzK21BRjVJVi9IdUFEbnc3RFQ1SDdsWS9tVkJpSk1wZllONEI0?=
 =?utf-8?B?SFVCdk9VT1ZVTGVpazdwRDVYUUZabXdwTkZWdURVb1Z3cm1sUngwcDRXM2Jv?=
 =?utf-8?B?dlRFdUwzQkYzR3dkUTBhbDBVMFpOcTdBQmM1cTBXTWdKcGZGcUhuWldhTDNW?=
 =?utf-8?B?ekxiYmZuV3Q3TDliQm10WitVdkZTMjBUbHBWblN5QmtWMEx2WHBONHUrVStX?=
 =?utf-8?B?RnZ3UEp3eDhWdmI1cWNXY1Z6dFZ4UW1iSkdOZnBGK2o4d3pJQUQ1ditXVHNk?=
 =?utf-8?B?VFgzVVlsVHdpc1lPMG04V081elJlWnk2b2x6WHp5WHdJdDZvanJsNUp4MHQ2?=
 =?utf-8?B?aGZOOHNyRlNUWU5wa3krVDZET29aN2F4eXFtOEpGOWtlT0hsSGR0MGJmRVhV?=
 =?utf-8?B?Mm1CazNiNS9XbUQySTRBM2pLNnhWMk94cVhxSGFKbzRBMDluQXdDbDlWT0JW?=
 =?utf-8?B?a0NiaDFBLzR2YTYvYlZ2ZngvSW9vSGpQeFdjbExxbGdkUHF0MXRnUmNRTk1I?=
 =?utf-8?B?TmdGR0g1NXo4VW8rVHEyalhaVjc4N2xRS3ZUdXlkZDU5Uk1EU0lBcDhvdk04?=
 =?utf-8?B?WlBhSGZEVkdFOFpKcE56ZU1DaE1PbnFpN1NjYlAyclU0dmdhZDdWUzVFTDBJ?=
 =?utf-8?B?QlVsQnRRME1RcUl5QVJtTWd1d2FhRSttVkFRY0FNb0UwZlVHK3FQTFJMeU5P?=
 =?utf-8?B?ekY5YWtxM0FvakhQRTd0VlVsbVRxZU9yZHJsZ2VjWnZVY3dQTnNUK2pSQU5L?=
 =?utf-8?B?d3NJREcweWlpRzZHTVlOTmhXeWkxbmM4aEZvdlo3d29kUW4rZHg1Y0JQcnY1?=
 =?utf-8?B?LytaWWhuTmdBT0pXaXc3Nk5USkZFc1lxaUF0eE9DRDRRS0MyNnpQellCS216?=
 =?utf-8?B?UFJMVTd6aWNlc0ZBL25QcUJRODFsYzlWbXg5elpRcFhOYTlBTGE5bW44VU9I?=
 =?utf-8?B?bzF3K1FVUUs4NUxNMHZWYTdNMVNNaHRkWXBrM1RGZHRDb1hQL3pyL2dTUmZO?=
 =?utf-8?B?Q2V1VFo4RXowM1lEdUxnU0JOWTFWZjNoekQ2VXpuMmgyNytHYzJKS3FXQWUx?=
 =?utf-8?B?VkZKak9WZFM3VXdnRjdKcTFZLzVsNXRFS2I3TUg4RjNqOEhXK1pjdkMxWFRa?=
 =?utf-8?Q?Mrz2z5kElmwHfEwe0DfYUQELj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b475d2fb-5a8e-49ec-bbc8-08dbcaeae2be
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 06:17:18.1476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27aXWWi0AXsCYWcnA2XL6VUeRNNW2QigisqChLn52O/4YfHhLQX8QarweGYsELYsAb9rFesjf4etYlQygUZN5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5364



On 10/6/2023 5:16 PM, Vasant Hegde wrote:
> Current code invalidates single page and entire range for the given
> domain ID. IOMMU hardware supports multiple page invalidation.
> This series adds support to invalidate range of pages.
> 
> Also consolidate various invalidation functions, remove unused functions,
> re-arranges invalidation related functions.
> 
> Note that this series doesn't add support for PASID based invalidation (except
> PASID 0 for v2 page table). We will include necessary changes in SVA series.
> 
> Testing:
>    - This series is tested with v1 and v2 page table and it works fine.
> 
> This patch series is based on top of SVA Part 2 [1] which in turn based on
> top of iommu/next branch (Commit 8e5ab3f54a10).
>    [1] https://lore.kernel.org/linux-iommu/20231006095706.5694-1-vasant.hegde@amd.com/T/#t
> 
> This is also available at github :
>     https://github.com/AMDESE/linux/tree/iommu_flush_improvement_v1_v6.6_rc1
> 
> 
> Thank you,
> Vasant

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Thanks,
Suravee
