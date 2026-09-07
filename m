Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012051.outbound.protection.outlook.com [52.103.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5867C3E9F93
	for <iommu@lists.linux.dev>; Mon,  7 Sep 2026 03:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788753178; cv=fail; b=OjDtFdYeWr/86eTSdIqEQtvquKueQflcVa+ITSh18eMTMTNTrqEe8fVg92UdmnEvHvfutjeQW3AiszqVO80GqXBdgGXlnbPcZjTUfkqNaGVTJe3mu+6bWnIjMxzQxYK94ZUTyB9+5bZn5qdsowMY6veZ/FZV2A9Rt5j3I42+tB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788753178; c=relaxed/simple;
	bh=h+JB/5JCknyWOhX8OkcNL9FiM5ur04VcfCGObeeSiH0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HOVgt3URJNPuwr3uYe/G6PaMgY/4H/lbj3HBCl3DhFj4CwXHVcr60h/9q2nCox55sbHIl070CgiJz3SnzX3fQL/9WUW8uqxxzMld+B5eOINuDttkAkJgf3yqDvuYr5eTPZaH9kMxZhIa2C4zuC2yf060tAV7GiL/9n16rBjbl8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=DLc6GzJa; arc=fail smtp.client-ip=52.103.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="DLc6GzJa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pML46IBsl+b97kl40WQpuiICoN1jD54bqkWKVEafyjSLKpP6coxibMJNjJIGvYIuLRmFDwPJMaEDw0qYJ0g1zST2Ai4iHbI8wjojLbkklU32t5R+XMukVjvmgWYXX7VDwHOyMorafDDnTxj0NJpLdIOZLVYXQws6npmmRSqE1rNPI4gnl3w82Ot7+53xIGjCT+AFECzNO7cKZkIgkHYK/+oaPFG4UmJrv9rgEHh7JR8WF7lwYOuup8CuqDE8CFFBBx/+2TXNC37v5hPO0Giusrxtc3anvmgKVa4Ci31KUg159dU/9H0EV44bCP1hH5ShOt7+tT10J27+2c+poC/crg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsLyMDJjyNMKa8ecT40mZsTw6l1UvJg9lXF7NWXbkE0=;
 b=ifQp0dnZQ1Mas+sZTjaHOCBB3aVd52vBvc4fzoyr7Q9uBSt5YU5tUbvxJNZPJFYGq59k95mJki+oczf7RbZ/WGk4/vyHFLJxH5CDMFbWnrn4WuMWfS16ag1pg/tAtXp15DnEeO4dwVT+sD3UxCVFPbJh+ajR/8z9VOJ1dHiS2GbpiWFsiOzb+tuj+zDL0QWKxPMB0yYPidqcQ/Rjn1dPJRhMDdsVBfpM6mL3gDi12L7bo0DZ/RCxhgOh2HyBDN8bGYFJPtTQB+npgVYcIhkGGTc+veabB8DE37shCU3dDbuezRl6KgwpvhcxoRmam1huFJ5c63nJZzP9hDeGFBUzMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsLyMDJjyNMKa8ecT40mZsTw6l1UvJg9lXF7NWXbkE0=;
 b=DLc6GzJa9P3y+HHbERv97WX4fHh2B6cWFsSjphAVAKZyXGPs5x8GyZAQ2KA9ROTam8RuQMDSkgTBoi3lU6cwCOlhNUxHFXItVBNlsATQgWIN4ekzsVBgHFlHEUXJEXjTWQLJZOIfVYSANBUihGe6MCt7KqXuCyu5taaD3fDjj1YHT5C2oZel+aEC4DCMs4CFATsj/5KYv3QMxo58aQjFgPWzjmrsw1TXZ1+n+DLbXU9py5Pfe98sHEXQ8YF8mYli8uNVH9vN4vVK5cgwc8JEOtiPQ3Wucf6k51NKxSGIQAQXgqCuN0YdXvOBnmK6ps/yCgeENj8126mWrpJmnf5bmw==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by TY0PR04MB5658.apcprd04.prod.outlook.com (2603:1096:400:1be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.13; Mon, 7 Sep
 2026 03:52:47 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 03:52:47 +0000
Message-ID:
 <SE3PR04MB8922591D6A8B676B97A7CE59F3B22@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Mon, 7 Sep 2026 11:52:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] iommu/riscv: Add command queue lock
To: fangyu.yu@linux.alibaba.com, tomasz.jeznach@linux.dev, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, baolu.lu@linux.intel.com,
 jroedel@suse.de, zong.li@sifive.com, andrew.jones@oss.qualcomm.com,
 anup@brainfault.org, jgg@nvidia.com, jgg@ziepe.ca
Cc: guoren@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20260901133920.14550-1-fangyu.yu@linux.alibaba.com>
 <20260901133920.14550-2-fangyu.yu@linux.alibaba.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260901133920.14550-2-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0057.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::16) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID:
 <9a66ce7d-e4d3-4639-b3b2-308883291515@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|TY0PR04MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e4bf26c-cb38-4ac8-4122-08df0c937ae8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24121999003|22091999003|5072599009|6090799003|25010399006|4140399003|12121999013|19110799012|8060799015|15080799012|19101099003|55001999006|23021999003|51005399006|440099028|3412199025|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djRIWC8vcG8wNEhXSExycVpadTcweHhnWWU0OXUvQ3lQNjdUbVpnYS9Hd1pG?=
 =?utf-8?B?aE0wVXdpTHM1VUI0OXgxSFQ4VmNHanhQcVAxYXR6OC9pcnIva2NVaUdSOUFa?=
 =?utf-8?B?d2d6NC9CMElWT2QzTXdaaUluMkE2dUtPZE9vR3N1cXhmMFhDdkJSeUdkQndp?=
 =?utf-8?B?UnY4Y09NUjJBUHdmYWFZRDVreTN4Sko1WHVtbnRVVEwrNjdPUnZiRDVkdDhy?=
 =?utf-8?B?aUJiMXZRK1lSQ2VYWWFha1E3K2F4R0U5Ums1SjBhcGdKa2RvVTBHYnI3b042?=
 =?utf-8?B?UlIxNDgzT1NXQ2dyRnlUdEVqazgxc3ZpU0dNNElFK2NUL09SRE5NdHNBTTVF?=
 =?utf-8?B?RXhGNFhZbmZBUFNDVktFbGhNM1plSDREOFRwaUJoNGdHVTBqOGxOejhENGpK?=
 =?utf-8?B?ZXR1K1ZpRWlURWNwRVFuN3NoOFBqNkwxazJGZDRGa0MwVzJBN0krTVgyallE?=
 =?utf-8?B?aXpHQlFjbksrTzVPQUpGamRGWjVweC9oclg0RzBzMlYxVm5DL1JqNm9mNlF4?=
 =?utf-8?B?UHAzMG92eisrT2JsQ0hwNzNqbXpqRGpXc296WEYrb3F0SGQ3RDlsanA3YjBT?=
 =?utf-8?B?VG1nVFc4ZUNkZVZVS0E2ODlCTkxiMmQvV2JEcGJqNnBCRXZMM1FFK1VKeTV2?=
 =?utf-8?B?Ly8zN1pTdXFwOXgyS09HdXBPVHIybjhSRVFMVUVuMGNORXlRbitFdGVqeXo3?=
 =?utf-8?B?WkMybm4vd0JCcGtISElZc1BwTXlGaUFob3dSVVpBMStRQmFtZ2JUVldxSmdL?=
 =?utf-8?B?by84V09kV20wYktmZWdhL3Z3ZVM1WnIxVVJ4RmhVUjRTaTdMNmNBcEt3blpk?=
 =?utf-8?B?cUgyK0tRWXZJVUlCRllvdkc1WUl2cy9oYTNydktzaWlScWpXb1dZcTBCQm50?=
 =?utf-8?B?K3ZRdmRxTkVjOU4vcnFObDRub3M5ZnhFVFFRRnoxZ2RhVmJtZjdhUVYxc0Vk?=
 =?utf-8?B?b1NVdFVHMXZRZHhEUVFpVXNVeGk2cE9lQWkyMTU0cnQ1OUZxeHFMcld2dmJo?=
 =?utf-8?B?MGNWRkR2dWRNOTU2N2R0TjJGeUJTOEFyeDJrb2t5YkhqNzlINDR2ZEtEaEt5?=
 =?utf-8?B?MVI1QUJMVkVpTTBWaGd5UFJhZjVTODl5bmRaOHgwbk9NbTR6WkJnaFZtSlpZ?=
 =?utf-8?B?TFJsT1ByTGFSclpLckJMVjROQ0hGZy9YU1QreHZSY1doZHdrTjdqektyR1ZX?=
 =?utf-8?B?WlY5UzZaRzVTZlFFQW1BVUswSCtVWE9xYkVvejdudWNxNzlpK0VGYTEvdHpa?=
 =?utf-8?B?RkR1ak5PcFBpdGpzQ1h3RWtodnFUMFFSNEZUSkttdXFQSUFsallqaUhoK2tM?=
 =?utf-8?B?eXgxSmZjSkY2ZUxoUXZDVmFnc1R2L2JTa29IdTNYVjQ4N1BIWTNhVzNlaTVB?=
 =?utf-8?B?OXlEdmEzWFdQYjgyVFBZYW8reHhrczY3aVlveUlRS3lDTS9Ec1Y2MnVidlFE?=
 =?utf-8?B?NnpqYVN5b3Y3Mm9uTlYzaFRxeUh5VGlTbkVVTFpRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1NSeUczc2ZsVWhqemkrd2ZsOWJORnNQaFdjM3pJbWUzVDdhMkVqMVViY25S?=
 =?utf-8?B?KzhBbThPYUxpd2N0MkxYT3RhQ29UaEpkUzkveXEwWTRybDBmWUtONmp4c3VX?=
 =?utf-8?B?YzNSZVpCcWhCa3NJcWhYbjFoWFU0NFVJTzY0ZkhHWFM2WnIwSldYWXlLdmV5?=
 =?utf-8?B?MmNZcWwxaDFqZVRTajB6VzQwUENjaDRqdkxkYUxxZUtrRTlvL3orNkF5QWFl?=
 =?utf-8?B?RWFPQlp2MmZ1VnhtcDE4d0Z5ZjEyVEx3aFJNTjBZYWVKWXVNLyt5RkNSczhj?=
 =?utf-8?B?aklFZ21xK0lINW1uVWRaQW0xOXhWQXN1cDRsQ3lMeGkzSmkwVWh6OU9IR0ZN?=
 =?utf-8?B?Yzh0NE43d0d0UE9pTnVqcFR4SW1PZGlSZzhCeFBJR24rZEdqVkQ0aStjVVBN?=
 =?utf-8?B?ZGhCaWMrRUYxbnJkdnNuVmVpU2lYUEZHWVE5dGFTOUFKYWY3UmFEeTZtWFZI?=
 =?utf-8?B?SWdMdzlTTHJwOFZndEF2WlkzLzJFVUZHNUhQSWlxOUJJNFBCRkdYUU9iU095?=
 =?utf-8?B?cTFXVDJBSGZIVjl6VTIwblNBT2FJRjZlaW1ueVVlR0htM2dWakk2bUpka1RV?=
 =?utf-8?B?dkJjcG96S2NVb3JQZURIdFVIa0hxMGk0SGRlKzdzdkZ2cUdNaVMybjFTWUJa?=
 =?utf-8?B?dmJGQ2NJeVBucXdDb1RoSGhWalF0Y2lYQ05QbjVsRktFTnI5cjNWOUFOZXNm?=
 =?utf-8?B?eHJBeEZDNmNkZy9oU3VzSU9aRm5XejhCOUVzeFozdlVmTXgyRlNTL0M3dm5Z?=
 =?utf-8?B?SXoyOXNGbEtkY2ZIRGYvSThuTHE3bFFrVkJIOU9CUW9vRVIvZWZMS2JrWlhE?=
 =?utf-8?B?cXNIUVZOeDB6UDBRZkRYYTduVjBDZ3hteFF0L2tkZGt5dUR3SkxnMTQrWXo3?=
 =?utf-8?B?MEMzL0ZySHE4Y2J6ZU5TcmJsc3RncjBIaHBuaDZvTkxlK1pSMlJlTUx2ajJO?=
 =?utf-8?B?ZE5IV3RPNTJHNUxFOGU0OHZGUmFjUkJqaVlsWnE3K1dxUXVvbTEyVklnZEMy?=
 =?utf-8?B?aWRvQnVxWUE1ZjcxazZVUXZmVW1qaXIycTkwa0xYa1V4U0Rrc0ZaOVJBRlhF?=
 =?utf-8?B?bkVFVEhuMWNaa1lSVEhGUUNqSUNCMWNYdXcxbXA1VCtmeUZ6M08yd3Jaek8x?=
 =?utf-8?B?RHgwUWVCR0pBdTlsbzg2aTgyZGd5aTh1R25OcjFpMzRVUHVvZjE5RjNtTWcy?=
 =?utf-8?B?K1VIMHcyeU5MQlpvQllacVNuWWhaUlllclU3akllZ0FQVFcrUEYvRUdpNFFN?=
 =?utf-8?B?cXBibDQyTnRSbSt6czBiUW1sa3ZCMFF0bkI5dThlNHNtRU4rWmJ6RDRwZm01?=
 =?utf-8?B?UXRvR2VzVjRBWnlZRkVuUVEvZnFlT0tXMjVOMWcwK1FweElReDZhT1NTMUtC?=
 =?utf-8?B?VVVXRUQ5cHZadGMzRGVzR2g4UDBHaHNVMjN0UHRMemRRNGxKQktVdjJKN1Nj?=
 =?utf-8?B?UUlSUXRCRnorTDNSWjhjVEhIMzIxRUZxZ1N6Zmlxb0NGUnVjRHAyK29mZGxD?=
 =?utf-8?B?b3g2NkZEaEt0a1R5K05SWHlUcHV2TzAxNGd3Rm93U2dINXF0MmpTS1dXeE1i?=
 =?utf-8?B?TE8xSzFQbHRVWDd1RnVtcXJob1NuNXUwTXBDcFdTVElmZ0ZkK2VGSVk4WWpT?=
 =?utf-8?B?YS8vWmdhZi9mRjFpV2ZHdzN5WWdDekMwUDF5NXI2bmZFRm9qa2ZZcDVmM1Vu?=
 =?utf-8?B?ZjV5MDdhRS9rN2JMaTFJWTJpNlk2OTc3bkxrc05wMDZwNTFPK2dCNDhiL0N3?=
 =?utf-8?B?anBtK0lSZllUZFZxeVM3ZEhxeTZzbHhGMUNPV2NhODhsMUVWbWFQOU42NzZZ?=
 =?utf-8?B?V0NzUnE1QVpnbE9BZklhMjFNUkM2Z2Y2dTFWQ0tIRlpYUDcvTmR3WEtvb2s2?=
 =?utf-8?Q?kTTGSQfZbr3Li?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4bf26c-cb38-4ac8-4122-08df0c937ae8
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 03:52:47.6504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB5658


On 9/1/2026 9:39 PM, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> Add a raw spinlock to the RISC-V IOMMU queue state so command queue
> publishing can be serialized by a later change.
>
> Fixes: 856c0cfe5c5f ("iommu/riscv: Command and fault queue support")
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   drivers/iommu/riscv/iommu.c | 1 +
>   drivers/iommu/riscv/iommu.h | 2 ++
>   2 files changed, 3 insertions(+)
>
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index cec3ddd7ab10..2c0dcc90cf85 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1560,6 +1560,7 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
>   	int rc;
>   
>   	RISCV_IOMMU_QUEUE_INIT(&iommu->cmdq, CQ);
> +	raw_spin_lock_init(&iommu->cmdq.lock);
>   	RISCV_IOMMU_QUEUE_INIT(&iommu->fltq, FQ);
>   
>   	rc = riscv_iommu_init_check(iommu);
> diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> index 46df79dd5495..5676001548cc 100644
> --- a/drivers/iommu/riscv/iommu.h
> +++ b/drivers/iommu/riscv/iommu.h
> @@ -12,6 +12,7 @@
>   #define _RISCV_IOMMU_H_
>   
>   #include <linux/iommu.h>
> +#include <linux/spinlock.h>
>   #include <linux/types.h>
>   #include <linux/iopoll.h>
>   
> @@ -23,6 +24,7 @@ struct riscv_iommu_queue {
>   	atomic_t prod;				/* unbounded producer allocation index */
>   	atomic_t head;				/* unbounded shadow ring buffer consumer index */
>   	atomic_t tail;				/* unbounded shadow ring buffer producer index */
> +	raw_spinlock_t lock;			/* serialize queue publishing */
>   	unsigned int mask;			/* index mask, queue length - 1 */
>   	unsigned int irq;			/* allocated interrupt number */
>   	struct riscv_iommu_device *iommu;	/* iommu device handling the queue when active */
