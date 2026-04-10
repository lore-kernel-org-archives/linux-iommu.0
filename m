Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2623BD25D
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823298; cv=pass; b=N2Pdi30rKMKAANDhMRngorrAQJz6ZAX0WOxCJ0pGhDUB0iLRw4CF+n18GRFs2Z6DU44LACOhdEi9xWQrH4e1t0R0oX/+yBwjrdXuJJDMNV53d948ShGWuNmmtcsdW/bj/ujzVCvBxK+qeGWOqkPlNOYbkBL41H8Pa+wz5imjfOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823298; c=relaxed/simple;
	bh=HZs2dOQHfZyros26cAcHpBbRttnvDk74t3XJQ4JrVHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbEWB9Emr+adFQ5nf+E9Pi+2e4+4p0lSsEpSqRaDp7v1vmrT+qI5WKEmxLcCKhwAwXnXhZI7rLkpKXRvWjE8WD/p/VnY8T7DEQVwzED/Zj8ceZUtKmCo73VCUSEjHBxRhdNqgEa3dN/O8vUTUKF46M3eoFcbj/vj21HaSWkWCkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tagehaz9; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tagehaz9"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8f97c626aaso321134066b.2
        for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 05:14:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775823295; cv=none;
        d=google.com; s=arc-20240605;
        b=N/L4S/62jK6/xxJ7NvsCkO7CLSvND60RCRix1F4umyLv2sOij8W+vHtCPrDPfd1TyK
         hn+Ze+Y+UUwrm3ZHHdu880A/wwLWOsmnBQLCvwyt/vaNyUHtsOn5P7+tQFNkHL7NbIwz
         t0l6di+3PqORCLH4h6aiVU8aKVX+ZqX293xsip88OQlLrjBcoeaiXydAxuxYusi8xk4e
         kXCrv/l5IEmTlOX8+kyZYGiIcPSktuoyL7Wuxq/jQOfd2QcLATFppyxsSUyrjrLoDdPa
         GzKcZj2mtsyK9nd+5TbkDhY6hBhycAg6W8+YYfeb+G+i+xTUQR5QpW4UFU1ZhBllTLBw
         ZBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7jIY/1++oar4yAYBTP2iQ0v5rOvIuL4pDsKGubLCfjE=;
        fh=g5VSjKdsDqafqn3ESIrSJJdr7vge9QY7RRsZO1WhXgA=;
        b=cfWJxY5fGFTjucxV/3vpRhjbGdNuXf/rtwQuVVCZOdlnt+4osXdk1HWsixojZX3jbH
         KbsPzzAvpgsIrF2aBdWqLP/037LK0JbALUu0vvZWUjR9onCRSqj1vrjWIdHcPr/3E8/N
         NtTZEhYNQZKsboyNMn3ziCd5sfbvTUcizjMv+t5XNOAZNIG6mGFsUTyV4KzVrlQM9zDA
         OfJiftkhAWS7TUnJ9cmxyaX8DOfwGPKWixlU19fiUKzZRuhCik+HS37zZQXGbqZPa6vt
         +8Xf4HYD9a0D7ZyOMFzT89Ly7uzH1bGxKIGUmuYJVF985svk8fYKXlvtKwqqorTlsS6o
         TKnA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775823295; x=1776428095; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7jIY/1++oar4yAYBTP2iQ0v5rOvIuL4pDsKGubLCfjE=;
        b=Tagehaz9HlME4u20P+H5W4mlkfgoLMPA0fEQbiheix5b0lmJbAZ77wo02Ksz0a6CRf
         YVu6pS8gtw+XXobjbBrfRhyAAgbUDmRfmmjiXz4mcLPGDjhz2eKYk1t0dbrVe2DTVy2T
         GQC1v44EG1KeVfPMQSLi5jdl3U2O+9oszp5VcWt6NGOMz00ilVT9wopLouuuuGcgaQRc
         DIgTdzmbXTWb9PLXkTGFiFfrv18bZ+GjkOzdARvaevzO6+OxzEUrrDTWz9tZIOhc8hR6
         ke/r9Pe5acRWrPoUG6H64Zj1cgMOStK1LNTku1RvcCO9oft0UiGilRPSxXeVi5G4zuGI
         bFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775823295; x=1776428095;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jIY/1++oar4yAYBTP2iQ0v5rOvIuL4pDsKGubLCfjE=;
        b=mjSJDDGNpVMxwHSpLpPWtYVGi7nEDcdwBMWiCBhEj79q1+PaClFSm7NMOBf6qKo/pJ
         SZAO/EBu0SU1TrvuaHjkjMhM5mtNEHeXtOSp1vnTmvjccVBHe3KLb5p+Z4i18eH7/JB+
         6AKPEqCVgja9Y5ShueULgn4HJcG3jsxUufZo1qKRHU3/tkUMZl/obF/RgLLJzSQ+il+I
         P6KmherKfTzXOjdfICBJrhwgzfRMeJMwtfP8CRmnfoOurUvbcf1JI7T9DXnR1rvEgBsc
         mlA1+IMXM5akIdfA3xQh4QDLWbomMMLuL8GOR3Bw9zTyk3w+kTLVnBZtLhgV21M8bm+x
         t2tA==
X-Forwarded-Encrypted: i=1; AJvYcCXwR4VMX1fJugo9LsIwZUrIRtTxVzOpDpt3Mj4zGOg4wX8oWnk/ZkAZOTzrs2PU9ih+sKvNAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwIBWCDftIVybKiKpg39LR+e+jkkLq93Zo3nKCg+IJKDyfNrCTy
	g91saHent8uOyllPFkLZIA1V2RX+RvfS28iME3xk+q3ZuAPb9r/C9UjEIc8UDCfZz4C70+L++Zl
	e3V/O+rZl8Zz4w8RkeLmx9Y6yWG7awQJrfHZjXPwm1g==
X-Gm-Gg: AeBDiesbUtXqt3aqR6opsrwq1uuriKnwAE9Uc1khZ5Hz2TjdfWWgxXM/zNEz7afcVGV
	Bcy9cXAW6o4Tjm3aE+P8s137x/Rq1pqeZDW8OqJM/TroESF980caFCxUVUd2FgOaeFEx6Ai+nfH
	y3yh5DhaAyiRABbWOIBFvKwKx5MRuE9495EiIN/oW19JhVY0cl52zHQqUsC4AzFbeNqqoHMe7sH
	CEBEb89lME1j+RQTttchLoULkHCrWFZnzQgMrWO8shn/DXzHlpQTk+RzfHhRXE1z4N31wYu+D9d
	rN/6yyLTWdslekGypGXflIYJrlsc5MUSylkSNDc=
X-Received: by 2002:a17:907:e102:b0:b83:95c8:15d0 with SMTP id
 a640c23a62f3a-b9d7279bb78mr130310166b.52.1775823294707; Fri, 10 Apr 2026
 05:14:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260407092617.635223-1-jiri@resnulli.us>
In-Reply-To: <20260407092617.635223-1-jiri@resnulli.us>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Fri, 10 Apr 2026 17:44:43 +0530
X-Gm-Features: AQROBzADFveULcyZjtNgjI9rBi4aeeX0JzC3AEXYi9kt8DQW2Z9q1-iXZwCoelw
Message-ID: <CAO_48GFt21rv0PJd2Csa0O4OEpN053_p__4Zux+m7jQdHSagEg@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf: heaps: system: document system_cc_shared heap
To: Jiri Pirko <jiri@resnulli.us>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	iommu@lists.linux.dev, linux-media@vger.kernel.org, 
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com, 
	tjmercier@google.com, christian.koenig@amd.com, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, jgg@ziepe.ca, leon@kernel.org, ptesarik@suse.com, 
	catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com, 
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com, 
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello Jiri,

On Tue, 7 Apr 2026 at 14:56, Jiri Pirko <jiri@resnulli.us> wrote:
>
> From: Jiri Pirko <jiri@nvidia.com>
>
> Document the system_cc_shared dma-buf heap that was introduced
> recently. Describe its purpose, availability conditions and
> relation to confidential computing VMs.
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: T.J.Mercier <tjmercier@google.com>

Thank you for the patch!

Marek: Since you're taking the dependent patches through your tree,
could you please use:
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>

and take this as well?

Thanks and Best regards,
Sumit.
> ---
>  Documentation/userspace-api/dma-buf-heaps.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/userspace-api/dma-buf-heaps.rst b/Documentation/userspace-api/dma-buf-heaps.rst
> index 05445c83b79a..f56b743cdb36 100644
> --- a/Documentation/userspace-api/dma-buf-heaps.rst
> +++ b/Documentation/userspace-api/dma-buf-heaps.rst
> @@ -16,6 +16,13 @@ following heaps:
>
>   - The ``system`` heap allocates virtually contiguous, cacheable, buffers.
>
> + - The ``system_cc_shared`` heap allocates virtually contiguous, cacheable,
> +   buffers using shared (decrypted) memory. It is only present on
> +   confidential computing (CoCo) VMs where memory encryption is active
> +   (e.g., AMD SEV, Intel TDX). The allocated pages have the encryption
> +   bit cleared, making them accessible for device DMA without TDISP
> +   support. On non-CoCo VM configurations, this heap is not registered.
> +
>   - The ``default_cma_region`` heap allocates physically contiguous,
>     cacheable, buffers. Only present if a CMA region is present. Such a
>     region is usually created either through the kernel commandline
> --
> 2.51.1
>
