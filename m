Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD20328B4D
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767606051; cv=none; b=LQHcgBS+8PvtmJ7p7SuzcDXLECVOyntQxQgQjg4R/hdISmCsA+Ar61XI+1HtgMzn/GSnxAkfVEvhw5ZCA+jmaKcfGQWhyPRXYEh8Trt7pbqm49Paqn4lps1Aitk9zrtq0OCsSJfbDj09n2O62QiKR3efc+fuAdKq8YkCOhvE9Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767606051; c=relaxed/simple;
	bh=kfKJrQ5a7Po2zi22PzxrbpGrQhRcJMv+xYYFiP1AGz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ryYHv27P7uP1LO97D95f1Rpow6itIC9vt2yuTxBwWLYP6qieDArrugf1BPqQc6dFd4j2mxbuQObSiXN6RUVZv2tg/tEE37fORSfBmMiq5E4gLh5q1KKWds8kca2Jq46uCiLwbDhbeJDCiY2qthSaFDs46X0av9qzmVWMjzi333g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JAp4d4mS; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JAp4d4mS"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-430f3273b92so651798f8f.1
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 01:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767606040; x=1768210840; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoPF4qbo+ysXILWF9RMN1mDoAoivYGl4rzNQocqtbj4=;
        b=JAp4d4mSrRR+yqI8E08iWf3zgqlrPuFuZWwl/TWwNA/DoVz+K2/91flgeSbgPi65TY
         1op7FqKJJ+R+JoR54tttZOtMNXtaOJArtX5d+0SV3n7ZtC3GnmCXfad6TJPRMsbUP31n
         GSCti5NYT1QiEZ5+/MR6FY4YK0t2uMxj1LYqdQ+SUVwSWecdHxjOZQaDozYsvBSHjZzg
         pbodljD6+kPryVZtqcN0Q3E2D3OK4ghA5oMid+UHLjKI/3o+M8LyAuV+V+lmHH5m+DA/
         H4LxR2LwURZtEh/wWBOQSw907WFOsljSWg++MJvZAv/RoI8O0ezKZgdA7EUSSg4i8Q+k
         gE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767606040; x=1768210840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uoPF4qbo+ysXILWF9RMN1mDoAoivYGl4rzNQocqtbj4=;
        b=fN+pa22FB2w34z5JgU+chJeddAbs0nqUVLwT+Zycdn6trS4Yes8b/JJeMCt5/k0HkV
         01D6VpzNrdVur/T8hAuMthdjvzT6QneK9Icbt1z/ARh1JkN0HW/+H4GIpXJBZm4wFAq4
         Fyyv0A7f7ce5kPIpXO5077I10ot7Hl94ZpHP3EpaI4ra8xwveOlROUlCnbU8xfEKUZd3
         AW/2o6Ou4eBoWuKRoA3feNBpDHFpYfX7WgYQi0iadnVmo/zhTHfa2LG3Bi5sfTEBMimT
         lOKiN/eLg8JjgY7YppEbZCVRrT5Td3b8m8LbrhPDLxbDTRDC0L2XkXLJLr42UAo1Xs/4
         Cxww==
X-Forwarded-Encrypted: i=1; AJvYcCWxB7zNT4ZBF3MabJzvxgjpFPyT2EzCLi/jCErtMt5Xve+w3sexVp+qfYj+1G40MgzPiJRK0g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRJX/BT18tMk9wqCxJkEuQ4E3BpMmxLR8+ww1kpx1wkGyQL1Gw
	AEgr2WmScG60aKpQE2K016vmH5gI5FmU1Ohvc2sWZpWsLB50NyZGnsWQinYurWb3u9w=
X-Gm-Gg: AY/fxX45kKMni/hEU5qTALfkWwtFrXpmJR9J7eStMP71ZK+12I5sfsWrXJLgxmg5QGe
	NjJTIE+9Z45l3JG9w4q/uSDmnEd9a7oZ96V61vfiEImgI2SkOmXtodEtw5Q36Axy36OEXy8/dOV
	jzfnPrANdhpfvSw4LieTEtOduB1NS08HvdmkKrRITnKqDJV2WWF2TPndnJDNry1Ye2+1asH93Dx
	vVTMDYSfGxdaQhAZal2BGH8gy+3K7zja+bRgRTkNkVnr5cafIlSI2p7xaNWqmNEjDOPO02u6me0
	q/xKlo8odyLIFQ5P0buorpmwpEQX6JHoR3E4gkjM+y2ckMW2azfbsfg1bP4DO+R50OrycdmTgjk
	GClnmvCn4MHvlYl7UYNMJNjB1HOgJnbdo8oMpSHtBIS3tVTgjq1a2685smzDXz7GftScqrMTbt9
	ouV5PD4eueEbp4/LstBAzuQJN6uQCRM6KGz90VhZFA4QZELaS6N+VgOHdtjDMZ2Jyo8b84m8mK6
	sAPy4PNksZ/JFo=
X-Google-Smtp-Source: AGHT+IH9uJ6jLlQ3sMbfjfqB2tBZwtUo3Z4YZNjyI98ICTrDJSXZI/68FFDolBTS/hTy3IR7RjNHZw==
X-Received: by 2002:a05:6000:1841:b0:432:84fc:46bb with SMTP id ffacd0b85a97d-43284fc4782mr21485079f8f.6.1767606040029;
        Mon, 05 Jan 2026 01:40:40 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324e9ba877sm100563291f8f.0.2026.01.05.01.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 01:40:39 -0800 (PST)
Date: Mon, 5 Jan 2026 10:40:36 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Leon Romanovsky
 <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Bartosz Golaszewski
 <brgl@kernel.org>, linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
 virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 01/15] dma-mapping: add
 __dma_from_device_group_begin()/end()
Message-ID: <20260105104036.09a77f13@mordecai>
In-Reply-To: <19163086d5e4704c316f18f6da06bc1c72968904.1767601130.git.mst@redhat.com>
References: <cover.1767601130.git.mst@redhat.com>
	<19163086d5e4704c316f18f6da06bc1c72968904.1767601130.git.mst@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Jan 2026 03:22:54 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> When a structure contains a buffer that DMA writes to alongside fields
> that the CPU writes to, cache line sharing between the DMA buffer and
> CPU-written fields can cause data corruption on non-cache-coherent
> platforms.
> 
> Add __dma_from_device_group_begin()/end() annotations to ensure proper
> alignment to prevent this:
> 
> struct my_device {
> 	spinlock_t lock1;
> 	__dma_from_device_group_begin();
> 	char dma_buffer1[16];
> 	char dma_buffer2[16];
> 	__dma_from_device_group_end();
> 	spinlock_t lock2;
> };
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

LGTM. I'm not formally a reviewer, but FWIW:

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

> ---
>  include/linux/dma-mapping.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index aa36a0d1d9df..29ad2ce700f0 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -7,6 +7,7 @@
>  #include <linux/dma-direction.h>
>  #include <linux/scatterlist.h>
>  #include <linux/bug.h>
> +#include <linux/cache.h>
>  
>  /**
>   * List of possible attributes associated with a DMA mapping. The semantics
> @@ -703,6 +704,18 @@ static inline int dma_get_cache_alignment(void)
>  }
>  #endif
>  
> +#ifdef ARCH_HAS_DMA_MINALIGN
> +#define ____dma_from_device_aligned __aligned(ARCH_DMA_MINALIGN)
> +#else
> +#define ____dma_from_device_aligned
> +#endif
> +/* Mark start of DMA buffer */
> +#define __dma_from_device_group_begin(GROUP)			\
> +	__cacheline_group_begin(GROUP) ____dma_from_device_aligned
> +/* Mark end of DMA buffer */
> +#define __dma_from_device_group_end(GROUP)			\
> +	__cacheline_group_end(GROUP) ____dma_from_device_aligned
> +
>  static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, gfp_t gfp)
>  {

