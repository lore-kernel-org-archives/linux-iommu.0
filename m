Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AED31EDA2C
	for <iommu@lists.linux.dev>; Wed, 17 Dec 2025 04:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765945533; cv=fail; b=I+tP+6GoCFhzY/dFXFHYt/jn4wcgc4qZ+qBO/T6cVgjdFFJuqh/KQsMWl8x/V0G8K5yTGpCD4e2IVMsgDn/wb65opqiJ4tygbAppjkdk2OF8W6EwVea9lTPAB05m0cZeZ55j0of4j21c09FIQqjWSHjbYtUQ3ZKOEBLYfeFx71g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765945533; c=relaxed/simple;
	bh=uOGb0uclIXI9TlOX4aJQ0SL21sVRxgc4YltsmvSsFkM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cr1da72y+5aiSe19Psw9yEojIpfJsId4T+1SrdO3WT5LWv67kEiaKIMcyMTm2ts0f74vMNAXILYbquoq37QwNd0JjtQWQAMZJB7NL8gU99x+vavRMlfyulcAN2PkARrjH8U3ecf9E1357HyNS4mASskXmT9qRy2GNrSWKGQzybA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qc1RVJC1; arc=fail smtp.client-ip=52.101.85.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qc1RVJC1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgPEZx/S18XKIEBti3arNS8YiQcB0tAiPqg1u3cq3l/i4DyI15mFYb5ewF2h7DTYYuNQUmZquXv7UnfNBkK+iTk5i3ELrUeqWhBm+TFU5Q5kVjB1/wjOXL42V3/NHT6n3ONHvsJ6SzPq7Gr+6pCHbsG1QHU0SEilzy83eA3Utx5dju5RjHMYBFQwWP/C+QXZZOSNNrx8EDwigOjee0kb1qRD/R/Js8YLqdZxeOPWTsAYpidOrVDfxkR07rbDt1CD6rMt4znFoPNRjr2w+KFG1UA0WPcHBRWBU+a+wZxj3h7Kh1cj7KVGV3w6ByAor4wsSt02+FqjlkOJZUnBCJ/lRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqlNACuEhmU9kxWm62cP44IZkQdXbPMzh9RuWtXFAEg=;
 b=KzktD5ff0XcXoZd+vlUQNaYN1n+x8meBiorW/Dz6sebJIcdipqKRbsiqbVBJ7VFCVnrX+UW3rxeSfWxcQsitwXPOfKZbhmRNlcpSAPrmkrfqeNWW6zpQL1wECy8/LgAIPPI7yoAXzefcEk6SHWzMM0pmMP2FiyP7UnIgsHi4u7QEdNNWUU3I8JrsbwXEeZRjWRGUx6G/7JrQ/i2FEPNkp7izhieNflceNHGTZqcPSjAGV66ydqkHv+mT3rEicbV1bJNiAVEyxxrjGWqLWMmSLa3/cCnHCPNZ33GhXQFY8eYrkyu3ZU89faJxdNX43CmJuLJoMv8Y9ZEUIYOJw+oLWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqlNACuEhmU9kxWm62cP44IZkQdXbPMzh9RuWtXFAEg=;
 b=qc1RVJC1WSOCCJDONtRqzlC7X9aigmub0rgOteewmHi6G0CVn6iPKEcD8z/WI1uB4d6cEeauX9Qf2JfThcfK1YknlP075r0Fq6wI0C4Ent9wgpIa3IV8oKHdXDHHHrUjyTk4z/dvI0W1QtIwQw6Lu2zo4YMAJdyvgKGKiCch/HQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Wed, 17 Dec
 2025 04:25:29 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%4]) with mapi id 15.20.9412.011; Wed, 17 Dec 2025
 04:25:29 +0000
Message-ID: <10029978-31bb-4ff2-891f-564b970a41b5@amd.com>
Date: Wed, 17 Dec 2025 15:24:54 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
To: Wei Wang <wei.w.wang@hotmail.com>, jgg@nvidia.com, kevin.tian@intel.com,
 alex@shazbot.org, joro@8bytes.org, thomas.lendacky@amd.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <SEZPR01MB4399D06A044791DEA8BE43CBDCAAA@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
 <SEZPR01MB4399DA27E304E8BFB3C667DEDCAAA@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <SEZPR01MB4399DA27E304E8BFB3C667DEDCAAA@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P300CA0046.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fe::8) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CH2PR12MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd45d49-4762-4473-1b32-08de3d244f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnJpSk1jbmZMTW5neFg2Q3RoOFpXTTQwOVRwZXh0MTNScWZxUU54TER2WWlP?=
 =?utf-8?B?SzBvaDJGSDhxZmhvRUxYSUQ0TjJzeXpLTEhWaWc1MmY2a0M2TlY4eFg4Skhz?=
 =?utf-8?B?SUwrd0RySkJjbFZHQ2JMTFp0YUZnTk40ZnFqOWpzUWN1NW8rdnd1VC9JUUxx?=
 =?utf-8?B?TTc2K2wwUDlkWXlDREIxZDJaRjJmQXVTVDZrYmVkYnlVTFhNL2FtT1ZpK05m?=
 =?utf-8?B?V3h6c2g4MG10UDdDSTh2TkloUVVSZlVaMnNIVWhwYVBsRDJwYXMyYzIwaG9U?=
 =?utf-8?B?d3NYalV5OTlVeWdXalYvbmRFbnV3aGVZeU56eVJTcDloWHhZZEY5VlRaenRB?=
 =?utf-8?B?YjVoWXhCMnovcmsxY2sxbXdtbzZxZlEzaC9uZi82dW1tNlJoUDFlVm9UenVi?=
 =?utf-8?B?QkRqNW5qSGkzY210NlMraEVsdVBZTkU0K25YQ2gzcVZXVkxaYnNTdVdZRlpU?=
 =?utf-8?B?Y3QzZzQ5NWRGWnI2SkM4Y0ROV3gxZVg3aGQ2eEhRNlYyclFwZlRaY0JkZmg5?=
 =?utf-8?B?b3pIL1JtSkpoTGQxelNRL3Z1MWtlV2ljeUhvNDJLTkRXRHZBcUJ2RjVoTkE2?=
 =?utf-8?B?TDhoNjNzWktvWmdiemFtZ3FtRkNRdHhmd3MyTUM5ZEM3aVN6STU4VjlmdWh2?=
 =?utf-8?B?UENCbk5rdVRDd3I5VFNKQWk2UzZiU3dmVEZ4SzNPQnp5M0puQllHUUlLKzhU?=
 =?utf-8?B?ZmFsdVhVVS9jZCtLY01UbnY0SW5EM00wSUxBdjd0akZyK3dDT1d5NlV6Q2Ns?=
 =?utf-8?B?RVZNek9DZUhrMmg0dE4zL1l5bjdRY1VFMnJiOVIxMGQ5UmlobWh5cmliVk5Z?=
 =?utf-8?B?aHRweUxJeS9PbzJpdFFXb05ValBSNXcyR1N3NHpzb1Y4MjljU3hjTWM5cVBT?=
 =?utf-8?B?S280ZER2M3VhTTFPcWdOU3JzdlBwY3lrNEdnOStWbkFTcDYvN3AyZzhCSFgv?=
 =?utf-8?B?ck1uMlN4VHRabzltUG5QZTZNZWVoam9WZ1JSbUtLcCtFQmVOeVJ6RFFUUFhE?=
 =?utf-8?B?S3JiTjlZaFhsWm1BMjVDTGRVNUc4TXNETHBDNUVWZ0VTeGd3eFlwcTU2MmtZ?=
 =?utf-8?B?TVo5bWwvd1NMRFA4cGZCVkpPZmptOEx2MlZpY01JcFJnQ05NWkZHVmtkMzVF?=
 =?utf-8?B?NVlRcmw2bzE4UUVtc3AwQnZ5VG5rRHd3cENzVkFYODhwbXdvbFlTNFpZdnV3?=
 =?utf-8?B?ajBWeTVIVDN6cVlWcHpxNGEwajlMbjFsRWg2Q0N0TDk0Q0pSYUNUZ0paS1Ru?=
 =?utf-8?B?c1B3S0g0a0VjMk4zR1Y4RCtxSHJzZ1NXSllYTW83Vm80dTNTRVhDMFE1RW1K?=
 =?utf-8?B?alBZR05wSGloc09KVzhPTUg5bmtPb1hTUW9GbElDZStKcmp1SU5hNk9UTWlu?=
 =?utf-8?B?VjJZVlBMVG83ZDFBaWdGeWdKL1AwVHBFeHFKTGVsd3pBcFdaWmxCYjZYRWMw?=
 =?utf-8?B?SXpiaXBNbWRucHFCelNFSWFhZ0I3TFIzTHdXTTFuTndaRWZMOXRpdE9rRWdo?=
 =?utf-8?B?TXQ2Uko1S1hSVkwrSUo3dmpZdjVGY0FZTUFmQjlNdXlFWnU0Sm9mVVB5Qytk?=
 =?utf-8?B?YWZ6TnlOcFdrU2dwU21nb0ppSE1KRDNJQmZzaFJGMEJmemNWcC9kT1Rhb1Jy?=
 =?utf-8?B?RkJobmtLLzN0em95VGUrU2NJbFVlS3ZoVk9HSEllcEdTcU9ERDJGcFdibUNK?=
 =?utf-8?B?aVZ6aGlVVk12bU0vZWN5eGw1ZG5MOUp5Ukd2M2l6ODNhL3N3QWxQdThPMDJn?=
 =?utf-8?B?ODNLQWxJNllaVjRFNkI2MWxvU1R0aDdmS2VRZ0dEdXRUblpFOThzcFQ1WHJ6?=
 =?utf-8?B?QnArNmNKd3VHQStCdXFiK3hCaTNXZ1FvMytCSVVHb1A3enhFUnplTENMNU9a?=
 =?utf-8?B?VzlPRXRyazdKN2k3SGozdG9iR3ljS2E0c2Y2SEN6K2w1NExZdmtJS3J2bkc5?=
 =?utf-8?Q?+ahIMIK1MkItTsRq/InKXHEBjlPOz3eX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXo1U3k5bFo5a2RJeGJGckdad3AzbHBtcDVWbFZDZytzK2ZCUjgyWXNaaXlQ?=
 =?utf-8?B?a0hQOW91enBWMlR3NjRZSEN1TkUyWTRvRzY0eXN3ajhvOHFRRmorbHM3SzVK?=
 =?utf-8?B?UitsNVAxWkFsZTlVT2QvNkRRbHNHcFg3T3Z2VWpFVlN1ZXNtTjBRbzMxZG4x?=
 =?utf-8?B?dXJPUEFnZytTSnpreUlpKy9pSnVrQ2RwL2xiVVExZ0FBTGhNZDgyMjJHMUMw?=
 =?utf-8?B?eGdzK04wdFFVcW9mRkNKR2lBYUxTM0hUaG9TcW45bllYd0hNbSt0Y2kydndz?=
 =?utf-8?B?WjVDNmRhTExwMkEyeHJIOXIzdWo4TElGUlFPV21ManJ5NW90NzluS3JweXR6?=
 =?utf-8?B?VXVobEhpTFNIQTFZOTgyQ1owaWVjZG95MjU5WDkvTFB4RlRmbVVMd2Y1YVpQ?=
 =?utf-8?B?bWR6cHZNOVo4dmJzeGVkVTZMV2dNM3dPcDdwQnk2SFc1MnpIRTRmejZOWllM?=
 =?utf-8?B?enN4ZTRsd2VBMXpwbUNqWlltbjdVc3Nhc21jeW5kUFVDMklTUU5uQkhpUDE0?=
 =?utf-8?B?dDNLNjhWWTFSUURXNzhpUlZGZDBEOWpSaGFncHFpVkZWR3dZZVZWK3duckxk?=
 =?utf-8?B?MVVhZmQ3Si9ZR0RGR0hHRkxrYVVEQzJVNVhnNndCLzFZV3A4VkZSdUlXNXR4?=
 =?utf-8?B?cWZDc1h2b0xPOTg3elBheDF5NXJuZDV4dTUyYmNFcFlyRDhIaUg2Tk1wZjZ6?=
 =?utf-8?B?Q1ZKZFlQY04rR2J2SW1JQkltYm04b0pvKzBwejNvVUtZUjNqVkZ1ZE5IdmVa?=
 =?utf-8?B?SjBXZ0Z0bGZFTmU0TzJCT1dsY3NBYzQwQTByMjA3VFZJNUhYNXhqOFJnc28w?=
 =?utf-8?B?SVRtMnBKclRnZjNtNVVFM3N4Z1JOR2NVeVAyMHpob2ZwU2R2RXI1TFhhWGlT?=
 =?utf-8?B?cytrSi9uajdMZ2Rwb2QyYjhkeTlnZUFMY2lKTWppN0xIMFNtN0pNM1lNL2J4?=
 =?utf-8?B?YVZwd2xqV3dJaG1na1NaME0vQkNkNEdZbFhDMGcwQnVSYlFBQnJYRDJITlZq?=
 =?utf-8?B?NWozWEFac011QS9sUmpZVWhrRVkrdjgvVXFSbW5zVEk0Q3ZTVmord0dMRE5D?=
 =?utf-8?B?cURIT2c2dTdZMEs0V2VHVGhpNm1nckhoME9MbjVNRGg0bHVLdWIrSmthVEFj?=
 =?utf-8?B?QjFYVG5HaFhQOTFFVDVIVXdvUDgxcHRvZzR3UkpTdmFncnErVWNUaEdHaExC?=
 =?utf-8?B?RDZ6S2lpZnVGc0IzbDJVRTMrQ2pSTVloaHVLK0NQY2ZQUjJsdURrZ3pRd3Nk?=
 =?utf-8?B?RkVsWVlWL0dWaDNCTm82VHB3enlLTzF2ZjhwWlFoRXlNdDBrbkVnb0lUSVFy?=
 =?utf-8?B?OHZhMThRejk0NUtBd0NkbEdsNWhzbnUwekNsU3JpOEI5aVVndE8yTGw0U1lu?=
 =?utf-8?B?ZGg2RnhMa0h0WXJJT1JibkJ0TkJaeERkMVJ1WEJNVHMrd2ZUYzdXYWhuQXc3?=
 =?utf-8?B?MGFXbXNXazRvWmFoMUF6QThnNENadnBrMkJUMllEam8vTmR0L0ZPQVR4Tm04?=
 =?utf-8?B?QUJ3c2NOVDRWR2NlVWpUbWIrRFZIMmMrcVEwakFtckNHUVlaZWJuTmV1SDE4?=
 =?utf-8?B?K0haaE9wUVB4a0N2eXNtVWtYN0Yxbk9LWE1nTmJtZkV4dUgyblR3d2cwSll4?=
 =?utf-8?B?bmw0dWpCTk5UODNSS1NLbkpQL1E0UFRRaXV5NHAvZG1MeTk3THdrRzJ2eUVz?=
 =?utf-8?B?aG1HQVo5WVdaRzQ0RDFNUHBvdmVvNjFKWGpNUExxU2Mrd1doOFFCQVNWUzZv?=
 =?utf-8?B?WHVOc0phZEpUVlNoRkpPV0YxTGJ3dkhyU0dUMnFnOGNzWFlvMDFKdDJqdzM1?=
 =?utf-8?B?L1dKaktjSnpJRFpJWVEvWks0Y0V0ekpndXlwQUVjd21VNTZUOUwvWEVhQ29Y?=
 =?utf-8?B?SHo1dVhFMFlPNkw4YlhkY0xKQmczclVrdzZEWjcwcm43NUtsb2xPakVaYlN4?=
 =?utf-8?B?cVZ4RXNKMWV1OUlvVkE5YnhVaENnSm5mM05uanlJRERxOFZUVk9UK0ZndkxM?=
 =?utf-8?B?UUN3VGhEbVR0Z1UraXJORlFlaWl4TTgyWFo4Ny9ETzRLYjRVTFhQTHp5QTlp?=
 =?utf-8?B?RlR2N3kyQXFZK3ZDYVV3OE1qY0VYaDBMVURCTGFDZUl3dEZJaWNBQ21NbXlM?=
 =?utf-8?Q?KLOinc5kw8TrirLpQePGKopT5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd45d49-4762-4473-1b32-08de3d244f17
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 04:25:29.2051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uiCyYsFsLW8W2WznTpbKvGvjHvxuAbidCHAkJ3PLVOLFQKtKWOtsMHs1UCGYPkMez3Bg8y3VcmLm/N8ud2JYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120



On 17/12/25 03:13, Wei Wang wrote:
> Before requesting the IOMMU driver to map an IOVA to a physical address,
> set the IOMMU_MMIO flag in dma->prot when the physical address corresponds
> to MMIO. This allows the IOMMU driver to handle MMIO mappings specially.
> For example, on AMD CPUs with SME enabled, the IOMMU driver avoids setting
> the C-bit if iommu_map() is called with IOMMU_MMIO set in prot. This
> prevents issues with PCIe P2P communication when IOVA is used.
> 
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>   drivers/vfio/vfio_iommu_type1.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 5167bec14e36..dfe53da53b80 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -583,7 +583,7 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
>    * returned initial pfn are provided; subsequent pfns are contiguous.
>    */
>   static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
> -			   unsigned long npages, int prot, unsigned long *pfn,
> +			   unsigned long npages, int *prot, unsigned long *pfn,
>   			   struct vfio_batch *batch)
>   {
>   	unsigned long pin_pages = min_t(unsigned long, npages, batch->capacity);
> @@ -591,7 +591,7 @@ static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
>   	unsigned int flags = 0;
>   	long ret;
>   
> -	if (prot & IOMMU_WRITE)
> +	if (*prot & IOMMU_WRITE)
>   		flags |= FOLL_WRITE;
>   
>   	mmap_read_lock(mm);
> @@ -601,6 +601,7 @@ static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
>   		*pfn = page_to_pfn(batch->pages[0]);
>   		batch->size = ret;
>   		batch->offset = 0;
> +		*prot &= ~IOMMU_MMIO;


Do you expect IOMMU_MMIO here, why?

Then, what if this vaddr_get_pfns() called with vaddr which is some RAM immediately followed by MMIO? The whole vfio_dma descriptor will get IOMMU_MMIO, hardly desirable (also quite unlikely though).

Thanks,


>   		goto done;
>   	} else if (!ret) {
>   		ret = -EFAULT;
> @@ -615,7 +616,7 @@ static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
>   		unsigned long addr_mask;
>   
>   		ret = follow_fault_pfn(vma, mm, vaddr, pfn, &addr_mask,
> -				       prot & IOMMU_WRITE);
> +				       *prot & IOMMU_WRITE);
>   		if (ret == -EAGAIN)
>   			goto retry;
>   
> @@ -623,6 +624,9 @@ static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
>   			if (is_invalid_reserved_pfn(*pfn)) {
>   				unsigned long epfn;
>   
> +				if (vma->vm_flags & VM_IO)
> +					*prot |= IOMMU_MMIO;
> +
>   				epfn = (*pfn | (~addr_mask >> PAGE_SHIFT)) + 1;
>   				ret = min_t(long, npages, epfn - *pfn);
>   			} else {
> @@ -709,7 +713,7 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
>   			cond_resched();
>   
>   			/* Empty batch, so refill it. */
> -			ret = vaddr_get_pfns(mm, vaddr, npage, dma->prot,
> +			ret = vaddr_get_pfns(mm, vaddr, npage, &dma->prot,
>   					     &pfn, batch);
>   			if (ret < 0)
>   				goto unpin_out;
> @@ -850,7 +854,7 @@ static int vfio_pin_page_external(struct vfio_dma *dma, unsigned long vaddr,
>   
>   	vfio_batch_init_single(&batch);
>   
> -	ret = vaddr_get_pfns(mm, vaddr, 1, dma->prot, pfn_base, &batch);
> +	ret = vaddr_get_pfns(mm, vaddr, 1, &dma->prot, pfn_base, &batch);
>   	if (ret != 1)
>   		goto out;
>   

-- 
Alexey

