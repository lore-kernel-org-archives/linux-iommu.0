Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C4A2E54DE
	for <iommu@lists.linux.dev>; Mon,  1 Dec 2025 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764581834; cv=fail; b=KxabK3/CLdgjF60bSP1IDEndDln+QVGLkRHQLWwNIQ7ASHLmC/ZJqprZvb7ntjjk2UVeVu0pTMTewxjynf655AwALiTen07r6SE8OhOgoyMNv1PGP8tqkknYXNxtRByP2tpfEwTY6RNljalGzgErwhIZHvzTO66Vs8q38RrVLxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764581834; c=relaxed/simple;
	bh=fJCcVwPkjfz5jykXrhQzumBBdMoMZQ9WYRfzKgsI8H8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hOz1sn14PIeCVrIm6dtrNS2Q1VLI9Cji7eHbkG5oCbFiVzXVaIJVPz50L7J3nltPPIk5XfrVrTMY22dg/0vjKXZ5mZoReZdAHsP9h9NZCMi+zeHD9JneCIlvs4A6sM2zE8K0X4k5mClw6yhuUwNlmUyq1GJ/W/WxlzDrhp9muFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XZCFpwiJ; arc=fail smtp.client-ip=52.101.48.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XZCFpwiJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pT5EghURZi+dhD2Skm3PeyrrOL7rZ9mFyw1RfhRJeF4d9dcaXZM99/0k5UcC+wzyAvX741CzhVIbXPglIM8YdF4OBrHaNA4vlYZopKTjA1bMyV8IdcbEOxB4aHWZzdxmwwS1O77J4NQYFvRz5H8GUNig6+SFd4Rb0whj64xbboh2QUDx4Q1G0/KBWVOyA/xdjuw2cLU03jsjbRykahyEnwLofc4JbtB96mP/5EWdotmkMWBWQFO98Hb1Drs9xmaxghwzDqSaCiifqNhvPAHVfjWfN3ZlvzCUhQ5gR3jjNLCYujJ47qXA1fC273lydvOTY59OGRz8OxvIYatU9qDMCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1sEUgHz9J6RQ1A6qmSpZIVDTNaEpZCjBuwAR9o3u9g=;
 b=iXWnOg5YCRBVcI8YpwTpkXJQvlS5k7lS/oMrTOlOHNbEkboagUVx1AIO7c0j5o7lLtCM6iwsdpRd4nSXSpQCoHmnFKgHTsO5IV/y2tgEF5zNcVS2+ifQox7zFl1v73HG/Rjj+vArj0G7nOk6iiqGdFHGMfCsx59R2VXrVv7+UXPnEiDbGvhhT3ND7ZLzFaqrps9LpE//L35Twbdst7NIDzGK3Hpnqwotv5LgE0sf4nIIE2WF+PWNBjdWvcUUhY0AM3QxMtY2roIH/oTZnD80qUNMtJ3xCtCjGieliWfhhZtqTWMP6UnFxCcEKrA3/XMrEV9VJ3/uiIZefkqCi/mB9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1sEUgHz9J6RQ1A6qmSpZIVDTNaEpZCjBuwAR9o3u9g=;
 b=XZCFpwiJQlY9suEB6XbfR8F6opzAy43qx9qstypqEfQZZfKDxbuzvxDsHy0QnZCKbXnDKtSRV0yFI6JQ/BpjxHQQoU+8OzkC5dWI1CPyHNU2Pia7qJDXATOu/dfOVAON9SoiHgsq3zIqtHgny1O07LJN0VyMKJRI/yMkGPjQFQ6J1vJJ9rU8kv86hefevRvV7sDtt+HcFXTb+PNclHDo0g6UzvoNLEzgPeGP3bgcMfjzg3r3eXsQX90wKzlsgwEEAUHFx2Xh7hpwn5gAEw5x8rFEhmA20w2Qy4undAafemtkx3MzX52ZU/mogRpC7qkUHmZhPepPBbG0O0w6/Ci1pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 09:37:09 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 09:37:09 +0000
Message-ID: <acae92d8-3394-436c-be8e-8bed7a923e85@nvidia.com>
Date: Mon, 1 Dec 2025 15:06:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] arm64: dts: nvidia: Add nodes for CMDQV
To: Jon Hunter <jonathanh@nvidia.com>, will@kernel.org, robin.murphy@arm.com,
 joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nicolinc@nvidia.com
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, jgg@ziepe.ca,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20251125071659.3048659-1-amhetre@nvidia.com>
 <20251125071659.3048659-4-amhetre@nvidia.com>
 <dff3a962-82dd-4aac-ae11-69f0e95ba04d@nvidia.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <dff3a962-82dd-4aac-ae11-69f0e95ba04d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0121.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::8) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|BY5PR12MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: 169d8576-5b23-493a-5cc4-08de30bd329c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmVEUktLNlEvY3doMUF6Z3U0TVB2UEVmdXc2UFd3bjNNY3VDVXVES2ViQ2Ez?=
 =?utf-8?B?a0RGV1lXMWlQbVhwdnBKUDJjR012UURVL3IvZUxrbjh2bnVZNkgyZWgxRStK?=
 =?utf-8?B?SU44dWljMHljQ2RPbU1pdk80NTgzOXBLcmN1dmlMaHRyaWhKYzc3b2QzTHNN?=
 =?utf-8?B?aStEbE5mYWFsRjR3OXRsWXZLM2tlOTk2WFU0cjA5K29TTS9Wd29mamdwWlBH?=
 =?utf-8?B?SEtvRGcrVUM1QzRQQjZZRmtqUjc0dEd3S1VjdTV2TndCZXRqaU95N21WZVNa?=
 =?utf-8?B?cEJSTGRDVzRGK2V4TkdUbUUxenpNd3J3Tjl0Sk9GaStOYzhNNUpMWEZ6NzNr?=
 =?utf-8?B?N2p2aEV5OE9rZVM4RHNqQWU2VmVKbzV4Z1QzYW9ISFpxRENaamNZR0VSa01s?=
 =?utf-8?B?SWVFNkhJakZBK3lhcDkzaG5JMXVINytCSVFoS01jdTJ1S1dlajNSWDlCUTJ4?=
 =?utf-8?B?QkJteFVBaTZLMGJhcmZhRnB4ZVBIUVorakdBbGl0d2Z0OEcreDdaUjJsSFA4?=
 =?utf-8?B?VVcvdEM1c05iZUJVTXhBSHdtVnFtWHpBdmVtZ1ExZ2xTOC9iaDR0cFg0QWZo?=
 =?utf-8?B?WVBtYjV4L3hab2RMbjdGSWhYS25EMFlsRmR1eE4rcU5aanNtRGtpK0RyNVdD?=
 =?utf-8?B?MTZlS2xDcldSN2g2NWZNa0VOYStJUGozUFZJRlRReUNUV1Zzc1FzRlFXWHk5?=
 =?utf-8?B?Yy9CNUdRaWk1c2Q2aDQ2S0djSUZNYXRsRk50dkhjTjZyWVlYWlhXTjRtaEY5?=
 =?utf-8?B?N2dWZ3FxMXRDSGFGbUxZUjRiY0ZDM1VxOWw5SFpZeUpiWUgxWUtjM0JtU2Va?=
 =?utf-8?B?ODdwYzhvaXJId0QrL2NRSCtGbEtJNmxiMHpnSncxM0VBaHppZTAwWlREV0E5?=
 =?utf-8?B?Qlp3bEdXa09MaGo4VWpDeEgvSVJ5NDJMU1Jzd1NVdkR5MUl2M2tES2xXdjMx?=
 =?utf-8?B?OXJ6eXV2U2tYTVYzQXZXQ2tzcTJBd3I2dVBjQS9iVFdwVzRBOVZOTnMwbm5v?=
 =?utf-8?B?Tk90VTdyMzFpaHBFY01rVmlzOHJDYXFkRG9ObXRMR01aM2xteE4wZWNHUDZk?=
 =?utf-8?B?MW9zVlFpeGh3OENiRFEyTmM5dnVBWVZkeUJmM0NUT1o2dkNxRCthNjByYVA0?=
 =?utf-8?B?N0d4a29QVFFwK1pMTUgrSW51LzgyMFVWdUF6OTV0Q1ZKd3JZTE5CcmZ4TGxl?=
 =?utf-8?B?eDQ4SUN3M1dEc3hMcVJINFppb2pMMW81WHZIWFlYTERGcHRyVUlkQm5HQUkz?=
 =?utf-8?B?MTFJak1zcWlmOFFWQzltdi9Mc0lZZDN4K3drdGZmTEFyNFhZRjRkcUkrOVVu?=
 =?utf-8?B?emJJM3BZSURpTk5GN1IrY3JIbHIvY2JSRHBkMjMwWlptNVRCSE0vWHYvTG1D?=
 =?utf-8?B?UUEyNzFBWDhvU2MzSjRldElNZy9Pb3ZHMGgvazVWRG5mdHNEZzJLR2dPQ0dG?=
 =?utf-8?B?S0dzNHA4b1o2OFltUGoxVW04RkFIR2xYWk5NcHVBV25wRFlsVzdMQzRlUXI0?=
 =?utf-8?B?NjBnb3hRdTRCNzJ0UmtDWnpyTnY3aUJ5ajNKTHZsSmoyNkZEUEszaGtIRXVZ?=
 =?utf-8?B?azdWbUljZFBmQlJRMEdUZ2xZcjRHRUt1WWtQeVpzcFhnYktROTJHWVJxWFVo?=
 =?utf-8?B?bzJHTmhaV1F1UmI2dmcvYjNQN3BaRks3bktaL0cxSkZ3TzBDYkVTVk9idHF4?=
 =?utf-8?B?UVJWWEd4ejB3ZWNRVEpHWGs3S1d5RXpyWFA2bStkNE1IdkJhclJLOFIvZ0VQ?=
 =?utf-8?B?UEx2WXkraHIwSjRjN05lVmNQR1JXdnJNUS9sWW1Bb0FpbjdVSy9IaHRnTDJ5?=
 =?utf-8?B?Qnoxc1A5TWw4VEpTeUtBY2k3ZFAyb1NWZzRPY0RCWVVJbHZTSlNpM0lVNzgw?=
 =?utf-8?B?MlhuT3ZpUnlDU1U0eklWa25vb3RxcWRUZlVWYktOOHhpODBKUjZvTk81SWo5?=
 =?utf-8?Q?/1wbTbUAiBe7VgkmY6FRc0u6dvg5U/Xb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bE1WRFQwNVVmajg3SWhFQ283RjRCRVVXd1JmaitHeHRtNHVQSkhUdDVkZXZC?=
 =?utf-8?B?S3hwRk5nRkZoS2FYYTRDRzU3UGFONDNZdkY5d1NPQzY2UkhtSXRWTFNCamtv?=
 =?utf-8?B?b1hUZXE0T3RNTjJ3WHV1b3p1c1lSK3dFTDdKUXlDa3B4MkROeEtKVlQvR1k0?=
 =?utf-8?B?akwwYzdlS2RuT1RJbGFXUEszQi96NHRKb3BUVU0wT1pqYkhKK1hDWVdKQTRo?=
 =?utf-8?B?dlZzV1RIOE9QVno3VjB2c1ZCVmo2Z05wMW93RlBPK0ljMjRWcDZSdDhSNFFk?=
 =?utf-8?B?UkdRVkN3N3Bpa3VUbmt0SUdIR25aUXh5NE5YazdiMXViWVo0NjlXSUlrZXFT?=
 =?utf-8?B?RUJhQnhzUTJsbGN5Ui9DSkFQNUhhN0VSY3lHOUJwQUVKMGpvMFFXbldBWXdp?=
 =?utf-8?B?N2VhS2tvNXhyVGxxTmRNbWEzcmJTWXlBb01CWWl6QTZQWk1lVkJleFJvcmdo?=
 =?utf-8?B?Q3p0K2hOT1lBcDVjZ21jY0J0eTZ2amRCQVFIbEhOTTNjQWQ1ZVlURHc3Rk9Y?=
 =?utf-8?B?aUNkTTZlMnRNOGlrQXNRU1QwVE9HSUlzQWxxUjdBWEc2Ky9wOWdodFhYeUha?=
 =?utf-8?B?cXBFeEFTUjUzS0lXYlJTcWE4WnB1MlVXb00wcXVmMkxNRTR2dHdsU0hoeXNH?=
 =?utf-8?B?eTNmbWZ4c284Y3ZlbmZEZlFBSkRQcDNiZThVTGRJYlJuUlIrY3lrbnQrUnh5?=
 =?utf-8?B?dy8zd1RWQndPd0JNbWVoWkx5bTV0di9PMS9pNnpiaU9qQ3FYelc5TEplTkNH?=
 =?utf-8?B?TXVuOFpNTUorZjhZSkdkTjlOWDR5ekhHczVDYnBuT09lcGlrR3dnZ1NYZmdZ?=
 =?utf-8?B?NzNRcXhnMitGWFVScWN4aFJvcWFhNzB4d2ZmWmF5bDBSQ0xWdnRZRkhYVWlS?=
 =?utf-8?B?R3IyQ3U4NWE2Y09rVzZQL0E3U1NLck92bS9RY1NTMk9UWFhNKy9ySHBWRTNj?=
 =?utf-8?B?TUlMc1dLdmgyNmdHN1piVlhvek95K29UTFUrUG1ST2J4RjRaMm91LzNweWI5?=
 =?utf-8?B?RWFGd0RMN29EREZlYWxnYThIRTZSTUx4Qk5nY3hQL3J4a3FydDJ3S2k1NFEy?=
 =?utf-8?B?VWhiRW9VYk9KTzl6SnVKRG9UZ2J2ZGZzUkY2NXVtNm1xNzA5NlZxMjE3UXlH?=
 =?utf-8?B?TzF6eFh1TWtQUm54Mlh0ZFVtdHBZRUk3b2JvQ2hlVTBOVDRXNXBHODVialRr?=
 =?utf-8?B?NjNJb3RwYkgwaWdFcU1tVHJkWXluZ3N3ZzIzbFAwQ2p1UDVUTm1heHNWR3hp?=
 =?utf-8?B?c2tVZXI5QmhQZ25nY2hQZVlyc2hZeXBhVkRqZklpMEVyNG9zdTJLZW9HbDdX?=
 =?utf-8?B?bWNuUkVNL0F5cnY4SjFycEJDQURlQ1QvdXRPMVlvUXVZSTlRd3NKb0ZTZXlz?=
 =?utf-8?B?eTI2ZGFFMWN3ckV4M1hucEcxQUJtZVNqdzFDVXhDa2I2QkN5TjhTTzZoRHBt?=
 =?utf-8?B?UkpQYVdaOWhCSGRFUFlTdTFudWgrMUc2anFmeGlmNUFEQVV3QU96NjdOaHlJ?=
 =?utf-8?B?M3hCYUdFalB6c0VtRnpXeUN6ZllzK250bGdramIyNCt3K0Z4Uy9QTTg1Nk9Z?=
 =?utf-8?B?MDRFQUtNaGlxYkUyQktqVnJIWGdRV0dMa1pDL3ZudXB5V2VEOE1IRVBUWm5I?=
 =?utf-8?B?WmpIUXpMOXBMaUVDYWtPRUZnSXhoaUVncGpIditJNmNwOHk3aGdnL28rK1Yy?=
 =?utf-8?B?QnA4L04vZjBUeXFwZGtnSzBuT0U5ZGNGZ0VOaHZmZmlyNXJRc1pMeVVsYXFx?=
 =?utf-8?B?M0JTZjJjbjdDK1liNnhnZklYYnJwVWs5dGFoS1hlUENQaytTVzNNeSthendN?=
 =?utf-8?B?RlRhdTYybDgxd3Q5ZTdMaFRHUm9uWFp1dG5ybEVkNXBqbk5tOCt3VWhwVEo0?=
 =?utf-8?B?azMzWUhhUCt6WFlNZUM3V2JCUlk3eTN4OW5hbXlZK0VTWHk5WFRQQ0ZTU0xU?=
 =?utf-8?B?WHpSYlB4NUY4bDNiclNUMFJwMmI5MVkrODc0MWwxYWt6Q05TT2s0czR6cm5t?=
 =?utf-8?B?bzA5bFhyMjh3ekFXUHBiQVFIUGZIdDZ3TUJhcWRrM3RVcHQzM2JQY3JpL3pi?=
 =?utf-8?B?MTJmTVFOS0pXUXJUNkE0Yk4yVmplTWdwa1dFMWVWWFJaZEFvMTBBWmRtS05J?=
 =?utf-8?Q?14o9L2cNoS6J0hN9uv1r7Ntjq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169d8576-5b23-493a-5cc4-08de30bd329c
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 09:37:09.2132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zMJS8RzPz/n34Yvf2ORSPNccGhwwjenujY2mT0vOOBAenLfV3wEPTn0263BWBfjVWVNTcTIY9JHGiSAy5UcDoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116


On 11/25/2025 3:52 PM, Jon Hunter wrote:
>
>
> On 25/11/2025 07:16, Ashish Mhetre wrote:
>> The Command Queue Virtualization (CMDQV) hardware is part of the
>> SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
>> virtualizing the command queue for the SMMU.
>>
>> Update SMMU compatible strings to use nvidia,tegra264-smmu to enable
>> CMDQV support. Add device tree nodes for the CMDQV hardware and enable
>> them on the tegra264-p3834 platform where SMMUs are enabled. Each SMMU
>> instance is paired with its corresponding CMDQV instance via the
>> nvidia,cmdqv property.
>>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>>   .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |  8 +++
>>   arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 55 +++++++++++++++++--
>>   2 files changed, 58 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi 
>> b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
>> index 06795c82427a..375d122b92fa 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
>> @@ -26,5 +26,13 @@ iommu@5000000 {
>>           iommu@6000000 {
>>               status = "okay";
>>           };
>> +
>> +        cmdqv@5200000 {
>> +            status = "okay";
>> +        };
>
> This needs to be ordered in the file according to its address.

Hi Jon, Thanks for the review.
cmdqv nodes follow same ordering as its corresponding iommu nodes.
I have added them immediately after corresponding iommu nodes.
Can you please check and see if it's fine? Same applies to your
similar comments below as well.

>
>> +
>> +        cmdqv@6200000 {
>> +            status = "okay";
>> +        };
>>       };
>>   };
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi 
>> b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
>> index f137565da804..d8287b95221e 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
>> @@ -3361,7 +3361,7 @@ bus@8100000000 {
>>                <0x02 0x00000000 0xd0 0x00000000 0x08 0x80000000>; /* 
>> ECAM, prefetchable memory, I/O */
>>             smmu1: iommu@5000000 {
>> -            compatible = "arm,smmu-v3";
>> +            compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
>>               reg = <0x00 0x5000000 0x0 0x200000>;
>>               interrupts = <GIC_SPI 12 IRQ_TYPE_EDGE_RISING>,
>>                        <GIC_SPI 13 IRQ_TYPE_EDGE_RISING>;
>> @@ -3370,10 +3370,11 @@ smmu1: iommu@5000000 {
>>                 #iommu-cells = <1>;
>>               dma-coherent;
>> +            nvidia,cmdqv = <&cmdqv1>;
>>           };
>>             smmu2: iommu@6000000 {
>> -            compatible = "arm,smmu-v3";
>> +            compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
>>               reg = <0x00 0x6000000 0x0 0x200000>;
>>               interrupts = <GIC_SPI 1 IRQ_TYPE_EDGE_RISING>,
>>                        <GIC_SPI 2 IRQ_TYPE_EDGE_RISING>;
>> @@ -3382,6 +3383,23 @@ smmu2: iommu@6000000 {
>>                 #iommu-cells = <1>;
>>               dma-coherent;
>> +            nvidia,cmdqv = <&cmdqv2>;
>> +        };
>> +
>> +        cmdqv1: cmdqv@5200000 {
>
> Same here. Please order according to the address.
>
>> +            compatible = "nvidia,tegra264-cmdqv";
>> +            status = "disabled";
>> +
>> +            reg = <0x00 0x5200000 0x0 0x830000>;
>> +            interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
>> +        };
>> +
>> +        cmdqv2: cmdqv@6200000 {
>> +            compatible = "nvidia,tegra264-cmdqv";
>> +            status = "disabled";
>> +
>> +            reg = <0x00 0x6200000 0x0 0x830000>;
>> +            interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
>>           };
>>             mc: memory-controller@8020000 {
>> @@ -3437,7 +3455,7 @@ emc: external-memory-controller@8800000 {
>>           };
>>             smmu0: iommu@a000000 {
>> -            compatible = "arm,smmu-v3";
>> +            compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
>>               reg = <0x00 0xa000000 0x0 0x200000>;
>>               interrupts = <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>,
>>                        <GIC_SPI 22 IRQ_TYPE_EDGE_RISING>;
>> @@ -3446,10 +3464,11 @@ smmu0: iommu@a000000 {
>>                 #iommu-cells = <1>;
>>               dma-coherent;
>> +            nvidia,cmdqv = <&cmdqv0>;
>>           };
>>             smmu4: iommu@b000000 {
>> -            compatible = "arm,smmu-v3";
>> +            compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
>>               reg = <0x00 0xb000000 0x0 0x200000>;
>>               interrupts = <GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
>>                        <GIC_SPI 31 IRQ_TYPE_EDGE_RISING>;
>> @@ -3458,6 +3477,23 @@ smmu4: iommu@b000000 {
>>                 #iommu-cells = <1>;
>>               dma-coherent;
>> +            nvidia,cmdqv = <&cmdqv4>;
>> +        };
>> +
>> +        cmdqv0: cmdqv@a200000 {
>
> And here.
>
>> +            compatible = "nvidia,tegra264-cmdqv";
>> +            status = "disabled";
>> +
>> +            reg = <0x00 0xa200000 0x0 0x830000>;
>> +            interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
>> +        };
>> +
>> +        cmdqv4: cmdqv@b200000 {
>> +            compatible = "nvidia,tegra264-cmdqv";
>> +            status = "disabled";
>> +
>> +            reg = <0x00 0xb200000 0x0 0x830000>;
>> +            interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>>           };
>>             i2c14: i2c@c410000 {
>> @@ -3690,7 +3726,7 @@ bus@8800000000 {
>>           ranges = <0x00 0x00000000 0x88 0x00000000 0x01 0x00000000>;
>>             smmu3: iommu@6000000 {
>> -            compatible = "arm,smmu-v3";
>> +            compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
>>               reg = <0x00 0x6000000 0x0 0x200000>;
>>               interrupts = <GIC_SPI 225 IRQ_TYPE_EDGE_RISING>,
>>                        <GIC_SPI 226 IRQ_TYPE_EDGE_RISING>;
>> @@ -3699,6 +3735,15 @@ smmu3: iommu@6000000 {
>>                 #iommu-cells = <1>;
>>               dma-coherent;
>> +            nvidia,cmdqv = <&cmdqv3>;
>> +        };
>> +
>> +        cmdqv3: cmdqv@6200000 {
>> +            compatible = "nvidia,tegra264-cmdqv";
>> +            status = "disabled";
>> +
>> +            reg = <0x00 0x6200000 0x0 0x830000>;
>> +            interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
>>           };
>>             hda@90b0000 {
>
