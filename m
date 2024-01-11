Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4E1184D
	for <iommu@lists.linux.dev>; Thu, 11 Jan 2024 05:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pm16AYJq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMJ3EWE/qy9+ywVJcZWmjHMYUmsL/jnuZ2tcJIv5KcOsaiHPF/ZIhVXVpUuwLXkItK+g8Pdxl+S7MAXRvFZhp+MahPSw6lRouAYzkRc5AnWG0n1DTE6oCB1oHO19uUkfGKcl71dODGcfqelH9aaSv5uINvotP80EDFayNkrb5P32OmnxLeVglW3zJjjgi76zBsS400pfG8GoDMyXRJs0iaWwloQbN4eSj2Qpimz0JDBWjUslov69VR9sPo02wwySRAYc1CyvcIvQ/hfbzz3n41tPveDKLpBE4sO5UGiugz830QQ4sLDhVIUtpCQhNLBClq+oaZYnLlLsMjjUKoQEmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTnBT411xHNRLSYipqYyHlZMuLfClu84aXScsUAMxcQ=;
 b=Q74Q0TrsdB3KHzbvOsMtOdzc+hkVBvpHd/3e5lMDdMnbMRjZUzA21ia6ha1MMIIFAWiP0aS3x/dUO75bmq78N7+KJO5djzLLvpicoTUeUJ2aqbRSuMavcpaNyhSdHMsxCv6KCrnmVbLJx1ardncPeFxhaO3IkZECi8TO4Vi29/WGty4PeG4Wy6kg/MAo0elchMkFrvsPGqq1LaXmU+M5RCoDxmw6aZd0Z8P361/WgEp0k63ZGyK3aDnYBEcCwchmhg0vDQhi0M1Su1HbbSVTWO5rbydV25AN2Vz7FlZ1Q690pKw0uBKb40/g0ObPZmzumDEg7WEYgdUQTf02YBFpYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTnBT411xHNRLSYipqYyHlZMuLfClu84aXScsUAMxcQ=;
 b=pm16AYJqeaBSMqTWx1Rl3vySjrNO4yXUW47oVQfy2LD6DESuc5vYPTQ6X49SpSegVJmJ77iKQbO0G8sRjkk8AzN+4fQS75OiFAToZTdIaydpveu+2Uo5rto0lZZO+vc4RJlYih4M5cQ8738OlsBKi5sTSGFaqWEGZjIJfXxJx9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 05:18:40 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 05:18:39 +0000
Message-ID: <aa148970-2664-5779-d761-2a3185d7e620@amd.com>
Date: Thu, 11 Jan 2024 10:48:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 13/14] iommu: Add ops->domain_alloc_sva()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20231221111558.64652-1-vasant.hegde@amd.com>
 <20231221111558.64652-14-vasant.hegde@amd.com>
 <20240109175049.GA502542@nvidia.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240109175049.GA502542@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::22) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN2PR12MB4270:EE_
X-MS-Office365-Filtering-Correlation-Id: ec7f74b5-0b0e-451c-2ee3-08dc1264c542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QDsq2uu85xxlOq7FFLKNDtGApF8YCa4dP+k4iahZcWsu9LdEr9FJ1Bu4CHlaA049ZOnRhfXNGYshWEaGy8uE0hETuMfY3kV18U08S8klCxvjTW8ByW3WI5cJY05p1Z6VKu94qrgjzBlJGBRaR5GtJEs6DVPFoY6n5lvXy1E9BCrlRTAAmfH8qOzQ32osOZ2roJ1G4vuHff2pcIPWXTVQfTCycUKQUUMzT1pIOIKIEZVtObmQecOEVexbITcCaDIpWg0pkrFunEudbUM+8cZBqKsfLyVyeAHbz1cl1Sel4HpgBAlvjkHxZsnq0RpO3QYbOonqUUIjWGw1trbxH+jvcWU3TUb+OTcbf4++NuZAFs9wJkcAtVg/gmc60xITEbAExolT0+IIz6sXCn0Vt+2AI6+DiG/UT/wxxHaou+kd0XQj06qlwESxLlvpjm0DHcrOjj7l8SP0wjf58sXcUrcR2NpRrysFWBtNx4kumyKb8OHRARpb9u3RPQ14YpkiEY9TBGAovCFqib7XulujCpHusa9VQ9wH3yYkHCjp5aWCx5aR1+CHsDJP5UWiYjU9M4JjkIIzgZLfk7fDLI6GOSMg5hl/9SBriBaaPEW23e7eOLIApxaZ1/WwHhhHZ9TGuFXa98POY1hxoUuBbZDaRyUYag==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31686004)(6512007)(478600001)(53546011)(6506007)(2616005)(26005)(6666004)(38100700002)(31696002)(86362001)(36756003)(41300700001)(2906002)(44832011)(5660300002)(4326008)(66946007)(6486002)(6916009)(66476007)(66556008)(8676002)(8936002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SURLL3JpRVpPeWRROGtlVzBEUDdXenV4LzBUeVhPalU2Y0U2NHdoQ1lUVTJS?=
 =?utf-8?B?T25iNWlSaEs5Z0Q0SUd3VWVaeGJqSzQvNUxKc3F5QWVFQWhzbU9VZERzWGNl?=
 =?utf-8?B?SFRYNkZ5T1FaV1VJSUtHREpNRWZQNkcvRllaa2dGVmVqN0xoNldZbm9tRkdM?=
 =?utf-8?B?KzlpZVozbEF6YURVQkV0VGJzRzd4TTVTNlFMOXh3czViMzhqc045UW1aTzZo?=
 =?utf-8?B?bUpzMlM3bmhyeTE0c2N0eWx1TFFCRDUzdW5PVHdyc1NhOWR6WEhSMkZNS2lz?=
 =?utf-8?B?TStrcERUeFpYNS9hUTBDalRzZ1J3SEd6U3YrZXA5Ynh3S2tUeUJIOUgvM1VZ?=
 =?utf-8?B?ZitGZTIzcXpQU2UwR0VLMGJlSmptWmF5VG8rUTFJaHlKa1FwUzFXZkZVdTV4?=
 =?utf-8?B?MkljVW84QzZhbWhsUmVaRUIxWUh1bi9NbTBJb0tWNkxiaFVJenI4MXQvLzlB?=
 =?utf-8?B?di9La2hSOHY4NjJTdjBlZnd2UmJoelhzbFkzcVlHMWF4YWdpNVhMZmtwdlN5?=
 =?utf-8?B?Z3lmc0ZJTHNVTlRxUnZCZWE0L0FaMzh4bE53OTdMM0lJcXlCRThKc09mNjNQ?=
 =?utf-8?B?MnUyNkVYZ2YwQjBhVVlQOXQyZVRMUUVTV3Y3a3IrMlV0eGhYdVdWSzhGNmZr?=
 =?utf-8?B?WkpwRU91aGpJWEFFUkRvL0N0TVE4cXl1MS9LbFdSZ0YyMHBSdmk4V2NmbmFQ?=
 =?utf-8?B?TXVBVnJ3ZFMxS2JmUGtZaW16YkFObGRMdGRLOTZ0Ri95U1hWL0szNytoVko1?=
 =?utf-8?B?Mlp1RkFzS0FyeU15Q1RTakJlNVlMd3dNUklIb1JiZ2NRRmFYczJyaGZyMlRh?=
 =?utf-8?B?VzVuRDVPOW15MDZkQUdyMkYvdVhaaWVDME1tM3Q2NjFWK1cyWGZxVzJFdzAx?=
 =?utf-8?B?UEtvZURYOTNkK2RYM2RBOXU4dHZNNFJGNUI5RUFESE8ySzMyekcvTFpjWjQy?=
 =?utf-8?B?SzRrTU1GQVpnK3kxYnhUaytZR3ZqREpFeHBlbmtwU0VZaFZOeHdEdWsySFdH?=
 =?utf-8?B?NVRndVZOMVNEK3F2WC9IZStVZHdmWWl3bkRIQndjZGtBTkhybVVlYkhOc21z?=
 =?utf-8?B?TDIyeGhrZXptVjFPYUFaTVYwYWJNc09DZit5czhPdWVRMGlHZEVmUlRGQVNx?=
 =?utf-8?B?UTFNYXFXUGNBc0hyWDBJNWhUVElaaTE1dFdVUlZTMjJXaEUreTBDeTNkd2xI?=
 =?utf-8?B?VWJFUlBoenJ2K3JQbldPMmVzWTE4SWJpRWh0b3B0R1R5eDEzRUh5amlMeTVz?=
 =?utf-8?B?TXVmWDRDV3BLNjFvZy9WRVUxZVFYalpKVldrZzlwdWlpb1hZQXkrc2htUFk3?=
 =?utf-8?B?Q1AyY2ZyMWF1RkRUZUhlT3R1dWN4dHBXRE0zVnVmbzFheDc1Wld2UVZ5MXhv?=
 =?utf-8?B?UEFtbTUyNDJYVDdMNVAwZGIrLzVwREZiNFBTY2Z0NWFYNitmb2RRd3JPU1ha?=
 =?utf-8?B?cXQ4TEdPNXcxRyszUWdDalowOUJLVjBMUDVrN0RCZ3A2UENWajJ2emc0WUdi?=
 =?utf-8?B?SWFrQzZXYll1Y1lOVDZHbU41WEQwSG4zV1psZHpqK2NEaWhnUE9wMDFicStz?=
 =?utf-8?B?L2xXd3VFWHJCNGJwczhWM2ZmNnFFREVNR215MUM2TTd1UHh2SXBhcUxwWG5i?=
 =?utf-8?B?QmZTd3VMS2cvQWtpZnBidVR4cExjclhZUDcva0lybUd6QzF4dUZvc2NDNUhW?=
 =?utf-8?B?Ty9GSjIzeDJvamlPSnpDSDR1Y21MeEhsUW9KVS9scEdpQmZLSUM1ZU5lcHlO?=
 =?utf-8?B?TzltS3Y5V1FyMmJuUFR3UEtPVUJ0M3A1T3lLMG4wbklCakdBTUVTWEZmS1FJ?=
 =?utf-8?B?aVhnRXNrVHpZeUpCZFhzMHRYSVN1TGlZVmFzM3BxbTIrRk5vTFEvcHA1MjBC?=
 =?utf-8?B?cGs4U2tYb0UxZ1llWGR0ZHBybzMyUGV1VVgrZzc2cHJPT1dSYWljNVExdVBr?=
 =?utf-8?B?ZENnb1VGakZ2QlUyV0YrcnExcStZeVNVZllZcFZFbU4xYWFNY2gvK2VYNUpo?=
 =?utf-8?B?cjIwQ1Nta0FqQXVSOGJyaWJwM25ESXFyVUVEc002dUZWMjdvczlWdVFXcWFR?=
 =?utf-8?B?ZDd6b2s0bVJ6QnVZV3N3SW9MT0VFdmo0SjdsbVFrTTVQK2h4aTFVanlIWk0y?=
 =?utf-8?Q?lNji2iEW0pEUrm8YiNoSZMC3O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7f74b5-0b0e-451c-2ee3-08dc1264c542
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 05:18:39.8605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APHhdrivozUNxRqghtI8UAVxgFn5Vfp4mMCNl+dQdDmmJ/rHapvR9p7p6JPczkOS2f3K/1TljqlRlCNFP4+tfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270



On 1/9/2024 11:20 PM, Jason Gunthorpe wrote:
> On Thu, Dec 21, 2023 at 11:15:57AM +0000, Vasant Hegde wrote:
>> @@ -270,11 +270,18 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>>  	const struct iommu_ops *ops = dev_iommu_ops(dev);
>>  	struct iommu_domain *domain;
>>  
>> -	domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
>> -	if (!domain)
>> -		return NULL;
>> +	if (ops->domain_alloc_sva) {
>> +		domain = ops->domain_alloc_sva(dev, mm);
>> +		if (IS_ERR(domain))
>> +			return domain;
>> +	} else {
>> +		domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
>> +		if (!domain)
>> +			return ERR_PTR(-ENOMEM);
>> +	}
>>  
>>  	domain->type = IOMMU_DOMAIN_SVA;
>> +	domain->owner = ops;
>>  	mmgrab(mm);
>>  	domain->mm = mm;
>>  	domain->iopf_handler = iommu_sva_iopf_handler;
> 
> This hunk is in commit 7be423336ecc ("iommu: Set owner token to SVA
> domain") which is already merged to Joerg's tree. Make sure to drop it
> from this patch when you rebase

Right. I will rebase and drop this hunk in next iteration.

-Vasant
