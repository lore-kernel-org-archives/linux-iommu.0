Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7E0849C
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 11:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740741505; cv=none; b=kDfJrqUk/TKl8iGsvc4+lCno2MyesaL5RmXro4j1rnoJmBXN2elRPvloPppTRAQeXhh75df+mT30wGamc2X6NXf23t9wzes9JfWYbdLF8I7MvV29bcPAXL2FmInEk70q26kIskn5BsRqN4IXiDNycF2EBuu8y8EcZEldXZGnaUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740741505; c=relaxed/simple;
	bh=uQTgHoCFKtedWfTENTgJ6xsrJTdimOdPQ9eKGGYbtac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F85JZ7g39wnk3/LqbEDmnvYxWP//hZB4uelphRegBTZV9kHGzzaaCWqw+WGXeOE+jyGq+DJFceiRm0mXEBeZK7cr3WfqIzwzK4/tiKL3wFXFZALy2DpZzSc0KZhwXsxhLwqe/Zjh9/JMiyh/KmzkjJOw0heXq2951JqZwFqf/sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=bMM5WSxf; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="bMM5WSxf"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1D3EF43F38;
	Fri, 28 Feb 2025 12:18:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1740741501;
	bh=uQTgHoCFKtedWfTENTgJ6xsrJTdimOdPQ9eKGGYbtac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bMM5WSxfMbP5DxeYOoJyeh3mcuXzOULdqMS4orWV7Rw/71rP+bvOOP3HHn+bymIyV
	 dt5bkiM/AG/7EWRqLur8/SGMCugfhsvPuc1mzQm6ki8PLUQFx1uKbgGKru09H/ekyh
	 QMRuQn44p53JAQQ0BYCO0kn4/XskQv6nSz1Pzb5IFAkPnsP5aJSfUEQncaTzcnqvmi
	 rI3nOQW7rCjH7Ab9QNldvHHKpJPYj7+nod7E2eqkWAluWMERutzv2+O6PLyoap5pjo
	 JeXPPWpk7K+7Vt/IEZn/FRb5ttDL4JdZaeGRuITeFPdI76997NdJXOGcaIeYxFDfaP
	 ZmpQnuY2CJKIw==
Date: Fri, 28 Feb 2025 12:18:19 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
	will@kernel.org, jgg@nvidia.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH 1/1] iommu/amd: Preserve default DTE fields when updating
 Host Page Table Root
Message-ID: <Z8Gbe6InZ862dn6E@8bytes.org>
References: <20250106191413.3107140-1-alejandro.j.jimenez@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106191413.3107140-1-alejandro.j.jimenez@oracle.com>

On Mon, Jan 06, 2025 at 07:14:13PM +0000, Alejandro Jimenez wrote:
> When updating the page table root field on the DTE, avoid overwriting any
> bits that are already set. The earlier call to make_clear_dte() writes
> default values that all DTEs must have set (currently DTE[V]), and those
> must be preserved.
> 
> Currently this doesn't cause problems since the page table root update is
> the first field that is set after make_clear_dte() is called, and
> DTE_FLAG_V is set again later along with the permission bits (IR/IW).
> Remove this redundant assignment too.
> 
> Fixes: fd5dff9de4be ("iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers")
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>  drivers/iommu/amd/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
