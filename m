Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4802D238F;
	Wed, 22 Apr 2026 05:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776835473; cv=none; b=Cui2nj1kXEPK+R0VOqeZS1Z0wObRbB82aYzzL8WrjPOn3ONiplMGr0LAuUjlkLXWjWbgYzFsiY64dziJKOrD+dx8TAggGPuZZ7BFxQFPYFdthMXx+uK0DT3sGDtDIcowvBC628okpCkIMHFfJlP1r0nDtOur4ngJ/alGd5cN82w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776835473; c=relaxed/simple;
	bh=jShtjf7XMEdswZ6ZkZT4t3sTzEGPGHkQ7xylAzPuM0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lWygTlo1N7Cg6gdbJpPDzeMdoQjwtFGoYNvJshcA9beqMf2xSU61mUWh3j1ooTvjRqFV/TkAuFKrVOqbaDOGgf9D5MDc0xK+JAOON78m9Xowy3bqE68rCQAJrH8+o/gH0mU9VzRCTPA+abZyHD/Qudx3HmYTcKJsGuorFIjqC+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hl5wszca; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hl5wszca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9C6C19425;
	Wed, 22 Apr 2026 05:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776835472;
	bh=jShtjf7XMEdswZ6ZkZT4t3sTzEGPGHkQ7xylAzPuM0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Hl5wszcaJ9m6Ketjw7BaRg5ziSG5rzsPSEUdK5/jehLBUwSL+prVslOYl7speNkUm
	 uapxmrBJ0E+St/bIHT5yYu6BRsBp+BPl1hR0vXFSWTeQP6JDjNpsfLIM1dOHewWyDZ
	 p78uu/9RfwMFoUm9KsBtgjVSTH+e7FkStIIVilnD7h/q55qlRhzO3IzQVvHyZODVch
	 /CLYvmDoAvK8mNmzBhI6wxfJ/2WqCoJGVcs/htbF/CGXXigClNqSuNL4UjkfHvldZC
	 4gm7agdMeNMMwUJEZ8r1Kv8FaaAC9HENEgr7XwZgcvjPUYsYSQYIIiDrpD3F3Ceo3f
	 M/M4r8ZkGuRpw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, catalin.marinas@arm.com, jiri@resnulli.us,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v2 7/8] dma-direct: set decrypted flag for remapped DMA
 allocations
In-Reply-To: <20260421135311.GH3611611@ziepe.ca>
References: <20260420061415.3650870-1-aneesh.kumar@kernel.org>
 <20260420061415.3650870-8-aneesh.kumar@kernel.org>
 <20260421123419.GC3611611@ziepe.ca>
 <d83e00a6-6c01-4640-bd69-e10daeedeeae@arm.com>
 <20260421135311.GH3611611@ziepe.ca>
Date: Wed, 22 Apr 2026 10:54:26 +0530
Message-ID: <yq5atst3d0tx.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Tue, Apr 21, 2026 at 01:54:52PM +0100, Suzuki K Poulose wrote:
>> On 21/04/2026 13:34, Jason Gunthorpe wrote:
>> > On Mon, Apr 20, 2026 at 11:44:14AM +0530, Aneesh Kumar K.V (Arm) wrote:
>> > > Devices that are DMA non-coherent and require a remap were skipping
>> > > dma_set_decrypted(), leaving DMA buffers encrypted even when the device
>> > > requires unencrypted access. Move the call after the if (remap) branch
>> > > so that both the direct and remapped allocation paths correctly mark the
>> > > allocation as decrypted (or fail cleanly) before use.
>> > > 
>> > > Architectures such as arm64 cannot mark vmap addresses as decrypted, and
>> > > highmem pages necessarily require a vmap remap.
>> > 
>> > I don't think I saw an aswer for this, why can't arm accept
>> > pgprot_decrypted() for vmap? It really should, I don't think we should
>> > have these minor pointless arch differences.
>> > 
>> > Suzuki? You mentioned it, can you elaborate?
>> 
>> We can accept pgprot_decrypted(), but this must be done carefully
>> as the backing pages must be first converted to "decrypted" in the
>> linear map (set_memory_decrypted()).
>
> Isn't that the case for any use of pgprot_decrypted? I think that is
> fine and followed by the dma api.
>
>> With that in place, it should be fine. It is,
>> set_memory_decrypted(vmalloc_address) is we don't support.
>
> That makes more sense. Nothing should do that, changing the state of
> memory that is mapped any place other than the linear map is not
> allowed. I understand this is the condition where Intel will machine
> check..
>
> So with that clarification at least the commit message should be
> revised in this patch to not mention vmap.
>

I will update the commit message to clarify this further.

-aneesh
