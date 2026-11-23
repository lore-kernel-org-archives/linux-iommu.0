Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795425074;
	b=pQ6zm28jfyJIMmu8kmIBxvPu3DBzldyfUsstKD0CAwXkZLEANLnnrTQavTfNoxB70Pbq
	 VpnmYxo89z8PoRRPkMd5YtHzoyB4oMDQgM+mbjvzVUb35Rm9E+hPISj57Sht5iQctS5xY
	 kAddhFf1iv+tWXMe4fureV3VEkRNYNsH+SuQouq6QqQzgioNc5eyFBYwZ0HIMoGHY7bWI
	 GwOjNQnuzIrw10PLDk21Wbo4jFwdu7qKQJI9cJy/64wyJ1jbmqPuZy9xZj6Xy6ovTvqlM
	 GA2veGVk5EUT81j04ROH0/vzxV8sgbYhE1MJ4m56VaT4OF1ZFAOFJFxZTlkfNwg7Exg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425074;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+ZRzLaxXm1TGryN+k8iYwB9yxKG7+19yrzZ8vxYeHKs=;
	b=t3tF0A5tcwLtZhKkjr5+pt7Sd25uDIUF6+KZBwWag9WJY0S+QA2hwX2GA+tKPhWcaCpg
	 pL3spEjas4fR4/fla9qyAzhFatoSlMhCEjFDyfBvJa13/pcJq2yA04YLIx0D5ZzWkwCly
	 3fk8aeS8m1a7EQR0py6YNnwfH4FHaXYEYqYgPjWsykSYDsOE+MjFbAqDW5OCQm+h558UY
	 FG0ugrVy1VGHwvhb+5qvTXuc82zmgnwiLhxMMbjvh+LAC0dRS7Uq7AvMfelvP1vAQAX5c
	 fBzallJGjKkvhJKY0kw3udkAfMODzA1hac0/Fh5Z9vBLo9hqp9fFCTAVyEaPxK06u7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30E3606A31A
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 09:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F30E3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549216fa.dip0.t-ipconnect.de [84.146.22.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id BBFB4244C20;
	Mon, 23 Nov 2026 10:11:12 +0100 (CET)
Date: Mon, 23 Nov 2026 10:11:11 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: robin.murphy@arm.com, Andrew Jones <andrew.jones@linux.dev>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, 
	will@kernel.org, pjw@kernel.org, palmer@dabbelt.com, anup@brainfault.org, 
	tglx@kernel.org, kevin.tian@intel.com, fangyu.yu@linux.alibaba.com, 
	nutty.liu@hotmail.com
Subject: Re: [PATCH v7 0/5] iommu/riscv: Enable MSI remapping and IOMMU_DMA
Message-ID: <awQC8jVJC1mQYUTQ@8bytes.org>
References: <20261022154603.1374754-1-andrew.jones@linux.dev>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022154603.1374754-1-andrew.jones@linux.dev>

Robin, can you please have a look at the iommu/dma changes?

Thanks,

-Joerg

