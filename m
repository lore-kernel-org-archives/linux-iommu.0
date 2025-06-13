Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEBD79F5;
	Fri, 13 Jun 2025 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749819026; cv=none; b=WoMwG0ICzgHu0NGkMx4pbhw/lIXCub1Qf/lWuacOdQlMwi5fuk085LDhydg3OdlgmNIl6aHcPfIYsA6WQYYxa/UfQ1pe+ey4E0J2ktrbtpP6EtpvADb/ZsbLxqLgSgYT312J6DweJAykBtAYYzOwCKYGtv/TvVzhtvmufdpy9w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749819026; c=relaxed/simple;
	bh=79WqwjURJrzcM8vb/SrEx49AYycjsLMAMZFEZGKyt8U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WhGeVtfX7O78nZwc7GI21xeMF7rSkavPiBF/XkKn3wSUHagJDsAtdC1yZRNBFE/iMlQ99MckgvO+JCRU9zvMOJ0GTxfvfhAEZgXDPgcKvvsJ6mch2idBvKDzYa5rbiOFsaV+SN4IPmkO7AvQJvMFKruXr2ME5jsGlRDh7lyCV6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEulPce0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEulPce0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55CFC4CEE3;
	Fri, 13 Jun 2025 12:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749819025;
	bh=79WqwjURJrzcM8vb/SrEx49AYycjsLMAMZFEZGKyt8U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cEulPce0chfJ/48f3xl++id2UE+66hPqoI/OwP4GXDX1qDNutroMdTPltj5gZAzNY
	 BKSXlPQRTjYbLZjJkM/VUTcD62fQOjAqYuENIvXb+pFlPhE2VLMsNKPxM0t4NPacXp
	 09IayyOwye8v9t0ujUPnQeFP82iuXgJdXs03fbfkHinzC3RvMUu0jUW7MegSx8oJo+
	 kJhBbYUWO6BVJh8yNhHp1RKOjl3sSx4JqKlD2b6Kj40UI4hpbbbfWw2d8G+P7kwSEu
	 FJ91hmg6iD5XK6M25MVyhtgva6tT2jTyRKhSOTCoivULEcYqkIoUhe6fnOqIdT/qKZ
	 s/AcHZQchhbAg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>
Cc: <acourbot@nvidia.com>,  <dakr@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Valentin Obst" <kernel@valentinobst.de>,
  <linux-kernel@vger.kernel.org>,  "Marek Szyprowski"
 <m.szyprowski@samsung.com>,  "Robin Murphy" <robin.murphy@arm.com>,
  <airlied@redhat.com>,  <rust-for-linux@vger.kernel.org>,
  <iommu@lists.linux.dev>,  "Petr Tesarik" <petr@tesarici.cz>,  "Andrew
 Morton" <akpm@linux-foundation.org>,  "Herbert Xu"
 <herbert@gondor.apana.org.au>,  "Sui Jingfeng" <sui.jingfeng@linux.dev>,
  "Randy Dunlap" <rdunlap@infradead.org>,  "Michael Kelley"
 <mhklinux@outlook.com>
Subject: Re: [PATCH v4 1/3] rust: dma: clarify wording and be consistent in
 `coherent` nomenclature
In-Reply-To: <20250602085444.1925053-2-abdiel.janulgue@gmail.com> (Abdiel
	Janulgue's message of "Mon, 02 Jun 2025 11:53:11 +0300")
References: <20250602085444.1925053-1-abdiel.janulgue@gmail.com>
	<9MKxKNA6QF7sSvlvmOX-7hZHeRN1N-Qm1EKm3nhZFgJLsmZAKhIrzu1ZeRy1w-4f7ZZGUEHhxLLILrq05UpOKA==@protonmail.internalid>
	<20250602085444.1925053-2-abdiel.janulgue@gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Fri, 13 Jun 2025 14:49:02 +0200
Message-ID: <87y0tvbydd.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:

> In the kernel, `consistent` and `coherent` are used interchangeably for the
> region described in this api. Stick with `coherent` nomenclature
> to show that dma_alloc_coherent() is being used, in addition to improving
> the clarity in the DMA mapping attributes documentation.
>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



