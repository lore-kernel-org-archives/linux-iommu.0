Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732D93E1723
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653569; cv=none; b=iBBC1Lt8PP5Dtikf1OANHLUASvINK5PknmL76cIovP0cqNW1trXKU2lZVDyu6X3+Cpf3/WoDNnoitgpKWK6G041mKYpKPabJEg0WcJGgaY+JDuyd8VSXIuqOdM3NeEEyd2jYgwBZ5/GuJNjrzx1C0YBRPuHiS2VQHVky7vzMhCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653569; c=relaxed/simple;
	bh=4IrHsiAS5RlY/yZO5MU8rItGwplYzpm+UIMFHUYdnGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1YVmHycVU6B42UPDlLBWhZxA7WD3YiZTY9XifQqoViUeuP4XKrh1edw7ca3FR0nWsKBWtKrIgsrSNgX4TgvI7vO1R/5A3Oy4LtF8KY4AaqMn5fVL4eneh9M/OL4sT+edb4Lxl2qUOO0OOd/xpq0zorcW2KBMDnmzDmkERI8v44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaQBdZPG; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaQBdZPG"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38511175ad3so9423216a91.2
        for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 10:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784653567; x=1785258367; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UaZs0dUksz9lWWombvtYA7KfGwaIYElA59FlH0y/uOc=;
        b=UaQBdZPGfKmuxA9qg5qpeeaY7B8drJkDBpUVC+6OEaHdxKmpP43V/f3nQqptgotdII
         Dr2x2mLn6Uz74uiGgm2EMpUJUvZ1jn9AOihi9AKLPwLOOJRzSikguKAmwBp9lGbwJ1H3
         svmpgLeSfysp0Nx6U+LD7u9rZ694bxP6DEmzR8vnIhSfuuxxPo1O5AV2Ey+D7M6U7SHc
         ca7/j4UGByc67dHn6ICBRcc55VmmWNnG6jn25WJrWakDX+aqOYfo5lAPJNTgkfuOPPLd
         uFV/7MGZlnJN1D9MdtoBncH4+LpC0uBtX/9EdLknekUezvwmNybcQjZLzEtN3DZJonqL
         redQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784653567; x=1785258367;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UaZs0dUksz9lWWombvtYA7KfGwaIYElA59FlH0y/uOc=;
        b=aa8djCrxfrjBpn/iJ9tZD6v+PyFbvfoyM5z6qgu+6TU+J2I5EcSXDhoVo6keECxTYn
         zIwfqFCvZIDH3oSTRtIEUjB4hB7ywmBOpJCllijA3OUGGDLlCimgpteZRyn2wXKfuJ7h
         pGKCSMDdF5gl4KS3oT81JbWWsOQjNJ8qIBcOE2X49xSsan5zmjAwdfZZjZnFmTCja1AV
         j19kvs9Zim19rZsNe1ANyH7PFb35+fUo9hez0tdlbsJMha0tfowYE6ruZ1QNfhSkeeJd
         bmFP2fF/dJ2kMTKHDHlly4UW5qE4kqDFP/YE/AhZpjYiR20ZZlDShsorocdcbKe3xitF
         RemQ==
X-Forwarded-Encrypted: i=1; AHgh+RoHq0swv7e9uwrYMT8lB+R1/AMlxNbVD7a+8H98ew0Kex7KszTGgfrHb0MDi3M46URkSMMLhA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwWSfJUK9DfJV1a2Vu60VtlexigUyjCFIl5TdnnSilu+nFq/0jM
	Pyf5lSkFJdpm3PrARZ6asiYZL2RrEWGbbKvi3IVX+bAyDU45t2gTwcJc
X-Gm-Gg: AR+sD12E8gbHYXmw+rRqRFBnHpkWcYk6kKflH1uH/2bEXLm+GPJZyZxBXzPLEgN4r2Z
	BU76tHoaQ763BHmGXH8Guk8UYeeuz3s/SFpOo8iMpqc6kW/owDbfW+9JW0xoSTygoZVOL90Yj53
	zVYy1Ke17y/3jT0kckqqIlK41K01ZahNdQqV7T0ya4Hk1UR6imO5tamhJUTblh6fvp5vgGTEoOF
	VtefHks0t46xa78uYFRhsFVF5c0OSi9IWS/w5JLvrdq8zA3sJoI26obyerY2AxIw/6bGRsDwhDl
	8ITsoYBEPdqH25alXzvW7ME9EvViiQLRp93VsxaZhynj1s1DzmLP5TOVTPDOcUmt4a+tmskGBpD
	aiFTx+rJmfY2Br0DagCaqtF08i8QJFqHvAQN8TsillOZ2wrBSJ6v8qAj6vfxXePvpJk+fC4F31d
	sf9oZqYElonyzLGwRSRZjzPWTICsvcaIqJNw==
X-Received: by 2002:a17:90b:17cc:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-38e4b3dc089mr20506488a91.4.1784653567393;
        Tue, 21 Jul 2026 10:06:07 -0700 (PDT)
Received: from fedora ([2601:644:937c:6c90:6d4e:7b2d:4a39:fb0c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cbb6e8sm39508170c88.9.2026.07.21.10.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:06:06 -0700 (PDT)
Date: Tue, 21 Jul 2026 10:06:03 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Kiryl Shutsemau <kas@kernel.org>,
	iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm/pat: allocate split page tables as kernel page
 tables
Message-ID: <al-m-6iCSScC7M9x@fedora>
References: <20260720-fix-cpa-kernel-pagetables-v1-1-0766e782cefe@kernel.org>
 <al5-fDRStgU6gjk6@fedora>
 <al5_Le9QlD4zlt25@fedora>
 <al8hE_ded6qyWiDv@lucifer>
 <al8_xx_99BjAUn5A@fedora>
 <al9BpTu2ma8GpiPW@lucifer>
 <al9KzIhKXa3PCMqa@kernel.org>
 <al9b5uE-ep9ADtLt@lucifer>
 <al9hMyqpjd4l0Fql@lucifer>
 <al95Y5aXof0ISEkI@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al95Y5aXof0ISEkI@kernel.org>

On Tue, Jul 21, 2026 at 04:51:31PM +0300, Mike Rapoport wrote:
> On Tue, Jul 21, 2026 at 01:09:27PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Tue, Jul 21, 2026 at 01:00:53PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > On Tue, Jul 21, 2026 at 01:32:44PM +0300, Mike Rapoport wrote:
> > > > On Tue, Jul 21, 2026 at 10:58:50AM +0100, Lorenzo Stoakes (ARM) wrote:
> > > > > On Tue, Jul 21, 2026 at 02:45:43AM -0700, Vishal Moola wrote:
> > > > > > >
> > > > > > > Well some kernel page tables are still allocated without ctor (early allocated
> > > > > > > direct map for isntance), and if you did pagetable_dtor_free() it
> > > > > > > unconditionally calls pagetable_dtor().
> > > >
> > > > TBH, I cannot think of a scenario when page tables allocated at boot would
> > > > be collapsed. But surely, checking the page type is safer just in case.
> > >
> > > Yeah nor can to be honest, anything that could be made large in the direct map
> > > would already be large right?
> > >
> > > But it's 'just in case' somebody did something dumb :) Later can maybe make it a
> > > WARN_ON(). But just to fix the proximate issue for now.
> > >
> > > >
> > > > > > > The ptlock_free() and __folio_clear_pgtable() there would be harmelss (no locks
> > > > > > > assigned for kernel page table, and if PG_table never set clearing it is a noop)
> > > > > > > but the lruvec_stat_sub_folio() would cause an unbalanced decrement of
> > > > > > > nr_page_table_pages.
> > > > > >
> > > > > > Gotcha, thanks for the explanation :)
> > > > >
> > > > > No worries, this is subtle stuff with lots of weird gotchas and stuff we need to
> > > > > improve... I seem to have fallen down an unexpected rabbit hole with these fixes
> > > > > :)
> > > > >
> > > > > >
> > > > > > > It sucks, but until everything is updated to call the ctor we have to do it this
> > > > > > > way :>)
> > > > > >
> > > > > > Yeah that makes sense. Although I'd rather see the condition as:
> > > > > > if(PageTable(ptdesc_page(...)))
> > > > > >
> > > > > > We really shouldn't be calling ptdesc_folio() anywhere anymore.
> > > > >
> > > > > I think better for a follow up since the code already uses ptdesc all over the
> > > > > place (fundamental to the approach really, keeping a list of page tables etc.)
> > > > > and this is a fix that needs backporting.
> > > >
> > > > I agree with Vishal that it's better to use page type rather than folio
> > > > type. And it's the same for backporting ;-)
> > >
> > > Ah sorry misunderstood, you mean straight up PageTable(ptdesc_page()), I thought
> > > Vishal was saying we shouldn't be directly referencing ptdesc's at all (which
> > > would be the rework).
> > >
> > > I guess definitionally page tables are never folios. I lazily went with what I
> > > saw elsewhere, my bad :)
> > 
> > Ah yeah I remember now, i saw __pagetable_ctor() dealt with folios:
> > 
> > static inline void __pagetable_ctor(struct ptdesc *ptdesc)
> > {
> > 	struct folio *folio = ptdesc_folio(ptdesc);
> > 
> > 	__folio_set_pgtable(folio);
> > 	lruvec_stat_add_folio(folio, NR_PAGETABLE);
> > }
> > 
> > 
> > And was like 'huh?' (surely definitionally they're _not_ folios) but went with
> > that on that basis.
> 
> I wonder why setting the type is even in ctor rather than in allocation.

Yeah, you're not the only one wondering that ;)

Kevin is actively looking at moving those to the allocation/free site instead[1]!

> > Another place to clean up I guess? (that one _definitely_ is a follow up though
> > ;)
> 
> Yep :)

Yup. It makes most sense to clean those up when we add a per-memdesc
api (i.e. for memcg in this case). I haven't really had the time to work
on those though :/

> > Cheers, Lorenzo
> 
> -- 
> Sincerely yours,
> Mike.

[1] https://lore.kernel.org/linux-mm/20260714-remove_pgtable_cdtor-v1-14-44be8a7685d7@arm.com/
