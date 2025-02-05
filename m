Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80822211491
	for <iommu@lists.linux.dev>; Wed,  5 Feb 2025 02:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738723290; cv=none; b=WiVlOkhxR0UClLeX7RvAHRcAtY2+dArnBjM+8eHdJAC5EMsyUFzWCpdGX4yGDCbl/bbkL/PEUVlPFIltqKpTnNZ+shwjl00XBupQCIOGRr7+srzpZuvKbjq32eyuYfwc3qS9Vc/q4gKZL75u1R4gQ3FekpAuZzih1KidxyqehBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738723290; c=relaxed/simple;
	bh=QwQn3prrCd9nf+gWzBIeH8P3iezKUf5V2n1S7gTfQSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elpvCU9BQ8/ka0FMFlG4NR2l9oyv197EPhWLWIULVUcsrCVK6FaIQb7WfLiSO9YwIwyPeG3NUvAuU91ZSSsjPcq36VmlGH7rOICfUFyCe9DA4tnEjloERmiRWo1kY/OcH05LZnOA0ZyUGp5QqwVhZQmrJpwAgSjqJg5yQzQfwms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJrGj/DU; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJrGj/DU"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-724f4d99bc7so1442041a34.1
        for <iommu@lists.linux.dev>; Tue, 04 Feb 2025 18:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738723287; x=1739328087; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwQn3prrCd9nf+gWzBIeH8P3iezKUf5V2n1S7gTfQSo=;
        b=lJrGj/DUHk/aOsdp3rYc1lfI3MOF3EBj3CBG8pNEpyZKP2HCNg5ly34qE3CwYKWwpW
         42Hh/7nd+zJaRniSV/ZHWQd2/GB0N7WtdioxAcBWme9jUhE5E964eexLbk7AGou318Ec
         +H+teTyiw99t3PcmbRw6hFiHSLFHSaebwaCZmHMvx1UNAfED4lTObkUCBvfN9IlykZ+1
         i1PuEY5lbEj01LoMQHeMfJl2JR0srSFxUxXlqSm3O6KOdd5+cu9PMO6F4Bsn73rSOm+O
         LmxAzrvRGUHhxSjxX8vzhLv0jjkaF0AXMu7b/Ne6KrD49vMWhyqHzEyjGHPf/THLx+JE
         5D+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738723287; x=1739328087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwQn3prrCd9nf+gWzBIeH8P3iezKUf5V2n1S7gTfQSo=;
        b=Hq571Lw1mJxpyPdzlNMbrZ3FVVhAqpztjj4n0BvrSvsi6TDyvrlmfsOQRo0G/zgnXz
         Oe+OU8IEOPVTLzpy1bCA0nqJud77oXMfJVAyuUJykBYmjTFjRqut8rvYWGil4DkLupe6
         OA8Czm6H8orSXrg/6Gbxwyqh3A4On9KbJy+jF6SbOR8aNUAH2KExSs/TAloffUZy2QTx
         et5Aru9U2RXRviwLiD7jyIA52RXhwQRF79JPnIBgtg6gvkrKxGBG5Z/+kHYMos+o2vPm
         pP0ER0GBv2SWpIGBqhhzXnSuKSOjTVGJJXp5dBNZ0KhITRBPOIuuzJ9UNidJ0UPNrra8
         MGbg==
X-Forwarded-Encrypted: i=1; AJvYcCUZULFpUpWiGVHlOBdNsPEkXZ5Yk06Q3lmO0i9G/10WWfBr8wb41fEvJfW6lvkIGd/MjiUXMg==@lists.linux.dev
X-Gm-Message-State: AOJu0YylMliYS0F1lszZsfulC/YPC4XRSi4Mo1eYI7ALDLMfr8U3MbWZ
	yxdIjuSoJxhnTD66PXATG/RIBMIaASAIuI17ejUiFfKEde8PRkolOPevLmoQjMedQilFe3LV4dh
	OxKKpBfgvoEQ95xlDsDE+d+1jZiw=
X-Gm-Gg: ASbGncvqw6zTYQKb/R9aY5Do1VjF+9O9vMdhIHGmek0i2rhwc0ILZUjLLC2X+HNW1ST
	nPaFqA4E6nzVBLuGNOOm/CwHoUGyxAZVrghfEqDUZymgpRl7HRPNyHGBorEVib7vtX2Zxx7uQIw
	==
X-Google-Smtp-Source: AGHT+IETE5RM6ytR4I0MAoaOcUYN/nT4zaRWwsSaMUFzY7MuCNXhcUa43uNFxmzefRwg1gzObIY0smWMYi3lZSbjz34=
X-Received: by 2002:a05:6830:390f:b0:71f:c1df:187e with SMTP id
 46e09a7af769-726a428f697mr1007784a34.27.1738723287529; Tue, 04 Feb 2025
 18:41:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250108122825.136021-1-abdiel.janulgue@gmail.com>
 <20250108122825.136021-3-abdiel.janulgue@gmail.com> <CAEmX-ZUbPqNUBj2-xAf=5uGE_GWAQQ79akADZCDxNsmx7Lf9VQ@mail.gmail.com>
In-Reply-To: <CAEmX-ZUbPqNUBj2-xAf=5uGE_GWAQQ79akADZCDxNsmx7Lf9VQ@mail.gmail.com>
From: Thomas Hampton <thomas.j.hampton@gmail.com>
Date: Tue, 4 Feb 2025 20:41:16 -0600
X-Gm-Features: AWEUYZnrN-ey9XldwNfEx9_sBu9MokwgLKnIwcLv6TBhp-pMZofzcBpx-zH6lCs
Message-ID: <CAEmX-ZXg0w3RHN7hYe4bFOcg9srNapQU18JjTAWbBjwWurNC4g@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>, daniel.almeida@collabora.com, 
	aliceryhl@google.com, robin.murphy@arm.com, rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Valentin Obst <kernel@valentinobst.de>, open list <linux-kernel@vger.kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 10:54=E2=80=AFAM Thomas Hampton
<thomas.j.hampton@gmail.com> wrote:
>
On second thought, this wouldn't prevent the construction of a closure
that simply extracts the pointer itself, nevermind.
