Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191943B531B
	for <iommu@lists.linux.dev>; Fri, 20 Mar 2026 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030356; cv=none; b=TuoS8WGMOFiyz27jG/tv63RDavSmsIbZyomlhjImW24T21zU17h+seEqFN5N1TZlBILOe3PEeZvCIYJHX54lXWRrX5wuInMEi/9u0tsSnSArJd2EEnMlxciqBD3H5EN7y6DNtuvmU0ivjHwoM6AGSl8TogdzPM3S3NFB5P+UCY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030356; c=relaxed/simple;
	bh=QS1WWhfnhlxuhnsuWa2H0Rvb7wQFQVJGDESzCKXlKw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYZ2GsxVQWmfTQbpzGhPotbBNoSvBKnkiuypE/0rENyfGp6bekboJcH2YCHavUtj5Ac0/fpufqYRQGWga5Nh8HmoHlj4IGG1RnijcdAI3fUk/gZpYriCRyXolkzf0lAiZCQOAazsAKA18cc38OCEf23FaqdPDafEtXYeRgwCaCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VU8bO6RS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VU8bO6RS"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b052ec7176so8835ad.1
        for <iommu@lists.linux.dev>; Fri, 20 Mar 2026 11:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774030354; x=1774635154; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cLXxR402vA3/2ADlyJ4N6o23ie2gXoPSWXjjE5PFaBA=;
        b=VU8bO6RSTJpElG+O2ycLjQZ+qTp5xdxazeG204pZ8e9s/yhkSPz9Sx+VinyjsuYx3C
         CC2gcmZEbuffhUhH6ylH5efOJ/CvCthpanIc0Ow2QuJaCwOK5RbCvvpEpadwQ+WUN/uf
         7Tp7uISHM9EEct5BNZcM1ewNtFb+8OlWKFEw+F2psnYGFgSQtmYqSLNYvkjk+Zg7apz0
         fqeF0bVhBCEOokSetrOxji7NQlOQilrAD9GlYJkIgdBVvYKPdm2bvV8FUvD8AorINJ1W
         MOdPhxkeipRGc9VUQl2ljgo6vxyQDGn85zRr36gK+L0qq3D+6VTT2i6BMXHEV56tVTbh
         ordw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774030354; x=1774635154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLXxR402vA3/2ADlyJ4N6o23ie2gXoPSWXjjE5PFaBA=;
        b=WFCCvMO5bFIuOi9/Krtf5XgeuIgjhdEsIN18H+2Tl6Gf4KFIG4LwHFtbsMLUVEwaWq
         nR3c0Qi1OvfOOvgbzae6s4+1yuve30F69aHtbxI8TZSntWgw0gt7VA/N9heok2zbY2Gy
         m7qXw1uvcEo3PaPiT+N4HO3pIrk+bqppd4cxnQrsT/NVZjByXcVTuBoBCgTjrKDib6nO
         HnLwW3mEknekJ1i3MsfilmIMdH9ivaCJb5D0jsliY7m4bq9LAsP5f1Rd+d3zXk/XTPFh
         A3tzJsEZBGc9tnn+eyogDJdD2OZkfCSMsLdOJaCvWrIKL0q2OVLFcMqLmcPocPMasqnW
         ZgMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFMKsTMnWB50zNfwkhKbIkwWT9IjWLi7kqlYAjGLdzz7tdXe2T4ilYCz3JRTlEiW0W0a3ZoQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8V1DPo0a5MAewTETPVX8MKv/a5qFYpim6tXFjYKP1U2ACDHae
	bDAikosYdUNEAq1IZT+48IsXb25JEclJgnW+hEfL3EqvzVSAxfGUTB5Mp+6fje03NQ==
X-Gm-Gg: ATEYQzxaBdVAzDHNTJrWL9pkqUmE37dfZtRMesB2aaJ8AYBgM27ySpZ0GqALtYcJeXJ
	rGxbFtXjTEzodn8HjOe2aP3ZsbfjHspIGAxMdVRA2JhLMI6htDmaz5Dy4K9Ax5b/3Web4z9rqrR
	p9FIGH3Nv9+FloB4ArqBJgMbb/BxT7Cgu+TTFEMgoeV3+JwlQsuRCJR8XoiNB9AFLXAJ7jrztmU
	892dlF4J6wx76gNf/iBpqnmbQuMK+CZhWAR8ET3bi16PrvwbKn9sMSm5TiemXQ6qwnyuLSBvHwD
	lH0/oK+Cq2WJ9R1lw4EjI1bG0TNpM4kFfo4VIMWkv2hHNAP194xhb2Y9tF7oYzeTkZeeOSwD4Pd
	OEXYzzMz7JUohOKzka3LSlVMzGnjSzkG+V733ifCtwhiIceG58a9BcjUvc6hie4Qqxdrj8n/Kq2
	VX2JbMzdb1OwjmbXuUMM+p50ETImVIJXg3NrSRCL5wglnsRdKEAnhzEFnrKEqOJRA7065e3ydH
X-Received: by 2002:a17:902:cf45:b0:2b0:5193:1212 with SMTP id d9443c01a7336-2b08b40a7b1mr217595ad.4.1774030353862;
        Fri, 20 Mar 2026 11:12:33 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd36b169esm1069896a91.12.2026.03.20.11.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:12:33 -0700 (PDT)
Date: Fri, 20 Mar 2026 18:12:28 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Ankit Soni <Ankit.Soni@amd.com>, David Woodhouse <dwmw2@infradead.org>, 
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
Subject: Re: [PATCH 04/14] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <ab2KDEatYbSZJVfC@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-5-skhawaja@google.com>
 <d3wmnc43r3mir2emoitj432j3bfdw362dqmkvywa2qvu5tskb4@oqjkseil5i54>
 <af4h6wh75qdvgu27td43ndlxdyb5drq2pf7tssdsln3q5gce6f@6su7ylrgomhz>
 <ab2Dkn605sRbpK5S@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ab2Dkn605sRbpK5S@google.com>

On Fri, Mar 20, 2026 at 05:27:46PM +0000, Pranjal Shrivastava wrote:
>On Tue, Mar 03, 2026 at 06:41:26PM +0000, Samiullah Khawaja wrote:
>> On Tue, Mar 03, 2026 at 04:42:02PM +0000, Ankit Soni wrote:
>> > On Tue, Feb 03, 2026 at 10:09:38PM +0000, Samiullah Khawaja wrote:
>> > > IOMMU pages are allocated/freed using APIs using struct ioptdesc. For
>> > > the proper preservation and restoration of ioptdesc add helper
>> > > functions.
>> > >
>> > > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> > > ---
>> > >  drivers/iommu/iommu-pages.c | 74 +++++++++++++++++++++++++++++++++++++
>> > >  drivers/iommu/iommu-pages.h | 30 +++++++++++++++
>> > >  2 files changed, 104 insertions(+)
>> > >
>> > > diff --git a/drivers/iommu/iommu-pages.c b/drivers/iommu/iommu-pages.c
>> > > index 3bab175d8557..588a8f19b196 100644
>> > > --- a/drivers/iommu/iommu-pages.c
>> > > +++ b/drivers/iommu/iommu-pages.c
>> > > @@ -6,6 +6,7 @@
>> > >  #include "iommu-pages.h"
>> > >  #include <linux/dma-mapping.h>
>> > >  #include <linux/gfp.h>
>> > > +#include <linux/kexec_handover.h>
>> > >  #include <linux/mm.h>
>> > >
>> > >  #define IOPTDESC_MATCH(pg_elm, elm)                    \
>> > > @@ -131,6 +132,79 @@ void iommu_put_pages_list(struct iommu_pages_list *list)
>> > >  }
>> > >  EXPORT_SYMBOL_GPL(iommu_put_pages_list);
>> > >
>> > > +#if IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE)
>> > > +void iommu_unpreserve_page(void *virt)
>> > > +{
>> > > +	kho_unpreserve_folio(ioptdesc_folio(virt_to_ioptdesc(virt)));
>> > > +}
>> > > +EXPORT_SYMBOL_GPL(iommu_unpreserve_page);
>> > > +
>> > > +int iommu_preserve_page(void *virt)
>> > > +{
>> > > +	return kho_preserve_folio(ioptdesc_folio(virt_to_ioptdesc(virt)));
>> > > +}
>> > > +EXPORT_SYMBOL_GPL(iommu_preserve_page);
>> > > +
>> > > +void iommu_unpreserve_pages(struct iommu_pages_list *list, int count)
>> > > +{
>> > > +	struct ioptdesc *iopt;
>> > > +
>> > > +	if (!count)
>> > > +		return;
>> > > +
>> > > +	/* If less than zero then unpreserve all pages. */
>> > > +	if (count < 0)
>> > > +		count = 0;
>> > > +
>> > > +	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
>> > > +		kho_unpreserve_folio(ioptdesc_folio(iopt));
>> > > +		if (count > 0 && --count ==  0)
>> > > +			break;
>> > > +	}
>> > > +}
>> > > +EXPORT_SYMBOL_GPL(iommu_unpreserve_pages);
>> > > +
>> > > +void iommu_restore_page(u64 phys)
>> > > +{
>> > > +	struct ioptdesc *iopt;
>> > > +	struct folio *folio;
>> > > +	unsigned long pgcnt;
>> > > +	unsigned int order;
>> > > +
>> > > +	folio = kho_restore_folio(phys);
>> > > +	BUG_ON(!folio);
>> > > +
>> > > +	iopt = folio_ioptdesc(folio);
>> >
>> > iopt->incoherent = false; should be here?
>> >
>>
>> Yes this should be set here. I will update this.
>
>I'm wondering if we are silently losing state here. What if the
>preserved page was actually incoherent in the previous kernel?
>I understand we likely need to initialize it to false here because we
>don't have a dev pointer for DMA sync operations at this low level (though
>x86 uses clflush).
>
>But when is it set back to "incoherent" again? I don't see that
>happening during the driver re-attach phase?

This can be done during restore_domain as the domain has a reference to
the dev when it is recreated. I will updated the walker and add this in
the next revision.
>
>Should we at least mention that this API intentionally overwrites the
>preserved coherency state and that these pages must explicitly be marked
>incoherent again later by the driver based on its preserved HW state OR
>by the IOMMUFD re-attach?

Agreed. I will add a Note about this.
>
>> > > +
>> > > +	order = folio_order(folio);
>> > > +	pgcnt = 1UL << order;
>> > > +	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, pgcnt);
>> > > +	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, pgcnt);
>> > > +}
>> > > +EXPORT_SYMBOL_GPL(iommu_restore_page);
>
>[------ snip >8 -------]
>
>Thanks,
>Praan

Thanks,
Sami
