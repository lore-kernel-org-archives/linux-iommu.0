Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC1D1E04BB
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730973660; cv=fail; b=sLasQek+4LL1FlQAQ2OjxkzFpv2IW5/4xkvRi1ICH7Age2oCmRoZXKfm8GShPxFsMbcuFsO743ZjAeXQ8cmK+WfvxLI9xPt6vxoO7FjiPUIeAC+wMzoaBcq7MK2xbHF66tFT9c/ZG6EpN1QeNnxu4poYYaeSTh2vdg/Um2Isuxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730973660; c=relaxed/simple;
	bh=KJYgynh63owlFHKcXhDBeiNEESrmqIBCDYjXanzZQcw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Am1nOSR4a8pDiz2MSZrNFqIc+uDdLzEUnnYxDuHDrKo5h7BUqH5PJVwwMvWunX/jx60VEDU7T78/5o3q4yXGtIXxECzj1zh+ZD2DogDOzyx4V3lvbWpInr5ffL9KMx6yLrQdv0aaMFYooU5YcTdP6kEp6zYCjAWn1vEuggbGHcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IS4axRcN; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IS4axRcN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3erMSO3rwO8FLjBxw5wRtxPZHDUr9i/EYrvCXOjzyatF8xAfgoECAyx/mbVIvdALziOyj3OcooennRO+ASOjnyBpXmkyoow77NaiEZTGE85lfl+AKWx8MqVcJL7xeA/IKc8KGk+4M+Ut3aHcOK4J2BAG+eR6tKWqcRH+qooIOnzVdP0/1jV9nPJLsM3CfE0JXyLujpoY0iepAlJ7eTkRoxJcR106lCVbzNnnpdfMp9EBMr0XAODTRdGqjsG624jDIS93dxjKGbENuxb2V2a3r+uaY6yKoRfYgRNkoxgrJVdlMyQaKXkklqzQTRuv4G/GVerH++Y6pminLc7hPFMuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6t+icx6UDParUf8buRlEufktS5kMK3TaUu+Qih35ztY=;
 b=VFForIT6qHQSKUxW1cikxgCO+Qgs6oMvpQHBJb5A8tG7LV1ypuj5omMufqqxBnw+BM3Dzebnas6G7OIU4ClcUc9v7iT5KtsW85D1adWn+KqWT2K/UgSTNmWPRQHltPIgRXbX7/ex4e3IGqXtMloxx+2alYtjVCk/lKS7jTpsqMJ/TxTVoi84Trqjvv94EY/b51l/d5CCs3TSt/O1L1byfrGYAwtlphWhPDJn7psrANdnkZ3W90s1xvktgUcXYYIjlOQixtDwKmhgTpVXfqJf/repa7B3CKbyYO42ez5EuJRiFKorknisNs6NpHlEmqChnhGB/ZvQ0tkp+qrhr+G7LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6t+icx6UDParUf8buRlEufktS5kMK3TaUu+Qih35ztY=;
 b=IS4axRcNhtyq8k9h061Axv/vMIDxmOf1OGkPW9lHExzpCCrixX5QKRZypjfTRdHuWQC3jSvtTfOKFNglcA4PtNaUX69yuXNS98l6WYhNvlvIbXKtRa4D/1XTHtnjZUblEX/o69iV5fLRAIrfv1ucUpfqflUJtgZRXxxW929LAaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DM6PR12MB4339.namprd12.prod.outlook.com (2603:10b6:5:2af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 10:00:56 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 10:00:56 +0000
Message-ID: <5ff5b402-95c4-408a-99f0-2f6ea4e617b8@amd.com>
Date: Thu, 7 Nov 2024 21:00:50 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH V7 6/9] iommufd: pfn reader for file mappings
Content-Language: en-US
To: Steven Sistare <steven.sistare@oracle.com>, iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
 <1729861919-234514-7-git-send-email-steven.sistare@oracle.com>
 <8f2fadc0-1872-49db-83aa-314352adbb6a@amd.com>
 <7788773d-471d-48ad-9f9c-ddd5671b26e5@amd.com>
 <2bbfb5fa-20e5-4935-b52d-73b5186c6123@oracle.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <2bbfb5fa-20e5-4935-b52d-73b5186c6123@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY5P300CA0080.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:247::14) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DM6PR12MB4339:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a7d8fe3-5f2b-4cc7-00bf-08dcff131257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHNzMnVJU2ZFLzZwVFFBUEQ0dUM1cGt2NFlWWmUrdUVJRVExcjdvdXNSa2hw?=
 =?utf-8?B?bm5RbjhCL29pU3BNNytlZEtzM1J0eEpseWdGejZOYlpIOWxGL1gxWE81QzhD?=
 =?utf-8?B?M1kwcmhZekpuQzR1UVZvTjZ2akE5VzBxMmE5aFVTWHlucFdzNjRaN05qQjRX?=
 =?utf-8?B?M0U2ajNYZ0hCbXVLRzYwMng4R0hoc0RyRCt0SDdndkoxcE1XU0I0L05MaTBS?=
 =?utf-8?B?R2ljWitvU2xqRmQ0b3NWTytkM1pkYU5wamtkWktjUnN5eE1oRzRuWHRodkht?=
 =?utf-8?B?SnhXdThmcndYcUNHZGs5cithWjVJaVNCVVBCdm5hcWg1S0xidDhRVjNCMkNK?=
 =?utf-8?B?TmlyVnl0REZnVnlZUFhuTFRWL3hTYkJYVUF3M3ZTU0NyRUQzZFVNNnowaXBL?=
 =?utf-8?B?YmJqREpEZXpZd2p1aWwzTTZJRkdQTUszZ1c4UFU2Y0J4N3RuZXNEWDhiYU50?=
 =?utf-8?B?RFFhU2FnZndmUUo2VTJ6Tk1Dbm9hNys5S0crZWRBT29uM2R6Lzl1ZUlwa2hr?=
 =?utf-8?B?eitUdGd2WEhqaGNrT0tFMnVMK1pQdTM0N3JmTnZGT3k2dDErL1Q4emtodEE2?=
 =?utf-8?B?dTFDZnpZTSt3WXNUTHFaaWdpYlhMRkIyeXpVRU1zcFZQQi9IVWR2VVE5Z3JI?=
 =?utf-8?B?YmJUS1FncDJyRzZDa0FWYWE4R05NcksrcGplOW9uVnM3bGc4RXhZM1JHWW1N?=
 =?utf-8?B?RmE5K0tmck44cjhuODhjZWFyWksxbHJXeDQ1c2ptcUtreEZSd2hFY2JRSERo?=
 =?utf-8?B?K3pFMURvb0NsUFFTTWRJbWp4VWYvVXRQYmNka0kwd21YUTlBSkFKb3ZzVDl6?=
 =?utf-8?B?OEQycjNYODBqQXhna25UOGQ4M05sYTBUdk5UZE9ZbU9DS2JTMEFDeVhOOWpp?=
 =?utf-8?B?eWcwalJSR3p4d3QzYnliNlNSM2ptNHZwclVnVFZSN0F6MGpmcmlWcHRKWnlH?=
 =?utf-8?B?RmlLQkIvQ2RyaHE2b1g1TEwwUlloa2hqZUF2cm9xQlJDWURrdlF3YkpMNWtQ?=
 =?utf-8?B?bzlSVDJxaVFSamZyVUltMTJJdUpITVpzNll5cTNXOXpVcndyL0N4UTVuWjFM?=
 =?utf-8?B?Uzh0Y3NqcWJISkFidm9manJRVktpTEJZSjFJcm1OTURWKzR1RThoY242ZFUv?=
 =?utf-8?B?RXl0eTJqbURDMnl2ZmZWd1F0djBJYjFhaWZkUmdScXpCZlgxK0loeWx5Y1Jo?=
 =?utf-8?B?LzhNQnJ4WTVHUmtaR29vK2ZCajhNMFZucnRlS3g0dzViKzdEZnNUVVVXZ0th?=
 =?utf-8?B?cjZxVHVzOVNHN0FxTnNHTUU1VklkdlgzSHh0YUZqQjE5c0Q0Ulg0SkU0K3M0?=
 =?utf-8?B?cUhETU44K0hKQ0w0eG5QenhUZE9kV2RGckFlOU5jVmZEd3BtSWQ2aC9QSFU5?=
 =?utf-8?B?SFVhNnZUa1Z2NEwzT3pBZWU3eVdsdHgwL3JYRXhCa3d0UEVDcWJZdHIyd2cz?=
 =?utf-8?B?SFVxWU5ETnNaVmR3WFNXNlJSeW1PTzlqZVdEKzRzaDlBQ2Q4WHNxMXlqUmZM?=
 =?utf-8?B?eFZ6WlBCT1FTSnpCWXVFZ2Q5RzQvSVl4b242dTVjTTFOZklKVlZlTkdVZ3Rr?=
 =?utf-8?B?UVArRnMwMklCYnd2K0NqN2ZYVjVya0E2TnZkM2o1VWcwdmM5T1pVNHYybXRD?=
 =?utf-8?B?NzNGZ3JDNUUvZWF3OVk4U2s0MUpNZFc4bWRLK055bU1hbDdsbXROUDB4Zm1H?=
 =?utf-8?B?a0g4Tzd3MlF5NlBNRzFwQS9LazZ6NTZzeXFhMVQ4MzJrODZ2SlFxM3VJV0E3?=
 =?utf-8?Q?AqxUVWaw0XsJu1mu38FSAS10e8BtwUej0NjJfX+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXhTZmI1Z0FEcndJS1dmbjhGNkJ1QXl1WFVwOU8wdEgzcFBxR1J4d3Q3SnBF?=
 =?utf-8?B?a1B2dW9RTmhvTFRmTHhkb1d5cjBhMWZ6ZUZVVXZNa3AyWXVISXdEMUNsQXVY?=
 =?utf-8?B?RGtWZGd1M0JJNEE0SHpjODdtZDZrYTZuODBnVlBJbTdSUEtseXlmNFdES0Nm?=
 =?utf-8?B?SkY3TEdDKzU4OHlHTnRBbndCYnZvY2tsUzFubVpjVk5jaW9jRzhpQXhXWjB6?=
 =?utf-8?B?MHpLb0s2emRpTUxDT3ZERC85WHJJR1kzcG5QREx2b0lkejV0OTVjN1lYMnMr?=
 =?utf-8?B?bzYvMWpreUhQNmsrY1Q4clUrcTZrYUhna3NUSmRTVWxjRFhsc1NBd0UrSGFu?=
 =?utf-8?B?SCt4UDU0b0pmN3RBSHVnbjZ1OS9QcTYyR2J2S3Y5TGRKdHBRNTdkbnVOWEZy?=
 =?utf-8?B?aDlNOUtKSklhdVQxeVNYcHdYbHd4UWUzQm5JaHRHcm1HTXlTeWdmazRyWmtt?=
 =?utf-8?B?UU0xN3YydnQzMTRZb2grLzl3bWJycTZMVkpjM1JkYWxRNlh3K0Q3ckx0UHpI?=
 =?utf-8?B?K1VaZ2tOeXBSRjhmKzd1eEhTbHBya1R3TDZPZU5vQm1SWTRkdzhPelQybFFW?=
 =?utf-8?B?YlB2ZHVSbFpXcDVXSG5PckIrVzcwTzVBVWI1R1Y3UklSUzF0N3VVOEdPa0VF?=
 =?utf-8?B?YnN6UFgwcjZHYTJDZi8ra1ltcVBjUTBySzluRGpFajlHaUNabEZpaFZ6UXp2?=
 =?utf-8?B?NVgycGhwMUJDbXVuczArYlVmemF4VDY0cFBwUFVzK3V3MkxYM1ZyTjFCa3VP?=
 =?utf-8?B?VUZidGVxQXFsNjdLWWNsdDBWY3c2M1NUT0FCbFJrWHFaZEtRVkJqSXFCdWJm?=
 =?utf-8?B?KzFycGk4WDN0dGpqMHlWcTZyT2JINnVhMHVkOFN2N2lLTGNhNHdCaE4yMEFS?=
 =?utf-8?B?R2Ixc2o3RnV5UitFVmhwRHVGcHM0ZkVORGo2eitHWkZuY0tyS09aNkxyM0g2?=
 =?utf-8?B?MmtnRFMzdzdtaFVCaHQveHpFS09WZEJ1KzB1M2ZHaEF6ajQrYWZISW5FckhH?=
 =?utf-8?B?aW44QW9iMVZVb3Q1MmEwZWtNLysxT1dGZkoxRFM0ME9EcVhHZ01aQ29mY1N5?=
 =?utf-8?B?MVVDUlQ4bGZpZGJ4VFljVlZNVGZ0WDUxcjkzemI4RXM0NEpxaHAxaFFGRUxx?=
 =?utf-8?B?L2dSd0Y4RlpPWXBFSitRN0VRTlpISENETmRpWVR6SDJYZ2xiUnFBOElPekY1?=
 =?utf-8?B?M1pFWjRjT3JvYVpJem42ZVU4MVJad2x0T0RsNlVpM0QzS2tCVjAwZTdrNXl6?=
 =?utf-8?B?KytoNWcyS3Y0NHc2eUlRYUQ4YlQ4b0VQcFdJWUU3dE03MS9sTkN2TXVuMVYr?=
 =?utf-8?B?ZVRyVmdYc2dGU2NablBhbHpsMWpyZjhZYi8vTE5BMHBVbDNHVi9FNGE2WDRl?=
 =?utf-8?B?bVpJWGJqSGxNMEtjZmk2R3JXd1lQYkpwSHo2ZzVybng5MTJ3U1ZyMWhxaWdC?=
 =?utf-8?B?MjVNZFVEWGliN04xa2MrdlhnQXNteHRyWEszcGxwRUN3WEJnNmsyMHQxMWND?=
 =?utf-8?B?TGd5ZU9abGNtZzl6K1N5UC8zTmlXKzhyMkQ4YlFGeTdBZGhHbTJkWE9wd2Yy?=
 =?utf-8?B?WFRPZHFWMTIzbUVTMmFZaEVaTlArajh5aUM1b1ZtRmx3aTllVk1Rd3poa3ho?=
 =?utf-8?B?M0c4eEtPTjA5UHBMaXl1QnJVenptSjhqcHVrS0wwNG0zK2xxNHE2Sk1COVN3?=
 =?utf-8?B?UEJZU1BOTUdJdnRoczBQVktuMVg1TmV0eEx2ZmJZNTNmWGIwMHppMHZ3YUdx?=
 =?utf-8?B?a0FQOUtBZUppQXp5ZGgxQlRTeEdSYkFHelMzNHc3T0NCQ2lta25OODJ6S2Jm?=
 =?utf-8?B?VGFoZjcycDY5MU0rWDBIbnA0MHVoRVZIRmROTTh2WjVRZ01tVE5jQUhkcERi?=
 =?utf-8?B?djZwTmdCMWpOMUFYNytQMlI5OGd6dEdDKzJmbUdEU2tPUm1EckcxZkVRME5O?=
 =?utf-8?B?aHVGelYzejJreG9JakIrQXdha3Zub2xncjJqUCs4NFIxNGh5Zzkvakk0UXN4?=
 =?utf-8?B?b24xbHRjc1JLMDFVdUp5dzdCakV0UG1EVkk1V2t5T3F2aFVXM2pYOG5NK1NV?=
 =?utf-8?B?alRnVGIvR0NRZ09RTG9haVBaemJ6Wk9JV1JmMXhXZGtacVVsUTRIK21pTXhs?=
 =?utf-8?Q?XRUchAOcgvtaisVP2s79eXLxO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7d8fe3-5f2b-4cc7-00bf-08dcff131257
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 10:00:56.0385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8UocMIaXuD6eDTk0M0uD30J9Dumtr+A1oeNDaQSdcHsasaRPw/LfAgmUy3u03sJIHB3E8pddnaGoHAqu1vCiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4339



On 7/11/24 00:19, Steven Sistare wrote:
> On 11/5/2024 10:18 PM, Alexey Kardashevskiy wrote:
>> On 31/10/24 14:34, Alexey Kardashevskiy wrote:
>>> On 26/10/24 00:11, Steve Sistare wrote:
>>>> Extend pfn_reader_user to pin file mappings, by calling 
>>>> memfd_pin_folios.
>>>> Repin at small page granularity, and fill the batch from folios.  
>>>> Expand
>>>> folios to upages for the iopt_pages_fill path.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>>>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>>>> ---
>>>>   drivers/iommu/iommufd/io_pagetable.h |   5 ++
>>>>   drivers/iommu/iommufd/pages.c        | 128 
>>>> ++++++++++++++++++++++++++++++-----
>>>>   2 files changed, 116 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/iommufd/io_pagetable.h 
>>>> b/drivers/iommu/iommufd/io_pagetable.h
>>>> index 8e48266..5ac4eed 100644
>>>> --- a/drivers/iommu/iommufd/io_pagetable.h
>>>> +++ b/drivers/iommu/iommufd/io_pagetable.h
>>>> @@ -177,6 +177,7 @@ enum {
>>>>   enum iopt_address_type {
>>>>       IOPT_ADDRESS_USER = 0,
>>>> +    IOPT_ADDRESS_FILE = 1,
>>>>   };
>>>>   /*
>>>> @@ -202,6 +203,10 @@ struct iopt_pages {
>>>>       enum iopt_address_type type;
>>>>       union {
>>>>           void __user *uptr;        /* IOPT_ADDRESS_USER */
>>>> +        struct {            /* IOPT_ADDRESS_FILE */
>>>> +            struct file *file;
>>>> +            unsigned long start;
>>>> +        };
>>>>       };
>>>>       bool writable:1;
>>>>       u8 account_mode;
>>>> diff --git a/drivers/iommu/iommufd/pages.c 
>>>> b/drivers/iommu/iommufd/pages.c
>>>> index aa79504..5f371fa 100644
>>>> --- a/drivers/iommu/iommufd/pages.c
>>>> +++ b/drivers/iommu/iommufd/pages.c
>>>> @@ -752,19 +752,32 @@ struct pfn_reader_user {
>>>>        * neither
>>>>        */
>>>>       int locked;
>>>> +
>>>> +    /* The following are only valid if file != NULL. */
>>>
>>>
>>> Are "struct page **upages" and "size_t upages_len" still valid in 
>>> this case? The code (kind of) suggests they are not... Thanks,
>>
>>
>> Ping?
> 
> Sorry, I don't recall seeing your first email, but others asked this 
> same question
> and I answered.  upages and upages_len are still used when file!=NULL 
> for mediated
> device access, to point to the pages array returned to the kernel 
> client.  

This would make a nice addition to the commit log :)

> Maybe
> "u" for user is not a good description in that case, but changing that 
> and still
> using "u"pages elsewhere would complicate the code for little gain in 
> clarity IMO.
> 
>> Also does "user" in function names mean "userspace addresses" (as 
>> opposite to "file"? 
> 
> Yes, except for mdev as noted above.
> 
>> If so, the patchset makes many names misleading then. Thanks,
> 
> The new stuff I added is prefixed with file.  I left the existing upages 
> names
> as is.  That made sense to me, and made the maintainers happy enough to 
> accept it :)

Fair enough :)

I was initially pointed at this patchset as an example of how my 
guest_memfd pinning of private memory (CoCo VM) should look like. And so 
far it's been good except the actual pinning part - memfd_pin_folios() - 
expects the file to be shmem or hugetlbfs and guest_memfd is neither 
(well, last couple of months). Is there any plan to add those? If none, 
I will then, just wanted to check. At the moment I do what KVM does 
which is calling filemap_grab_folio(). Thanks,


> 
> - Steve
> 
>>>> +    struct file *file;
>>>> +    struct folio **ufolios;
>>>> +    size_t ufolios_len;
>>>> +    unsigned long ufolios_offset;
>>>> +    struct folio **ufolios_next;
>>>>   };
>>>>   static void pfn_reader_user_init(struct pfn_reader_user *user,
>>>>                    struct iopt_pages *pages)
>>>>   {
>>>>       user->upages = NULL;
>>>> +    user->upages_len = 0;
>>>>       user->upages_start = 0;
>>>>       user->upages_end = 0;
>>>>       user->locked = -1;
>>>> -
>>>>       user->gup_flags = FOLL_LONGTERM;
>>>>       if (pages->writable)
>>>>           user->gup_flags |= FOLL_WRITE;
>>>> +
>>>> +    user->file = (pages->type == IOPT_ADDRESS_FILE) ? pages->file : 
>>>> NULL;
>>>> +    user->ufolios = NULL;
>>>> +    user->ufolios_len = 0;
>>>> +    user->ufolios_next = NULL;
>>>> +    user->ufolios_offset = 0;
>>>>   }
>>>>   static void pfn_reader_user_destroy(struct pfn_reader_user *user,
>>>> @@ -773,13 +786,67 @@ static void pfn_reader_user_destroy(struct 
>>>> pfn_reader_user *user,
>>>>       if (user->locked != -1) {
>>>>           if (user->locked)
>>>>               mmap_read_unlock(pages->source_mm);
>>>> -        if (pages->source_mm != current->mm)
>>>> +        if (!user->file && pages->source_mm != current->mm)
>>>>               mmput(pages->source_mm);
>>>>           user->locked = -1;
>>>>       }
>>>>       kfree(user->upages);
>>>>       user->upages = NULL;
>>>> +    kfree(user->ufolios);
>>>> +    user->ufolios = NULL;
>>>> +}
>>>> +
>>>> +static long pin_memfd_pages(struct pfn_reader_user *user, unsigned 
>>>> long start,
>>>> +                unsigned long npages)
>>>> +{
>>>> +    unsigned long i;
>>>> +    unsigned long offset;
>>>> +    unsigned long npages_out = 0;
>>>> +    struct page **upages = user->upages;
>>>> +    unsigned long end = start + (npages << PAGE_SHIFT) - 1;
>>>> +    long nfolios = user->ufolios_len / sizeof(*user->ufolios);
>>>> +
>>>> +    /*
>>>> +     * todo: memfd_pin_folios should return the last pinned offset so
>>>> +     * we can compute npages pinned, and avoid looping over folios 
>>>> here
>>>> +     * if upages == NULL.
>>>> +     */
>>>> +    nfolios = memfd_pin_folios(user->file, start, end, user->ufolios,
>>>> +                   nfolios, &offset);
>>>> +    if (nfolios <= 0)
>>>> +        return nfolios;
>>>> +
>>>> +    offset >>= PAGE_SHIFT;
>>>> +    user->ufolios_next = user->ufolios;
>>>> +    user->ufolios_offset = offset;
>>>> +
>>>> +    for (i = 0; i < nfolios; i++) {
>>>> +        struct folio *folio = user->ufolios[i];
>>>> +        unsigned long nr = folio_nr_pages(folio);
>>>> +        unsigned long npin = min(nr - offset, npages);
>>>> +
>>>> +        npages -= npin;
>>>> +        npages_out += npin;
>>>> +
>>>> +        if (upages) {
>>>> +            if (npin == 1) {
>>>> +                *upages++ = folio_page(folio, offset);
>>>> +            } else {
>>>> +                int rc = folio_add_pins(folio, npin - 1);
>>>> +
>>>> +                if (rc)
>>>> +                    return rc;
>>>> +
>>>> +                while (npin--)
>>>> +                    *upages++ = folio_page(folio, offset++);
>>>> +            }
>>>> +        }
>>>> +
>>>> +        offset = 0;
>>>> +    }
>>>> +
>>>> +    return npages_out;
>>>>   }
>>>>   static int pfn_reader_user_pin(struct pfn_reader_user *user,
>>>> @@ -788,7 +855,9 @@ static int pfn_reader_user_pin(struct 
>>>> pfn_reader_user *user,
>>>>                      unsigned long last_index)
>>>>   {
>>>>       bool remote_mm = pages->source_mm != current->mm;
>>>> -    unsigned long npages;
>>>> +    unsigned long npages = last_index - start_index + 1;
>>>> +    unsigned long start;
>>>> +    unsigned long unum;
>>>>       uintptr_t uptr;
>>>>       long rc;
>>>> @@ -796,40 +865,50 @@ static int pfn_reader_user_pin(struct 
>>>> pfn_reader_user *user,
>>>>           WARN_ON(last_index < start_index))
>>>>           return -EINVAL;
>>>> -    if (!user->upages) {
>>>> +    if (!user->file && !user->upages) {
>>>>           /* All undone in pfn_reader_destroy() */
>>>> -        user->upages_len =
>>>> -            (last_index - start_index + 1) * sizeof(*user->upages);
>>>> +        user->upages_len = npages * sizeof(*user->upages);
>>>>           user->upages = temp_kmalloc(&user->upages_len, NULL, 0);
>>>>           if (!user->upages)
>>>>               return -ENOMEM;
>>>>       }
>>>> +    if (user->file && !user->ufolios) {
>>>> +        user->ufolios_len = npages * sizeof(*user->ufolios);
>>>> +        user->ufolios = temp_kmalloc(&user->ufolios_len, NULL, 0);
>>>> +        if (!user->ufolios)
>>>> +            return -ENOMEM;
>>>> +    }
>>>> +
>>>>       if (user->locked == -1) {
>>>>           /*
>>>>            * The majority of usages will run the map task within the mm
>>>>            * providing the pages, so we can optimize into
>>>>            * get_user_pages_fast()
>>>>            */
>>>> -        if (remote_mm) {
>>>> +        if (!user->file && remote_mm) {
>>>>               if (!mmget_not_zero(pages->source_mm))
>>>>                   return -EFAULT;
>>>>           }
>>>>           user->locked = 0;
>>>>       }
>>>> -    npages = min_t(unsigned long, last_index - start_index + 1,
>>>> -               user->upages_len / sizeof(*user->upages));
>>>> -
>>>> +    unum = user->file ? user->ufolios_len / sizeof(*user->ufolios) :
>>>> +                user->upages_len / sizeof(*user->upages);
>>>> +    npages = min_t(unsigned long, npages, unum);
>>>>       if (iommufd_should_fail())
>>>>           return -EFAULT;
>>>> -    uptr = (uintptr_t)(pages->uptr + start_index * PAGE_SIZE);
>>>> -    if (!remote_mm)
>>>> +    if (user->file) {
>>>> +        start = pages->start + (start_index * PAGE_SIZE);
>>>> +        rc = pin_memfd_pages(user, start, npages);
>>>> +    } else if (!remote_mm) {
>>>> +        uptr = (uintptr_t)(pages->uptr + start_index * PAGE_SIZE);
>>>>           rc = pin_user_pages_fast(uptr, npages, user->gup_flags,
>>>>                        user->upages);
>>>> -    else {
>>>> +    } else {
>>>> +        uptr = (uintptr_t)(pages->uptr + start_index * PAGE_SIZE);
>>>>           if (!user->locked) {
>>>>               mmap_read_lock(pages->source_mm);
>>>>               user->locked = 1;
>>>> @@ -887,7 +966,8 @@ static int update_mm_locked_vm(struct iopt_pages 
>>>> *pages, unsigned long npages,
>>>>           mmap_read_unlock(pages->source_mm);
>>>>           user->locked = 0;
>>>>           /* If we had the lock then we also have a get */
>>>> -    } else if ((!user || !user->upages) &&
>>>> +
>>>> +    } else if ((!user || (!user->upages && !user->ufolios)) &&
>>>>              pages->source_mm != current->mm) {
>>>>           if (!mmget_not_zero(pages->source_mm))
>>>>               return -EINVAL;
>>>> @@ -1068,8 +1148,15 @@ static int pfn_reader_fill_span(struct 
>>>> pfn_reader *pfns)
>>>>       npages = user->upages_end - start_index;
>>>>       start_index -= user->upages_start;
>>>> -    batch_from_pages(&pfns->batch, user->upages + start_index, 
>>>> npages);
>>>> -    return 0;
>>>> +    rc = 0;
>>>> +
>>>> +    if (!user->file)
>>>> +        batch_from_pages(&pfns->batch, user->upages + start_index,
>>>> +                 npages);
>>>> +    else
>>>> +        rc = batch_from_folios(&pfns->batch, &user->ufolios_next,
>>>> +                       &user->ufolios_offset, npages);
>>>> +    return rc;
>>>>   }
>>>>   static bool pfn_reader_done(struct pfn_reader *pfns)
>>>> @@ -1151,7 +1238,14 @@ static void pfn_reader_release_pins(struct 
>>>> pfn_reader *pfns)
>>>>           unsigned long start_index = pfns->batch_end_index -
>>>>                           user->upages_start;
>>>> -        unpin_user_pages(user->upages + start_index, npages);
>>>> +        if (!user->file) {
>>>> +            unpin_user_pages(user->upages + start_index, npages);
>>>> +        } else {
>>>> +            long n = user->ufolios_len / sizeof(*user->ufolios);
>>>> +
>>>> +            unpin_folios(user->ufolios_next,
>>>> +                     user->ufolios + n - user->ufolios_next);
>>>> +        }
>>>>           iopt_pages_sub_npinned(pages, npages);
>>>>           user->upages_end = pfns->batch_end_index;
>>>>       }
>>>
>>
> 

-- 
Alexey

