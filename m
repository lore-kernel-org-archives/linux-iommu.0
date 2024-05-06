Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2CB3BBE8
	for <iommu@lists.linux.dev>; Mon,  6 May 2024 06:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714977794; cv=fail; b=rC0/GB/J1MTHhUuWAH7saG9rrHq5H79jKxZOplQJnshqQJZnGlzMg1AtqCcscykZrwTfhCaPPxifKZ4ITjo8BFHeJfiLCS/SbWfEUY/5jXoEGctYfIE2K3py7TbHYxYd8l7NPu1bU5U7ePokldJ+a+bLKhGSPKjlnoEUk2GPVAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714977794; c=relaxed/simple;
	bh=jh5XE/pYXY9uwnFWJkK/vyrbxN/1mghkpwynXCXareg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WaWdYiwVb2ADjys/fJJ5EtfTCoJ2mmMiBcJUzPMs98XPXSumRNL63Z1BGqkdBYfoW+uleWBXIXQ9RLgmzvnNRqtpFNkv6ZdfNUj/2LQ0n8btnK3POoySl0wvHmUG+KUwFO8hyh/hhpgQkdc8ssN+UKMlC7c9F7mq89cA7K6jO2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=czN1V+T1; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="czN1V+T1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaQnlgfIP++RMMiqHiznolz3QQquDpkHr9EJBiNTFjb5IbuAUketg46XUk0AaQBljh8wyx9mzp5vADviaG82AX8GKTtlUrK8tnzqOBBb8oak87AYBaMgKQJJsbHCRfNKiFR6AR/Ytb0D1j9eDHMpKqFFr6TVE0TPKcWrVCSYSPjZVLi5VGs7huy2srra/kTvmxbUoiguAIzCq+PpdDpv2Pen5ZNzdRYUDH5/sqJQrT4Z7o9ejajNJZoOahcAAXKkfSfQaEJZImB0sED9fSQeji/Biz+ugIUpgUJ9Y9zErMqZCUIJ4XAoJnGxaqpXgSr8DACvRyKv4HEYekY8xhGuDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/+EN2z6GdB+R1RUbLJMLU9JY/ouoVvf8TpajrxNXVw=;
 b=NqITuLnyQqSnyhCRuESxpU4UaWr2068x6Tg3Md+a7EDBRa4d+pgMHIgPh4UOt4bQdsRitXf3medfhl2coDC2yA4JvH2f14qhfxMqlvPkO7SB3CDZH1rdusy2Db5yePF/ZxQv6XpHdxogFkUBE8KWZ90RtEq3G12k+gW+TiRzAXV7HufGFM8AK6Am9ppZp9UEoVY4FlufA93yolH765ToVEPdwNAOpBR770HTMCn3FxMWpvrJpg0BFkhbqHEhkjpVKxBNfh/+ury1fmh+DoHmL31Qj+HWyLSflall/dEdSuMvA6kzxipKhD0lNXZH09tzSffUuWGeUyhDclTsyR2asA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/+EN2z6GdB+R1RUbLJMLU9JY/ouoVvf8TpajrxNXVw=;
 b=czN1V+T1NLf73DgmMu19ZKFak8SllrE7INmnAuwWS3mluIMndF0vJdaUVVaq8/1srBB/EbchT/jELZ/nRpqg3eKky9PohOvPAHpZCMs0E5kxEJMyDe+9l+eMemkSNVqUq9s6Yy4bJKD2emDu6cZl/BRxd3YfG0gkura5p7Mlr5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 06:43:09 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 06:43:09 +0000
Message-ID: <70265637-b583-4281-a958-c052ca803432@amd.com>
Date: Mon, 6 May 2024 12:12:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/15] iommu/amd: Setup GCR3 table in advance if domain
 is SVA capable
To: Joerg Roedel <joro@8bytes.org>, Klara Modin <klarasmodin@gmail.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com, wei.huang2@amd.com,
 jsnitsel@redhat.com, jgg@ziepe.ca, Jason Gunthorpe <jgg@nvidia.com>
References: <20240418103400.6229-1-vasant.hegde@amd.com>
 <20240418103400.6229-8-vasant.hegde@amd.com>
 <333e6eb6-361c-4afb-8107-2573324bf689@gmail.com>
 <ZjS7uFRQ7_o1HUjl@8bytes.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZjS7uFRQ7_o1HUjl@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::18) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 065eb784-1372-4356-8888-08dc6d97caca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFhOKzFYZVp1Z1VRVm1zSHdxQkYwZ2I0aWR1WGZsbEkvWGxEVi91UzZ5K2dx?=
 =?utf-8?B?R0M1bXVldVorRVZFQ0ZuOWcxRzlzeUxxZCtJVWY0VzNYNkIxamxwZ1VqcDhT?=
 =?utf-8?B?MDZtOTQ5dThPZHFYNTcxN3A1TWNsMDdKK2tjWFFDdHhEMEppVVVqc3E5bUFJ?=
 =?utf-8?B?WS8rbW9nbVJTekt1Z1BRVmVlaTk0blJVQWdqbGdUcEU5VUxrK1JCQStGL3NP?=
 =?utf-8?B?TFZES0dTcklsRmJCQy9KR3YyQmozbVFXSjlGRjh1UUhrekgvd2ZRQkVNUlV5?=
 =?utf-8?B?eHR3MjJVYVdKSUJoMkNOaWVGMjUwblY2eDFvUCt0bzduSE9iOWRzZkJla0tn?=
 =?utf-8?B?VzJ4NFBGeGxNbjlISFNsWWk4dzZYRC9rUzFuak4vZmhsQy9YTUlFRFZxZUpv?=
 =?utf-8?B?Uy83V2Q4VWxqWWY4S0hXeiswNnZLTTZBYlM2SDNnc0w0UllwVlUxNW9pa3Jp?=
 =?utf-8?B?eVFFb3AvdFZocDFVcGdvTWxCQUNjR0NBOEs1YTN2dEdPUy96UHdFOVVmNnpR?=
 =?utf-8?B?anVKdW50Qi83RDVNcjdHeXUvdWJ6Nmp5ekExNXBTemM3OHlmdE10MFhBRHpM?=
 =?utf-8?B?VHJpRzVuTCtHdUpJZTJ3bFkyNms4dzdQNmZabllydXk0MVlNVitTVDJtSjJn?=
 =?utf-8?B?Y2RmWEdqRTVMT3Q1Z2M4MU5RK08wK2w4QzB3Y2ZwVDBXdU5nTmJkMkpRU1FK?=
 =?utf-8?B?WkZFUSt6TklOQ2JmRXhOSkhVMVRvZVpqNzF5ZHJna1ZLVVlEdEhVQzNUbStX?=
 =?utf-8?B?REw1aVNLb0NhdHVhTHQvWGg0MDdGRk9pRVBzdC9CVVBCOUtlL2d4NVk4cFpz?=
 =?utf-8?B?ZVE4YXo0clNnanozZ05yYiszNlQ3L1UwUmh2SjE2V2pSbjA5UExlek9oSW5Y?=
 =?utf-8?B?YTRObHE3K3FkMTB5ckJhS1A1ZnEzSDBjeVBET1hmQ1VBMW1TZDIrS1BlTDBC?=
 =?utf-8?B?QzhaSlp1SG91MTNhbldGYit5ZVRrRk9TcTQ3dXpKRk9WMUdYZmliZnptRzVV?=
 =?utf-8?B?RXVnOEVDbGU3MU14Z3VzRHBwdDFaYWpsYm10clNTaElqajVOU0RQeTB4RXpw?=
 =?utf-8?B?NzJmMkY0RUpYc0FQVWJUMStXZlFzelIrQUNmVzhhOC9TYWRkcEhORCs5TURy?=
 =?utf-8?B?N0QwSFRDdUpWbFZkSnQraWNjYjQyVmlkVVRXb1BpNlV1eUYrWEgvQ3NLWEVK?=
 =?utf-8?B?Q3pPTk03RTNtRVFvUWJFaEdGd1NpQXpjUURCYUVQaHZ3a3ZWSHdLSmk3cTFP?=
 =?utf-8?B?dmxyN0cvTk1CNmhTLzZlMjN1QlkrMUkxenpEYzg1dHlJV3RJQVZQUSs4Smkz?=
 =?utf-8?B?Q2hGc0g4aWdzOFlaSGZCNEdTeGJOSE1hYXh6aTl3L3NlZWYzQ05paHd6SGpr?=
 =?utf-8?B?T3I5MnJCbS9ES0tQRGxJTks5cENJWGY3K2ZGbXpVdFhIZWsrengxbDNyVXdl?=
 =?utf-8?B?alZsd3liVkpUWXFxblBRNVVLOEJPUS9ZYWd6dk5YdVQ3YUg4NmJ2WDNCRmdm?=
 =?utf-8?B?anF6VDBCQ0xFeDVUd0xLOFN5Yjkyb2ZraERseHVUeFptSDk2UmwzYW0ycFR4?=
 =?utf-8?B?ZEcwOXJlNXdZeU1JODhlUWpZZmFBRzIwUTI0VXdkdlQ3RGd1Rm4xUUpOc3Fu?=
 =?utf-8?B?WGl4MjVHRWFzNERDd0NReldZcWJYVUliVEJxTzlocnlmWDdmVkV1SWNOa1o3?=
 =?utf-8?B?V1h2enpyS0tVM1hLTnV0NEhtbldFOGEzOVpVcW9MMFhYbXdBUytOTFR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkJsVUY5bHdUZGR6U2R2QnlFMURkUG9aemhETUFaV0V2ZXJOaUc2TC8raDdz?=
 =?utf-8?B?MG1KQm1rTmtSUHlFRHc2dlk3TnZHanNaR1NydUZZTnRjV3lQQnFPRmQreXpz?=
 =?utf-8?B?azJpQlZGdFArSkU4LzBvaXJPQXBkRWZoandKLy9pa2I1djVLNEVhdXRaL2xz?=
 =?utf-8?B?eld5WGNaaDZITENBam03TkRxUUEyR25udjRtMHFQL1FDaFZnRU1ONWptdXk2?=
 =?utf-8?B?RkRxb1VqQTA0M0J0Z0RXS29EYkZvTmxxdlp2MHZGWFNOTjRTbE05bTFxUWdt?=
 =?utf-8?B?eDNLc1Q2MjQzY1RXZVF6VFNGRmFkS2ttSkRtcE1INUdsaHhueW1Eb1FwRE1a?=
 =?utf-8?B?NVBtWlF3dU5oUHB4SzRxRWFtdnJZT1dpcnc3ZmR3ZUR5RVc3MUhlckY4dk5j?=
 =?utf-8?B?K3J6YXdncWlhUDd0MXNsN1RPbnRvOTJjT01rdHdlTkRkWTFGaHdPcTNyT3hE?=
 =?utf-8?B?WUFoZUZwamRlWVo2M1ZnU2oyWGxESVFOQ1J6L1Y2dzlqOFA0N2RGa2hoaXJN?=
 =?utf-8?B?NFN6WE1VRTgvOUZvSFk1QThIZVZDMkFucE0zZlJXb0dYRUZKcnBkaGNHQm5y?=
 =?utf-8?B?VkMvVVBkdEM0UU5vSGRsUWlNc05Ib2c5NHdnZHcxc0kzY25PcjFNaVJjSDZE?=
 =?utf-8?B?dlk0eENhWTZrendkSHlHWXpKLzhHeFRLUDU3MGZqTVBXSkJVci9LYTBrVGc0?=
 =?utf-8?B?dCswMWJMWEROdkVhNUV3VC9xd2NYQllPb3JhbGtRR3JWRVRERUVIREZFVlZ6?=
 =?utf-8?B?MDRqVVJxcW9iMGYyK25FUGMxOVB5NE9PZWJ4V1BXcE9yK1N1WWlTYTdNSTl6?=
 =?utf-8?B?dHJEWjRrbmxTc24zUFFwbGlDUUJKOEo5TW1OT29Qa0pkTUJ4cSs5cEZ1MndD?=
 =?utf-8?B?NlhvMTg4WmVWQzBvYjhKVTJRUVlHOXJHRWgrOGxIN09sWVlmV3NKQTZ2ckJu?=
 =?utf-8?B?T3FqR29tSnFsWlVjcnkvcWhuNmhiVjBkTlIreWxxMmlNWlhjbk9LQlliL1Rn?=
 =?utf-8?B?QTVpRjRRaXNDV29HZG5BT3lXOTBsQU1hYkpXYmJDbjg5czI3UWNEZnF3djNP?=
 =?utf-8?B?Vkp4QjhWR3hYSjVnc09VTy9KWHdyMXhrSFJ4ZXExTGx0KzNLTS9kUVcwcWJz?=
 =?utf-8?B?ekN3Z2g4TWNHcVlQSEcrQjNXd0dmQWl6T3BCbGN5SWtSd0tFOXpRYnd2cVUw?=
 =?utf-8?B?Q1ovaTdWVXFCZzlwaGlteTgrRk8xdDdZeGtJTytvZzRYYWJzV091MUZLVHpt?=
 =?utf-8?B?a3A0UnlMdkJLTDZYQW1SbmYvN2ZYY0FUaGxROXg4Vy9oTFpTWmxubEpvcTZG?=
 =?utf-8?B?OGVnTFJPRzBGWEhWSURhdW1pcFE1dXVvdVpTTWhqV0k1Z0tzYlJZZ3BINTRL?=
 =?utf-8?B?T2c2WU96YnMrRmlDdFNLSnBVWEEydFVrVjNLQ2NWUTFWOWRwMm54R2txSGtx?=
 =?utf-8?B?VGdQZ3VTVEhOQ0UraFc2UkFIeWFwWnpjdlJIbGt5WEp4dU5vOWNOdjQxcTZJ?=
 =?utf-8?B?dWhaZ2NNSVBmWGpraTBZWG1UMDk3c0tnOFVkaXVrZzJhOWhsUTFOTEJwZ1ho?=
 =?utf-8?B?ZndjNnpmaGJ2MGhaRFFEZmozeTh0WWhuK2ppQllodE1ZNFhHWFB2aWVGQjBw?=
 =?utf-8?B?TnF5UloyN2VsR2VqNFk3cUp1Nm9WNTZ5UG9tQU1FbWdjTUlpbklZa0N4SWt3?=
 =?utf-8?B?Rk00Q01xNWZSQ0c4YlFwenFsbjdTTFN4cE1KcFR0bGNBNUQra0c0Zmt2UjUw?=
 =?utf-8?B?Tk9KOHNpYnMrQ0lObzdRRms5UkhzeXVwMTJWSkFCSU9NaEhWOHFYUTJvNUtz?=
 =?utf-8?B?NWdSa0E1T1lhOWVKeXhHaDFyL3F6SUJyVjZ0cEZrTWMxQVV1aG9yTXZXZllu?=
 =?utf-8?B?UXJUUGY3eUdwUkpFMkJkRS9GaVBLRHJ3RTV3V3lXVWczRUM5UlFLMWhXZGkv?=
 =?utf-8?B?NFIzTk1jWXFQVnJoK2ltUDlUb0VTTFhCTHVRaWtveTBQaVlBbHZzQllmQnlN?=
 =?utf-8?B?K3ZRWWw4aHRYZTVFckFtTlhaeHd4a0RGRjdvekJxVjZrSjZSdE9QOVJROERX?=
 =?utf-8?B?bE9ob0lJOExjbUZPenFQT0N3VVowTzZNVWhEQUJTM3k0RkpzRkpIVnVFbFNy?=
 =?utf-8?Q?96Fl6p1Ca1yE+tXUM5Lu0jYwq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 065eb784-1372-4356-8888-08dc6d97caca
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 06:43:09.3214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UN/BxCIyqqUcbMTAkVI1OIsds90hVu5vB9N7+L626wyzsLXqyMtOh1ev9vLpY2Rzu0+zzh7iW6zxAKFgPiDS1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327

Hi Joerg,

On 5/3/2024 3:56 PM, Joerg Roedel wrote:
> Vasant,
> 
> On Thu, May 02, 2024 at 03:16:18PM +0200, Klara Modin wrote:
>> This change seems to interact poorly with the amdgpu driver. It fails to
>> initialize properly (monitors go to sleep).
> 
> Can you have a look please? We need to resolve this otherwise I have to
> exclude the x86/amd branch from next, as I can not send code with known
> regressions upstream.

Sorry for the delay. I was on vacation last week.

Looking into the report nothing strikes me immediately. DTE setting looks to be
fine. I will see if I can find a system internally to reproduce. Will update soon.

-Vasant

