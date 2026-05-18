Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45769384233
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124938; cv=none; b=FzonsX/gxsUkV3b6hr1PuzvSEyosgO8N+vHrOffWWoK1Oy6OSvvyUEGhOGDpgIOppanLDqSVdQ7D9ofcOP578FdLZZK19bZYjdUZE4srT6bX5BbTt+cUSd2wOQTONAU/QrVhLGuQ4pdokUn8csM73mi7o5D/bbOfXP/3gFgfs58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124938; c=relaxed/simple;
	bh=kvzoRRtRkt99R85TCv6fmYGvBN6W9hGpuH3oahXqcoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRo48qaYvTZJlkqq8eNupQktr+ZijDRb/O3b/6uhECPWbnaxyxrd86kMUhgUlR8+lWFN18LGvFGdl8p/zwPHoySailqN08tj70SwUC3tjFmyygvowNDYuX+CGDO161Y+bD0XjxSzJlackq+5mS3tVIN6pBtLcnyoCYoxrdD83MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C/DgB42F; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/DgB42F"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b46da8c48eso65ad.1
        for <iommu@lists.linux.dev>; Mon, 18 May 2026 10:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779124937; x=1779729737; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GOpQmNzrJoZpllcvwCwLtMCpq7AcJeE0RS7V56u/5aU=;
        b=C/DgB42FUG7GwyyU4k7CGYdgQ+bHL0ZFwaIbcpZ70I75vEloOAFH+AX+vWMkH/mAN+
         cPLKFd2uNNGZF+pGlJddF3ZTRJFdlZus7sJPYee9dMNrilPbRAGdu1ne14rDAaKIGH+I
         gYc5Xd78rZXo3S6dh1itUPeLezt1MV3XtZFZlfjZbE9Cpnsin4F0LmZKzkhsd2qAwnqm
         EwIpUGH7Om/22p5R3y6Q0GxURFXGHMxrO6tLVDOMq+4A2O90RtF4GLvo1h+NCqWZYP/p
         qQoBy/E0Ll18UxOozXXF4iew/HX58gHyOctj7/av/MDYllKHpVEo3kSm+B0iQYcmYcui
         rhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779124937; x=1779729737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOpQmNzrJoZpllcvwCwLtMCpq7AcJeE0RS7V56u/5aU=;
        b=IcLbBdckKDHZ7cWOhWGIhomSw/mP43w2vK6gWlcKJsKYqCyhMDxDWzaBYCjrAuO7ZY
         srVYCUtPguRpi+/6qy2PcmP1Apo5Zr7Y0DngXgfNDBm1BPoZDs/YaOZ8mcqXnhybPuM9
         xe5Te5PNo+LiFjxv0s93TtBFXusKJ3pGIUakX6izQlzksqU9toUsV/7DEQW4R8iVs7vP
         sM6SRrKy9d3ZR1SVRBaZAm1+kly1+E/zcvbQrI8VFg4h9XtU/s6UJf4cTT42YKdrrap2
         6gXpYXxD3NTDenzvNjztvEO5jiEjGks1TYEJIs0hut5zcaDVsy9WlXi2zUli0gCf6uaa
         8pDQ==
X-Forwarded-Encrypted: i=1; AFNElJ/n99eRh+ai0QTgvwN3owlHSGGqHFSCIRVzs9cAm2P0Fegu3LZh3hI8my2ZbRw8WbhijHjjeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdkR4FpFzPLTrmBfD+B4s8jrbrcQc6JV4lsP1v0YQj6OPhC2LT
	9M4MtRqyWtEriVyO/Et1MTKHiBx23FhI2X7zlUKVY+jYXzVonDROrvtHoHK8AOu9tg==
X-Gm-Gg: Acq92OHDqJMHQtYsn8dDyL3lPH7E2hmdIDL1PgciAs6CfK7gdoRSQn3qs3ua1t2LwCI
	Z1HfxMWv7ECdsvggvIgMIPBXNTeFWnaxkxoKdcjna+zxt4OtzorfYpQlf9ZjDNOqNUGfI3LDqwu
	L4z69FEKdCJFn1yJE+G4YNpfqIn/ZRe0DBX/Z5iIvE0ElgqgyJIZilLG29fY41SVCIPKy4yhVGf
	hE2gMDtnhsN1NAadofD3LI9gHTRDSBeQRUumuATMb2JPoq/Nw9yYpHwsVgVN5YP+2NiCFqKVfaJ
	G7leK7XHGNbvcosehS/92FgLtn4clnq4kuJ9UFmUbYZSIBsiWladbbQBBNsnVZPgWCSqs+PGfON
	sMJ7LSBc+gMAxWBzrJ/hAa/HSPI7MvMt6/3VBg4qZePCqywCXSyJaSXpFr+GSXFjOSeW/ETSHcy
	TgCPEwc8+/MWlflQvbrkHEGd+9uxOWOv7SMB+r/GoYtO8LBcE/yWfvCPvSezuHGFU5gC8GFapck
	KgprinN
X-Received: by 2002:a17:903:228e:b0:2b0:aee4:afe7 with SMTP id d9443c01a7336-2bdb03a197bmr3385745ad.10.1779124935806;
        Mon, 18 May 2026 10:22:15 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1977b779sm15315177b3a.23.2026.05.18.10.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:22:15 -0700 (PDT)
Date: Mon, 18 May 2026 17:22:12 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 05/16] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <agtKjY_D2S6I_DVd@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-6-skhawaja@google.com>
 <agsg1esRdKwV3dxB@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <agsg1esRdKwV3dxB@google.com>

On Mon, May 18, 2026 at 02:23:17PM +0000, Pranjal Shrivastava wrote:
>On Mon, Apr 27, 2026 at 05:56:22PM +0000, Samiullah Khawaja wrote:
>> IOMMU pages are allocated/freed using APIs using struct ioptdesc. For
>> the proper preservation and restoration of ioptdesc add helper
>> functions.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/iommu-pages.c | 108 ++++++++++++++++++++++++++++++++++--
>>  drivers/iommu/iommu-pages.h |  30 ++++++++++
>>  2 files changed, 134 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu-pages.c b/drivers/iommu/iommu-pages.c
>> index 3bab175d8557..b1ffeb930e6d 100644
>> --- a/drivers/iommu/iommu-pages.c
>> +++ b/drivers/iommu/iommu-pages.c
>> @@ -6,6 +6,7 @@
>>  #include "iommu-pages.h"
>>  #include <linux/dma-mapping.h>
>>  #include <linux/gfp.h>
>> +#include <linux/kexec_handover.h>
>>  #include <linux/mm.h>
>>
>
>[snip]
>
>> +
>> +/**
>> + * iommu_unpreserve_pages - Unpreserve pages that were preserved in KHO
>> + * @list: List of pages to unpreserve
>> + */
>> +void iommu_unpreserve_pages(struct iommu_pages_list *list)
>> +{
>> +	struct ioptdesc *iopt;
>> +
>> +	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm)
>> +		kho_unpreserve_folio(ioptdesc_folio(iopt));
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_unpreserve_pages);
>> +
>> +/**
>> + * iommu_restore_page - Restore a page that was preserved in KHO
>> + * @phys: Physical address of a page
>> + */
>> +void iommu_restore_page(u64 phys)
>> +{
>> +	struct ioptdesc *iopt;
>> +	struct folio *folio;
>> +	unsigned long pgcnt;
>> +	unsigned int order;
>> +
>> +	folio = kho_restore_folio(phys);
>> +	BUG_ON(!folio);
>> +
>> +	iopt = folio_ioptdesc(folio);
>> +
>> +	/*
>> +	 * For the restored pages incoherent is set to false as these are not
>> +	 * mapped using the DMA_API. The remapping of these pages using DMA_API
>> +	 * is not needed as these are not going to be written to by the new
>> +	 * kernel.
>> +	 */
>
>Looks good.
>
>> +	iopt->incoherent = false;
>> +
>> +	order = folio_order(folio);
>> +	pgcnt = 1UL << order;
>> +	iommu_folio_update_stats(folio, pgcnt);
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_restore_page);
>> +
>> +/**
>> + * iommu_preserve_pages - Preserve pages during kexec handover
>> + * @list: List of pages to preserve
>> + *
>> + * Returns 0 on success, negative error on failure
>> + */
>> +int iommu_preserve_pages(struct iommu_pages_list *list)
>> +{
>> +	struct ioptdesc *iopt;
>> +	int ret;
>> +
>> +	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
>> +		ret = kho_preserve_folio(ioptdesc_folio(iopt));
>> +		if (ret)
>> +			goto err;
>> +	}
>> +
>> +	return 0;
>> +
>> +err:
>> +	list_for_each_entry_continue_reverse(iopt, &list->pages, iopt_freelist_elm)
>> +		kho_unpreserve_folio(ioptdesc_folio(iopt));
>> +
>
>Looks good.
>
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_preserve_pages);
>> +#endif
>> +
>
>[snip]
>
>> +static inline int iommu_preserve_pages(struct iommu_pages_list *list)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static inline void iommu_unpreserve_pages(struct iommu_pages_list *list, int count)
>
>Nit: This is inconsistent from the signature in it's counter part in
>IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE)

Oh. I will update this in next revision
>
>Let's remove `int count` from the arguments to avoid broken builds.
>
>> +{
>> +}
>> +
>> +static inline void iommu_restore_page(u64 phys)
>> +{
>> +}
>> +#endif
>> +
>
>With that stub argument fixed,
>Reviewed-by: Pranjal Shrivastava praan@google.com

Thanks Pranjal.
>
>Thanks,
>Praan
