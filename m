Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA72352FA0
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 09:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814437; cv=none; b=j1lRnKsi6sPXdwl7LGAZxDuMg/aMnGFsntwZhnVbENuipKDj+dmcW+GhS9UR073cUFYyvNvQJtJpEC+/LX6EgVD3dQETMNr5cjFC9hFVTsyJDEpKjH5nOPG/2mDDjqyKgu7R8z2mNMz72OCkZpOBTrNqP+2Jrp3Ak2/sxTf1h0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814437; c=relaxed/simple;
	bh=CtJJ7eqAhTEPmIQ3y2ZWoU3/ICrb/VjiiJxRdiLM6Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtBUxRJOHON1Q6lgxvA0obVG+nzMwGZfAqebao78fOidV/GETdK3EHo+QpzWtfqJgPNrDCRvCy2PYLYMA2p8KfPMrfM9DtNn2IhAV7x5J+/gPrrgpx4jbHmpNShmdvvm6oGsqDbfie62o7xcEMusORgidRGROXi06/zDEemivaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=PmcW8Qea; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="PmcW8Qea"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 41B315FD8D;
	Mon, 19 Jan 2026 10:20:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1768814435;
	bh=CtJJ7eqAhTEPmIQ3y2ZWoU3/ICrb/VjiiJxRdiLM6Qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PmcW8QeaZsz3/hImHrfqS6R5FSmBxoyu4WSZS5ANa1a5oesr5MkqeuvQyRJ73gojR
	 nd0nrzITQ1bSwE1ea4J6ccx91Z4ro5TNYJVCUGdYr+tvov4joT6weRr/IycvUW2YmR
	 yb1DEfAyVvvu+V/3cBudCRpNkYXethAOxgNd+11US78dRx1eIVkpt4hoCaPQHSzXn9
	 HNY9PQ4QfI/OGP9+75RlIEtyWtKXGio/w0LixDqvGRlkgQUoap8SGbmmkCGPtUjrY6
	 WgQZSCmJf1Yz+oTTOHy5MEkZqWmZU9x1T8X1VZPjToKzynzcVcMPoEUXteNYmBTJNb
	 UH9B5pgXaLj+Q==
Date: Mon, 19 Jan 2026 10:20:29 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Wei Wang <wei.w.wang@hotmail.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, alex@shazbot.org, 
	thomas.lendacky@amd.com, vasant.hegde@amd.com, suravee.suthikulpanit@amd.com, aik@amd.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] iommu: Avoid setting C-bit for MMIO addresses
Message-ID: <n5qpe3uoj42kghrssonutrdbee7ainyr3e75ya3b5onlhbfzei@c32arggnkmsd>
References: <SI2PR01MB4393C9B731ABDA050A336166DC88A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SI2PR01MB4393C9B731ABDA050A336166DC88A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>

On Mon, Jan 26, 2026 at 03:19:19AM +0800, Wei Wang wrote:
>   iommupt: Do not set C-bit on MMIO backed PTEs

Applied patch 1, thanks.
