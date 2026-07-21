Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B478419307
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627197; cv=fail; b=HiG9pgsXkm/IXd0NsdU3fpKo9i0//zRqiyE1Wh6yg9YhkwHSj8fqBYUxlf+tOhHxNkGsWX9rsjb6JKV0y8x0lBqZ/EvnERTjwaMryLLBgBRxMqsxzWSPdTiKkT7v4w1kGlvclIDYyXYdEjCBCvXQRZBQk3Me041hdRNJlimXCYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627197; c=relaxed/simple;
	bh=+f0KY1jlaLR1yE1XoOOoSZOaO40yGUFNw2rhI+YCJNc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ubA7nwlcvrcZjREyv5mg/jO5bMsG1s6RqnV218mR5oUkU86ElpRauPjw7ctragPsAm8t7F2qyIBb0OSqqpbeQ6LVBINEJT3n3EBgwW+A5rSezfA34N8WA4gnDxfd7dFhTidDQiKgyORS4vuYBNEha9W7rnwBQLTvdbxZimI+TEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VoyKXbHD; arc=fail smtp.client-ip=52.101.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VoyKXbHD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=roji+2AzhaFTEtVtjUNDwp/6Truazb2puMWtJ/KV0AIAgQro0is9oVbQVMLzFFITzqo0Dk0naarzbg3WUzwhpJ54wGYIk1BVIOfCLLXnTCvJQVjDKkDao2AjYlA/ddz/7k5hb/az1YZMJc14l12QGQMk3J601qWUKaF/gzutWn8gR/D9DAxXoVV5tRuLa1Fc/pwEyn9a6lxc9Wjxqv6qNnBNRfQ7WHf/LYwh8XbgfPjZ2JYPuSwTYOjUSu0FotuDuSTCoGCT+YFaTj88ozmOa+Bbm9Gok9Z0euqq9C9MDuwotnX+z9TznDfdIkALY7laUYTy0hxSC+WT3W/z22GKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcTC66BJ6+uqrGM8jg/DGYCws1IXYwJurAcPWOfMJ8A=;
 b=UreO5QAK2CiCYp+rPx/h3pkl/8QBCTPN9REKQI0gzg4yUbrGFALYp6k19yJYm3xN0wIjXd/qktEs+yLXNeknaDyfzfIxj5hWB1hBIqNIajI2F0KdSkNPqO0WzxOSuOzBIezzpUA8CVg/+y6xuO0fJB3dFbSH7YUS9e2uKAmDm/iqV/Hw+GmKzpVCNzOzI50y18D7pIxRBVdAcc12DLuXWbYnQIoW7lZ/7a0ltn42CHqjlo1h5Tj+hOD/bg8ax13Km8wcCo7DeALs/OToqo4/FXO7fPnnAGasgrYYd29dt2b2GgoIVNhgXteFsRZLXTxtWQVX4wRJtVIgQgy2a+SCgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcTC66BJ6+uqrGM8jg/DGYCws1IXYwJurAcPWOfMJ8A=;
 b=VoyKXbHDWKPQS2ZxLLVOssuZDG8DUyGbvKqc3pf7MXz0VOvUN7Yq+x2g0nAd+7ZsBFkE4j8p9Z29Czpq6iDxF8arXratH4Riw7xKhqlr7boe7UMkT+7gGgDUDI4AZytoVCVXWhBwtHntq9n14ms3h1WQPQX6f8fPItO+TM9L7jA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 CYXPR12MB9339.namprd12.prod.outlook.com (2603:10b6:930:d5::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Tue, 21 Jul 2026 09:46:33 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0223.013; Tue, 21 Jul 2026
 09:46:33 +0000
Message-ID: <e2146f94-113e-4920-9da8-2b78d1ee32f2@amd.com>
Date: Tue, 21 Jul 2026 15:16:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Wait for completion instead of returning early
 in iommu_completion_wait()
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, xlpang@linux.alibaba.com,
 oliver.yang@linux.alibaba.com
References: <20260716141622.325032-1-guanghuifeng@linux.alibaba.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260716141622.325032-1-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0194.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::7) To BL1PR12MB5754.namprd12.prod.outlook.com
 (2603:10b6:208:391::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|CYXPR12MB9339:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b1514b-fc59-43fa-e754-08dee70cf245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|3023799007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	CPdtbr6sg3BBMh8QnBuSZ3CVqrwU/GUBc8SHlNz2bMAjcXTZnt46oVI1srGYdi0aH3zlxArQrArpMjONHMxD3e1isg71jT5pABhn6j+XMZgdEPNlA05vZXUGK/HB6yI5NTVZAo3moeZjcf9YOo7Cyz3KfQuXNr5n+jnIneyB5E2fL+u+TYRRIojveYS65UFTS1OFO3AWMQscApIHmP50v+nAXOXgiq7Vvz1g0CKjagPanoLhbqsz78DYh+34S+LkO2pm4nheEoRzvwj3+731jJHaB9UnsmrOXJTXZWQ+RCT0TCkjLevpeYFq6dz1rp5zvKIEiPnE7CZg2ydYIaVf7ZVj8brPfwuSA+XfWy6rce5RKJ8WzTdETw4ydV+8jWRHtnUKwTUjcQfN0Xyhi0guxtRKlipVlz7Sylzd7pMdPGGMSR+AirTaqhy/e29xpoCVKLh5Buu51Q83Q+WhouJ3Nuqwg/vn3pJB0ayQ8ElB2z6p6A51TITxsPNxU6LnIEMRdWl5K5DPfpJ1Cv2y9SOn4D1hDvojzvNRr2AeGiPquwWucUtjJIwCCcl1cBWa/vOz/JZj14XyZ3aZAxg6NeR/TKAd3VZVmq/q/uLjZSSGNozl14uIFXwJfOFwdMlI2x8XaBUR1q6KO0LZ/t4lpTrXOKO3CUdVtlvmNzR3OHXZKDQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlFHdnpSS0Y1bUlIaHY2bUtkaFlKdE1XZDJGdGdnTHQ1bHJGVHArUWRSRDNs?=
 =?utf-8?B?N09sZ0o3c0JmWjBCMTVUdDhJYUhIMU9jTm1KemNPR2M3NzlMNEZHWEJXZzdQ?=
 =?utf-8?B?L01XbVBDWDBsMk9pWnBZeXo4cC9KaHdYa01wOGx3SUhxUW5WaFJCTU5vVkNu?=
 =?utf-8?B?eUdRWDBaNjQ2UWM0amFlc1NSOGdWbWtnMUVzRVdrK1dWK1BYanViaCtCeTFx?=
 =?utf-8?B?TmhLTDZWd3M2cWwrQWV0VFh3SDZ0aDdiOWx0K1RnZy9ZTTcxN2dmM3ZEcWR6?=
 =?utf-8?B?d3AvMzI5U1AyM3orRFlGb3pCdzhKTklPWjBpVk1GeUVtUTVzYThkTVkybnkz?=
 =?utf-8?B?QzJLaTZxc0k4MjdLdDBsV0FiQU4yNjNBVXNYSGxhaENMNGNxUUl5RnViTDVN?=
 =?utf-8?B?SmFyUVBzZDRxcmVHOVVpVlNnaFFqUkU3aU9qRjFvOXM2VXNhZGVkdTkxbzBW?=
 =?utf-8?B?bThmVFJQVjNSRUNOUy9KT2hPNmMxMnJWY2x4R2lvYWRzVTNrMFBTM1B6WDhq?=
 =?utf-8?B?eitvd2VudEtmd1JaWitBeGhwNzhVblRuTDc4ZTAwU1VKdmd4Y1RQQmlRa1VH?=
 =?utf-8?B?U05rSFBuQ3YzM2JlNTJlV0twOVU2UWEwUlBrOUU1dWRRUlZoVi9PcUl2OERN?=
 =?utf-8?B?MVNKcnA4Z1luUjJ1aFgvOVhuQndjTDd4TmluQy9sRG1zRVJOb0crREJ3Q0Er?=
 =?utf-8?B?SHpGL2twN2x4ZUp1VWd2dGk3UHIvcmZndFg5RkY0dTF0QTJFVUxHRmptVjlG?=
 =?utf-8?B?K0doV3A3RkFmYVdlaXF5emVkUlkvWGRNZmpFaDg2T2dOVkE4SEt0dEVseDJv?=
 =?utf-8?B?cEdXZ2NFWXdzTHpuYnFCZ1c0dERtT2VaUVNQbExETE9ESXFkbWJlSThiVHZO?=
 =?utf-8?B?a0hIRlkxRSsxZXRBcnNCaW8yTzY4U2dudFFGSDVvQS9DbDgwOFNxcnRwRExJ?=
 =?utf-8?B?STN4L2tNUmFGTjZUenkwbDlCK1o4U2NrYXd0NkVnNHo2cE9DUWV1c0sxY3lm?=
 =?utf-8?B?SkRrVm41dEJwSTdzTDdYaWJPUk15UnlLVSt4RmV2N1pSWUVnOHY0dFJlZXVo?=
 =?utf-8?B?WWE0ZmZWUmQwOURYamNiblEzRFZ1V0xJQWtJMEphd3Y1eVNpbWkvWVVjdURy?=
 =?utf-8?B?ZGNzbkVmNzBjbnB4OCtIY1dVK2pJK09PN2djdXhTSTZYZW9XQkYrTDY3WEdJ?=
 =?utf-8?B?UE93V2tqand1L0VjZnhjcG9kVDVFZERNMm91N29rVU9BRjR5dHRWNmQ5TG0w?=
 =?utf-8?B?YThYZGhqbWNaY3JSRWlRaW5lN0txSldoSWowZVRLYWtPektoRElDeTBrcDQz?=
 =?utf-8?B?amFnL3ZXMWdOS0dJYXBVbEFYdXBIeWJuZ3VwOHNLRm9UNkdWcnp5OGRraGh2?=
 =?utf-8?B?Q21ublc2MU1MMVFwc1RYWXBTLzU1czJhZ04zREhFVW5vUWNyUTNvNXpWOTVD?=
 =?utf-8?B?M2JhMHpMQ2IzVndxcm5Qa3dmVkhtajJhRHc3d2dKRzZUN0l0VURrVm9Dc3li?=
 =?utf-8?B?ZUhqTG94VGs1ZitnWkY4bkp0dDZHVTRJMWVYeUlDaVhnSm1naHlRQWxZQXFP?=
 =?utf-8?B?NS9PSjFGdHJ2SzJuR29zY1Z1OU94MERVTWtkWDYwTE5RVVFLeGhYV1R2WUJ0?=
 =?utf-8?B?TXJId29kM0pkN3Jwd0QzN1lwRkx2bjVmNkNkN0pwWnlxeGxRWnhEU1lSK0Za?=
 =?utf-8?B?dTVqRVdkSmhGWlgyK0VOdGZWcG9ISGVuLzRvNjZsMEZEY2pZUzNFL3VBcUZJ?=
 =?utf-8?B?WW5jVnNDREtjME8xaU96WEhJcDN5ZWg1ZTJRZ3NvdVc2a0RmL2luWktnT3gx?=
 =?utf-8?B?dE5vSmJjempZZnJLV0VQRnZ5aE1xb3E1UmkxQTRESURwUTRvcGJRQnRsNXVD?=
 =?utf-8?B?b0JoTVI1NjlHSGF4YSt3Q0ZMY1ZpV2w2Q3JqcXFjY25YWk5SRk8yTzNjQjM2?=
 =?utf-8?B?ajFjK2VsNkROeVRVR3FLd0hNcStkZVdOWFcxRzFmZnFTbkFCRGlicDFrT0Ez?=
 =?utf-8?B?ekMvYnI4YjRwUnRwNUJEdFRtTXp0aFRHMkt5dGlXZXVTOVNjTWVPSk45amZV?=
 =?utf-8?B?N0tCK2xadTNURy84QXhSTlAzNHpKd052MHNQcWNxbDVyZ3NSL3NPdUt2RnpW?=
 =?utf-8?B?WEw3MG4wcml1RGdYb1RvTkxHZHFIcGhtdW1Tc1laSG53clhNbnBzRFRyRmFM?=
 =?utf-8?B?NTk2T1AvREdkNkFNd05FcDdpbTdJZlQvUjU5d0lscSthZS9zeWNaYklNamFY?=
 =?utf-8?B?QjJaaldNeXR5ZVo2a3JnSlNlWkM1NTFTOEpzNXViUkdnczVCeTd5NzZtM1Zn?=
 =?utf-8?B?TDh0NEM2aEl3SFpEYzJTTk1XL3Jtakg4ZnZEQW12SXZBSkREcDc2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b1514b-fc59-43fa-e754-08dee70cf245
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 09:46:32.9478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PECGCnmRsowTflNCyEwZljv6UMSn4kdlQxZ9Z+8xMDuKDzVXNqMmlpfvqQwysMoAVovmA4azoNtbLNtoT6ReRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9339

Hi Joerg, Will,

Can you please pick this patch for rc as it fixes important synchronization bug.



On 7/16/2026 7:46 PM, Guanghui Feng wrote:
> need_sync is a per-IOMMU flag shared by all domains and devices behind
> that IOMMU. It is set whenever a command is queued with sync == true and
> cleared when a completion-wait (CWAIT) command is queued. However, a
> cleared need_sync only means that a covering CWAIT has been queued, not
> that all previously queued commands have actually completed in hardware.
> 
> iommu_completion_wait() read need_sync locklessly and returned early
> when it was false. This breaks the "block until all previously queued
> commands have completed" contract in a multi-CPU scenario:
> 
>   CPU2: queue inv-B                  => need_sync = true
>   CPU1: queue CWAIT(N); need_sync = false; then wait_on_sem(N)
>   CPU2: read need_sync == false      => return 0 (no wait!)
> 
> CPU2 returns without waiting for any sequence number even though its
> inv-B may not have completed yet (CWAIT(N), queued after inv-B, has not
> been signaled). CPU2 then proceeds to, for example, free page-table
> pages while the IOMMU can still walk stale translations, opening a
> use-after-free window. This is a logical race in the meaning of the
> flag, not a memory-visibility issue, so barriers alone do not help.
> 
> Fix it without losing the optimization of avoiding redundant CWAIT
> commands: take iommu->lock before testing need_sync, and when it is
> false do not return early but wait for the last allocated sequence
> number (cmd_sem_val). Since need_sync == false implies no sync command
> was queued after the last CWAIT, that CWAIT is FIFO-ordered after every
> not-yet-completed command, so waiting for its sequence number guarantees
> all prior commands (possibly queued by another CPU) have completed. The
> common path with pending work is unchanged and no extra hardware command
> is issued.
> 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>

We have reviewed/tested this patch. It looks good.

Fixes: 815b33fdc279 ("x86/amd-iommu: Cleanup completion-wait handling")

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>


-Vasant






> ---
>  drivers/iommu/amd/iommu.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 563f9c2672d5..29dc18d3d22e 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1450,11 +1450,23 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
>  	int ret;
>  	u64 data;
>  
> -	if (!iommu->need_sync)
> -		return 0;
> -
>  	raw_spin_lock_irqsave(&iommu->lock, flags);
>  
> +	if (!iommu->need_sync) {
> +		/*
> +		 * No command has been queued since the last completion-wait.
> +		 * A concurrent CPU may have already queued that CWAIT and
> +		 * cleared need_sync; need_sync == false only means a covering
> +		 * CWAIT is queued, not that all prior commands have completed.
> +		 * Wait for the last allocated sequence number so that any
> +		 * command queued before this call (possibly on another CPU)
> +		 * is guaranteed to have completed before returning.
> +		 */
> +		data = iommu->cmd_sem_val;
> +		raw_spin_unlock_irqrestore(&iommu->lock, flags);
> +		return wait_on_sem(iommu, data);
> +	}
> +
>  	data = get_cmdsem_val(iommu);
>  	build_completion_wait(&cmd, iommu, data);
>  
> @@ -1464,9 +1476,7 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
>  	if (ret)
>  		return ret;
>  
> -	ret = wait_on_sem(iommu, data);
> -
> -	return ret;
> +	return wait_on_sem(iommu, data);
>  }
>  
>  static void domain_flush_complete(struct protection_domain *domain)

