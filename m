Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012050.outbound.protection.outlook.com [52.103.43.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB47175A7F
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 03:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790565462; cv=fail; b=b4/cjMD/d54AvpJsH/lsyYZdxARmPC7B/Ce758xsPMMFeOV+mpaE9SEbouVm6TZMmiUah9O9HF9qcdOIQIWCTLiGMeayTsatp/wRUgnkKAAyXmCXMeyf7fiYaUCa0W1p1YE6PslIaMXT2o94X2z1SJZeI7XPnt28iNGLPfVh1bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790565462; c=relaxed/simple;
	bh=0dWaSlDScIRxBcZgybeOo2h8zdbW01xbeJGc0NandU0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fra19SgdYrMXjgorfO0Vr9RPC6igQJwo7XE14vuMitLQkdJ3UrNuFkbTOGQLvD8nY1utMiOo4fiWlixaDbKc4wQi9nYOBQs8INexr8iyGxYpPcNl28eco3QwotqgQ0KmGYMpLc610/6CDiV74TOwHhWmcUaT1ndTwmXniuw9NSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ptJhgeUu; arc=fail smtp.client-ip=52.103.43.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ptJhgeUu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pukug4JLt1pnqCU1G+2MVNTsL3nawINpda5fOgg/f8n3n2BjOEtlpGEvrRJYm5MWsvpy0w5/TGIfWq7m+yK7IGeCmji5GWCgd9RyolPWBIGBadBSHe7oIs+H+gHqtGVatOlsTtAAKczu60ZbRsRT7VWbKd8g5OW/H0XTl28IIbB7HlxNCPKX5Z3d/G7J1v3rCJU2fBDPsz3BSucMQ2ninRyFOD22XN4pJHerouFX9MHRyiPDz5vb1+sW7iDxCHbRiFzsyivq+LK8khUYhxcSVNiqqg3gKyWnV9x8MCKsE0yAOTKCVJOIPyW6Qhnrn5Hs1R1VUBU/l3ROlo7RhjpDWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cakbbaGUSRcGIdWKVAlCXd7ucgI5AjqsobfGiU3GuQ=;
 b=F3zpXCD7spk0lsXbtllB8JbBLQ9T62LStJqvqIt8agFLDFFgGGFPphgnFODonfv8F2ze5euCxhp0skHAEAwXGauLnfVw8FtJQj3WVpMYbL7E/i8bGi/IrEEjzEY2cc+f3yqxfptYUubNwILJCDPYUDCpz3K4wEuKbKkP5XmZFkCZ1Gz3RjDhC0EAOAdv+wSGamt2apz/1sq/TCJClq6lsOiCGAEqeee/HadUHIzGDzaE1QoYzeBvrONEZ+1vl6dD7HCKnzT6OawUzBp1WAVIH/2OaOFgPStpCuF1HlfCHeGFhKZrwm3aLy3GYvM7UBP0j3q53WgMvH0IczD1pRpIxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cakbbaGUSRcGIdWKVAlCXd7ucgI5AjqsobfGiU3GuQ=;
 b=ptJhgeUuB4GTDK0Q5JDZAA7RJc/K53NBJ2xEmmcb+xN7JS883+TG1GMo92QFwpQnbKLc2lXeai9YVUXNfM609LOOIFL5t4q4F2quxksG9wV+Zg4aaWFgQFr8eJcjQZmCe4g8k175Bc9+gBkXyc4JE2Sn5NSTquLa6PUtkXxVdDrb7Jnw/rCZZHOVq27mnHIX4P6FPEJeO1LrbdKx6VEgvPRCk4XEpIFvD3Wq0RYrxXtV+WcpGgRSusLWD6RK5UwFPDQ0kgokR2G7THel0UaJiBCbTqkRAjzdTkft0/+dw9kFvZErWBq9zprC34S6kuwa/W5R02OuraPojjtvnbSEXQ==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by JH0PR04MB7088.apcprd04.prod.outlook.com (2603:1096:990:34::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 03:17:29 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 03:17:27 +0000
Message-ID:
 <SE3PR04MB8922873F2CF8DA1DED1B2ADBF38D2@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Mon, 28 Sep 2026 11:17:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/16] riscv: defconfig: Enable IOMMUFD and VFIO
To: Andrew Jones <andrew.jones@oss.qualcomm.com>,
 linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
 tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
 fangyu.yu@linux.alibaba.com
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
 <20260925151659.419512-16-andrew.jones@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260925151659.419512-16-andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0026.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::20) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID:
 <97bd625c-c259-43de-9e64-5693c591a7e6@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|JH0PR04MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b5bfc6-0ebf-47e5-3ca0-08df1d0f062d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24121999003|22091999003|51005399006|25010399006|4140399003|23021999003|8060799015|19110799012|55001999006|19101099003|6090799003|5072599009|15080799012|40105399003|2607281247196008|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3FFRkVaNkp1S04zSWY4d3NDendBcG1pbmJTZ3d4aXlPNHhDUk45Wk5kbmFB?=
 =?utf-8?B?Z1BSdWxZMnFBb2FicU5UNTdCZ2FCZ1ZpOUNBNTErb2V4WjFIanZ1c1RVeURi?=
 =?utf-8?B?emUzQWxpQ2tNRVZKMjVDOXlnYXJELytBZTljd1Y2UG9vbE9RenYxbGx3NXBp?=
 =?utf-8?B?U1E0dTd2WVdwZk1XeWh5cVorbzlTN3N0bDJ6Z0ZOaUp3WVRnSEVkS0lKQjdU?=
 =?utf-8?B?NVJ5ZU1mRm9QaWY2NXpsV2VYb0pvN2FsSU9NejNYZ0YvaWh5VVNIVG42ZUlq?=
 =?utf-8?B?TWFlakpwaHQ5bk1HK1FPQ2RqKzQ0aTY5ancyVHcxclkrMDFCMGptTU92QTE1?=
 =?utf-8?B?akdlTHhWYWozWE1GTVV3ZXBOU1ZrYlByVGNqMERNSG1sUWZkc3VZUHdLVUtC?=
 =?utf-8?B?Rlc5ZVlZWms3Y0g5Sk9UTVppemQ5TXh6VktoSXdQRnAzdzZaVG9FVXhpVzU5?=
 =?utf-8?B?Q2dCUXZFTU1YNnlSM3lzNDdybkNBamRNRUVQaXF2WHJGd1lZWitPVnYrd25Z?=
 =?utf-8?B?dURzL2doclNiTC9teUc3VTB6cElQTW9ZWlFLSXdqYTdFeWEyOTl1alZUVjdr?=
 =?utf-8?B?b25OeWY5NklzSE9ZV0ozVUtJZmNnTHc1cUpjb0d4d2tzQzhWb2VEbUZHc0Jv?=
 =?utf-8?B?NlRlcmY1R05FYjJIUEE5YWZlOVV5S3VvWE0zd2NQYXBCZGRxUXlySkE1ZzhB?=
 =?utf-8?B?K05adVAvM0pyN20yTTQ4STd4REwzeVFWWFJMcS9MNVBHY3Q1VmFnMUtrbWdr?=
 =?utf-8?B?UkttRm8yc1JTR1ByT09FdUZhRGNjWEJQR1FRM1d4WmttZ3l2Z01NZm1oamFx?=
 =?utf-8?B?NERWQ1FMdVpyMHVRc09XZm1POHZXbUFoTTI3ZlUyQnQ1TjFNUEVlZE53dkRP?=
 =?utf-8?B?U2tmRDlyRVBTSWhtaDVySlBkWGJzZUNYMFUzay9peWNnVi85VjVLVW12cVVV?=
 =?utf-8?B?SS9wWjlTbTZ5SlJHaHFIWFBmQzdoeWVZbXlHbUp0Ky9rb203S0lQc1Y2U3ZB?=
 =?utf-8?B?bWhqUW9OdDVzdzdZVmw5M0dMMXpDekJzaW5WUnUyNk1WdGRRWjVaWjBSNDNS?=
 =?utf-8?B?cFhqb254R0hnRmVkOGZLMjExMmdEZ0phNWxCTGl6ZTlNd2ZQR1oyT3liaVls?=
 =?utf-8?B?dFpnTnkrSkF5VG9PN1REQWIrdGZQUldBQytTZ3lHVWROZElkSTBtTi96RUVs?=
 =?utf-8?B?azVvTEk1QkZtQlBsZFIwZDBkTVd4S1FEenpQb2JHK3d1alZYY3FxNnFDeHpm?=
 =?utf-8?B?aGhpOEc3dk9Zc1U5U2VmMjVsN3dTSmROUUJIVHV1dUhGNVIwMVllRzcxVTE0?=
 =?utf-8?B?dFc2Zy9KVFBRUHNPazBOS0pFbHVtZ0ZLUU1TSUtMVTRqaEc4OC9LMDczMUF0?=
 =?utf-8?B?VW5ISVJUMStUdkJla3ZveDhLaFZrU25ZQnRldTNVYjQ2RXh0WGgvNjZ1WWxo?=
 =?utf-8?Q?WV8XFTyW?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REZhTjA1TnhhbDdRMkRIc0VZS1BCcG95Wjg2S1pXM3NXdm1uRzFRSlZoMmtv?=
 =?utf-8?B?NVBYbWlkcU1JZndNb0VNU3BVcDJDaW9GSXRRNUJpd0hyLzdodlhzd2hrZUF0?=
 =?utf-8?B?b0R5enZxaDNBVjBaMFhVUUx6VlRLUCtZeEZyZ1NTM1dpT2dLM3hZdWk3S3lG?=
 =?utf-8?B?RnZ5TEhoeDdrTm8xYmp3aDZTclZOZEFLQXZYVHBIVVVhVDlVOXlxc25aOWV4?=
 =?utf-8?B?bkZvdGRoMjl0SnBNemtNd21wZFhITmVJNCtxS05mN21ENGNtT1Z5anZyTXMx?=
 =?utf-8?B?MGdHbFhzaG0yYVMxbS8wRkhkajVpNDhuU3UreGlzazl2K3Q4RW1iQldOd0tz?=
 =?utf-8?B?bEM1Zkp5YXczRjFYSDhNbWFBMFpNa2pubnZkY25tc0dMZDFLMG02bWNpK1E3?=
 =?utf-8?B?cXJ3R2N0YmRLYXJoaWkxNVphTmg0aHlBeGRaR0UvUDFyb2pGaTUxZk9RbkhG?=
 =?utf-8?B?ZWlObi9qVU1iczJFbXJBeG5ZSXR1TmJ6L2FCOXFMMHdZN0pxd0NDVWs4SG5j?=
 =?utf-8?B?R1B6bEQ3MWpIRTZuYjBwa3pVc1RoUWRYd21BNUZPTXArbk5XS0V3aUNsL0tE?=
 =?utf-8?B?SzR3TzlVWjB6OFlEQzJrajVxS2lGSCtVN2JtajVSMytsQ3kzREswd1BLcFFN?=
 =?utf-8?B?NGhHZkVjVXRDQzdxTGJaTjk5bmNzWkVYLzZDelFsWjdRbG5Na3NQeHVYNjAz?=
 =?utf-8?B?UUJqeTl3clpNcmUwS3JXbGlkL1VUS0RvV1RtNzBYOFBscEtFT1F2R0dBTG5l?=
 =?utf-8?B?L2ZQalRQbzNUbVhLcGk2TC9NWEhSSlJYcVZNV3UyQnhnbmlNWWRpOTRyeTB0?=
 =?utf-8?B?RUF4UURUYnFhVklQTHRXQ2RUWndaTXRYVWhGdk9pNVhocngwME9CeFAwMVlK?=
 =?utf-8?B?WlNMUnVpNmhNUGNFS1RPTFljMTZONE9RK2liY0JVMmIrVGNPUzRVSUErQ0Fw?=
 =?utf-8?B?QXBxVHJqd29SbmFKSklTaURxSEN2ZXd5ZnQ4VjlMY25QK2piQ0ZhczJ2K29o?=
 =?utf-8?B?RDlkNW5kTGl1SG1EbFVUWUdzL1lrSXdwWkV2T0MrenByUnlqT05hWlQ3OXdV?=
 =?utf-8?B?Y3Z4MVVsR3VHS0xTWHYwOGluUHBRSThXNVJjMjVyc2JjOEJBcDZaYnFhRS8r?=
 =?utf-8?B?NTgrRWFIc1k0eTU4UCtuVUxUbWJqSFlPTWZpT0Yxd2dCc3RaWHJUODdoR3FW?=
 =?utf-8?B?aVZxSEdGeEMvU0Nta0taWVJFTzg3bWxjWlVaUzZJbnNxN1lwT0RuVi80cDBL?=
 =?utf-8?B?M3pBSnVwQUlPYko3elRkQ0FGdGNYaDM1M1V6ZUNmOTZ1ZE4zMEcxZTZ4ZUxh?=
 =?utf-8?B?ZEpvaHVvUWczMTc0SklWSjZJUlc2UnFBZjE3TjBuM1FESEJXWkdES2hwbUtp?=
 =?utf-8?B?WmFDWWlLdWQrWUE1QWxqaStpSVVQR1BDS0xVQnlna2w4eTJGZVpTbnlSZW1p?=
 =?utf-8?B?SjBuRm41TE1DbllSMEl6NkhHdkV0MXB5eEd0NmtZQ0dWVms1L1N6TGhtcUdy?=
 =?utf-8?B?UnRZbGdwN3ZoclFuVXYreU1XWVlid0lablliTXdZeElUbnVSRFBySnlDclVD?=
 =?utf-8?B?Y3BacHZHL3hCMms0amRCQnkzRDgwRzdSODlsejJlcTJSS09HRldXRzE2NG1C?=
 =?utf-8?B?S0xRbUhtbVpjb0FacHlSZ1IwSWxIeEcxZS9SOVZIWHRlcGNrSnFndUpIYlpH?=
 =?utf-8?B?eXREdEtROC9vUS92NXR6MjZsRmxKMks4NlZVdXI1UjdFUW5PRWFZN3ZVNXRM?=
 =?utf-8?B?aWgwS0wzcGxYVE5RM21HMVRabFRiSnN6bW81WlRlcy9tRWpTZk5WaXdRWnli?=
 =?utf-8?B?U216Z3JENWZPbmVUOHNudGlBejEyREFKajUzNjBOcWx0RGFsVEc5MUNGVXRw?=
 =?utf-8?Q?8P3Uch8zVRrqM?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b5bfc6-0ebf-47e5-3ca0-08df1d0f062d
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 03:17:27.8412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7088


On 9/25/2026 11:16 PM, Andrew Jones wrote:
> Enable iommufd and VFIO in the default configuration now that the
> RISC-V IOMMU provides the DMA and MSI remapping needed for userspace
> device access, including assignment to virtual machines.
>
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   arch/riscv/configs/defconfig | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 04ae305d5511..daf382c05441 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -251,6 +251,10 @@ CONFIG_DMADEVICES=y
>   CONFIG_DMA_SUN6I=m
>   CONFIG_DW_AXI_DMAC=y
>   CONFIG_MMP_PDMA=m
> +CONFIG_IOMMUFD=m
> +CONFIG_VFIO_DEVICE_CDEV=y
> +CONFIG_VFIO=m
> +CONFIG_VFIO_PCI=m
>   CONFIG_VIRTIO_PCI=y
>   CONFIG_VIRTIO_BALLOON=y
>   CONFIG_VIRTIO_INPUT=y
