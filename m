Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FDD477983
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114215; cv=none; b=L8N88IwoSgjE8+qlxo9x5Q45PUDJrCMAi9py0A+2ys+XnLw7VFxYJIgtA/J7xTVK/A2ntTmN3kmROiykOgCp9exKXeHERtYtCplEpQ+jGC0TkPQtkXadS0kZXIDcCS9A52IVWkr58eankV0wTygp+UO/WCJmBItyjpLriOKLpCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114215; c=relaxed/simple;
	bh=RK9scrGy766A6YXR54Pqoa2eq1DiOV7GVNJWPlAdn/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPtaic2eTkhOOvlDjyBmRlzYTDdV3q2io0R0R4fo9u9gqpDgiSqSXYGrs5oQRV1vuJSPQ40nyNAADg58vsz5RaMJkX8FxmiGU4UN4kNK/1cZ4lsgde+jptESi4yi+KCPnN4mmLbr7zf6LyEjrZfut1C3cosabkTIYk39NMR53tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oq5Usj7d; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oq5Usj7d"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so725ad.0
        for <iommu@lists.linux.dev>; Mon, 18 May 2026 07:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779114207; x=1779719007; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+sZbZUHjZ//GhpOMWpDa3xawAFKF5ioAagbi5BAli/g=;
        b=Oq5Usj7dHAr+iBeXknKBjiuPAcmUau0kWoU7t6lZmqMxYwX9RMwrNq+1vnzeLjTrvS
         TJU1A71q5hP01XAMlRnXVE5BGByWT775eDcQMvOlnGDRiXECdNxOhV0/+/Fcp0FQEgnX
         Zg5MuFgAfu3xmRPXh+WFYXoqPEXhh1ceXV28lu9yjWw1VLoHQICleRADt/cmSrv51cin
         2bikAdRRHENAVfnoiEhDfinctrBSqEoJBisKUjXt+HRooi74m+hW4gBc44FZayzzk13j
         Ueb3hbUWDMyxZEIeU2E8Jwc9lZvTWKQAoXdirPm6N5Ay8J932Bu20W83v71tfc66+1i4
         VDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779114207; x=1779719007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sZbZUHjZ//GhpOMWpDa3xawAFKF5ioAagbi5BAli/g=;
        b=amrzu8SU3hmgOqIrCBVUtJmL8epKuUQrpJvpfKBFNh5O/Mb+JsXDBEGJ4mcqDRRDUz
         YXh+X8YVdBuiDE/ctB9JmU79pafAPs7Fjnnms3d6RA9BMhDbL80ts/QOeGtEkw4AdxGS
         191lBSMDPE++O3CDSHVwuBFAft1bfNXiId837zTcZ4UeO3CqvW3uRRyEVpjue2/4OpsA
         uE2Fvs79sCeohy8b8rP2TYvdCQhHJypYZ3bOmHBFa2UsnHxO/XARZ6gX4szWzUxBNoys
         A8KYmIOtPE13fo5Bt3Cb3phPrz3D+HHx1barB5lREbuoTND+J3qyllHs33a4zbBsvFyZ
         bSig==
X-Forwarded-Encrypted: i=1; AFNElJ8SgFMrh6f+XoRILmtQu6SKAyeb1G+EZaVHwM289Lqa4tAj6HjqXxFLluDoIJQUGTeeH+6qpg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyc+UHNrASx9xGfRkM+ZNa12afYLmuPyM2s4tK3YasTI2k2CwwA
	cFCaS+xbTUUgMI1OsCtHyhqqTDlZFRDRTMplktmaFgE5cgkgpQz2gsqa0TB4a7uHRQ==
X-Gm-Gg: Acq92OE6M2NiT5PQQip/34O1QKIe+HwMkunwoCn2E8fYvwHDAkFfz7Nr3b430EwUeSr
	zkzYZDC76MNiiEcewYz3TIKODUxW8K6Z683zye3gwN8O6G75P7e1euLJ5UEus+3YxBiLPDhCW79
	OtGm8N4yb0kInWsOoRieCioJNzjMK04JQxEcXbLfQbysqwyfJbZzE7do3pDZ07TYbHoyz5dhKDm
	AsGnHxvguW7uXRczWUBTlMLz/N9M9AoEq5OcNSykdhsaqlYbSO5uuzbe/ndNjPHKnz26SOfmbXi
	Ah4PCdgv4PzcqdWT1rxLwU087fzNr3ev9RNVUWU3H7F0aPhLlitYisKCtcjWdFfbeh2weFrHtWG
	glXsgTJrB5CaaE+PYPXpxdgpz9DNyVS68YiqPfSQYqxdA0kdk0b9LqaJlAO8aUWqp0yquy/iQJb
	5QSPFg10dC/iQTWns0xcgFnLjQFr/oXQoU70jJmd6yZEwJnv5g4BK8iqFG6OZYijkrT7Sl
X-Received: by 2002:a17:903:1a2d:b0:2b8:e82d:ff7c with SMTP id d9443c01a7336-2bdb32c3f0cmr2581525ad.9.1779114206217;
        Mon, 18 May 2026 07:23:26 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d11b495sm159685695ad.69.2026.05.18.07.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:23:25 -0700 (PDT)
Date: Mon, 18 May 2026 14:23:17 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 05/16] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <agsg1esRdKwV3dxB@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-6-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-6-skhawaja@google.com>

On Mon, Apr 27, 2026 at 05:56:22PM +0000, Samiullah Khawaja wrote:
> IOMMU pages are allocated/freed using APIs using struct ioptdesc. For
> the proper preservation and restoration of ioptdesc add helper
> functions.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/iommu-pages.c | 108 ++++++++++++++++++++++++++++++++++--
>  drivers/iommu/iommu-pages.h |  30 ++++++++++
>  2 files changed, 134 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-pages.c b/drivers/iommu/iommu-pages.c
> index 3bab175d8557..b1ffeb930e6d 100644
> --- a/drivers/iommu/iommu-pages.c
> +++ b/drivers/iommu/iommu-pages.c
> @@ -6,6 +6,7 @@
>  #include "iommu-pages.h"
>  #include <linux/dma-mapping.h>
>  #include <linux/gfp.h>
> +#include <linux/kexec_handover.h>
>  #include <linux/mm.h>
>  

[snip]

> +
> +/**
> + * iommu_unpreserve_pages - Unpreserve pages that were preserved in KHO
> + * @list: List of pages to unpreserve
> + */
> +void iommu_unpreserve_pages(struct iommu_pages_list *list)
> +{
> +	struct ioptdesc *iopt;
> +
> +	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm)
> +		kho_unpreserve_folio(ioptdesc_folio(iopt));
> +}
> +EXPORT_SYMBOL_GPL(iommu_unpreserve_pages);
> +
> +/**
> + * iommu_restore_page - Restore a page that was preserved in KHO
> + * @phys: Physical address of a page
> + */
> +void iommu_restore_page(u64 phys)
> +{
> +	struct ioptdesc *iopt;
> +	struct folio *folio;
> +	unsigned long pgcnt;
> +	unsigned int order;
> +
> +	folio = kho_restore_folio(phys);
> +	BUG_ON(!folio);
> +
> +	iopt = folio_ioptdesc(folio);
> +
> +	/*
> +	 * For the restored pages incoherent is set to false as these are not
> +	 * mapped using the DMA_API. The remapping of these pages using DMA_API
> +	 * is not needed as these are not going to be written to by the new
> +	 * kernel.
> +	 */

Looks good.

> +	iopt->incoherent = false;
> +
> +	order = folio_order(folio);
> +	pgcnt = 1UL << order;
> +	iommu_folio_update_stats(folio, pgcnt);
> +}
> +EXPORT_SYMBOL_GPL(iommu_restore_page);
> +
> +/**
> + * iommu_preserve_pages - Preserve pages during kexec handover
> + * @list: List of pages to preserve
> + *
> + * Returns 0 on success, negative error on failure
> + */
> +int iommu_preserve_pages(struct iommu_pages_list *list)
> +{
> +	struct ioptdesc *iopt;
> +	int ret;
> +
> +	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
> +		ret = kho_preserve_folio(ioptdesc_folio(iopt));
> +		if (ret)
> +			goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	list_for_each_entry_continue_reverse(iopt, &list->pages, iopt_freelist_elm)
> +		kho_unpreserve_folio(ioptdesc_folio(iopt));
> +

Looks good.

> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_preserve_pages);
> +#endif
> +

[snip]

> +static inline int iommu_preserve_pages(struct iommu_pages_list *list)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void iommu_unpreserve_pages(struct iommu_pages_list *list, int count)

Nit: This is inconsistent from the signature in it's counter part in
IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE)

Let's remove `int count` from the arguments to avoid broken builds.

> +{
> +}
> +
> +static inline void iommu_restore_page(u64 phys)
> +{
> +}
> +#endif
> +

With that stub argument fixed,
Reviewed-by: Pranjal Shrivastava praan@google.com

Thanks,
Praan
