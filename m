Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6231A18AED;
	Mon,  5 Aug 2024 12:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722860455; cv=none; b=rb3nnMjICPTA6PnHUaocBZHoP1pmEaNlrs0TBAk9Z1caz16jVWPdWtd91b5MQHj6U0lCH3W7eyKWdy9ZzMv4pmX7Kzxvld2Je+Rh12u1/XRS8/wsEmR4Io+PZAAjhwXWhCjSRCp6hUC65egQ6DYJHQhuCP8nV1mGfTqLUS+w43k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722860455; c=relaxed/simple;
	bh=xgT3yrBODxszxWQGjpeSfMMbsA2ZFJKz3zAKPl93k2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfhPBZGZkENoX18ubsn6Pdskk4S5fIsI+RCVxZ1xlQyImyCGXlZGPsPUpS/CehJOiiBPRdIyuvU+LjZTym7fDukH9I/gurBM0YIaeXNk5WnKKlGeAaohtNGfzWZLI1oSpXgFZamqpNu51NXPoVdpCSKh+b325p8kREnlAJAWJRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlUFmcki; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlUFmcki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA14C4AF0D;
	Mon,  5 Aug 2024 12:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722860455;
	bh=xgT3yrBODxszxWQGjpeSfMMbsA2ZFJKz3zAKPl93k2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mlUFmckiY4vG/qsYsHBjap9cMu5L8n5Rk6wqqTfO3zOrWv4hAzu/JenKaP6EouHiH
	 gsALZZb4bIbshJ0o1Upx4nFraKU5OVL3j3hXGYaFR3IwQHiiOQ2wXGmzohiwnowzlV
	 6qY1wd99js2M0F7V9ucyB+y3Un3g/GUthyzNXECbt65h0mqXq//eGldKyhgSc9QZPO
	 DJYhkh+zeDq4bm5LD7AsmKx1Hhxz45oB0wozZCGOEUMJuGy4abmtIQjl+/YWn62uK3
	 giBXSyYLJYqlCCjGtLMi70ec+IOhqidFLyDz8Cv0XEROi/l5EpeOtBJ4IHrVczT7Uo
	 HlwLHpJFuXhCg==
Date: Mon, 5 Aug 2024 15:20:50 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>, leonro@nvidia.com
Subject: Re: [PATCH v4 0/2] DMA IOMMU static calls
Message-ID: <20240805122050.GA480973@unreal>
References: <cover.1721818168.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cover.1721818168.git.leon@kernel.org>

On Wed, Jul 24, 2024 at 09:04:47PM +0300, Leon Romanovsky wrote:

<...>

> Leon Romanovsky (2):
>   dma: call unconditionally to unmap_page and unmap_sg callbacks
>   dma: add IOMMU static calls with clear default ops
>=20
>  MAINTAINERS                 |   1 +
>  drivers/iommu/Kconfig       |   2 +-
>  drivers/iommu/dma-iommu.c   | 121 ++++++++++----------------
>  drivers/iommu/intel/Kconfig |   1 -
>  include/linux/device.h      |   5 ++

Greg,

Can you please ack the change in the include/linux/device.h file?

Thanks

>  include/linux/dma-map-ops.h |  39 +++++----
>  include/linux/iommu-dma.h   | 169 ++++++++++++++++++++++++++++++++++++
>  kernel/dma/Kconfig          |   6 ++
>  kernel/dma/Makefile         |   2 +-
>  kernel/dma/dummy.c          |  21 +++++
>  kernel/dma/mapping.c        |  90 ++++++++++++++++---
>  11 files changed, 348 insertions(+), 109 deletions(-)
>  create mode 100644 include/linux/iommu-dma.h
>=20
> --=20
> 2.45.2
>=20
