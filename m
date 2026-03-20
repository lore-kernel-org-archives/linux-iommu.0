Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8357739098B
	for <iommu@lists.linux.dev>; Fri, 20 Mar 2026 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774002673; cv=none; b=jtCi2rRKN3EbJ5/zmJPhzur5koCZPfOAddfDSi1QzC9s3YB0MLSh5aFseeGILQq98P7IPusxv0L2xUXlVDuZ4j3fT/9AJP/HmOALNftqy+yxyOwkvw7Got2v4Cf3G0qGczYDZxs5awILpHjL7hKUAn4NEFgTw5RAiD9qkidXgUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774002673; c=relaxed/simple;
	bh=7iSJHc2eZhYal62FEWMQKE8t7kSYZwpGO3d0BmcUETA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=UZZcNCsT338mve1bWq08ZyBB530ooAVsIVD6Ip1OA4G/7YQC7aroCBL1ja55cYW4L4AS8nAjmvXTkSSz0+BJWjCbYTouxGEIo6fVwNxfej7NTdwq0Fg+8FxAOyrLQoA/BATycyGB+o0Wv+9zpQYeQhkR9T0bUWfWX4XgtQATKxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IORWrZ1s; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IORWrZ1s"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260320103103euoutp0223564c26b256ee58ea6def121e502349~ehgYQ4sWO0376103761euoutp02L
	for <iommu@lists.linux.dev>; Fri, 20 Mar 2026 10:31:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260320103103euoutp0223564c26b256ee58ea6def121e502349~ehgYQ4sWO0376103761euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774002663;
	bh=Je/UP3GHWRUtL4Wy4tCMeLqGWWxZru1icunF6GGNybA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=IORWrZ1svztVX8Y53yoA7R5vFoFosmTv8fmy8+Xs5hKW4YLJKS6pJo2f+WyOaCBUJ
	 jY/nPKaVMhwUjWxn9STqZDy2+SCzoPur2EAtnO5JzgfGd4oWzmOqN04Ht1xI2O2Ltw
	 Zeury3wtYHZDxVmZaOZFDN6KTOy7aV+ZMjeKyVLo=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260320103103eucas1p13a73695dc5aebe3de444e9aeb8587243~ehgYB5dIl1260012600eucas1p1m;
	Fri, 20 Mar 2026 10:31:03 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260320103103eusmtip105cb6edcfb82d61e9017b73e788995c0~ehgXnoB8l0186101861eusmtip1z;
	Fri, 20 Mar 2026 10:31:03 +0000 (GMT)
Message-ID: <e351bf79-8a97-4df9-a4ba-17a56c7903a5@samsung.com>
Date: Fri, 20 Mar 2026 11:31:01 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma: swiotlb: add KMSAN annotations to swiotlb_bounce()
To: Shigeru Yoshida <syoshida@redhat.com>, Robin Murphy
	<robin.murphy@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander
	Potapenko <glider@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260315082750.2375581-1-syoshida@redhat.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260320103103eucas1p13a73695dc5aebe3de444e9aeb8587243
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260315082850eucas1p27ecb1059ada2007cf021455e72563f5b
X-EPHeader: CA
X-CMS-RootMailID: 20260315082850eucas1p27ecb1059ada2007cf021455e72563f5b
References: <CGME20260315082850eucas1p27ecb1059ada2007cf021455e72563f5b@eucas1p2.samsung.com>
	<20260315082750.2375581-1-syoshida@redhat.com>

On 15.03.2026 09:27, Shigeru Yoshida wrote:
> When a device performs DMA to a bounce buffer, KMSAN is unaware of
> the write and does not mark the data as initialized.  When
> swiotlb_bounce() later copies the bounce buffer back to the original
> buffer, memcpy propagates the uninitialized shadow to the original
> buffer, causing false positive uninit-value reports.
>
> Fix this by calling kmsan_unpoison_memory() on the bounce buffer
> before copying it back in the DMA_FROM_DEVICE path, so that memcpy
> naturally propagates initialized shadow to the destination.
>
> Suggested-by: Alexander Potapenko <glider@google.com>
> Link: https://lore.kernel.org/CAG_fn=WUGta-paG1BgsGRoAR+fmuCgh3xo=R3XdzOt_-DqSdHw@mail.gmail.com/
> Fixes: 7ade4f10779c ("dma: kmsan: unpoison DMA mappings")
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

Applied to dma-mapping-fixes. Thanks!

> ---
>   kernel/dma/swiotlb.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index d8e6f1d889d5..9fd73700ddcf 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -30,6 +30,7 @@
>   #include <linux/gfp.h>
>   #include <linux/highmem.h>
>   #include <linux/io.h>
> +#include <linux/kmsan-checks.h>
>   #include <linux/iommu-helper.h>
>   #include <linux/init.h>
>   #include <linux/memblock.h>
> @@ -901,10 +902,19 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
>   
>   			local_irq_save(flags);
>   			page = pfn_to_page(pfn);
> -			if (dir == DMA_TO_DEVICE)
> +			if (dir == DMA_TO_DEVICE) {
> +				/*
> +				 * Ideally, kmsan_check_highmem_page()
> +				 * could be used here to detect infoleaks,
> +				 * but callers may map uninitialized buffers
> +				 * that will be written by the device,
> +				 * causing false positives.
> +				 */
>   				memcpy_from_page(vaddr, page, offset, sz);
> -			else
> +			} else {
> +				kmsan_unpoison_memory(vaddr, sz);
>   				memcpy_to_page(page, offset, vaddr, sz);
> +			}
>   			local_irq_restore(flags);
>   
>   			size -= sz;
> @@ -913,8 +923,15 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
>   			offset = 0;
>   		}
>   	} else if (dir == DMA_TO_DEVICE) {
> +		/*
> +		 * Ideally, kmsan_check_memory() could be used here to detect
> +		 * infoleaks (uninitialized data being sent to device), but
> +		 * callers may map uninitialized buffers that will be written
> +		 * by the device, causing false positives.
> +		 */
>   		memcpy(vaddr, phys_to_virt(orig_addr), size);
>   	} else {
> +		kmsan_unpoison_memory(vaddr, size);
>   		memcpy(phys_to_virt(orig_addr), vaddr, size);
>   	}
>   }

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

