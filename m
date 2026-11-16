Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794821089;
	b=yMgPpELbqJ8XWV0UyLc8J744wcWHEHgWnvirVXCa24mrz0KpYIrMi/X0YG/Jyt5hYJ8i
	 5tbBDrk722wAMuys07fFMPwljB3JUdH4+ykDpt/YOzEFfD8B7WgdVnpUCwylBq1ZxZ6Qt
	 B3VNbruxbXfQJvpWGo/9SeJ1X/izUCiKQplYWlNYJ65SS65S3ApIki/iq937T8fBjqaXx
	 Wm0oC1dbxNX6cWbAtU6dKrC8JlOl0TnMgJLsx1AnIq7j+vHi9qR6VMSGd6LOz7Wg3tohv
	 Dfj8Q7S+7stBvCpMERTxqJpHmsDtTXlZyk0+QZw9WYRCDej8MYUuzfH+CO5PqvIB5eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821089;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=NzRJZjBOxaxgKLdelc+gYs9FrpZH1Z5oIdhO5vPKkNI=;
	b=CP5hmU9V921t445RTyZB2O76RtzQL1OdXMj2uinEteQE/djHDruNR6cSCJXeQLEyzLio
	 pfJn0m8NBkssbTRXW0XjXrRaMeGCBijAm0+BRscgRox0KX5yqhYOJFLJ1eYFigrC4WAoQ
	 M9U+EOvVpFKnJDtmqntqE8NpdSCa5J9Awj+Ne65tkXhBmULej7O4DZ43rgZUJlKmYHV7X
	 TmlmMm3v2cVos/p2aFUfb5IRE6QpPC0/x3lz+X5De0HPKeYBgFeuvwaU8VmhTc+dhezZh
	 +AxSp+IlcxAnqnIQaF6dTLhUm4n6vJ/NnNfTWdNdGPZhE3AZwAKp/1mpiUtLYCWDcnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QSYAUO3F;
	arc=none smtp.remote-ip=115.124.30.110
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C149606A329
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 09:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C149606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QSYAUO3F
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794821079; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=NzRJZjBOxaxgKLdelc+gYs9FrpZH1Z5oIdhO5vPKkNI=;
	b=QSYAUO3FfbQks1Bu7oVzc10ngbmfAhXsCFds8h3qVxFGSYySl0JvfIJEFSTTXG6DLljmzXLYlfAb4dLZBE6P52iVV8zIs/eu/EvHgtrV2qfswRn0CZk/ASo7VpHHqFofHBQUZ7M+uperj89oXppGxcF9i0Z9gJK3HGiPCsIX0cI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0XEqDQid_1794821078;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0XEqDQid_1794821078 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Nov 2026 17:24:39 +0800
Date: Mon, 16 Nov 2026 17:24:38 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-contiguous: reserve NUMA CMA areas after default
 reservation failure
Message-ID: <avrL1hGke3Hux2IM@U-2FWC9VHC-2323.local>
References: <20261115120534.2331911-2-thnkslprpt@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261115120534.2331911-2-thnkslprpt@gmail.com>

On Sun, Nov 15, 2026 at 02:05:35PM +0200, Avi Weiss wrote:
> dma_contiguous_reserve() returns when reserving the default CMA area
> fails, skipping independently configured NUMA CMA areas that might
> still be reservable.
> 
> Register the default area only when its reservation succeeds, then
> continue with NUMA CMA reservation even if the default area fails.
> 
> Fixes: 7e6ace2535d0 ("dma-contiguous: add kconfig option to setup numa cma area if not configured explicitly")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
> ---
>  kernel/dma/contiguous.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 90937dc7c627..0b6500bb6cd9 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -287,8 +287,6 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
>  						  selected_limit,
>  						  &dma_contiguous_default_area,
>  						  fixed);
> -		if (ret)
> -			return;
>  
>  		/*
>  		 * We need to insert the new area in our list to avoid
> @@ -305,9 +303,11 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
>  		 * but we also need to insert it in our list to avoid
>  		 * having a default area but an empty list.
>  		 */
> -		ret = dma_contiguous_insert_area(dma_contiguous_default_area);
> -		if (ret)
> -			pr_warn("Couldn't queue default CMA region for heap creation.");
> +		if (!ret) {
> +			ret = dma_contiguous_insert_area(dma_contiguous_default_area);
> +			if (ret)
> +				pr_warn("Couldn't queue default CMA region for heap creation.");
> +		}

Thanks for the fix!

Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>

one nitpick is, is the below code more readable? (I'm OK with
your patch as is):

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 90937dc7c627..3daa9ae3ab7d 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -288,7 +288,7 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
 						  &dma_contiguous_default_area,
 						  fixed);
 		if (ret)
-			return;
+			goto numa_resv;
 
 		/*
 		 * We need to insert the new area in our list to avoid
@@ -310,6 +310,7 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
 			pr_warn("Couldn't queue default CMA region for heap creation.");
 	}
 
+numa_resv:
 	dma_numa_cma_reserve();
 }

