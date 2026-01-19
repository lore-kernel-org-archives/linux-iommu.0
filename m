Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBDC35580C
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814997; cv=none; b=Sd6YL8DgBSkK+P6qjVjR3qasHMh7o+jhmBnBU31GuiDaEfhvMHo4oanxluof1QwaQu/rZ90CcPu2KIMHs2mKvDgtL8oDtGK5eC+rgPDEImCYdw+IX9hG6VNzKa3NIhWaMdeuv/uNueurQ8Lur9pZwNwq4UkNrvlgoV6I9/DK7FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814997; c=relaxed/simple;
	bh=OmaA48PF+aapLbo0XX9BQ2SwdV9QU57r0NNgj482gLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9qSn3oBsNMvguiRyleVz2qBbXz+KrwVGh4d4dFwY6yRpsFObgZw7H1JF0jNqOCj0+qE7mwOFw24MkDK1KcpV8eys6gRdCQYoRTfQrZTfinv5SZ4P7/q7SyciMY9Ut/NCNSriA17u/5AS5Rqlu7aeBspwsFmXbi4uMdlO/pHUaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=XBB3+nws; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="XBB3+nws"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D3A475F66E;
	Mon, 19 Jan 2026 10:29:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1768814993;
	bh=OmaA48PF+aapLbo0XX9BQ2SwdV9QU57r0NNgj482gLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XBB3+nwslOlxvH2r0ONrj19bvLyQ6WtMJ+Mc99P308UvnrrcI7U1RHRqEkVobDC6M
	 6W4PpLU1BERoC/Zcmv8ZZo+1+dY6wd+md6a92BEeTXQnC+t9AFzNewOYizMvzna3ox
	 Xv91ZZ5UROezfB+gv5pwicqQpAfmEKa7fHP7k6/UecPtB59ao0DJlgRPOx+uyQJkvB
	 VknC8ZkDb7sA1H8CJFSCtnCs7vyvT4ZMJjnp2UjZfi4b8G4hWxjbF1DMzPtF6t0ZV3
	 k1f9fMH9UVWbcCid+NC2asTt1tqgSmk6luOKXngq5u0g7HJd2KmZH+nX9Tj0fhNT8W
	 Udf5vnVbIYJRg==
Date: Mon, 19 Jan 2026 10:29:51 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Will Deacon <will@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Asahi Lina <lina+kernel@asahilina.net>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, iommu@lists.linux.dev, 
	linux-mm@kvack.org, Deborah Brouwer <deborah.brouwer@collabora.com>
Subject: Re: [PATCH v6] rust: iommu: add io_pgtable abstraction
Message-ID: <l7ww4wkdplczyuiqqrjn7nx5jf7fn6ffl4hwfn2pyls3wy74uf@gmmufe6ncy3j>
References: <20260118-io-pgtable-v6-1-423846996883@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118-io-pgtable-v6-1-423846996883@google.com>

On Sun, Jan 18, 2026 at 10:08:08AM +0000, Alice Ryhl wrote:
>  MAINTAINERS                     |   1 +
>  rust/bindings/bindings_helper.h |   3 +-
>  rust/kernel/iommu/mod.rs        |   5 +
>  rust/kernel/iommu/pgtable.rs    | 276 ++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs              |   1 +
>  5 files changed, 285 insertions(+), 1 deletion(-)

Applied with Danilo's suggested fixup, thanks.
