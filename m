Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013008.outbound.protection.outlook.com [40.107.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428651F427C
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615712; cv=fail; b=ki4coOJs+pHwbMrYI2XV4prm21IS+aB5TsF2kZuDQyRdhCG7NOyHol/bJUv8Tb2ljwGoGB2XkWJegDXYl2zeV/0vYcEMhQttuCugS6iTKIyXHQp1bGkynLKPpI7uyM4JeDoj5/75bA45Saf/q4L+MVORze9JqucULyRHaBN91eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615712; c=relaxed/simple;
	bh=NEEr3v3NUL6UMKxHBUFwiSoc8ehie9XTqbg4qP20t9w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S5bJ7TJc6dmwxTVWjwFR579hIIRdNJgHa/0QmcQg/vRBlN6op/tjfiiuMajgJtU8kRMkM0x1LrG1nXFyg0p851gX3sl3ojRoiR87kJwTVFprSduYX9U9S5XZX034UKapj+y1HNQRzChS+rRu7qsq+B/kEAvFcs2hT6w7lbt+xe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U0erKL0t; arc=fail smtp.client-ip=40.107.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U0erKL0t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bxx/mPe3UXgr2HH1DvLKsEdvF6ZHZzugUBwaCUa3qYUStAMxB8xlUrANOHNpbtZp16BKqdEWxeQEKdSk1usfnnLfqjn4xtaxZ01DkUJjvz6XRHO2T/lznK+kWzIFsmiLk24QzHqWPBEqv6QW+KZpMYO/miYyuDL9p7cPlPEx3cn9hzcLueg8g2AYAnTazqninHbvBoe9LPlnFBL1fzZVmF6iCIqUh9zFF4lTpeu34Dh4aKgrSwAxT935WIOWLrE3YSt1EivUNgodTLuxj97zIo3wYp1osQ/0727vAaQpBThnZtlAiDCMvIOAJzvlCGtquQ3btJgpeo3zAm1IxPHiag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJQoqSEPZFOxU9SKlrmeAOOR1/x49yTJvh+LjkqYq/4=;
 b=eFy0aX2+5+ZQMECN3+vCmAW9i+lhFQ/DNWZX+vr8ghnXnRAflfxcDFstLI84pEDFQ+oZOXWzRICrjh/8rhuLk3TdIYTiG3wYDz0HXsg4L+DMjkvG6YeJiLVJv0JCx7iC+gzlrWUyGpTeyg8xrsG/JMawVaM4ULwwF67Yk9QENsPcnUodSH/TJk/f7Xu/UVcOFh45Rfw4nypGOLvVINJMM6NFjXLBCM+TAZofsT1Fr52AOOE1X2jVHGl8iqCzvrspcfBPjsTKcSPIllDyqN1DaUYspjAEDC6PLZIl7Hpwxt7XYcxxD7GS0sqfgkT9990peLWzr4RunldOZl+1jRpDmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJQoqSEPZFOxU9SKlrmeAOOR1/x49yTJvh+LjkqYq/4=;
 b=U0erKL0t7GfhZpc1LY+HtoXE3S2+vwgWdDMguu4C/B7vFP0+CbrEgPV3uRdhjI7SCaLQWvxo3B3LssXs+3H5YP1XcA8onYxaiGkOwpWa8lTttCKCYehKy7JgWPdxW82xyMDe7yPRyT3zP1gjDypuBV4Mt87KIXxJt6G3usWQZos=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS5PPF5A66AFD1C.namprd12.prod.outlook.com (2603:10b6:f:fc00::64d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 17:15:05 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 17:15:05 +0000
Message-ID: <d0f7e245-829c-471c-bf91-f3a0994f5fa4@amd.com>
Date: Mon, 28 Sep 2026 12:15:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iommu/amd: Add PerfOpt IOMMU performance
 optimization support
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <superm1@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 amd-gfx@lists.freedesktop.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
 Jatin Kataria <jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <20260908041207.38113-2-mario.limonciello@amd.com>
 <20260924225018.GB16465@ziepe.ca> <arYf3iJW7hfTua__@8bytes.org>
 <20260925122848.GD163130@ziepe.ca>
 <4560d7d3-4d67-457d-bcd7-2176bd850bd4@amd.com>
 <20260925223928.GE163130@ziepe.ca>
 <ab1cdd64-3390-480a-8d41-a942e8b2e120@gmail.com>
 <20260928120831.GF163130@ziepe.ca>
 <34bcdf7a-82b1-43cb-8409-735ebef3fa97@amd.com>
 <20260928171157.GI163130@ziepe.ca>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260928171157.GI163130@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:610:11a::22) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS5PPF5A66AFD1C:EE_
X-MS-Office365-Filtering-Correlation-Id: de1f9dc3-e067-4351-f631-08df1d8409cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|22082099003|18002099003|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	/2Wyb8b0UEQHDgTXqIRYKjUW4sotHcU+U8ygJbKMCrraytLHO/tbRZ+qK03eWe79QnHewOXrixZjDCmhtkMxK/TMGn3quJDP3E4JEF19EiVeUASULvY9k6b/QLbsoS1jDnZv/xawyyjY895T2MV6Tkf7m7ZaJoVUjrVtjAMcFB2Ph6xBYFb9EOXD7j2gpTixi1bBLU7oJkitI0HP4NPd/IzrFZKzuk3yFwYZDbyGEM+WBN9etVdsNUjWVX4sMH/gth9JEfAJv2c7bo9UOmUiIHjVaB+WnW4CIS5a0TfaojwmacfaFj9WTnOXm3Suf5D8ltJ1EkhEG/gii9z+VB8oT7CTfzjmqB2VMXu0C/s9nUo3J6hykrCnoXRirVn6EmnyasnvLAd1wPE3F1jwjP8HHo2EtDjYZUHfxvv8SoP9KQBf4y2JeyWobKa2YEMKCGh2Jl3r52SwC8otWnHPQezxAlR+OJTs71NgzUUygNDHhUv2Q6hihMmBT5+9JLdxoPQOlk1pNR/PqQmy3PDOZjrqp0RpNWEngCmbF8DUI5krEymo6igtqBACnfJcJ+i6WgJB0h3F+PyxBxCp0AGI4gbusuoDgUfhNKtZEEnFRKVJy5Pg3+KZnXfhbQ/eMygYmJBUxwEP3dykfoE9HDR02QeNqWrhg16sYxaVmTmh1oozVcw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ump3bDlXRG9EcSt1MTgrc2ZqNm5JQWRxdmsxcDJGSnlCYzVHakhycGRCdDdt?=
 =?utf-8?B?ekdhT0xSWUxHR2x2TWFqVlkySnZ6bjcxV1NLZ2RzdGxSbmVmRms4dE9lMlNQ?=
 =?utf-8?B?RTFUUG5qcGV0Mlh5Y20rWTA5RVgxdThxODJVS3E2OEdRVzBtcFlndzNWS2VX?=
 =?utf-8?B?MjNXMmdmcHI3c2V4bGYzTzJhSTJLUUY4NnpGY3NSZDNIK2VoU1pPVXFvU2hH?=
 =?utf-8?B?Nkg2K01HSnQzVXRldXVjVTcyejZXbWladEkvM3lKZUZyRnBMazJJdXh2WHM0?=
 =?utf-8?B?dXY0YjRXYTRRd3AvTlBLbXV6K3AvZFZLU0g4U1Y2VmdZS0xZTm55aTZVRE9t?=
 =?utf-8?B?TXQxN29pZmhOSVhNSldVeFMzQk5POVhxTncxdXRTUi9VMXFoL085NExiRXFW?=
 =?utf-8?B?OGVxcUFLVEI1UFlVY2ZuMjhXeXF3N2hGUjFkR2Y2Z1VieUtXZGpPbkhRd2c3?=
 =?utf-8?B?RmJMY2p4U3VRcnJudGsyTG5LZjBOa3phWU1jak9DSS9XSm9pdnJjQXoxbjlE?=
 =?utf-8?B?LzRVbWd3cStpdWx3RU9yamV1QkpjYlNuY0N6L2l6TTlrT3B2bXJwS0NoNTdn?=
 =?utf-8?B?ZlAzRmZEaXExYW10dldlZ1dndWNZakFxbFQvYkh0dTMwcEE4cmx0WG5rb01r?=
 =?utf-8?B?TVNLOXFEV3RlZTJPQlJ6cFVJZ0JYVGo3TlJoZDczNjZ2WkpkKysyOUR3cDhO?=
 =?utf-8?B?cmMzellrcXI5c2d4bkZJNW5DdGNSME9ocDQ1anFCRlRjRURFVFFXOHRaLzFj?=
 =?utf-8?B?WEhzY09wVi9MWTBGZkpOOUtXL3l4eXM1YzVac2lPU2VDOFIxWGRWNEN1eVZF?=
 =?utf-8?B?NE9PUUlQbTErZFNQN2M1WVl0OEpWSTF0QVpLQUI5ZUlMbHpJa0ltL2JYWHdm?=
 =?utf-8?B?UmNTUXlHY3U4NmxETU93NG5EbGM0Y1JnejZlMnR4Q1FWeDBJVkRqYWpzQ1FW?=
 =?utf-8?B?emVBR0VPZkZCOTZsOUNlUDZ5U1BmbS94aC9GNkFybUhRMEJINWcrcDNaK3dt?=
 =?utf-8?B?VGRSaXJKSmEzUFh5dXhBRDdWSUxrdEpuNEMrVGNVNis5ck9TaFp3QmI1SG15?=
 =?utf-8?B?Tm5EMzdDemRVOURwWWJUa1BpWEpvRU9CYU1lcDdjLzFEQkViRTVKeWJIeld4?=
 =?utf-8?B?Mi82MmM3MzYvYmM4TENTYlJ1empGdkJiZ1hJeGN3dlBXdS9pNVMzOE8wbXgw?=
 =?utf-8?B?MGJCY0dYRFlxelZyYzJpV2ZkalJ2K0VJQzN3YXdMV2lkVGZlaC9IUWZ6Tzgr?=
 =?utf-8?B?Q0wxbi9zdldzS0RodEY5RTQ3QXR4RW1KN1dhT1hDQXZ2ZTVxMWZYaHRMWjg2?=
 =?utf-8?B?MDA4c1QvM2VheERJMGVaaGJKYm1SWjJmdkxRVVgyT1JEekpoOFllaTAwd3My?=
 =?utf-8?B?dklOUWJ0VnFxbW1qL1BEOEdnYXhqbEdMVEJPWDFjcm56YVFZTkZQQkxCeE5a?=
 =?utf-8?B?emR3QU1XWCtiOVY4QlBIbTFDb2FQUUtnajRTNlpDUjZmeWZCMFBlcys5WVBo?=
 =?utf-8?B?R25uZ0N1U2UyeEp3S05sQ2tRK3kyd0w5cFlWS2xpOEhtZFB0QzZ0NDNENEho?=
 =?utf-8?B?VGM5ejc2dUp2NmxnOXhRam9FNnBOUm5tQmZMOU50eC84Z0w5RGFBSVlFenVu?=
 =?utf-8?B?RTFLU1lVVlBTYmJVOEN0NWtBUXFkaXdjQjJZRXRqbzByUitJT2NlaXFFVDlt?=
 =?utf-8?B?UFpnajEzblBERURkdkJJQ0ZiQnFCMG94aFc3VExWbnVoTThtNmJ1ZjFOaDZk?=
 =?utf-8?B?MnkxK1hncS9RMTJjeUIrb3lhSzR1dGNTUmVoN2E4ZTZsSktzYlJkRWhMdjh6?=
 =?utf-8?B?UnJNVFI5NzN5ZXlDMHhjY2ZPRFcxbEhXUDVhcm00NHFqa1pNM3RjcFNSTG83?=
 =?utf-8?B?U3haN2plOEtDSzRTcTZpMTVkaVBKOVlEcHUrajBLcXRleU80K1ZTTHNBK0dL?=
 =?utf-8?B?T1c2NkovNWprU3I2N01halFqd2gzZW15Nkl1VUoxVS95bUJwVHdzYWpnaGpS?=
 =?utf-8?B?UXJ6S00vY29xMmdCRWc5aktubXZXbGFCOFJOOC90VGprOUxwUVZZVndBTzJV?=
 =?utf-8?B?b0ZkQnZzT2NOOXh1UFlpbFpxUDhSYXVvSmZVL0FURFM2dVMrbTl2aVZ3aWd1?=
 =?utf-8?B?OHBJMml4STJIdGNvZVZyNzBVYm41VmFSMCtUS2Q2ci9nODdkeFJqa1BDc3BD?=
 =?utf-8?B?TVdtMmRUcEltb0JOK0o3NVZDUTZZazlDRE81alppWkprWU0yQWxnbEJtVmlX?=
 =?utf-8?B?N0V0U2JBRTR5NzJoM0hHRmliQXp4a3dQZURBRUVhT3k1eVVIRExyNGNzcHVW?=
 =?utf-8?Q?nY9hb+l/7qmoXj2szu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1f9dc3-e067-4351-f631-08df1d8409cf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 17:15:05.0304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApI91/v+gi2XcJ5R3Eu3odbmhI14XXkBfDbES65vItb4zVfQFg0StkMFJhitoIe26KOjSo8pAVtE1s0rfwicJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5A66AFD1C



On 9/28/26 12:11, Jason Gunthorpe wrote:
> On Mon, Sep 28, 2026 at 10:32:41AM -0500, Mario Limonciello wrote:
> 
>> Actually; no.  amdgpu has migrated away from PCI IDs and probes based on the
>> "ATI vendor" + "display class" instead.  As part of the probe sequence there
>> is something called an IP discovery table pull from the platform that
>> identifies all IP blocks in the hardware.
> 
> Oh, so that big table is not processing pci ids.. OK
> 
>> This IP discovery table will indicate graphics IP and that is mapped to
>> relevant driver code.  So for example GC 11.5.1 is what you find in a Strix
>> Halo APU.  If a future APU had exactly the same graphics IP but a different
>> display IP it would still be GC 11.5.1.
> 
> Move this stuff to drivers/firmware and iommu and GPU can access it
> together?
> 
> "IP discovery table" sure sounds like a platform firmware datablob to
> me at least?
> 
> Jason

Yes; it comes from platform firmware.

Alex, what do you think of doing this?
