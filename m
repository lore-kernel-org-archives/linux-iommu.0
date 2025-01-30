Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61953135A53;
	Thu, 30 Jan 2025 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738238421; cv=none; b=s6ew2IIWrlISd6IYbPDQx0R/uaB745FLVnDeILmcBQUjhCjnlVYo8/QUTRzwn/2rHtsBf+K79xWj/wPXIjRsZh/AdCNN9B6aM3j30QbJnz2eMuH383ah1stnPGlKViQc+nBaXLoRNbmqxXRT68du0n+JNl41EgXygBhmd2er00s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738238421; c=relaxed/simple;
	bh=cvoJe7oWPzQIq4UrBuClnefTcQ27uAPLNOxky+B1l9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G51f+DolmZG1BP2PuzAxXYpc3MiIp4Bo8eQToQxnnST9i8nAS8+MPs+zpOJzK7wlx2m3fuTdYKnMWjg3LK0QOTiT4BCXzPX4gp62sRBjKAvlCn4sbwhwHSSZWI5fPkQDwZxEDQ7KFTnutc9xOJnLZXYJsyjzyYJ+G1VV5hsB228=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scbH9EJt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scbH9EJt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7773C4CED3;
	Thu, 30 Jan 2025 12:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738238420;
	bh=cvoJe7oWPzQIq4UrBuClnefTcQ27uAPLNOxky+B1l9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=scbH9EJtyEmLDEtUm/pLupMBiqkraKGtcJzxbXZQsHR0/nyFyG/ocx+8vokj/b8nW
	 cRCSdBkF9MSo2wibVPz1UJoHO2KlamuqBuQGAJiwKlB3KhI2nJF/RGTGdr7sVEMNb8
	 ndW4cGUuJF7z4AmoC6dedvZrEsxmKqt820GyGBvD/MlYv2W0ADyPlRCtgKYgyINyyy
	 XTJ/ezwl9IWJOmCst+1HQivRSllF3beJEabNCdwjXfjUcAN8gJSfACGWZCE5/Jzq/m
	 9mk3Alobk1WAn7+s5kQ9G/m0XteuUyORaLVBe7pEPtHhtDEkIQGsGi2IWBTjzEj1Gd
	 yXrobkFsRw7UA==
Date: Thu, 30 Jan 2025 13:00:14 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
	aliceryhl@google.com, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v11 3/3] MAINTAINERS: add entry for Rust dma mapping
 helpers device driver API
Message-ID: <Z5tpzt9dET7kOJ_h@pollux>
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-4-abdiel.janulgue@gmail.com>
 <4956d01e-2d06-4edd-813b-9da94b482069@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4956d01e-2d06-4edd-813b-9da94b482069@arm.com>

Hi Robin,

On Thu, Jan 30, 2025 at 11:49:12AM +0000, Robin Murphy wrote:
> On 2025-01-23 10:42 am, Abdiel Janulgue wrote:
> > Add an entry for the Rust dma mapping helpers abstractions.
> 
> Can't really speak for the Rust side of things, but I could be an additional
> reviewer to keep an eye on the DMA API angle if that would help.

I think this is a great idea and it is very welcome and appreciated.

- Danilo

> 
> Thanks,
> Robin.
> 
> > Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> > ---
> >   MAINTAINERS | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index baf0eeb9a355..4808c9880b3e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6822,6 +6822,16 @@ F:	include/linux/dma-mapping.h
> >   F:	include/linux/swiotlb.h
> >   F:	kernel/dma/
> > +DMA MAPPING HELPERS DEVICE DRIVER API [RUST]
> > +M:	Abdiel Janulgue <abdiel.janulgue@gmail.com>
> > +M:	Danilo Krummrich <dakr@kernel.org>
> > +R:	Daniel Almeida <daniel.almeida@collabora.com>
> > +L:	rust-for-linux@vger.kernel.org
> > +S:	Supported
> > +W:	https://rust-for-linux.com
> > +T:	git https://github.com/Rust-for-Linux/linux.git rust-next
> > +F:	rust/kernel/dma.rs
> > +
> >   DMA-BUF HEAPS FRAMEWORK
> >   M:	Sumit Semwal <sumit.semwal@linaro.org>
> >   R:	Benjamin Gaignard <benjamin.gaignard@collabora.com>
> 
