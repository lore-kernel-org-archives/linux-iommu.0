Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EED13B8D75
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486938; cv=none; b=AueHMiHHRalzMEeK7OgVGep0w2ys5IxIMsZUbeaj9GUQBzfb0LIMfnqGirPU/T4qDd3DnmCNw79wWfIA6Unp94m1e1Suev7XuTcg+nW+SD2lqq82YyfHLXMH5fYnUh5wwKJ1ileHeEydg/qSS+UOHR4WttjqRl/yHxb3ImvK29c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486938; c=relaxed/simple;
	bh=1OTai5XQcPKAzlvbKeBHtZYacoe9n2xrOOUoEPBnkU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4hD4gU3nP0L8N4q9qvU8BmWxBqKPi134Wr+aNWKITHWLa4/0r9hgEacmlvTVUVaNoxVqlXcLTOcT4Ghgt29BxDTMoqO699TltMoK5dN8NxH6gWQXg1uQuD9DXHRA9V2g705Opf4ZKdqjb0pdWlYzK1CPnpq1NrqUIYNbDuGypU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=JQegSdcg; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="JQegSdcg"
Received: from 8bytes.org (p200300f6af1d9600f5faa5cebd6c042e.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:f5fa:a5ce:bd6c:42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DD3DA1C44DC;
	Mon, 11 May 2026 10:08:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1778486922;
	bh=1OTai5XQcPKAzlvbKeBHtZYacoe9n2xrOOUoEPBnkU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JQegSdcga1IhnUnKF+Sv0cnGkICuLjLcmCuSMJmh4xwPkFn5VhnXZoSWXrwh2N9M2
	 uyx5DS0/WE3dwiplV2AhosUqcYpXDlUL2JH5hLfdX3mjmlXELx3aZSM/Cep+h3eHWX
	 O8ge+w7D6inMIPQA6kw11HXNPboYOl+L1HS5dBhw97z4kdiVigJBtULQbtWtoW2fbv
	 me1VdyiWaqgzdcPJVLa0n+fkwjujeJU0VVAVUDOQfxXIseSKRMvnt4IBBC/5+Jo3bO
	 OIMXmgWlqT838OAZnTKHIuDNCSWy374DaLY5ZFKdOfELssMIttv7FnnGkvQhAhaB1j
	 i71I0iKNJHDbg==
Date: Mon, 11 May 2026 10:08:40 +0200
From: Joerg Roedel <joro@8bytes.org>
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Ziyuan Chen <zc@anthropic.com>, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] iommu/amd: Bounds-check devid in __rlookup_amd_iommu()
Message-ID: <cfhoa2kztzk5xklrbl5nnygenxfrro2smow5naj4xascc4ugt6@byfaegjgwjpr>
References: <20260421-amd-iommu-rlookup-bounds-v1-1-bbac5f0f48bd@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421-amd-iommu-rlookup-bounds-v1-1-bbac5f0f48bd@linux.dev>

On Tue, Apr 21, 2026 at 07:26:13PM +0000, Jose Fernandez (Anthropic) wrote:
> Fixes: e874c666b15b ("iommu/amd: Change rlookup, irq_lookup, and alias to use kvalloc()")
> Cc: stable@vger.kernel.org
> Reported-by: Ziyuan Chen <zc@anthropic.com>
> Tested-by: Ziyuan Chen <zc@anthropic.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Assisted-by: Claude:unspecified
> Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
> ---
>  drivers/iommu/amd/iommu.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Applied for -rc, thanks.
