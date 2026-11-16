Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794828231;
	b=sc9VpBAiu3rIzvC4e9hj+UrZeicF2pTcJGOe5nY3/7Kke4XWoFHBPoN6HZwH2sGA30g9
	 X/ty5ZSmD/Kgn5GXiM9jmPMriGeZJsTPB09zI8kjrDsYYXOyvumq7N5cfksrqmpfJMAFf
	 w/R2rXtVCimb5313/e1/bBHNU3qxGaW5/vZavTwkebp4enAPpYPp6sC3kS7VCFyIfB+Eb
	 DgKK7s4/1vrFSbvNSdAn9g1K6xrY10Suo953e6rk2v6O8XHJtosz8nsVGIznG+Nyti6HG
	 GSUg0FuE9SErvuclX/S/FPV1+nge/n12dcZRKVbCVIZRkK96ksXywBGj0S9qP41stcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828231;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-EOPAttributedMessage:
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
	bh=OI/WrA4F7+It9HSnetMOFeSFw5BXsAiZxPgCSBXV4dA=;
	b=RtLTW3LgRRmkyOJf2gSS7tTtCT5JsJB8uTBbu/jGdRk2ulXSzI5CIF8NxWljInnBwLg6
	 6SBp9P6Dwb6QUEvLMWecVEcP9kenUhCcMY7hecGbRyG/Myt7MMavI9JJiI5PnwXCVk1rt
	 +9hT8s33WY7XH1nx1/qdEhbR/elrI+heGif4x7bERuldXRkvr+q5tjkK7TnYgwZwVhT3P
	 LRRNxdscfgrDjUCBzRlOp3vqUKYKVR1aBWnm1F0wsuclRP7O9h51d7/m7obZ7xy9iaVF+
	 XSOAsi1xOJOLaQdPEek2Chc2VXngdL5EDSv8aGID0EOB74IZJcuKjGx0820RNfsv1aw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RhD1+RKc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.16
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013016.outbound.protection.outlook.com [40.93.201.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72978606AB7B
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 11:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72978606AB7B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RhD1+RKc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAZuBPiqUJo8yh8dQE1KK5a+7AsX7dNnis1tfEcdnv8jHNYP7mZmqHTs1TCqnSsHFmzQSiEhtXfOgxKBMBpwDzJdmTnWoatd7Z32xXkDgGfYehpSUvopHJ4ENVA3rsKRvOJZr2f9X+h83Nn4Rnei4gmZU4XQa+cgpGmTLMhJyTDwaTPiujQY0n6hFgBqzfuISd0gCPzA/xKMLqaHKTMou2wtXG88PuVYh1qEVctVtH9bhInPja+2ePvWzRlH6RSShls84xYHbj8nfn2ADnOA1F+KAhtBzgs2ux54rrjYWTFkQH+AchijiC/MXjbd9hYns/wW8BZ6oOjgzN5eJ8/WDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OI/WrA4F7+It9HSnetMOFeSFw5BXsAiZxPgCSBXV4dA=;
 b=CU9wcpbTGViksoWBJNNlmoqgcOjam7DGEKtcsho2I/snsVTj/XpWr8DSJMaULBGX366Ywtug2APzaAxoExIkoyjBMProDbTVl4IGItjRy3XWrbg8815qI1Z/Fczx3Ofsmvnq7jtLjx7/3c9zcJcywCDV/cyPbipCaSLwZt7st3oP3M6OVm6L9e4svtMop7jRz8aL8ezLojYQmiGsKgWd1oVdh3PE0DRfyjsUl2UpxZS5qxxlGKtJ66hqnjLu0Af23gN3ECnwwqPcvr3Bgzn7k//32O5vfB4Bt4ntNfCFE3f8EDp/8l9griWBsZ5KA2q5VEGMJSDxe8JsmIIFdyWoJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.alibaba.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OI/WrA4F7+It9HSnetMOFeSFw5BXsAiZxPgCSBXV4dA=;
 b=RhD1+RKcoHwEjo847rUmGmXv4OQasbwObT9q/6N22vNIjxx77Jfr97N+dnO1/vWshPuG5m3y8RpEP2gv4aaoxWxN5QzpMaV9oCx04IyrrhIg3OZ+Mk6B7v70pBZFd+nc32MZBCjREWWAtqSogfxLoGniZdgc4NIc8wYlZBJ2BCs=
Received: from CH0PR03CA0110.namprd03.prod.outlook.com (2603:10b6:610:cd::25)
 by SA5PPF8ECEC29A9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Mon, 16 Nov
 2026 11:23:46 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::97) by CH0PR03CA0110.outlook.office365.com
 (2603:10b6:610:cd::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Mon,
 16 Nov 2026 11:23:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 11:23:45 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 00:30:59 -0600
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57 via Frontend
 Transport; Mon, 16 Nov 2026 00:30:57 -0600
Date: Mon, 16 Nov 2026 06:30:54 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
CC: <joro@8bytes.org>, <vasant.hegde@amd.com>,
	<suravee.suthikulpanit@amd.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: Do not clear unobserved log overflow status
 bits
Message-ID: <4nnekry6a3q52hsibm7cqrwbtrkr5vp6yuhwucreaz3pckt2a7@rh36fx2u5i3o>
References: <20261116033902.3277875-1-guanghuifeng@linux.alibaba.com>
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
In-Reply-To: <20261116033902.3277875-1-guanghuifeng@linux.alibaba.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|SA5PPF8ECEC29A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 542442c0-7c2e-4a61-6e49-08df43d41407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|56012099006|11063799006|261026140227099003|261021123027099003|261026121527099003|261028144727099003|261102123227099003|261021121427099003|261022105027099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	5piqGFaa77JY1ww3GDICBzyaxa6r9G5XKkZNVMX8Z2pw2fQqNwz/kTelfSkLuYwH1+b53EpzaX6tP4jOjTtS+MvVllOnly9keqRvRA25R6qORG13E2wgSAN55sAf9CV3BnM2CQFgHxWeO2ZCLxcgtNb0EHUm0iXs237G0FGCTxD+Zt6l2Hl62K7jgL0a4dhj9RQ1Jud7kSfYNL3dAL8iIdkOzszjL6MeKmvZHnXgHd1Jyuf+bUn9lqHS/q2pveX9TQ1u158TO8hX8bz2OOX9Tpdk18wQegmOP9NVn4pglseAAwFMzYztHhDAUibMC64mCi+fVV17k/zlM2foYEeYiSTNaX9s6FBDpSG+OvVtMdFUxhTlYgYMV5p63plrB1ojpmVMK8HL7rBBwDj2OvRmUMgIRQg33UhcmgXa853zTURjFMkZ+Mbpxbr+QfNzXOirjZR92UuN1a/lE9Bfkd0rDWW/ssLvyNPs0WlnNVOtorUY6RyjszrVL1yyM5nKQnka3ldu7hq30HFeBvrF+qJeqPildq1+hfTiyHQC+XDq0brXqnR84H+nKnhfDqb6MKMigZKUT9o1BQAB46m+RyVqpsULj823n47EQ83Tz//nB/sFLEsqj6lDMqvzvAVY8eooULpOGGa3EWy6offae3vUAGUvsuwT6gYimhciWBMZzkOn/GW282pGWsg45OKBLEQitGTlx5l17ksUZPTDWsFLrA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(56012099006)(11063799006)(261026140227099003)(261021123027099003)(261026121527099003)(261028144727099003)(261102123227099003)(261021121427099003)(261022105027099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Jymzh5uDZCNsBV8f+d9avnf6xCeSm2ieQIB6pNlH5PaQgtRj5qnx3oCejorvj9FPldJVRIy6FyJ9DEw3yfkAT/9OqUB8aWw18npg5BHde2wg/s9qG/XBU83XJ6y9NLd+20OEaHImGfjEwITDm2Kz4ftUGqxW0ROKrM9oyvIvKCLbXzmfUMf6+aeaClA9Uf/w5icd8CH37LW9Dh0bEbfsDa0Nk8cgjMDtiYL3+fOA/uG4TU9VGugTxLdC+4FJjEKH3dJQ/P3vW4CRUbaW8+3h40xw42VAMqGmvGIYT717wMDVPkC2JbpykiYw9B59JjxQhGy8scF729irj45933TAi9qY4kD+hPW3qtNm3qbueOngRKD/q6vTxtlP2xVWTuPjmnWTQyHRT1RUwiXADvo17TfJ9BeRRCt4QsoXT7vSCHANdKdLJnAtV1pXd957BUEq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 11:23:45.7741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 542442c0-7c2e-4a61-6e49-08df43d41407
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8ECEC29A9

On Mon, Nov 16, 2026 at 11:39:02AM +0800, Guanghui Feng wrote:
> amd_iommu_handle_irq() clears the interrupt status with an unconditional
> writel(mask, MMIO_STATUS_OFFSET), where mask is int_mask | overflow_mask.
> The log overflow status bits (GALOverflow, EventOverflow, PprOverflow)
> are RW1C and, per the AMD IOMMU spec, transitioning them from 0 to 1 does
> not itself generate an interrupt; they can only be observed by an IRQ
> round triggered by the corresponding log-interrupt bit.
> 
> If hardware sets an overflow bit after the status register is sampled at
> the top of the loop but before the unconditional writel(), that write
> clears the freshly-set bit while the stale sampled status does not
> contain it, so overflow_handler() is skipped for an overflow that really
> happened. For the GA log this is fatal: amd_iommu_restart_ga_log() is the
> only recovery path, and per spec section 2.7.4 logging stays halted until
> GALogEn is toggled. A bare W1C of GALOverflow is not part of the
> documented recovery, so the GA log stays halted, no further entries are
> written, GAInt never re-asserts and the GA log interrupt line goes
> permanently silent, losing all AVIC non-running vCPU wakeups on that
> IOMMU.
> 
> Clear only the bits actually observed this round by writing status & mask
> instead of mask. An overflow bit set concurrently is then left asserted
> and is picked up by the existing ERBT1312 status read-back at the bottom
> of the loop, which re-enters the loop and runs overflow_handler().
> 
> Fixes: 2379f3485239 ("iommu/amd: Refactor IOMMU interrupt handling logic for Event, PPR, and GA logs")

This commit only moved the existing clear into amd_iommu_handle_irq(). The
unconditional write already cleared overflow bits before that refactor.
The first commit that put an overflow bit into that write is:

Fixes: 5ce97f4ec5e0 ("iommu/amd: Recover from event log overflow")

The GA and PPR overflow bits were added later, by af47b0a24058
("iommu/amd: Handle GALog overflows") and 274c2218b8b2 ("iommu/amd: Handle
PPR log overflow").

Otherwise, patch looks good to me.

Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

-Ankit

> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> ---
>  drivers/iommu/amd/iommu.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index d0d55c93a480..39254671b924 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1168,8 +1168,17 @@ static void amd_iommu_handle_irq(void *data, const char *evt_type,
>  	u32 mask = int_mask | overflow_mask;
>  
>  	while (status & mask) {
> -		/* Enable interrupt sources again */
> -		writel(mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
> +		/*
> +		 * Clear only the status bits observed in this round.  The log
> +		 * overflow bits (GALOverflow/EventOverflow/PprOverflow) are RW1C
> +		 * and do not raise an interrupt on their own; clearing them
> +		 * unconditionally here would drop an overflow that hardware set
> +		 * between the readl() above and this write, without ever running
> +		 * overflow_handler().  Leaving such a bit asserted lets the
> +		 * existing ERBT1312 read-back below re-observe it and re-enter
> +		 * the loop so overflow_handler() runs.
> +		 */
> +		writel(status & mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
>  
>  		if (int_handler) {
>  			pr_devel("Processing IOMMU (ivhd%d) %s Log\n",
> -- 
> 2.43.7
> 
