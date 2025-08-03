Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C467C1DE3C8
	for <iommu@lists.linux.dev>; Sun,  3 Aug 2025 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754219746; cv=none; b=KQ6BZhST+Xr9sJTr32UbIPiU4z+bWSsSclyrQDyX6DcySeXXLdCbd8RujF59ncqK19eq7/+CP+KC5tIO0qPPOHGKvk3ljicp5+DKW7EnS+NUd0v9p+OpQIDdAWCxCWkw9jFNdVcHhQVJo9X0Y/xyZvEj974CFkD4utFrbGeMcxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754219746; c=relaxed/simple;
	bh=P1xihm6nYGBaA31Ku0RBITl7ToPMxIN0kgn3yguOXCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=p0ccqKqmHbdjZODyRwtmeBKnDE51Ewp+Nj0T738nBkdK5/5I8qOOGgqC6qF7Rsx9Mbh+M3EA3gPbgbZQcy+YVLOyy91t0Fm+ZMAbd5MLqtSfdnvA8+X8yh4RF6Ay0b4j/SzgQyWm/HtCFxmdNN/pNjyZ5SdsGSM37vrR48pQXGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com; spf=pass smtp.mailfrom=infinidat.com; dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b=CuXzMMiz; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinidat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b="CuXzMMiz"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-707453b0306so25138066d6.2
        for <iommu@lists.linux.dev>; Sun, 03 Aug 2025 04:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infinidat.com; s=google; t=1754219743; x=1754824543; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RlAuN8Gw47ZBISll2i6eJ2pzlpQq1e20H9Pgw4gDQCE=;
        b=CuXzMMiz9xtI8qVVqGwPe54MTgp/6uOWwe1mhVDoyoxW2vQqA+pWPnls0Brblr+deR
         aEBpJDkZHEWqeN83fLMNpAdc3SMxne9/zmVDIgmpOAkuZaflXH5N406wspOr1tVfGOmQ
         RMnPjHW4AyOT6Sf2LuW7HJ84c7NGKTd37gevQsoyLO/aggbYgf8p5i/ABbZQ8/OrUfNP
         qjwYgUUbnb85RUIWs7JRwm50674q7jGNHSmU4EE2k3bI4Gt1n0zkXQ51dDZxtBofko9/
         M/5E4zbD99EOi40BO5CGaH64rfTKB4pZZR8UkcEiG/Qt4z5mQl1ShDj+fNGszryyO20P
         b3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754219743; x=1754824543;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RlAuN8Gw47ZBISll2i6eJ2pzlpQq1e20H9Pgw4gDQCE=;
        b=EeZ28yxhkSz6txOaKeyonPIM0gp67vHRa9xb3hXtfNcfpKudpKfmMzyji1XWBX5u2T
         IsdSagNO8cJWggERew/BYYBB37YP7Gze+/+4WwlXoGMulXPBKHCrtloYUgtlpUKe0vbX
         ApSkC4AvecPnbC+qgCGVP5P7rH8R1y4Xe2WTCrgYjfq9zbP7SHORZnTyJZbCA/C1M+Ug
         FU1zNrhTmtcyaOjlEQr/m6AwnQIUXOzyUUtvrXx5ogiMg08iAnjNilqOYXdhDy1bK/SG
         dC1hfers9HRZImhRw9poKAbrhA1zuRvrSGjnDa5v47rw1P6chC1D+NfB3SMv/irNnkr1
         h5wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwFuuH/6WRboTfPxLLWAqWJEFDq75zvsihMLSKxyN1mdtDWSVWQH3AB64E+UJN6tqj/4WY/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLGY77sovos1x9jXY4EtFuJwEt1uBljOPAJyYIMJRqr+EMa2B3
	ok6B3JhGomxwub+npLmO8uHhnAf4AlxzQPYa+NJj7aT9KcsDwqlZ8YFhfozVSgyTUY8/MkwOvgk
	ZZaafpJHlUKuUeAaMv0yGA6uMEuneIkwazLkqSM+EOU1YruxDf6GvW1w=
X-Gm-Gg: ASbGncsvNCxl9/YS2S+45JJxn1X7C/mwxkGgpyM2/FQgbjWozqVPpvAc2yEh1hrG/rM
	4WifSA/Q5IBXQUj0wuaI+G1AAWFT9eyCUs4yq4yZ3bhGHVcLfXLRT30008qt5GnX8tLMnJx8s8Y
	n9AS1ukHrUNRscmvk7KtL9uNlsIJvn76tvR3cZ9WV2lSCYTtvbUl3CZUeG3BhZ0hFWP+Rkvbn6d
	sDvyJgPYQ==
X-Google-Smtp-Source: AGHT+IHSRvS5Rc51kBhuWo/kXgLlKGxZEwmgjLiMqCPE6UtxHQooEtrwwfJHpqFFnA+fkUMdO46iBGn0rPqUj9LUuLA=
X-Received: by 2002:a05:6214:5097:b0:6fb:59de:f8ab with SMTP id
 6a1803df08f44-70935edc218mr96809796d6.10.1754219743635; Sun, 03 Aug 2025
 04:15:43 -0700 (PDT)
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
 <CAEHaoC0Au_0yLRKSnDg=_qjnmDMmbJ=Nff+W1feEBTib0Jb_gA@mail.gmail.com>
 <CAEHaoC2ZQAd+h=7mKPOuMfAMex-41soD8=kx2vR_em+i71oBRw@mail.gmail.com> <CAEHaoC3t8nFhR4MAYV1AaR5mjN4ndkkWrKUyBY_smbtpDykAEA@mail.gmail.com>
In-Reply-To: <CAEHaoC3t8nFhR4MAYV1AaR5mjN4ndkkWrKUyBY_smbtpDykAEA@mail.gmail.com>
From: Constantine Gavrilov <cgavrilov@infinidat.com>
Date: Sun, 3 Aug 2025 14:15:32 +0300
X-Gm-Features: Ac12FXwo3cEc8BChv_4H2DlsqyGf1kK8GuuMJrVYj5__fN-d73nDOsTDuW2BEKU
Message-ID: <CAEHaoC1mHQp62GMBofGJwKBkjgf8rQr_tUxwESKa7Ehd6_3nWA@mail.gmail.com>
Subject: [PATCH 6/8] Large DMA alloc/alloc DMA addresses from the top
To: linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

This is the seventh patch from the set of patches that enable large IOMMU
DMA registrations. Entire work is available at the master branch of the
master branch of git@github.com:cgavrilov/linux.git repo.

This patch ensures that addresses in IOMMU group are allocated from the top
to the bottom of the address space. It fixes some issues with the use of
cached_node and cached32_node fields of the iova_domain structure that
resulted in fragmentation of the address space. Fragmented address space can
lead to failed allocations of DMA ranges.

commit d8bb3c731ff750afc568fa73d770eb1fa3e96c09
Author: Constantine Gavrilov <cgavrilov@infinidat.com>
Date:   Tue Jul 1 11:19:08 2025 +0300

    Allocate DMA addresses from top to bottom in IOVA domains.

    The cached_node and cached32_node fields of the iova_domain structure
    are used as the starting point for the address search only if the cached
    node starts at the DMA limit or below it, or if the DMA limit is 64 bit
    or 32 bit respectively.

    The cached_node and cached32_node are updated upon successful allocation
    only if the search was performed from the node that does not lie below the
    cached values and not above the DMA limit.

    For clarity, cached_node field was renamed to cached_top_node.

    To enable the existing optimization for network stack behavior - where
    network drivers can allocate above 250K DMA buffers for network pools
    without using SG tables, we add cached_middle_node and middle_pfn_limit
    fields. Without using those, the system locks up for minutes at boot
    time trying to allocate network pools.

    This ensures contiguous allocations from top to the bottom, with holes
    due to alignment or due to lower DMA address requirements for some devices
    in the group. Altogether, this avoids fragmentation of DMA address space
    and ensures that large DMA ranges are available.

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 0c436dd35404..09356d6065ef 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -47,7 +47,9 @@ init_iova_domain(struct iova_domain *iovad, unsigned
long granule,

     spin_lock_init(&iovad->iova_rbtree_lock);
     iovad->rbroot = RB_ROOT;
-    iovad->cached_node = &iovad->anchor.node;
+    iovad->cached_top_node = &iovad->anchor.node;
+    iovad->cached_middle_node = &iovad->anchor.node;
+    iovad->middle_pfn_limit = IOVA_ANCHOR;
     iovad->cached32_node = &iovad->anchor.node;
     iovad->granule = granule;
     iovad->start_pfn = start_pfn;
@@ -58,22 +60,63 @@ init_iova_domain(struct iova_domain *iovad,
unsigned long granule,
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);

+static struct rb_node *iova_find_limit(struct iova_domain *iovad,
unsigned long limit_pfn);
+
 static struct rb_node *
-__get_cached_rbnode(struct iova_domain *iovad, unsigned long limit_pfn)
+__get_start_rbnode(struct iova_domain *iovad, unsigned long limit_pfn)
 {
-    if (limit_pfn <= iovad->dma_32bit_pfn)
+    struct iova *cached = to_iova(iovad->cached32_node);
+    if (limit_pfn == iovad->dma_32bit_pfn || (cached->pfn_hi + 1) >= limit_pfn)
         return iovad->cached32_node;

-    return iovad->cached_node;
+    cached = to_iova(iovad->cached_middle_node);
+    if (limit_pfn == iovad->middle_pfn_limit || (cached->pfn_hi + 1)
>= limit_pfn)
+        return iovad->cached_middle_node;
+
+    cached = to_iova(iovad->cached_top_node);
+    if (limit_pfn == IOVA_ANCHOR || (cached->pfn_hi + 1) >= limit_pfn)
+        return iovad->cached_top_node;
+
+    return iova_find_limit(iovad, limit_pfn);
 }

 static void
-__cached_rbnode_insert_update(struct iova_domain *iovad, struct iova *new)
+__cached_rbnode_insert_update(struct iova_domain *iovad, struct iova
*new, struct iova *start_search, unsigned long limit_pfn)
 {
-    if (new->pfn_hi < iovad->dma_32bit_pfn)
-        iovad->cached32_node = &new->node;
-    else
-        iovad->cached_node = &new->node;
+    /* insert the update only if the search started from the cached
node or above it
+     * This way, we alttempt to allocate from top to the bottom, with
holes due to alignment
+     * or DMA address limit for individual devices in the group
+     */
+    struct iova *cached;
+
+    /* update top node */
+    cached = to_iova(iovad->cached_top_node);
+    if (limit_pfn >= start_search->pfn_lo &&
+            start_search->pfn_lo >= cached->pfn_lo &&
+            new->pfn_lo < cached->pfn_lo)
+        iovad->cached_top_node = &new->node;
+
+    /* update middle node */
+    cached = to_iova(iovad->cached_middle_node);
+    if (limit_pfn >= start_search->pfn_lo &&
+            start_search->pfn_lo >= cached->pfn_lo &&
+             new->pfn_lo < cached->pfn_lo) {
+        iovad->cached_middle_node = &new->node;
+        if (limit_pfn != IOVA_ANCHOR && (limit_pfn > iovad->middle_pfn_limit ||
+                iovad->middle_pfn_limit == IOVA_ANCHOR))
+            iovad->middle_pfn_limit = limit_pfn;
+    } else if (limit_pfn != IOVA_ANCHOR) {
+        iovad->middle_pfn_limit = limit_pfn;
+        iovad->cached_middle_node = &new->node;
+    }
+
+    if (new->pfn_lo <= iovad->dma_32bit_pfn) {
+        cached = to_iova(iovad->cached32_node);
+        if (limit_pfn >= start_search->pfn_lo &&
+            start_search->pfn_lo >= cached->pfn_lo &&
+             new->pfn_lo < cached->pfn_lo)
+            iovad->cached32_node = &new->node;
+    }
 }

 static void
@@ -87,9 +130,13 @@ __cached_rbnode_delete_update(struct iova_domain
*iovad, struct iova *free)
          free->pfn_lo >= cached_iova->pfn_lo))
         iovad->cached32_node = rb_next(&free->node);

-    cached_iova = to_iova(iovad->cached_node);
+    cached_iova = to_iova(iovad->cached_top_node);
     if (free->pfn_lo >= cached_iova->pfn_lo)
-        iovad->cached_node = rb_next(&free->node);
+        iovad->cached_top_node = rb_next(&free->node);
+
+    cached_iova = to_iova(iovad->cached_middle_node);
+    if (free->pfn_lo >= cached_iova->pfn_lo && free->pfn_lo <
iovad->middle_pfn_limit)
+        iovad->cached_middle_node = rb_next(&free->node);
 }

 static struct rb_node *iova_find_limit(struct iova_domain *iovad,
unsigned long limit_pfn)
@@ -161,8 +208,8 @@ static int __alloc_and_insert_iova_range(struct
iova_domain *iovad,
         unsigned long size, unsigned long limit_pfn,
             struct iova *new, iova_align_t align)
 {
-    struct rb_node *curr, *prev;
-    struct iova *curr_iova;
+    struct rb_node *curr, *prev, *start_search;
+    struct iova *curr_iova, *start_iova;
     unsigned long flags;
     unsigned long new_pfn, retry_pfn;
     unsigned long align_mask;
@@ -179,8 +226,8 @@ static int __alloc_and_insert_iova_range(struct
iova_domain *iovad,
     /* Walk the tree backwards */
     spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);

-    curr = __get_cached_rbnode(iovad, limit_pfn);
-    curr_iova = to_iova(curr);
+    curr = start_search = __get_start_rbnode(iovad, limit_pfn);
+    curr_iova = start_iova = to_iova(curr);
     retry_pfn = curr_iova->pfn_hi;

 retry:
@@ -193,11 +240,11 @@ static int __alloc_and_insert_iova_range(struct
iova_domain *iovad,
     } while (curr && new_pfn <= curr_iova->pfn_hi && new_pfn >= low_pfn);

     if (high_pfn < size || new_pfn < low_pfn) {
-        if (low_pfn == iovad->start_pfn && retry_pfn < limit_pfn) {
+        if (start_search != &iovad->anchor.node && low_pfn ==
iovad->start_pfn && retry_pfn < limit_pfn) {
             high_pfn = limit_pfn;
             low_pfn = retry_pfn + 1;
-            curr = iova_find_limit(iovad, limit_pfn);
-            curr_iova = to_iova(curr);
+            curr = start_search = iova_find_limit(iovad, limit_pfn);
+            curr_iova = start_iova = to_iova(curr);
             goto retry;
         }
         goto iova32_full;
@@ -209,7 +256,7 @@ static int __alloc_and_insert_iova_range(struct
iova_domain *iovad,

     /* If we have 'prev', it's a valid place to start the insertion. */
     iova_insert_rbtree(&iovad->rbroot, new, prev);
-    __cached_rbnode_insert_update(iovad, new);
+    __cached_rbnode_insert_update(iovad, new, start_iova, limit_pfn);

     spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
     return 0;
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 2800bdc203b1..0780a64e1149 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -26,14 +26,16 @@ struct iova_rcache;

 /* holds all the iova translations for a domain */
 struct iova_domain {
-    spinlock_t    iova_rbtree_lock; /* Lock to protect update of rbtree */
-    struct rb_root    rbroot;        /* iova domain rbtree root */
-    struct rb_node    *cached_node;    /* Save last alloced node */
-    struct rb_node    *cached32_node; /* Save last 32-bit alloced node */
-    unsigned long    granule;    /* pfn granularity for this domain */
-    unsigned long    start_pfn;    /* Lower limit for this domain */
-    unsigned long    dma_32bit_pfn;
-    struct iova    anchor;        /* rbtree lookup anchor */
+    spinlock_t    iova_rbtree_lock;    /* Lock to protect update of rbtree */
+    struct rb_root    rbroot;              /* iova domain rbtree root */
+    struct rb_node    *cached_top_node;    /* Save last alloced node
from the top*/
+    struct rb_node    *cached_middle_node; /* Saved last alloced node
in the middle */
+    struct rb_node    *cached32_node;      /* Save last 32-bit alloced node */
+    unsigned long    granule;             /* pfn granularity for this domain */
+    unsigned long    start_pfn;           /* Lower limit for this domain */
+    unsigned long    dma_32bit_pfn;       /* 32-bit PFN limit, constant */
+    unsigned long   middle_pfn_limit;    /* cached_middle_node is for
this limit */
+    struct iova    anchor;              /* rbtree lookup anchor */

     struct iova_rcache    *rcaches;
     struct hlist_node    cpuhp_dead;


-- 
----------------------------------------
Constantine Gavrilov
System Architect and Platform Engineer
Infinidat
----------------------------------------
