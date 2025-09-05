Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B7F3451DC
	for <iommu@lists.linux.dev>; Fri,  5 Sep 2025 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076632; cv=none; b=qTnXNRjkMxsy5dVF5Eag1bmhnnPcHaiTGAZ9hgWBV8SNlNAHzv64B8BynnSVlArMpaP366Hx8dbldA3nU9GukqVDX1LhXBMMDaRZb3kwCcRdL+rD5fI2eP2nL5zAnAM6LSeZt1nSeza54YDfq2Skdr+Oexs8umIHreTy6gG8xSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076632; c=relaxed/simple;
	bh=tlGgOA/sfWBvfUawxF7mc/eLFymheu0RUCB1qgZV2Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlOcZMrAzV/iXiR+RaVShq4L+V+rgruEIArC5SMs2SVgx+lDpI9DlKL915VzM88j+O82ezvfZw6+z8qiIiSkbClyknVxnj7Q9yFTqrgKY8L29VB+XxDqNXLZMSCexsL0E57kg87GM8bUf0FSHS5CkU9U5L7JWR6dDZSeNH1qFZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=4zKMKk0G; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="4zKMKk0G"
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DAA5354B38;
	Fri,  5 Sep 2025 14:50:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1757076630;
	bh=tlGgOA/sfWBvfUawxF7mc/eLFymheu0RUCB1qgZV2Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=4zKMKk0GBPEZ6dowrd2trNVKXuwyazxMc6H356C31kbkoQZuqTeZf7kejIT7JOk95
	 OVLT7GKyUsGwWUxuVEm+jnN7ytz8IrDQnS8uO9OpQRKoxHzDg11TS+dRLD8FRJ7qe5
	 5m7jdIX6WA3USuoQO2qOErHsBi2VdPvDjoqi+LmZM8xseoXJQeBctEMZE548kO6Y2Z
	 hzVJNAvMCIOAYP9HSbfulOf+5IDJWGQxOwNyZQt/EgliEBKzHvglWaDL2luXbPsfrp
	 nby1vZar2EkNOP6ANzfskQRBPCjQvJ2Ad7ERTxynaZFIfICYfPvzcn5bGsQTHI03p0
	 kJWB6EnHavgNw==
Date: Fri, 5 Sep 2025 14:50:28 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: schnelle@linux.ibm.com, will@kernel.org, robin.murphy@arm.com,
	gerald.schaefer@linux.ibm.com, jgg@ziepe.ca, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	stable@vger.kernel.org, Cam Miller <cam@linux.ibm.com>
Subject: Re: [PATCH] iommu/s390: Fix memory corruption when using identity
 domain
Message-ID: <aLrclKHjVgTrNWA_@8bytes.org>
References: <20250827210828.274527-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827210828.274527-1-mjrosato@linux.ibm.com>

On Wed, Aug 27, 2025 at 05:08:27PM -0400, Matthew Rosato wrote:
> zpci_get_iommu_ctrs() returns counter information to be reported as part
> of device statistics; these counters are stored as part of the s390_domain.
> The problem, however, is that the identity domain is not backed by an
> s390_domain and so the conversion via to_s390_domain() yields a bad address
> that is zero'd initially and read on-demand later via a sysfs read.
> These counters aren't necessary for the identity domain; just return NULL
> in this case.
> 
> This issue was discovered via KASAN with reports that look like:
> BUG: KASAN: global-out-of-bounds in zpci_fmb_enable_device
> when using the identity domain for a device on s390.
> 
> Cc: stable@vger.kernel.org
> Fixes: 64af12c6ec3a ("iommu/s390: implement iommu passthrough via identity domain")
> Reported-by: Cam Miller <cam@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  drivers/iommu/s390-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied for -rc, thanks.
