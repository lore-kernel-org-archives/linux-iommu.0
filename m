Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA5B171B4
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 14:39:11 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7981A218E8;
	Fri,  9 Jun 2023 14:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1686321549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O+nq2sVFNvU6nyWExPnHDrSk7SL7j6fMmlV/ftm6VIU=;
	b=ODZm/S6k31XYx+UCgoj7RzO3oZFNknYltRACUNBh5M4wtGImi+QiMGTDk8gi1vrICkOq5w
	b1rG3dINTJz4oB9ka0qLpAkaBqVtBwhhpKERhdAywR/C5Zpb57ZJuq+N/CXuKJyKhGPrDd
	VCk+tqXsjxxOzq5OoPxbGdqNpNL/7As=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1686321549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O+nq2sVFNvU6nyWExPnHDrSk7SL7j6fMmlV/ftm6VIU=;
	b=0Bl4ggUNIl7d0gyZnuB8rmdlsXkGQqNVlYeBQhcny6DxjGyGMsb8BkIKydQr80ttblBIdh
	7SOD0umVHOv90FBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1162713A47;
	Fri,  9 Jun 2023 14:39:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 9Ax0A405g2RUcgAAMHmgww
	(envelope-from <vbabka@suse.cz>); Fri, 09 Jun 2023 14:39:09 +0000
Message-ID: <3b2c5414-7623-c4a8-1a24-1c8e1ced0387@suse.cz>
Date: Fri, 9 Jun 2023 16:39:08 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v6 16/17] mm: slab: Reduce the kmalloc() minimum alignment
 if DMA bouncing possible
Content-Language: en-US
To: Catalin Marinas <catalin.marinas@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Ard Biesheuvel <ardb@kernel.org>,
 Isaac Manjarres <isaacmanjarres@google.com>,
 Saravana Kannan <saravanak@google.com>, Alasdair Kergon <agk@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>,
 Mark Brown <broonie@kernel.org>, Mike Snitzer <snitzer@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>, linux-mm@kvack.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Pekka Enberg <penberg@kernel.org>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Roman Gushchin <roman.gushchin@linux.dev>
References: <20230531154836.1366225-1-catalin.marinas@arm.com>
 <20230531154836.1366225-17-catalin.marinas@arm.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230531154836.1366225-17-catalin.marinas@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/31/23 17:48, Catalin Marinas wrote:
> If an architecture opted in to DMA bouncing of unaligned kmalloc()
> buffers (ARCH_WANT_KMALLOC_DMA_BOUNCE), reduce the minimum kmalloc()
> cache alignment below cache-line size to ARCH_KMALLOC_MINALIGN.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Nit below:

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> ---
>  mm/slab_common.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 7c6475847fdf..fe46459a8b77 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -18,6 +18,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/seq_file.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/swiotlb.h>
>  #include <linux/proc_fs.h>
>  #include <linux/debugfs.h>
>  #include <linux/kasan.h>
> @@ -863,10 +864,19 @@ void __init setup_kmalloc_cache_index_table(void)
>  	}
>  }
>  
> +#ifdef CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC
> +static unsigned int __kmalloc_minalign(void)
> +{
> +	if (io_tlb_default_mem.nslabs)
> +		return ARCH_KMALLOC_MINALIGN;
> +	return dma_get_cache_alignment();
> +}
> +#else
>  static unsigned int __kmalloc_minalign(void)
>  {
>  	return dma_get_cache_alignment();
>  }
> +#endif

Should be enough to put the #ifdef around the two lines into a single
implementation of the function?

>  void __init
>  new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
> 

