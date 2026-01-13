Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193D61B3925
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 21:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341073; cv=pass; b=HX7WzyTrXXwDi3Cg0l0wluQEpogSnXpUjVTWK+eR4fHJR9IIqTW/0YMf1jHz9ZnbPMThnh218zMjO6Egg2qwVWjiisQS6t80e41U6EqekM43n1flNtdjgnjJJ0g/fJQ2GsXZSqRevBfqi6iapOgkmsEa1gAleLDZYG7pIiV/fNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341073; c=relaxed/simple;
	bh=ekAUez4+2plL4pdPm5f1N1qqBlyBPKjY8j6Kb8XqgmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2xfessP2UAAUkmlhHMl4ZH+DHN7oZ16U13R6JVi4BdVsOkcciNwDYsxGGOs0dCVYPJ0eWVz5A1mBD+7lADG5Fs+foF6m/2D1pzSUvNrnqJL29Xc6BhK+fV+Ta4pGLUopXlgp03f4lw5HS8wvJqPu8ajvpMFL6AaSFCInKEnvS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b=IbYU7DmI; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="IbYU7DmI"
ARC-Seal: i=1; a=rsa-sha256; t=1768341035; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hVhzh7AUHTdxJu6JvU4kLmFazeYoDzKotMzv/D0+4u5XOphxRjl7dZTbxQS4N5Mkz3d/eIx3IvpTS931MdBemgUkwZATmz3d1Ag1d/KfBBEFCXSBOzAQteKzUS97haUtC+K3Yy4IKG078ZDvzWmTWcDVJfiJQXhFJCr6MYk2V+8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768341035; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DPLmlARrAcdXGkqRjXYNOZR541qNKastiV4OAPsNBiI=; 
	b=EZj3yMH0q9j4X6ixHTZ3mt+M3ALvq0gNqc/kJlCT0VrQ1bkUJakxrFuUkyq0bfXRm0HedxzFGlGbfWhmUmmrQEfzXdtzULlZGQyzhNAN5eTtKTJlsIQMu1PLT0lJk258gPp7GviAR61IDWtfUXBAJFf5FuTibTMiQ6H/IjvQHzs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
	dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768341035;
	s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=DPLmlARrAcdXGkqRjXYNOZR541qNKastiV4OAPsNBiI=;
	b=IbYU7DmIuRb+kX+hMyLBkx3DFwew+5h+AoOpYREVU3b0zeTRpjIkL+MS1wX0zerY
	v+XtqpaEwvaanAklDZfQVtzj6ZSmfxod8CenGAi8MzmDUF9SUmZGBREfF+kkkP2/kby
	bX2qewW7GYMa40KjmoW4SN+/T0+lwxaZgfBkpE7E=
Received: by mx.zohomail.com with SMTPS id 1768341034234779.9306294454532;
	Tue, 13 Jan 2026 13:50:34 -0800 (PST)
Date: Tue, 13 Jan 2026 13:50:33 -0800
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Will Deacon <will@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Asahi Lina <lina+kernel@asahilina.net>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	iommu@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v5] io: add io_pgtable abstraction
Message-ID: <aWa-KVC8CVvn8GGs@um790>
References: <20260113-io-pgtable-v5-1-7ed771bc3d8d@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113-io-pgtable-v5-1-7ed771bc3d8d@google.com>

On Tue, Jan 13, 2026 at 08:49:27AM +0000, Alice Ryhl wrote:
> From: Asahi Lina <lina+kernel@asahilina.net>
> 
> This will be used by the Tyr driver to create and modify the page table
> of each address space on the GPU. Each time a mapping gets created or
> removed by userspace, Tyr will call into GPUVM, which will figure out
> which calls to map_pages and unmap_pages are required to map the data in
> question in the page table so that the GPU may access those pages when
> using that address space.
> 
> The Rust type wraps the struct using a raw pointer rather than the usual
> Opaque+ARef approach because Opaque+ARef requires the target type to be
> refcounted.
> 
> Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
> Acked-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>

As part of the wip for booting Tyr firmware, I have been using this
io_pgtable abstraction including v5.

Built and tested on arm64 with rustc 1.91.0 and bindgen 0.72.1.

Tested-by: Deborah Brouwer <deborah.brouwer@collabora.com>

