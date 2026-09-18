Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012056.outbound.protection.outlook.com [52.103.66.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09432931C0
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 04:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789704227; cv=fail; b=PUPA+myCj5qG2BTVA8J8CGuy4/ruDwXvCeVIpcCJQcd0Fd2F3hFLdSlT+ma8DIXgbhv7T5eDncg3hWTZJ44u0+bMzfsEIgUVcuP00oOoaOyI88+psgN0LYpnsa9MurYR9kDgJi2Xpraw5XIVaaDudNjGQrwc78rCf2jfMMJ5NQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789704227; c=relaxed/simple;
	bh=YAHK5qxx86vTs2ZmoW/7co2BYu4WZhP5SGoMytk8lMA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YOdlovN+XUNnpT56kee0Ty2mqAjeWjbL7jdq1tIAPaFLWZlLdYijy3FfjcleOVCgeIkP2VW/4/jV+vKauHh0jXrR+Jvr3Smi6ThhERGJmP4uyPm9j+vpB/19LbFrsLc1j9prXZamKMYKFNYJ7QD6gPyAY64T799SwUfINcsaPuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=dxF1mToT; arc=fail smtp.client-ip=52.103.66.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="dxF1mToT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjzrPxunR/IzK86+i2DDyJ3mzP2ZPZv83JZ+jiIkXsbUQQImhLVb3yStzO21HalGLMwBUJO7YqkCEVXx3mu2UyG0odBDmceVvO2KJUiCAkbiM9oV5iS6iX6mek5XtB2NGzbr6LWfd7LdK1wiJIMMzFbAcUJZ6wHTb2lbZZbnCMLV4bZstS8C0AhjGvl22T8CLdva33SfRpr0ydrbNKDohGjJFaeylvkfmXoYGrIP1YI19oDBwNf+J1gtcMqQXI2/L9pAqxC6Y3NvC0Rjgo7fCDZymmOEBfD2BlamYpBuMXwcngm9A5ZeDBssU+ZmzIIVQdpgvjFF28uCUxSLsX9bHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQfnyYeDhporNPS+IkH5hjcPKOQMULyRJmhuNm3raL0=;
 b=U7TdmoTa2rsRraRtqiNaShz5vR2uAwFxyuIDFWyLM1KwkIXFatlOm+tO/qkY2PRZe+46WOedzv9dFAV6f3moAvaaYbeQy+bzSYPSQ2HfLv27i3IBFx2PcEtaW+AICatZxDRgxAS1CERPu9qDmL9bgGRcaBt9QaDiSMuhwEDATRnzUPk4WAF67m61ZP7Su9u0eb/2phO4I78AciGAEvUo5JCQWRvdMgIz9LWxLZb+k6K7lr/QKla8P75SqZxlkgxkOLtjvYxcucXD2YuNkjvJHVj00fLOJBcxAxZrsWVO8LZbFZDgL7IUS6GO7eSdCHLhFTgtmiKyvw4zib9zjUOOpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQfnyYeDhporNPS+IkH5hjcPKOQMULyRJmhuNm3raL0=;
 b=dxF1mToT8TBsR1ohaL/CgSBIhPUiaq+3CDcMprwXEh6eNzSoaZcUO3KtlPjyaM02FhBy8HO9VQ1sTXz+ZAqeS2xzBKVkm6jMzsxwXwKvc9esGgY6j31lLI7CKIbG7BYTm5Cpm8og3/sMRDPw3WUG90SHBR1UBVanPXFA+nAxKkHEmmNGxaka3VbjfD11da7JeCe7rm0vHFKZSi/Y63MfDJJ/VQh5wPHiMlZleiITYUIThPlg75xZTRQ5d4AafR8c/xC6g8uOy0wxweuN95iqvhLvCGGWOySFC8ReI9y57uQv9wFVc1QU8Oa3d8RnJhD3GP+aZS6tD47Otd9zsF5KGA==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by TYSPR04MB7761.apcprd04.prod.outlook.com (2603:1096:405:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 04:03:36 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 04:03:35 +0000
Message-ID:
 <SE3PR04MB8922E0F2DC7F68C00399AF78F3872@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Fri, 18 Sep 2026 12:03:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 05/10] iommu/riscv: support GSCID and GVMA
 invalidation command
To: fangyu.yu@linux.alibaba.com, tomasz.jeznach@linux.dev, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, baolu.lu@linux.intel.com,
 jroedel@suse.de, zong.li@sifive.com, andrew.jones@oss.qualcomm.com,
 anup@brainfault.org, jgg@nvidia.com, jgg@ziepe.ca, kevin.tian@intel.com,
 atish.patra@linux.dev, skhawaja@google.com, vasant.hegde@amd.com,
 joerg.roedel@amd.com
Cc: guoren@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org
References: <20260915032828.11250-1-fangyu.yu@linux.alibaba.com>
 <20260915032828.11250-6-fangyu.yu@linux.alibaba.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260915032828.11250-6-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0026.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::20) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID:
 <9fcdfce6-9433-4ab0-b0a5-68431b42df27@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|TYSPR04MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca4fa87-d5dd-4c6d-5df1-08df1539cf38
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24121999003|22091999003|25010399006|19110799012|12121999013|4140399003|23021999003|51005399006|16051099003|8060799015|19101099003|55001999006|6090799003|5072599009|15080799012|41001999006|40105399003|12091999003|2607281247196008|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjB0cEpXRTlpQ29vMlJ6a2RkbzQvYXBXV0hVNm40U1I3eHZpSHViT2xsdVc4?=
 =?utf-8?B?YzlhaUJKNWZxenREZzFPckxHRW85VHQyaTJvRnQvd0FqZjNQNk94T3RlZ0kz?=
 =?utf-8?B?NlhBUzdaalVwTTEyTnFGdzFyOVhJeVl3YmdQTnhpb25SMTBjYnBZYXpqT0o3?=
 =?utf-8?B?NnhGMDFBSUpPcUxscDY2ME82Tnc1dVlHb2dBdzVTemxjWFhtMWFjREJXWWVk?=
 =?utf-8?B?NSs3eVo3Wkc0OWpTSk92YThkalVwQ3VSUW0wTUwwUGpwckFFcTdYSHBFcDN5?=
 =?utf-8?B?TkphVTBPNGZiV3VvYkRjVmhlRWhRZzc0LzJsZ1cxUFMrRmZ6WHlIdkcxMXlv?=
 =?utf-8?B?Qm1ONnp4SjcyUTJ3d3U1c0hDZTZEWHB5d3M5YmV6MDhKTWY4ZHU4YWwvbkJW?=
 =?utf-8?B?T1J3bng2cW04OGpzMHBIMU9iVTFZNFhtdlNqSlhmV2NpVDMxdy9BbVRIR2VY?=
 =?utf-8?B?elNlU3ZYbkdUVDJKY2J4QkduWGxESk5MTml1Nk1NRmRnQ0pqV2tYb1lxNUFj?=
 =?utf-8?B?VlNiZEVRcG9qVm5qSWQ5cSsydml1d2w2ME9KRFVSbk01R3JwRXpCRkhRWFVi?=
 =?utf-8?B?SkRGV3J1VHV4NWZXeTF6djZQWklyYlg4RDhMaEtyamJySVNXRVNTRXBzaFZQ?=
 =?utf-8?B?aSt2SW5ieGFHeU8rYWFoM2JIODVXNXRSM1hyZUJKTzRTUVVrOHNmb2FaWTVV?=
 =?utf-8?B?eEUzNHltWTNValREZDZ6SlF5RDA4czNnQnVTSFpyemx6cVZENGtHcTNYWmxq?=
 =?utf-8?B?bVkzM0xvNXQ1THl5WWl3Y0VCVWp3eUxLQlorWDRyK1dTRkg2SU5KT3pIajFn?=
 =?utf-8?B?V2lodDd0YVBkV2tQb0ZabkN2MndIZ3ROdmExYzI2YjZLL3oxTGNDeUQ1Nytp?=
 =?utf-8?B?RmVGZVNuN1lyQ1lzRjdRQ0lrbzU0RUtKZWRaVStGWTljU2I3aEhSZVAyNXA3?=
 =?utf-8?B?RDlYLzh2NWF5QXBES01sVWhKN0NaYUZiVUtXb1BYMjdDMjJzMk1hb2Urb0tX?=
 =?utf-8?B?bk5ScEZBbmNEeVUwUElGSXlPR3VEeDd3Z0JGTlFPaXFrLzdGYjJFSTRZajg2?=
 =?utf-8?B?aStGL1QrRnppTm5wbjBHYzhZTjFOM2ZYdzdLVHZMakovVVcrcDJrVGJNLytT?=
 =?utf-8?B?elNjZTNnT2trNGU3V0JNWkNvbGpUTzk2RzI2aWZwQ1dTUnVrYUNKQ0NWZlFV?=
 =?utf-8?B?VkVxZ1JzTXQ0MEtOL0pEbWZaTk1scFpQaXFRaVBvSGg1WHBhVm51emxRQWJa?=
 =?utf-8?B?SnRhVnBGK2xsbUg5NFhNQlJGZDJFUEtEcnozRDJKSnE2OUcyT05PZWJUa09s?=
 =?utf-8?B?NlBscW1qN0E4SWJlTzZBb2VteFhmTHdaeWhWdTFmUkFpTFFXVUxPbHhyK3d2?=
 =?utf-8?B?QUJBa2NDcGlIR3FEai9xUDBSekhJeEx1OXVkb1hpMkNUcHF4bmJyeVpQNkxq?=
 =?utf-8?B?VjFIeHpkOC9vSDU1djJYRUR3aXdoSnNacnpMMitwbUhRREgxUkEzL0ZMZjBK?=
 =?utf-8?B?RnFQdnY4TXByWjEwYXVROU1mMkdUQWRZbnpNdnhtYjVtMEVMekN1WHZCcTht?=
 =?utf-8?Q?OJKmXA4jO0kRPPInOajB4XH5Dyb6QMWV7geAceZPZT6UgU?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UStiQy8zTzhpVlUwV0M0cUpsaW13RllRQ00zSDhaOW1XZzlQNEtmeWVWZlJG?=
 =?utf-8?B?ZDA0bDZ2OUN6TkhONGRKanUxMDlUUjFMZmY0VlFLSnp2UWNmc0N2U2ZzVWJx?=
 =?utf-8?B?VDRaRUdEd0tTT3VncWkvTGtHQTNRYnhNRTV4cmlZaU9zTzNSWjJjN0RIS2pw?=
 =?utf-8?B?dVFWTUp5U3Q3N01Bc0NoOW5JWHZtZEpxZHZGYnE1UzdST2ZtNmVNeHQxZjFE?=
 =?utf-8?B?bVF1Nkc2cTZ5SWRqNzY0YXo2cEltY0xzMHBSKzl1WG4yR3JpMVVISVRhWnlp?=
 =?utf-8?B?cGpLZG43eVIyZUFlbGhuRXBRWTdGZ3BLWlBhbHEwWmZNZXBkUm9HZnYrZ2N4?=
 =?utf-8?B?WWN1QkdncXFIUGl6TGlNYVVsYVd3SG4ra1c2OXdLQklkNEJGUkord1Y0dTI5?=
 =?utf-8?B?MzVOWGxJblN3MmNJdTRqVjFpRms0bDVPMGFMNVRFaGhycndRcktlUno3bGs0?=
 =?utf-8?B?RVIvWlBuQjFFWVp3a0h2czNqekZnaThJM1JQK1JQOHhSYUFYT3I1Y3ExY0pK?=
 =?utf-8?B?OUdaMFkyK0F2M0p1RmRXdGtNSGwrVUFqMEhybEtSWGVrbDNHTXNoN3F5aFBC?=
 =?utf-8?B?ME8wV2tqMGFNMjJpZWNjdXBvRmdLb05mR2I4NUpweTM4eHJ5NU9ZQys4YjNI?=
 =?utf-8?B?SDhCQ1hvcVRabXVUOE8yTW5mbnBsMVp1Y3lkd2RyYm1UT2FXMGUyZjJxS2NV?=
 =?utf-8?B?SHN6MmZXM3BjbjQ0SHhpeWdNaEszVmlPVnJVT0pIVkNROTQvWUtJZ3Jwc2Fi?=
 =?utf-8?B?d2ZyRDNBRTk1Vk1YdUpjUE80d28vQmV4UU1VWWpUc1o1K1paUFA5RlI2QXpL?=
 =?utf-8?B?cFZVbFVlbGpDdVVOZElsK1NiUHVzK21kLzZOK0xHcGI3eCs5Q2NEMnJNQ0lp?=
 =?utf-8?B?Y250MjNmY3VqemFvY1RQYncwa2owclFJdnBlMU96Z2ZOMTVhMVdwWUpYTzRi?=
 =?utf-8?B?Zkg1YlNaWXZ3MVQyYXRISmNqRjkrOWMxVmpST1BHTHo2VEcvdjYxQk9LQnVX?=
 =?utf-8?B?ZitpeU40UlhJNUhpaCt6OG9uaitBQURWaU5XUEtiYUFXSTZNOEV0NERYRWlz?=
 =?utf-8?B?Q3c1M2pCS0tDVlVmTEhQWUFTTVRic1YvOWlyOHlIVUZqODljeFVKTVBCRStL?=
 =?utf-8?B?Q0FubmExUnliNmIrT2pNMnAzdlRJZXFUMXY1N0FUWnljdGtnQ0lDMHVXazFO?=
 =?utf-8?B?OE5EODFEUWZDbGlFSWg3aGJuVjlpcEZka09aU2tDck5ZbW4zYXgrRk1kbjR6?=
 =?utf-8?B?TUpzY1ZFUC9nVlVVdlZLTGw2c2oxUlRNMGtoQUs1WUw4VnphblZFdWhrdU0w?=
 =?utf-8?B?SUxoMXdqTEUzL2F3S2FSb3FuM0trZ1B6enRzUzFubXRVOGZEUFF3dVBqRTVE?=
 =?utf-8?B?WmorUjBQOExDZ1ZwdThJalljdG83VVNQaEppRzgrbUxTRWE4QjhjZ0JSV2My?=
 =?utf-8?B?UldHNHZic002TlpBVHhRMnM0dk9lOXowMlRVclJDc2pSU2NnbXRJV2xCT1p5?=
 =?utf-8?B?YS9uSTEwZlZoYUVCODc0Z1pjRU9IYkpkNkVFeHlYUUNuVm5xSXNUM2RmM1ZC?=
 =?utf-8?B?NUZ0UDlHRnRzenFwa084dUhnMVpobFY4eWdhdzNnd3g0ZE5rd2kvd0ZkZGNz?=
 =?utf-8?B?dVYwcGUzRGw3MXBMTVpPZTcrdUZaMHZ5U2tFQmJNR1VvOG9xYWVPNW43UW8r?=
 =?utf-8?B?bytsVWVURmFhb1BjT2JDNy9xR2JwZTFiNjVrRjZlbFg3Z3FoUHZQM0VKNENR?=
 =?utf-8?B?YitwdTEvNS9lampmdEFHOGZYODdoNWM0RW91cnF6N0MyN1NiWExLclJGRGNN?=
 =?utf-8?B?S3V2dFZtMnUwU0MyMjFydnBYbDluYWp3dVJpd3B2MDBXTUlsSjRYOEVKZmdH?=
 =?utf-8?Q?wFDrvJkZ5rLSq?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca4fa87-d5dd-4c6d-5df1-08df1539cf38
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 04:03:35.5041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7761


On 9/15/2026 11:28 AM, fangyu.yu@linux.alibaba.com wrote:
> From: Zong Li <zong.li@sifive.com>
>
> This patch adds a ID Allocator for GSCID and a wrap for setting up
> GSCID in IOTLB invalidation command.
>
> Set up iohgatp to enable second stage table and flush stage-2 table if
> the GSCID is set.
>
> The GSCID of domain should be freed when release domain. GSCID will be
> allocated for parent domain in nested IOMMU process.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   drivers/iommu/riscv/iommu-bits.h |  7 ++++
>   drivers/iommu/riscv/iommu.c      | 62 ++++++++++++++++++++++++++------
>   2 files changed, 58 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
> index f2ef9bd3cde9..65d1f2250011 100644
> --- a/drivers/iommu/riscv/iommu-bits.h
> +++ b/drivers/iommu/riscv/iommu-bits.h
> @@ -720,6 +720,13 @@ static inline void riscv_iommu_cmd_inval_vma(struct riscv_iommu_command *cmd)
>   	cmd->dword1 = 0;
>   }
>   
> +static inline void riscv_iommu_cmd_inval_gvma(struct riscv_iommu_command *cmd)
> +{
> +	cmd->dword0 = FIELD_PREP(RISCV_IOMMU_CMD0_OPCODE, RISCV_IOMMU_CMD_IOTINVAL_OPCODE) |
> +		      FIELD_PREP(RISCV_IOMMU_CMD0_FUNC, RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA);
> +	cmd->dword1 = 0;
> +}
> +
>   static inline void riscv_iommu_cmd_inval_set_addr(struct riscv_iommu_command *cmd,
>   						  u64 addr)
>   {
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index c5b6214ee672..99f05f1db35b 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -48,6 +48,10 @@
>   static DEFINE_IDA(riscv_iommu_pscids);
>   #define RISCV_IOMMU_MAX_PSCID		(BIT(20) - 1)
>   
> +/* IOMMU GSCID allocation namespace. */
> +static DEFINE_IDA(riscv_iommu_gscids);
> +#define RISCV_IOMMU_MAX_GSCID		(BIT(16) - 1)
> +
>   /* Device resource-managed allocations */
>   struct riscv_iommu_devres {
>   	void *addr;
> @@ -819,6 +823,7 @@ struct riscv_iommu_domain {
>   	struct list_head bonds;
>   	spinlock_t lock;		/* protect bonds list updates. */
>   	int pscid;
> +	int gscid;
>   };
>   PT_IOMMU_CHECK_DOMAIN(struct riscv_iommu_domain, riscvpt.iommu, domain);
>   
> @@ -981,7 +986,7 @@ static void riscv_iommu_tlbi_calc(struct riscv_iommu_tlbi *tlbi,
>   }
>   
>   static void riscv_iommu_iotlb_inval_iommu(struct riscv_iommu_device *iommu,
> -					  int pscid,
> +					  int pscid, int gscid,
>   					  struct riscv_iommu_tlbi *tlbi)
>   {
>   	bool use_nl = tlbi->non_leaf &&
> @@ -989,8 +994,13 @@ static void riscv_iommu_iotlb_inval_iommu(struct riscv_iommu_device *iommu,
>   	struct riscv_iommu_command cmd;
>   	unsigned int i;
>   
> -	riscv_iommu_cmd_inval_vma(&cmd);
> -	riscv_iommu_cmd_inval_set_pscid(&cmd, pscid);
> +	if (gscid) {
> +		riscv_iommu_cmd_inval_gvma(&cmd);
> +		riscv_iommu_cmd_inval_set_gscid(&cmd, gscid);
> +	} else {
> +		riscv_iommu_cmd_inval_vma(&cmd);
> +		riscv_iommu_cmd_inval_set_pscid(&cmd, pscid);
> +	}
>   
>   	/*
>   	 * If non-leaf entries were changed and the IOMMU doesn't
> @@ -1074,7 +1084,7 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
>   		if (iommu == prev)
>   			continue;
>   
> -		riscv_iommu_iotlb_inval_iommu(iommu, domain->pscid, &tlbi);
> +		riscv_iommu_iotlb_inval_iommu(iommu, domain->pscid, domain->gscid, &tlbi);
>   		prev = iommu;
>   	}
>   
> @@ -1208,6 +1218,7 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
>   
>   		WRITE_ONCE(dc->fsc, new_dc->fsc);
>   		WRITE_ONCE(dc->ta, new_dc->ta & RISCV_IOMMU_PC_TA_PSCID);
> +		WRITE_ONCE(dc->iohgatp, new_dc->iohgatp);
>   		/* Update device context, write TC.V as the last step. */
>   		dma_wmb();
>   		WRITE_ONCE(dc->tc, tc);
> @@ -1258,16 +1269,19 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
>   
>   	WARN_ON(!list_empty(&domain->bonds));
>   
> -	if ((int)domain->pscid > 0)
> +	if (domain->pscid > 0)
>   		ida_free(&riscv_iommu_pscids, domain->pscid);
> +	if (domain->gscid > 0)
> +		ida_free(&riscv_iommu_gscids, domain->gscid);
>   
>   	pt_iommu_deinit(&domain->riscvpt.iommu);
>   	kfree(domain);
>   }
>   
> -static bool riscv_iommu_pt_supported(struct riscv_iommu_device *iommu, int pgd_mode)
> +static bool riscv_iommu_fsc_supported(struct riscv_iommu_device *iommu,
> +				      int mode)
>   {
> -	switch (pgd_mode) {
> +	switch (mode) {
>   	case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39:
>   		return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39;
>   
> @@ -1280,6 +1294,22 @@ static bool riscv_iommu_pt_supported(struct riscv_iommu_device *iommu, int pgd_m
>   	return false;
>   }
>   
> +static bool riscv_iommu_iohgatp_supported(struct riscv_iommu_device *iommu,
> +					  int mode)
> +{
> +	switch (mode) {
> +	case RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4:
> +		return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39X4;
> +
> +	case RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4:
> +		return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48X4;
> +
> +	case RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4:
> +		return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57X4;
> +	}
> +	return false;
> +}
> +
>   static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>   					    struct device *dev,
>   					    struct iommu_domain *old)
> @@ -1292,11 +1322,21 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>   
>   	pt_iommu_riscv_64_hw_info(&domain->riscvpt, &pt_info);
>   
> -	if (!riscv_iommu_pt_supported(iommu, pt_info.fsc_iosatp_mode))
> -		return -ENODEV;
> +	if (domain->gscid) {
> +		if (!riscv_iommu_iohgatp_supported(iommu, pt_info.iohgatp_mode))
> +			return -ENODEV;
> +
> +		dc.iohgatp =
> +			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_MODE, pt_info.iohgatp_mode) |
> +			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_GSCID, domain->gscid) |
> +			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_PPN, pt_info.ppn);
> +	} else {
> +		if (!riscv_iommu_fsc_supported(iommu, pt_info.fsc_iosatp_mode))
> +			return -ENODEV;
>   
> -	dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, pt_info.fsc_iosatp_mode) |
> -	      FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, pt_info.ppn);
> +		dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, pt_info.fsc_iosatp_mode) |
> +			 FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, pt_info.ppn);
> +	}
>   	dc.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
>   	     RISCV_IOMMU_PC_TA_V;
>   
