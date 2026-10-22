Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792647147;
	b=dL53g7/iBkRQ9vvy8q6UWt8B4O62BleHYOpuS5bRSUa6kMjIZZ1FAW+looPM5gOjeYSX
	 1W6HIVCqzGGJEcJAO/uK8NzBXZeTgF/CLkIy/nRTj6ZfcRtt3TBCEi11XwvKLmprrDbY4
	 J4YryQm9q/+uez2e5LgYtPs2kM4Tk7l2QQset+jDMGk8jQHtLB3fltyGiVQEqSBufC5Pb
	 MzkiGACnZEIC/mIGp94Jk6zvU89AkYR2qvgzd2j5Qy8REj8URPQC0vF13t8h5b/v9upUM
	 B3z2mV5wPPYy8koYnqCBGAVYWsIDH5W2oL99IF6Y7i1bTkbIZ6ROdqXZdItYTB0grCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792647147;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	bh=GoyFVEQmrmpDs5Spa00paVrQpesVfiNMtphiwTnAmQY=;
	b=gqHZROaG1QhdUBQwgZyfRWw7/cjAxRbSH/yViEcDtQUHJIrInH9VKaAIqqC9/A0x4u+L
	 sTq+g7XGBwBO9LoI4ewx1tgfQOTr9Y75tAWD0jF7/EH4ol0TUq6GCJq/BtCn/bXCc/DzO
	 qF6dE4N1Cee7jNvMQMBMu1mMlDsJ8jAHqaD9PTuLuDq7HvMcVx1MW8j+p1mOq48gAgs6t
	 scONzCOPNtSf+siUZck2w/fIGLXLmEBiXbeTwW1X2qU9Q2mPsmG5kMnVY8rCWgwOlwGSa
	 PhuRsloV8qjIA4ZeDRZtjEd9xPpr+F2HEu0rsDE56NxV+/rBXCQdW4teUQY0HwMx+pw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ueYFD8Y1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.54
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011054.outbound.protection.outlook.com [40.93.194.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB22606A31B
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 05:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CB22606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ueYFD8Y1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/fIyF/hOLYbKshgqcZZfxAY0bS/fnqfzVoZAtPZCFiYDAKsLCcREZc87CHPyCJXYznWwtPSEeKQrsCS2ySPDoq5X/qCeAJWUi24u6KkPx4Rc7op/rN1Ti0Nd40rgoRgkCXBt05IWFw9Tz2YyCeXEQuvZqYtSFwET8DvmsXiqb/tDRskP8caqMtEJ1f3DegY8z5kH8riOI7tw7maNDZ92pAAgsvrxdAZqbtDoDj8+hDZTz0jGP8HJRZbRQPRdsIJKI+2IZNfoCBkZ32ivuh9FrgNQcUW2kdhQlYHDDx4sYkaz+FgPWSFt4s6W8XKmAcY2ke/crmsmTuyeoP4RaQ85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoyFVEQmrmpDs5Spa00paVrQpesVfiNMtphiwTnAmQY=;
 b=JUrYFh9JY+e4Z0R7eHs9ZOw8qbRvg8hth7iKWjq8ryo8MUDpS0lLL95e5VaVMQi0KD9MJ9W6yr8DEg7rtMex8Vo4T43JYPRUyDpIUU6ZtXmV/octWqXTHtkARLbVBHHJzjBBOkIgIrh9Vz5zQaYdmCrNBgc/udzULzedO843SpcQYsTbz75TKrYNg1XrqUo+TGRhQ4wRkSQTg1M1W9UbSV7gHsBKh0n+NIEJu7k2inE6GPJscCFz8zQYSSKjawHGVts4p3MlLl7Z2NOGVqu5ew7yx443//YBEx6OpvhwUsJvPKB/mVLrgEAOmIbcxC8yA/5bu6hPI7nvVieCuGgF8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoyFVEQmrmpDs5Spa00paVrQpesVfiNMtphiwTnAmQY=;
 b=ueYFD8Y12xKQCFQ9RZ+s9NpW22BY/yrZ2N+ntbtu28Gh77npxO2xQ93qf2ipmN0bOlIbb9CnJc/pp4p4QikyHjcqAWMOcLRArff8o9bMSIhlwiyNyQ9IyGTdu8cgTCbjkKlIg4zPSZX2VG5a2YzOsjEpJokPfIHNGk6MlL8mkDY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 05:32:21 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 05:32:17 +0000
Message-ID: <a6e93726-ff61-4f41-8da5-d45e9cfd4fcb@amd.com>
Date: Thu, 22 Oct 2026 12:32:08 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/24] iommu/amd: Introduce
 EVENT_TYPE_GUEST_EVENT_FAULT
To: Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, joro@8bytes.org, jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, Ming.Shu@amd.com, SooJin.Tan@amd.com, chrisl@kernel.org,
 wvw@google.com, wnliu@google.com, dantuluris@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com,
 guanghuifeng@linux.alibaba.com
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
 <20260930092344.5616-3-suravee.suthikulpanit@amd.com>
 <787b4f08-fd74-4597-8508-fe4ccaf75a24@amd.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <787b4f08-fd74-4597-8508-fe4ccaf75a24@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR01CA0175.apcprd01.prod.exchangelabs.com
 (2603:1096:990:75::23) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
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
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|MN2PR12MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e98ca59-7f57-4984-de21-08df2ffdd5e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|56012099006|4143699003|11063799006|261021123027099003|261021121427099003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	wStmrKnVxmvKKuuy/wG5lesZG6/xfzoK9QxzqKuOTY/cWr+DcTo05/DaZy7yw24rzIcYLl6+Qlchlb3x/315DF8Z0h2IM9be0DkMe5bEo4bxpiXf+JaHgH33nIh+Cmdn2g67Fwlw8cK48tJw916JlM/yt+FPlUJzbd3mSzbrZcJHq0Xk9s2SrN1ABs16F694ugwssou21d4FVem01Fphc5Ff8gPaDXQTa3yhYJUAYXtwFcfcx7CgNHfvQpMT2N+iHPUUm2YlYoDZdYDV7x9g9JKZU9JqZzXdvlhSxK3K7aFE+RZSfalc4R8jMAvWIYDJ9NanX8ykxaWpK4NLwkhNQlW4FF6I7xIuuQr2woipOX2XDDZoPZLRHbqKrPtMTALKJAJTUfIwu07gPcAEFPYM6hg2b6Zszx7COMSJEii464w6vQXPwwfienJHjguLEImcPGNuJ6N/tkuvZF8ktfSLlS1GsM+ksLotbXjPfYIQdd05GmyTAURh9kGl66h7Mcq6UhjkAs74rJtCcLZzm0YQDhmflOo1Uyktmo2X7Bh1jAlI0HgOrQd8+KJGOq6tfU+HGr4xV9IXaJpjC0IcgByb7nC+vLgkw+Is7sMu8Hz/TW2XwvGt2mYAovGC1JYGHAuGTpN3+JipzOXjVUldoIqMHgpLGXBtrUHM4sLolVZUUdI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(261021123027099003)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmVHaTM1R2YwRmVVc1JaeklDRDRHQTJwMDdwYTV2cFJObzY5TFZ1aU5jMjl2?=
 =?utf-8?B?N3lXczdha09aN1phdUlmNE9SNG9PRGVNM1FONHNGSGNPamJwcUV2RlgwWjdh?=
 =?utf-8?B?Z0hNZXBweXZvU2tPZnphSmViMG4rN2NJUVNKRzBjOXNOdmd5anlZT09tSmk1?=
 =?utf-8?B?YytCMEZ4azZqOFlUR2pBRElaR2JRblpRZ0dzRlNHQXZ0dlpPeDZtTXFyR0Fq?=
 =?utf-8?B?RWlqUzNaeVhNRHBFOVROS0RjTFFUWFhtSktNaDdtd00zS0ZYcG1Dbktzc0VL?=
 =?utf-8?B?WllsckVqclZBTVFaSVR3bGZqT0VoRkJSVjV5UUVRVTAvZEdmcGhNVUhCaW5W?=
 =?utf-8?B?d3phQXNZaEI2OG9lKzY1UEk3YWVuc0Z1ZFRNNHYzV0lzL0FFOTQ0WkRYK2E0?=
 =?utf-8?B?aWN3ZTZWSytMUWFHKzdXWUtHNUc1V3V2dVRYb1BzcXZWaGtLZGQ0QjJReUdF?=
 =?utf-8?B?UUM4WVJBTlVqTDkwSzRJcklkMHBMVkd3M2dkdnJZKzFYaWx0L2N3UitIaURF?=
 =?utf-8?B?OFowTUN5Z201VTZya0JCWG1mS3BPeEVGM29HV3JYMlhwK2l4dGZvS01SejJ0?=
 =?utf-8?B?OThPWEVEVitudEl4UExWS1hRWG1HZS9SU2FKOC9yK21jK2x6Z2NTV2UwbDly?=
 =?utf-8?B?VU5IMWF4dDhVTDhNbTJ5bFRwbHlSQWgxK0FmWnBpbS9BMlZaT0FQNVVmUW55?=
 =?utf-8?B?c3lTR3JjQ1VkOWNKeEwrZE1BM0E1OEJZSHN6bGZxelYzYTJMSEZ6NFNNdTYz?=
 =?utf-8?B?OThjb3BjdGl0YkVoTWNtZytNdGQ3YTR4R3Znd29Bam5LYWVlTm0xbGlzSk5p?=
 =?utf-8?B?WEpmQzVoUmsrbGZISGJGenF4aTNnQUF1anNUcGVLa0xiM3RMSnJTd0QvU2U0?=
 =?utf-8?B?MHU4ais3ZVJUa29GMlJjSmZyU040VExWRno2UUZLVVNpVUpYLzl3YlJEYmo4?=
 =?utf-8?B?Wm5CQVZRbzkrVUF5OWtXdGNINnQzemcxSHhBaE9VUGJOQ3ZoUzBHaXV3bC9S?=
 =?utf-8?B?TjRWOGVKaUREdWpPUnZEdXJLN213ZXg2eTdhTjMvSW00MnhLZEhpODZvc1NZ?=
 =?utf-8?B?amkyaFIyQ2FjWE1yQWRDVnR6U0UzOTA5bFlNQk1YbCtvMkRZbjgyN3Vnb29G?=
 =?utf-8?B?TGdXcXhFMlhwbzhkU0w0UkhCQjRCclk2cFY0Y3J2NmN6VFdQSHhTTGRkbnBk?=
 =?utf-8?B?eFg4dlc3cjlMKytGQTVuNkd5YXByeW83L1ArQUNzZmZyZUJNTlhpcUJZRFk1?=
 =?utf-8?B?cDEya2R5SGgrMitRejhCbSt1TFB1aGUvenFmUzVTYXh0bEtZQ0tleU54Z3Rq?=
 =?utf-8?B?bmZadTUxOWEyMTBTdXZiVWhJeXpqNDNVSmJKb3VuekpZRTVlQUdYN0xZamFr?=
 =?utf-8?B?aFQxSkhrREhOZEttNVlrNytvQ3huZ1JTK3R0YTFvUXpRQkx3NWFoM1VCQlZ2?=
 =?utf-8?B?bGlXNVVlQzJqMGcydFNndkovcDFJNEwrUzdkSU9YbHVNd01USWc5czRiblJu?=
 =?utf-8?B?ZTVpMUJzLzRRSEJMTzdkeUpaWWZtWXZCYzZQMzFPUDN2Ym9xcmhxWnpRNXRX?=
 =?utf-8?B?QTk1bWQyOXJ3N1NtbXZ0Zm5ubFFQRkxDMkJ5K3pQL3JkK3hEaGlsc0x3ME1J?=
 =?utf-8?B?ZW4ydDB2eThRcjFQR20vVEVjT2IraTBIdnBnanVFbHdHdnFsODhPb29nUXUv?=
 =?utf-8?B?NnpLTXNqOG9RMGQ4dDYzMFQ0YVZNUlJZc0tBMHEyS3pjYWNmT1pLeW84RHNy?=
 =?utf-8?B?Ly9jUm9CK0VXeFB6ODlmK2VXeW1hazRJelVycXlhMFBTSGRNWUliUjlrNGxz?=
 =?utf-8?B?Nlh3NGZscWNwdHBHUFdROHVSQkRES2pjK2xMSU5vWGVJcHp1Zk1qWWhMQkts?=
 =?utf-8?B?ZjFKejJXeGVDbmFqOWdwRDVQRk1Ga0ZkSDNOT2hhQWxnOFFkV2M5WWgvK2or?=
 =?utf-8?B?K1I1elNXMTJRelZMdmxFRnU0ekxUaTRYWkdKZ2dnamllcDZCSjdXckJBUDRq?=
 =?utf-8?B?YTVlOSsxQXQ2NGNnR0lYank5YXRJSTlrUjlCc0htRUpwbk9CaFZ2dno0Q1Ar?=
 =?utf-8?B?VWNDeHJDdExlbmNVM052OWZsNkN5MVNZZDdpeU1kUjJIL00yUEpoUmNKdGZv?=
 =?utf-8?B?U0x6M0tKV0dld3Y2bVp0cXdiTlA2TXI4a0lhdkF2MmN5a3RLK0lmemx5VUZn?=
 =?utf-8?B?RW8vaHo1aGRGWC96YnRrR2pJc1ZWMWVFOWZtNnlMNm9mTUJGSGtNQXViS0t0?=
 =?utf-8?B?WVpReDFReDZTM0l3T0lEeU5zTmpXOXF6UElLdjlZenl6SGtaSFBhV1ZjMTBo?=
 =?utf-8?B?S2ZWcHEwbFFZaDBzM3o0S01HaWlwaDloQldHZjZNVXk0Zko2ZjZaUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e98ca59-7f57-4984-de21-08df2ffdd5e4
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 05:32:17.4996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N711iAQyms3C3FpdGGkDlGAr4/Mb9yV0MmniIzSI5TjcSCHW3wpGIl5JF/N4PVefhIGNnfuNUFgJ3qjgb2XujA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064

Vasant,

On 10/19/2026 1:10 PM, Vasant Hegde wrote:
> 
> 
> On 9/30/2026 2:53 PM, Suravee Suthikulpanit wrote:
>> INSERT_GUEST_EVENT with non-zero reserved bits logs
>> GUEST_EVENT_FAULT followed by the original guest event.
>> Consume both event-log slots, wrapping via
>> evt_buf+(head+EVTLOG_ENTRY_SIZE)%size, and dump the guest
>> payload raw so it is not decoded as a host event.
>>
>> Wait until occupancy is at least two entries, not merely
>> until live tail is not the pair offset. Re-read the
>> event-log tail each poll iteration so a return of 2 cannot
>> advance head past a stale cached tail and walk empty slots
>> with the type-0 erratum retry.
>>
>> Retry a type-0 guest slot up to LOOP_TIMEOUT, the same way
>> erratum 732 waits for the primary slot. Return 2 only when
>> that slot is already in [head, live_tail). Return 1 if the
>> pair never appears in tail. Rate-limit the guest-triggered
>> logs.
>>
>> Log an invalid guest-event when the pair slot is still
>> missing or type 0 after that wait, instead of stalling
>> the event log.
> 
> 
> As per spec:
>    GUEST_EVENT_FAULT event is always written in pairs with a guest event entry
> immediately after it into the event log.
>
> Why not add one additional check in iommu_poll_events() such that:>    if event at head is GUEST_EVENT_FAULT and actual fault event is
> not-yet-written by HW just return.
>    If subsequent event is also written then handle the event.
> 
> and increase head pointer accordingly.

I would like to keep the code for handling GUEST_EVENT_FAULT (including 
the logic for checking guest event pair entry) in iommu_print_event() to 
simplify the code readability.

Originally, I try to handle the case where the guest event pair may 
arrive late, but that adds complexity to the tail polling logic. For v7, 
I can simplify the logic to just report GUEST_EVENT_FAULT event with 
missing guest eventinstead then.

>> ....
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 43a5690721af..2df81e29519e 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -942,8 +942,18 @@ static void amd_iommu_report_ppr_err(struct amd_iommu *iommu, volatile u32 *even
>>   	pci_dev_put(pdev);
>>   }
>>   
>> -static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>> +static u32 evtlog_used(u32 head, u32 tail)
>>   {
>> +	return (tail + amd_iommu_evtlog_size - head) % amd_iommu_evtlog_size;
>> +}
>> +
>> +/*
>> + * Decode one event-log slot (or a GUEST_EVENT_FAULT pair).
>> + * Returns the number of slots consumed.
>> + */
>> +static unsigned int iommu_print_event(struct amd_iommu *iommu, u32 head)
>> +{
>> +	void *__evt = iommu->evt_buf + head;
>>   	struct device *dev = iommu->iommu.dev;
>>   	int type, devid, flags;
>>   	volatile u32 *event = __evt;
>> @@ -965,7 +975,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>>   		/* Did we hit the erratum? */
>>   		if (++count == LOOP_TIMEOUT) {
>>   			pr_err("No event written to event log\n");
>> -			return;
>> +			return 1;
> 
> This will cause head to progress event though there is no event. 

Actually, there is an event (since the head != tail) but with (type == 0 
: invalid event). So, we need to discard the entry and increment head.

>>   		}
>>   		udelay(1);
>>   		goto retry;
>> @@ -975,7 +985,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>>   
>>   	if (type == EVENT_TYPE_IO_FAULT) {
>>   		amd_iommu_report_page_fault(iommu, devid, pasid, address, flags, vflags);
>> -		return;
>> +		return 1;
>>   	}
>>   
>>   	switch (type) {
>> @@ -1023,9 +1033,90 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>>   	case EVENT_TYPE_INV_PPR_REQ:
>>   		amd_iommu_report_ppr_err(iommu, event, devid, address, flags);
>>   		break;
>> +	case EVENT_TYPE_GUEST_EVENT_FAULT:
>> +	{
>> +		u16 gid = FIELD_GET(EVENT_GID_MASK, event[1]);
>> +		u32 next = (head + EVTLOG_ENTRY_SIZE) % amd_iommu_evtlog_size;
>> +		u32 *guest;
>> +		u32 live_tail, w0, w1, w2, w3;
>> +		int guest_type, wait;
>> +
>> +		dev_err_ratelimited(dev, "Event logged [GUEST_EVENT_FAULT gid=%#x flags=0x%04x vflags=%#x]\n",
>> +				    gid, flags, vflags);
>> +
>> +		/*
>> +		 * GUEST_EVENT_FAULT is paired with the original guest
>> +		 * event in the next log slot (possibly wrapped). The
>> +		 * poll-time tail can predate that slot. Wait until
>> +		 * occupancy is at least two entries, then retry a
>> +		 * type-0 pair slot the same way erratum 732 waits
>> +		 * for DMA visibility. Return 2 only when that slot
>> +		 * is already in [head, live_tail). iommu_poll_events()
>> +		 * re-reads tail each iteration so head cannot skip
>> +		 * past tail.
>> +		 */
>> +		wait = 0;
>> +		for (;;) {
>> +			live_tail = readl(iommu->mmio_base + MMIO_EVT_TAIL_OFFSET);
>> +			if (evtlog_used(head, live_tail) >=
>> +			    2 * EVTLOG_ENTRY_SIZE)
>> +				break;
>> +			if (++wait == LOOP_TIMEOUT) {
> 
> I think we should avoid avoid this loop in interrupt handler path.

I am removing this loop.

>> +				dev_err_ratelimited(dev, "Event logged [GUEST_EVENT_FAULT invalid guest-event (does not exist)]\n");
>> +				if (!amd_iommu_snp_en)
>> +					memset(__evt, 0, EVTLOG_ENTRY_SIZE);
>> +				return 1;
>> +			}
>> +			udelay(1);
>> +		}
>> +
>> +		guest = (u32 *)(iommu->evt_buf + next);
>> +		wait = 0;
>> +		for (;;) {
>> +			w1 = READ_ONCE(guest[1]);
>> +			guest_type = (w1 >> EVENT_TYPE_SHIFT) & EVENT_TYPE_MASK;
>> +			if (guest_type)
>> +				break;
>> +			if (++wait == LOOP_TIMEOUT) {
>> +				w0 = READ_ONCE(guest[0]);
>> +				w2 = READ_ONCE(guest[2]);
>> +				w3 = READ_ONCE(guest[3]);
>> +				dev_err_ratelimited(dev, "Event logged [GUEST_EVENT_FAULT invalid guest-event %08x %08x %08x %08x]\n",
>> +						    w0, w1, w2, w3);
>> +				if (!amd_iommu_snp_en) {
>> +					memset(__evt, 0, EVTLOG_ENTRY_SIZE);
>> +					memset(guest, 0, EVTLOG_ENTRY_SIZE);
>> +				}
>> +				/* Occupancy already includes this slot.
>> +				 * Skip it so a late DMA fill is not
>> +				 * decoded as a host event.
>> +				 */
>> +				return 2;
>> +			}
>> +			udelay(1);
>> +		}
>> +
>> +		w0 = READ_ONCE(guest[0]);
>> +		w2 = READ_ONCE(guest[2]);
>> +		w3 = READ_ONCE(guest[3]);
>> +		dev_err_ratelimited(dev, "Event logged [GUEST_EVENT_FAULT guest-event %08x %08x %08x %08x]\n",
>> +				    w0, w1, w2, w3);
>> +
>> +		/*
>> +		 * Erratum 732: clear both pair slots so a stale guest
>> +		 * event is not decoded on the next poll. The second
>> +		 * slot may wrap to the start of the ring. Skip on SNP;
>> +		 * that buffer is not writable.
>> +		 */
>> +		if (!amd_iommu_snp_en) {
>> +			memset(__evt, 0, EVTLOG_ENTRY_SIZE);
>> +			memset(guest, 0, EVTLOG_ENTRY_SIZE);
>> +		}
>> +		return 2;
>> +	}
>>   	case EVENT_TYPE_VIOMMU_HW_ERR:
>>   	{
>> -		u16 gid = event[0] & 0xFFFF;
>> +		u16 gid = FIELD_GET(EVENT_GID_MASK, event[0]);
>>   		u8 src = (event[0] >> 16) & 0x3;
>>   
>>   		dev_err(dev, "Event logged [VIOMMU_HW_ERR gid=%#x address=%#llx src=%#x flags=0x%04x vflags=%#x]\n",
>> @@ -1044,24 +1135,27 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>>   	 * SNP enabled system.
>>   	 */
>>   	if (!amd_iommu_snp_en)
>> -		memset(__evt, 0, 4 * sizeof(u32));
>> +		memset(__evt, 0, EVTLOG_ENTRY_SIZE);
>> +
>> +	return 1;
>>   }
>>   
>>   static void iommu_poll_events(struct amd_iommu *iommu)
>>   {
>>   	u32 head, tail;
>> +	unsigned int n;
>>   
>>   	head = readl(iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
>> -	tail = readl(iommu->mmio_base + MMIO_EVT_TAIL_OFFSET);
>> -
>> -	while (head != tail) {
>> -		iommu_print_event(iommu, iommu->evt_buf + head);
>> +	for (;;) {
>> +		tail = readl(iommu->mmio_base + MMIO_EVT_TAIL_OFFSET);
> 
> We should read tail outside the loop. Otherwise we may stuck in interrupt
> handler context for long time and cause softlockups.

I am simplifying this logic.

Thanks,
Suravee
