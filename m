Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013051.outbound.protection.outlook.com [40.107.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCA8305677
	for <iommu@lists.linux.dev>; Wed, 24 Jun 2026 06:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782282168; cv=fail; b=hNIHEjv2oo6bkl6G7+tCxLfFmFbyFV3qN/6qeaFn7EtPnYQv7m8zqzDDcRYuC6piRNS9vhNn/Ll2nLJyyiO5EYOB8vFyLSSZ7N+026fFyzUeOUz4EUxsTI7zj7hbC9Od5U+vNZtjzV2rwLVpQBXKl+5Zxz1DhXDJPo3nTlMVIDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782282168; c=relaxed/simple;
	bh=uM+zR6wU9FOvTMIU9ar/i7kJkuhIRTqY7m7Rek6rna8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3+A/NPd25gMTzgsgPTvKVMOBq7DzQ4ZpHHBEUWyiH2x6vZwwWOgAuKdZ3n4O++J93crC0ANWbKQAfNqgj2J+QPYch86bML2zUjEMHyQv3+qXNFH63EkQZhbx2Zqzci9or7l8lRxOJYWTDNUh4gSB4I+mV09LxM8p258mGCD3EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KmXedbCy; arc=fail smtp.client-ip=40.107.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KmXedbCy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJu5XPuG2p7gyU1SvAiQiDGRWn2YXAnSBwefxFoM+pNuKc0cWL9Mdveyeg7hR0DAKL2Jl+3jydgwrMTSIr9/Q10EM9IW7zP4XufZSR0tnWXFY1pQSVkImhT6MnZp5b4OQOAQi7S7nksjuzSisbLv1cKluYAMxphwNcPA2wkczLUmnAzlrZhDy/XMS/BYPyVK0s+ueKKCgc2eLdM9DqNp2ddPE3CmIPzlQ8A/Je/m7inJNfgS3Eg5loiM5sTwTBnZW6nl1Qdxz51mA18t4CJatG32vlidlvYNSXG6aW8BHZviI73i689x6IkYF9YbFLQmecg04DDddkZAjt3DtYPTDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SATZpmG3gdSD3bW5KdQlwRksWp9Ur7q/As9fBxqamyI=;
 b=sbuShPuNMAdpjbp5T6hQO/FKmyDGO/m/C9bnlNiKb/P5G9eqik9ZpcaPtSvGh51XSSyo6lEKGPO4nk6CIEgelX739XgQjxGm0bwpSING9hP89ubIYwvXcu1nA3E2c9aXk/3tB8lNU8BlOMJsVitTMm4bqb/RfRJf6BwZ6pec7OHNc0RS0HhBR99A/NUS5j04dzqPve7XgjTYuYPUIzLzi/9XxFvBYHlSELEAJaPgL8Ix2WlSQnYh2puGuxTo6byBTirOhJJcK4vQ+gXIMOgnrIgzmpbBUgim/Vel/a4TO6eFQtaPydg88m/MTW/ntCDM3EDe6igBfYEBCaAKTtjTWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SATZpmG3gdSD3bW5KdQlwRksWp9Ur7q/As9fBxqamyI=;
 b=KmXedbCyLVPhsZ9k08npCZy80PzDp/E0BbF8KzDWcYwTtKxk18rCU/UeXrvAqgErhl329O8pp6q17dZjDXE9bivPBfVHn1NZDBycJ0YbUIUkiwPgVRAWQ24Q10+iYAJ4yFhGhUIxWFYG6zJYTD5vBcMK9ytokquuFiL4gBK0jEk=
Received: from DS7PR06CA0050.namprd06.prod.outlook.com (2603:10b6:8:54::32) by
 SAVPR12MB999119.namprd12.prod.outlook.com (2603:10b6:806:4e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 06:22:43 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:8:54:cafe::88) by DS7PR06CA0050.outlook.office365.com
 (2603:10b6:8:54::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Wed,
 24 Jun 2026 06:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.0 via Frontend Transport; Wed, 24 Jun 2026 06:22:42 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 01:22:41 -0500
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 24 Jun 2026 01:22:39 -0500
Date: Wed, 24 Jun 2026 06:22:29 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Vova Sharaienko <sharaienko@google.com>
CC: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, <android-mm@google.com>, <kernel-team@android.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] dma-coherent: use KiB in DMA allocation logs
Message-ID: <uhi4y75ojzqfpdmhqexcfmnu7mo2aaiuaboqzit32mjtjhapdy@gq47jed54f2b>
References: <20260624000516.597555-1-sharaienko@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260624000516.597555-1-sharaienko@google.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|SAVPR12MB999119:EE_
X-MS-Office365-Filtering-Correlation-Id: 3acf0672-9054-4279-8b07-08ded1b8ff8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DxbMbVwc7m6UYHZnPE8vZ6DrNk5asCg4+LbNlp3sbezniNL7RqgLJTQ/OOeuOdCdWcrz1tZjkFAlEKejcTTZJXL+lOptquCI9PwMMsv6QAakl7E3QeLK0gkb9O6U5m102C6fMLqzdFi4dYVmp/W56Fp1BYJWOm4+Me8NE/AjfdPFPTh5jYQNY+SuhABL8Soi7qt3IsEYVP9oojXPUndcqj9SNqLsDxaVMitT90c4nBZqiFN5Tc8AAk6n4QbY6F4H3NYzHnvpjmFuSjnHi1762M4IF0SdZaVQ8kaJI8oDM5G86LmWzgLpfuBemw4ol4LPkxW0dArhuEpUq10Xj1kSYI/fl3pycPFQCfRn+LfNtdTTJnWZgIDuYhAYUFZL8JT9lBTNhfjlcfY4P+4tmxn7HTISX6oFDI9ipvJ09gL2PGEqGkP+l979g5gA/Dno0a8qCHBXKB6C4m571XWdDhJjetLd78QF0qzrBWbGfKMxHGFBbtBBRdoM6WICDYXV8PLPJojFZ/Ge6y3M1XRvIoEDmRWdnWAWbqMCB1Xxj/mETsoomZErJ9Qg3QztEc/hzAyhkOJZLMcy5xyLL3T/caP1xKBfwHAMUaRQivnKulp8/ER/5Nrthl0BGFgFKlwDdqFv9Ebf/Liswchs2Ws1v6oC9fpJE7mnaUCugdRLuJ/KM/mmm5i+NcEbuTKqvBdSrqIQkGjAHQiosgpAg7w3b3/GHg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eN47nLmece9rEz5k7PH/H9Dzp4W3OLtBOHevmc+dSThQGWbTaSePmrqzos4IVDo84Nwe9SCW3f3yevYyVlinioNyVW8/G4uVISJtp5VQ9P49Nnw2mloYRNAqfdn+gMxbgeWb28enbBVPMk56zWA8dS+NCXLk5//68LeHuOrSLVa5EKXuQhA9Dk+VqWjdOyYi5eqkQKL7LPzs28qoSHIVbBr8+xyK7UEuMw2u74M6jxw4iDPLMuIzto35Ln9xLI0Dokjy0Dss7A9wFuGe84ToslkmYarAP8pPyl09AksbRh2r/7jj0Ciq4ddPPbgNLZIddgyLSJs5IA2QB+b1tGuAsWEG4nbAPQiCL6uLK+d1xJQgKhJ8JHj0Zy/S7olf26Y2lTWIEghwCy5IhQByzfKj/Zr9kORBhm7WVSSWnrNZEyqIPNjCaLgJlkTN+B2hNP+D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 06:22:42.4236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acf0672-9054-4279-8b07-08ded1b8ff8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999119

On Wed, Jun 24, 2026 at 12:05:15AM +0000, Vova Sharaienko wrote:
> We are proposing to update DMA reserved memory pool allocation log
> messages to display sizes in KiB instead of MiB. Using MiB caused
> allocations less than 1 MiB to be logged as 0 MiB due to integer
> truncation. KiB provides better precision for smaller memory regions
> specified in the Device Tree.
> 
> This is currently marked as an RFC because we would like feedback on
> a KiB unit change.
> 
> Signed-off-by: Vova Sharaienko <sharaienko@google.com>
> ---
>  kernel/dma/coherent.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
> index 480dd1766ece..3ede8da395ce 100644
> --- a/kernel/dma/coherent.c
> +++ b/kernel/dma/coherent.c
> @@ -69,8 +69,8 @@ static struct dma_coherent_mem *dma_init_coherent_memory(phys_addr_t phys_addr,
>  	kfree(dma_mem);
>  out_unmap_membase:
>  	memunmap(mem_base);
> -	pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %zd MiB\n",
> -		&phys_addr, size / SZ_1M);
> +	pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %lu KiB\n",
> +		&phys_addr, (unsigned long)(size / SZ_1K));

'size' here is a size_t, so the portable specifier is %zu, which also
lets you drop the cast.

>  	return ERR_PTR(-ENOMEM);
>  }
>  
> @@ -384,8 +384,8 @@ static int __init rmem_dma_setup(unsigned long node, struct reserved_mem *rmem)
>  	}
>  #endif
>  
> -	pr_info("Reserved memory: created DMA memory pool at %pa, size %ld MiB\n",
> -		&rmem->base, (unsigned long)rmem->size / SZ_1M);
> +	pr_info("Reserved memory: created DMA memory pool at %pa, size %lu KiB\n",
> +		&rmem->base, (unsigned long)(rmem->size / SZ_1K));

rmem->size is a phys_addr_t, which can be 64-bit on a 32-bit kernel.
Casting to unsigned long may truncate. It's an unlikely corner case,
but casting to the widest(%llu) type can avoid it.

-Ankit

>  	return 0;
>  }
>  
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 
