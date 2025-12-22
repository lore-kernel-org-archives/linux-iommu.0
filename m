Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B5A2C11E2;
	Mon, 22 Dec 2025 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766427127; cv=none; b=NMlctLEwu0ZCZl5k/iqjqG3/kApD+Im8BrIVJx51513kDNbPqMe9KhSz3JIiAa+EG+BvxFDcG/3FREmL6T49KynZvROwwIPkRvNPBPSKIHMBC7DmbrY0J1Pr8NOPS/KFRo3pNOl0IDbQSKFNf5c7nVppZA4b4UjrZpqYNu/HJw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766427127; c=relaxed/simple;
	bh=hwHm+OuW28tSZc7CkV1VxMvCfGShzVn8DtXS//zQnvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sm/X0Gfd5IvZPkKhx5yPUfcrXAkACUpGMr9t/lw/PR3WWAaDKOKz5KHS0pcUL27u0Dh16MwkpoSpOKkhHNrJ72hf5uxZmLsKsDsxymNXfOUwXJJ7x19NKnK4NhVfBKEoyTwUUJ3aVfPKZSIq3qb2ka6Uq89tO20npB9tSNzzWqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GOyD8Bgk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GOyD8Bgk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78092C4CEF1;
	Mon, 22 Dec 2025 18:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766427125;
	bh=hwHm+OuW28tSZc7CkV1VxMvCfGShzVn8DtXS//zQnvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GOyD8Bgk2UzH7ZSirehN9QNhT3rrNaUXfngaujVNXw4lCCrzFACypXv1Jc7qV4YUc
	 xm2kVGSpjg3uFUz35LGygfcXwM98H2bcTuuYYihhn5xby7NYXYNVDruln2L4z4O9LJ
	 mQKS2Q/KEJclTIZIT5p1GPiGmvtyA+t53UKVzd5E=
Date: Mon, 22 Dec 2025 13:12:02 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>, 
	Robin Murphy <robin.murphy@arm.com>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [GIT PULL] dma-mapping fix for Linux 6.19
Message-ID: <20251222-tricky-cockle-of-economy-61906d@lemur>
References: <CGME20251222160344eucas1p12182e7b47456263b0b67309f6c674ac4@eucas1p1.samsung.com>
 <20251222160328.2523773-1-m.szyprowski@samsung.com>
 <CAHk-=wgpWEoW1VKZv-7YC_oftbqWXh3xERYBsjfv5dc-MO-Lmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgpWEoW1VKZv-7YC_oftbqWXh3xERYBsjfv5dc-MO-Lmg@mail.gmail.com>

On Mon, Dec 22, 2025 at 10:03:42AM -0800, Linus Torvalds wrote:
>    remote: UnicodeEncodeError: 'ascii' codec can't encode character
> '\u2011' in position 90: ordinal not in range(128)

Ah, yes, everyone's least favourite Python error message.

> and I wonder if that's why I also haven't seen a pr-tracker-bot reply
> to your email yet (but it might also be that I'm just too quick to
> blame things, and it's just delayed a bit).
> 
> Konstantin - I think it's only the subject line that matters here,
> because if it reacted to non-ASCII characters in commit messages, I'd
> have seen this issue many times before. I'll send you the whole
> traceback separately, although I suspect you can easily just re-create
> this issue locally.

It shouldn't be necessary, but won't hurt.

Thanks,
-K
