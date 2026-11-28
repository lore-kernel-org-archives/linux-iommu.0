Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795834714;
	b=MlaakqpFvouXzuiMg8qczU+VX3cmgeWW7E9WiQ3oTOwRFYRJdfN3ux9uU/Wj2M8lxUau
	 Ka0ilrt9xP1D1wEMRiaPmFp7X2kwFiBfVvBxrPNPaqZoisfbuUaNo6ZZFY2n3kkmm2CwC
	 HUzdGmNhRYBfg4ocCqOhm2j/dAAP/01u/kYy1JWx+6DQTW4Mzccxw0kA1EJmSUIHnRhHL
	 mf+9PNMdIudCUYfMGz2mTk4uBiFAIkPW9OV3hNSZczQUvCeBc3GjAusJK+tSqtnftr9V+
	 CY9db4zdCCiDvjFkmIn0rBWEoxtxumRdD8rU6h3xrymlMSIsoP7WndwWfCDa8t8G9TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795834714;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=iXm9bjNklHkCJkXC6cXS/6l9msjPSXzfutfiuU6LTJE=;
	b=SJ4wSmLRkBRdJZTkR0hj36byuxtsj/VBHhPYqH5isE5rgUZF4DnCH43L7LI0ffbdhmrg
	 KFrd0ugUspGGh5WFPev4YKUxB9WAcXusOvo4XH3vhUy6QtgfERpS5M0Undsu8ElvuS3mq
	 zd2soEXZFBV9WD5ODcKIMqt40CJMPQZ7Sd7o3ezaejdpL20jpUdyZw6BE1CRdtROrTxaU
	 WW89Jje1Kyji5F/02Foabi/KaKLab1WqrxFmHMJqrCKX9E4u/4GB9qLbXS0GJsf/7n6y+
	 4UiXBDd8rvTv3FEC4fQducWhf60MifJ9spP2oliQEpJnvLOJxXE/HundlZVZbsf/FmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=SfKvHHDA;
	arc=none smtp.remote-ip=113.46.200.218
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ADE606A31C;
	Sat, 28 Nov 2026 02:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34ADE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=SfKvHHDA
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=iXm9bjNklHkCJkXC6cXS/6l9msjPSXzfutfiuU6LTJE=;
	b=SfKvHHDA5DZy5PHVuUfUp7ZJIYPFO/O1wYHgqxN6U4/eJpLR+3Ela1UpPw9XS8p/TtJJrEZrr
	gDPn1UZB2A8lTM0A3I9jkCqzQxTZVWI0Nmo8f3SKrZ6KPSFo+ihxjnn+PVobzzgk/65BELmIsiR
	LEeIYm+6onwT1S/RxJyVyGY=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4jbw1Y64lPzpStH;
	Sat, 28 Nov 2026 10:57:21 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 102B5202E6;
	Sat, 28 Nov 2026 10:58:29 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 28 Nov
 2026 10:58:28 +0800
Message-ID: <ad0126a1-0d5d-47eb-87fd-1df6ccfece02@huawei.com>
Date: Sat, 28 Nov 2026 10:58:27 +0800
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
Subject: Re: [PATCH v10 4/8] crash_core: replace for_each_mem_range() with
 for_each_mem_region()
To: Wandun Chen <chenwandun1@gmail.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<robh@kernel.org>, <baoquan.he@linux.dev>, <rppt@kernel.org>,
	<m.szyprowski@samsung.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <ruirui.yang@linux.dev>, <robin.murphy@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-mm@kvack.org>, <iommu@lists.linux.dev>
References: <20261127090723.741253-1-chenwandun1@gmail.com>
 <20261127090723.741253-5-chenwandun1@gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20261127090723.741253-5-chenwandun1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk200008.china.huawei.com (7.202.194.74)



在 2026/11/27 17:07, Wandun Chen 写道:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> for_each_mem_range() skips MEMBLOCK_NOMAP regions implicitly. Switch the
> weak defaults to for_each_mem_region(), which exposes struct
> memblock_region and per-region flags, and filter NOMAP regions explicitly
> via the new crash_should_skip_region() helper. This prepares for a
> subsequent patch to extend the skip filter.
> 
> No functional change.
> 
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
> Acked-by: Baoquan He <baoquan.he@linux.dev>
> ---
>  kernel/crash_core.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 8a861a946e26..e161c8b65e00 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -283,25 +283,34 @@ static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
>  }
>  
>  #ifdef CONFIG_ARCH_KEEP_MEMBLOCK
> +/* Exclude NOMAP regions from the vmcore. */
> +static bool crash_should_skip_region(struct memblock_region *reg)
> +{
> +	return memblock_is_nomap(reg);


LGTM
Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

> +}
> +
>  unsigned int __weak arch_get_system_nr_ranges(void)
>  {
>  	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* crashk_res + crashk_low_res, +CMA splits */
> -	phys_addr_t start, end;
> -	u64 i;
> +	struct memblock_region *reg;
>  
> -	for_each_mem_range(i, &start, &end)
> +	for_each_mem_region(reg) {
> +		if (crash_should_skip_region(reg))
> +			continue;
>  		nr_ranges++;
> +	}
>  	return nr_ranges;
>  }
>  
>  int __weak arch_crash_populate_cmem(struct crash_mem *cmem)
>  {
> -	phys_addr_t start, end;
> -	u64 i;
> +	struct memblock_region *reg;
>  
> -	for_each_mem_range(i, &start, &end) {
> -		cmem->ranges[cmem->nr_ranges].start = start;
> -		cmem->ranges[cmem->nr_ranges].end = end - 1;
> +	for_each_mem_region(reg) {
> +		if (crash_should_skip_region(reg))
> +			continue;
> +		cmem->ranges[cmem->nr_ranges].start = reg->base;
> +		cmem->ranges[cmem->nr_ranges].end = reg->base + reg->size - 1;
>  		cmem->nr_ranges++;
>  	}
>  	return 0;

