Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4E33806A2
	for <iommu@lists.linux.dev>; Fri, 20 Mar 2026 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774004497; cv=none; b=O2Gilj+T06MM0YXIQK3LonsCm7u/zrTk1sKeG8sVBGc5NYDO6CsgXzEtlCKwbcH5ZNzh20M9xUXyjWFPxXFWXap43EYADGnwsnA+/Ea1ytL3aVq+760VOl9qZ8gAEbGCJXPDe7p5TUIWkieU93SyhDf3lmKan+BXj4woEcgOpDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774004497; c=relaxed/simple;
	bh=I+b2MfTUl9PUVONvxyAi7SYFGR42FhHD/i4tetAjZ5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBBfV8hHspl/UCx6J0njSPYCKYTaHwSlRTKVjQYRWLBTM3XAB8x188K8S7wK/6CrZ7fshgvmdx2GrYiM6j86m4x5+cgTj4HBCJQ11Nz3a+GMoEN8yu9vQE66KKPIGQYmKOfpufm7Ii2w7qCFTGo/f7uKN1zmfpFMYT+6NAXCzSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wn3QZpQ+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wn3QZpQ+"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aeab6ff148so60895ad.1
        for <iommu@lists.linux.dev>; Fri, 20 Mar 2026 04:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774004496; x=1774609296; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u4IpdhMaTzIZMDXUfszWTAYV9iBNtcbdIph6j1hYbzE=;
        b=Wn3QZpQ+OsnSJGeotHHncXWlYLWQ9hl3KvhkvUIW8P2FzxtJ99D036CIvHlDA6y3Ob
         B/YI7UMaxe/OBm8T6eZOvNJv8fl9ar3CIqstkIE7EYn7cuNjh4YIw6U9NY5tObLs5SvQ
         xlPskEJEjkCsPvt+HVUVnYF1akfdpE3mDmw37dXnlQ7WENpBVUKvYUuLbzgmVDBJF+0l
         52t1ul+bfr20tz//vYK8cwKWq4VlVoOGTEFqP5Q0wFj/opR5W0BW3uJN9DE7ZXWpMDqX
         13R5RmWOfLNvYOVrxY730UdD3EemkUtXwL/m6Ax9X87lhdLuH5MR284CkLC7f4IrpDME
         oGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774004496; x=1774609296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4IpdhMaTzIZMDXUfszWTAYV9iBNtcbdIph6j1hYbzE=;
        b=rjcd2cBqj2HZY+KGMhrtTfYs+BbPFLSo9Pza0nCm4a7+4N5oOitPhW6FPLJQ7M/5SI
         f+XIcBX7iBEwQzMBmqV14IS3cpj7dwSQHNoO67D5xb0/v04wXr6Jw0wJVfRZwF4D/eBE
         zzJwCSILFvQoQrgnq/1qonojmLD7BZIJZQXZL/OaZSrgMYB89DC/20oZ1g88igP7iM4w
         qM6AOuLRc3VBQidt2vOh9ixsKjWwj1PbTqOkjDW/K8TXYx4vZpOTyUXfffiYIWvbCAhZ
         AaWr/vS/k+p/oFYUbFsF4TqWtduH6WPd2J5mA0oMRyARBbVfUuNowYshbiJpCZMVyWRQ
         Xaiw==
X-Forwarded-Encrypted: i=1; AJvYcCUKsE6fohUfQE52MhSFE67k0vCP8C37aOD47rj2Imi0Q2/5Tmb+xotuzOYRCy4Tqc/btQVg5w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwObtsEwYg9FYLKB59lxqfyHsnIXTt7TPOqS5Wbu1PJQtqP3AgA
	8xN61xK7qcKSjk4GzyiFwH+m2rBMoPG0OzbAXCEQzah4WaDw6MCFLD+pHL1Pgthkdw==
X-Gm-Gg: ATEYQzxf7UWE5sYVVctcftcd+dRSkUcgis/yP0FJ2gBntXMjyq5UjMMTQkaz1fR7yqp
	bSWplFd4+I/qMyV2idv1ibkfELmRlwYvInPoLydb0at4NMKy6OSkdRgMvxpTGOyeKKPXhnClrAY
	9oJuxRDL6Z9xYQOb/GbarsqZf5hSl7yFTxpttROUGASgPerrF6ijgfzAIn3sSdbm1ZWXJkDd5MN
	rdG8mmf3iXQSqp3zK+KtC+q1u/RsNW6BDKZcgoK6kfMel/tBKzR2oXkqGMKvMi/PdI5/mjyYIzE
	jYxGeRWS7jwEK51oTg3mNeHNZhPHWImTjPl1Ikcky0dUIuvz/Ngfckha0RLiFLlx0cJmY/g+eQ1
	U60y6Ek1lEjgC9bBsmSU4XAJGVkOUR6xTAqAlHPQf9/PXggpcBiy5jRiqNqQWxcg0JVvIPHecvx
	sqJ8CwB9eEMaiLA1Ufw5DgRR5vXb2Es0BInzlSDxLt5uhNNYA265wYhjy0oW9t+YwB3xZL
X-Received: by 2002:a17:902:f68b:b0:2b0:7a9b:82f3 with SMTP id d9443c01a7336-2b0828558dbmr2679785ad.8.1774004495106;
        Fri, 20 Mar 2026 04:01:35 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0410b1bdsm2240439b3a.57.2026.03.20.04.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 04:01:34 -0700 (PDT)
Date: Fri, 20 Mar 2026 11:01:25 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
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
	Chris Li <chrisl@kernel.org>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 04/14] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <ab0pBc2-Yr7qo-2G@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-5-skhawaja@google.com>
 <20260317202925.GA2582517.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317202925.GA2582517.vipinsh@google.com>

On Tue, Mar 17, 2026 at 01:59:03PM -0700, Vipin Sharma wrote:
> On Tue, Feb 03, 2026 at 10:09:38PM +0000, Samiullah Khawaja wrote:
> > +

[------- snip >8 --------]

> > +EXPORT_SYMBOL_GPL(iommu_unpreserve_pages);
> > +
> > +void iommu_restore_page(u64 phys)
> > +{
> > +	struct ioptdesc *iopt;
> > +	struct folio *folio;
> > +	unsigned long pgcnt;
> > +	unsigned int order;
> > +
> > +	folio = kho_restore_folio(phys);
> > +	BUG_ON(!folio);
> > +
> > +	iopt = folio_ioptdesc(folio);
> > +
> > +	order = folio_order(folio);
> > +	pgcnt = 1UL << order;
> > +	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, pgcnt);
> > +	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, pgcnt);
> 
> Above two functions are also used in other two places in this file, lets
> create a common function for these two operations.
> 

I was thinking about this, out of the 2 other places one is 
`__iommu_free_desc` where we are supposed to subtract pgcnt.. but I
think we can follow the -pgcnt pattern we have currently and add a
helper `iommu_folio_update_stats(folio, pgcnt)` where we can pass -pgcnt
to subtract nr_pages? Something like:

+static inline void iommu_folio_update_stats(struct folio *folio, long nr_pages)
+{
+	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, nr_pages);
+	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, nr_pages);
+}

@@ -86,8 +91,7 @@ static void __iommu_free_desc(struct ioptdesc *iopt)
 	if (IOMMU_PAGES_USE_DMA_API)
 		WARN_ON_ONCE(iopt->incoherent);

-	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, -pgcnt);
-	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, -pgcnt);
+	iommu_folio_update_stats(folio, -(long)pgcnt);
 	folio_put(folio);
 }

But I'm unsure if passing -(long)pgcnt is a good idea?

> > +}
> > +EXPORT_SYMBOL_GPL(iommu_restore_page);
> > +

Thanks,
Praan
