Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C229442CB1E
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415056; cv=none; b=IGOgjWkS2GbUCdxa6nI0n3cC/31gAU2dqcxkeHW9sFqE2TLmG6ABmyeLtu18LumLwgMRelAh+DPREbEeK5GZGP8ryI/HeKQigVmdZQPhSmqe3H7envy/6Ry7ikmOe8g4LUmaE27ksBDiAFMO9f9pVCp35dCykteOOOS/o7YYHOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415056; c=relaxed/simple;
	bh=BcwsKDtfk0hphX3A0PDG2WfcEr2UGnr3e54otlHFW4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7/Y0i0VJIn8yqEpLj5c/P9+cSz9TyzsGJ1sDlKeP9GS3k7jJd9wXRhGIYx6g7l4r8GYu4erz/TeBqYVM2GLMgY0Keaqwv4d0KOejqV4Bdnso1w+lemSQ/IGjb5exEvjipO4Ri18uaH9e/UDmuakklGFiJLrOY3Q4Lb7f+/tGHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc50014f63e0f2a030593.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:14f6:3e0f:2a03:593])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A6B85240651;
	Thu, 30 Jul 2026 14:37:31 +0200 (CEST)
Date: Thu, 30 Jul 2026 14:37:30 +0200
From: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, iommu@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, samitolvanen@google.com, 
	laura.nao@collabora.com, boris.brezillon@collabora.com, daniel.almeida@collabora.com
Subject: Re: [PATCH v3] rust: iommu: add device lifetime to IoPageTable
Message-ID: <amtFbx_6SN6kgHQK@8bytes.org>
References: <20260703-pgtable_lt_b4-v3-1-e738e1f513a4@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-pgtable_lt_b4-v3-1-e738e1f513a4@collabora.com>

On Fri, Jul 03, 2026 at 05:28:44PM -0700, Deborah Brouwer wrote:
> Currently, using a raw IoPageTable is unsafe because the returned
> IoPageTable is not tied to the device driver binding lifetime.
> 
> Since device drivers now receive a lifetime parameter <'bound>
> representing the interval during which a device driver is bound to its bus
> device, add a lifetime parameter to IoPageTable. This ensures that
> the returned IoPageTable cannot outlive the bus device binding.
> 
> Also remove the option to create a page table as a device resource since
> currently Devres is not compatible with resources that have a lifetime
> parameter. This option can be restored once the lifetime-aware
> wrapper for devres is available and if a use-case appears for it.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
> Changes in v3:
> - Rename 'bound to 'a since the page table could have a shorter
>   lifetime than the whole device bound.
> - Remove the TODO comment about restoring the devres option.
> - Link to v2: https://lore.kernel.org/r/20260703-pgtable_lt_b4-v2-1-f14da6d4106d@collabora.com
> 
> Changes in v2:
> - Renamed new_raw() to new(), since the constructor is now safe.
> - Link to v1: https://lore.kernel.org/rust-for-linux/20260702-pgtable_lt_v1-v1-1-18d9c9812a1a@collabora.com
> ---
>  rust/kernel/iommu/pgtable.rs | 32 +++++++++-----------------------
>  1 file changed, 9 insertions(+), 23 deletions(-)

Acked-by: Joerg Roedel <joerg.roedel@amd.com>

