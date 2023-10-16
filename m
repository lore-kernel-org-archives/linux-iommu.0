Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782CBA2D
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 07:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Y3ZNyfWQ"
Received: from 8bytes.org (p4ffe149c.dip0.t-ipconnect.de [79.254.20.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1FCD31A45BD;
	Mon, 16 Oct 2023 09:39:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1697441948;
	bh=7sdqdUUJ9Hr1aww5lCsIEogrToelKcRZ/iBtXIyQryY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y3ZNyfWQo6sPn6Q/spii/sLwkEjK1eZt3Ve36XdVcBBbeoiDyF7KjfKW7fvvPO1DK
	 PBHv2MSKqnoxATfAX26tL+ZG697k2Gy9nN+KKSKlvrd2PBtxR/uRjxGOzHjXEGTumm
	 o/2AzetzGE1a0E/h/nVApBJP16XD3QM6JUxYHQOASsezwex9WU4zsrhE5nylvAUhHX
	 Q3/I0d17Ois4fQyz1wgdPAiZedd9S8m+NTj5/2Tji2ObILnqmzxs2nTC7ALiESnJ7o
	 2wgGhoFUfmj98QtLQmH0Y6GaAwdsyfx+qvpCbBekTsGzXJTkAmeJelAyfIGEiYr3/J
	 NYooK5uzINLeg==
Date: Mon, 16 Oct 2023 09:39:06 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iommu: change iommu_map_sgtable to return signed values
Message-ID: <ZSzomke_a2EaAe79@8bytes.org>
References: <06672b96-23fd-424c-8880-1626e7bf119c@moroto.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06672b96-23fd-424c-8880-1626e7bf119c@moroto.mountain>

On Wed, Oct 11, 2023 at 11:01:21AM +0300, Dan Carpenter wrote:
>  include/linux/iommu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
