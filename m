Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8677265612
	for <iommu@lists.linux.dev>; Fri,  2 May 2025 06:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746168129; cv=none; b=TVMF4IvNUovuLu0Cxga5zPIeMNRCO7AtCjQPA478rzCAqlKmM1JrCbUy2wIUPJ+47HbMXwtD5/ZSBXfr4BSRtBJ639sZAuHjJS8+8lYYOlJ8FrtqgUN6tmUa4Su7YjVzFU++bZHBS42f7Kq93Z2I0BU2CmzB5ZshF0i36pyc1eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746168129; c=relaxed/simple;
	bh=ew0EpJlMd6R899IfeYWdVqjf7FH/9zArOwY2jNia5g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxGWtVhdenDUnVySNa2MQ5cV8Qf4VXcqzaUfyhFVIPpdGHi8Zi7IAw6qSmZTJBtHNcEaRpvI/Pe6QdDH9/9kLAwZ8wRXsaj8X0BsbM0sP5VwxApR1mBYckfZazw8beixwU+w2ie1kD1j2HT+wMULjFHGJolbvMfnhY5oJZHkuCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=CHWLgDst; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="CHWLgDst"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 9312E49B71;
	Fri,  2 May 2025 08:42:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1746168125;
	bh=ew0EpJlMd6R899IfeYWdVqjf7FH/9zArOwY2jNia5g4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CHWLgDstK6YxOn/9JI9sT+oQiT4Aak87z8MX2IT/p2Hdqr40LnpgKBGA4/5GqYlfq
	 4EEpM1fPsTrdgzht9YwsJlEIBYjRuJ/cyNimlhBUjtU48yaLVGEAhIEd9KMuUdD5lN
	 DsHTzDDeE41s7UUeDN7iLfTmRW9OmgkzglkdW85DlzKPnRprIBuCiaGsghuOO0rhz2
	 BWsqgvlznugSaEauM40R3/pB+kJQJcfydvk8jtZB2ah+OVt2DFmsWhppbFeqe+iW8/
	 sTv0mJ8WPyjazi9uq4jNZv8CLRwk+/xNAdAB07LF+yepcGZDgZrlUWaUckOmcXnKM0
	 tpxIy+8ZiMnNw==
Date: Fri, 2 May 2025 08:42:04 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Cleanup comments for dev_enable/disable_feat
Message-ID: <aBRpPOO6HiY5DPAS@8bytes.org>
References: <20250430025249.2371751-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430025249.2371751-1-baolu.lu@linux.intel.com>

On Wed, Apr 30, 2025 at 10:52:49AM +0800, Lu Baolu wrote:
> The dev_enable/disable_feat ops have been removed by commit
> <f984fb09e60e> ("iommu: Remove iommu_dev_enable/disable_feature()").
> Cleanup the comments to make the code clean.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h | 2 --
>  1 file changed, 2 deletions(-)

Applied, thanks.
