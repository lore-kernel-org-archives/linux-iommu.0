Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0BF2E611F
	for <iommu@lists.linux.dev>; Fri, 22 Aug 2025 06:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755844912; cv=none; b=jg+NFR1CxmgafMuHhJDPGVvVEEjibUjmCb+bugYLCAh14QRNbW6pddzYWKMBwStFaMYVC5YQ8dx3RZR7nya2kNl/eVWuB9AK+YYeQ926kh2m4hB4N5LLhHqQakWR5VyVlLgYc7BfluWtJ2SLqODcbroM9i9XF6MYoEQ2VUSPK2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755844912; c=relaxed/simple;
	bh=NhQFO0rePfsIm+ZuSFdYTBz/qr+Qp+tq0rchzzWcrKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jc5X1CenBgxrzmYK5XVeFoSncoIu8FqU7MFWUwPZr+eKOEp9t6mcV0+Cw8bMgpcvVUC/FyCRSYrBJc8jnMDV2TNgui2vCg/gpkWLKVO9+w4oY1ZeW1mudSl9Ahhm2sBASgB4G2xdEbQn9X37299PDv3iCvRuG5stVCYpMFPHF7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Qvukm80n; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Qvukm80n"
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A56A253456;
	Fri, 22 Aug 2025 08:41:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1755844907;
	bh=NhQFO0rePfsIm+ZuSFdYTBz/qr+Qp+tq0rchzzWcrKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qvukm80n6STPbGxXIfOPFQWT7Bgc/JfWVO8X2vhUtGP4Dv1SreJLa2AQ+4sOKRZOn
	 z+5JwuRNSbuaITzF6t9jYrQJ+WsCxmG/X/a59bPTL7mdfhXgu5a4un7Jz6X7fAe+Dr
	 AII/ZbysARLtKd0bYkhzJF45Kzy421lFZ8LuY3rESPxcq8rdKgJ6YeWKnQZEpDzGbF
	 CKm6xQ0ppY46BycIAZw8g+LyMSaDutN4yBrQokXgjicchJlOQ5xk5/aXnZnapRhXPY
	 8euzpOofx/fEqtUd+n+QPo3Ln0+iGMa8naR9DU/feWmcXU4l7LQmimFtguUKQ4ZEAl
	 kPvk/KadBIiww==
Date: Fri, 22 Aug 2025 08:41:46 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc] iommu/arm-smmu-v3: Fix smmu_domain->nr_ats_masters
 decrement
Message-ID: <aKgRKnbBnZ51C-t-@8bytes.org>
References: <20250801030127.2006979-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801030127.2006979-1-nicolinc@nvidia.com>

On Thu, Jul 31, 2025 at 08:01:27PM -0700, Nicolin Chen wrote:
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied for -rc, thanks.
