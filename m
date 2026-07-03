Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CDF38333C
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 06:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783061046; cv=none; b=LlVUJckGZ6e2QjD99MMH/APef7szAxoMHA52NcPCutgGhkTAczMpd0Jxh2sh6Py6JXBYlqhgOTVygiL9sC6hCLqNchN5/1NkFgwCR/i06rUw4vg5OQihGeD72kxWZs0n0/V2M/0oxAINIl25z3IYYb7nB0H55JsCgU5eTxcaQXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783061046; c=relaxed/simple;
	bh=Pf5q80ck+5U2ixrJWHV1AI8ArmR0ZtcwQp0edbeGpww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u8hxmjnHYIJD2issVdKTu1qtDk1+v7PF12JwbUpvdnMMebC2gelmxw/I3MNGnlY8Z9czmOGWQo8cRIZDGzxL7US+7GTXs1RU6810aeswStsgdxhfSZ3fzrNd1UIezDDW827F9tcaxCY7Z6XyOjgtt6nJPlgBFKGDZo9HaVcapWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rQYy2c72; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rQYy2c72"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-c125bdd01cbso25601066b.0
        for <iommu@lists.linux.dev>; Thu, 02 Jul 2026 23:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783061043; x=1783665843; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7jmn19R8R/PMFgOwF2vvch2Q5bX9NRBwJ66kDptBPuo=;
        b=rQYy2c72qkqQxHUMgGHHgzmnQeSAfn/a9RJIDSmaECYs9yc+TsePy7NxzOFGSgeDs1
         SCTYTkwiYFu+fXBmerHSO4MjH9IqR0HybS1GUM0lAoJWfkYqA2KvR71kbhWNCvK8VSy3
         taTtBJRzIh+/kgVRTuhiQykNkkO0DLr9oBhTy2f5WJTXMFE3aDMeAyHjNjazPmH/sYWa
         mVo28VY4Qy2cNy+e0eTIYmayvvzO9NkSLMm5NueokvNsnC3GowHGrA93EYpa42OKJZ1J
         L3gT/u87JzY/NLIQVLojn9XSBorE4Vovdiq9M6QHWwFFMXfh+YCeaRWpEfYUHvNFuHPD
         caEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783061043; x=1783665843;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7jmn19R8R/PMFgOwF2vvch2Q5bX9NRBwJ66kDptBPuo=;
        b=iBpmyEbbS0zW3uOKhcP4nLuvdu1rC4Z7lP3CoH5O68OtgZfvH1X7SSZHImNkc7t69C
         9WYll1dM926f8nZy2ej9Hh6zdXtghsKiycqldfYdrEU6Fu9Jar5if7JYpLuKqy3KbwP/
         J8KNVG+wI7NbB85ToUh+Qiv+sruV5xuxqtk1axf+/vlJ6GyKR7L0xzch6/kLUurl04ef
         ywvFLZ3JbGmsLhGKtIHMT3re8SYldmoVF7VelPFzyQebDImYKzJn1+7j3+UpWN3dyO1H
         Zd0W16mMpVL+3Qb1qRpvzIlxS2tS037cxTBD8ZBUOc8n5mjZhsJ+tuNdQiZ/o4DRlWly
         b4bw==
X-Forwarded-Encrypted: i=1; AHgh+RqZyn7ZEkTFiYo6r9XWCC2pliBx93O6A450EXRols84XPDXVhR7QT+fQzYEmMnBUzAI3Qz4uw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxksA/CSDKi+YIE9aSHlmkdmlm8qG4g/2Kcm1HKWleZjEVeKHQj
	8RGzuOhgjMHVTwot9X9uDgMpHmag3199XNINyCOou76rvCpJ9rT4yOmY0bC6lz9ieufE5TzYycp
	jIuz4EK2LfyO4FJbzZQ==
X-Received: from ejj11-n1.prod.google.com ([2002:a17:906:a34b:10b0:c12:d541:2b1])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:970e:b0:c10:256:3d6a with SMTP id a640c23a62f3a-c12aa1b0166mr449505466b.31.1783061043110;
 Thu, 02 Jul 2026 23:44:03 -0700 (PDT)
Date: Fri, 3 Jul 2026 06:44:01 +0000
In-Reply-To: <20260702-pgtable_lt_v1-v1-1-18d9c9812a1a@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260702-pgtable_lt_v1-v1-1-18d9c9812a1a@collabora.com>
Message-ID: <akdaMa7hQbAjWbox@google.com>
Subject: Re: [PATCH] rust: iommu: add device lifetime to IoPageTable
From: Alice Ryhl <aliceryhl@google.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, iommu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, samitolvanen@google.com, 
	boris.brezillon@collabora.com, laura.nao@collabora.com, 
	daniel.almeida@collabora.com
Content-Type: text/plain; charset="utf-8"

On Thu, Jul 02, 2026 at 04:47:39PM -0700, Deborah Brouwer wrote:
> Currently, using a raw IoPageTable is unsafe because the returned
> IoPageTable is not tied to the device driver binding lifetime.
> 
> Since device drivers now receive a lifetime parameter <'bound>
> representing the interval during which a device driver is bound to its bus
> device, add this lifetime parameter to IoPageTable. This ensures that
> the returned IoPageTable cannot outlive the bus device binding.
> 
> Also temporarily remove the option to create a page table as a device
> resource since currently Devres is not compatible with resources that have
> a lifetime parameter. This option can be restored once the lifetime-aware
> wrapper for devres is available.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
>  rust/kernel/iommu/pgtable.rs | 32 ++++++++++----------------------
>  1 file changed, 10 insertions(+), 22 deletions(-)
> 
> diff --git a/rust/kernel/iommu/pgtable.rs b/rust/kernel/iommu/pgtable.rs
> index c88e38fd938a..d4a16283b5a7 100644
> --- a/rust/kernel/iommu/pgtable.rs
> +++ b/rust/kernel/iommu/pgtable.rs
> @@ -16,7 +16,6 @@
>          Bound,
>          Device, //
>      },
> -    devres::Devres,
>      error::to_result,
>      io::PhysAddr,
>      prelude::*, //
> @@ -59,15 +58,16 @@ pub struct Config {
>  /// # Invariants
>  ///
>  /// The pointer references a valid io page table.
> -pub struct IoPageTable<F: IoPageTableFmt> {
> +pub struct IoPageTable<'bound, F: IoPageTableFmt> {
>      ptr: NonNull<bindings::io_pgtable_ops>,
> +    _dev: PhantomData<&'bound Device<Bound>>,
>      _marker: PhantomData<F>,
>  }
>  
>  // SAFETY: `struct io_pgtable_ops` is not restricted to a single thread.
> -unsafe impl<F: IoPageTableFmt> Send for IoPageTable<F> {}
> +unsafe impl<F: IoPageTableFmt> Send for IoPageTable<'_, F> {}
>  // SAFETY: `struct io_pgtable_ops` may be accessed concurrently.
> -unsafe impl<F: IoPageTableFmt> Sync for IoPageTable<F> {}
> +unsafe impl<F: IoPageTableFmt> Sync for IoPageTable<'_, F> {}
>  
>  /// The format used by this page table.
>  pub trait IoPageTableFmt: 'static {
> @@ -75,25 +75,12 @@ pub trait IoPageTableFmt: 'static {
>      const FORMAT: io_pgtable_fmt;
>  }
>  
> -impl<F: IoPageTableFmt> IoPageTable<F> {
> -    /// Create a new `IoPageTable` as a device resource.
> -    #[inline]
> -    pub fn new(
> -        dev: &Device<Bound>,
> -        config: Config,
> -    ) -> impl PinInit<Devres<IoPageTable<F>>, Error> + '_ {
> -        // SAFETY: Devres ensures that the value is dropped during device unbind.
> -        Devres::new(dev, unsafe { Self::new_raw(dev, config) })
> -    }
> +impl<'bound, F: IoPageTableFmt> IoPageTable<'bound, F> {
> +    // TODO: Create a new `IoPageTable` as a device resource when DevresLt is available.
>  
>      /// Create a new `IoPageTable`.
> -    ///
> -    /// # Safety
> -    ///
> -    /// If successful, then the returned `IoPageTable` must be dropped before the device is
> -    /// unbound.
>      #[inline]
> -    pub unsafe fn new_raw(dev: &Device<Bound>, config: Config) -> Result<IoPageTable<F>> {
> +    pub fn new_raw(dev: &'bound Device<Bound>, config: Config) -> Result<IoPageTable<'bound, F>> {

The name new_raw() indicates that this is something you only use in rare
cases when you are doing weird stuff. But with this change, I no longer
think that's the case.

I would suggest renaming this method to just `new()`.

As for creating a device resoure version with DevresLt, I think that can
be the secondary constructor and be called `new_devres()` or similar.

Otherwise LGTM.

Alice
