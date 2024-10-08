Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021096.outbound.protection.outlook.com [52.101.62.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E07D1E0DE5
	for <iommu@lists.linux.dev>; Tue,  8 Oct 2024 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407102; cv=fail; b=jqgsEb+SvWVwSVZEWq8oKykGUqsXe1wjsEmO28V37OJmSwoXgpn3SppVuuhT+UEsQgOeeq2Bb00dBBBtAAyTJmQm2HFNCLqYRRfOgnXGVhdAFuY3Jfft00Qmn9pAkplJuICePTdWT8QQt+Fbz3wqTXEpF7RTpfwsSPUevV8CNw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407102; c=relaxed/simple;
	bh=y7M7j41K9gNRLhXwZ8PA0u89zzTPXMjXt+zCRJMJvag=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IhyLkij6vX7Ez4EzNijHa/r88t/ExlrrEfJrXDdCyS1oFAQiSAqmagIrXFUw3OJeTG5PRkB0JWGtVjmusbtYzA9dbBdtzyNxLfdmTmJtvtF76wdjKMioB2rluS1wn8iefHCBn+gGCpyoiPAB4/1BwnmZF8cr04UtWVSqwu08ENA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=OUnizXtp; arc=fail smtp.client-ip=52.101.62.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="OUnizXtp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8ESPlP+5tLRGu43Vc9nYeXV/SS9PFTG4VK+2Re3mWrLrde/ZEIls2gLVIkuhrSYm/agFPil5wyX+AgxhHAjPtdthaGlv/lk2Qu3IJUMs7rbPFeDnpA6zTe2bs3ABwUbryX7Uq6Vq/zVPcoH/JkHSyxqGhxy9BDY6rEPOpD5eVIG0o4lBhYi9iKuBEFxnUbAdg5Rw2yPbzCAc+GFGljZ0WOo1YXrDJqbrB46XC5nfmNlG9RXjdneNfWU/K8yK6MOWco9S9LahD5qRDkvEQ5pBGyn2aFMhxfWZ2SExafm+atit2AukHanB/SMk3YvYMuNi1sLkpScyllsWACTo21WaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xK0D09nMZN2GMQGtMny+vuI5h18Yqpf2RRhzFHb/6gI=;
 b=p8okf1/37e+aJQWUvSQncADba6oHa48NqLP91ELtsz1nWGxdwv9UEu1A3d7cLH6AvDnr22wlBP3va1nM0rtWySbkwMhkn1NOIE7Eqpjzn43h1E426ezrSaH+BUhVGckJuTInt+x0k5vd7rD2JyIN/nJpCEcHcXzLYUjxrmvuHnYJ0f/7QeL4oKD7JHUFQue2TAronfBRJ2SeUMKhyFcy+8ERApdzL2jvZ2jNYr7ZaXtKYf44Mq1oG4FWZBas16R0t5XU2TQotD33RiMfB/sOEJlJAwxSPk215J6g2Ky5QylriVZwRfLhEaksMf5DXzpjMIuMjPFgLbSV3xUxcR9eOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xK0D09nMZN2GMQGtMny+vuI5h18Yqpf2RRhzFHb/6gI=;
 b=OUnizXtpH8tnpXtd9Ba1aobNR0j+iOtc3f0Fn1tEDvUXeOhXqrgEMUniehMAgDvWDIFTUVhkYQSVz0syWQ9T2LyFTpDCvcFazZwH0lk6ZSqL5IvGBEjw5yBm560JkxYloBcbYqkLmK5XRgy95co0SWW1lv+ailz4dUf4zjNqve4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CYYPR01MB8292.prod.exchangelabs.com (2603:10b6:930:c2::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.29; Tue, 8 Oct 2024 17:04:54 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.033; Tue, 8 Oct 2024
 17:04:54 +0000
Message-ID: <b5725875-d04c-42e3-bcbe-e119019de7e1@os.amperecomputing.com>
Date: Tue, 8 Oct 2024 10:04:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: nicolinc@nvidia.com, james.morse@arm.com, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20241004180405.555194-1-yang@os.amperecomputing.com>
 <20241008133458.GA10474@willie-the-truck> <20241008151506.GC762027@ziepe.ca>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20241008151506.GC762027@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0060.prod.exchangelabs.com (2603:10b6:a03:94::37)
 To CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CYYPR01MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fdb8f35-b1cf-46aa-3988-08dce7bb5469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTJ6Y3ErSzBaVGhuVzlVN1luT255RzNOQmZyRnhleDFnbEFRTDJMOGp4bDR0?=
 =?utf-8?B?eEc0ZW5iODRLUW5nU0NTdWdyaTVXUUNySHJ2SXFxMUk1MG9oOVlXN1lJY1cy?=
 =?utf-8?B?aWNwajdlUFVCY1lrdG5lbFMyWW5VTVhYaHYxYW9FemlRaFFublkxSEZBNEw1?=
 =?utf-8?B?MkxtTmlkWkQwWDFOSWdFNUMxTDNHelBqTnhHUHd3a1VBUG8rMXkveE5GckNG?=
 =?utf-8?B?Q3RFSjBvcEF5RHp5Q0pFTDN3MDcyRmVESEduZCtNbXR1Mll6bHNWZENzZ2dX?=
 =?utf-8?B?aUdSWW1naVAvcjNjTFZZUXNYSXh3RCtXczJvbkJFcDRZTjZ3SGdXQU52REIr?=
 =?utf-8?B?NTAxRjcyaFo4SEtsRWZxbmRQK0kwNDc5eURJTXg2YkEyQTZJNHVuaVFKUnMw?=
 =?utf-8?B?TXVCeEkzWUVyUXVhRzhhQ29maW4vWWRFNGZIdHgyeWU2VVMyY3BlRDVkeitQ?=
 =?utf-8?B?dTZhMklVNThYTXVlbm13U3hXSHhmTStJSGJEOWx6UXdvMWNuUlBHTFpCN3h1?=
 =?utf-8?B?MWcwZjlCaCtpYkluM3NFZGg5UVRqVTBuOHdIVG5TTjhGOWxMOUhkNHZ6Sng1?=
 =?utf-8?B?K3lxTjZ2dzJ4cXo2WXlLUmg4YmVZTTdhNG1ndnBLenY4TEdJMkxVSVBvcDNw?=
 =?utf-8?B?YXRJdW52d0JTL0hoNjRvUVJ2R2JRVVl0cmZ6OVFtd0dHRDV6TmpZNXpDMHIz?=
 =?utf-8?B?YUZjYm1OT2NLTkdEa1lNeU1BazNQREY5dGthTTc5Vi9tdmRtWEwyWTdPM3Ft?=
 =?utf-8?B?NzZOc1loWDJwYUExZHZjVHlwL0duL0ZKU3ZDRnRYbzRlazB5THZmcE9QbTNq?=
 =?utf-8?B?VHdsTTF0Q1JOS3plcmVyeTZzRUQ2MTNoVUo2Qm9DVnMxWXhhOFJvNnF5NVBW?=
 =?utf-8?B?V2FKeDF3WXNhd1cxV1JSWE5SeC9TbXgzYjExZzEydVVvM3llMG1mVmxTUVpn?=
 =?utf-8?B?cjlOOWZZZXF5cnZUM2NnS2pBVHFza3M5eU1SdTcwaGRuSnl1b25scFFqZVlj?=
 =?utf-8?B?YUJHOXhuVXR6YjBGMVltcS8rREhYZTI1ZDZDcGsyb2NIdzJlWEIyd0dtV2Ev?=
 =?utf-8?B?d0hnVE1kY0pnUFF2aUNzT1pSWS9MVlh3b214R1hMS2ViSGc4aHVMa0hrK3BK?=
 =?utf-8?B?cXQ3azNzOGxxMHpVZ0h6NDRYbk5MUmw2UEVUWDRlZU5TbW1mU0pDRnpzM2ZY?=
 =?utf-8?B?SHhnZ1FBVEtCT2M3OGFJYzdsRHlPVzYrcXAvZi90U2tYNXVmK296R3hqYWdr?=
 =?utf-8?B?MENkcXRhMVZIUWUwY2ZtYzhUTFJFeXdqMUVrSHZJdGJkbzJGc2oyZVBubzJN?=
 =?utf-8?B?eHBEcmIwY1N2cnB2V0MyZExkeEx3Ulk2dk5kc2xEYTl0cTQrR1VDVkUvZkhR?=
 =?utf-8?B?d0xTVUdMcmpwMjdhOWg5L2J1VFRGdUhHT1hWbm1mZFhBWVJUVEhrek93emNO?=
 =?utf-8?B?a0RjVWVGYWdCV0ZJVWxyUDhjbFN0VVdQOXBsM3dCWFc0NUhBVHNiVHJCaUlr?=
 =?utf-8?B?cHM0RTVWdVIveTJhdVRNVDFuNmIwL0UwYkwxL25uMk54ZDJUa0tzaUp2bHdT?=
 =?utf-8?B?SjVOYmlNZWw4QWJadmFRZGx4M2lYbWp5Ukd3OXlKR0c5alRURStKRkliUDA4?=
 =?utf-8?B?OG5XV3NEbThCbSs1c1lIQ0l6YmNUbHdxaytlRElIdDVJRE93dVBMSVl5aEgv?=
 =?utf-8?B?QVVYUUNKbnB6c0N5ZUY1cnNWdXN1ZS8rVVI3MTIxei9SQ0tQL0p2K0pRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjhWNGJrcU5iR0JiaUVGdkd2cTV4OEdlZ09wQmxONGI5bmNkTzU1ZEg4Ykl2?=
 =?utf-8?B?bStaaHdkbFNEa05naGRlTGV4aER0WkFHYXpzNTZwVVBIRExKQ0RkTGc0MWo0?=
 =?utf-8?B?QmFUZDhwUDFjQU1XaDZGS2lXVUd0SjZrY0g5UlJUbU5uT2pDczlzK2JXazE5?=
 =?utf-8?B?amY4WCs2dDlzZGN6Z2JnbGNMVElYQzVYa05rOElwNVU3MkxmaHZmOFAzZmVt?=
 =?utf-8?B?cCtiWkNJSjFoM28zeUdGY3IxMzdjOHFueTE4Z3RTc1A1SllnM09ON2F6MGQv?=
 =?utf-8?B?STFJTHVINElZUDFMNXJUenRoeHUyaUorQnBLb1FaN1hQeFFSMzRhMlc5SlNa?=
 =?utf-8?B?K0J5S3dTTWJhRGhlNTFxa0I5Vm9IWXpIclRzZ2Juc0JRSmQ3VlhNczBrSTcv?=
 =?utf-8?B?RityUXhlY3lpVVg0OEdvUTZkcTBZK0gyNjI0TitFL2lGdFZHOXpwNzNiY2ZN?=
 =?utf-8?B?L2E0aUxDTVNDS2ZNR29rWmRVbno4WHZYSHZBeGZpU3h5emdCR3FGQ0pmbTJH?=
 =?utf-8?B?VnJOcnV1dG1UVE5JNVVpTU9KQ2JwdWd5TEhjUTNzUmtNTjBESmVCc0k1Q0Ri?=
 =?utf-8?B?LzBwRjFzcmVjbTc2dDNUaXdVTGNDU2RvajJTcTROZnRHZzU3c1RIVENvYXNv?=
 =?utf-8?B?b0Nkb2NFN2lUU3d5cFJIU0Vuc3BodHVPMC9HOC91V1JTckg3cG91MzI0b0kv?=
 =?utf-8?B?NHZWR3JiNEpIRTdjclo4Q1djTW8vdWZ1S0d6L3VGeGZMVWgwTkxKSEdWc0Ra?=
 =?utf-8?B?MVFqS3hwVlJ3VG5oMkJzRGFjU2hqQjhxQjQwTDZpZmdyTFVxT1l6ZzlSTmMy?=
 =?utf-8?B?K2Vyd3pMT0I0YmMvbWJTRG5JWm55NisvSkJ1MVlpeWNzWW91a1pMTndJUGk0?=
 =?utf-8?B?SzQweEhndndjWlhjREJINHZzalZwaE5tYStNNjJUZ0tMbUlvdUtQN1FhREUz?=
 =?utf-8?B?aFFnTE1Va2lYa0UrZlNWWUtTb0pyZzU4bnZ4blowNldTY2l2aVNiVEdxczlt?=
 =?utf-8?B?MlFtUVVuRFQ4cHpWRVJ1cFAzTVJhY0R3NVpLanNtREU1QUI0NlZacWpiR0RV?=
 =?utf-8?B?YW9lcExjdnAreXduTVM5cHl1RlpVaXlnVmQ4ekR6OW9Jc0dZQmJqU1lJSHY4?=
 =?utf-8?B?ZjRXNEttM09LQjk4UFRCOE52cTc2RndUTFNlTW9MRzRqVWZwQzAyTUhwVTNp?=
 =?utf-8?B?YS8weVF3U0tTRTNtZk0wZjV3WXlBSStrZCtmM3BFYUlyZ0FQS0g4a3BRa01w?=
 =?utf-8?B?bWpzWGUydUgvc3ZaTGR1OGFsOHZuTjQzNnVaQlNWckZtbTZLVGVrQVI3RC9z?=
 =?utf-8?B?dXU5MmNpMFJ1MjB4NnEvSGZJUU1IZ3pOR2JkWlk2Y0JWcDkxNXpVZVhYNEh5?=
 =?utf-8?B?VkdRN2ErN2JZb2tzeC9LZmFhYzEwSzh4eW1yQzRtckoxZXVoblVlWFkwVjhO?=
 =?utf-8?B?YjhSUmJRSkJBaSt0ZDBzMFZ5NFNXWldlcldkci9UY29ad0hycDFVTndxUUJr?=
 =?utf-8?B?UmZlbnRnZ1NUeC9hdDIySlc0elRMOXhLaHRacGR4Zy9nemY0RytnTmNNbkdj?=
 =?utf-8?B?amt0RTRNZkFiV21LcjZhS2ZweW00eVZZRzhGTmU3VU03eDMvVDNjaURnTHNw?=
 =?utf-8?B?QmFGc0J6Y1cwTE1ZRm9LSDV6b242NSswOEViWGR1WlZFT1dzRVVLMzdzYjVH?=
 =?utf-8?B?WGlQZVE1N3NlS1pNd3hoY3ppS3NNY1QrdnlXb0FtdnpjS3ZtZmpBUjJrS0pu?=
 =?utf-8?B?NkpGSjNvNEhMVmJ2NTlRQ0cvRzI4d2VYMVpTTzYxY1RqS240TkJUQS9sSU1t?=
 =?utf-8?B?alNuTUVQRDJpQkFwQ3BKWC9ZL1lFOXBhaE5CVzd3K3hSRTBTNEY0RXNGZVRU?=
 =?utf-8?B?Ym9CTlVLTUxVOTNCeWUycFFSM2wrOTFqc05YcFJwdFRKVENTSHNuOWpndE50?=
 =?utf-8?B?b1lVWlVFM1RKNWlOdk1mMEk0cGQ3aFpXa0V6NkhwMzhZWnZnL2l1d0pNWVpq?=
 =?utf-8?B?UnY0Ukl3T0VpL3NYNEsxODdaeFBIYTRtZVFQeTNEaXhyaUsvSk1WVWQwL1lV?=
 =?utf-8?B?ZUlzYU02c0RJVDFnWk9xdkVoeW9FOHNLdEpWYkNNVzFsazYrdGl5V01IT3Q2?=
 =?utf-8?B?emE1WkNTZHJrQmxieXNmRlA3QUlvY2tMZWsvYjlIekhBTWlJWFdHMFlXTXFR?=
 =?utf-8?B?Vnc9PQ==?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdb8f35-b1cf-46aa-3988-08dce7bb5469
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 17:04:54.2790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHx4wJomruKZPFxWlTaP7mNIsh4RrIfO8da2ayrJ+2A2bmR0e3t1ymm3Me9zGS7/GO/KVHJueoO90Gvprewcplk8RP1bJNDj2vMG4jpLFGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8292



On 10/8/24 8:15 AM, Jason Gunthorpe wrote:
> On Tue, Oct 08, 2024 at 02:34:58PM +0100, Will Deacon wrote:
>
>> This all looks a bit messy to me. The architecture guarantees that
>> 2-level stream tables are supported once we hit 7-bit SIDs and, although
>> the driver relaxes this to > 8-bit SIDs, we'll never run into overflow
>> problems in the linear table code above.
> My original point was about the confidential compute position (sigh)
> that the untrusted hypverisor should not corrupt the driver.
>
> So your statement is architecturally true, but we never check that
> IDR0_ST_LVL_2LVL is set if IDR1_SIDSIZE > 2**7, and so we can get into
> this situation where the hypervisor could trigger some kind of bad
> behavior.

Jason's concern seems valid to me IMHO. But if the simpler version is 
preferred, I'd suggest add some comments at least or the check suggested 
by Jason to make the architecture guarantee more clear. Just in case 
someone else won't repeat what we had done just because they see "1ULL" 
in 2lvl code but not in linear code.

>
>> So I'm inclined to take Daniel's one-liner [1] which just chucks the
>> 'ULL' suffix into the 2-level case. Otherwise, we're in a weird
> I think you should take it and let better be for the CC crowd.
>
> Jason

