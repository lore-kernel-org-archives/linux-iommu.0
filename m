Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A8323E356
	for <iommu@lists.linux.dev>; Mon,  6 Apr 2026 03:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775445972; cv=fail; b=j1Bdtbb1sgrmqnC+LBo4VUuWwdt+ILNHBNf/FTXGEuuKYx1bGdNs1OngiYYogBTUWhMnSvGaNhJMTRL61fOQ20VyZG1AArsLUnsz7ZE5oT2xGA4pPtonbUI/m3IecpYX3RFKVDhovQ2Q/XNr3DZ55pB8pUA9c22CwQHorChDelw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775445972; c=relaxed/simple;
	bh=qvMT//sGrCH70FdI5cn03ov3E8C043MbbCJS+pPFL2A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aV8GgUD4Gs/XhcIIX5Q03xzol/MC0lZNALT0JsjqIqZ8c8Tix+6QM5VwB0Fk4PMPM1P5MmZNCeuyNK2qL5xnBLxRftsatWIJVjI1MI4lav87e2V1RQp4Bx4YPspV2RDyv6c6SpQx6Q1JDUwm5CmN8xbUnpHcPjqXxArroZGBMcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BUXh2hsg; arc=fail smtp.client-ip=52.101.48.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BUXh2hsg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmLVZU97OvTINxd+8DbxkizN7xq/HoxhMSpxs+7K94gLeaKdsJvVlTTirMJmvwB06LrZdpp/czWzpN9mb4oql24R0Eh13vmjEQHIQokZ28tCWlvJ0vnAiAh+ErF44OgHLYGDy1+hv+y5nld8eC/i98WTXy3QdpyJ8vaoDhWw67xuP2RNASpQKKI1WpUT4LMGkrm2xd5/ndwfiW5e7m+rQZjePspUuHNVvCaI5YXqYKokrEe+FiUk27Bf1NBOWtPKO89THV6CEessbAwfuFzEcRXzxuzqIeuPb/aSIaHc3KBggxQ3xKx+jkLKovf6ADhwmc/AUxgP5NJwlBMx3+tjUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBkM6ZqmO5za3L+RPa49f/xsWwNpmyUuJCRUxFyoXbY=;
 b=FbVHLaYzobcblG3mEmLCWdy3yQ+b/O+1Dn8RXZ0LurF9v+xKz9B/TS92RLn1+FPVWRgsdzyjNbnkMHLRRemoe4PlmiIyqY15z0igrlNH3m023eCJUi6HtPYP14DY99bj3PAVCpfIxPBC8ugTndsJx9aUiU+dl+11uaFke3Ed0HZUZUxMb3cPluY4P90wZjqRAOSebmt32l+nQD8owp1e1M8lLD/zj+0dJGUt0oDf57U5jxFoEfHHnW0VgM0C7ruAxORCSjUJcKhQJk3Xm8GcoxjSpS5+YSr29ne9DDomDjHz9BqLn0PA9EMxCk2W8lZS+ObwsBHsRMuqtKZ4+1NGcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBkM6ZqmO5za3L+RPa49f/xsWwNpmyUuJCRUxFyoXbY=;
 b=BUXh2hsgXEqTn+o91guybjfsfuerXjLhGySuo5ZE9KB1K5SPtFbqqb0VM6Vd9cOIdQO97uFVvA+1rPb4a4jdfQv8oS+NQhtc0GVMM3hx/NQzaDEcl7wuatr8rtkSG/PeEqyeme8Cg9zYI9wpAeTWGbZpW6Cx6G5Yw7sCYFI62pE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 CH3PR12MB9170.namprd12.prod.outlook.com (2603:10b6:610:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Mon, 6 Apr
 2026 03:26:08 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4%7]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 03:26:08 +0000
Message-ID: <b672226b-1853-412b-b3dc-882d23c11dc3@amd.com>
Date: Mon, 6 Apr 2026 10:25:58 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/22] iommu/amd: Introduce vIOMMU-specific events and
 event info
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com, yi.l.liu@intel.com, kevin.tian@intel.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
 wnliu@google.com, dantuluris@google.com, chriscli@google.com,
 kpsingh@google.com
References: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
 <20260330084206.9251-3-suravee.suthikulpanit@amd.com>
 <acpDvyrd5Yz/luK/@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <acpDvyrd5Yz/luK/@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0240.apcprd06.prod.outlook.com
 (2603:1096:4:ac::24) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|CH3PR12MB9170:EE_
X-MS-Office365-Filtering-Correlation-Id: 98fc64ed-16b6-4dcf-60bc-08de938c3de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XEiU/mfXrf96P+HSwH0ajvIyymHvJToc4fGFqYLsj3GVF0RY3zrkogDJmkZX3CKctaTztEePS1efzKvDpbo4AhrNNne9F01OD1Wa9aHtZhcuVDzoUlNPbuSxis4VvIma0F3sZG4y/qasTb9xqZEWo0KSFVOPsvZq6nAKVfuoFzVBhNljGNdoOEFN3yeMdPyn4vYxmzDcarPIK+MY7I8E1S7lduskjGpOM+A0zNhJoe0Z2CV66XR/kdmy90Qj2RKc3l+59eEzC3gsHOu7DwiHSc4xBmcf9YId2DPCnfdSV0/WjBmpTY/kJFxFIKqsZgXKIPHBWg+UaxLtPDLbZgscUaObffKoEvEKrXn8Ggbd93PM8Fd+npavMxbCAwEDt0Ss8Sw7WtQ67C/BGss/M5VJJ38/02Lul+LmysgwcwokmrIj7/IrPrFYh85oB7+yWyVsKToDIlf4r6UJrb4GK7nO8Rw8nWjgkz/1oCDoHM8Oif2Mq01ieaNAt/P4Qq4MP/UUvDP3xcDoomxDMSy8vEKVYyTMD9mCWtMhySu+UTRVM2pxfg3KtcLVHyT/NTbFUiTi2hTHMprbnR/XA3GNmodNRT9ruDArOth02ScnohiybeMtaPrpp+vYHwR3Cty5817LVd7jW9nSYcKqQBFNtKloMctXQ2Auq3mgwBpV+0gQe2i9P1IB/eyYMBeAPafL+ENeFn/fsMINiuwO0KLK47ZiYjWpUKaiqRhUNI31QxWZXH0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VE1pTzZENFhwSFJkU1JoR0xKdzgrMDVlcVJTWU9DL3ZJRDVsamxabDVTdFBq?=
 =?utf-8?B?bm1YSlcxdjN4UFBJbk5wZTdiN1FxMmNRTjN2QUgxZXNkdFQvMGI4QldaZ09I?=
 =?utf-8?B?SmNVNE1WQks5VEZKREFGMndlMHA4ckRxUW1jKzNWbDRXUko5eTJadGZNVlFN?=
 =?utf-8?B?ME45MUpQN2lUc29zWEl5aTdoNWFZYU9sY1pLQ1NBSWx6UnQ2aEhtVC9WY1BJ?=
 =?utf-8?B?QzRweUtRNEkwVDR5dUxWcEVMZDNxZUxJejYyYklBK2VOK2tWRXdtclFpeWNU?=
 =?utf-8?B?ZUVlVXdIQnNZMDdLNWEzK000djJjSnoyc0QrV2JCK3hZMVg2MXIvZDBHOU9p?=
 =?utf-8?B?b2RTeVNzbkFyTC9WY2VlV1FTMXhZOUc0REg4LzlZdGwyNGoxaGpwakNUc3oy?=
 =?utf-8?B?UWYxeDRVbmlxUmhzVEIySmxWc1NLbVVyei9XdkYwSE1pTkVDMW9oQWtVMU9P?=
 =?utf-8?B?K3NSbnJWRE5PaWs4NFZ1V0Zub1laOXVwbktRajhDNGVlMFQzN2RmVm1wK3h0?=
 =?utf-8?B?dXdUN3pDRm5EdmpJYjZEbUlJcVJERS9hV1RuRjhZU08vbSsrZ0draTZ5L0Zl?=
 =?utf-8?B?c29Hd0JFVmNJVGZ2SFVxeFBZNDBxQzFyNjZpUGtsZkNFd3hJRG5TNVNSTmxm?=
 =?utf-8?B?S3FzbXhHczJXNjNJcE1oaTkvV1FlM0thakF3bVcvNGlKZXhnZ2tLdlBoZlQ4?=
 =?utf-8?B?SjdKTzRMbjg3cmNtZWI0cVUxWHRSVDJKNjB4cWw4bmUzcTNYQkJpVEp3Y3ZT?=
 =?utf-8?B?TFdnRTRjcFpEVUt1VGtHN1NPditOQ1U5bjQ3Yi9KRFhPVWNKdWM4OFN2Nytv?=
 =?utf-8?B?aGRocUhwSVpNOVZXT2FMbFZyekNCOTVvdTVEYWhCeFdOKytNWFF3VmZQcFh2?=
 =?utf-8?B?Q3JVUE1ZTndEQm9sQm05czgxbnRUQXQzWk9ZZC8yajdEaHJhNk9oK1VsdWN3?=
 =?utf-8?B?RVRHNTVyMlVPdnhIcnNkS1R4QlFkQWNGWFRhM1Q2Y2RrZkZTTDNrVnIyOFdR?=
 =?utf-8?B?aU1GV2tERWJwck93cUg5dmNOQ2NJaHhWWFAvdWowbUo2QnhZZi9UV1FZcU5t?=
 =?utf-8?B?Z1VQU3hCalc0dXoxNE5tS2wweGFRZ0d3Vmh2SVY3QTNlUzdsSzhWY01PZG5I?=
 =?utf-8?B?WTlwWlYxbzR1Rm9EK1BvZVF0bU1HSjZWUjJUWGdrTDNsemV5T1JPaGp6eU00?=
 =?utf-8?B?ME9ZS0RMSHNSbnAyUURvYzY3WC8wZ0NRTnNxK0dka1Z5Vkl4aVZ4RnZtTzVB?=
 =?utf-8?B?SjdrS001dHFBaUt1cWExN1VQRGVYWFhXRzI1VVdMa3FUbDFaNS9YUEptejIx?=
 =?utf-8?B?UU1vamhGK1h2ZXp2T0NlcWpMUzlzbkZST3lyTFZtaW5hK0k5YlE2V3NCdFRy?=
 =?utf-8?B?UkRPRWU1Z0ZicjdUdzhRZFdUV1VWOE5NSS9QOUtZM3laSTZaWTFOQ2VtUk10?=
 =?utf-8?B?MGt2VUIyeWJ6elg4d3dOZ1loa3hzMnB4bDQ2ajhoeG5QaHk3cHE0QzV3dmZj?=
 =?utf-8?B?NndacUF6cWJ5K3FoR3AvWjY1RWYvUTlPT2dtd2JlY2grMEd0YWJscEh0Ukpn?=
 =?utf-8?B?SzY2WUFOVUtTZE9JOFFjbDVBOTJPZlo5S3cxa3JFRkdGeG5HS2ZaVDJPQU54?=
 =?utf-8?B?TVVHajJVa2NNL3ZaZjA1MXBCeU4yaGhubGVBQmFEaXA3Q3RERUMzMERyVk9S?=
 =?utf-8?B?MW9Mc1BvakVKSTZDVmUxVVBjVlIvREJ2STlCbThLVHdWTStXamJiR29FdlJu?=
 =?utf-8?B?dzl1czdrbEFZdk0rQk1TT0R6OTBzNlFmbWF3VSsrNlE4TzNKUEt2cW5RTDlp?=
 =?utf-8?B?S1BVVUo5MnhoSHJxbTQweEFONUlvd1NDVWpiQktaWkRnanpNQ1RCUHRLWjBz?=
 =?utf-8?B?UTBTdEZ2RHlicnVETEtMcDdudkl5c2RxbjBiajF6SlN4Wm5ZYVdDaDZvVGFE?=
 =?utf-8?B?cXdkTU1XbXRjVTZFQ3dhbnFSUjZ4T3hzeUJ5RFl1bXgzSkVuTEQwUnpDcnVa?=
 =?utf-8?B?K2hpdDQxa3NxaGpTSWdMQ2gwZmFkWkFGWXFzcE1FU0VQQ0Jadkc4S043c1h2?=
 =?utf-8?B?QVdldlc1S01iMzFyY2VrSk4rejlTMnNlTVpkNnRtTDd5RGVzcDJZcmNBakRQ?=
 =?utf-8?B?YU93cGFtQ1EyeFVEU0txVUgzRXlVWkllNGJkbnBjYzJQbnBvaC9mSWx1Nlcz?=
 =?utf-8?B?K21wVmdnTDlYbFRxeTBCUUtVWE9yTWpubDJGdHNsWW9NbktVcjJGaGdQVTdx?=
 =?utf-8?B?N010UG9hdnZ0SEJGSCtGVFM0dUxaYVdpbnVxZ3ZBb1RaUmdTQUUyYmFSZGhS?=
 =?utf-8?B?SlJyZlo0K1AyY0VtOTVwV1hGNk8vRHpWcjArNWxucDdtNm1WNUJkQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98fc64ed-16b6-4dcf-60bc-08de938c3de9
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 03:26:07.9256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3eK5iNMuHZFbH+WkmFq5kP7/E1pcELgy2uO/SPtAvpg5HVQuJWgUUBCR41+V42cGMiFGH8rtmPmTAc6r0Ip9mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9170

Hi

On 3/30/2026 4:34 PM, Nicolin Chen wrote:
> On Mon, Mar 30, 2026 at 08:41:46AM +0000, Suravee Suthikulpanit wrote:
>> @@ -927,29 +927,42 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>>   	}
>>   
>>   	if (type == EVENT_TYPE_IO_FAULT) {
>> -		amd_iommu_report_page_fault(iommu, devid, pasid, address, flags);
>> +		u8 vflags = (event[0] >> 27) & 0x1F;
> 
> Hmm, I don't see this vflags field in the AMD vIOMMU spec
> (48882-PUB—Rev 3.10—Feb 2025).

I have checked with the documentation team, and they are in the process 
of publishing the new document, which will have the information.

> Anyway, perhaps define a pair of SHIFT/MASK macros like other
> fields?

Ok

Thanks,
Suravee
