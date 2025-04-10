Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9671E231F;
	Thu, 10 Apr 2025 23:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744327739; cv=none; b=cnut0sVoyjEKAVJ1QT2LvsdBCEQlGTougXa6WfBn2CJwGtZkk9J/MSQAc2qa7u35Z0Pvkz/ThL+aE3+/iGxGdKM6TtkOhoT7fL18EbrDIkk+e/Vw5ZlY1hchykM8NvPxesjYqJCPd7e8hDsSGT6M0St0HPtmjjCfGwXl8W83sOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744327739; c=relaxed/simple;
	bh=QR5wAxwNs/0pUlpoV2G8ubqvhwn+jxCykH9UePuSiOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1MNEkAUq1nHFF9qJ3XTOfJKrIU/JfldqQlFHuTZAfw6yOl0W8duhrb9TlnQ4wHAvXFIMzK81g2NPU7r3i4kcr+bZBdp+AYMfHqMiMEITJl91YL8oakt0K9REsWteKiZO6bn6SGdKoyhTn94AasbqG31TYBWRBrgSxkSPILp9xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Amt3Xp1Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Amt3Xp1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D28EC4CEDD;
	Thu, 10 Apr 2025 23:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744327739;
	bh=QR5wAxwNs/0pUlpoV2G8ubqvhwn+jxCykH9UePuSiOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Amt3Xp1QAg4PYzlL02RcZ39wf9i++eqNZTs04vFd1c2whx+m/Rpe4qDFQ9xYLWQ5E
	 W9xmi9SOfdseb+sCHVMXCtT+HeaKPMkS8mS/63UlCwzY4qVvf+TjsbI8d76kIrh3MV
	 qUzjoHLCLtmxesyzQLAR3lKJRTsKeOTBIdkf0t5wFSsCtGBn8s//O9+wfWhHgswkPQ
	 frFPJz3lK7h7cQi9jv1qkOh/KmIigH+oawXZKZmliAn+ZSQ38O4Pqe7ca2Rv7DusTY
	 t5hkGXQzbbv0EDuXn9GRfIuY2ww3ppAI40Ql3Y1W0/6UMUQr/Guw4RTLp/wZ/sN+bI
	 uaADJ3sBAngLQ==
Date: Fri, 11 Apr 2025 01:28:52 +0200
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
Message-ID: <Z_hUNCwXrZKI4D4o@cassiopeiae>
References: <D93BX5NEOSC8.3NOVI9GMDJEXD@proton.me>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D93BX5NEOSC8.3NOVI9GMDJEXD@proton.me>

On Thu, Apr 10, 2025 at 10:58:10PM +0000, Benno Lossin wrote:
> On Thu Apr 10, 2025 at 5:34 PM CEST, Danilo Krummrich wrote:
> > On Thu, Apr 10, 2025 at 03:11:01PM +0000, Benno Lossin wrote:
> >> On Thu Apr 10, 2025 at 1:54 PM CEST, Danilo Krummrich wrote:
> >> > On Thu, Apr 10, 2025 at 11:58:17AM +0300, Abdiel Janulgue wrote:
> >> >> @@ -78,13 +74,14 @@ impl Drop for DmaSampleDriver {
> >> >>      fn drop(&mut self) {
> >> >>          dev_info!(self.pdev.as_ref(), "Unload DMA test driver.\n");
> >> >>  
> >> >> -        let _ = || -> Result {
> >> >> -            for (i, value) in TEST_VALUES.into_iter().enumerate() {
> >> >> -                assert_eq!(kernel::dma_read!(self.ca[i].h), value.0);
> >> >> -                assert_eq!(kernel::dma_read!(self.ca[i].b), value.1);
> >> >> -            }
> >> >> -            Ok(())
> >> >> -        }();
> >> >> +        for (i, value) in TEST_VALUES.into_iter().enumerate() {
> >> >> +            let val0 = kernel::dma_read!(self.ca[i].h);
> >> >> +            let val1 = kernel::dma_read!(self.ca[i].b);
> >> >> +            assert!(val0.is_ok());
> >> >> +            assert!(val1.is_ok());
> >> >> +            assert_eq!(val0.unwrap(), value.0);
> >> >> +            assert_eq!(val1.unwrap(), value.1);
> >> >
> >> > Maybe use if-let to avoid the unwrap?
> >> >
> >> > 	if let Ok(val0) = val0 {
> >> > 	   assert_eq!(val0, value.0);
> >> > 	}
> >> >
> >> > I know it's a bit pointless, since we know it must be ok, but the educational
> >> > message of the example should be to check and not to unwrap, so maybe that's
> >> > better.
> >> 
> >> The if-let will silently ignore any errors, so I don't think that it's
> >> fit for example code either.
> >
> > Yes, but we still have the assert!() before, so the full sequence would be:
> >
> > 	assert!(val0.is_ok());
> >
> > 	if let Ok(val0) = val0 {
> > 	   assert_eq!(val0, value.0);
> > 	}
> 
> Ah right, missed that.
> 
> > The intention would be to avoid patterns that shouldn't be used in "real" code;
> > assert!() should be obvious not to use for real code.
> 
> Yeah, I'm not sure if this is that valuable. I think having "real code"
> is better, but I don't have any idea what to do in this case.
> 
> Why does this sample do the validation in the `drop` method in the first
> place?

I assume there is no specific reason, maybe Abdiel wanted to have a bit more
lifecycle for the allocation than just probe().

I guess we could just move it to probe(). Alternatively we can also keep it in a
closure or function and only assert! once for the returned Result.

> I guess the same code on the C side would do this in `remove` or
> whatever the equivalent thing is there, but would there be the option to
> report an error? Or is `remove` an infallible operation? In that case
> `assert!` probably is still the best option.

remove() is and has to be infallible, yes.
