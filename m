Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794828544;
	b=ADKrgjaK1qvSwlyeFOYqF5X92R8eSIYVv03/pTiwqy1+kZUTDLXMUUWN2SzbknT3Uj+W
	 5S0lEX7tWatGtRwHX+qBrUKKtTI2gi3Tl71ov9emdr+zdmYl1KZczop6rPU1PrUwamzPa
	 dxE62zkIcVephJvJdV6zwDEkYgWIpkdCZjI9p98DzrA34wtu06sYvpdwkXliw7G0FABKE
	 CAFDuhdxWr8SApdRww7lJluCerKTGVFuY7M/O6POz5k27IcOZbGchqKfYYN0OAdI653Ym
	 kv7jE8hFouOwm9J1L4p39wEOf0Nohm2vyvr7rXYXhowbbkcmNzFEmgpu91pF0eN+Ymw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828544;
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
	bh=7KwIqvCUN+4njv23JfE7MRZR5BAkrj+O7Nkml8+2Y0Y=;
	b=yUyf/lzT3jc+ipK4k4fzuW8BQVQiPdShy39prIZc90LcJfnQCeDxtTRSxxCmsWhwCKh+
	 G7/5Z1HbozG8oTs1ynr5PLdOaXMHdBr5o5bNaGxSGBeQGpcYnirEqJzQGK50A795APq2t
	 sOnIvkEkEJpBP7DHPurK1tSEHVgvSAGc8kLcqtWBRpu4XB50EBIL4VcKBIDgc2GtF7Wd+
	 LbCcX386YxVHpgPQhphm/uH92Ss4Y7BQsKv2diMhoCs1NkLagaZMCkvhLbhDRS9W44rG7
	 Ij+YCuJsHTwCmBePTK992nceZrUf4X5js15hsEKrYTS8fvivPBdQp81NK4txA1AIwmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dpOaM+2n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.2
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCBF606A337
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 11:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCCBF606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dpOaM+2n
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMEBIrVosd1pl6wR4+070sKKp73q9MhtBMbbGhMrwmumUsW8HKhu+exO6MNIlz8l5tigHNiRbUyvCN2l0/nhVjlxC+0WaCLp9u2qVFhqkXBOzVf+RzFKUfowhbfhphRH87lsq6BUjRiFstQt+cgdOlLQS8FLyqHAQ+jr9dXvPiSuiI1rzuIyhm2ywSfldy2lLjCa/pR9fbgme3T7ToHGEAbmVSAhvA8U4ME/jG8v8K0+Or8RQkGMah1GrytUDbrS9fPLbDUJDYtQRAJWoHBHL2sld86mZYTHIVoeX+wzMMKD6Z4AG+ILtzWyCiqaPlpXudZ8D5Emc8rJL3PplAovew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KwIqvCUN+4njv23JfE7MRZR5BAkrj+O7Nkml8+2Y0Y=;
 b=dryhLlNnQKNFTPzyPf94CDLDHXX0X/J/9gQ3vo1Vba4HbQwIkemsfuj8WJADztdZVkPYpw5Pump1ESYMI1Lhhi2f13wjOcGPxHRw6lc8FcwebfanJ6OlcO/KJ/cpaG2/FGJCPphXDuJHnZqTANIVnwNMtubaWE36f/pnbRQbxkdDESoxOIllYyMtLTU3V4lt4zVe495T3aqlGtyeXHXZFZ4RdXXE4DVY6jAcwXQB1jT6FVg5QWXkjjigIzXbfr2Hza4MjfZsNfetsQuRTekrgGWtPHdX/Rn8uV4rQsBY3ccyE7J2xX+rJRK6pfzgEPTNIjs1uznEaAY8SazsNoB4KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.alibaba.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KwIqvCUN+4njv23JfE7MRZR5BAkrj+O7Nkml8+2Y0Y=;
 b=dpOaM+2nTxg+NRGQbMz3+PhVj+dy0t4pkCZRtl3ZP15ulOkkEYq43bBXsB/HVs79ZT22F05NAN/TSY9zKEsMtBuSwjU+kmoTTqYFNUtydswoRv1MNQfjaWvfQdYTGNZhBRV0vUga+nj2zm9CTcqUN2NVJYaq9NZFnyrD8FPUSA4=
Received: from CH3P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::30)
 by SJ2PR12MB7895.namprd12.prod.outlook.com (2603:10b6:a03:4c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Mon, 16 Nov
 2026 11:26:31 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::73) by CH3P221CA0018.outlook.office365.com
 (2603:10b6:610:1e7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Mon,
 16 Nov 2026 11:26:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 11:26:31 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 02:40:33 -0600
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57 via Frontend
 Transport; Mon, 16 Nov 2026 02:40:30 -0600
Date: Mon, 16 Nov 2026 08:40:28 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
CC: <joro@8bytes.org>, <vasant.hegde@amd.com>,
	<suravee.suthikulpanit@amd.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: Do not clear unobserved log overflow status
 bits
Message-ID: <2icavkel5nx5423kyzmxbov24j2pqt3cx4iis66kktvvgmmxzb@cmdompfw7hlf>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|SJ2PR12MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: ec656ea0-5951-431a-5142-08df43d476ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|22082099003|18002099003|6133799003|261009223027099003|11063799006|56012099006|10067099003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	TfEmnKHQwdM9W+WwLXkHMzyBREY44/oXOCHcUVaW6ofoofbMb+zCRYf0efSkgfasodt/8Jf7VVkSi8Pl1nVHtAcLz/bPgAYyAqogcTop+WG9L6443AStDhNcbnknGba3q+16uODonNnjCqD0vEl7zOV1vGbna6Ajo9jfpWjMxTaQYIBKrI4/z2D1gKe8k3O9sQxk6sbVJqkEL14t+nJfx4vEGNIZj6NGfrMLmsqPIucHk3XiFAozxMJZH1lf1K+Ri4HIDQvv9O2hpxsEp5peu9BGssmlT2xTXkRd0v6XhGgmHC29iysNAKztpitxuNd32prG2Z3Aoo9w2QIjTQ88Du9XPu51m16WC1v4FzJOKbvS/h+erCgpCtmZvhhux3QGIp2XXDpNcW2RE2Nhj8E7yn+GKdqwH4ZvjjR533ggRfICT0sTNQSRe2xrwXI8xTh7SVRsnCHIcglNuWbISFT8WiY90FWBzWI9/iEzm602fZNWFTVfGGQ7PlnMgJCbOZmh6vRgtwOExGCaNQ8pKsVfEC9Tln4eMd3rct98dCDty7yo89W+IsiElFaad4ihjnZLKv7J6e1V4JM+LhAch7R+fZmp+gXvY6JSV4XZszwOfbaLjKI5zkFmzSw8sAZVpxBXdDnx4U+VUhPZ1Q1Nqu9yGuPiTUzMvgbEzqlxYPYNOW7aaoWKcGe/XiMZNBR9vfZEz708HVYvlUt1fTZzfdcfuQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DdKu3innBdHNukhHCsuTN8L2L0ubrrjPu/ZPvyX6ANzm+GvaNLhvnwpVTvZLMRhkQCAO+7tO5DPPjldQ2sgCXl5QGAFFjHg6XAP959rW0bhbh4ydUDGqT733eeJPybWRUwDONdDRfBrcu4j322wJLBKSvmNe3Q/2uQBjDAZoEe07gebshd7V7upFBo6lwJz5oVXRzo9nb3aT6q2/xb/VWZB5NzAxJBeWVCnvm0SW9YqyC6cnN8zOT1sOC2Wmyu4RZIbH01grW6Z6T5JxdiXu2SvtoXpVzwT/ArOuYcYsqjg1nvPn01msqW6PfhGDmy0ieEg9/6aN4trGr7cYuPP78JH6R2z3/+cjC8rkDC037mZY7gTfj4JsGQXixypL9Bc2RelYLS52l5tn56DHoi4oJzwUq4uBC+Xr7ABekNXE3FdzTw4vlceOW+D+NryF51qb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 11:26:31.4952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec656ea0-5951-431a-5142-08df43d476ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7895

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

Otherwise, Looks good to me.

Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

Thanks,
Ankit

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
