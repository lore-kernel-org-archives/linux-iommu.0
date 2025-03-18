Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4BA20D502;
	Tue, 18 Mar 2025 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307544; cv=none; b=gfEUt+hPbB9ReDzYpHep+iMWybybE/wQqvIDnO3u3HmsekxbboKryTMUWM9qbx8of92Jt3+Fe83Xm5ngPzsNbs50U2V6YuzeAriIqTf08AD8jxexJb7DFBwUz5JdrereBeBX9U2Fo7TBayi6Qsn+velnyCY/yR8Ak9qqxGu7BII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307544; c=relaxed/simple;
	bh=epxV7GtHxcvtkAeq8eZfhijBk8m+5xzi3EFgfO0RqKs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NNhcCpwXoL31IRfihxH0vkr03FE+3R5OFFPQcqTlWfbHHqJTpfEYNDai3AUCDXaHgp/k3t6nMrooruIw0Y+wjAK+77kPL82rf8tuoFrDoaVYx0vr24gN5kUA1Y1miB6ghyEpmYQYcLCu0gb/VQiwVQMlFqNDsiwRBfCytyVvmUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQYEYPoN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQYEYPoN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F03BC4CEE3;
	Tue, 18 Mar 2025 14:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742307543;
	bh=epxV7GtHxcvtkAeq8eZfhijBk8m+5xzi3EFgfO0RqKs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rQYEYPoNW+oXRPd5s5lR1acZ8VzzZ8cr05MRwjURtoMeWvVHoUPnE+KP/0WRnAIF2
	 dtGNeC4cX4ASjay7e2Q8iIYIJksc7zUv+ZGF4T7EnJKl9Z0AJJOju7MA4vBZNuJWV7
	 70JfMPkP1efS1ZBuukfLV02EERQOPmCdQCvL+F/ryadIcq3BHzsHznyZqkAVhhkCJL
	 ljyBvnYNv0Xma3n+QK4/w82zNbEiJmzQoQkGzGRGkVFvS349PhHCkoGsjTwt+ZoLms
	 6uT9MRPXdTr2b82hcmpBcrIU8D1idvEQqiT2Wv3L+e3ZD41dq6/GnCXZd/g8A85v29
	 PSL/E07XNqQHw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>
Cc: <rust-for-linux@vger.kernel.org>,  <daniel.almeida@collabora.com>,
  <dakr@kernel.org>,  <robin.murphy@arm.com>,  <aliceryhl@google.com>,
  "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Trevor Gross" <tmgross@umich.edu>,
  "Valentin Obst" <kernel@valentinobst.de>,
  <linux-kernel@vger.kernel.org>,  "Christoph Hellwig" <hch@lst.de>,
  "Marek Szyprowski" <m.szyprowski@samsung.com>,  <airlied@redhat.com>,
  <iommu@lists.linux.dev>
Subject: Re: [PATCH v15 00/11] rust: add dma coherent allocator abstraction
In-Reply-To: <20250317185345.2608976-1-abdiel.janulgue@gmail.com> (Abdiel
	Janulgue's message of "Mon, 17 Mar 2025 20:52:07 +0200")
References: <rTVBNBYxl4bn6nnkXBjTN8d-dpiCOR32i2Fpe5-wuhzcGjijW1iXnKaA4pbok32ockodVqTYGEfEA_JVpOC3ZQ==@protonmail.internalid>
	<20250317185345.2608976-1-abdiel.janulgue@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Mar 2025 15:11:49 +0100
Message-ID: <87msdiig2i.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Hi Abdiel,

"Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:

> This series adds the rust bindings for the dma coherent allocator which
> is needed for nova-core[0].
>
> For v15, document safety comments on the exception of usage on
> read_volatile and write_volatile as suggested by Boqun Feng.
>
> This is tested on a Nvidia GA104 GPU device using PoC code which parses
> and loads the GSP firmware via DMA.
>

I messed up and replied to v14 of the series for patch 3, 6 (x2) and 9.
Comments still apply to v15.


Best regards,
Andreas Hindborg


