Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFDF26ED59
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 20:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772050533; cv=none; b=eaftPFDdA96+8VWZRSXqXZiwVvxf1fqaYY0NDd044tcgZkGaK7XZ+WFFVOhoBeZoUfGOasv77RvZpxH9n+gBeOOD6MVOsr6zldyVuMKQ8wcYoXUckuDi7BrW8puUfgJr+SVYCvDN3dD7pi9PkisuFUMJ3l1aSCW/RbA5DpcZmUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772050533; c=relaxed/simple;
	bh=bs36U7Z6zD0Hnagwm/ZqHl1ycDYGkn0uTVkMRoGi2qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A94g6+jC5YmhHpWiYqxdiOJWQhfAgMd2owMTGS72tLZWViGk+xjaglgcNLEtckvO0v4zNXpIekQKPiTEaujDaSeZS5C/dxC75WbeX6xiMYANhPB/050RWnhsUuVn9CUcAm4GVIuhP0i16P0q5UZfEgwk4bvRECYEI8Uqf+d0vMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SPcQJIap; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SPcQJIap"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2adb1c1f9d4so19155ad.0
        for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 12:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772050530; x=1772655330; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4YyrNDRwRzkk9A2IzQ/QDYdpFxKzWLCjN0pyf/juCsM=;
        b=SPcQJIapuRL+ooU9YGcVUVhbRl61gOZrG5ExEmvnDNfkkOhqeEewvQrL3YiLpgXIt3
         Hzsuum2UEyx2K0QWCMvba+izhRblCSiDvtJ/S5LF9o/QOmHkA0OvTbirVgpSMLVJygHe
         RLFxek9gPPivlkX8zA3/nEaXHSiI2MiXigCPdXhiXSB6X7NOvcZX6eOVqREStlOjpaH6
         9bylWt+cge7J+Xu5gqmcanRoECRwkTCMxRX5JlRSdELU9stxGGeIZEib6a+dDVeZqux7
         CshHj+LAWychQw7jMFwLKW2BmQmQT4XSKQWtte8B5K3xljB3svb0fqBp4tBvmyi5UQZK
         N2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772050530; x=1772655330;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4YyrNDRwRzkk9A2IzQ/QDYdpFxKzWLCjN0pyf/juCsM=;
        b=kucSs8zmFHhvgXQkKrouk2cE9OJEL5psOXEuBbjiDWNcC+k5Tgdi0UpmB0FxaDDaU2
         2k55ToRF39NJQDYl/D0/nJRGD5pfSObYjO+D1k/9+vxz/G4NRr2n342Zk6CuD5DlVAk/
         4V06j9U0T9nuAxnrp05+qlmogc3OhzE3xkMEkq2+5Yys+PPeAIQfztJoP039MEq35wc3
         uIkQZJxLTFEabaF3e+/TmI1EFQsl9vWFa9BS3+N0casW2jTD3cTw+eKOACERSGuopByL
         a31aP3RRhadSl9K5xrNrZhLs5l9c7UXtK9sHe908Ldm8TxqECMW28tW23t8kwVn5+1EC
         eiLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvmb4UG3J4Mws200VDjhJn3IogoGmpytxmqDDFoJvHBpEd9I2EA47jFmRjyq/E/Fx5L4cFeA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7IdTkb22FafWVh4Y/VO5HHmCz3kYXB+ppJFsbWX1Ri8NxMZoI
	f/GJSUIbA9B8rrC6XKZ/j3mhjvrl37A9669t4BIInCikWIwMpdCUoVnuF0Da/6DYEQ==
X-Gm-Gg: ATEYQzwxgmt0hYbVArZr7HGY5MD3G2R1NocLrJX5PSwsYCqorff5h4MB2c1z/eHK7wj
	dlJ9Xh5tXHifUVGFHLtkOcJ+AyHRJgu6iu3FGY2WLhOLFViwyjFur6MrLvUJ3sNFLfynhmc7q7Z
	Rq2IU4c7BhX/EIyxvkOXqZPmzMZIpDinVMHL6cnqz60jbXbl28XvF+NsSFXuXdXW3F/SAuT1j8d
	PmFl6VKSlRC++iwCDwB/gGeqbaQAy/jWCeFLSE/2SkfRafodbKT8+MxUAC9t2oawWkgQ0syeIco
	5HGeCjVJesoW2yRu6RRHHKq7eC+sdF+//u9EaOZx+gCtHX9dnLn8m9m2uMMOxlJpxHLeK+7GodJ
	nIQ7LFoIjop3/QZaFvewt+MFtCBw9ZardfbZpJ4Jc/p2eo0PLhbUDZX6CzezX0ZRjRw18l+JUtL
	KSHdbqINCaylOmJcfrF+zbTI/x18y0D8BFhVE4KoSFfpNo2uzW1ybqy2ujYUhN
X-Received: by 2002:a17:903:2a86:b0:29e:27f4:bac0 with SMTP id d9443c01a7336-2adf77c692amr376915ad.16.1772050529556;
        Wed, 25 Feb 2026 12:15:29 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6d5970sm502335ad.80.2026.02.25.12.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 12:15:28 -0800 (PST)
Date: Wed, 25 Feb 2026 20:15:24 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Ashish Mhetre <amhetre@nvidia.com>, robin.murphy@arm.com,
	joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH RFC] iommu/dma: Validate page before accessing P2PDMA
 state
Message-ID: <aZ9YXDleB5XyC7zt@google.com>
References: <20260224104257.1641429-1-amhetre@nvidia.com>
 <20260224123221.GM10607@unreal>
 <aZ4Q1HA9q1ojsVYY@google.com>
 <20260225075000.GA9541@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260225075000.GA9541@unreal>

On Wed, Feb 25, 2026 at 09:50:00AM +0200, Leon Romanovsky wrote:
> On Tue, Feb 24, 2026 at 08:57:56PM +0000, Pranjal Shrivastava wrote:
> > On Tue, Feb 24, 2026 at 02:32:21PM +0200, Leon Romanovsky wrote:
> > > On Tue, Feb 24, 2026 at 10:42:57AM +0000, Ashish Mhetre wrote:
> > > > When mapping scatter-gather entries that reference reserved
> > > > memory regions without struct page backing (e.g., bootloader created
> > > > carveouts), is_pci_p2pdma_page() dereferences the page pointer
> > > > returned by sg_page() without first verifying its validity.
> > > 
> > > I believe this behavior started after commit 88df6ab2f34b  
> > > ("mm: add folio_is_pci_p2pdma()"). Prior to that change, the
> > > is_zone_device_page(page) check would return false when given a
> > > non‑existent page pointer.
> > > 
> > 
> > Doesn't folio_is_pci_p2pdma() also check for zone device?
> > I see[1] that it does:
> > 
> > static inline bool folio_is_pci_p2pdma(const struct folio *folio)
> > {
> > 	return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
> > 		folio_is_zone_device(folio) &&
> > 		folio->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
> > }
> > 
> > I believe the problem arises due to the page_folio() call in
> > folio_is_pci_p2pdma(page_folio(page)); within is_pci_p2pdma_page().
> > page_folio() assumes it has a valid struct page to work with. For these
> > carveouts, that isn't true.
> 
> Yes, i came to the same conclusion, just explained why it worked before.
> 

Ack.

> > 
> > Potentially something like the following would stop the crash:
> > 
> > diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> > index e3c2ccf872a8..e47876021afa 100644
> > --- a/include/linux/memremap.h
> > +++ b/include/linux/memremap.h
> > @@ -197,7 +197,8 @@ static inline void folio_set_zone_device_data(struct folio *folio, void *data)
> > 
> >  static inline bool is_pci_p2pdma_page(const struct page *page)
> >  {
> > -       return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
> > +       return IS_ENABLED(CONFIG_PCI_P2PDMA) && page &&
> > +               pfn_valid(page_to_pfn(page)) &&
> 
> pfn_valid() is a relatively expensive function [1] to invoke in the data path,
> and is_pci_p2pdma_page() ends up being called in these execution flows.
> 

Right, that makes sense. Ideally, it shouldn't be there at either of the
places (iommu_dma_map_sg or is_pci_p2pdma_page()).

> [1] https://elixir.bootlin.com/linux/v6.19.3/source/include/linux/mmzone.h#L2167
> 
> >                 folio_is_pci_p2pdma(page_folio(page));
> >  }
> > 
> > 
> > But my broader question is: why are we calling a page-based API like 
> > is_pci_p2pdma_page() on non-struct-page memory in the first place?
> 
> +1
> 
> > Could we instead add a helper to verify if the sg_page() return value
> > is actually backed by a struct page?
> 
> According to the SG design, callers should store only struct page pointers.
> There is one known user that violates this requirement: dmabuf, which is
> gradually being migrated away from this behavior [2].
> 
> [2] https://lore.kernel.org/all/0-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com/
> 
> > If it isn't, we should arguably skip the P2PDMA logic entirely and fall
> > back to a dma_map_phys style path. Isn't handling these "pageless" physical
> > ranges the primary reason dma_map_phys exists?
> 
> Right. dma_map_sg() is indeed the wrong API to use for memory that is not
> backed by struct page pointers.
> 
> Thanks
> 

[--->8---]

Thanks,
Praan

