Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F858003F;
	Tue, 30 Jul 2024 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722327403; cv=none; b=tt9n68kaeyv+zJ4SCoyPFI3sKs4/20DnQrrmTxG2WFa36TYN/jTEVxtVtHPYQ2fJNjZw5ZgkuE2zK1UhlsV1t07NBurMiYyULu5wRiWqLEK4McosKE1oAqslhbqlXPQzyQ4V0qLJh128dyomW9JvIPSpXOAFrgNWgEQiGRlyiaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722327403; c=relaxed/simple;
	bh=9vV7852rXBybuz0N5JlPgLQHXBOTjJY6DP6MvflMBQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFIdQJezF8mLw5U7Pf2Y1Gy2VMyLiY3zIwcILqKNwm8t1WAYN0AZct29JQ3XdujBO8Pk+Ic5Y6CefSrHYSTRH2+J+Dv+KgDZKy2RNxT+VJppBEBAwbtFiUfYA9o7rnNfOzQ4AkO/JZMSTmIKKV1GRkD8tUeZyrbwjQM64tY+LD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgFCjndf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgFCjndf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BF7C32782;
	Tue, 30 Jul 2024 08:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722327403;
	bh=9vV7852rXBybuz0N5JlPgLQHXBOTjJY6DP6MvflMBQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UgFCjndfKEUbkEoyuhONHjgpqeHkD/bGys7RglYGBKDo7Ri4C7oSVB0hV4c3ea4WX
	 k+8888FtCSmDlcU9SKvH8QzAWmVaYjliRZJDO59//CPXhporMFfXZcVTQFZ4zqs/3c
	 5EQGyXe7RjIcpR519Txn1g9bmheb6TubecS9/NsbONuQb1k57cH26+UbGYY5G5Tb/s
	 LkrThqGWSUeIQUfrthtcbsjRUqdsWYiA0XisgaVGEjzqbmFpuFYG73I43EJBNosSmp
	 fw8cDTGFbQocYEpL8t8osjPuCgA6adHQfoGGtI5d53WY/8yPlDTHqIFlOAwFhhj/2s
	 hTInRQ+KU9oVA==
Date: Tue, 30 Jul 2024 11:16:37 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Mostafa Saleh <smostafa@google.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 2/2] dma: add IOMMU static calls with clear default ops
Message-ID: <20240730081637.GB4209@unreal>
References: <cover.1721219730.git.leon@kernel.org>
 <dd34bf3ecef252b4910d70aa21ff5273b5e8b19b.1721219730.git.leon@kernel.org>
 <ZqeN6MP4o2JNLcUz@google.com>
 <20240729171518.GB31388@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729171518.GB31388@lst.de>

On Mon, Jul 29, 2024 at 07:15:18PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 29, 2024 at 12:41:12PM +0000, Mostafa Saleh wrote:
> > Just out of curiosity, is there any observed improvement from that?
> > As from my experience the DMA-IOMMU path is quite dense so it won't
> > be senstive to such micro-optimizations.
> 
> We are trying to gradually fix this.   Part of that is adding not even
> more indirect calls for the next generation map API.  But another totally
> unrelated part is that we can compile out the dma ops entirely for
> common configs, which I really want because people are badly abusing it.

Christoph,

This is good remark, should I add this to the commit message and send v5?
v4: https://lore.kernel.org/all/cover.1721818168.git.leon@kernel.org/

Thanks
