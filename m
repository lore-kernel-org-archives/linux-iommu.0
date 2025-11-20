Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3202EBBAA;
	Thu, 20 Nov 2025 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763634937; cv=none; b=ZIVJnVoSzcLfHve2VKpEn9tX88H2uUXogdhTEDBWXndEHXTVTk690YX1vaqSq7S9Y5+tlJpGH4OaEAMyTGetJC4T0LJPEf25HUHtWSaGn/kq9BHKkowBdIIyRKtHLcomR4FDRZSWp1FHS7Ax6Vx0ct+jwfzvMshhp+29S1FMLXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763634937; c=relaxed/simple;
	bh=JhN5ODh4SUzvOgFOKxr7bEcrjPEG8Ip1MG+TWZ4MFBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orFcDb27PNYJMknvjbq0Ni90aFaNOae8dOP5Ob33Hlcvi+KXMBXNJjnfLO0nHFz0U6MeCvLKnbnnZQN6A+PTiyJr6VQzthtmd00G4zWzdsiL8tZdBqU1hNhlvFTCoVI6lpve/wTu3ZZUK/KuTv8/AI6BPFutlSri01vFv6ZQVb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GREW670r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GREW670r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C55C4CEF1;
	Thu, 20 Nov 2025 10:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763634936;
	bh=JhN5ODh4SUzvOgFOKxr7bEcrjPEG8Ip1MG+TWZ4MFBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GREW670rDfQ9BqsGMHJ+jirMkrMenMfQNZHG0Aw/NHasbANFNYEdgTfG+fzjCwSAB
	 WacykwzQR9deDr5K6StoxF/RGXaqCJtkXnVGlKrXt7+vvAKDHpn8YdBryvpPy5E1cl
	 c8bv3go2d/7gGSyFdz5m450iEa1W/02Cm4Hvr2SVlwxke3/dHN4xlamRvNZ83bVT6I
	 OxMuetQkvJOs7eOYOHKkzuzd26tz3ZhUgETW9uVOiw9bThnaNKsBz03ZA0daxzHRfD
	 w6U2lclj+2sp78GVLQuwlCoyW0LoLwrZMI9aSAfx6WJff7kTGz8mby/gE+rwQZxlaw
	 8b1ZFU0/xn6+A==
Date: Thu, 20 Nov 2025 12:35:22 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 6/8] x86/mm: Use pagetable_free()
Message-ID: <aR7u6ukKVM2S7rOX@kernel.org>
References: <20251022082635.2462433-1-baolu.lu@linux.intel.com>
 <20251022082635.2462433-7-baolu.lu@linux.intel.com>
 <aRvWfv_fc60zUK1d@fedora>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRvWfv_fc60zUK1d@fedora>

On Mon, Nov 17, 2025 at 06:14:22PM -0800, Vishal Moola (Oracle) wrote:
> On Wed, Oct 22, 2025 at 04:26:32PM +0800, Lu Baolu wrote:
> > The kernel's memory management subsystem provides a dedicated interface,
> > pagetable_free(), for freeing page table pages. Updates two call sites to
> > use pagetable_free() instead of the lower-level __free_page() or
> > free_pages(). This improves code consistency and clarity, and ensures the
> > correct freeing mechanism is used.
> 
> In doing these ptdesc calls here, we're running into issues with the
> concurrent work around ptdescs: Allocating frozen page tables[1] and
> separately allocating ptdesc[2].
> 
> What we're seeing is attempts to cast a page that has still been
> allocated by the regular page allocator to a ptdesc - which won't work
> anymore.
> 
> My hunch is we want alot of the code in pat/set_memory.c to be using ptdescs
> aka page table descriptors. At least all the allocations/frees for now.
> Does that seem right? I'm not really familiar with this code though...

Yeah, that sounds about right. Allocations in x86::set_memory should use
pXd_alloc_one_kernel()
 
> [1] https://lore.kernel.org/linux-mm/202511172257.ffd96dab-lkp@intel.com/T/#mf68f9c13f4b188eac08ae261c0172afe81a75827
> [2] https://lore.kernel.org/linux-mm/20251020001652.2116669-1-willy@infradead.org/T/#md72f66473e017d6f3ce277405ad115e71898f418
> 
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  arch/x86/mm/init_64.c        | 2 +-
> >  arch/x86/mm/pat/set_memory.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> > index 0e4270e20fad..3d9a5e4ccaa4 100644
> > --- a/arch/x86/mm/init_64.c
> > +++ b/arch/x86/mm/init_64.c
> > @@ -1031,7 +1031,7 @@ static void __meminit free_pagetable(struct page *page, int order)
> >  		free_reserved_pages(page, nr_pages);
> >  #endif
> >  	} else {
> > -		__free_pages(page, order);
> > +		pagetable_free(page_ptdesc(page));
> >  	}
> >  }
> >  
> > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > index 970981893c9b..fffb6ef1997d 100644
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -429,7 +429,7 @@ static void cpa_collapse_large_pages(struct cpa_data *cpa)
> >  
> >  	list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
> >  		list_del(&ptdesc->pt_list);
> > -		__free_page(ptdesc_page(ptdesc));
> > +		pagetable_free(ptdesc);
> >  	}
> >  }
> >  
> > -- 
> > 2.43.0
> > 

-- 
Sincerely yours,
Mike.
