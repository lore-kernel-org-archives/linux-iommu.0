Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D8219E0;
	Mon, 16 Sep 2024 20:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726517961; cv=none; b=pnKTTJ4fo1ib0L9fkVn0XJfmzbZpA3pcvI6YztwBD6I27ngZ9i7iNzd2S8SMB7oX3P1HDz3FAyP1wEZkSWtptUvtIVi5f3YPlxVc2ssi8PYLwlPEnR1ayqVPu7XIrYE5wGtnnWUSswZ0noPF6LQ/NvAbwSO+VBSpxBMfMxAjh+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726517961; c=relaxed/simple;
	bh=9oMaMq4JbZsi++uRLE3HEFiboWVRs8H6S6Ee3vyo6ng=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dQU8inTOvZUp/vO9YXts0SNk6WKwxpC/k0NrS1JlrHSg350Awu+Uat8MYGFXLtczLNMGwvxWqIsi3gCkFQme13u0HFVnUJOgDkdUcy/ovopwqb/DWv/kztPJ8TlL6c0TZF3L8yJ4Sr0kTrOAjrJ0THGj61px8vZEA4LJkP+hpI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVRbnsjG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVRbnsjG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424B0C4CEC4;
	Mon, 16 Sep 2024 20:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726517961;
	bh=9oMaMq4JbZsi++uRLE3HEFiboWVRs8H6S6Ee3vyo6ng=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=OVRbnsjGRZj8KqNu89ASxv0qzGUd9UE5Dp9vi8lPma+XdHFJkEPelDXGH8UNAlznc
	 thtUhqQsdlXK3g3yp1Waccqz+51v9KT0/0AVS8mQ1sNUd8HSJo8yPWk1wpTS2uz7zJ
	 syMMFZhsOQGUDS8vBv3FEk/8xhwqyXxCNQpne0m3ZUDNSyVQi1uv519yL1jzN/8Mjh
	 yPVKPcKVE2UtuipCI8E0IrMOmMDs+0IJlxTU14E9G/bpe1eeOUxQAFOlsTapFnYYaX
	 0y43AzcGbNbDHtk6D21hPFGRWkZwh4Ju8AtDslfHOykOFyCkUKJ9tgychqJQKMV/X+
	 6KsiKvkorXsBw==
Date: Mon, 16 Sep 2024 13:19:18 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Juergen Gross <jgross@suse.com>
cc: Jan Beulich <jbeulich@suse.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, 
    iommu@lists.linux.dev
Subject: Re: [PATCH v2 1/2] xen/swiotlb: add alignment check for dma
 buffers
In-Reply-To: <8866f8a6-e42c-47d2-af6f-c4bdda5a358f@suse.com>
Message-ID: <alpine.DEB.2.22.394.2409161312000.1417852@ubuntu-linux-20-04-desktop>
References: <20240916064748.18071-1-jgross@suse.com> <20240916064748.18071-2-jgross@suse.com> <d23c9af4-4a79-4300-891a-fba3ea9cbb1c@suse.com> <c2dd89b4-46c7-4a0a-a47b-70862294176b@suse.com> <8866f8a6-e42c-47d2-af6f-c4bdda5a358f@suse.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1816907758-1726517960=:1417852"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1816907758-1726517960=:1417852
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 16 Sep 2024, Juergen Gross wrote:
> On 16.09.24 08:56, Juergen Gross wrote:
> > On 16.09.24 08:50, Jan Beulich wrote:
> > > On 16.09.2024 08:47, Juergen Gross wrote:
> > > > --- a/drivers/xen/swiotlb-xen.c
> > > > +++ b/drivers/xen/swiotlb-xen.c
> > > > @@ -78,9 +78,15 @@ static inline int
> > > > range_straddles_page_boundary(phys_addr_t p, size_t size)
> > > >   {
> > > >       unsigned long next_bfn, xen_pfn = XEN_PFN_DOWN(p);
> > > >       unsigned int i, nr_pages = XEN_PFN_UP(xen_offset_in_page(p) +
> > > > size);
> > > > +    phys_addr_t algn = 1ULL << (get_order(size) + PAGE_SHIFT);
> > > >       next_bfn = pfn_to_bfn(xen_pfn);
> > > > +    /* If buffer is physically aligned, ensure DMA alignment. */
> > > > +    if (IS_ALIGNED(p, algn) &&
> > > > +        !IS_ALIGNED(next_bfn << XEN_PAGE_SHIFT, algn))
> > > 
> > > And this shift is not at risk of losing bits on Arm LPAE?
> > 
> > For alignment check this just doesn't matter (assuming XEN_PAGE_SIZE is
> > smaller than 4G).
> 
> Wait, that was nonsense.
> 
> I'll change the check to:
> 
> 	!IS_ALIGNED((phys_addr_t)next_bfn << XEN_PAGE_SHIFT, algn)

With this change:

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

--8323329-1816907758-1726517960=:1417852--
