Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EE0152515
	for <iommu@lists.linux.dev>; Tue, 23 Jul 2024 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721752746; cv=fail; b=ZpHziQBeNq6BvELokVxw46pz0L4wQiWNsATrCJAGo7jWwxTCtZKJfo73B9lEtybjXrB6SPnm1PM2CKNk2nas+WNGbg1R+kCW6ewKbcMg5GMvwvjbSRi0FE6hp3iRuWz2LBuo8wa4+JjA0i8vvdmbp+XKjCdGBwRejQ77Djwm2EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721752746; c=relaxed/simple;
	bh=BHvOU6g/yzuJZR4zeqUT0Noz2QnoiGvl1knSztFEUQk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=psXhM6BQicHGG1k+b67zoZLsiLl8KlpWbKerVlhwNuMmkeJkxUmGkb2iAN/JQLRHGs82Nfj3VdvWJaJegWoQ/SvJvXtawy8gOSnbU1K0IYUI/X+iFDvHtU5CV5VIj8pK7WfJER4puDo5tO502K16HPX+OCVHeombvLKcF22fwKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vJwVxV94; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vJwVxV94"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIj5Fk4Doy614tdcc7AwWmdrtvaxXDXZvHAYwYoHxxCLq0FGSugHxLBCI5Q30gQTgPpQKsR4DU21CEK3lB9hcHIGGVCDWh3VBVLsVRX33jiCe3XjEVuQ8LyktETzySDB1y9FJrjtEuB9wWvHpbyMs6J2eW9ofXuDwji/c+W6GqorxXLtqjfPAxQvUHj/s0vfO/CJ2mPb0l23zO1khDkl5mFt2VEHh1ox4mzpxIcKgZnCIPeR+kQ76b/5kxhMb7pWLpgIm8T5ZfpIAOXM+MuXSNjfyHdQtIFfnZq4ZaSCdVyoYKwwLuDAXZS0M0tcaXhfqWaZpXk9fQIKdOaN4KA00g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bx1b88FgzEYBw6aT74AviGbmbYJoe/+E+UO+Nczks7E=;
 b=jGKDa6fivlf1QIbT/zZSD5DScw+nRXv8bDy6l5HKnlASJWw4Frv9afoNYPskLh5tS+59okPdMYJqboYKlLEF+hOHWX6Z8Prh5mPPrze6YblZl0VIJsfi2amgpPyfoUTiMmaCUFDwmUrJj5nknVusDysiSNpY4cRM2dP9KBDxR3W0xKC/Hg2u79gqY5qqDtKD7C8S6jSnmgVWedQ6RzY5wZ1EmZSX1UTs/RQi6MrpVYx7mbuf9crKkRcnmy2rBN/ZyW+H6YGBZBuk2KMZxocfYV8RoL9zREf3Hp41u6tGQv1UGOyycbDZrcREwjL8UyXm/9ByEaGosu8wk9NlFHCd4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bx1b88FgzEYBw6aT74AviGbmbYJoe/+E+UO+Nczks7E=;
 b=vJwVxV94iPtUegzuhcxChmc4P5MnZwbUc5tsQ/KIKjzlr65TJrvSpTdAjEh+jcAPkAKNvD8Bz2++XV3UrMiibkjDCyF7d/QSO+L59u3o40Op206j+bk8Om9uRetKy4S3HOyqxqB0hGTcz3PpBe52xBUBqeTLnGYMG6Vgomd2WMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.19; Tue, 23 Jul 2024 16:39:00 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 16:39:00 +0000
Message-ID: <e7a6ce53-c473-44d0-9177-b7dafa5c6aa5@amd.com>
Date: Tue, 23 Jul 2024 22:08:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Add support to change domain to blocked domain via
 sysfs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com
References: <20240722115553.6005-1-vasant.hegde@amd.com>
 <20240723130507.GK14050@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240723130507.GK14050@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: aed2337d-640a-4dd3-26eb-08dcab35f42d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnZRNzEya29kQ1RtYWF2NkN6SElvVjcrK2FEb1kvTDVTamFCUFlkY0dpZHBP?=
 =?utf-8?B?SFJVNU96WlM3VVEyZlJQWWltcjdZYlUvL1N1U0xiSzF3Z1NnU0VSSU01UnIv?=
 =?utf-8?B?WldCK0VuVC94eU45cFo3aHkvRWZaSUN6M3V5Sms4SjNTMXl0SUJOOUFPdkdC?=
 =?utf-8?B?RlF3YUFBNGVEMEc0eGIwWjBtU1F2cVBQZnRmZHYvVTNnU1pkNWkrV1R4djFZ?=
 =?utf-8?B?bDd6MEYxelRUYjVaM09rZk9WRk0xSDlJNDFRMFZLVGU5NFY4Y0J1UVlMUlNm?=
 =?utf-8?B?U3BaOWg4YmYzVVA0US9hMXZXcGF0cXB2R213dkZ6c3NjLzBIc2lXZDJCU3FZ?=
 =?utf-8?B?OFdQQnpEbkJDWTBPdzBjQzRyTEQ4NDdndVdLMWxqc0IyYzZvZmRQVmdtZGdP?=
 =?utf-8?B?KzhDVkhMcUkzTDFVdzFBdlpFWnBra25WSGRzTGJ5SmlmeGRCSDdGMDU4aHQy?=
 =?utf-8?B?NnU5N2lpZDArcFpvQUFDM0xGekRmUE40UlhrRXFNSmRJOVE5V0xrdEx0aFlU?=
 =?utf-8?B?UG9JUHo5TlhJYUxsdVBqcHZIZnRMM1JVZ2Z2MkVKQnhpNTdTenZDU3VPTlEx?=
 =?utf-8?B?Q0NOeGVraTVBaklkaDFJcTQveGxCSkozcXV4NCtSNDIrWGxqbjA4d0hmazFk?=
 =?utf-8?B?MjE0aGwvOGNBRXF5UG5BZ29iVkFvckwzRkJFNEpnaEVjNWFIdFAvUFNZSjlR?=
 =?utf-8?B?cjhvZHV1TEV2WDhLaFFvOHZmRWV3S0RjdEFRRFdNbktkKzdRNThrWmxBTW9D?=
 =?utf-8?B?bERJU1BLcGNWNGZ3TTBROTRSVENyeHNsNTV6Mk9GcGRjQXFIRFcvSnRjaUtI?=
 =?utf-8?B?R1dqSmhzbEgxR0RneDNiZnZJNVZjWWc2Nm0xeW9zRjU0MEx1ejdodnV2Q0FP?=
 =?utf-8?B?VEh1V0lWNFpJNm9QRGRoMXBOelZVWnNNZVdDNndROEVZK2EwNGpRb3pmQWgv?=
 =?utf-8?B?L2dRM1NGK3V0T0FzY0haTzdtcytmZDE3UEo5MFVkbHpoVmVKMVZEU21CZW1O?=
 =?utf-8?B?UmJ1SjhPRXZ3Wm96YTV6bE52K1RwY0RoajhOK0l5SGdyVTE3S3dpcU9weU5i?=
 =?utf-8?B?WU9XcjI0TUl2OVRVeTJ4Z05jWFJzMEZLaEtZb1M5THVBRXI2bVI4MENzUXUy?=
 =?utf-8?B?U1VQMHR2amtTdk5PRVhDMVJheVdUVkJoTC9rME1xV3F3d0N4WHg5Y05LRzVY?=
 =?utf-8?B?cHVERWNOOWppUXR6N3NKSGxNNjVsbnRldmt2WktzbFJFaVRZOXlEbjdaUVJn?=
 =?utf-8?B?VWh4ckVnVE1JOXdHVzhac0cxQTBLQmZFaEpaVkVOb24wdTZ3N2U0YUZBYmdj?=
 =?utf-8?B?dTBXMmw4bVlseXV1cGhtdk00d00wc0c3QlREckdVR3MvODdERWUwU0ZPL1Fm?=
 =?utf-8?B?U0JXOHgvdHQ2RXpEUTE5ZWpiaXBOMnhOR1QzRW5JSnltcy9Tb1EyVkdHVkVV?=
 =?utf-8?B?M1BiQzg5UnFqeGFTUEt2bjU4YUpXY3I3YVQ3bjVTdXdta2ZqVUd1MkMrTytj?=
 =?utf-8?B?b1FGN05sMGxkZUFsMTVqWUx1QVMyOGpad2lrWTdpY1pXWk1Pc3doSCtwTW9i?=
 =?utf-8?B?U3V5UkZicTdmTzhISzVHa1RkSUNwdnJqYlRRTUFmdURtZ2ViVnh2UEl5NmND?=
 =?utf-8?B?cmREWmdQTG8wMk5WTjdsYXRpdm1NL2UwWWNjNUNrczZUTzV6WUo0eU1Lb3JO?=
 =?utf-8?B?ejJ2ZzF0dUUzWlYvTTVyeVg1cHJTRGtxZk4vYitoR3FOdUZyZitGcDk2ZUFv?=
 =?utf-8?B?aWFDcEVUemwzSjVWNkVqMEh5TFUvNDVQNGZjVE5hWHRidUZQT0V5YVBPTS9W?=
 =?utf-8?B?Uk5EUU9WblpVZHd0WStPQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGJya05qcU5DSHRkU3lyVjVOZkk2T3VoVTh0Nlk1MTBaMWFHOXVGcExFUnpZ?=
 =?utf-8?B?RGNyNGt0UzluUkRlMGN6STlqU01FcDRRRyszVDQxOUUwRFdFSzkvQzBvV1Bl?=
 =?utf-8?B?SjJxRGliRUNKU2FPQVNBc2N4NjdLRDFkYWQxZ2paempSREQwbVM5WHZpUWFu?=
 =?utf-8?B?ZEZYSVE1ZjlQM3JhbGhxVU9KZzRpM2MxNWc5UWhMdzM5cXNIWlFhZll3QTVJ?=
 =?utf-8?B?RkhMaWZnU1lLL0IzdUtUcTdyMUlNcDhvRkpXZkEza21TdzRWRmFFdE9OTTVI?=
 =?utf-8?B?Tm9CMmRieGxYcnZmUWJ4d3hiSXpjLzFDUlpIMlQrbWFZdXdIZjVIT00yd253?=
 =?utf-8?B?bDNzU1NUamhnT3FyNDdVQkJXRUdMTmdhekZIak1WQml5VnFaMU9QeWxiczNs?=
 =?utf-8?B?eldwSXNXUnFzaGg1a3pjODNvalFpUUFHaUYzc1crQlhJNm8rNWlpd0JMbmRu?=
 =?utf-8?B?T0U1cFRjeUhNZ290WitnQW9MTjlQR0Z3OUFQeTFZZmFURTU1bjRINEh2aTRL?=
 =?utf-8?B?S3JBdGxBQ2V5TWlCbUNNWERrWjhzVHFwSFdmNmpXdjNjS3N2RWJsamd0M1RZ?=
 =?utf-8?B?bnhmTnlOcWxHUjJRbnR5SnlYdm5nMCtLOFlVQXgxelNOS2dHS2NHWmRXWndJ?=
 =?utf-8?B?SGVweGZTS3c4VVh2MTJlUEsxNnQ2am1OTm13UVY1QVVCa0Qvcnl0ZktCWDZv?=
 =?utf-8?B?YVVsTzllRHlLZHFSZVlVa254NTJkWk1Dem1oUDY5c2hEeFNmM3g5L210K3hy?=
 =?utf-8?B?UlVRclViR2VCY0dzdDhQdTliUWxpVzZBenI5MVF4MWFxTUdhaThoZnk4czRj?=
 =?utf-8?B?Q1I1VjlHQkV1eEdib3F5Vis5dzVFVmM0OTJkQjBjcStrMzRwc1ZGUElaSkpj?=
 =?utf-8?B?dm9SbG9SWlNFeldCZmpoekVjZVNPYkF4bmYvWVMrd1U4Y2trSUlBOFp0elJM?=
 =?utf-8?B?OGxzcDhkSWFWQ1FlTDFiUGFEOUZ1bUdzY1FxbmI3WEsxQ0VaYnBsUlJmOGVk?=
 =?utf-8?B?NWlDV1FDOUMxbzZxeU5zcXdJYTYvSzlXRU8rckpPY0lXZ3g2anRReFpNbmRh?=
 =?utf-8?B?UDFIUHBURlU5THRnTklyYkYwTVNhZjlqM2ljN1lncStvYzRwTDJRUXdseGc1?=
 =?utf-8?B?OEY4KzUzb29aclVNYjFMMW1tdm5ZRk13aitBeDFwUEs0ajhNdFdnTGNWMmJK?=
 =?utf-8?B?YkdWVFdIUmdrMkZad0tDUVpaaDhXbnMxeGc4eS9qbVNYQW42ZkJvcWpLNFox?=
 =?utf-8?B?ZDNqWFVVUDZhZzZVUXhCUmh1YVdwamY5YnZZdmJsdTc3ODRSTUlQZEZoS25B?=
 =?utf-8?B?cUdlRTNWTHplb2YwS2VhTzc2T3ZNd2FTMXdiOFRLT3o2QmU2SFBRUW0yeCtk?=
 =?utf-8?B?cDNXZGJweHpLRlNkSk9XWmJoZXI3ZXB0WGVlcWYwVWNDNmMwUVYyV0t1eDBw?=
 =?utf-8?B?Sk9Xb3FQeVZob0JEaEhEMm5OZnc4eUhtckFFYUQ2MzhWZ2o4aXlvbVZkOURw?=
 =?utf-8?B?YWNHdlhvS2xIbk1mUXhGRGhYVzg3VGhwNENhbnBCa1poVytIcy9pOEp0aFdt?=
 =?utf-8?B?WXRtOEFCeFlsVFNuZXVPbHA4WW5JS1NXVXNOeEsrK1phalVtaWh0clV1aGVa?=
 =?utf-8?B?STAwU05YTFhhSDEyb2NGSHZwcnhhMzFVeXR2cGF2djd3T0lLVkVmOTA3N0Vz?=
 =?utf-8?B?M0ZoTFFtUlBhTkRmeC9lNUc3UGRMdE1xNXprbFFVMFE2RnN1bVMwRHRRUGQ0?=
 =?utf-8?B?UXpRUlhwOGt1ajNzZHMwYzNkak1tUlJFSzRXOEtqVVhMRWk3NWhNS1ZpaEhQ?=
 =?utf-8?B?b3BTNExJMXhRNGVUZ0VDUUwvMVY1R0tjZnlqbmNmY2JHQndORG9nVU9udnVY?=
 =?utf-8?B?UnhiY2paT2x1bGZLY0w2ZEV0NHNOVzlTSVQ0OUQrVmtwdXR0K1lsMkptSklj?=
 =?utf-8?B?MGhFVnNEbklQUlg3aXNYdkxabzlEeXdGMUJSNTJ1Z2REd1VCYktIczc4VWZN?=
 =?utf-8?B?SXlZRVZLditnMlBQbE1aR0tZdkM1MFZ4QkIxM0FJMTJldVVmQ1IrTDdrRHBr?=
 =?utf-8?B?emVhL2s5YVQ2MFg5MG5VOEFnZXJiRmNhM2JkZjBvYVRObnhxb3htQ2FlUkJR?=
 =?utf-8?Q?zzPccHcrw4SLgBNIlmjmurYaG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed2337d-640a-4dd3-26eb-08dcab35f42d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 16:39:00.1536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPCRp1ZMu48t8jiIv01ZJr3yC6pLxVqphn1mns7iKF7yshIc9+5VyBrmur+anCGJqRO95Dzie+ZImuICsAZ/eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120

Hi Jason,


On 7/23/2024 6:35 PM, Jason Gunthorpe wrote:
> On Mon, Jul 22, 2024 at 11:55:53AM +0000, Vasant Hegde wrote:
>> Add support to change default domain to 'blocked' domain. This is useful
>> for debugging.
> 
> But how does it work? 

1. unload the module
2. echo "blocked" > /sys/kernel/iommu_group/<groupid>/type

> If you set the default domain (aka the domain
> used by the DMA API) to blocked, then surely no drivers should be
> bindable too? 

That's correct.

> Did that happen inadvertanly for some other reason?
> 
> Maybe this is just a neat hack for testing purposes?

Correct. I wanted to test blocked domain implementation. I found this is the
neat way of doing it. I used it for testing and then thought its better to put
it in upstream. Hence posted it.

-Vasant
