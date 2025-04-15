Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C20129A78
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 23:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744761008; cv=fail; b=tG6aX7hvdwU1u1Qw5XX4Jgo4gg0VnKF3zeQ0t4AcUvExj44CtOtSl879z03ab5Aj3dayJGxFMkIY/kIvhRAyEUJS321S17aXcDJqnMKXhp3K/74YFMFNWWxNaFk4gVYH2/t3CEZCNbZatIk+GVx0V42bGVjXk+5wi7XtuN9NSz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744761008; c=relaxed/simple;
	bh=qAlczySTw6e/G9YCHjoc1N5NpJ1oMAiDeKjvKXZ8NSA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iWcUQqgI/MFdHYXbofltnq9iFUmQNvVIfu35P4F3vxIXA+seF0j4iTWvALBzLpNw/Cf196LbvC3W3jvrXOAKwIIxXUA0R6pgZDhkdVJAqpdB6y9kZpDewjZfsxVV6TqWwh9e2zeBX+uG1iJaRmVzy0MqrUzJA2UeifgltiTPghU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mN/1dVP1; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mN/1dVP1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgqMXYBhFp77kmbbSlsVZ7XI41Yif3kGCBm6+EDZKpmZIHzw9cMjgKOHW8+boh90x2JTvaWDPK/JdkcGN6qwVGi09sWA25pPMYN/MsSVdlu2gru6oayMztRCdk/ap6uR5gNeC1TraU+I+smiyT0GlCb+VteL6ZqVjQXRhtEt5yOmC8gDKWftCYApDp0yOkeXLehvwCSnYEZk7sk/zeXLNh6b2ZRDipZWSvmxfUtHflNKEX412y2g8W4TCXcazXL/KjnT8gm5V4DEKlVKijupACrcjlpk9lq+1SVehzeIQftBSggHVs/4GVqiFLi9X6f+4sfCSPWQTiaoUrN09h0mqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZB9Irl54gpGqlDbOzbQ6LqcdinruOKvCPkw/VOxmZyo=;
 b=ta8/8XvDl37V80759nE79fXgFx4XZGBDn8XA+CJ3bSt2HEhjVWBQZPaZhZdATcwDKjnNwNyS6+potlreGKUo0zTLcLP4TK92zywvy6Nff8gtgw5KA9IeuOiZBpT/TuI3hWjQTiMjXwA5qWolL2t3zQowokIgeq70UiHmYlO64QCUIioTgF7Gg/B3zITgwLmrpeJJwop72phcb5aF+06XKGstgocDPdk+yo4oU8TBrIqbLbZovnwLZyLqs71glFWcvYHqOwt5CCxXGj0Oyxr8Z1dm7HhzKi+2WWOHtIGWfMWaj24ffwyUZJMXWjtA8vZQTBFKpCwSf6yUssjZzgPDCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZB9Irl54gpGqlDbOzbQ6LqcdinruOKvCPkw/VOxmZyo=;
 b=mN/1dVP1UXoSjF39MC1CLo9ChqyEYnbKs5NHq9hh5yrr0T7yVjEUAShvAx7hkN4cG3g5kNnI/xqUsG+NFicMzuAMYhRbL4AJvTR8X+CFmoFWtuPEzd3QV55U3X+so15SIZCzH7/INYQ+BVqH59LEYm4Wgjq/9RA/7z8rZbxKc3HrMfkrF29rJtGRGsffzHeqKUVAhGDLebTkKTfK+Cd2mEIJQQQ/DQv/UQFrtRQr/UXMb5G7WzLpPiPh3moBaYjhU5ZjWYkTnJRJzmjTPuUO8Vk5LV2Pis2FLDcLsjeh726JL29h4HlcgfEE/k9am1ajM9KFCQzMysyfiVkfEGY3BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by CH1PPFF9270C127.namprd12.prod.outlook.com (2603:10b6:61f:fc00::62b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 23:50:03 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%6]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 23:50:02 +0000
Message-ID: <90788e4d-e92f-4b32-9103-f4c528bec026@nvidia.com>
Date: Wed, 16 Apr 2025 09:49:58 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix pgsize_bit for sva domains
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
References: <20250412002354.3071449-1-balbirs@nvidia.com>
 <20250415131053.GB517881@nvidia.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20250415131053.GB517881@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0161.namprd05.prod.outlook.com
 (2603:10b6:a03:339::16) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|CH1PPFF9270C127:EE_
X-MS-Office365-Filtering-Correlation-Id: c3ab9955-959a-4386-ec13-08dd7c783d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zm1PbHI4ZVA1RGFpK0Y2Y0FFRk5qcVZnR3NnTFZvcEZ4ZjdBOU9pOGFaTHA4?=
 =?utf-8?B?bElRdVlNZXR6MUFjOTZpckthRk44aWduMGZuajMwMW9IcW4vMXJ3WTJyN1Yy?=
 =?utf-8?B?MmVDV2FnSkdqcTZaRzNBNUo0Y3pwTldiS3FiUWwyN0F1cjlvVCtxOS9MbVU4?=
 =?utf-8?B?djVhYmFFckhqRGJnVVYrdTdMbi9iZDBsRVZDaGJablc4UlZ6TjRqNzhrQm5C?=
 =?utf-8?B?Z3oydXp2MFNVbWh3R3BYVExrcU9sZEN6bWlMWGpXdW9naitXNitmT0xUTUlE?=
 =?utf-8?B?ektSOXpXWjdLb3NFT1VxQ0ppM2NRMkEwakovYUcxclVUK2dwMVQzZ3QrWWFG?=
 =?utf-8?B?MEZ0NjMySjdDRm1hOFFQOVJ4bGFzUVo1UjAwT2M0N2VNL3pXekxyZndrODB5?=
 =?utf-8?B?dlpHWG92UDNnQTlIc3VNVmNHK0lTUTFkSWdaWklWd2h2N2V6S0cvMy9mQjYv?=
 =?utf-8?B?OFg0eXFxUmQ2akIyRFpLVHVSeXhnRlRCK24yT2dkZE1lbEtDSmdmT3d6YTkx?=
 =?utf-8?B?QTdDSmFYdWg5UlRiNGE3OW5QZHZMZ0YxUWtMTjhNR2NNMTcxWWoxZTgrUWpH?=
 =?utf-8?B?N09jMnhCR3h6TmdpUCtkdFFNVXMybUxWellZZmVYZmRIekRiaGtoYTFqcUk1?=
 =?utf-8?B?Qm5qMlZ5VHppZ2xFQU5IYVM2USs1WDFyL2xNY0JobjBxVzZmUktmZ1BLL1Nu?=
 =?utf-8?B?eUp4U3EwdjNjRFhPZEhQbFdxOTJ5NWxJanFpRzgzOFdPWlgyZmRmbktuN2lR?=
 =?utf-8?B?VEdCNUYxUTR2a3NZVU9saWRzVVI1b1VreW1YZkk3WEpReWJwUmhJbXV0Wk9j?=
 =?utf-8?B?alMwRG5TVFovRGN5a2ZGNjZnSWhtRnRrQTkwc0JyaWwyYnpTVWJ6ZktCNkRF?=
 =?utf-8?B?V1l0UnlQSVU2VGhCc0diNm9ZV3JucGtyR2Y3eWZFckZreExBUVFNV2pKNXpm?=
 =?utf-8?B?aVNqb2xsbzdtQ3owcUlQbklmWjhXYWxFVDlCQkhHcVJSMTdSZ3RuRDNHdlo5?=
 =?utf-8?B?UjZ3d1ZqZ2JHVjZGa1pkd2NSdmVsaGlJc2UxTnBIaThDNFBJeEZ6bkw1Ulp1?=
 =?utf-8?B?VkpSQkRaUUpuQmJGTkxSU1FMNEpYYzFVRE9DQzFMUEdvS3FnV0ZpbVdqdEpB?=
 =?utf-8?B?eDJZTCttRExzdEVsVGtxRk1EcWRJeGxuNWc0QnZxQmxwZ1RvN3NUbGxVVVJV?=
 =?utf-8?B?Snh1dFNLVHdnUm5IcWFrbnlLNXdSNjhBNytZTW1sTU5yNnZqUWdiTCtJUlNn?=
 =?utf-8?B?SjV2SWFFN0piQi9wSWRaNS9PZkpLWFY3ZndiQ2lIMGxtMkFremRTMGRwODJ4?=
 =?utf-8?B?WXZML3ppSUZSdVlSa1NOVk8yL3hNc0NtOXo4VVdFcjRZOFNoTlRSL1NFaFpM?=
 =?utf-8?B?RkF2MUVXTEhkZXc3SFMzMGx3VlVYMHYwWVhaaXJ0RUtQQ3FrWTRJRWRhdnlR?=
 =?utf-8?B?c2MvMlBjWHgyK1FvLytOV2RSTWg3Y2t6ZTVtekx0eWc1TFIwZnhmYkhxN2dX?=
 =?utf-8?B?Zk5kWHZKVGJETUlqREZTK1ZKN29kVzEyMXIrNksrNkVrNFBPZjJHb1BkU1Vp?=
 =?utf-8?B?YXR3eFBKamdQVHFwSnA4OFNoUHNyNjd0K3ZOM3lGVEZiV1FBdzZvUENFY0d4?=
 =?utf-8?B?bTBEOGhZcy9FRHZ6RXYvbmJnS3JTMnV2SUpFRjlNcE94bEUvS0Vib0F1RVc1?=
 =?utf-8?B?UUZDWUsrdGVpMHZkR2FoaE9lRkxER1FoRCs5b2JwYW1ITEt4U0RGOWM5ZHdh?=
 =?utf-8?B?bWhuQU1KNkdNeDJoeGFBcGt2YU82enlCR2Q2VWxGSDcwSVNSSjFBTjVFRG1B?=
 =?utf-8?B?TXhNdTVvNjZRQVMyUWNyZEMvNmRwNjNPL01RZTliajh0enlOVUF4WlZZeG1V?=
 =?utf-8?B?OXZNaWtJZFMzME4yK2gvd3BRSUNOT3VxQzNDa0V4T1FOaS9iSnNQUmVyd2k4?=
 =?utf-8?Q?wSQhpBqJCZw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVJqK3hqSEFoemdMODZ4c0hWbFdBbWlWVnBlS0Fzand2Wkx2NHpVblVzVG91?=
 =?utf-8?B?M3c0NHhRY212MEdYaHp6cGlSUi8xQm1BN2dXbDQ4ZWt2cWI1eXJDak9KNkZz?=
 =?utf-8?B?RzRhOGszMlFnV0NjYkJvWXJaQy90T3ZoaUFpcFpVR0NMeG1vQ2ZMQk5IQ0Vt?=
 =?utf-8?B?dVVrQWtwN0dwRFJnb2xIc3Y5bENoaDZJSkVaWFBNTFZOR1F6K1NNQnhVQ00v?=
 =?utf-8?B?R2lwbC9VWng0Umxnd2w5SjM4WjdCVWl2RUE2RGgxcUNoUGc1VFZBN0YyTFlr?=
 =?utf-8?B?cS9aNTBOejBSTHNlOUJtZlptckR6aVBUZFB2NnBuc2hoclJIcjhvUE9wZjVT?=
 =?utf-8?B?aDVJa0ZwM24rUkhWZXA5bEVmQms0OWpONFpQZTNDS2o5L0QrUEJibGErblE5?=
 =?utf-8?B?d0FEOW8xWnBTYWJqbnVEZWYxREtJajNWcWlWb3RRcmxSWktzTm9Td0c2alNx?=
 =?utf-8?B?Q3hjdkpQZUZLcE5icVg4TkxydjZEZDhEZHdGOEQrWnZJS29yckdUcDBGaHpB?=
 =?utf-8?B?SERIZWVYeHZ4dy9mUWZJcFpBM082WXhoTFlpZy9IM1puMjc5ZERGYitUUnUz?=
 =?utf-8?B?YVRyd1dOblZJNTk3TTJqellmb3ArREhSWFNFUDZ6WHpTdDhBL29SdDZBMUpq?=
 =?utf-8?B?QW9rVldLUno1MW1wdWNUQW56TGhtRzhYUENJdlp3cmdiV0szUEJHQVBjMHF4?=
 =?utf-8?B?bzZZdjFwUVUvOER2a0ZSOThTTUZ3REJIQUx1aEY5bENNeEFQVElHd0hXbC8z?=
 =?utf-8?B?OHZIdk5rSy80Q252U3c0QWpZUjI3bUlqTGZMYXFMU0o5NFRWZERJUGVnSEk2?=
 =?utf-8?B?bk8xd2crM3loSmtveVBNTEtzTDlMWmZYUXo0Tit3ZThtOTZuMlI3WGx3WDA5?=
 =?utf-8?B?bk1TMFdqNUdaMzB3Z0tadHZkWHlNQkNBeU12a3NiQzRNclFjVElwZEVpaFM2?=
 =?utf-8?B?Z0lWWHlYRC9hOUR4NmtGVE9yOExJZE50R2dFNlRQaUxuOXkvWmlqZGMwSTQ4?=
 =?utf-8?B?bVhLZWFqSmZvOUpCV0NldkRUUkZSNkJCTnN2cW16TklnczNrd0JEMXJNOFNy?=
 =?utf-8?B?b28raVpTTWxuZlpTNnYydG1GR2hOc1B0RlQ0cU9nbXM5RVZuQ0dzVXZYZ3JG?=
 =?utf-8?B?WTRsSkVnSWxsVVVKUms4VUhuNzd2RzkxeWRZOVcvQmFOY205UDVhZkZGRjRp?=
 =?utf-8?B?K096ZkxiK1BFdklEZDE2dTIwR3J0dnJzZ0tFZzNDOHRSSlZnMHdjbVMyNUx5?=
 =?utf-8?B?bWs1TE9oQ1B4WEdlNEs5SmZCRU9iSEY2RTgzQjByYy9WZVdSU2pRMGliQTBu?=
 =?utf-8?B?L0NtZUxqMjF4OWZQQW5RZUJ1SUt6dU15V1o4T2hmSG84RXcxUHA0R01nLzND?=
 =?utf-8?B?QmpnTzNzUjF0SmpnYy9obVROQjJOajlXOWYxc3R4SlM0SEYyNUJldmljdzJl?=
 =?utf-8?B?a04rREdEcmZINXBaLzVRVWpEWmFXOElHaTQxaWhZR0x5b2JsTTZXZmVnaU5M?=
 =?utf-8?B?dDY4TmVMckxqOGFsb0FlL3VSakg0SStwNUNQaWRCa1lKVnBTRHVDWS8vZUQy?=
 =?utf-8?B?dnJCQjVVc1cwTWM4TUtUWVN4KzZFem5GQmhCSnQxaFRIVWozMThXY1hkUkZ4?=
 =?utf-8?B?bENSdDRud3QxcitkNHJyVVRhTnlSaHViaUFadStmYmxRUEp2NUh3d25VLytD?=
 =?utf-8?B?dDh2Uk9FYkYreEdBUWFGWU9ZamJIZ2FGbmtMRVN5REc3YU5zNExYN1VJdE1i?=
 =?utf-8?B?OHYzQksydnV2YmpJK0hTSWY3WXcwWDkxZEFkclpWZVpqcldQcUVDeXQvcXJS?=
 =?utf-8?B?bUNGc21NYjh2SDVOK1kwVGwxR3VlT3I0d3RsRFEycEYyejNXMUVLSFpnVGNv?=
 =?utf-8?B?bFFBYXg0NHI2WHQxODZuN3Z6cXpsTFZGcW1aSXhuYXBPZzl1TDF6V0Zpclg0?=
 =?utf-8?B?VHF6a2hxbGZwZDJFUmcxUTdGOTQ5MUJ6YlllcHVyak5nOS9BbDBZRzlJRk9L?=
 =?utf-8?B?cXljQ0hBNlJSc3JDeFZTNkNQZHBtN3B0MU0xZTdYcHkxVlR3akNDNUlySlhV?=
 =?utf-8?B?QWZGelJ3bFVLTHNXSUJkQ0xpQmxpb2dScnVWb2k0UGhKZ0sveitkbkx0MS83?=
 =?utf-8?Q?GsQp6eTtRg3Wxjw99QaYsNOmo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ab9955-959a-4386-ec13-08dd7c783d61
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 23:50:02.5568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AArKhJS1Z93pU1E7FVyv2a66J/64JmZwQkHS8y+l57nrX6c5Y+LdwwxXNgm6i/teGL53ulZEzr3mMDR8zjQ7Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFF9270C127

On 4/15/25 23:10, Jason Gunthorpe wrote:
> On Sat, Apr 12, 2025 at 10:23:54AM +1000, Balbir Singh wrote:
>> UBSan caught a bug with IOMMU SVA domains, where the reported exponent
>> value in __arm_smmu_tlb_inv_range() was >= 64.
>> __arm_smmu_tlb_inv_range() uses the domain's pgsize_bitmap to compute
>> the number of pages to invalidate and the invalidation range. Currently
>> arm_smmu_sva_domain_alloc() does not setup the iommu domain's
>> pgsize_bitmap. This leads to __ffs() on the value returning 64 and that
>> leads to undefined behaviour w.r.t. shift operations
>>
>> Fix this by initializing the iommu_domain's pgsize_bitmap to PAGE_SIZE.
>> Effectively the code needs to use the smallest page size for
>> invalidation
>>
>> Fixes: eb6c97647be2 ("iommu/arm-smmu-v3: Avoid constructing invalid range commands")
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>>
>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>>
>> ---
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> This should go to rc
> 

Thanks Jason! I was wondering if I should add a cc: stable, I think that it's
a simple enough fix to backport, but I would also like maintainer(s) inputs as well


Balbir Singh
