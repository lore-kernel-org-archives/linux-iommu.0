Return-Path: <SRS0=Sm7F=2K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1B9C43603
	for <iommu@archiver.kernel.org>; Fri, 20 Dec 2019 01:52:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42AC7227BF
	for <iommu@archiver.kernel.org>; Fri, 20 Dec 2019 01:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOaH9Gox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42AC7227BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darnok.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 09DEE871C0;
	Fri, 20 Dec 2019 01:52:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NF1lUrtPIdZn; Fri, 20 Dec 2019 01:52:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C05BD86C18;
	Fri, 20 Dec 2019 01:52:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3AD7C18DC;
	Fri, 20 Dec 2019 01:52:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 452E2C077D
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 01:52:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 33AD024C93
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 01:52:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2r0c9zBPpCcf for <iommu@lists.linux-foundation.org>;
 Fri, 20 Dec 2019 01:52:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 by silver.osuosl.org (Postfix) with ESMTPS id B662A24B99
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 01:52:49 +0000 (UTC)
Received: by mail-qt1-f194.google.com with SMTP id e6so6829591qtq.7
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 17:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=CCSISgtL7V8q9QzteOk0TtxD6M/0tQtEP4MUsyWTHdY=;
 b=gOaH9GoxzGYN498MOlNcrkcsTwVBFU5rEcYT0q8i6Gt7Xlz00HRMAfxIgfudrfEd3v
 mY/JFetkm4h7jGUNaWFVWbIt0hFRfM4oTe1FK0pgweSnospRz8tp6ZuvIUvm+Y67Zsr3
 DorRN3MY/Dn01rwI/p7EAIBQ/8MS5+MvYXVNTjNny7IpDjElbh6bR5C+uwrWOS3SC0af
 NOrONYHdm8wI6wJ4fp465deSnxdSj8yI6t1AmeIXF8mTi9xLE1lquWhIPtxhYQO8cr6c
 wFmR6NkvP1JKqfMdsuVXcymXSYzUGt7lPasrwHLQyjRcaAd8XJIet5B14Rtm+P1055aa
 yBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=CCSISgtL7V8q9QzteOk0TtxD6M/0tQtEP4MUsyWTHdY=;
 b=gPfj2Ol+wdNt1dy3Bum7eglgvQsTqlO+mMHemN7xZ2m1aHGUPmnmcMem7bROKjspte
 YrZBboIGTwP/79qLVAXkasL4aC9fNnuC5ivvTKqhplwfBWg95ofUKZngxgelKkyGXcpI
 Hyz5pY54Vc1VylNRq1ZQtVrXcIDVsHM9xqkvoKUovEV4gPsbP8ot2t7ntuyGfAKMUa++
 CXU/0TxBk/DLKYisO1RF0mJqWfcV5hMnuh8KzSsVa1xZGj5PBYpj4Rb+UXegPm2432yU
 Dam9rJVMRDfMT24NDgkKDLWqigBoM+/5uVNk35h/mDeNAudddr8Jwf3qTiYjl6DYCTso
 mnrw==
X-Gm-Message-State: APjAAAWyZk9zjwFnNXmESbS6t7g4tZGLC6Fia0RWClVXX97jlbbEX1cb
 PEVFnAki2vVtw6otGAUWaaQ=
X-Google-Smtp-Source: APXvYqwZzRJYZaDplMj+cs7gO/EShqkHd/IVN0lblFKUygOJQPmh7grAKNTN8o+yJbQNopfjIqa2dg==
X-Received: by 2002:aed:2f45:: with SMTP id l63mr9965730qtd.221.1576806768487; 
 Thu, 19 Dec 2019 17:52:48 -0800 (PST)
Received: from localhost.localdomain
 (209-6-36-129.s6527.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com.
 [209.6.36.129])
 by smtp.gmail.com with ESMTPSA id f42sm2568030qta.0.2019.12.19.17.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 17:52:47 -0800 (PST)
Date: Thu, 19 Dec 2019 20:52:45 -0500
From: Konrad Rzeszutek Wilk <konrad@darnok.org>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Subject: Re: [PATCH v2] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20191220015245.GA7010@localhost.localdomain>
References: <20191209231346.5602-1-Ashish.Kalra@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191209231346.5602-1-Ashish.Kalra@amd.com>
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com, dave.hansen@linux-intel.com,
 konrad.wilk@oracle.com, peterz@infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, bp@alien8.de, luto@kernel.org, hpa@zytor.com,
 tglx@linutronix.de, hch@lst.de
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Dec 09, 2019 at 11:13:46PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> For SEV, all DMA to and from guest has to use shared
> (un-encrypted) pages. SEV uses SWIOTLB to make this happen
> without requiring changes to device drivers. However,
> depending on workload being run, the default 64MB of SWIOTLB
> might not be enough and SWIOTLB may run out of buffers to
> use for DMA, resulting in I/O errors.
> 
> Increase the default size of SWIOTLB for SEV guests using
> a minimum value of 128MB and a maximum value of 512MB,
> determining on amount of provisioned guest memory.
> 
> The SWIOTLB default size adjustment is added as an
> architecture specific interface/callback to allow
> architectures such as those supporting memory encryption
> to adjust/expand SWIOTLB size for their use.

What if this was made dynamic? That is if there is a memory
pressure you end up expanding the SWIOTLB dynamically?

Also is it worth doing this calculation based on memory or
more on the # of PCI devices + their MMIO ranges size?

> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
> Changes in v2:
>  - Fix compile errors as
> Reported-by: kbuild test robot <lkp@intel.com>
> 
>  arch/x86/Kconfig           |  1 +
>  arch/x86/mm/mem_encrypt.c  | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/dma-direct.h | 10 ++++++++++
>  kernel/dma/Kconfig         |  3 +++
>  kernel/dma/swiotlb.c       | 14 ++++++++++++--
>  5 files changed, 62 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5e8949953660..e75622e58d34 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1522,6 +1522,7 @@ config AMD_MEM_ENCRYPT
>  	select DYNAMIC_PHYSICAL_MASK
>  	select ARCH_USE_MEMREMAP_PROT
>  	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
> +	select ARCH_HAS_ADJUST_SWIOTLB_DEFAULT
>  	---help---
>  	  Say yes to enable support for the encryption of system memory.
>  	  This requires an AMD processor that supports Secure Memory
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index a03614bd3e1a..f4bd4b431ba1 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -376,6 +376,42 @@ bool force_dma_unencrypted(struct device *dev)
>  	return false;
>  }
>  
> +#define TOTAL_MEM_1G	0x40000000U
> +#define TOTAL_MEM_4G	0x100000000U
> +
> +/*
> + * Override for SWIOTLB default size adjustment -
> + * ARCH_HAS_ADJUST_SWIOTLB_DEFAULT
> + */
> +unsigned long adjust_swiotlb_default_size(unsigned long default_size)
> +{
> +	/*
> +	 * For SEV, all DMA has to occur via shared/unencrypted pages.
> +	 * SEV uses SWOTLB to make this happen without changing device
> +	 * drivers. However, depending on the workload being run, the
> +	 * default 64MB of SWIOTLB may not be enough & SWIOTLB may
> +	 * run out of buffers for using DMA, resulting in I/O errors.
> +	 * Increase the default size of SWIOTLB for SEV guests using
> +	 * a minimum value of 128MB and a maximum value of 512GB,
> +	 * depending on amount of provisioned guest memory.
> +	 */
> +	if (sev_active()) {
> +		unsigned long total_mem = get_num_physpages() << PAGE_SHIFT;
> +
> +		if (total_mem <= TOTAL_MEM_1G)
> +			default_size = default_size * 2;
> +		else if (total_mem <= TOTAL_MEM_4G)
> +			default_size = default_size * 4;
> +		else
> +			default_size = default_size * 8;
> +
> +		pr_info_once("SEV is active, SWIOTLB default size set to %luMB\n",
> +			     default_size >> 20);
> +	}
> +
> +	return default_size;
> +}
> +
>  /* Architecture __weak replacement functions */
>  void __init mem_encrypt_free_decrypted_mem(void)
>  {
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index 24b8684aa21d..85507d21493f 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -35,6 +35,16 @@ static inline bool force_dma_unencrypted(struct device *dev)
>  }
>  #endif /* CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED */
>  
> +#ifdef CONFIG_ARCH_HAS_ADJUST_SWIOTLB_DEFAULT
> +unsigned long adjust_swiotlb_default_size(unsigned long default_size);
> +#else
> +static inline unsigned long adjust_swiotlb_default_size
> +		(unsigned long default_size)
> +{
> +	return default_size;
> +}
> +#endif	/* CONFIG_ARCH_HAS_ADJUST_SWIOTLB_DEFAULT */
> +
>  /*
>   * If memory encryption is supported, phys_to_dma will set the memory encryption
>   * bit in the DMA address, and dma_to_phys will clear it.  The raw __phys_to_dma
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index 4c103a24e380..851c4500ff88 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -54,6 +54,9 @@ config ARCH_HAS_DMA_PREP_COHERENT
>  config ARCH_HAS_FORCE_DMA_UNENCRYPTED
>  	bool
>  
> +config ARCH_HAS_ADJUST_SWIOTLB_DEFAULT
> +	bool
> +
>  config DMA_NONCOHERENT_CACHE_SYNC
>  	bool
>  
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 9280d6f8271e..7dd72bd88f1c 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -155,11 +155,21 @@ void swiotlb_set_max_segment(unsigned int val)
>  #define IO_TLB_DEFAULT_SIZE (64UL<<20)
>  unsigned long swiotlb_size_or_default(void)
>  {
> +	unsigned long default_size = IO_TLB_DEFAULT_SIZE;
>  	unsigned long size;
>  
> +	/*
> +	 * If swiotlb size/amount of slabs are not defined on kernel command
> +	 * line, then give a chance to architectures to adjust swiotlb
> +	 * size, this may be required by some architectures such as those
> +	 * supporting memory encryption.
> +	 */
> +	if (!io_tlb_nslabs)
> +		default_size = adjust_swiotlb_default_size(default_size);
> +
>  	size = io_tlb_nslabs << IO_TLB_SHIFT;
>  
> -	return size ? size : (IO_TLB_DEFAULT_SIZE);
> +	return size ? size : default_size;
>  }
>  
>  void swiotlb_print_info(void)
> @@ -245,7 +255,7 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  void  __init
>  swiotlb_init(int verbose)
>  {
> -	size_t default_size = IO_TLB_DEFAULT_SIZE;
> +	unsigned long default_size = swiotlb_size_or_default();
>  	unsigned char *vstart;
>  	unsigned long bytes;
>  
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
