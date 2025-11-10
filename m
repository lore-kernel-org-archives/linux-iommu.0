Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1D5267B15
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768553; cv=fail; b=Njw7Ey65iKPnBOinsvxHF2O5kZiqG/NGuQk7r8bLCo/iWWGKGkoCKQDPnrzrpsXAFHmU2WLbO8b9AM8N+UexO681Bv/uxJJmez3COraldxlyijDRjfUFI4sQUzkalYZQrizlM22KPjijPPtpeVl+TNu4cNFOdY8e/kLZ9ucWY3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768553; c=relaxed/simple;
	bh=BPCTmyoDeNbIi3Emgr7RVmjgBsZavLki9NlLsr4Dxs8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PlfzAgAPLcBGrKDAsoj/uaRJjiPgDx+gzjLqIh+Lpi/ND4SFXzNWWAFaT9a/1j6MCvy+ulEZ90wwVpIBKu0JCsXYUU/6puWRHsk8o289x8WMP1wOWXQQhBP6zG5oYCuEjFrusKcmi1LaYXUhQEeIZQlI+/QCjd/C2GUSxGIGLLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3L1ByNyR; arc=fail smtp.client-ip=52.101.62.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3L1ByNyR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqeBaNMms3jseW6+xFkZ8lWDh6Gu+fDGNjZFY2NbaMBfXsDnQyt2sMQ/GluwI/0AHXUnvKvnys5chfeMOKiAKFEOky+2rgSMaFInxAK1Kgu9f6DZ+3DeTfQ4fmFaNdkfwCTTlse9jeKyt2FZL907404ibn+RDeAnyOHrtJfSzx+geAEb9WYaUQ6kapllfy4RA7oVz7AuVnOdTpxZufo+a0bpGqCgCN+PEjrwj9/nRR4RTPidTFqI9Mm3sLPJWlMoDqbGvJCGL5vsufWZa5qPK+JYpMpbbftwniFlireb4I+G99rpYiXIKOBawW4JntLyIfhetOIHM+bm9zYdKMaYcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXie/NTLDZgnt0dbT0fA605VyHGYNbmesRcICfRoLDw=;
 b=GXrs/De9GeHHGDFbrVmgibOVnm194LhrwFZ/pV5ZfzkwpM2AabcvJzfciPExftdilkJtciw8Y1UiUMeoIBHPFgK3CdV/Y3A+SDfFRhK5HjwoQxe0CFPAVp6u0l2h1lUvvA64aIUnHP0DQnKP8HUcFDBGlz2PWnRQYcz+IwKcPpusTOJwxbgCri/E04AHyCsxI/NbcJcea65x4Hft7Ou6B6SaAij/yn72keZO2XcHEErymdbUazwIi03ge9H0QqH55zZgAS2wD7e6DvvUYjlx59Ys/N1pdEyCAG4Fsm+D3hbTC68vXSOsies2Y/vtN0XdRAR5HtQm+85W37EiIjxZIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXie/NTLDZgnt0dbT0fA605VyHGYNbmesRcICfRoLDw=;
 b=3L1ByNyR2xKyVEcYXs9iqjwa8ikK6S7pWMHpFdVTcDj1isNx0gvwklWsVSKnCivQfR3yEQeDuFVXWmNxHDbMyhStH6zYbd/q+F55VsBG/6JYu1QiTCNTpiG4kRkFZgEcSmbmKe/ZK4CrEhIrE/QNen0KX+N8musvkT/l4ttClaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:55:48 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 09:55:48 +0000
Message-ID: <b937cac0-4a48-4991-9958-0c6010887a1a@amd.com>
Date: Mon, 10 Nov 2025 15:25:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
To: Tom Lendacky <thomas.lendacky@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Wei Wang <wei.w.wang@hotmail.com>, "alex@shazbot.org" <alex@shazbot.org>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Alexey Kardashevskiy <aik@amd.com>
References: <SI2PR01MB439373CA7A023D8EC4C42040DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393DFDCB2788CB823DAEC64DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107010349.GD1708009@nvidia.com>
 <SI2PR01MB43930E5D802B02D3FCD5ED9ADCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107141632.GL1732817@nvidia.com>
 <SI2PR01MB4393E04163E5AC9FD45D56EFDCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107155704.GM1732817@nvidia.com>
 <SI2PR01MB4393E3BBA776A1B9FC6400D4DCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107163614.GN1732817@nvidia.com>
 <087b3567-5c74-4472-827d-e5a47761a994@amd.com>
 <20251107183209.GP1732817@nvidia.com>
 <a63411aa-6590-4bae-a7f7-01be8ba27eea@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <a63411aa-6590-4bae-a7f7-01be8ba27eea@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 14131435-0324-4d8f-bcc9-08de203f52f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1J2RWQ0ZTlWU2RselBrN1hWdGRXNkI0SGRqVXYrK2I5MkZjOUM2REFwVjgv?=
 =?utf-8?B?N3NHSXowdGZKcUlkRWo3QXBjaGd1Sk5Rb1J4SElnZlNXWEluandkc1VhKzRV?=
 =?utf-8?B?ejQrMVNTaVZrdTJ2Y004dEhqZ3ZaZmRUdXhUQ3VWeGNNanpRTmhTV1BtWVpa?=
 =?utf-8?B?ditkUjhpclo0eDZqaHcxYkRYd0x1djdTa1RNRFpxTDBZT3FHd1hSbjJPTEdz?=
 =?utf-8?B?OGxTenQvMDZSZm1LU0JsbC81YTdoTVpvNWtnWndGS2JXNkVsN0lkRnNxdDhZ?=
 =?utf-8?B?dE8rRit4clpRcWllcHU0dTlBYmdpWEpQaUxpNmVXWWJldVdvUjVhVVphK3M5?=
 =?utf-8?B?YTNVSFBvYk1za2wxVXNrUk9NQ2xvNDJ2TzFqYjluZGMxV0VFaHlaYytab2gy?=
 =?utf-8?B?SWFGQTNncXpCVUNIQS9SL1NGaFMzYkxHa3E3MFNoTnZJVlhwOHBDSGlhRTZ0?=
 =?utf-8?B?amk0ZG81cU5lOEROeE9zMHRSNHZ4WXRvam5nVzJ0bnpRME02Qy9XRDZTcnF1?=
 =?utf-8?B?S0hlbUJhbVZCVDhvQy9NTHBQOGRUb2xreDlUU3YvdFBVVDdGNTBYckd4QnJG?=
 =?utf-8?B?RWZSbVZXNXFVSDRqVXBUenl6aUdvMGdtVDBteE1aUGd6cENGWlhQK3VkaVgr?=
 =?utf-8?B?NHBmYXExdGs5aXVTNk1KamlucUZCQnlUMWMvbmRjTS9WcFIrS2ZpWm0zbmFz?=
 =?utf-8?B?YzEybkpudzBueUpsbEppSzVYWFY0eDhib0VnWG9zTW91Y2FzUGN6anA4L3lJ?=
 =?utf-8?B?aU5CMit6U3JWT3UvM2tKdHBzdFdZSFk4WlVpVk5zZlZPdkVuU1VyYlFBelM2?=
 =?utf-8?B?UithUmY2eEZOSXdMbElTWGJRcVhKdTBJTUo1bkl4U0o2by9LRTBrTXF4UEhv?=
 =?utf-8?B?NnBKUTMrczhHejJqdG4rVXROWTFNb0lYZktVUUpXYlFoTUpzWnhXWURGekVP?=
 =?utf-8?B?SGJmeTNuTXZLanVxdFZGejJqdW81NmlGR2ZCR2ZLL2xFVnVvTlZPYlpLcFpJ?=
 =?utf-8?B?aFBnU1ZOYUVmOEVLL0pYSm5YcGRIQTVzem83YmRTMjMyblpzMzRhTFFndmZj?=
 =?utf-8?B?NHVQTW5XcWxJSUY4bWUxdVNSWWJ2MVVoSGdua0RKc1hkeTMzeXRrckdEa09x?=
 =?utf-8?B?L2lZTnQvRk1kODcxK0JWRDduU0UrOHI1WDZML0QwcUZDdnJxemltTzVMK0RO?=
 =?utf-8?B?TC8rVGh3RXgzeUVDNUlJWldqcngzL01vRVMxZDZQMS84czVMUmZYWHRaRDd5?=
 =?utf-8?B?VFhMTmIrR3NYV0JpMkFRN1hYZjlQYlU5QzRNbHVhaUloV2RkdVQ2ZWVkMitq?=
 =?utf-8?B?Y1pZZXJ3SVhxSWdDZVNsbTdBQ3BpeWNWWE91SFNxd3IrUWZGWHpScTRxWmVm?=
 =?utf-8?B?WWR5Mi9SUHg2TzNQSG1KRmdaVDYrejc3YzBmaGRtS21xMW9ETVh5b0NLQnc1?=
 =?utf-8?B?T1hBYnZlendRTk53Tko4ZWtMb1IzbGhBN1NQYVdYRXdDR2RnZTQ1VnNDZ1hT?=
 =?utf-8?B?aHliYmtEbEZiUkEvMDZ5N0pjV294TnQyQU5NM3FrUFluMVJ3SGlBNUYxY1Yv?=
 =?utf-8?B?cTVzbDRIbm5RcGJzNG9nQzlDaktOZ2ZteG1RRDJtWnU4QnJpbTgwancrK1NB?=
 =?utf-8?B?NkZGT2RzSElvTnQwTEtJbHlnRUFFZkNMbmF2UWZJYW5yNGNPbG9CY0Q3WHJj?=
 =?utf-8?B?VUkyNHQvMTJlUmpzeHU4d09oWkFzSzQzb3MrdnpXS0RFcWljeUxKSkVOeTNy?=
 =?utf-8?B?bmwwdnBQOUZ5V1ZpS3d3azQxTWtTZDJsWGdBREVUT0RxWFA1VWh6MTk1R01R?=
 =?utf-8?B?Y0JuMnNnREhISGNHOXhQUW9PY1AvWUN2dHJxQXV2b3pCdmtYUFZKU2xwYWgz?=
 =?utf-8?B?T0xqRW5aSi9JdHZ1THNzOElBOGs2V045c2NRVnNPTWk0c2h2Rm5vYjZmejd1?=
 =?utf-8?Q?dDD/RPC3txiKpbXXaBdSd8Un5vo5vi5s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vkx4ZHVaTVk5WVhXbHdzeWhzaURLa0JUdVhoWFVTZ3ZQc1QvM3ByaGEzN3RT?=
 =?utf-8?B?TTNvNnpzeUd1TnpFSnd2SittOWcxeWFHMVpnQW5oU21yVkcxM3I1MmZvWWNJ?=
 =?utf-8?B?YXFWaW50QVZoeW9EOTlrb0wza1RPZSt2aU0wdDJnVFdUTFhJaHhzSW1jWEZH?=
 =?utf-8?B?Y3VQNHl4VURDWHNzTzB4Vk1ET3g5eTdBaU1SVG9MbFc3U09EYURKL3lqOEpH?=
 =?utf-8?B?ZWlrSDkzbTFyc3NPa3dCaDVPME5uS1hJNzNzQnNlVFFLelJOaFVsQjNJODlq?=
 =?utf-8?B?M0VqQ0IwekJjdkpyQXBTU1lmTndVSUpqdy9LOWM1OFRpcjNuUGRhTkdEcnp0?=
 =?utf-8?B?YVd1MElqd2RTYk52Y2RjWUhkSFA2cmRGcnVxdHM0ZXJsNUh2UHU3MDhZdVlV?=
 =?utf-8?B?em1QRllUcHAyaG8vYlcwVnFydS9kZUFKZ2IxNHMzeCtwN1BteGxTeVFZYnNW?=
 =?utf-8?B?Wlg2NTM1elQ0L0p1TzRCak81UXFRN0VGWFVTZG45Yk5RWmxwc2tTc25GNWpN?=
 =?utf-8?B?SnFnMEVrQVpjK3o3QWllMWFZMmtOQ2xqd1cwbElweFhtM1NGNG5ZeXpFTTV1?=
 =?utf-8?B?U3FTT1J5bUluV21NTkVSWlF4a1k3dDJOMHlSdnBBU1Y1bmczTU5oVzF2YXBT?=
 =?utf-8?B?Q0YrbzBmTXY0NHhFMnVteXA0eVV2NUNubFFOU1czRGQycHJyd3RNTFNTaGc4?=
 =?utf-8?B?elFObzJvUmZJazNKRlQzQ1FPdXJYV0pvYzRvdnBGYVdNNlk2YUJCVUh3bzVR?=
 =?utf-8?B?SkdGWHRWWTRqV1phN1NRZDJ3Sk1tOEpFVVkzR29xT0RIb0hJYndnRmVDdE44?=
 =?utf-8?B?Q1dnaTVCUm80bW9oTW5CTCsycGdLY0xzRWM4MlFKV2hiaUtQTWJ0eHNxUEIr?=
 =?utf-8?B?YlB3dS82QTIyVUw2RXJuL0ZZb2ZiTE9Wb2xwS2lGOEx2aExNSG12RmViejhR?=
 =?utf-8?B?R1dyRUloSS9LVnhHQy91TktVbmFSd2w0ZjZTRjduVFhRT2ljSWhCWnU2TDdI?=
 =?utf-8?B?cmtWayttUXVFR0JlUWVpMmVVMnBJT0tIOCtjalNnKzd0RTNsUHdxd3VyclRM?=
 =?utf-8?B?UVhNejMzVkRGVHF1SXBQN3NzU1pSU08xeEpxV0xuOEJ3QWhyWnlkczJIeWFh?=
 =?utf-8?B?YStQdWl1cW9jRzV5VDJYMDNFa3A2Qm05cnFaREpiNHpPYjNSNVB5NmM0anFC?=
 =?utf-8?B?ajNtcEtGSE8xekpXc05BR0FJbWdGb2tNRXByeHh1NzEzdFZYaHowbHNPZnhm?=
 =?utf-8?B?Z0o1dEhrQ0ZIODE3cWFWSldCSS9VZnFpUGZBZXlteEZyV2RNS1ZhOVY2dFFD?=
 =?utf-8?B?bFYxVVRYcU9Vcy9ucXVmVGR5ZnMxVGhtTWZwQ3hER1VZbU01R2NDNStITVQ4?=
 =?utf-8?B?TkxZNy9nYW1Qc3djNzJ0T3Bvb3B6ZCt4Q0t2cVRqWDBZVmc0d2ZwcjR0OW1X?=
 =?utf-8?B?cS9BY1BZTFhHQm9LZEtxak1DaUd6c3BJTXBKWUM2V25nVWdTaDY5a3hSZTJi?=
 =?utf-8?B?UUk0VHZ0bThacTFTdys5T0xtczlZdFQxUjgrbWpiZlRCRjZTend2RXhYeEVa?=
 =?utf-8?B?WkNnQlF4V2N4bWpJTVdsK2ZVK3VJeXVIRkNNRE5mK1QxNmdBcmViR1F4aDMx?=
 =?utf-8?B?UHdJamVuVzAwWjU3ZHUwUEp1KzhQd0R0Z0lKbFdPUXhna3ZUQjNkNGJ0aDE2?=
 =?utf-8?B?UkhvbDFSaUxlanNkQ2VYOUN5STdpblROY1RtVUZUU2JTWUFTbW5FMGQ4ZU44?=
 =?utf-8?B?dGUrWVNidkRSU3YzK0xWbGJHUTR6SWpUV3E5R1ZPRE95RFJTVGlLbHhQeVpG?=
 =?utf-8?B?NkNtTzJ4S0ZWYi9mNTIxRHIxWVpSSTlpRDUrMUhOZmU2K29qamtab2d1UGVK?=
 =?utf-8?B?NDE1K2RJTVZCVU1TN1lqaWFROElTYnVEekZGUG91SDM2TkFXVFhOY1BTMit0?=
 =?utf-8?B?NllkTHJqWW1TVkhkdmw2Z1BCdGs1QitrWlp2YkJlMFdFWEVDQ1RHSjlHbHhz?=
 =?utf-8?B?RFYvL2ZJQ1Bud3FhNzVGWk1uY2xpV1ZPZm9oQW02Zkt1dUhDSXA4OWZsVW5B?=
 =?utf-8?B?OWx1WHRoR3k5RXdMak5pSVFWcHE1d0k1YkkyeHRqNmZJeWQrZEZwYTlzNTVR?=
 =?utf-8?Q?V3bkUaQt4L8iFWRFTYT16xwus?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14131435-0324-4d8f-bcc9-08de203f52f3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:55:48.3433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubDrll3Ax8+1wRQUJ68D2mraIbKmkxTkWyPMF71xF7DtSdISEGd/9GHV0Jw9F1dXq1JjHThXRwohacWcfXLDNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330

On 11/8/2025 1:29 AM, Tom Lendacky wrote:
> On 11/7/25 12:32, Jason Gunthorpe wrote:
>> On Fri, Nov 07, 2025 at 11:56:51AM -0600, Tom Lendacky wrote:
>>
>>> When you are on bare-metal, or in the hypervisor, System Memory Encryption
>>> (SME) deals with the encryption bit set in the page table entries
>>> (including the nested page table entries for guests). 
>>
>> So "decrypted" means something about AMD's unique memory encryption
>> scheme on bare metal but in a CC guest it is a cross arch 'shared with
>> hypervisor' flag?
> 
> Note, that if the encryption bit is not set in the guest, then the host
> encryption key is used if the underlying NPT leaf entry has the encryption
> bit set. In that case, both the host and guest can read the memory, with
> the memory still being encrypted in physical memory.
> 
>>
>> What about CXL memory? What about ZONE_DEVICE coherent memory? Do
>> these get the C bit set too?
> 
> When CXL memory is presented as system memory to the OS it does support
> the encryption bit. So when pages are allocated for the guest, the memory
> pages will be encrypted with the guest key.
> 
> Not sure what you mean by ZONE_DEVICE coherent memory. Is it presented to
> the system as system physical memory that the hypervisor can allocate as
> guest memory?
> 
>>
>> :( :( :(
>>
>>> In the guest (prior to Trusted I/O / TDISP), decrypted (or shared) memory
>>> is used because a device cannot DMA to or from guest memory using the
>>> guest encryption key. So all DMA must go to "decrypted" memory or be
>>> bounce-buffered through "decrypted" memory (SWIOTLB) - basically memory
>>> that does not get encrypted/decrypted using the guest encryption key.
>>
>> Where is the code for this? As I wrote we always do sme_set in the
>> iommu driver, even on guests, even for "decrypted" bounce buffered
>> memory.
>>
>> That sounds like a bug by your explanation?
>>
>> Does this mean vIOMMU has never worked in AMD CC guests?
> 
> I assume by vIOMMU you mean a VMM-emulated IOMMU in the guest. This does
> does not work today with AMD CC guests since it requires the hypervisor to
> read the guest IOMMU buffers in order to emulate the behavior and those
> buffers are encrypted. So there is no vIOMMU support today in AMD CC
> guests.
> 
> There was a patch series submitted a while back to allocate the IOMMU
> buffers in shared memory in order to support a (non-secure) vIOMMU in the
> guest in order to support >255 vCPUs, but that was rejected in favor of
> using kvm-msi-ext-dest-id.
> 
> https://lore.kernel.org/linux-iommu/20240430152430.4245-1-suravee.suthikulpanit@amd.com/
> 
>>
>>> It is not until we get to Trusted I/O / TDISP where devices will be able
>>> to DMA directly to guest encrypted memory and guests will require secure
>>> MMIO addresses which will need the encryption bit set (Alexey can correct
>>> me on the TIO statements if they aren't correct, as he is closer to it all).
>>
>> So in this case we do need to do sme_set on MMIO even though that MMIO
>> is not using the dram encryption key?

Yes. Its mapped to GPA (at least IOMMU VF MMIO BAR, I believe its same for TIO
device as well) and we need to set 'C' bit.

-Vasan



> 
> @Alexey will be able to provide more details on how this works.
> 
> Thanks,
> Tom
> 
>>
>> Jason
> 

