Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AA9284B26
	for <iommu@lists.linux.dev>; Tue,  6 Jan 2026 21:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767734369; cv=pass; b=iqwpfk0jAG3ulN4AVhcaXQUgY2cNlyOvyyl/g+nP2zlm6+5BWbvQaGxCy/3fRR0aLlsA48HUbRxtfn342Zw+n8rJe0E4LqmUMd+l8sKKh+tJTodS+JpYRVO7F6/8966nVVBdMo+Ju7YGlOrY/J17H2skMELCF0v/8gqx3nhldgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767734369; c=relaxed/simple;
	bh=sNK+qQwDfUndLOKto7ahkG+BQnpGyBQcb9WTb7JdGTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrYEFSyXsG3zy+KgWGGRT4USft+Vqm8GHYprdNBkYghZ7rlC6VTsKBo/yEezqHLLnte7SUjoNgMCsiwwBd+1woicdc20plAF/PeuyBX3jj4s3cH9YyjWto9txZ4B+1dzZ4y5g9b2WGVgoJ6Bo8NNSIungtxDJD3+VWw44yYlNRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R9LifQ/c; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R9LifQ/c"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-11a247de834so2017c88.0
        for <iommu@lists.linux.dev>; Tue, 06 Jan 2026 13:19:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767734367; cv=none;
        d=google.com; s=arc-20240605;
        b=g3As49eBCoQiXzK3sTG5mZW5hdzDZFFk4G649wG7GM+IkpTlmpZGxad4xqTw6xwIa5
         GTeUj6A7CpIYwPmTAekTSl3ktxplBIHGYEX4RkKBPqZuTUBmpuNd0hMD7K9z5GFqsbEI
         pdwBPYzpWxGt44snBX1V3uvqIdTgfMdNaMfNcGYfm9R8mkiJY60pWQj54146mSw3JGwo
         Ff6yXd9AfATsjr7hAItY+ADvMZE2dHVxQGompy+SpLDsVSCIksYy5GONvNOiRBKfLq/5
         LSnj1X4iBREXJABb4eVZkTnEg0xRiFPpmwPrxVt6zaNnLTvpdtmHHQlSNMKo7JzcV1Rq
         RIlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v0WDLL1FeM2LN8bxMsxZQjW0E/VVI2Vol2qU0rnzeCI=;
        fh=i/vui4iucl4S+4Asc/EOeQ4RtzShUpoHUhLFR8MYpPc=;
        b=igoleW1yeiNlrAcgMmwAjpfMX54JWt7zidELD8BEKYfkz2K1w3bhK6gqDCscc52AXE
         Tib6DnYY3QNf9rUXD8La7qyoF763MVe2qYMFescN+CH+Yxvric1cRgQ33RibisWXcN7e
         9d4OOlQdKQQsKs2ndAvoSGT9abq/BoX7lkMnPLVIh0lMCnYPB4m02bY73Ck3+nxNzax5
         rTLTnxI3loJ4iqx6ZspbvJXJg0RGvGzTt5l9MfXE/TsRoQkpXQveG6Mt3udxUk6FMZa+
         wsZX0G4xRG+9yFKLTntkzov/HJhDWE9GkKCeU8SuavwQGDCRBmzys6yxgBrAtwTwmjoz
         bgvw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767734367; x=1768339167; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0WDLL1FeM2LN8bxMsxZQjW0E/VVI2Vol2qU0rnzeCI=;
        b=R9LifQ/c2KyiKufJNozriwwKsaGX5WAGSdtemgcd8WYi3BxT16ifCHuRxN6wQT3MG/
         VYfcSkTfdfewhr/RwTI+5XEBHgZveVsxvwsZe08eunc3EeZOpGFpMCrUEcd9ZWANYwSs
         4ostUb3fCmQwYLFmdWQzl7Kn1mqTPql5vMESviGopF/k7cXlG3wGu1iB2verwm6ovcNw
         IgOX5InY7S/ElBju2PESc3sMhjfOoC3PYDtAJ98aJ2v7D86wfOfKOENNpSj4qaz3FcLw
         GGX8k2npVWX04bMTpGWNLzPQ52aFYo/SbaiaIlWUXGrCQvyvAmuu4gkR8ruVWBzAGv7a
         285A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767734367; x=1768339167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v0WDLL1FeM2LN8bxMsxZQjW0E/VVI2Vol2qU0rnzeCI=;
        b=uVzAGwd6WXLaZ7eMcrcrDeBGJ0MNTaSOxG/qwYyIa+FndOQiOoaIDMQecd4SlWnzgm
         sW8LSaqeevvGExDEIuK/B1NQp6dPJfnBpfE3uSYa37nQqb5PUzs3QXB5Fr8ySc6avRls
         x/UoaZwYu8/IwkTHzELu99TeANmMpy6ReiYhHWmsoREC16R8l9UGZIHXw6uYjQ8D7OGY
         wbKbCPI8LSsip+6ii2muZIiwZP9k5FaDqrXELTLUsQj/kr5UAegz2ciroq/G0QiDxw/I
         OsgOt8vEovy4pwLW3U9pWT7pxMRGDO4X67jzwqynhs49UzcP9V//yel5Wv7iO9BgxpQZ
         5KrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsdKrESaxM3AnfBRqJBuKWfTzw9zUGzmUCv7qT9KyTzDAxCJYDkj34c9UQ0FrFar6XZFLR9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxliDfebm+rtIpmJYPzClufBJYu3Fbv8eJemNMiF4/3XavL5e3I
	bZGpQMRHQ66LcrDY87fA5P+/fIAmLtuIMzrwcmlKKSNXd6PyJMx9kBGIi3qthkLB6xqKYnqSG7Z
	eN24svRgUCOFVwBo6r+MT/GSKmoVwudmGV0sp/JjK
X-Gm-Gg: AY/fxX5+Qtl5P6ujRZqyziAay+/HTRZPeONMj1jKNZcvJ9ICeizK7gn+efOixPZEOHA
	2s1jyJ6CnkAdUoU3swtFiWKwk18RT+xoW0hQusbhBFb9fGMO2xY4YyxHk0KOWyCyGWIMjCfolJY
	qRMA3jQT6WV1EDr6WRPQlsXXT1GzzzM76c+Hw4LYM//tDiiJtLeFUGDMq3dBWp8lOooF/z2Ei0C
	CXaDHqYwxYe9x4bcx068azCHO/msCY+uiyByGTPCdGXnFLPH6QejG+gFjUDXGZ48AoehpxQOhBt
	6ls2dZ2SrenyRtOZpHISABubli/lJi09wQ==
X-Received: by 2002:a05:7022:2204:b0:11a:4c75:a45b with SMTP id
 a92af1059eb24-121f8690149mr27061c88.10.1767734366229; Tue, 06 Jan 2026
 13:19:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260106162200.2223655-1-smostafa@google.com> <20260106162200.2223655-5-smostafa@google.com>
In-Reply-To: <20260106162200.2223655-5-smostafa@google.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Tue, 6 Jan 2026 13:19:13 -0800
X-Gm-Features: AQt7F2oijAP3GChcEgGLCyF9ausjTQAQE9RZQidHFJzJm2N1jZ-pPamc_b3fK2A
Message-ID: <CAAywjhQ=b504kj7j0sBR4tShkeFcgEZw5nY-SvQDdZoaEEP00g@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] iommu: debug-pagealloc: Check mapped/unmapped
 kernel memory
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz, 
	surenb@google.com, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com, 
	baolu.lu@linux.intel.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 8:22=E2=80=AFAM Mostafa Saleh <smostafa@google.com> =
wrote:
>
> Now, as the page_ext holds count of IOMMU mappings, we can use it to
> assert that any page allocated/freed is indeed not in the IOMMU.
>
> The sanitizer doesn=E2=80=99t protect against mapping/unmapping during th=
is
> period. However, that=E2=80=99s less harmful as the page is not used by t=
he
> kernel.
>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/iommu-debug-pagealloc.c | 23 +++++++++++++++++++++++
>  include/linux/iommu-debug-pagealloc.h | 14 ++++++++++++++
>  include/linux/mm.h                    |  5 +++++
>  3 files changed, 42 insertions(+)
>
> diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-=
debug-pagealloc.c
> index 86ccb310a4a8..5353417e64f9 100644
> --- a/drivers/iommu/iommu-debug-pagealloc.c
> +++ b/drivers/iommu/iommu-debug-pagealloc.c
> @@ -9,6 +9,7 @@
>  #include <linux/iommu-debug-pagealloc.h>
>  #include <linux/kernel.h>
>  #include <linux/page_ext.h>
> +#include <linux/page_owner.h>
>
>  #include "iommu-priv.h"
>
> @@ -73,6 +74,28 @@ static size_t iommu_debug_page_size(struct iommu_domai=
n *domain)
>         return 1UL << __ffs(domain->pgsize_bitmap);
>  }
>
> +static bool iommu_debug_page_count(const struct page *page)
> +{
> +       unsigned int ref;
> +       struct page_ext *page_ext =3D page_ext_get(page);
> +       struct iommu_debug_metadata *d =3D get_iommu_data(page_ext);
> +
> +       ref =3D atomic_read(&d->ref);
> +       page_ext_put(page_ext);
> +       return ref !=3D 0;
> +}
> +
> +void __iommu_debug_check_unmapped(const struct page *page, int numpages)
> +{
> +       while (numpages--) {
> +               if (WARN_ON(iommu_debug_page_count(page))) {
> +                       pr_warn("iommu: Detected page leak!\n");
> +                       dump_page_owner(page);
> +               }
> +               page++;
> +       }
> +}
> +
>  void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, si=
ze_t size)
>  {
>         size_t off, end;
> diff --git a/include/linux/iommu-debug-pagealloc.h b/include/linux/iommu-=
debug-pagealloc.h
> index a439d6815ca1..46c3c1f70150 100644
> --- a/include/linux/iommu-debug-pagealloc.h
> +++ b/include/linux/iommu-debug-pagealloc.h
> @@ -13,6 +13,20 @@ DECLARE_STATIC_KEY_FALSE(iommu_debug_initialized);
>
>  extern struct page_ext_operations page_iommu_debug_ops;
>
> +void __iommu_debug_check_unmapped(const struct page *page, int numpages)=
;
> +
> +static inline void iommu_debug_check_unmapped(const struct page *page, i=
nt numpages)
> +{
> +       if (static_branch_unlikely(&iommu_debug_initialized))
> +               __iommu_debug_check_unmapped(page, numpages);
> +}
> +
> +#else
> +static inline void iommu_debug_check_unmapped(const struct page *page,
> +                                             int numpages)
> +{
> +}
> +
>  #endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
>
>  #endif /* __LINUX_IOMMU_DEBUG_PAGEALLOC_H */
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6f959d8ca4b4..32205d2a24b2 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -36,6 +36,7 @@
>  #include <linux/rcuwait.h>
>  #include <linux/bitmap.h>
>  #include <linux/bitops.h>
> +#include <linux/iommu-debug-pagealloc.h>
>
>  struct mempolicy;
>  struct anon_vma;
> @@ -4133,12 +4134,16 @@ extern void __kernel_map_pages(struct page *page,=
 int numpages, int enable);
>  #ifdef CONFIG_DEBUG_PAGEALLOC
>  static inline void debug_pagealloc_map_pages(struct page *page, int nump=
ages)
>  {
> +       iommu_debug_check_unmapped(page, numpages);
> +
>         if (debug_pagealloc_enabled_static())
>                 __kernel_map_pages(page, numpages, 1);
>  }
>
>  static inline void debug_pagealloc_unmap_pages(struct page *page, int nu=
mpages)
>  {
> +       iommu_debug_check_unmapped(page, numpages);
> +
>         if (debug_pagealloc_enabled_static())
>                 __kernel_map_pages(page, numpages, 0);
>  }
> --
> 2.52.0.351.gbe84eed79e-goog
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
