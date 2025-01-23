Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C041121171F
	for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737641780; cv=none; b=ESfAHOH28iEDIGLhlRbCt/POost+wdXwthhDIK9HaNNmgHcLpRBBG3bcRrgS4t1CvGCU1HeaS5kE7ekY8FBNDiPqrklqXlohFrvvdI7fuWNTrWNx6TdeZzlfzLrOZO1TPT+aCM+ogNNn48r9j5tpgQVr9wgIXgYQkA3NF62kPI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737641780; c=relaxed/simple;
	bh=wFQRAR+UbyxJkTdGtdDRCO/Ux+XBAI70FmckB2I+cz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dU0Tg8EbSZ5EXMmAhbGMPzeYYYVvOuaU+tm78dtxWyGuGhop2u/VTUWv9gLL5AA743kOP2ii0T0cc3/JAAnv56Ml31zzfCHLpsfpFM7hcv5mJFq5qd3aZAHqIYkt32JtjJay8Cw/feubSdrXBjBn+IQqUsuIcbZInvOaN7pPGTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSU0lD7u; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSU0lD7u"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ef05d0ef18so240851a91.0
        for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 06:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737641774; x=1738246574; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFQRAR+UbyxJkTdGtdDRCO/Ux+XBAI70FmckB2I+cz4=;
        b=bSU0lD7uG2mx58wcND9P6n5x1SEJol4SOk/4M0P3qMzbGlh8+gj1bsHROoPQQQl34z
         qk+HDKV2QpNclUtRQLefSSF5A3kSPPA739VFQdNq8tbAvGFRnzGAtGPBTS93qs2MzzdS
         zuWiJG7bzkVEP3X9mDDUL3MYa4o7BeXjoDjHE1iyJ2DJ8/VYFqdddSiHFzyOoLfcQZcc
         xbtYjkuhV6e0LYswnBmQBbKp/UEHq7w13pMkp4tblLvWdjtAhF62RYrZIZKgflcuW2f9
         GZ0BO9Xldx04C7izxdmpEbsO5ndQWBCu25U53OnS8OE3xqv/4gtCVHD+k9C6JgJq/B7F
         RaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737641774; x=1738246574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFQRAR+UbyxJkTdGtdDRCO/Ux+XBAI70FmckB2I+cz4=;
        b=h9Q822FG4O52moGZN6E2kCn+zvqNIdUDJKGLsRRnzol9cQT8NcPM1gyhnI+Ov6OjhR
         4n/AFfEqH7rndBEdiSbZRVzGGMWSgO/iQHeddy15yQkiMPI8pw0Z98m2cDD//xboVFzA
         WPrQz7exireTM7TkJccBUjwiq/l4xhEFbJJDY5cVZqzCPhKFm3aMzQTanScVR1P3WDAw
         e64RbBtB8WNy1+H7J0BdPhd7L5aKuUkCwhPCBrqq8pNDwdEKNKNo8156R5FaAXQ9tt4F
         GgGmK7ghuBD5FxlohZU832uGiI7z/7Tfs8CQNo+sPO/OcbBIHv/gPGpmqLoF0v0gOf3o
         rLoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl60ZlZ8l7VruG4OdjWtuL22/nS281ywla1kcd8cEy/GyZSe/G32iwQhhjcBrR74sYNgAZXA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzosEErotVFFzWqmifigAFbX//RVcV1dE3ZYogmx7OT6LA4jZbq
	qDJO46J5GsVpYL+O0p6x8qjIpgGB/Vrcg9INLhDQPhCtEfOb16uZJYMfCTWBRPovGp96/6M7Jlf
	YSu+/AJKw/ZkxRUJyagfOy5bpqdc=
X-Gm-Gg: ASbGncvLiPq+/Gm/qbvRLc2EqlsJK0lfptOGEaP8KO8g+UTEo9Hoy6lz4UCctf81tv9
	6QuWFkNO9t3MEE//OuKOdc+WPmQDUVj0fqsAo8G+fRpWIxaRbxGO0XNV74G2wDQ==
X-Google-Smtp-Source: AGHT+IFBX9h1NFlbamzZYz3CLVXkBZMBNrCE/6iJV1TBzqE1M0MU4IUclfvJBkpWZfb7odXJ+Uv0EZcFXS/q+Mtdoq8=
X-Received: by 2002:a17:90b:534c:b0:2ee:6563:20b5 with SMTP id
 98e67ed59e1d1-2f782b06b52mr14477214a91.0.1737641773986; Thu, 23 Jan 2025
 06:16:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250121191432.1178734-1-abdiel.janulgue@gmail.com> <20250121191432.1178734-4-abdiel.janulgue@gmail.com>
In-Reply-To: <20250121191432.1178734-4-abdiel.janulgue@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 23 Jan 2025 15:16:01 +0100
X-Gm-Features: AWEUYZlZEiZq2V2b3wTqB9B-oPb5SNJJ-KNqQmn9GobBkSA8HfwoUjNt9_DYBa4
Message-ID: <CANiq72n4cgutTCcVa+Ee4jnsELxfmCrvotZQCVO8aQ1J3ppTNA@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] MAINTAINERS: add entry for Rust dma mapping
 helpers device driver API
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com, 
	dakr@kernel.org, robin.murphy@arm.com, aliceryhl@google.com, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, 
	open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 8:14=E2=80=AFPM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> Add an entry for the Rust dma mapping helpers abstractions.

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel
