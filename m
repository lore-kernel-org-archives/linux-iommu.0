Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013081.outbound.protection.outlook.com [52.103.74.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6389547043
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 04:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789704239; cv=fail; b=Ovse0NiLh2l2msf2jz6A7QUvYjoblXZn1mMrLrvWEPQ8PKfbwf9siQ7Gw9kiQ/Msh66aNjbtP+FyCx8iXW2MCiaZkxvwiBuQyXlCQ/LwEdoJtwrD4jCUyKtvZOH+31dCijpdNn2JfANo/PGKtwH+9tvBAO4iwjXJCpoCYXQLgkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789704239; c=relaxed/simple;
	bh=Ri1mLnhcV9sOmoYFa8k9WVBZ9PKsnPVSNAkv0qNS3KE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P0H1HcDy7J257J7uucW08RJVrfrhRK2kJXXt8Rgn5Ir6hRGEhbjP2OQFZzt5qwgy/VBMaHwVLtYU5VXs8wy24v80e3l/h7wi1pJ2CAOo2iLC/1tT3lifaZBJbYnwGqDZ2kEtSb49IFuSwSGMukgIhqbv6oVLGS3HN+jQax1fy8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=lgZrztu+; arc=fail smtp.client-ip=52.103.74.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="lgZrztu+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVa/8j0EEPO/q7/2R+vkQlo3esnycpSi1Ty9ZyKj3fXT6JZsoSdIhiUjxFrOX3l5nnIpqd2yhVP5x7yspl3kVuaFmliNhyXhP4nNK15grvTiHLL8xja3YC+Nihxt25Vtkmqarb2bU8sS8GxU6tl91/YhZlfS3rYOdAwodt/kpVb/TFtMCx6mV5ua3jjw5+/H1LRCBHisSqZf7yhWKGMyXre5ZHcbFRoJoScRqsVj0SCtwqXtkh1UpFg/DisbOhCdzxVE2iI/zZ1ENMKBTXYhRK+I35VcaquiRUAqo0DelgA6/sllvMZRfMdea9ktIXUFUnDOOj2V6fHQ+DUgkoSINQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DXfrWy4iLjmaDZ9KqORJ+0QgdOl746ZUauvcDhrhcI=;
 b=k06qECWhgavWQoybKvEWLVOk4SYmxO6IP5+LajE7VYY9c9V7xs4CSvLhQNQsmjEdOvz66F/4lX/A7feh3hjALbQsmS4rzALN+3JYqYC7BbY3A5nly1WeGCHnwSHPgalyT8vsDhhAPhQT5KeWyh9S1NtoNqUMDrf5sdw2ZYXReJt+wbTc3j25p75GR6nNM4/BpqOhL+y+k2Ialp5Yep6ddTxhqE31qesNfUqdlyZliELen1ozLSkJobclgWmwO1K7CdwWrdcXUMLWHQ1Hi8Pe8ZnGX9ZQV7U1eBHh0AdDLfRqRERFKgyRnKYNYPokzsCzgY6Z1+FD8JpXUCdq47KlDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DXfrWy4iLjmaDZ9KqORJ+0QgdOl746ZUauvcDhrhcI=;
 b=lgZrztu+JpDDfwZAATzqnRai3/QUN6uNZrbEUIMXJ/Q/hZKBa1bsXKf4O3kkONBelxysTSUKJK4wzIuCBwRr9oc5jTo1PG8S7K1b7QxFDWeAUyOTrLI45cEbl/JsszNVGiXiyecm5zs18kwGxHh8B4WLKTsUp/Que0PXdghuT6+//j1gOaFZ/tgNAuB8ZH4Js9suHt4MrRuOTH8HbkW/oXw/yyqi9FZet2ZrldOJ6HnTHQOZcnXdfbrcxmDjwfVetKpF8OG9lBGR9VO2aaVpLWv23FC/sNT8wCeRoGOIrcYbSSoJs7cbb0p/fDgD+kJKJ6sp+W0NT6akfrKHZP4fdA==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by TYSPR04MB7761.apcprd04.prod.outlook.com (2603:1096:405:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 04:03:47 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 04:03:47 +0000
Message-ID:
 <SE3PR04MB8922AA13463BBC6E3F8178AEF3872@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Fri, 18 Sep 2026 12:03:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 06/10] RISC-V: KVM: Enable KVM_VFIO interfaces on
 RISC-V arch
To: fangyu.yu@linux.alibaba.com, tomasz.jeznach@linux.dev, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, baolu.lu@linux.intel.com,
 jroedel@suse.de, zong.li@sifive.com, andrew.jones@oss.qualcomm.com,
 anup@brainfault.org, jgg@nvidia.com, jgg@ziepe.ca, kevin.tian@intel.com,
 atish.patra@linux.dev, skhawaja@google.com, vasant.hegde@amd.com,
 joerg.roedel@amd.com
Cc: guoren@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
 Tomasz Jeznach <tjeznach@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>
References: <20260915032828.11250-1-fangyu.yu@linux.alibaba.com>
 <20260915032828.11250-7-fangyu.yu@linux.alibaba.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260915032828.11250-7-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0019.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::14) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID:
 <3ce1d4d8-ebbb-4b6f-8667-4d2c83c19668@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|TYSPR04MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b8e8029-6116-400e-a6e7-08df1539d6e4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24121999003|22091999003|25010399006|19110799012|4140399003|23021999003|51005399006|16051099003|8060799015|19101099003|55001999006|6090799003|5072599009|15080799012|40105399003|2607281247196008|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHpiRmhGalcrRHUwUDAzekZYdzRNSW9sU2pRMFdJSlBLVDdvaDdWeGRRUWNP?=
 =?utf-8?B?dWZ0Rk05anFwK0lFK29MOEZkMVlIQkZKYW1sVXAyS2FtNEc5clBITmg2Uzd4?=
 =?utf-8?B?bEc0UUZMVGV2MVgva3R3L2wwMEQ3VDJpSW84cGt2NktaTnpPMkE1bjd3WlRo?=
 =?utf-8?B?MWxEVGtWZVRYd1gzeXV2aEhtVUJYeXdld3QrMkREM3VXaU1RUUM5M3JBcHdq?=
 =?utf-8?B?akRNUjRoOGtqRXFVcnVDdisrWkJYbitrenMvZ0V1NlhreCtLZ3NlN1ZnZFR3?=
 =?utf-8?B?MlBXRFRlS0hpb01mZXRtLzAvOW1mYWJjd1pKUVdYcCt6cmY1VWpndUZkSmpY?=
 =?utf-8?B?bDVCU013cVhqS3dNL2JWbW9SUEpadTZoN0EreXEwSWdtMktRanRLSE94K2h4?=
 =?utf-8?B?T0VSZmJ2c2FNTnIxUU5BcUZKaU95aFVXRXFrK2V6V0RxSG9veVZJTGNKaHFz?=
 =?utf-8?B?ei9TR1FaTmpFVkdBVk1iMkRBRHNRZTdkQkhHNHBNRGJGNG83ZC9RWnVYZy9v?=
 =?utf-8?B?THVCcThwakdFL2xBS083VVVpRFowREZjeFFTenRvWFZubnZ2eWhrQTFBZk5j?=
 =?utf-8?B?THBlVEdKQjVRbmlqNjQ0MDFLVk1SVkJDMVpCNnIycHh4bWJnUjBCUlJBTG5o?=
 =?utf-8?B?MWJmc2hpZXAzUTlFQjZDNWg3R0h1NnlibUV1VHVjOU9yTW1sWSs1S05CZnZh?=
 =?utf-8?B?R0xFc1l4Y1FkazdEdmkrNlFkQTdyWmtzMUx1QlJiaVlpRkhicDVDS3pZVWMz?=
 =?utf-8?B?ZmM5UVNvZytXOTVNZ1JyWjJ4TjVRc3dtdWV5YTRjTVBVZjVMZFRJUGZxRVlQ?=
 =?utf-8?B?MGJUNlYxZUhWUHpSY3d0SHN3MzZsY1JiMW5HcTZTaUx1SVdUdE9relp1SXlm?=
 =?utf-8?B?dXBYUkN1amtFV05aOFExcXZZblB0TDI4bE1ReExZUldWNDdBT2pFRGo2U1Rz?=
 =?utf-8?B?WEVwV2tFMS9XNzlCRkVEQ0hLUXM0Y3U1bFdtQ1FwMGpWZTN5U056Slg0UGhD?=
 =?utf-8?B?bnZHbVFTZzF0K0tXakp3T016dGpvSnQ2MjFwOWU3RnBhd3NOMDNJdStmWFNa?=
 =?utf-8?B?NVZmclo0eGdWdUZBMVZQSlJDUHpuSzR4R3V6eis2dERmMkRDbllaOVg2dENF?=
 =?utf-8?B?WG5YQUQ3RlQ0VmU1UEh2Y0JncmNPVTN1YVJQcnU2TE1jY2V5akQreWRqV1B3?=
 =?utf-8?B?ZkEyYU5yM1M2azlqdFlwbnc3cTNXMmJkclFKbUpWcnIrZzNWSjY0aUg0SUl2?=
 =?utf-8?B?ek45eGR1dzFPVUFuRUs0RDA4VkNValdSZGM4bmhTekFSZUQxcEttTC9Ddi9s?=
 =?utf-8?B?MVBEaFNFWlNKUlZ0amhKVnpVa01zVmhKUzFZTjJhcC9yUzhpNDd2Ym1MdGUx?=
 =?utf-8?B?VFc2bnI5NDZRUDZGU0hJcCsyS1NCR1JFUDh3dEVjMkxPU3RLMkFSTEt1dDA1?=
 =?utf-8?B?UVF2Tzc4NGhONFQ4TkwwbGdoZ3A4TXg3YVRUZ2ZBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGVhYkpHWHdveGJGZ3pZVUF2ajEwSXYrSUVZRnJnU3IrMWk3WG9hR1JMRjB2?=
 =?utf-8?B?OE9GWmVlSVp3SzFTOGc3UGhDb2tqb2g5TFQzeDR4aWkvN1RjM3B4cUNlZUgv?=
 =?utf-8?B?Qnl0TU41dEhpdm5ZbGRyZWx2SXhScTBxMm52ckp2VUF0aitzbjVEcmViTWQ2?=
 =?utf-8?B?Vi83aWFMUVl2Y1ZzNDAreFVQa29CRThpRFhjc2xVVnF5WUFjMUJFdlJmNFhH?=
 =?utf-8?B?M0UzaWNUbkszZmFQVDljOC8vQ2U1bTdSbFhKbVlNS3Y4SjZoSkZGeXFJeFFQ?=
 =?utf-8?B?bHBOVjZIem9xS0NPc0kvV2NxQkVFaFE1Vlppcy9QcC9GT1hMSCtVbmt4em16?=
 =?utf-8?B?eEd2YW82YW9qVDBPelR6V0tTYUw0aWJKcmxhdFowMW81bzFRbGQxSUpEckE3?=
 =?utf-8?B?eHp6NUxtdFJVeXEyNDRQVmJsS3Z2dkRqa1NMbkM5TTNCcXh5RE5xd0RrOVZB?=
 =?utf-8?B?dDFNUFM1czU1RThoRDRzeWZ5OURwYVlPdVdmVWwvS0JTVTNXRDFHbERqa0l6?=
 =?utf-8?B?c2Z2U0E1MzMyRUd2b2J6ckdtZFRIMkpkNjFZT3V6d09pNjRWWjQrdlZZZ1Bz?=
 =?utf-8?B?dmFmbjB3RGVsQkRwSkZ1bm52bXpJOXJ0T2VWVWpKL0VLakliRnprb1Q3bUx1?=
 =?utf-8?B?bXJQaE1wU0tGbUs0MWIvR0NudVBqUDBETitwd2Z2QlJGMFFpdXpRNmxwUkcx?=
 =?utf-8?B?Ti80UmpTK2RhVFBiS0szbjVIRm1tUEZxdGtCaWpqdGRWQXJML2duL2w3OXdC?=
 =?utf-8?B?c0hXOGhJTUtVOUdZQUxkNjN1Qzdwa0JHRENqWFdad0piUVU0TExTSEYxNzRz?=
 =?utf-8?B?SlhvTlJGTU1mdkIwTnNLVElZZ1k4MVp4ZUdhaW15L1ZIU0JpZTIwMWp0YnI1?=
 =?utf-8?B?WGg5dUxZenFLS0k5YmxlVDliQkRFY1FseVRsSlk4YkhUTFFITWpiYytzMTRj?=
 =?utf-8?B?OFg3bVZKSm9kdGlCU2Q5K01HSklPRUhTaVZ2VjJqcDEya0dRa3NMTXFJZHlR?=
 =?utf-8?B?czZ5OWZnY1QxNUxhbG9UL1puT2d0S0ZPVStxemRlVGR1c1NkQnJ4b2ZjSDU0?=
 =?utf-8?B?bUdpUXZiT2hTT3lxb3BsNERHU0tJVWZNU2lGWjEzeHFNQVlqQytBS00rMG9O?=
 =?utf-8?B?UXpKWHh5VmdyZVNvMTZuTlBERzkwUFZzcjVKUmFHNDh6b21jUnN4Y3VqNEtz?=
 =?utf-8?B?ZkZZWmRkV3RPV1hXdldxUjg4T2gxSGVWcmRpYXNEZ29PNWJMcFdna0pKOVVs?=
 =?utf-8?B?bkFlZnduWHZOSE9DRHQzY2hCQWthSWFyMkthLzhuMUpLcEVjRE1CbDVjcXpa?=
 =?utf-8?B?Sm12dkNOQ0hBUUdDYk9KNFlSUTRUeDhrZSt3NzBZdFBMR3ZDeHovei90d1NO?=
 =?utf-8?B?eUtzcUI1VnpRRXhTZG0zNktQT1dlNzE1ZXluNHYxdmRMZzdxTUFBaHNvMGc5?=
 =?utf-8?B?aHlUeTdPc0tDU0hHcCtyamtpdjB5b2tPQmJZNkZyVnl5bVhWOXdsSnFNTEFk?=
 =?utf-8?B?Uk9ENlVORHBFTHlmNk8zeDFMQ1pPNVJXNXBsRFF5ZXQ5VHd2THJhdzNiOW95?=
 =?utf-8?B?bE9YbEhIaTJ1aFZ6RUpkb0V6dWRqdXQ3TmNNVlh1TDBTWWpTbWExUWYva2hi?=
 =?utf-8?B?TDhEZlNJK1BmT25zREIzQTVuM1dLSEVCV1ZxaFd1cGo0dnlTNG1FcitEMElv?=
 =?utf-8?B?ODBXR0ZGK0RyeDdvVVBqUzlvNFduRGxTTXF6QkpTZkVMa2h1dEdUSXZmUWJV?=
 =?utf-8?B?SmtWU2EwaXpGVTFKLy92RitoQVRhdXk2NkxoRW5SVW43OEdGblFsMDg4WU4r?=
 =?utf-8?B?ZWYvcG5nS1JzODlsMXlyMktHTkZtYUhCdW03RGhITjliUDhtaGtWVmdOdHVW?=
 =?utf-8?Q?+21yHuoGj9KrK?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8e8029-6116-400e-a6e7-08df1539d6e4
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 04:03:47.7284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7761


On 9/15/2026 11:28 AM, fangyu.yu@linux.alibaba.com wrote:
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> Enable KVM/VFIO support on RISC-V architecture.
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   arch/riscv/kvm/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
> index ec2cee0a39e0..54ee90f010ef 100644
> --- a/arch/riscv/kvm/Kconfig
> +++ b/arch/riscv/kvm/Kconfig
> @@ -30,8 +30,10 @@ config KVM
>   	select KVM_GENERIC_HARDWARE_ENABLING
>   	select KVM_MMIO
>   	select VIRT_XFER_TO_GUEST_WORK
> +	select KVM_VFIO
>   	select SCHED_INFO
>   	select GUEST_PERF_EVENTS if PERF_EVENTS
> +	select SRCU
>   	help
>   	  Support hosting virtualized guest machines.
>   
