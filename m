Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013080.outbound.protection.outlook.com [52.103.74.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A4B2D46D9
	for <iommu@lists.linux.dev>; Thu, 25 Dec 2025 04:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766637171; cv=fail; b=FzoggzEViUaXeOkqlgPHX7qv02Vw6cBcxb0YLBacbLKJOv5TBTD4zfIcGIKXg2J9XISBDgogBwZ/NIk1iFbUIvNJ8vk1uNK+a2t9VnlZFrkyTxkjdmcJwobdZ6HyYCEezw9ZuZu5h93Ny0D1Skq8RHhd7lj4CeYsJlpLdy6O7tI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766637171; c=relaxed/simple;
	bh=3ESNJPpnJzliz+c9dLE0CzUw2B2IUAjYvz1BR43Oz1A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G9E6aEZKxt8klW5b6mARG2BAlOsVdU/pd4JLH8Pe4OoHbUsPnVFaNQogGHAtTdUxpR7j4az6aYw+B0nzsJ4PF9QBfLGr6TOehRI+Tfm29NBskd+B+oaA77HAQGYIFQVG1Aj2tJyJpg4umE8NCVRlRidlgp1KqcFV6zDoEblVce8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ScTH1yeG; arc=fail smtp.client-ip=52.103.74.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ScTH1yeG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpHFbyB73sMErD5MUsCJEmDixSRwbRszDW+dnsVLXc09SeqnG6TggoRrAD8PMOluJIfhtpLSQ741Ad9Lty/tSsoHB88udIQ4lgJs8o+53brtFimDAEmKiiSbbyJBpw8fyQLKimuI5/MuIvI1NtHr2Goc1vzLnkRBzi1BybO7YjodE1w6XEVSRcWt9Mni6xCnwKvqLuW8JFi1u3MP6ty38FYoubsjDE96VvJlzZm/uFV+OQtoP6RJPprGN+b+RmlZzpP2qpdhdvYsXK+B9SMCQ5WvbJPDK6TsJWcDGn/ZTiBzCkFZTidEOwkNvahGBvJdSkHQQMggy8M/SmeNEZ71NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+MDjXybpSXgJ8uqWlFbICtuHh4W2w+Hyionyp5ApEo=;
 b=f3h2gasxtKsDV0KF4/+BQDX70Gsfd4vZH0NNvaw6yJx+lrQh/u8YfaHZcmmCPbWjwAOXUoNZ8hf2H5gJ/Pim4XmiO5eqXoQsZwU9J0ik+6mupebk8jg4WSyLfj1kXctzVFBxY+MuPfvZvPcFn/KOuGQ5bolTbVw9FsqnjFCMS8UMHxa7lcd6kVEvlQj7PvfK2YmpFCLayPkIWdKd5PB0ESGvOZipdqAWtGZ55xkSPn1mBLRScOYAKuitswqflfuKSNbLus1h6BL5ZsX4gYZUsWm3AE775O7kGcI77icYu3eeoWTe2TDZ6Y3JCJdMuYrbdeyZrAtbD6b51OMh4W2bfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+MDjXybpSXgJ8uqWlFbICtuHh4W2w+Hyionyp5ApEo=;
 b=ScTH1yeGXk3dis9oD48SiB/wTH7bsA6F7JYyBsw3icGg4i/RjnivBrELS4gjwB+TtPSp5HEBP5jDzBPMn4qCHegsfnbVAV/PzxBh5OCQxX3McGhu6J2W2nJuMSJyRmXiuwo9+JWR+J6Y2e6/Q8bzYIkn9fzmZXx3ZDTDsV6jUUWwuFBR34AIdAJDAt6H2WYNysDmPFyq+hXPEwP8TmCataH8YKnp4k0TMer3vE3pbBJIrlOV1eQbORZe8V/m2mu4zH/au+fa8HRK1FBptFJdsZz2Q0NzKF+ZbaAd52C+gwD42/46RzrrmD6PsynaAWj1P1ZWKXY3jaqCkjvpD96/hQ==
Received: from KUZPR04MB9265.apcprd04.prod.outlook.com (2603:1096:d10:5a::6)
 by TYZPR04MB5925.apcprd04.prod.outlook.com (2603:1096:400:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Thu, 25 Dec
 2025 04:32:43 +0000
Received: from KUZPR04MB9265.apcprd04.prod.outlook.com
 ([fe80::3c38:c065:daf4:cbfa]) by KUZPR04MB9265.apcprd04.prod.outlook.com
 ([fe80::3c38:c065:daf4:cbfa%5]) with mapi id 15.20.9456.008; Thu, 25 Dec 2025
 04:32:42 +0000
Message-ID:
 <KUZPR04MB92652A9F33B1EA2A2CFF51C4F3B3A@KUZPR04MB9265.apcprd04.prod.outlook.com>
Date: Thu, 25 Dec 2025 12:32:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/riscv: Fix unsigned comparison with negative error
 code
To: Alper Ak <alperyasinak1@gmail.com>, tjeznach@rivosinc.com
Cc: Dan Carpenter <error27@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251222151550.987992-1-alperyasinak1@gmail.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20251222151550.987992-1-alperyasinak1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0072.apcprd02.prod.outlook.com
 (2603:1096:4:54::36) To KUZPR04MB9265.apcprd04.prod.outlook.com
 (2603:1096:d10:5a::6)
X-Microsoft-Original-Message-ID:
 <1d83802e-7178-46ca-92bf-f589c90edce2@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KUZPR04MB9265:EE_|TYZPR04MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: e3962b81-248a-44ac-03e0-08de436ea4b5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7042599007|5072599009|461199028|6090799003|51005399006|19110799012|41001999006|23021999003|8060799015|15080799012|12121999013|10035399007|440099028|4302099013|3412199025|40105399003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rkx3Tk40eEFYRDdDUk9OQTg2TmFFN3lmeUJER1VWWVNwYVhZT29NT0NDMld1?=
 =?utf-8?B?K1dVM04xakRZNFZYNUJKSHBXM1JFZDhFbnkzQ2NZVXlaYWNGY1lzRzRUb1Jv?=
 =?utf-8?B?NXlmcnUwNyt6T1RaNmhudlZDMk1PWUNmK2J3bmYvdXBoQjNJR1Q3clQrSGlo?=
 =?utf-8?B?RkpLdTMwR0wza2hQR0hYUEpLWjhBSXNJZ1FQVUtPeEo4RlRHRndING1qNFQ3?=
 =?utf-8?B?SVAySFBqbzRicXRCZ0NCNVVPM0Q2RngyQ0lpNm0zYytCTFkzT0t3U2tFWUZt?=
 =?utf-8?B?VEQ3Q0RqbVEwWWJLb2t3TlVobkZQZnFIanNGaTczZGs2L2NIaUg0RW1FMDVY?=
 =?utf-8?B?Zit6UitIVVFBL3N6bVZFbjZONFE5aTV1VFNUMVlvclJEVk1MbFlMM0pyZjJi?=
 =?utf-8?B?cGpITmpyZW4wM1g1VjYxQWQvVWFDN01GaWZUcUQwM2Z6bS82TkVZZlNlMzNu?=
 =?utf-8?B?UzJYRG00ZjZjZWwyYXROZ2FoSkxKTE5DZm1Bb0ljUjNYNG4zQmwyT3JmK0Qy?=
 =?utf-8?B?Uk83RFNYT3hUbUxZTXNWcUJYZEpIa1U4dFpEbmtVMzgrUlBQakJxdlZBRzdn?=
 =?utf-8?B?RmhFay9vODVucXozMlBZZi91OHZxUmRwdEVwUDRtM2U3RXVoZDQ3U3p2YzJU?=
 =?utf-8?B?QlRCL2JDN3hOSmFDa05ZTU5QZ3NuRmdMUVJuelBPODVZQlFOMk1OQkppbTk2?=
 =?utf-8?B?Q3laRE84NS81ejZIQk1sL3d5VktpWE91bk0xZXdtOFZsRVNhaU1WUmhrTS9F?=
 =?utf-8?B?K2FjbmE3endva0tzY3VxaG54MUdtQzdrMEQ3U2lhU2xjakVzY2s1OWdZS0o4?=
 =?utf-8?B?WXUzbVZKMXMvRm8yQlB3UHhYMzlIeGpmMWJDQ0ZRc0hkcjhVK1JsbVF4c2p1?=
 =?utf-8?B?VGpOdTRWUnk4NS9XcDNWY2U2UVIwdk11akxhaTFMdTZqMXBmUGJuVk5lMEhP?=
 =?utf-8?B?ZWZRVUhjeGtOaGdoQnpYZlcyRmRydlZ6YU5iR3JkR0E4cmF0cm8rWGdMV0ph?=
 =?utf-8?B?dXUyUnRQTFcxTDhhbTBFS3FQeGkwWHFvQVNvb28vSlNiWFY3OGVROFRpekxs?=
 =?utf-8?B?WXBPZGFiM2taTEI1TzZwRWxaa29YaGlnL2FSSUJyRVM2OW9kL1BFMVBSR3FQ?=
 =?utf-8?B?bGVIUGVTdHNHbThLZEt0YzhRVWZraEJBczJwZkpBa0xNSnVZazNueVZZUEN0?=
 =?utf-8?B?N2ZYVGpSMHV5NmlaOTh0MEQwMHFMTzVhbGpZeFpCZTVqQmdqeDFSeUVsbksx?=
 =?utf-8?B?bVFMVUI5ZVJoWTVCcnFQMVJjaVRsdG9IVTFydmdJNVJ4YUgrK2t3STJTZEtZ?=
 =?utf-8?B?UDVjRThyOXNZMFljcktGT0R0VjBWSlprK2NGTHVZNEhySlIwTXRJQUxsVkQy?=
 =?utf-8?B?UkpqaHZLQnQva2tkVGlmeDdacS9mTTBFaW53anNxYjJKTFdrT2RnbWg4QUQz?=
 =?utf-8?B?UjQwellNNXhyU05kbVdzQzRyN0FLY3pWY0p3aXZIOStzaXBtcnNxU3RKeTdT?=
 =?utf-8?B?dXlLQVBpWS94M3pmUDBnT3hxdjA5YUg2K0htRnptNjNsdHB3Y29vOGNkYU5i?=
 =?utf-8?B?WGJzRVZwbkxUUXlybkpSdE1aMEFPREFVdTE0cm56TnN2NmxCMGJ6SVcrR1Jm?=
 =?utf-8?B?YjV3UnQyY0VaSWtDMWJMaFBrdVhENHZYcGFYeG5zQmlva21mWG4rdU9oVjZD?=
 =?utf-8?B?V3FsUFlBZTl2dmt0UURhUlZVT1RUYVpqUk1qUk9JK2RzdUo2QWw1MUxPRWt1?=
 =?utf-8?B?aG01TFpDYVZKdW55dExpMkhOZG04MGFyR0xXeWRuaVZxZk45Uy96NmtPQXJH?=
 =?utf-8?B?V1dZdXhSNTBMeFBBR0JxQ1g4c1lIN0VPNVBNMVpzbGNxVVZUUnBoTDZzOWk5?=
 =?utf-8?B?Rkp0NSt5SmdLMkVPdUpZNHdNWDNJZm5idFdHZ3p6a3NDVXpPWTlQdEtDZmNz?=
 =?utf-8?Q?ZiJOEfBKjRV53mlCKLSfoBDRkfubzFfj?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVZUcHE5SkNJSWRWN1BSYVN4UnM5SVlSRnYxQWN0REtUQ2poR1k5V3pyZmhI?=
 =?utf-8?B?TXFxODNJa1pvM05Ddm5jNzBQTHVPaml3Wno0SHc2Nk9scjdselR2enVlbmsr?=
 =?utf-8?B?akc4dlFhcjNQOWNhNjZPRWtsRzZYWnk4aXhCemhaaDNrRUJxM1Fzc3BKVmIx?=
 =?utf-8?B?VDJMOFg2RDFHOHNOc2FYemw3Z3NRQkpEdU55eHZqTzFIYklqOHlBUGNHRlNK?=
 =?utf-8?B?OUtuSkhUSGpFcXozNGVETDRRMXZ1Smp6RC9IMVpKM2hjUEtGZjRwVUxiNE00?=
 =?utf-8?B?RlpXOVBnS3REa3dlY1FOd1VEdDlic210MXZEa3ZOTnpRaGpJK3ZWMk81Y3dP?=
 =?utf-8?B?MVExR1k5dFpncDJ6RXFnRHptYTloL2kwc0VBT1kvaHB5MWpkdXZtdkNYeS9w?=
 =?utf-8?B?NktRd3VtNDl0Q3poNjFGcm1JcjFOcERZSmczZk1Sclo1VTJKc2ZvNitMTTVX?=
 =?utf-8?B?MTltWEY5MUE3MkM1dlRScUlhRmp6NkRreFNmcThYSHhBRXI2UVNFVXc0dExy?=
 =?utf-8?B?SlhJSFp3T1hDTmY5dmpvU0diejhmZlM1cWhzVjkwcnlPVEYrbXpxN3RGeEE1?=
 =?utf-8?B?M1RiUm1QUDBrNVNPN25TaS9LeWh5K2xNaTFkUXZsOGZodzlNcWtGQWtJTE9i?=
 =?utf-8?B?MiswbXNuWW0wRHZURVhmdkVhTXBnYUtuaDcyUTg4SVJaNlJLSFkvQXYwbmo0?=
 =?utf-8?B?NnBVOEtTSVNWbDVtbU1EQ3pveHBnd1lheWNyQmFxMUI2bXQ2ZjdpaExZdTFi?=
 =?utf-8?B?aTNzeXZlVjZkbGpiOGlkQ1M5aHYvSWw0T0VVRmw0L0IzUDlIV1NDRU9qQWhS?=
 =?utf-8?B?UzhGWlc0d1lXTmFyclVxNHFSWEV6RFJ0QXdmblRHRHBPMVBFcGRBcXQwTjNF?=
 =?utf-8?B?NE5DaCtKMW45YTROQ2pXK1Y5MVZPNDA2Y29xNk9ZS29lOUU0QzhHTnM3dG1Y?=
 =?utf-8?B?bGVkSFJCZE9yQk5JNHh5NWJ4UUhhNEdsdUdyeXlCbEdBbFU5ZzVKQmIyR1V1?=
 =?utf-8?B?OElFeHZaODhTaEdoTDRqd2dLK0xvK3NubDQvTWtraXZuckhIVDVoMzVEM0gx?=
 =?utf-8?B?MXlnQW5WckJZamRhNzFUSzBhaS8xVWkyNE1RbVQ1cnhqa1IrRzBUMHVzZ3lh?=
 =?utf-8?B?TUxnUkRpOFZkRm1mRVhLbWxSVjlYbXJQTmY1UXhSYnVLNGdvY0hyTlRQeTFQ?=
 =?utf-8?B?ZFhvcGh6TWN3UW1EdWxCc2RJZW1ITzBkbXlhMzljdUFEYXVaL2tuSUQ4aS9a?=
 =?utf-8?B?SmVhYk9KNlNBQjZ4ckF0OUY3aUpoRElIY01jZERTQlE2RGFaanJ0RjQ4NFRR?=
 =?utf-8?B?cDdkM2hZUTdHeEQvc2RaTjlobldKQVpudnkybDZjWXo5T0pIQ1lSQzdwbDB5?=
 =?utf-8?B?eklLVytoazJ4cHJHMDREck1PL3VrNzZMMDhrbkdYOExKcURGSFdLZU0yNG9X?=
 =?utf-8?B?RERoZTcvN0dMelg3blNqYnFXeUh6ODdaVmZtdkNBb0Y0c1djTjI4TTZlM3Zh?=
 =?utf-8?B?UUNlNXluQWJzcldFVFpjT1R6dkppd2pybGhzdGh6MGlnbHRsSEl4cjI3dms1?=
 =?utf-8?B?Q092T2F1a255b1VwSHNrcnJpZVQ1WVZNSTRCMXJNQmRkZG42QWJGZ0NCNEln?=
 =?utf-8?B?YkI5RHF3RkFJdUNodHRqS3FLQnhjMUhHOWRMalpjOEkxVGpzdmtMdFpISm9q?=
 =?utf-8?B?Ulp0UHFsRDNyQmE5VXNjTVFHOFd3bzJaWWlhOFNQVklxR2oza25xbm4yblJx?=
 =?utf-8?B?QUp3cHl4d2NEUERITUgrSnZiRlkyY0t5WG5FVFRLRTlyTUJpa1N1ZWRveisw?=
 =?utf-8?B?ZDc0L0xjNkloY1lob1hPQVVuc3ViZ1Bhb3U2dU1QV3dDWDlNK2d1V2pGajJY?=
 =?utf-8?Q?RIuhtIPPuLG6C?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-515b2.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e3962b81-248a-44ac-03e0-08de436ea4b5
X-MS-Exchange-CrossTenant-AuthSource: KUZPR04MB9265.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2025 04:32:42.8440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5925


On 12/22/2025 11:15 PM, Alper Ak wrote:
> platform_irq_count() can return -EPROBE_DEFER, but irqs_count is
> unsigned. This causes the negative value to wrap around and bypass
> the error check.
>
> Store the return value in a signed integer first and check for
> errors before assigning to irqs_count.
>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202512141551.kZLTle5r-lkp@intel.com/
> Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
> ---
>   drivers/iommu/riscv/iommu-platform.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
> index 83a28c83f991..5ec8efedbf12 100644
> --- a/drivers/iommu/riscv/iommu-platform.c
> +++ b/drivers/iommu/riscv/iommu-platform.c
> @@ -68,8 +68,13 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
>   	iommu->caps = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAPABILITIES);
>   	iommu->fctl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
>   
> -	iommu->irqs_count = platform_irq_count(pdev);
> -	if (iommu->irqs_count <= 0)
> +	ret = platform_irq_count(pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	iommu->irqs_count = ret;
> +
> +	if (!iommu->irqs_count)
>   		return dev_err_probe(dev, -ENODEV,
>   				     "no IRQ resources provided\n");
>   	if (iommu->irqs_count > RISCV_IOMMU_INTR_COUNT)
