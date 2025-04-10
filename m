Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FF82857DB;
	Thu, 10 Apr 2025 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744286099; cv=none; b=ejnFrkwRLDTZ0PsDznODMaE575YdGBbHd5/GTqe8wcF2czsAmnDDH67+TI+bK1Fo21f+3sIo9o95vxFceX7UXH+ElsnwHrSrkE0CPzNOsev9Ryc6Kh/zWW7EgSqlwr62hifanifsIrNQzHLqQS1s9/QCnmX6F7Jld/Rh8EyChSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744286099; c=relaxed/simple;
	bh=+rbqJBTcp/aKWEpqPhVv9PGK+VJrhFGyn4aSeHbatDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2o/8HhX6SBZnpfwLnel3T7UrT5mS79lVXlsPERDhTxugnItO3I7Wle9gwE+QRYR6NAJ8bwK4q9tkK2JWKo+JdAC5CIEOhwbLOU9xw9CPPcR7UV1SWXwp91DFSAoFxnKCdKV5kMmpOkiepPABFrprwAL8SVBus74UygrTNJ4Id0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSC1aJFm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSC1aJFm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EBEC4CEDD;
	Thu, 10 Apr 2025 11:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744286099;
	bh=+rbqJBTcp/aKWEpqPhVv9PGK+VJrhFGyn4aSeHbatDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YSC1aJFm4RiRfDJvOIVHnOkHYr5jrgjyKy0cRY36uWXhHa5/HDxjoo5XKisnwertT
	 lLyNM39sdMH+dBe/gxSd5R2QRipzwX+ZOFNBXT4qI6RdiNoEpTsCXQXNJvQPla4jFq
	 FZ8P2YY5ky7/01dTcRuqoikYiP5mPhccu9MuDklD8tqeB9kPXO73Gqdzio6FaHOPb9
	 ocnD5ls1FlOZQwP2MrMpD8yxHSrM26YtPBaVjIYdhEXkmeOtwWOiAZnPVAmwx0nulN
	 DKlWm+TIDTRd+IvHZWdUy7X8kTJvJdYTT3OJKhI8bB/HZ2iWbDOrCAUivEVh3+x9MO
	 iDz7IFrGV3W/Q==
Date: Thu, 10 Apr 2025 13:54:53 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: a.hindborg@kernel.org, benno.lossin@proton.me,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 2/3] rust: dma: convert the read/write macros to
 return Result
Message-ID: <Z_exjZ9xEntlL9FC@pollux>
References: <20250410085916.546511-1-abdiel.janulgue@gmail.com>
 <20250410085916.546511-3-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410085916.546511-3-abdiel.janulgue@gmail.com>

On Thu, Apr 10, 2025 at 11:58:17AM +0300, Abdiel Janulgue wrote:
> diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
> index 874c2c964afa..1e610545e100 100644
> --- a/samples/rust/rust_dma.rs
> +++ b/samples/rust/rust_dma.rs
> @@ -54,13 +54,9 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self
>          let ca: CoherentAllocation<MyStruct> =
>              CoherentAllocation::alloc_coherent(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
>  
> -        || -> Result {
> -            for (i, value) in TEST_VALUES.into_iter().enumerate() {
> -                kernel::dma_write!(ca[i] = MyStruct::new(value.0, value.1));
> -            }
> -
> -            Ok(())
> -        }()?;
> +        for (i, value) in TEST_VALUES.into_iter().enumerate() {
> +            kernel::dma_write!(ca[i] = MyStruct::new(value.0, value.1))?;
> +        }
>  
>          let drvdata = KBox::new(
>              Self {
> @@ -78,13 +74,14 @@ impl Drop for DmaSampleDriver {
>      fn drop(&mut self) {
>          dev_info!(self.pdev.as_ref(), "Unload DMA test driver.\n");
>  
> -        let _ = || -> Result {
> -            for (i, value) in TEST_VALUES.into_iter().enumerate() {
> -                assert_eq!(kernel::dma_read!(self.ca[i].h), value.0);
> -                assert_eq!(kernel::dma_read!(self.ca[i].b), value.1);
> -            }
> -            Ok(())
> -        }();
> +        for (i, value) in TEST_VALUES.into_iter().enumerate() {
> +            let val0 = kernel::dma_read!(self.ca[i].h);
> +            let val1 = kernel::dma_read!(self.ca[i].b);
> +            assert!(val0.is_ok());
> +            assert!(val1.is_ok());
> +            assert_eq!(val0.unwrap(), value.0);
> +            assert_eq!(val1.unwrap(), value.1);

Maybe use if-let to avoid the unwrap?

	if let Ok(val0) = val0 {
	   assert_eq!(val0, value.0);
	}

I know it's a bit pointless, since we know it must be ok, but the educational
message of the example should be to check and not to unwrap, so maybe that's
better.
