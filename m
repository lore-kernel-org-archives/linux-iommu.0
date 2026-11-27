Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795760476;
	b=PEQOPpWJWPfxiEc+Fzh+Qe9z/jdVI2t08Px4iMEBG8ewSdepzISpL62RirDsx3VXVc9W
	 q7elRpa8ajO9ZrDpprAM+rIFCJO4c37PaSrlpV0bFZzA8nev2zR228DsG+41m5bei8pey
	 AYB2biJSRhq70XWphfh/TPjdFHoVyGyVsrD665IzJ0jB9HmoOFnVEBzan7wRJYLOC0Rp9
	 VKXxJXjYBw0U2o3feYtVl3RswsQuahPn3vzSJ4/kEJuRjbDb2Zcl1PF8UlHwiHMQdL01k
	 lpx4/sPHvHObyJDu5/KrV3Djq+rLV10D1gAwkYID62+218rpeEZglh9vm2wjNHnzxng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795760476;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 CC:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=y6307av9SmVBQuz0zC9Mw0FP2yW7V/9P8V0XCvI5Rfs=;
	b=xQ92Mi22fpn91eqTRh3JZ6vMWozCx+fO6oYiKOACP651SGFlh+wQqXcn+hKL1xssHLlT
	 ZBmD/4eB/O+6s7XbP/ryAd86BDF2yYGCQXHUZiUmSc9jsGuJb0/ND2JrT15uvyUTFPJL4
	 E0rfbWXtlkAAOz3b3IaxuBsIBmSMO3ZzAiwTvgnBMQP2uBL6H0HwCx7aAWC6V+fIW8m7w
	 +r4xF+TljY/pF3PrAu3/mECIsucK3BIuJTwIRKCz6Y57vjwSmgy7p5TNfzbuAtW7l23fO
	 VPDQi3jjjoo5Ro26dLh2JPrmgGF6E8yI+Stn0nWD+MYzuupCALQz+DHhXhXt1i1gBKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4SmLXmOc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.22
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011022.outbound.protection.outlook.com [52.101.62.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E6C606A31C
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 06:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98E6C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4SmLXmOc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTLrAXNgKdw/9ZBdnX0N4zkvicrJT47jl0XGhq2QV7QmqtbvSwSE2qG11Ko1sR1DJvs7kKPrD7jvsPnX+NafMckOusFyjOrpdTosqHLZtrNiBKYPSSqsq/Czk28A8K1kV9m8hUWwd84KMKJ2Psg10algzenKv2M+R7CmlScu9EcfFh+KnmS6MOXpBptJvIOnHiM0pMrVXxqFyoCRkK9S642aqQjedOHTQoYGCGFjBaEe4rLNI4Dm1vAc4N302572vPKuRzaLJVvJcX8VcZu1wfJ6ClDh3OSqo2ow5RcyTNea11drKR0eb+2M3WvyPY9OnH2JLGK+xtAZLqjMx+ud/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6307av9SmVBQuz0zC9Mw0FP2yW7V/9P8V0XCvI5Rfs=;
 b=NcmXGtSxTcF57GPtAk6ZB+x+3QeUHd+ECBjwgeFuZYXZIaLddc4hEkI22s6gZz3N1jyunx9a/xJMw+GKXuXsQo7+skV3LsifvmF7tJPWtG+FocP4BsPILVGIh9ir4zLbcvx/0ZJrO1OXV/mRFGLzvSNwjklPXoOMVNuAKP56Jis57RY/L/yzAf8OA6ZsJYwPp6dD1nui2zCtQRislH78y0SEwViYiuFxVGFjlRU7o1EbUxvDQeIRtjsi7jWnKrQR74qE8wEf63V/KXDkcITN90Bg+aawnwQoLOMjDPQUU5ZP+lRD9uhh4i9zuQh+dBc8OWZa8sF2au2oZKoWOjKEmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.alibaba.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6307av9SmVBQuz0zC9Mw0FP2yW7V/9P8V0XCvI5Rfs=;
 b=4SmLXmOcLOkvMeiSDSHBvN42zIvAVmcyzxCLNROyAmP8uvFL9s2ct+MDgHbIzg36Nqasn7L9XF23euiYyIk1OO27/pgg4BjSu3uhU5ioJEXNWpklj4wANDG1aMHrYU77EjOHaK5HuESIoEvFmHNbh6tCuMeJEw+THtokpNcv7pE=
Received: from PH7PR17CA0024.namprd17.prod.outlook.com (2603:10b6:510:324::21)
 by SJ2PR12MB9189.namprd12.prod.outlook.com (2603:10b6:a03:55b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 06:16:51 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:510:324:cafe::5) by PH7PR17CA0024.outlook.office365.com
 (2603:10b6:510:324::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Fri, 27
 Nov 2026 06:16:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 06:16:50 +0000
Received: from [10.85.44.127] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 00:16:47 -0600
Message-ID: <633f0e98-9a59-450a-bc1e-d9a5c88922df@amd.com>
Date: Fri, 27 Nov 2026 11:46:40 +0530
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/amd: Reuse device data for IRTE cache
 invalidation
Content-Language: en-US
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>, <vasant.hegde@amd.com>
CC: <iommu@lists.linux.dev>, <joro@8bytes.org>,
	<linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <will@kernel.org>
References: <721a92c6-fbf3-4f92-9812-3765dbe4af6a@amd.com>
 <20261124121518.440906-1-guanghuifeng@linux.alibaba.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20261124121518.440906-1-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|SJ2PR12MB9189:EE_
X-MS-Office365-Filtering-Correlation-Id: cdacadc9-5768-4426-25ad-08df4c4e0651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261028144727099003|261022105027099003|10067099003|5023799004|4143699003|11063799006|56012099006|261102130727099003|261022075727099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|261026121527099003|261026140227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wN4m4TeK3I3dCsExf7LV+0F73LN0tqGSvQniU3lwlcKvuAB7FBQTFrAuVeQLhIU5HO4RpcCL11cBxjzd4aJc0iGIGgdZg3a2Z3BczLeyYxdOzHkUDEh1m8fSYXGcvUhfHkbygrW92ZiTbaHDcAJzzXsyoFbyziurROjvVnAZI6gBYZGkiZaqMcdyLgTJQsWOJwECHYlh93wOdRsBd44jZQXD6DJ+fpBZIRtR7o/hI8YImpGgLgYefMDoBwSA4L7rjdAIsD5ItlBIjknEhHXJ3ojM8Oo7MiD9su3IQ8VVBUcGMp8dWTENBXxuwPgytA/EUB5NBbxFcJxNvXCBZg0hF3FUpJhvOiXtAQqODQ4qjCR8ejVvMnK7FYTY0FbmnIpk96xSZHfNbTNHCPm0U6417mg411+z0w//dBIIKETpdwDkHp9KSid2rN0jAbAN3DkDqaPg8QH6Xxlzz86nIA9xmZGcQRkf5X48ObAGf9gVC6ZOFy1EGa9/8/oaHzADol46pbCNNqZH7gBX27nYw20b7D6DIsz2zV9U4+xohYkZ0l9UdBCBigz1lJBNuaRV+Mf24VbTeGr1hGuZYu3O+ozBErdrU2f9FVNaV0l37AcUWhRTOoBDIfuiIL11Fr8kdZWbBdf5Tx2QeQao4QHyuIwbCp5Ry6nnxoDzmdjMWo3292Hjy2lPgo+YHHqzYhTgEKwrPVt17vZ60mHtodi9WJKYsA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261028144727099003)(261022105027099003)(10067099003)(5023799004)(4143699003)(11063799006)(56012099006)(261102130727099003)(261022075727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(261026121527099003)(261026140227099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HVPpo3izuMWgVWgb21s5Gs8QhR94flS6Xz0Xuau92jrMFNC7KjcbNzf5R8SMAe3OSuWryj80NIob+yFv0eDpM2BaFRZJIoTRV+I5gey/4cSKxxUdLWceZFJOwlzV61xzka4ZMDdMr5j0XoRWnlfC/3Cyk4NXIxAZBUXhILTKP9fnUSVQ9RKIQnJTqQjia22YeKdf2k7rxZqLYwpW9QB64+Y7b/JtnHCPB9nI9EtANwYkWJLcY/8mTTskH8SuW3xFlaVxwcy32MczpgqWeBjGh91Rmqin0FfsdykzfBV+hTcozpY0CzKgZBZXjAv+oPHqE5wD7qrys5BF2Jc7jRU2qVtNToHv2pdi7rVdiN+4kDaH2IhWCZVJFz1yyd/hkVmdC+POyzISgPh7nYoxWoe/1IBY7SMEspLey80Az6HPX9txwhfspte4PVlytFJx9SIw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 06:16:50.6029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdacadc9-5768-4426-25ad-08df4c4e0651
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9189

On 11/24/2026 5:45 PM, Guanghui Feng wrote:
> The DMA alias invalidation path in iommu_flush_irt_and_complete()
> performs a linear search_dev_data() walk on every IRTE update.  Nested
> VM entry and exit can switch multiple interrupt routes between guest
> and remapping modes, repeating this lookup for each posted interrupt.
> A reported workload with 4334 device entries shows median lookup
> latencies of 22-33 us per invocation, even when IRT caching is
> disabled and the lookup result is unused.
> 
> Save the allocation-time device data in struct amd_ir_data and thread
> it through all IRTE update paths:
> 
>  - iommu_flush_irt_and_complete() accepts a dev_data parameter.  When
>    IRT caching is disabled it returns immediately without any lookup.
>    When dev_data is NULL (IOAPIC/HPET allocated before PCI enumeration)
>    it falls back to search_dev_data() so DMA-alias invalidation still
>    works if the device is later probed.
> 
>  - modify_irte_ga(), modify_irte() and free_irte() accept and forward
>    dev_data.
> 
>  - The amd_irte_ops callbacks (activate, deactivate, set_affinity) are
>    extended to carry dev_data so that amd_ir_update_irte() and the
>    irq_remapping activate/deactivate domain callbacks pass the cached
>    pointer.
> 
>  - amd_iommu_activate_guest_mode() and deactivate_guest_mode() pass
>    ir_data->dev_data directly.
> 
>  - amd_ir_set_vcpu_affinity() reuses ir_data->dev_data for the vCPU
>    affinity capability check.  This path is only reachable through
>    irq_bypass producers (VFIO-PCI, vhost-vDPA), where device probe
>    always precedes IRQ allocation, so dev_data is guaranteed non-NULL.
> 
> Device data is retained in the segment list across unplug and reused on
> reprobe, so the cached pointer remains valid throughout the IRQ
> lifetime.  The PCI device is still resolved through dev_data->dev at
> flush time so that later device association is observed.
> 
> DMA-alias invalidation, command ordering, locking and completion waits
> are preserved when IRT caching is enabled.
> 
> Fixes: 5aac28784dca ("iommu/amd: Invalidate IRT cache for DMA aliases")
> Reported-by: Yifei Ge <geyifei@linux.alibaba.com>
> Co-developed-by: hr567 <hr567@linux.alibaba.com>
> Signed-off-by: hr567 <hr567@linux.alibaba.com>
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 10 ++--
>  drivers/iommu/amd/iommu.c           | 76 +++++++++++++++++------------
>  2 files changed, 51 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index f98770db0090..da6d90f3a574 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -1029,6 +1029,7 @@ struct irq_2_irte {
>  
>  struct amd_ir_data {
>  	struct amd_iommu *iommu;
> +	struct iommu_dev_data *dev_data;
>  	struct irq_2_irte irq_2_irte;
>  	struct msi_msg msi_entry;
>  	void *entry;    /* Pointer to union irte or struct irte_ga */
> @@ -1045,9 +1046,12 @@ struct amd_ir_data {
>  
>  struct amd_irte_ops {
>  	void (*prepare)(void *, u32, bool, u8, u32, int);
> -	void (*activate)(struct amd_iommu *iommu, void *, u16, u16);
> -	void (*deactivate)(struct amd_iommu *iommu, void *, u16, u16);
> -	void (*set_affinity)(struct amd_iommu *iommu, void *, u16, u16, u8, u32);
> +	void (*activate)(struct amd_iommu *iommu, void *, u16, u16,
> +			 struct iommu_dev_data *dev_data);
> +	void (*deactivate)(struct amd_iommu *iommu, void *, u16, u16,
> +			   struct iommu_dev_data *dev_data);
> +	void (*set_affinity)(struct amd_iommu *iommu, void *, u16, u16, u8,
> +			     u32, struct iommu_dev_data *dev_data);
>  	void *(*get)(struct irq_remap_table *, int);
>  	void (*set_allocated)(struct irq_remap_table *, int);
>  	bool (*is_allocated)(struct irq_remap_table *, int);
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 41ee4ad1dcf8..d171ccf2eee0 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3291,18 +3291,21 @@ static int iommu_flush_dev_irt(struct pci_dev *unused, u16 devid, void *data)
>  	return ret;
>  }
>  
> -static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
> +static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid,
> +					 struct iommu_dev_data *dev_data)
>  {
>  	int ret;
>  	u64 data;
>  	unsigned long flags;
>  	struct iommu_cmd cmd;
>  	struct pci_dev *pdev = NULL;
> -	struct iommu_dev_data *dev_data = search_dev_data(iommu, devid);
>  
>  	if (iommu->irtcachedis_enabled)
>  		return;
>  
> +	if (!dev_data)
> +		dev_data = search_dev_data(iommu, devid);
> +
>  	if (dev_data && dev_data->dev && dev_is_pci(dev_data->dev))
>  		pdev = to_pci_dev(dev_data->dev);
>  
> @@ -3578,7 +3581,7 @@ static int __modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
>  }
>  
>  static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
> -			  struct irte_ga *irte)
> +			  struct irte_ga *irte, struct iommu_dev_data *dev_data)
>  {
>  	int ret;
>  
> @@ -3586,13 +3589,13 @@ static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
>  	if (ret)
>  		return ret;
>  
> -	iommu_flush_irt_and_complete(iommu, devid);
> +	iommu_flush_irt_and_complete(iommu, devid, dev_data);
>  
>  	return 0;
>  }
>  
> -static int modify_irte(struct amd_iommu *iommu,
> -		       u16 devid, int index, union irte *irte)
> +static int modify_irte(struct amd_iommu *iommu, u16 devid, int index,
> +		       union irte *irte, struct iommu_dev_data *dev_data)
>  {
>  	struct irq_remap_table *table;
>  	unsigned long flags;
> @@ -3605,12 +3608,13 @@ static int modify_irte(struct amd_iommu *iommu,
>  	table->table[index] = irte->val;
>  	raw_spin_unlock_irqrestore(&table->lock, flags);
>  
> -	iommu_flush_irt_and_complete(iommu, devid);
> +	iommu_flush_irt_and_complete(iommu, devid, dev_data);
>  
>  	return 0;
>  }
>  
> -static void free_irte(struct amd_iommu *iommu, u16 devid, int index)
> +static void free_irte(struct amd_iommu *iommu, u16 devid, int index,
> +		      struct iommu_dev_data *dev_data)
>  {
>  	struct irq_remap_table *table;
>  	unsigned long flags;
> @@ -3623,7 +3627,7 @@ static void free_irte(struct amd_iommu *iommu, u16 devid, int index)
>  	iommu->irte_ops->clear_allocated(table, index);
>  	raw_spin_unlock_irqrestore(&table->lock, flags);
>  
> -	iommu_flush_irt_and_complete(iommu, devid);
> +	iommu_flush_irt_and_complete(iommu, devid, dev_data);
>  }
>  
>  static void irte_prepare(void *entry,
> @@ -3656,50 +3660,57 @@ static void irte_ga_prepare(void *entry,
>  	irte->lo.fields_remap.valid       = 1;
>  }
>  
> -static void irte_activate(struct amd_iommu *iommu, void *entry, u16 devid, u16 index)
> +static void irte_activate(struct amd_iommu *iommu, void *entry, u16 devid,
> +			  u16 index, struct iommu_dev_data *dev_data)
>  {
>  	union irte *irte = (union irte *) entry;
>  
>  	irte->fields.valid = 1;
> -	modify_irte(iommu, devid, index, irte);
> +	modify_irte(iommu, devid, index, irte, dev_data);
>  }
>  
> -static void irte_ga_activate(struct amd_iommu *iommu, void *entry, u16 devid, u16 index)
> +static void irte_ga_activate(struct amd_iommu *iommu, void *entry, u16 devid,
> +			     u16 index, struct iommu_dev_data *dev_data)
>  {
>  	struct irte_ga *irte = (struct irte_ga *) entry;
>  
>  	irte->lo.fields_remap.valid = 1;
> -	modify_irte_ga(iommu, devid, index, irte);
> +	modify_irte_ga(iommu, devid, index, irte, dev_data);
>  }
>  
> -static void irte_deactivate(struct amd_iommu *iommu, void *entry, u16 devid, u16 index)
> +static void irte_deactivate(struct amd_iommu *iommu, void *entry, u16 devid,
> +			    u16 index, struct iommu_dev_data *dev_data)
>  {
>  	union irte *irte = (union irte *) entry;
>  
>  	irte->fields.valid = 0;
> -	modify_irte(iommu, devid, index, irte);
> +	modify_irte(iommu, devid, index, irte, dev_data);
>  }
>  
> -static void irte_ga_deactivate(struct amd_iommu *iommu, void *entry, u16 devid, u16 index)
> +static void irte_ga_deactivate(struct amd_iommu *iommu, void *entry, u16 devid,
> +			       u16 index, struct iommu_dev_data *dev_data)
>  {
>  	struct irte_ga *irte = (struct irte_ga *) entry;
>  
>  	irte->lo.fields_remap.valid = 0;
> -	modify_irte_ga(iommu, devid, index, irte);
> +	modify_irte_ga(iommu, devid, index, irte, dev_data);
>  }
>  
> -static void irte_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid, u16 index,
> -			      u8 vector, u32 dest_apicid)
> +static void irte_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid,
> +			      u16 index, u8 vector, u32 dest_apicid,
> +			      struct iommu_dev_data *dev_data)
>  {
>  	union irte *irte = (union irte *) entry;
>  
>  	irte->fields.vector = vector;
>  	irte->fields.destination = dest_apicid;
> -	modify_irte(iommu, devid, index, irte);
> +	modify_irte(iommu, devid, index, irte, dev_data);
>  }
>  
> -static void irte_ga_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid, u16 index,
> -				 u8 vector, u32 dest_apicid)
> +static void irte_ga_set_affinity(struct amd_iommu *iommu, void *entry,
> +				 u16 devid, u16 index, u8 vector,
> +				 u32 dest_apicid,
> +				 struct iommu_dev_data *dev_data)
>  {
>  	struct irte_ga *irte = (struct irte_ga *) entry;
>  
> @@ -3709,7 +3720,7 @@ static void irte_ga_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid
>  					APICID_TO_IRTE_DEST_LO(dest_apicid);
>  		irte->hi.fields.destination =
>  					APICID_TO_IRTE_DEST_HI(dest_apicid);
> -		modify_irte_ga(iommu, devid, index, irte);
> +		modify_irte_ga(iommu, devid, index, irte, dev_data);
>  	}
>  }
>  
> @@ -3945,6 +3956,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
>  		}
>  
>  		data->iommu = iommu;
> +		data->dev_data = dev_data;
>  		irq_data->hwirq = (devid << 16) + i;
>  		irq_data->chip_data = data;
>  		irq_data->chip = &amd_ir_chip;
> @@ -3963,7 +3975,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
>  		}
>  	}
>  	for (i = 0; i < nr_irqs; i++)
> -		free_irte(iommu, devid, index + i);
> +		free_irte(iommu, devid, index + i, dev_data);
>  out_free_parent:
>  	irq_domain_free_irqs_common(domain, virq, nr_irqs);
>  	return ret;
> @@ -3982,7 +3994,8 @@ static void irq_remapping_free(struct irq_domain *domain, unsigned int virq,
>  		if (irq_data && irq_data->chip_data) {
>  			data = irq_data->chip_data;
>  			irte_info = &data->irq_2_irte;
> -			free_irte(data->iommu, irte_info->devid, irte_info->index);
> +			free_irte(data->iommu, irte_info->devid,
> +				  irte_info->index, data->dev_data);
>  			kfree(data->entry);
>  			kfree(data);
>  		}
> @@ -4007,7 +4020,7 @@ static int irq_remapping_activate(struct irq_domain *domain,
>  		return 0;
>  
>  	iommu->irte_ops->activate(iommu, data->entry, irte_info->devid,
> -				  irte_info->index);
> +				  irte_info->index, data->dev_data);
>  	amd_ir_update_irte(irq_data, iommu, data, irte_info, cfg);
>  	return 0;
>  }
> @@ -4021,7 +4034,7 @@ static void irq_remapping_deactivate(struct irq_domain *domain,
>  
>  	if (iommu)
>  		iommu->irte_ops->deactivate(iommu, data->entry, irte_info->devid,
> -					    irte_info->index);
> +					    irte_info->index, data->dev_data);
>  }
>  
>  static int irq_remapping_select(struct irq_domain *d, struct irq_fwspec *fwspec,
> @@ -4133,7 +4146,7 @@ int amd_iommu_activate_guest_mode(void *data, int cpu, bool ga_log_intr)
>  	__amd_iommu_update_ga(entry, cpu, ga_log_intr);
>  
>  	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
> -			      ir_data->irq_2_irte.index, entry);
> +			      ir_data->irq_2_irte.index, entry, ir_data->dev_data);
>  }
>  EXPORT_SYMBOL(amd_iommu_activate_guest_mode);
>  
> @@ -4165,7 +4178,7 @@ int amd_iommu_deactivate_guest_mode(void *data)
>  				APICID_TO_IRTE_DEST_HI(cfg->dest_apicid);
>  
>  	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
> -			      ir_data->irq_2_irte.index, entry);
> +			      ir_data->irq_2_irte.index, entry, ir_data->dev_data);
>  }
>  EXPORT_SYMBOL(amd_iommu_deactivate_guest_mode);
>  
> @@ -4174,7 +4187,6 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
>  	int ret;
>  	struct amd_iommu_pi_data *pi_data = info;
>  	struct amd_ir_data *ir_data = data->chip_data;
> -	struct irq_2_irte *irte_info = &ir_data->irq_2_irte;
>  	struct iommu_dev_data *dev_data;
>  
>  	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
> @@ -4183,7 +4195,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
>  	if (ir_data->iommu == NULL)
>  		return -EINVAL;
>  
> -	dev_data = search_dev_data(ir_data->iommu, irte_info->devid);
> +	dev_data = ir_data->dev_data;
>  
>  	/* Note:
>  	 * This device has never been set up for guest mode.
> @@ -4225,7 +4237,7 @@ static void amd_ir_update_irte(struct irq_data *irqd, struct amd_iommu *iommu,
>  	 */
>  	iommu->irte_ops->set_affinity(iommu, ir_data->entry, irte_info->devid,
>  				      irte_info->index, cfg->vector,
> -				      cfg->dest_apicid);
> +				      cfg->dest_apicid, ir_data->dev_data);
>  }
>  
>  static int amd_ir_set_affinity(struct irq_data *data,
> 
> base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f


The V2 test results are similar to V1

Tested-by: Sairaj Kodilkar <sarunkod@amd.com>

Thanks
Sairaj

