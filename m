Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ADC3612D6
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 18:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771871603; cv=pass; b=NCoGtpSFz52WOQN7R9Kn0/Q55f0hrzW/VA9VqJ3EfDydP82547ChFyhqGb/h4b02DMoaIXpbctNmU5gfoGzpmqZvH1XmcmwzC+8BUz+eOWMFH7tSV2+6nOdGxk0mdy1lsvve0+6vanhRBc4QbTbZbbomWKnnVo2q1Y9+Fy7lP2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771871603; c=relaxed/simple;
	bh=OlksQpzsFEkRVJRE9g419OdwGDh3+i8ICDHTevP//cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ifpbUe3HDvvieX9tyFrGW6EGggsYV/prAJ21nRX6bmp1oCgfz8RZYHw/2i6/h0G91A3yl1vcOLEbX5HlpkIHRCK7wr0+rvo3khRL33mT2EK42rktk2tLXtW4ixUasJVrmMy74iJhURYTg16K+Sz9zrOiE0jcVCTabhacG4lTQYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hQDRt/B+; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hQDRt/B+"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so8179627a12.1
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 10:33:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771871600; cv=none;
        d=google.com; s=arc-20240605;
        b=Q41ZzvtFbkJHg6Q4BgWlCcEBmrpjxHO65lZSjkoppSBcdxjUWbRuo/SbWx+vIvBFh5
         UJisLLvEQGBPLl2kydPkS8UGBxnzEYEljau7W1XmcyQfRBrDlKNZaUmqMz3L+wVFUhDZ
         rp/hhU7XiurzM+OEpGWUUq80Q7hdNeP9huV6EbP54QB3RJlkTIEmLd/EJCk4EpaiPDUi
         S2zI1Bkq6VfeiaC/te2uFF6UQeiwLPBSEyF/xB8l49tlSzCqXVS1hMpnocRCT+NMOLzb
         0DJQUC3UEFaMFrep8+5duLMONsybWtoOkH57DQusMbryMzGza3dFhF/zVvveVC+8NxxY
         5Ekw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SdXTYyc+CZiWHvNxIlGUblHb7sAtxXqArT15DTb3rus=;
        fh=9obEsU11ikXdvKotMtd3ym5LAigJSSNUu+OgX+EhBGE=;
        b=J5eAFf48zAM4Edo2iQDgcCiEvpMV/tr1pg6oCYjSFezQolhpYyt2wVqKXCDW1pTDU0
         fI6X/vHACUOaGU+D0VSuHx8XuD63A4z06QwiiVu93x9uP9H4h0jmjj48Y+ezNg3zBtJP
         wo6EJ96JW9nMOo9zo4DyZHsslw/mEI3IKDgXBK976LkHspPNtSlOf6IuhT0eeaRujduH
         ueaIdNS0Gju8zKwPtb3vWhboW4sN14TO8LRnQ8Z7inwDdXUAc/eHKYXeINhxBLPg5lgS
         1XfDSl+AQWa3BZzvEDUfD3afAA1evF/j9RXftxqsRDX0yNwei+6vPm3Pmg/jlZOuL5oL
         IXLg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771871600; x=1772476400; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdXTYyc+CZiWHvNxIlGUblHb7sAtxXqArT15DTb3rus=;
        b=hQDRt/B+dQ31ny/sIXT4S89GG+PrcXT0rXeb/DH7a0Y2CC5qTDac0aNAQ6bGnClceU
         lSZM0PV0OdjzFLCPvNgppeAAUc6oWB7EmQPNFe0IHYFDeVkemS1DMOZN2KU2FdrGXRi0
         e1JCpopEVRqt2c1EWHFAUPtH86V4ketNuA+8zA5KA6ZprgGTyTq+HOOvW443ZsINuDV6
         8ctwFk4J7CTQs4g6Kb2Iqf2rA7essZpbYiDVoRLIdLWN65b2XnkEnYfJQOopVNiTiXWh
         3iuDDijmh9iTnAfFGyCrdEpTWGmYaMPOmv+yScfBGACiOQeAUMQWDDJh8BynppOxS2JY
         vANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771871600; x=1772476400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SdXTYyc+CZiWHvNxIlGUblHb7sAtxXqArT15DTb3rus=;
        b=qrzdYSeVamqsfbNDfwlqnxzW6t/2L1sxx7GJN35dHqcYFkgfH1AnmrjetAKa0oYvBZ
         G+mC/qbBQjE4Tjcu6RJIPznZvDcEfavzIOLRItpKJWx0ZH3wg5/ZgzwF7vvv8NsUSm07
         VWCsm3Qzi03arcr0dVtz3YO+SsjImkYZrLYVTKCFaf3OtnXGan706e/c0gOumVFrLAur
         uMG6dC6yKsPYw8RLte5L7kHystmMsFPedrJVB3/pgu0QVixfiUOfDuJd+mASMFXPganI
         6Z7OsQwNfG6YBu1YBLiv16Pz7xf2f6CCzl6ktor9Ghiqz271m0etao9d3Q6wCJxuUwz9
         bbLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJLAAcPsDMz2ESzkBJIUzhbwVvQgiTZdP31Gl5yyTNw7jidMzx2s/r7jrrMZsxFfWbnU69kg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6BdzpqdsRcxyg9Rr25SGqBVRFvTMxZTalFKU40xb5ORMdPpqH
	jGFcMnCviEc3eiGb3/PhVAW1TuuQ9meSE6NNmdXHfUYkWHzQhlb6UynKPeEMik953LYo5vJDmh8
	XgyIxbr80FWvIcq2zkuA1yCOFOrFi/F7XJDAeILg=
X-Gm-Gg: AZuq6aLDDQHLW3QBu2gIXjIXwLUqPnOG8K9Mrow34/NqF4YDtkLV0Jqv0nPr4RRKAQo
	0mOTK1vXn3u3Bk3yXUkaC/1BcyntHcnUvOqZhUG0sWCqxl2jJmYUhINbFtJ01PKcelrBnaT+UOY
	ru0Xr/O+9cFSB4nCesjGcf/3RD1EW2ZhUtzX+B9gYHWvYQLd0Trq3MUzbMWNmZMCYXunt/kCwt/
	hMyBuSaFLBuGUlLD16DYA8omgyYpJ/DKscalrFPKBKc5HhWLqSg/SZzNGmKybsz88CvR1BjRoFt
	zZn8Z76BUrLhq5PMrvelXr3wVNkjboGv3U5J
X-Received: by 2002:a17:907:9452:b0:b88:713e:78a5 with SMTP id
 a640c23a62f3a-b9081aeedf7mr579641266b.28.1771871599312; Mon, 23 Feb 2026
 10:33:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260223095136.225277-1-jiri@resnulli.us> <20260223095136.225277-3-jiri@resnulli.us>
In-Reply-To: <20260223095136.225277-3-jiri@resnulli.us>
From: John Stultz <jstultz@google.com>
Date: Mon, 23 Feb 2026 10:33:07 -0800
X-Gm-Features: AaiRm51mY0mKY0_1_wq03WmYtA7Qg-aNpUveVzAZTLNHpqLqVMbVU7X_E2imwkI
Message-ID: <CANDhNCp94KG06P_7ivMTNA27qEM9g8ox-h3b_tZ=v6e-25xJ3g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dma-buf: heaps: system: add system_cc_decrypted
 heap for explicitly decrypted memory
To: Jiri Pirko <jiri@resnulli.us>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	iommu@lists.linux.dev, linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, tjmercier@google.com, 
	christian.koenig@amd.com, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	jgg@ziepe.ca, leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com, 
	catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com, 
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com, 
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 1:51=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> From: Jiri Pirko <jiri@nvidia.com>
>
> Add a new "system_cc_decrypted" dma-buf heap to allow userspace to
> allocate decrypted (shared) memory for confidential computing (CoCo)
> VMs.
>
> On CoCo VMs, guest memory is encrypted by default. The hardware uses an
> encryption bit in page table entries (C-bit on AMD SEV, "shared" bit on
> Intel TDX) to control whether a given memory access is encrypted or
> decrypted. The kernel's direct map is set up with encryption enabled,
> so pages returned by alloc_pages() are encrypted in the direct map
> by default. To make this memory usable for devices that do not support
> DMA to encrypted memory (no TDISP support), it has to be explicitly
> decrypted. A couple of things are needed to properly handle
> decrypted memory for the dma-buf use case:
>
> - set_memory_decrypted() on the direct map after allocation:
>   Besides clearing the encryption bit in the direct map PTEs, this
>   also notifies the hypervisor about the page state change. On free,
>   the inverse set_memory_encrypted() must be called before returning
>   pages to the allocator. If re-encryption fails, pages
>   are intentionally leaked to prevent decrypted memory from being
>   reused as private.
>
> - pgprot_decrypted() for userspace and kernel virtual mappings:
>   Any new mapping of the decrypted pages, be it to userspace via
>   mmap or to kernel vmalloc space via vmap, creates PTEs independent
>   of the direct map. These must also have the encryption bit cleared,
>   otherwise accesses through them would see encrypted (garbage) data.
>
> - DMA_ATTR_CC_DECRYPTED for DMA mapping:
>   Since the pages are already decrypted, the DMA API needs to be
>   informed via DMA_ATTR_CC_DECRYPTED so it can map them correctly
>   as unencrypted for device access.
>
> On non-CoCo VMs, the system_cc_decrypted heap is not registered
> to prevent misuse by userspace that does not understand
> the security implications of explicitly decrypted memory.
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Thanks for reworking this! I've not reviewed it super closely, but I
believe it resolves my objection on your first version.

Few nits/questions below.

> @@ -296,6 +345,14 @@ static void system_heap_dma_buf_release(struct dma_b=
uf *dmabuf)
>         for_each_sgtable_sg(table, sg, i) {
>                 struct page *page =3D sg_page(sg);
>
> +               /*
> +                * Intentionally leak pages that cannot be re-encrypted
> +                * to prevent decrypted memory from being reused.
> +                */
> +               if (buffer->decrypted &&
> +                   system_heap_set_page_encrypted(page))
> +                       continue;
> +

What are the conditions where this would fail? How much of an edge
case is this? I fret this opens a DoS vector if one is able to
allocate from this heap and then stress the system when doing the
free.

Should there be some global list of leaked decrypted pages such that
the mm subsystem could try again later to recover these?

> diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
> index 648328a64b27..d97b668413c1 100644
> --- a/include/linux/dma-heap.h
> +++ b/include/linux/dma-heap.h
> @@ -10,6 +10,7 @@
>  #define _DMA_HEAPS_H
>
>  #include <linux/types.h>
> +#include <uapi/linux/dma-heap.h>
>
>  struct dma_heap;
>
> diff --git a/include/uapi/linux/dma-heap.h b/include/uapi/linux/dma-heap.=
h
> index a4cf716a49fa..ab95bb355ed5 100644
> --- a/include/uapi/linux/dma-heap.h
> +++ b/include/uapi/linux/dma-heap.h
> @@ -18,8 +18,7 @@
>  /* Valid FD_FLAGS are O_CLOEXEC, O_RDONLY, O_WRONLY, O_RDWR */
>  #define DMA_HEAP_VALID_FD_FLAGS (O_CLOEXEC | O_ACCMODE)
>
> -/* Currently no heap flags */
> -#define DMA_HEAP_VALID_HEAP_FLAGS (0ULL)
> +#define DMA_HEAP_VALID_HEAP_FLAGS (0)
>
>  /**
>   * struct dma_heap_allocation_data - metadata passed from userspace for

Are these header changes still necessary?

thanks
-john
