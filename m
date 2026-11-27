Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781694;
	b=KUJVNcF3LcsYthVO0jBUPawAJDTthZRIyujvDhnbtZXcnlAYuqM8bnXljLh4UAlGoY7T
	 /i8xJHY1JuDbIA6JJrfrW4n3hxh7mYmDtsuy1tRKN8SjDefW9SgJPJ06dR12nyOUP8oKu
	 bIySeFpI6ws+Lyhi3+kQhbqobfvHbfzmQPiU8C4FdMktjLPxKq/40wyqgEX05rLb19I16
	 8GshLK9AYcH40mKtheC2Esl5gCa6feUaJji9ctDZgO0Bcr9dpVe7flOp/+rGRM5mgBSuD
	 +NHQpSdulo3hR/umIpfWIE5aj6/nkUm5ExrCPIwPaPqFmYUKgnoO8VafNgTVPIxAQMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781694;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=tM8SXc9WGf6iPLFbf68oH/I2l2oZdLX38iKCsqiqJkY=;
	b=jgZARd7ikM8z+5N3EfK7KXlVERZHxXD9BU/oWBqErBuNQmNx+QZJyGfB7Yz8CUkKTKgl
	 pBZm2DSNiNqLzfow8qfpRK25pVE++5e1M41J/tKQBBUvViutFs6ydtH24c87RYIbejsk/
	 0u2eqiej9yG/KvAOsXbmYzk3we9SFXPFZYKvYekJd0CEiEq2OyAdaRDWFVtRsCUj/ODKv
	 /331ypjXV3jXGWqOF20/Rk9wRrcVLCsqmzwDkzQ6Z9XFvh4IVF1QwZA+q+zRnqDFIHINs
	 90Ej97prP2ECW0Om4e0XVHrvc7QVN3OMcUD/sHT933G7HQSrwwmru6WBXoYx0ykWQ4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIZ2PgCC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B68E606A323;
	Fri, 27 Nov 2026 12:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIZ2PgCC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEA71F000C1;
	Fri, 27 Nov 2026 12:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795781694;
	bh=tM8SXc9WGf6iPLFbf68oH/I2l2oZdLX38iKCsqiqJkY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=aIZ2PgCCSdBh7XmzcJDpf7YgWkZ8/PzA4YV/zcGM11or/4gPkPdmyzwzeb9vzZBJU
	 2zInaHrgLawwRJSVDG3/2z8/A/J4ua/wchlgufVddjLb2qXuTzOsHq19DMrOjjlYGo
	 y/d6vI+nO6hHY28DEzoq5C0Ugv4xhzLEPQkjO/3kYBlbt4wFZbQtZtG6pM2qMSnsNm
	 mqIcvp7NHajVYr5/7FUdPyuZAGi6I9T5LKUUwGzQz13mMpGOZSC6LPs/5t84y60w3O
	 uVvR8ajJcLWMClOKml8jHc6pnzWmLQNzRta+n958LFQOaxkvMwk82yGQjzF3k9H3W1
	 hhLpTPbUqqsGA==
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 5/8] dma-mapping: Introduce lendable-dma-pool
From: Sumit Garg <sumit.garg@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org, 
 akpm@linux-foundation.org, m.szyprowski@samsung.com, jenswi@kernel.org, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 mark.rutland@arm.com, robin.murphy@arm.com, hch@lst.de, 
 ryan.roberts@arm.com, sumit.garg@kernel.org, sudeep.holla@kernel.org, 
 ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, 
 danielmentz@google.com, linux-arm-kernel@lists.infradead.org, 
 linux-mm@kvack.org, iommu@lists.linux.dev, op-tee@lists.trustedfirmware.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261111110738.872947-6-vdonnefort@google.com>
References: <20261111110738.872947-1-vdonnefort@google.com>
 <20261111110738.872947-6-vdonnefort@google.com>
Date: Fri, 27 Nov 2026 17:44:23 +0530
Message-Id: <179578166371.172025.2529658384273765570.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=974; i=sumit.garg@kernel.org;
 h=from:subject:message-id; bh=Sx4ywZBhiyullZrUtgY82SttR0yq7G5O52iMdmFQsBE=;
 b=owGbwMvMwCV2RWpxpe9rmzmMp9WSGLI5S3Q33F0lUXiz/xDP3tOl0RxvDeZkfjTJm7Dr88pGL
 puQ1PbbHaUsDGJcDLJiiiypX79N2yb0rzbU6gQPzBxWJpAhDFycAjCRZAZGhm7vDu0tNkxffpat
 f6wmaad/knepippM+rqdy3k+Zk3OU2H4X/fAReDjgWa2WUuZ9tT9XZR/OTpDcP3+JQtvMH1bE16
 pygYA
X-Developer-Key: i=sumit.garg@kernel.org; a=openpgp;
 fpr=65F5F696B612FE7D553AC80CD41AA3794DEB3C9C

> On arm64, when memory is lent to secure world (e.g. via Arm FF-A), fatal
> CPU speculative reads can still occur while it retains a cacheable
> direct mapping. Introduce the "lendable-dma-pool" reserved-memory CMA
> driver with dma_zap_direct_map() and dma_restore_direct_map() to unmap
> pages before lending and restore them upon reclaim. Devices use the pool
> via "memory-region" or "linux,cma-default":
> 
>   reserved-memory {
>       #address-cells = <0x2>;
>       #size-cells = <0x2>;
>       ranges;
> 
>       linux,cma {
>           compatible = "lendable-dma-pool";
>           reusable;
>           linux,cma-default;
>           size = <0x0 0x4000000>;
>       };
>   };
> 
> If no lendable-dma-pool node is provided, the API falls back to
> can_set_direct_map().
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

-- 
Sumit Garg <sumit.garg@kernel.org>
