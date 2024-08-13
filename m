Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBE9168C20
	for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723539090; cv=none; b=QgrzWboasiwlvT5wHdInDX0l40xnRZUHHEv8BaiXFloiavKC9J6ewjnGNxYxhlQRebbbCn7dLFDlXvRKc1YBq5wS0sodOngQDgfhdub1s9whv5eyM+lbqR8tTURxHHZaC12tiDN4s8B1KT8C5tAWeFkYnXRbGa6OEskZ2U33Hu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723539090; c=relaxed/simple;
	bh=SmLMiiKEtiBMsHkITQJ0wLTxfVkKF8noZpD+Hik+pvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDdVeNjXD2iqGDQT2NmK4twiHaDvLz+6chCqEBabkeJ6tTA1T/V2Q7JUbeIvcT9PSz+ZwGXrviUDqJvXX4J8tgKrEEtaUrbbL0BNPxsO0mtgbEfJYIF5PweKgXJ5K+irKPdLBp+deFgt+E6YWBCQvk7CuL8ZULBIaVqR5WUCixo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=ZAm5uQ+P; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="ZAm5uQ+P"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 2BC6F2A5885;
	Tue, 13 Aug 2024 10:44:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1723538690;
	bh=SmLMiiKEtiBMsHkITQJ0wLTxfVkKF8noZpD+Hik+pvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZAm5uQ+PXbTaCFZ3hNzM4tSj/vEG+xff5hUhDoC93qFQrEbQenq2V+1YG0E+utcQL
	 Ph+L9pcUoLJ75VAfl1pPR1cB4GkDGNPI2Z6yhsRwfHLc6coID8//OKxhEcQsIZsvEU
	 LhAh9aeU/ME1i7EjSzkU0/gkW9liAA5ojP6te9y+ILy9RZN6L/pZGRbzi6YfxxlhFK
	 pPR48OwxrpNDZ/9pWUyHbrsZPiP8s/+c1u0KSvhLL7lDbZDAD/K0TiUyxBevsXFsMr
	 ZYBjuTkKlB88iuuSUV4lUdiM3h5z/aNqHTcNFaPQ/DK751NcCC+MMgWJKthtHpB0wU
	 P7pQF1FVi1JIg==
Date: Tue, 13 Aug 2024 10:44:49 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH] iommu/amd: Add blocked domain support
Message-ID: <ZrsdAd2Lmh_q6fYw@8bytes.org>
References: <20240722115452.5976-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722115452.5976-1-vasant.hegde@amd.com>

On Mon, Jul 22, 2024 at 11:54:52AM +0000, Vasant Hegde wrote:
> Create global blocked domain with attach device ops. It will clear the
> DTE so that all DMA from device will be aborted.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Applied, thanks.
> 
