Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518722EA754;
	Tue, 10 Feb 2026 12:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770727704; cv=none; b=HUi0gQz7cQjXfAqaGMkw9iYel9cQyFJLqMqnSkZxTEOioaAqNrMAYUIqXvyJ9vLYNnMZuQHHgFTtZw5U05hBOd8KUrxmHHLsGlB8IJkaIYNJiVnmC7btLT7ckuHdEIGYlB8RxdxvwsopZz00NziWOiJaOJZkD/RlCi68Eb4hKvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770727704; c=relaxed/simple;
	bh=f9Hioy1nBNAN6Nj6FmxHzvPM8qjWxbtxXn6ma/BOEN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLjlAd8pZq0BjUhkI8oEbd0KDsT5gdjpx0hfLkyp4ng1SxVvksP6nykT//pkH7Y5+xkBaAAx8DlvWHwsT97mTOtXPFGN26DMbeMbdkOW50sAYKrO4Qds0uyrW2KHUzkndrII4nC3wNwGW4rtZBd3PF0pGicSM8PdR91QWraVouE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Omxd9ntP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Omxd9ntP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAD6C116C6;
	Tue, 10 Feb 2026 12:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770727704;
	bh=f9Hioy1nBNAN6Nj6FmxHzvPM8qjWxbtxXn6ma/BOEN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Omxd9ntPib7buprI2avF9vcC5Snk52LrNPhoNyFSO+Pp/RnFY9OpJi8PDjJVaxHmb
	 JXUYYvf8mDOqJL00C/SA5U6DUzy7M/eEd+7C4i1SVv3A4qZh92mM5Rm14mro68cR2t
	 6h0t8AeSTNBPNmliXeDF6glQjfeed1kx5MhPTPGFC1WpXrv0JLEgHiJbUaah2n5b5Z
	 gAdRG3klf2YYAP5MWPc6bLxDm6TKYyUEZQvEGN2z5fMUW9rlSD2hezSOCJvY1XcU/+
	 BRxCvbm1bcNecNnEBO0TGKpRpqR28vrU2kjBTA1jfqTtyRVkkCx0KnIFJBp3Nan0jG
	 VoQHRcdYSklIg==
Date: Tue, 10 Feb 2026 14:48:19 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: John Stultz <jstultz@google.com>, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
	linux-media@vger.kernel.org, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
	tjmercier@google.com, christian.koenig@amd.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com, jgg@ziepe.ca,
	sean.anderson@linux.dev, ptesarik@suse.com, catalin.marinas@arm.com,
	aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com,
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH 4/5] dma-buf: heaps: allow heap to specify valid heap
 flags
Message-ID: <20260210124819.GC12887@unreal>
References: <20260209153809.250835-1-jiri@resnulli.us>
 <20260209153809.250835-5-jiri@resnulli.us>
 <CANDhNCoHEZsNRmU+3z5AbeAy05H7PTtUdTq1apNd5k0f9hWW8A@mail.gmail.com>
 <hwdezwktndbm6hoko3rz5lffgfljodegcygzf6rbdf2ferokj6@ftk2uk3rqfdq>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hwdezwktndbm6hoko3rz5lffgfljodegcygzf6rbdf2ferokj6@ftk2uk3rqfdq>

On Tue, Feb 10, 2026 at 10:05:14AM +0100, Jiri Pirko wrote:
> Mon, Feb 09, 2026 at 09:08:03PM +0100, jstultz@google.com wrote:
> >On Mon, Feb 9, 2026 at 7:38 AM Jiri Pirko <jiri@resnulli.us> wrote:
> >>
> >> From: Jiri Pirko <jiri@nvidia.com>
> >>
> >> Currently the flags, which are unused, are validated for all heaps.
> >> Since the follow-up patch introduces a flag valid for only one of the
> >> heaps, allow to specify the valid flags per-heap.
> >
> >I'm not really in this space anymore, so take my feedback with a grain of salt.
> >
> >While the heap allocate flags argument is unused, it was intended to
> >be used for generic allocation flags that would apply to all or at
> >least a wide majority of heaps.
> >
> >It was definitely not added to allow for per-heap or heap specific
> >flags (as this patch tries to utilize it). That was the mess we had
> >with ION driver that we were trying to avoid.
> >
> >The intent of dma-buf heaps is to try to abstract all the different
> >device memory constraints so there only needs to be a [usage] ->
> >[heap] mapping, and otherwise userland can be generalized so that it
> >doesn't need to be re-written to work with different devices/memory
> >types.  Adding heap-specific allocation flags prevents that
> >generalization.
> >
> >So instead of adding heap specific flags, the general advice has been
> >to add a separate heap name for the flag property.
> 
> Right, my original idea was to add a separate heap. Then I spotted the
> flags and seemed like a great fit. Was not aware or the history or
> original intention. Would be probably good to document it for
> future generations.
> 
> So instead of flag, I will add heap named something
> like "system_cc_decrypted" to implement this.

It is problematic to expose a user‑visible API that depends on a name.
Such a design limits our ability to extend the functionality in the
future, should new use cases arise.

Thanks

> 
> Thanks!
