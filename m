Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD7E4414;
	Fri,  7 Mar 2025 11:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347922; cv=none; b=RmF8vOU6Th6YFfHz7ljWyCHfRtQYr34sd9YDi26J6awlN1b6zkGcUrkulxKH6c47elXMHXnd3kQTynzNXz9F0qCteHu/NKma7Wp7EvPhaKe+H1eg9MZYONqtpGGbWdfAvVmdjgAmU9tN3OnpdvtO/iY0GeYrgb00e6ASK3TxUdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347922; c=relaxed/simple;
	bh=bZX9DQXvrsK9MXD2A2pPaKa9P+31M/XTNYgpao8+NB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtifMDxGi1jpuLPHzoc61Y0e63SuscoBqNxFcUv+RIl60MLX5eGuRY7y8glWipgGsMM25zzCVyvBNqRoh5v27vbOQ+uajaAXvZOK4Ck7IcrbzmFPYShVfATS5VgWQac+5+asliw98lC8Cb4+qAQluvwvCGbewrsLhUJvn60A4yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUN8UJnZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUN8UJnZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9116AC4CED1;
	Fri,  7 Mar 2025 11:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741347922;
	bh=bZX9DQXvrsK9MXD2A2pPaKa9P+31M/XTNYgpao8+NB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VUN8UJnZd7skL++NRzQOoi5nQnDZJEgm4Tykk/UPz+dhDRvB1VYcnxCpIAm+GXXEz
	 9lCGDp9uRS7Jb5JGJg3kptb3sC8n5GrzZwt5VbRiCyc977li1Z5F218v9W0Vwcx3Sq
	 MsZrvDpEw2kc90RmXSXQfYNz8UvAbe4zrMq77b4Jf8YMbC53SFolP6u+5F0mAaNxV+
	 peBXdgUXCb52JNZ6bbX4xECbj4+lWfl6vlZhywXWs+GAkGKS8+XemztQSJgsSIuwE2
	 up+47+Rw4Sc1WnWfOHiteo8dEJ7IGyRr7cpvzmfAC+8NQddrZNKtAJakJTivtQ8vTF
	 Sm8gHLtB8+3Lg==
Date: Fri, 7 Mar 2025 12:45:15 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
	robin.murphy@arm.com, Miguel Ojeda <ojeda@kernel.org>,
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
Subject: Re: [PATCH v13 3/7] rust: pci: impl AsMut<Device> for pci::Device
Message-ID: <Z8rcS4hEHIYNzPll@cassiopeiae>
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
 <20250307110821.1703422-4-abdiel.janulgue@gmail.com>
 <Z8rV6y5GLgovaWdN@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8rV6y5GLgovaWdN@google.com>

On Fri, Mar 07, 2025 at 11:18:03AM +0000, Alice Ryhl wrote:
> On Fri, Mar 07, 2025 at 01:06:20PM +0200, Abdiel Janulgue wrote:
> > From: Danilo Krummrich <dakr@kernel.org>
> > 
> > Some device methods require mutable references, since they change the
> > underlying struct device without lock protection.
> > 
> > Hence, make it possible to retrieve a mutable reference to a Device from
> > a mutable pci::Device.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/pci.rs | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> > index 4c98b5b9aa1e..141430dac2d5 100644
> > --- a/rust/kernel/pci.rs
> > +++ b/rust/kernel/pci.rs
> > @@ -432,3 +432,14 @@ fn as_ref(&self) -> &device::Device {
> >          &self.0
> >      }
> >  }
> > +
> > +impl AsMut<device::Device> for Device {
> > +    fn as_mut(&mut self) -> &mut device::Device {
> > +        // SAFETY:
> > +        // - `self.0.as_raw()` is valid by the type invariant of `device::Device`,
> > +        // - `struct device` is embedded in `struct pci_dev`, hence it is safe to give out a
> > +        //    mutable reference for `device::Device` if we have a mutable reference to the
> > +        //    corresponding `pci::Device`.
> > +        unsafe { &mut *self.0.as_raw().cast() }
> > +    }
> > +}
> 
> This makes it possible to call `mem::swap` on two devices, which I doubt
> is allowed.

Good catch, that's of course not allowed.

Obviously, this is for Device::dma_set_mask(), introduced in a subsequent patch.

Thinking about it, maybe it should be implemented by bus devices instead (e.g.
pci::Device) -- dma_set_mask() doesn't make sense for every device.
