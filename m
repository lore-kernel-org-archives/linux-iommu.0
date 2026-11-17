Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940872;
	b=Ai0roSZmlZqhJV0bWBj2a8cMm7Zo1qxaTKtARbrqfl6U8giRierpycGIdIff7XDJEsti
	 +cHBZ/F8F2X9fhAcU9iNnWgRfBohAQWfdpZghJGqK8EHocTFNqTjVzUtt5Ni/MVum2pgo
	 uvXmQVxYQ1JxoqztDkV5ErIKIdNjzsya1riv3V0iPwRilX15TzSyxdeZTmEXJM4D2dEZJ
	 S6Ylp8xn4n8iGMsF/yIfGZO3Uekq2rZJQmk2u7PtOlVWPJUYv2tNIa3w889yGFf7Bhtc7
	 rc/OO3etOYtmf52kqFn/4UkPX4c7NJaGznstfMHueW5TcL6vvexr77JNWm2/3pL5LcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940872;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vnbT4MZAH5b2bOseo+QUn8hjmpncTD2myqHBSQmO50k=;
	b=f3gpBH19Bw0Vhg2hd5WZ5mrJKyPANRKcG5OFzA3ikzjycU4jXfQVTl2QKDoYGzpVchWi
	 o5Yhjt9+4m1Yc7kbnPEqPImCqtjBqoWuXugGBgcnSDJkB1ZQayo9JIUnLMs0gvyKKkNYi
	 AZx5AZmhJf48O4CBaREA/EMHs9KiWAoNRXvTU/v7Ws70y+tAJV9mVh2r9uxDvhIklcLQb
	 p7TwMmGByVBUdYO4l2Ec5Au3RznA9szkW5C04/MNCZINeVvhJ6z5QVGlIAwtRvQOWVzhU
	 hoMt/Ar+jfXh0JWjFc2fRaIBaHxlsoGt1FMKL7tCKfXSG54ZSeXss/+yEtaNYDNtc4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EZb6nnaO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE06606A31C;
	Tue, 17 Nov 2026 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EZb6nnaO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94F71F000C5;
	Tue, 17 Nov 2026 18:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794940871;
	bh=vnbT4MZAH5b2bOseo+QUn8hjmpncTD2myqHBSQmO50k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EZb6nnaOcwR/4NbkQBf0LSZwk1sGOiqQAx49xLpGqqsstq7MLHNQmGCOKoBLacxBS
	 uPUXQp/23cSFbJdN4xc/P7zu09VtiS50JsRKBKbkWX21SMzcZV3yny1wvNJjDSiJno
	 Ig3V/1tuYEMDBaQDOGQF163fM6PSglIJAdSJqpJhOQUm3OU+pMuqrBs9uOKFtUwGXM
	 YxsasHesDA6RLV+BcMLjSZ5sKLggcNqosAg0Y0eQKCMBrKU6A3J9ZH967YOcze7+Kl
	 YKv+DLtKfgl91KutXpTEi/9E+CAiMXwXYgsCLQB8OJzKotLFPSzOaBDPDd7a4FnKXc
	 78DyZUOnzYx8Q==
Date: Tue, 17 Nov 2026 10:41:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: robin.murphy@arm.com, netdev@vger.kernel.org, iommu@lists.linux.dev,
 joro@8bytes.org, will@kernel.org
Subject: Re: [PATCH 00/11] dma-mapping: add dma_alloc_attrs_node() and
 dma_alloc_coherent_node()
Message-ID: <20261117104111.3dce9bf2@kernel.org>
In-Reply-To: <e69146b1-74cf-451a-9598-cc85ea992263@samsung.com>
References: <20261106184433.761422-1-kuba@kernel.org>
	<CGME20261112161622eucas1p131619576b0d4e6d201197007f3d7c951@eucas1p1.samsung.com>
	<20261112081616.13b81fab@kernel.org>
	<17fd14e7-41e3-4658-a62c-1206fd2b5e0d@samsung.com>
	<20261116145420.2b533196@kernel.org>
	<e69146b1-74cf-451a-9598-cc85ea992263@samsung.com>
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

On Tue, 17 Nov 2026 08:19:33 +0100 Marek Szyprowski wrote:
> On 16.11.2026 23:54, Jakub Kicinski wrote:
> >> If possible, respin the tag with latest acks/reviews, then I will pull it to
> >> my dma-mapping-for-next branch.  
> > SG, added the tags and re-pushed:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git tags/dma_alloc_coherent_node  
> 
> Pulled into dma-mapping-for-next, thanks!

Pulled into net-next as well.

Thanks everyone!!
