Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012059.outbound.protection.outlook.com [52.103.43.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB742DB780
	for <iommu@lists.linux.dev>; Fri, 31 Jul 2026 04:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785471960; cv=fail; b=YhgIjX2ElwQglIshIDPhCB2kX+4nTagORVxU2BXq6mDdnXlwQxkH038EXnw4G85RF0v6okjfdoFjiSI9yGLQ75g/uvcuO45BFblF2ZGhPupDlnUCY7zJxPfWbNyCJkcWyr6h6fGN7FA4UMltTuiQMJXOjScUlmdTcbD0TGzHnts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785471960; c=relaxed/simple;
	bh=l2ecWjcPlY6lTEQe3iURbG7zH+CjaH86aZ9B4fcYPYQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gai1thG9uUeVvbYUP82WV1DvVD3SfaIS5/IJT0911oik7xMjsTvkbpW/+ypUtOLF7+iiLBP2xPGB+iWRdffnpmtYWDjA56QJ0s1eCpyKLcbd9xtGOE9TSU0pnqHRWiTKzkUAaH0eHXNTHjpBtFquwwVsw8KbLxGZysfbxl3Oomg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=LDOX1D5a; arc=fail smtp.client-ip=52.103.43.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="LDOX1D5a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WR/4b5GmUFZS8l4+ftAbxeZKqVuiWUKlzXvZ4RDPmH188Uihi5Jazon12dIlPkEmKhuTrfN5xm+M6AeJksorIMrA4FjPUaYt+aAc4L64Y6H9HytHALKm+u8rnKiYBq5DXAAH19JZO0dA3i3/KBYOxjrSmgjGfKVCJrPXQtsAOnvVkKZns5yMIjwx4ZuEsbMuCgS4gpr6ZxlinNn55c/hWv78GjlnyfYAe3X50SgsK+PPPIb+DSZhfyJl3DLUOr2Btn05k84wCbY3UhF+fL1Z+NqW1Xh/VrHFyj4O8jrgUaxAGCTQnW7Ro0U6mHlOw+jAh5J1AhKiN8RctyY+6nYuWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYgVr3z06QfdeVM+cZKFwOMEqQm623cGmpcHjIrT65c=;
 b=OI09P+DyUflmKdnb8dvKUT/GR4eJkYM//Of+uIA/7vWyNTSavMFSPVXrCysm6J9SDBnf0EV5IZHBaJde/+3kCX+K+zeg68f9wnaeTegadA5bO563ToskBW2TPWI0NSh/yAjv5U89rYgMFFSJ7xU8LtVeUlLkCC/jux9cijMmDPwDwAvQzSLooBgcGXS8BNaWFljcuGkYW5DWfjFS8a2Uy3tEV+PZ/3UqMcqGyf1Q+HbaAHm/eZO2yLnkOah1H5QRwmS40sWXzsZ8nvP8d/mcxoum2F3tWhTxn2Us6qtYXQ4A9yigU8zfWYHDz7AD8el0DUzFygTWkgKBTCDgUxcidA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYgVr3z06QfdeVM+cZKFwOMEqQm623cGmpcHjIrT65c=;
 b=LDOX1D5aD8JXRg9ecjLO0sCscjXWQiHqubjZZscnsrGuBM0LNL2FMu+eJVm3dlw6ZSpEhCf3fSKiWqqEV5CmeB7NSdUtcbdoyRJtitNN3IAYP7oYzgYlNMnqz1XNV5D/KnsirCpUjaCWZkXKdYfeCP15KUPmqcflZcUl4njt8FOBIWwvPF6WKuwVFeq8G6dTe6PrizSjym0TQlFfzXrdTu362uQx9U0YOsmPtTL1vRNWdPdqCaMaX6lUGcLArBzGTrdOLHsn16TWvl4avC964PXKqNySolEdG8FNCEJmvUWw/y6+r7LCSIpR4XZ4+USVEvBY+DfQVJECp2b4O9IiYg==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by KU4PR04MB9296.apcprd04.prod.outlook.com (2603:1096:d10:7d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.10; Fri, 31 Jul
 2026 04:25:52 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0292.009; Fri, 31 Jul 2026
 04:25:52 +0000
Message-ID:
 <SE3PR04MB892283365E2966E3FBD23775F3C82@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Fri, 31 Jul 2026 12:25:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/dma: Restore locking around msi_page_list
To: Andrew Jones <andrew.jones@oss.qualcomm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
 nicolinc@nvidia.com, jgg@ziepe.ca
References: <20260730132323.1428473-1-andrew.jones@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260730132323.1428473-1-andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0183.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::16) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID:
 <c40c5fdd-fc8b-4593-be26-9a7c73b7d1c3@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|KU4PR04MB9296:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c40848b-7b8f-4daa-38f9-08deeebbce0f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|19101099003|55001999006|15080799012|5072599009|6090799003|25010399006|4140399003|8060799015|19110799012|22091999003|24121999003|3412199025|4302099013|440099028|10035399007|52005399003|40105399003|26121999007|2607281247196008|1602099012|1141799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zm9tc3FaQVRNbVZBeC94M3JxRWZUZUN3ckxWcEtwcDd4T1J3V0IwNTdHTXUr?=
 =?utf-8?B?R3oyaDVOT1lCYm13MlVPRFV1T1NrSHJ6cjZpL0FTdHR2OTJEQkpQNHpKemE2?=
 =?utf-8?B?K2JHcDdOV3JVdHlmSFR5TmZQMUREcHdhc1RyTFIxaWtYRUppL0NNSkVTVnZX?=
 =?utf-8?B?eWIrV0lkYUlkYXpBeXZOL1BXbTYzY05JdXQ1RXpYckRObW41TDJiYWhvRUFz?=
 =?utf-8?B?Z1NTV3BvUXJLcm04b09uZ0hTRk81Uzg0Sk1SQ1RFTCtzREx4Z1I1SWNGcTRq?=
 =?utf-8?B?cllZZ3FVb0tHMWpmRDN1UCs0ZE5RSzl3RWlEd1JzRlkrR0QwUG1UT2VFQ21x?=
 =?utf-8?B?S2FOYXFCQk43NzVYNXJReXJ3bDRDZEczbFA1bFZ1M1FiZmhXZnU3Slh1NHhh?=
 =?utf-8?B?U2lTQmRXbTl0S3llVVpSbjdGQmJtK1RldkhvMGJyQ2pJbHVpUFRZYmo0WnBy?=
 =?utf-8?B?ZWlZMENtK3RRcVozK3Z0SElhTFI0YkRQZER6N1lWcTFzY3dROXpFUUhnTmlB?=
 =?utf-8?B?SWhhcHRUcGhmYSs2NjludnFyUnhjQ0JZNWF0dWVJbllkMm5CVEJCdlk0RmlC?=
 =?utf-8?B?RUJFcFFSRGNLNVByd1JHeFcxdVBPL3FXakFlYzMvSGRvaHQrSXYrUGNIQ1pW?=
 =?utf-8?B?Q0NEczIwT1ZTTlRBRzFUYy9IRzBqNkNPUXIrb0wwSDdaSUxFbVhzSkxYTkdN?=
 =?utf-8?B?WjlaQWVDVGpQNEZJRkhHU0t1aEZxdXdRTUUxc25pL0t1Z01SZlYwZGlJVnFw?=
 =?utf-8?B?ampoZXNMdlRmSG5kQ2Q3eWVBclI3c2dwbTZKZVpzS29ZTFBmc3BNUmFDQ0lJ?=
 =?utf-8?B?cXd6VEcvT3JXdWtCbjNIbnJGZmdQOHVHQ21Sd3BpSXAyYVI5eUlydE9tWXpx?=
 =?utf-8?B?bmthVEgxcFRlVFNScGxIc3RoSm1acTloVHZKNlZMTS9mQnpNSDdSNnRRdDRD?=
 =?utf-8?B?THZKNUNSVFl4M1JjaWJqVGhtVU5COFJjdnZDRXZ3cmdLMmEyQ3FFbi9qV2RW?=
 =?utf-8?B?RXduT1Buam5lZUVlWGdDUWRmWXlwWld4Mjd2cGFyMjJJSzFVWVN4d21MTVhB?=
 =?utf-8?B?SWR6RTVHWVJTbERZTjJGZjdBOVdCZHVYZTRSbXJMdExDdW05NStoSHpsTitz?=
 =?utf-8?B?RlFjSExNa0tLRmlEaW1pRm1mOVlXZ1dZZUErdzQybjQyN1ZldXlDMFoxbnl3?=
 =?utf-8?B?NkhyK2FiRlcrODZUVUREZXozdSttQWkrUThqQWRHZHRITG90NnhMRVJyWTdZ?=
 =?utf-8?B?cDRtcmJ0U2lyWUJEUkZBdTF3OGxncjdpdkUvdWZiQXc1S0p5MVJsOVo0aERM?=
 =?utf-8?B?NEZMVWZPZFRZUXRwOURobzBVc3Z4WGQ3MjhTWlhJVUgwUk5iZGlYU0RBcm44?=
 =?utf-8?B?TDBEb3FFckMrQ2swMThRZXZJeXNIMGxIUStCeDNQZjZ3RnJldFgvcnA4bVN0?=
 =?utf-8?B?UnBuTWZWSmlNTmZwUHh2aXdmWXdLWGs2bzE0eHNxa0R2V1N1MllSd2Y2aUNH?=
 =?utf-8?B?RzEvakFqZWxZUEFVeGNVaktDTEFFcWJ5dE5udU9BMFlpRXRjRHlpTFFyU0pn?=
 =?utf-8?B?Zk9DZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVB2NjkxWkZ3RXNqcERMTnZTdmoxajEvdlVEUGpKc2IzM3V0VU4xUFozQThO?=
 =?utf-8?B?M3JRM0FVQzhQdlJZbGtQRjhOLzV6WnB0bHc5QXhId2VvRkZGcFVkNitDY2Jj?=
 =?utf-8?B?b1hVU1VzZFB5cjZTb1RnR0hUR2tGNTN0SExHS0RXNHBvZ1V5N0M2SHc0Qzh0?=
 =?utf-8?B?MlVjSUNkaXJTRUQzSXNwQXlJaVllemJEYXVLamdiRmQzWmxrSTE0WWFKNm0w?=
 =?utf-8?B?ZlFHeHRiZHg4S1FwYkdZOFlKbVJsL25IdHNrQXJGc0dzWUxZVkhtbUxoWEhV?=
 =?utf-8?B?TERPVldyV1VBb3ZvUDM4WlpBYXpReEoyZ2tvdEZrOCtocUR1NkdrMHBlYlNk?=
 =?utf-8?B?ZlFXaTZVRjFqaHF3cXo0cHhCUS9DUy9EYjlQdWk0emdOczZhS3ZhL2dMTEZM?=
 =?utf-8?B?Yzdtek0xYlh1VUsxWDJrYVJDUUhudnBYQnFIMUFSWllldkpNMjJmUS9zYmVP?=
 =?utf-8?B?OFVMRm9MVWZ2QlM2K2FJS25yRUVkMlBneEZRY0hYaU45M2RHNDlscCtRWUVM?=
 =?utf-8?B?c1JsWElYczM4R2xIR1NaRDNnL2hCNlNoSmdYUkVBd1hJem05ZEVuYno3Vy8v?=
 =?utf-8?B?NU5OVjB1a0lqZk54TGFkaEx0QlEzRG5XVDhhYlFWYStSVjVyTTJCNU9DendX?=
 =?utf-8?B?SGJKRGNNVXBLQ3pvdi9JWkhoOEhUT292WDE5RkRvUDdpdlc1TGZMNFdiQlVG?=
 =?utf-8?B?WWYreUZvNCtiWGRhbDZ0UUtWZEVkZzRvbVQyUzhxTGtrRHk3WVlLaVo5WWdr?=
 =?utf-8?B?UU1KbmVPN2tVLzhqaGJFaHlJUllHNkVQK1FFMGhQRmFwUXZ4WTNGNnlHK0pP?=
 =?utf-8?B?VGZ4L2xEK0NibmtlRkxSbGJuZk5YV2dwWStMNnlLOEFrdnVwN3RmNnlOamVx?=
 =?utf-8?B?aGdxM0dpQTVwZm5YRUJ3Qkt4SUVlNldKeUN3Yk43QVdRZ3lDYWNQdkVPQ2dE?=
 =?utf-8?B?WVAxNkpxc1JZcjdxNmxIZmtybzVVOE5uWCtqMHRzamJIRHpTQmR4WDN4Q2Rs?=
 =?utf-8?B?bjQrd2ZDamtaRC9Ba1dLU292cUk5RG9oR2hDQ0c4RzhSckdvWHlOcHNDalNE?=
 =?utf-8?B?eURIVXVsR0ZUMU1adXBvbXcyOWVFckFhS1JDaFlBb1o4RzJQRUV1QTBQSkht?=
 =?utf-8?B?cWlaS2FVdFExQUw0TUp0UVFmdzZJMzVDdW9JaUs0d0hXM3VxTGdCdG1VK0wx?=
 =?utf-8?B?VDB6L3ptSFBZdktINmhZK1grYUZFUVg2c0IyMmJqS25wTjY3Y3pyck5CTzU2?=
 =?utf-8?B?YWwzbTBnQlJBMC9sNlRwU3RWQ1dxcWh5QlJWc2VLQ054bUNzbTFRaTB2MVZ1?=
 =?utf-8?B?c3hXVXpsQzdjMGtiNU5hNTZZb28xME1YT1ZSMXRnanJuU21CS3RHQ1lWV2pv?=
 =?utf-8?B?NGw3eHdCY1ZMQWw0S3ZBekZJTnpQdkw3dFhuaDlBT3JicjdLc3FwVXl1am9Y?=
 =?utf-8?B?amE1V2JwWDZqd0xWNEJDVDk2SGNKNXQ2aGppY0VOakk0ZGhmUGtyZWhUbXlE?=
 =?utf-8?B?Sit6K2dTZE4xcHkyajI1Nmo0bm5XcXExdDhsWFRMaFp6ekZOZVlKdGlLR2Nv?=
 =?utf-8?B?dE1ha3dNL05FWHM2dk5TQkM4OTNKK3A5MU1HUTVJSVVSR1ZGamtRTmc1eXUz?=
 =?utf-8?B?b2dOWG04Nks4cTJWV21oNCtzSEJmQnZ5YkdnWWZ5M2FBcnEybmQ0WUZFUnBL?=
 =?utf-8?B?RUhyeUROMmJZN2dPR000cGh1djVjemVnVWNwUzJQT2xIMnhpUXRTU1BqNjAr?=
 =?utf-8?B?Rm9yRWtJSnRDN1RMZ2hUWER3bThDdEd3UlhMV29xdXNuNzNtODE4cTlNWFpu?=
 =?utf-8?B?ZUlVTGVaRG1CWlE0b2I3QkJ6UjdKZkUvc0JmMFd4RW1rWnVLaStxSitKQXhV?=
 =?utf-8?Q?OlJBISa4U9K90?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c40848b-7b8f-4daa-38f9-08deeebbce0f
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 04:25:52.3659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR04MB9296


On 7/30/2026 9:23 PM, Andrew Jones wrote:
> Unlike a group's default domain, which is always freshly allocated
> and privately owned (iommu_group_alloc_default_domain()), VFIO type1's
> legacy container merges any newly attached group into an existing
> domain whenever their iommu_ops and cache-coherency enforcement match.
>
> iommu_dma_get_msi_page() only asserts the caller's own group mutex is
> held (iommu_group_mutex_assert()). On an IOMMU that publishes
> IOMMU_RESV_SW_MSI, e.g. ARM SMMU, a VM with two such devices assigned
> through the legacy container can have their guest drivers probe and
> allocate MSIs in parallel; each host-side VFIO_DEVICE_SET_IRQS lands
> on a different device fd and group mutex, but both devices' domains
> are the same merged domain, so both can enter
> iommu_dma_get_msi_page() concurrently and corrupt msi_page_list.
>
> commit 288683c92b1a ("iommu: Make iommu_dma_prepare_msi() into a
> generic operation") dropped the prior msi_prepare_lock on the
> reasoning that "each iommu_domain is unique to a group," which holds
> for default domains but not this VFIO type1 case. Restore the static
> lock, since it's only guarding a corner case and will likely never
> be contended.
>
> iommufd avoids the equivalent problem by having its own callers
> (iommufd_sw_map_msi()) take a ctx-wide sw_msi_lock before ever
> reaching the shared list. VFIO type1 can't mirror that since it
> dispatches to iommu_dma_sw_msi() which is outside VFIO's jurisdiction.
>
> Fixes: 288683c92b1a ("iommu: Make iommu_dma_prepare_msi() into a generic operation")
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
> Sashiko reported this issue while reviewing a riscv iommu series[1].
> I've only compile-tested this fix.
>
> [1] https://sashiko.dev/#/patchset/20260724151218.965929-1-andrew.jones@oss.qualcomm.com
>
> v2:
>   - switched back to statick lock as 288683c92b1a had [Robin]
>
>
>   drivers/iommu/dma-iommu.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 9abaec0703ef..9a07eb39336e 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -2204,6 +2204,19 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>   	dma_addr_t iova;
>   	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>   	size_t size = cookie_msi_granule(domain);
> +	static DEFINE_MUTEX(msi_prepare_lock);
> +
> +	/*
> +	 * Normally a device's default domain is only ever attached to that
> +	 * device's own group, and the group mutex held by
> +	 * iommu_group_mutex_assert()'s callers is enough on its own. A VFIO
> +	 * type1 container is the one case that breaks that assumption: it
> +	 * can merge devices from different groups onto one domain, so two
> +	 * devices' group mutexes don't serialize each other here. A static
> +	 * lock is sufficient due to the expectation that this is a corner
> +	 * case that will never be contended in practice.
> +	 */
> +	guard(mutex)(&msi_prepare_lock);
>   
>   	msi_addr &= ~(phys_addr_t)(size - 1);
>   	list_for_each_entry(msi_page, msi_page_list, list)
