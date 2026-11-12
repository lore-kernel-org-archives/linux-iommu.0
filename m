Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794500177;
	b=oqK+YMbvsfaOFaBBRmkawdu4JRjP5Rm9VLDat7AainNeGJqg/pA+GsD8vmvvjwBUl+pz
	 Wv1GyvUr4MVkSh4x32OxD7VhqpqWDcu2Mi1dicIEpLl+1uKcX08oLUx8WgKd8iNt9/uo2
	 thndToGgEESYAR21TQ/xpwOyF+AdHjKk3k0952X1IsmdQhclPUMMmoWfEym6xZXqrT7nt
	 MsRMQVnvPsGqjRFGGMbY0IlYbnG8feGyM1+Ag/rkbNtZtwsI9aMCXHEYoNQ0dw7Gr1Afo
	 Bl7jBIvAU7Fr4MUFLjUBzrLPZ1UiimejvlA8yf2P7HXjT6dHUmE/VDyK9nkqjcZZwRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500177;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=klJQeqEyyKZQ5t+wf9+9n+9t0hBk3VmevR/qLOdRtjE=;
	b=aWUuCorM22lmU2Dgo5/cSsY0wUGjrdAsYH0/W255MrD1FFcxGi7UsSWtjZn9hoKpEtH+
	 iaFoXlMeKL/TvV/xHPowt+s+o7F/RgqIfLebbG4fDVnqIrwv10X0upHQu8SwInRjgbraA
	 AAmqjPsiKIHpjbl5OetJS2UtGt1Qs8g194E+1V2qcqr1OeI/6/Dtovbbm+DfzLql+iNEa
	 LJiVeMlNZ+S05A2yoEYbKB7RLVsKFHpfvEl+yr5mpNEQI00cMAwpjn0jz9yOce/f8W3cH
	 tCUvEaTUGujLkZY941w45EJ9leHyO1dfZMNbhmlUoTUDjFTLHWiUXfq/JFaKyrtpSYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bozFZLev;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D200A606A333;
	Thu, 12 Nov 2026 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bozFZLev
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C30B1F000C4;
	Thu, 12 Nov 2026 16:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794500177;
	bh=klJQeqEyyKZQ5t+wf9+9n+9t0hBk3VmevR/qLOdRtjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bozFZLevDjUTK5xXkYPKn/LLBZzOgZ1nSmfwQLNMa06sVJy89i5KEDz/ta6dpgove
	 ReKxDJ04POxIn3cXWEG1WUhQBxk53mQdkctlv2gX2+qh6hMIBJxf0wLHWePWhHuEpX
	 xysxXJ49N5kzHaLWoFa4hQ5/uoOkIN+ir7qkL3YQzAadt84j7X9neMWGPRv9pdwLUC
	 88ecUCTXzLyAkdEnyJWN/6kUcNpwqVm3C0VDBN8vASz6WGZ1kbt2H6NNMS1EQaxpqD
	 7ivRqzFXAQeYTsJxWmVAEYi0HTVnxuv5E7eOu5OlfqewvMrNgMncuN0Z2EZiIB6Pc0
	 FQqdZ30/eXFbQ==
Date: Thu, 12 Nov 2026 08:16:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: robin.murphy@arm.com, m.szyprowski@samsung.com
Cc: netdev@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 will@kernel.org
Subject: Re: [PATCH 00/11] dma-mapping: add dma_alloc_attrs_node() and
 dma_alloc_coherent_node()
Message-ID: <20261112081616.13b81fab@kernel.org>
In-Reply-To: <20261106184433.761422-1-kuba@kernel.org>
References: <20261106184433.761422-1-kuba@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Nov 2026 10:44:22 -0800 Jakub Kicinski wrote:
> Stable tag on top of v7.4-rc1, so that we can also pull this into
> the networking tree:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git tags/dma_alloc_coherent_node

Marek, Robin, would you be willing to pull?
Or should I respin the tag to include the latest Ack/Review tags from
the list?
