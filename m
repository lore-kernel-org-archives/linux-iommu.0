Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F401320B22;
	Mon, 25 Aug 2025 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756109237; cv=none; b=ObsEFE5GSXeY8KcA+W0/Z89Pty6Vb1ugx40qdMrz695+u37tr9rX0pYqynGYoVc+YtZ29IscG8XGj8H3ZmQBAGC6ygQNgX/RgIR9V/Ifoyz9PODaMPv8K6liiEd7N2EuTkr1fM5ljFyPhtp7jaMf0gYT8jrjYZLi5FVM/vYL15M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756109237; c=relaxed/simple;
	bh=IBIp2gvwdN7Gzu3Imd4BXP9l50KbPoLZlLKeiU+y9wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bx37Zvm9FrJyx3zwQ7lp2rCCGAyV1eC70RF09WCC5p5Rr9x2WeTZQ0l5xzUiOL1ClYSo7Q6SURnYEr5DBFgmzYfKh/KuUHTdSVA6fAvGPSzzcyiXcbO/XyzHdYcSTrVTR3wYH+2qP0hv/i+A1NxuPvhF/HpUyHa4G1sDKluM0Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9E63768AA6; Mon, 25 Aug 2025 10:07:10 +0200 (CEST)
Date: Mon, 25 Aug 2025 10:07:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 7/9] nvme: apple: Add Apple A11 support
Message-ID: <20250825080710.GA23193@lst.de>
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com> <20250821-t8015-nvme-v3-7-14a4178adf68@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-t8015-nvme-v3-7-14a4178adf68@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Aug 21, 2025 at 11:56:44PM +0800, Nick Chan wrote:
> +		writel(anv->hw->max_queue_depth | (anv->hw->max_queue_depth << 16),

One long line left here.

Otherwise this looks fine to me.

Do you want to merge this through the apple SOC tree?  If so:

Acked-by: Christoph Hellwig <hch@lst.de>

