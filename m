Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793939228;
	b=mz5EyXBeW77rco5VbHfk4vk69nK/7P5JMznDRm66OrQvSVxcIesBRExVmTl/zYkJYbnl
	 SF7xhfBB4twAnFbqCgZEXA4Y2L+YvjbH1ft+SwfgzrY3zGjcDAaOLF3TQdzyCShFf4ie/
	 7DF9AkPt4+MVrBd95xTu5J9S7FPiyTsBzVRvY8lO4BEFCf6hQDqqT5miG2M5jRrFbe5EN
	 6Pf2azZ7DJgLsVR0kcCsfSZJtj1wEsciMbJEng1SX1rkdfGTwwW8Mng+dWxhlI8qlWm+L
	 AdHp9adPSE+Lo143p/Lx5Ej94N4o60FzIpR9fVhspwOiCQD+Dj6R8JDUt+RXsguDeZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939228;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=qzz67zs+pFHkPDw9CvEOVBLMAeEVtoqxrLVTDRpkgTs=;
	b=fYvpPlLjooe9MJ/uArYLO09Rr6okjruSmjvNcm8AYmk29cEd6NTWgq72t58aCvEF0Y7M
	 gJqgm+ksONOE5M3VvMT/C0xb+cYb0RMJktwaAwic5Ed5KT661Ah+CFv7uvzVDOskJBC51
	 qC717arAM6SOBBWuac/wc0rjEX3kylokvky5GHeUifuBRc4msFyLxyzJRNeU4YH5MGEwo
	 VSzIkq7LlxXIu5cAdpCvTyp/7+PRSHVW2PD327zqRxs1qMOgXJSJ10NRu0KY9Y59C/+Eo
	 x3BTudQuJi3iAK+mRa/13SbG8o/yGZkAmo+CaMypeMJ0Lh/U6p+dH8Ed4q6Vk13V6+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="PTK7/02R";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.19
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012019.outbound.protection.outlook.com [40.93.195.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B808606A31B
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 04:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B808606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PTK7/02R
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f92gi5CaLrGMApZiwts7AnmbMXPL0RpSMnhuRoG35ius7Tq8njRF5elxBLlFxFjauer0KGUNESuL3ylvYCJsspPs5e0FcUgT0rUxvr1xj2pCkGcDV/mfl5IYwXlcdhdflhiXofYsAa1XeBUhWNiQe7n5GkgqahVrq9YciPMbJ/Aw1G78nK26x2znPx1/gZ7miuLspU2FcOylf6rrCWK9/LwtHssurkQoPAQXS+xtd0pLRVoCVai+HYBvF6G37Rw4SL6qlih2GczvQsp6xR/gJsC406oW0Yir2evc573HtScZhtgWXTE+Qp5L5jIHAO8RIFeD8F2sTjlynHhIszwCdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzz67zs+pFHkPDw9CvEOVBLMAeEVtoqxrLVTDRpkgTs=;
 b=wJzH16RsuT0he1G055t4utgWiRScRJff/P5+3oD/0Q7IKoApGmyszTdzgvDRzX44gIbUwdx44tiGMFbZ+7CQ+nWtfq3FKIVReXuzSjYD5R7PJVwSTnWe190+7i+cph3qS01dpGw4WlVFeBiCSTnF49ewcTu9YtiY34mCY4Szin4uy6Whd3mxMiHypleoSzfcvPu/Wlii3ywMUxidU6UuSEK6HhQng894S0WS8hO6VynwXD8oQJf7i+/j8wTAg4XrLAXxPz33sS0wBVHHm5V0HAuldtA+U2EM6sYy4uyKgQ4Q5TvX7dN5jgTAHbzak2MMyu34XoITcRtq0cV2LvIkxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzz67zs+pFHkPDw9CvEOVBLMAeEVtoqxrLVTDRpkgTs=;
 b=PTK7/02RuwGNvqnRs1kV3350ZRaO2yGmrdtwjoWD5IllMBck+8azWHshRlzQ52bfmOJ3kBwIvKUi8lXzq0ADL3L4qc0qmc9DRyrV0/hKAGlBAslEViIdVVIodUKxoWOStDW+6rao0tXcyqupwoGAhg9Wxi0DCzp8IveTP1eo4iM=
Received: from CY5PR13CA0024.namprd13.prod.outlook.com (2603:10b6:930::14) by
 DS2PR12MB9566.namprd12.prod.outlook.com (2603:10b6:8:279::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.8; Fri, 6 Nov 2026 04:27:04 +0000
Received: from CY7PEPF000000E9.namprd04.prod.outlook.com
 (2603:10b6:930:0:cafe::75) by CY5PR13CA0024.outlook.office365.com
 (2603:10b6:930::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4 via Frontend Transport; Fri, 6
 Nov 2026 04:27:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000E9.mail.protection.outlook.com (10.167.247.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 04:27:03 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 22:27:03 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 22:27:02 -0600
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Thu, 5 Nov 2026 22:27:01 -0600
Date: Fri, 6 Nov 2026 04:26:53 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Vasant Hegde <vasant.hegde@amd.com>
CC: <iommu@lists.linux.dev>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH 4/7] iommu/amd: Allocate the completion sequence after
 queueing commands
Message-ID: <s4b7st5cinupjxjicjphw7v3334udxcfkcoxigccvo4balx2va@36ftdbkkeu2d>
References: <20261105042254.399163-1-vasant.hegde@amd.com>
 <20261105042254.399163-5-vasant.hegde@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261105042254.399163-5-vasant.hegde@amd.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000E9:EE_|DS2PR12MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: b678940b-b628-4109-930a-08df3bbe357e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|56012099006|11063799006|4143699003|261022105027099003|261021121427099003|261009223027099003|261102123227099003|261021123027099003|261028144727099003|261026140227099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	yrlbjluWETT2Jo7+VxpQFnkn/bzv8k1yiExI09F78+nuIPPREvE1Th+pmB2QuZYUcX8BICVXld3nmi22AvVuRX7vC5RFgBrz0MPPzPIx3FWI37r9ZBO5UYuxMVV1vmwzWgj7cv7ovcjHwT0IJAldXxeiBMD4pTRSWz6ep1/6wwOjJ3PPK87gMmZ+DUxoiu0JCRYiwsMugpsdU6JjVN+OisxQcTEt8V8mmKCbbZvUdPuLL8kxCO5z/Ug7Q3lYRew2k+w0ipvESw/ncg1h/B1SwgMALT3IrUfQ85bvK6ohQzyOo24sOuO0Ktp3VCS0LhA2A4r03mwOpIEmk/LqhxlZmWrG8dZlWvma9oTJIaorkxquV7myen12AB/ixU8VahfVrSBKr8w6yepxb0GSDT9IG6Va+U24gFz51S4X5JS2kV9uIK+9ZvwZSCra8hYcq6T6u7Zy4D1QoSUws0kTtW7UrSl7qXI5rBegHvKudq6fbJa0qWzvf6I7j0bSDoPFodzTRWCe8wiFCZj2zyyT9Q2cu26gRYWpris4THLa9Bgwu86l9G5+B29witbcCjduDbQiLo3DaimbZqd0qhxAjf/5T7CirctjrxH2G88MetfHtgn3HtnzKrCw046wwzeZrqIImCwTbdFSruKLs4FL+3hJGrHi8dMplEScGuIECJFLYP7u8S1X6YHEpHMeETueMGCYryl04RMWfze3WV4cNvTxqA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(56012099006)(11063799006)(4143699003)(261022105027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261021123027099003)(261028144727099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DR8Wle+cab0/GVZCsLgDQUVS3Vs2xgPuBPX4a3M/ZPV3mo7A5XkSja3bR1wlQRtsd9GlPNHqxSgEKaW6IY6yuHPCi+hrIFJPeVMj+eC5eC1o/egWej8i3U34D54N7tRkQc1HnXXxPybS26VuZnIr8q1JCcjY0NsusZFds9HQTWmdLy7T7ZNTmxPGE2hbWhF5mpa7UH+o6UhePcjhJnRhxlPmgATsqvaiMO9ZtHcmLyEPYrS0OTwEcBILY0wkuiuppA0C2WLsaL7wLBpwtiX5qOU4gp2gx4FG0ocqWlyXmRBQOD1VzWzeX9xhigofcqWJlHqHVHWSlChqowyTaD2OkmBSEJom+jyWvXgooJXQwFyrOFH/vcXkOmvgJnUzOFheD1Yb/bgrb3+RbuKuD1tEgXnCLO/YUxR+obnyhg9RSRsEC3DmDBqeIMVFUjMZ3wl9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:27:03.6328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b678940b-b628-4109-930a-08df3bbe357e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY7PEPF000000E9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9566

On Thu, Nov 05, 2026 at 04:22:51AM +0000, Vasant Hegde wrote:
> iommu_flush_irt_and_complete() reserves a completion-wait sequence number
> (via get_cmdsem_val()) before queueing the invalidate_irt commands. If one
> of those commands fails to queue, it returns early without ever queueing
> the completion wait that would store that sequence number.
> 
> Currently this is harmless, since iommu_completion_wait() is only called
> after some command has been queued. But allocating a sequence number and
> not using it may cause problems in the future.
> 
> Reserve and queue the completion wait only after the invalidate_irt
> commands are queued. Move the locked sequence allocation and queueing into
> a new __iommu_completion_wait() helper, called from both
> iommu_completion_wait() and iommu_flush_irt_and_complete(). The caller
> holds iommu->lock; the semaphore wait stays outside the lock.
> 
> Cc: Ankit Soni <Ankit.Soni@amd.com>
> Assisted-by: Cursor

Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 50 ++++++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 9559d272eb18..a5fe524b5afe 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1436,24 +1436,11 @@ static int iommu_queue_command(struct amd_iommu *iommu, struct iommu_cmd *cmd)
>  	return iommu_queue_command_sync(iommu, cmd, true);
>  }
>  
> -static u64 get_cmdsem_val(struct amd_iommu *iommu)
> -{
> -	lockdep_assert_held(&iommu->lock);
> -	return ++iommu->cmd_sem_val;
> -}
> -
> -/*
> - * This function queues a completion wait command into the command
> - * buffer of an IOMMU
> - */
> -static int iommu_completion_wait(struct amd_iommu *iommu)
> +static int __iommu_completion_wait(struct amd_iommu *iommu, u64 *data)
>  {
>  	struct iommu_cmd cmd;
> -	unsigned long flags;
> -	int ret;
> -	u64 data;
>  
> -	raw_spin_lock_irqsave(&iommu->lock, flags);
> +	lockdep_assert_held(&iommu->lock);
>  
>  	if (!iommu->need_sync) {
>  		/*
> @@ -1465,15 +1452,28 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
>  		 * command queued before this call (possibly on another CPU)
>  		 * is guaranteed to have completed before returning.
>  		 */
> -		data = iommu->cmd_sem_val;
> -		raw_spin_unlock_irqrestore(&iommu->lock, flags);
> -		return wait_on_sem(iommu, data);
> +		*data = iommu->cmd_sem_val;
> +		return 0;
>  	}
>  
> -	data = get_cmdsem_val(iommu);
> -	build_completion_wait(&cmd, iommu, data);
> +	*data = ++iommu->cmd_sem_val;
> +	build_completion_wait(&cmd, iommu, *data);
> +
> +	return __iommu_queue_command_sync(iommu, &cmd, false);
> +}
> +
> +/*
> + * This function queues a completion wait command into the command
> + * buffer of an IOMMU
> + */
> +static int iommu_completion_wait(struct amd_iommu *iommu)
> +{
> +	unsigned long flags;
> +	int ret;
> +	u64 data;
>  
> -	ret = __iommu_queue_command_sync(iommu, &cmd, false);
> +	raw_spin_lock_irqsave(&iommu->lock, flags);
> +	ret = __iommu_completion_wait(iommu, &data);
>  	raw_spin_unlock_irqrestore(&iommu->lock, flags);
>  
>  	if (ret)
> @@ -3469,7 +3469,6 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
>  	int ret;
>  	u64 data;
>  	unsigned long flags;
> -	struct iommu_cmd cmd;
>  	struct pci_dev *pdev = NULL;
>  	struct iommu_dev_data *dev_data = search_dev_data(iommu, devid);
>  
> @@ -3480,9 +3479,6 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
>  		pdev = to_pci_dev(dev_data->dev);
>  
>  	raw_spin_lock_irqsave(&iommu->lock, flags);
> -	data = get_cmdsem_val(iommu);
> -	build_completion_wait(&cmd, iommu, data);
> -
>  	if (pdev)
>  		ret = pci_for_each_dma_alias(pdev, iommu_flush_dev_irt, iommu);
>  	else
> @@ -3490,11 +3486,11 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
>  	if (ret)
>  		goto out_err;
>  
> -	ret = __iommu_queue_command_sync(iommu, &cmd, false);
> +	ret = __iommu_completion_wait(iommu, &data);
>  	if (ret)
>  		goto out_err;
> -	raw_spin_unlock_irqrestore(&iommu->lock, flags);
>  
> +	raw_spin_unlock_irqrestore(&iommu->lock, flags);
>  	wait_on_sem(iommu, data);
>  	return;
>  
> -- 
> 2.31.1
> 
