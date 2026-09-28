Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013074.outbound.protection.outlook.com [52.103.43.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B47359A66
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 03:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790565426; cv=fail; b=Sc63JBYRlv7AWTPv4bx1HiTpAo2bSJ7UkWLoDm8U2t92aTbhDT3wwimnzz19gjAZQiN6Hma/as0aMWtTk8ENN7QLF4hFhaSVRcv4U4ew8yG8E0cPRrEGbQTLHFhbztEOLM7mZZOMfaBTkomNQ9ZDaz5yjrGphCEY6OA5dlGhme8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790565426; c=relaxed/simple;
	bh=uRMkXIwarRCBKpeI9I1BpLVPIDwIaH+/Zz1AP8C4TW4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U6pKBQeLIjLWgPcttj42O35uP3QIifteKZA1CoY9txDJWbqP3F6vkRtytaRNKiRHdAHbva5igm9gNPlXQR5DihQvqh3a9KLWpbgiRMMVlUalehewBIiQqlp/mB5qUyavlHcpAikTueaEItLCdAG1FSmgONzL+oxNfLgC7RHJhI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=H2XAI4xQ; arc=fail smtp.client-ip=52.103.43.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="H2XAI4xQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBpmLTuGaCHF5C/vw1gqS2yexjAy7L4o6yg2hAlBReLqU+dHAktKczGwOTltB+VVIRWutoDCocA0SQQowvb6Ykn6QNNfQS4Fw6CRKXPvzEn5T3q7sQ8igvw3sqf415i97xeRzmmJHDZRm+CwZiHNn3odk9IU08Muyi7mdiDfYDH981RaCQrsP7saqbEbr9fgZz9Syj4AoULAL2KHz7B2lvMyQV3S8v5Vz+N6WPmdmZUrtYnQ1HS8fBtu5GB81eYgLnxN+cl78Hl8zo3fD+wBhOjn3p+SRAPXABo9iAy/ViC+6FhKnhhDP60AfEMyVo9dhSR05qP3IJdhJwiXvP88cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ner11Hy0NNBhAzj7KtYFnA5N9bBT8tFESAF1G0sSkdo=;
 b=O4nYRbU0MfVSZTinjTvO0dV+yvKlAePRSPLZotV1MDvE7RAv7YYV8tSPR2vOK7z8nn6pY7QNAQn0C22ZtXoAFsf0KNMs/4RQ97kFDRMj4YL7VKNtiKsHcICnRYyJuQNgDgueJb0t/OYORl+N1vAEzFymIGfTJkOz5pIyI5occo6M4ea7Dx94rXTw+rp+yaiIn0/5ab8X+Qjh98YqaPoEdqUThc/FDD8xsHhI3CM7HuijEIzWMV/CDC5/qM7MIiH6KAzfVYy7rsfdrtqU1hDIZ+03S8gHdYHVdUVjqfl8WJFnRM8FW0NRI9awfpSqKgajxjt5nUA7DXyIaCIB9UrXuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ner11Hy0NNBhAzj7KtYFnA5N9bBT8tFESAF1G0sSkdo=;
 b=H2XAI4xQsclbEJSGNjVBurpaRLRxIdFozpohwBwQkFckoKMCTPC8ayvi0pKeMRll+i5+TfitdrnsvuMIHNZE2Z7ZvSHdbvj0tIHDBjXsj/jOLiy/76C+nMBEIycGTRARiNxVrg7iScMoipueo0Ben/u8V+rAJqcCLtmwnRO8s3+wueWKEux7Bd2qY/Z/Qumpm/NPzyPIEJ7/LWn/nupi6bOhT2CAUgSFmocUXLx6eN/mLaXaQfhrUaOamR8kBWX8TexN0vkVTSxfrkidWGGwH9Ub/7FRFp9o+TQKkMIr8WSb5cj2Wr6lvxps4IX7uP9gTT3qpLOToK475e1PqdTJWQ==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by KL1PR04MB7659.apcprd04.prod.outlook.com (2603:1096:820:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 03:16:53 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 03:16:53 +0000
Message-ID:
 <SE3PR04MB8922C531AE0393F58DFBFB42F38D2@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Mon, 28 Sep 2026 11:16:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 16/16] selftests/vfio: Allow building on RISC-V
To: Andrew Jones <andrew.jones@oss.qualcomm.com>,
 linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
 tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
 fangyu.yu@linux.alibaba.com
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
 <20260925151659.419512-17-andrew.jones@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260925151659.419512-17-andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID:
 <d6cc578e-61b1-4cb6-9755-4957cab31e8c@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|KL1PR04MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 276386da-3cf7-4603-4cef-08df1d0ef151
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|15080799012|5072599009|6090799003|22091999003|25010399006|51005399006|4140399003|8060799015|19110799012|55001999006|24121999003|19101099003|10092599007|440099028|3412199025|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXV5OXA3T2crWU9EbjhDemlPK1JoeS9MZW5ZVDZ5ZFJMMUJocGhSV21FNnBm?=
 =?utf-8?B?V0kwT2lHZ0Vlc0JjMzBCWHdYcGtQeDN3QnRBTUlEcjJwOUE3cWwxVFcyN05C?=
 =?utf-8?B?SkFCVU1uMFkrSW1wakJVdHIraUlGNGlVcFZENmJINUlPYXB5WEY2STZ6aG9X?=
 =?utf-8?B?dTRRUlkyc0J2REJ1d2JITEcvdUlLc3VrK052djNVTmR2V3Fwa01FOEVKN1Vk?=
 =?utf-8?B?aml5TmtsU2VqZ2E5UW5qL2xyRG9URWlwU0VUWitkUUdvQU1JZnVZL1J4SHp4?=
 =?utf-8?B?bnZjcFBGVVpOTDkxd1A0U1NBZDNyMzdEc3hHMU9XZW4wVTVuZEo0OWF0aWlr?=
 =?utf-8?B?NU9oLzd6d1R3WWUxSDdsYk5RQWxmVjhTVWtLNndueDZabFQvSXl6b0tGVkxl?=
 =?utf-8?B?SU9McmZkZFFDSHNsbUZUV2NRMzYzbG1SQUgvT212NU9udndQQlJ5TlhUcmVR?=
 =?utf-8?B?ZERwdnZIL0RIWTRJTkMyaEZmK0puN3JTeEsya1BpU1dqeTdmSE9oQVFIWis0?=
 =?utf-8?B?M01Ed1Y5azMvUDJ1cjV2b2tnTlJ6NCthQ1dWUThHUHp5UjRhbWFpSWxMYldN?=
 =?utf-8?B?cE1PZXRTLzBxUXhFUjlZZG9vT1NQeHBIb0QwcnJFZzhrTFprNy9pOFhOUWlD?=
 =?utf-8?B?emRQL0pNaWpJM3JVNHhFZVdxZHdkYzJpVnFQSXlrOEViNTZReE1sMFMrYWN4?=
 =?utf-8?B?cXNCOFpWNXV5SEcxbzBaS2xZd1kyTVlldWpXQWp3UUgycVdQSnNscWJaOE1H?=
 =?utf-8?B?Q3ZZdmFFbG05T0Z0K1Q3eU1vZ2pCNElISWhxaGxWQnBTem1CMTZ5Q1hvOGhQ?=
 =?utf-8?B?OWhac2dWdzhsOVVNVHQ5LzdGUjlWeHFGblNnK3JtWjZad1BHVldCenptR01m?=
 =?utf-8?B?eFNpTGRQUCt1bnJoRXYrRUIrWXU5MWtOMVBTMXU2K3NjaW1OcE9nWTRBbjZi?=
 =?utf-8?B?TlgvUFYzNlc5eHl0b2hWbnQrK3IvS2JXQnNCMlJscVNYcHhJcjdaNVNqR3px?=
 =?utf-8?B?TCtJSkRRSUdMN0I3MDRlc01tRmtvZGN2QjRtTnd1U3pBa1BLbXAxK0VDOUJR?=
 =?utf-8?B?R0VrQlZrZmIydUZLUlp2anhsajk0QnNGcHBTTzdoVklCSjNHaFRoaGpEQnNl?=
 =?utf-8?B?MXhiL2s1M01DT3htWjFhQUtUZmk3eHhBT1IyY2M2dGtlZ28xeGk3bzNxRU1k?=
 =?utf-8?B?WEJ5MnNlNGtwNEtBbTJ0VjZzVkFkUmdST25HcjllR0dKMHM2UXRJTHFEVXZt?=
 =?utf-8?B?YWRFUTJJdW93eXlPb0N4Rko0TTFrODBEWG9HZTVkdFJ0SlNLUnRPUzdtVXp0?=
 =?utf-8?B?d2d4WWR4RllEMDJpLzcwQ0NsVUFjY2hWVS92c3dJd2dzaWY5VmtCclNSWDlQ?=
 =?utf-8?B?c1hTMXI5MUVrL1I4U0JJTmpESTdjVGF1MDB0TkNhejFZekhZZ0l1bUU0c2c0?=
 =?utf-8?B?SVNPWmE3ZitnVEdIaXNFWmZzNkovcFdFbmFlTVFRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q09oNmxoc210cjFWZUFheDJUTlBHaGJtWXZrRitvV2dmN1N3bFpicTJNWCtD?=
 =?utf-8?B?bnZwQjJBbElKeVhNVFZ4OThrbU1iQXM4dUY2TGdydVFGWjBobDVsMGVQSHFt?=
 =?utf-8?B?UUxtK1VFZGRvTmVxNUovTjNUTkJraUxhTHhEWEF6bi9vUnBsMmxRT25IaEpz?=
 =?utf-8?B?ZHFONTZvQnBtWFhVSlU5Y2NnNzZSbGJhcElqK2NvNVNoNFdVR28rTXRvTlhh?=
 =?utf-8?B?Q2lDSXhlc0VodkgzTkJ2dm9QUzFMeEwzazZhRTFxdHVTcWZQUlpwbzJydmpz?=
 =?utf-8?B?ckRyVHF3MTYwUGxRT01Md201ZFJQVnVOczhzV0xlMElkb2RscWgyMWdCSWR2?=
 =?utf-8?B?bzFvRytJWkhJRTk2bW8yMDU5YWVPZ1R0bFRLOWZaV0JZb29BaWkwSVl5SllB?=
 =?utf-8?B?NmhGQXBVam1sdFM5YS9wK0IyYUgyWWJWUmh4MWh1SEliRG55Q0djNGxEaUlC?=
 =?utf-8?B?L0FMTlVJaW0rQUhuZEgvWXU4V3N6L2o5RDRLQVVZM3JKZTNQUk5KOTFqZmc5?=
 =?utf-8?B?QjB0MEZKelg5elp6eG1nZEZIUW9MazRWYmIvTVBycUt5RmlJc1pORnBjU1hJ?=
 =?utf-8?B?N2hIdDdIL3Z5RFFHZjlzcXdURVZkZHgrT2tMWHpocnVsek80aDNGS0UvZVBv?=
 =?utf-8?B?VnFYRDZIWWt4cUtiKzNmczV0cUVSeGE2OHNFOUcxRkE0SllpVXl4clFOc3A3?=
 =?utf-8?B?WitlbDNweU16NTZkMEt6VXhPdi9kc1FwTGQxaS9uY2p4NVVJTThja1J0QVNF?=
 =?utf-8?B?aTMzVGZ1OHdLL1F0aVpVTHNMWTIwcXhYZ0hLMDRBYTJ2ZHhIUzdUTWRFdGtG?=
 =?utf-8?B?RXh2NkVNNFE2M25NOStKNVZCL0lSSFVqaHhIZjVZVFNHK0dVZzJ0a1VEMG1t?=
 =?utf-8?B?NHFzWXdtb1lGcHZONm8zVUtBa2RIcW1TRHlkT0pJVmZNeWY2RWtKOGFSZ3hz?=
 =?utf-8?B?UmI0M0p2T1kzMmNMYjhTbVBvWjZDNW90NExwcmN3SE04alIvUng3SzZoSjl3?=
 =?utf-8?B?Mld1Y3dYYXRhcjdxZ1dTMXJsTCtnQmZJdVd3UC9VajU1eGZPVXoyM2piMmZz?=
 =?utf-8?B?Tkg3L24yZ05CdWxEYjExdWNZVUhLbFhjd280MDdNNUpBUTlxWlRDQmFtMVV1?=
 =?utf-8?B?Q2ZkeWdNUFVBVENKM1BjL0F0NWIxcVBOYXBGYzc0S1VRSDVlK3E0ZGh6S080?=
 =?utf-8?B?LzRQUmF5UW1LcE9pc2E4YzBYNFJUK3Y3WEtoK0JWOW5uN25Bc1ZRN1RDM2Jp?=
 =?utf-8?B?SCtmUGJyaDBhOWJYMnNIRWlQN2pIc2dXYklXa3lTV0NTYW1aVXlpYThuTDk4?=
 =?utf-8?B?U1k5c05ocUo5MFVQWVR1K0dCTXNEbWh6UzdqNDNqMHhtWTFKMWdDMzhyWFMz?=
 =?utf-8?B?RDlBUHFuYUhMN25JUUt6TXM4NTZRSVJ3SFNiVk85SlN4SVFCdE5KTEZaUi9r?=
 =?utf-8?B?aVJOSEloRm5mdmRVbFdQL3ZwMWhEZ3BnRW9kaTNhTXZhQjIzd1RGTUxHcUd6?=
 =?utf-8?B?STdDYkJsM092YWdDT3BKYWFTcnVkVkpJRFNSZ3h6RzR2UWg1MzYrVHd4Vzcv?=
 =?utf-8?B?a1VUKzRFTUVHSm03czJqOXczUW42Y2paeVRSR1I3VDlXUHRZMklvdVRBb0Rs?=
 =?utf-8?B?Z0w5L3UzMGcwS2tTd0MyMzNZRnlWQ2dVSFo2MHhHallvTTRSVFBqdytwNk9v?=
 =?utf-8?B?bkpnbFo2eWFDSFN6Z1RiNXQyMnNlVUdBQUQ4bVFONG4vUHo0WTAzNjlEeDNS?=
 =?utf-8?B?QWViSkQ2OFdVbmQ1LzU1aVZZVUp2NjFSOXVNaVZ5VjJEcW8waWF3Ym0zS1F3?=
 =?utf-8?B?WmNURlBnWWtGcEdpNGtsNk1XUDVpTmRUVEROTlpmdEtzYmtYNWdyb1ZyRGZk?=
 =?utf-8?Q?cgKCbazUrq1E8?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 276386da-3cf7-4603-4cef-08df1d0ef151
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 03:16:53.1757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7659


On 9/25/2026 11:16 PM, Andrew Jones wrote:
> The generic VFIO selftests, including iommufd coverage, require no
> RISC-V-specific source changes. Top-level kselftest builds normalize
> riscv64 to riscv, while direct builds may use riscv64. Include both
> names in the architecture filter.
>
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   tools/testing/selftests/vfio/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> index 2c32c48db509..2c7d8ea81b61 100644
> --- a/tools/testing/selftests/vfio/Makefile
> +++ b/tools/testing/selftests/vfio/Makefile
> @@ -1,6 +1,6 @@
>   ARCH ?= $(shell uname -m)
>   
> -ifeq (,$(filter $(ARCH),aarch64 arm64 x86 x86_64))
> +ifeq (,$(filter $(ARCH),aarch64 arm64 x86 x86_64 riscv riscv64))
>   # Do nothing on unsupported architectures
>   include ../lib.mk
>   else
