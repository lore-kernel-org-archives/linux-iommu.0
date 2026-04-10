Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3323E0C56
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775860777; cv=pass; b=edhAmg7ek9BkqDNYugi115qsUOPzZ5+VDiEN08SuzvS2xbruC5mbapqYNYNEWUD9i/tI3iMoGDYozNY+TWNWx/pFChaC6mVqQaHFr0uQZUz+ZuwczaIOhrtlynlIciuoNgFC1Cvpqrk+1po54Tgy7c2FM969tEyoMTHEifpmpyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775860777; c=relaxed/simple;
	bh=tfo/A2i/TfSQnXpxKW4Rl6w2iMoE8xdLhh4QlvRABwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TF3+98v+DPjJ/VgRxU2+RpLXWIuCShZjQvMvFOsL6cw3aCZtdmWoS3H7MdrxvELREFsaxhCLHBMI8Yk3x0F6NnfxJgRVsEOzmt57BURJBXZXI6W7GFBmrEQqh+0X/cOsQPsGFvj1PCR9k1H4LIS13cJkjGAKMGAu5kulXu0zNjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com; spf=fail smtp.mailfrom=uber.com; dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b=32wlnMfS; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b="32wlnMfS"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7a17bc5745eso26549707b3.1
        for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 15:39:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775860774; cv=none;
        d=google.com; s=arc-20240605;
        b=euZYDZm1mRepxHtsK8f5k3Aew34hPkaTL73rihSXOBdqzuZu0W9Sejf0dwRHQp9LoP
         X14v4N9q0+F8f3yiY8K/3qq6NdgVyKjTpVbZklMRwss70fhGZFMeIrMMk1vAJPlv5rQa
         0Yis5hZHsVyiKeV7YCLsgaGnygb0jvI1gYR7xYmvxvHXkDxqM2ZIpbGDOcWjb13vqqSr
         C/VXFTurfe4f/o0Zr8spJy5MUV6VLEfskLOHHQu0/FPLo7diu1rQDbxCAwcW/keJSQw2
         oSgMfLwXJvzVfC59aXR+6d8E80Q2ehQQOIObwRcrEilvCZHdPa+S2s8zCKJAM738frS0
         qopA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jLwMpFotmNz9qSI+dw+StTfkgSeaXjf1JHydsM6F8ys=;
        fh=BV8AWao0g3dFYx8rwY5/02Vue3o3evxs7pqn+OMvkTc=;
        b=fSyDekPW2XvmlXqLW2B7nrIVC57M+BkOR/5xujL4C+xgGE6rn8JmRvhV2R5be3Gwot
         zdTdIRB6vK0YIfie3bG+88nApaw9OixT2vTKxUFbI3oMNaVuzpo+BSoLa/QyUqjGBaX9
         YgZumCdWtTrSJmSXAFFnRZbDLxd43VhzksBZFSLjr9RUhBHoN2SmbhgrjXT9x31AfhqT
         sS7ITwYYgUQvQ1cO2rdpOdqNtB6y6hz27Y2eZdweq1EHadEFzcWuwBLNyuYOaKLwaZD4
         EnEZNU8RY3DX7q/Klss5+nZg4EPpPirgTg/Y3d5yaoWqe0hw4G6ZEbesTNJdI3Vi51Gs
         bHfg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1775860774; x=1776465574; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLwMpFotmNz9qSI+dw+StTfkgSeaXjf1JHydsM6F8ys=;
        b=32wlnMfSMmOGUKFIs6VzdruUmx/gCa5sU/6v8kma9JYf8u+dRaHzwB0o43Dz/PBnGI
         WhhqNdUo9ZyXzs0J1gct0GeCurAmEhaJsX1gi+2opLiziOYZyvIdzVFntQ3rpOadENMK
         NkYVg1ZLeZEWMrCNDfwLjYVu9h7lPj21CGvew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775860774; x=1776465574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jLwMpFotmNz9qSI+dw+StTfkgSeaXjf1JHydsM6F8ys=;
        b=sDQBq4mYyoM9ofa/8N5xk+EWXhRfCZGn3w8L33yRmufzCqGTW+Hosou6IgQ2i4Q0yp
         j728YfJTTNqvZ+/CEBuLG0T5xQ+2FdLUBGu9s3PzzFgfVZEeLRB73PtaKVJbkMhoZIdh
         lJBkH3DPySt8Pk7knIQ32mZeZIqtHDFFupJEjGAZUl8QzMf+LKlZFzjWyLEcfN9ZQ4lv
         F3zvyfltzdaRI+gT96EZlPFhBDTYD/kkVDpYf1Fl95VubBQNllHH3k37MJ8/Ptmc+Pc5
         u+6w3vCCGbfBB00xpsy0S6hC83dDu0/ry72/TAVlA4nZfy0BNFMH4DwuG6NZ5C3ypt5w
         BY0g==
X-Forwarded-Encrypted: i=1; AJvYcCXDsNCqQMQiqSaA+HSkVPdJGCY3tUdWUM8R/nRdRZ+G3RpzyRqOtOZOvmdkS0A2+Yu5pNsSxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxN9iK98opP/8eTATb7lTHiPrDoUZ2DucR4GkLpVa13I2EMSk28
	SMP+tf1ec+w8aY/ubzI3ZxlY6R16rSn+oxcq+tFjM4b8s/ow1DCjzU1IFwoBtPQIQw8TBEorvIW
	stExP/PB1C6lNP9iS6IpVeX45gBCF1b716hn2b+d0bA==
X-Gm-Gg: AeBDieuoWPs63hgVZQFaclNld4zYudEbsNHCni6oOZ7fqV0qjFSEcpLAzpk9WTXV1HE
	PDf953lNc292AuhYaW+1N9qCu7wFN2ydoSN22NGRALc2onnHdzdmaLVBVMY92R5ACuzGdzNy9XE
	EnEBpNfegrXLXN3u2orKqVSOikepaDOfldZdT/0H5RmqLJySGnrlSHbpoMoMIEkc1fs6MUqu8TM
	eZhSeHM2B0f1H4OMfPPXAh8vhaxWdnxZ8TTce+tTBQJ5j48GPd60J0krR4khg+UjaH4/fbsyCz5
	ZRI2ox1T
X-Received: by 2002:a05:690c:6612:b0:79a:5164:bb2b with SMTP id
 00721157ae682-7af6f327722mr51252397b3.7.1775860774045; Fri, 10 Apr 2026
 15:39:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+w=M=SEUeGvXaK6OqdDVjYrbagnzDgAMgCRHbRqoYvS+OgW=w@mail.gmail.com>
 <c773c37c-b4ce-4f3f-927f-0be8a9b2d7a5@arm.com> <CA+w=M=SmUFUCfS6kGvRh3A4Vq++gSwhuPK7gn-ebWnM6BkpiZQ@mail.gmail.com>
 <CA+w=M=THPjp9JwDPe_XpLcEpLTLakCf8OiybSbLwOPxjmAHy0w@mail.gmail.com>
In-Reply-To: <CA+w=M=THPjp9JwDPe_XpLcEpLTLakCf8OiybSbLwOPxjmAHy0w@mail.gmail.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Fri, 10 Apr 2026 15:39:17 -0700
X-Gm-Features: AQROBzAheFmuUjqq6dqy8RnxTIRftTFHZJAZ9Du3u4CTLlxXL3_Uubzg8grCZ_E
Message-ID: <CA+w=M=TKSo-vDuOfMEZv=SGfaOMZ91XPgG5rJadWbzXtReyM3w@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: fix swapped arguments in SGL DMA unmap path
To: linux-nvme@lists.infradead.org
Cc: linux-iommu@vger.kernel.org, iommu@lists.linux.dev, jroedel@suse.de, 
	Robin Murphy <robin.murphy@arm.com>, will@kernel.org, Nagi Parimi <nparimi@uber.com>, 
	Kshitij Doshi <kshitijd@uber.com>, Jeff Bean <bean@uber.com>, Vikrant Soman <vsoman@uber.com>, kbusch@kernel.org, 
	xboe@kernel.dk, hch@lst.de, sagi@grimberg.me, leon@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 3:29=E2=80=AFPM Alireza Haghdoost <haghdoost@uber.c=
om> wrote:
>
> The arguments to nvme_free_sgls() in nvme_unmap_data() are swapped for
> the multi-entry SGL case. The first argument (sge) should be the
> segment descriptor from the NVMe command's data pointer (type
> NVME_SGL_FMT_LAST_SEG_DESC), and the second argument (sg_list) should
> be the pool-allocated array of data descriptors.
>
> With the arguments swapped, sge points to the first data descriptor
> (type NVME_SGL_FMT_DATA_DESC). nvme_free_sgls() sees a data descriptor,
> unmaps only that single entry, and returns -- leaking the DMA mappings
> for all subsequent segments.
>
> This manifests as unbounded iommu_iova slab growth on ARM64 systems
> with 64K pages and IOMMU DMA translation, where IOVA coalescing is
> disabled due to the NVMe 4K page / IOMMU 64K page granularity
> mismatch. On x86 and ARM64 with 4K pages, IOVA coalescing handles
> the unmap via dma_iova_destroy() and the buggy path is never reached.
>
> Fixes: 7ce3c1dd78fc ("nvme-pci: convert the data mapping to blk_rq_dma_ma=
p")
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
> ---
>  drivers/nvme/host/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 28f638413e122..728999e4247d8 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -761,8 +761,8 @@ static void nvme_unmap_data(struct request *req)
>
>         if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_l=
en)) {
>                 if (nvme_pci_cmd_use_sgl(&iod->cmd))
> -                       nvme_free_sgls(req, iod->descriptors[0],
> -                                      &iod->cmd.common.dptr.sgl);
> +                       nvme_free_sgls(req, &iod->cmd.common.dptr.sgl,
> +                                      iod->descriptors[0]);
>                 else
>                         nvme_free_prps(req);
>         }
> --
> 2.39.5

Apologies, I wasn't aware Roger Pau Monne already submitted this fix
(commit a54afbc8a2138 "nvme-pci: DMA unmap the correct regions in
nvme_free_sgls"), which is already in 6.19.y. Please disregard this
patch.

For the record, we independently confirmed the bug on production ARM64
hosts (64K pages, IOMMU DMA-FQ) where it caused ~490 GiB of leaked
iommu_iova slab over 42 days. Setting sgl_threshold=3D0 stopped the leak
immediately.

Alireza
