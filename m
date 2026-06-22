Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830A439021A
	for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116031; cv=none; b=GHmm9lKSM8mQeOaBNit5ptH36bhvFinfosyZLjdHoEI/0+9l9D4NzK2HAAOgh509k1ZCZzoTxzmZx4jrKxIdebXmccLxqt8x3mYhSGkjwk/fHNmXNSp8GJroly9WX/ZWxFo/Vc2vxDg+5E/nBjZ0+So8LOqoa2ZYewnG7W1otjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116031; c=relaxed/simple;
	bh=F6H+rAEwAFlvo2vcoaq3mMaDhsIksTBUqphzpxP80WY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lnZI06ecKL/oM55jiLws34wr4Rfj21rWP9EluFpno3EPoa/3PKHwie7PEMd4Hjp1YOpyLmg3ibXO7s7n3VYSji+NX12ugysqDrT+i+lI/TvzK2/Q0zhiyPahKEvE4e90jFE8V4RPgMCb9qvRU4MSdr1KRN1rkKSt+Z1SpCuK2vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pahMDRfH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pahMDRfH"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b9318997so27156145e9.2
        for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 01:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782116027; x=1782720827; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y69DNLtkcPX106ySVX6ZlNH6S9rjQScn7EBr8UTU9k0=;
        b=pahMDRfHpOFrmruaMDhI3sr1qGy4riLap0PtsGUbYFlkO5ldCGwUdzGcWOx8QqcBv1
         V3qFJvj2TCI5KrERmX/pQ/l8p6H4WTOmk41nPOt5Oep0xi6eyCt/fdJE4Q7GvHhD9oB+
         HokYXjUw1byHTO+AZiLJZNYN/rmOiF7OYeFmilaUKmO5ma9u43J1e7FIugyIM7OXKS/M
         DYX1Iah4YC8FC+YtpHuH9EhmTFwQgNzQiyT16iqKRrIt5+VR6kJ3q+JtWSGd/qVmVzBU
         uivIlzYp/6qurNRo/borsLzoCdTsLWPVOoimf0JorRTVkoSxiTah2dakJ3RMv3ckdR9C
         oddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782116027; x=1782720827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y69DNLtkcPX106ySVX6ZlNH6S9rjQScn7EBr8UTU9k0=;
        b=dNEHBaibiEJPp7Ecbpooto+0I39PZX7nVQfXiDFFU6NrHBHo+XN/GquGmji/ZJ48hJ
         B+aCeGDKS3Tud2hoIINc4LqJYjJIieeJH5CqWB3EcnY5CdHZJGsHCZVBwCU76tKJlT2x
         bFhvVYx+Lot2pBQb/K0wT80NiKB2Vw+xedenEgY+A5mOQVm8u6RycKivSmG6JJivE8sG
         azgq4b5I/AsnsmZzIKsK7J7kC77gtwqxExQ7qyr3QXAqtBq2UJ9ozrU63KwEcwe+2EiC
         9dWYtpP84JV/Dk4l4i5u8ZgpV3Wp7ddoIHvrz7Qg8OD3eWYyp0L6Q/JzUZjtuwO4SCb1
         qDEQ==
X-Forwarded-Encrypted: i=1; AFNElJ+PrOoKqCEGo0fYTHQEiU0+HVOL25XLYT0Itaq799OyghYOoXH7gU639/oy8Lne5Omg5MKQDw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKR7RHyadvN5b4V1KPUb+CT6znn+p9N9eFCUwlMSy7xJCejrMP
	4iNCLKoPaNHi+8pV2cM2n//eKrGQUYByMfnO8kcqdhO/fAFABWxY0cCX
X-Gm-Gg: AfdE7ckiK8gtBKMM9SDUFdhkVQ8BAIMj6Nszsb2e29++D8I9Oi6X6SxjNiLB38M44Kz
	7cCrVRgJkW3cHjImkWeUglv1crcBvFr/CkefHGTe/E52dOzdFSP7fnaEUryEwcM4b1k6hqgTR73
	NKlu2bgxnpfqgCs8XFlmzBZK8jpM7I2DGmKWlxHWhZa7WsMTHJaiFZyd3xci2A8Rpvird0k4yPo
	wLmHXEwFKhofNSltcYxzntVDFchTQdt9uVzcR8BQB43qRBdpdFQYdTgQIW3TdRseh0bPKDz3FcV
	Hm01AStuEQtaTd1BBC1H2UlFOZdbTzeOEqRpEPLS+MR2SMtrgNyTCQ9GMtOBYi3vIZYmJZbvP4q
	l8Ch25CysHIbyOKDrtt9OwxwELz9cTz7FQ0J5iCk2Y8m2gTh4yaxMF5hgeEguqtlxlZb6i8bwIP
	eWFdpSxK8G/59P/EZ3LoHgYombp2dRuWm69mm9X9aYVV3k6yO+GQ==
X-Received: by 2002:a05:600c:8719:b0:492:4c60:bfb8 with SMTP id 5b1f17b1804b1-4924c60bfdemr121648545e9.28.1782116026585;
        Mon, 22 Jun 2026 01:13:46 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd30078sm274806595e9.7.2026.06.22.01.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 01:13:45 -0700 (PDT)
Date: Mon, 22 Jun 2026 09:13:44 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Hu <xuehaohu@google.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen
 <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Kevin Tian
 <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, Alex Williamson
 <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com,
 praan@google.com, kpberry@google.com, sashiko-bot <sashiko-bot@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH] dma-buf: Split sgl by largest page-aligned chunk
Message-ID: <20260622091344.794e0d74@pumpkin>
In-Reply-To: <20260621222130.1667453-1-xuehaohu@google.com>
References: <20260621222130.1667453-1-xuehaohu@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Jun 2026 22:21:30 +0000
David Hu <xuehaohu@google.com> wrote:

> Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> first entry, resulting in non-page-aligned DMA addresses for all
> subsequent entries.

How did you find this?
It requires a single buffer over 4GB - seems highly unlikely.


> 
> While the underlying IOMMU mapping may be contiguous, hardware
> DMA engines often require explicit address alignment (e.g., page,
> cacheline, or storage sector boundaries). Passing unaligned
> addresses and lengths can cause explicit failures in DMA descriptor
> creation or silent data corruption if lower unaligned bits are
> truncated.
> 
> Fix this by splitting the scatterlist by the largest possible page
> aligned chunk within `UINT_MAX` (`ALIGN_DOWN(UINT_MAX, PAGE_SIZE)`).
> This ensures all scatterlist DMA addresses and lengths remain page
> aligned and satisfy hardware constraints.

It would almost certainly better to spilt into 2G chunks.
That removes any need for any divisions.

> Page-aligned entries allow the system to cleanly chunk payloads into
> PCIe MaxPayloadSize (MPS) (e.g., 128 bytes, 256 bytes, 512 bytes).
> As a result, this may help reduce TLP fragmentation in P2P transfers
> and alleviate potential congestion within a logical PCIe switch
> partition, especially when Relaxed Ordering is not possible due to
> hardware constraints.
> 
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260609165431.778061F00893@smtp.kernel.org/
> Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hu <xuehaohu@google.com>
> ---
>  drivers/dma-buf/dma-buf-mapping.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
> index 794acff2546a..f2bde38fdb1f 100644
> --- a/drivers/dma-buf/dma-buf-mapping.c
> +++ b/drivers/dma-buf/dma-buf-mapping.c
> @@ -5,6 +5,9 @@
>   */
>  #include <linux/dma-buf-mapping.h>
>  #include <linux/dma-resv.h>
> +#include <linux/align.h>
> +
> +#define MAX_ENT_SZ ALIGN_DOWN(UINT_MAX, PAGE_SIZE)

>  
>  static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
>  					 dma_addr_t addr)
> @@ -12,9 +15,9 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
>  	unsigned int len, nents;
>  	int i;
>  
> -	nents = DIV_ROUND_UP(length, UINT_MAX);
> +	nents = DIV_ROUND_UP(length, MAX_ENT_SZ);
>  	for (i = 0; i < nents; i++) {

Why not change that to 'while (length) {' to avoid the division above.

> -		len = min_t(size_t, length, UINT_MAX);
> +		len = min_t(size_t, length, MAX_ENT_SZ);

I bet that doesn't need to be min_t()

>  		length -= len;
>  		/*
>  		 * DMABUF abuses scatterlist to create a scatterlist
> @@ -24,7 +27,7 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
>  		 * does not require the CPU list for mapping or unmapping.
>  		 */
>  		sg_set_page(sgl, NULL, 0, 0);
> -		sg_dma_address(sgl) = addr + (dma_addr_t)i * UINT_MAX;
> +		sg_dma_address(sgl) = addr + (dma_addr_t)i * MAX_ENT_SZ;
>  		sg_dma_len(sgl) = len;

Replace the multiply with 'addr += len'.

-- David

>  		sgl = sg_next(sgl);
>  	}
> @@ -41,14 +44,14 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
>  
>  	if (!state || !dma_use_iova(state)) {
>  		for (i = 0; i < nr_ranges; i++)
> -			nents += DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
> +			nents += DIV_ROUND_UP(phys_vec[i].len, MAX_ENT_SZ);
>  	} else {
>  		/*
>  		 * In IOVA case, there is only one SG entry which spans
>  		 * for whole IOVA address space, but we need to make sure
>  		 * that it fits sg->length, maybe we need more.
>  		 */
> -		nents = DIV_ROUND_UP(size, UINT_MAX);
> +		nents = DIV_ROUND_UP(size, MAX_ENT_SZ);
>  	}
>  
>  	return nents;

