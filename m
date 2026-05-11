Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43DD3346A8
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484716; cv=none; b=Wj1EUwFRjGCeR79UvI5/Fw/1cP8Zw7c97PHifXls7WFXFyEicX6/R7mcUBUuE5/xLr6A2Tv1VLSSywXWAq3yctq5T15UGNVSuX1XCqC7LSefzWWqQT1qMc7CKGUzXEuasEZ8e2NE3afaWHl6pqxTrVxQmCaC1DMKI1HyGB0sqsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484716; c=relaxed/simple;
	bh=8NMOkFwesrKWURB51smC0eJsMZxF/MsGZNcq4Rgw90E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvMCXA+h8r1cUAeWBg2xFT2OLCPSUg6ObuqPbxgBkq9vuA72PYF6R0+YE5SID6bzRYXBaUidsH/DATAgheLVfnjHRt086vhkfJOyx/UtLCGBD9PF+98BO0KcjXs3jraSYQWI+lVWplqvL07x4hubvb3xg1ZzycLTf5tMYCewoIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=cGoiOSIL; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="cGoiOSIL"
Received: from 8bytes.org (p200300f6af1d9600f5faa5cebd6c042e.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:f5fa:a5ce:bd6c:42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D783F1C41F2;
	Mon, 11 May 2026 09:31:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1778484707;
	bh=8NMOkFwesrKWURB51smC0eJsMZxF/MsGZNcq4Rgw90E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cGoiOSILIGwttiawFTf0hy7TR6HCGyRucoDgL8YMgktIfxvHgWFqJx9bX+t41A8ox
	 Lhs4v+9Lq9+m4g1vaz1v4DaTvWyf1ihSFQnzD2SVrBZ0TAmsHz8zMe+yzwGoFVkj+D
	 CcqK9nwmvBYHgnxDxwN47zWnUdnmGDkY9WsRWA3HYudENR7F42drIK7R0djZYIuxaQ
	 euFXmbrizCinFZG9F1qvRFx3z7Kr0+84Ja3k94bnuthAyPc/1yqaV+ya/GxzLv0f7T
	 Ayp5VH/lQ90ydK6Udfznj/G+GJpzmz4q37XMyXY/nZrpVu29RYJnSm4avrqGwB8zal
	 o5ix2w5ax4coA==
Date: Mon, 11 May 2026 09:31:46 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Sean Christopherson <seanjc@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Explicitly bail from enable_iommus_vapic()
 when in legacy mode
Message-ID: <utkh4mj3wddgtsdagg2m3n5zhmmne5n2pa7o56phieyc6g7ciq@qge574d6mysp>
References: <20250315030928.2373250-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315030928.2373250-1-seanjc@google.com>

On Fri, Mar 14, 2025 at 08:09:28PM -0700, Sean Christopherson wrote:
> Bail early from enable_iommus_vapic() if IOMMUs are configured for either
> of the legacy modes, as it's absurdly difficult to see that
> iommu_ga_log_enable() is guaranteed to fail because iommu_init_ga_log()
> skips allocating the ga_log.
> 
> Opportunistically have iommu_ga_log_enable() WARN if it's called without
> IOMMUs being configured to support AVIC/vAPIC.
> 
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  drivers/iommu/amd/init.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Applied, thanks.
