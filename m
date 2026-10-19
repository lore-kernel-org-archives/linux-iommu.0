Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011032.outbound.protection.outlook.com [52.101.57.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A103E0C4C
	for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 06:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792390240; cv=fail; b=LNf2ZvZVlzkmW3qnym6/Bnp5il0q/q+jePmgTm6cHpsLuKH37ymifqcqaNAH3g8XypSYdwKp8Y4CaMydQZW5Hqj5MxixWFFo1o1Lmiex4Bke4X5e38lucJQrlaZYE7hkb/1I439q8jPrXB+66ig5Ju+VgcFc+MoZVDo0kJKHyJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792390240; c=relaxed/simple;
	bh=rcHB4+pl9qxBRnqvKM9saqs/0ZSXf+/3s3bAGNryU4M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XTvwuk5ARwXWK8NRRo1IIBenQPh9eKH5lrKCj/Hj/EzhaHs1avHcGDaPBvQSel54wiJt2lxSbH8+MXr5C1XasL+qYHeSUo4tbzTrE5npL+WNy8+ub7xZCNyVnSG0CsbAdycAU0nDsku5rrsOsyCr8k0Zcowd6luvpIlVrzH5IU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g6u1J7FT; arc=fail smtp.client-ip=52.101.57.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g6u1J7FT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+9+IjPxUQcNpTs9TOv5ROv1mw7oFFZLn6Y/TKPXB+ZZxfuy/OhMQs3KVJIGj2VeBQgNE99qTzKJtwfRkMh/zZVRhRzFmUgs2l3fS33aMkNqQ055zAjyCbjZc0OdDyDbiTeeD2es5mIz+7xuW3ydcjJh7l8nXP1v/Jv1VYg400JbSnWfrLwm6VSNHIXEfgduQN00bw8PTx1N1bHx+aK2sXGbRCmq7TVbntnjS/BwIRpeoWoN633CupKWpqdecvwYqYp/3kUbciOWu07CtJ+N76WHbcH3C91q1g/QkVWlzt1+HGgCCsAVozeiCdZ1jl2tj+gq77QaSx+bZZOMdaSXeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQSalPaoeIP3CvNRevoDUMkHeNpt9/S0zCr7H9FKO+k=;
 b=LbMpaI028/vTcowZM4bDXVR867RDAGEojSnHyzgG5zW9OKnrwKhntwXYPC+G43PvH2gJ7Pfttt6e1UCXeWYHTwrWcgMYEARabZHbPwcwzKL9imKyz+Tsq6lVg+u5wjxHf3jrfDqQqL6FXZlz4CgtQrVD/+iU7A8xMftpSuTronQHOgqs0C+q9yzBrQuWLD46vzsExM1cDXws+g9GpWV6hBzpcmEVg1L4cyvvnGJIGPiJDP+e0zLDkk6/R7l7fv8UgY6jjD3CHTh2t3umRPrfvAJDaY2xqpxnID7BBOv8NGBNRxtIO1W6nKZa83myGY3+dc8D/fkILbBFD0JrZu8zvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQSalPaoeIP3CvNRevoDUMkHeNpt9/S0zCr7H9FKO+k=;
 b=g6u1J7FTEyPPQmKEbRmz9KW/z1d7RZx2GD6LsJi1mnLE05jxOZ7wznVOrP7JLg1+p2v8M6g4WK79HJWcldYjerA77ByhnBNRHu0lHqh0P+yUy/siDytvP4yuAIyKI3UqRCdd9nAbpSRa4rVzWS4eLENRmhnEN3QiHBsjKtSqx2I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by PH8PR12MB999320.namprd12.prod.outlook.com (2603:10b6:510:42f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 06:10:33 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 06:10:33 +0000
Message-ID: <787b4f08-fd74-4597-8508-fe4ccaf75a24@amd.com>
Date: Mon, 19 Oct 2026 11:40:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/24] iommu/amd: Introduce
 EVENT_TYPE_GUEST_EVENT_FAULT
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, Ming.Shu@amd.com, SooJin.Tan@amd.com, chrisl@kernel.org,
 wvw@google.com, wnliu@google.com, dantuluris@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com,
 guanghuifeng@linux.alibaba.com
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
 <20260930092344.5616-3-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260930092344.5616-3-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0271.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21d::8) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|PH8PR12MB999320:EE_
X-MS-Office365-Filtering-Correlation-Id: 9432b351-9ec4-4c72-d8fe-08df2da7af3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|261009223027099003|10067099003|56012099006|6133799003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	ayEDuJwrzKL4r6pdH6QmiyydjLV7IhnsfxSx3i/QXWga6bLn6CXHzH/HiJTTT+jjCTbhnTpV1vsEyMNZPtVX5/htEOQay/I7xLaWyMhLUljLYMsJP8TBMUMJEEZVcdishzS/rgPHK5qMimrwiOAkR1saBHhQukQkMA7/0/ZR4elwo2iVNJBdUxt8zsmmu4+wq9O51HcK4zzdkty5MiOWZcRHzwi8uRhHoXTFr9M9GkwIE25s4wWdcb50i+uBEu7HU3Yocy+BW9VK1oM8h+J6fgeoNnFm8hspmQ+EZLSngQppsdX4cWszIsr68lWg1edI0ztzo5BjOkdghM6VyiKpM3TFiiNwJL1ltk5sQ6WMaQwM0dmO9kRHeneIgH2qlbJ6eh+j2Svpocp0xU0K3d+emHwH5bOuKoHdhr0uz3AUn1VeOPstvi4aIM277mP+5ZLGUPfljwD1m5xFzXdi9mCSdz7/lLD2XBBvrAAHWugzXYQ3a2XB4r/94LDhrI/FbJWoforo7LAb3iGOODGfi3bh8BAiKuZ7sqo87yZtTd1F0sayUnbP+KWCb4Ko9zwUL0kxgPIQ09H/jCC1V2AIqsEzgntESeV7Xe6AueEaincIzWZisd/BN/70eJz4GUSFWzhygNTxErM1Ks0T7hou999QSn6alGkWrdR2ZxAJk8zSRBE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cm90UUJvZGlaUDZnTWorNElaT0ZJdGJxbWEwdFp4c1RqZ2FjcENOMVR5SFdz?=
 =?utf-8?B?ZTZqL0J2YmdCR1QxMzJqdVdUZGJKN2ZPTmQ3TDN2Q0ozdndCRDBqSUZsWjI0?=
 =?utf-8?B?TVVnbnJHak95R0JBczNaM1oxcDBURjgrUFh3K2t0V3NGak9UdXIyWE1Va3Av?=
 =?utf-8?B?YlJLOVpzalorTnBQeTArVTNIbHJ5RTZDZ2FhUjFxTm1qdW13SzdQNkZWZVZy?=
 =?utf-8?B?SFZ0OGlKVW9tL2JIaWU3ckdlVUZQU21iRzhDbzN1emRlb05RaTd1QnN4Nmwr?=
 =?utf-8?B?bmlkU0Uva2N5MEFzWStzRjBCRUFWRkx2RTNUYlV0Ly9YTmU3NzVxa0c2RGRu?=
 =?utf-8?B?VjdEdFcvZkdOeTZwbnVNWGIxV3ZweFk4bFR6WldpT0FRckVCeEo1YmlISnlV?=
 =?utf-8?B?WmNGdTR0VHJGdFdLVlVJNFNCWENuMUY1RXJSV3ZzRHBUNlY4Y1Z0RDRPSTJD?=
 =?utf-8?B?R2tyZ0FoVG01VDMxNXVuQjVXQTczVUgwZ1NmVVJJVGpKZ3FjV0E3RGw1a2Q2?=
 =?utf-8?B?ekl0N1FvTjZ0YWpETGIvZUhqcGZiTFdiUWxUS2RuMFlJWll0M05CN2lhcmtI?=
 =?utf-8?B?ZzE1b3VaUDJqbTdsOTdoU3duUXU2NDhNR3BLcmVkZWFGdkJZTVJvb21MK3JF?=
 =?utf-8?B?YzdOeGJGZUZxQlJjVXlUOHJXdFdRY3hBM3piRlI4YzlaTVVxcytUMXMwalBC?=
 =?utf-8?B?OXpjVUlaZmJqK2d1WHhzRDFETHpHUEhsYnh1SFAxVmdsTEMrQ1g3L2M1U3dt?=
 =?utf-8?B?RlF1UnFzZ3lvT2JHdUQ3aHdFSEh3UFZIZU9wblB1SzhLZjh1WWYreHppZTN2?=
 =?utf-8?B?M3VaLzVKam5aNHRreDFDS2drNmVtNTJCdGNVWDd2aDNhaFRUL1gvRVphdWlH?=
 =?utf-8?B?Vm1MSk5WNVhoVUIxK0hRekd3Q2s4L2dpUWRPQThLa2tSdW9mUG9UaUJtcFpE?=
 =?utf-8?B?QkU1YjRTdkNkcGtZdUFNYTJCZmVNNEJUZ3hrT3NVd3JqZDdCZXY5bUNtYjNF?=
 =?utf-8?B?U2xxRmdMS3V1Q01OOXpydGd3ZG1mR0drL25wVWJqcGFSTEpoNUpjY21VN0RJ?=
 =?utf-8?B?cVl0blRIQmsyMmpKa0MzQkd3OXhnSE1xaTFaZXE3Nk1WTEI5RElqcUxSS3Av?=
 =?utf-8?B?KzBzM09XUURESmdFbXovdmNDdmI4T0xiNFZHUldlUFlGWG1zaTlndDN3VmEr?=
 =?utf-8?B?SytIQWI2UHhGdXJKZ0dMbWJ4NXJHVXluSzV2UllhZm43dXJIOUpMT2txTURo?=
 =?utf-8?B?c1hPbXVWQ1A1OFRVOUE0RFpIeGcrcWp3d1dwVmlpK0tENE1hNitrcHA1L21T?=
 =?utf-8?B?U0NnZXNTdFlCODI1Wm44MFlQMXhRYWhPVjMrNGtpcElTYkhQUnRYcHJlQm12?=
 =?utf-8?B?WXM5bnNTWlhLTmRwRkxLY2xlZ0xYdE80OEJyakZvNjFxRjRmc3hmb0hjUWJE?=
 =?utf-8?B?bHNEQ3RJdnNQQmlEdnZBYUZPRVRqd09pN29RZFFLZnM4ZWdMTkh4TmZwVWZJ?=
 =?utf-8?B?OHN6bzAxMFltN2N1aElDUk1KUnkxTjRNNUl5eW9Lb1lUSUdTdDJDNzBtc1ZC?=
 =?utf-8?B?OHlqSmlPa3BTVmwvUU1vZjNOZkJRbmF4QXJ3ckd2a2JGQzZqdmhlb29QazRL?=
 =?utf-8?B?VlpWZ1dzTlpqMUZ0d0lLbkZkOXkyQ2RqeGZOUHhBdGw3WWNQTkVrS2grRDN2?=
 =?utf-8?B?NEV0SGpzQmpyQVlEbDJEczJMTGwzaVR2ay91c2pyWWo3QWk4V0ZGcTdDelQ4?=
 =?utf-8?B?Qi9RcmdCSkFVWWxOcVVrSEtrUWh6YStzM3NhWGpGTmdreEpWSUZRWWtsUlA4?=
 =?utf-8?B?NXgrcjhJS3ZQWUZIUGRoSzBralFHaHBqeFNNRmVJS3hHd1BtYis2K2VUODYy?=
 =?utf-8?B?dDRHdElkbUp0UDNRMTNKYzA2RXhsSnRqR25WV0JlZU5iVEFFMUlmME9WaXpF?=
 =?utf-8?B?Tld0RTlFZDBaODVHUmZXK3RoSXFqcmJKWUoxQUtESkI2VTMxN01YZ1V1WHRL?=
 =?utf-8?B?Q2dkWFBCQXp3QUJhWmlOcmtqTi9YcThqUXRHc0NVT1BjcGpwM2Q1NG9xRW1x?=
 =?utf-8?B?TlN6d0d5cGE1VjJTT2xZZDNLcHAvakFyOWo0ZHhMSXZpM3FubUxBbkZJR25y?=
 =?utf-8?B?cTNsUVNDeEFoMW5hT041SG96YStzeTJxOUdmQ0RzYVh1cVdSZW1YanlDZVQ5?=
 =?utf-8?B?c2Y1NVpMRmFiUXdQenBHMEFPbGRXWjJUcEF0N3h4STdEMSs1YWtPVVZpU3VN?=
 =?utf-8?B?V2ZoZHp6eklsWkJKNEFHNzdpOWo4TzJIRDRvNEtqL0VzejBjLzBXUHpxN2R5?=
 =?utf-8?Q?4a7xhMRhELncTPG5c0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9432b351-9ec4-4c72-d8fe-08df2da7af3b
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 06:10:33.6326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9a4plI8mwdi3Lz6GeQr11XfNaDpoVjkZxfK6/t7j2DA+/mq/th103JyxFOXZe8GY+KiiDCL32GhZ8WIcTfcOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB999320



On 9/30/2026 2:53 PM, Suravee Suthikulpanit wrote:
> INSERT_GUEST_EVENT with non-zero reserved bits logs
> GUEST_EVENT_FAULT followed by the original guest event.
> Consume both event-log slots, wrapping via
> evt_buf+(head+EVTLOG_ENTRY_SIZE)%size, and dump the guest
> payload raw so it is not decoded as a host event.
> 
> Wait until occupancy is at least two entries, not merely
> until live tail is not the pair offset. Re-read the
> event-log tail each poll iteration so a return of 2 cannot
> advance head past a stale cached tail and walk empty slots
> with the type-0 erratum retry.
> 
> Retry a type-0 guest slot up to LOOP_TIMEOUT, the same way
> erratum 732 waits for the primary slot. Return 2 only when
> that slot is already in [head, live_tail). Return 1 if the
> pair never appears in tail. Rate-limit the guest-triggered
> logs.
> 
> Log an invalid guest-event when the pair slot is still
> missing or type 0 after that wait, instead of stalling
> the event log.


As per spec:
  GUEST_EVENT_FAULT event is always written in pairs with a guest event entry
immediately after it into the event log.

Why not add one additional check in iommu_poll_events() such that:
  if event at head is GUEST_EVENT_FAULT and actual fault event is
not-yet-written by HW just return.
  If subsequent event is also written then handle the event.

and increase head pointer accordingly.



> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |   2 +
>  drivers/iommu/amd/iommu.c           | 116 +++++++++++++++++++++++++---
>  2 files changed, 107 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index f26a9059a356..704b4c8acdc5 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -138,6 +138,7 @@
>  #define EVENT_TYPE_IOTLB_INV_TO	0x7
>  #define EVENT_TYPE_INV_DEV_REQ	0x8
>  #define EVENT_TYPE_INV_PPR_REQ	0x9
> +#define EVENT_TYPE_GUEST_EVENT_FAULT	0xb
>  #define EVENT_TYPE_VIOMMU_HW_ERR	0xc
>  
>  #define EVENT_TYPE_RMP_FAULT	0xd
> @@ -255,6 +256,7 @@
>  
>  /* Constants for vIOMMU event fields */
>  #define EVENT_VFLAGS_MASK		GENMASK_ULL(31, 27)
> +#define EVENT_GID_MASK			GENMASK(15, 0)
>  
>  /* Constants for PPR Log handling */
>  #define PPRLOG_ENTRY_SIZE	0x10
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 43a5690721af..2df81e29519e 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -942,8 +942,18 @@ static void amd_iommu_report_ppr_err(struct amd_iommu *iommu, volatile u32 *even
>  	pci_dev_put(pdev);
>  }
>  
> -static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
> +static u32 evtlog_used(u32 head, u32 tail)
>  {
> +	return (tail + amd_iommu_evtlog_size - head) % amd_iommu_evtlog_size;
> +}
> +
> +/*
> + * Decode one event-log slot (or a GUEST_EVENT_FAULT pair).
> + * Returns the number of slots consumed.
> + */
> +static unsigned int iommu_print_event(struct amd_iommu *iommu, u32 head)
> +{
> +	void *__evt = iommu->evt_buf + head;
>  	struct device *dev = iommu->iommu.dev;
>  	int type, devid, flags;
>  	volatile u32 *event = __evt;
> @@ -965,7 +975,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>  		/* Did we hit the erratum? */
>  		if (++count == LOOP_TIMEOUT) {
>  			pr_err("No event written to event log\n");
> -			return;
> +			return 1;

This will cause head to progress event though there is no event.

>  		}
>  		udelay(1);
>  		goto retry;
> @@ -975,7 +985,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>  
>  	if (type == EVENT_TYPE_IO_FAULT) {
>  		amd_iommu_report_page_fault(iommu, devid, pasid, address, flags, vflags);
> -		return;
> +		return 1;
>  	}
>  
>  	switch (type) {
> @@ -1023,9 +1033,90 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>  	case EVENT_TYPE_INV_PPR_REQ:
>  		amd_iommu_report_ppr_err(iommu, event, devid, address, flags);
>  		break;
> +	case EVENT_TYPE_GUEST_EVENT_FAULT:
> +	{
> +		u16 gid = FIELD_GET(EVENT_GID_MASK, event[1]);
> +		u32 next = (head + EVTLOG_ENTRY_SIZE) % amd_iommu_evtlog_size;
> +		u32 *guest;
> +		u32 live_tail, w0, w1, w2, w3;
> +		int guest_type, wait;
> +
> +		dev_err_ratelimited(dev, "Event logged [GUEST_EVENT_FAULT gid=%#x flags=0x%04x vflags=%#x]\n",
> +				    gid, flags, vflags);
> +
> +		/*
> +		 * GUEST_EVENT_FAULT is paired with the original guest
> +		 * event in the next log slot (possibly wrapped). The
> +		 * poll-time tail can predate that slot. Wait until
> +		 * occupancy is at least two entries, then retry a
> +		 * type-0 pair slot the same way erratum 732 waits
> +		 * for DMA visibility. Return 2 only when that slot
> +		 * is already in [head, live_tail). iommu_poll_events()
> +		 * re-reads tail each iteration so head cannot skip
> +		 * past tail.
> +		 */
> +		wait = 0;
> +		for (;;) {
> +			live_tail = readl(iommu->mmio_base + MMIO_EVT_TAIL_OFFSET);
> +			if (evtlog_used(head, live_tail) >=
> +			    2 * EVTLOG_ENTRY_SIZE)
> +				break;
> +			if (++wait == LOOP_TIMEOUT) {

I think we should avoid avoid this loop in interrupt handler path.

> +				dev_err_ratelimited(dev, "Event logged [GUEST_EVENT_FAULT invalid guest-event (does not exist)]\n");
> +				if (!amd_iommu_snp_en)
> +					memset(__evt, 0, EVTLOG_ENTRY_SIZE);
> +				return 1;
> +			}
> +			udelay(1);
> +		}
> +
> +		guest = (u32 *)(iommu->evt_buf + next);
> +		wait = 0;
> +		for (;;) {
> +			w1 = READ_ONCE(guest[1]);
> +			guest_type = (w1 >> EVENT_TYPE_SHIFT) & EVENT_TYPE_MASK;
> +			if (guest_type)
> +				break;
> +			if (++wait == LOOP_TIMEOUT) {
> +				w0 = READ_ONCE(guest[0]);
> +				w2 = READ_ONCE(guest[2]);
> +				w3 = READ_ONCE(guest[3]);
> +				dev_err_ratelimited(dev, "Event logged [GUEST_EVENT_FAULT invalid guest-event %08x %08x %08x %08x]\n",
> +						    w0, w1, w2, w3);
> +				if (!amd_iommu_snp_en) {
> +					memset(__evt, 0, EVTLOG_ENTRY_SIZE);
> +					memset(guest, 0, EVTLOG_ENTRY_SIZE);
> +				}
> +				/* Occupancy already includes this slot.
> +				 * Skip it so a late DMA fill is not
> +				 * decoded as a host event.
> +				 */
> +				return 2;
> +			}
> +			udelay(1);
> +		}
> +
> +		w0 = READ_ONCE(guest[0]);
> +		w2 = READ_ONCE(guest[2]);
> +		w3 = READ_ONCE(guest[3]);
> +		dev_err_ratelimited(dev, "Event logged [GUEST_EVENT_FAULT guest-event %08x %08x %08x %08x]\n",
> +				    w0, w1, w2, w3);
> +
> +		/*
> +		 * Erratum 732: clear both pair slots so a stale guest
> +		 * event is not decoded on the next poll. The second
> +		 * slot may wrap to the start of the ring. Skip on SNP;
> +		 * that buffer is not writable.
> +		 */
> +		if (!amd_iommu_snp_en) {
> +			memset(__evt, 0, EVTLOG_ENTRY_SIZE);
> +			memset(guest, 0, EVTLOG_ENTRY_SIZE);
> +		}
> +		return 2;
> +	}
>  	case EVENT_TYPE_VIOMMU_HW_ERR:
>  	{
> -		u16 gid = event[0] & 0xFFFF;
> +		u16 gid = FIELD_GET(EVENT_GID_MASK, event[0]);
>  		u8 src = (event[0] >> 16) & 0x3;
>  
>  		dev_err(dev, "Event logged [VIOMMU_HW_ERR gid=%#x address=%#llx src=%#x flags=0x%04x vflags=%#x]\n",
> @@ -1044,24 +1135,27 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>  	 * SNP enabled system.
>  	 */
>  	if (!amd_iommu_snp_en)
> -		memset(__evt, 0, 4 * sizeof(u32));
> +		memset(__evt, 0, EVTLOG_ENTRY_SIZE);
> +
> +	return 1;
>  }
>  
>  static void iommu_poll_events(struct amd_iommu *iommu)
>  {
>  	u32 head, tail;
> +	unsigned int n;
>  
>  	head = readl(iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
> -	tail = readl(iommu->mmio_base + MMIO_EVT_TAIL_OFFSET);
> -
> -	while (head != tail) {
> -		iommu_print_event(iommu, iommu->evt_buf + head);
> +	for (;;) {
> +		tail = readl(iommu->mmio_base + MMIO_EVT_TAIL_OFFSET);

We should read tail outside the loop. Otherwise we may stuck in interrupt
handler context for long time and cause softlockups.


-Vasant

> +		if (head == tail)
> +			break;
> +		n = iommu_print_event(iommu, head);
>  
>  		/* Update head pointer of hardware ring-buffer */
> -		head = (head + EVTLOG_ENTRY_SIZE) % amd_iommu_evtlog_size;
> +		head = (head + n * EVTLOG_ENTRY_SIZE) % amd_iommu_evtlog_size;
>  		writel(head, iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
>  	}
> -
>  }
>  
>  #ifdef CONFIG_IRQ_REMAP

