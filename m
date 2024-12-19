Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0287C2594;
	Thu, 19 Dec 2024 11:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734607370; cv=none; b=U4930zqTfVGxt4ITPSlSM34xBpgO9JiEtKmiu5o9IGhjWZ/3JX4u9bPKuMhq8WiuLAbtNd0feDRtloSYBaGOpXANuvioHgjjjkAl5Wg65nha5flo1YlSQKvKgMe8I3Lb+RQewJ8/iBeZKuNIz4KksM43awuNNhCav9sSQlT9mqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734607370; c=relaxed/simple;
	bh=3+5Q0Qysj8llseSuscoFbDFwGe965ckZvQ14Tok/Yhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mX3nFjrNl6CAppdM9e37NuPK2uwxYHk8PwyGSps8LuXdlnC1v0bz9DAjUIbpbcOk8QDs8MIUkfZfpCbMpqB3VRQZjwZLbOaw7JqLZmjx3hKKOMwOoVEmqzswuKebUXYIEjThtl5elZZuUn9lY5xAMiD6JCD5RAhKdai00ov+MDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaHgo13G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaHgo13G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C211C4CECE;
	Thu, 19 Dec 2024 11:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734607369;
	bh=3+5Q0Qysj8llseSuscoFbDFwGe965ckZvQ14Tok/Yhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UaHgo13GPe1WZOWuIBiDVt64R7iwCKzf/jLrQQyPg6s2oRaPQVRcWKSml4JVsHGUL
	 btZpLf/yUAQ9+3YTAsk6cGdkfqSyuQgWILM5NB3fbt06hOgaPDEpHJGfLriP/Ck3bF
	 g4nTcaWGgVrBbTHz/25j4IUEsLF4SM0oBQ9nafQh8gBJn1IJxOkp1TjJbhw0KYWKlH
	 dKwIvVpKfZ/6VRAXey0ldl8eLAX3ZGYQnq3XYmR41CnXbqPCaWh5DVBnzfC6UVfVqB
	 VlFJZAmL79wTX/eQLIpC2LQpBHGfmIi8Mv1lESv4s6jo26KC/zaKFRHkJKNRWHMkwQ
	 VlGe7VnmJvdig==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org,  Daniel Almeida
 <daniel.almeida@collabora.com>,  Miguel Ojeda <ojeda@kernel.org>,  Alex
 Gaynor <alex.gaynor@gmail.com>,  Boqun Feng <boqun.feng@gmail.com>,  Gary
 Guo <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  Benno Lossin <benno.lossin@proton.me>,  Alice Ryhl
 <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>,  Danilo
 Krummrich <dakr@kernel.org>,  Valentin Obst <kernel@valentinobst.de>,
  open list <linux-kernel@vger.kernel.org>,  Christoph Hellwig
 <hch@lst.de>,  Marek Szyprowski <m.szyprowski@samsung.com>,  Robin Murphy
 <robin.murphy@arm.com>,  airlied@redhat.com,  "open list:DMA MAPPING
 HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v7 2/2] rust: add dma coherent allocator abstraction.
In-Reply-To: <7c8e84e7-a212-445f-bc4e-ef65dae7fb29@gmail.com> (Abdiel
	Janulgue's message of "Fri, 13 Dec 2024 10:53:29 +0200")
References: <20241210221603.3174929-1-abdiel.janulgue@gmail.com>
	<20241210221603.3174929-3-abdiel.janulgue@gmail.com>
	<7c8e84e7-a212-445f-bc4e-ef65dae7fb29@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 19 Dec 2024 12:22:35 +0100
Message-ID: <87ikrflxxg.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Abdiel Janulgue <abdiel.janulgue@gmail.com> writes:

> Gentle ping. Does this approach make sense? :)

If you include the `Allocator` trait and the `Pool` it would make my
life a lot easier when rebasing nvme. For now I'm just going to use out
of tree patches that include the dma pool.

If you do not have a user for dma pool, maybe just include the
`Allocator` trait and indicate that it is there to support other dma
allocators in the future?


Best regards,
Andreas Hindborg


