Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18E123C376;
	Wed, 12 Mar 2025 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773476; cv=none; b=QTW0/KKp4p/3SNWpcxWcEwdMwIiI6ZtvyGHOSZQ2bKi5PoJUJO26buoJ/NbqRH0vBKlGeZ2eaGFwKlzjmY2NRekQqDtIkltlQIIvIXAgL86czsZpgZsP4doZUlTQ9oSlsjpSrGb9HtLor6aXhkG9KXrmZBFDkZ4JIE9Gz4JdV8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773476; c=relaxed/simple;
	bh=WPKZgWXS6TO2Pkm4H5Q0EXYryaAnMa+J46vPcty7+I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gy2AZeSBKAr3zu/Vw9YlFRbeZAf80NCwYY/htgnKzNHOZvkUtvtyNPAHy/8QhwNAhosq580hxRVrmFF2PJrKKzcko+0LGDlxlA21IbmeoZanFK4B+QeHd8YgU4zkScxo6NNlvjnu6lGLIcIFH8OCTBjJHQCx3RBmsfVHONRjMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hN7zTksC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN7zTksC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDA9C4CEE3;
	Wed, 12 Mar 2025 09:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741773476;
	bh=WPKZgWXS6TO2Pkm4H5Q0EXYryaAnMa+J46vPcty7+I8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hN7zTksClow5IIOcuncjzOHxvDCtnmKmgDHs1uD6jDzBa7Nktfiy0aQmjWsV3EfnE
	 i7326JV1MpsxmC9oOU/pJ8oBd71VDSuzWdlme346oxXzL2Z5xjraNYgt9cbalogv7d
	 tmPZLDXBwbhE0NzN7OQbfBKelb/McZfXyt6IM358SnCe9+qgz3vq2pFJ/hZH2YyGVT
	 z0cKbLH/JlEH4Y8CDxSnBMAgO4d9u0pmEG012L0iXk9CHq7ZkHLAN8c/dS7CpdpAQi
	 1Pw7oUN/8TAt71zzbvPLFBEtypIpOCinURBvBMm2ZwrIWVR5+qGjRevOUDd66KeisW
	 nJicsFd95j5uA==
Date: Wed, 12 Mar 2025 10:57:49 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
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
Subject: Re: [PATCH v14 06/11] rust: dma: add dma addressing capabilities
Message-ID: <Z9FanUCUZAuBgQwk@cassiopeiae>
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
 <20250311174930.2348813-7-abdiel.janulgue@gmail.com>
 <D8DZ2XP3AI2Z.76W9FKGRNM92@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8DZ2XP3AI2Z.76W9FKGRNM92@nvidia.com>

On Wed, Mar 12, 2025 at 12:37:45PM +0900, Alexandre Courbot wrote:
> On Wed Mar 12, 2025 at 2:48 AM JST, Abdiel Janulgue wrote:
> > @@ -18,7 +18,35 @@
> >  /// The [`Device`] trait should be implemented by bus specific device representations, where the
> >  /// underlying bus has potential support for DMA, such as [`crate::pci::Device`] or
> >  /// [crate::platform::Device].
> > -pub trait Device: AsRef<device::Device> {}
> > +pub trait Device: AsRef<device::Device> {
> > +    /// Inform the kernel about the device's DMA addressing capabilities.
> > +    ///
> > +    /// Set both the DMA mask and the coherent DMA mask to the same value.
> > +    ///
> > +    /// Note that we don't check the return value from the C `dma_set_coherent_mask` as the DMA API
> > +    /// guarantees that the coherent DMA mask can be set to the same or smaller than the streaming
> > +    /// DMA mask.
> > +    fn dma_set_mask_and_coherent(&mut self, mask: u64) -> Result {
> > +        // SAFETY: By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
> > +        let ret = unsafe { bindings::dma_set_mask_and_coherent(self.as_ref().as_raw(), mask) };
> > +        if ret != 0 {
> > +            Err(Error::from_errno(ret))
> > +        } else {
> > +            Ok(())
> > +        }
> > +    }
> > +
> > +    /// Same as [`Self::dma_set_mask_and_coherent`], but set the mask only for streaming mappings.
> > +    fn dma_set_mask(&mut self, mask: u64) -> Result {
> > +        // SAFETY: By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
> > +        let ret = unsafe { bindings::dma_set_mask(self.as_ref().as_raw(), mask) };
> > +        if ret != 0 {
> > +            Err(Error::from_errno(ret))
> > +        } else {
> > +            Ok(())
> > +        }
> > +    }
> > +}
> 
> I'm not quite sure why this trait is needed.
> 
> The default implementations of the methods are not overridden in this
> patchset and I don't see any scenario where they would need to be. Why
> not do it the simple way by just adding an implementation block for
> device::Device?
> 
> This also introduces a `&dyn Device` trait object as parameter to the
> coherent allocation methods - not a big deal, but still inelegant IMHO.

There are mainly two reasons:

(1) The dma_set_mask() function famility modifies the underlying struct device
    without a lock. Therefore, we'd need a mutable reference to the
    device::Device. However, we can't give out a mutable reference to a
    device::Device, since it'd be prone to mem::swap().

    Besides that - and I think that's even more important - we can't claim for a
    generic device::Device in general, that we own it to an extend that we can
    modify unprotected fields.

    However, we can claim this for bus specific devices in probe()[1]. Hence the
    trait, such that the DMA mask functions can be easily derived by bus
    specific devices.

(2) Setting a DMA mask only makes sense for devices that sit on a (potentially)
    DMA capable bus. Having this trait implemented for only the applicable
    device types prevents setting the DMA mask and allocating DMA memory for the
    wrong device.

    This isn't necessary for safety reasons, but I think it's still nice to
    catch.

---

[1] Gotcha with bus specific devices.

Currently bus specific devices are implemented as Device<ARef<device::Device>>.

This was a bad idea and is on my list to fix. As convinient as it is, it is
unsound, since this means that driver can always derive a mutable reference to a
bus specific device.

I think that the upcoming Ownable stuff would be a good solution, but maybe I
should wait any longer and fix it right away without Ownable.
