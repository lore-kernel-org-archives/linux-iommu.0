Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1443B2F3609
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763983425; cv=none; b=JwUCiX5To/Y6G+AeK13E/A27J50obdLZiR3miocWEtKZIXPMY/0SEVcGVj/1ALDlsb0qoa0juGUT4qn+UpYKlEhNEFvVvZc3XxgTiC+Qlb7lTgythoFczXVlL7zUfPEIJjy452Ijoy6sEr+Nek9MmK0OJVDt25CEHNd/PYSlECc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763983425; c=relaxed/simple;
	bh=bBx2zX4NNXGxJ60W46Gs+T1nncBnetTXvCFoQnu4iCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hxl+lAmmx7Y1ySm4uMXzPH+AM0i29VnAJRonLOtvrw0KkFah1XHr57LKv9synBpnYpUgqf0KbeNSUqxOYdVOp65ke4tFk9I0sgxxvHz1Ya9kqtbvDlI2kRv8h0/RLEkrMr8zfyFNf2ExILRavf685vcInMG0vqkGtN1HsA/sKjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SzwhfDxD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SzwhfDxD"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779a4fb9bfso91805e9.0
        for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 03:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763983422; x=1764588222; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A/9qmpcn6sF8ptPObBDBMptCfIXtJ3l0IrBw1r6Q5lI=;
        b=SzwhfDxDf8Popm53nWX2JQbdXNeUawKrRlvzIeR6ewpBzHtH9+a8bJXEQSf9lMmh+L
         E8IiKdv1EWkdqn4GOA+SefLeHcHbx5ELoWC1zTJxIhcaRYfmGjDrZw8EdeyZk2mYhORo
         vJy02wVCAIfcmF/9iDCDUgu9pawhITZpL+ZyRWJqpA+9PDO7/nK441iJG4Pd1z0NCy2b
         Z0vGju+rBHhe6ZPt7wcrxHsi40oF/iXQciUCvkZKmj5ysjJTbJ3CZfCEKGLnA2t4k19c
         v460NX84St3P+FpeY24+bzFcyVJ6SPJsN/cYGQpwtg6xK1Md13+Sk3JQGt7g3ul2ad+4
         QF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763983422; x=1764588222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/9qmpcn6sF8ptPObBDBMptCfIXtJ3l0IrBw1r6Q5lI=;
        b=QO7KIVtm2J8yHJ0DsMJuimezkLEkyWBt1E4c7OldiRKPDm/hF6LsETBSdjU/0mdpRw
         XYDHs5JqO88SNplQhaa3fTocQVXbQa3C0VuHLRR5VYuXklCV89GubIPd65Qb3Ay/JTo6
         V1vyl6tDKZ9h/D40sj6b+3+F2+IllexHI3ZQlNZVUFXMrC2vi5M72RPGPcTieyECjLPj
         lwm/2Su5PGD4ywNbcR97mw4mQjAFaAOEHNwob1pmYZ/dO9ppGObbChTqD3q7Mk/nIxjE
         zaVsx+V5+w/Xo5kL07wsu5+DMkJKQFliYgJ4LBnmQaJ7Yy6l5G84qoTOQ3Gs13/YxIIx
         xxGA==
X-Forwarded-Encrypted: i=1; AJvYcCXCeCYFRnGRhnETt+PqhZsmYaNp9qFDpPwW6atKf83dUyOYw2FNl09suNcvZpE9g+YP/oWVHA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0fqryJlxRcD7fpmsCNGuUqcz+GGxAVasRXsMbbYRVO5WT28Qo
	0YndLne5mHMONbMjUJQijCjMKAouuvNp+e+1Ew8gqD8LLsWB0xGNPHhEKu9JMSH/og==
X-Gm-Gg: ASbGncsTTJvIuRv/aU7XDQvy+Z5y69waYtNdoB7Rq5/6Sa9pFhy8BMHhMwEUObT2pqv
	Q57i1eoBiK9mtVb2BOG1pKL+Cb1PSS1pke6Xe3oWD3h27LJEwcgm/7aFfYjEiCh3syre41aiLlQ
	WwRSUH6CF82qoGB4MxM1SPjZNKve1qnxl39yko6Ll1gVZO6NLjYPGcmWn2u9xImmuxrdEqjiZ/Y
	V1X2wf07uTbMufrv57Ga2y3cekD5mm+0nzYSxlTT05bKx7hrGWBC3ydyPiOk8rU/CBpgyUoFUM6
	KMPgkTKoPR5/l+/9C9MdNnQJFWIudGhSR8MnMeZ+M6Ru7L7b7Pi6+HMKHd2lPh6JH6IZunywf5s
	CpOqcPReNKH058Mb08LDfCB3sVZZd4oIWXKEh3JroZBR4I+X0//r7KzDM2wGeFWSXSFvS16KjFA
	3TxhFB9Y3i+V95GceTXVJZW+Mi7EvG84U6+6MJOYZA5Dlwijwb7Q==
X-Google-Smtp-Source: AGHT+IHPjRoPkJts63WSW1KmhvXOZnj4KJdKdrrFOfPPYFwb16nEkLhtHX2sQ0Em7vKdjEkEynh8tg==
X-Received: by 2002:a05:600c:3b94:b0:477:1afe:b962 with SMTP id 5b1f17b1804b1-477c5ea32a2mr1726485e9.1.1763983422303;
        Mon, 24 Nov 2025 03:23:42 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf198a67sm200937725e9.0.2025.11.24.03.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 03:23:41 -0800 (PST)
Date: Mon, 24 Nov 2025 11:23:38 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Will Deacon <will@kernel.org>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz,
	surenb@google.com, mhocko@suse.com, jackmanb@google.com,
	hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org, Qinxin Xia <xiaqinxin@huawei.com>
Subject: Re: [PATCH v2 2/4] drivers/iommu: Add calls for IOMMU_DEBUG_PAGEALLOC
Message-ID: <aSRAOv6WqFTxzy_C@google.com>
References: <20251106163953.1971067-1-smostafa@google.com>
 <20251106163953.1971067-3-smostafa@google.com>
 <aRW6P7vhTIZvm2Qf@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRW6P7vhTIZvm2Qf@willie-the-truck>

On Thu, Nov 13, 2025 at 11:00:15AM +0000, Will Deacon wrote:
> On Thu, Nov 06, 2025 at 04:39:51PM +0000, Mostafa Saleh wrote:
> > Add calls for the new iommu debug config IOMMU_DEBUG_PAGEALLOC:
> > - iommu_debug_init: Enable the debug mode if configured by the user.
> > - iommu_debug_map: Track iommu pages mapped, using physical address.
> > - iommu_debug_unmap: Track iommu pages unmapped, using IO virtual
> >   address.
> > - iommu_debug_remap: Track iommu pages, already mapped using IOVA.
> > 
> > We have to do the unmap/remap as once pages are unmapped we lose the
> > information of the physical address.
> > This is racy, but the API is racy by construction as it uses refcounts
> > and doesn't attempt to lock/synchronize with the IOMMU API as that will
> > be costly, meaning that possibility of false negative exists.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > Tested-by: Qinxin Xia <xiaqinxin@huawei.com>
> > ---
> >  drivers/iommu/iommu-debug-pagealloc.c | 23 ++++++++++++
> >  drivers/iommu/iommu.c                 | 14 ++++++-
> >  include/linux/iommu-debug-pagealloc.h | 54 +++++++++++++++++++++++++++
> >  3 files changed, 89 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
> > index 385c8bfae02b..a6a2f844b09d 100644
> > --- a/drivers/iommu/iommu-debug-pagealloc.c
> > +++ b/drivers/iommu/iommu-debug-pagealloc.c
> > @@ -5,11 +5,13 @@
> >   * IOMMU API debug page alloc sanitizer
> >   */
> >  #include <linux/atomic.h>
> > +#include <linux/iommu.h>
> >  #include <linux/iommu-debug-pagealloc.h>
> >  #include <linux/kernel.h>
> >  #include <linux/page_ext.h>
> >  
> >  static bool needed;
> > +DEFINE_STATIC_KEY_FALSE(iommu_debug_initialized);
> >  
> >  struct iommu_debug_metadate {
> >  	atomic_t ref;
> > @@ -25,6 +27,27 @@ struct page_ext_operations page_iommu_debug_ops = {
> >  	.need = need_iommu_debug,
> >  };
> >  
> > +void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t size)
> > +{
> > +}
> > +
> > +void __iommu_debug_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
> > +{
> > +}
> > +
> > +void __iommu_debug_remap(struct iommu_domain *domain, unsigned long iova, size_t size)
> > +{
> > +}
> 
> Since the IOMMU API doesn't really have a "remap" operation, I wonder
> whether it would be clearer to have unmap_begin() and unmap_end()
> functions instead? You'd probably want to call them as a pair, so the
> check for unmapped < size would move into unmap_end().

I guess that would be cleaner, but we have to pass both size and
unmapped to unmap_end, I will give it a try.

Thanks,
Mostafa

> 
> Will
