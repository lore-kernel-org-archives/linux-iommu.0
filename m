Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794576221;
	b=N6ULJ1sdyacVPbDuKkcIOicSJru4h4Bq/GDx5nsuTm8t+IpotpUAiWmfAcpo5tl9Tzu0
	 011aNhgZ4srALG664qT+vRZHjlSpT2M4PKtn4qwl+UmSpIXJ8Ixn1HdcCG3HxqvMHS3F0
	 H3vWe4b2f309kzD6i8AFMO5bPjco03euECARc+T53kRVhBjvxdKa8tXGIMHQwxB5+afyS
	 Q9+mhcVyuLvwP9Mv/1hJAtk5XAkM+e3DEYVlkOTEdkIZ8jZASBOVgzS4jUMlcV9YRFkfW
	 zOmgpZ3Xu2Y5xPxj/kVMde6kfiNx8GLOny2FKvxCBXlvxuWpgLyqSUlXZqVbxcsMFLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576221;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
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
	bh=aIvGLlx0zAMKQChbVMHjd0yo4VMoJDHJ55zue9NT2MA=;
	b=1b/vENFS4EQUKYQoqsj+x+ejvLPd/wiOMtKM1MBgXAVRkHiqGAwiR+LjYlzTQtk27GH5
	 QysWoT/1MPYIJJ6RK36Kht3WhONOyoEHLQvstzMYQdpel38JYPQ/5RdFmrU06RyCg2F+0
	 Z68vXGpTcbq2NWhNZNn3L4hjA6Wk1Ce22sNG7v4PBFS/A/gCgKEINo/NUIEcbnuFDuUPY
	 AkRKkZwq3XiW4rCL8dU9MFPKwfPdirAuvHAHE8lWyGMjXEfPnETtQIxjl52IVV7udBhIS
	 x9roSbAJ0osn2F/6sozdyp2se3gaF/UNswN7t10MKo+198RJ4gVFADypPm6MtQjF3MQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Gla9LwBy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.49
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010049.outbound.protection.outlook.com [52.101.84.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFC7606A8A8
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 13:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CFC7606A8A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Gla9LwBy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+Nx2fWLFGuwkET02PgHqY3qUXyckBmsf64jWy0HMdARxwk9LYez7af7CyMPqeusyo0PIeAHiuTcd/5SbyPL0jRZqodic71JuvKZRB9epCov7+Y4LHJjOGXnfIm91wtLJOzXqmV12O6MWmqH4OIKlHvPdDXelxO0whgUGBkjF4YotaYwJgr3rm6WT4DHmX1sB9a9EvPmV68ZZdLyex5R9yfXW9Q35WFzZ5saJBKSJOoV0b5I8n5Ffba2eJ/EvcjF4+eO+vgrC1ORQxgKNbHys/+Nt9n1ovHBUJUkKjR28JZGjArJQy6KzorWVLSlCGiahQqoAk4qc04eSeS+NPwYFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIvGLlx0zAMKQChbVMHjd0yo4VMoJDHJ55zue9NT2MA=;
 b=isNOk+9Df3z1u1UJNcnAM4Ma0qPPlyv4YioPiWmQB/Tb+kk0UFgAmmBRmhauHxBUOiled3O74sDj0P83NJFi7Fir72lggVq8DfJrQIKT2UcZYptc7ZiiH/glnUBa5XDNCxZiCeRE5Ae0gDCjii3Kur0iZiPCn3K7ntr703Swvo67ZPB3MDoJH2O390GIuIs2Jdv+6CzQflInlW8FvQWlHXN7dn7YLAFbXQV30q54qWiApW+YZOVcGpxbD/PMwEJEMEcrJtmB23Bra6BcLPozus4+Q44xZnVCSjCe6twyR9egcG+yXJ64OIBNfi9Irc/hQzHBpG5PcoFVoQm8ux0v1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIvGLlx0zAMKQChbVMHjd0yo4VMoJDHJ55zue9NT2MA=;
 b=Gla9LwBy/1aO09nJqVkDJ8Fku8Lwwuou4A75TSKYRJqGwrtJsQM/pNYfCJmgPQmKlMSnHMAhYXPv18K7SNU9bwp70WHiH/sqaZP5Zq9I7SPHRwfRNfUGX3VbsD/Bz/9Xy7pIRjpyJyWaDB48CRiqL0ufoeHF+bu7TaMWXU7J0ooz3yxfN7ErXTKGQhzu1TSH1PLJGapP4vu4hJ901MlveF9of3LWGCROzGTVUW4houWNeEEnlxhimYm3kymQWN0CREa676l+YM/hIN1WN450iS6Dkj2quuANVnR9NCfuzMbV9fGsDT7y0izIjhjgPwaXZoDN6LwX402aqtpg0QCUNQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by BR2PR04MB007356.eurprd04.prod.outlook.com (2603:10a6:2c8:6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:23:38 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 13:23:38 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 13 Nov 2026 21:27:21 +0800
Subject: [PATCH RFC v8 9/9] iommu/arm-smmu-v3: Quiesce PASID before mm
 release unlinks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-b4-smmu-shared-sid-ver8-v8-9-587307a77f3a@nxp.com>
References: <20261113-b4-smmu-shared-sid-ver8-v8-0-587307a77f3a@nxp.com>
In-Reply-To: <20261113-b4-smmu-shared-sid-ver8-v8-0-587307a77f3a@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Thierry Reding <thierry.reding@kernel.org>, 
 Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: SI3PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::8) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|BR2PR04MB007356:EE_
X-MS-Office365-Filtering-Correlation-Id: dfe34842-ae7e-4423-7426-08df4189538b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|23010399003|1800799024|18002099003|22082099003|921020|11063799006|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261022105027099003|261021121427099003|56012099006|261021123027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	FdSCmZ6u9VdydX2pF9L7m+ucX+qzTKzuThuSV6QfphbUnG4zJ2LZWmQRoxMEjaaB3HnZWXU8+spqcaukrgpG4MiKrhQ7uaQiuveXEwIWIdqjrjhxbWufpum6d2dLJHzWCKaAkkwWIN8HEiIwP5d2AQso4insl7sTcuARqoo6AFXxD2c9wmyyt8CA9qfeBFu9LQFJjSIg2YIE4h2ANyXw98W+/KGN5IOoRjAcGUmjPKGt+tFASea55SB0HVr2BZC4+RLF3WWOSAT6JKgcN5PrS7KnAdVM0fPCqqZXeDwl+dA53YG6D6s3hpnqV29U1HBcFtxTR/nnmqpuYolhbgMw0vfE8Un7tG6e4J/eF+0h7LEuqD9PV7/xyVqUhmltrdmFNFESdi6ghQ7y1ETohbMpcYUCZx1E7+icnbOAlov4C/NNpsVdPi7U96H2c1vkqnjCmduSfqk01fc814Qvdzz+RdVBEYKMzltRrKur+zmmKuntgR541wsFqDeVBkVx1HKQWhoGknDFQ3Hm2/KJv8f4/6lpNI3p/HxuUfdns1rlAL+hGSzQRL4YUOkOnsxnfFVxI1/SMhk8Cg26jK6nlboZqrS/ujjTqVTFlkqtHfhLQ2ntv1UF3b3Yq+guStuBfl08FwGr5sKpdAzMRG1pZa0SqPGiPfB/F24NJ4xv79jNlNcOwuetTj6oo24x7DiE0VGRvpQ7wTXay6jfK3y61GRU3w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(921020)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261021121427099003)(56012099006)(261021123027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2pkQWkrUHI5T0p1OHlvVVdBSXFlZmV4RUFqcE9WR0EvNmluS3IvSU4wZFJN?=
 =?utf-8?B?ZERQTlVkMjhEU3granhxYjYycEJUS2Zvck5oaS9ySE9FeVRHODR0SjRxVCtG?=
 =?utf-8?B?Smk3VGVUT2VPcm1qYlBqR3FBaHR2Q0NvSjhIdlJHQVdMTDhMSlhBZE1PaWJM?=
 =?utf-8?B?VFVoZU5yd0U5eGV1MFFkWEZhWDNSNytWNVA2UU5NaXR1SVZBRlVMUXc2OTk2?=
 =?utf-8?B?YnJmdnRjRHREbWRFbkpDR3o0dXZQUURpdEF0VTRpREgvdVZpbzhWTzZ1UGla?=
 =?utf-8?B?bFVNbkYxUytaZWpxQ0ZGRStDbHFpNE81VkZ6elRwMjRXR0FSZlNmS1pLMjRB?=
 =?utf-8?B?bEhub3RQeUtHOE16bEE0c0paV283QTZoWlltbEJQY3ZHRGFYRHhuQnNoN3lj?=
 =?utf-8?B?eGFpcVIrZHVsWmxDMFg0NitES3VKd2U4STRoUzZHOUUvNGpJTmxnTUUrd2Nu?=
 =?utf-8?B?Rms4c0RTY0hSU24yOWZBUVVWR0JkY0hwRnV1QWZLV3l0QzB3WEE3K2VPU1kz?=
 =?utf-8?B?Qm9CdlBPQjd2N3d2eitDMFJrMkFLcHR6VkE0ckV5YlJrK0JRam5SaGh5K054?=
 =?utf-8?B?ckdYaHZGYVBOQlMxMkt2UG5vdk5kd0cxTG5VRzY1UFAzSkovL2VxNUdYeWJu?=
 =?utf-8?B?bnloRDd4U05pd1RrZzlqN0gwRVh1czROTGo0aU9kcWkxaVpBMEtHWFZVSVVl?=
 =?utf-8?B?MXRtNDZMY0NnWWFoZ1J1YWZHT2JxT2Njb3dGVnVTbWpXT0NUblAwYTNGUS8y?=
 =?utf-8?B?VCs0Q3NmOEFhRkVwcDRlM2V2K09mQkh2Mng3Yk01Ujk1K3poWFh6c1NIOEhN?=
 =?utf-8?B?R1JDZ0d3czRpN1owZFhoSGNXcVRnc0dQbE9lRGxEU09CMnEvSTErN0JGUFc2?=
 =?utf-8?B?OVdVMkt0UWVsSDZjbHc2S3VtVUszODZ6NHZBWnpiTGdNbWdJcVQvQUpGdk1n?=
 =?utf-8?B?MUNHd05sVUhYS25tVldMcHl1WmJwTFlwV0k5WFRJc29BRU5LTXorOU9BSFFQ?=
 =?utf-8?B?Z09zSVFudTMrd3dSRVJGdVNvbFUzK3owSTlnZTQwVzYxdkNLZDkwbHR6ODhR?=
 =?utf-8?B?VzBuQjVvRGxCNmFHcWRITjNVR0FJSmg4NkkybXNjU1phUU94RHhJeU1ydk10?=
 =?utf-8?B?Z3o3TyswQjZpb0JEcWx0UjNGdlNPUDkyWVNSUHQrVlhyaFVLK3VlckRKSzEx?=
 =?utf-8?B?OVNRV3NmTFdpTDhnRkZHOEtFaGp2VW1pSHgyVkd6Ly9LVGV4d1p5U2wrbU9m?=
 =?utf-8?B?QlJ0a2FSdlIyaG41ckFwRDhUZ3BxWE9JUWYzWUEwRDJ0SjlTcHFjOEsraldI?=
 =?utf-8?B?N2xDcW0wSFJKRXdSTjZXbmxOOTA2U2UrVUdlbjJocTFZMmp1ck9sdml1aTJF?=
 =?utf-8?B?UEZKVTFESXFEbGFZdXZuY3BaUGEyTlJ6aTh0WFRFOHNJNElYTE8xOWQ4K1VO?=
 =?utf-8?B?MThQek04NzVmZ0p2VzRCMXJ3U2hZMmd6dzljK2lLUElPYStSM09IcDN3K3N0?=
 =?utf-8?B?NlU3UnplcHNUSGlHL3FPTmRMVFNyUVJ1UVBlZjcxYWFLdHNmT0lRL1lQWUdQ?=
 =?utf-8?B?djBnQjlWYmh4ZTZ5SU9PKzU3Z2ZZU1Ezb2pKejd0bDE5di9kQ2o1RGxjWUdp?=
 =?utf-8?B?VnBNbElRNFF0ZUV4aGc5MDYvN1VDbkpaNmpzRTdYWGxzRkIrRm9hdVlwM1Nz?=
 =?utf-8?B?dG1OU0NOTWRHbkNnaXRvZ3Y3dVpWME9vMWdKdkpwcnhNWWJrNWk1UzVBRHp6?=
 =?utf-8?B?K0FxZ0RicHc4bmpBWXlLNGo0OUhoMVVDd1ZRVjBjQWRhMEo4UDZicTlxb1dt?=
 =?utf-8?B?eVVnOFVUbzFlQi83eHlsNzlXTFpxa25YWkw3UUdSU0x5eVk2VFV5S1hKcXlv?=
 =?utf-8?B?Sm5TRzZLR1dWVnFxNHZIUnVqVFk4ZmZRQjIybHpDKzRKVDlMWjdlOUVFanpW?=
 =?utf-8?B?eTR4ZFRyY29ZdmVuQUg3STc4VGdDQllyK0lRZ0prWEprd1RwNUh6NDhKenVv?=
 =?utf-8?B?VWphT1ZldFU3eVFiaVZGQ3Z3bEhWR1dCY05sdElabmJZRUoyVzZ0TGxYakll?=
 =?utf-8?B?YlBYdHpqdkpMc25SYWIvVGNIT2IzVC8xL3ExSU1yQmZjNWdGUVdGbjlIbEsr?=
 =?utf-8?B?bmttelRja2NZS1FaY2tLc2VieWxsRkMvSnZJK2psaDlIUmFyOWRPbmNBZFdK?=
 =?utf-8?B?WkZicTFzN3RENnNhQmxZMVVzeUlYUms2bi9CdzhRRDltRm9PMy9xdzJhYXdL?=
 =?utf-8?B?T3hUeUJMaXJ0ZkpSUmEyUk15NXBMc29DcFlMRXIvZHk3b2ExVWpXVzJ3bmd4?=
 =?utf-8?B?WDB4aE1MMkVpd1dOeUxoY0Fmb3lVNjBKUWN4dkt1dEsxU3p6QXZoN282ODNJ?=
 =?utf-8?Q?7B0WhPBPga9lbQidksgJDkhJOdZOUwNUX0fo7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe34842-ae7e-4423-7426-08df4189538b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:23:37.9906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YuWFpNwOQ0s7HKZU7SwUh+wrTXpvxPisyKKZ0SP87Ik00jPPheQNsBbuCBCNMuaoci9AhKip36hJzRKcXxBxFN4xFHdJjPiVP9SEIry2CzCJ0A6dt+Gqr3UPmYVbGQ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR04MB007356

From: Peng Fan <peng.fan@nxp.com>

arm_smmu_blocking_set_dev_pasid() unlinked the PASID master_domain
before clearing the CD and invalidating the ATC. arm_smmu_mm_release()
only takes devices_lock, so it could miss the removed entry, return after
arm_smmu_domain_inv(), and let exit_mmap() free page tables while the
PASID CD was still valid and could be re-fetched.

Clear the CD and invalidate ATS before unlinking the master_domain, so
mm_release either sees the entry and writes a faulting CD itself, or
sees it removed only after the CD was invalidated.

mm_release must not change used_ssids while quiescing, otherwise a write
racing with clear_cd() can resurrect the PASID count. Add a no-account
CD write for mm_release, and re-clear the CD without accounting after
unlinking to drop a faulting CD written in the race window.

For the last-PASID downgrade, do not propagate attach_dev() failures:
the IOMMU core requires set_dev_pasid() not to fail in this path. The
private CD table is kept allocated for reuse.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c |  4 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 95 ++++++++++++++++---------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     |  7 +-
 3 files changed, 67 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index f65c60652c0d..23dbe6ff479d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -178,8 +178,8 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 			continue;
 		arm_smmu_make_sva_cd(&target, master, NULL,
 				     smmu_domain->cd.asid);
-		arm_smmu_write_cd_entry(master, master_domain->ssid, cdptr,
-					&target);
+		arm_smmu_write_cd_entry_no_account(master, master_domain->ssid,
+						   cdptr, &target);
 	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5a6bed0ca7f1..f22a3b6455a5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1675,6 +1675,26 @@ void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
 	arm_smmu_write_entry(&cd_writer.writer, cdptr->data, target->data);
 }
 
+/*
+ * Quiesce the CD without changing the PASID accounting. mmu_notifier release
+ * writes a valid, faulting CD while the detach path owns the used_ssids
+ * transition, so it must not resurrect the PASID count.
+ */
+void arm_smmu_write_cd_entry_no_account(struct arm_smmu_master *master, int ssid,
+					struct arm_smmu_cd *cdptr,
+					const struct arm_smmu_cd *target)
+{
+	struct arm_smmu_cd_writer cd_writer = {
+		.writer = {
+			.ops = &arm_smmu_cd_writer_ops,
+			.master = master,
+		},
+		.ssid = ssid,
+	};
+
+	arm_smmu_write_entry(&cd_writer.writer, cdptr->data, target->data);
+}
+
 void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
 			 struct arm_smmu_master *master,
 			 struct arm_smmu_domain *smmu_domain)
@@ -1734,6 +1754,23 @@ void arm_smmu_clear_cd(struct arm_smmu_master *master, ioasid_t ssid)
 	arm_smmu_write_cd_entry(master, ssid, cdptr, &target);
 }
 
+static void arm_smmu_clear_cd_no_account(struct arm_smmu_master *master,
+					 ioasid_t ssid)
+{
+	struct arm_smmu_cd target = {};
+	struct arm_smmu_cd *cdptr;
+
+	if (!arm_smmu_cdtab_allocated(&master->cd_table))
+		return;
+	cdptr = arm_smmu_master_get_cd_ptr(master, ssid);
+	if (!cdptr) {
+		/* Only ats_always_on allows a NULL CD on default substream */
+		WARN_ON(!master->ats_always_on || ssid);
+		return;
+	}
+	arm_smmu_write_cd_entry_no_account(master, ssid, cdptr, &target);
+}
+
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_device *smmu,
 				    struct arm_smmu_ctx_desc_cfg *cd_table,
 				    u8 ssid_bits, bool ats_always_on)
@@ -4176,61 +4213,49 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
 		.old_domain = old_domain,
 		.ssid = pasid,
 	};
-	int ret = 0;
 
 	mutex_lock(&arm_smmu_asid_lock);
 	arm_smmu_attach_prepare_invs(&state, NULL);
 	/*
-	 * Unlink the PASID from the domain before invalidating its CD.
-	 * arm_smmu_mm_release() walks this list with only devices_lock held
-	 * and writes a valid, faulting CD; unlinking first prevents it from
-	 * resurrecting used_ssids after the last PASID is detached.
+	 * Invalidate the CD before unlinking the PASID from the domain.
+	 * arm_smmu_mm_release() walks this list with only devices_lock held:
+	 * if it sees the master_domain it writes a valid, faulting CD; if it
+	 * does not, the CD has already been invalidated here. Either way the
+	 * page tables can be freed after mm_release() returns.
 	 */
-	state.old_master_domain = arm_smmu_remove_master_domain(
-		master, &smmu_domain->domain, pasid);
 	arm_smmu_clear_cd(master, pasid);
 	if (master->ats_enabled)
 		arm_smmu_atc_inv_master(master, pasid);
+	state.old_master_domain = arm_smmu_remove_master_domain(
+		master, &smmu_domain->domain, pasid);
+	/*
+	 * mm_release() may have written a faulting CD in the window above.
+	 * Drop it without touching used_ssids so the CD is invalid again and
+	 * a later PASID attach accounts for the install correctly.
+	 */
+	arm_smmu_clear_cd_no_account(master, pasid);
 	arm_smmu_install_old_domain_invs(&state);
 	mutex_unlock(&arm_smmu_asid_lock);
 	arm_smmu_attach_release(&state);
 
 	/*
 	 * When the last user of the CD table goes away, switch the STE back to
-	 * the RID domain's CD table (S1) or to the native bypass/abort STE
-	 * (identity/blocked). Do not call attach_dev() for an S1 paging domain:
-	 * this is a teardown path where allocation failures cannot be
-	 * propagated. The private CD table is kept allocated for reuse and
-	 * freed when the device goes away.
+	 * the RID domain's shared CD table (S1) or to the native bypass/abort
+	 * STE (identity/blocked), by re-attaching its sid_domain. Do not
+	 * propagate attach_dev() failures from this teardown path. The private
+	 * CD table is kept allocated for reuse and freed when the device goes
+	 * away.
 	 */
 	if (!arm_smmu_ssids_in_use(&master->cd_table)) {
 		struct iommu_domain *sid_domain =
 			iommu_driver_get_domain_for_dev(master->dev);
+		bool ats_always_on = master->ats_always_on &&
+				     sid_domain->type != IOMMU_DOMAIN_BLOCKED;
 
-		if (!master->ats_always_on ||
-		    sid_domain->type == IOMMU_DOMAIN_BLOCKED) {
-			if ((sid_domain->type & __IOMMU_DOMAIN_PAGING) &&
-			    to_smmu_domain(sid_domain)->stage ==
-				    ARM_SMMU_DOMAIN_S1) {
-				struct arm_smmu_ste ste;
-				struct arm_smmu_domain *sid_smmu_domain =
-					to_smmu_domain(sid_domain);
-
-				mutex_lock(&arm_smmu_asid_lock);
-				arm_smmu_make_cdtable_ste(
-					&ste, master, &sid_smmu_domain->cd_table,
-					master->ats_enabled,
-					STRTAB_STE_1_S1DSS_SSID0);
-				arm_smmu_install_ste_for_dev(master, &ste);
-				mutex_unlock(&arm_smmu_asid_lock);
-			} else if (sid_domain->type == IOMMU_DOMAIN_IDENTITY ||
-				   sid_domain->type == IOMMU_DOMAIN_BLOCKED) {
-				ret = sid_domain->ops->attach_dev(sid_domain, dev,
-								  sid_domain);
-			}
-		}
+		if (!ats_always_on)
+			sid_domain->ops->attach_dev(sid_domain, dev, sid_domain);
 	}
-	return ret;
+	return 0;
 }
 
 static int arm_smmu_attach_dev_ste(struct iommu_domain *domain,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index cd659590dfe5..79623d8283f5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1096,8 +1096,8 @@ struct arm_smmu_domain {
 
 	/*
 	 * CD table shared by all non-PASID devices attached to this S1
-	 * domain. A master uses a private table only when it needs
-	 * substreams (PASID) or ATS-always-on/S1DSS.
+	 * domain. A master uses a private table when it needs substreams
+	 * (PASID), ATS-always-on/S1DSS, or the stall model.
 	 */
 	struct arm_smmu_ctx_desc_cfg	cd_table;
 
@@ -1212,6 +1212,9 @@ void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
 void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
 			     struct arm_smmu_cd *cdptr,
 			     const struct arm_smmu_cd *target);
+void arm_smmu_write_cd_entry_no_account(struct arm_smmu_master *master, int ssid,
+					struct arm_smmu_cd *cdptr,
+					const struct arm_smmu_cd *target);
 
 int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,

-- 
2.34.1

