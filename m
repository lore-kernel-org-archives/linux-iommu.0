Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDC738BF9B;
	Tue, 13 Jan 2026 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296311; cv=none; b=rbvizAaNfygqW+rcq6/0Kb/aVNxvrgezW5AzQ01ka3d/W+7gtpFaqM5oxS11kMMuMKaI3djOlFxTW+pe72WrC24hC/PSKE2WZ2PQfl8p6z8hykD4BJ80m/KS2lSz5oyxBLy5Wik5daF6/WemOuhy358wliUfgGKRMH2+9jq0i7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296311; c=relaxed/simple;
	bh=5WcDfOtEjk2CZ85KBhVtVus8q8w9KHZIwPMUEvSME1s=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=RO5r/plVa0dMslVDrOw1jb6rXzAP30i9KHv4cFEwQ+OiC9losjDd0RxcVKlTFlkpulMsBn4QVXmCuLXJKmzmUDeSpsMX9J5dnClQimX5zPwHajxopTY7PZo+/HOtdflAMlCrmroeiW5ay/ByiEBKwkmcbaFIRYtkZ/vdOtM4PNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qzw+nhTW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qzw+nhTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1994C116C6;
	Tue, 13 Jan 2026 09:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768296310;
	bh=5WcDfOtEjk2CZ85KBhVtVus8q8w9KHZIwPMUEvSME1s=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=Qzw+nhTWNXpxN2P2pyNSziV4x3a65LBSG9ra/AjxaG+vmZC3LvrsdgYFjilsd0PWq
	 78OK65dQW/pLg5ROTawBuuLxwF/mSd8/Ii82NWpXFhREbPoYBrppXv0ZdgWxra4Bxl
	 7t70BTER+DRhEuO81b3GlTLiOrVn/rual86e4f/T3IJQXCXWywXeKiHlIY7+pPe5u2
	 ZV7iV8/vAQsKB6h1Uj5Uzip2/jKuLPPUr7WUW/sfF8EC73PRg5IAHk99jU3of1B0LI
	 oGZ/2knzQTdGaQ7KF/Y7oJseWpH8ITEJcD59UJvy5UttNWZ8Ropg2aAu5zt8kykGFN
	 IVNZJHiN0NH0w==
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Jan 2026 10:25:05 +0100
Message-Id: <DFNCQ48YFMOM.3MX8XIT2I7UET@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v5] io: add io_pgtable abstraction
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Will Deacon" <will@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Boris Brezillon"
 <boris.brezillon@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Joerg Roedel" <joro@8bytes.org>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Asahi Lina" <lina+kernel@asahilina.net>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <iommu@lists.linux.dev>,
 <linux-mm@kvack.org>
References: <20260113-io-pgtable-v5-1-7ed771bc3d8d@google.com>
In-Reply-To: <20260113-io-pgtable-v5-1-7ed771bc3d8d@google.com>

On Tue Jan 13, 2026 at 9:49 AM CET, Alice Ryhl wrote:
> We did not discuss where this should go in the MAINTAINERS file yet. As
> an initial suggestion I added it under IOMMU SUBSYSTEM, but please let
> me know what you prefer. There is also a DEVICE I/O & IRQ [RUST]
> subsystem that it could fall under.

Either sounds good to me.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b11839cba9de1e9e43f63787578edd8c429ca39..eccdb937762a7545fcd5db019=
4ab7c1b6dfdfde6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13241,6 +13241,7 @@ F:	drivers/iommu/
>  F:	include/linux/iommu.h
>  F:	include/linux/iova.h
>  F:	include/linux/of_iommu.h
> +F:	rust/kernel/io/pgtable.rs

If it's going to be IOMMU, let's move the file to rust/kernel/iommu/, other=
wise
it gets picked up by both entries.
