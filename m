Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9FD22157E;
	Tue, 19 Aug 2025 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755592248; cv=none; b=YJ/nHu8h0WBhXHJE8bte37jGCnTzh+iOaX3MWJmGaq+7fVm4NWfsLNzDuxJp8SSBpcRZ5IP+tWGCETPDzUh0vxvIiolx+YbUbnzoHhd+oSd/4V/eskJB5GX3nLaQuszp/yi7amv7nM7aY66dFqAHOqkNeIvdD2uNAVm0+XyfBVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755592248; c=relaxed/simple;
	bh=gB7I83ABsjDdTgfsajyNi5zZJUiLR96qIk2L/9GIJT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swbxx96Px28+xF2y09KIAkXqeSd5CeRPvqDiRPWB1Wjh0DR1pfiMgCR/PjxEZSuCSHyuwOzPS+ZVTx4Haxt8LrLTIRTmKTUyS+jni+8JQB2MfGgV11QZ58trpjj0kDJa7k6Q+akk5pxveHKPJauqJEK1o5SDrA9HHuUbIhqJTaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7DA59227A88; Tue, 19 Aug 2025 10:30:39 +0200 (CEST)
Date: Tue, 19 Aug 2025 10:30:38 +0200
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
Subject: Re: [PATCH v2 7/9] nvme: apple: Add Apple A11 support
Message-ID: <20250819083038.GA1901@lst.de>
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com> <20250818-t8015-nvme-v2-7-65648cd189e0@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-t8015-nvme-v2-7-65648cd189e0@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 18, 2025 at 04:43:00PM +0800, Nick Chan wrote:
>  };
>  
> +struct apple_nvme_hw {
> +	bool has_lsq_nvmmu;
> +	u32 max_queue_depth;
> +	void (*submit_cmd)(struct apple_nvme_queue *q, struct nvme_command *cmd);

Please stick to 80 character lines for the NVMe code.

Also I don't think an indirect call here is a good idea.  This is right
in the command submission fast path.  A simple branch will be a lot
faster.

> +
> +	if (q->is_adminq)
> +		memcpy(&q->sqes[tag], cmd, sizeof(*cmd));
> +	else
> +		memcpy((void *)q->sqes + (tag << APPLE_NVME_IOSQES), cmd, sizeof(*cmd));

This could use a helper and / or comment to make the calculation
more obvious.

> +	anv->hw = (const struct apple_nvme_hw *)of_device_get_match_data(&pdev->dev);

Do we even need this cast?
