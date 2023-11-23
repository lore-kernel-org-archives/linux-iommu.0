Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B383FB2B
	for <iommu@lists.linux.dev>; Thu, 23 Nov 2023 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GBJhuPCy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EF4OWH9difqy8HHESPBIVtfW8h1V5pTAcvH91PJo3Vu0U5Ql7X/MmEw5u+SRGJHQK8bncjvhIzuv12cdbtFGiiG/ePxqrclVOVIbi7QG+MGrpTTk5s4jbIljkxqEH/1zt5fJV4E/V2m/Gg17t4dTIw1NzJbY4ySv6ftTwGYhu2JoIdXERoZ3XqwdV21GnRXmD8dsxxqrtjdR13xWl1RSymXak70apBRD+s+ZVivUkIQWSGEWMwuyOif8QrrXRvgMlDRppDno+eWrDSw5BGy2sDkPbDsY7FTjLpSQ2fZdd/AKTa1UB5bW0lw5C4SZQM/ojKUP+nClUTb/VI31b+kcag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXNLA+efiw82ek6IWc6vHaxfLwmpQvHeAzAJupgOJkE=;
 b=odRVPf4TANbnClIWOPPYiP+hEktpJXpEA/EpX3b5ubnIYo5ki1XBDTS3V6ZxhlxhTZdHfRA5wyu2lddedfcjg3EpaNa42LjfYqjU9y1HDAeQPkorKCXxUJWkV6dEbvLH/GwVdFd8n+enj2uLsbrDgx4n0AB1i6NOFXIqtADb6uAeC7JST5g773S3K8gLBBys7gyQsO5mly6XHq5lq60mpaWQTG5gfA+/5InigveIELQVKZcKNwlQ4D3QRMxOKFW6CB0WOsFrX5GdDlm65Zm/3561JmTw3+Rn+0YfQzjDOMrLgQyIvtaZ9fdzM0J8RDKcLpIExJSriTAFQok8vvycdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXNLA+efiw82ek6IWc6vHaxfLwmpQvHeAzAJupgOJkE=;
 b=GBJhuPCyPPLjY1rDNqYtrpkmnGw+lfxZMiOmj0YEh2RshY76U4j/MkSe9wvH5LvCxk+SgoOvHsyJfJENy8Y2+agsp5mWj4EKgxuXrA3xOdovwJi6CaY4n1nss6bB0N0NqbRK7mqKEOZNSpzzLEJDuF+SPLDrICuR7l3bmIIKSr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 LV3PR12MB9235.namprd12.prod.outlook.com (2603:10b6:408:1a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 17:23:32 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af%3]) with mapi id 15.20.7025.017; Thu, 23 Nov 2023
 17:23:31 +0000
Message-ID: <73c7dd92-7aed-f5ce-db44-26b9f5c0876d@amd.com>
Date: Thu, 23 Nov 2023 22:53:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 12/13] iommu/amd: Refactor GCR3 table helper functions
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20231013151652.6008-1-vasant.hegde@amd.com>
 <20231013151652.6008-13-vasant.hegde@amd.com>
 <20231106174003.GP4634@ziepe.ca>
 <d905c553-964a-b15e-19f5-1be4896a7818@amd.com>
 <20231107133157.GZ4634@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231107133157.GZ4634@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::22) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|LV3PR12MB9235:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c4307a-8aef-4025-bba9-08dbec48e9f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PXPPwAzrC38qV1n8ta8R1cILKKN+GLK9xIAbPw5zNkz+AjrFjocOvHZgJ9Z5lI+hO1Sj1MLQhnUfUR4YKsrKAXcT9lGG8Qna+OvASK5xwlVW2g4kceaMYy3yxp17UqAgrDkYLI2JjQR/bWkP/UUGepeZZHleq23ZuwuODBvil1989FguIX7r/+s9P7gSwAwSGYYqQ/lju3IcvbcHe+wQlneBhE1A2GLW8ARDgTsoaZ799GJAXvCPhb2L6w9HzA1D9xfZ2ZEIsmjQ00NUPjndKNF+yzIjRykLCmfLShzt77MDJVE/H5KcyslTGatLCUwLJdKZ8cHNqhVaJN248kKE7w8ZpVqpB2Cwr66KmtF495uRo+y8gUwkQ7xGJkcIHnX8l++KGHy7Nsc9dmgaxAMTQ8BN0JLVXm/8ZZ6oER8+B7EcF/tPJJj+vElrqgEpD8y2d7S8nDGpTNyFaM/8KOjjjXC4gp4hDksoCe8gKNVA3JxdX+j3DjnO/WAIfR9c5e+7VKUnAaUKS4ULtLh35jt63hbSPbg0jeNtvpN8n7vkYgDcdpfObFoAg0m7mKbIykSJm4Qqf7gu/XA8ZW7/7NPRGuy+EVlPznuZgzYXj8DcY/wGUjvp0Dwcuo0i+H1tM2OBQO+g/5c9jo5GeWpx/2I7Kw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(366004)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(38100700002)(41300700001)(478600001)(31696002)(6486002)(36756003)(86362001)(6916009)(316002)(26005)(53546011)(83380400001)(66946007)(66476007)(6506007)(2616005)(66556008)(5660300002)(4326008)(2906002)(8936002)(8676002)(44832011)(6512007)(31686004)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTZSV0sxYXdtS1pSZmNnS0x2TnFQSDhBekRJTTdRNmYxQldlVFhqY05YVVpQ?=
 =?utf-8?B?R1dUTUdJV2RVKzVRREYva2RzQkNuZGxvbTdxMUZHTnNjdEREeVBpM0J4RGNC?=
 =?utf-8?B?Nk13M0NEYVdNcThJSmU1cGx5RHJYUmN3aFJnZHZOYi8zbEdDLytCUzFkS2Y5?=
 =?utf-8?B?Y0M0UUFCaVl1eDhjelVibGpZQmxZUTNSMnU3QmxmTUR0emhXZDhaajVKVnFv?=
 =?utf-8?B?Z3NXWWlTcTJaVkR2VHhuQUdlSTY4Z1JVREtMeWlyK0g1dGZ5b29UYWhOc0c0?=
 =?utf-8?B?R21yTGUrUlM3Qm1JRm1EU0xWYUhrY3VUd21OeWZrY3N3bDBsajJoS1JScWgv?=
 =?utf-8?B?R1Mzd0w3ZWRubFp3ZTZFOEJXcnFNNWM5YkRJWW82UGFMYlQ1VmV3UUxvbG9Q?=
 =?utf-8?B?Q25hUWJsSVpjYzJ4MThOTmVDV2JENFRVRk1lVDlOMG5IOXVzQ3NYUVVJQTlT?=
 =?utf-8?B?OCt1VEZrTWRjbXpSQk12ZEYrSWtZYmEwUU5ET1hybHZMNjJjaDh1MnQ0aU5X?=
 =?utf-8?B?SkJnL1VUTzdVSDh3dUd0VllIVmV0bTlXWHBIcWUwWm1aUTcwV1lVT2cvbDFE?=
 =?utf-8?B?aVV3RmxMVEQxbVNiOEg3bFBtWi9lbUxiWDZDMXYrU3VHV200eEQ2emdSV3Bl?=
 =?utf-8?B?NHB4cTFiUkJCbkFsbDI4dFJ6V2lVbGZCZG02bnZjbXpxUHMvTUtBM25OdWNk?=
 =?utf-8?B?Mnl6SGxjOUxaK0lsR3VPeEhOYjIxNDlub0ZyL2pVMm9hcktVQTAxUlQxMCsw?=
 =?utf-8?B?ZUkvN3dZT2pJK1VCWHUzSlp6THU5V1lYNml2R3RkNlhvY3gwTTBXQk5pUFpY?=
 =?utf-8?B?aDFyL3RQZkRjcXBJYlFncVcvcTcwWkFyekFheng5UzdPZ2xOMXFUVG9jdXI4?=
 =?utf-8?B?M2NwOS9XQmptbFFXSUw3VVByWUV6anFMZjZoM0tVQ0p5a3ZwaW1mVlhCTXVZ?=
 =?utf-8?B?Y0dTNDhCUURjMTZkTkVpMitYMkl1cG9JaFB6TVBYUVBueXlvMC8xZmV5bkF5?=
 =?utf-8?B?djFRUlNxR1QxUVVpT3E4OURmb3RzWGluK21tRUhGYitSVG5RTDRVTTlIa1Mx?=
 =?utf-8?B?RFpZcEJpbkYyZ2l0UWlqTytsUjVpL2J0aHljSGtmNjBZK215RVBocDh6aDk4?=
 =?utf-8?B?bFlGMnczRWh0dE4xRXRNelJzOFMzSEpjZUpCZEZIN3RpR0JvamtnNXlsQkpW?=
 =?utf-8?B?OUVkcXZlSHpZdFlrUHpEOGdkZGNXU0lUSVg1WFN6TXJJY011dlpuVGxYMkRE?=
 =?utf-8?B?KzRPM1NlYUpGdDR4azBXR2d5ajl3bFYxSDUvOGxReXF5V1lMZk9EMVU1STNL?=
 =?utf-8?B?c3dRSjNzVVFoQ01ZbUZ3Y2VMNXpyRUF3TU9kdzFVekw2UEV2SzdBbmhBVDRj?=
 =?utf-8?B?dkk5aU1hbXpRdGZjOTM0TElHMHRvRGgvQS9hL2Z5cTQzWkUxU3ZGbVpFVklI?=
 =?utf-8?B?RDBkMDl3MVdpU1JLVFd6aWxlbThVd0laaFpWUlI4RVRxU2Mwd2ZsVmd4Y2lu?=
 =?utf-8?B?S2lWdWcyazFjeFVONzhwZU9LUGpoQzJPMEJDVXBHVVBWQTdEaVVBanJDalNS?=
 =?utf-8?B?ZU9PdkpFVElOMCtob0NzamYyR0tMV0dUM3lpUTNFamZXMDkyREhpQU5IU2ls?=
 =?utf-8?B?UzNzQTVZanRQS2RrR0FZYW1TQ00wZ09ieGdPZWFRZEgxZ1Y1SHlWaG40SUJ0?=
 =?utf-8?B?Z2xXUEw1RSthSWZ1S2hFeDZab0J6cHdTTUJmMmF2R0FWUUk2VFlKM2xSTFdn?=
 =?utf-8?B?ZGQ4ZG1yQnZRVnEvY0xBT3pCSVFUWnhYcTJzVHh4VlowSVhLMkgzMyszSEQw?=
 =?utf-8?B?ZmJHNUVnVmF3SUU1KzliTjY0N1QwZHJCNEk0YlkrNHhPcDRJN3VWQkM1bG1p?=
 =?utf-8?B?a1YySmRkbU0wQk96NzRuTlFWMURGS1BhQW1NbTQxa3lTUTE3ckdEVzM2aUhj?=
 =?utf-8?B?d0hqWkdNM1owVm1JU1FHNEZWNHlnV1JUcEJZNXNYY2xvKytXTEhnLzlFbmx5?=
 =?utf-8?B?bWw1anh1VUYxUXVTWWtOTmhKN3BBMytNaUszcFpaR1pXYzFZU3BIa3RGWnAy?=
 =?utf-8?B?UktSOUcyQ3gzc2Q3TVJYQ2xiYk9sT2QwRllCY0NpR1R6RmRCZDdRVnlMT05F?=
 =?utf-8?Q?R2WlhF0xfJVi6tTKLujcXm42g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c4307a-8aef-4025-bba9-08dbec48e9f8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 17:23:31.3890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoCHX/qcGkxQAzAaquGglj77aJ7AIOyrgkJFsTUP+hiHjioSubNM+khPwFBf5H0jrLhB1TumGF+uvkNkLVxB2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9235

Jason,


On 11/7/2023 7:01 PM, Jason Gunthorpe wrote:
> On Tue, Nov 07, 2023 at 11:43:10AM +0530, Vasant Hegde wrote:
>>> You should be moving to a direction where the ops->attach_dev does
>>> exactly one update to the DTE. It loads the new correct value of the
>>> DTE that attach_dev is asking to create. All this repeated touching of
>>> the DTE during the attach_dev flow is sort of a functional bug, or at
>>> least a sub-optimal implementation of the API.
>>
>> We are not touching DTE repeatedly. We do need to detach device (so touch DTE)
>> and then attach device to domain (another touch).
> 
> Twice is repeatedly. Again look at how smmuv3 turned out, there is
> exactly *ONE* DTE update per op callback.

I have fixed setup/free gcr3 table path. As mentioned I have added cleaning up
do_attach/detach() path to TODO list. That will be outside this series.

>  
>> I am not confident to make change like above (i. e. just attaching device to new
>> domain and then destroying old domain related data) in this series. Those
>> improvements can be looked into it later.
> 
> Sure, but you need to start organizing the code to work like this with
> the proper layers and division of work.

Ok.

-Vasant
