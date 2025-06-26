Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908F912DDA1;
	Thu, 26 Jun 2025 23:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750981472; cv=none; b=mYbpStGn3ARRkugKmHD0SyEtGQgQMABQ6lqAlGOKcscUpvdQay6pgDaO4pRATTpRWq86skMoxvQ8vB+IJDyCCbagnOrWf4l8nRhkQShOViLhrfl3+TBtEgkdLSMDTZ2VdkpWSRMfAhGpbA2+/Iqllpzr2Jmod+Z/e4u7zBfU/Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750981472; c=relaxed/simple;
	bh=6GR56atUSt+bKa4y7fIYRqGS50kbuDnTWP0AsyJpTbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgY7CFJuitxaqvX0P049alLN+4/vc9O6cjIUhmLzhM4IENpZM+8JSDJm2fjfqVdeLgX+GWHQRu88KUnBy0NReB+REsbyW2XF0t10XWr/CT4NYYemEmZ3uB8qHyLsbaz9NAGF7BJKLssiz6kBt11g6oE0OAMGcyDZaNv4KowEJ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeKUV2eT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeKUV2eT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB91C4CEEB;
	Thu, 26 Jun 2025 23:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750981472;
	bh=6GR56atUSt+bKa4y7fIYRqGS50kbuDnTWP0AsyJpTbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GeKUV2eT7stYLibvFNyt2+U9+BWAI7aNDwUBYqlIG8GrzxAHfQbM++zJA4yqObHRt
	 N1zCSGg8uNTEV3Bhe4bWdy2nDoRizw+LfI/B/uZlkcDRiQ3NPpgj7gPRXr62gj3NWg
	 oeS/Vqc9+Rqd/Aj8GMmShwEvVtUoHzHU2n9d74opMMvkCtHs3mXBd5gK+netVfupnp
	 yykaRGfjON3CcHqlthe9S2LjHHAaYDyRiE+akk0e3TakcxL7R5tmnN/WQ8cQhGCOow
	 Rqc0ukbpAlR4mzRRNqY38g8tJtFSpccGrHH75WMzqUboCSUeFUsFM02hIdjkj2+xYv
	 sYSfy2dhYjxEA==
Date: Fri, 27 Jun 2025 01:44:24 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Lyude Paul <lyude@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
	rust-for-linux@vger.kernel.org,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Petr Tesarik <petr@tesarici.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH 1/2] rust: add initial scatterlist bindings
Message-ID: <aF3bWKvj0eCHnATV@pollux>
References: <20250529004550.GB192517@ziepe.ca>
 <DA9JTYA0EQU8.26M0ZX80FOBWY@nvidia.com>
 <95ff963ddabf7c3cd2cfd07d0231a0073ff6847e.camel@redhat.com>
 <DAED5BUK7TUQ.4JRHFMWZ99W3@nvidia.com>
 <27e17dbf-df6a-48fc-a652-ad48a776f668@gmail.com>
 <DAENGORNRVZH.2KIGKFV5C5G3L@nvidia.com>
 <f787046921fd608c385dc5c559883c5d70839507.camel@redhat.com>
 <DAP96FEJ0XWT.PWYMIE8IJAVQ@nvidia.com>
 <e2677c26-1c25-4a34-b666-9dcfa9642fd1@gmail.com>
 <20250626224355.GE213144@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626224355.GE213144@ziepe.ca>

On Thu, Jun 26, 2025 at 07:43:55PM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 26, 2025 at 11:31:15PM +0300, Abdiel Janulgue wrote:
> > Just commenting on this bit. From what I've seen, we don't actually leak
> > anything. The cast only creates a reference to the original C `struct
> > sg_table` object which was allocated and owned by whichever kernel subsystem
> > called sg_alloc_table(). Rust doesn't even allow us to take ownership or to
> > dereference the value, so this one is safe. Destructors are not called on
> > those "casted" objects.
> 
> This does not seem the right kind of philosophy.
> 
> Every pointer out of the kernel APIs has some kind of implicit
> lifetime contract.

Yes, and it also comes with a contract of ownership of the object behind the
pointer.

> Eg if you have
>   b = get_b(a);

Given the below I assume you mean taking a reference of an object B that is
embedded in an object A, rather than taking a reference count, which 'get'
implies a bit.

I.e.:

	struct A {
	    b: B,
	}
	
	impl A {
	    fn get_b(&self) -> &B {
	        &self.b
	    }
	}

> Then the lifetime of b might well be 'alive so long as a is alive'

Yes, and it is a good example of what Abdiel means. In your example a owns b,
which means that the type A is responsible to destroy its instance of B once it
is destroyed itself.

This means that a.get_b() returns a reference b of the type B that is bound to
the lifetime of the object a.

Dropping the reference b does nothing, since it does not have ownership of the
instance of B.

Please find a runnable example in [1] (and please also let me know if I
misunderstood you).

> 
> Or if you have some function pointer callback
>   void op_foo(a) {}

This is a great example too, since it can have both ownership semantics:

  1) The pointer 'a' in the op_foo() callback points to an object that is owed
     by some other object somewhere else, but the callback gives you the
     guarantee that the pointer 'a' is valid throughout op_foo(). In this case
     we can create a reference of the abstracting type in rust. In this case the
     lifetime of the reference is limited to the scope of this function.
     Dropping the reference does nothing, since we don't own the object behind
     the shared reference.

  2) The pointer 'a' in the op_foo() callback points to an object that we have
     to take (back) ownership of, hence only creating a reference of the
     abstracting type would leak the object eventually. Instead, we have to
     re-create the actual object instance, which would usually be some Arc<T>,
     KBox<T>, etc. In this case, we took (back) ownership of the object and
     hence the lifetime depends on what we do with the object subsequently. If
     we drop() it, the destructor is called.

> The lifetime of a might well be 'alive only within the function'
> 
> AFAICT rust needs to figure out these implicit rules and the compiler
> needs to enforce them.
> 
> Eg
> 
>  a = make_a()
>  b = get_b(a)
>  destroy_a()
>  do_something(b)
> 
> Should be something impossible.

Correct, this should give you a compile error. You can also see this case in my
example in [1].

In Rust you can also describe lifetime relationships with explicit lifetime
annotations. For instance, you could have a function signature like this:

	fn do_something<'a>(dev: &'a Device<Bound>) -> MyType + 'a

This means that the reference to the bound device has a lifetime of 'a and the
compiler ensures that the new instance of the type MyType returned by the
function can't out-live the reference to the bound device.

[1] https://play.rust-lang.org/?version=stable&mode=debug&edition=2024&gist=eed9d9c3e3ee187a9294961223e6b833
