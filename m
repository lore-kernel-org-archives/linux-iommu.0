Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D23E10794
	for <iommu@lists.linux.dev>; Mon,  7 Aug 2023 12:34:11 +0000 (UTC)
Received: from 8bytes.org (pd9fe94eb.dip0.t-ipconnect.de [217.254.148.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id AF2A92802C4;
	Mon,  7 Aug 2023 14:34:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1691411650;
	bh=khxzW0Soy7gYIG0pguWDQLphO1PRRFQL4AMMIQA7lHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FldM5UDYt0qQyEh5yXXxCBUHIP9j2gUPPYzoZsve33GtlPQ0iTWWzbksEEoyvTNhD
	 EPomlQeIbGYn7NSV8mC7rWiDkOGkUbNmgY+pXTh2DhrBYQ7zB8ykQSBvjZbZ+cvvzL
	 3YqbI3her9M/4PjMfLt0sRcKGW4r7gP04oCPqtBZqEmFiHyrQD/r/GKjUAmpjTJnCe
	 SAluHb/D2KHlFS47q3emdeTSJJiEY6OGWF7X8l6Mfwsh8fAvtstAIgo5cB1NEf14fp
	 guf7ZbixSj4p/HOK4B7Wwlh1xkW7J89W5YbXU+fwzSKa9wzk2jn9GT7I96WmklsQqA
	 +AkpgAkD3XH+w==
Date: Mon, 7 Aug 2023 14:34:09 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, iommu@lists.linux.dev,
	Orson Zhai <orsonzhai@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Chunyan Zhang <chunyan.zhang@unisoc.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/sprd: Add missing force_aperture
Message-ID: <ZNDkwWEvV5yYclg3@8bytes.org>
References: <0-v1-b782fe624c2a+3d511-sprd_force_aperture_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-b782fe624c2a+3d511-sprd_force_aperture_jgg@nvidia.com>

On Mon, Jul 24, 2023 at 02:36:05PM -0300, Jason Gunthorpe wrote:
>  drivers/iommu/sprd-iommu.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.
