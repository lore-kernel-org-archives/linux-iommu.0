Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795103246;
	b=ZDu6EDoZw6kHIzAyFT68c2j1MLBitKRp5Ys6YlwWwea8riyMWMBY3dJ2G35vAIZM44Vm
	 i/AfkwjA5za4vlmSyHCBci0SWo+GxKuato4qDNcTAjlYdf1it/J3dJ5kGAG3Idk6NFknm
	 /XDqkqOYQmodG8X/s7gx1taGhdVtPlVHpdlyraeMxsbJkUmXI57hSclbk9ZiL/nmf4DVn
	 wd7sEOVtgBQNZdIGJyq/pCoocdmgyU0ulF+xuzSpQoRJgNOQuFZCmNwdt11iEyuToz7N/
	 TFZ4vX7uxBX1c4gvPvmuWV4BNN9hdULhtlduwHUe3Cs+JRMbDw0seLPiLaRfgWtlbPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795103246;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-ClientProxiedBy:MIME-Version:
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
	bh=ISwmK+gST8zSTOHSlHfZjEheogXs6tu6a93z5aNAb7U=;
	b=eIzJiSuHsPDiQcP2Wqg1x+T07XpS4qgH+2p/A6eS7GaYIzWwMDfyG4sb92ZCvy7o2Ibs
	 2BB3BMa8B+xAwLdfcTjyfZxjYRKTmRttOT6YRTuEDlVBdk+eCFNTOrh+7yaZsl0Lgg9i2
	 Lh7tLyFs9MGfp+C5opFjCyLKuHUwkM6eAAChgo7W+qZPg0MpBm2kQ2HWOwyed8t4EGw/L
	 fO1ahr1YQUNT7r3l8MQJGpN3p44vNIcRib4hOwrtKIY6OVqNlgIz1qvelwI5+Sw2ro7A6
	 Sykm0zmUQRIfYfkKHuGuLOlHrJtfITjitk7izrNNwXrZGo0FvjlJ+RHIdcL27Y066tw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lrqKtFGJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.45
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012045.outbound.protection.outlook.com [40.107.209.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335B660A3832
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 15:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 335B660A3832
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lrqKtFGJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8H+dkAzF8BlItyxzKiO/99U3v9wVxclMUM2BwZ0EWuKUO2hjDZ0jMcy4ZT7BgcjgdvKuGjr73XK4cZUTsWLceptRyhSGXlujb0B6Q8IhyeRwyeVIf5QQGagQNc6WplQwoFWmte+yjw81uJ/w2pUVzH5H12LD0ubbLADByGULYmOiSY9dbnpa4oKMv0Cg5YlWRghJ78IScgjEaRx2nlmrWreB4Gs5bwcBDYHpEn9RdnqV3L9ACcjsfVr0sW41gmQrwtw2j61J6SJyrAxFSKCJcCuQA1aCuCwozdVKEGehrRHFLfIcwEKjF9u/w29xvKNN0Z9BqTGM2gnUAd/ED09Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISwmK+gST8zSTOHSlHfZjEheogXs6tu6a93z5aNAb7U=;
 b=uHlPMT4tAU0mfKzYj4DyqC8UYhJH/YJe0hPlrbbIQ9nA62JDSwL6YESaIP5ma4O/fyH+GANqJQkpmAtqu5uBsIWkoV4fgsT3FDf0loXdRpAJO9pSWxbygW69vQ+uQdu6NG0nO5M+zBVUUTC5HJVkFwaosBd+ya9gTtNUrOD2CXm6Mu63tUbfjZGtNfshySHcijj/puZFwXkE08jGzI3dRGPshONQkf8M0TEARz/YICk0jiTUgNQk5a2jb4HfPb4IeD+AQSxBlwxHmlY3/ZPBI6k8FbrH3hQRKAzOilGha7xBvwAN467gOm0OIKZ4wODoIjUkKg6zCHjoZvi5ecwxTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISwmK+gST8zSTOHSlHfZjEheogXs6tu6a93z5aNAb7U=;
 b=lrqKtFGJ8jBuyC2FvMhR/jouzV4lhQ1jGxPU84S2Ud4IqP1cK6LeSBqJ1dFFyuacq1Et+bWtApAIdSo5CQ/JATvOkThWbyJ106Ulhnwe7kWtjeFb9vkxiK90TL6jmTpkC3n55Ud2b+8U3rCrC81AxJKN9DiJE4as8X2MmSJnxXNeIQO8oxjmjhZwrN30CIlo3EX9ui4LXHtVmU8QDCk/Cv2bEfW3NowiAJ5wKc8qYQPOkKKQFCSHWMN9O2mxupbvk6uIoMj5GT1jXLamBSDZgHtBx43JAbpugD1Cu5qHi/lGeBhFNEsVEmj1wY5IlkhwVFmVllumxOA3+CzvzUf7KQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CH3PR12MB7522.namprd12.prod.outlook.com
 (2603:10b6:610:142::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 15:47:20 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 15:47:20 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 Qihang <q.h.hack.winter@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261118164026.54455-1-q.h.hack.winter@gmail.com>
References: <20261118164026.54455-1-q.h.hack.winter@gmail.com>
Subject: Re: [PATCH] iommufd: Unmap the failing batch before releasing its
 pins
Message-Id: <179502988869.3851267.13632146860422875730.b4-ty@b4>
Date: Wed, 18 Nov 2026 15:24:48 -0400
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: MN2PR16CA0057.namprd16.prod.outlook.com
 (2603:10b6:208:234::26) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CH3PR12MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f40ff8b-2a81-4b76-0a36-08df46546554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|11063799006|56012099006|261026140227099003|261028144727099003|261009223027099003|10067099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	AL8FppFdnoIxSttiAiboh5vANuHMn5UPKJQUgq5gxujJQKjUro7RXGmE3PkOiHSOFogrZrirCTr66VrCtdoBNsaTJEug+JHFPf0LIgO+dsK+7JZhIu35mt7qJvjHXZsbXYkHszEUcGJIuP4xxc+938GtLsxucOSMI05zeIE+pOKvkIZGz8hTyx0u/D8iwFUnIu9qJq+UVlzQVSfvVbCgrRzbWFiaO24qc3jy24YZgQK5s4XkZdD4LQ1ZLwq+D7aLNd4CK8AmqLHvzQWVPS2p4Bbekvijtwz96KelbTwvPQxbX4Bsmzr5+cTKcAZj3dbl3T8w+dHROt4jZBb+M6ILJ6ST7jFO07wwn/pLOnaVIRFZgneOHxuKwe+E/QjkgsrQ5E1h3458oIpOlWrbyaLS14xs+AESuodVYOTMor1uSa4EtVavAK7COPfybxVxmnKE+gYdEUeIn/mqgMkWg3n6PCRTarcQ0iSdHHpC4DFVfLASpDkFqQJdKT6DYurXvsC/rXQ0071Z4HsGNepvaXboiZbh20hLPCcI0X0hRjJq+ESi1kx4mOM/3fFnxP1HpJktOAowyD9XzAPu/3x8bJecgvppuBn8NZ5/P4/KDkHOwx+YKT3XOwFL4hGnuc5rfgyDxeY0MqmaPyUWh8poDDRxc5hX6hFIJEg5qVMjS06jKZI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261009223027099003)(10067099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1dGNUNYZjRWS3FkYmNHWmp3TGRURUozbDBjdWQrOU5JNWFyRVZibkJud0c4?=
 =?utf-8?B?anNNYmp5c0RLb1E4aGtFZUNPcGdnelpuazRRckl4ODJTTkMyUGYxa2dRYTQ1?=
 =?utf-8?B?MWxMRTM4aHpiUDRkWFl6WnRla3l1V1pNVHVCZmFVemJuSHJjSVk3MDJpKzk2?=
 =?utf-8?B?TzZnYTRCcjkzNmN5UHJJQWRSTWJuZDVFbzNRNG1JeXBGSmEzRnpubmRtWTBl?=
 =?utf-8?B?ZlQ3YVY0NEFvaGV1ai8rRzdEYnNVc2IvMXFXWEhWVHNPYVVmNlZhZFJFeDNk?=
 =?utf-8?B?VWlwbEtKN1FvVXEvZmlueGtHQlVTMm5rSXdJZ21mNmFjOW5vWFFnbnJaSGJn?=
 =?utf-8?B?UlR3bkpZVkdQQ0x0Zzk1d1ZSVU8wbHZEaUw0SEtmbUhrSmZ1MVQ5Ym85QmFr?=
 =?utf-8?B?Q050NlNQNzlHazdSRmdpbGh1ak5maEhFRDZZdWJuRjhzL0J2Y2d4Y0tqdVU3?=
 =?utf-8?B?OFdRajBiTndzekJZVFoxYS9sdVliV0F6bWR2U1ZuZ1prQktVR2M4aEZXUkVm?=
 =?utf-8?B?bSsxRG1WdWFsUEc3QXk5Rk9rL2hsNXNaT3lBRnQ2Y3JQc21mSWllaDVDNTdm?=
 =?utf-8?B?UEFQa2JaZTA5TkFJVExKOTBUK2hReHRLdWdTWTRIZkxlYk5qS1RZNTlwQ1Np?=
 =?utf-8?B?bXp2RW1iQURTTEg0dk5iM0hQUGcrQzNIZUV4QTdPSFhmZkkvOXY3QngrekFH?=
 =?utf-8?B?cWd2cFNnVkFBWWxKMjZob1ZBc3IyR0ZwcU9zUFhwc3lZR0M4V1dJY05FRHd3?=
 =?utf-8?B?M3BncW5BTTYzbU9NNFR1ajBxVTR5ejZvYnk3c3pFUHVxVWdZRk9ITjlIV2RM?=
 =?utf-8?B?NkpJMW1tVVliU3BMWTV1TmpHUVlabFVFTjB5OHRrUngwR3ZsQXdaaUdVQmo2?=
 =?utf-8?B?bnJBUytyT3QyN3hxZlZkVnVQNWRNd2tqSWJPYXRaMXF2dUdocVVLNG9LK1Nk?=
 =?utf-8?B?UGRaOEYvUUEzN3MxTTBlR3VsL0JXWDdIMG8yUC9FOU14ZVJVaS82RFJ5TGth?=
 =?utf-8?B?WlJqN3BXeHBxVnFJYlBtWE1hQTVpZWdGQi9NVWZtdGl6ZDNCSVN1RDhtTk5K?=
 =?utf-8?B?U0F1YTFGQXU2NC9Ob2FLZVFuZ2M0SFZVQTUrZ0RWc3ZYRVR3VWNkNkdwdFJB?=
 =?utf-8?B?cC9HR042a0Z5VXFoeVcyY21SSEZYZGxuQURXdkJQUklDSnAzNDk2US93ekZn?=
 =?utf-8?B?YldJNEZmUDhPT1dVWCtISWdjaFd2QTVVaUxqWlczbFdjS2xrRlIxSTdwNzc1?=
 =?utf-8?B?R3ZTWHN2WGVWT2VsMVlYM0Z1dmZSclZQeWtVcEk5enE1NXY5VjBHQWpGU3Jp?=
 =?utf-8?B?ZVNRdnhhSXFaTDlFZ0lGcmZsb1plY09wR2QvMXFnUmtyNi9TSUg4WnpqUDZX?=
 =?utf-8?B?WEo0UnhROEtuNk5IZVNjMGVOQWV4ZkZKUjE0N0w2OXlWNms0YkF6eUNNdHJ1?=
 =?utf-8?B?eldBUkNseTl1REpUeXZuREhkanVmVVBBdW9ockhzenN2dW85Z3puY3cwWisz?=
 =?utf-8?B?ekFLem5Ec05mbnIySDBqaWlEV2dBWkg5UmRKOWdlT0p6eUN0K0xHQ2FCTEQv?=
 =?utf-8?B?a0s2ZzNwYTVGVVBFbUJlV0lxOUhEbDBlVHNwRE5ocGlvRFpNc1V2RjJZS05s?=
 =?utf-8?B?ZWlUTnN3em1CZHFaZlYxb0pwblovaGx0TGQ2OHR5UlJJV3YxZG4vbzVQYnBD?=
 =?utf-8?B?R1hieDc1dC8zeHJMY29EMmkzRVFPMXpwKytSNGNKUVVJMVp6Y2RrdDgvL1dF?=
 =?utf-8?B?eGtjaTEyUUJVZk5Oa3dGSTl6cmZkU2JLaVN2eVBvZDZpZ1hCbkZlcndELzhI?=
 =?utf-8?B?VGIzaWlOQjFJVmJMQXo1Qmt0OHdpZm9BaDlBNUJpQ2cyaFNmQWlUQzF4bXcr?=
 =?utf-8?B?MzhxUG83RGhNYktWbDRCSVV0TEpJVFdLMElxQktDTXp1V0JSZU9wbkJDemx4?=
 =?utf-8?B?SnIxcGx2cnpzZS9UeEZBMzZTQ3VPNFh1eW42ZXB3akYxZlVRenEzaHZjZlJx?=
 =?utf-8?B?dWQ3dG03Q2xzN0xVV1dudnJXYkxTN25DVlA3bTIvODJXeWp0V1dhdzg1ZG5B?=
 =?utf-8?B?Y1FMdDZRSFNIVjI2cWFjNjFDWmN1MmtSNURaT2FTUmdpYzYrRG1vWWJNeUk2?=
 =?utf-8?B?ZFZLc0k2b3FrcG5kNDZ0M3RsY0ptRENXWlZMWExVN296Rkd0U2lKaDRrWVdD?=
 =?utf-8?B?cWoyMDA0ZEk3SkZXT0tDbE4zeDNIRDI4N3ZiYWV4K01KWUVQYUpLa0Z5OUVV?=
 =?utf-8?B?WjJpYzAvZm9KeWJuWHpzOWVFT1ptR3h6b2p0cUhMaDNMRmFkLy9xVnNrcHNa?=
 =?utf-8?Q?KDzySD7Z0/38nRDee1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f40ff8b-2a81-4b76-0a36-08df46546554
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 15:47:20.3988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ie7f2EspFRYfWXk09CO6nMJxeDcMkvCkRTLoRjjnrc36G0oHDsMxJSJ1xYcLpyZF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7522


On Thu, 19 Nov 2026 00:40:26 +0800, Qihang wrote:
> iommufd: Unmap the failing batch before releasing its pins

Applied, thanks!

[1/1] iommufd: Unmap the failing batch before releasing its pins
      https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?id=c4a8d7229960cb5007e6495785c0b151566705d2

Best regards,
-- 
Jason

