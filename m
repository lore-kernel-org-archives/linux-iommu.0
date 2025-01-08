Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B77619F133;
	Wed,  8 Jan 2025 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736349702; cv=none; b=fV/l6wYfUqJNU1TriqFBpvnPiqPAg04zGgjXqLrovvZ7w2LjYtnhZwxqNH1ULAYPQGXdeLimSUGdF1A8CvJjYcsD2k6iZkJso2ipKGrvaANXI95OSHT7DIzsNF6kIiLZj2vYTWSKIPIrvS10UX1z+5raj4nYhvqSLnmuEFmUGns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736349702; c=relaxed/simple;
	bh=Xl0LSoacZLsHbo71xmR9kSIXl0emO248cdGl+8gdm/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAIRRtWwzNPy3Wn3dW5/tw8WECcjYCKua8nJ4Z1VowvDx21d6mxRwjJAJXqUD4857FPOlyEZiMAzri9ZKTft8Euy9MTzlnnq7pNM0FgNof7k7OC+CQnpB/Iosvvq5OU5Ac3AjFbbLXzycRdCK1KCF7S0we5QjL5OBPxyVwGRTq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cqh7vWO1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cqh7vWO1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A940AC4CED3;
	Wed,  8 Jan 2025 15:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736349700;
	bh=Xl0LSoacZLsHbo71xmR9kSIXl0emO248cdGl+8gdm/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cqh7vWO1XCT2ahQQK02X3kmpwDUiRdBfKDkL6W45+A4vmmppOxvKv5P4uquHGQR7F
	 h6GnEBAgQ21zflEx/lqLzqwmseGcwxr/B9VuH/piuAjh6WjIHTubGHyxf7PCG1fHaJ
	 8i3TGFNyN6I3NfvExmB9avzsbFmvMMZnH6jky6z0SqdseZ15LJGx6HRd2F49TS4Ma0
	 KEyPzx0V1gqPlxchSGjsnLRPBTBtl25zntsZA/gxxs21RLP0kqnZnJbWTC4qjGEBqq
	 vtFBjqmYIWHT5DqGELGgcmfMZDR0RfWz9t6QmkGgNOTeClGDM20Nwt4rugms6TKoMb
	 P1fSY29TiJFVA==
Date: Wed, 8 Jan 2025 16:21:33 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	daniel.almeida@collabora.com, aliceryhl@google.com,
	robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
Message-ID: <Z36X_ZnCmBQBMoZ6@pollux>
References: <20250108122825.136021-1-abdiel.janulgue@gmail.com>
 <20250108122825.136021-3-abdiel.janulgue@gmail.com>
 <20250108135951.GA18074@lst.de>
 <CANiq72=R2N+QiCiHZQu-6YJ9aYpn_bik3BW3U=nAW3jL7unzLw@mail.gmail.com>
 <20250108151858.GB24499@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250108151858.GB24499@lst.de>

On Wed, Jan 08, 2025 at 04:18:58PM +0100, Christoph Hellwig wrote:
> On Wed, Jan 08, 2025 at 04:16:18PM +0100, Miguel Ojeda wrote:
> > On Wed, Jan 8, 2025 at 3:00 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > No rust code in kernel/dma, please.
> > 
> > What do you suggest?
> 
> Keep the wrappers in your code instead of making life painful for
> others.
> 

What does "your code" mean? Duplicated in every driver? Otherwise
rust/kernel/dma.rs seems reasonable, no?
