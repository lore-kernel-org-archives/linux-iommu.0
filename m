Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1AD425CC0
	for <iommu@lists.linux.dev>; Fri, 31 Jul 2026 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502105; cv=none; b=OGBfG7LwPK8h0JwO3soMGO+bjhibctma7POOP+9bY0rRq+bSmWEB+OQa+m/Md4R9SXRVJTyaNZmMOZiJp5aRrherz0d0sHQG0SQJCA9QRBLW7Yc8bmuAAaPAaRUugy2IO3l+oC8UpXQzhVaKgjGTcufLLJlfA8077cUSDXVICbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502105; c=relaxed/simple;
	bh=ZQtcZcvZAcOtTtPqKpdoZSZ+z0OYDwFlo8afULyr+B0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KUP0WJMEzGA4MndIs5vsQwjWyX1IrFmbRsQ/hOAvOaRH4TIMnwnq1CiWjXrOpQgyRuX8V3aj7yPWVUhFeLfFJWMqKWDHz1N9qDIjy/knP0S7zBjGi6I+xPDzYqrRCAyAmgBhRQtvCGxiuR57Ijsf/zCvgFqjGtVT8AJ76zFcGEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uhDly1wy; arc=none smtp.client-ip=209.85.208.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uhDly1wy"
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6983e384c66so949280a12.1
        for <iommu@lists.linux.dev>; Fri, 31 Jul 2026 05:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785502101; x=1786106901; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=USM/uxphlK5U3jmHzJnvrNhoNwlWgSplg6PGbnKffbU=;
        b=uhDly1wyLYcxDT0bdLfIA+6NMDOEv2S+gv6PzyDHZ+3wRxmlaDJMUER9LZ0tF8o56R
         HFQHCGVLgbDjrQ4ifyxDeqAuQsimk8T4eYnfcPvUIpeaXQjxmM6SUI3elZPp2GANUPhU
         rV3bhE3P0q7xR9IUx02jODkFo93VlLoexkDsuNsNuP39et0eOwEiz9nj2sYsHwY+gZ2Z
         YShRSZQubt1UpmXeUcfdpayE3y2U9YuHZsiRagRbFoNnUYiCQWRoieelWE6ZuuWP2VOD
         CubOaLNTUuC7bX4lNUkuuuzdoNoVL4mrfvM6THKmrDVW/TvxmB+ryGOufS9m4+tUFJCl
         9fHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785502101; x=1786106901;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=USM/uxphlK5U3jmHzJnvrNhoNwlWgSplg6PGbnKffbU=;
        b=dpfccEJcvLs8fP5wiW1vaKJzYAX95cJebQqs07LvdnmCQPVr8zSGs8WvByPR+Y7dkW
         zLeqU8deoifNWSgaX50KKP+HsMCrfEepG9n70a5oCdCTjWAFpVmA/80OA7dwCd/BbZY1
         Lj47ZDTdXe1A1aky/CPmIdjrCYJb9s+9YQsG708C5JXXo8ro2EYt3862E7GrwwyX4rBS
         5vIhEytUS2+0cBvOteCWVOzvoyUlnzvQa9yfh9rGBBPtTUAD+MfLS+Rk3TUAtpBXNREI
         m4IbGZCq9J+4PTCxgmcXawCCWf8d+wu2FFEhARgA5ucxKwysemEpU06zyn3ZPbiiHJmA
         uo5g==
X-Forwarded-Encrypted: i=1; AHgh+RpWEu7S7KM/+hnJYxQAl6UdTspOWFQz4vibggWhftG1ciR9+4KFBZT6S3VNv9zETB/We4Hwuw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlQwbvB7hOHhBPYtQBBTj4cP7R8pLCazv2ZzJEP2lCQqWVJpk3
	lZbNleVTiw97ibpMLihLj5i1GeJo8UN0Ycno01MUQ33Uosf9/tiK7aPdi6UiWQvtL3mh/ynm00S
	+WK9o/s5dzStNg45YNg==
X-Received: from wmbev15.prod.google.com ([2002:a05:600c:800f:b0:493:c773:ff79])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4404:b0:698:3b7b:e492 with SMTP id 4fb4d7f45d1cf-6a098f263f5mr1092694a12.40.1785502101210;
 Fri, 31 Jul 2026 05:48:21 -0700 (PDT)
Date: Fri, 31 Jul 2026 12:48:19 +0000
In-Reply-To: <amtFbx_6SN6kgHQK@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260703-pgtable_lt_b4-v3-1-e738e1f513a4@collabora.com> <amtFbx_6SN6kgHQK@8bytes.org>
Message-ID: <amyZkwWyyAVSgdYP@google.com>
Subject: Re: [PATCH v3] rust: iommu: add device lifetime to IoPageTable
From: Alice Ryhl <aliceryhl@google.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Deborah Brouwer <deborah.brouwer@collabora.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, iommu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, samitolvanen@google.com, 
	laura.nao@collabora.com, boris.brezillon@collabora.com, 
	daniel.almeida@collabora.com
Content-Type: text/plain; charset="utf-8"

On Thu, Jul 30, 2026 at 02:37:30PM +0200, Joerg Roedel (AMD) wrote:
> On Fri, Jul 03, 2026 at 05:28:44PM -0700, Deborah Brouwer wrote:
> > Currently, using a raw IoPageTable is unsafe because the returned
> > IoPageTable is not tied to the device driver binding lifetime.
> > 
> > Since device drivers now receive a lifetime parameter <'bound>
> > representing the interval during which a device driver is bound to its bus
> > device, add a lifetime parameter to IoPageTable. This ensures that
> > the returned IoPageTable cannot outlive the bus device binding.
> > 
> > Also remove the option to create a page table as a device resource since
> > currently Devres is not compatible with resources that have a lifetime
> > parameter. This option can be restored once the lifetime-aware
> > wrapper for devres is available and if a use-case appears for it.
> > 
> > Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> > ---
> > Changes in v3:
> > - Rename 'bound to 'a since the page table could have a shorter
> >   lifetime than the whole device bound.
> > - Remove the TODO comment about restoring the devres option.
> > - Link to v2: https://lore.kernel.org/r/20260703-pgtable_lt_b4-v2-1-f14da6d4106d@collabora.com
> > 
> > Changes in v2:
> > - Renamed new_raw() to new(), since the constructor is now safe.
> > - Link to v1: https://lore.kernel.org/rust-for-linux/20260702-pgtable_lt_v1-v1-1-18d9c9812a1a@collabora.com
> > ---
> >  rust/kernel/iommu/pgtable.rs | 32 +++++++++-----------------------
> >  1 file changed, 9 insertions(+), 23 deletions(-)
> 
> Acked-by: Joerg Roedel <joerg.roedel@amd.com>

Applied to drm-rust-next. Thanks!
