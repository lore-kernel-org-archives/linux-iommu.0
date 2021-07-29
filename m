Return-Path: <SRS0=dGrv=MV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72B2C4320E
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 15:13:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8038561054
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 15:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8038561054
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D0856061C;
	Thu, 29 Jul 2021 15:13:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lvPqGZIg_AEJ; Thu, 29 Jul 2021 15:13:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 27F2460662;
	Thu, 29 Jul 2021 15:13:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E8F6C0010;
	Thu, 29 Jul 2021 15:13:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B671AC000E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 15:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B1BCB60662
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 15:13:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qE8JjWLSs0_l for <iommu@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 15:13:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 895FB6061C
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 15:13:29 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 q17-20020a17090a2e11b02901757deaf2c8so9989253pjd.0
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 08:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=akMNdPJ4WS5nbnxgvsvMYm/zRUHwcBCfIsow9Ks6kis=;
 b=dLioqOpBl2TpGowMKGZzRjcLFx0fZ0sBHYpCjAxABGEJkW9CgwGvHYqQ7apVDck0xx
 W5FuDqVbCnNd70/DtkMCPd4nqMpezuT6upxl41IkUNtJlgdLrD+RhjExDK3z3ce7yAyi
 4T3pGiS49Fpux5+3O0k15LkGMg6tQKFB1XgNeZAHuGRcTvc6EBLKsj3eNAVBiUHKR1xX
 /CgKKN3LRKSV3ywoC91cZi4VtcHW9BdxphQdF31SCJLo1LkxTmqp53t070UtFqT4mdev
 zb6GH16wdrsVQodoRsmLapOWCa0r0OH1HB0WqtJ3jUF4EHVlDutR3ypdLueHvAxYkwe8
 3NDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=akMNdPJ4WS5nbnxgvsvMYm/zRUHwcBCfIsow9Ks6kis=;
 b=SWOyBZ/hxD6ChuboOjVi6w02eBV6eNXVbHGrNwyQIh+QuiaEzSgmrptiR+mstaPdfd
 OP0t/uHuP9tC473t7qJGi6Y5krErn11KjPr25BWiDzivi5GXxFc6JXGJ12QP7+rOOUko
 pthQuuOrrUcy0ZUiuvUhDcvgeUYvY3iZWN647Niwf5dvlanrxbVg3Dm1TyRHCasf3fqT
 MrvF3PPbMYLfSb/EVd//MmMb0OHDjd4E0HK5do8l+LgyDu6BwSmerOUjOh2NVt03i/NT
 qcpLsPUwRI5JzCAtOHHA8l6YrQvmcWnyCdt6Fgu3NNs9VG28Ph3VS8cSpfBkEZW6uXJZ
 Ru1w==
X-Gm-Message-State: AOAM532B783MuEUbb5R2erphrtL5fm/fH+d8DRYM1RywZzn187z5metd
 Be1L9Nl/Sg8IH8ri+AmDS8E=
X-Google-Smtp-Source: ABdhPJz+1u+t4XYMb612jZVRZC2eq6EVWswZWptItrWPSpDVi083nnf1kcuFDG/7rvR4ghR/eM6m5A==
X-Received: by 2002:a63:5505:: with SMTP id j5mr4265664pgb.250.1627571608984; 
 Thu, 29 Jul 2021 08:13:28 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 c7sm4247137pgq.22.2021.07.29.08.13.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jul 2021 08:13:28 -0700 (PDT)
Subject: Re: [PATCH 09/13] DMA: Add dma_map_decrypted/dma_unmap_encrypted()
 function
From: Tianyu Lan <ltykernel@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
References: <20210728145232.285861-1-ltykernel@gmail.com>
 <20210728145232.285861-10-ltykernel@gmail.com>
Message-ID: <da69c920-c12a-b4ad-7554-68b9e99bb6ce@gmail.com>
Date: Thu, 29 Jul 2021 23:13:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210728145232.285861-10-ltykernel@gmail.com>
Content-Language: en-US
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, david@redhat.com,
 peterz@infradead.org, dave.hansen@linux.intel.com, hpa@zytor.com,
 anparri@microsoft.com, kys@microsoft.com, will@kernel.org,
 boris.ostrovsky@oracle.com, linux-arch@vger.kernel.org, sfr@canb.auug.org.au,
 wei.liu@kernel.org, sstabellini@kernel.org, sthemmin@microsoft.com,
 xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
 aneesh.kumar@linux.ibm.com, x86@kernel.org, decui@microsoft.com,
 ardb@kernel.org, michael.h.kelley@microsoft.com, mingo@redhat.com,
 pgonda@google.com, rientjes@google.com, kuba@kernel.org, jejb@linux.ibm.com,
 martin.b.radev@gmail.com, thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com,
 keescook@chromium.org, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, tglx@linutronix.de, akpm@linux-foundation.org,
 jgross@suse.com, martin.petersen@oracle.com, saravanand@fb.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kirill.shutemov@linux.intel.com,
 hannes@cmpxchg.org, vkuznets@redhat.com, robin.murphy@arm.com,
 davem@davemloft.net, rppt@kernel.org
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
      Could you have a look at this patch and the following patch
"[PATCH 10/13] x86/Swiotlb: Add Swiotlb bounce buffer remap function
for HV IVM" These two patches follows your previous comments and add 
dma_map_decrypted/dma_unmap_decrypted(). I don't add arch prefix because 
each platform may populate their callbacks into dma memory decrypted ops.

Thanks.

On 7/28/2021 10:52 PM, Tianyu Lan wrote:
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
