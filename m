Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83461220F48;
	Sat, 28 Jun 2025 18:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751137066; cv=none; b=ufoGm2RSi3G78nD8gy2m93zjTU7mdL6bYLEt9NJAFZTxQv2hxVaFqmgY/kV7ChdSNZ/7zBnweKNNvE0mPLDLus6wkkB/hIs10ronFYBk9XstfI7Eb2uEFAVKn0gd94qPnDPvCDWEi4K58XDg3hSpVLsYx/hwPGsAzOFvO9qe0fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751137066; c=relaxed/simple;
	bh=ZAl987RtnqAA6nEP255KwhOX71RKQ7rq7qAN9e/1jHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3sOmzkTYSTfqmmhNr2ivdc8xiTAOuCR5skWHT5Hdb12R+y8rMcXEcU6zVgrOe2z2hMHUK2c8gidiEjIdw/iRLmxCihNHHSy1TwPZYXuwW/Z0k/0WTVFrj68xCBD7VtNb71sOGc9f3TA1RA8KjmYCpDqsaFSA7y6HAlInAGYU/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YBkXNGxJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YBkXNGxJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=WS0+TC72GZxX8qGZhl4eqr21pm5RLZYj9dJ7tqT9W+M=; b=YBkXNGxJjm/YF2TGbCKlg8iric
	DXQ+QW8+FIM1BEe6GEsM0QSRhlxQ08+vL6DKpKqDlTdTmiiW8P0gWSKOObXEk1rZH2fSrZroIxBYt
	ofosom1Z3W+0uGjkBAe14OjZE1MKqqi22quwSXZSUJ1MnmWMxOHv8Dxh5ArUve1AOzQC3CgYiemt9
	QeZmcXfj7Z1rhrG27+j1a2r+dxFeqb83UNS+SCe2bqgxMTFPiCWP1Q/68881p1Vj9GKlZveSlL3+f
	2C9Y9Qep21P3TVqQkllMF65q7JORSjbnrLvxQuoTHt0FwUZJTK9y9TISEK0F7SitH4peQVHN5TBfK
	BPYfLrPg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVak7-0000000H7ds-2BFC;
	Sat, 28 Jun 2025 18:57:39 +0000
Message-ID: <eeaf9f80-7b84-4133-a2c2-be2e9c1e97c9@infradead.org>
Date: Sat, 28 Jun 2025 11:57:36 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] docs: dma-api: replace consistent with coherent
To: Petr Tesarik <ptesarik@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Bagas Sanjaya <bagasdotme@gmail.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, iommu@lists.linux.dev
References: <20250627101015.1600042-1-ptesarik@suse.com>
 <20250627101015.1600042-3-ptesarik@suse.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250627101015.1600042-3-ptesarik@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/27/25 3:10 AM, Petr Tesarik wrote:
> For consistency, always use the term "coherent" when talking about memory
> that is not subject to CPU caching effects. The term "consistent" is a
> relic of a long-removed PCI DMA API (pci_alloc_consistent() and
> pci_free_consistent() functions).
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/core-api/dma-api-howto.rst | 36 ++++++++++++------------
>  Documentation/core-api/dma-api.rst       | 14 ++++-----
>  mm/dmapool.c                             |  6 ++--
>  3 files changed, 28 insertions(+), 28 deletions(-)

-- 
~Randy
