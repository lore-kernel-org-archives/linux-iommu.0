Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C882BAE1
	for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 05:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718862855; cv=fail; b=VY5UxVAHb/qWm3eQVEU+jH90GZVpFvP44myP1wC/aMBfjOXkW6lt1hPcoRaDopC8gypzxX6yui70sDSZKM1QOM4VvyBaOoZ1sE+hCjA+Zt2qt6g/Awj38a5Um1WIlVFQ5mIWdHjUXAA1/I3ryT09xv7oEnIvqEGgK1zTezojTqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718862855; c=relaxed/simple;
	bh=KJTkyK4gCvk4o9zdonzlX6vyzzfpriBD/U+2iX39H/E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cwLIO6S62yLKG8xZphzYK60FKaQYLPlJaqCSagwu8hC3nb7YOyg5TquMWz7jDt4JKFEJtSzy+sIPoxlgPZJHHQHAlub/LPXV4Qk5LVUQZE/5p7J8ykyh9WsA4hk8AeRwNlqyWB2REC1hbCtAfqV/2K3F3Lu3H0+Uas+gmANIZP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bb7GplBy; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bb7GplBy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArGKBWaz6ChZvPvD3lqJIGxI5rstXUioRnVyfoKnS3beUrTYEVLqiL7pks8EBFplD41x0ydBIvIzER0Ivf1/xqRgoeqB4bafm0bbBopHGqd2Ks1HX4R2Ufyu4dI7D0KgTXBz+I0Mg5+ch+qqGetq9OOR9ahEknYoE6vPwdG6GrywKRxNU5g7d5DQHicdkqoS9oqDWlOMaImnIFPyHbevhc3SHmefrKv3cffdhMALSLs9mQbQCJhActVNEJdUc2iKEf2AWKybY+fVOG13J7BWq3s3lyzGzih+TzexbUTfedfp+JaPP4jpqLgtN5FyORzxmao2GzxAukyw1mRHyFJP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUSRnrKOVqdC5dw2ThrZnedWjjo1Mk0mJ6GHjeVUclo=;
 b=fNQ8J2S7r5YyLGfnaagl7ZRoAL3m/V1dCuXlrZGHGx9PDyQXxWJpP1KyKzXsPXA4WEuK0K0AhpyN1H26kMD0/yF6uEKBdRP8EW8Rpqvj9GqPMCnmZ6iBBHl0M4PSZqDB488QQQpuUQ/khyDBsaWHaaGwHTCq//+mPpu8bZ1M8FF1W7zXSPpVQ+lcPWkJ/uF7hMKCpYcBVff23y8UXh6euJItFRC6bawOJAc40rkQJlN5V8x+BvU0IogqBbLcvj7YmqHofBO6M+0o7161SdyU2W6M39X7HxnU/N2Js2cRZG5qzaYt01r8dashIk6Qf6+IOg9PHh2o1DJeyLX5ollGoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUSRnrKOVqdC5dw2ThrZnedWjjo1Mk0mJ6GHjeVUclo=;
 b=bb7GplBy7XCJeCvIEsZ8heV8x1JElHGNWkf9BhigWGxiW1tb6vOS26R4f2KL/HFpcKVEKjD56U7SQT5lA0pyn9XV22Rs2cyjGuVS9N/tdSuWbAZ2PhxvUnSYGxkZMBRWE8yBcPagU97cGGEW+SXYUeo2u6t6oWLGhHhMd0GarOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 by DS0PR12MB7557.namprd12.prod.outlook.com (2603:10b6:8:130::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 05:54:10 +0000
Received: from IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::73e4:a06a:f737:e9be]) by IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::73e4:a06a:f737:e9be%6]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 05:54:09 +0000
Message-ID: <bdbb40da-faa5-4321-a58b-5fcffcbc818c@amd.com>
Date: Thu, 20 Jun 2024 11:24:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix missed device TLB cache tag
To: Baolu Lu <baolu.lu@linux.intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240619015345.182773-1-baolu.lu@linux.intel.com>
 <20240619164620.GN791043@ziepe.ca>
 <1dfb467d-f25a-4270-8a36-a048f061e2aa@linux.intel.com>
 <BN9PR11MB5276F76798E61D231D861A2F8CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
 <976d4054-6306-4325-a112-5cf69b0c6f34@linux.intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <976d4054-6306-4325-a112-5cf69b0c6f34@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::6) To IA1PR12MB6043.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6043:EE_|DS0PR12MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: fb2bbddd-45ba-40bd-b884-08dc90ed675a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWMxMHpvQUt6dFNvSWxPTWdIcWVGeGtSNVp3d0xRQndzV1NUVVpXcmRZVGcy?=
 =?utf-8?B?MlZRRHplVEx3bzF2amY2ekx2aTdKb2E2QXhIcHB6TXlpVGEwTjhMSk04K0Jz?=
 =?utf-8?B?S0xqenVKVFNTcWlBOXpDcVFxVVNGWFNHR3NFRmZIK0g2TlJyNXNBSkVjVjhW?=
 =?utf-8?B?ZHl3blB3KytkT1Q4VzdtKzU3V08zalY4eEYvcUJhVUY2a2FiaW5YS3BQQmli?=
 =?utf-8?B?cjBNTmY0bmVhZHBaZ01UbVhMZUZ4akdPb0ZxWkZCc3RjRm9yK011MkI4WHRF?=
 =?utf-8?B?UnRuQWpvdElJRkF3V3FUMm52R0ZxVnowYVN3SHZ6M2pjTnEzOUNJN0k4bWtS?=
 =?utf-8?B?QlV0Z3hIa2I0VkduNG50cUhnNG1IWjFDRHM2anhqbWRLZy9talJKaGk4UUJR?=
 =?utf-8?B?Rjd1a244dkNPN1FLSmlMSzF0ZVpJdzJyVmFTVnZqWkRZRWRidnh4K3FFL2lL?=
 =?utf-8?B?QWZ1dXBqRUJqYnRVNTRSdmxUMWRDSXI0STc1dk5lYklkTFR2NStZWFNBV3Bq?=
 =?utf-8?B?S2VhWDFKcWtwRS8vb2xNNzJJc2dRaEY0eXdLSFBvRkFrUFFaQ0dldXU5bmdk?=
 =?utf-8?B?QUo4YU1ialVwNTZUTTYybUhmcXRGSncvN0xWWXA0RmJrdFR4L3p4eU9xbVox?=
 =?utf-8?B?TmVlMjFvM2tBcDlWb1dTbFUvbWhXWDI1dEdHaEF3aHlua2VQMkZNRzhHekwy?=
 =?utf-8?B?ak1Jdk1hWHg2SXRiOFpJSHJ5UGRiWmc2c2ZOQXhwRGlBMW5SYkdxTkE0V2VK?=
 =?utf-8?B?M2FMRzZEanRQSklTZE9Ha3FXNzZJM2YzYnZSSTZMNzc1djNDNjVqeldGN0tQ?=
 =?utf-8?B?Z21VMlBCSUtDdnEzZUFkZ0xYeVVrd0VGeEVXRDF3KzYzZVpKR1VqeFVIbzRF?=
 =?utf-8?B?T1owazk1UGgxQjVIb0FVU2hwWDFtcXhEK2NoT1M2WVdJWC80OXM1dk1yY1hV?=
 =?utf-8?B?QTNiekppeTVNcDZTbTNpMGJoSVNCUHlpdTZoLy9ObnlqZWU2VE9Kd2s5Z3RB?=
 =?utf-8?B?ZjdBaHRJc0I1MFN6WDU1RGFZY2p0NWNGMVNldlpYR2NnUHlyaWw0aG1kVEtI?=
 =?utf-8?B?RWVtb3dSaWRpeHZDMmNEVUlZczFKSUF2V29ZRCtyQzlYM2MzRzRxWDI5Zm5C?=
 =?utf-8?B?WHE2d3RxYisxczhqSEZGTkoya0NHQ05FbmtrbjRvZER2REtrTmJxRW9LaUR6?=
 =?utf-8?B?VG1wanF1c3FaaFZTUW8wK2xaSjRZQlY4anp1U3dkRzRpdDQ5QlN0THpWU29V?=
 =?utf-8?B?QTRrdFUvUDhFZkZkTW9xRW5xRjIrNThTV2h2MmFNWTZTSzBkZWZYMFR5Z3FE?=
 =?utf-8?B?UTJPbzBEaFJrSFgvYWhwb3hJNk91MXFqU3RkUWM3Q2dzNkwzelFRK3dVVkw3?=
 =?utf-8?B?VVQyaTNrUHk0ZmNEbjMvQmp0Q0pWS3B4NkJ1cjlsWDRJWWo1SXZyNE92Z1FO?=
 =?utf-8?B?T3d3Wk5nbnNMOTMyaC9rUnpRVEc0U3Y0VWFiSTRYRnR3VVh3WlRjaU84dkFh?=
 =?utf-8?B?YUxMT0xXMHZvbE9td05FNkt2czhhSThkSElqaDRiQnlQbHNJMjQzanFGekox?=
 =?utf-8?B?dS8xaHNRcUNCMS9wMEJsZkVZS0FpMGZPNnc4UW40MlRoUG1FV2VXL2xQV3dW?=
 =?utf-8?B?WnZJYUpvako3enBDY3VEY2xVNUd2NElZNWE5RHRBSE51V1pwdjRJT3d2YnlB?=
 =?utf-8?B?UmYvWnd4aXpJcWVQSmNWYnhLYjhpRkQwWEVFeDEyT3ZvOTdqbStPa1hHYWZx?=
 =?utf-8?Q?HORd7HJOIahUJ1oeR+7khqFZrCigLbaJsoeYXsp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6043.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bktkbHZjbUNGbm1MK2J2WUpEWHZ5Z29LT1Rua2dzQi85RE85NmhKWURqUU5u?=
 =?utf-8?B?dkZ4cjR5cG45THAxa2QrdnBicjFtN1FYUGxTOG1oNjFBNCthNUhiK2lxZmpD?=
 =?utf-8?B?akdXQmV4WEpOM1I0TUd0eWZpVmhkSDZZWElML09CNjJyOVdJay9kQzB3NDhP?=
 =?utf-8?B?Wi9iUVlDcmRxdkZVaWFoOTJnckdpblB1MlBHcHNidFZMZUpEQ0xvK0p6QzNR?=
 =?utf-8?B?UkhwcHlMb3gvZGliV3NHMWUxd0NzNDhhem0xUExLRGhZbTZlSG9UYVo3VHRy?=
 =?utf-8?B?YkI1Vk5vTnBmOGFBZ1FZamFZSjRVcmRYRW95Q2JFcU1xRHpNTCt3T1JQRDUr?=
 =?utf-8?B?Z25TS052KyszcytwUTZLampWN1JuWWlIWHJFVUZjdmhjTlBOQlFvY29VQnhO?=
 =?utf-8?B?RFl6bnNnN0dCRW04ZVVPTnhwb0N3TTN6aWVOY2F6aUhjT3lsbjhBU0FDNGlI?=
 =?utf-8?B?U0toalFCRFp5NUNLZGlpUmRqZ0lqT2tFUk00Wk4xTHBRMTVuRG1TMFRFa0Jt?=
 =?utf-8?B?dG5CZGEzaCtRZisvOHBYQjVwQ2lsaHRkYmhDaUFZTXBKQ2d5ZVJxMmFpTE54?=
 =?utf-8?B?SzJITXJoRHllMEpkWWdRZUxXMUZSTW1id0hWR2VvbXhBb2swcVdPWGdnMStr?=
 =?utf-8?B?RldvaThBbURHcHZpUjJxTW0wcG9EZjRzSG5RbE1HMk5CQm1SZTRUZi9adjlX?=
 =?utf-8?B?Ukl2N1RuUHYrY1U4ZmRoeWcreTJwaXVMTFJsYnJNK2NOTHJpRC81dDVuR1p6?=
 =?utf-8?B?WnJqYUd6a29aNHZ5WmxVR1BjdENFS0N3dmZ2Z1hMR1ZGOHJLZCtjNDd6dDhN?=
 =?utf-8?B?VDFabW53QW56U2Z4dzdIbCtJU0FJTWtiYlZRUVNLWEg5TmNXOFdHdk53VzAx?=
 =?utf-8?B?Z0JIL3JKeDhMQ0RKMGlERzNYRkl0QVFDemh2U21NS1hEM212NXJ3eUFVRy9E?=
 =?utf-8?B?WGxnTWYyUmV6Q2tBVXl4dnpSVXNzMTBMNlp0dWZWYUdUcEpEamhYZHVFWlM0?=
 =?utf-8?B?MThRaUd5aUhBaUp4OVVnVEI2bG5uOStoNW9pazFTZVdPMmNYanZPVUdsdEJm?=
 =?utf-8?B?SUkrNEdLMktrSW5OTzgrbUdIUXY3bkFoRm5Dd1dDQUNEZ0pBQzhwZmt4a29a?=
 =?utf-8?B?VmxsdnNkK25JKzk2QVlPVEJwMEJVSWxSMmxPL1B0Q3NibDVYcm9xaWdTY0oy?=
 =?utf-8?B?MlZkV3ViV09QYmIzSnN1WExPWWpEa2hidWg2TU1nV0pPRDhhL09uZmlaOXJa?=
 =?utf-8?B?R3BmckN6eTJBeWg1QWZsa2FIVUxtVFB3aExDZGtGU2pUY3h4cTN3cUh6VU90?=
 =?utf-8?B?ZjFrOGUxSDA5Z2F3ejlJV3BlRWJPbUpIUVA4aUYrOWtKMTN6d281a0NyeHRL?=
 =?utf-8?B?V01IZ3NCeVFUMkhtdUxGV1RkQmErOTJhYUFGUmZ2T0FhT1RGTm1lK2FEa2dx?=
 =?utf-8?B?VDlYL3FVLzJDVC8veEdoejVQVUhrQ1lMWCtzRUpZcUpzNUthaWJUTWZXRlND?=
 =?utf-8?B?eVJaS1czZEpSV3RRTVNRaktrbWx2MU9TdTdzODhRem5TaXdTczZ0M01pZVNR?=
 =?utf-8?B?aDEvWTE3bFR3aDZXVkdyZUpwVTVjYlowM1VWc3JzVysydjlIQnd3NHRjckM1?=
 =?utf-8?B?dnNyV2NKZThUamhhUkVmNWUvcnJOYzBCTFhQSko2OC9OMmt4aE9LUldNRDBz?=
 =?utf-8?B?REtTLzlKSkgyckh4bnA1Umt2SW9ramJKLzhNZ3V1RCtjaDRXYk53TDU3ZDFp?=
 =?utf-8?B?OVJka1JPenl4L1Jaa1FLQk9rRmR2RVAwWHRqc3hOTTh4N2tGdXBsdXVLandG?=
 =?utf-8?B?dFdwc3RzcmZ5d0JPMlFpTTZXeFA2a0kxditlR3N0VnF3VW1WbTdjc2d0ZUhm?=
 =?utf-8?B?M29ScWFVRyszRFRuSVNsLzZENEIzM01LM0I2SUJwOGd0dU5uR01sS0Z4MHR3?=
 =?utf-8?B?WTJnbmpOaEJmQllMRkdVN0x2TGw5czZXQWxOZUREc0RBamI2N09jTHlZNFhh?=
 =?utf-8?B?RFdQZmVEdmJCa3J3cUZSQVhvQW9VcWY2V1FZZU54Q1llbzFmZzlCYUE3ckk5?=
 =?utf-8?B?T1RSanhZZTc5ZC9Ma0JyVkZZWkZOWi84Y3loQnFibXVXZmRnK3d6OUQ4YTFR?=
 =?utf-8?Q?zqSrqEX0n2KVo/i6JBy9pnF/v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2bbddd-45ba-40bd-b884-08dc90ed675a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6043.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 05:54:09.8473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R23p6Ci98wFsjpQ/F9ZhFYomvf6iODsXFRhuLe8DgunatJqkhEMHAwO/RjgmcYL1yLk0LLMon9tr2+Eb9I+S9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7557

Hi Baolu,

On 6/20/2024 8:43 AM, Baolu Lu wrote:
> On 6/20/24 11:04 AM, Tian, Kevin wrote:
>>> From: Baolu Lu<baolu.lu@linux.intel.com>
>>> Sent: Thursday, June 20, 2024 8:50 AM
>>>
>>> On 6/20/24 12:46 AM, Jason Gunthorpe wrote:
>>>> On Wed, Jun 19, 2024 at 09:53:45AM +0800, Lu Baolu wrote:
>>>>> When a domain is attached to a device, the required cache tags are
>>>>> assigned to the domain so that the related caches could be flushed
>>>>> whenever it is needed. The device TLB cache tag is created selectively
>>>>> by checking the ats_enabled field of the device's iommu data. This
>>>>> creates an ordered dependency between attach and ATS enabling paths.
>>>>>
>>>>> The device TLB cache tag will not be created if device's ATS is enabled
>>>>> after the domain attachment. This causes some devices, for example
>>>>> intel_vpu, to malfunction.
>>>> What? How is this even possible?
>>>>
>>>> ATS is controlled exclusively by the iommu driver, how can it be
>>>> changed without the driver knowing??
>>> Yes. ATS is currently controlled exclusively by the iommu driver. The
>>> intel iommu driver enables PCI/ATS on the probe path after the default
>>> domain is attached. That means when the default domain is attached to
>>> the device, the ats_supported is set, but ats_enabled is cleared. So the
>>> cache tag for the device TLB won't be created.
>> I don't quite get why this is specific to the probe path and the default
>> domain.
> 
> The issue is with the domain attaching device path, not specific to the
> probe or default domain.
> 
>>
>> dmar_domain_attach_device()
>> {
>>     cache_tag_assign_domain();
>>     //setup pasid entry for pt/1st/2nd
>>     iommu_enable_pci_caps();
>> }
>>
>> seems that for all domain attaches above is coded in a wrong order
>> as ats is enabled after the cache tag is assigned.
> 
> Yes, exactly. But simply changing the order isn't future-proof,
> considering ATS control will eventually be moved out of iommu drivers.

[Unrelated to this patch]

You mean ATS setup will be moved to individual device driver? Is there any
reason for that?


-Vasant

