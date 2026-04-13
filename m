Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306A338AC72;
	Mon, 13 Apr 2026 07:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776064781; cv=none; b=hXPFuEYE8mcJqV4sCY3m3EjC+rZIHq/U9kxdGCBqmpxNCQYRcZeHzgVgiRCaiEAjtTu34f94hXj3yE6BrIAJdasZfhEc0PC9YIFln7/WxJh18JE7O6yJhspfQ1w44FwerOmKJDX7Z9QBUMJf15pW5s+f929h8xrEb8c6k0gfois=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776064781; c=relaxed/simple;
	bh=rv3Q9Laozuj6itSDtWQA8UKp3uRgVzFFcFM1jyTTMkw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VYldiq7UVY7XEz0t6H+7bOJWCr40wRzkuxNZZi5bjK0tF8hTre7ha4p0oUehlA+nhHNFKpRWhZMS6Qd1ZKSuSbctoM8l9ABYsOhRcdUeof2FCyIIE1ddtg0FX/MooANsn1GZvPi8zHj7RXiwWPAy8vAaPjNgCMsgl5s2ECpnJhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgZ3qd+u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgZ3qd+u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA92AC116C6;
	Mon, 13 Apr 2026 07:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776064781;
	bh=rv3Q9Laozuj6itSDtWQA8UKp3uRgVzFFcFM1jyTTMkw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dgZ3qd+uo9RyzvJD6VX09uztG+qtGirSANw/cY0gfMwL+tue9qoACLZYw6vvn8JDG
	 K4naP+H9QB4l72fqu0d45q2clmcTQeU5oyGmS6g/X0RP/P1s8Pv7bIiZ0lG4ZcJhhA
	 uW+8XYkn/9DCcEiHH5F6jHB75q2Cn4KGeYoPyJHnYyKFN6qZ0BG/JfQcmDxwJpD6aQ
	 N6IAxMrDE+HRVQIs3C2bmS6aRA2EMmvwNEo1Ya7EPBAd1gBXwqOhWSKdzjE48rVUEj
	 eOnFCLPh9y+8TQksHvK1Frqma8NaspTJ9MMtwOmCSvlj5UboT+DZCWWYGbRp7HinNn
	 ZZuzhrPdlbsNQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, jgg@ziepe.ca,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [RFC PATCH v3 5/5] dma-mapping: Fix memory decryption issues
In-Reply-To: <20260408194750.2280873-6-smostafa@google.com>
References: <20260408194750.2280873-1-smostafa@google.com>
 <20260408194750.2280873-6-smostafa@google.com>
Date: Mon, 13 Apr 2026 12:49:34 +0530
Message-ID: <yq5a5x5vba49.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mostafa Saleh <smostafa@google.com> writes:

> Fix 2 existing issues:
> 1) In case a device have a restricted DMA pool, memory will be
> decrypted (which is now returned in the state from swiotlb_alloc().
>
> Later the main function  will attempt to decrypt the memory if
> force_dma_unencrypted() is true.
>
> Which results in the memory being decrypted twice.
> Change that to only encrypt/decrypt memory that is not already
> decrypted as indicated in the new dma_page struct.
>

As discussed in the v2 email thread, we should address this by deciding
whether, for now, we treat all allocations from swiotlb pools as
unencrypted

https://lore.kernel.org/all/yq5aeckjbdrt.fsf@kernel.org

>
> 2) Using phys_to_dma_unencrypted() is not enlighted about already
> decrypted memory and will use the wrong functions for that.
>

Can you split this into a separate patch? I=E2=80=99m finding it difficult =
to
understand what the issue is here. Adding the unencrypted flag multiple
times to an address is not a problem in itself. Even so, I still do not
follow when we would end up doing that.

At the interface level:
phys_to_dma should always return an encrypted address.
phys_to_dma_unencrypted should always return an unencrypted address.
phys_to_dma_direct should depend on the device state.


> Fixes: f4111e39a52a ("swiotlb: Add restricted DMA alloc/free support")
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
>

-aneesh

