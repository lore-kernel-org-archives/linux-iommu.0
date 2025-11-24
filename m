Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DBC29A322;
	Mon, 24 Nov 2025 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763998554; cv=none; b=JOZ27lomH73Y4s6lMlkEtSPjIT186DhP5wf26BixJrD/532neAuNl57I3jONxo2wvsZER/sw6Au3nlEfHP6/QJy2CJlhSSCzTIGoEdEq2CQl+eSzZguJ8p4FlKQtS/sUz5wvu4BvMUNqkQk+SauRKVDI9ysgTgREzkUkUJVPnfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763998554; c=relaxed/simple;
	bh=7VZeXfp6ZIRCC08fnhWtDnsbWcV7AvyrY5shwTqTDd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7IZEmlXL80sdYAbsmsH290EsU0upUsqROl6afP8Jx+ooA6dpgcEb/1KZNW84m72n7RA058kYeHsttlboORc+8/hwCai7EAQCRGfycg/1g6xXGKRBE5j952zm/Y76c+mO9UuFa+sjkzZ+BIRrmeSvx1iRpJZ+P7FDgGl7BDoH/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmjEetKU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmjEetKU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C384C4CEF1;
	Mon, 24 Nov 2025 15:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763998554;
	bh=7VZeXfp6ZIRCC08fnhWtDnsbWcV7AvyrY5shwTqTDd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UmjEetKUsP8vTi2+W9Jpienz7MdX9ymF4BAXdAIA5wp7OWWquN8S4o6M25N3aBP3j
	 m16mRE5WLVsqyUxNOfcEDQJJv3+ljpL42Mv7HVj30PFQEjGmBIvoBphSk/QhY6/gp9
	 tGZeXkz8UrIatNiVl+kFUo3CejtmPvWFcGyzUzXKI07aVx/WWx5pM4GkEfIUbHoDPV
	 RmbYrnIQBRpy1LYlsd8wVSL3Gh6jVK/FGYJMm6aC43B57l486Pu0aWOH4MB4X+sGD2
	 Ff91CMw3oECCDzLPmFB6ZOEFQiZ8plV/7laYbywsn/2TEMD2BGZET3yxeSSCDFsOZK
	 tugDPAzLiRYRw==
Date: Mon, 24 Nov 2025 15:35:47 +0000
From: Will Deacon <will@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz,
	surenb@google.com, mhocko@suse.com, jackmanb@google.com,
	hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org, Qinxin Xia <xiaqinxin@huawei.com>
Subject: Re: [PATCH v2 3/4] drivers/iommu-debug-pagealloc: Track IOMMU pages
Message-ID: <aSR7U4pI_mYryFzh@willie-the-truck>
References: <20251106163953.1971067-1-smostafa@google.com>
 <20251106163953.1971067-4-smostafa@google.com>
 <aRW6Tf_G2ObR__vE@willie-the-truck>
 <aSRRizzS39jI3BjH@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aSRRizzS39jI3BjH@google.com>

On Mon, Nov 24, 2025 at 12:37:31PM +0000, Mostafa Saleh wrote:
> On Thu, Nov 13, 2025 at 11:00:29AM +0000, Will Deacon wrote:
> > On Thu, Nov 06, 2025 at 04:39:52PM +0000, Mostafa Saleh wrote:
> > > Using the new calls, use an atomic refcount to track how many times
> > > a page is mapped in any of the IOMMUs.
> > > 
> > > For unmap we need to use iova_to_phys() to get the physical address
> > > of the pages.
> > > 
> > > We use the smallest supported page size as the granularity of tracking
> > > per domain.
> > > This is important as it possible to map pages and unmap them with
> > > larger sizes (as in map_sg()) cases.
> > > 
> > > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > > Tested-by: Qinxin Xia <xiaqinxin@huawei.com>
> > > ---
> > >  drivers/iommu/iommu-debug-pagealloc.c | 74 +++++++++++++++++++++++++++
> > >  1 file changed, 74 insertions(+)
> > > 
> > > diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
> > > index a6a2f844b09d..0e14104b971c 100644
> > > --- a/drivers/iommu/iommu-debug-pagealloc.c
> > > +++ b/drivers/iommu/iommu-debug-pagealloc.c
> > > @@ -27,16 +27,90 @@ struct page_ext_operations page_iommu_debug_ops = {
> > >  	.need = need_iommu_debug,
> > >  };
> > >  
> > > +static struct page_ext *get_iommu_page_ext(phys_addr_t phys)
> > > +{
> > > +	struct page *page = phys_to_page(phys);
> > > +	struct page_ext *page_ext = page_ext_get(page);
> > > +
> > > +	return page_ext;
> > > +}
> > > +
> > > +static struct iommu_debug_metadate *get_iommu_data(struct page_ext *page_ext)
> > > +{
> > > +	return page_ext_data(page_ext, &page_iommu_debug_ops);
> > > +}
> > > +
> > > +static void iommu_debug_inc_page(phys_addr_t phys)
> > > +{
> > > +	struct page_ext *page_ext = get_iommu_page_ext(phys);
> > > +	struct iommu_debug_metadate *d = get_iommu_data(page_ext);
> > > +
> > > +	WARN_ON(atomic_inc_return(&d->ref) <= 0);
> > 
> > Is it worth dumping some information about the page in addition to the
> > WARN_ON()? That way, you might be able to benefit from other debug
> > options (e.g. PAGE_OWNER) if they are enabled.
> 
> These WARN_ON are for overflows, which should never happen.
> I initially thought about using the refcount_t, but it didn’t seem
> suitable as refcount_add() expects that the refcount is already “1”
> indicating that an object was already created which doesn’t fit
> in the semantics of what this is. Similar for refcount_dec().
> 
> In the next patch there is a WARN_ON for the refcount check
> to capture the mis-behaving context, I will add a debug print with
> the leaked physical address in that case as this is the important one.

I was thinking specifically about calling dump_page_owner().

Will
