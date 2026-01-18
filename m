Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BCF1B808
	for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768729858; cv=none; b=slcBnflVQz5820rLR1qbcV/fksn09+WMlr3yBZzklq6eT8vuUxS4OewTHwoMHj1W0OXE1G051XZ5pyjPgLoTFIVAHwgl/g+5wDbNmlOmAh3GgDckpOa+x3FODWyPq6ZLBmA4zbiE+t7F59SRykU6A89Efo0uwONPD9kdfeM+xl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768729858; c=relaxed/simple;
	bh=8PTSJ8pfJPlmOwYFvGwrXK5b9UqaO4C/h0rYTsruiqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HenjGSNphj/udNIexl2jFKm0lYmurmHasEP8BAiv9l7YH0Kun6fJBsUdma9sKUHQIVJV8lyukJxK2csvc+rSqaAmhSUeTHWNyVmTMEJECFhu6ENiDrOjI59bSwGp+o+b5VfhIfeuHAK06JnFdLbXJxUO9runqnhA09I8qP5Dmos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Rl41jstB; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Rl41jstB"
Received: from 8bytes.org (p200300f6af1d960047d77347aeef488f.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:47d7:7347:aeef:488f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1BEF65C16D;
	Sun, 18 Jan 2026 10:50:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1768729855;
	bh=8PTSJ8pfJPlmOwYFvGwrXK5b9UqaO4C/h0rYTsruiqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rl41jstBxXOX5c8HRJDBTxD4sOcPT7SO7m9rB1WimfWEdpH8/PiBpM4ZaiU8Rca8q
	 NQ2hnP/8BOBr5vIRmkHeqa8pVUqJsHvBGOBHlkDRDR5fyKuNGiUW4PILXfr45/bLIT
	 tU7umTsFvi6wfCWuOXB9Cie83xWbzHywUblnRuvb+x+YclEJwL+12/L8ackb1nBwWL
	 y/KtUqEy3koDjic3Uf6qFlIYEaD3ClIcHXfsKmDgOfVtSl4uXPnAhk+rH3a8K0SCK9
	 23nFhgJb6M0SJwNhzmuNJWYvq7S4yTnd34usNf5lOHI/+cfR6ABaGniHNrunaK1OgI
	 iUjmcWclgqs7w==
Date: Sun, 18 Jan 2026 10:50:53 +0100
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
	linux-mm@kvack.org
Subject: Re: [PATCH v5] io: add io_pgtable abstraction
Message-ID: <swz2lj4xhs6vjmjs56aj5u7pbk4uaqur3cqt4zoybqrx7yckg5@ifu7j7i2fmco>
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

Hi Alice,

On Tue, Jan 13, 2026 at 08:49:27AM +0000, Alice Ryhl wrote:
>  MAINTAINERS                     |   1 +
>  rust/bindings/bindings_helper.h |   3 +-
>  rust/kernel/io.rs               |   1 +
>  rust/kernel/io/pgtable.rs       | 276 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 280 insertions(+), 1 deletion(-)

Thanks for your contribution! I'd like to queue that for 6.20 but agree with
Danilo that there should be a dedicated iommu directory under rust/kernel/. Can
you please move the file and send a v6?

That directory might some day also contain everything needed to having full
IOMMU drivers written in Rust :)

-Joerg
