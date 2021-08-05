Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89619C4338F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 15:56:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB49610FE
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 15:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3CB49610FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E916B404B4;
	Thu,  5 Aug 2021 15:56:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tdb8vZvUtZqC; Thu,  5 Aug 2021 15:56:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 883F24012F;
	Thu,  5 Aug 2021 15:56:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A05DC001A;
	Thu,  5 Aug 2021 15:56:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05E10C000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 15:56:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E8F3D83B21
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 15:56:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e8O2AFR2LAeK for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 15:56:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F1DBC83B1F
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 15:56:45 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 s22-20020a17090a1c16b0290177caeba067so15936505pjs.0
 for <iommu@lists.linux-foundation.org>; Thu, 05 Aug 2021 08:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RCTsDCtEUr9crU7FdVukkrAFOZDkX3iu2puUZlCshpI=;
 b=QLTD+I4si6TRStW3i+byEh+1Irtr6ILej9vo4oW1Nn2U3wtKPus5Q6l0kyCkqfLQ+P
 hZ8yjDAd0Nuc6MtizkDbmXNItH98ZjFBLjtXtMxv39zNJnaZWCHW2ngj5q4Pu9jNvfq8
 bzNSavZ4ty6c8S6Sfv/hFxaTSSnUMx90F8xfVWQm9z5xV1zhBRpVu10ETufiRpOiQTD9
 RzE6mO6mQczpUPW+Q+r00eX58g42C1HasWKWfZ2UVeAFyJj+HwJU606hzf87gKJ/+ooV
 BuwmRJ98aX+tfm7YNSXUbt4iN34dCtoubVxnaF1USweLp+Vjbulgjcf9sDEiBTuejvtR
 5IZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RCTsDCtEUr9crU7FdVukkrAFOZDkX3iu2puUZlCshpI=;
 b=EhnZxqwbnGICx29sELom05KnudCHrr9/ODQuItads9BzrhVZFk3wjjJWhCqzFnL0W7
 s3OK9gtJ5jOK6caIQsGU4gt/9spBLR6h2KJeZp1BJL9z2ggeQAa33ap9kUQ6932WRO8g
 fqJ+zVZh5Q2zYv5n72zmCe9Iimz6k+rBRwZJVLBxejxSdoVuLJTyQzSHT2/LuIhI+YN1
 NSIZs+CbJrBF2BQYHTyTh1CHbTCUHE/O9/o6IoETsM6ivQrK+U+x3TAuwOFpWnnVrsVJ
 U7zv2sjH4dP6rWQ9+Y0B2Re/gZyGear0G+z2KqV51zMtSB1dY6XHKz5KCEg6FYbASAUM
 jQbg==
X-Gm-Message-State: AOAM533rTIHBTBozG89oRRpIoZMK3hqdx3mgoZzJAL+rWRvo7zNl4uYS
 B4n4ypHR0UmvI7ck2qb5kHk=
X-Google-Smtp-Source: ABdhPJx2CcJ9YMvvKydKzMmm/L2XWhlBqcisHtQ6BBUyv1YcZ1T2Ns9MTQ4Jit08qy2zQW953vHgXw==
X-Received: by 2002:a17:902:9a46:b029:12c:9aae:daac with SMTP id
 x6-20020a1709029a46b029012c9aaedaacmr4504908plv.78.1628179005359; 
 Thu, 05 Aug 2021 08:56:45 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 m1sm4685977pfk.84.2021.08.05.08.56.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Aug 2021 08:56:45 -0700 (PDT)
Subject: Re: [PATCH V2 10/14] DMA: Add dma_map_decrypted/dma_unmap_encrypted()
 function
From: Tianyu Lan <ltykernel@gmail.com>
To: Christoph Hellwig <hch@lst.de>
References: <20210804184513.512888-1-ltykernel@gmail.com>
 <20210804184513.512888-11-ltykernel@gmail.com>
Message-ID: <fc36c85f-cc34-5ad2-8f9c-06dbe85ca165@gmail.com>
Date: Thu, 5 Aug 2021 23:56:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804184513.512888-11-ltykernel@gmail.com>
Content-Language: en-US
Cc: martin.b.radev@gmail.com, linux-hyperv@vger.kernel.org,
 brijesh.singh@amd.com, david@redhat.com, peterz@infradead.org,
 dave.hansen@linux.intel.com, hpa@zytor.com, kys@microsoft.com, will@kernel.org,
 boris.ostrovsky@oracle.com, linux-arch@vger.kernel.org, wei.liu@kernel.org,
 sstabellini@kernel.org, sthemmin@microsoft.com, xen-devel@lists.xenproject.org,
 linux-scsi@vger.kernel.org, aneesh.kumar@linux.ibm.com, x86@kernel.org,
 decui@microsoft.com, ardb@kernel.org, michael.h.kelley@microsoft.com,
 mingo@redhat.com, pgonda@google.com, rientjes@google.com, kuba@kernel.org,
 jejb@linux.ibm.com, parri.andrea@gmail.com, thomas.lendacky@amd.com,
 Tianyu.Lan@microsoft.com, keescook@chromium.org, arnd@arndb.de,
 konrad.wilk@oracle.com, haiyangz@microsoft.com, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, tglx@linutronix.de, akpm@linux-foundation.org,
 jgross@suse.com, martin.petersen@oracle.com, saravanand@fb.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kirill.shutemov@linux.intel.com,
 tj@kernel.org, vkuznets@redhat.com, robin.murphy@arm.com, davem@davemloft.net,
 rppt@kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Christoph:
      Could you have a look at this patch? It adds new API 
dma_map_decrypted() to do memory decrypted and remap. It will
be used in the swiotlb code.

Thanks.

On 8/5/2021 2:45 AM, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> In Hyper-V Isolation VM with AMD SEV, swiotlb boucne buffer
> needs to be mapped into address space above vTOM and so
> introduce dma_map_decrypted/dma_unmap_encrypted() to map/unmap
> bounce buffer memory. The platform can populate man/unmap callback
> in the dma memory decrypted ops.
> 
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>   include/linux/dma-map-ops.h |  9 +++++++++
>   kernel/dma/mapping.c        | 22 ++++++++++++++++++++++
>   2 files changed, 31 insertions(+)
> 
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 0d53a96a3d64..01d60a024e45 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -71,6 +71,11 @@ struct dma_map_ops {
>   	unsigned long (*get_merge_boundary)(struct device *dev);
>   };
>   
> +struct dma_memory_decrypted_ops {
> +	void *(*map)(void *addr, unsigned long size);
> +	void (*unmap)(void *addr);
> +};
> +
>   #ifdef CONFIG_DMA_OPS
>   #include <asm/dma-mapping.h>
>   
> @@ -374,6 +379,10 @@ static inline void debug_dma_dump_mappings(struct device *dev)
>   }
>   #endif /* CONFIG_DMA_API_DEBUG */
>   
> +void *dma_map_decrypted(void *addr, unsigned long size);
> +int dma_unmap_decrypted(void *addr, unsigned long size);
> +
>   extern const struct dma_map_ops dma_dummy_ops;
> +extern struct dma_memory_decrypted_ops dma_memory_generic_decrypted_ops;
>   
>   #endif /* _LINUX_DMA_MAP_OPS_H */
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 2b06a809d0b9..6fb150dc1750 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -13,11 +13,13 @@
>   #include <linux/of_device.h>
>   #include <linux/slab.h>
>   #include <linux/vmalloc.h>
> +#include <asm/set_memory.h>
>   #include "debug.h"
>   #include "direct.h"
>   
>   bool dma_default_coherent;
>   
> +struct dma_memory_decrypted_ops dma_memory_generic_decrypted_ops;
>   /*
>    * Managed DMA API
>    */
> @@ -736,3 +738,23 @@ unsigned long dma_get_merge_boundary(struct device *dev)
>   	return ops->get_merge_boundary(dev);
>   }
>   EXPORT_SYMBOL_GPL(dma_get_merge_boundary);
> +
> +void *dma_map_decrypted(void *addr, unsigned long size)
> +{
> +	if (set_memory_decrypted((unsigned long)addr,
> +				 size / PAGE_SIZE))
> +		return NULL;
> +
> +	if (dma_memory_generic_decrypted_ops.map)
> +		return dma_memory_generic_decrypted_ops.map(addr, size);
> +	else
> +		return addr;
> +}
> +
> +int dma_unmap_encrypted(void *addr, unsigned long size)
> +{
> +	if (dma_memory_generic_decrypted_ops.unmap)
> +		dma_memory_generic_decrypted_ops.unmap(addr);
> +
> +	return set_memory_encrypted((unsigned long)addr, size / PAGE_SIZE);
> +}
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
