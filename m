Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CA931ED80
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779181448; cv=none; b=Y/Cl7RhpXVeFtaorHHMmhJhfmnub8LraxKFcfdFO0Od1jFqPZkItRl0gg9vzhsb8EFy4oK96LXgjKRJo//wuzEiKZtx7WJvTd9bM97ZYV8R1Rb6s4bWUMBX/C+RDpMl1P9Sd/4NAqN2Alp/8i/of6ozsXHWJkAOVdR/NGqjsd/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779181448; c=relaxed/simple;
	bh=gDzdAUulVlGD070L7jP4eRqheur1rkwF7n/wUYoaoRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6Y7+MClqyH1BV10PZbnXSUP4ayQLswetQrLFw+ipIghCkEmZ3kgzvs6ZT5a8hljFPsdXx3A9eSp3l24Lf6gNJTl8db7ALBl9rqbX2ZjLQOflBfHaZzJwhi3/9njy4LQ5eQQN/CVv56lcK1N5Q6ZBpBkOrCD8QbCdNfPzDe4q30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc5006ce656747b95889c.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:6ce6:5674:7b95:889c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 86F0A1C017D;
	Tue, 19 May 2026 11:04:05 +0200 (CEST)
Date: Tue, 19 May 2026 11:04:04 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org, jgg@ziepe.ca
Subject: Re: [PATCH 0/3] iommu/io-pgtable-arm: iommu-pages and cleanup
Message-ID: <agwndyswlv0JmwPl@8bytes.org>
References: <20260513215203.3852661-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513215203.3852661-1-smostafa@google.com>

On Wed, May 13, 2026 at 09:52:00PM +0000, Mostafa Saleh wrote:
> Mostafa Saleh (3):
>   iommu/io-pgtable-arm: Use consistent sizes for page allocation and
>     freeing
>   iommu/io-pgtable-arm: Rework to use the iommu-pages API
>   iommu/io-pgtable-arm: Use address conversion consistently
> 
>  drivers/iommu/io-pgtable-arm.c | 88 +++++++++++++++++++++++-----------
>  1 file changed, 61 insertions(+), 27 deletions(-)

Applied, thanks.
