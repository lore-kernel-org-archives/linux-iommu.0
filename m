Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAD33233E8;
	Fri,  8 May 2026 04:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778213029; cv=none; b=DVfzYTaGKPNFKsgKOU4u3khEt0glbuAPZLcgDFjkZjB0RNk2qIggak5XY40s8Z8hHvwyDpiLmOPES2pGs06dHEYmz5B3pNTFSOMqgax42P2U2OYdzuxaYrwCYttU8uSDAEttLQhUFqpZGzry1KUmDc21dpWlQraboAheLczmMUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778213029; c=relaxed/simple;
	bh=bqWtPosLO/BvenMA49okt9gW0ZGgKAIZ5TC0QxjLFHQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=flJKM11pmevIX3lCdbdziwMiH2BY6eB+p2q5M8jDObpSr/+eyEoKroH4Zpt3v1lWMlZYT4YV66gVNiOgASyAWMBbeO1II9uBJ5GRh6HcA6PiqcVBdfhxF9hLZ+7rGuPpfqcCffJeVwwoiqbmQADnI980031E+C68MsuVGuNSXso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDp82Pkg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDp82Pkg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D8BC2BCB0;
	Fri,  8 May 2026 04:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778213028;
	bh=bqWtPosLO/BvenMA49okt9gW0ZGgKAIZ5TC0QxjLFHQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HDp82Pkg1qVcMjveQxzYHzgL6rwHFTFRdlvMamG5XwiHMI+VO6ljcNDoYQzvCuHwj
	 eJJEDGVkRBXMx9cPlDURvYA5WMrLyf/el5zVFepJ2AAjsK/byr+uvi7UxkCxHOC2ul
	 TggzhB0x0eEsls3Y6jliT8boHx3YDs3qWjXIUfGGbdrvePkWuGq89lBeZhdQdhix3o
	 9ek+K3+j1iDys4Jf6v/vw4cP1pBXkQpV32yWF6l6Cu6r005wtWFw9WsUyuTNXp0kCV
	 DyxStl5wOOsf/YgjmjPXoa+QbYoGEIfGPaLTpM3yQDi/Bd7boFAMF8MMnvwtgEwgPt
	 E3X01i1AxDdpQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	m.szyprowski@samsung.com, will@kernel.org, maz@kernel.org,
	suzuki.poulose@arm.com, jiri@resnulli.us, jgg@ziepe.ca
Subject: Re: [RFC PATCH v3 3/5] dma-mapping: Decrypt memory on remap
In-Reply-To: <afzJgQSN0ROM3lEb@arm.com>
References: <20260408194750.2280873-1-smostafa@google.com>
 <20260408194750.2280873-4-smostafa@google.com>
 <yq5atstdanx8.fsf@kernel.org> <afzJgQSN0ROM3lEb@arm.com>
Date: Fri, 08 May 2026 09:33:41 +0530
Message-ID: <yq5ao6iqtun6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Tue, Apr 14, 2026 at 03:01:15PM +0530, Aneesh Kumar K.V wrote:
>> Mostafa Saleh <smostafa@google.com> writes:
>> > In case memory needs to be remapped on systems with
>> > force_dma_unencrypted(), where this memory is not allocated
>> > from a restricted-dma pool, this was currently ignored, while only
>> > setting the decrypted pgprot in the remapped alias.
>> >
>> > The memory still needs to be decrypted in that case.
>>=20
>> For ARM CCA, we cannot mark a vmap address as decrypted. I don=E2=80=99t=
 expect
>> non-coherent DMA devices to be used in an ARM CCA configuration, but we
>> may need a way to document this in the code.
>
> I think you clarified what you meant later. The vmap here is just fine,
> we pass pgprot_decrypted(). The key is the dma_set_decrypted() on the
> page address before being remapped.
>
> On arm64 we probably don't care but if we want to enforce it for all
> architectures, dma_direct_alloc() could return NULL if
> force_dma_unencrypted() && remap (maybe together with a WARN_ON_ONCE).
> However, the proposed patch is small enough to cover this case as well.
>

I have posted a new series clarifying the commit message and adding further
changes here https://lore.kernel.org/all/20260427055509.898190-1-aneesh.kum=
ar@kernel.org

-aneesh
