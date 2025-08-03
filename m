Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560A72206BB
	for <iommu@lists.linux.dev>; Sun,  3 Aug 2025 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754219631; cv=none; b=hIkoPZKjJxpEN4ZOAaBmARymojPE44uTF45rP+WSJ8i97hsP58dop86uwsVuYmDKFydAqEIADLcvU7zjF0X984Ke6Rt3TU7xo0E5RF1lFjYGDW1belU0OesM3hXphja+YkktRaR89ZbyiQFez5VEiyCqnk5YnKQZrvLOgi+37Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754219631; c=relaxed/simple;
	bh=O+g8CxkQPuLesApubC8IAJLYwASoA8Ig8vnN1L8Il2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=IksnXSN8Snih5lwZG4WpG4ilSRlXimXKOpVdePMWk3b4n4I+RX9uvS+bl3Mc7683a+COpNa+pGIl1/AdqJvBKyjoRz3p6n8M47dtd6PO00TiyunhKOH09mI4wa48AK22LbHEa+FT0G/1tGDaHP/Ha79n3VmM3S+XXCwkcjKTObo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com; spf=pass smtp.mailfrom=infinidat.com; dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b=M6EFLhne; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinidat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b="M6EFLhne"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b0619a353dso2154521cf.3
        for <iommu@lists.linux.dev>; Sun, 03 Aug 2025 04:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infinidat.com; s=google; t=1754219628; x=1754824428; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GEUjqEm9tcGU+yKMIokzl2jHHPWYnk7whteuYDv/T20=;
        b=M6EFLhneNR67LGTdAxBIIiGQQ3pIRVxqlanTrFd09ydFsDFxez50E9dsVBwV9IOWYC
         tNC14BEzevmZQVmuByv48RIRX+KKhKkJBgzeSAtWsm/71fSY9O8c3gkxAtQvacnyUMVH
         Wgo4D+X9WtvTyFZC77TemKrYcILWqvVlpsFP+hKYuF8t0TE9caQ8lEBspMulKEYai0yv
         LZLiUDQ2ixVQTXsRpkMK+aHFEPwoN7okVmJRXyqr2Zz44/uRXsIQp6qjbDd81f7llWC4
         itAIyt58K4Xr+Tt7EPZsw5DKVZaCFA9OY2+5DR4+Pgdgb9Nui5uVwxHhcb4hI3cAWo06
         htVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754219628; x=1754824428;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GEUjqEm9tcGU+yKMIokzl2jHHPWYnk7whteuYDv/T20=;
        b=ltHRmsRMUWEjls8tcptnHIHELkc5VQgqV1RKDnBczlj4cqAQxGI3oT9DbfHcGJT3Sf
         9Tgp+KqqFLNB2oQl18/kD/rgwEsc9yOVin/Ddxte+hfCELeY6ZzuP5i0kFtZUEsuoDUk
         qoqM2zGQGRZbFSW8pAiJKe+ruGLd0mKvswUBgyMiFVoowhJ4tS5Nq5o09Fk0f/h3lOXF
         8DsBQYWuWSZQycmyR9qFyIawt7TxREZo3s6oo/VNBPm5+9bd9/c6WlT7A73JYkDYzQDU
         czu/+8LXBeDtluE6W7ITfMQxTKwANSgbhQcLIdgy57NIlhcz89AxtYtmU2r93xPWs8nm
         GcWw==
X-Forwarded-Encrypted: i=1; AJvYcCU0kci3otrMU2gMZsbEBpd9UbAxCKVwHiFHYOF6E8k6qQD5xkYw2uL8CDiNi6TkrwKpKcSbeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyOJx4WhRwq6xdhI0GmWJEWB7gwJsF/oxEWXrlgB79yePCAPCfK
	gQNkCateTaQbeycU7ew7wnZoB4mwQK6HPBdm0iTtlf02+UO6+dFv0QeRdasf8qp8qH8sFTXs772
	sNWk5DdbUKxQP7xaRVHG2Oqs5iHw03WuSlK19IL5ZSj76ycKBU+oQGwI=
X-Gm-Gg: ASbGncsw8k5o3/Lxm5h6HeAksl0mdDJe6CI3xn93UJM0i0xWG+wasMt2jfo6EILTXDy
	60Uy2ktkx/Wn912fxcDuuTvO+9xv+ZSNHPkANI9Yct4RaCg+2xZHL6DuEE8yOwo04jCG6BVk2jD
	w0Z+RnHzIn17VrSeWOqNvOci5v0ogABYhU3a/BIPeNleMmbiDJgVwA1NUkAbYVpbX6q6WcHSII5
	iMdl269uQ==
X-Google-Smtp-Source: AGHT+IHMQDvRCofDDloJvGjiEeerEIY/Gk/pqXHt4400cKQ1iuLYdaI7mko2AdwujXEATtF9h/5fBrg4fLW3hXab0IE=
X-Received: by 2002:a05:6214:478c:b0:709:49a4:885f with SMTP id
 6a1803df08f44-70949a49a0dmr40803926d6.22.1754219628138; Sun, 03 Aug 2025
 04:13:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAEHaoC2BWe+0Ps2oU-0xPDLFYYKG-o9+_ynFgh7u3qqyRDtrTg@mail.gmail.com>
 <CAEHaoC22NDpHUWovJChCx_XqchkEvUPYrFFe_L1PH9Mw2e386A@mail.gmail.com>
 <CAEHaoC2bi3VUEuoWKgHbgUFfdxmACrhkjaQ9Jni-4-ByP5tYJg@mail.gmail.com>
 <CAEHaoC3ZMvHe7D-JX9bfM9hfSPs0QV-og=om5eKFFqSL=tpjcw@mail.gmail.com>
 <CAEHaoC0Au_0yLRKSnDg=_qjnmDMmbJ=Nff+W1feEBTib0Jb_gA@mail.gmail.com> <CAEHaoC2ZQAd+h=7mKPOuMfAMex-41soD8=kx2vR_em+i71oBRw@mail.gmail.com>
In-Reply-To: <CAEHaoC2ZQAd+h=7mKPOuMfAMex-41soD8=kx2vR_em+i71oBRw@mail.gmail.com>
From: Constantine Gavrilov <cgavrilov@infinidat.com>
Date: Sun, 3 Aug 2025 14:13:37 +0300
X-Gm-Features: Ac12FXyc_haSATZmshA1lIscPRg0h10RAjFcZPKYQTbpgA8tGl5MqqjtHPhJ2Y4
Message-ID: <CAEHaoC3t8nFhR4MAYV1AaR5mjN4ndkkWrKUyBY_smbtpDykAEA@mail.gmail.com>
Subject: [PATCH 5/8] Large DMA alloc/remove max32_alloc_size field
To: linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

This is the sixth patch from the set of patches that enable large IOMMU
DMA registrations. Entire work is available at the master branch of the
master branch of git@github.com:cgavrilov/linux.git repo.

This patch removes max32_alloc_size field from the iova_domain structure.
This field was introduced to optimize the path of allocation failure (return
failed allocation without checking for available regions), but was not
implemented correctly, resulting in failed allocations when the space maybe
available.

commit cfdad4eb84e8c5dc7aa3f868575007de2e1fc1e4
Author: Constantine Gavrilov <cgavrilov@infinidat.com>
Date:   Tue Jul 1 10:05:11 2025 +0300

    Removed max32_alloc_size field from the iova_domain structure.

    This field exists for the purpose of optimizing a path of failed
    allocations in 32-bit DMA space, when the 32-bit range is depleted.
    There are a number of issues:

    1. max32_alloc_size is updated in __alloc_and_insert_iova_range()
       without checking the size after allocation of the range fails. This
       will cause a wrong failed small allocation after a "big" allocation
       fails.
    2. max32_alloc_size is updated in __cached_rbnode_delete_update()
       without checking the top bound of the released range and the size
       of the released range. This defeats the purpose of the intended
       "optimization".
    3. Alignment constraints and DMA  address limits are not taken into account
       when updating this field after the allocation fails. This results in
       future allocation failures that can succeed if looking for available
       ranges is not skipped.

    Rather than fixing this "optimization", remove it altogether. We shall
    not optimize for failed allocation path that is rare, and the optimizing
    affect of this feature is questionable.

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index aba58630be12..0c436dd35404 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -52,7 +52,6 @@ init_iova_domain(struct iova_domain *iovad, unsigned
long granule,
     iovad->granule = granule;
     iovad->start_pfn = start_pfn;
     iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
-    iovad->max32_alloc_size = iovad->dma_32bit_pfn;
     iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
     rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
     rb_insert_color(&iovad->anchor.node, &iovad->rbroot);
@@ -88,9 +87,6 @@ __cached_rbnode_delete_update(struct iova_domain
*iovad, struct iova *free)
          free->pfn_lo >= cached_iova->pfn_lo))
         iovad->cached32_node = rb_next(&free->node);

-    if (free->pfn_lo < iovad->dma_32bit_pfn)
-        iovad->max32_alloc_size = iovad->dma_32bit_pfn;
-
     cached_iova = to_iova(iovad->cached_node);
     if (free->pfn_lo >= cached_iova->pfn_lo)
         iovad->cached_node = rb_next(&free->node);
@@ -182,9 +178,6 @@ static int __alloc_and_insert_iova_range(struct
iova_domain *iovad,

     /* Walk the tree backwards */
     spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
-    if (limit_pfn <= iovad->dma_32bit_pfn &&
-            size >= iovad->max32_alloc_size)
-        goto iova32_full;

     curr = __get_cached_rbnode(iovad, limit_pfn);
     curr_iova = to_iova(curr);
@@ -207,7 +200,6 @@ static int __alloc_and_insert_iova_range(struct
iova_domain *iovad,
             curr_iova = to_iova(curr);
             goto retry;
         }
-        iovad->max32_alloc_size = size;
         goto iova32_full;
     }

diff --git a/include/linux/iova.h b/include/linux/iova.h
index 30ce5ad499d2..2800bdc203b1 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -33,7 +33,6 @@ struct iova_domain {
     unsigned long    granule;    /* pfn granularity for this domain */
     unsigned long    start_pfn;    /* Lower limit for this domain */
     unsigned long    dma_32bit_pfn;
-    unsigned long    max32_alloc_size; /* Size of last failed allocation */
     struct iova    anchor;        /* rbtree lookup anchor */

     struct iova_rcache    *rcaches;


-- 
----------------------------------------
Constantine Gavrilov
System Architect and Platform Engineer
Infinidat
----------------------------------------
