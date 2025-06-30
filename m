Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB06C28B7CD;
	Mon, 30 Jun 2025 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751290432; cv=none; b=q22atwEKYWMiIey6GgITUYd/QI9APkEQ0M5wK+K+0ODCyZOZX1qsQQVzo6X1xlH1L7L/6XSbLjE3jidDC/C7WK4HkH8IJ3GSNX4fMIuUCRLlwiyYVJKX9lMlji+1cw/GwXlrxVoWo0NYtnMbiqxLoiNRq+pxTG48TCrBa3HufNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751290432; c=relaxed/simple;
	bh=Rvs1PsRenPznmu4G5uyb4pYDwE94UCVHnNHwaCzxKpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4/uNx34QulHVNie7q+SLd1A+rcHngNdpGd2vpH1g2du3JOEWMnfKkSOc+adM/Jc3g/990UdNkkth848v9xStcFezR144xEF/PGDxfhYbK4y/+gDguH3Po2O0Oj/D++zpe3p53vJb49CT4ukfTdcgldESsqwj12urL2bBdO1vBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B2DF5227A88; Mon, 30 Jun 2025 15:33:43 +0200 (CEST)
Date: Mon, 30 Jun 2025 15:33:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ben Copeland <ben.copeland@linaro.org>
Cc: linux-kernel@vger.kernel.org, lkft-triage@lists.linaro.org,
	regressions@lists.linux.dev, linux-nvme@lists.infradead.org,
	Dan Carpenter <dan.carpenter@linaro.org>, kbusch@kernel.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	iommu@lists.linux.dev
Subject: Re: next-20250627: IOMMU DMA warning during NVMe I/O completion
 after 06cae0e3f61c
Message-ID: <20250630133343.GA26040@lst.de>
References: <CAL0q8a6pOBZbWYdwKzC1U-PuH4rgf2miv0jcF=fWVZt_dUZHmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL0q8a6pOBZbWYdwKzC1U-PuH4rgf2miv0jcF=fWVZt_dUZHmw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi Ben,

> [   32.857521] iommu_dma_unmap_page+0xc4/0xe8 (P)

Can you resolve this to a source location for me. i.e.

gdb vmlinux

l *(iommu_dma_unmap_page+0xc4)

Also what IOMMU driver is this device using?  It looks like it
might not support a 4k IOMMU page size.

