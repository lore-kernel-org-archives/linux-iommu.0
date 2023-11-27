Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B5D17739
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Lc9QCSl2"
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 2DDF11A6DDC;
	Mon, 27 Nov 2023 11:10:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1701079855;
	bh=uyKgGwA+epO0X21oeFNT+W+/WhLE+FThm5QJTvK4Y9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lc9QCSl2NJajRZ8uZ+LnT/mgRDEtVO6rfK4/JyLq6TDKfH1TnhplhNlPe3uvAb/uf
	 a9f+0SqrEMvy47WDpps9TuaJM9jnR7BVHM3Nc6M/6hIM1y0+5nmvonn5mt8XPsggEL
	 LbME77AQbtumL07D7itimUwRGRtuXUne1NJzC4cbl9+crPt3coMDe3sFfFTW0pDTOw
	 1Lchs+E9EH8z5X2hv8vozANwS3XYyCN2sgb/3Fm3CdEbAW4pKN+MUbwZCiPQ3x3Cop
	 YLyx+zrR6ddI1i76apcpoGapuIYbsXSlLiOG5NJQ7PCvrnKQ3qxklhg5tuqGWtZQnj
	 dLFUoYlQAoUyw==
Date: Mon, 27 Nov 2023 11:10:54 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Rob Clark <robdclark@gmail.com>,
	Gaurav Kohli <quic_gkohli@quicinc.com>,
	Steven Price <steven.price@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	kernel@collabora.com
Subject: Re: [PATCH v3 0/2] iommu: Allow passing custom allocators to pgtable
 drivers
Message-ID: <ZWRrLhxEHxzNz41r@8bytes.org>
References: <20231124142434.1577550-1-boris.brezillon@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124142434.1577550-1-boris.brezillon@collabora.com>

On Fri, Nov 24, 2023 at 03:24:32PM +0100, Boris Brezillon wrote:
> Boris Brezillon (2):
>   iommu: Allow passing custom allocators to pgtable drivers
>   iommu: Extend LPAE page table format to support custom allocators
> 
>  drivers/iommu/io-pgtable-arm.c | 55 ++++++++++++++++++++++++----------
>  drivers/iommu/io-pgtable.c     | 23 ++++++++++++++
>  include/linux/io-pgtable.h     | 34 +++++++++++++++++++++
>  3 files changed, 96 insertions(+), 16 deletions(-)

Applied, thanks.
