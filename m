Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795187428;
	b=A4uZ585ErYQNsCgGP6jiATnPaz7Yz5D96fMvXR5j3pv9oBASzsQxhxlZ/zYJZnglz1Lp
	 lFVhPnWDhKnm7RnoXWIPmpgPkmoQOwEbGnZmHr5G43OBK7AeVfxPxKLadCnt7UVZFqBfI
	 w6nJM04nenpMS4i+OZODtP3n9FpCTw3W20QErVuJzRqLsJ/MLCjWiO34Ohs0FO3+KBycs
	 4S2eQfFNHwyw75rbQqW4BHK22/2LLCrRcRIkZiISYtl8psCArOQg8bTdECcO22w+CgpTe
	 /+BZtkg6Zt027PhgTayR3N0stwBbkPgHES7sghnnXhhlEAm1ehxhTBIKnlV7h6Mc+yw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187428;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=vcplZTAAHGX3T5p/VasZIZDV+0KoqnxnxmPFnZ76yLY=;
	b=185eJuIjGYiZIE/YDHkjen1SYQZmEU1oA41FidN8CvxzmnAafdV7Sjy7ma8hHWnHfs2B
	 u/PO65GyE7OojWTwr1CGtmB6B6SeYsj+sUgfz0cDR8JdXvSAYHWjHNzbx2UweptsVjXF9
	 7l9l7y2ze5PYX5zS8qBifBLC79/sVnm4SbIOZTHZSMllbKsqfpJs2RQZ1ojW2UqmTQ/aQ
	 OPYyKa4kD+Ej46At9Fl+YyUOwF9/ReWlhNjcVv6+29pQQINPaM6pCXqr0r6f6Q6equNxU
	 M2EytGghYheu+LwNjdJC3MQ0PQ7vlprcAcSV+FFIpmWmtGLD4jq/R/xH/TOKM7B3S4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="ffTEU/LS";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.3
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012003.outbound.protection.outlook.com [40.93.195.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8028D606A32C
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 15:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8028D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ffTEU/LS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONg6X2G9Mo1c+JoGfQR3hrgsqzbrzNXVdWwx7Z3ElT4htiV95QAuNkBQhkUL2LFYU82OBkIrC88ioERT2T7r4NMrCx0rJInGtdpQRbS/IDmrTE5+DGcXQiRjCKunnRoAtqy/Im9CGo5AYw49+yLB3T3L4WNEFEz3eM3EzKEwpEhgrabCjkO0Vwgxn16HSwBqEGHmYB0DOWcOHaT5eaJrhQGhsDc5cGkvWMU7y9OISq3EeyRVTsfmK4q7N1/qi8hNkBoL1IJRZcuhMEgi7eGoSW5iflibEesrW570AYj5uhG0VEmQOz54QXcpep7K3xQvXHKiQ1oB3LzVvhT4go81FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcplZTAAHGX3T5p/VasZIZDV+0KoqnxnxmPFnZ76yLY=;
 b=Cr0G7aY1kzn5cG9ntknVDmoe/tqESyL9W7VxuXdkZvltecOwAzHnb5kGRjrUI2butxXrBYTvGObFpq6gJpv1Qq6dLeKhiS88WoyWVES34alvUwnqP5fsPw4RPfTD8+L1XsPHuTb9frII1FW9YWLP3ZpwK50nd36YV92cEB5UJhQRv1kM43F6WlEIYhkqJYu5+9CZCUkxE+8445CV49J06jsPxsqt5xMRwgNqqA2LnU4fTiJkeeYh3n5QnH95Gr8OaHR6fD8ri3nWAnsLXzJ5Mhrq+2P2QCFJLSq0XI9ZX0ZiWnboPLfOybFS/jTmKfFxpTSWkCttkOmKPbRj0aQhEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcplZTAAHGX3T5p/VasZIZDV+0KoqnxnxmPFnZ76yLY=;
 b=ffTEU/LSCP5vcb9OMrxenMZFzsfxuXFYkjyIbDtkv21Py3jSUIz+EwtlCNqtX5x1AkbVrmBQ6n16ihKyQXzkB5AJ7mAvQ/eIKExcrks507P4EyLxpk6JZe23wSNM0Ocky/C+2RpMLEqFOLjWH/PjRwjko816b0PKhNCzXBYHEno=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by CH2PR12MB4213.namprd12.prod.outlook.com (2603:10b6:610:a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 15:10:22 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 15:10:22 +0000
Message-ID: <20a94854-4a7b-492d-bfb2-98daa3da3932@amd.com>
Date: Fri, 20 Nov 2026 20:40:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] AMD IOMMU v2 failures on Cezanne; page-table
 flushing helps
From: Vasant Hegde <vasant.hegde@amd.com>
To: Nathan Blomquist <nblomquist@gmail.com>, joro@8bytes.org
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
References: <CACOV87VBwH+R3eSBEOuz8hk7OaT63+A9m6ipPSW5wt1VhHMFPg@mail.gmail.com>
 <CACOV87WpRNEo=7ckZBdcmGnZ17c3w5qPOe5jY9ZJUdr6y_DAVw@mail.gmail.com>
 <8af27dcd-72b6-4a16-875a-057d369450b6@amd.com>
Content-Language: en-US
In-Reply-To: <8af27dcd-72b6-4a16-875a-057d369450b6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0342.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21f::9) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|CH2PR12MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: 635fe121-f07e-4020-49d2-08df4718659b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|22082099003|18002099003|261009223027099003|5023799004|4143699003|11063799006|56012099006|261026121527099003|10067099003|261028144727099003|261022105027099003|261102123227099003|261026140227099003|261021121427099003|261022075727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	uL4SkH7yPHaObQoQI8GU75kAe+QsVk+3p/qY1DWckyUWs1Tg7wEYlG4XyMKrtcKOopb+Yngod3O+4W1vfHVmKkhlhnkQGBJROiRPY/9uAJN3jtvzpA6+TrlruhuaN7WmPsty/HglIX1Qj7xIjHTRyPDhJ3Sy03I5xFVPoucXbBWKZsyLD8HdPB3qJZjiZSu8jmlzEajylhO+RX1BtWaAIxQCLnMlBX0sSoh1cYLjo5FJK+B8t6YSRdb9JNDEx+JnsU6o8/dODNSzWj7xZFYxEDb23oSTh31kkwvMwAsq9JmZ504gp3Iq9JkAb1tVsrxIF3yU25dVi0R7X33t+8n4J6UxoysfoEWxTTxVp8YttKatxJZez+gfXnrEP8BOJP284nfcxrtkHO3slX1foCbSqSXNDMmhi43XsJC7GETOVdsO2jFe7hlVHlIWzK7tN8xy6jqzfRuOLmGdoupo1P0cS8W7r/BfYWySatreZFwnq7ezEuPnn49vIp40xdD13AiA3ZXVADLiW4TWPRacDzbXZHINkOcySEdXfVN9EESZso5n9J+EwgpPwCS7741JXi+FQqe7o/6wActRPihiig2HWGNBObioKGquKXw1Imb3A2j8kGW9esHe4rCIjmDeoXac
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(261009223027099003)(5023799004)(4143699003)(11063799006)(56012099006)(261026121527099003)(10067099003)(261028144727099003)(261022105027099003)(261102123227099003)(261026140227099003)(261021121427099003)(261022075727099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3AzUjBQbDBiTlJqeHhIa05mWjJza1c1VVF5b2JTTG9PZ2RzUnVadnRvQ1Vp?=
 =?utf-8?B?TmdVNEhQSlRzSU1IeTlDYXRRR1VPcDFZaVZXaVJ6VDZBUituT1hPbHJUT0tW?=
 =?utf-8?B?YXhtSkhZbnFnMmhEOVNiMTcranJmb3FyZTR4OVY3d0EwUGVPQjdPNWducnpX?=
 =?utf-8?B?bWhobWxJaGR0akZpZmtGMDhqUkpaZEhKT3RZa0htQ2ZUNkQvU1E2eTJTVXpW?=
 =?utf-8?B?c3BpQnROampXeXk1Rm1UcUd5Qjgvb1h2RE1NUDlQTmdweWZGVTFsSXJFTVJa?=
 =?utf-8?B?UVk0WXlZdy9BeTJGekE1YUZCZ0VBV3VHTzdZWnVyblczMlV1VEhjNThmY1Qy?=
 =?utf-8?B?M0hHN3o4dEJPWmd6WlN4bTUwTTQzUkx3VEEyaXB3RERNRWR0eTFTOCtsT2cz?=
 =?utf-8?B?ZWJtTURvaGlZVjNoMTZiSm4vMXI1NFg0anlFR0FsclVvUSs5ZTM0V1Z3NWZv?=
 =?utf-8?B?angyR29ZRFZQRmNUT1dVWFNpR0FESXo3T3oxWkduQ0JYczhrV1lUTEhkTUdN?=
 =?utf-8?B?b2NVdlk5azkxU2wzYW9KWngrK1ZnVXVwSHQvWTMxbnp4TlF6K1JwVWtNYU1r?=
 =?utf-8?B?V1A2Vks4TU1vL05USjdJbFBZb0V5bWhEYmJzOTFzNThCQ3pJLzNEWUYzR2NR?=
 =?utf-8?B?QXgxMnZvQXBDYnpwckJsUHF4VDJxMEd5ckNZY2MramhRdG1tc3VXWDFlVEU1?=
 =?utf-8?B?L1plbnRBcktwMVZFSzA2dlRHV3BhZ2Zzamk0aEN0RjVvUmFOR2NvRWNOZm5s?=
 =?utf-8?B?emp6ajBpQUdjSHdzenlaTkFMcHFjdHBKNm9LZ3RoNzJhcG1CVzc0bFUySjFZ?=
 =?utf-8?B?dERWWGtzcm41RXJ3Sk5xd2M2YmFPWnQzSlR3eTF6ZmNuQUZHcjRZN212ZUY2?=
 =?utf-8?B?WjVzVDJoWm9RbitjVjVDZ2hINHVKR3JIZVUxT25EQ3JmVmtTOEVYTmw4aGFx?=
 =?utf-8?B?VnJpUEcrY1pNY0xHMHJZbHcyYnVXQ1JqYWJOb1VEaEtwUzMzVzBZUEpMd2s0?=
 =?utf-8?B?RlZNZ0x4WVVjK0QwcTQwSXYxUkxLV0ZzYU1va1Bkcm5JYS9keEN6MEgybE5N?=
 =?utf-8?B?VjM0eHYyNUMxdGRtYnRkdWpIL00xTnh4RlVCazd2TnhVa1g3RnBhV3pySG1k?=
 =?utf-8?B?UmJrV1U1TkdYWUROVFp0akpKNUExdWs2RFdiaEs5V3l0MVN2TmJVZldkN3Ar?=
 =?utf-8?B?QWVSUUpybUhldHJycWlFbnl6WWpPbThWbzVyeUJFUUp1NGQ3OEdmZGluemFY?=
 =?utf-8?B?VUdLbllENEVhaVQzUVIzamhkdEIzaXVYcGNPbjhsTm5xNXZyVVpmcGQ0VWNm?=
 =?utf-8?B?VVhNUWxrRDE0emlaN0pzQ0xqcmhTNnBMV2p3SlBtZXRYb3RPZFBaWDdGTmdw?=
 =?utf-8?B?MDBuVHVITDdiMDdzb0FucUNEQXA2MkJVZmQweGJTSnZWMVVsb2Q3SkQ3cXFU?=
 =?utf-8?B?RVdNVnFYQXY5TTBPRVZwZVdyeUVpN3FKTGtQK0wxSjE5ZG80bVpTbWVmZlpi?=
 =?utf-8?B?K3FxR0dCR21OdjZuVVp1dWRDbG0vcDdaMFdnM0JVZS8xQ2FwM2ZCMXZrbXhK?=
 =?utf-8?B?N0Y0KzBjWWtzaWRMUWlwRjZleElxb2hxWHhJeEs1Ti9kYjBEbDA3cTVHR3NQ?=
 =?utf-8?B?dlNzTVhEb2xtT1BEUXFOL1JmeFA0ZkxDWEF1c2VvTDhEcHNqZFJ0VXJYeGpL?=
 =?utf-8?B?MENOUStWbThTQWJzZmowR2xVWWtRTXJZRkhlNHJKVTdUajNPSWlpNWROT3dV?=
 =?utf-8?B?amZDYkxSMkFqWFpESXA0YmxUUy9pdHYvUEdGdXZqV0VWdUNaZFdQWFQ3dlNi?=
 =?utf-8?B?dGdtR05lQ0xJT3hCMmpCbmFQV3RjQS9RUUpYNk0xbTdmR09JU0x6L25YQjZv?=
 =?utf-8?B?ZWRwb3pOOWt0Z2hHWkxsbzRsMXFpTmxJOVcySzE4MWxBMXdqQjUvMFNxSkhN?=
 =?utf-8?B?OHdyR0FlZSt6UFJHeFIva2Fsd2pJbi9lcWpISTdSazBOTnBNK21SOHNUWFNs?=
 =?utf-8?B?Y3dnWGlmVVV0VWVKM0tsMzh3RXJpL0NkVXhYOWcwWmwxQUd0S05qUDBxbFM3?=
 =?utf-8?B?RklJQkUzRDdocmFxZDZJNExNRkx5RUVKMnkyNzloYS9pNVZhZzIyREljdVhm?=
 =?utf-8?B?TXgxQ0F1TXk3ODN0QTJTSmswVXRIL0RkeVgxYXZ2U3lqSmNTYktIUC9VRjdn?=
 =?utf-8?B?eW1xcVkyNnR0WlQzaERDK0lkU1V3N0UrcDBXOWtFN3VyNWxFNU1uOFhPU3VV?=
 =?utf-8?B?Q1JtdFdySGFRMU5lUTdjeTdUT0lQMDY0NWxCWkxnblRMcFA3MXFVaGhVRXJz?=
 =?utf-8?Q?LIDlXdS6o8zBKAY9RZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 635fe121-f07e-4020-49d2-08df4718659b
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 15:10:22.0689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSD+cveRWp0TSmGz4A/uUNJnpEDMl3v15cIFgm9YrMIwHPYpuDr6tn7r8XpkhErkm9ylC0cxoDC/vmWh/5iUgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213

Nathan,




On 11/15/2026 5:26 PM, Vasant Hegde wrote:
> Hi Nathan,
> 
> Thanks for the report and all the experiment you have done to narrow down the issue.
> 
> 
> On 11/14/2026 8:49 PM, Nathan Blomquist wrote:
>> [You don't often get email from nblomquist@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Hi,
>>
>> A further test result from the affected Ryzen 5 5600G (Cezanne) system:
>>
>> I booted with amd_iommu=pgtbl_v2 and the experimental v2 page-table
>> cache-flushing patch described in my original report. The system boots
>> successfully, drives/storage work, networking works, and usb devices work.
>>
>> Before the patch, booting with amd_iommu=pgtbl_v2 caused widespread
>> failures; almost nothing worked.
> 
> Interesting. We regularly run tests with pgtbl_v2 on server platforms and we
> never saw this issue. I did double check on Turin system today and it worked
> fine (it doesn't have GPUs, but it has NVME's and Network card).

Mario and team narrow down the issue and confirmed issue is specific to Cezanne
platform. I will send updated fix soon.

-Vasant


> 
>>
>> This suggests the problem may extend beyond Radeon initialization when
>> v2 translation is selected more broadly on this system.
>>
>> The cache-flushing change is still experimental. This result does not
>> resolve cache visibility versus ordering/timing effects or establish
>> performance and long-term data integrity.
> 
> In v2 (guest) page table mode, we don't have explicit 'coherency' bit. But we do
> have a DTE.SD bit which is set to zero.
> 
> From spec:
> 
> 0=IOMMU page table walk transactions for this device are snooped.
> HyperTransport™ transactions by an IOMMU must set the coherent bit in page table
> walk requests for this device.
> 
> So far my understanding was we don't need clflush as we don't set DTE.SD bit.
> 
> This patch may impact the performance little bit.
> 
> I am not aware of any erratum on coherency issue. I will check internally and
> get back to you.
> 
> -Vasant
> 
> 
> 
>>
>> AI assistance was used to draft this update.
>>
>> Thanks,
>> Nathan
>>
>>
>>
>> On Fri, 13 Nov 2026 13:03:53 -0500, Nathan Blomquist
>> <nblomquist@gmail.com> wrote:
>>> Hi,
>>>
>>> Resending in plain text because my earlier email included HTML.
>>> Apologies if you receive this twice.
>>>
>>> Could you take a look at this AMD IOMMU regression? Since 7.4-rc1, my Ryzen
>>> 5 5600G systems fail to initialize Navi GPUs under v2 translation. Identity
>>> mapping works.
>>>
>>> The bisect points to bf5bdfd1f8d4 ("iommu/amd: Force identity mode for
>>> selected GPUs only").
>>>
>>> I've attached a small experimental patch and logs to this comment on the
>>> AMDGPU bug tracker:
>>> https://gitlab.freedesktop.org/drm/amd/-/work_items/6081#note_3782405
>>>
>>> I found that my dGPU stopped working when trying 7.4-rc1 for a different
>>> issue.
>>>
>>> The patch enables the existing guest-page-table cache-flush handling
>>> through PT_FEAT_DMA_INCOHERENT. Pristine 7.4-rc2 plus those three lines
>>> initializes both an RX 6600 and RX 5500 XT, with no IOMMU faults or PSP
>>> errors. DTEs confirm both still use translated v2 DMA-FQ domains.
>>>
>>> I also tested whether the flush's barriers alone were enough. Using one
>>> unchanged kernel/initramfs, both GPUs gave these results:
>>>
>>> - Cache flushing: pass
>>> - No flushing or barriers: fail
>>> - Two MFENCEs without flushing: fail
>>> - No flushing or barriers again: fail
>>> - Cache flushing again: pass
>>>
>>> The feature's other effects were retained in every mode. Failures had IOMMU
>>> page faults followed by PSP KDB-load failure and probe -22. GCR3-only
>>> flushing also failed in an earlier test.
>>>
>>> So two MFENCEs alone didn't help, but I haven't ruled out the extra delay
>>> from flushing. This is a diagnostic patch, not a proposed final fix;
>>> performance is untested.
>>>
>>> Is there a known Cezanne coherency erratum or something in the v2
>>> table-update path we should check? Full logs, DTEs and diagnostic patches
>>> are available.
>>>
>>> AI assistance was used for the diagnostic code, testing and write-up.
>>>
>>> Thanks,
>>> Nathan
>>>
>>> Subject: [RFC PATCH] iommu/amd: Enable cache flushing for v2 page tables
>>>
>>> On a Ryzen 5 5600G (Cezanne) test system, an RX 6600 and RX 5500 XT
>>> fail AMDGPU initialization with translated v2 DMA-FQ domains on v7.4-rc2.
>>> IOMMU page faults precede PSP firmware loading failures and probe -22.
>>>
>>> Enable the existing generic page-table incoherent-memory handling for
>>> AMD v2 domains and provide its required IOMMU device pointer. On x86,
>>> the existing flush implementation calls clflush_cache_range().
>>>
>>> This is an experimental extraction for review, not a proposed final
>>> platform policy. It enables this handling for all AMD v2 paging domains,
>>> not just the affected platform. Cache visibility versus flush-induced
>>> ordering/timing remains unresolved, and performance is unmeasured.
>>> The feature also disables a single-page fast path and sets an ignored
>>> AVL bit in non-leaf entries.
>>>
>>> AI assistance (OpenCode) was used for the diagnostic implementation,
>>> test automation, evidence analysis, and this extracted patch and text.
>>>
>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/6081
>>> ---
>>> Base: pristine v7.4-rc2, before applying the c1diag diagnostic patch.
>>> This three-line extraction was separately built and boot-tested once,
>>> without diagnostic logging, mode selection or GCR3 modifications.
>>> No GPU workload, performance, cold-boot or other-platform validation yet.
>>>
>>> drivers/iommu/amd/iommu.c | 3 +++
>>> 1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>>> --- a/drivers/iommu/amd/iommu.c
>>> +++ b/drivers/iommu/amd/iommu.c
>>> @@ -2810,6 +2810,9 @@ static struct iommu_domain
>>> *amd_iommu_domain_alloc_paging_v2(struct device *dev,
>>> domain->iommu.nid = dev_to_node(dev);
>>>
>>> cfg.common.features = BIT(PT_FEAT_X86_64_AMD_ENCRYPT_TABLES);
>>> + domain->iommu.iommu_device =
>>> + &get_amd_iommu_from_dev(dev)->dev->dev;
>>> + cfg.common.features |= BIT(PT_FEAT_DMA_INCOHERENT);
>>> if (amd_iommu_np_cache)
>>> cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE_NO_GAPS);
>>> else
>>>
>>> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
>>
> 

