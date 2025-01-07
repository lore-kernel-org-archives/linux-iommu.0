Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79533522A
	for <iommu@lists.linux.dev>; Tue,  7 Jan 2025 05:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736226123; cv=fail; b=uJ4VGRjdaU+KBaCMd65uUWGf+lZ9+JWeO3O8R4jhVBPdGZ7tvNAYy4IITRIVQjIb4O7/6tXD4Z06B7Xvfev/i8y6CNlr8C1W5hErmlE2POCehbJcFzA+ameNn8QnFtGa3GQO0uCusRKLiZaxZr7iE21VJb5lPnEapA7vLeL4c38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736226123; c=relaxed/simple;
	bh=1zhiOhG+88482aDP3aWQ/XG0qmsrVOwXyv6vFw2wro0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UuZEFw7l/qLdxSKrLfo6GGDB5MCQCCc/4N2nQpjfE9xBEXOAtNlfw8jPL+Kp4jflUtUP5kca74gxU33pRNcuyBAYocOmAQdA5g6CrWhC1R05NBeZjrf+Tc/tASmDLkNI/t+LRwDQAkQT3A9TP+ATY4g0l/t0i7n9GrwxZ3CS4f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cmuFPMzq; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cmuFPMzq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8n9F4CA92jrdft6L+Tze1bFzcn6Y2tqImIBxP1falF3QmYtpycGIDvj1yiJj+wMnbMNNFOSmZqJhTcrSqPLSoYogzlnmGfn2UYcJ/PXTQBxvMvbaOzFcZr/2K1QWlfin7fWCEZD5OHBZLFn+H8725833VbIi7kS5RzG+Ox+TTlHqNGg8v6v+sszp8c+Nj8SV+kSuMCbGSObvvoN+FvZJX2S7muAZOl/c562diolIBOJ6IFPOQ/hcgYmfxh9P1Rj28BywqkelgqsbMFX+D6iB7okqt13guKAnUIdr4ZCv7/0FLfZ4WXn2aoYYOKHu36vHgjMKb35Dq7WZxnwavpgUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rF0cvr0S2jJjN8g7PBP8E5Btu9eWPPxK6AWh/+n/DVo=;
 b=fLRbXNQ1EMpcHt3vMGvy/jvAYu0BhxIZAfPGTiQ0tsakGzu0NmOMAqZRaTs/LftuhgKS+yZOhLWyek8dsrFDSvYK1yPvh4dRXktxX8qMIFZQATMEwnWhG9jGCmn/PjCS/MTlFWeUdb9k5gub4UchYxF+67V7F9d4JIf53TJ4yzd3DpOxITzlSqj02Le5z6LMfj7MCVqjgsrjOqRFM6tBr7Y19SSIIMrP1PKSF+wVhSj6r4UbRQPTSdoSZE801Ll+0iX3yzq9als+duBIxd3WWMoewlkSszO9Mw48eqq+SXgqa94QMqhCglMsLG7jOq2OlpMGdTNVm4+IHI/BMie5Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rF0cvr0S2jJjN8g7PBP8E5Btu9eWPPxK6AWh/+n/DVo=;
 b=cmuFPMzqfQ9U+SyNgqzQCFQdc4JQXHTZSOf3gzjBDEM5NrZFfNMZ16WRUV8YthjH3ycTRy+hRhDsM28ljfxQVwRHOUdkxcm3bWqPwHlAEAr0uSuRA49xI9L96T47bIAdAALviV0RRzZjdMOoI3l9Z/AThbGm4tG7MQmHIw+ZK+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7)
 by DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 05:01:56 +0000
Received: from BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f]) by BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f%6]) with mapi id 15.20.8314.013; Tue, 7 Jan 2025
 05:01:56 +0000
Message-ID: <32e3b143-c9b1-443e-bb9d-59a0fbf51ff7@amd.com>
Date: Tue, 7 Jan 2025 10:31:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] iommu/amd: Refactor AMD IOMMU debugfs initial
 setup
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 vasant.hegde@amd.com
References: <20241126191228.GA2650296@bhelgaas>
Content-Language: en-US
From: "Srivastava, Dheeraj Kumar" <dheerajkumar.srivastava@amd.com>
In-Reply-To: <20241126191228.GA2650296@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::27) To BN9PR12MB5163.namprd12.prod.outlook.com
 (2603:10b6:408:11c::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5163:EE_|DM4PR12MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: de5a6c73-d973-49fb-84ac-08dd2ed86872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bE9JT0ZhVnZibnRJUVNMVVJ0aFRjRzJjeGw3cjlXNllZM2V5blNCT0dSclNu?=
 =?utf-8?B?VlBuRXk2aUFqMm1JM0gzaWpEZFIzRmdOSnY3bUcyRGQ3VTNXRElXTnJBRTdS?=
 =?utf-8?B?d25VQWFoK0tGZDJOK3lIUWRPcUVlNVc1T1JuSkhlK3ZnMk5XeVVvVTNta1ZQ?=
 =?utf-8?B?R2VCOTZZaTZ4MmtYNXJyT0tqeklKUHlZTlhCNjVLdk82MS85K3o2OEFDZWtP?=
 =?utf-8?B?T0tlaWlMdERha2V5NXhpMnRCdWt4VExuaUczbFVkWUE2Nk9SM1dlcy9mR0t4?=
 =?utf-8?B?eEpUc2JrZjNWNy9nbmc1RkFWNGlsZlN0Z3Z5NTByWlErMExuQ2UwRXRnNzNq?=
 =?utf-8?B?Z3RGeGY4RUtiQXl1b0ZvVmhocGR3c1gzUXdIZzJuUmZBZDZHTWtnRnFvMmU5?=
 =?utf-8?B?SHlURk1jVVlOVUZIWXZwYjRIOFZ2M085NUVoVDlFeG82NjRmcUFKT2Y0bzlx?=
 =?utf-8?B?d2o4ekJKRTM1TUtwMmk3MU1oM1BqaUh4ZjFzcTBuTFNSL0FRVGhZbmxmanZn?=
 =?utf-8?B?SG1aZzVyZ3F3NlI5WndvUkRoUnRBQmZGOVViS29XZjhTUkhpdEJzaUZiUFhN?=
 =?utf-8?B?Q2NmWEhWeWNvbDYxK2daaUZ5YzFiYzlMbWlXaEJEeS8rMlZLenU2N1B0bFd6?=
 =?utf-8?B?bVNIbFRiRS9rYk0yUWR0bnlZVi9WdGtXMTJpWUFZdmVTdzJ6ZHN5NHpBUWpQ?=
 =?utf-8?B?TmQrQ2F4eGRaNkR1R0YydzJPK3czZWZpemJpV09oNjArWHFxYnA3bkYyVVY1?=
 =?utf-8?B?M3FqRWtwWXpqdzcvZTk2TFRrU1dhM3ZuYlZocSs3UWhtVDNGNThRM2U5RzlE?=
 =?utf-8?B?ZllHcVI4MzRuWllvUXVkc0w2VGVoTXJYWWlac1ozZ2Q4L2hWRWsrSzNHdU9M?=
 =?utf-8?B?MzBoOGhkTm5ZSHBJTWExU2lTQjBKYVo4SlE5Y005MUhhYi9LQzM1RXl6endC?=
 =?utf-8?B?bE1YeXZYMFdVK3BTRTd1akZPYUpFK0txYkVHM05aUjhZQ1JibHIvempUb3da?=
 =?utf-8?B?b0NJekJSZEUrNkoxU0ZuVllkMUwyaEpWM2x0Wjd6NkF3SC9Nc1k5N0ExeTFI?=
 =?utf-8?B?VTVJc1QxcllJNUpodE5TcGF3Q21YUzVxYjhWaW1iUEYrY0lWUHljUGV0QlhW?=
 =?utf-8?B?Wkp6REF6RG9ZRGl5YkdVaHBlSG9WVmVXb3BEYjFyMGhyRGIvVm9RblpWb010?=
 =?utf-8?B?RlVKMndWOXQrYk9JSFBnL0RibXRlQStZb3EzMXJBV3ZJNlpkamNoZTRvbTdH?=
 =?utf-8?B?KzVqcUdWREVNbkpsMlVITmlGMVVhMkowb2ZEY0lubVJXbDVOdGhRWENPWHpI?=
 =?utf-8?B?SEQzKzFSUkZINFViWUkzejd5YXFWVm5jY0YvWFZUNm9UaThqaVNEUzVVWi9I?=
 =?utf-8?B?MkxNcVpWTFFzQUR2VDhMVDdpck9GTXZSMkkxT1lkRS9QVndxVHM1RDB5SXdK?=
 =?utf-8?B?VUpFY3pMQ1hyMkorMDBSNzRkRFRIRGpKTVlWWnNndmR3SmppNEN6eVVoSjd4?=
 =?utf-8?B?dGFQMWFiTjBNTER0Q2diRGU1bUtiYmNLQ2ZzM1hxY0piMUZRQzcrV2ZtcFlv?=
 =?utf-8?B?ZWFHVUp2ZVZ6UGVhd3ZpZXMvL2lqY0hnMy9lN2pwR2w1QWcwZ0hWSUJxN1BI?=
 =?utf-8?B?WnpmVWJURWVpV2lwRGV6b2l6NUwwaUU4MjYvRGFRemtwcC9wb1MrSzN1Y09n?=
 =?utf-8?B?TGxtZEg5MGgwb295dlNQK1U1NCtDekRLRC9IaDNSaHdxUkQyNHk2cm1BK09C?=
 =?utf-8?B?OGx2N1ViQlZSZ1RvOVZwbS83RllLWncwVXV3VEljalZGUEd5eHdFNlZCR0xF?=
 =?utf-8?B?Wm9PbDJrWitpNGpZOEs5T1djZEl4aDRJNFU2Sys2Z0RTMWpxWmVTN1pWSkhO?=
 =?utf-8?Q?wvciYqDXJKVkn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFdCdFdZeU5hTkhpRTFzMUtodVlHNjdBSG1leDNGUm5Gd0dGWklnN0dTMGt2?=
 =?utf-8?B?WU5vai8zeFR3VFNvam1uNjRnNEFvbld2MndtUHkyQURCaUlMMVFJNTUvZnIx?=
 =?utf-8?B?cnZKVzRCSzA0eG5CUXJnaStvN0RySy9kY3BTVnRxVmgrcy9GMVRuajlSeDZB?=
 =?utf-8?B?MmQ4aitXOWRxRWVSbm9NdnFCRmVrMVR4cm4rQUdsMHBPdjZzZ29YQzhEK2Ey?=
 =?utf-8?B?cnJURHl3ZjFMbWVOanU2YWVRZk00MElzRjFZNUNGaDRwL1lCc20wbzFSeEVh?=
 =?utf-8?B?TEVQemNmdjVYMnFrZjVJZDFDREkvaUpWL2NhRXdWWWF0clRPb3AwaHlwUFRS?=
 =?utf-8?B?M09RWVBhM0kydHNITTFPWko2MEVnOHgxQWY3WWZGb2crN3hlWTZXS3U3T0Y3?=
 =?utf-8?B?UHIydkpjR0tidE8xNDVKQTdOOVFDdjBRMTBLRy9IdHAvU1BvQmQ2WjhaUnRR?=
 =?utf-8?B?ZUVQZjFXTW5NTENWdEVSZjVHZkhtaUJFaWE5ZjBzTHNzYWpzcmJaU2duQ21x?=
 =?utf-8?B?c0N5T3ZEbUR4OFpscklwajFCQnRQWXgyQlpqR3JHRmtqYVRacWVEV1p4S2Q4?=
 =?utf-8?B?dnBCZU44Q01ud0xsTEJsSDEyaXZwcHRSUUJmcU01Nnp0bFE1MWEyeU1wNzFp?=
 =?utf-8?B?L3NUN25qSklWOG92L1F5d21MR21zNjhuZFlLQkdsaEkrRVBGSGNkVDZUN1Rs?=
 =?utf-8?B?N1lMTDg0dVVTb0VkTVlWRkRpZVh2ZmFocm5EVGdkcjJadXBiT01SbDk0MnY1?=
 =?utf-8?B?SnQ3Q2NwQjlodUtjZ2R0clFHcjNpOWRBRE03L3h1YmpYek1nbkVwb0htK3pu?=
 =?utf-8?B?L0ZST2tyeEx6YitCRHFXZEhvNXR2RUY0N2VjeTB5MFFQclV3NFpPOHRqbEh1?=
 =?utf-8?B?Q2ZSWUt1WVNwQ0Y0U0orUEdIZXZwS01JWmd4RGs5dzNxRnJocExjc2JPV3Nq?=
 =?utf-8?B?S0JBUms3S2NjYUo4VjdYbE1odFhFR2psZmJVVkprM3RSOFZpYlJBWlJHVWhH?=
 =?utf-8?B?Wm5YWDcyQTJhdGU3K0NMSi9yaWhBS1Exeld2U1ZRQllXQjVGWTk0ek9WZld6?=
 =?utf-8?B?Q2lCOVkzYXFWUkRVaFJKemxoRkxmOGN0aHBvN3RpQjY5OEh4MmdiWXdhNUdI?=
 =?utf-8?B?TUd2d3BEM0ViTUEyM2llVHBLWlU5UzNWZTdOTWo4bUlKQVpkVi9KV1VkR211?=
 =?utf-8?B?VmVUWWJMK1ZnU3NOT1NvK0xFdWFOVlMxby95c3EyYi96ZGtmTVh1TEpyOXJP?=
 =?utf-8?B?V21FeUk3M2RGYk9GZ1pVdnVmT2tJb1c0YnhkKzNxMERZQmwrbXFzVGRVQk4z?=
 =?utf-8?B?bFZrYTRXMEE0VkZoVE90a3VPUDEyNDJNYkEybnAveXJieDRMZ01ybTREWXBu?=
 =?utf-8?B?RmFaNDN2Y25LUExLRkRMc2JFbDJjbXYydGVvRktnQ25SM2VPRUJ1djI0Ym5Q?=
 =?utf-8?B?MUVacTl1RTlOU3F0OGZ3di9paFNUaGFKc0d2L3lkcGVlWjRLR1JCSGZtK3B0?=
 =?utf-8?B?OGtoZW1sOWlRRFpWS0VpSEpHZ3ZzQzZkNW80dE5Ma05TUndPeWhZcm52dGVC?=
 =?utf-8?B?QnlQVVhjd1VDYmlhaFNqeFg1THQrcVh3T3RJS045TGluTTIwaDBnRjM1UXN0?=
 =?utf-8?B?eEY4N1NXaUk4cVRIK1RFR3Qwb0VlT0FOR1V3VGRoMFVKQ2NmTFBOdkFYMk5K?=
 =?utf-8?B?d3lXZVRwM05TM1B4Y21MYTV5MWpaakkzajhOd1g3MDRRNGZWaThKaDI4SG9O?=
 =?utf-8?B?VW9vZGxBZzBSbldzdTF0MFI0dUpWUVZZS3NtRnUrNUswbDdLcldMT0JEL3JT?=
 =?utf-8?B?MFAvVFdkekM4U3JTVWhrYWpueG5PRjNzL2lXNXhWU3dPaXlZbGZzd2dGY3J2?=
 =?utf-8?B?Y3pYZThPMnI1YjZoa0JWdFErWUo2aGpkK01YMjJ6ck5SSm9LOWlTbCs5VzNL?=
 =?utf-8?B?TWNJYXErdTIwbS9VeGZyR2wrTXBsY3hGbG5HamFXR0dETmdFVW9teXE3T1VO?=
 =?utf-8?B?RTIzQm5hQnNJWjdhOG5sdjlTYVorU0Jjb201ZVQ5V05aRGN1MWl4bGZPSk14?=
 =?utf-8?B?T3JVSFZxNUNSTHBsc1hhWTU5dkJLL0RqT2ZNSExCbHUxbzkvVEVZR0hsZ0d3?=
 =?utf-8?Q?fExBsuW2fXb47kBH3nrVTiU3S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5a6c73-d973-49fb-84ac-08dd2ed86872
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 05:01:56.0585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPiVmLKrhDzups+lwTX/G24RSb2cUn0OXSBIFucS8p6pgcowGyyMhzWtsT1PNJmY29nJp/cMxMihqycogBHFnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940

Hi,

On 11/27/2024 12:42 AM, Bjorn Helgaas wrote:
> On Wed, Nov 06, 2024 at 01:16:32PM +0530, Dheeraj Kumar Srivastava wrote:
>> Rearrange initial setup of AMD IOMMU debugfs to segregate per IOMMU
>> setup and setup which is common for all IOMMUs. This ensures that common
>> debugfs paths (introduced in subsequent patches) are created only once
>> instead of being created for each IOMMU.
>> ...
> 
>> -void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
>> +void amd_iommu_debugfs_setup(void)
>>   {
>> +	struct amd_iommu *iommu;
>>   	char name[MAX_NAME_LEN + 1];
>>   
>> -	mutex_lock(&amd_iommu_debugfs_lock);
>> -	if (!amd_iommu_debugfs)
>> -		amd_iommu_debugfs = debugfs_create_dir("amd",
>> -						       iommu_debugfs_dir);
>> -	mutex_unlock(&amd_iommu_debugfs_lock);
>> +	amd_iommu_debugfs = debugfs_create_dir("amd", iommu_debugfs_dir);
>>   
>> -	snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
>> -	iommu->debugfs = debugfs_create_dir(name, amd_iommu_debugfs);
>> +	for_each_iommu(iommu) {
>> +		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
>> +		iommu->debugfs = debugfs_create_dir(name, amd_iommu_debugfs);
>> +	}
> 
> Doing this setup with for_each_iommu() precludes any hot-add of
> IOMMUs, but I guess there's no indication of hotplug support anyway
> given all the uses of for_each_iommu() in init_iommu_all(),
> amd_iommu_init_pci(), amd_iommu_enable_interrupts(), etc.
> 

Yeah and here i don't see any concerns with the approach for now. Please 
do let me know if you have a better way to do this.

Thanks
Dheeraj

>>   }
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> index 43131c3a2172..d78dc96bbec3 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
>> @@ -3377,7 +3377,6 @@ int amd_iommu_enable_faulting(unsigned int cpu)
>>    */
>>   static int __init amd_iommu_init(void)
>>   {
>> -	struct amd_iommu *iommu;
>>   	int ret;
>>   
>>   	ret = iommu_go_to_state(IOMMU_INITIALIZED);
>> @@ -3391,8 +3390,8 @@ static int __init amd_iommu_init(void)
>>   	}
>>   #endif
>>   
>> -	for_each_iommu(iommu)
>> -		amd_iommu_debugfs_setup(iommu);
>> +	if (!ret)
>> +		amd_iommu_debugfs_setup();
>>   
>>   	return ret;
>>   }
>> -- 
>> 2.25.1
>>

