Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476DDA59
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 04:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730089504; cv=none; b=Q+49kpg60bS3VfKpekk8MhCfFauDlS9FSnnY1pBR9KMzH3HnyYvzVgOBs1c21WYgQVyKRB4Ge5uM/mJAZj7BPaZlsNH5ytEeyIUW2pnughJo4hmkfseZP6YJAkEfRqA1EM8KkS+mdx+L8k8hvF91yJgD2C7ODhvxcgChgqhQ2Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730089504; c=relaxed/simple;
	bh=Y9iGHqOHKOxRX/YuktGKzJY8/m4TQ2gtHKBpbGPfu08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nsxjt8Or9NRNvtg8Bu7HJM1tmuHER9TVkgdIwn/7EGsR1m1VADKLO1jERxQKSPWAnpCdkObjMONR7eo4kfpS2X3FHUvyRCPbhB/yc74ZEC3qPIeMC8SGMBIYEL+jeZRz6LcOzvxyWQsHC+MFpdzA8PYvDuj7WAixNdwF1jt6DrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDlr6ze+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDlr6ze+"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cdda5cfb6so35723555ad.3
        for <iommu@lists.linux.dev>; Sun, 27 Oct 2024 21:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730089501; x=1730694301; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3x7sfjCk6an/jee3PqRBielnEix2rcYMcqqI8sdlR0=;
        b=eDlr6ze+FmgZQSGHXiEs3Xk1fWVvkQQmsIBnc3zoGhfkJwwBqcdBQ72N4kourzfdxe
         7pfDe1uEozOfF5URGvnhk02PBlDy9V89BIxbHyVsiRS+SpRmhMVec+IZwy7HiyL/gBY6
         XBKLdw2JFUQNbQouSKR04zSXy43ea0MDLlPGVwhquDLtomGuhkzhClReQPXX/M8fqKRJ
         FjP4SuLsr0tgyb7P+xb2ZqxFBWEX0+r6gQ4JeWoUFG/NESueUj36VojJ7UowZ/1YacK5
         a/yfq+uWQxVN7DO6a+QLWww7bxUW/xBHE1sPgkb6eJGy89PTaGDsYkMIMjxwcC92d6ow
         xxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730089501; x=1730694301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3x7sfjCk6an/jee3PqRBielnEix2rcYMcqqI8sdlR0=;
        b=RLGJS6rOtdY/m6dk8t41ueH5AUKwnwKK1XX7gtXYBsgbNIy+kp0sz6OIOkE83GiKMz
         +fZhBBioAflJpYZcyyTaM9Cqrv8DOXKRYBmO0Fz36nvNNvk7ldXINFQPwv0JijgXBINA
         i77bbFCF8lI+PQMhvQgoppSLSBNZCZvi2Lh2RBeFF+E9YC7wwo8DxzMDdBtmsjLUuP1T
         YfSbbK4+vE9xYoHe1WWTAY263FdMsigeWyHol2XUlH7KVNKtdNm+f+TM3e5dOC1KetZZ
         1GAoUlJ8tdz2Dg88bf0inCCSwsbum4S2HA1FiDF6GsU78EUG7dKMzsrrrMK3IDeEnlw7
         KCKg==
X-Forwarded-Encrypted: i=1; AJvYcCX2xLw81ccwSki06e1BE7otrnxiIZP5yQ/xbHjmnzlqX38XWnhoUETZrcLrcYa0kCnkDGn06g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyc4KvcZbx/gDa3RHxxX3RXZKXLCXhznmr5QWPbQgvjt+l7zBK4
	OVyCkGlFkzt/QVT+nlvfDHWIup65PTxoRrLorGjEY1Zde2P6fWzh49p2c9GWe0hf1ypiC6PacvE
	UvC0RbvdFdusd+2/ETr0rk7WvISw=
X-Google-Smtp-Source: AGHT+IF/XbpZuxphQQOGSTKqE4rMFhTi6L+p1iG+0wHvbb3b0Zmpl46tdIWRMT6RjNj1jqQyIDmtIwt2bzj/qL3GX/U=
X-Received: by 2002:a17:902:db02:b0:20c:b700:6e10 with SMTP id
 d9443c01a7336-210c6c8856cmr116967905ad.34.1730089501376; Sun, 27 Oct 2024
 21:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1730037276.git.leon@kernel.org> <844f3dcf9c341b8178bfbc90909ef13d11dd2193.1730037276.git.leon@kernel.org>
In-Reply-To: <844f3dcf9c341b8178bfbc90909ef13d11dd2193.1730037276.git.leon@kernel.org>
From: Srinivasulu Thanneeru <dev.srinivasulu@gmail.com>
Date: Mon, 28 Oct 2024 09:54:49 +0530
Message-ID: <CAMtOeKJeVrELCp5JpYTC64KdfKpbnW9a8QrnL6ziCYL48nc=qQ@mail.gmail.com>
Subject: Re: [PATCH 05/18] dma: Provide an interface to allow allocate IOVA
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Yishai Hadas <yishaih@nvidia.com>, 
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	=?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev, 
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2024 at 10:23=E2=80=AFPM Leon Romanovsky <leon@kernel.org> =
wrote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> The existing .map_page() callback provides both allocating of IOVA
> and linking DMA pages. That combination works great for most of the
> callers who use it in control paths, but is less effective in fast
> paths where there may be multiple calls to map_page().

Can you please share perf stats with this patch in fast path, if available?

> These advanced callers already manage their data in some sort of
> database and can perform IOVA allocation in advance, leaving range
> linkage operation to be in fast path.
>
> Provide an interface to allocate/deallocate IOVA and next patch
> link/unlink DMA ranges to that specific IOVA.
>
> The API is exported from dma-iommu as it is the only implementation
> supported, the namespace is clearly different from iommu_* functions
> which are not allowed to be used. This code layout allows us to save
> function call per API call used in datapath as well as a lot of boilerpla=
te
> code.
>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/iommu/dma-iommu.c   | 79 +++++++++++++++++++++++++++++++++++++
>  include/linux/dma-mapping.h | 15 +++++++
>  2 files changed, 94 insertions(+)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index c422e36c0d66..0644152c5aad 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1745,6 +1745,85 @@ size_t iommu_dma_max_mapping_size(struct device *d=
ev)
>         return SIZE_MAX;
>  }
>
> +static bool iommu_dma_iova_alloc(struct device *dev,
> +               struct dma_iova_state *state, phys_addr_t phys, size_t si=
ze)
> +{
> +       struct iommu_domain *domain =3D iommu_get_dma_domain(dev);
> +       struct iommu_dma_cookie *cookie =3D domain->iova_cookie;
> +       struct iova_domain *iovad =3D &cookie->iovad;
> +       size_t iova_off =3D iova_offset(iovad, phys);
> +       dma_addr_t addr;
> +
> +       if (WARN_ON_ONCE(!size))
> +               return false;
> +       if (WARN_ON_ONCE(size & DMA_IOVA_USE_SWIOTLB))
> +               return false;
> +
> +       addr =3D iommu_dma_alloc_iova(domain,
> +                       iova_align(iovad, size + iova_off),
> +                       dma_get_mask(dev), dev);
> +       if (!addr)
> +               return false;
> +
> +       state->addr =3D addr + iova_off;
> +       state->__size =3D size;
> +       return true;
> +}
> +
> +/**
> + * dma_iova_try_alloc - Try to allocate an IOVA space
> + * @dev: Device to allocate the IOVA space for
> + * @state: IOVA state
> + * @phys: physical address
> + * @size: IOVA size
> + *
> + * Check if @dev supports the IOVA-based DMA API, and if yes allocate IO=
VA space
> + * for the given base address and size.
> + *
> + * Note: @phys is only used to calculate the IOVA alignment. Callers tha=
t always
> + * do PAGE_SIZE aligned transfers can safely pass 0 here.
> + *
> + * Returns %true if the IOVA-based DMA API can be used and IOVA space ha=
s been
> + * allocated, or %false if the regular DMA API should be used.
> + */
> +bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *state=
,
> +               phys_addr_t phys, size_t size)
> +{
> +       memset(state, 0, sizeof(*state));
> +       if (!use_dma_iommu(dev))
> +               return false;
> +       if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
> +           iommu_deferred_attach(dev, iommu_get_domain_for_dev(dev)))
> +               return false;
> +       return iommu_dma_iova_alloc(dev, state, phys, size);
> +}
> +EXPORT_SYMBOL_GPL(dma_iova_try_alloc);
> +
> +/**
> + * dma_iova_free - Free an IOVA space
> + * @dev: Device to free the IOVA space for
> + * @state: IOVA state
> + *
> + * Undoes a successful dma_try_iova_alloc().
> + *
> + * Note that all dma_iova_link() calls need to be undone first.  For cal=
lers
> + * that never call dma_iova_unlink(), dma_iova_destroy() can be used ins=
tead
> + * which unlinks all ranges and frees the IOVA space in a single efficie=
nt
> + * operation.
> + */
> +void dma_iova_free(struct device *dev, struct dma_iova_state *state)
> +{
> +       struct iommu_domain *domain =3D iommu_get_dma_domain(dev);
> +       struct iommu_dma_cookie *cookie =3D domain->iova_cookie;
> +       struct iova_domain *iovad =3D &cookie->iovad;
> +       size_t iova_start_pad =3D iova_offset(iovad, state->addr);
> +       size_t size =3D dma_iova_size(state);
> +
> +       iommu_dma_free_iova(cookie, state->addr - iova_start_pad,
> +                       iova_align(iovad, size + iova_start_pad), NULL);
> +}
> +EXPORT_SYMBOL_GPL(dma_iova_free);
> +
>  void iommu_setup_dma_ops(struct device *dev)
>  {
>         struct iommu_domain *domain =3D iommu_get_domain_for_dev(dev);
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 6075e0708deb..817f11bce7bc 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -11,6 +11,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/bug.h>
>  #include <linux/mem_encrypt.h>
> +#include <linux/iommu.h>
>
>  /**
>   * List of possible attributes associated with a DMA mapping. The semant=
ics
> @@ -77,6 +78,7 @@
>  #define DMA_BIT_MASK(n)        (((n) =3D=3D 64) ? ~0ULL : ((1ULL<<(n))-1=
))
>
>  struct dma_iova_state {
> +       dma_addr_t addr;
>         size_t __size;
>  };
>
> @@ -307,11 +309,24 @@ static inline bool dma_use_iova(struct dma_iova_sta=
te *state)
>  {
>         return state->__size !=3D 0;
>  }
> +
> +bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *state=
,
> +               phys_addr_t phys, size_t size);
> +void dma_iova_free(struct device *dev, struct dma_iova_state *state);
>  #else /* CONFIG_IOMMU_DMA */
>  static inline bool dma_use_iova(struct dma_iova_state *state)
>  {
>         return false;
>  }
> +static inline bool dma_iova_try_alloc(struct device *dev,
> +               struct dma_iova_state *state, phys_addr_t phys, size_t si=
ze)
> +{
> +       return false;
> +}
> +static inline void dma_iova_free(struct device *dev,
> +               struct dma_iova_state *state)
> +{
> +}
>  #endif /* CONFIG_IOMMU_DMA */
>
>  #if defined(CONFIG_HAS_DMA) && defined(CONFIG_DMA_NEED_SYNC)
> --
> 2.46.2
>
>
