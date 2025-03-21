Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83771E7C19;
	Fri, 21 Mar 2025 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742584599; cv=none; b=JX/qyMfQgOZPr22X853zIOHlBqKpA1lHjWURqXlQ9OV+BY5KpTpNCBsq5QAVF6foLNBK9hRbWctpkHmVMfvUES9gBDjP5BTjYd2f0OeQ4mHYJg6+/KnP6la0jq69l418JTElry1bOTSGeHwZyHpYDV1o4hJRnOsPS+NGyuicrZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742584599; c=relaxed/simple;
	bh=z/KWnvifda+GnMC8P1oTofMdHHiYyEq5V6QA+opf3Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9CxBClvaPFbWpAdSC7Qt84mo2b4UG/W3AXgRKtRJrj3hKWlV0KVijVfubocAt4/CXpgdjYQeS8TZkw3nLyNahc94GzUPelesIDR6BWKo0Mr08p7byYq3nWpQcCYZTZwCSXAUF+fb3fwsQojOB0gZIM4WTgSKNtSnhx97h7Tmk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0+I5ja8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0+I5ja8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67464C4CEE3;
	Fri, 21 Mar 2025 19:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742584598;
	bh=z/KWnvifda+GnMC8P1oTofMdHHiYyEq5V6QA+opf3Tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D0+I5ja8ltkfI1jQ6JJ+4/NcV9WG2bTYXvh7eG96Ats2DAzkupf7L0K/24M/sTHxi
	 Xok2+01z4l+QPfoB53cPmE1HcDEK0TFbhkFYIo8MucvHuJljlZ0l/weqLMI+GpkZYW
	 5oEA8U1uaetf0Y/myaSH0soXI6jff3lt5w8Hz+O7hSVhYbcOsTJNWgJ4qyzz/TPKz7
	 e0etQickE2XcbXi6EiSpEMPVuCxBs3vX1EWgnVehTG7MlK1/AyRJrsDKQCeOJUrF6A
	 3DMmxOWSYqI9fdz/1Ul8s2jtwI/DKBsLc8+mNA4aTf/y7xEqQt3g5cjZn0i1uEDbhQ
	 ghf2bycWv450Q==
Date: Fri, 21 Mar 2025 20:16:31 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
	robin.murphy@arm.com, aliceryhl@google.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v13 2/7] rust: add dma coherent allocator abstraction.
Message-ID: <Z927D6V4SqAZ_Hcg@cassiopeiae>
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
 <20250307110821.1703422-3-abdiel.janulgue@gmail.com>
 <20250321172353.GO126678@ziepe.ca>
 <Z92jPXvMOqhgv04k@pollux>
 <20250321182901.GQ126678@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321182901.GQ126678@ziepe.ca>

On Fri, Mar 21, 2025 at 03:29:01PM -0300, Jason Gunthorpe wrote:
> On Fri, Mar 21, 2025 at 06:34:53PM +0100, Danilo Krummrich wrote:
> > On Fri, Mar 21, 2025 at 02:23:53PM -0300, Jason Gunthorpe wrote:
> > > On Fri, Mar 07, 2025 at 01:06:19PM +0200, Abdiel Janulgue wrote:
> > > 
> > > > +        // SAFETY: Device pointer is guaranteed as valid by the type invariant on `Device`.
> > > > +        let ret = unsafe {
> > > > +            bindings::dma_alloc_attrs(
> > > > +                dev.as_raw(),
> > > > +                size,
> > > > +                &mut dma_handle,
> > > > +                gfp_flags.as_raw(),
> > > > +                dma_attrs.as_raw(),
> > > > +            )
> > > 
> > > This is not the correct safety statement, the device must have a driver
> > > bound to call this function, a struct device reference is not
> > > sufficient.
> > > 
> > > I belive Danilo was suggesting to ignore this unsafety for now, but if
> > > so it should be documented correctly.
> > 
> > If just landed patches [1], which are the foundation of addressing this issue.
> 
> Those patches say:
> 
>  The context types can be extended as required, e.g. to limit availability  of
>  certain (bus) device functions to probe().
> 
> Which is not an appropriate limitation for dma_alloc_coherent, we
> expect it to be called outside probe in real drivers. Is there more to
> that story?

Yeah, we can also use them to derive specifically typed Device instances from
other entry points of the driver where we know for sure that at this point the
device must (still) be bound to the driver.

For instance, bus callbacks, subsystem callbacks, certain (but not all) IOCTLs,
IRQ handlers, etc.

All those cases can be covered by only the type system, without additional
locks. We could even use this as an optimization to bypass Devres'
try_access() calls when holding a corresponding device instance in those places.

> 
> Regardless, the safety comment should not be merged with incorrect
> information. :\

v15 did land in rust-next, so unfortunately this was overlooked. Since you
caught, mind sending a patch improving the comment?
