Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E621487EA
	for <iommu@lists.linux.dev>; Sat, 20 Jul 2024 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721503288; cv=fail; b=uxtL7rnx6p3UeJ42+xpkwGo5C75IUPHUFlBlSYxE+pQauW1xl4BeyViENRKyNmBcyHEPjY+i9cqSXY+fFxI5Ab2A9qTq0MwdSnCujYVL9cMDBsPmHFN6X6hSrAKL3tXn3Ex12chHzfrJK0U2FQcd5TimKZ21hd3+1J2ZiChbeGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721503288; c=relaxed/simple;
	bh=aXrRGwKh5V6eRSVJn63CjPYbSSsm6ZX/u1S4/7LZAek=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EBsbbQhDugPwOaoamOOpS43Q6DajKieRcDwmK/dtPzlR/lmYv8ElWWxU1UIqi1a8g0vgOnRREgy4B9fLeZETP1HIWGFyDPbyFC083ZirrbLbKaLqQq/aKAo8whM0h60NmJC98CJdzJyPs6wwXbl8ETYBdwMZSpnCE9L++aiPBjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Dou7YjPO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qaIF2UIO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dou7YjPO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qaIF2UIO"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KIq5lj016631;
	Sat, 20 Jul 2024 19:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=6sa+sHYej+l7Lii8hqbBukBnBfLIzSXDxeG6yfZobuI=; b=
	Dou7YjPOSW1555rRlvsvbRq77VbvuctfxlFKUTvwJ77SavtQ0+7Qb2/CfNeD5euP
	SvbMHqgJWHYPGr+3/2JDnL3AQjmMIbFuU9vj46GzaPhHnqxsC44LaDihvsO4rBQr
	z3TbaOBOEqCko+uT5Fpvc4PJHX5IZw9USv4DUtmJrfzPIfczydYtWtoyaquH46Mf
	TcvFSdWaUArIemhpFj2wJ3jDniHvZmuMuwoasakZJCSHlIVsS4pXBbXwYQ8bDUNZ
	+n+jP/ti2iiDduuPgQaIcomm4bID8nzItUv4uo86toKkqe7UxvzYIIN2iEZXs99p
	rAE5pfDS97lSHZZBmZPc3g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gjv8g0sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jul 2024 19:21:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46KHriZq009789;
	Sat, 20 Jul 2024 19:21:22 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40g3p6q02e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jul 2024 19:21:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WAcNZYU51Q8PsYguSpfMbUc4MaBRua4kN04cR7L7rtc1ZJhRumA/eHc/T61aMS/CuWBYlkzUiZ4PrVKvbaeUlq2xBQRrnRXkoSOClDAkk/CNdDWrTbsvfpfq5ouXMX9jJchY6Nf/NP6BmtO8RWBKGEL4+Tyy9oveY7pv4k8uddQRJo6PjcOL0Hs3b0fymmeBUBbapVJKo8y0aCivPWOUWsTDpzIXr16UjZIss2BbTezKMapiimpIlco0xfluCJd8NyR7OpzdOGzg4hIXeWXFqQwdxXztPhd6+s6HsQwHeEx2pxsTVUeouR4JirLt2Xf5zGDUj4HuzItHkJ8a6q4v3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sa+sHYej+l7Lii8hqbBukBnBfLIzSXDxeG6yfZobuI=;
 b=DTP24qQOtQG3JCdh6CIczRaHTPoKcESLuMFusTcVSaDs9ZIQkGcnGkk9QHZWpc2dkFg96OVaUOraNtnw6IJx3RgXKoqKislaV3PIaKNyuVap7GI2rdz1IqKVwlj6TppY90SCPsyee9qlCgZNHubhsxiCKJQyZ/a+95IjoOgCtu5Clcem9Zl7OEFIZjJfY/5KM49WrH26RAnugu9F63sziNgCK5QzQFTozcIZ4QgHTdxrvdRfkHXYFCNPhEiByF5lepbKslaSMHzbBldZbUBDf/jFS1Pw8CeCOVYGDk24wA8i031Ov76PtLwDZ3tvR1d8XnAlMAhMBG921iikdtyr1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sa+sHYej+l7Lii8hqbBukBnBfLIzSXDxeG6yfZobuI=;
 b=qaIF2UIO1KveB6GOgw1DvDitIFgGJvY5HyzRuYIWY/u+uTgT40sTtZh2kuQnp3IHbR8iHi9aELZzqFkxwYsU9WkAeMX3COGPG3AQmgVQn4sBCdoom8IGTOjV5Dt4Tc7mjrvpDK3wZ+8Lx/iZWuwc+ER3W3whkJ87g+T7HbGQTM8=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MN6PR10MB7423.namprd10.prod.outlook.com (2603:10b6:208:46c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Sat, 20 Jul
 2024 19:21:20 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.7784.016; Sat, 20 Jul 2024
 19:21:20 +0000
Message-ID: <88c5cfd5-ae13-43ee-a61d-2b4369c0279a@oracle.com>
Date: Sat, 20 Jul 2024 15:21:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 0/4] iommufd live update
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
References: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0068.namprd02.prod.outlook.com
 (2603:10b6:a03:54::45) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MN6PR10MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ef21af-12e1-42fe-3c92-08dca8f122e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXJoYlB1U0haRlZNazNvRXpxdUlmSTlCYkZtWFRQaEZMaGhZVktlZHR3ei9v?=
 =?utf-8?B?MUlROGZxZzlkVXRDRlpLVWFXU3E5ZVF5OWtUWnVSdGxmMTE3MXNweWFXcEN1?=
 =?utf-8?B?OUc2WUV1QWFkM25XTVJGaStvL0JPak8zZ3dTVk9JUlcrakdLTFl2dlNBWi9B?=
 =?utf-8?B?clloMXJPeG1OQ2t0S0prZ3dFYXo4Rm5KbEkxZlZTTy80ZFYrT254ckpLYXYy?=
 =?utf-8?B?dk1wMDlCa0ZVSmYrb0ZBeXdlbGI2MGMzUHVYTzhBdWJoSnNiWm42TGF1RTNR?=
 =?utf-8?B?M2dDUlVBVDZSY3c3RzN3Y24rdXVXMlFnTUEzTHJOQ0JlWDhscWxqL3NFLzRJ?=
 =?utf-8?B?aEUxVGQrdkVVRnVYYXRCbW9tR2hTZC92aEZiT1Ria3JrUllqaUdwdkNPL2Rq?=
 =?utf-8?B?ZUdUVjVzV3ZuZFZIdFFhNXFJM3daaU5YR2xzKzc2Z1dLOHp0STQyRGZwbndi?=
 =?utf-8?B?Tmo1MHYzQ0JTdVJEcmlYaHl5dzRMRC9qbXN3NXRuYVVjNDE1T0dyVS9hSi9q?=
 =?utf-8?B?TUJQU0VjZm1JVi9EdjgwSXJrRzBFS2RwUG5QQUlFaFBteDQwZFVmbUVaVHVz?=
 =?utf-8?B?bU5kMEZIK3p5UHp5ZWFYS0hGMDRkRGJFTFVnT1dHL1p6RDFUeTlSdnZiSElH?=
 =?utf-8?B?T1lpZkRCd3l3STNYdTJncmx0dElLblUzZnh1SDByWk9lTkxLNTlPTWdjL09S?=
 =?utf-8?B?UnlNZGVJSTJneW8vOTJxU0YvbUdieW1Hc3BCejg0blVLV29BbGhHN3NuVzRU?=
 =?utf-8?B?Mm1sTmdsYmJnaGhkUmNDR2UvcW1oV2trZjErY004WWtKZjRsUnJONUtrNkJN?=
 =?utf-8?B?cVUxM0FVRFBUWVBneUtEREd2aHB3L1doOFEwOFZjNlAyUWM2UTB5Y3ZSVkhM?=
 =?utf-8?B?MlkreE9jSHNZSkJQWWJhWGlmUG16STZCY3hoei9BWk1SQWhraDEyNG1TYWhO?=
 =?utf-8?B?TTRtWUpMbWJZM09IdXBTVllFeW1wbFN0Y1dCa1BQaHpRTmpsV0REYVBaUjdV?=
 =?utf-8?B?ZDdCZlF1am1LQ0hwd1Y5UFIrVjgzZXllczdzRmFrcERNR0FBK2hnQXRuekRk?=
 =?utf-8?B?WmJBNmplZk43cTdHcHh6QzdqSG1tOFFGMGl2VzNTdzR3aExrdG92OTNlWm8z?=
 =?utf-8?B?VUx5TzNFbXQrV25oSGNFY2ZOUUtaRStyN1NHY3FUVlFOcFJmSzE4dC81c2FZ?=
 =?utf-8?B?bVNCdUs5aG1pSmxOTnljYmRyUXVwNm82V0ZEaytCRUx5UFl1cDRYWUNqdlR2?=
 =?utf-8?B?SmR5LzJoMlFkOG10OVVhKzJ0N0lmcjVnWW1tU1VvNEVuZ3JDQ2k3YythUzNv?=
 =?utf-8?B?aEwyZnphb3RBTzV5ejhCVGpaY09id0RLUEhTRTNSQ0hWdjBWZnA3aDIzNjVl?=
 =?utf-8?B?RTFVYURsQnFiMW1aby9IVjVvcWtyd0R0TGE4MVhzZmdZN1ExeVQxTXVmVU9D?=
 =?utf-8?B?OGlHR1Rwc0x3NDY0OVhoOXNsaU9OZCtCaHJmVFpLNWZYMDRZNmpOOFU0YUxm?=
 =?utf-8?B?c3kwSENQc0lrRXZ5KzF3U05LZHEzTGcxeGFjVXZpMklia0RHL3FsUkhlUDJj?=
 =?utf-8?B?U25uL2grNkl4d01IeSs4aGpLMElCM3RHRnMrSm52UjZyRmZvVUxOUDZnMG9i?=
 =?utf-8?B?ejRFSzF6OW50c2p6VnNHbCtHK1NoT25mUWFacGpBUWI4L0FtSDRIU3hTUG05?=
 =?utf-8?B?UU5vUkVFN3J0alN1R3NHSGl1UkUvamtkczZTa1JnRE9zdVIyUW9oN0xYRXZl?=
 =?utf-8?Q?Nn+H0p6+aMlbt8OlAqW4UMqzLdaJICBSi9pnyJb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWJuc21oWUFuWUpCQWlqOGJXdEdEaVJTaGRtRTlhSjQ5b0NLM01PY2dHakxv?=
 =?utf-8?B?SHJjYVFWYkZhYktidW5LcW1xTERYQVEvQWVPT1BHTHRYaXZLNEVWamhDUkJR?=
 =?utf-8?B?ZVpOWVo5NUFkUUlDMEpyVU9ZdGJHVnFpRnhrYkV0cTVhYzBWeDRWWUJMM0Z0?=
 =?utf-8?B?bnJveGpYbW1kTDZGNDhOY1M2U3kyMzJwYkIvMGhCeSsxWGQybnNEM2xKRllS?=
 =?utf-8?B?ZmNnTHVJL3VUK1o3ampzaHZHRzFWZEVmYjJrZm55aWNyTkxsbHN1SjRuSG9p?=
 =?utf-8?B?MnN1ZHQ2ZmUwWjNKSmtFNVg2MThmSGsySFhtd21XRGVCbjVTTmNvM3BJT0Rw?=
 =?utf-8?B?TWNvSDZqcDhhS2srUUQ4WVRsODkwTkNKcFRucXlSTXFqRlUxUDRwRUQzSmtX?=
 =?utf-8?B?RVBWemg5eFNTYUlFRktoZHBaVEkrTGNoS1ZueEdqckd1YVhwZjQxV0V1eGxo?=
 =?utf-8?B?NXJZYjg3ZDJuVkNOMzJwMnNIaklSR2MvQVRpS09HU1Z1YStzckVuL2duVEpK?=
 =?utf-8?B?MkNiOHN2RHhGSnFld0pWaUwzeE9YOVVhQnc2RWl4K3VjK2Nuc25xZTJDZDhV?=
 =?utf-8?B?clp4ekFjMFR1cnAxZkc3TnRjdDhmMlZZNzhGMWlzT09DNCtYYkJuWlhhY1F1?=
 =?utf-8?B?aVBFNTNkbDAxaVhFSENpakdkdHJySjNOdVdQbnNTVkVjejVrK1crbUdZY0FB?=
 =?utf-8?B?Z1lWQjEveE0vMGFjRUtrK3NCYzlkQ1piRTljUGhNaFFqVFhRSy8vNnpWSHlU?=
 =?utf-8?B?bGxzMzNXZnNNWUcvOWp2bDBEaWViSTArNW5TY1pFc2NRampFSGoxbmVoWHow?=
 =?utf-8?B?N2lqN28vYWxRRXg2UldBbUlZUHR2a0dhZ0hrM0hQWGZHOUxpdlpBQVNNUDdl?=
 =?utf-8?B?UTVZVk1OQnlyQy9WSTdmaGNaWGdKTHk2TUdTVzA5UHVYNTVnQkJ5UGlRclcr?=
 =?utf-8?B?QkxDaDZ5SnRqa1k5SFZzOUhYSmFpeEpnenA3bDdHZ3JLdDBERVdDYVN0WWRw?=
 =?utf-8?B?U0t5SWx3dzR0cnFCeWtJczVXdUUrQkNjMFJYQlgwZC9hb1MvZFMzSmMzUC8x?=
 =?utf-8?B?RXI1d2t3TFdnT2pqOG94NzhEVlVicTljZU5tdEM1WEVqd1pDdGhnTDYyWmVM?=
 =?utf-8?B?enZlOHBNV2ZFK1lJZW1HUE4zMGxkYkI3VVA2RnB6dFRzUjNDSGhpNFBQd2ZL?=
 =?utf-8?B?TEJIWVlBd1Y3Mk9ZY0t2SFBXRE4vZ3l5akZKSUY1aXgxTmp1VjR1VEVQS3M5?=
 =?utf-8?B?VEUwQWNQc2Z4bHh3YzdrNGtZS2YxVFhQWVhrNDJBUWpuQjBtM085WnRiYldu?=
 =?utf-8?B?MStaTG5NUWU5b29pN1g1L1Y1aHNsNm03ZHdISTEydGI0c2czWHlaZndhR0Y2?=
 =?utf-8?B?S21HaU9Xd0hlcEloS1o0aVNobThkQXZQS0VXc1FnWVgxWi9xSXZiaHFZR3dF?=
 =?utf-8?B?c0w1cFhaRHRtdGdlbkZMQlJFeDNFWHFsUjdMSUgzTGRQWS9nNVQxZGhIaW4x?=
 =?utf-8?B?Zk9GdnZPTkZOcU5LMDhPSm85cTVGdVFXMGkyT09vL3czY0tsSmV2cEluNjg2?=
 =?utf-8?B?ZmdaTkxhNFZVYkZKcVBwZ2x0VjVhVDB1dUhZSmhMYU5OYWNNV2E2Zzd0VDhi?=
 =?utf-8?B?bFErUnRQYzZoOStkWGw2UENJbjdTZFFiL2lSR1FOT1c1MGt0d0owdlV4emFw?=
 =?utf-8?B?UUR6RmdZMXdIcy9vVFpiSFZhZ3NHQ2xtR3ViOGk3Sld1VFhCQnZ4SEJtV3JT?=
 =?utf-8?B?M29sUUN6d2xRcXdXRlY0UEIvS1BtN3czd2ZObUthQk14ZXhvSEZRN0wydU1L?=
 =?utf-8?B?MkhaQk9oclpKb1g1ZlVza29udlQxcm8yL0pGa1NGcEMwdVVwTmVUVTZOc3pt?=
 =?utf-8?B?K1c5MXNtaW8ybmR4WEdOQjIzR0hFQnFzMjJlUWJzYVhYdzFMZ1RLODFISnVU?=
 =?utf-8?B?Q3pBUWNhWEZOY1V1aW1JUm5CejlaS0xiM2RJdGN3YVFDODVGTFhUdWg3OEdl?=
 =?utf-8?B?dXp0U05MZTFacFdDMk1WdHE0cTA0b1BnVWtWOGJwY2lYUkZON2d5SmU0ejdh?=
 =?utf-8?B?eG5MVkZDNThVYzFtcTY1Wi9MU1VzVVhWbHp4SHdMNU4rN2ZxRWhQZmErem1u?=
 =?utf-8?B?M0MySTl6aGdZUGRRMW5uZkpNQTVFR05USnNCVUFiN2U2alYyOWlTQWpLSEww?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7PvM+SsX17jpAhqHKM/PuWSErGbCVqIjfCqoLo4Sutmn/v7xsHtEbmVQsUtrMNDmZ4C/1Vh1nD26lgxxEyJWNtSbDpjWPcAZuQrG9CXM7v8AZAzTLNMEr6D73EsWTxGrzy/HUUPmuovg2W4l+IMIAFLKQJFOXWaParX1ecO3eMUi109bxzJVWAJLn3lhCnjyXr+AiXWt23YIIhCAfdO3EeDKGsWi8zD1x0bm1Xu7rtriwy60H/xe0VqXZQ/e9OYOKzLWGBoeoJYu6tX1CYkiq5raGhG5FY4Hl+VwZfBh/diGeMDKhk/6RFpzk66to+zBybXm5pGchxM0oPGZtPiSwW4E4dEXvW/IxdWz2CjF0ieuIzwA12+TD0+Fky5klNwMyiRT9MwezpoSSsjSKt5bD4lL4s3+c9cM57S/gGU7GBfWQXKx36f0p9vf1eEvXN1JYOaJOtPo3LiVZzLJ1LZFEQtZZgOcofu4ZkoIXWdny/yqab2UrTg/4/6KzYGJkKKOG/qwviK6Nyk0fo+p4ClJ2Ju5YFkdCe9AgwhHor2exaAM73mu6wTBXV2xYk8E2mxnG6XjDIVRqRt7KN+VyFcoudgAFHC1y4WiYa65fxD6BCQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ef21af-12e1-42fe-3c92-08dca8f122e6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2024 19:21:20.7061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JtDfJ+tOG8G0NMED715omvBivuDNXiAR6SgbfBnGtgxf7JcjbZgQpvRIif1CprbzauAEr8ks3biYU7PHulv8iuJj4WeEUXADv4rELIbczUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7423
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_16,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407200141
X-Proofpoint-GUID: tBYFd_PlfkmteFRRdky3efuGCzipAHT3
X-Proofpoint-ORIG-GUID: tBYFd_PlfkmteFRRdky3efuGCzipAHT3

On 7/20/2024 2:56 PM, Steve Sistare wrote:
> Live update is a technique wherein an application saves its state, launches
> an updated version of itself, and restores its state.  Clients of the
> application experience a brief suspension of service, on the order of
> 100's of milliseconds, but are otherwise unaffected.
> 
> Define the IOMMU_IOAS_CHANGE_PROCESS ioctl to allow management and use
> of an iommufd device to be transferred from one process to another.  The
> application is responsible for transferring the device descriptor to the new
> process, eg either by preservation across fork and exec or via SCM_RIGHTS.
> 
> All memory objects that were mapped for iommufd DMA in the old process
> must also be mapped in the new process, but they may have different virtual
> addresses in the new.  The application passes an array of new addresses to
> IOMMU_IOAS_CHANGE_PROCESS, and it atomically updates everything to the current
> process, grabbing the new mm, transferring pinned page counts, and recording
> new virtual addresses.
> 
> If the application directly exec's the new version of itself, it must take
> special care if the mappings may be accessed by kernel threads, such as by
> vfio mdevs.  The original process must fork an identical caretaker
> process which calls VFIO_IOAS_CHANGE_PROCESS to take temporary ownership
> of the mappings without changing VA's.  The original process then exec's
> its successor, which calls VFIO_IOAS_CHANGE_PROCESS with new VA's to take
> ownership from the caretaker.
> 
> Thanks to Jason Gunthorpe for code and ideas in this series.
> 
> This is implemented in QEMU by the patch series "Live update: iommufd"
>    https://lore.kernel.org/qemu-devel   (to be posted shortly)

https://lore.kernel.org/qemu-devel/1721502937-87102-1-git-send-email-steven.sistare@oracle.com

- steve

> Steve Sistare (4):
>    iommufd: Export do_update_pinned
>    iommufd: Lock all objects
>    iommufd: Add IOMMU_IOAS_CHANGE_PROCESS
>    iommufd: update VA
> 
>   drivers/iommu/iommufd/io_pagetable.h    |   6 +
>   drivers/iommu/iommufd/ioas.c            | 291 ++++++++++++++++++++++++++++++++
>   drivers/iommu/iommufd/iommufd_private.h |   2 +
>   drivers/iommu/iommufd/main.c            |   3 +
>   drivers/iommu/iommufd/pages.c           |  10 +-
>   include/uapi/linux/iommufd.h            |  56 ++++++
>   6 files changed, 363 insertions(+), 5 deletions(-)
> 
