Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013085.outbound.protection.outlook.com [52.103.43.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50994348C75
	for <iommu@lists.linux.dev>; Tue,  1 Sep 2026 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249180; cv=fail; b=J3OClO5FHD0XNdd8k4K+Hwk6PfkG1uGSljaViIKvCFgkliwngm7hZqEUyx3nyg6+bHO0u1OD84Vqe9XNwj9cHOMNgkXrHAOFhyCv60bHqJ03wzwMzy/AmO7/aCT6iwYCxyyASbu116NK4uCg6ATMvHmNANMdGZw6qLMD96hJF6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249180; c=relaxed/simple;
	bh=ehOHTWZNLUOlzMISuMT2fbmY2JZ0lFoMJZfX3SUBu0c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=blU5CEYOXDKIKWj2Xn5OVv2m0Gk0xe0MHBo7SxQwhYX7h1J6kM02WVLNVQCEPdtEIiACDLzSj8BUuTGNaUyzh7rkVbxXFgxyTFbdUqJ/mycwdVCYmN61M9NhiEBb+x/0KbrSeaOEVGF9yn/kLY450Hc05rNjnkd/BTOvPpbPou4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=E7+bI9Oz; arc=fail smtp.client-ip=52.103.43.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="E7+bI9Oz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRo4ddttJJkPMaFS5bXzWF9fHcjwvGqMw6pkon4e6T6/rofJTSPQWtilp3pHi4oWGEGDgzM+mCabmPyOOWzBK8ZNICFB0ZLn4wMxh4lM1Zm2Y6mb1/U7nTnGTefByCosPrRlWjirc9Tlx/wOyYWUFBH77qW5g7jVv9Q8y33LVP++6AT20tWlIoq4ywGYfW6PMv93EpJ2iqD08hMgVY3gnm8d2pMW+Z7uRMyrXMhGsXaFvRib/zYgVASolL77pdop/FN4ymeHwS1qmlAssKfY25sjB7nKQaIrkRJvhx5DGa3yKYN601KMbIPuLkoKnhjiv176w3Zuog1/MTAsJ8T1BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNyt63D2q+wanEOtPcVDqHMyhKZ1//zPysJDrEhDYXk=;
 b=J86OWnCNg9aM4J2ZRvIVAOl2xgH/Soh3Hv74scjAGIi8VfF76zoEHrYwmw8v6jZidOLvhM/AxNmt/V1Szkb9LjKK+X/C1qaZWsglXwLHRCBr2/DjeGpQqFq/pZjaZFZZprEr07vfbc1+KQ5+l3pmuwG+n/zTGmKKoqf588aiPvMWnstLwNcArLfYh/OuE//0rkepqGTNQSg+CiMZigr4HwegEsxA1npJ7KMqG0pQRem2ane2x0pkMOyyhKvIJX7tpgM02+se1oxfQf0oclEouDvQPU4dbVtHWAdlu9Sdzi0O11FUCTlV9gbpfGCOzRJPt8HGwugFkm28pCOGFcLs5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNyt63D2q+wanEOtPcVDqHMyhKZ1//zPysJDrEhDYXk=;
 b=E7+bI9OzAog6xAXMgIwju1/PSyCecFa1QKjqZI349e/NHzdO02NjWKV9gwEBXsBE98W/G5XCNpiv/0Zm7eWsYkB8ik2pDdYTr3m0B1Y3KfMDLzAAaP3Ng4P7g9RkidOZLttlBimWb8Hogtfp4Auvv9tMONO87e7g3pHSuVKYQqrBAPbsVPUT5cCgO5PWRNljBXKFthLoCleM33FPE9k3btr4vSbHdqrmH3nFrroHjhkNGOB4wh2KvauvDwD4YEXj7B2Bkjwyu4dPkNzy2Eu6a2YInXQHUi0bDLx/PReDdejYJhDBEJaPfkMUo/FumA5ga5+x062vGtoVUj8qBfxR6Q==
Received: from KUZPR04MB8925.apcprd04.prod.outlook.com (2603:1096:d10:46::5)
 by TYZPR04MB5680.apcprd04.prod.outlook.com (2603:1096:400:1c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 07:52:48 +0000
Received: from KUZPR04MB8925.apcprd04.prod.outlook.com
 ([fe80::e3dd:6f77:3be9:b71d]) by KUZPR04MB8925.apcprd04.prod.outlook.com
 ([fe80::e3dd:6f77:3be9:b71d%7]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 07:52:48 +0000
Message-ID:
 <KUZPR04MB8925FC23C61FFB353A126EE7F3A82@KUZPR04MB8925.apcprd04.prod.outlook.com>
Date: Tue, 1 Sep 2026 15:52:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/17] iommufd: Convert struct iommufd_sw_msi_maps to a
 growable bitmap
To: Andrew Jones <andrew.jones@oss.qualcomm.com>,
 linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
 tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
 fangyu.yu@linux.alibaba.com
References: <20260831145943.313726-1-andrew.jones@oss.qualcomm.com>
 <20260831145943.313726-3-andrew.jones@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260831145943.313726-3-andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PS2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:300:57::15) To KUZPR04MB8925.apcprd04.prod.outlook.com
 (2603:1096:d10:46::5)
X-Microsoft-Original-Message-ID:
 <8299fd99-bfd1-4640-832d-dda9de19fd95@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KUZPR04MB8925:EE_|TYZPR04MB5680:EE_
X-MS-Office365-Filtering-Correlation-Id: be774bc2-5fd5-4313-158a-08df07fe03a3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24121999003|12121999013|41001999006|5072599009|6090799003|25010399006|4140399003|22091999003|23021999003|19101099003|55001999006|8060799015|19110799012|15080799012|51005399006|3412199025|440099028|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVVJeXMwY1hxNHVkbUpNVnJ6VnhRUTl6ZnJjVmZJMFhaYW1tenNlMlZ1UU50?=
 =?utf-8?B?emZoTkY3VWFuUFZOOE5jT08vVE45Z3VId2hOZlRrdjIzcENiTnZNaGNBdkh6?=
 =?utf-8?B?YXlwWG0weVBIaThuQmN0Q2N5U1U0bWZPOW1lM1VBQ1U4cGRaWlRXcXRTTGVa?=
 =?utf-8?B?Wml3SjNKdUt3QWdBOTdhSjBJZ1R4ZWVpbXNYeDAyUnJ2WmxXR2JzYlp3Rm5O?=
 =?utf-8?B?cld1YXhyUVJmWE1aTnNRYzhSRm14bDJFaGR2RnFyaWpoMXpPRkFTWEJ0eEFE?=
 =?utf-8?B?MWFBSWwyanZra0ZxbG52R0ZseVUyYU5FYUlCbEtteFExZnFkd3czMmYrMzZk?=
 =?utf-8?B?VjlCY1d6MVcyYkhDUkh4VjZ2OVJsN0U0YUhFaTh6RGhPb2xNWDJBaDczYTB3?=
 =?utf-8?B?eW1zZUkxSWlhcmhza1lsY3N1bk1pRzIrT0dCWGE3Wm5kSG9EWnFNQ0h1aVBq?=
 =?utf-8?B?bGYyWHlNVFA0R205bVNDZ3V4UlFTRkhiYWtJN0g2MGhuV0NTQVpoNTc0S0hk?=
 =?utf-8?B?b3NyMnE0Nm5xcDNoNmd4dkRaQlViWWV6bElKT0UyY0JTMjZJczNjdDJoRXBB?=
 =?utf-8?B?UWZ5T3dXL2ZuNTRMOHlJR1NtdDVZN01Oc2hORHBtTGNndU94ZVVjNEZWZXRm?=
 =?utf-8?B?TjV4RFRWeHNkWmFIcUUvT1RJZTVjOThVeWNCd0lIVXBsL01yc0VjeStaZS91?=
 =?utf-8?B?TUVybTFUSThZUFFCbUVRWDlBbXd1SlBlWFUxYldvODhaelJlQ2M2Vk52cllD?=
 =?utf-8?B?aXBSSXpHdjMydmlOOURycTZtZHFtS2dzMkFDRkxuY1lidkxDUjRJckQ3Wkxw?=
 =?utf-8?B?K2U1N21ULzFpMk9yQzlRZ3lrcUlkNG1TU0lmNXZqUXdkUzZSUUxqQjE2MnNo?=
 =?utf-8?B?WnVSRXFCd0pGNGxxQ3RPNEgzSlc2VXVXTlJTNXV4SEo0RjJLYm1JQ3hrcUov?=
 =?utf-8?B?eGx5cEhKL0Vnc0hEQXE5VGExK1ltelM5Uk90M3RtMHFKUEpSWDFKSFFyUjhB?=
 =?utf-8?B?N3EwOG1nM3V0Uk5vNVJkVlk3aWszOVFQS0FTbkNOdjIzS2d2dHFMaTc1eWhw?=
 =?utf-8?B?TXZvd2JONHM3Q1FOSllvb3ZvQURMcjN2RDJzbk5Oa0dXbVRBQUF1MjhISlFX?=
 =?utf-8?B?bDRiaktFRHZtc3F0aCszSFpHdWNNcE9CU1p0dDlRalpEQ3dqK084S0Ztekox?=
 =?utf-8?B?Zmd6YlIrNVpNbVp0MEd2NUtTaG9yaEhyYXRZdFhPbkkrN3g3WEk4VTg1UEFG?=
 =?utf-8?B?Wm11R3lmY1RHQ3pGdy80bUN1ekpjWURTVncxSU91Zy82bXdMS1VtOXU1WlMx?=
 =?utf-8?B?ZnAxYmUxdkRaWXQ0RzNnaGxCT2puNG1wd3FqZ0h4SE9TeGUzRUFCUytrNGNi?=
 =?utf-8?B?MkJaWVhGbEVZbytOWTh6RStmSktTQTdFRkxDZUdRZGZtRk9DZ3BmQ1hGbW5Y?=
 =?utf-8?B?ckRmQWZmMDFOZi9KeVJESzZsZ0U2OXp2akU2TkM4dm9OTUZsQVMvS3JML0Vz?=
 =?utf-8?Q?LUbTMPMCvr9LMm5YM35pIkYRdM/?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RG5zWjMyblFTWWh0R2YyMzN2QTRxUDZ2SEN6U1RPN2NjNEl6KzFHbk05MFNm?=
 =?utf-8?B?WURPYk1ER0FtZmtZRjdrQm85Z0FuOVMvMkIwMWlWTE5GVy9DSThMSmRrK1lM?=
 =?utf-8?B?a3Z5cWZsZGZETHlFYW5zUWRlQTJFak1JQzlZUDdySjlRMWlGK1JXVi81SUlW?=
 =?utf-8?B?U2NFSUlId1FOeFFpeXFyN091dmc2WEFYZ083c1U1MWJkaEtlaCtKN3ZuNmFi?=
 =?utf-8?B?ODVzajdDbXFUNjJOVDVyOHBFWUt5ZEx2WFdPaE5Xd2lpbGYxcWZtc0VsTW5K?=
 =?utf-8?B?WCtaN2p6SmltSllFSE9OTmZRZVVuNnVTbFFFUXlVNHdBMXhPNHRRdS9wa0tF?=
 =?utf-8?B?WFFPcDdvaHQxMWljakpaWDh4TTlBZEhiYVNPMCtDUVdobWxjYi84bEt3eUJm?=
 =?utf-8?B?K0UrQUNZSld2VW1wWTlzbXAwY1ZLYU5xMHBVeXdLeE82QVRST0VkRzF5MDAr?=
 =?utf-8?B?K1RIUE4rSkUzY3AxYkpReWhwT0VRTXlLMjVLTlpuZ0RFaGxtR21lVTNudjRV?=
 =?utf-8?B?MEpvc0Jva3V5MVlDNkNVNUo0T1luZ3FXOXVUQTdVa0RzMjZ1QmR6SUd3Ly9k?=
 =?utf-8?B?QXppaEN5UmxsZ1RxbmtpREZFNm84OEVwNlRtSFdKdU9Na2dIYk1OQU1xMXFn?=
 =?utf-8?B?MDN5bnF0a3MrTHRrSG5tUTdZaVNCakFjNlF3RDdVeDJXN2xtd2pLMVhJWXBi?=
 =?utf-8?B?MTBNR1cwdkNIcWhKZVhXUW1iVjZyT2t6Mkl6WWowSGhTU1Rob1lGVWM3TlJ4?=
 =?utf-8?B?amNTNzhnSXFsMnBGUWI4cSttZkhUeTM5OHBwR1JEcFVXREF3N3lDRGFYTjdC?=
 =?utf-8?B?bVl6QzdVYWpmVEZIc3lmaFVIOXNlVXZYYmlhVGYrUThxVitBRTY1em5UQzJt?=
 =?utf-8?B?QW9LUGw3aGZmVzExRkJSWEx3WlhMTlFWOWhIVThrSmNtZXpWTDl3bmVMU09w?=
 =?utf-8?B?ZUt0a3JVL0ZQYlVFeEZvZkZqYUdNUGtYVCtabHE0WVk0bjBiRTdZNEE3czFl?=
 =?utf-8?B?SGwraCs3dVBjbmRudmlrejNubWFKYmNxU0ozUXpEQzQ3eTNHSHZ3K2Q0K0dz?=
 =?utf-8?B?RDVkRktJVkdESnVYdUlHamNEekduNFRzNVNSekhhWFA1dTI3WGUxN0FDS2VX?=
 =?utf-8?B?N2ZRS3I0ZE4ycE53VWgwN0d0ZVpUTktDZlRadXNDN0tQYzdWdk9oVFEyRVVQ?=
 =?utf-8?B?NmVMdWdzU280cDJJK2ZXNjdTMERaYy9Dc3Z4aWtWbmlZUTVwN1ZjQ0JBWkYv?=
 =?utf-8?B?aGVCODRwbXdUYjB4Qjcxc0MycDlodGw3MzVCM1BWbjU5NWlQU1UrLzRXRS9E?=
 =?utf-8?B?b25Od2RwOFJ6MDFEcUJNUXQ3bU5aRHpMYStiVy9KM0YramIwMG13L2pvVWhh?=
 =?utf-8?B?RlQ1N01iUVFCT1ZHQk02QkN3ekJ1ZUIwSnMxMWVVc21VWnk4T2doQ2tOeVVk?=
 =?utf-8?B?cWd6R3V5Mk5NbzdpcWU5U2k5aTA4V21WbUMwN3ZRMmpHVmFFUDgrV21JTXg0?=
 =?utf-8?B?bFRSR0RHMnFPSUJmS1hSdmJtQmhscEt6NHN3YUFFcWwyUFA1RnArTzlzOXVh?=
 =?utf-8?B?d21Wem9kcFhTR0krSEZtaWtjNmJ3eVRhUk42OEkzTDF4SnNpdjF6dmJ2MzZt?=
 =?utf-8?B?U3V1YzVTTGdrTkZOdmQ2aWpud0FjMVF5TXRlQTNMTnR0STZPWWNFT2x6UlVL?=
 =?utf-8?B?Mzh0UHZZVkJGS2lnS21uZkw0RVR0V2lxOGtVc2h6NmxjcEdVVy8wQUdKOGdE?=
 =?utf-8?B?ZTZPamxvaHdzU09rbjdUWGsrODRabnNsZEJkOTFOd0ZyTE5RWDJBaEpUay9M?=
 =?utf-8?B?NWZibFk0c0N5bmoxZmRLZHpTcmVBSlc4UXV0aWFWZlhZYzdhdlBKcmdobFZ0?=
 =?utf-8?Q?PwVQoE6ylPkSa?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: be774bc2-5fd5-4313-158a-08df07fe03a3
X-MS-Exchange-CrossTenant-AuthSource: KUZPR04MB8925.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 07:52:48.5429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5680


On 8/31/2026 10:59 PM, Andrew Jones wrote:
> struct iommufd_sw_msi_maps uses a fixed 64-bit bitmap, limiting each
> group and hardware page table to 64 software MSI mappings. RISC-V
> interrupt remapping needs a mapping for every possible CPU, so this
> limit is insufficient.
>
> Make the bitmap grow on demand and treat IDs beyond its current size
> as absent. Cap it at 16K entries to bound allocation size while leaving
> ample room for expected software MSI users.
>
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   drivers/iommu/iommufd/device.c          |  3 +-
>   drivers/iommu/iommufd/driver.c          | 37 ++++++++++++++--------
>   drivers/iommu/iommufd/hw_pagetable.c    |  1 +
>   drivers/iommu/iommufd/iommufd_private.h | 41 +++++++++++++++++++++++--
>   4 files changed, 66 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index d488c23fd353..868f1e591208 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -34,6 +34,7 @@ static void iommufd_group_release(struct kref *kref)
>   		   NULL, GFP_KERNEL);
>   	iommu_group_put(igroup->group);
>   	mutex_destroy(&igroup->lock);
> +	kfree(igroup->required_sw_msi.bitmap);
>   	kfree(igroup);
>   }
>   
> @@ -384,7 +385,7 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
>   		int rc;
>   
>   		if (cur->sw_msi_start != igroup->sw_msi_start ||
> -		    !test_bit(cur->id, igroup->required_sw_msi.bitmap))
> +		    !iommufd_sw_msi_maps_test_bit(&igroup->required_sw_msi, cur->id))
>   			continue;
>   
>   		rc = iommufd_sw_msi_install(ictx, hwpt_paging, cur);
> diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
> index 3b8067976eac..d0b05b1fda42 100644
> --- a/drivers/iommu/iommufd/driver.c
> +++ b/drivers/iommu/iommufd/driver.c
> @@ -196,13 +196,15 @@ iommufd_sw_msi_get_map(struct iommufd_ctx *ictx, phys_addr_t msi_addr,
>   	list_for_each_entry(cur, &ictx->sw_msi_list, sw_msi_item) {
>   		if (cur->sw_msi_start != sw_msi_start)
>   			continue;
> +		if (cur->pgoff == UINT_MAX)
> +			return ERR_PTR(-EOVERFLOW);
>   		max_pgoff = max(max_pgoff, cur->pgoff + 1);
>   		if (cur->msi_addr == msi_addr)
>   			return cur;
>   	}
>   
> -	if (ictx->sw_msi_id >=
> -	    BITS_PER_BYTE * sizeof_field(struct iommufd_sw_msi_maps, bitmap))
> +	if (ictx->sw_msi_id > IOMMUFD_SW_MSI_MAX_ID ||
> +	    max_pgoff > (ULONG_MAX - sw_msi_start) / PAGE_SIZE)
>   		return ERR_PTR(-EOVERFLOW);
>   
>   	cur = kzalloc_obj(*cur);
> @@ -222,21 +224,25 @@ int iommufd_sw_msi_install(struct iommufd_ctx *ictx,
>   			   struct iommufd_sw_msi_map *msi_map)
>   {
>   	unsigned long iova;
> +	int rc;
>   
>   	lockdep_assert_held(&ictx->sw_msi_lock);
>   
> +	if (iommufd_sw_msi_maps_test_bit(&hwpt_paging->present_sw_msi, msi_map->id))
> +		return 0;
> +
>   	iova = msi_map->sw_msi_start + msi_map->pgoff * PAGE_SIZE;
> -	if (!test_bit(msi_map->id, hwpt_paging->present_sw_msi.bitmap)) {
> -		int rc;
> -
> -		rc = iommu_map(hwpt_paging->common.domain, iova,
> -			       msi_map->msi_addr, PAGE_SIZE,
> -			       IOMMU_WRITE | IOMMU_READ | IOMMU_MMIO,
> -			       GFP_KERNEL_ACCOUNT);
> -		if (rc)
> -			return rc;
> -		__set_bit(msi_map->id, hwpt_paging->present_sw_msi.bitmap);
> -	}
> +	rc = iommufd_sw_msi_maps_ensure(&hwpt_paging->present_sw_msi, msi_map->id);
> +	if (rc)
> +		return rc;
> +
> +	rc = iommu_map(hwpt_paging->common.domain, iova,
> +		       msi_map->msi_addr, PAGE_SIZE,
> +		       IOMMU_WRITE | IOMMU_READ | IOMMU_MMIO,
> +		       GFP_KERNEL_ACCOUNT);
> +	if (rc)
> +		return rc;
> +	__set_bit(msi_map->id, hwpt_paging->present_sw_msi.bitmap);
>   	return 0;
>   }
>   EXPORT_SYMBOL_NS_GPL(iommufd_sw_msi_install, "IOMMUFD_INTERNAL");
> @@ -290,6 +296,11 @@ int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
>   	if (IS_ERR(msi_map))
>   		return PTR_ERR(msi_map);
>   
> +	rc = iommufd_sw_msi_maps_ensure(&handle->idev->igroup->required_sw_msi,
> +					msi_map->id);
> +	if (rc)
> +		return rc;
> +
>   	rc = iommufd_sw_msi_install(ictx, hwpt_paging, msi_map);
>   	if (rc)
>   		return rc;
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index 623cc608ca0c..54873de43eb0 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -32,6 +32,7 @@ void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
>   	}
>   
>   	__iommufd_hwpt_destroy(&hwpt_paging->common);
> +	kfree(hwpt_paging->present_sw_msi.bitmap);
>   	refcount_dec(&hwpt_paging->ioas->obj.users);
>   }
>   
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 43fbc5bed8de..9ca5f9f92cdf 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -9,6 +9,7 @@
>   #include <linux/iova_bitmap.h>
>   #include <linux/maple_tree.h>
>   #include <linux/rwsem.h>
> +#include <linux/slab.h>
>   #include <linux/uaccess.h>
>   #include <linux/xarray.h>
>   #include <uapi/linux/iommufd.h>
> @@ -29,11 +30,47 @@ struct iommufd_sw_msi_map {
>   	unsigned int id;
>   };
>   
> -/* Bitmap of struct iommufd_sw_msi_map::id */
> +/* Bitmap of struct iommufd_sw_msi_map::id; starts empty, grows on demand. */
>   struct iommufd_sw_msi_maps {
> -	DECLARE_BITMAP(bitmap, 64);
> +	unsigned long *bitmap;
> +	unsigned int nbits;
>   };
>   
> +/* Large enough for foreseeable SW MSI users while bounding bitmap growth. */
> +#define IOMMUFD_SW_MSI_MAX_ID	(16U * 1024 - 1)
> +
> +/* Grow bitmap to accommodate id. Must be called under ictx->sw_msi_lock. */
> +static inline int iommufd_sw_msi_maps_ensure(struct iommufd_sw_msi_maps *maps,
> +					     unsigned int id)
> +{
> +	unsigned long *new_bitmap;
> +	unsigned int new_nbits;
> +
> +	if (id < maps->nbits)
> +		return 0;
> +	if (id > IOMMUFD_SW_MSI_MAX_ID)
> +		return -EOVERFLOW;
> +
> +	new_nbits = max(ALIGN(id + 1, BITS_PER_LONG), 64U);
> +	new_bitmap = krealloc(maps->bitmap,
> +			      BITS_TO_LONGS(new_nbits) * sizeof(unsigned long),
> +			      GFP_KERNEL_ACCOUNT);
> +	if (!new_bitmap)
> +		return -ENOMEM;
> +	bitmap_clear(new_bitmap, maps->nbits, new_nbits - maps->nbits);
> +	maps->bitmap = new_bitmap;
> +	maps->nbits = new_nbits;
> +	return 0;
> +}
> +
> +static inline bool iommufd_sw_msi_maps_test_bit(const struct iommufd_sw_msi_maps *maps,
> +						unsigned int id)
> +{
> +	if (id >= maps->nbits)
> +		return false;
> +	return test_bit(id, maps->bitmap);
> +}
> +
>   #ifdef CONFIG_IRQ_MSI_IOMMU
>   int iommufd_sw_msi_install(struct iommufd_ctx *ictx,
>   			   struct iommufd_hwpt_paging *hwpt_paging,
