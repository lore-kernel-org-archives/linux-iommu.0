Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47EF211A23
	for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 14:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737643506; cv=none; b=g8AuVOUmV0id0j3MscUI/lPfI/t1upOHpMZPPL+erqqoNyw3Y9yFg5XsvWkdpOfud/2f9dMd4Z7ZaySPnhNC/TFLtwi3V9gXcGC/5KR2leLVieH+v6uFIBbsx/RNRh9KwsbkBEPHKvnBoVcDUQwMmuCGjSCJ1dZjboouPNb6Zyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737643506; c=relaxed/simple;
	bh=59TAt9fjZIpo6zMhv5/0UQlSV+XK+wUgVioWGViGU/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=appQnYQxwi/FsYR5lKRzOWFuPHFza8mfJl4fHu2NHFeHcCIAwgl1nxJQQan7DdYLU8TLoaGvmH3gHJDykc8zjYUgTcWMu5rfrTRNlRMevCtAa1mI8BdXXSUWaq/jaLm/9auGHsJu/lqXxIcha0kMEVDtV9K3upK3dmF6Rk2YSGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHinL8B5; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHinL8B5"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ef7733a1dcso232823a91.3
        for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 06:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737643504; x=1738248304; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59TAt9fjZIpo6zMhv5/0UQlSV+XK+wUgVioWGViGU/4=;
        b=DHinL8B5ZNFEYoNs2rrvS8A/Rl9EuIGDYxJdmPyBY/tDpYgUo760++NhCMZKPP+AGU
         IBeZC991sQiHPFNyQdMe+WSYBcGbPFPHqsuG8d+lw04X+/Lbb4gRw+2ZgofSfkmuDGZv
         8TJ2QDQ5A9uZfRX7UWad8RRLXVLbMU+pKblTh0Gw2cIx9arFToHSzZBxIBZbMaJcNz4d
         t/pm+k4Cxuo7fjQzOhYfH3GWyYuJY7LdMlv5Czr4gxxJFPxmfG3Z7kbjJPABYs6taEXq
         3jDaIndnDJQudOadFH0+tb/y3xbeZG7rGSHtJppPocbnZVIbyKM0drdJ6hPF6Qh8Ubt9
         WBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737643504; x=1738248304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59TAt9fjZIpo6zMhv5/0UQlSV+XK+wUgVioWGViGU/4=;
        b=AlpCf+hTZIofu+3yiWhKVCa7f3J+rZ75XwUkx6MYWg14X7DbiIifb0cuDuPnXJYUCA
         fKisgK/ZIynFV1eu5Oi4p2t2Ui3FlNd/ZNPH3CDYsw1xpK79/J7No4NsuaypWgUcKB6N
         KGnE7eB15mZWEDDz/BCEzMv01qbLW/sX/ebWd/vVCwoWuswrM9o4YAkwZMbX8HS4N/mi
         ZOs3Pbyle14rVGqE/Op3thzSy/IaswbZtvmwT3uPLVjBfyniDDYyGhCtYICTbA/DKGZ3
         L2FCYnShfWPbILDDvIELe9d4PGrUQquSYsj8wWTyWNm37ApreA11fEJXFEitD6yJ4Chj
         RNJw==
X-Forwarded-Encrypted: i=1; AJvYcCU1yl1KdngeMjVvLzmyvGJr88KeB3ze/H7dudCudfPIhVCfKmk4pSkx2FbA5sMigSdesOyL0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5jq9srzaiVkpuNAsPa6hLFYooM8d86Nnj6ByupOtG5rGp2NgF
	ZWmuC/P6Qk2zWR9UoKbeAjDlxCaV7Aw4aKrW4AmDEkEONIHPmniu9TCPngQb95qG3+NwL9ZDg+W
	pMrLyCFEldolRDIOH+gI8Kp5xGpc=
X-Gm-Gg: ASbGncsKSeiEDZe/ers9rcPh/qgvh779DdKCcgE4klQwz/nMMWr5CvuSq+iMYK1wjQX
	cAy7tc0G+27AFNCmil170QO2c/NUnen/Mt0fyeaNtFtMdxLlul2PWH6+MsTNLUQ==
X-Google-Smtp-Source: AGHT+IGaQ0gL/+/weHSk8LSL+JDfJmOxyxmBXryc7xtAqA/LRkVP4oLH/9+rQROG89VDB/4UN7R1ubytmQDN51o977o=
X-Received: by 2002:a17:90b:3ccb:b0:2f4:465d:5c91 with SMTP id
 98e67ed59e1d1-2f782f9d2b3mr14018439a91.8.1737643504187; Thu, 23 Jan 2025
 06:45:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-3-abdiel.janulgue@gmail.com> <20250123132940.1f3c2666@mordecai.tesarici.cz>
 <cd25d3a6-c203-4460-ab7c-81fa4b56c566@gmail.com>
In-Reply-To: <cd25d3a6-c203-4460-ab7c-81fa4b56c566@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 23 Jan 2025 15:44:51 +0100
X-Gm-Features: AWEUYZmkksCt9G3YVgZQ6w0QIRxra5paOEbubhos0RuTJ3C_JxEeFHK6DmYSkm8
Message-ID: <CANiq72khT0LgvOd+JfYVx4iZpTVMzCDUiUteukHLjGOA_gLWjA@mail.gmail.com>
Subject: Re: [PATCH v11 2/3] rust: add dma coherent allocator abstraction.
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>, 
	Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
	daniel.almeida@collabora.com, dakr@kernel.org, robin.murphy@arm.com, 
	aliceryhl@google.com, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, 
	open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 2:38=E2=80=AFPM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> Miguel, what do you think? Would it be possible just include this change
> and the one below locally if you think this series is ready for merging?

Sure -- there is more than a week until the merge window closes and so
on, so we will see if there is more feedback and Acks by then.

Cheers,
Miguel
