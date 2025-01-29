Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFC618C031
	for <iommu@lists.linux.dev>; Wed, 29 Jan 2025 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738138405; cv=none; b=g+LThH8XH23YezR/9xNwLlOF5uyvl/hbbhYqJXuLGX+u8HHD5F2yIbyYiIRzJ4pyDBoSp2rdYTFQyT3MA7QxH92Lf6i5ADnVrHB1ZkW8Z9ueFW1dkRAWXNVPYbolQq/vxdKQz4poGKAhyAUUPQFTKFU0hVk67MFH2dlgYPL1BuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738138405; c=relaxed/simple;
	bh=XFTTej/dvTxgXd7tcm1FQNxU6aAOMe5wPF/TwbxmyU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/A4xOAdGxamIz8itJCsx3G8cGdke9YdaIq2DZF9TbWrUfOPoiFxE1QmKdlTYWzvhqe+DIm/Y66pg7OedLs6lF0PzTkMaaxVzW8lyH8LP2E3qOAh5kxxFjSJOURCmEzOWR6X5uJfl19N1dGtGRpyvnk1s86uBqOhvQJY8UFKpvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBNhInU4; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBNhInU4"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f2f5e91393so1531525a91.0
        for <iommu@lists.linux.dev>; Wed, 29 Jan 2025 00:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738138403; x=1738743203; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFTTej/dvTxgXd7tcm1FQNxU6aAOMe5wPF/TwbxmyU4=;
        b=gBNhInU4bj885gfYfZCWiQCQ9Qm322xhz/Nh1BKRy1cIV1Sx8KUEruaz42qu5E3Dj3
         2Cd4IjCAdGgqe1Aj+GKH9Jue+yMTWpycQojwGOULQUX28UtmMt/NJ3aF3zQTIFGbdO0o
         JnjxZwuUXuBTfnHxyLhjukGCebCBgpQXiODYyQMznkGR2Hzb4JKYB7ETxwcbEtlTDKiN
         +AD4wN2g+kfMGil+5y8+JYrMEEVjvTvwMmt6EoWuyytJjGAb+woQSHs7bJY8uL7CbK6r
         sjqNOBSeHEYsmjYyZUsXak5c0te7JJ544gTIrZLFC4UC5QwbRMFiUbNIWusJKteK4zi+
         8WKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738138403; x=1738743203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFTTej/dvTxgXd7tcm1FQNxU6aAOMe5wPF/TwbxmyU4=;
        b=PMgX5lPkXJwwruKONvzfRJNTWKOgXOszn1PLkas3mCf9cZPuJBeG87s9NPBpZSme9A
         YIKXyW+skbmd8yv9IFQqwxV7PTTe20pGUI2YsNTRPANO4LLXOe0y56ZNb9nMUUwG3RMy
         D97PVgq9XvgdpDINW3yciA6uc9mPd9L7RM229tLrNNK3QAEfFUnsRYcTjLRiAEdflJoY
         FmqSnTK03WmSYyhM4nlHZl2TMH7nnGqrkIgc4DqANDFxC/Tm84l6pV86qe/SPvtl516i
         rutBu2bSiZX2gGdjR4gJYQUe6yvePGn+ZtBPoy4HLFqN4JeWdQMw/bhRD+O+kxEKG2cS
         cM/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJWVqk8YJ8k31QkZfW+kQ9pEufYfXhlK1yz3OTTbPDKO27NHFloiusxju9CbvNguWepV7HvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzZi0ahBzvhQOnHHB8dIhVtd0iCtcUS0Vx12KucKzy68DzWOIH
	/1SsYPnSCycIUhAbt30EEIKu1awoLTS7ujaXoxEfhXEmgrD1rb8z3nn0BKqN1xrxdrE2AxicZgd
	wZaGeF/AkIPd499wYwRvs4pYraBY=
X-Gm-Gg: ASbGnct37gIG+e4oUvwZUbsf6EbKyKhSLXTGdSUAF8ogd3C+WA8IWNWx574Q3gAutex
	0cZ185YrOhrIiYnm9aa/Gzjeo/VPSS0g6bpTIdvoM4uCrhmOG5P2ymUxslbyi0Mck7uUU8/odfg
	yBSZv7xzPwOnrmMH2hhkHMivGd4qe8H/6kbqXC3rxZ
X-Google-Smtp-Source: AGHT+IHBHb30ocjFfz031920JR5yGABISrgLDuRo0AE0Z5+F+Bp9aNXEvXMsXF0o3GOG2yHzQeNOoXUPJjGFgV8n15w=
X-Received: by 2002:a17:90b:5188:b0:2ee:f64b:9aab with SMTP id
 98e67ed59e1d1-2f83ac7a07dmr1270046a91.6.1738138403203; Wed, 29 Jan 2025
 00:13:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAEHp+Gasm2ZuYPusn1ZsMuePpjV0atutVGTr9n3-DT=tQODYkQ@mail.gmail.com>
 <50b71ac2-b84f-4f09-8795-d1c89a7c56af@arm.com> <CAEHp+GZRNApNBxznU8YioJO7+ezosKtUmTqaQXe8J6r2QyGjcw@mail.gmail.com>
 <741c6f7d-e36b-4ddf-a92b-9bbed2ce75c2@arm.com>
In-Reply-To: <741c6f7d-e36b-4ddf-a92b-9bbed2ce75c2@arm.com>
From: Dima Stepanov <dstepanov.src@gmail.com>
Date: Wed, 29 Jan 2025 09:13:10 +0100
X-Gm-Features: AWEUYZk4WvLDRdCQm5FwA_NlINlDHfem5Gau2w_kc5n735f_VbtDQngDBezmslI
Message-ID: <CAEHp+Gb3CH74DTsvVg1VaXJrMqZ+YQDcF1c930EKxQNUSKH3-g@mail.gmail.com>
Subject: Re: [PATCH] kernel/dma: dma_common_find_pages returns pages for
 requested address
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 7:53=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 27/01/2025 5:47 pm, Dima Stepanov wrote:
> > On Mon, Jan 27, 2025 at 12:50=E2=80=AFPM Robin Murphy <robin.murphy@arm=
.com> wrote:
> >>
> >> No, that's a bug in the caller of dma_mmap_attrs(). As the kerneldoc
> >> says, cpu_addr/dma_addr/size must still represent the whole buffer as
> >> returned by the allocator - any offset for the mapping itself relative
> >> to the start of the buffer is expressed in vma->pgoff.
> >>
> >> Thanks,
> >> Robin.
> >
> > I see, thanks for clarification Robin. I was confused, because dependin=
g
> > on the backend it will work or not work. But i believe that in this cas=
e it is
> > undefined behavior. That is unfortunate to me, since the idea behind wa=
s:
> > - The memory allocated once because of device/firmware
> > - Different users could request a part of this memory from the kernel a=
nd
> > mmap it
> >
> > And i didn't want to expose this offset information to the user. Wanted=
 to
> > rely on the kernel to mmap the proper part of the buffer.
>
> In principle I don't see why you shouldn't be able to create multiple
> files representing different parts of one large buffer - seems like the
> ops for said files would just need to be a bit cleverer, and remain
> aware of the whole buffer as well as the range of their own part within
> it. Then they can adjust vma->vm_pgoff accordingly before calling
> dma_mmap_*() (and possibly perform their own stricter bounds checking as
> well.)
>

This is a good point, i think you are right. Indeed in this case i could go=
 with
the vm_pgoff approach internally without exposing any information to the us=
er.
Thanks for figuring this out!

Thanks, Dima
