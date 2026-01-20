Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A5434D4EC
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 18:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933390; cv=pass; b=fkGZ3WvOLa5gsongQG/DSwYphIp1eizAF2Ie5oD9hwEtb/QDuD2Nms26Vx5Q1PcVipMZLNbc9BOPvQ9r+kYkudBS34iYegBeT8d4L2c/ic6ZJRBbfmHCm+uDR7haBP4Zdo50Abc+oaKTTcua32dPVmtSwl3/MyZQ0TM+s/uuR3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933390; c=relaxed/simple;
	bh=I3prWUHACKoq46YzuOw9WAkFRf96ZJwt4IChstlP6AQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssqu87vcU8syWtPXBZJXqw7wZRf7YygiZlmKF8XeoYgoOjEQAXkTl5iX3UrpLvuucd9O7LRpsW0f0uWtiwxIvBng2gA49IfR16atIpij+cQa4O9SP7IWr19pSj8vjoCdWrbMWQ6hG+RW2T3vNV/XYVaPbTez7CUQ/AezLN3ZYbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HVoFcQKG; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HVoFcQKG"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5014acad6f2so27781cf.1
        for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 10:23:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768933385; cv=none;
        d=google.com; s=arc-20240605;
        b=XlVkPkWuh9NBme7CmK0qbliwFrdPUlV2f5Q0znf5XdVKo5de64+Mfr72p0iNP9g/L/
         w8WAdY73Rodp77wrHt31ySt9LSE0j1sVu8Tu4XUbAFKXN/snJLmn1wg6SQdU4gVGopQ1
         9HuQPzqDX0IpquZ7d5QB0jCv4vj/CuWYS4YzBRJCSE40ipBBClkrJc77fpNZyECjJUMk
         St3h1C9xFPUNYxBSERQH/TQjHBGW2WpXa/en2tc7tfRR06WGRYZZMZ/W7C+VeDc9Rk4W
         GJQOIagnBqLW2vfGIa12vwqyyc12HhNIXYGWzwagiwpe7Uw7eOfi1vAzKXgXHs1qgcHx
         JKdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=prbFJUMbRwSPb2162Jr+/kVKQtX3qmcYeeelHD6oA9s=;
        fh=7tepBYZhTHTt2/ipUYXzg/UUK1Zxnx/+ZXcQACuj5so=;
        b=Qo+wI7vDmmRYhO13s7tx68Nt05m5nffsenVK+RdFIRS1kbD3UIVEhPavfTmuRsiwKV
         FJpGsUpvhm2KmknDFsNyDfP2jSDRsNqX7aNP3zjlJ97nidCjORD1NPWfxBs5qnbTS7Is
         IwKtjauLq1RCnSYnzqA/i+uh4QQWV4w2BdHqR6cptUdTVas3D9mHKJ/Tpr6OpIo7rk7u
         3cO1kpI7nI8R1Scmkbo/6rlsMxF5XzEyVav4bwRwjhRyZRR1H0xtC/srF6ulQsXaNXXb
         mOC4jC0sK8uCLIyXSYveOYI6oiueLmwz+YoKriPa6D3FVQ/SgXwaUDr99K2Qh+7upuGC
         cloQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768933385; x=1769538185; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prbFJUMbRwSPb2162Jr+/kVKQtX3qmcYeeelHD6oA9s=;
        b=HVoFcQKGURDpsvOxgIf0bYV/QARpC3BpO4yXnG+obQrBBi54qcgC/5drYRyEzyBlO0
         TCUDhxnuNUqGISzrqPvVQWvtAwM5uXCy6BaoA3Q/uMNzt1RxdUGDAjclSf6oe6mISfPc
         Ii5y+o1SiAdQfCZEwjW4i1A0p3nJsouLIg4lStNGUinw8kwBmqyQDmSNhS/lkXXMysb/
         TEXwyNN63viuzYOgM6l29ISuxgkO8EZtGGzJo+rxBK22LbfNxzhsaSFv/dqz+Hse10CL
         UPO9pnhqrHoSuiM4DCWb2QDVS628LeZuNmvwKRfcxfsYDjeVMICX3JLDbqcXjjT5ZplT
         IX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768933385; x=1769538185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=prbFJUMbRwSPb2162Jr+/kVKQtX3qmcYeeelHD6oA9s=;
        b=CVlciBsvkuYPpIYPBpFPJ68G+LKqt2VuJaWEitfn9Jy+QSMjkLp/Mzk5HLjmgwo0Pj
         hSFSjY30fggf3g6+ZXe/pV2SICuh1j22myVb8e7g6QwYrWG3zNTHReq+LGAeRGc4sjva
         2bhmXsqhevs3ARpgrkAdaVsyjrf6U6R1Jnj0zoMApde1nwHN7k76wlwTjXch3jEHP0eI
         cQsxmBQ9YucVi08h8RHczjvelo25wF72zl8aTnIiyTcFc1MCXiVovDI8RrwcJBpVFqs3
         an5ZGglrFDQswoPdDKOqLN25bSFbQk5kcU3Aiactk76u9ksX8rwuPs5GZwVUQ8xp5882
         +WNg==
X-Forwarded-Encrypted: i=1; AJvYcCVRZLQg2IzNALBB1DwvsjED8XXCH1sJ6ojKlCLCYQ6a2njhkXKVvPUlGYE9ookApFxh+EHUYw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4axn2H0ckQl4bp7JKm36Gwc8bzIZgGMGSrQsWCg1iEyl3iTHC
	FPZljxt/Lq9XoWjtf4Ps/WT64X+hECdm99YfLMZftfG9LQOcyGX5c7p1AW31pGMHRj0j30RyMFx
	+I705WoUv/ySPJ/F4DdN3otE8n2WTghpCsKt5UkHW
X-Gm-Gg: AY/fxX5Kz7OHtIFBjaelxlzGmVSjBoxfRhixBCK/TyjtAGPeWlfoqHvcx2lzP060eFx
	y3TqF287IgsFuKgg/8AyfS6yZ8PSkaj+ACWySpwLLWruXa8Uol3XwRYWuC865eSzCFIxGf4B9KW
	V4YkS4q3QKEJQpC0ZEO6v1/t0rbBaS5HZl2G82jOcOELO+hhBVSis2P9jg/LDNoX5gQDkQx2Pip
	gN7EAb02fM3gkEjMNP7bMx7fg0UcugurTdYk2NI5z8Q3zGzQ7PAv5iS+CW0thAHC4Y5jkVqahGE
	29nbbwKQLY4cbjeX70nstZKik1xyeBiq2Oc=
X-Received: by 2002:ac8:58d6:0:b0:4ed:ff79:e678 with SMTP id
 d75a77b69052e-502e0c7f18dmr425261cf.18.1768933385193; Tue, 20 Jan 2026
 10:23:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260120061816.2132558-1-baolu.lu@linux.intel.com> <20260120061816.2132558-3-baolu.lu@linux.intel.com>
In-Reply-To: <20260120061816.2132558-3-baolu.lu@linux.intel.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Tue, 20 Jan 2026 10:22:50 -0800
X-Gm-Features: AZwV_QivdLK88ajAp__l99_1nqZ6WfDkpAu55jksmbfq3ph_1-2EyDMcO7Zu51U
Message-ID: <CAAywjhTf1eZ20eGcZPAZN5o77+O3TEc_mT6W1f=qVtabbLwS2w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iommu/vt-d: Clear Present bit before tearing down
 context entry
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Dmytro Maluka <dmaluka@chromium.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 10:20=E2=80=AFPM Lu Baolu <baolu.lu@linux.intel.com=
> wrote:
>
> When tearing down a context entry, the current implementation zeros the
> entire 128-bit entry using multiple 64-bit writes. This creates a window
> where the hardware can fetch a "torn" entry =E2=80=94 where some fields a=
re
> already zeroed while the 'Present' bit is still set =E2=80=94 leading to
> unpredictable behavior or spurious faults.
>
> While x86 provides strong write ordering, the compiler may reorder writes
> to the two 64-bit halves of the context entry. Even without compiler
> reordering, the hardware fetch is not guaranteed to be atomic with
> respect to multiple CPU writes.
>
> Align with the "Guidance to Software for Invalidations" in the VT-d spec
> (Section 6.5.3.3) by implementing the recommended ownership handshake:
>
> 1. Clear only the 'Present' (P) bit of the context entry first to
>    signal the transition of ownership from hardware to software.
> 2. Use dma_wmb() to ensure the cleared bit is visible to the IOMMU.
> 3. Perform the required cache and context-cache invalidation to ensure
>    hardware no longer has cached references to the entry.
> 4. Fully zero out the entry only after the invalidation is complete.
>
> Also, add a dma_wmb() to context_set_present() to ensure the entry
> is fully initialized before the 'Present' bit becomes visible.
>
> Fixes: ba39592764ed2 ("Intel IOMMU: Intel IOMMU driver")
> Reported-by: Dmytro Maluka <dmaluka@chromium.org>
> Closes: https://lore.kernel.org/all/aTG7gc7I5wExai3S@google.com/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.h | 21 ++++++++++++++++++++-
>  drivers/iommu/intel/iommu.c |  4 +++-
>  2 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 25c5e22096d4..599913fb65d5 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -900,7 +900,26 @@ static inline int pfn_level_offset(u64 pfn, int leve=
l)
>
>  static inline void context_set_present(struct context_entry *context)
>  {
> -       context->lo |=3D 1;
> +       u64 val;
> +
> +       dma_wmb();
> +       val =3D READ_ONCE(context->lo) | 1;
> +       WRITE_ONCE(context->lo, val);
> +}
> +
> +/*
> + * Clear the Present (P) bit (bit 0) of a context table entry. This init=
iates
> + * the transition of the entry's ownership from hardware to software. Th=
e
> + * caller is responsible for fulfilling the invalidation handshake recom=
mended
> + * by the VT-d spec, Section 6.5.3.3 (Guidance to Software for Invalidat=
ions).
> + */
> +static inline void context_clear_present(struct context_entry *context)
> +{
> +       u64 val;
> +
> +       val =3D READ_ONCE(context->lo) & GENMASK_ULL(63, 1);
> +       WRITE_ONCE(context->lo, val);
> +       dma_wmb();
>  }
>
>  static inline void context_set_fault_enable(struct context_entry *contex=
t)
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 134302fbcd92..c66cc51f9e51 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1240,10 +1240,12 @@ static void domain_context_clear_one(struct devic=
e_domain_info *info, u8 bus, u8
>         }
>
>         did =3D context_domain_id(context);
> -       context_clear_entry(context);
> +       context_clear_present(context);
>         __iommu_flush_cache(iommu, context, sizeof(*context));
>         spin_unlock(&iommu->lock);
>         intel_context_flush_no_pasid(info, context, did);
> +       context_clear_entry(context);
> +       __iommu_flush_cache(iommu, context, sizeof(*context));
>  }
>
>  int __domain_setup_first_level(struct intel_iommu *iommu, struct device =
*dev,
> --
> 2.43.0
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
