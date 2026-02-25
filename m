Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AFD311955
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772050296; cv=none; b=CNFdjw3EdUvd20Tai72+ZHwjROC6Rhc1BYY3SLgS7kjayr4YxTsZU482GKP/T8jFSsq9edk7bkrHZ6cvCzAXglZ5zdsfYNqatV8ID/ZyMAIEPDgVizfKxoMmqz4/lJxCBQBhZpyxg3uhjZ0Cmf8jSpkKeHvXrTabb9w2YyT+5yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772050296; c=relaxed/simple;
	bh=em9/pmP4Zil+1qgnj07w3eGPsU3yjMUlhqOHzAdRYoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsqEsHeSFA9Ey+yw8J1flpOdXvSb77Q3qxPnquKr4D3a+Nkw03pXKu2JA/yaoKgvS2f/Zj9PX3zjbOhN18KDm/M0PQYA2rET67CPpyg+qN+tTMOAjIUpkV6HMP2QNouR1Ofnh5n/S597SAdrSHP1VY66CbP2siQNtMq0ZwGlzBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n4dppQfo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n4dppQfo"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2adb1c1f9d4so18825ad.0
        for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 12:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772050295; x=1772655095; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2MWFdKV7J70WVUzusLdwzbROOrIDq84oPID02+MRug4=;
        b=n4dppQfoVMs0pY3EA6MFgalo+E4YUAIPAmdQtFn4MvVuEwkm89Cki/mWAsjG7z8Aen
         poefMUpirtxjPzQ2wY52FYFCc6z+SJMBlV3TeVutbjxu8MTRBmXxxxCY4mrzfMH4AH/Z
         rzHT9tD6Q7czPRECIgq0B5htAHWvBgSjvcMrK2/OI5TLuXIegx71EAPRItIQ7LIltyuH
         d6QjDoWrKXGmWiS1c4bbcNuVHNe8Ts7+AuzHPSHgjKmaKsi3DpXmB39pTN1jb2RgXrp6
         hMVODYoCNMxKN3fVnrhR+84OqfA+N5nma85UcPnkdnyf462BH4iyUMQlIP3JoFcjpTRt
         sosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772050295; x=1772655095;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2MWFdKV7J70WVUzusLdwzbROOrIDq84oPID02+MRug4=;
        b=h1ehF1EnmpgAzyPdGwWM+y2zP6604EazUGVxft1iZOoJCcpJU7DD8sfr2MsIScz5hw
         vSq5xlquGN8DdH/bfKP6eRbt0VAcYytDTuh7fj993IZQC6kHn2Xqw3lR3mgVPaKIrzbX
         l6uBMSMPHk036Ss2Db3qr303KinxcgIfE2+z+lmdOsjdzml3I1fMfDO9/Q/ZlQVquxIs
         jPyEXBaJXqMqjm0P9DWfIuhXvRT7Hdp0zaMHu1KMo+kTIdj/ybhtFavXeIRImgustZ8n
         nHolqNI5SOea9VepAQTRcPYibMDwpTgqMeXunLCsDKfTNKiDYEXECZxHTwZPgW7oXYTW
         uyZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9vR6R/bYFAABY9/Pg1783NBxd/IKNDmcwV+x1WbCR1TLuIIFppfQGi3h8xkqNxFncyCQguw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGmbPLH03Zp4Kf62QcuKc6Bk6X3oCQTlfTSIOhkVEiZJB9X0vT
	/7SaApcnDnKDNEDZkLSRiAs3nke7Nyod9EUM0+3sRm7SvR80VHJBwWKZwOH47CArMD3srLCcyrA
	bgO+luA==
X-Gm-Gg: ATEYQzzVZ5OnjljIvEI07YGoIGSceWjcL+zzZInMZyzFx6dZgFkQell6AMKViRiE0nn
	TiwHnYijbijudJm0uadSvKHvlV9uNkGZlSkqVpCWwW9C86VoQELxq07sBTJHLXeP/oTXcOsVkBh
	4ttSAVFIA6vXJUMzQ4sBJEMJ1RqNKZRQexj96komW5oYq+h5N5Xy1SCLg9k5BYtl9iIXevvvEMG
	yS/OCE8ziu2DocFYO2rT0HPoW1/z3LfMVfE60oSDqkEJcS2m/j3tBa9YLoHiqXwuIoYfDdVPWq9
	EJ3rCOGM7xG69nrfq5cSSs3r64/nYP7OECwiYI3pJV6fxs0CiY5dZLasMarkbR/RF4qtTSlYYIe
	m3GaKC5Y0PsGcqfHkLbRjRscf68Plw7GoFrgSyC9C1vvga4wO3TGmHG0I9YmwGqe5Cd/QEQ/rth
	zhD+i0EysK+OELHWVRGGwR06MxeIbaNqJklpiWvm6Lf6SfunYs41AaALjZIAdc
X-Received: by 2002:a17:902:b688:b0:2a3:ccfa:c41f with SMTP id d9443c01a7336-2adf783d909mr135475ad.1.1772050294261;
        Wed, 25 Feb 2026 12:11:34 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3590203d3edsm3860787a91.9.2026.02.25.12.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 12:11:33 -0800 (PST)
Date: Wed, 25 Feb 2026 20:11:29 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Ashish Mhetre <amhetre@nvidia.com>, robin.murphy@arm.com,
	joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH RFC] iommu/dma: Validate page before accessing P2PDMA
 state
Message-ID: <aZ9Xccnn7JOikudb@google.com>
References: <20260224104257.1641429-1-amhetre@nvidia.com>
 <20260224123221.GM10607@unreal>
 <aZ4Q1HA9q1ojsVYY@google.com>
 <9d01b4e3-be5b-4c9c-8088-1d10f67f1fd8@nvidia.com>
 <20260225075609.GB9541@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260225075609.GB9541@unreal>

On Wed, Feb 25, 2026 at 09:56:09AM +0200, Leon Romanovsky wrote:
> On Wed, Feb 25, 2026 at 10:19:41AM +0530, Ashish Mhetre wrote:
> > 
> > 
> > On 2/25/2026 2:27 AM, Pranjal Shrivastava wrote:
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > On Tue, Feb 24, 2026 at 02:32:21PM +0200, Leon Romanovsky wrote:
> > > > On Tue, Feb 24, 2026 at 10:42:57AM +0000, Ashish Mhetre wrote:
> > > > > When mapping scatter-gather entries that reference reserved
> > > > > memory regions without struct page backing (e.g., bootloader created
> > > > > carveouts), is_pci_p2pdma_page() dereferences the page pointer
> > > > > returned by sg_page() without first verifying its validity.
> > > > I believe this behavior started after commit 88df6ab2f34b
> > > > ("mm: add folio_is_pci_p2pdma()"). Prior to that change, the
> > > > is_zone_device_page(page) check would return false when given a
> > > > non‑existent page pointer.
> > > > 
> > 
> > Thanks Leon for the review. This crash started after commit 30280eee2db1
> > ("iommu/dma: support PCI P2PDMA pages in dma-iommu map_sg").
> > 
> > > Doesn't folio_is_pci_p2pdma() also check for zone device?
> > > I see[1] that it does:
> > > 
> > > static inline bool folio_is_pci_p2pdma(const struct folio *folio)
> > > {
> > >          return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
> > >                  folio_is_zone_device(folio) &&
> > >                  folio->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
> > > }
> > > 
> > > I believe the problem arises due to the page_folio() call in
> > > folio_is_pci_p2pdma(page_folio(page)); within is_pci_p2pdma_page().
> > > page_folio() assumes it has a valid struct page to work with. For these
> > > carveouts, that isn't true.
> > > 
> > > Potentially something like the following would stop the crash:
> > > 
> > > diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> > > index e3c2ccf872a8..e47876021afa 100644
> > > --- a/include/linux/memremap.h
> > > +++ b/include/linux/memremap.h
> > > @@ -197,7 +197,8 @@ static inline void folio_set_zone_device_data(struct folio *folio, void *data)
> > > 
> > >   static inline bool is_pci_p2pdma_page(const struct page *page)
> > >   {
> > > -       return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
> > > +       return IS_ENABLED(CONFIG_PCI_P2PDMA) && page &&
> > > +               pfn_valid(page_to_pfn(page)) &&
> > >                  folio_is_pci_p2pdma(page_folio(page));
> > >   }
> > > 
> > 
> > Yes, this will also fix the crash.
> > 
> > > But my broader question is: why are we calling a page-based API like
> > > is_pci_p2pdma_page() on non-struct-page memory in the first place?
> > > Could we instead add a helper to verify if the sg_page() return value
> > > is actually backed by a struct page? If it isn't, we should arguably
> > > skip the P2PDMA logic entirely and fall back to a dma_map_phys style
> > > path. Isn't handling these "pageless" physical ranges the primary reason
> > > dma_map_phys exists?
> > 
> > Thanks for the feedback, Pranjal.
> > 
> > To clarify: are you suggesting we handle non-page-backed mappings inside
> > iommu_dma_map_sg (within dma-iommu), or that callers should detect
> > non-page-backed memory and use dma_map_phys instead of dma_map_sg?
> 
> The latter one.
> 

Yup, I meant the latter.

> > Former approach sounds better so that existing iommu_dma_map_sg callers
> > don't need changes, but I'd like to confirm your preference.
> 
> The bug is in callers which used wrong API, they need to be adapted.

Yes, the thing is, if the caller already knows that the region to be
mapped is NOT struct page-backed, then why does it use dma_map_sg
variants?

Thanks
Praan
