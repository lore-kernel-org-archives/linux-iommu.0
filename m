Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4334D28E5
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763397251; cv=none; b=atOVbwehMcoh0wRQl5J+NnDq8DVY6JK6qWwhW0C04scrc4qXYZ5i7UIOz3ddmF6OKC7N2lPAvPZeHnHLiCDNCW2trI8x6iauOaKw7pD4vOTgmffyQYtPrA5o1DWIcW4TK9n9qJTdU7jQVVlQUatZ3kfb4JoJiyeujvTFiZK+x4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763397251; c=relaxed/simple;
	bh=zzWdLmtGggW9oRj+naWFU0UlArBlbWzK2DFfx8jpMSs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ytb9nf1zho7Jfpm/S+zAg/HL0Z+rsH0lnaokRnS9BSd61YgB4WX7z6k+60IQcqHhA2V4VobkiXOPCEH60IpL3CZ/FkdMJAfshICRpCArWTx7B0EHx1ricUqmryLEMhbeDwNaNKyZO77ngLkrynmbGhai3WVbHQPVy5gz42vP7Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yp+KbeoT; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yp+KbeoT"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-429c5da68e5so2564441f8f.1
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 08:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763397247; x=1764002047; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dnt6AMffwSDJMbW+9hMVzLqsThvI95BECbEYPsOm0UQ=;
        b=yp+KbeoTHjzkSdqV713yTO/xwI/FnqcOHuxFPKoIoN8z3HCpqzzgv+YpLWnsU3ODWB
         vNlDEjFRsY+fuMZ0WWdvuvH0RV8+jKLIhv+kbYhU72S2HykQU+I9V6RccoPjM3gCTWH2
         zaYHUKIjEVClE+NAixNcYwLt4pyPiO4a3QvcK9EVQRyDOc+V6zG5L1Mct/TeXsmuSUV6
         upSIe4zt99yVY85pLEDM+wQSBIjlSTWkaMUI95vMXxF/ipt0N4wL7WCEEXkeJpmFu+Z+
         juhuUvjrj6Pu4bGOa88e1C/kFbfvBXxY27CniHR2/Tlq+jocqxB8tequ8bP12jUvqnOG
         aMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763397247; x=1764002047;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dnt6AMffwSDJMbW+9hMVzLqsThvI95BECbEYPsOm0UQ=;
        b=IRKeu7Gn0AtOCc9yH2Hy1np7xkQzSwBqhmfCJZIa82/xRJMFWkzBsPf78eGsFpBe1H
         Qr15KSPZrAlRR1rP4L5sgbpqyhlyM1yFg0IagolEz0BtRg07GoOv8frY/6q6F0ESwHqe
         gENMYRyHDGbytgsGef+yFm9OgDlKFf3vV72RjzZ+n9q5CtAKwd0sH/14Hs17i6Y4Hj+B
         UZaM86JaqIPyaPK4afzhwvHnYPQzv2KOZgTLQsUgei/TZL2snx1sNLBoeNsF3BGKP5Ya
         FjOa3KpfygTLwULHaJUj0Ju8O2w+UEbD0fkBebDJ4UjR8wQE7kDo7ux1h/YytgOBpPh0
         erDA==
X-Forwarded-Encrypted: i=1; AJvYcCV9aiEJ8jtjjRNYfSfaCmX5zd0cc1uiiKaojgbM9z8qCQvqjDl6alnABO26LK+zMamdzqhCSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxcHPOGkjkKa0D05BKZuUDDmNicDBYKEnqJuQq+aWMNgKrihjlI
	EZPEZ/NKvO6Mzkd/3jScqjK4hagNGU6eFrp3+w622RSCfJghJi7bwi5nrleZ6FvupMY8IwF07uU
	AjGoFWwcEmic9Acw26Q==
X-Google-Smtp-Source: AGHT+IGf3SSTcSDNX35lGHyTDeVfIkh75oyqd6PvBpSYTmqxSNGCpLyaYAzVUgwUDnODNmGVYD8Jy8eTO5xF54g=
X-Received: from wrbeh10.prod.google.com ([2002:a05:6000:410a:b0:42b:33e5:ebb6])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2911:b0:429:cc35:7032 with SMTP id ffacd0b85a97d-42b52821778mr17645835f8f.23.1763397247461;
 Mon, 17 Nov 2025 08:34:07 -0800 (PST)
Date: Mon, 17 Nov 2025 16:34:06 +0000
In-Reply-To: <8A5C6836-992B-477A-A77C-EE0736166552@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251112-io-pgtable-v3-1-b00c2e6b951a@google.com> <8A5C6836-992B-477A-A77C-EE0736166552@collabora.com>
Message-ID: <aRtOfhNjlCavCTjU@google.com>
Subject: Re: [PATCH v3] io: add io_pgtable abstraction
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Will Deacon <will@kernel.org>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Asahi Lina <lina+kernel@asahilina.net>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"

On Wed, Nov 12, 2025 at 09:57:09AM -0300, Daniel Almeida wrote:
> Hi Alice,
> 
> > On 12 Nov 2025, at 07:15, Alice Ryhl <aliceryhl@google.com> wrote:
> > +    /// Map a physically contiguous range of pages of the same size.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// * This page table must not contain any mapping that overlaps with the mapping created by
> > +    ///   this call.
> 
> I don't think there is a restriction that forbids you from mapping a region that has already been mapped.
> 
> If A->B->C are adjacent regions, and you try to map A -> C when B->C is already mapped, I think this
> call will simply return length(A->B).

I think that such overlapping ranges are not allowed. It triggers a
warn:

        } else if (pte) {                                                           
                /* We require an unmap first */                                 
                WARN_ON(!(cfg->quirks & IO_PGTABLE_QUIRK_NO_WARN));             
                return -EEXIST;

Alice
