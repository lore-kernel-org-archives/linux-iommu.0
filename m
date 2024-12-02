Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EE71FE473
	for <iommu@lists.linux.dev>; Mon,  2 Dec 2024 12:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141547; cv=none; b=D2io6dCJS+PG6cADPlAyzXw3e1molGkNaxppVvhphsBa6IYJfrtRox9Za3BYYZtaONJkfq2XzddD+3zjDb+ZUTbR1J/TDfr3bM+wjtnsPuxE8XG95NaWfI913FATlBCykZz+q8n3WNYD0BxSGWW8kTjtQ1fVAonqH3/CiaWWiJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141547; c=relaxed/simple;
	bh=BAsvATPPwiRNshFbfMSazAQL2k/Uitt2kSkENPu+FCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c62KhURbL0Au4fmWAKyEyhzUrsZ8GrU8sTmK38pUrEt/TRdMwHEfUscBrqEvu6ngmpLoDGDMoJYFvJWJLDomi1LE74sLtdYeqyf2oy3H95zBO9ihY8JY81RqrAmAAaA01NWhCKmP0Md5KhIjbvMv9RN9Y/t6KxFF3uS7CvCDJW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TWFyfqOd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TWFyfqOd"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a9f9a225so216615e9.1
        for <iommu@lists.linux.dev>; Mon, 02 Dec 2024 04:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733141542; x=1733746342; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e3OJxeC05OEpKJXaqS/T7FWlvK5y/yJmdvmfj+hUxqc=;
        b=TWFyfqOdFZmt1PBAEE+mOZ1wdHwasQEVCIGjjGt0m5pNjSP66ATJif8BwCMV4kvGP2
         931zKT0Fk2Ht+ugFqkOkzig/M5qCApu2kKiAItVwNvRgnBe4PPjrUG00afAVugNEMLia
         gAM0fnafHU90fFForwZiCvSyFrMI0T1DcTOy0GPpnpDBg6UGgHANBuaE6rEW8wvzVK6G
         zwjX3pIv8CJ1uGsZrURBBFqMjGzmUnaxBTsND12P+2EYx47q+WMR2dB9+OfDcA/MTL4y
         R+Jo32cOx1PpykTAgLcEOxtgjXX4ucKYNa//IYalyPlpnQAuZ7FQ+QxcBek9PkEFcGU0
         4UJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733141542; x=1733746342;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3OJxeC05OEpKJXaqS/T7FWlvK5y/yJmdvmfj+hUxqc=;
        b=iS5n5/HhqcfwHAB+8fllTyT0H1+H2/6mCjuSYmk3zVXSeJgF38VrAeykqVPO7Ms9PU
         dVAgNSLhu4hGtdw04aPM4mfX+5dmGuK86F75gJOeKSLe4IpicXav3bJjIVh0218MufnJ
         vtw3ijGazpRDHWw842Zxngb4NeHMJPO+jSewlO7RkDhnHxvXHOVuem++Hr7t8J9jyXEb
         EJx58QRNFRV/o7B/f67iCqys2hR1+rA7i03Qf227I7ldv6YyeuwCEvEn14VnmclOs09B
         YVvP+ceR4mTDj7uSJipwmVYgnkzFO7XcnYs/EJ7L9CobX1HKWK6oPLAXsW4adzQ/5eoG
         9FGg==
X-Forwarded-Encrypted: i=1; AJvYcCX/yRFF6qkvCDcDK7XX7aUDx36n+2hU6DJc3Llqnq6ruSaAthdYhNVjLll313vIRIfOurQbCA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTTi5xmJ816D6txzGgYAV57SlMd5jV9WUSQtQ3gPmMcrJyHi/M
	Ps26ubIwLTCuyygY47RgiplIbHoUfnmZShHYROL2KpVOi3M4E8q/4pQfQWzrOA==
X-Gm-Gg: ASbGncu88dsANcIVcaneRIwihphR6gbyrRSuYe57gmzjTYzMLu6QTUp/eYGvPzK39pv
	X8+rr9mGUkfV9NxNE824i2Nvt/pebNtvCR4ntHB5I5Wnyc+ELMV/FLmHA638DwNZH1fPavZSG33
	juC3KkW0gMh7Phe/GeUju8t1EI+qnMle4hNP1yZLWMu4C2oO/x33ej0Oh72HJVVM+zudJwWkZc1
	eIvTLF4WXT8nDuPkUys11qhOnGj38h7lCC6w9EbUD92ZiMK3rn8nvjZfdTz+b+SjO8TaE+qzFKQ
	qqYThTEoSx2p
X-Google-Smtp-Source: AGHT+IFWgNWQtw5nySaRT0MW3AbORF9BjBCT5+v/BU5F99S0LZr6LNKr+wPuDHwta/Ys4y0RVWD2ww==
X-Received: by 2002:a05:600c:2253:b0:428:e6eb:1340 with SMTP id 5b1f17b1804b1-434b0577f32mr4477205e9.4.1733141542168;
        Mon, 02 Dec 2024 04:12:22 -0800 (PST)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385deeb6acdsm9806424f8f.81.2024.12.02.04.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 04:12:21 -0800 (PST)
Date: Mon, 2 Dec 2024 12:12:17 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org
Subject: Re: [PATCH 1/2] iommu/io-pgtable-arm: Fix stage-2 map/umap for
 concatenated tables
Message-ID: <Z02kIaxP96am-P2f@google.com>
References: <20241024162516.2005652-1-smostafa@google.com>
 <20241024162516.2005652-2-smostafa@google.com>
 <CAE2F3rDyj8WohXHTa1H3_gqTndyJL3cUEfBnXCEibNo1oYTt3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rDyj8WohXHTa1H3_gqTndyJL3cUEfBnXCEibNo1oYTt3A@mail.gmail.com>

Hi Daniel,

On Sat, Nov 30, 2024 at 08:20:10PM -0800, Daniel Mentz wrote:
> On Thu, Oct 24, 2024 at 9:26 AM Mostafa Saleh <smostafa@google.com> wrote:
> >
> > When calculating the max number of entries in a table, Where
> > RM_LPAE_LVL_IDX() understands the concatenated pgds and can return
> > an index spanning more than one concatenated table (for ex for 4K
> > page size > 512).
> > But then, max_entries is calculated as follows:
> > max_entries = ARM_LPAE_PTES_PER_TABLE(data) - map_idx_start;
> >
> > This leads to a negative index in the page table, where for:
> > - map: do nothing (no OOB) as fortunately all comparisons are signed,
> >   but it would return a negative mapped value.
> >
> > - unmap: it would leak any child tables as it skips the loop over
> >   “__arm_lpae_free_pgtable”
> >
> > This bug only happens when map/unmap is requested with a page size
> > equals to the first level of the concatenated table (for 40 bits input
> > and 4K granule would be 1GB) and can be triggered from userspace with
> > VFIO, by choosing a VM IPA in a concatenated table > 0 and using
> > huge pages to mmap with the first level size.
> >
> > For example, I was able to reproduce it with the following command
> > with mainline linux and mainline kvmtool:
> >
> > ./lkvm run --irqchip gicv3 -k {$KERNEL} -p "earlycon" -d {$ROOTFS}  --force-pci -c \
> > `nproc` --debug -m 4096@525312 --vfio-pci 0000:00:03.0  --hugetlbfs  /hugepages
> >
> > Where huge pages with 1GB would be used and using IPA in the second table
> > (512GB for 40 bits SMMU and 4K granule).
> >
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  drivers/iommu/io-pgtable-arm.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> > index 0e67f1721a3d..3ecbc024e440 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -199,6 +199,17 @@ static phys_addr_t iopte_to_paddr(arm_lpae_iopte pte,
> >         return (paddr | (paddr << (48 - 12))) & (ARM_LPAE_PTE_ADDR_MASK << 4);
> >  }
> >
> > +/*
> > + * Using an index returned from ARM_LPAE_PGD_IDX(), which can point to
> > + * concatenated PGD concatenated, get the max entries of a that table.
> 
> I believe the macro that returns an index is called ARM_LPAE_LVL_IDX
> not ARM_LPAE_PGD_IDX.
> 

Yes, the comment is not quite accurate, although ARM_LPAE_PGD_IDX()
calls ARM_LPAE_PGD_IDX() which is the problem.

Thanks,
Mostafa

> > + */
> > +static inline int arm_lpae_max_entries(int i, struct arm_lpae_io_pgtable *data)
> > +{
> > +       int ptes_per_table = ARM_LPAE_PTES_PER_TABLE(data);
> > +
> > +       return ptes_per_table - (i & (ptes_per_table - 1));
> > +}
> > +
> >  static bool selftest_running = false;
> >
> >  static dma_addr_t __arm_lpae_dma_addr(void *pages)
> > @@ -390,7 +401,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
> >
> >         /* If we can install a leaf entry at this level, then do so */
> >         if (size == block_size) {
> > -               max_entries = ARM_LPAE_PTES_PER_TABLE(data) - map_idx_start;
> > +               max_entries = arm_lpae_max_entries(map_idx_start, data);
> >                 num_entries = min_t(int, pgcount, max_entries);
> >                 ret = arm_lpae_init_pte(data, iova, paddr, prot, lvl, num_entries, ptep);
> >                 if (!ret)
> > @@ -592,7 +603,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
> >
> >         if (size == split_sz) {
> >                 unmap_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
> > -               max_entries = ptes_per_table - unmap_idx_start;
> > +               max_entries = arm_lpae_max_entries(unmap_idx_start, data);
> >                 num_entries = min_t(int, pgcount, max_entries);
> >         }
> >
> > @@ -650,7 +661,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
> >
> >         /* If the size matches this level, we're in the right place */
> >         if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
> > -               max_entries = ARM_LPAE_PTES_PER_TABLE(data) - unmap_idx_start;
> > +               max_entries = arm_lpae_max_entries(unmap_idx_start, data);
> >                 num_entries = min_t(int, pgcount, max_entries);
> >
> >                 /* Find and handle non-leaf entries */
> > --
> > 2.47.0.105.g07ac214952-goog
> >
> >
