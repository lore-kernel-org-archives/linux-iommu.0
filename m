Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13B8211A0E
	for <iommu@lists.linux.dev>; Tue,  8 Apr 2025 05:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744090917; cv=fail; b=emdHFwh0MLnF2CHfI9h/6kY0jlvlYTsCfX2zi6+ZQxDxXjgDasoOSIP7VrrLcccJHy8Ldw3upy/ZrtwEsjkWSAFe8ivyRi7f7UXEfgtNVnpk6VGORsFz/f3dwKtftuO4OhlsBNuVduhFn1C7CFp4oOjn0lbsJfXCrksUh7IzU7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744090917; c=relaxed/simple;
	bh=dxkePDDxdBpVwGV/wVgyphJIUhzQwHwGmZCV9rlD6XU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bLXq+hqg0k62+LhMQ1xjo0KJ3niKoESBNiVBF0a9N2G0cv9ToBN/b3l7sMRFVWW2vN2VCaJ+aXmnX0axCNowxPuUGkqbxxpmDw0MoUqoUZQwzX+z48Qj3peI09AkLphSF9rak7tFtKQ/9j7nG3xMALmkG9uQqjgj19XZ2dq8ebM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AFrCZpos; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AFrCZpos"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fu+BSlddtgtcs27IR/Yaooue92Ne7DK+RFEg2XCUSZzCibTpKWVFSOPQ2D5n0sENJmk0nXFWMzFNBsMULs2NSr3zuHS2NIyoiCwNUeE/LkLIRkj+QsG5WHwdE6W3/0fHhIu/xzRNULj9wcAZ31GlH+jVJLqBA96IunEs5eYpvJrNyfymzQjR180DiaHKtIOAxHAf1Vis1JEjuEz7CJvyZ+d6EL2E3WzGujxkt+gS+GVHv+vqHw0E4vwvkHKiBc0hazzSL54caQBtc3MlOS0m0lURY1uvMDmwkinqJxGDua5UzMgye/PzYnTXZWFalebLaHlRLznQjIxXhx5ME8gMww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbwt/2ep+cs4aYVgtHwrQPaxjj+ulcnmZQZQqi5Zw9U=;
 b=rZQlP4OUXZPxB7nmJcGM7n3gB+wCFBoB4bNyEb7SBvczmaVorxuCmaIp7jw80Rz1Qfp96rMPJ7KE3FvVhsM5RYbIrDoyd/Mi47myql9+yKpKidX7uEZk1+PP6P0THkx9Al5WcKb4s0iY4oGiq/DoSGkvI22MBydbs3oORye9eSmN9ftD4Dv7/66V65jZRlWZrkSDJRPvqKTorsxry2DwfjXuC7Z4LeyrYJQzmHqMjILDVFtuDVKpoimgD8LJXmOr7j/VjiSyG0BqX0GWsX7ayem6j94vODBMQBMW+xJ7HEJlIhpQBpFNkmKRS0M5+rG/5dp0Jdoid3zNkzTKbBVRGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbwt/2ep+cs4aYVgtHwrQPaxjj+ulcnmZQZQqi5Zw9U=;
 b=AFrCZposm4OxSR/2qINKcnMBfi4PJ2VnqyOj0vDgJ5P7dMN86s76aDeTG3Dq8pt6YZiRitseJnyniM+PzPStTKTDvAgrBsslrHXqK289rGMMJVOQsbJRfILKr6Kn3Hl2rwkTtSlp9xujQgm05YrEBe1xrqJ5ghAeNEZrJwO3lx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7)
 by SJ0PR12MB6829.namprd12.prod.outlook.com (2603:10b6:a03:47b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Tue, 8 Apr
 2025 05:41:52 +0000
Received: from BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f]) by BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f%3]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 05:41:52 +0000
Message-ID: <d1e56da5-8049-4db7-97b8-05a9e7e7bbda@amd.com>
Date: Tue, 8 Apr 2025 11:11:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] iommu/amd: Add debugfs support to dump IOMMU MMIO
 registers
To: Vasant Hegde <vasant.hegde@amd.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: suravee.suthikulpanit@amd.com
References: <20250317115830.3416-1-dheerajkumar.srivastava@amd.com>
 <20250317115830.3416-3-dheerajkumar.srivastava@amd.com>
 <f1b0721c-b518-4bf6-9de9-f09369b85d0c@amd.com>
Content-Language: en-US
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
In-Reply-To: <f1b0721c-b518-4bf6-9de9-f09369b85d0c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::8) To BN9PR12MB5163.namprd12.prod.outlook.com
 (2603:10b6:408:11c::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5163:EE_|SJ0PR12MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c4e9dc-9688-42f1-4bdc-08dd7660109b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZE5UbXcrRWxuczhtZWVzalF0NHVOSjdWUEZGSmxEVUhtQW1PRzEyeXRpbDVl?=
 =?utf-8?B?VTBDRFAwQkJJWFpLVG1Fb3ZpcEtLU2xNeEpSODB5NDR0Si9FNk52eWdLc25K?=
 =?utf-8?B?eVZjempuaXo1cHpTWXJwK3I1VkhyQ0sycWI2dkFNbzRLWm0rekFKZ0FEUm9k?=
 =?utf-8?B?bXZoeThaV2w3Y2lwOXJRcTVrK2ZUSjdOSEoybFdKcHFiM1pMLzRkVEZhNUYy?=
 =?utf-8?B?QVFUT082emt1bUZrS1pFT3FrSi9IcWRXMGgxN1pRbklENGg1bjMxVmFocnho?=
 =?utf-8?B?UW9oeU91N0xEKzBBYmNGUjR3Sms2MExSMDMwZ2NZNlVPand5M3FTc2k5eHBq?=
 =?utf-8?B?WEZUaU9ZRjRyNnBJWTdzWG1IMlc1Yi8zdGkzNW44ZzF4RmZ5dHREajU0RE1Y?=
 =?utf-8?B?SVZ4ekpWY0xFT2lPWW8wZW1vMk9mYUNlQ2c4Zm96VThrbExSQjd4ZVhMTk04?=
 =?utf-8?B?N25iRTlvZDB2RFROY21rVGp4bWlVSjZpUTBSQlJ6bVBtTUFMSTIvUE5WUXJR?=
 =?utf-8?B?MkZsY09tOG5oUlZ6bENpVHdjdldDRnk4QXdoUnBwcURoaEJyZWUrZHp4RXZ2?=
 =?utf-8?B?elc3TDc0OWZGTVl3d29HOGk3QlNZQVF2cVZyUHRSTUxsRnJVUmtoQkQwbUZ1?=
 =?utf-8?B?dERlRGlraG56VVE2RGZ4VkRObmhrd3VJdk5TMUFTUlUwODNmS1ZESncvNG01?=
 =?utf-8?B?RHc5V1ZHdm5CYSt4ME9KL2hpdnR3bVVCbmFHbjZ2Vk1pQ2ZqTVVDOXlDQjR0?=
 =?utf-8?B?KzB5djJwWUdBRWkyaEJGRHF5NDBCMm85aHZZNzN2bVRHNWJSWjNnRUhhak4w?=
 =?utf-8?B?Njk1ODZ5NEF3ZTJYdmU0SXZuNXNVSlloVnRFWVduNHJ6dUd2SlVET0wrZ2xS?=
 =?utf-8?B?NnpGek42V3IyTVV6ZDRnRDRUbTBTNW5ManV5cWgyWSs1VHRKcWFsZDB4Q1JO?=
 =?utf-8?B?dlZwc1JFR2wyU2FTSHR5V2o5UUUxR0Y5ZGd3clp6UnZIMmtnUTU2dEVCM0Zt?=
 =?utf-8?B?UE1BNWZvTWZxbjlBaUVBQW9zenlUY0RQRU5teUZUYWJPWmRnYzRpa1QwTGJT?=
 =?utf-8?B?KzBwYXZSeFZpMUtGOGF6U1ZmMTJWbHFtSHJldGc4bTZFOVl5Tk54V284V3V4?=
 =?utf-8?B?ZWV1Q3pqeXVva3JabmVDNDJzMWxmM3FNRFFlUzhYTGR6M21UVDRiWkU1OWpw?=
 =?utf-8?B?M1c4L2w4dm1PM2RKeVNZbzhKb0tLemVLMzRDV3B3dmtMaHRreFNHTnR2ODhn?=
 =?utf-8?B?M1hpOFhESXFTQzl0R1djUVBhY2FVdEhOVXB5em5raDNINklwYkdDUDhPdkhq?=
 =?utf-8?B?T1ZJNU5YdDhDOW1CY1c4enVvRThiNHl2RWJzZEVhNGhWM0MrKzNQditaeWRB?=
 =?utf-8?B?M3NnZ0crdXFaUFhHaCtXWEd4ekVhYi9ka2dPSCtGNUVjeWF2Q2lyZXIzU2g5?=
 =?utf-8?B?ekNzRnczSWlVZVlQQlhEUGNWZlNtdnZNUGhCSVVaZWtaUVBTVG9UL2lrRE5B?=
 =?utf-8?B?aDk0NDNMUnB5Wk5FQ0pRNVVMN2F2c0VJMXFtUjk5ck1LeTM4RU4reHN5N0M3?=
 =?utf-8?B?NVFLVHBBMG52RmxIdS80S01GQy8zcm4zcFVHVndUVWxpN3ZOWGxGTnpqVVFa?=
 =?utf-8?B?cTJRY284Q01mMVRRNzhsTmswRlB1ZGU3NHRpUmlTeFdyekNWMElSSmFvd2Yw?=
 =?utf-8?B?eE5ObnRZVkpIMmNSU0krMkZOZTJ0UlJjaG41WFNMRG1Sa25sOVllTHdRbzJN?=
 =?utf-8?B?eDNtcmFtTEdoaVJmamhFOEplbVdGUWhLV2pZaXpiUWtick9scWNsSEtBamk2?=
 =?utf-8?B?OGV0UDlKNzR4Z2V4WnMwTERnVm9pVUxBMng5bUZKVlJMcDJuOHpiOVdCcXNF?=
 =?utf-8?Q?u3n+JESqrCyv/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmdjcU81T2crMUFRdzNCWkt6R2E0M2cxNTV6M29DS3pHcEh5eW5wS3ZJak1K?=
 =?utf-8?B?YXhKWGpid2tZZnNsdUV5QzRENTgzL2ZFeFA5N0J3WmVrUUxwWFdpVlpVY2pn?=
 =?utf-8?B?ODNiQkNkK0JaTFdoSlJlU0VxUFZwaXRDZXRLR1RTbXpBQTZoUVBlT0sxNzlZ?=
 =?utf-8?B?UUVIV0FNcHpIdHcrazJZdHVZeVdWUVRVV2hKdjNBRkdPdEJjWnFZOUUySlRn?=
 =?utf-8?B?YncvcUIzUVd1WHExSTYrNEZTTUxZRHpyZHFzd29nVHY3OEt1ZWJWZWs0RXBF?=
 =?utf-8?B?ckZZc1FFMWIxVTNqQVV0T3FOSC9nUFlQdkZmR2l5cmJDVU52T0lZK0RiMDJT?=
 =?utf-8?B?dTdReXFudC9JU2FWRTYraTJ1MkRmR2MzZVhaVzdPSXFQYWdSREtUTHIzV0hM?=
 =?utf-8?B?MytXNTd5ZkZFakxFaExmWHg5SktwRTRhcXNONzBzaU5vQjZ5ZjNHTm5FOFZQ?=
 =?utf-8?B?dVQyRDY4WnVPUDRLYXBmK3RkUWJReWVqNmdSdzh1bGtkdWJhQW5NaUpJcUJR?=
 =?utf-8?B?QU5QVGtFMk1VL29wTWtJb2J5WVQ5dUJaTGwrWlV6ZHhBZnBCVjFTTk1ja2xm?=
 =?utf-8?B?azBReURQa2kvNWozbmo5b28yQTJ2OGhnTFVNVStFcXJuekNoNnNsSkZHWXNz?=
 =?utf-8?B?aFRpYmZkTkZvcnhBeDU4Z2V4MDN2UWxkUGx6dGZ0N2haOTFvdHdiTmxTNzdT?=
 =?utf-8?B?d2w2UlhsblgvR1E2VndLbDcxeHhEYWIyQjlLNUZidGNEN2hXa0kxRzRJT3ls?=
 =?utf-8?B?WUQwNFNvNFFSNXZXNUQ0ck1ldHF3NjFWVytWN2p0WVJDRTJkbDlzYXo1S2Q3?=
 =?utf-8?B?cUxKMlA1aWtKc1BkK0QyRGU2SkFWUFpFYjBiRzA5cVJuTjlqVDJ4MHVPOFhx?=
 =?utf-8?B?VVVaSk5nNlp6OUZzcXF6dlRoWmZORmpjNXhWS1p1ZEFIM0hQL2Mya2Uza2V4?=
 =?utf-8?B?OXlwMjlsejJGNkZudFJZN0JWTWJDU0R3UWFjNnRJUDQxcHIrNm9ZS2xhMzJ6?=
 =?utf-8?B?MzJ3MUorOE1hT3lIVHJiN29tdDd2bG12RTJCVzRnS0FkUGE0MzZjYkcybHQ4?=
 =?utf-8?B?bzRWR1E4TjIwK0toOFJ0TGkvbzZxL3ZMMkFHRlljWEpkNGd1Y0sxTThFdVZj?=
 =?utf-8?B?TlN5cS8zZVR4WTZMQm9oTUptbUtKSlQ5UWZMTnN3eHlleDdYSmFTazV1eFhx?=
 =?utf-8?B?eGd2cFdqNVduVDFEUzhJU0RuUnowZTAvMFA2eWVPYUU0MGFJMFdTRmtWekRX?=
 =?utf-8?B?WTFma3M1WFVINlpnUjdrTWR5cmZRNkxVTVBPMjFGRGpub3IrYndkSGl1UXRp?=
 =?utf-8?B?bGtGdTRRWnV2Zk9pYmtOYVZEc2taM1pRdE1vcnB6akxiNFk5N3ZxMFk1Tnh5?=
 =?utf-8?B?SDVILzliYjJtM1JaODFhaXBnSzMzR3R5WXpjWHFGT05JS1BBYWUyYXByY1d4?=
 =?utf-8?B?NERjQlppb1BvbDEwNklYUlE1dUxpYlBZR0FqRVVOYmgzM3ZWV0dLMGRJTk9G?=
 =?utf-8?B?L1NjUTNaNStBTlJBcGQzVklDSlJaMTZzUnp0V3RQcW00NU5iSlBwZGR0VGVU?=
 =?utf-8?B?TWRISGtlWWp5V1BmcVBCVlB3RzlueE96SEk5U2tvQUlaSVl4S1puT3Q5UnJO?=
 =?utf-8?B?SDNSNXFmQk4vUVhzdUFIOGI2N3lrd25tM3VQWkt6K0tEK0F5SzBYQTdFTUlS?=
 =?utf-8?B?MEZJTjFwWkc4amM1MVBuMkh4cHc3RkRjT2o4UlRvaVcwazFPSU1lYko1bXU1?=
 =?utf-8?B?SkNCVDQwd2IvcitUYlpFWEtxWXNJQkQ4SG5RUFBhL2tzcjY0Yy9yWEZzTmtZ?=
 =?utf-8?B?a09obmhnZDYybmxPa3BISjJITFY1MEtMbmVlOUx0T3JTMkhTMjlVeWl3ZXpy?=
 =?utf-8?B?eDhoamFNL2gxRkVMb0ErOVpnQlRpNDBlSnBzejdBTkVnWW95N0hoMVVYclh3?=
 =?utf-8?B?K3V5UXlJNHRWd082QkRQbG4yK3VZTWIrMzJKdHR5bDBzaFpoVVFGU09PN3BO?=
 =?utf-8?B?ZkJWK016Z2F5ZWZrcys0c2lnQml3Q2ZkVm1sZG51WWpmTDhlY2V4L0ZVYWgr?=
 =?utf-8?B?OWd4R3RaQVRjczdSUmd6M2tVdFhiLzJTeUovaEtyUmtKd2o5TkFpWDlSWmxj?=
 =?utf-8?Q?s/1Vs8R0oIW6ryryOEOuwsrqM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c4e9dc-9688-42f1-4bdc-08dd7660109b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 05:41:52.7244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AogL19+MXItNReHc86mFaeSIpCfu6IhkqT9xN1xUXYIW2HnwvdgPKTmD7AoJpNs0qHUthLd0Gqm96ZREH7SvWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6829

Hi Vasant,

On 3/19/2025 10:20 PM, Vasant Hegde wrote:
> Dheeraj,
> 
> 
> On 3/17/2025 5:28 PM, Dheeraj Kumar Srivastava wrote:
>> Analyzing IOMMU MMIO registers gives a view of what IOMMU is
>> configured with on the system and is helpful to debug issues
>> with IOMMU.
>>
>> eg.
>> -> To get mmio registers value at offset 0x18 for iommu<x> (say, iommu00)
>>     # echo "0x18" > /sys/kernel/debug/iommu/amd/iommu00/mmio
>>     # cat /sys/kernel/debug/iommu/amd/iommu00/mmio
>>
>> Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
>> ---
>>   drivers/iommu/amd/debugfs.c | 47 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>
>> diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
>> index ff9520e002be..c61d52420c5f 100644
>> --- a/drivers/iommu/amd/debugfs.c
>> +++ b/drivers/iommu/amd/debugfs.c
>> @@ -15,6 +15,50 @@
>>   static struct dentry *amd_iommu_debugfs;
>>   
>>   #define	MAX_NAME_LEN	20
>> +#define	OFS_IN_SZ	8
>> +
>> +static int mmio_offset = -1;
> 
> 
> Somehow I missed to catch this earlier. Here you have global variable but mmio
> is defined per IOMMU. Shouldn't we track it per IOMMU ?

Yes correct we need to maintain per iommu global variables for mmio and 
capability registers offset. I have sent v5 addressing this. Please find 
some time to review it.

Thanks
Dheeraj

> 
> -Vasant
> 

