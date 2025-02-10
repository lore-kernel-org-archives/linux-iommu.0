Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334C31C7002;
	Mon, 10 Feb 2025 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739183055; cv=none; b=aWTX8A0ix0kFY85d10NAtNpDevXZucHx+03FofubT4qtP6Wkqqvwn4Kn3Z2uTnV/sCcZJx1BdaHjktu/Uqb6dEc4kM5cfCnQ1GiDofnoM6ay9h3akGuOczjhZaz/X/dbsETKZVprRZoeO6lPRIYk7+ZI45d6D7gJzVni7G2A7Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739183055; c=relaxed/simple;
	bh=TctaVDweRinYvOUGBU0wd63UFzTDTBKv9BZiXXpCc9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6hflpOMiw5hj74FVLa/JhWG42QwjLfGZ5UTNqlLP3D9Tic53seYOitxSDPLqoxLytdvvmVffISmTpz78tIJahqFDB8LtYacfeoX2s3taWlF+tE2AbwdYIz6mlInUDl8S71pdBHRj8l9ZQ1chOJPlrC9E4OAgXo9NobUM3VcqUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnxyMAmp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnxyMAmp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A394C4CED1;
	Mon, 10 Feb 2025 10:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739183054;
	bh=TctaVDweRinYvOUGBU0wd63UFzTDTBKv9BZiXXpCc9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NnxyMAmpYjpQViak815nMD2Q3JlAq3Zygy6vwbdlyHRtFyRXPpB1asssv+q0Mvih7
	 oSBdssa6nD+bGnMOfNizXItRLhGFMDW1fW+CI71oiYb9B0XlsQMQJAbaHTfTjPTKSB
	 mDqzPt0uRQrhgO9SSroduw8+Z54KwVIhOdCjD7MY5R5JiRBpMlisy6U287QhtJz+0L
	 hDx5R4iSMxs5sBxIJPwJHTR/Ul/38Vpz0CsQ5Jtn/34njFOOa8TPOQVeTwC9tqXV0D
	 FpHnUhjyTVwyzX0AhbV1dhTNfXSBnSkYsMYKRHGAf6J1wTp/j/2YYs0juHoa/Rsd+G
	 hS69W013Cv/1A==
Date: Mon, 10 Feb 2025 11:24:06 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Hector Martin <marcan@marcan.st>, Steven Rostedt <rostedt@goodmis.org>,
	"Dr. Greg" <greg@enjellic.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Airlie <airlied@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Greg KH <gregkh@linuxfoundation.org>, phasta@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	daniel.almeida@collabora.com, aliceryhl@google.com,
	robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	Bj??rn Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: On community influencing (was Re: [PATCH v8 2/2] rust: add dma
 coherent allocator abstraction.)
Message-ID: <Z6nTxks3u-ErSalQ@cassiopeiae>
References: <20250131135421.GO5556@nvidia.com>
 <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
 <Z6OzgBYZNJPr_ZD1@phenom.ffwll.local>
 <CAPM=9tzPR9wd=3Wbjnp-T0W8-dDfGah-H3Ny52G85B+2Ev9ksA@mail.gmail.com>
 <208e1fc3-cfc3-4a26-98c3-a48ab35bb9db@marcan.st>
 <CAHk-=wi=ZmP2=TmHsFSUGq8vUZAOWWSK1vrJarMaOhReDRQRYQ@mail.gmail.com>
 <20250207121638.GA7356@wind.enjellic.com>
 <Z6bdCrgGEq8Txd-s@home.goodmis.org>
 <1e8452ab-613a-4c85-adc0-0c4a293dbf50@marcan.st>
 <07c447b77bdac1f8ade1f93456f853f89d4842ee.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07c447b77bdac1f8ade1f93456f853f89d4842ee.camel@icenowy.me>

On Mon, Feb 10, 2025 at 05:41:30PM +0800, Icenowy Zheng wrote:
> Furtherly, the monorepo nature of Linux kernel means to refactor an
> interface, it's usually the person changing the callee that need to
> change all callers to satify the interface change; having Rust code in
> tree calling the interface effectively means adding the responsibility
> of fixing the Rust code when the interface changes, which could be not
> acceptable by the C-only maintainers. In regards of adding a
> maintainer, having more maintainers means more communication.

This is exactly the same as for every new driver / component, regardless of
whether it is written in C or in Rust.

It is absolutely common that driver maintainers help with integrating core API
changes, if necessary.

I don't see why the same process should not work for Rust abstractions.

(Additionally, in this particular case even one of the reviewers of
DMA MAPPING HELPERS offered to be a reviewer of the Rust abstractions too, in
order to keep eye on the DMA API angle.)
