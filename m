Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA2D1DF258;
	Thu, 10 Apr 2025 15:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299273; cv=none; b=XyMxTJcK0nmhPAZUxJGXCV7CxNu8LKMPLYBz//TyH5MK4d1e2fXcRs9i/H/GHxyswQs2si/FYiiVUer1nefuSUwgTIv5kaSLYfCMOK5M9PH+Y6L6pbsahGOo2y5Di9qe2rf8BZaY8iFMophbw1mZm9X8QX3kOKcYfEPbhpl+oWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299273; c=relaxed/simple;
	bh=chG2qc958SltEXeebkRxLTHhMr+J82fDLTxWI4yu2vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGGCep9MDxxoKQPzu8i5Wxi+Y60ZFSakxH74tJj0MjMqqxOI9NM6vccoab8dep7SoElcYIyP3xvSjErVjiGuWC+ygfIzAWEuc8lM6OCxG1gf1Ufh8z2+PmaCLhZDvgd4sqm7VkiCI4qaWSbUvfAva3OP0kBNR5a+vpFjLJi4POk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKyVv1AY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKyVv1AY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CE6C4CEE9;
	Thu, 10 Apr 2025 15:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744299273;
	bh=chG2qc958SltEXeebkRxLTHhMr+J82fDLTxWI4yu2vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fKyVv1AYUUD6IrJUMK6SxH0iKTg30q9UF3U5QDL5M0vFma/U9K912kTpER8l7JXqm
	 umfkEY3/Noe1h6LwsTwLiTGcP3mTGuzibFrnAiE9iwGUAJKZqAcf8xERer5qvQaTFE
	 QBzRIiDb5ppPvt7oRWK65jYJKr4Eik7XWbQCDv0nZiTtjPGBDQGCb/x/hmsnNzd4hG
	 oUVmVo+anHwdPQxoGNed1BayL/KH3TuR9Z/UgjU4huB8qzkn2sjUI4csp8dfaVujeM
	 8T2gkHLqRNPAeRWVoqQgVlQ7Mo0MO6sZ5tG3vXw3ysPtyJZpLOq5/xvm4/hqaQyZ+U
	 3NUq24MruRNnw==
Date: Thu, 10 Apr 2025 17:34:27 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, a.hindborg@kernel.org,
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
Message-ID: <Z_flA_DP5_1mG6h_@pollux>
References: <20250410085916.546511-1-abdiel.janulgue@gmail.com>
 <20250410085916.546511-3-abdiel.janulgue@gmail.com>
 <Z_exjZ9xEntlL9FC@pollux>
 <D931ZGPNHUA8.U3L2C72CVH46@proton.me>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D931ZGPNHUA8.U3L2C72CVH46@proton.me>

On Thu, Apr 10, 2025 at 03:11:01PM +0000, Benno Lossin wrote:
> On Thu Apr 10, 2025 at 1:54 PM CEST, Danilo Krummrich wrote:
> > On Thu, Apr 10, 2025 at 11:58:17AM +0300, Abdiel Janulgue wrote:
> >> @@ -78,13 +74,14 @@ impl Drop for DmaSampleDriver {
> >>      fn drop(&mut self) {
> >>          dev_info!(self.pdev.as_ref(), "Unload DMA test driver.\n");
> >>  
> >> -        let _ = || -> Result {
> >> -            for (i, value) in TEST_VALUES.into_iter().enumerate() {
> >> -                assert_eq!(kernel::dma_read!(self.ca[i].h), value.0);
> >> -                assert_eq!(kernel::dma_read!(self.ca[i].b), value.1);
> >> -            }
> >> -            Ok(())
> >> -        }();
> >> +        for (i, value) in TEST_VALUES.into_iter().enumerate() {
> >> +            let val0 = kernel::dma_read!(self.ca[i].h);
> >> +            let val1 = kernel::dma_read!(self.ca[i].b);
> >> +            assert!(val0.is_ok());
> >> +            assert!(val1.is_ok());
> >> +            assert_eq!(val0.unwrap(), value.0);
> >> +            assert_eq!(val1.unwrap(), value.1);
> >
> > Maybe use if-let to avoid the unwrap?
> >
> > 	if let Ok(val0) = val0 {
> > 	   assert_eq!(val0, value.0);
> > 	}
> >
> > I know it's a bit pointless, since we know it must be ok, but the educational
> > message of the example should be to check and not to unwrap, so maybe that's
> > better.
> 
> The if-let will silently ignore any errors, so I don't think that it's
> fit for example code either.

Yes, but we still have the assert!() before, so the full sequence would be:

	assert!(val0.is_ok());

	if let Ok(val0) = val0 {
	   assert_eq!(val0, value.0);
	}

The intention would be to avoid patterns that shouldn't be used in "real" code;
assert!() should be obvious not to use for real code.
