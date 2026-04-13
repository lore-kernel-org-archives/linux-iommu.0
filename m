Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FD6266581;
	Mon, 13 Apr 2026 06:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776060523; cv=none; b=fbv3q30uyvciFdXoQhLdUtryXgrbqBALmj2Wus2dK0Z8EtDmz0EvFQkdrCnNandbV7haBzx4BkEqIg/t8BYltjYzuGG2wJzg82V9qJtbhByfqQoL+TJKI669Kw4Mqa+DDBW0Mjh3ARF5+IQ4+BwuIojl8EY3PF9zg4FWcMhWcT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776060523; c=relaxed/simple;
	bh=ppNjTN17ZtNMJ9dO7yGf0/EnI3kOcrqsYNfdNJxlsuE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GrOIqJHCPCbl6f5gGe2deKktuzqOH3Fv0uRyF3YEIzlr+3/8T1h7Tf98aCQtGtT8X7d+CfJTxGOYQxkKqMbGTxBm7qIu+hJYcj57px0NWY6yubVKLb0f4sQ6Sw8TVYTFuaJ+bonsFrXZ/WQE6TCRu/JkvUfpKyvf+e8u73vsrjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sk6T2UVz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sk6T2UVz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312AFC116C6;
	Mon, 13 Apr 2026 06:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776060522;
	bh=ppNjTN17ZtNMJ9dO7yGf0/EnI3kOcrqsYNfdNJxlsuE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Sk6T2UVzhH4mzCSjF1XvsGiUG0qPfwOuXGM6wumlTc8Wmb0Wk7YpbUSYEy/LyVrZW
	 MKl67lkMNOp6hnvZbwmvmtjvbql8Qn4UlsDpLPEnGcYG8WfwXn1dfcaQFtzVN2cQX9
	 ITAEZ8zY/Ciu0p2LHyaNsRPVZfDob0hettgP3Z4U8bDAoa5P85Y31PMCZfRO90ew8J
	 KOD0lerABRXieA58nPDF+K0ZAXI3lZBg8xnpZXmmywUxlBfhlbzSuJimd4s/OqT6Vy
	 XCa3ULZYvYDOcos52YU0UUUE7UNZDj2I3052Da49K5HhJ9puNSM6mFpOiNRA6vr1iw
	 kmic2crfXu88w==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, jgg@ziepe.ca,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [RFC PATCH v2 2/5] dma-mapping: Use the correct phys_to_dma()
 for DMA_RESTRICTED_POOL
In-Reply-To: <20260330145043.1586623-3-smostafa@google.com>
References: <20260330145043.1586623-1-smostafa@google.com>
 <20260330145043.1586623-3-smostafa@google.com>
Date: Mon, 13 Apr 2026 11:38:36 +0530
Message-ID: <yq5abjfnbdej.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Mostafa Saleh <smostafa@google.com> writes:

> As restricted dma pools are always decrypted, in swiotlb.c it uses
> phys_to_dma_unencrypted() for address conversion.
>
> However, in DMA-direct, calls to phys_to_dma_direct() with
> force_dma_unencrypted() returning false, will fallback to
> phys_to_dma() which is inconsistent for memory allocated from
> restricted dma pools.
>
> Fixes: f4111e39a52a ("swiotlb: Add restricted DMA alloc/free support")
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  kernel/dma/direct.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 27d804f0473f..1a402bb956d9 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -26,7 +26,7 @@ u64 zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
>  static inline dma_addr_t phys_to_dma_direct(struct device *dev,
>  		phys_addr_t phys)
>  {
> -	if (force_dma_unencrypted(dev))
> +	if (force_dma_unencrypted(dev) || is_swiotlb_for_alloc(dev))
>  		return phys_to_dma_unencrypted(dev, phys);
>

So what kind of device is this? Is it a trusted device that needs to use
swiotlb in unencrypted form?(is that a valid use case?) Can we add additional comment
explaining the type of device for which we are allocating the DMA
buffer?

>  	return phys_to_dma(dev, phys);
>  }
> -- 
> 2.53.0.1185.g05d4b7b318-goog

-aneesh
