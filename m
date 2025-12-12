Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE453312831
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765532474; cv=none; b=UoHoI6ZkQ95Srm3MlR0CqsKi/fvCOFQJxeKYyvfEelg2m8WTCRNlU3xCrHllijzRyaIT2fcWTYj4zTkamP9jc5/jv82uYvzjE6m2345s7pmXsn7nyrPr+qZYiekhLPQLO7VQ7s7alDTR2SqKKd/D8PH5kkPZUOD4RNDmqU1MFDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765532474; c=relaxed/simple;
	bh=/DwHOk5c2eD0Vxh7f5OQ4V+UKKui+51GMERXKOPoGK0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXgJUFXyLzCEgIZeBxBh9EaD677ZmOTBHjovZM+zyun/o0qvaI8nm95+166E+fYDNg3vvtNp2ewQniYr2YZ/P5u9BaD0+2OsFRuF6CQJl3BFyIdciRS34BbxwRL+DXvEcfLykziItJgrJndQmM+F5naB7akmz9mLM5trP7hFW3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jKl/sZPT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jKl/sZPT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1765532471;
	bh=/DwHOk5c2eD0Vxh7f5OQ4V+UKKui+51GMERXKOPoGK0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jKl/sZPT5Fq8we2J4h12wq9dhaferqqG7WYrh7c5Y1k5yBsJRMxSPvRCYDSthsFe8
	 pRqw/bWdb5arjO4jzO0ebG7e3egbR/5HaJg3gCz1rMcvTGYH23kRmB7RO/abMhPeXv
	 pP44WpV+iM3lP2u6jLE3rcBHt99HTvhioEdkk9vV/zsqJzhBc+WelZKtTdeIp6hRZI
	 kmpNosTBznVu+OWO723zn0UqOjgkh4gRNzv8gubsK5YawM0ijxqLCMQ3L+hxcgdI1g
	 HvFUydetaOLNCQ1Pm2xQnAIFIdzuv4f22nuxZ8yOhxrtVyypGcGEw32L5sKR8OKSyU
	 Ko6IEHLDYFUQQ==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4DBE917E0451;
	Fri, 12 Dec 2025 10:41:10 +0100 (CET)
Date: Fri, 12 Dec 2025 10:41:05 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Will
 Deacon <will@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross
 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Joerg Roedel
 <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Asahi Lina <lina+kernel@asahilina.net>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v3] io: add io_pgtable abstraction
Message-ID: <20251212104105.6af97d05@fedora>
In-Reply-To: <aTveh8c3RngvnIMp@nvidia.com>
References: <20251112-io-pgtable-v3-1-b00c2e6b951a@google.com>
	<20251128180255.GA836877@nvidia.com>
	<20251212094427.2ec0b31e@fedora>
	<aTveh8c3RngvnIMp@nvidia.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Dec 2025 05:21:11 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Dec 12, 2025 at 09:44:27AM +0100, Boris Brezillon wrote:
> 
> > > > +// These bindings are currently designed for use by GPU drivers, which use this page table together
> > > > +// with GPUVM. When using GPUVM, a single mapping operation may be translated into many operations    
> > > 
> > > Now that we have the generic pt stuff I wonder if GPUVM should be
> > > providing its own version of the page table implementation that
> > > matches its semantics better.  
> > 
> > Not too sure what you mean here. Are you saying that we should fork
> > io-pgtable-arm.c (or rather a subset of it), and have it all
> > implemented in panthor?  
> 
> Not quite, probably next yearish some of iommu is going to stop using
> io-pgtable-arm.c, and switch to the new stuff.
> 
> The new stuff has alot less duplication if you want to make your own
> special stuff like this:
> 
> > against it. Now, I see good reasons to do that, like the fact we
> > would be able to add features like batched repeat mapping updates
> > (mapping the same page over a wide virtual range without having to
> > duplicate the intermediate page table levels that are exactly the
> > same),   
> 
> That's certainly a unique requirement and it could be implemented with
> a gpusvm specific set of operations.
> 
> > or the ability to extend the mapping arguments with
> > shareability/coherency info (that we can do by adding IOMMU_xx flags
> > too). But there's also downsides to it, like the fact we wouldn't
> > benefit from bugfixes materializing in io-pgtable-arm.c, if any.  
> 
> The new stuff is significantly modular already so this risk is a lot
> lower, and we could further modularize things that are actually
> duplicated.
> 
> But doing something like repeating page table levels will require some
> fairly different unmaping logic already...
> 
> You also had the special allocator asks (and presumably optimizations
> are possible there too) and probably optimizations like taking page
> lists directly out of GPU structures instead of multiple calls and so
> on.
> 
> When 6.19 comes out go look in drivers/iommo/generic_pt and read the
> documentation pages that will generate under the kernel docs site.

Ah, nice! I will certainly have a look when it's out. Thanks for the
heads-up.

> 
> Then you can think about what is ideal for GPU and consider what the
> work would be like. My uneducated feeling is with gpuvm trying to be
> common code it could also have gpuvm provide shared common code that
> directly builds page tables in CPU memory using the above framework.

So, gpuvm is one level up (it doesn't deal at all with any HW
representation), but I guess we could provide helpers for UMA-GPUs,
where preparing the page table on the CPU is a thing, and it could be
that MSM would be interested in using those helpers too.

> 
> > > IOW it doesn't seem right that common code would be making decisions
> > > like this, the nature and requirements of the flushing are entirely up
> > > to the driver binding to HW.  
> > 
> > We're not saying this will work for everyone, but rather, this is a
> > default implementation that does nothing, and if you need to do
> > something, override it with your own. I guess if that's really
> > problematic, we can force the user to provide one and keep the NOP
> > implementation on Tyr's side.  
> 
> In my view there is no possible correct way to use this page table
> code with HW unless you also provide flushing ops. I can't remark what
> is more rusty to do but having a default full of NOPS should at least
> come with a comment explaining that the driver still need to provide
> something.

I'll let Alice decide, but I'm perfectly fine with both options
(NOP default with a disclaimer, or no default at all).

Thanks,

Boris
