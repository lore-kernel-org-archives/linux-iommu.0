Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936FB54652;
	Tue,  2 Sep 2025 05:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756790813; cv=none; b=HD52ZNTn355CftRXQZrTMLSs/Nsy7hElNV6D7/boWf6xgBJzDbE6atoVIbOp/J2/W1V1xUE3G9CUE8jGJEDCygR5djcpKhbVziBxYt+mutGnW1tNUS3Tv+pfdy3nljI4k1QX5y9Q4UB+1y+i+fbZMpOwGN0cl35YOUrY8HhLnT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756790813; c=relaxed/simple;
	bh=BfII0mWTjBQDFPNTLW0jl6aLZKx/Rg8X4WNfi2A6t8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBKjjafo+0P0ux0Bw5N4qxwDdEx14uYsxCUCS/2zDuwSv8rVEgTov3xFBLvsg0sq65SukTeNvociyqKnnnSGE9LoIxeJQeIS5KXpyb9JJWM4C/d6zmfaEUhRe/h5gLRQ3YQAqQEpxoxYY8hGKsRSTynpypez3+C3ukOx01eBy1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1565E68AA6; Tue,  2 Sep 2025 07:26:47 +0200 (CEST)
Date: Tue, 2 Sep 2025 07:26:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sven Peter <sven@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Nick Chan <towinchenmi@gmail.com>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 7/9] nvme: apple: Add Apple A11 support
Message-ID: <20250902052646.GA11139@lst.de>
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com> <20250821-t8015-nvme-v3-7-14a4178adf68@gmail.com> <20250825080710.GA23193@lst.de> <89251134-9685-439e-b220-92717663f038@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89251134-9685-439e-b220-92717663f038@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 27, 2025 at 05:56:33PM +0200, Sven Peter wrote:
>> Do you want to merge this through the apple SOC tree?  If so:
>>
>> Acked-by: Christoph Hellwig <hch@lst.de>
>>
>>
>
> I don't think that's necessary since there are no build time dependencies 
> but if you want to I can take it through there.

Merging it through nvme sounds fine as well, I just through up
grabbing everything together would be easier.  I also noticed there's
another Apple hw enablement series that touches nvme, so I guess both
should go through the same tree?

