Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627E01C6FFA
	for <iommu@lists.linux.dev>; Thu, 29 May 2025 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748528630; cv=none; b=hNv1X7ALK7ERqqKJl9mBySHbK6CBuFfqNxFAnw1J0ac2duRcwmv4C8ZvMxtPqzCIkVmdJNH1sJO8meO6NIbixRmkRFbzi2QWg6TnTm3Pas9FYWAFIQlIAo7g475G/gZaJVHBSgI+SOromKWnttm2vu9rFitzlmmoh/fcfgXB2c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748528630; c=relaxed/simple;
	bh=vMTVSByqMNrfkYziJ5GzUMRwRxKpnrG5sJUwP0QUUkU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QRDzTGXGpEg1mv2t82I60tf3rHZfAmPFhWrXsXg+phVNdF1JLrvYnQRMqgrQy8pPKNWGIEURwD9pTfyQnnosPPe2BPjf46JMQktJF6x59IelSKYAAvmdQNdNLmLXoOmATax5F0XFfRtelQs97JYhVJ8pQB/ThGvfy4ny00duXPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=kTjlgtz6; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="kTjlgtz6"
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 62F9E237D72;
	Thu, 29 May 2025 16:14:25 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1748528065; bh=/heSIOkrc6S13I1DyoRw7pZSmG/U2TSfn78nKHqvfyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kTjlgtz6DudrpDALWockeOMzedddM4W/o4YX+J5W3D/7w04LQvmnkx0TrV55g08wV
	 QvDm1cmzIVF/CFB3cVjDWh9XJt6aNOL/cQxOVJFVzu36galgD6vBJH6M4WPO0S49uO
	 I1+wl6vd378SUruFCMNelQOZ4yVTD3s4Qgg2dUyjeqQI6V1sPQyz4wWENgcP18yTta
	 9qDND63VO/Zrqf6oCycGqYBM/7ahEL2Rqlgkfioyim2Zgzk0jIME5sd+t0g37nI8cv
	 wMHInV63c13NKV/fT2AMCHzPWly9e1TC66WF+INFW9HXtWC3kMoCEmTPJp1KFojLix
	 tehkz5n0oTQfQ==
Date: Thu, 29 May 2025 16:14:24 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, acourbot@nvidia.com,
 dakr@kernel.org, lyude@redhat.com, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, open
 list <linux-kernel@vger.kernel.org>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>,
 airlied@redhat.com, rust-for-linux@vger.kernel.org, "open list:DMA MAPPING
 HELPERS" <iommu@lists.linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, Sui
 Jingfeng <sui.jingfeng@linux.dev>, Randy Dunlap <rdunlap@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH 1/2] rust: add initial scatterlist bindings
Message-ID: <20250529161424.5cd95308@meshulam.tesarici.cz>
In-Reply-To: <20250529004550.GB192517@ziepe.ca>
References: <20250528221525.1705117-1-abdiel.janulgue@gmail.com>
	<20250528221525.1705117-2-abdiel.janulgue@gmail.com>
	<20250529004550.GB192517@ziepe.ca>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 May 2025 21:45:50 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Thu, May 29, 2025 at 01:14:05AM +0300, Abdiel Janulgue wrote:
> > +impl SGEntry<Unmapped> {
> > +    /// Set this entry to point at a given page.
> > +    pub fn set_page(&mut self, page: &Page, length: u32, offset: u32) {
> > +        let c: *mut bindings::scatterlist = self.0.get();
> > +        // SAFETY: according to the `SGEntry` invariant, the scatterlist pointer is valid.
> > +        // `Page` invariant also ensures the pointer is valid.
> > +        unsafe { bindings::sg_set_page(c, page.as_ptr(), length, offset) };
> > +    }
> > +}  
> 
> Wrong safety statement. sg_set_page captures the page.as_ptr() inside
> the C datastructure so the caller must ensure it holds a reference on
> the page while it is contained within the scatterlist.
> 
> Which this API doesn't force to happen.
> 
> Most likely for this to work for rust you have to take a page
> reference here and ensure the page reference is put back during sg
> destruction. A typical normal pattern would 'move' the reference from
> the caller into the scatterlist.
> 
> I also think set_page should not be exposed to rust at all, it should
> probably only build scatterlists using the append APIs inside scatter
> tables where the entire model is much cleaner.
> 
> Because this is also wrong in the sense that it destroys whatever
> sg_page was already there, which may have been holding a page refcount
> and thus it would leak it.

Thank you, Jason. You already made this suggestion for the RFC version,
and it begs the question if perhaps the underlying C API should also be
deprecated and eventually removed from the kernel.

A quick grep shows about 200 call sites, which may take some time to
remove, but if the API is apparently broken without people knowing, we
should start doing something about it.

Petr T
