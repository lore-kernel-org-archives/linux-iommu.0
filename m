Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060F426D4C6;
	Mon, 23 Jun 2025 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750693384; cv=none; b=KmdLK5SnOovyb1sfQNBKNCQJMdi9ZGFk6Gyc0axXo5rjhhoQsno8aTkkhNKjw7sxAO00z+g+gY1N96wDNDcRQLJA+JxVbJgaJwst5cIeeZHFkfSke2CJCxz1hpKVUHYqCV4NSJEKzgO1ktsz4e8LXfvjZvgVe1TwT7v2GioGees=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750693384; c=relaxed/simple;
	bh=DEsBc+hs49pm8VweFdAsT/RduB+CaSEOw49ute5T254=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQcHaHLObQWICP9igmBC4U0WWueLKlEuxhVgGjY1Q41kroq/hdYBCOh60tJp0Ci3n4FOkEZFLwBh1yESIzpbPIaLLigOReacAWwOUUuKYymCGf7+OJUk/zImrHERzH8yXq6sjTWSFUYUNWl8W2NnZOGEcrvHyaxE4c4u+8dXrrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uo4+3kr0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uo4+3kr0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C80CC4CEEA;
	Mon, 23 Jun 2025 15:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750693383;
	bh=DEsBc+hs49pm8VweFdAsT/RduB+CaSEOw49ute5T254=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uo4+3kr0C+qRmuQBrmqoJaywznJcg9JXcxC0SHXwxKUQmxEDdm4JkwJlAYxC5d3SY
	 l7OXpXpZZv8GJ02aC/3Wr/+lBCRAfuLUGNiNDC6cjQIj5yIuQOP86smwD5zZis1Kcg
	 FXyMj4UHdoQsBM73LciSAVKbsnh7tsrpzPi4TK7s+QRuKiWzRfM9MQdGFlEElhIwVH
	 31Kygn94r2vDUsKKl/6kT7ujEcpjJtdeCaT4iHPWi2FwCLJReByCSUbf5Ibp2Zv4CX
	 E8XmFyr1NwFrBE/fBG+8jhi1jWsYRoTobogifQGKilvlmxib8Lb0VmRI0FouG1UTza
	 9Vo+0s8N5FpvA==
Date: Mon, 23 Jun 2025 17:42:56 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: acourbot@nvidia.com, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
	rust-for-linux@vger.kernel.org,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Petr Tesarik <petr@tesarici.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v4 0/3] Additional improvements for dma coherent allocator
Message-ID: <aFl2AOUQ-CKYgIn8@cassiopeiae>
References: <20250602085444.1925053-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602085444.1925053-1-abdiel.janulgue@gmail.com>

On Mon, Jun 02, 2025 at 11:53:10AM +0300, Abdiel Janulgue wrote:

Applied to alloc-next, thanks!

> Abdiel Janulgue (3):
>   rust: dma: clarify wording and be consistent in `coherent`
>     nomenclature
>   rust: dma: convert the read/write macros to return Result

  [ Fix line length in dma_read!(). - Danilo ]

>   rust: dma: add as_slice/write functions for CoherentAllocation

  [ Fix line length and slightly reword safety comment in doc-test of
    CoherentAllocation::write(); fix formatting issue. - Danilo ]
